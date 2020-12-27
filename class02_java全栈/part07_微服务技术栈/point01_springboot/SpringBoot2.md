# 001、课程介绍

1. 课程大纲
   - 第一季 SpringBoot2核心技术
     - 第一章 基础概念
       1. 介绍Spring技术栈
       2. 快速入门
       3. 自动配置原理
     - 第二章 SpringBoot2核心功能
       1. 配置文件
       2. web开发
       3. 数据访问
       4. Junit单元测试
       5. 生产监控
       6. SpringBoot核心原理
     - 第三章 SpringBoot2场景整合
       1. 虚拟化
       2. 安全控制
       3. 缓存技术
       4. 消息中间件
       5. 分布式
   - 第二季 SpringBoot2响应式编程
     - 第一章 响应式编程基础
       1. 概述
       2. 使用Ractor开发
     - 第二章 WebFlux开发
       1. 使用WebFlux构建Rest应用
       2. 函数是WebFlux
       3. RestTemplate与WebClient
     - 第三章 WebFlux访问持久层
       1. MySQL
       2. Redis
     - 第四章 响应式Web安全开发
       1. Spring Security Reactive
     - 第五章 响应式原理
       1. IO模型
       2. Netty-Reactor
       3. 数据流处理原理

# 002、Spring生态圈

1. Spring技术栈概述：SpringFramework是Spring生态圈的基础：分布式微服务开发、响应式编程（Reactive）、Cloud（分布式开发）、WEB、Serverless（函数式开发）、Event Driver（事件驱动开发）、Batch（批处理）
2. SpringBoot作为生态圈配置地狱的解决方案：是基于Spring5应用响应式编程，使用Java8新特性重新设计源码架构，可以快速创建Spring的生产级别的应用，核心是内嵌Servlet容器，内置的自定义的starter简化配置，并且提供生产级别监控、健康检查及外部化配置；
3. SpringBoot的注意点：版本迭代块，需要经常关注更新变化；内部封装太深，原理复杂度高，不太容易精通

# 003、SpringBoot当下的时代背景

1. 微服务：①微服务是一种架构风格：将一个多功能的单体应用拆分为单功能的多个单体应用，每个应用称为一个服务②每个服务运行在自己进程中，可以独立部署和升级③服务之间的通信可以使用轻量级的Http技术④微服务去中心化：数据分离，服务自治，自由通信；
2. 分布式：拆分出的单体应用在部署时候可以独立部署，称为应用的分布式；
   1. 分布式应用面临的问题：
      - 远程调用
      - 服务发现
      - 负载均衡
      - 服务容错
      - 配置管理
      - 服务监控
      - 链路追踪
      - 日志管理
      - 任务调度
   2. 分布式解决方案：SpringBoot + SpringCloud
3. 云原生：应用上云（①服务自愈②弹性伸缩③服务隔离④自动化部署⑤灰度发布⑥流量治理）

# 004、SpringBoot官方文档

1. 文档结构

# 005、SpringBoot入门

1. Maven设置：使用国内镜像，使用Java8作为编译版本

   ```xml
   
   ```

2. SpringBoot父工程依赖

   - 依赖方式一

     ```xml
     
     ```

   - 依赖方式二

     ```xml
     
     ```

3. SpringBoot WEB场景启动器

   ```xml
   
   ```

4. SpringBoot启动类

5. 定义测试接口：/hello

6. 打包、启动、测试访问

# 006、SpringBoot 依赖管理

1. 依赖管理机制：

   - 引入spring-boot-starter-parent依赖
   - 这个依赖也有一个父pom：spring-boot-dependences
   - 在改pom.xml的properties中声明了SpringBoot启动器中所依赖的所有依赖的版本号
   - 自定义依赖版本：自定义properties中重写SpringBoot的版本配置

2. 场景启动器

   - 官方提供的starter：是对一种功能场景的描述，包含了改功能所有的依赖；官方提供的场景启动器命名规则是：spring-boot-starter-*；

   - 自定义starter：建议的命名规则是：*-spring-boot-starter表示是由第三方开发提供的启动器；所有场景启动器最底层的依赖是：spring-boot-starter

     ```xml
     <dependency>
         <groupId>org.springframework.boot</groupId>
         <artifactId>spring-boot-starter</artifactId>
         <version>2.4.0</version>
         <scope>compile</scope>
     </dependency>
     ```

# 007、自动配置特性

- 主程序所在的包及其子包中组件都会被扫描进Spring容器中
- 各种配置都有定义的默认值
- SpringBoot所有自动配置都定义在：spring-boot-autoconfigure依赖中

# 008、注解详解-@Configuration

- @Configuration + @Bean

- 获取到配置类实例：调用配置方法默认是从容器中获取组件，配置类是代理对象，@Configuration.proxyBeanMethods=false表示是轻量级模式，容器内不会检查配置方法在容器中是否存在，直接返回结果；

# 009、注解详解 - 底层注解

1. @Controller、@RestController、@Service、@Repository、@Component
2. @ComponentScan、@ComponentScans
3. @Import：作用是给容器中导入注解，必须标准在Spring的组件之上，Class类型属性表示需要导入的类型，调用该类型的无参构造器并注入到Spring组件；导入的组件名称是该类的全类名

# 010、注解详解-@Condition条件装配

1. @Condition的派生注解

   | 派生 | 作用 |
   | ---- | ---- |
   |      |      |

2. 自定义@Condition派生注解

# 011、注解详解-@ImportResource

1. 导入Spring的xml类型的配置文件，并加载到容器

# 012、注解详解-@ConfigurationProperties配置绑定

1. @ConfigurationPropertiesprefix：指定在配置文件中的属性前缀
2. @EnableConfigurationProperties：表示开启属性配置功能，需要指定需要开启的组件，并将这个注解注入到容器中

# 013、自动配置原理

1. @SpringBootApplication是一个合成注解，引导加载自动配置类

   ```java
   @SpringBootConfiguration
   @EnableAutoConfiguration
   @ComponentScan(excludeFilters = { @Filter(type = FilterType.CUSTOM, classes = TypeExcludeFilter.class),
   		@Filter(type = FilterType.CUSTOM, classes = AutoConfigurationExcludeFilter.class) })
   public @interface SpringBootApplication {}
   ```

   1. @SpringBootConfiguration：是SpringBoot提供的配置类表示

   2. @ComponentScan：包扫描，自定义的扫描器

   3. @EnableAutoConfiguration：是一个合成注解

      ```java
      @AutoConfigurationPackage
      @Import(AutoConfigurationImportSelector.class)
      public @interface EnableAutoConfiguration {}
      ```

      1. @AutoConfigurationPackage：自动配置包，底层是@Import导入AutoConfigurationPackages.Registrar.class，作用是批量给容器中导入注解，作用是将主启动类所在的包以及子包下的所有组件添加到Spring容器中；
      2. @Import：导入组件AutoConfigurationImportSelector.class：作用是使用方法getAutoConfigurationEntry(annotationMetadata)给容器中批量导入组件，改方法的作用是读取当前系统的所有的的配置文件，名称为：/META-INF/spring.factories，读取了AutoConfiguration属性
      3. 按需开启自动配置项：安装条件装配规则，将自动配置类添加到Spring容器

# 015、自动配置流程