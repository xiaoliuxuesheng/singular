# 第一步  基本坏境准备

## 1.1 添加依赖

- 和正常的Mybatis一样添加持久化必须的相关依赖

  ```xml
  <!-- spring aop -->
      <dependency>
          <groupId>org.springframework.boot</groupId>
          <artifactId>spring-boot-starter-aop</artifactId>
      </dependency>
  <!-- mybatis -->
      <dependency>
          <groupId>org.mybatis.spring.boot</groupId>
          <artifactId>mybatis-spring-boot-starter</artifactId>
          <version>2.0.0</version>
      </dependency>
  <!-- mysql -->
      <dependency>
          <groupId>mysql</groupId>
          <artifactId>mysql-connector-java</artifactId>
      </dependency>
  ```

## 1.2 需要修改主启动类的配置

- 禁用掉默认的数据源自动配置 : exclude排除掉默认的自动配置数据源的配置类

  ```java
  @SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
  ```

# 第二步 配置数据源

## 2.1 在配置文件中指定多数据源

```yaml
spring:
  datasource:
    master:
      driver-class-name: com.mysql.cj.jdbc.Driver
      type: com.zaxxer.hikari.HikariDataSource
      jdbcUrl: jdbc:mysql://127.0.0.1:3306/case_master
      username: root
      password: root
    slave:
      driver-class-name: com.mysql.cj.jdbc.Driver
      type: com.zaxxer.hikari.HikariDataSource
      jdbcUrl: jdbc:mysql://127.0.0.1:3306/case_slave
      username: root
      password: root
```

> ?useUnicode=true&zeroDateTimeBehavior=convertToNull
>
> &autoReconnect=true&characterEncoding=utf-8

## 2.2 配置数据源

1. 添加数据源信息为master的DataSource

   ```java
   @Bean("master")
   @Primary
   @ConfigurationProperties(prefix = "spring.datasource.master")
   public DataSource master() {
       return DataSourceBuilder.create().build();
   }
   ```

   - @Primary理解为默认有效选择，DataSource可以设置多个

2. 添加数据源信息为master的DataSource

   ```java
   @Bean("slave")
   @ConfigurationProperties(prefix = "spring.datasource.slave")
   public DataSource slave() {
       return DataSourceBuilder.create().build();
   }
   ```

3. 添加动态数据源容器DynamicDataSource，装载maste和slave两个数据源并指定默认的数据源

   - DynamicDataSource是自定义的动态数据源是需要继承AbstractRoutingDataSource类
   - 

   ```java
   @Bean("dynamicDataSource")
   public DataSource dynamicDataSource() {
       DynamicDataSource dynamicDataSource = new DynamicDataSource();
       Map<Object, Object> dataSourceMap = new HashMap<>(2);
       dataSourceMap.put("master", master());
       dataSourceMap.put("slave", slave());
       // 将 master 数据源作为默认指定的数据源
       dynamicDataSource.setDefaultDataSource(master());
       // 将 master 和 slave 数据源作为指定的数据源
       dynamicDataSource.setDataSources(dataSourceMap);
       return dynamicDataSource;
   }
   ```

4. 关键配置，设置SqlSessionFactoryBean中的数据源将来从动态数据源中获取

   ```java
   @Bean
   public SqlSessionFactoryBean sqlSessionFactoryBean() throws Exception {
       SqlSessionFactoryBean sessionFactory = new SqlSessionFactoryBean();
       // 配置数据源，此处配置为关键配置，如果没有将 dynamicDataSource作为数据源则不能实现切换
       sessionFactory.setDataSource(dynamicDataSource());
       sessionFactory.setTypeAliasesPackage("com.louis.**.model");    // 扫描Model
       PathMatchingResourcePatternResolver resolver = 
           new PathMatchingResourcePatternResolver();
       sessionFactory.setMapperLocations(resolver.getResources(
           "classpath*:**/sqlmap/*.xml"));    // 扫描映射文件
       return sessionFactory;
   }
   ```

5. 事物配置，微服务中好像都不用事务, 配置事务管理, 使用事务时在方法头部添加@Transactional注解即可

   ```java
   @Bean
       public PlatformTransactionManager transactionManager() {
           return new DataSourceTransactionManager(dynamicDataSource());
       }
   ```

# 第三步 编程实现动态数据源

## 3.1 自定义注解

- 用于指定请求使用的数据源

```java
/**
 * 动态数据源注解
 * @author Louis
 * @date Jun 17, 2019
 */
@Target({ElementType.METHOD, ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface DataSource {
    
    /**
     * 数据源key值
     * @return
     */
    String value();
    
}
```

## 3.2 APO实现数据源切换

- 读取自定义注解,设置切换数据源

```java
/**
 * 动态数据源切换处理器
 * @author Louis
 * @date Jun 17, 2019
 */
@Aspect
@Order(-1)  // 该切面应当先于 @Transactional 执行
@Component
public class DynamicDataSourceAspect {
    
    /**
     * 切换数据源
     * @param point
     * @param dataSource
     */
    @Before("@annotation(dataSource))")
    public void switchDataSource(JoinPoint point, DataSource dataSource) {
        if (!DynamicDataSourceContextHolder.containDataSourceKey(dataSource.value())) {
            // 数据源不存在,使用默认的数据源
        } else {
            // 切换数据源
            DynamicDataSourceContextHolder.setDataSourceKey(dataSource.value());
            // 是哪个方法选择了哪个数据源
        }
    }

    /**
     * 重置数据源
     * @param point
     * @param dataSource
     */
    @After("@annotation(dataSource))")
    public void restoreDataSource(JoinPoint point, DataSource dataSource) {
        // 将数据源置为默认数据源
        DynamicDataSourceContextHolder.clearDataSourceKey();
    }
}
```

## 3.3 线程级别的全局变量

- 为了保证当前方法所执行的所有操作都是同一个数据源

```java
/**
 * 动态数据源上下文
 * @author Louis
 * @date Jun 17, 2019
 */
public class DynamicDataSourceContextHolder {

    private static final ThreadLocal<String> contextHolder = new ThreadLocal<String>() {
        /**
         * 将 master 数据源的 key作为默认数据源的 key
         */
        @Override
        protected String initialValue() {
            return "master";
        }
    };


    /**
     * 数据源的 key集合，用于切换时判断数据源是否存在
     */
    public static List<Object> dataSourceKeys = new ArrayList<>();

    /**
     * 切换数据源
     * @param key
     */
    public static void setDataSourceKey(String key) {
        contextHolder.set(key);
    }

    /**
     * 获取数据源
     * @return
     */
    public static String getDataSourceKey() {
        return contextHolder.get();
    }

    /**
     * 重置数据源
     */
    public static void clearDataSourceKey() {
        contextHolder.remove();
    }

    /**
     * 判断是否包含数据源
     * @param key 数据源key
     * @return
     */
    public static boolean containDataSourceKey(String key) {
        return dataSourceKeys.contains(key);
    }
    
    /**
     * 添加数据源keys
     * @param keys
     * @return
     */
    public static boolean addDataSourceKeys(Collection<? extends Object> keys) {
        return dataSourceKeys.addAll(keys);
    }
}
```

