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

   - Bean的生命周期相关配置：默认是由Spring容器管理，当时Bean的创建和销毁方法可以自定义，Spring管理声明周期时候会调用初始化或销毁方法；多实例的Bean容器不会负责执行销毁方法；

     ```java
     @Bean(initMethod="",destoryMethod="")
     ```

   - Bean的初始化和销毁方法有两个接口需要自定义Bean实现，可以完成初始化方法

     ```java
     @Component
     class Xxx implements InitializingBean {
         public void afterPropertiesSet()throw Exception {
         }
     }
     
     //  单实例的Bean的销毁会被容器调用
     @Component
     class Xxx implements DisposableBean {
         void destory() throw Exception {
             
         }
     }
     ```

   - 根据JSR250规范中定义的注解实现Bean的初始化方法：@PostConstructor-在Bean创建完成并且属性赋值完成来初始化方法；@PreDestory-在Bean移除容器之前会调用的方法；在Bean的方法中添加指定注解

     ```java
     @Component
     class Xxx {
         @PostConstructor
         public void postConstructor()  {
         }
         
         @PreDestory
         void destory() throw Exception {
         }
     }
     ```

   - Spring提供的BeanPostProcessor-Bean的后置处理器，在Bean的初始化前后进行一些处理工作，

     ```java
     @Component
     class Xxx implements BeanPostProcessor{
         // 两个实现方法,一个初始化之前,一个初始化之后
     }
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

7. @Import：向容器注册组件的方式：第一种是自己写的代码上添加自动注入标签完成自动注入；第二种方式是通过@Bean在配置文件中注入单个组件，也可以是第三方包中的组件；@Import是导入的意思，可以快速的给容器中导入组件

   ```java
   // 方式一:组件ID默认是组件的全类名,可以添加多个组件
       @Import({组件.class,...})  	
       @Configuration
       public class ConfigClass {
   
       }
   
   // 方式二:根据选择器导入组件
       // 1. 自定义组件选择器类实现ImportSelector
       class XxxImportSelector implements ImplotSelector{
           @Override
           public String[] selectImports(AnnotationMetadata anno){
               // AnnotationMetadata 可以获取到标注了@Import类的相关注解信息
               return String[];// 返回值是需要导入到组件的类的字符串全类名的数组
           }
       }
   
       // 2. 导入时候指明导入选择器
       @Import({XxxSelector.class,...})  	
       @Configuration
       public class ConfigClass {
   
       }
   
   // 方式三:. ImportDefinitionRegistrar:接口通过向
       class XxxBeanRegistrar implements ImportBeanDefinitionRegistrar{
           @Override
           public void registrarBeanDefinition(AnnotationMetadata anno,
                                               BeanDefinitionRegistrar re){
               // AnnotationMetadata 可以获取到标注了@Import类的相关注解信息
               // BeanDefinitionRegistrar: 收到向注册器中注册组件
           }
       }
       @Import({XxxBeanRegistrar.class,...})  	
       @Configuration
       public class ConfigClass {
   
       }
   ```

8. 使用Spring提供的`FactorBean<T>`接口实现Bean的定义，自定义类实现`FactorBean<T>`

   ```java
   class XxxBean implements FactorBean<Xxx>{
       public Xxx getObject(){
           return Xxx
       }
       public Class<?> getType(){
           return Xxx的类型;
       }
       public Boolean isSingleton(){
           return 是否是单例;
       }
   }
   
   // 将XxxBean注入到Spring容器中,默认获取的是工厂创建的对象
   ```

9. @PropertiesSource：引入外部的properties配置文件

第二部分 扩展原理

1. @Value：可以赋值基本数据注重类型；可以使用Spel表达式#{}；获取配置文件中的变量${}；

   ```java
   applicationContext.getEnvironment();	// SpringIOC容器获取环境变量
   environment.getProperties("key");		// 获取配置文件中的属性
   ```

2. @Autowire：自动注入，注入Bean中指定的名称；required表示是否必须注入，没有注入也可以；

   - @Qualifier：明确指定需要装配的组件ID
   - @Primary：如果容器中相同的多个组件，可以使用给核心的Bean上添加@Primary表示是首选的Bean
   - @Autowire标注在方法上，Spring容器创建对象时候回调用方法完成赋值；而且方法中参数是自定义类型会从IOC容器中获取；
   - @Autowire标注在构造器中，容器启动会调用构造器完成创建对象，定义在构造器中容器就会对容器参数进行初始化完成赋值操作，构造器中的参数会从容器中获取；
   - @Autowire标注在构造器的参数上，效果和标注在构造器上是一样的；

3. @Resource：JSR250规范中的注解，属于Java规范的注解

4. @Inject：JSR330规范中的注解，属于Java规范的注解

5. 

第三部分 WEB支持

01、课程介绍

1. 课程学习内容
   - 容器注解
   - 扩展原理
   - WEB：SpringMVC相关异步

02、@Configuration、@Bean

- @Configuration：Java语句版的spring.xml配置文件，可以通过AnnotationConfigApplicationContext加载配置类并初始化IOC容器对象；
- @Bean：向IOC容器注入bean：bean的类型的方法的返回值类型，bean的名称是方法名称或@Bean的value值，value的值的名称优先级高于方法名

03、@ComponentScan：定义在配置类上：用于扫描指定包中的组件并注入到SpringMVC容器中

- @ComponentScan
  - value、basePackages：指定要扫描的包，
  - basePackageClasses：
  - includeFilters：@Filter指定包含规则
  - excludeFilters：@Filter注解排除规则
- @ComponentScans：包含多个@ComponentScan

04、@Filter的type自定义TypeFilter：

- @Filter.type()
  - FilterType#ANNOTATION：注解
  - FilterType#ASSIGNABLE_TYPE：类型
  - FilterType#ASPECTJ：aspect表达式
  - FilterType#REGEX：正则
  - FilterType#CUSTOM：自定义，实现TypeFilter接口的自定义类型

05、@Scope设置Bean的作用域

- @Bean默认是单实例对象：为@Bean注入的bean指定作用范围为单例或多例@Scope
  - singleton：单例对象
  - prototype：多实例对象
  - request：web环境一次请求创建一个对象
  - session：web环境一次会话创建一个对象

06、@Lazy针对单实例@Bean注解指定为懒加载，在第一次获取时候回创建

07、@Conditional：根据Condition接口的实现类的判断条件确定配置类@Configuration是否生效或者@Bean是否生效

- 自定义Condition：实现接口Condition

  ```java
  
  ```

- SpringBoot内置的Condition实现类

  | 类名 | 作用 |
  | ---- | ---- |
  |      |      |

08、

