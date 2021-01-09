# 第一章 SpringSecurity

## 1.1 SpringSecurity简介

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>应用程序的安全性体现在两个方面：认证与授权；认证是指某个主体在当前系统中是否合法、可用，这个主体可以是登陆用户，也可以是接入的设备或其他应用系统；授权是指认证通过的主体是否允许执行某项操作的过程；

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>Spring Security是Spring采用AOP思想，基于Servlet过滤器实现的安全框架；提供的完善的认证机制和方法级别的权限控制；无需修改Security内部功能，通过自定义的扩展方式实现认证和授权；

## 1.2 SpringSecurity环境搭建

1. SpringSecurity学前知识

   - Maven：搭建多模块项目、搭建SpringBoot和SpringCloud父工程
   - Spring：Spring的核心IOC和AOP
   - SpringBoot：Security的使用环境SpringBoot
   - Filter：过滤器的使用与原理
   - 微服务相关概念：分布式认证原理，单点登录原理

2. SpringBoot项目搭建

   - 单体应用：将SpringBoot依赖作为`<parent>`

     ```xml
     <!-- 使用SpringBoot依赖作为<parent> -->
     <parent>
         <groupId>org.springframework.boot</groupId>
         <artifactId>spring-boot-starter-parent</artifactId>
         <version>2.3.5.RELEASE</version>
         <relativePath/> <!-- lookup parent from repository -->
     </parent>
     <!-- 在当前pom中引入需要的Security依赖 -->
     <dependencies>
         <dependency>
             <groupId>org.springframework.boot</groupId>
             <artifactId>spring-boot-starter-web</artifactId>
         </dependency>
         <dependency>
             <groupId>org.springframework.boot</groupId>
             <artifactId>spring-boot-starter-security</artifactId>
         </dependency>
     </dependencies>
     <build>
         <plugins>
             <plugin>
                 <groupId>org.springframework.boot</groupId>
                 <artifactId>spring-boot-maven-plugin</artifactId>
             </plugin>
         </plugins>
     </build>
     ```

   - 多模块应用：首先定义父pom进行依赖管理，然后单模块将父pom作为`<parent>`，引入父pom中管理的依赖

     ```xml
     <!-- 在父pom中的<dependencyManagement>管理依赖 -->
     <packaging>pom</packaging>
     <dependencyManagement>
         <dependencies>
             <!-- 从官网查询版本依赖约束 -->
             <dependency>
                 <groupId>org.springframework.boot</groupId>
                 <artifactId>spring-boot-dependencies</artifactId>
                 <version>2.3.5.RELEASE</version>
                 <scope>import</scope>
                 <type>pom</type>
             </dependency>
             <dependency>
                 <groupId>org.springframework.cloud</groupId>
                 <artifactId>spring-cloud-dependencies</artifactId>
                 <version>Hoxton.SR8</version>
                 <type>pom</type>
                 <scope>import</scope>
             </dependency>
             <dependency>
                 <groupId>com.alibaba.cloud</groupId>
                 <artifactId>spring-cloud-alibaba-dependencies</artifactId>
                 <version>2.2.3.RELEASE</version>
                 <type>pom</type>
                 <scope>import</scope>
             </dependency>
         </dependencies>
     </dependencyManagement>
     
     <!-- 在子模块中引入<parent>并引入需要的Security依赖 -->
     <dependencies>
         <dependency>
             <groupId>org.springframework.boot</groupId>
             <artifactId>spring-boot-starter-web</artifactId>
         </dependency>
         <dependency>
             <groupId>org.springframework.boot</groupId>
             <artifactId>spring-boot-starter-security</artifactId>
         </dependency>
     </dependencies>
     ```

3. 启动项目，验证Security是否生效：访问`http://localhost:8080/`会自动重定向到`http://localhost:8080/login`链接打开Security的默认登陆页；登陆名称默认：user，登陆密码：控制台打印出的随机密码；

## 1.3 SpringSecurity认证

### 1. SpringSecurity内置过滤器

<img src="https://s1.ax1x.com/2020/07/03/NOE0eK.png"/>

| 过滤器类                                | 作用                                                         |
| --------------------------------------- | ------------------------------------------------------------ |
| SecurityContextPersistenceFilter        | 1、请求开始时从对应的SecurityContextRepository获取securityContext存入SecurityContextHolder中 2、请求结束时清除SecurityContextHolder中的securityContext，将本次请求执行后新的SecurityContext存入到对应的SecurityContextRepository中 3、默认情况下SecurityContextHolder会把SecurityContext存储到ThreadLocal中，而这个thread刚好是存在于servlet容器的线程池中的，如果不清除，当后续请求又从线程池中分到这个线程时，程序就会拿到错误的认证信息。 |
| WebAsyncManagerIntegrationFilter        | 1、Spring Security的SecurityContextHolder是通过ThreadLocal实现的。 2、WebAsyncManagerIntegrationFilter可以使WebAsyncTask能够在异步线程中从SecurityContextHolder中获取上下文信息 |
| HeaderWriterFilter                      | 是在请求前后写入一些往前请求头或者响应头写入一些信息         |
| CsrfFilter                              | SpringSecurity会对所有post请求验证是否包含系统生成的csrf的token信息，如果不包含，则报错。起到防止csrf攻击的效果。 |
| LogoutFilter                            | 匹配URL为/logout的请求，实现用户退出,清除认证信息。          |
| UsernamePasswordAuthenticationFilter    | 默认匹配URL为/login且必须为POST请求。                        |
| DefaultLoginPageGeneratingFilter        | 如果没有在配置文件中指定认证页面，则由该过滤器生成一个默认认证页面。 |
| DefaultLogoutPageGeneratingFilter       | 由此过滤器可以生产一个默认的退出登录页面                     |
| BasicAuthenticationFilter               | 此过滤器会自动解析HTTP请求中头部名字为Authentication，且以Basic开头的头信息。 |
| RequestCacheAwareFilter                 | 通过HttpSessionRequestCache内部维护了一个RequestCache，用于缓存HttpServletRequest |
| SecurityContextHolderAwareRequestFilter | 针对ServletRequest进行了一次包装，使得request具有更加丰富的API |
| AnonymousAuthenticationFilter           | 当SecurityContextHolder中认证信息为空,则会创建一个匿名用户存入到SecurityContextHolder中。 |
| SessionManagementFilter                 | SecurityContextRepository限制同一用户开启多个会话的数量      |
| ExceptionTranslationFilter              | 异常转换过滤器位于整个springSecurityFilterChain的后方，用来转换整个链路中出现的异常 |
| FilterSecurityInterceptor               | 1、最后一个拦截器 2、获取所配置资源访问的授权信息，根据SecurityContextHolder中存储的用户信息来决定其是否有权 |

### 2. 认证流程概述

- 认证流程图如下：登陆密码请求是Security内置的认证方式；短信登陆请求是基于Security的认证流程而开发自定义认证流程

<img src="https://s1.ax1x.com/2020/07/25/UxLY8g.png" alt="UxLY8g.png" border="0" />

- 密码登陆认证流程说明：客户端发送/login请求并且携带用户名和密码，请求被Filter拦截，在Filter中首先根据用户名和密码new一个未认证标识的Authentication，然后将Authentication交给Manager，Manager根据Authentication的类型找到处理这个Authentication的Provider，在Provider中调用UserDetailService返回的UserDetail，如果根据用户名密码new的Authentication和返回的UserDetail进行匹配认证标识，匹配成功则new一个认证成功的Authentication，至此Authentication作为通行令牌表示认证成功；
- 短信登陆流程说明：短信登陆在Security中是没有实现的，所以需要自定义对Security进行扩展；①首先需要定义短信认证的AuthenticationToken类型以及处理该Token的Provider，②其次要定义拦截短信验证请求的Filter，③最后将自定义的Filter配置到Security过滤器链中；配置好之后的短信验证的流程和用户名密码的流程就相同了，只是处理流程中的关键对象的类型有所区别；

### 3. 认证流程核心对象解析

#### 1. Authentication

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>Authentication是一个接口，用来规范获取认证相关信息的方法；使用Security可以自定义多种认证方式，不同的认证认证方式有不同的Authentication的实现；接口中获取认证信息的说明：源码说明

```java
public interface Authentication extends Principal, Serializable {
	/**
	 * 由AuthenticationManager设置：用于获取授权主题的权限集合，确保修改返回的数组集合不会影响认证身份状态
	 * @return 令牌未通过，确保返回空集合，不能为null
	 */
	Collection<? extends GrantedAuthority> getAuthorities();

	/**
	 * 用于作为认证主体的凭证. 通常是一个密码;但是也可以是任何相关AuthenticationManager的调用者期望返回的凭证
	 * @return 证明令牌的凭证
	 */
	Object getCredentials();

	/**
	 * 存储于认证身份相关的其他信息. 可以是IP、证书、编号等等
	 * @return 如果不用可以为null
	  */
	 Object getDetails();
	/**
	 * 获取认证的主体：如对于用户名密码方式的认证，改信息则为用户名.是期望被验证的请求主体
	 * AuthenticationManager会返回Authentication：包含了更丰富的主体信息，在Security中一般
	 * 会用UserDetails作为对象主体
	 *
	 * @return 被认证的主体或认证成功后的主体
	 */
	Object getPrincipal();

	/**
	 * 用于指示 AbstractSecurityInterceptor 是否需要从 AuthenticationManager 获取认证令牌
	 * 通常AuthenticationManager中的AuthenticationProvider会返回一个不可变的身份令牌，返回为true
	 * 此后的认证过程AbstractSecurityInterceptor将不再从AuthenticationManager中再次获取令牌，
	 * 直接返回 true，用于提高认证性能
	 
	 * 出于安全考虑，该方法需要谨慎的返回true：除非他们是不可变的或者是创建以来不可被修改；
	 *
	 * @return 如果令牌认证通过（true）AbstractSecurityInterceptor将不会再向AuthenticationManager发送
	 * token获取令牌
	 */
	boolean isAuthenticated();

	/**
	 * 参照isAuthenticated()方法的描述，改方法的实现需要保证isAuthenticated()为false的情况下课调用该方法，
	 * 如果isAuthenticated()为true调用该方法需要抛出isAuthenticated()异常
	 *
	 * @param 如果认证值得信任参数为true，如果认证被拒绝参数为false
	 *
	 * @throws IllegalArgumentException 如果视图修改认证状态为true被拒绝（因为认证状态需要设置为不可变）
	 */
	void setAuthenticated(boolean isAuthenticated) throws IllegalArgumentException;
}
```

> - AbstractAuthenticationToken已经对Authentication做了部分实现，如果需要自定义认证需要基础AbstractAuthenticationToken，并封装自定义需要的认证信息
> - 由基类AbstractAuthenticationToken派生出的类表示Security的一种认证方式，每种认证方式都有自己对应的AuthenticationProvider实例进行校验；

#### 2. AuthenticationProvider

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>每一种认证都会有一个AbstractAuthenticationToken（派生类），而Token的认证方式需要定义在AuthenticationProvider中，所以每个Token都有自己独特的认证Provider，所有的AuthenticationProvider都会被AuthenticationManager管理，如果Provider认证成功则AuthenticationManager会返回认证成功的Authentication作为Security的通信令牌；

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>如：在用户名密码的认证方式中，AbstractUserDetailsAuthenticationProvider主要作用根据请求中的数据作为参数通过UserDetailsService获取到服务器数据库中的UserDetails对象，然后进行与请求的认证信息进行匹配，如果匹配成功则认证通过；

```java
public interface AuthenticationProvider {

	/**
	 * 向 AuthenticationManager 提供请求认证的对象,AuthenticationManager根据Token类型匹配对应的
	 * AuthenticationProvider,如果认证通过返回一个完整信息并且具有认证令牌的Authentication
	 *
	 * @param 请求认证的主体
	 *
	 * @return 如果认证成功成功返回完整的认证信息,如果返回null,则会有下一个AuthenticationProvider进行认证
	 *
	 * @throws  如果认证失败抛出 AuthenticationException
	 */
	Authentication authenticate(Authentication authentication) throws AuthenticationException;

	/**
	 * 表示该Provider所支持的AuthenticationToken类型
	 * 
	 * @param authentication
	 *
	 * @return 如果返回true表示该Provider支持该Token的认证
	 */
	boolean supports(Class<?> authentication);
}
```

#### 3. AuthenticationManager

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>AuthenticationManager 这个类是接口，他的实现类ProviderManager的作用是收集所有的AuthenticationProvider，用于处理与之对应的AbstractAuthenticationToken；

#### 4. UserDetailsService

- 封装了获取用户的逻辑，由开发者封装用户信息并返回

  ```java
  public interface UserDetailsService {
      UserDetails loadUserByUsername(String var1) throws UsernameNotFoundException;
  }
  ```

#### 5. UserDetails

- Security内部定义获取用户信息的UserDetails接口与他的实现类User
  - UserDetails：是个接口定义了获取用户相关属性的逻辑，Security或根据返回的UserDetails完成校验；
  - User：是Security默认提供的一个用户的实现，自定义开发可以继承User类或者实现UserDetails接口；

#### 6. AuthenticationException

- 是Security认证异常的基类：如果需要自定义Security的认证异常，需要继承自该类；

## 1.4 Security概念-授权

## 1.5 Security概念-OAuth2

# 第二章 Security认证

## 1. 默认用户

- 在SpringBoot项目中添加依赖`spring-boot-starter-security`，会将SecurityAutoConfiguration注入到Spring容器中，并且SecurityAutoConfiguration组件会引入SpringSecurity相关配置类

  ```java
  @Configuration(proxyBeanMethods = false)
  @ConditionalOnClass(DefaultAuthenticationEventPublisher.class)
  @EnableConfigurationProperties(SecurityProperties.class)
  @Import({
      SpringBootWebSecurityConfiguration.class,
      WebSecurityEnablerConfiguration.class,
      SecurityDataConfiguration.class })
  public class SecurityAutoConfiguration {
  	@Bean
  	@ConditionalOnMissingBean(AuthenticationEventPublisher.class)
  	public DefaultAuthenticationEventPublisher authenticationEventPublisher(ApplicationEventPublisher publisher) {
  		return new DefaultAuthenticationEventPublisher(publisher);
  	}
  }
  ```

- 在项目的默认的零配置的状态下，便会开启UserDetailsServiceAutoConfiguration配置类的功能，该配置类会读取SecurityProperties中的配置信息（SecurityProperties中默认的User属性如下），所以默认的登陆用户名是user，密码是随机生成的UUID，项目启动会将密码打印在启动日志中；UserDetailsServiceAutoConfiguration会将从配置文件中读取的用户名和密码并构建为InMemoryUserDetailsManager将用户信息配置在内存中；

  ```java
  public static class User {
      private String name = "user";
      private String password = UUID.randomUUID().toString();
  }
  ```

- Security应用启动后，如果是浏览器访问应用资源会被Security认证拦截并被DefaultLoginPageGeneratingFilter拦截：在过滤器中构造出登陆表单页，并响应给浏览器；

- 在默认登陆页中会发送`/login`请求，根据用户名和密码请求认证；`/login`请求会被Security内置过滤器UsernamePasswordAuthenticationFilter拦截并执行认证流程；

## 2. 配置文件修改默认用户

- 在默认的Security的项目中，用户名固定是user，密码是在控制台输出的随机密码，不方便使用，根据SpringBoot属性配置，可以在配置文件中修改Security的默认配置：修改默认的认证用户名和密码，默认从配置文件中读取的密码会添加前缀{noop}；

  ```yml
  spring:
    security:
      user:
        name: 自定义用户名
        password: 自定义密码
  ```
  
- 修改用户名和密码的默认值后，UserDetailsServiceAutoConfiguration便会使用配置的用户名和密码构建InMemoryUserDetailsManager将用户信息加入应用；

## 3. 配置类修改默认用户

- 如果在配置文件中指定用户名和密码的方式只能指定单用户，Security提供配置类，可以在配置类中指定基于内存的用户信息，在配置类中可以配置多个用户信息以及权限数据

- Security的配置类说明：①需使用@EnableWebSecurity标准Security的自定义配置类②需继承WebSecurityConfigurerAdapter类

- 在WebSecurityConfigurerAdapter类中的configure(AuthenticationManagerBuilder auth)方法参数提供了向内存中新增认证用户的方法，所以可以在配置类中指定认证用户；

  ```java
  @EnableWebSecurity
  @EnableGlobalMethodSecurity(prePostEnabled = true) // 启用方法安全设置
  public class SecurityConfig extends WebSecurityConfigurerAdapter {
      @Override
      protected void configure(AuthenticationManagerBuilder auth) throws Exception {
          auth.inMemoryAuthentication()
                  .withUser(new User("root", "{noop}root", AuthorityUtils.createAuthorityList("ADMIN")));
      }
  }
  ```

  > - @EnableWebSecurity是Spring Security用于启用Web安全的注解。典型的用法是该注解用在某个Web安全配置类上(实现了接口`WebSecurityConfigurer`或者继承自`WebSecurityConfigurerAdapter`；
  >
  > - @EnableGlobalMethodSecurity：想要开启spring方法级权限验证时，只需要在任何 @Configuration实例上使用 @EnableGlobalMethodSecurity 注解就可以；
  >
  > - @EnableGlobalMethodSecurity 这个注解为我们提供了prePostEnabled（prePostEnabled = true 会解锁 @PreAuthorize 和 @PostAuthorize 两个注解）、securedEnabled 和 jsr250Enabled 三种不同的机制来实现同一种功能
  >
  >   | 授权机制       | 授权注解                                                     |
  >   | -------------- | ------------------------------------------------------------ |
  >   | prePostEnabled | @PreAuthorize：在方法执行前进行验证 @PostAuthorize：在方法执行后进行验证 @PreFilter：对集合类型的参数执行过滤，移除结果为false的元素 @PostFilter：基于返回值相关的表达式，对返回值进行过滤 ... ... |
  >   | securedEnabled | @Secured：用来定义业务方法的安全配置                         |
  >   | jsr250Enabled  | @DenyAll： 拒绝所有访问 @PermitAll： 允许所有访问 @RolesAllowed({“USER”, “ADMIN”})：角色限制 |

## 4. 动态获取用户

- 首先对用户名密码认证的源码分析：浏览器中表单发送`/login`请求：UsernamePasswordAuthenticationFilter

  ```java
  public UsernamePasswordAuthenticationFilter() {
      super(new AntPathRequestMatcher("/login", "POST"));
  }
  ```

- UsernamePasswordAuthenticationFilter构建UsernamePasswordAuthenticationToken交给AuthenticationManager处理

  ```java
  public Authentication attemptAuthentication(HttpServletRequest req,HttpServletResponse res) throws AuthenticationException {
  		// ... ...
  		UsernamePasswordAuthenticationToken authRequest 
              = new UsernamePasswordAuthenticationToken( username, password);
  		// ... ...
  		return this.getAuthenticationManager().authenticate(authRequest);
  	}
  ```

- UsernamePasswordAuthenticationToken类型的Token最终被AbstractUserDetailsAuthenticationProvider处理

  ```java
  public boolean supports(Class<?> authentication) {
      return (UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication));
  }
  ```

- AbstractUserDetailsAuthenticationProvider获取到子类的提供的UserDetails

  ```java
  protected abstract UserDetails retrieveUser(String username, UsernamePasswordAuthenticationToken authentication)
      throws AuthenticationException;
  ```

- AbstractUserDetailsAuthenticationProvider子类DaoAuthenticationProvider：当Spring项目启动时会判断容易中是否有UserDetailsService类型的Bean，如果有则会设置到DaoAuthenticationProvider属性中，所以AbstractUserDetailsAuthenticationProvider根据子类提供的UserDetailsService获取到UserDetails，根据UserDetails中的信息执行认证流程；

- 根据源码分析结果，只需要自定义UserDetailsService的实现并注入到Spring容器中，在UserDetailsService中Security提供的用户名查询数据库，根据数据库的信息构建UserDetails对象，Security会根据返回的认证信息与请求的认证信息进行比对，比对通过则认证成功；

  ```java
  public interface UserService extends UserDetailsService {
  }
  
  @Service
  public class UserServiceImpl implements UserService {
      @Override
      public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
          // 根据用户名从数据库查询信息
          return new User(username, "{noop}root", AuthorityUtils.createAuthorityList("ADMIN"));
      }
  }
  ```

## 5. Security5认证加密

1. SpringSecurity5之前需要将密码生成器注入到Spring容器，在Security5之后不需要配置密码的加密方式，而是用户密码加前缀的方式表明加密方式：如`{MD5}xxx`代表使用的是`MD5`加密方式、`{bcrypt}xxx`代表使用的是`bcrypt`加密方式。这样可以在同一系统中支持多种加密方式，迁移用户比较省事。在Security5之前的加密类：StandardPasswordEncoder, MessageDigestPasswordEncoder, StandardPasswordEncoder 不再推荐使用, 全加上了@Deprecated

   ```java
   @Deprecated
   public final class StandardPasswordEncoder implements PasswordEncoder{}
   ```

2. 新增PasswordEncoderFactories 类,里面有一个静态的方法 ,可以明显的看到此方法默认是使用BCryptPasswordEncoder 作为实现

   ```java
   public static PasswordEncoder createDelegatingPasswordEncoder() {
       String encodingId = "bcrypt";
       Map<String, PasswordEncoder> encoders = new HashMap<>();
       encoders.put(encodingId, new BCryptPasswordEncoder());
       encoders.put("ldap", new org.springframework.security.crypto.password.LdapShaPasswordEncoder());
       encoders.put("MD4", new org.springframework.security.crypto.password.Md4PasswordEncoder());
       encoders.put("MD5", new org.springframework.security.crypto.password.MessageDigestPasswordEncoder("MD5"));
       encoders.put("noop", org.springframework.security.crypto.password.NoOpPasswordEncoder.getInstance());
       encoders.put("pbkdf2", new Pbkdf2PasswordEncoder());
       encoders.put("scrypt", new SCryptPasswordEncoder());
       encoders.put("SHA-1", new org.springframework.security.crypto.password.MessageDigestPasswordEncoder("SHA-1"));
       encoders.put("SHA-256", new org.springframework.security.crypto.password.MessageDigestPasswordEncoder("SHA-256"));
       encoders.put("sha256", new org.springframework.security.crypto.password.StandardPasswordEncoder());
       encoders.put("argon2", new Argon2PasswordEncoder());
   
       return new DelegatingPasswordEncoder(encodingId, encoders);
   }
   ```

3. 加盐的变化,以BCryptPasswordEncoder为例,盐值是随机生成的

4. Security5的加密方法：不需要在配置文件中指定新的加密实现

   ```java
   public static void main(String[] args) {
       PasswordEncoder pwd = PasswordEncoderFactories.createDelegatingPasswordEncoder();
       String encode = pwd.encode("123");
   }
   ```

## 6. Security配置文件

- 默认的Security的配置类：DefaultConfigurerAdapter没有对父类做任务操作，WebSecurityConfigurerAdapter#configure(HttpSecurity http)其作用，默认的配置；

  ```java
  protected void configure(HttpSecurity http) throws Exception {
      http
          .authorizeRequests()
          .anyRequest().authenticated()
          .and()
          .formLogin().and()
          .httpBasic();
  }
  ```

  > - authorizeRequests（开启请求认证）anyRequest（任何请求）authenticated（必须认证成功）
  > - formLogin：FormLoginConfigurer被添加到Security配置中
  > - httpBasic：HttpBasicConfigurer被添加到Security的配置中

- 自定义Security的配置文件：①配置类使用@EnableWebSecurity标准②配置类继承WebSecurityConfigurerAdapter并重写configure(HttpSecurity http)方法，在改方法中重新定义Security的认证行为；

## 7. Security认证-Basic

- Security默认有两种认证方式：

  1. Basic：默认请求头是Authentication，值是`Basic `开头的Base64加密的`用户名:密码`；
  2. Form：表单登陆，默认form.action是`/login`，可以通过配置修改；

- Basic认证被BasicAuthenticationFilter过滤器拦截，并且Token类型是UsernamePasswordAuthenticationToken；

- BasicAuthenticationFilter主要源码解析：

  ```java
  public static final String AUTHORIZATION = "Authorization";
  public static final String AUTHENTICATION_SCHEME_BASIC = "Basic";
  public UsernamePasswordAuthenticationToken convert(HttpServletRequest request) {
      // 解析请求头 Authorization 关键字
      String header = request.getHeader(AUTHORIZATION);
      if (header == null) {
          return null;
      }
  
      header = header.trim();
      // 请求头是 Basic 的认证方,式则被该过滤器拦截并处理
      if (!StringUtils.startsWithIgnoreCase(header, AUTHENTICATION_SCHEME_BASIC)) {
          return null;
      }
  	// 请求头的值 == Basic 表示没有请求参数
      if (header.equalsIgnoreCase(AUTHENTICATION_SCHEME_BASIC)) {
          throw new BadCredentialsException("Empty basic authentication token");
      }
  
      byte[] base64Token = header.substring(6).getBytes(StandardCharsets.UTF_8);
      byte[] decoded;
      try {
          decoded = Base64.getDecoder().decode(base64Token);
      } catch (IllegalArgumentException e) {
          throw new BadCredentialsException( "Failed to decode basic authentication token");
      }
  
      String token = new String(decoded, getCredentialsCharset(request));
      // base64解析并判断是否是冒号(:)分隔
      int delim = token.indexOf(":");
      if (delim == -1) {
          throw new BadCredentialsException("Invalid basic authentication token");
      }
      // 构建Token并返回
      UsernamePasswordAuthenticationToken result  
          = new UsernamePasswordAuthenticationToken(token.substring(0, delim), token.substring(delim + 1));
      result.setDetails(this.authenticationDetailsSource.buildDetails(request));
      return result;
  }
  ```
  
- 如果需要修改默认的请求头与认证方式，需要自定义Filter并继承自BasicAuthenticationFilter，并将自定义的Filter添加到Security过滤器中；

## 7. Security认证-Form

- 表单登陆相关配置：①配置自定义页面②配置认证参数③配置认证处理器④配置认证结果⑤配置认证结果处理器

  ```java
  protected void configure(HttpSecurity http) throws Exception {
      http.formLogin()
          //用户未登录时，访问任何资源都转跳到该路径，即登录页面
          .loginPage("")	
          // 登录表单form中action的地址，也就是处理认证请求的路径
          .loginProcessingUrl("")	
          
          // 表单登陆配置用户名参数名称
          .usernameParameter("")	
          // 表单登陆配置密码参数名称
          .passwordParameter("")	
  		
           // 登陆成功处理器
          .successHandler(null)
          // 登录认证成功后默认转跳的路径,指定认证处理器后该配置无效
          .defaultSuccessUrl("")
          .defaultSuccessUrl("", true);
      	// 认证成功跳转地址,指定认证处理器后该配置无效
          .successForwardUrl("")
              
           // 登陆失败处理器
          .failureHandler(null)
          // 认证失败跳转地址,指定认证处理器后该配置无效,重定向后响应的Location中是带有(“?error”)
          .failureForwardUrl("")
          // 登陆失败跳转页面,重定向响应的Loaction中没有(”?error”)
          .failureUrl("")
  
  }
  ```

1. loginPage：默认的登陆页是由DefaultLoginPageGeneratingFilter生成并响应到浏览器，在改配置中可以指定自定义的登陆URI（必须是/开头），security会在当前域名为基础重定向到该URI；该URI可以是一个静态页面，也可以是一个Controller方法，在处理器方法中处理页面跳转；

   ```java
   http.formLogin().loginPage("/hello");
   // @GetMapping接收请求并重定向到百度
   @GetMapping("/hello")
   public String hello() {
       return "redirect:http://www.baidu.com";
   }
   ```

2. loginProcessingUrl：登录页表单默认的登陆请求url是`/login`，改配置用于修改默认的表单请求`/login`

3. usernameParameter：修改表单请求中用户名参数名称；

4. passwordParameter：修改表单请求中密码参数名称；

5. 认证失败：failureUrl、failureForwardUrl、failureHandler，只有最后一个配置会生效；

   - failureUrl：表单使用POST提交登陆请求，登陆失败后，Security根据配置的URL进行重定向；

   - failureForwardUrl：表单使用POST提交登陆请求，登陆失败Security会执行forward操作

     ```java
     request.getRequestDispatcher(forwardUrl).forward(request, response);
     ```

   - failureUrl：表单使用POST提交登陆请求被UsernamePasswordAuthenticationFilter拦截，登陆失败调用默认的onAuthenticationFailure方法，如果自定义了则会执行自定义的认证失败处理方法；

6. 认证成功：defaultSuccessUrl、successForwardUrl、successHandler：只有最后一个配置会生效；

   - defaultSuccessUrl：Security根据配置的URL进行重定向；
   - successForwardUrl：Security会执行forward操作；
   - successHandler：认证成功后执行onAuthenticationSuccess方法；

## 7. 记住我

- Security记住我原理：一个请求，先进入UsernamePasswordAuthenticationFilter，当这个过滤器认证成功之后，会调用一个RemeberMeService服务，在RemeberMeService类里面有一个TokenRepository方法。
  RemeberMeService这个服务会它会生成一个token，然后将这个token存入到浏览器的Cookie中去。同时TokenRepository方法还可以将这个Token写入到数据库中，因为我这个动作是在通过UsernamePasswordAuthenticationFilter认证成功之后去做的，所以在存入DB的时候会将用户名和token存入进去即token和用户名是一一对应的。等第二次这个同一个用户再次访问系统的时候，这个请求在经过过滤器链的时候会经过RememberMeAuthenticationFilter过滤器，这个过滤器的作用就是读取cookie中的token，然后交给RemeberMeService，RemeberMeService会用TokenRepository到数据库中去查询这个token在数据库中有没有记录，如果有记录会将username取出来，取出来之后会调用UserDetailsService去获取用户信息，然后将用户信息存入到SecurityContext中去，以此来实现记住我功能。

  <img src="https://s3.ax1x.com/2021/01/04/sPj2Bd.jpg" alt="sPj2Bd.jpg" border="0" />

- 记住我的配置：

  1. 在Html表单中新增参数：remember-me

     ```xml
     <input name="remember-me" type="checkbox" value="true"/>记住我
     ```

  2. 配置数据库：因为添加"记住我"这个功能需要用到DB，所以我在properties文件中去加入我的数据库的信息

     ```properties
     spring.datasource.driver-class-name=com.mysql.jdbc.Driver
     spring.datasource.url=jdbc:mysql://127.0.0.1:3306/tinner-demo?useUnicode=yes
     spring.datasource.username=root
     spring.datasource.password=root
     ```

  3. 在Security的配置类中开启记住我的配置，并指定数据源

     ```java
     
     @Autowired
     private DataSource dataSource;
     
     @Autowired
     private UserDetailsService userDetailsService;
     
     @Bean
     public PersistentTokenRepository persistentTokenRepository(){
         JdbcTokenRepositoryImpl tokenRepository = new JdbcTokenRepositoryImpl();
         tokenRepository.setDataSource(dataSource);
         // 首次执行自动生成数据表
         tokenRepository.setCreateTableOnStartup(true);
         return tokenRepository;
     }
     protected void configure(HttpSecurity http) throws Exception {
        http
            .rememberMe()
            .tokenRepository(persistentTokenRepository())
            .tokenValiditySeconds("过期时间")
            .userDetailsService(userDetailsService)
     }
     ```

##8. 获取认证信息

1. 方式一：使用SecurityContextHolder的静态方法

   ```java
   @RequestMapping(value = "/username", method = RequestMethod.GET)
   public String currentUserName() {
       return SecurityContextHolder.getContext().getAuthentication().getName();
   }
   ```

2. 方式二：在Controller处理器方法添加Authentication类型参数

   ```java
   @RequestMapping(value = "/username", method = RequestMethod.GET)
   public String currentUserName(Authentication authentication) {
       return authentication.getName();
   }
   ```

3. 方式三：在Controller处理器方法添加Principal类型参数

   ```java
   @RequestMapping(value = "/username", method = RequestMethod.GET)
   public String currentUserName(Principal principal) {
       return principal.getName();
   }
   ```

4. 方式四：注入IAuthenticationFacadeBean并获取认证信息

   ```java
   @Autowired
   private IAuthenticationFacade authenticationFacade;
   
   @RequestMapping(value = "/username", method = RequestMethod.GET)
   public String currentUserNameSimple() {
       Authentication authentication = authenticationFacade.getAuthentication();
       return authentication.getName();
   }
   ```

5. 方式五：通过`HttpServletRequest`获取

   ```java
   @RequestMapping(value = "/username", method = RequestMethod.GET)
   @ResponseBody
   public String currentUserNameSimple(HttpServletRequest request) {
       Principal principal = request.getUserPrincipal();
       return principal.getName();
   }
   ```

## 8. 认证结果处理器

- 认证成功处理器接口：AuthenticationSuccessHandler；
- 认证失败处理器接口：AuthenticationFailureHandler；
- 自定义认证一般都需要实现一个Filter，如果需要全局使用搞一个认证结果处理器，则需要将认证成功处理器和认证失败处理器作为自定义Filter的内部属性，当认证成功后执行处理器方法；配置Filter到Security的过滤器链中的时候需要为Filter中的认证结果处理器属性进行赋值；

## 9. 登出logout

- 登出相关配置：①登出的url②登出成功处理器

  ```java
  protected void configure(HttpSecurity http) throws Exception {
      http.logout()
          .logoutUrl("/panda/logout")
          .logoutSuccessHandler(logoutSuccessHandler)
  }
  ```

## 10. 自定义认证-短信验证码

- SmsFilter：在认证
- SmsAuthenticationFilter
- SmsAuthenticationToken
- SmsAuthenticationProvider

## 11. 自定义认证 - JWT

**Security整合JWT原理**

1. 首先需要浏览器发送登陆请求（带用户名和密码）
2. 根据请求UsernamePasswordAuthenticationToken交给Security的后续流程
3. 认证成功后根据将用户信息作为JWT的载荷信息生成Token，并保存到Redis或直接响应到Http Header中
4. 当浏览器获取到Token后，再次请求服务器资源需要对头部Token进行验证：Security提供的BasicAuthenticationFilter具有身份验证的功能；

总结：Security JWT本质上是对Security原有的认证的扩展和增强：不再是单一的认证方式，而是用户名认证和身份认证的结合同时配置这具有安全保障的JWT令牌完成分布式认证（单点登录）

**Security整合JWT代码关键点整理**

1. 自定义JWT工具类：最安全的方式JWT-RSA方式生成TOKEN和校验TOKEN的方法
2. JwtTokenFilter：继承UsernamePasswordAuthenticationToken，获取认证用户名生成Token保存到HttpHeader中
3. JwtAuthenticationFilter：继承BasicAuthenticationFilter，获取请求头中信息，身份验证

# 第三章 Security授权

## 3.1 权限模型

### 1. ACl模型

访问控制列表，是前几年盛行的一种权限设计，它的核心在于用户直接和权限挂钩。

RBAC的核心是用户只和角色关联，而角色代表对了权限，这样设计的优势在于使得对用户而言，只需角色即可以，而某角色可以拥有各种各样的权限并可继承。

ACL和RBAC相比缺点在于由于用户和权限直接挂钩，导致在授予时的复杂性，虽然可以利用组来简化这个复杂性，但仍然会导致系统不好理解，而且在取出判断用户是否有该权限时比较的困难，一定程度上影响了效率。

### 2. RBAC模型

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>RBAC（Role-Based Access Control ）基于角色的访问控制。RBAC认为权限的过程可以抽象概括为：判断【Who是否可以对What进行How的访问操作（Operator）】这个逻辑表达式的值是否为True的求解过程。

- 即将权限问题转换为Who、What、How的问题。who、what、how构成了访问权限三元组。
- RBAC支持公认的安全原则：最小特权原则、责任分离原则和数据抽象原则。
  - 最小特权原则得到支持，是因为在RBAC模型中可以通过限制分配给角色权限的多少和大小来实现，分配给与某用户对应的角色的权限只要不超过该用户完成其任务的需要就可以了。
  - 责任分离原则的实现，是因为在RBAC模型中可以通过在完成敏感任务过程中分配两个责任上互相约束的两个角色来实现，例如在清查账目时，只需要设置财务管理员和会计两个角色参加就可以了。
  - 数据抽象是借助于抽象许可权这样的概念实现的，如在账目管理活动中，可以使用信用、借方等抽象许可权，而不是使用操作系统提供的读、写、执行等具体的许可权。但RBAC并不强迫实现这些原则，安全管理员可以允许配置RBAC模型使它不支持这些原则。因此，RBAC支持数据抽象的程度与RBAC模型的实现细节有关。

- RBAC模型
  - RBAC0的模型中包括用户（U）、角色（R）和许可权（P）等3类实体集合。
  - RBAC1，基于RBAC0模型，引入角色间的继承关系，即角色上有了上下级的区别，角色间的继承关系可分为一般继承关系和受限继承关系。一般继承关系仅要求角色继承关系是一个绝对偏序关系，允许角色间的多继承。而受限继承关系则进一步要求角色继承关系是一个树结构，实现角色间的单继承。
  - RBAC3，也就是最全面级的权限管理，它是基于RBAC0的基础上，将RBAC1和RBAC2进行整合了，最前面，也最复杂的：

### 3. DAC

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>自主访问控制（DAC: Discretionary Access Control）：系统会识别用户，然后根据被操作对象（Subject）的权限控制列表（ACL: Access Control List）或者权限控制矩阵（ACL: Access Control Matrix）的信息来决定用户的是否能对其进行哪些操作，例如读取或修改。而拥有对象权限的用户，又可以将该对象的权限分配给其他用户，所以称之为“自主（Discretionary）”控制。

- 这种设计最常见的应用就是文件系统的权限设计，如微软的NTFS。
- DAC最大缺陷就是对权限控制比较分散，不便于管理，比如无法简单地将一组文件设置统一的权限开放给指定的一群用户。

### 4. MAC

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>强制访问控制（MAC: Mandatory Access Control）：MAC是为了弥补DAC权限控制过于分散的问题而诞生的。在MAC的设计中，每一个对象都都有一些权限标识，每个用户同样也会有一些权限标识，而用户能否对该对象进行操作取决于双方的权限标识的关系，这个限制判断通常是由系统硬性限制的。比如在影视作品中我们经常能看到特工在查询机密文件时，屏幕提示需要“无法访问，需要一级安全许可”，这个例子中，文件上就有“一级安全许可”的权限标识，而用户并不具有。

- MAC非常适合机密机构或者其他等级观念强烈的行业，但对于类似商业服务系统，则因为不够灵活而不能适用。

### 5. ABAC

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>ABAC被一些人称为是权限系统设计的未来：不同于常见的将用户通过某种方式关联到权限的方式，ABAC则是通过动态计算一个或一组属性来是否满足某种条件来进行授权判断（可以编写简单的逻辑）。属性通常来说分为四类：用户属性（如用户年龄），环境属性（如当前时间），操作属性（如读取）和对象属性（如一篇文章，又称资源属性），所以理论上能够实现非常灵活的权限控制，几乎能满足所有类型的需求。

> 例如规则：“允许所有班主任在上课时间自由进出校门”这条规则，其中，“班主任”是用户的角色属性，“上课时间”是环境属性，“进出”是操作属性，而“校门”就是对象属性了。为了实现便捷的规则设置和规则判断执行，ABAC通常有配置文件（XML、YAML等）或DSL配合规则解析引擎使用。XACML（eXtensible Access Control Markup Language）是ABAC的一个实现，但是该设计过于复杂，我还没有完全理解，故不做介绍。

总结一下，ABAC有如下特点：

1. 集中化管理
2. 可以按需实现不同颗粒度的权限控制
3. 不需要预定义判断逻辑，减轻了权限系统的维护成本，特别是在需求经常变化的系统中
4. 定义权限时，不能直观看出用户和对象间的关系
5. 规则如果稍微复杂一点，或者设计混乱，会给管理者维护和追查带来麻烦
6. 权限判断需要实时执行，规则过多会导致性能问题

既然ABAC这么好，那最流行的为什么还是RBAC呢？

我认为主要还是因为大部分系统对权限控制并没有过多的需求，而且ABAC的管理相对来说太复杂了

## 3.2 Security授权- prePostEnabled

### 1. @EnableGlobalMethodSecurity属性详解

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>@EnableGlobalMethodSecurity(prePostEnabled = true)： 会解锁 @PreAuthorize 和 @PostAuthorize 两个注解。另外还有@PreFilter和@PostFilter两个注解

- @PreAuthorize：注解会在方法执行前进行验证，

- @PostAuthorize：注解会在方法执行后进行验证。

- @PreFilter：对集合类型的参数执行过滤，移除结果为false的元素。基于方法入参相关的表达式，对入参进行过滤。分页慎用！该过程发生在接口接收参数之前。 入参必须为 java.util.Collection 且支持 remove(Object) 的参数。如果有多个集合需要通过 filterTarget=<参数名> 来指定过滤的集合。内置保留名称 filterObject 作为集合元素的操作名来进行评估过滤。

  ```java
  // 指定过滤的参数，过滤偶数
  @PreFilter(filterTarget="ids", value="filterObject%2==0")
  public void delete(List<Integer> ids, List<String> username)
  ```

- @PostFilter：和@PreFilter 不同的是， 基于返回值相关的表达式，对返回值进行过滤。分页慎用！该过程发生接口进行数据返回之前。

### 2. prePostEnabled注解的内置表达式

| **表达式**                     | **描述**                                                     |
| ------------------------------ | ------------------------------------------------------------ |
| hasRole([role])                | 当前用户是否拥有指定角色。                                   |
| hasAnyRole([role1,role2])      | 多个角色是一个以逗号进行分隔的字符串。如果当前用户拥有指定角色中的任意一个则返回true。 |
| hasAuthority([auth])           | 等同于hasRole                                                |
| hasAnyAuthority([auth1,auth2]) | 等同于hasAnyRole                                             |
| Principle                      | 代表当前用户的principle对象                                  |
| authentication                 | 直接从SecurityContext获取的当前Authentication对象            |
| permitAll                      | 总是返回true，表示允许所有的                                 |
| denyAll                        | 总是返回false，表示拒绝所有的                                |
| isAnonymous()                  | 当前用户是否是一个匿名用户                                   |
| isRememberMe()                 | 表示当前用户是否是通过Remember-Me自动登录的                  |
| isAuthenticated()              | 表示当前用户是否已经登录认证成功了。                         |
| isFullyAuthenticated()         | 如果当前用户既不是一个匿名用户，同时又不是通过Remember-Me自动登录的，则返回true。 |

### 3. prePostEnabled注解的内置表达式使用案例

1. @PreAuthorize("hasRole('ADMIN')")：

## 3.3 Security授权-securedEnabled 

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>@EnableGlobalMethodSecurity(securedEnabled = true)：启用@Secured安全控制注解，否则@Secured注解无效。@Secured注解是用来定义业务方法的安全配置。在需要安全[角色/权限等]的方法上指定 @Secured，并且只有那些角色/权限的用户才可以调用该方法

```java
@Secured({"ROLE_user"})
void updateUser(User user);

@Secured({"ROLE_admin", "ROLE_user1"})
void updateUser();
```

- @Secured缺点（限制）就是不支持Spring EL表达式
- 并且指定的角色必须以ROLE_开头，不可省略。该注解功能要简单的多，默认情况下只能基于角色

## 3.4 Security授权-jsr250Enabled

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>@EnableGlobalMethodSecurity(jsr250Enabled = true)：启用 JSR-250 安全控制注解，这属于 JavaEE 的安全规范（现为 jakarta 项目）。一共有五个安全注解。如果设置 jsr250Enabled 为 true ，就开启了 JavaEE 安全注解中的以下三个；如果设置 jsr250Enabled 为 false，以下三个注解失效；

1. **@DenyAll**： 拒绝所有访问
2. **@RolesAllowed({“USER”, “ADMIN”})**： 该方法只要具有"USER", "ADMIN"任意一种权限就可以访问。这里可以省略前缀ROLE_，实际的权限可能是ROLE_ADMIN
3. **@PermitAll**： 允许所有访问

## 3.5 自定义授权表达式

## 3.6 Security授权原理

### 1. 授权流程解析

<img src='https://s1.ax1x.com/2020/07/03/NOzwJx.png'/>

### 2. 授权 - 配置

### 3. 授权 - 注解

### 4. 授权 - 自定义

# 第四章 OAuth2认证与授权

## 4.1 OAuth2协议

### 1. OAuth2说明

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>OAuth2是一个开源协议，是一个开放标准，允许用户授权第三方网站访问他们存储在另外的服务提供者上的信息，而不需要将用户名和密码提供给第三方网站或分享他们数据的所有内容。

> 为了方便理解，联想一个使用场景：拼多多开发的电商服务，消费者想要用自己的微信登陆拼多多，但是不能告诉拼多多自己的微信密码；微信提供了基于OAuth2协议的服务器解决第三方认证的问题：拼多多在微信授权服务器上注册为一个服务商；当用户用微信登陆拼多多时候，拼多多会将用户导向微信的授权页面，用户在微信的授权页面完成登录，得到一个授权码返回给拼多多，拼多多拿着授权码去微信认证服务器获取资源访问的TOKEN，微信根据授权码发给拼多多的一个资源访问TOKEN，拼多多就可以拿着TOKEN去访问微信的信息了；

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>分布式系统：在早期的系统应用是一个单体应用，在应用中集成了所有模块的所有功能；在服务系统演化过程中单体应用中或根据功能模块拆分为多个单体应用，这些被拆分的单体应用被成为分布式系统；

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>分布式系统认证：在分布式系统中每个应用服务都需要对访问者进行认证，面临的问题是在一个应用中认证的认证信息无法同步到其他应用中，导致用户访问其他应用也需要认证，提高系统的使用复杂度；所以分布式认证系统的主要功能是只需要认证一次，认证成功后的认证信息在所有分布式系统之都有效

### 2. OAuth2角色说明

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>在传统的client-server认证模型中，客户端通过提供资源所有者的凭证来请求服务器访问一个受限制的资源（受保护的资源）。为了让第三方应用可以访问这些受限制的资源，资源所有者共享他的凭证给第三方应用。总结OAuth2中的角色：

- **authorization server（授权/认证服务器）**：最核心的服务器，验证客户端和资源所有者，发放Token
- **resource server（资源服务器）**：验证令牌，提供HTTP接口供外部进行资源访问
- **resource owner（资源所有者）**：保存在资源服务器上的资源所有者
- **client（客户端）**：相对认证服务器而言，客户端也称第三方服务器，需要拿着用户的授权去认证服务器上获取Token，并用Token访问资源服务器获取资源；

### 3. oauth2授权模式

- OAuth2基础的流程图

  <img src="https://s3.ax1x.com/2021/01/05/sACHgA.png" alt="sACHgA.png" border="0" />

- 根据第二步用户同意授权的方式，OAuth2的授权模型分为四种

  - 授权码模式（authorization code）：①用户访问第三方应用②后者将用户导向认证服务器③认证成功后认证服务器重定向到第三方应用并携带授权码参数④第三方应用根据根据自身信息和授权码申请令牌⑤认证服务器验证授权码发放令牌⑥第三方应用使用临牌访问资源服务器数据；

    <img src='https://s3.ax1x.com/2021/01/03/s9aYfs.png'/>

  - 简化模式（implicit）：简化模式是对授权码模式的简化，①用户访问第三方应用②后者将用户导向认证服务器③用户同意授权后认证服务器直接将令牌发放给第三方应用；

  - 密码模式（resource owner password credentials）：用户向客户端提供自己的用户名和密码。客户端使用这些信息，向"服务商提供商"索要授权。

  - 客户端模式（client credentials）：指客户端以自己的名义，而不是以用户的名义，向"服务提供商"进行认证。严格地说，客户端模式并不属于OAuth框架所要解决的问题。

## 4.2 SecurityOAuth2基础

### 1. Maven依赖

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-oauth2</artifactId>
</dependency>
```

> SpringCloud提供了oauth2分布式认证解决方案，SecurityCloudOAuth2用于解决分布式认证

### 2. SecurityOAuth2 API

> 总结
>
> 1. redirect_uri：参数只能implicit模式和authorization_code模式使用
> 2. 客户端必须要注册一个redirect_uri参数

#### /oauth/authorize

- 授权码模式：

  |   请求方式   | GET                                                          |
  | :----------: | ------------------------------------------------------------ |
  | **请求URL**  | `http://localhost:8083/oauth/authorize?client_id=c1&response_type=code&scope=all&redirect_uri=http://localhost:8082/auth/code` |
  | **请求参数** | response_type=code：表示是授权码模式 <br />client_id：客户端ID <br />scope： <br />redirect_uri： |
  
- 简化模式

  | 请求范式 | GET                                                          |
  | -------- | ------------------------------------------------------------ |
  | 请求URL  | `http://localhost:8083/oauth/authorize?response_type=token&client_id=c1&scope=all&redirect_uri=http://localhost:8082/auth/code` |
  | 请求参数 | response_type=token：<br />client_id：客户端ID <br />scope： <br />redirect_uri： |

#### /oauth/token

- 授权码模式：

  |   请求方式   | POST                                                         |
  | :----------: | ------------------------------------------------------------ |
  | **请求URL**  | /oauth/token                                                 |
  | **请求参数** | grant_type=authorization_code：<br />client_id：<br />client_secret：<br />redirect_uri：<br />code： |

- 简化模式

  |   请求方式   | POST         |
  | :----------: | ------------ |
  | **请求URL**  | /oauth/token |
  | **请求参数** |              |

- 密码模式

  |   请求方式   | POST                                                         |
  | :----------: | ------------------------------------------------------------ |
  | **请求URL**  | /oauth/token                                                 |
  | **请求参数** | grant_type=password：<br />client_id：<br />client_secret：<br />username：<br />password： |

- 客户端模式

  |   请求方式   | POST                                                         |
  | :----------: | ------------------------------------------------------------ |
  | **请求URL**  | /oauth/token                                                 |
  | **请求参数** | grant_type=client_credentials：<br />client_id：<br />client_secret |

- 刷新token

  |   请求方式   | POST                                                         |
  | :----------: | ------------------------------------------------------------ |
  | **请求URL**  | /oauth/token                                                 |
  | **请求参数** | grant_type=refresh_token：<br />client_id：<br />client_secret：<br />refresh_token： |

#### /oauth/check_token

- 检查token

  |   请求方式   | POST                                                     |
  | :----------: | -------------------------------------------------------- |
  | **请求URL**  | /oauth/authorize                                         |
  | **请求参数** | client_id： scope： code： grant_type=authorization_code |

#### /oauth/token_key

#### /oauth/confirm_access

#### /oauth/error

### 3. SecurityOAuth2数据表

- 数据表概述

  | 表名称               | 说明                     |
  | -------------------- | ------------------------ |
  | oauth_client_details | 客户端信息表             |
  | oauth_client_token   | 客户端token记录表        |
  | oauth_access_token   | 客户端access_token记录表 |
  | oauth_refresh_token  | 刷新refresh_token记录表  |
  | oauth_code           | 授权码                   |
  | ClientDetails        |                          |

- 官网GitHub维护SQL脚本：[GitHub](https://github.com/spring-projects/spring-security-oauth/blob/master/spring-security-oauth2/src/test/resources/schema.sql)

  ```sql
  create table oauth_client_details
  (
      client_id               VARCHAR(256) PRIMARY KEY comment '客户端的唯一标识',
      resource_ids            VARCHAR(256) comment '客户端可访问资源ids',
      client_secret           VARCHAR(256) comment '客户端密匙',
      scope                   VARCHAR(256) comment '客户端申请的权限范围',
      authorized_grant_types  VARCHAR(256) comment 'authorization_code,password,implicit,client_credentials,refresh_token',
      web_server_redirect_uri VARCHAR(256) comment '客户端的重定向URI',
      authorities             VARCHAR(256) comment '客户端所拥有的Spring Security的权限值',
      access_token_validity   INTEGER comment 'access_token的有效时间值(单位:秒)',
      refresh_token_validity  INTEGER comment 'refresh_token的有效时间值(单位:秒)',
      additional_information  VARCHAR(4096) comment '预留,必须是json',
      autoapprove             VARCHAR(256) comment '是否自动Approval操作'
  );
  
  create table oauth_client_token
  (
      authentication_id VARCHAR(256) PRIMARY KEY comment 'DefaultClientKeyGenerator生成的唯一值',
      token_id          VARCHAR(256) comment 'access_token`的值',
      token             blob comment 'OAuth2AccessToken对象序列化的二进制',
      user_name         VARCHAR(256) comment '登录时的用户名',
      client_id         VARCHAR(256) comment '客户端ID'
  );
  
  create table oauth_access_token
  (
      token_id          VARCHAR(256),
      token LONGVARBINARY,
      authentication_id VARCHAR(256) PRIMARY KEY,
      user_name         VARCHAR(256),
      client_id         VARCHAR(256),
      authentication LONGVARBINARY,
      refresh_token     VARCHAR(256)
  );
  
  create table oauth_refresh_token
  (
      token_id VARCHAR(256),
      token LONGVARBINARY,
      authentication LONGVARBINARY
  );
  
  create table oauth_code
  (
      code VARCHAR(256),
      authentication LONGVARBINARY
  );
  
  create table oauth_approvals
  (
      userId         VARCHAR(256),
      clientId       VARCHAR(256),
      scope          VARCHAR(256),
      status         VARCHAR(10),
      expiresAt      TIMESTAMP,
      lastModifiedAt TIMESTAMP
  );
  
  
  -- customized oauth_client_details table
  create table ClientDetails
  (
      appId                  VARCHAR(256) PRIMARY KEY,
      resourceIds            VARCHAR(256),
      appSecret              VARCHAR(256),
      scope                  VARCHAR(256),
      grantTypes             VARCHAR(256),
      redirectUrl            VARCHAR(256),
      authorities            VARCHAR(256),
      access_token_validity  INTEGER,
      refresh_token_validity INTEGER,
      additionalInformation  VARCHAR(4096),
      autoApproveScopes      VARCHAR(256)
  );
  ```

### 4. SecurityOAuth2运行原理

- SecurityOAuth2执行流程：

  <img src="https://s3.ax1x.com/2021/01/05/sAAteI.png" alt="sAAteI.png" border="0" />

- SecurityOauth2改造方案：用户名密码（验证码）、手机短信、JWT：

  <img src="https://s3.ax1x.com/2021/01/05/sAEgjH.png" alt="sAEgjH.png" border="0" />

## 4.3 SecurityOAuth2认证服务器

### 1. 默认配置

- 首先认证服务器需要支持最基础的认证功能：①添加Security启动器②定义Security配置文件③为security制定一个认证用户

  ```java
  // ②定义Security配置文件
  @EnableWebSecurity
  @EnableGlobalMethodSecurity(proxyTargetClass = true, prePostEnabled = true)
  public class WebSecurityConfigurer extends WebSecurityConfigurerAdapter {
  
  }
  
  // ③为security制定一个认证用户
  @Service
  public class UserService implements UserDetailsService {
      public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
          return new User(username,
                  "{noop}root",
                  true,
                  true,
                  true,
                  true,
                  AuthorityUtils.createAuthorityList("ROOT"));
      }
  }
  ```

- 添加SecurityOAuth2依赖并声明认证服务器配置：注解@EnableAuthorizationServer会向Spring容器注入认证相关配置类，具有了认证服务器的最基础的功能；

  ```java
  @Configuration
  @EnableAuthorizationServer
  public class Oauth2Configurer {
  }
  
  // @EnableAuthorizationServer 源码
  @Target(ElementType.TYPE)
  @Retention(RetentionPolicy.RUNTIME)
  @Documented
  @Import({AuthorizationServerEndpointsConfiguration.class, AuthorizationServerSecurityConfiguration.class})
  public @interface EnableAuthorizationServer {
  
  }
  ```

- 查看源码默认会随机生成一个客户端，但是不会配置为客户端配置redirect_uri

  ```yaml
  # 基于配置版的客户端的redirect_uri
  security:
    oauth2:
      client:
        registered-redirect-uri: http://localhost:8082/auth/code
  ```

- 发送获取授权码请求/oauth/authorize：获取授权码，同意授权的用户是认证认证服务器获取的用户信息

- 发送获取令牌请求/oauth/token?grant_type=authorization_code：根据授权码获取令牌

- 检查token：/oauth/check_token?token=

- 要使用refresh_token的话，需要额外配置userDetailsService：/oauth/token?grant_type=refresh_token

### 2. 默认配置修改

- 方式一默认的客户端数据是随机生成：如果只有一个客户端，可以将客户端基本信息在配置文件中指定

  ```yaml
  security:
    oauth2:
      client:
        client-id: c1
        client-secret: s1
        scope: all,read,write
        grant-type: authorization_code,password,implicit,client_credentials,refresh_token
        registered-redirect-uri: http://localhost:8082/auth/code
  ```

- 发送获取令牌请求：根据授权码获取令牌同上

### 3. 配置-基于内存

- 方式二基于配置的客户端只能配置一个，可以在认证服务器配置类中指定多个基于内存的客户端

- 首先认证服务器的authorization_code类型的认证需要依赖AuthenticationManager，所以在Security的配置文件中将AuthenticationManager注入到Spring容器中

  ```java
  @EnableWebSecurity
  @EnableGlobalMethodSecurity(proxyTargetClass = true, prePostEnabled = true)
  public class WebSecurityConfigurer extends WebSecurityConfigurerAdapter {
      @Bean
      public AuthenticationManager authenticationManager() throws Exception{
          return super.authenticationManager();
      }
  }
  ```

- SecurityOAuth2配置类配置详解：一

  

### 4. 配置-基于数据库

### 5. 配置-jwt

### 6. 配置-自定义

## 4.4 SecurityOAuth2资源服务器
