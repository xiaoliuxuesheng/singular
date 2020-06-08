第一部分 Spring容器

1. 基本环境准备：新建maven工程添加基本依赖

   ```xml
   <dependency>
       <groupId>org.springframework</groupId>
       <artifactId>spring-context</artifactId>
       <version>5.2.4.RELEASE</version>
   </dependency>
   <dependency>
       <groupId>org.projectlombok</groupId>
       <artifactId>lombok</artifactId>
       <version>1.18.12</version>
   </dependency>
   <dependency>
       <groupId>junit</groupId>
       <artifactId>junit</artifactId>
       <version>4.12</version>
   </dependency>
   ```

   > 1. spring-context：添加context会自动依赖Spring其他核心组件

2. @Configuration 和 @Bean：@Configuration的作用Spring的配置文件（xml文件），Spring加载注解式的配置文件和加载XML格式的配置文件的方式不同

   ```java
   // 加载xml格式的配置文件
   new ClassPathXmlApplicationContext("person-bean01.xml");
   
   // 加载注解式的配置文件
   new AnnotationConfigApplicationContext(Class<?>... componentClasses);
   ```

3. @ComponentScan：在xml配置文件中使用`<context:component-scan>`标签，用于扫描Spring中的组件实现自动注入，使用注解的方式是在配置类上添加`@ComponentScan`注解：需要指定需要扫描的包，就可以实现自动扫描注入；查看注解源码可以看到用法和xml标签的相同，可以排除或扫描指定的bean；`@Repeatable(ComponentScans.class)`表示可以重复定义

   ```java
   @Retention(RetentionPolicy.RUNTIME)
   @Target(ElementType.TYPE)
   @Documented
   @Repeatable(ComponentScans.class)
   public @interface ComponentScan {
   
   	@AliasFor("basePackages")
   	String[] value() default {};
       
   	@AliasFor("value")
   	String[] basePackages() default {};
   
   	Class<?>[] basePackageClasses() default {};
   
   	boolean useDefaultFilters() default true;
   
   	Filter[] includeFilters() default {};
   
   	Filter[] excludeFilters() default {};
   
   	boolean lazyInit() default false;
   }
   ```

   - FilterType的扫描规则

     ```java
     public enum FilterType {
      
     	ANNOTATION,		// 根据注解
     	ASSIGNABLE_TYPE,// 根据给定的bean类型
     	ASPECTJ,		// 使用aspect表达式
     	REGEX,			// 正则表达式排除
     	CUSTOM			// 自定义规则：是TypeFilter的实现类，实现过滤规则
     }
     ```

   - 使用案例

     ```java
     @ComponentScans(value = {
             @ComponentScan(basePackages = "com.panda.component",excludeFilters = {
                     @ComponentScan.Filter(type = FilterType.ANNOTATION,classes = {Controller.class})
             })
     })
     @Configuration
     public class ConfigClass {
     
     }
     ```

4. @Scope：定义配置文件中注入@Bean的作用域，取值有singleton和prototype

5.  @Lazy：懒加载bean

6. @Conditional：条件构造器，作用是根据指定的条件向Spring容器中注入Bean

第二部分 扩展原理

第三部分 WEB支持