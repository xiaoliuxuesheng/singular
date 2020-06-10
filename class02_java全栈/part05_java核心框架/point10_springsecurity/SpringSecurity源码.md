1. SpringSecurity启动

   - 添加依赖

     ```xml
     <dependency>
         <groupId>org.springframework.boot</groupId>
         <artifactId>spring-boot-starter-security</artifactId>
     </dependency>
     ```

   - 解析SpringBoot启动自动配置：spring.factories中的SecurityAutoConfiguration

     ```java
     @Configuration(proxyBeanMethods = false)
     @ConditionalOnClass(DefaultAuthenticationEventPublisher.class)
     @EnableConfigurationProperties(SecurityProperties.class)
     @Import({ SpringBootWebSecurityConfiguration.class, WebSecurityEnablerConfiguration.class,
     		SecurityDataConfiguration.class })
     public class SecurityAutoConfiguration {
     
     	@Bean
     	@ConditionalOnMissingBean(AuthenticationEventPublisher.class)
     	public DefaultAuthenticationEventPublisher authenticationEventPublisher(ApplicationEventPublisher publisher) {
     		return new DefaultAuthenticationEventPublisher(publisher);
     	}
     
     }
     ```

     > 1. ConditionalOnClass：表示项目启动时可以加载指定类则将当前配置类注入Sring容器，在添加Security依赖后，这个类自然就会存在，这个配置类则会生效
     >
     > 2. SecurityAutoConfiguration这个类生效后通过@Import会引入三个组件
     >
     >    - SpringBootWebSecurityConfiguration：查看源码说明当存在这个WebSecurityConfigurerAdapter类并且Spring容器中没有WebSecurityConfigurerAdapter这个组件则增诶生效
     >
     >      ```java
     >      @Configuration(proxyBeanMethods = false)
     >      @ConditionalOnClass(WebSecurityConfigurerAdapter.class)
     >      @ConditionalOnMissingBean(WebSecurityConfigurerAdapter.class)
     >      @ConditionalOnWebApplication(type = Type.SERVLET)
     >      public class SpringBootWebSecurityConfiguration {
     >      
     >      	@Configuration(proxyBeanMethods = false)
     >      	@Order(SecurityProperties.BASIC_AUTH_ORDER)
     >      	static class DefaultConfigurerAdapter extends WebSecurityConfigurerAdapter {
     >      
     >      	}
     >      
     >      }
     >      ```
     >
     >    - WebSecurityEnablerConfiguration：查看源码表示WebSecurityConfigurerAdapter这个类存在并且Spring容器中不存在这个组件springSecurityFilterChain，并且当前应用是WEB应用这个类生效
     >
     >      ```java
     >      @Configuration(proxyBeanMethods = false)
     >      @ConditionalOnBean(WebSecurityConfigurerAdapter.class)
     >      @ConditionalOnMissingBean(name = BeanIds.SPRING_SECURITY_FILTER_CHAIN)
     >      @ConditionalOnWebApplication(type = ConditionalOnWebApplication.Type.SERVLET)
     >      @EnableWebSecurity
     >      public class WebSecurityEnablerConfiguration {
     >      
     >      }
     >      ```
     >
     >    - @EnableWebSecurity：
     >
     >      ```java
     >      @Import({ WebSecurityConfiguration.class,
     >      		SpringWebMvcImportSelector.class,
     >      		OAuth2ImportSelector.class })
     >      @EnableGlobalAuthentication
     >      @Configuration
     >      public @interface EnableWebSecurity {
     >      
     >      	/**
     >      	 * Controls debugging support for Spring Security. Default is false.
     >      	 * @return if true, enables debug support with Spring Security
     >      	 */
     >      	boolean debug() default false;
     >      }
     >      ```
     >
     >      

     



10、Authentication

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

10.1、SecurityContextHolder

 		SecurityContextHolder是SpringSecurity认证最核心的类，包含SecurityContext

<img src='https://docs.spring.io/spring-security/site/docs/5.3.3.BUILD-SNAPSHOT/reference/html5/images/servlet/authentication/architecture/securitycontextholder.png'/>

​		securitycontexts是Spring Security存储身份验证的详细信息的地方。Spring Security并不关心securitycontext是如何填充的。如果它包含一个值，那么它将被用作当前经过身份验证的用户。

​		表示用户已通过身份验证的最简单方法是直接设置SecurityContextHolder，如下设置一个

```java
// 首先创建一个空的 SecurityContext
SecurityContext context = SecurityContextHolder.createEmptyContext(); 
// 创建一个新的身份验证对象,并将身份信息设置到SecurityContext中
Authentication authentication =
    new TestingAuthenticationToken("username", "password", "ROLE_USER"); 
context.setAuthentication(authentication);
// 将SecurityContext设置到SecurityContextHolder
SecurityContextHolder.setContext(context);
```

​		也可以根据SecurityContextHolder获得关于已验证主体的信息

```java
SecurityContext context = SecurityContextHolder.getContext();
Authentication authentication = context.getAuthentication();
String username = authentication.getName();
Object principal = authentication.getPrincipal();
Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
```

