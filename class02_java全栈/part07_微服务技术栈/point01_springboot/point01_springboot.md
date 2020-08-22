# 第一章 SpringBoot入门

## 1.1 SpringBoot简介

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;从 2002 年开始，Spring 一直在飞速的发展，如今已经成为了在Java EE（Java Enterprise Edition）开发中真正意义上的标准，但是随着技术的发展，Java EE使用 Spring 逐渐变得笨重起来，大量的 XML 文件存在于项目之中。**繁琐的配置，整合第三方框架的配置问题，导致了开发和部署效率的降低**。  

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;2012 年 10 月，Mike Youngstrom 在 Spring jira 中创建了一个功能请求，要求**在 Spring 框架中支持无容器 Web 应用程序体系结构**。这一要求促使了 2013 年初开始的 Spring Boot 项目的研发；在2014年伴随着Spring4.0开发出了SpringBoot；Spring Boot 并不是用来替代 Spring 的解决方案，而**是和 Spring 框架紧密结合用于提升 Spring 开发者体验的工具**。

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;SpringBoot是Spring技术栈的一部分，核心特点是快速的创建基于Spring的J2EE的产品级应用。

## 1.2 SpringBoot的特点

|                             优点                             |                             缺点                             |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| 快速构建项目。<br />对主流开发框架的无配置集成。<br />项目可独立运行，无须外部依赖Servlet容器。<br />提供运行时的应用监控。<br />极大地提高了开发、部署效率。<br />与[云计算](http://c.biancheng.net/cloud_computing/)的天然集成。<br /> | 版本迭代速度很快，一些模块改动很大。<br />由于不用自己做配置，报错时很难定位。<br />网上现成的解决方案比较少。<br /> |

## 1.3 SpringBoot与微服务

## 1.4 SpringBoot入门案例

1. 新建Maven项目，添加SpringBoot依赖

   - **方式一**：通过继承SpringBoot依赖的方式使当前项目具有SpringBoot依赖，而`spring-boot-starter-parent`有是继承自`spring-boot-dependencies`这个pom，所有自定义项目时候也可以采用依赖管理的方式

     ```xml
     <parent>
         <groupId>org.springframework.boot</groupId>
         <artifactId>spring-boot-starter-parent</artifactId>
         <version>xxx.RELEASE</version>
         <relativePath/>
     </parent>
     ```

   - **方式二**：Maven的pom的特点是单继承，在企业开发中，公司一般会有标准parent，有需要SpringBoot环境支持

     ```xml
     <dependencyManagement>
         <dependencies>
             <dependency>
                 <groupId>org.springframework.boot</groupId>
                 <artifactId>spring-boot-dependencies</artifactId>
                 <version>xxx.RELEASE</version>
                 <scope>import</scope>
                 <type>pom</type>
             </dependency>
         </dependencies>
     </dependencyManagement>
     ```

2. 定义主启动类，添加配置@SpringBootApplication

   ```java
   @SpringBootApplication
   public class XxxApplication {
       public static void main(String[] args) {
           SpringApplication.run(XxxApp.class, args);
       }
   }
   ```

3. 添加WEB场景启动器，定义测试Controller启动项目

   ```xml
   <dependency>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-starter-web</artifactId>
   </dependency>
   ```

4. 添加SpringBoot内置Maven插件

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

5. 打包项目，使用Java命令行工具运行打包后的项目

   ```js
   java -jar xxx.jar
   ```

## 1.5 SpringBoot版本管理

- SpringBoot依赖的父pom中管理着内置场景功能所涉及的依赖以及对应的版本信息，例如SpringBoot2.3.2管理的版本号

  ```xml
  <properties>
      <activemq.version>5.15.13</activemq.version>
      <antlr2.version>2.7.7</antlr2.version>
      <appengine-sdk.version>1.9.81</appengine-sdk.version>
      <artemis.version>2.12.0</artemis.version>
      <aspectj.version>1.9.6</aspectj.version>
      <assertj.version>3.16.1</assertj.version>
      <atomikos.version>4.0.6</atomikos.version>
      <awaitility.version>4.0.3</awaitility.version>
      <bitronix.version>2.1.4</bitronix.version>
      <build-helper-maven-plugin.version>3.1.0</build-helper-maven-plugin.version>
      <byte-buddy.version>1.10.13</byte-buddy.version>
      <caffeine.version>2.8.5</caffeine.version>
      <cassandra-driver.version>4.6.1</cassandra-driver.version>
      <classmate.version>1.5.1</classmate.version>
      <commons-codec.version>1.14</commons-codec.version>
      <commons-dbcp2.version>2.7.0</commons-dbcp2.version>
      <commons-lang3.version>3.10</commons-lang3.version>
      <commons-pool.version>1.6</commons-pool.version>
      <commons-pool2.version>2.8.0</commons-pool2.version>
      <couchbase-client.version>3.0.6</couchbase-client.version>
      <db2-jdbc.version>11.5.4.0</db2-jdbc.version>
      <dependency-management-plugin.version>1.0.9.RELEASE</dependency-management-plugin.version>
      <derby.version>10.14.2.0</derby.version>
      <dropwizard-metrics.version>4.1.11</dropwizard-metrics.version>
      <ehcache.version>2.10.6</ehcache.version>
      <ehcache3.version>3.8.1</ehcache3.version>
      <elasticsearch.version>7.6.2</elasticsearch.version>
      <embedded-mongo.version>2.2.0</embedded-mongo.version>
      <exec-maven-plugin.version>1.6.0</exec-maven-plugin.version>
      <flatten-maven-plugin.version>1.2.4</flatten-maven-plugin.version>
      <flyway.version>6.4.4</flyway.version>
      <freemarker.version>2.3.30</freemarker.version>
      <git-commit-id-plugin.version>3.0.1</git-commit-id-plugin.version>
      <glassfish-el.version>3.0.3</glassfish-el.version>
      <glassfish-jaxb.version>2.3.3</glassfish-jaxb.version>
      <groovy.version>2.5.13</groovy.version>
      <gson.version>2.8.6</gson.version>
      <h2.version>1.4.200</h2.version>
      <hamcrest.version>2.2</hamcrest.version>
      <hazelcast.version>3.12.8</hazelcast.version>
      <hazelcast-hibernate5.version>1.3.2</hazelcast-hibernate5.version>
      <hibernate.version>5.4.18.Final</hibernate.version>
      <hibernate-validator.version>6.1.5.Final</hibernate-validator.version>
      <hikaricp.version>3.4.5</hikaricp.version>
      <hsqldb.version>2.5.1</hsqldb.version>
      <htmlunit.version>2.40.0</htmlunit.version>
      <httpasyncclient.version>4.1.4</httpasyncclient.version>
      <httpclient.version>4.5.12</httpclient.version>
      <httpcore.version>4.4.13</httpcore.version>
      <infinispan.version>10.1.8.Final</infinispan.version>
      <influxdb-java.version>2.18</influxdb-java.version>
      <jackson-bom.version>2.11.1</jackson-bom.version>
      <jakarta-activation.version>1.2.2</jakarta-activation.version>
      <jakarta-annotation.version>1.3.5</jakarta-annotation.version>
      <jakarta-jms.version>2.0.3</jakarta-jms.version>
      <jakarta-json.version>1.1.6</jakarta-json.version>
      <jakarta-json-bind.version>1.0.2</jakarta-json-bind.version>
      <jakarta-mail.version>1.6.5</jakarta-mail.version>
      <jakarta-persistence.version>2.2.3</jakarta-persistence.version>
      <jakarta-servlet.version>4.0.4</jakarta-servlet.version>
      <jakarta-servlet-jsp-jstl.version>1.2.7</jakarta-servlet-jsp-jstl.version>
      <jakarta-transaction.version>1.3.3</jakarta-transaction.version>
      <jakarta-validation.version>2.0.2</jakarta-validation.version>
      <jakarta-websocket.version>1.1.2</jakarta-websocket.version>
      <jakarta-ws-rs.version>2.1.6</jakarta-ws-rs.version>
      <jakarta-xml-bind.version>2.3.3</jakarta-xml-bind.version>
      <jakarta-xml-soap.version>1.4.2</jakarta-xml-soap.version>
      <jakarta-xml-ws.version>2.3.3</jakarta-xml-ws.version>
      <janino.version>3.1.2</janino.version>
      <javax-activation.version>1.2.0</javax-activation.version>
      <javax-annotation.version>1.3.2</javax-annotation.version>
      <javax-cache.version>1.1.1</javax-cache.version>
      <javax-jaxb.version>2.3.1</javax-jaxb.version>
      <javax-jaxws.version>2.3.1</javax-jaxws.version>
      <javax-jms.version>2.0.1</javax-jms.version>
      <javax-json.version>1.1.4</javax-json.version>
      <javax-jsonb.version>1.0</javax-jsonb.version>
      <javax-mail.version>1.6.2</javax-mail.version>
      <javax-money.version>1.0.3</javax-money.version>
      <javax-persistence.version>2.2</javax-persistence.version>
      <javax-transaction.version>1.3</javax-transaction.version>
      <javax-validation.version>2.0.1.Final</javax-validation.version>
      <javax-websocket.version>1.1</javax-websocket.version>
      <jaxen.version>1.2.0</jaxen.version>
      <jaybird.version>3.0.9</jaybird.version>
      <jboss-logging.version>3.4.1.Final</jboss-logging.version>
      <jboss-transaction-spi.version>7.6.0.Final</jboss-transaction-spi.version>
      <jdom2.version>2.0.6</jdom2.version>
      <jedis.version>3.3.0</jedis.version>
      <jersey.version>2.30.1</jersey.version>
      <jetty-el.version>8.5.54</jetty-el.version>
      <jetty-jsp.version>2.2.0.v201112011158</jetty-jsp.version>
      <jetty-reactive-httpclient.version>1.1.4</jetty-reactive-httpclient.version>
      <jetty.version>9.4.30.v20200611</jetty.version>
      <jmustache.version>1.15</jmustache.version>
      <johnzon.version>1.2.8</johnzon.version>
      <jolokia.version>1.6.2</jolokia.version>
      <jooq.version>3.13.3</jooq.version>
      <json-path.version>2.4.0</json-path.version>
      <json-smart.version>2.3</json-smart.version>
      <jsonassert.version>1.5.0</jsonassert.version>
      <jstl.version>1.2</jstl.version>
      <jtds.version>1.3.1</jtds.version>
      <junit.version>4.13</junit.version>
      <junit-jupiter.version>5.6.2</junit-jupiter.version>
      <kafka.version>2.5.0</kafka.version>
      <kotlin.version>1.3.72</kotlin.version>
      <kotlin-coroutines.version>1.3.8</kotlin-coroutines.version>
      <lettuce.version>5.3.2.RELEASE</lettuce.version>
      <liquibase.version>3.8.9</liquibase.version>
      <log4j2.version>2.13.3</log4j2.version>
      <logback.version>1.2.3</logback.version>
      <lombok.version>1.18.12</lombok.version>
      <mariadb.version>2.6.2</mariadb.version>
      <maven-antrun-plugin.version>1.8</maven-antrun-plugin.version>
      <maven-assembly-plugin.version>3.3.0</maven-assembly-plugin.version>
      <maven-clean-plugin.version>3.1.0</maven-clean-plugin.version>
      <maven-compiler-plugin.version>3.8.1</maven-compiler-plugin.version>
      <maven-dependency-plugin.version>3.1.2</maven-dependency-plugin.version>
      <maven-deploy-plugin.version>2.8.2</maven-deploy-plugin.version>
      <maven-enforcer-plugin.version>3.0.0-M3</maven-enforcer-plugin.version>
      <maven-failsafe-plugin.version>2.22.2</maven-failsafe-plugin.version>
      <maven-help-plugin.version>3.2.0</maven-help-plugin.version>
      <maven-install-plugin.version>2.5.2</maven-install-plugin.version>
      <maven-invoker-plugin.version>3.2.1</maven-invoker-plugin.version>
      <maven-jar-plugin.version>3.2.0</maven-jar-plugin.version>
      <maven-javadoc-plugin.version>3.2.0</maven-javadoc-plugin.version>
      <maven-resources-plugin.version>3.1.0</maven-resources-plugin.version>
      <maven-shade-plugin.version>3.2.4</maven-shade-plugin.version>
      <maven-source-plugin.version>3.2.1</maven-source-plugin.version>
      <maven-surefire-plugin.version>2.22.2</maven-surefire-plugin.version>
      <maven-war-plugin.version>3.2.3</maven-war-plugin.version>
      <micrometer.version>1.5.3</micrometer.version>
      <mimepull.version>1.9.13</mimepull.version>
      <mockito.version>3.3.3</mockito.version>
      <mongodb.version>4.0.5</mongodb.version>
      <mssql-jdbc.version>7.4.1.jre8</mssql-jdbc.version>
      <mysql.version>8.0.21</mysql.version>
      <nekohtml.version>1.9.22</nekohtml.version>
      <neo4j-ogm.version>3.2.14</neo4j-ogm.version>
      <netty.version>4.1.51.Final</netty.version>
      <netty-tcnative.version>2.0.31.Final</netty-tcnative.version>
      <nio-multipart-parser.version>1.1.0</nio-multipart-parser.version>
      <oauth2-oidc-sdk.version>7.1.1</oauth2-oidc-sdk.version>
      <ojdbc.version>19.3.0.0</ojdbc.version>
      <okhttp3.version>3.14.9</okhttp3.version>
      <oracle-database.version>19.3.0.0</oracle-database.version>
      <pooled-jms.version>1.1.1</pooled-jms.version>
      <postgresql.version>42.2.14</postgresql.version>
      <prometheus-pushgateway.version>0.9.0</prometheus-pushgateway.version>
      <quartz.version>2.3.2</quartz.version>
      <querydsl.version>4.3.1</querydsl.version>
      <r2dbc-bom.version>Arabba-SR6</r2dbc-bom.version>
      <rabbit-amqp-client.version>5.9.0</rabbit-amqp-client.version>
      <reactive-streams.version>1.0.3</reactive-streams.version>
      <reactor-bom.version>Dysprosium-SR10</reactor-bom.version>
      <rest-assured.version>3.3.0</rest-assured.version>
      <rsocket.version>1.0.1</rsocket.version>
      <rxjava.version>1.3.8</rxjava.version>
      <rxjava-adapter.version>1.2.1</rxjava-adapter.version>
      <rxjava2.version>2.2.19</rxjava2.version>
      <spring-boot.version>2.3.2.RELEASE</spring-boot.version>
      <saaj-impl.version>1.5.2</saaj-impl.version>
      <selenium.version>3.141.59</selenium.version>
      <selenium-htmlunit.version>2.40.0</selenium-htmlunit.version>
      <sendgrid.version>4.4.8</sendgrid.version>
      <servlet-api.version>4.0.1</servlet-api.version>
      <slf4j.version>1.7.30</slf4j.version>
      <snakeyaml.version>1.26</snakeyaml.version>
      <solr.version>8.5.2</solr.version>
      <spring-amqp.version>2.2.9.RELEASE</spring-amqp.version>
      <spring-batch.version>4.2.4.RELEASE</spring-batch.version>
      <spring-data-releasetrain.version>Neumann-SR2</spring-data-releasetrain.version>
      <spring-framework.version>5.2.8.RELEASE</spring-framework.version>
      <spring-hateoas.version>1.1.0.RELEASE</spring-hateoas.version>
      <spring-integration.version>5.3.2.RELEASE</spring-integration.version>
      <spring-kafka.version>2.5.4.RELEASE</spring-kafka.version>
      <spring-ldap.version>2.3.3.RELEASE</spring-ldap.version>
      <spring-restdocs.version>2.0.4.RELEASE</spring-restdocs.version>
      <spring-retry.version>1.2.5.RELEASE</spring-retry.version>
      <spring-security.version>5.3.3.RELEASE</spring-security.version>
      <spring-session-bom.version>Dragonfruit-RELEASE</spring-session-bom.version>
      <spring-ws.version>3.0.9.RELEASE</spring-ws.version>
      <sqlite-jdbc.version>3.31.1</sqlite-jdbc.version>
      <sun-mail.version>1.6.5</sun-mail.version>
      <thymeleaf.version>3.0.11.RELEASE</thymeleaf.version>
      <thymeleaf-extras-data-attribute.version>2.0.1</thymeleaf-extras-data-attribute.version>
      <thymeleaf-extras-java8time.version>3.0.4.RELEASE</thymeleaf-extras-java8time.version>
      <thymeleaf-extras-springsecurity.version>3.0.4.RELEASE</thymeleaf-extras-springsecurity.version>
      <thymeleaf-layout-dialect.version>2.4.1</thymeleaf-layout-dialect.version>
      <tomcat.version>9.0.37</tomcat.version>
      <unboundid-ldapsdk.version>4.0.14</unboundid-ldapsdk.version>
      <undertow.version>2.1.3.Final</undertow.version>
      <versions-maven-plugin.version>2.7</versions-maven-plugin.version>
      <webjars-hal-browser.version>3325375</webjars-hal-browser.version>
      <webjars-locator-core.version>0.45</webjars-locator-core.version>
      <wsdl4j.version>1.6.3</wsdl4j.version>
      <xml-maven-plugin.version>1.0.2</xml-maven-plugin.version>
      <xmlunit2.version>2.7.0</xmlunit2.version>
  </properties>
  ```

## 1.6 SpringBoot学习基础

1. Spring内置注解及功能

   | 注解                                  | 描述 |
   | ------------------------------------- | ---- |
   | @ComponentScan                        |      |
   | @Configuration + @Bean                |      |
   | @Configuration + @Import({Xxx.class}) |      |

2. Condition接口

   ```java
   @FunctionalInterface
   public interface Condition {
   
   	/**
   	 * 确定条件是否匹配
   	 * @param context condition的上下文环境
   	 * @param metadata 被检查的类或方法的元信息(注解信息、类信息)
   	 * @return 如果条件匹配，并且组件可以注册
   	 */
   	boolean matches(ConditionContext context, AnnotatedTypeMetadata metadata);
   
   }
   ```

3. @Conditional注解SpringBoot提供的自动配置的常用实现

   | Conditions 实现              | 描述                                  |
   | ---------------------------- | ------------------------------------- |
   | @ConditionalOnBean           | 在存在某个bean的时候                  |
   | @ConditionalOnMissingBean    | 不存在某个bean的时候                  |
   | @ConditionalOnClass          | 当前classpath可以找到某个类型的类时   |
   | @ConditionalOnMissingClass   | 当前classpath不可以找到某个类型的类时 |
   | @ConditionalOnResource       | 当前classpath是否存在某个资源文件     |
   | @ConditionalOnProperty       | 当前jvm是否包含某个系统属性为某个值   |
   | @ConditionalOnWebApplication | 当前spring context是否是web应用程序   |

## 1.7 SpringBoot启动原理

**@SpringBootApplication**：用于表示当前类为SringBoot应用的主配置类，运行当前类的main方法启动SpringBoot应用；这个注解是组合注解，源码如下：

```java
@Target(ElementType.TYPE)
@Retention(RetentionPolicy.RUNTIME)
@Documented
@Inherited
@SpringBootConfiguration
@EnableAutoConfiguration
@ComponentScan(excludeFilters = { @Filter(type = FilterType.CUSTOM, classes = TypeExcludeFilter.class),
		@Filter(type = FilterType.CUSTOM, classes = AutoConfigurationExcludeFilter.class) })
public @interface SpringBootApplication {
    ...
}
```

1. **@SpringBootConfiguration**：表示是SpringBoot的配置类，其底层是Spring提供的`@Configuration`：表示当前类是一个配置类（等价于Spring最初的xml配置文件）

2. **@EnableAutoConfiguration**：开启自动配置功能，在Spring中需要配置的东西，由SpringBoot中完成自动配置，这个注解就是告诉SpringBoot开启自动配置功能；改注解的功能实现由`@AutoConfigurationPackage和 @Import`实现，源码如下：

   ```java
   @Target(ElementType.TYPE)
   @Retention(RetentionPolicy.RUNTIME)
   @Documented
   @Inherited
   @AutoConfigurationPackage // a
   @Import(AutoConfigurationImportSelector.class) // b
   public @interface EnableAutoConfiguration {
   	String ENABLED_OVERRIDE_PROPERTY = "spring.boot.enableautoconfiguration";
   	Class<?>[] exclude() default {};
   	String[] excludeName() default {};
   }
   ```

   1. `@AutoConfigurationPackage`：自动配置包，具体的底层功能是由Spring提供的`@Import`实现，表示给容器中导入组件，源码：`@Import(AutoConfigurationPackages.Registrar.class)`；`metadata`表示注解的元信息（主启动类上注解@SpringBootApplication的元信息），getPackageNames：获取到主启动类的包名，作用是扫描主启动类所在包以及子包里面所有的组件扫描到Spring容器中；

      ```java
      @Target(ElementType.TYPE)
      @Retention(RetentionPolicy.RUNTIME)
      @Documented
      @Inherited
      @Import(AutoConfigurationPackages.Registrar.class)
      public @interface AutoConfigurationPackage {
      }
      
      // ============================================================================================
      static class Registrar implements ImportBeanDefinitionRegistrar, DeterminableImports {
      
      	/**
      	 * 将主配置类所在的包以及子包的组件扫描进IOC容器
      	 * @param metadata 注解的元信息，改注解是标准在主启动类上的
      	 * @param registry Bean注册器
      	 */
          @Override
          public void registerBeanDefinitions(AnnotationMetadata metadata, BeanDefinitionRegistry registry) {
              register(registry, new PackageImports(metadata).getPackageNames().toArray(new String[0]));
          }
      
          @Override
          public Set<Object> determineImports(AnnotationMetadata metadata) {
              return Collections.singleton(new PackageImports(metadata));
          }
      
      }
      ```

   2. `@Import(AutoConfigurationImportSelector.class)`：（开启自动导包的选择器）源码如下：核心方法selectImports()，最用是以全类名的字符串；

      ```java
      @Override
      public String[] selectImports(AnnotationMetadata annotationMetadata) {
          ...
          AutoConfigurationEntry autoConfigurationEntry = getAutoConfigurationEntry(annotationMetadata);
          ...
      }
      
      protected AutoConfigurationEntry getAutoConfigurationEntry(AnnotationMetadata annotationMetadata) {
          ...
          List<String> configurations = getCandidateConfigurations(annotationMetadata, attributes);
          ...
      }
      
      protected List<String> getCandidateConfigurations(AnnotationMetadata metadata, AnnotationAttributes attributes) {
          /**
           *  Spring Boot中的SPI机制：core包里定义了SpringFactoriesLoader类，
           *  - 这个类实现了检索META-INF/spring.factories文件
           *	- 在META-INF/spring.factories文件中配置接口的实现类名称，然后在程序中读取这些配置文件并实例化。
           *  - 这种自定义的SPI机制是Spring Boot Starter实现的基础
           */
          List<String> configurations = SpringFactoriesLoader.loadFactoryNames(getSpringFactoriesLoaderFactoryClass(),
                                                                               getBeanClassLoader());
          Assert.notEmpty(configurations, "No auto configuration classes found in META-INF/spring.factories. If you "
                          + "are using a custom packaging, make sure that file is correct.");
          return configurations;
      }
      
      // 参数一:用类加载器获取META-INF/spring.factories资源,封装为properties,
      // 在properties中读取的属性是名EnableAutoConfiguration的属性值,
      // 将读取到的全类名注入到IOC容器
      protected Class<?> getSpringFactoriesLoaderFactoryClass() {
          return EnableAutoConfiguration.class;
      }
      
      // 参数二:获取到Bean的类加载器
      protected ClassLoader getBeanClassLoader() {
          return this.beanClassLoader;
      }
      ```

## 1.8 自定义SpringBoot Starter

1. 新建Starter项目：官方约定内置启动器名称是：spring-boot-xxx-sarter，而第三方自定义的启动器的命名规范是：xxx-spring-boot-starter

2. 添加自定义starter所需依赖和版本信息

3. 新建配置类：XxxAutoConfiguration，并添加Spring配置类注解@Configuration，并完善自动配置逻辑

4. 配置文件引入自动配置类：在根目录（resources）中添加文件META-INF/spring.factories（**文件夹和路径固定，否则SpringBoot无法识别**），在sspring.factories中使用properties格式添加配置：key=org.springframework.boot.autoconfigure.EnableAutoConfiguration，valux=XxxAutoConfiguration全类名字符串

   ```properties
   org.springframework.boot.autoconfigure.EnableAutoConfiguration=com.XxxAutoConfiguration
   ```

# 第二章 SpringBoot配置

## 2.1 SpringBoot配置文件说明

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;springboot底层实现了大量的自动配置，在自动配置类中配置了当前场景的默认值，配置文件的作用是用来修改SpringBoot自动配置的默认值；

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;springboot配置文件的位置和名称是固定的：配置文件位置默认是在项目的根目录下，文件名称默认是`application`（文件类型由两种：`.properties`和`.yml`）。

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Spring Cloud 构建于 Spring Boot 之上，在 Spring Boot 中有两种上下文，一种是 **bootstrap**, 另外一种是 **application**, bootstrap 是应用程序的父上下文，也就是说 bootstrap 加载优先于 applicaton。bootstrap 主要用于从额外的资源来加载配置信息，还可以在本地外部配置文件中解密属性。这两个上下文共用一个环境，它是任何Spring应用程序的外部属性的来源。bootstrap 里面的属性会优先加载，它们默认也不能被本地相同配置覆盖。

## 2.2 properties配置文件

1. **properties配置文件特征**：properties文件的内容格式是`键=值`的格式，可以用“#”作为注释，java中提供了配置文件的操作类Properties类（java.util.Properties）读取properties文件的通用方法：根据键得到value；

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
     date.key=1999-02-02
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

## 2.3 yml配置文件

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
     date: 2019-01-01
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

## 2.4 属性注入

1. **读取环境变量 @Value**

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

2. **配置环境变量 @ConfigurationProperties**：使用SpringBoot的自定义配置类封装配置文件中属性时候，需要在自定义的属性配置类上添加@ConfigurationProperties注解并制定属性的配置前缀；此时的属性配置类不会被Spring识别，需要使用@Component将属性配置类添加到到Spring容器中，或者使用Spring配置类添加@EnableConfigurationProperties注解讲属性配置类加载进Spring容器中；在项目中添加以下依赖，实现在配置文件中的属性提示

   ```xml
   <dependency>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-configuration-processor</artifactId>
       <optional>true</optional>
   </dependency>
   ```

   - **案例说明：@EnableConfigurationProperties**

     - @ConfigurationProperties(prefix = "配置文件前缀")：首先定义属性配置类

       ```java
       @ConfigurationProperties(prefix = "配置文件前缀")
       public class XxxProperties {
           // getter/setter
       }
       
       @ConfigurationProperties(prefix = "配置文件前缀")
       public class YyyProperties {
           // getter/setter
       }
       ```

     - @Configuration：自定义配置类将自定义属性配置类添加到Spring容器中

       ```java
       /*
       	@Configuration声明这个类是配置类
        	@EnableConfigurationProperties使注解中指定的数组中的ConfigurationProperties类生效，并将它们添加到Spring容器中
       */
       @Configuration
       @EnableConfigurationProperties({XxxProperties.class, YyyProperties.class})
       public class XxxConfigurationProperties {
           
       }
       ```

   - **案例说明：@ConfigurationProperties**

     - @Component：定义属性配置后直接将配置类添加到Spring容器中

       ```jav
       @Component
       @ConfigurationProperties(prefix = "配置文件前缀")
       public class XxxProperties {
           // getter/setter
       }
       
       @Component
       @ConfigurationProperties(prefix = "配置文件前缀")
       public class YyyProperties {
           // getter/setter
       }
       ```

3. **@ConfigurationProperties与@Value 区别**

   > 涉及到复杂对象的封装必须使用@ConfigurationProperties方式

   | 功能                      | @ConfigurationProperties | @Value   |
   | ------------------------- | ------------------------ | -------- |
   | 功能                      | 批量注入                 | 单个属性 |
   | 松散语法(下划线与驼峰)    | 支持                     | 不支持   |
   | Jsr303注入校验(@Validate) | 支持                     | 不支持   |
   | Spel表达式                | 不支持                   | 支持     |
   | 复杂对象封装              | 支持                     | 不支持   |

## 2.5 SpringBoot加载外部配置文件

1. 方式一：SpringBoot推荐使用@Configuration定义Java编写的配置类

   ````java
   @Configuration
   public class XxxConfiguration {
   	... ...
   }
   ````

2. 方式二：<del>需要在Spring中的一个配置类上添加：@ImportResource注解，一般没人会这样使用</del>

   ```java
   @SpringBootApplication
   @ImportResource(value = {"classpath:xxx.xml"})
   public class XxxApplication {
       public static void main(String[] args) {
           SpringApplication.run(XxxApplication.class, args);
       }
   }
   ```

## 2.6 SpringBoot多环境profile配置

1. **profile介绍**：Profile是Spring对不同环境提供不同功能的支持，可以通过启动参数激活指定参数对应的Profile配置，以达到快速切换环境。Profile是Spring对不同环境提供不同功能的支持，可以通过启动参数激活指定参数对应的Profile配置，以达到快速切换环境。

2. **profile文件格式**

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

## 2.7 配置文件类型与加载顺序

1. **bootstrap.yml优先加载**

2. **主配置文件加载顺序**

   > - SpringBoot启动会扫描以下位置的application主配置文件作为默认配置文件，一下位置的配置文件的加载顺序是**从高到低**，所有位置的配置文件都会被加载，高优先级的配置会覆盖低优先级的配置, 这几个配置文件形成互补配置。
   > - 通过spring.config.location改变默认配置，在项目打包后，在启动命令行参数后加这个属性，指定jar包之外的配置文件，这个外部配置文件和项目中的配置文件一起生效形成互补配置。

   - <kbd>/config</kbd>：项目的跟目录中新建config文件中的application配置文件；
   - <kbd>/</kbd>：项目的跟目录中的application配置文件；
   - <kbd>classpath:/config</kbd>：项目的classpath下（resources）的config文件中的application配置文件；
   - <kbd>classpath:/</kbd>：项目的classpath下（resources）的application配置文件；

3. **外部属性加载**：SpringBoot中属性配置不仅可以定义在指定的主配置文件中，在以下的位置都可以加载配置文件

   - **命令行参数：**所有的配置都可以在命令行上进行指定，多个配置用空格分开

     ```sh
     java -jar xxx.jar --配置项=值
     ```

   - 来自java:comp/env的JNDI属性 

   - Java系统属性（System.getProperties()）

   - 操作系统环境变量 

   - RandomValuePropertySource配置的random.*属性值  

     - **<font color=red size=4> ★ 由jar包外向jar包内进行寻找 </font>**

     - **<font color=red> ▲ 由jar包外向jar包内进行寻找， 优先加载带proﬁle </font>**

   - **jar包外部的application-{proﬁle}.properties或application.yml(带spring.proﬁle)配置文件**

   - **jar包内部的application-{proﬁle}.properties或application.yml(带spring.proﬁle)配置文件**  

     - **<font color=red> ▲ 再来加载不带proﬁle </font>**

   - **jar包外部的application.properties或application.yml(不带spring.proﬁle)配置文件** 

   - **jar包内部的application.properties或application.yml(不带spring.proﬁle)配置文件**

   - @Conﬁguration注解类上的@PropertySource

   - 通过SpringApplication.setDefaultProperties指定的默认属性

# 第三章 SpringBoot日志

# 第四章 SpringBoot WEB开发

# 第五章 SpringBoot启动配置原理

# 第六章 SpringBoot自定义starters

