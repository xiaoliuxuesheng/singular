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

   [^①]:是自定义在脚注















