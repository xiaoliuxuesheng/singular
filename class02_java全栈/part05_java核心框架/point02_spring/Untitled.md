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

