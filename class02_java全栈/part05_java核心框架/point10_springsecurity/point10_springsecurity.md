# 第一章 Security介绍

## 1.1 SpringSecurity环境

1. 新建SpringBoot Maven项目

   ```xml
   <parent>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-starter-parent</artifactId>
       <version>2.1.1.RELEASE</version>
       <relativePath/>
   </parent>
   ```

2. 添加Web和Security相关依赖

   ```xml
   <dependency>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-starter-web</artifactId>
   </dependency>
   <dependency>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-starter-security</artifactId>
   </dependency>
   
   <!-- 开发工具包 -->
   <dependency>
       <groupId>cn.hutool</groupId>
       <artifactId>hutool-all</artifactId>
       <version>5.3.4</version>
   </dependency>
   <dependency>
       <groupId>org.projectlombok</groupId>
       <artifactId>lombok</artifactId>
   </dependency>
   <dependency>
       <groupId>junit</groupId>
       <artifactId>junit</artifactId>
   </dependency>
   ```

## 1.2 Security核心对象

1. <font size=4 color=red>**Authentication**</font>：通过AuthenticationManager.authenticate(Authentication)方法认证后的Authentication实例对象是Security通行的令牌；

   - Authentication的基类AbstractAuthenticationToken，自定义的认证需要继承这个基类，封装自定义的参数；
   - 由基类AbstractAuthenticationToken派生出的类表示Security的一种认证方式，每种认证方式都有自己对应的AuthenticationProvider实例进行校验；

2. <font size=4 color=red>**AuthenticationProvider**</font>：用于处理特定的AbstractAuthenticationToken的派生类，每一种认证方式都会有一个AbstractAuthenticationToken以及对应的AuthenticationProvider，这个类主要作用根据请求中的数据作为参数通过UserDetailsService获取到服务器数据库中的UserDetails对象，然后进行与请求的认证信息进行匹配，如果匹配成功则认证通过；

3. <font size=4 color=red>**AuthenticationManager**</font>：这个类是接口，实现类ProviderManager的作用是收集所有的AuthenticationProvider，用于处理与之对应的AbstractAuthenticationToken；

4. <font size=4 color=red>**UserDetailsService**</font>：封装了获取用户的逻辑，由开发者封装用户信息并返回

   ```java
   public interface UserDetailsService {
       UserDetails loadUserByUsername(String var1) throws UsernameNotFoundException;
   }
   ```

5. <font size=4 color=red>**UserDetails**</font>：接口与Security自定义的用户信息的实现类User

   - UserDetails：是个接口定义了获取用户相关属性的逻辑，Security或根据返回的UserDetails完成校验；
   - User：是Security默认提供的一个用户的实现，自定义开发可以继承User类或者实现UserDetails接口；

## 1.3 Security配置相关类说明

1. WebSecurityConfigurerAdapter
2. @EnableWebSecurity
3. @EnableGlobalMethodSecurity

# 第二章 Security认证

## 2.1 默认的认证方式

<img src="http://m.qpic.cn/psc?/V52xXkY417Nw310rbooN1OUGO41S4u1u/TmEUgtj9EK6.7V8ajmQrEM0YO7lpT8u8trYpUco7qo7tkCHeV.rBwSSpUzAlC78wFeeqORREfcYB.AeO0pl7yUa0XBvoqAmaV637rkYPzW4!/b&bo=*APoAfwD6AEDKQw!&rf=viewer_4&t=5" alt="NQVVfg.png" border="0" />

## 2.2 修改默认配置 

```yml
spring:
  security:
    user:
      name: root
      password: root
```

## 2.3 使用配置类添加用户

1. **添加用户基本信息**

   ```java
   @Configuration
   public class SecurityConfiguration extends WebSecurityConfigurerAdapter {
       @Override
       protected void configure(AuthenticationManagerBuilder auth) throws Exception {
           auth.inMemoryAuthentication()
                   .withUser("root")
                   .password("root")
                   .roles("admin");
       }
   }
   ```

2. **配置说明**

   - inMemoryAuthentication：表示是基于内存的认证信息

   - UserDetailsBuilder withUser()：表示在内存中构建认证信息，查看源码

     ```java
     public final UserDetailsBuilder withUser(String username) {
         UserDetailsBuilder userBuilder = new UserDetailsBuilder((C) this);
         userBuilder.username(username);
         this.userBuilders.add(userBuilder);
         return userBuilder;
     }
     ```

   - UserDetailsBuilder的API说明

     | 方法名称                                                  | 简介               |
     | --------------------------------------------------------- | ------------------ |
     | and()                                                     | 用于连接配置       |
     | username(String username)                                 | 用于设置用户名称   |
     | password(String password)                                 | 设置密码           |
     | roles(String… roles)                                      | 设置一项或多项角色 |
     | authorities(GrantedAuthority… authorities)                | 授予一项或多项权限 |
     | authorities(List<? extends GrantedAuthority> authorities) | 授予一项或多项权限 |
     | authorities(String… authorities)                          | 授予一项或多项权限 |
     | accountExpired(boolean accountExpired)                    | 定义账号是否过期   |
     | accountLocked(boolean accountLocked)                      | 定义账号是否锁定   |
     | credentialsExpired(boolean credentialsExpired)            | 定义凭证是否过期   |
     | disabled(boolean disabled)                                | 定义账号是否被禁用 |

## 2.4 Security自定义登陆页

1. **自定义SpringBoot项目resources中静态资源**

   - resources/resources：SpringBoot项目启动默认会读取这个目录中的index.html页面作为首页，引入静态资源的路径是以static为根，需要将静态资源分包存储在static目录中，加载静态资源方式例如：

     ```html
     <link href="/css/element-ui.css"  rel="stylesheet">
     <script src="/js/vue-2.6.11.js"></script>
     <script src="/js/element-ui.js"></script>
     ```

   - resources/template：

   - resources/static：用于保存css、js、fonts、images等resources页面中需要引入的静态资源，需要在static中自定义目录管理静态资源，基本目录结构案例如下：

     ```yml
   resources:
     	static: 
     		css: 自定义目录-存放样式脚本
     		js: 自定义目录-存放js脚本
     		fonts: 自定义目录-存放字体
     		images: 自定义目录-存放图片
     ```

2. **Security默认登陆页面源码**

   ```html
   <html lang="en">
   <head>
       <meta charset="utf-8">
       <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
       <meta name="description" content="">
       <meta name="author" content="">
       <title>Please sign in</title>
       <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/css/bootstrap.min.css" 
             rel="stylesheet"
             integrity="sha384-/Y6pD6FV/Vv2HJnA6t+vslU6fwYXjCFtcEpHbNJ0lyAFsXTsjBbfaDjzALeQsN6M" 
             crossorigin="anonymous">
       <link href="https://getbootstrap.com/docs/4.0/examples/signin/signin.css" 
             rel="stylesheet" 
             crossorigin="anonymous">
       <script>window["_GOOG_TRANS_EXT_VER"] = "1";</script>
   </head>
   <body>
   <div class="container">
       <form class="form-signin" method="post" action="/login">
           <h2 class="form-signin-heading">Please sign in</h2>
           <p>
               <label for="username" class="sr-only">Username</label>
               <input type="text" 
                      id="username" 
                      name="username" 
                      class="form-control" 
                      placeholder="Username" 
                      required=""
                      autofocus="">
           </p>
           <p>
               <label for="password" class="sr-only">Password</label>
               <input type="password" 
                      id="password" 
                      name="password" 
                      class="form-control" 
                      placeholder="Password"
                      required="">
           </p>
           <input name="_csrf" type="hidden" value="848a7a76-cd96-468f-b33a-74a53d8a131d">
           <button class="btn btn-lg btn-primary btn-block" type="submit">Sign in</button>
       </form>
   </div>
   </body>
   </html>
   ```

3. **添加Security http配置**

   ```java
   @Configuration
   public class SecurityConfiguration extends WebSecurityConfigurerAdapter {
       @Override
       protected void configure(HttpSecurity http) throws Exception {
           http.formLogin()
                   .loginPage("")                  // ①
                   .loginProcessingUrl("")         // ②
                   .usernameParameter("")          // ③
                   .passwordParameter("")          // ④
                   .successForwardUrl("")          // ⑤
                   .failureForwardUrl("")          // ⑥
                   .successHandler(null)           // ⑦
                   .failureHandler(null)           // ⑧
                   .and()
                   .authorizeRequests()            // ⑨
                   .antMatchers("/css/**").permitAll()    	// ⑩
                   .antMatchers("").permitAll()    		// ⑪
                   .anyRequest().authenticated()     		// ⑫
                   .and()
                   .csrf().disable();                 		// ⑬
       }
   }
   ```

   ① - 用于指定登陆页的链接，作用是在请求被Security的认证功能拦截后默认会跳转带该配置的链接地址上；并且在这里指定登陆链接后需要在⑪的授权请求时候需要permitAll，否则被Security拦截跳转到的认证链接还会被Security拦截，进入无限重定向异常中；
   
   ② - 登陆表单或登录参数时候发送的URL，默认的登陆url是`/login`，自定义表单登陆可以修改登陆请求，也需要请求授权时permitAll，不然发送登陆请求会被Security拦截；
   
   ③ - 修改表单登陆的用户名参数，默认是username；
   
   ④ - 修改表单登陆的密码参数，默认是password；
   
   ⑤ - 如果不是其他请求引发认证而导致的登陆，登陆成功后跳转的链接；
   
   ⑥ - 登陆失败后跳转的链接；
   
   ⑦ - [登陆成功处理器](##2.8 Security认证成功处理器)，可以记录登录相关信息；
   
   ⑧ - [登陆失败处理器](##2.9 Security认证失败处理器)，可以记录登录失败等相关日志或其他信息；
   
   ⑨ - authorizeRequests表示是请求授权相关配置
   
   ⑩ - antMatchers表示路径匹配器，如果路径匹配的上则执行之后权限表达式的处理方式
   
   ⑫ - anyRequest()表示所有请求，这个配置要放在最后，应为这个配置之后再做路径匹配就无效了，authenticated表示需要认证
   
   ⑬ - csrf().disable()表示关闭csrf；
   
4. **authorizeRequests权限表达式**

   | 权限API                         | 描述                                                      |
   | ------------------------------- | --------------------------------------------------------- |
   | permitAll()                     | 永远返回true                                              |
   | denyAll()                       | 永远返回false                                             |
   | anonymous()                     | 匿名用户时候返回true                                      |
   | rememberMe()                    | 记住我(从token表)认证成功返回true                         |
   | authentication()                | 当前登录用户的`authentication`对象                        |
   | fullAuthenticated()             | 当前用户既不是`anonymous`也不是`rememberMe`用户时返回true |
   | hasRole(role)                   | 用户拥有指定的角色时返回true                              |
   | hasAnyRole(... role)            | 用户拥有任意一个制定的角色时返回true                      |
   | hasAuthority(authority)         | 用于设置权限字符串,等同于`hasRole`,但不会带有`ROLE_`前缀  |
   | hasAnyAuthority(... authority)  | 等同于`hasAnyRole`                                        |
   | hasIpAddress('192.168.1.0/24')) | 请求发送的IP匹配时返回true                                |
   | access(string)                  | 改字符会被解析为权限表达式，当做合法代码调用              |

## 2.5 实现数据库动态登陆

- **自定义Service实现Security内置的UserDetailsService**

  ```java
  @Service // ②
  public class UserDetailsServiceImpl implements UserDetailsService { // ①
  
      @Override
      public UserDetails loadUserByUsername(String username) { // ③
          return UserDetails; // ④
      }
  }
  ```

  ① - UserDetailsService接口的loadUserByUsername()方法，根据用户名加载用户，当系统识别UserDetailsService这个类在组件后，在登陆时候会将用户登陆的username作为参数调用loadUserByUsername()方法获取用户，而不是采用随机用户；

  ② - 需要将自定义的实现类注入到Spring容器，容器才能识别UserDetailsService组件，在这个Service中可以注入链接MySQL的dao，可以根据username去数据库查询用户信息；

  ③ - 参数username：是表单登陆用户输入的用户名参数；

  ④ - UserDetails是个接口，封装了获取用户信息相关接口，Security内置是User实现了这个接口，也可以使用自定义的类实现该接口

## 2.6 Security的加密

1. **Security登陆说明**：当前用户的 登陆信息会被封装在当前线程变量中，从数据库查询到用户信息后返回，Security会根据UserDetailsService返回的用户信息和当前线程中的登陆信息做对比，如果匹配则登陆成功；

2. **Security加密相关组件**：

   - **PasswordEncoder接口**用于编码密码的服务接口，首选的实现是BCryptPasswordEncoder；PassswordEncoder接口有两个方法,一个是`String encode(CharSequence rawPassword)`；用于将字符序列(即原密码)进行编码,另一个方法是`boolean matches(CharSequence rawPassword, String encodedPassword)`；用于比较字符序列和编码后的密码是否匹配；在Security版本5之前的做法是将PasswordEncoder组件注入到Spring容器中，当用户登陆时候会自动条用容器改组件的matches()方法进行密码匹配，当需要加密时候只需要注入PasswordEncoder组件调用encode()方法对字符串进行加密；

   - **DelegatingPasswordEncoder**：并不是传统意义上的编码器,它并不使用某一特定算法进行编码,顾名思义,它是一个**委派密码编码器**,它将具体编码的实现根据要求委派给不同的算法,以此来实现不同编码算法之间的兼容和变化协调；

   - **PasswordEncoderFactories**：这个可以简单地理解为,遇到新密码,DelegatingPasswordEncoder会委托给BCryptPasswordEncoder(encodingId为bcryp*)进行加密,同时,对历史上使用ldap,MD4,MD5等等加密算法的密码认证保持兼容(如果数据库里的密码使用的是MD5算法,那使用matches方法认证仍可以通过,但新密码会使bcrypt进行储存)

     ```java
     public class PasswordEncoderFactories {
     
     	@SuppressWarnings("deprecation")
     	public static PasswordEncoder createDelegatingPasswordEncoder() {
     		String encodingId = "bcrypt";
     		Map<String, PasswordEncoder> encoders = new HashMap<>();
     		encoders.put(encodingId, new BCryptPasswordEncoder());
     		encoders.put("ldap", new LdapShaPasswordEncoder());
     		encoders.put("MD4", new Md4PasswordEncoder());
     		encoders.put("MD5", new MessageDigestPasswordEncoder("MD5"));
     		encoders.put("noop", NoOpPasswordEncoder.getInstance());
     		encoders.put("pbkdf2", new Pbkdf2PasswordEncoder());
     		encoders.put("scrypt", new SCryptPasswordEncoder());
     		encoders.put("SHA-1", new MessageDigestPasswordEncoder("SHA-1"));
     		encoders.put("SHA-256", new MessageDigestPasswordEncoder("SHA-256"));
     		encoders.put("sha256", new StandardPasswordEncoder());
     		return new DelegatingPasswordEncoder(encodingId, encoders);
     	}
     	private PasswordEncoderFactories() {}
     }
     ```

3. **Security加密DelegatingPasswordEncoder**

   ```java
   String encode = PasswordEncoderFactories.createDelegatingPasswordEncoder()
                   .encode(coWechatUser.getPassword());
   ```

## 2.7 Security记住我

1. Security记住我基本原理

   <img src="https://m.qpic.cn/psc?/V52xXkY417Nw310rbooN1OUGO41S4u1u/bqQfVz5yrrGYSXMvKr.cqVV2CrymWPohSVDazcDzw6I2FpZqs5Rprv3I1YrW85WFddYU2ZwRN*Zns2lVWOBPIbHG5a3kA771wEfovkMVRZQ!/b&bo=1AWAAmkGwAIBCdA!&rf=viewer_4&t=5" alt="NloT4U.jpg" border="0" />

2. **Security记住我相关配置**：RememberMe功能需要将产生的Token存入数据库，Security内置实现是生成数据库与Token查询相关操作，需要配置数据源

   ```java
   @Configuration
   public class SecurityConfiguration extends WebSecurityConfigurerAdapter {
       @Autowired
       private DataSource dataSource;	// ①
   
       @Override
       protected void configure(HttpSecurity http) throws Exception {
           http.
               // ...
               .and().rememberMe()	// ②
                   .rememberMeCookieName("RememberMall") // ③
                   .tokenRepository(persistentTokenRepository()) //④
                   .tokenValiditySeconds()  // ⑤
                   .userDetailsService(userDetailsServiceImpl) // ⑥
       }
     	@Bean
       public PersistentTokenRepository persistentTokenRepository() {
           JdbcTokenRepositoryImpl tokenRepository = new JdbcTokenRepositoryImpl();
           tokenRepository.setDataSource(dataSource);
           // 第一次执行需要创建数据库,以后运行就不需要了
           tokenRepository.setCreateTableOnStartup(true);
           return tokenRepository;
       }
   }
   ```

   ① - 注入数据源

   ② - 在Security的配置中开启rememberMe并添加相关配置

   ③ - rememberMeCookieName() 是要在浏览器保存的cookie的名称，否则再次请求无法解析cookie

   ④ - tokenRepository() 指Security对Token的查询和新增相关操作的数据源

   ⑤ - tokenValiditySeconds 表示记住我有效时间；

   ⑥ - userDetailsService 从token中解析出的User赋予userDetailsService用作认证

## 2.8 Security认证成功处理器

- AuthenticationEntryPoint 用来解决匿名用户访问无权限资源时的异常

- AccessDeineHandler 用来解决认证过的用户访问无权限资源时的异常

- **自定义认证成功处理器类继承Security认证成功处理器**

  - 默认的认证成功会跳转到引发认证的链接上去，如果是一个Rest异步请求触发的认证，他希望的返回值是json格式的认证信息，此时如果认证成功跳转到原来的Rest请求上就和需求不符；

  - 认证成功接口：AuthenticationSuccessHandler，可以获取到认证信息
  - 认证成功接口的子类：SavedRequestAwareAuthenticationSuccessHandler，提供的跳转功能

- **用自定义认证成功处理器替换默认的认证成功处理器**

  ```java
  @Override
  protected void configure(HttpSecurity http) throws Exception {
  	http.formLogin()
  		// ...
          .successHandler(Autowired 自定义成功处理器)
          // ...
  }  
  ```

## 2.9 Security认证失败处理器

- **自定义错误响应页面**
  
- 自定义错误响应页面，在项目的根路径中新建`resources/error`的文件夹，新建错误码同名的html页面，SpringBoot如果响应的html格式的页面，则会先匹配`resources/error`中错误码对应的错误页面。
  
- **自定义认证失败处理器**
  - 自定义认证失败处理器继承Security认证失败处理器

    - 认证失败接口：AuthenticationFailureHandler，可以获取认证异常信息
    - 认证失败接口的实现子类：SimpleUrlAuthenticationFailureHandler，提供的跳转功能

  - 用自定义的认证失败处理器替换默认的认证失败处理器

    ```java
    @Override
    protected void configure(HttpSecurity http) throws Exception {
    	http.formLogin()
    		// ...
            .failureHandler(Autowired 自定义失败处理器)
            // ...
    }  
    ```
  
- 在自定义的认证失败的过滤器中抛出的认证异常需要手动的指定由认证失败处理器进行处理，否则框架无法失败抛出的异常

## 2.10 获取用户认证信息

1. 从线程变量的SecurityContextHolder中获取线程中的用户信息

   ```java
   SecurityContextHolder.getContext().getAuthentication()
   ```

2. 在Controller的参数中添加Authentication参数，Security会自动将认证信息传递给参数

   ```java
   @GetMapping(value = "me2")
   public R<Authentication> getCurrentUser2(Authentication authentication) {
       return R.success(authentication);
   }
   ```

3. 使用注解`@AuthenticationPrincipal`获取controller参数Authentication中的UserDetails信息

   ```java
   @GetMapping(value = "me3")
   public R<UserDetails> getCurrentUser3(@AuthenticationPrincipal UserDetails userDetails) {
       return R.success(userDetails);
   }
   ```

## 2.11 图形验证码扩展用户名密码

1. **基础回顾**：Spring中的过滤器的用法和涉及到的Spring其他核心对象

   - **OncePerRequestFilter**：它能够确保在一次请求中只通过一次filter，而需要重复的执行。大家常识上都认为，一次请求本来就只filter一次，加此特别限定，此方法是为了兼容不同的web container，也就是说并不是所有的container都与我们期望的只过滤一次，servlet版本不同，执行过程也不同，因此，为了兼容各种不同运行环境和版本，默认filter继承OncePerRequestFilter是一个比较稳妥的选择。
   - **InitializingBean**：接口为bean提供了初始化方法的方式，它只包括afterPropertiesSet方法，凡是继承该接口的类，在初始化bean的时候都会执行该方法。过滤器类中的功能类中可以在初始化时候预备一些相关信息。

2. **Security用验证码扩展户名密码认证**：Security的本质由是一系列的过滤器组成，使用验证码扩展用户名认证，本质上的认证方式还是用户名密码认证：即核心任然是`UsernamePasswordAuthenticationFilter`过滤器，扩展方式是在`UsernamePasswordAuthenticationFilter`之前添加一个验证码过滤器，通过了验证码之后才能实现用户名密码认证，核心配置在Security的配置类中实现

   ```java
   @Override
   protected void configure(HttpSecurity http) throws Exception {
       http
           // ... ...
           .and()
           .addFilterBefore(new 验证码拦截器,UsernamePasswordAuthenticationFilter.class)
   }
   ```

   > HttpSecurity中添加过滤器其他API
   >
   > - addFilterAfter：在指定过滤器之后添加过滤器
   >
   > - addFilterBefore：在指定过滤器之前添加过滤器
   > - addFilter：在过滤器链最后添加过滤器
   > - addFilterAt：将过滤器设置在指定过滤器的同一位置，但是顺序是不固定的，根据class排序

## 2.12 自定义认证- 原理

<img src="http://m.qpic.cn/psc?/V52xXkY417Nw310rbooN1OUGO41S4u1u/TmEUgtj9EK6.7V8ajmQrEPY94n6ue4F9mVDRTqkFisNzs87aW8XOIeDDXjv3TGI7gsJaKOZ8KT6C1bqY0iYeqKOnCieQ5mwMnmUHbLgVKvQ!/b&bo=DAZoAwwGaAMDORw!&rf=viewer_4&t=5" border="0" />

### 1. 框架内置用户名密码登陆认证逻辑

- 用户名密码登陆请求被UsernamePasswordAuthenticationFilter拦截，获取到请求中相关参数
- 根据请求参数生成未认证通过的UsernamePasswordAuthenticationToken交给AuthenticationManager
- AuthenticationManager从一系列中的Provided中找到支持（support）UsernamePasswordAuthenticationToken
- DaoAuthenticationProvider根据UsernamePasswordAuthenticationToken中的信息调用UserDetailService获取到UserDetail信息
- 根据获取到的UserDetail重新生成认证通过的UsernamePasswordAuthenticationToken交给后续的Filter

### 2. 自定义认证扩展 - sms

- 首先要定义对应的AuthenticationFilter用于拦截自定义认证的请求

- 每一种的认证方式都有自己的一个AuthenticationToken，用于保存认证相关的特定数据

- 并且要将AuthenticationToken交给AuthenticationManager

- 每一个AuthenticationToken都需要定义对应的Provider，这样AuthenticationManager才能找到Provider

- 自定义的Provider也需要调用UserDetailService获取到UserDetail信息

- 根据获取到的UserDetail重新生成认证通过的AuthenticationToken

- 最后需要将Provider和Filter添加的Security的配置才能将认证通过的AuthenticationToken交给后续的Filter

  1. 为该认证方式定义一个特定的Config

     ```java
     @Configuration
     public class Config extends SecurityConfigurerAdapter<DefaultSecurityFilterChain, HttpSecurity> {
     
         @Autowired
         private SecurityUserDetailService userDetailsService;
     
         @Override
         public void configure(HttpSecurity http) throws Exception {
             SmsAuthenticationFilter filter = new SmsAuthenticationFilter();
             
             filter.setAuthenticationManager(http.getSharedObject(AuthenticationManager.class));
     
             // Provider要根据UserDetailsService获取用户信息
             SmsAuthenticationProvider provider = new SmsAuthenticationProvider(userDetailsService);
     
      		/**
              *  1. 将Provide添加到全局配置中
              *  2. 将自定义过滤器添加到添加到过滤器链中 
              */
             http.authenticationProvider(provider)
                     .addFilterAfter(filter, UsernamePasswordAuthenticationFilter.class);
     
         }
     }
     
     ```

  2. 在将自定义认证方式的Config添加到全局的SecurityConfig中

     ```java
         @Autowired
         private SecuritySmsConfig securitySmsConfig;
         @Override
         protected void configure(HttpSecurity http) throws Exception {
             http
                 // ... ...
                 .apply(securitySmsConfig);
         }
     ```

## 2.13 自定义认证案例 - 短信登陆

1. **初始化验证码获取接口和验证码认证的表单接口**

2. **在Security中配置验证码认证相关请求的认证权限**

3. **后台服务实现获取验证码的功能**：获取验证码通过手机号获取验证码，并把相关信息返回并存储在特定的缓存中，等待认证

4. **实现自定义认证相关类**

   - AbstractAuthenticationToken：自定义认证Token，封装自己的属性

     ```java
     public class SmsAuthenticationToken extends AbstractAuthenticationToken {
     
         // 自己的Token中要保存的认证信息
         private final Object principal;
     
         // 未认证通过的Token构造器
         public SmsAuthenticationToken(Object principal) {
             super(null);
             this.principal = principal;
             setAuthenticated(false);
         }
     
         // 认证通过的Token构造器
         public SmsAuthenticationToken(Object principal, Collection<? extends GrantedAuthority> aut) {
             super(aut);
             this.principal = principal;
             super.setAuthenticated(true); // 必须调用父类认证
         }
     
         // 用于设置认证没有通过
         public void setAuthenticated(boolean isAuthenticated) throws IllegalArgumentException {
             if (isAuthenticated) {
                 throw new IllegalArgumentException("认证异常日志");
             }
     
             super.setAuthenticated(false);
         }
     
         // 认证信息中的主体身份
         public Object getPrincipal() {
             return this.principal;
         }
     
         // 通常作为密码 的证明性文件
         public Object getCredentials() {
             return null;
         }
     }
     ```

   - AbstractAuthenticationProcessingFilter：自定义认证的过滤器，被拦截后构建自己的Token，并设置到SecurityManager中

     ```java
     public class SmsAuthenticationFilter extends AbstractAuthenticationProcessingFilter {
     
         public static final String SPRING_SECURITY_FORM_MOBILE_KEY = "mobile";
     
         private String usernameParameter = SPRING_SECURITY_FORM_MOBILE_KEY;
         private boolean postOnly = true;
     
         // 用于拦截自定义认证的请求
         public SmsAuthenticationFilter() {
             super(new AntPathRequestMatcher("/authentication/mobile", "POST"));
         }
     
     
         public Authentication attemptAuthentication(HttpServletRequest request,
                                                     HttpServletResponse response) throws AuthenticationException {
             if (postOnly && !request.getMethod().equals("POST")) {
                 throw new AuthenticationServiceException(
                         "Authentication method not supported: " + request.getMethod());
             }
     
             String username = obtainUsername(request);
     
             if (username == null) {
                 username = "";
             }
     
     
             username = username.trim();
     
             SmsAuthenticationToken authRequest = new SmsAuthenticationToken(
                     username);
     
             // 提出方法为了给子类提供扩展
             setDetails(request, authRequest);
     
             return this.getAuthenticationManager().authenticate(authRequest);
         }
     
         @Nullable
         protected String obtainUsername(HttpServletRequest request) {
             return request.getParameter(usernameParameter);
         }
     
         protected void setDetails(HttpServletRequest request,
                                   SmsAuthenticationToken authRequest) {
             authRequest.setDetails(authenticationDetailsSource.buildDetails(request));
         }
     
         public void setUsernameParameter(String usernameParameter) {
             Assert.hasText(usernameParameter, "Username parameter must not be empty or null");
             this.usernameParameter = usernameParameter;
         }
       	public final String getUsernameParameter() {
             return usernameParameter;
         }
         public void setPostOnly(boolean postOnly) {
             this.postOnly = postOnly;
         }
     }
     
     ```

   - AuthenticationProvider：每一个Token有自己的Provider，用户验证token，重点是在supports方法中指定自己可以处理的Token；

     ```java
     public class SmsAuthenticationProvider implements AuthenticationProvider {
     
         private final UserDetailsService userDetailsService;
     
         public SmsAuthenticationProvider(UserDetailsService userDetailsService) {
             this.userDetailsService = userDetailsService;
         }
     
         @Override
         public Authentication authenticate(Authentication authen) throws AuthenticationException {
             SmsAuthenticationToken token = (SmsAuthenticationToken) authentication;
             UserDetails userDetails = 
                 userDetailsService.loadUserByUsername(token.getPrincipal().toString());
             if (userDetails == null) {
                 throw new RuntimeException("用户信息获取失败");
             }
             SmsAuthenticationToken smsAuthenticationToken 
                 = new SmsAuthenticationToken(userDetails, userDetails.getAuthorities());
             smsAuthenticationToken.setDetails(smsAuthenticationToken.getDetails());
             return smsAuthenticationToken;
         }
     
         @Override
         public boolean supports(Class<?> authentication) {
             return SmsAuthenticationToken.class.isAssignableFrom(authentication);
         }
     }
     ```
   
5. 最后需要将自定义的相关类添加到Security的配置中

   - 自定义Filter添加到Security的过滤器链中
   - 

## 2.14 自定义认证案例 - jwt

1. jwt认证和图形验证码类似，本质也是用户名和密码的认证方式；和图形验证码的区别是：图形验证码需要校验验证码之成功再根据用户名请求数据库获取用户信息，而jwt是可以直接从jwtToken信息中解析出用户信息，可以将解析出的用户信息构建一个认证成功的UsernamePasswordAuthenticationToken（也可以用解析出的用户信息查询数据库然后用数据库数据构建UsernamePasswordAuthenticationToken），然后保存在SecurityContextHolder中。

   ```java
   UsernamePasswordAuthenticationToken authentication = 
       new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
   authentication.setDetails(new WebAuthenticationDetailsSource().buildDetails(request));
   SecurityContextHolder.getContext().setAuthentication(authentication);
   ```

2. 案例代码

# 第三章 Security第三方认证

1. OAuth2协议：
   - OAuth2协议解决的问题：微信服务器上有我的照片数据，我自己要开发一个服务可以获取我在微信中的数据（我的服务就有了微信的潜在用户），但是微信服务肯定不同意直接读取用户数据，需要微信授权给我的服务：（授权的方式一：用户把微信的用户名和密码给我；授权方式二：用OAuth协议，用户从微信拿到令牌，我的服务用令牌从微信服务获取照片数据
2. OAuth运行流程
   - 运行角色
     - 服务提供商（Provider）作用是提供令牌。谁提供令牌，谁就是服务提供商
       - 认证服务器：Authentication server作用是认证用户身份，为用户提供令牌
       - 资源服务器：Resource Server保存用户数据，可以验证令牌
     - 用户：资源所有者（Rsource Owner）
     - 第三方应用（client）：
   - 运行流程
     - 用户访问第三方应用：想要获取微信照片
     - 第三方应用第一次会返回给用户要授权：用户同意授权
     - 第三方应用会去服务提供商的认证服务器：告诉认证服务器用户同意了，服务器验证用户发放令牌
     - 第三方应用拿到令牌：访问资源服务器，
     - 资源服务器验证令牌：同意访问图片
   - 在第二步有四种授权模式
     - 授权码模式：功能最完整，流程最严密的授权模式，所有的服务提供商都是授权码模式
       - 0：用户访问第三方应用
       - 1：第三方应用将用户导向认证服务器：用户访问认证服务器进行授权认证
       - 2：用户授权成功：授权服务器再讲用户导向第三方应用，并带有授权码（两个导向的地址是两个服务提前注册好的）
       - 3：第三方应用拿着授权码：再去认证服务器申请令牌（在后台完成）
       - 4：如果是刚才发放的令牌：则给第三方提供一个令牌，第三方拿到令牌
     - 简化模式：
       - 
     - 密码模式：
     - 客户端模式：
3. SecuritySocial：实现是OAuth2协议，封装在SocialAuthenticationFilter中，把过滤器加到Security过滤器链，带着用户走完OAuth协议流程
   - SecuritySocial流程中的接口
     - ServiceProvider：是服务器提供商的抽象，提供了一个AbstractOAuth2ServiceProvider，每个具体的服务提供商需要为接口提供自己的实现。服务提供商的1-5步是标准化流程；第六步获取用户资源是个性化接口
       - OAuth2Operations：封装的1-5步的标注流程，默认实现OAuth2Template
       - Api：SecuritySocial提供默认的抽象：AbstractOAuth2ApiBinding，获取个性化用户信息的行为
     - 第七步相关的接口在第三方应用内部完成的
       - Connection：作用是封装前六步完成拿到的用于信息。SecuritySocial提供了实现OAuth2Connection
         - 服务提供商的用户信息和第三方应用的用户信息的匹配：存储在第三方应用的数据库中UserConnection表，这个表是由UserConnectionRepository的实现JdbcUserConnectionRepository操作这个数据库；
       - ConnectionFactory接口：的实现OAuth2ConnectionFactory创建出了Connection
         - 包含了ServiceProvider的实例：用实例调取前六步的流程
         - 包含了Api的实例：ApiAdapter：服务商不同的数据结构转为为Connection标准的数据结构，做的适配
4. SpringSocial：提供了常规的实现微博、等等其他

# 第四章 第三方认证服务开发



# 第五章 Security授权

## 4.1 权限说明

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;认证(Authentication)：确定一个用户的身份的过程（判断你是谁）。授权(Authorization)：判断一个用户是否有访问某个安全对象的权限（判断你能干什么）。

## 4.2 Security授权原理

1. Security核心是一系列的拦截器：除了用户登录校验相关的过滤器,最后还包含了鉴权功能的过滤器,还有匿名资源访问的过滤器链`AnonymousAuthorizationFilter`：是一个方法级的权限过滤器, 位于基本过滤链的最底部。 主要作用是用于判断SecurityContext中是否有Authentication对象，如果没有则会调用AnonymousAuthenticationToken创建AnonymousAuthentication对象并添加到SecurityContext中，会当做匿名用户登录信息

   <img src="https://s1.ax1x.com/2020/07/03/NOE0eK.png" alt="NOE0eK.png" border="0" />

2. Security权限验证原理

   <img src="https://s1.ax1x.com/2020/07/03/NOzwJx.png" alt="NOzwJx.png" border="0" />

- SecurityConfig：主要封装了Security配置类中自定义的配置信息
- SecurityContextHolder：表示用户认证通过后保存在认证Context中用户信息
- FilterSecurityInterceptor：表示当前的服务请求，包含了当前请求的相关信息；主要是将当前请求对应的三方信息交给AccessDecisionManager（投票管理者）
- AccessDecisionManager：投票管理者调用AccessDecisionVoter的投票者最终来判断是过还是不过（也就是有没有权限）有两种可能

## 4.3 Security授权方式

### 1. 基于认证的授权

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;授权场景：该方式表示只有登录成功就表示登录用户可以访问当前服务的所有资源，无需对其操作做多余限定。多在业务类型系统服务中，除了系统提供的资源外，业务系统会保存大量的用户数据，为了保护用户数据而添加认证功能，当用户认证后，该用户就可以操作属于自己的相关数据，而不需要做权限操作。

### 2. 固定角色授权

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在某些业务系统中会添加类似VIP之类的简单角色，而且系统中的部分资源只有拥有改角色的用户才可以访问，并且熊的中的角色基本固定，角色对应的资源也是特定资源，此时只需要为用户配置对应的角色，用Security设置改角色对应的资源的权限访问方式即可，

- **给用户添加角色**：以下案例是基于配置的方式为指定用户添加角色，从数据读取到的方式也是类似：实现用户拥有角色的功能就可以

  ```java
  @Configuration
  public class SecurityConfig extends WebSecurityConfigurerAdapter {
  
      @Override
      protected void configure(AuthenticationManagerBuilder auth) throws Exception {
          auth
                  .inMemoryAuthentication()
                  .withUser("admin").password("{noop}123456").roles("ADMIN")
                  .and()
                  .withUser("test").password("{noop}test123").roles("USER");
      }
  }
  ```

- 在Security的配置文件中为该角色配置特点的资源：如下案例

  ```java
  @Configuration
  public class SecurityConfig extends WebSecurityConfigurerAdapter {
      @Override
      protected void configure(HttpSecurity http) throws Exception {
          http
                  .authorizeRequests()
                  .antMatchers("/url").hasRole("ADMIN");
      }
  }
  ```

- 或者使用Security注解在对应的Controller资源的方法上添加角色注解

  1. 在配置文件中开启Security注解功能

     ```java
     @Configuration
     @EnableWebSecurity
     @EnableGlobalMethodSecurity(prePostEnabled = true)
     public class SecurityConfig extends WebSecurityConfigurerAdapter {
         // ... ...
     }
     ```

  2. 在Controller方法需要验证角色的主要添加权限验证

     ```java
     @PreAuthorize("hasRole('ROLE_ADMIN')")
     @GetMapping("/user")
     ```

### 3. 使用编码动态的读取数据库

<img src="https://s1.ax1x.com/2020/07/03/NX9jfI.png" alt="NX9jfI.png" border="0" />

- 使用编码实现权限判断的核心代码：access参数是权限代码字符串表达式

  ```java
  @Configuration
  public class SecurityConfig extends WebSecurityConfigurerAdapter {
  
      @Override
      protected void configure(HttpSecurity http) throws Exception {
          http.authorizeRequests()
              .antMatchers("/**")
              .access("@rbacServictImpl.hasPremise(request,authentication)");
      }
  ```

  - @rbacServictImpl：表示Spring的一个组件，需要自定义对应的接口
  - hasPremise：这个方法是接口中定义的方法，改方法的基本要求
    1. 返回值是Boolean类型的值
    2. 方法必须要有参数一：HttpServletRequest request用于获取当前请求的URL
    3. 方法必须要有参数二：Authentication authentication表示当前已经认证成功的用户信息

### 4. 基于注解动态判断用户权限

- 在Security的配置文件中启用Security注解功能

  ```java
  
  ```

- 在对应的Controller资源上添加权限注解

- 注解使用基本条件说明