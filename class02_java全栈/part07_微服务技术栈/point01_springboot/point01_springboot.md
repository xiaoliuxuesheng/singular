# 第一章 SpringBoot入门

## 1.1 SpringBoot简介

​		从 2002 年开始，Spring 一直在飞速的发展，如今已经成为了在Java EE（Java Enterprise Edition）开发中真正意义上的标准，但是随着技术的发展，Java EE使用 Spring 逐渐变得笨重起来，大量的 XML 文件存在于项目之中。**繁琐的配置，整合第三方框架的配置问题，导致了开发和部署效率的降低**。  

​		2012 年 10 月，Mike Youngstrom 在 Spring jira 中创建了一个功能请求，要求**在 Spring 框架中支持无容器 Web 应用程序体系结构**。这一要求促使了 2013 年初开始的 Spring Boot 项目的研发，到今天，Spring Boot 的版本已经到了 2.0.3 RELEASE。Spring Boot 并不是用来替代 Spring 的解决方案，而**是和 Spring 框架紧密结合用于提升 Spring 开发者体验的工具**。

​		SpringBoot是Spring技术栈的一部分，核心特点是快速的创建基于Spring的J2EE的产品级应用。

## 1.2 Spring Boot的优点

<img src="https://s1.ax1x.com/2020/05/08/YnEXGV.png" alt="YnEXGV.png" border="0" />



## 1.3 微服务简介



## 1.4 搭建入门程序

<font size=4 color=blue>▲  基础坏境准备</font>

1. 环境要求：JDK7+、Maven3.9+、Gradle4.9+、Windows、Linux、Mac
2. 学习背景：Spring、Mybatis、SpringMVC
3. IDEA软件配置：JDK配置、Maven设置、文件编码设置

<font size=4 color=blue>▲ ​​使用Maven搭建Helloworld</font>

1. 新建Maven项目

2. 修改pom.xml

   ```xml
   <parent>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-starter-parent</artifactId>
       <version>2.2.2.RELEASE</version>
   </parent>
   <dependencies>
       <dependency>
           <groupId>org.springframework.boot</groupId>
           <artifactId>spring-boot-starter-web</artifactId>
       </dependency>
   </dependencies>
   ```

3. 新增主启动类

   ```java
   @SpringBootApplication
   public class XXXApplication {
       public static void main(String[] args) {
           SpringApplication.run(XXXApplication.class, args);
       }
   }
   ```

4. 定义WEB接口并测试

<font size=4 color=blue>▲ 使用Gradle搭建Helloworld</font>

<font size=4 color=blue>▲ 简化打包部署</font>

1. 添加打包插件

   - maven

     ```xml
     <build>
         <plugins>
             <plugin>
                 <groupId>org.springframework.boot</groupId>
                 <artifactId>spring-boot-maven-plugin</artifactId>
             </plugin>
         </plugins>
     </build>
     ```

   - gradle

     ```groovy
     
     ```

2. 执行打包命令

   - maven

     ```sh
     mvn package
     ```

   - gradle

     ```sh
     gradle build
     ```

3. 将打包好的jar包启动

   ```sh
   java -jar xxx.jar
   ```

## 1.5 SpringBoot自动配置原理

### <font size=4 color=blue>▲  解析pom.xml</font>

1. **spring-boot-starter-parent的作用**

   ​		`spring-boot-starter-parent`的依赖是`spring-boot-dependencies`，在`spring-boot-dependencies`中管理者当前SpringBoot版本中所有依赖的版本，是一个依赖的版本仲裁中心。

2. **spring-boot-starter-xxx的作用**

   ​		`spring-boot-starter-xxx`称为场景启动器，Spring应用中会有非常多的场景，每种场景所依赖的jar都不同，SpringBoot的场景启动器只需要一个入口配置，就可以将特定场景中使用的所有依赖引入项目。

### <font size=4 color=blue>▲  解析主启动类</font>

- **主启动类注解：@SpringBootApplication**

  ```java
  @SpringBootConfiguration
  @EnableAutoConfiguration
  ...
  public @interface SpringBootApplication {
  	...
  }
  ```

  ​		这个注解是一个组合注解，主要作用是用于声明当前类是一个SpringBoot应用的启动类，需要执行当前类中的main方法启动SpringBoot应用；

  - **SpringBoot主配置类@SpringBootConfiguration**

    ```java
    @Configuration
    ...
    public @interface SpringBootConfiguration {
    	...
    }
    ```

    ​		主配置类的功能是由Spring底层注解`@Configuration`完成，`@Configuration`主要作用是用于标识当前类的Spring的一个配置类；相当于Spring应用的xml配置文件；

  - **启用SpringBoot自动配置：@EnableAutoConfiguration**

    ```java
    @AutoConfigurationPackage
    @Import(AutoConfigurationImportSelector.class)
    ...
    public @interface EnableAutoConfiguration {
    	../
    }
    ```

    ​		这个注解是一个组合注解，主要作用是给当前应用的Spring容器中注入组件；

    - **自动配置扫描包：@AutoConfigurationPackage**

      ```java
      @Import(AutoConfigurationPackages.Registrar.class)
      public @interface AutoConfigurationPackage {
      
      }
      ```

      ​		自动配置扫描包的功能是由Spring底层的`@Import`标签实现，导入类`AutoConfigurationPackages.Registrar.class0` 的作用是扫描主启动类的包以及子包中的组件并注入Spring容器；

    - **自动配置导入选择器：@Import(AutoConfigurationImportSelector.class)**

      ​		`AutoConfigurationImportSelector`主要作用是获取类加载器加载当前包中`META-INF/spring.factories`文件，读取`EnableAutoConfiguration`属性的值，这些值是全类名的形式保存，SpringBoot读取到这些全类名并将这些类注入到Spring容器，这些类都是`xxxAutoConfiguration`类，这些类完成的大部分的自动配置。

### <font size=4 color=blue>▲ 自动配置原理</font>

​		`xxxAutoConfiguration`类类中有大量的默认配置属性，完成了自动配置，自动配置类一般需要在一定的条件下才可以生效，使用配置打开debug查看生效的自动配置选项：`debug=true`

​		如果需要修改SpringBoot中的默认选项，需要查看对应的`xxxAutoConfiguration`类中的属性，将这些属性值在配置文件中指定新值完成修改默认启动选项。

```java
@Configuration(proxyBeanMethods = false)
@EnableConfigurationProperties(HttpProperties.class)
@ConditionalOnWebApplication(type = ConditionalOnWebApplication.Type.SERVLET)
@ConditionalOnClass(CharacterEncodingFilter.class)
@ConditionalOnProperty(prefix="spring.http.encoding",value="enabled",matchIfMissing=true)
public class HttpEncodingAutoConfiguration {
    @Bean
	@ConditionalOnMissingBean
	public CharacterEncodingFilter characterEncodingFilter() {
		CharacterEncodingFilter filter = new OrderedCharacterEncodingFilter();
		filter.setEncoding(this.properties.getCharset().name());
		filter.setForceRequestEncoding(this.properties.shouldForce(Type.REQUEST));
		filter.setForceResponseEncoding(this.properties.shouldForce(Type.RESPONSE));
		return filter;
	}
}
```

★ **`xxxAutoConfiguration`类中相关注解说明：**

​			▲ @Configuration：表示是一个Spring配置类

​			▲ @EnableConfigurationProperties：启用ConfigurationProperties，主要属性被标签指定的类封装，能		配置的属性都在这个XxxProperties类中封装；

​			▲ @ConditionalOnWebApplication：判断当前应用是否是WEB应用，如果是则当前配置类生效

​			▲ @ConditionalOnProperty：条件判断，当前配置属性中是否有这个配置matchIfMissing = true，如果		没有这个属性也判定有效。

​			▲ @Bean：给Spring容器中添加一个组件；

​			▲ @ConditionalOnClass：条件判断，如果当前项目中没有这个类，则启用

​			▲ @ConditionalOnMissingBean：条件搬到，当Spring容器中没有这个Bean将该组件加到Spring容器

★  **@Condition派生注解的功能 **

<img src="https://s1.ax1x.com/2020/05/08/YnVAG6.png" alt="YnVAG6.png" border="0" />

# 第二章 SpringBoot配置文件

## 2.1 配置文件基本用法

### <font size=4 color=blue>▲ 配置文件说明</font>

​		springboot底层实现了大量的自动配置，在自动配置类中配置了当前场景的默认值，配置文件的作用是用来 修改SpringBoot自动配置的默认值；

​		springboot配置文件的位置和名称是固定的：配置文件位置默认是在项目的根目录下，文件名称默认是`application`（文件类型由两种：`.properties`和`.yml`）。

​		Spring Cloud 构建于 Spring Boot 之上，在 Spring Boot 中有两种上下文，一种是 **bootstrap**, 另外一种是 **application**, bootstrap 是应用程序的父上下文，也就是说 bootstrap 加载优先于 applicaton。bootstrap 主要用于从额外的资源来加载配置信息，还可以在本地外部配置文件中解密属性。这两个上下文共用一个环境，它是任何Spring应用程序的外部属性的来源。bootstrap 里面的属性会优先加载，它们默认也不能被本地相同配置覆盖。

### <font size=4 color=blue>▲ application.properties</font>

1. **properties类型文件的特征：**properties文件的内容格式是`键=值`的格式，可以用“#”作为注释，java中提供了配置文件的操作类Properties类（java.util.Properties）读取properties文件的通用方法：根据键得到value；

   ```java
   Properties prop = new Properties();
   prop.load(new FileInputStream(filePath));
   String value = prop.getProperty(key);
   ```

2. **properties配置文中各种值的书写格式**

   - **普通值(字面量)的格式**

     ```properties
     #设置字符类型的值
     key1=字符串常量  
     
     #设置属性类型的值
     key2=15      
     
     #布尔类型的值
     key3=0 | 1 或 true|false
     ```

   - **日期Date类型：**默认格式是`yyyy-MM-dd HH:mm:ss `

     ```properties
     date.key=1990/03/12
     ```

   - **使用内置random的api注入随机数**

     ```properties
     #随机字符串
     com.blog.stringValue=${random.value}
     
     #随机int
     com.blog.numberValue=${random.int}
     
     #随机long
     com.blog.bignumberValue=${random.long}
     
     #10以内的随机数
     com.blog.randomValue0=${random.int(10)}
     
     #10-20的随机数
     com.blog.randomValue1=${random.int[10,20]}
     ```

   - **使用属性占位符获取在前面配置过的属性**

     ```properties
     com.blog.name=博客
     com.blog.uri=博客地址
     com.blog.title=${com.blog.name}的地址是${com.blog.uri}
     com.blog.default=${com.blog.name:如果获取不到这里是默认值}
     ```

   - **对象(属性和值)、Map(键值对)**

     ```properties
     map.key1=zhangsan
     map.key2=20
     ```

   - **数组、list、set**

     ```properties
     list=值1,值2,值3
     ```

### <font size=4 color=blue>▲ application.yml</font>

1. **yml配置文件特征：**

   - 是一种标记语言，通常以.yml为后缀的文件，以数据为中心，是一种直观的能够被电脑识别的数据序列化格式，
   - yml文件的约定的格式：
     - ①k: v 表示键值对关系，冒号后面必须有一个空格；
     - ② 使用空格的缩进表示层级关系，空格数目不重要，只要是左对齐的一列数据，都是同一个层级的；
     - ③松散表示，java中对于驼峰命名法，可用原名或使用-代替驼峰

2. **yml配置文中各种值的书写格式**

   - **普通值(字面量)**

     ```yml
     #字符串类型
     key: zhangsan
     key: 'zhangsan \n lisi'		# 双引号不会转义字符串里面的特殊字符；作为本身想表示的意思
     key: "zhangsan \n lisi"		# 单引号会转义特殊字符，特殊字符最终只是一个普通的字符串数据
     
     #数值类型
     key: 18
     
     #布尔值只可以是true 或 false ,yml不会识别0和1
     key: true
     ```

   - **日期**：默认格式是`yyyy-MM-dd HH:mm:ss `

     ```yml
     date: 2019/01/01
     ```

   - **使用内置random的api注入随机数**

     ```yml
     com:
     	blog:
     		stringValue: ${random.value}		# 随机字符串
     		numberValue: ${random.int}			# 随机int
     		bignumberValue: ${random.long}		# 随机long
     		randomValue0: ${random.int(10)} 	# 10以内的随机数
     		randomValue1: ${random.int[10,20]}	# 10-20的随机数
     		default: ${com.blog.name:默认值}	  # 如果获取不到属性值,冒号指定默认值
     ```

      - **使用属性占位符获取在前面配置过的属性**

        ```yml
        com: 
        	blog: 
        		name: 博客
        		uri: 博客地址
        		title: ${com.blog.name}的地址是${com.blog.uri}
        ```

   - **对象(属性和值)、Map(键值对)**

     ```yml
     #使用缩进表示
     people:
         name: zhangsan
         age: 20
         
     #行内写法：用{}封装属性
     people: {name:zhangsan,age: 20}
     ```

   - **数组、list、set**

     ```yml
     #使用缩进表示
     pets:
         - dog
         - pig
         - cat
     #行内写法：用[]封装属性
     pets: [dog,pig,cat]
     ```

## 2.3 属性注入的方式

### <font size=4 color=blue>▲ @ConfigurationProperties 与 @EnableConfigurationProperties</font>

- 如果属性配置类不是Spring容器中的组件，而且只使用了@ConfigurationProperties注解，然后该类没有在扫描路径下或者没有使用@Component等注解，导致无法被扫描为bean，那么就必须在配置类上使用`@EnableConfigurationProperties`注解去指定这个类，这个时候就会让该类上的`@ConfigurationProperties`生效，然后作为bean添加进spring容器中

  ```java
  /*
  	@Configuration声明这个类是配置类
   	@EnableConfigurationProperties使注解中指定的数组中的ConfigurationProperties类生效，并将		它们添加到Spring容器中
  */
  @Configuration
  @EnableConfigurationProperties({XxxProperties.class, YyyProperties.class})
  public class XxxConfigurationProperties {
      
  }
  
  // 将XxxProperties类添加到Spring容器，并且属性与配置文件中对应属性完成绑定
  @ConfigurationProperties(prefix = "配置文件前缀")
  public class XxxProperties {
      
  }
  
  // 将YyyProperties，并且属性与配置文件中对应属性完成绑定
  @ConfigurationProperties(prefix = "配置文件前缀")
  public class YyyProperties {
      
  }
  ```

- 属性类只使用了`@ConfigurationProperties`注解，然后该类没有在扫描路径下或者没有使用@Component等注解，导致无法被扫描为bean，那么就必须在配置类上使用@EnableConfigurationProperties注解去指定这个类，这个时候就会让该类上的@ConfigurationProperties生效，然后作为bean添加进spring容器中

- 如果该类只使用了@ConfigurationProperties注解，然后该类没有在扫描路径下或者没有使用@Component等注解，导致无法被扫描为bean，那么就必须在配置类上使用@EnableConfigurationProperties注解去指定这个类，这个时候就会让该类上的@ConfigurationProperties生效，然后作为bean添加进spring容器

  ```java
  // 将属性配置类声明为Spring中的一个组件, 则会自动完成属性绑定工作
  @Component
  @ConfigurationProperties(prefix = "配置文件前缀")
  public class XxxProperties {
      
  }
  ```

### <font size=4 color=blue>▲ @Value</font>

- **为属性注入字面的值**

  ```java
  @Value("字符串")
  private String key1;
  
  @Value("100")
  private Integer key2;
  ```

- **为属性注入环境变量中的值`${配置文件中key}`：**主要是值配置文件中的key

  ```java
  @Value("${cat.catName}")
  private String propertiesKey;
  ```

- **为属性注入Spel运算结果：**`#{Spel表达式}`

  ```java
  @Value("#{10*10}")
  private String spelValue;
  ```

### <font size=4 color=blue>▲ @ConfigurationProperties与@Value 区别</font>

| 功能                      | @ConfigurationProperties | @Value   |
| ------------------------- | ------------------------ | -------- |
| 功能                      | 批量注入                 | 单个属性 |
| 松散语法(下划线与驼峰)    | 支持                     | 不支持   |
| Jsr303注入校验(@Validate) | 支持                     | 不支持   |
| Spel表达式                | 不支持                   | 支持     |
| 复杂对象封装              | 支持                     | 不支持   |

- 涉及到复杂对象的封装必须使用@ConfigurationProperties方式

### <font size=4 color=blue>▲ 属性配置数据校验</font>

- JSR303校验规范必须配合@ConfigurationProperties才会生效

  - 第一步：定义属性配置类

  - 第二步：添加@ConfigurationProperties注解指定属性前缀

  - 第三步：使属性配置类注入Spring容器

  - 第四步：为配置类启用属性校验@Validate

  - 第五步：为属性添加校验规则

    ```java
    @Component
    @ConfigurationProperties(prefix = "配置文件前缀")
    @Validate
    public class XxxProperties {
        @Email
        privete String email;
    }
    ```

## 2.4 SpringBoot加载外部配置文件

### <font size=4 color=blue>▲ 加载外部配置文件</font>

- @EnableConfigurationProperties注解注入到Spring容器中组件只能读取到主配文件application中的属性，如果需要读取其他自定义的配置文件需要使用@PropertySource记载

  ```java
  @Component
  @ConfigurationProperties(prefix = "属性前缀")
  @PropertySource(value = {"classpath:根路径下自定义配置文件路径"})
  public class Person {
  	... ...
  }
  ```

### <font size=4 color=blue>▲ 加载外部Spring配置文件</font>

- <del>需要在Spring中的一个配置类上添加：@ImportResource注解，一般没人会这样使用</del>

  ```java
  @SpringBootApplication
  @ImportResource(value = {"classpath:xxx.xml"})
  public class SpringbootConfigApplication {
  
      public static void main(String[] args) {
          SpringApplication.run(SpringbootConfigApplication.class, args);
      }
  
  }
  ```

- SpringBoot推荐使用@Configuration定义Java编写的配置类

  ```java
  @Configuration
  public class SpringbootConfigApplication {
  	... ...
  }
  ```

## 2.5 SpringBoot多环境支持→profile

### <font size=4 color=blue>▲ profile介绍</font>

​		Profile是Spring对不同环境提供不同功能的支持，可以通过启动参数激活指定参数对应的Profile配置，以达到快速切换环境。

### <font size=4 color=blue>▲ profile文件格式</font>

1. **多profile文件格式**

   - 主配置文件：application.yml
   - profile配置文件：application-profile标识.yml

2. **多profile文档块格式**：全部定义在主配置文件application.yml中

   ```yml
   # 主文档
   spring:
   	profiles:
   		active: 指定激活的profile的文档标识
   		
   ---
   # profile文档块1
   spring:
   	profile: profile1的文档标识
   	
   	
   ---
   # profile文档块2
   spring:
   	profile: profile2的文档标识
   ```

3. **Profile的激活方式**

   - **在命令行指定profile：**--spring.profiles.active=profile标识
   - **配置文件中指定profile属性：**spring.profiles.active=profile标识
   - **jvm启动参数：**-Dspring.profiles.active=profile标识

## 2.6 配置文件类型与加载顺序

### <font size=4 color=blue>▲ bootstrap.yml优先加载</font>

### <font size=4 color=blue>▲ 主配置文件加载顺序</font>

> - SpringBoot启动会扫描以下位置的application主配置文件作为默认配置文件，一下位置的配置文件的加载顺序是**从高到低**，所有位置的配置文件都会被加载，高优先级的配置会覆盖低优先级的配置, 这几个配置文件形成互补配置。
> - 通过spring.config.location改变默认配置，在项目打包后，在启动命令行参数后加这个属性，指定jar包之外的配置文件，这个外部配置文件和项目中的配置文件一起生效形成互补配置。

1. <kbd>/config</kbd>：项目的跟目录中新建config文件中的application配置文件；
2. <kbd>/</kbd>：项目的跟目录中的application配置文件；
3. <kbd>classpath:/config</kbd>：项目的classpath下（resources）的config文件中的application配置文件；
4. <kbd>classpath:/</kbd>：项目的classpath下（resources）的application配置文件；

### <font size=4 color=blue>▲ 外部属性加载</font>

- SpringBoot中属性配置不仅可以定义在指定的主配置文件中，在以下的位置都可以加载配置文件

  1. **命令行参数：**所有的配置都可以在命令行上进行指定，多个配置用空格分开

     ```sh
     java -jar xxx.jar --配置项=值
     ```

  2.  来自java:comp/env的JNDI属性 

  3. Java系统属性（System.getProperties()）

  4. 操作系统环境变量 

  5. RandomValuePropertySource配置的random.*属性值  

     **<font color=red size=4> ★ 由jar包外向jar包内进行寻找 </font>**

     ​	**<font color=red> ▲ 由jar包外向jar包内进行寻找， 优先加载带proﬁle </font>**

  6. **jar包外部的application-{proﬁle}.properties或application.yml(带spring.proﬁle)配置文件**

  7. **jar包内部的application-{proﬁle}.properties或application.yml(带spring.proﬁle)配置文件**  

     ​	**<font color=red> ▲ 再来加载不带proﬁle </font>**

  8. **jar包外部的application.properties或application.yml(不带spring.proﬁle)配置文件** 

  9. **jar包内部的application.properties或application.yml(不带spring.proﬁle)配置文件**

  10. @Conﬁguration注解类上的@PropertySource

  11. .通过SpringApplication.setDefaultProperties指定的默认属性

# 第三章 SpringBoot日志框架

## 3.1 日志框架介绍

<font size=4 color=blue>▲ 日志框架使用原理</font>：主流日志框架有自己的日志抽象接口，并且为接口提供的不同的实现从而形成了不同的日志框架，在开发中使用主流日志框架时，首先需要引入的日志的抽象层，对日志开发是面向接口开发的；其次需要引入该抽象层的实现，并且只能引入一个实现；有些框架默认自带有日志系统，所以在开发中需要解决的首要问题就是日志冲突问题

<font size=4 color=blue>▲ 主流的日志抽象层以及对应的实现层</font>

| 接口层                                    | 实现层                                                       |
| ----------------------------------------- | ------------------------------------------------------------ |
| <del>jboss-logging</del>                  | 比较优秀，日志框架稍微高级，使用难度较高                     |
| <del>JCL( jakarta commons logging )</del> | Apache开发的Commons logging日志，停止维护很久了              |
| <del>JUL（java.util.logging）</del>       | 是java为了和log4j挣市场开发的                                |
| **SLF4j**                                 | <del>① 首先诞生的是Log4j这个日志框架，有性能问题</del><br />② 为解决Log4j性能问题，重新开发的**Logback**日志框架 |
| Log4j2                                    | Apache借Log4j之名而开发，很优秀，但是主流框架未适配          |

- Spring 中默认是 : commons-logging
- SpringBoot 中默认是 : SLF4j + logback组合

## 3.2 日志框架使用方式

<font size=4 color=blue>▲ 正常情况的日志框架引入</font>：首先在java应用中引入`slf4j-api`日志抽象层，并为这个抽象层添加一个日志实现层的框架，建议使用`logback`：`logback-classic`、`logback-core`

<img src="https://s1.ax1x.com/2020/05/08/YnVdds.png" alt="YnVdds.png" border="0" />

<font size=4 color=blue>▲ 日志替换处理方案</font>：如果应用中的使用的日志接口是SLF4J，在不改变代码的情况下可以引入有log4j提供的日志适配包+对应的日志框架即可完成替换。

<img src="https://s1.ax1x.com/2020/05/08/YnVfoR.png" alt="YnVfoR.png" border="0" />

<font size=4 color=blue>▲ 日志统一处理方案</font>：在Java应用开发中经常使用到各种成熟框架，而这些框架一般会有默认的日志框架，如果在使用这些Java框架后需要统一日志框架的使用方式，需要为这些Java框架的默认的日志框架引入日志替换包，并且一定要移除掉应用框架的默认的日志框架。

<img src="https://s1.ax1x.com/2020/05/08/YnV5Jx.png" alt="YnV5Jx.png" border="0" />

## 3.3 SpringBoot中的日志框架profile

<font size=4 color=blue>▲ SpringBoot的日志配置</font>：

- 

<font size=4 color=blue>▲ SpringBoot的日志格式说明</font>：

# 第四章 SpringBoot WEB开发



# 第五章 SpringBoot与Docker



# 第六章 Spring Boot启动配置原理



# 第七章 SpringBoot自定义启动器



@ConditionalOnClass：当类路径classpath下有指定的类的情况下进行自动配置

@ConditionalOnMissingBean:当容器(Spring Context)中没有指定Bean的情况下进行自动配置

@ConditionalOnProperty(prefix = “example.service”, value = “enabled”, matchIfMissing = true)，当配置文件中example.service.enabled=true时进行自动配置，如果没有设置此值就默认使用matchIfMissing对应的值

@ConditionalOnMissingBean，当Spring Context中不存在该Bean时。

@ConditionalOnBean:当容器(Spring Context)中有指定的Bean的条件下

@ConditionalOnMissingClass:当类路径下没有指定的类的条件下

@ConditionalOnExpression:基于SpEL表达式作为判断条件

@ConditionalOnJava:基于JVM版本作为判断条件

@ConditionalOnJndi:在JNDI存在的条件下查找指定的位置

@ConditionalOnNotWebApplication:当前项目不是Web项目的条件下

@ConditionalOnWebApplication:当前项目是Web项目的条件下

@ConditionalOnResource:类路径下是否有指定的资源

@ConditionalOnSingleCandidate:当指定的Bean在容器中只有一个，或者在有多个Bean的情况下，用来指定首选的Bean