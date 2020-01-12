# 1. SpringBoot 默认异常处理

> @RequestMapping("${server.error.path:${error.path:/error}}")	
>
> 同一个url返回不同的响应状态

- BasicErrorController中如果请求头包含`text/html`,返回ModelAndView对象

    ```java
    @RequestMapping(produces = "text/html")
    public ModelAndView errorHtml(HttpServletRequest request,
            HttpServletResponse response) {
        HttpStatus status = getStatus(request);
        Map<String, Object> model = Collections.unmodifiableMap(getErrorAttributes(
                request, isIncludeStackTrace(request, MediaType.TEXT_HTML)));
        response.setStatus(status.value());
        ModelAndView modelAndView = resolveErrorView(request, response, status, model);
        return (modelAndView == null ? new ModelAndView("error", model) : modelAndView);
    }
    ```

- BasicErrorController中如果请求头没有包含`text/html`,访问`error`方法,返回ResponseBody的JSON

    ```java
    @RequestMapping
    @ResponseBody
    public ResponseEntity<Map<String, Object>> error(HttpServletRequest request) {
        Map<String, Object> body = getErrorAttributes(request,
        isIncludeStackTrace(request, MediaType.ALL));
        HttpStatus status = getStatus(request);
        return new ResponseEntity<Map<String, Object>>(body, status);
    }
    ```


# P016_简介

1. 内容概述
    - SpringSecurity基本原理
    - 实现用户名+密码认证
    - 实现手机号+短信认证

# P017_pringSecurity基本原理

1. 基本原理介绍

    - SpringSecurity本质就是一组过滤器链:封装在DefaultSecurityFilterChain.filters中

        ```properties
        SecurityContextPersistenceFilter 
        WebAsyncManagerIntegrationFilter
        HeaderWriterFilter
        CsrfFilter
        LogoutFilter
        UsernamePasswordAuthenticationFilter
        DefaultLoginPageGeneratingFilter
        BasicAuthenticationFilter
        RequestCacheAwareFilter
        SecurityContextHolderAwareRequestFilter
        AnonymousAuthenticationFilter=
        SessionManagementFilter=限制同一用户开多个会话的数量
        ExceptionTranslationFilter=异常转换过滤器
        FilterSecurityInterceptor=获取所有配置资源的授权信息,根据SecurityContextHolder中存储的用户信息决定是否有权限
        ```

# P018_自定义用户认证逻辑

1. 获取用户信息:security的获取用户信息的逻辑被封装在UserDetailsService接口中需要自定义实现类实现方法

    ```java
    @Component
    public class LoginUserInfoService implements UserDetailsService {
    
        @Autowired
        private UserInfoService userInfoService;
    
        @Override
        public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
            QueryWrapper<UserInfoEntity> queryWrapper = new QueryWrapper<>();
            queryWrapper.lambda().eq(UserInfoEntity::getMobile, username);
            UserInfoEntity entity = userInfoService.getOne(queryWrapper);
            return new User(username, entity.getPassword(), 
                            AuthorityUtils.commaSeparatedStringToAuthorityList("admin"));
        }
    }
    ```

    - 将实现类注册进Spring中,可以调用Spring的组件
    - 把从数据库读出的用户返回给Security接口,由接口完成密码校验,完成登录

2. 处理用户校验逻辑:是UserDetail的实现类Security内置类User中

    - User对象的完全构建

        ```java
        public class User implements UserDetails{  
        	private String password;
            private final String username;
            private final Set<GrantedAuthority> authorities;
            private final boolean accountNonExpired;
            private final boolean accountNonLocked;
            private final boolean credentialsNonExpired;
            private final boolean enabled;
        }
        ```

3. 密码加密与解密 ; 配置加密工具类

    ```java
    @Bean
    public PasswordEncoder passwordEncoder(){
        return new BCryptPasswordEncoder();
    }
    
    @Autowired
    private PasswordEncoder passwordEncoder;
    ```

    

# P019_个性化用户认证逻辑

1. 自定义登陆页面

    - 修改默认的登陆请求url 与请求参数: POST  /login

        ```java
        .loginProcessingUrl("/authentication/form")
        .usernameParameter("user")
        .passwordParameter("pwd")
        ```

        > 配置之后的请求url会交给UsernamePasswordAuthenticationFilter完成密码用用户名校验

    - 设置开启自定义的登陆页面

        ```java
        http 
        	.formLogin()
            .loginPage("自定义的登陆页面")
            .and()
            .authorizeRequests()
            .antMatchers("/demo_login_page.html")
            .permitAll()
            .anyRequest()
            .authenticated()
        ```

    - 编写配置文件-读取配置文件形式

        1. 

    - 编写配置文件-使用标签读取配置文件

        ```java
        @Value("${security.login.page}")
        private String loginPage;
        ```

        

2. 属性封装步骤

    - 定义全局配置文件,开启属性配置

        ```java
        @Configuration
        @EnableConfigurationProperties(SecurityPropertiesConfig.class)
        public class SecurityCoreConfig {
        
        }
        ```

    - 定义属性配置类,指定配置前缀

        ```java
        @Component
        @ConfigurationProperties(prefix = "panda.security")
        @Setter
        @Getter
        public class SecurityPropertiesConfig {
            private BrowserProperties browser = new BrowserProperties();
            private ValidateCodeProperties code = new ValidateCodeProperties();
            private OAuth2Properties oauth = new OAuth2Properties();
            private SociaProperties socia = new SociaProperties();
        }
        ```

    - 在属性配置类中添加属性,完成配置

3. 登陆成功处理:默认登陆成功跳转到引发跳转的url

    ```java
    @Component
    @Slf4j
    public class PandaAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler
    	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication authentication) throws IOException, ServletException {
    		log.info("登陆成功");
    	}
    }
    ```

4. 登陆失败处理:

    ```java
    @Component
    @Slf4j
    public class PandaAuthenticationFailureHandler extends SimpleUrlAuthenticationFailureHandler {
    	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response, AuthenticationException exception) throws IOException, ServletException {
         	 log.info("登陆失败"); 
        }
    }
    ```

# 020_登陆认证源码解析

1. 登陆请求到 UsernamePasswordAuthenticationFilter 

    ```java
    // 使用用户名和密码构建一个UsernamePasswordAuthenticationToken
    UsernamePasswordAuthenticationToken authRequest 
    = new UsernamePasswordAuthenticationToken(username, password);
    
    // 构建UsernamePasswordAuthenticationToken对象的构造函数 setAuthenticated=false表示没有身份认证
    public UsernamePasswordAuthenticationToken(Object principal, Object credentials) {
        super((Collection)null);
        this.principal = principal;
        this.credentials = credentials;
        this.setAuthenticated(false);
    }
    
    setDetails(request, authRequest);
    
    /* getAuthenticationManager调用 AuthenticationManager
    		- 不会包含验证逻辑
    		- AuthenticationManager是用于管理AuthenticationProvider收集所有的 Provider
    */
    return this.getAuthenticationManager().authenticate(authRequest);
    ```

2. AuthenticationManager 的实现类 ProviderManager

    ```java
    public Authentication authenticate(Authentication authentication)
    			throws AuthenticationException {
    		Class<? extends Authentication> toTest = authentication.getClass();
    		AuthenticationException lastException = null;
    		Authentication result = null;
    		boolean debug = logger.isDebugEnabled();
    
        /* 获取所有的AuthenticationProvider, 提供了校验逻辑,比如默认是用户名密码验证,
         	第三方认证时候不需要这个验证
      	*/
      	for (AuthenticationProvider provider : getProviders()) {
            // 判断当前provider是否支持authentication:UsernamePasswordAuthenticationToken
            if (!provider.supports(toTest)) {
                continue;
            }
    		...
            try {
                // 执行校验逻辑到了 AbstractUserDetailsAuthenticationProvider
                result = provider.authenticate(authentication);
    
                if (result != null) {
                    copyDetails(authentication, result);
                    break;
                }
            } catch (AccountStatusException e) {
     			...
            }
        }
    
        if (result == null && parent != null) {
            // Allow the parent to try.
            try {
                result = parent.authenticate(authentication);
            } catch (ProviderNotFoundException e) {
       			... 
            }
        }
    
        if (result != null) {
            if (eraseCredentialsAfterAuthentication
                && (result instanceof CredentialsContainer)) {
                // Authentication is complete. Remove credentials and other secret data
                // from authentication
                ((CredentialsContainer) result).eraseCredentials();
            }
    
            eventPublisher.publishAuthenticationSuccess(result);
            return result;
        }
    
        if (lastException == null) {
            lastException = new ProviderNotFoundException(messages.getMessage(
                "ProviderManager.providerNotFound",
                new Object[] { toTest.getName() },
                "No AuthenticationProvider found for {0}"));
        }
    
        prepareException(lastException, authentication);
    
        throw lastException;
    }
    ```

    - AbstractUserDetailsAuthenticationProvider

    ```java
    
    ```

3. 认证结果在多个请求中共享 ; SecurityContextPersistenceFilter,从线程中获取SecurityContext 

    - SecurityContextPersistenceFilter 在过滤器最前面,检查SecurityContext ,有拿出来放到线程中,出去时候检查线程中是否有认证信息

    - SecurityContextHolder : 用于操作SecurityContext 与当前执行线程关联线程级别的全局变量

    - SecurityContext : 保存认证信息实现类 SecurityContextImpl

        ```java
        public class SecurityContextImpl implements SecurityContext {
        	private Authentication authentication;
        }
        ```

4. 获取认证用户的信息

    ```java
    //方式一 直接从线程变量中获取
    @GetMapping(value = "/me")
    public ResponseResult getMe(Authentication authentication) {
        return ResponseResult.success(SecurityContextHolder.getContext().getAuthentication());
    }
    //方式二 在请求方法参数上定义Authentication 参数
    @GetMapping(value = "/me")
    public ResponseResult getMe(Authentication authentication) {
        return ResponseResult.success(authentication);
    }
    
    // 方式三 只获取用户信息
    @GetMapping(value = "/me")
    public ResponseResult getMe(@AuthenticationPrincipal UserDetails userDetails) {
        return ResponseResult.success(userDetails);
    }
    ```

# 021_图片验证码

1. 开发生成图形验证码的接口

    - 开发生成图片与随机码的的工具类

    - 定义Rest的服务接口,生成随机数保存到session,然后将码写到图片响应到前端

2. 在UsernamePasswordAuthenticationFilter前添加用来验证验证码的过滤器

    ```java
        @Override
        protected void configure(HttpSecurity http) throws Exception {
            ValidateCodeFilter validateCodeFilter = new ValidateCodeFilter();
            validateCodeFilter.setAuthenticationFailureHandler(pandaAuthenticationFailureHandler);
            http
                    .addFilterBefore(validateCodeFilter, UsernamePasswordAuthenticationFilter.class)
        			...
        }
    ```

3. 定义图形验证码的过滤器

    ```java
    @Setter
    public class ValidateCodeFilter extends OncePerRequestFilter {
    
        private AuthenticationFailureHandler authenticationFailureHandler;
    
        private SessionStrategy sessionStrategy = new HttpSessionSessionStrategy();
    
        @Override
        protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws ServletException, IOException {
            if (StringUtils.equals("/login", request.getRequestURI()) && StringUtils.equalsIgnoreCase(request.getMethod(), RequestMethod.POST.name())) {
                try {
                    validate(new ServletWebRequest(request));
                } catch (ValidateCodeException e) {
                    // 捕获到异常 交给认证失败异常处理器
                    authenticationFailureHandler.onAuthenticationFailure(request, response, e);
                	return;
                }
            }
            chain.doFilter(request, response);
        }
    
        private void validate(ServletWebRequest request) throws ServletRequestBindingException {
            String codeInSession = (String) sessionStrategy.getAttribute(request, CodeController.SESSION_IMG_CODE_KEY);
            String parameter = ServletRequestUtils.getStringParameter(request.getRequest(), "code");
            if (StringUtils.isBlank(codeInSession)) {
                throw new ValidateCodeException("验证码不存在");
            }
            if (StringUtils.isBlank(parameter)) {
                throw new ValidateCodeException("验证码不能为空");
            }
            if (!StringUtils.equals(codeInSession, parameter)) {
                throw new ValidateCodeException("验证码不正确");
            }
        }
    }
    ```

# 4-8_重构图片验证码

1. 图片参数可配置 : 基本参数可配置

    - 请求级配置   覆盖     应用级配置     覆盖        默认级配置

    - 图片大小
    - 验证码字母数量

2. 图形验证接口可配置:那些服务需要校验图形验证码

    - 添加一个urls的集合配置

3. 替换验证码生成逻辑

    - 定义接口指定生成验证码的规范
    - 通过不同的实现类完成生成逻辑的不同,把不同的实现类注入到Spring容器中

# 4-9_记住我的功能

1. 记住我原理

   - 第一次请求经过UsernamePasswordAuthenticationFilter，
   - 认证成功后经过RememberMeService调用服务生成Token,执行TokenRepository 将Token写入到数据库,同时将Token写入到Cookie中
   - 再次请求时会先访问RememberMeAuthenticationFilter,请求头中会带cookie中的token与数据库中对比,实现记住我功能
   - 如果对比成功需要使用UserDetailService进行登录

2. 记住我开发步骤

   - 配置TokenRepository 用于读写数据库

     ```java
     @Bean
     public PersistentTokenRepository persistentTokenRepository() {
         JdbcTokenRepositoryImpl tokenRepository = new JdbcTokenRepositoryImpl();
         tokenRepository.setCreateTableOnStartup(false);
         return tokenRepository;
     }
     ```

   - 生成token表格 : JdbcTokenRepositoryImpl

     ```sql
     create table persistent_logins
     (
       username  varchar(64) not null,
       series    varchar(64) primary key,
       token     varchar(64) not null,
       last_used timestamp   not null
     );
     ```

   - 表单中添加记住我选项 : remember-me

     ```html
     <tr>
         <td>记住我</td>
         <td><input type="checkbox" name="remember-me" value="true"></td>
     </tr>
     ```

   - 将记住我配置到Security配置选项中

     ```java
     .and()
         .rememberMe()
         .tokenRepository(persistentTokenRepository())
         .tokenValiditySeconds(getRememberSecond())
     ```

# 4-10_短信验证

1. 短信验证登录:意义是security中不存在的认知逻辑
   - ① 开发短信验证码接口 , 发送短信 验证短信
   - ② 