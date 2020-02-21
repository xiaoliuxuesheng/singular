# 前言



# 支持CORS跨域访问

## ① CORS

- CORS（Cross-Origin Resource Sharing）"跨域资源共享"，是一个W3C标准，它允许浏览器向跨域服务器发送Ajax请求，打破了Ajax只能访问本站内的资源限制

## ② 跨域的配置

- 添加CORS的配置信息:继承**WebMvcConfiugrationAdaper**父类并且重写了**addCorsMappings**方法

    ```java
    @Configuration
    public class CorsConfig implements WebMvcConfigurer {
    
        @Override
        public void addCorsMappings(CorsRegistry registry) {
            registry
                .addMapping("/**")    	// 允许跨域访问的路径
            	.allowedOrigins("*")    // 允许跨域访问的源
            	.allowedMethods("POST", "GET", "PUT", "OPTIONS", "DELETE")    // 允许请求方法
            	.allowedHeaders("*")  	// 允许头部设置
            	.allowCredentials(true) // 是否发送cookie
            	.maxAge(168000);	    // 预检间隔时间
        }
    }
    ```

    - **addMapping**：配置可以被跨域的路径，可以任意配置，可以具体到直接请求路径。
    - **allowedOrigins**：允许所有的请求域名访问我们的跨域资源，可以固定单条或者多条内容，如："http://www.baidu.com"，只有百度可以访问我们的跨域资源。
    - **allowedMethods**：允许所有的请求方法访问该跨域资源服务器，如：**POST、GET、PUT、DELETE**等。
    - **allowedHeaders**：允许所有的请求header访问，可以自定义设置任意请求头信息，如："X-YAUTH-TOKEN"
    - **allowCredentials** ：允许发送cookie
    - **maxAge** ：预检间隔时间

## ③ 使用自定义拦截器时跨域相关配置就会失效

- 原因是请求经过的先后顺序问题，当请求到来时会先进入拦截器中，而不是进入Mapping映射中，所以返回的头信息中并没有配置的跨域信息。浏览器就会报跨域异常。

    > - 请求进入DispatcherServlet过滤器，最终的函数执行在doDispatch()这个方法中
    >
    >     1. 根据请求request获取执行器链，先判断request是否是预检请求，是预检请求则生成个预检执行器PreFlightHandler，然后在doDispatch函数中执行；
    >         否则生成一个跨域拦截器加入拦截器链中，最终再doDispatch函数处执行，而因为拦截器是顺序执行的，如果前面执行失败异常返回后，后面的则不再执行。
    >         所以当跨越请求在拦截器那边处理后就异常返回了，那么响应的response报文头部关于跨域允许的信息就没有被正确设置，导致浏览器认为服务不允许跨域，而造成错误；而当我们使用过滤器时，过滤器先于拦截器执行，那么无论是否被拦截，始终有允许跨域的头部信息，就不会出问题了。
    >
    >         ```java
    >         protected HandlerExecutionChain 
    >         getCorsHandlerExecutionChain(HttpServletRequest request,
    >                                      HandlerExecutionChain chain, 
    >                                      CorsConfiguration config) {
    >         
    >             if (CorsUtils.isPreFlightRequest(request)) {
    >                 HandlerInterceptor[] interceptors = chain.getInterceptors();
    >                 chain = new HandlerExecutionChain(new PreFlightHandler(config), interceptors);
    >             }else {
    >                 chain.addInterceptor(new CorsInterceptor(config));
    >             }
    >             return chain;
    >         }
    >         ```
    >
    >     2. 根据Handler获取handlerAdapter；
    >
    >     3. 执行执行器链中的拦截方法（preHandle）
    >
    >     4. 执行handler方法；
    >
    >     5. 执行执行器链中的拦截方法（postHandle）；

- 方案1：使用Spring-Web自带的CorsFilter

    ```java
    private CorsConfiguration corsConfig() {
        CorsConfiguration corsConfiguration = new CorsConfiguration();
    	//请求常用的三种配置，*代表允许所有，当时你也可以自定义属性:如header只能带什么，只能是post方式等等）
        corsConfiguration.addAllowedOrigin("*");
        corsConfiguration.addAllowedHeader("*");
        corsConfiguration.addAllowedMethod("*");
        corsConfiguration.setAllowCredentials(true);
        corsConfiguration.setMaxAge(3600L);
        return corsConfiguration;
    }
    @Bean
    public CorsFilter corsFilter() {
        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", corsConfig());
        return new CorsFilter(source);
    }
    ```

- 方案2：自己实现Interceptor

    ```java
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
       if (request.getHeader(HttpHeaders.ORIGIN) != null) {
            response.addHeader("Access-Control-Allow-Origin", "*");
            response.addHeader("Access-Control-Allow-Credentials", "true");
            response.addHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE, PUT, HEAD");
            response.addHeader("Access-Control-Allow-Headers", "Content-Type");
            response.addHeader("Access-Control-Max-Age", "3600");
       }
       return true;
    }
    ```

- 方案3：增强自定义Interceptor

    ```java
    @Around(value = "cut()")
    public Object processTx(ProceedingJoinPoint jp) throws Throwable {
       HttpServletRequest request = (HttpServletRequest) jp.getArgs()[0];
       if (request != null && CorsUtils.isPreFlightRequest(request)) {
           return true;
       } else {
           return jp.proceed();
       }
    }
    ```


# SpringBoot属性配置文件

1. 定义属性配置文件

   ```java
   @Configuration
   @EnableConfigurationProperties(SecurityPropertiesConfig.class)
   ```

   - @EnableConfigurationProperties作用：使使用 @ConfigurationProperties 注解的类生效。

2. 定义属性封装类：@ConfigurationProperties

   ```java
   @Setter
   @Getter
   @Component
   @ConfigurationProperties(prefix = "panda.security")
   public class SecurityPropertiesConfig {
       
   }
   ```

3. 在配置文件中指定属性

   ```yaml
   panda:
     security:
       browser:
         loginPage: /demo_login_page.html
   ```

4. 添加属性自动提示依赖：和属性配置文件放在同一组件

   ```xml
   <dependency>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-configuration-processor</artifactId>
       <optional>true</optional>
   </dependency>
   ```

   