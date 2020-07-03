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



# 第二章 Security认证

## 2.1 默认的认证方式

<img src="https://s1.ax1x.com/2020/06/20/NQVVfg.png" alt="NQVVfg.png" border="0" />

## 2.2 使用配置修改登陆信息 

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

   - resources/resources：SpringBoot项目启动默认会读取这个目录中的index.html页面作为首页，引入静态资源的路径是以static为根，比如：

     ```html
     <link rel="stylesheet" href="/css/element-ui.css">
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
                   .antMatchers("/css/**", "/js/**", "/fonts/**", "/images/**").permitAll()    // ⑩
                   .antMatchers("").permitAll()    // ⑪
                   .anyRequest().authenticated()               // ⑫
                   .and()
                   .csrf().disable();                          // ⑬
       }
   }
   ```

   ① - 用于指定登陆页的链接，在这里指定登陆链接后需要在⑪的授权请求时候需要permitAll，不然跳转登陆页会被Security拦截；
   
   ② - 登陆处理URL，默认的登陆url是`/login`，自定义表单登陆可以修改登陆请求，也需要请求授权时permitAll，不然发送登陆请求会被Security拦截；
   
   ③ - 修改表单登陆的用户名参数，默认是username；
   
   ④ - 修改表单登陆的密码参数，默认是password；
   
   ⑤ - 如果不是其他请求引发认证而导致的登陆，登陆成功后跳转的链接；
   
   ⑥ - 登陆失败后跳转的链接；
   
   ⑦ - 登陆成功处理器，可以记录登录相关信息；
   
   ⑧ - 登陆失败处理器，可以记录登录失败等相关日志或其他信息；
   
   ⑨ - 表示是请求授权相关配置
   
   ⑩ - antMatchers表示路径匹配器，如果路径匹配的上则执行之后的操作，permitAll表示该请求允许所有权限无需认证；
   
   ⑫ - anyRequest()表示所有请求，这个配置要放在最后，应为这个配置之后再做路径匹配就无效了，authenticated表示需要认证
   
   ⑬ - csrf().disable()表示关闭csrf；

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

   <img src="https://s1.ax1x.com/2020/06/20/NloT4U.jpg" alt="NloT4U.jpg" border="0" />

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

1. **OncePerRequestFilter**：顾名思义，它能够确保在一次请求中只通过一次filter，而需要重复的执行。大家常识上都认为，一次请求本来就只filter一次，为什么还要由此特别限定呢，往往我们的常识和实际的实现并不真的一样，此方法是为了兼容不同的web container，也就是说并不是所有的container都与我们期望的只过滤一次，servlet版本不同，执行过程也不同，因此，为了兼容各种不同运行环境和版本，默认filter继承OncePerRequestFilter是一个比较稳妥的选择。
2. **InitializingBean**：接口为bean提供了初始化方法的方式，它只包括afterPropertiesSet方法，凡是继承该接口的类，在初始化bean的时候都会执行该方法。

## 2.12 自定义认证-短信登陆

## 2.13 自定义认证-jwt

# 第三章 Security第三方认证











