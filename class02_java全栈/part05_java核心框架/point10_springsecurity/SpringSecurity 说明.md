# SpringSecurity 说明

> SpringSecurity是一个提供授权和认证的框架，并且可以拦截常见的攻击，实际上成为了保护基于Spring的引用程序的标准

# 入门

## 1. 先决条件

- 需要Java8运行环境

## 2. SpringSecurity社区

### 2.1 获取帮助

- 阅读官方文档
- [示例程序](https://github.com/spring-projects/spring-security-samples/tree/5.5.1)
- [stackoverflow](https://stackoverflow.com/questions/tagged/spring-security)
- [issues](https://github.com/spring-projects/spring-security/issues)

### 2.2 投入

### 2.3 源码

- [Github Security](https://github.com/spring-projects/spring-security/)

### 2.4 Apache 2许可

### 2.5 社会媒体

- [twitter](https://twitter.com/SpringCentral)

## 3 Security 5.5

### 3.1 Servlet

- OAuth 2.0 Client
  - 增加了对Jwt客户端认证private_key_jwt和client_secret_jwt的支持
  - 增加了Jwt持有者授权授权支持
  - 增加了ReactiveOAuth2AuthorizedClientService的R2DBC实现
- OAuth 2.0 Resource Server
  - 增强的JWT译码器派生的签名算法
  - 改进的内容等
  - 改进的多租户支持
- SAML 2.0服务提供者
  - 增加了OpenSAML 4的支持
  - 增强的SAML 2.0断言解密
  - 增加了基于文件的配置，用于断言当事人元数据
  - 改进了RelyingPartyRegistration解析支持
  - 增强的依赖方元数据支持
  - 增加了对ap指定签名方法的支持
- 配置
  - 介绍了DispatcherType请求匹配器
  - 为过滤器安全性引入了AuthorizationManager

- 芬兰湾的科特林DSL
  - 添加rememberMe支持

### 3.2 WebFlux

- 增加了对EnableReactiveMethodSecurity的Kotlin协程支持

### 3.3. Build

- 所有示例应用程序都已转移到一个单独的[项目](https://github.com/spring-projects/spring-security-samples)中
- 完整的版本现在可以与JDK 11一起使用

## 4 获取SpringSecurity

### 4.1 版本编号

- MAJOR可能包含破坏性更改。通常，这样做是为了提供改进的安全性，以匹配现代安全实践。
- MINOR版本包含增强，但被认为是被动更新Level应该是完全兼容的，向前和向后，可能的例外是修复bug的更改。
- PATCH Level应该是完全兼容的，向前和向后，可能的例外是修复bug的更改。

### 4.2 使用 with Maven

#### 4.2.1 SpringBootMaven

> 如果使用其他特性(如LDAP、OpenID等)，还需要包括适当的项目模块和依赖项。

- starter

  ```xml
  <dependencies>
      <dependency>
          <groupId>org.springframework.boot</groupId>
          <artifactId>spring-boot-starter-security</artifactId>
      </dependency>
  </dependencies>
  ```

- 重新制定Security版本

  ```xml
  <properties>
      <spring-security.version>5.5.1</spring-security.version>
  </properties>
  ```

- 更新Spring版本

  ```xml
  <properties>
     <spring.version>5.3.8</spring.version>
  </properties>
  ```

#### 4.2.2 非SpringBoot Security

- Security’s BOM

  ```xml
  <dependencyManagement>
      <dependencies>
          <dependency>
              <groupId>org.springframework.security</groupId>
              <artifactId>spring-security-bom</artifactId>
              <version>{spring-security-version}</version>
              <type>pom</type>
              <scope>import</scope>
          </dependency>
      </dependencies>
  </dependencyManagement>
  ```

- 最小的Security依赖

  ```xml
  <dependencies>
      <dependency>
          <groupId>org.springframework.security</groupId>
          <artifactId>spring-security-web</artifactId>
      </dependency>
      <dependency>
          <groupId>org.springframework.security</groupId>
          <artifactId>spring-security-config</artifactId>
      </dependency>
  </dependencies>
  ```

- Spring Security基于Spring Framework 5.3.8构建,添加Spring的pom遇到Spring Security的传递依赖解决Spring Framework 5.3.8这一事实，这可能会导致奇怪的类路径问题

  ```xml
  <dependencyManagement>
      <dependencies>
          <!-- ... other dependency elements ... -->
          <dependency>
              <groupId>org.springframework</groupId>
              <artifactId>spring-framework-bom</artifactId>
              <version>5.3.8</version>
              <type>pom</type>
              <scope>import</scope>
          </dependency>
      </dependencies>
  </dependencyManagement>
  ```

### 4.3 Gradle

#### 4.3.1 SpringBoot Gradle

- starter

  ```groovy
  dependencies {
      compile "org.springframework.boot:spring-boot-starter-security"
  }
  ```

- 修改SpringSecurity版本

  ```groovy
  ext['spring-security.version']='5.5.1'
  ```

- 修改Spring版本

  ```groovy
  ext['spring.version']='5.3.8'
  ```

#### 4.3.2 非SpringBoot Gradle

- SpringSecurity pom

  ```groovy
  plugins {
      id "io.spring.dependency-management" version "1.0.6.RELEASE"
  }
  
  dependencyManagement {
      imports {
          mavenBom 'org.springframework.security:spring-security-bom:5.5.1'
      }
  }
  ```

- 最小依赖

  ```groovy
  dependencies {
      compile "org.springframework.security:spring-security-web"
      compile "org.springframework.security:spring-security-config"
  }
  ```

- Spring

  ```groovy
  plugins {
      id "io.spring.dependency-management" version "1.0.6.RELEASE"
  }
  
  dependencyManagement {
      imports {
          mavenBom 'org.springframework:spring-framework-bom:5.3.8'
      }
  }
  ```

## 5. 特点

> Spring Security提供了对身份验证、授权和防止常见攻击的全面支持。它还提供了与其他库的集成以简化其使用。

### 5.1 Authentication 认证

Spring Security提供了对身份验证的全面支持。身份验证是我们如何验证试图访问特定资源的人的身份。验证用户身份的一种常见方法是要求用户输入用户名和密码。一旦执行了身份验证，我们就知道身份并可以执行授权。

### 5.1.1 认证支持

### 5.1.2 密码存储

Spring Security的PasswordEncoder接口用于执行密码的单向转换，以允许安全地存储密码。通常，PasswordEncoder用于存储密码，在身份验证时需要与用户提供的密码进行比较。

- DelegatingPasswordEncoder在Spring Security 5.0之前，默认的PasswordEncoder是NoOpPasswordEncoder，它需要纯文本密码。根据“密码历史记录”部分，您可能会期望默认的PasswordEncoder现在是类似于BCryptPasswordEncoder的东西。然而，这忽略了三个现实世界的问题:

  - 有许多使用旧密码编码的应用程序无法轻松迁移
  - 密码存储的最佳实践将再次更改。
  - 作为一个框架，Spring Security不能经常进行破坏性的更改

  相反，Spring Security引入DelegatingPasswordEncoder，它通过以下方法解决所有问题:

  - 确保使用当前的密码存储建议对密码进行编码
  - 允许验证现代和传统格式的密码
  - 允许在将来升级编码

  你可以使用PasswordEncoderFactories轻松构造DelegatingPasswordEncoder的实例。

  ```java
  PasswordEncoder passwordEncoder = PasswordEncoderFactories.createDelegatingPasswordEncoder();
  ```

  或者，您可以创建自己的自定义实例。例如:

  ```java
  String idForEncode = "bcrypt";
  Map encoders = new HashMap<>();
  encoders.put(idForEncode, new BCryptPasswordEncoder());
  encoders.put("noop", NoOpPasswordEncoder.getInstance());
  encoders.put("pbkdf2", new Pbkdf2PasswordEncoder());
  encoders.put("scrypt", new SCryptPasswordEncoder());
  encoders.put("sha256", new StandardPasswordEncoder());
  
  PasswordEncoder passwordEncoder =
      new DelegatingPasswordEncoder(idForEncode, encoders);
  ```

  