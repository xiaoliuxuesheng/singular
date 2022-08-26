# 1. Prerequisites 学习准备

- 需要Java8以上版本作为运行环境
- Spring Security构建于Spring Framework 5.2.6之上，或许会和Spring5.2.6以下版本不兼容

# 2. Spring Security Community 社区

- Git长裤的issues

# 3. What’s New in Spring Security 5.3

# 4. Getting Spring Security

## 4.1 Maven

- 在SpringBoot项目中添加Maven依赖

  ```xml
  <dependencies>
      <!-- ... other dependency elements ... -->
      <dependency>
          <groupId>org.springframework.boot</groupId>
          <artifactId>spring-boot-starter-security</artifactId>
      </dependency>
  </dependencies>
  ```

  - 覆盖Spring版本的方式

    ```xml
    <properties>
        <spring.version>5.2.6.RELEASE</spring.version>
    </properties>
    ```

  - 修改Security版本的方式

    ```xml
    <properties>
        <spring-security.version>5.3.2.RELEASE</spring-security.version>
    </properties>
    ```

- 在非SpringBoot项目中添加依赖

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

## 4.2 Gradle

- 在SpringBoot项目中添加Security

  ```groovy
  dependencies {
      compile "org.springframework.boot:spring-boot-starter-security"
  }
  ```

  - 修改Security版本

    ```groovy
    ext['spring-security.version']='5.3.2.RELEASE'
    ```

  - 修改Spring版本

    ```groovy
    ext['spring.version']='5.2.6.RELEASE'
    ```

- Gradle Without Spring Boot

  ```groovy
  plugins {
      id "io.spring.dependency-management" version "1.0.6.RELEASE"
  }
  
  dependencyManagement {
      imports {
          mavenBom 'org.springframework.security:spring-security-bom:5.3.2.RELEASE'
      }
  }
  
  dependencies {
      compile "org.springframework.security:spring-security-web"
      compile "org.springframework.security:spring-security-config"
  }
  ```

# 8. Hello Spring Security

- 运行SpringBoot项目，在控制待会输出随机密码
- 测试启动：默认用户名：user，密码：控制台

# 9. Servlet Security：整体

- 客户端发送请求到应用，Spring容器会创建一个包含Filter 和 Servlet的FilterChain，在SpringMVC中Servlet是DispatcherServlet的实例，一个Servlet可以处理一个HttpServletRequest和一个HttpServletResponse，但是可以包含多个过滤器

- DelegatingFilterProxy：过滤器代理类

  ```java
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) {
      // Lazily get Filter that was registered as a Spring Bean
      // For the example in DelegatingFilterProxy delegate is an instance of Bean Filter0
      Filter delegate = getFilterBean(someBeanName);
      // delegate work to the Spring Bean
      delegate.doFilter(request, response);
  }
  ```

  

  <img src='https://docs.spring.io/spring-security/site/docs/5.3.2.RELEASE/reference/html5/images/servlet/architecture/delegatingfilterproxy.png'/>

  

- FilterChainProxy：被DelegatingFilterProxy包装

  <img src='https://docs.spring.io/spring-security/site/docs/5.3.2.RELEASE/reference/html5/images/servlet/architecture/filterchainproxy.png'/>

- SecurityFilterChain：是属于Security的一系列过滤器链，FilterChainProxy跟前请求通过调用SecurityFilterChain知道要执行哪个Filter

  <img src='https://docs.spring.io/spring-security/site/docs/5.3.2.RELEASE/reference/html5/images/servlet/architecture/securityfilterchain.png'/>

  
  - 运许为不同的服务提供不同的配置

    <img src='https://docs.spring.io/spring-security/site/docs/5.3.2.RELEASE/reference/html5/images/servlet/architecture/multi-securityfilterchain.png'/>

  - Security Filters：Security内置过滤器

    - ChannelProcessingFilter
    - ConcurrentSessionFilter
    - WebAsyncManagerIntegrationFilter
    - SecurityContextPersistenceFilter
    - HeaderWriterFilter
    - CorsFilter
    - CsrfFilter
    - LogoutFilter
    - OAuth2AuthorizationRequestRedirectFilter
    - Saml2WebSsoAuthenticationRequestFilter
    - X509AuthenticationFilter
    - AbstractPreAuthenticatedProcessingFilter
    - CasAuthenticationFilter
    - OAuth2LoginAuthenticationFilter
    - Saml2WebSsoAuthenticationFilter
    - UsernamePasswordAuthenticationFilter
    - ConcurrentSessionFilter
    - OpenIDAuthenticationFilter
    - DefaultLoginPageGeneratingFilter
    - DefaultLogoutPageGeneratingFilter
    - DigestAuthenticationFilter
    - BearerTokenAuthenticationFilter
    - BasicAuthenticationFilter
    - RequestCacheAwareFilter
    - SecurityContextHolderAwareRequestFilter
    - JaasApiIntegrationFilter
    - RememberMeAuthenticationFilter
    - AnonymousAuthenticationFilter
    - OAuth2AuthorizationCodeGrantFilter
    - SessionManagementFilter
    - ExceptionTranslationFilter
    - FilterSecurityInterceptor
    - SwitchUserFilter

- Handling Security Exceptions

  <img src='https://docs.spring.io/spring-security/site/docs/5.3.2.RELEASE/reference/html5/images/servlet/architecture/exceptiontranslationfilter.png'/>

  - 请求首先会调用ExceptionTranslationFilter调用FilterChain.doFilter(request, response)，检查认证信息
  - 判断是否认证
    - 没人认证启动身份认证：SecurityContextHolder被清除，The HttpServletRequest is saved in the RequestCache;AuthenticationEntryPoint 获取请求品凭证
    - 如果是AccessDeniedException 拒绝访问异常，

# 10. Authentication

- 架构组件
  - SecurityContextHolder：保留系统当前的安全上下文细节，其中就包括当前使用系统的用户的信息，主要原理是新的请求为该请求创建一个`ThreadLocal<SecurityContext>`保存线程信息；
  - SecurityContext：从SecurityContextHolder的线程变量中获取，包含当前经过身份验证的用户的Authentication。
  - Authentication：是来自SecurityContext的用户认证信息（不同的认证方式有不同的认证实现），用作AuthenticationManager的输入提供用户提供的凭据来进行身份验证；
  - GrantedAuthority：在身份验证中授予主体的权限
  - AuthenticationManager：接口定义Spring Security过滤器如何执行身份验证的API。
  - ProviderManager：AuthenticationManager最主要的实现类
  - AuthenticationProvider：用于ProviderManager执行特定类型的身份验证。
- 身份认证机制
  - Username and Password：用户名和密码
  - OAuth 2.0 Login：OAuth 2.0登陆协议
  - Central Authentication Server (CAS) ：中央认证服务器(CAS)支持
  - Remember Me：记住我
  - JAAS Authentication：JAAS身份验证
  - OpenID：OpenID身份验证
  - Pre-Authentication Scenarios：使用外部机制(如SiteMinder或Java EE安全性)进行身份验证，但仍然使用Spring安全性进行授权和保护，以防止常见的攻击。
  - X509 Authentication：X509身份验证

# 11. Authorization



# 12. OAuth2

## 1. OAuth2 login

## 2. OAuth3 Client

- Authorization Grant support
  - Authorization Code
  - Refresh Token
  - Client Credentials
  - Resource Owner Password Credentials
  - JWT Bearer
- Client Authentication support
  - JWT Bearer
- HTTP Client support
  - Servlet 环境的 WebClient 集成（用于请求受保护的资源）