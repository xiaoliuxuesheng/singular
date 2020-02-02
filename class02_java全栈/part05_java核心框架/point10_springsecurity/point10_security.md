# 第一章 SpringSecurity基础

## 1.1 基本环境准备

1. Maven依赖

   - 添加Maven依赖管理

     ```xml
     <dependencyManagement>
         <dependencies>
             <dependency>
                 <groupId>io.spring.platform</groupId>
                 <artifactId>platform-bom</artifactId>
                 <version>Brussels-SR4</version>
                 <type>pom</type>
                 <scope>import</scope>
             </dependency>
             <dependency>
                 <groupId>org.springframework.cloud</groupId>
                 <artifactId>spring-cloud-dependencies</artifactId>
                 <version>Dalston.SR2</version>
                 <type>pom</type>
                 <scope>import</scope>
             </dependency>
         </dependencies>
     </dependencyManagement>
     ```

   - 添加SpringSecurity相关依赖

     ```xml
     <!-- ★ SpringSecurity核心 -->
             <dependency>
                 <groupId>org.springframework.cloud</groupId>
                 <artifactId>spring-cloud-starter-security</artifactId>
             </dependency>
             <dependency>
                 <groupId>org.springframework.social</groupId>
                 <artifactId>spring-social-config</artifactId>
             </dependency>
     
     <!-- ★ SpringOAuth2 ： SpringSecurity OAuth2相关的依赖 -->
             <dependency>
                 <groupId>org.springframework.cloud</groupId>
                 <artifactId>spring-cloud-starter-oauth2</artifactId>
             </dependency>
     
     <!-- ★ SpringSocial : 第三方认证 -->
             <dependency>
                 <groupId>org.springframework.social</groupId>
                 <artifactId>spring-social-core</artifactId>
             </dependency>
             <dependency>
                 <groupId>org.springframework.social</groupId>
                 <artifactId>spring-social-security</artifactId>
             </dependency>
             <dependency>
                 <groupId>org.springframework.social</groupId>
                 <artifactId>spring-social-web</artifactId>
             </dependency>
     ```

2. 添加Security依赖后，项目会自动为项目启动安全校验（会有登录操作），启用|关闭security配置

   ```yaml
   security:
     basic:
       enabled: true | false
   ```

3. 添加Security配置文件

   ```java
   @Configuration
   public class SecurityWebConfig extends WebSecurityConfigurerAdapter {
       
       @Override
       protected void configure(HttpSecurity http) throws Exception {
       	
       }
       
   }
   ```
```
   
   - WebSecurityConfigurerAdapter：是Security提供的web应用的适配器配置类
   - configure(HttpSecurity http)：
   - configure(WebSecurity web)：
   - configure(AuthenticationManagerBuilder auth)：

## 1.2 Security中的默认设置

1. 默认的认证成功处理方式
   - 如果请求被认证拦截，security会跳转到登录页面，同时会记录本次引发跳转的URL，如果用户在登录页面完成认证操作，security会再次跳转到引发认证的URL上。
2. 默认的认证失败处理方式
   - Security认证失败会将认证失败信息交给SpringBoot处理，如果请求体中包含“text/html”，则返回SpringBoot默认的一个错误页面，其中包含了Security的认证失败信息。请求体中没有“text/html”，则返回json格式的认证失败信息。

# 第二章 SpringSecurity原理

## 2.1 Security常用过滤器类说明

1. <font size=4 color=red>**SecurityContextPersistenceFilter**</font>在每次请求处理之前将该请求相关的安全上下文信息加载到 SecurityContextHolder 中，然后在该次请求处理完成之后，将 SecurityContextHolder 中关于这次请求的信息存储到一个“仓储”中，然后将 SecurityContextHolder 中的信息清除，例如在Session中维护一个用户的安全信息就是这个过滤器处理的。

2. <font size=4 color=red>**BasicAuthenticationFilter：**</font>请求头的名称是<kbd>Authorization</kbd>，并且请求头前缀是<kbd>Basic </kbd>的请求

   - 配置登录方式是Basic

     ```java
     @Override
     protected void configure(HttpSecurity http) throws Exception {
     	http.httpBasic();
     }
```

3. <font size=4 color=red>**UsernamePasswordAuthenticationFilter：**</font>如果是表单登录会被这个过滤器拦截并校验

   - 配置Security的认证是表单登录

     ```java
     @Override
     protected void configure(HttpSecurity http) throws Exception {
     	http.formLogin();
     }
     ```

   - 判断是否是登录请求：默认是<kbd>POST /login</kbd>，获取请求中的默认登录参数：username 和 password

     ```java
     // 修改默认的登录请求
     @Override
     protected void configure(HttpSecurity http) throws Exception {
   		http.formLogin()
             .loginPage("修改登录请求URL,如果请求被认证拦截会跳转到这个请求中")
             .loginProcessingUrl("默认是/login交给过滤器处理,这里可以修改")
             .usernameParameter("修改请求参数：用户名,默认是username")
             .passwordParameter("修改请求参数：密码,默认是password");
     }
     ```
     
   - 通过定义认证的URL，扩展认证的方式：如果被认证拦截引发跳转的是html请求，则跳转到登录页面；如果被认证拦截引发跳转的是Rest请求，则返回json格式的认证响应，表示该请求需要认证；如下案例

     ```java
     // HttpSessionRequestCache 保存了请求的缓存
     private RequestCache cache = new HttpSessionRequestCache();
     
     // Security的工具 用作跳转
     private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
     
     @GetMapping(value = "/authentication/require")
     public ResponseResult requireAuthentication(HttpServletRequest request, HttpServletResponse response) throws IOException {
     
         SavedRequest savedRequest = cache.getRequest(request, response);
         if (null != savedRequest) {
             String target = savedRequest.getRedirectUrl();
             if (StringUtils.endsWithIgnoreCase(target, ".html")) {
                 redirectStrategy.sendRedirect(request, response, "登录页面");
             }
         }
         return ResponseResult.failure(ResponseCode.AUTHENTICATION_ERROR);
     }
     ```

4. <font size=4 color=red>**ExceptionTranslationFilter**</font>

5. <font size=4 color=red>**FilterSecurityInterceptor**</font>

## 1.2 Security认证信息相关类

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

6. <font size=4 color=red>**PasswordEncoder**</font>：设置密码加密方式，源码如下

   ```java
   public interface PasswordEncoder {
       // 获取加密后的字符串
       String encode(CharSequence rawPassword);
   
       // 这个方法是由Security框架调用
       boolean matches(CharSequence rawPassword, String encodedPassword);
   }
   ```

   - 如果要加密方式生效，需要将PasswordEncoder配置到Spring中

     ```java
     @Bean
     public PasswordEncoder passwordEncoder() {
         // BCryptPasswordEncoder是Security内置的加密实现
         return new BCryptPasswordEncoder();
     }
     ```

   - 如果Spring中有PasswordEncoder类型的bean，在进行用户密码匹配时候，就会调用matches方法
   
7. <font size=4 color=red>**PasswordEncoder**</font>：设置密码加密方式，源码如下

## 1.3 Security认证源码分析



## 1.4 Security其他工具

1. <font size=4 color=red>**RedirectStrategy：**</font>Security的跳转工具类

   ```java
   private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
   
   redirectStrategy.sendRedirect(request, response,target);
   ```

2. <font size=4 color=red>**自定义认证成功处理器**</font>替换Security默认的认证成功处理方式：

   - 自定义认证成功处理器类继承Security认证成功处理器

     - 默认的认证成功会跳转到引发认证的链接上去，如果是一个Rest异步请求触发的认证，他希望的返回值是json格式的认证信息，此时如果认证成功跳转到原来的Rest请求上就和需求不符；

     - 认证成功接口：AuthenticationSuccessHandler，可以获取到认证信息
     - 认证成功接口的子类：SavedRequestAwareAuthenticationSuccessHandler，提供的跳转功能

   - 用自定义认证成功处理器替换默认的认证成功处理器

     ```java
     @Override
     protected void configure(HttpSecurity http) throws Exception {
     	http.formLogin()
     		// ...
             .successHandler(Autowired 自定义成功处理器)
             // ...
     }  
     ```

3. <font size=4 color=red>**自定义认证失败处理器**</font>替换Security默认的认证失败处理器

   :dash: **自定义错误响应页面**

   - 自定义错误响应页面，在项目的根路径中新建`resources/error`的文件夹，新建错误码同名的html页面，SpringBoot如果响应的html格式的页面，则会先匹配`resources/error`中错误码对应的错误页面。

   :dash: **自定义认证失败处理器**

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


# 第二章 SpringSecurity认证扩展

## 2.1 图形验证码扩展用户名密码登录

1. 定义一个请求接口用于生成图形验证码

   - 可以生成随机数，并将随机数保存进Session；

   - 利用这个随机数生成图片响应到前台；

   - 重构图形验证码做到可配置

     > ① 验证码的基本参数可配置；
     >
     > ② 验证码的生成方式可配置，替换新的图片生成逻辑与方式；
     >
     > ③ 验证码拦截的请求可配置；

2. 定义校验图形验证码的过滤器

   - **OncePerRequestFilter** ：过滤器基类，旨在确保每个请求调度在任何servlet容器上执行一次执行。
   - 作用一：拦截配置中需要图形验证码的请求
   - 作用二：拦截请求后获取请求中的验证码值与session中的对比，验证通过则进行下一步用户名密码过滤

3. 将图形验证码添加的security认证过程中

   ```java
   @Override
   protected void configure(HttpSecurity http) throws Exception {
       ValidateCodeFilter validateCodeFilter = new ValidateCodeFilter();
       ...
   	http.addFilterBefore(validateCodeFilter, 
                            UsernamePasswordAuthenticationFilter.class)
           ...
   }
   ```

## 3.2 短信验证码登录新增认证方式

1. 定义一个发送短信验证码的接口

   - 发送的短信验证码保存在session中，用于在验证码校验时进行数据比对；

2. 新增Security的AuthenticationToken令牌

   - 继承AbstractAuthenticationToken，封装认证相关的数据

3. 新增Filter用于拦截需要认证的请求

   - 继承AbstractAuthenticationProcessingFilter类
   - 指定要拦截的请求，以及获取请求对应的参数封装在AuthenticationToken实例中交给AuthenticationManager，AuthenticationManager会将当前令牌交给对应的Provider进行校验

4. 新增AuthenticationToken令牌的Provider

   - 实现AuthenticationProvider接口
   - 设置当前Provider要处理的AuthenticationToken令牌类型
   - 接受到AuthenticationManager中的Authentication，获取其中的登录数据，调用UserDetailsService获取数据库用户信息，封装为已认证的Token；

5. 新增自定义Filter对当前认证方式进行校验你

6. 将Security认证相关的自定义类配置到Security中

   ```java
   public void configure(HttpSecurity http) throws Exception {
       http
       .authenticationProvider(authenticationProvider)
       .addFilterAfter(authenticationFilter, UsernamePasswordAuthenticationFilter.class);
   }
   ```

   > - 给Provider指定Manager
   > - 给Provider指定认证成功处理器和认证失败处理器
   > - 给AbstractFilter设置UserDetailsService

7. 将自定义过滤器添加的认证流程中

   ```java
   public void configure(HttpSecurity http) throws Exception {
       http
       .authenticationProvider(authenticationProvider)
       .addFilterBefore(validateSmsFilter, UsernamePasswordAuthenticationFilter.class)
       .addFilterAfter(authenticationFilter, UsernamePasswordAuthenticationFilter.class);
   }
   ```

# 第三章 Security权限设计

## 3.1 系统权限设计的说明

- 权限控制的本质：限定登录的用户是否可以访问系统中的资源

## 3.2 Security权限设置方式

### :dash: 设置是否认证

1. 方式一：在配置类中添加；示例：

   ```java
   public void configure(HttpSecurity http) throws Exception {
       http
       .antMatchers(HttpMethod.GET, "/test/config/not/login").permitAll()
       .antMatchers(HttpMethod.GET, "/test/config/login").authenticated()   
   }
   ```

   - permitAll()：权限表达式表示不需要认证
   - authenticated()：权限表达式表示已认证过才可以访问

2. 方式二：使用Security注解

   ```java
   @GetMapping(value = "URL")
   @PreAuthorize("permitAll()")
   public String test05() {
       ...
   }
   
   @GetMapping(value = "URL")
   @PreAuthorize(value = "isAuthenticated()")
   public String test06() {
       ...
   }
   ```

   - 配置类中的权限设置会优先于方法执行，所以配置中如果设置了所有请求都必须认证则会覆盖注解的配置

### :dash: 设置简单角色

1. 方式一：在配置类中添加；示例：

   ```java
   public void configure(HttpSecurity http) throws Exception {
       http
       .antMatchers(HttpMethod.GET, "/config/user1").hasRole("ADMIN") 
   }
   ```

   - hasRole("ADMIN")：权限表达式表示必须有ADMIN角色
   - antMatchers()：配置中的URL可以使用<kbd>*</kbd>作为路径通配符
   - Security对配置中的角色会主动为角色添加`ROLE_`前缀，所以如果要使用数据库保存的角色作为认证条件，需要给角色之前提前添加`ROLE_`前缀。

2. 方式二：使用Security注解

   ```java
   @GetMapping(value = "URL")
   @PreAuthorize("hasRole('ADMIN')")
   public String test01() {
       ...
   }
   ```

## 3.3 Security权限控制源码分析

<img src='./imgs/02_security权限源码'/>

###  :dash: 源码相关类说明

1. AnonymousAuthenticationFilter
   - 匿名认证过滤器，在认证相关过滤器的最后一个；
   - 判断SecurityContext中是否有Authentication，如果没有则新增一个匿名用户保存到SecurityContext中
2. FilterSecurityInterceptor
   - 接收服务请求并将请求数据封装为AuthenticationToken对象；
3. SecurityConfig
   - 读取Security配置类，将配置中权限相关数据封装为ConfigAttribute对象；
   - ConfigAttribute是一个Map：key是配置文件中的URL；value是配置URL对应的权限表达式
4. SecurityContextHolder：
   - 根据请求中的用户账号查询的数据库中的用户完整的权限信息；
5. AssessDecisionManager接口
   - 有一个抽象类和三个实现类；
   - 接收ConfigAttribute、Authentication、服务请求三份信息，进行权限判断；
   - 管理着一组AssessDecisionVoter（投票者），根据投票的者的结果，使用具体的管理策略给出最终的结果，默认使用的策略是有个通过则认证通过；
     - AffirmativeBased：有一个投过则认证通过
     - ConsensusBased：通过和不通过谁多谁说的算
     - UnanimousBased：有一个投不过则认证不通过
6. AccessDecisionVoter
   - 投票者，在SpringSecurity3.1后被WebExpressionVoter（权限表达式投票者）代替了；

## 3.4 权限表达式

1. 常用表达式

   | 表达式                       | 说明                                              |
   | ---------------------------- | ------------------------------------------------- |
   | permitAll                    | 永远返回True                                      |
   | denyAll                      | 永远返回False                                     |
   | anonymous                    | 当前用户是anonymous时返回True                     |
   | rememberMe                   | 当前用户是rememberMe用户时返回True                |
   | authenticated                | 当前用户不是anonymous时返回True                   |
   | fullAuthenticated            | 当前用户既不是anonymous也不是rememberMe时返回True |
   | hasRole(role)                | 当前用户拥有指定角色时候返回True                  |
   | hasAnyRole([role1,role2...]) | 当前用户拥有任意一个角色时候返回True              |
   | hasAuthority(authority)      | 当前用户拥有指定权限时候返回True                  |
   | hasAnyAuthority(authority)   | 当前用户拥有任意一个权限时候返回True              |
   | hasAddress('IP')             | 请求发送的IP符合是返回True                        |

2. 基于URL权限表达式：要使用两个权限表达式，则需要通过access()方法

   ```java
   // 需要具有ROLE_USER角色才能访问
   .antMatchers("/user/**").hasAnyRole("USER") 
       
   // 需要具有ROLE_ADMIN和ROLE_USER角色才能访问
   .antMatchers("/admin/**").access("hasAnyRole('ADMIN') and hasAnyRole('USER')") 
   ```

3. 基于RBAC数据模型控制权限

   ```java
   @Component("rbacService")
   public class RbacServiceImpl implements RbacService {
       
       private AntPathMatcher antPathMatcher = new AntPathMatcher();
       
       @Override
       public boolean hasPermission(HttpServletRequest re, Authentication au) {
           Object o = au.getPrincipal();
           if (o instanceof UserDetails) {
               String username = ((UserDetails)o).getUsername();
               // 读取用户拥有的资源
               Set<String> urls = new HashSet<>();
               urls.add("/admin/**");
               // 判断用户是否拥有资源
               for (String url : urls) {
                   if (antPathMatcher.match(url, re.getRequestURI())) {
                       return true;
                   }
               }
           }
           return false;
       }
   }
   ```

   ```java
   .anyRequest().access("@rbacService.hasPermission(request, authentication)")
   ```

4. 基于方法的控制表达式

   - 开启使用方法注解的配置

     ```java
     @Configuration
     @EnableWebSecurity
     @EnableGlobalMethodSecurity(prePostEnabled = true)
     public class SpringSecurityConfig extends WebSecurityConfigurerAdapter {
     	...
     }
     ```

   - 四种方法注解:@PreAuthorize、@PostAuthorize、@PreFilter和、PostFilter

     - @PreAuthorize 注解适合进入方法前的权限验证

       ```java
       @PreAuthorize("hasRole('ROLE_ADMIN')")
       @PreAuthorize("hasAnyRole('ROLE_ADMIN') and principal.username.equals('#id')")
       
       @GetMapping("/test/{id}")
       ```

     - @PostAuthorize 在方法执行后再进行权限验证,适合验证带有返回值的权限

       ```java
       // returnObject表示方法返回值
       @PostAuthorize("returnObject.username.equals(principal.username)")
       public Object demo2() {
           ...
       	return user;
       }
       ```

     - @PreFilter可以对集合类型的参数进行过滤

     - @PostFilter可以对集合类型返回值进行过滤，

# 第四章 基于REAC的动态权限案例

## 4.1 基于权限表达式

1. 定义标准接口，指定标准参数

   ```java
   public interface RbacService {
       boolean hasPermission(HttpServletRequest request, Authentication authentication);
   }
   ```

2. 定义实现类

   ```java
   import cn.hutool.core.util.StrUtil;
   import com.example.janche.common.exception.CustomException;
   import com.example.janche.common.restResult.ResultCode;
   import com.example.janche.user.dao.UserMapper;
   import com.example.janche.user.domain.MenuRight;
   import com.example.janche.user.dto.UserDTO;
   import com.google.common.collect.ArrayListMultimap;
   import com.google.common.collect.Multimap;
   import lombok.extern.slf4j.Slf4j;
   import org.springframework.beans.factory.annotation.Autowired;
   import org.springframework.security.core.Authentication;
   import org.springframework.security.core.userdetails.UserDetails;
   import org.springframework.security.web.util.matcher.AntPathRequestMatcher;
   import org.springframework.stereotype.Component;
   import org.springframework.web.method.HandlerMethod;
   import org.springframework.web.servlet.mvc.condition.RequestMethodsRequestCondition;
   import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;
   
   import javax.annotation.Resource;
   import javax.servlet.http.HttpServletRequest;
   import java.util.List;
   import java.util.Map;
   import java.util.Set;
   import java.util.stream.Collectors;
   
   /**
    * @author lirong
    * @ClassName: JwtAuthenticationFilter
    * @Description: Jwt 认证过滤器
    * @date 2019-07-12 9:50
    */
   @Slf4j
   @Component
   public class RbacAuthorityService implements RbacService{
       @Autowired
       private SecurityUserService userDetails;
   
       @Autowired
       private RequestMappingHandlerMapping mapping;
   
       public boolean hasPermission(HttpServletRequest request, Authentication authentication) {
           checkRequest(request);
   
           Object userInfo = authentication.getPrincipal();
           boolean hasPermission = false;
   
           if (userInfo instanceof UserDetails) {
               SecurityUser principal = (SecurityUser) userInfo;
               SecurityUser userDTO = (SecurityUser) this.userDetails.loadUserByUsername(principal.getUsername());
   
               //获取资源，前后端分离，所以过滤页面权限，只保留按钮权限
               List<MenuRight> btnPerms = userDTO.getMenus().stream()
                       // 过滤页面权限
                       .filter(menuRight -> menuRight.getGrades() >= 3)
                       // 过滤 URL 为空
                       .filter(menuRight -> StrUtil.isNotBlank(menuRight.getUrl()))
                       // 过滤 METHOD 为空
                       .collect(Collectors.toList());
               for (MenuRight btnPerm : btnPerms) {
                   AntPathRequestMatcher antPathMatcher = new AntPathRequestMatcher(btnPerm.getUrl(), btnPerm.getMethod());
                   if (antPathMatcher.matches(request)) {
                       hasPermission = true;
                       break;
                   }
               }
   
               return hasPermission;
           } else {
               return false;
           }
       }
   
       /**
        * 校验请求是否存在
        *
        * @param request 请求
        */
       private void checkRequest(HttpServletRequest request) {
           // 获取当前 request 的方法
           String currentMethod = request.getMethod();
           Multimap<String, String> urlMapping = allUrlMapping();
   
           for (String uri : urlMapping.keySet()) {
               // 通过 AntPathRequestMatcher 匹配 url
               // 可以通过 2 种方式创建 AntPathRequestMatcher
               // 1：new AntPathRequestMatcher(uri,method) 这种方式可以直接判断方法是否匹配，因为这里我们把 方法不匹配 自定义抛出，所以，我们使用第2种方式创建
               // 2：new AntPathRequestMatcher(uri) 这种方式不校验请求方法，只校验请求路径
               AntPathRequestMatcher antPathMatcher = new AntPathRequestMatcher(uri);
               if (antPathMatcher.matches(request)) {
                   if (!urlMapping.get(uri)
                           .contains(currentMethod)) {
                       throw new CustomException(ResultCode.HTTP_BAD_METHOD);
                   } else {
                       return;
                   }
               }
           }
   
           throw new CustomException(ResultCode.REQUEST_NOT_FOUND);
       }
   
       /**
        * 获取 所有URL Mapping，返回格式为{"/test":["GET","POST"],"/sys":["GET","DELETE"]}
        *
        * @return {@link ArrayListMultimap} 格式的 URL Mapping
        */
       private Multimap<String, String> allUrlMapping() {
           Multimap<String, String> urlMapping = ArrayListMultimap.create();
   
           // 获取url与类和方法的对应信息
           Map<RequestMappingInfo, HandlerMethod> handlerMethods = mapping.getHandlerMethods();
   
           handlerMethods.forEach((k, v) -> {
               // 获取当前 key 下的获取所有URL
               Set<String> url = k.getPatternsCondition()
                       .getPatterns();
               RequestMethodsRequestCondition method = k.getMethodsCondition();
   
               // 为每个URL添加所有的请求方法
               url.forEach(s -> urlMapping.putAll(s, method.getMethods()
                       .stream()
                       .map(Enum::toString)
                       .collect(Collectors.toList())));
           });
   
           return urlMapping;
       }
   }
   ```
   
3. 将权限配置类对接到security权限表达式中

   ```java
   @Override
   protected void configure(HttpSecurity http) throws Exception {
   	http
       	...
       	.anyRequest()
      	 	.access("@rbacAuthorityService.hasPermission(request,authentication)")
           ...
   }
   ```

   