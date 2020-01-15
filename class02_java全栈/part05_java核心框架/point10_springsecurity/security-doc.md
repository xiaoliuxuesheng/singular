# BasicAuthenticationFilter

- 处理HTTP请求头中的Authorization信息，把认证结果写入SecurityContextHolder
    - 当请求头中包含一个Authorization的参数，并且参数格式是 **basic xxx**的字符串，则会被改过滤器处理，其中xxx部分是base64编码的认证信息
    - 该过滤器会解析Authorization得到用户名和免然后调用AuthenticationManager进行认证，认证成功会把认证结果写入到`SecurityContextHolder`中SecurityContext的属性authentication上面
    - 如果头部分析失败，该过滤器会抛出异常BadCredentialsException。会清除SecurityContextHolder中的SecurityContext。并且不再继续`filter chain`的执行。

# Security认证流程

- 登陆请求是经过一系列过滤器链

    1. 表单登陆首先经过UsernamePasswordAuthenticationFilter

        - 用用户名和密码构建了UsernamePasswordAuthenticationToken对象是Authentication接口的一个实现

            ```java
            new UsernamePasswordAuthenticationToken(username, password);
            super((Collection)null);   		// 首次登陆还没有权限
            this.principal = principal;		// 账号
            this.credentials = credentials;	// 密码
            this.setAuthenticated(false);	// false表示未认证通过
            
            ```

        - this.setDetails(request, authRequest);  将请求相关信息设置到当前认证Token中

    2. AuthenticationManager : this.getAuthenticationManager().authenticate(authRequest);

        - manager不包含验证的逻辑,作用是管理AuthenticationProvider, 会收集所有的AuthenticationProvider,判断有没有provider支持当前登陆方式
        - authenticate()方法会进入到ProviderManager类中

    3. AuthenticationProvider的实现类ProviderManager

        - for循环会获取所有的AuthenticationProvider的实现类:真正的校验逻辑是写在AuthenticationProvider的实现中,不同的登陆方式认证逻辑是不一样的,调用Provider.support()方法是不是支持当前的Authentication类型(接口的实现类,在认证过滤器中传入的)

            ```java
            this.getAuthenticationManager().authenticate(authRequest); //这里传入的
            ```

        - provider.authenticate(authentication); 执行认证逻辑,抽象方法additionalAuthenticationChecks()完成认证

        - 由抽象类中AbstractUserDetailsAuthenticationProvider.authenticate实现,其中调用了this.retrieveUse()抽象方法,

        - 抽象方法是由子类DaoAuthenticationProvider实现,实现中也会调用this.getUserDetailsService().loadUserByUsername(username)方法,UserDetailsService接口封装了获取用户信息UserDetails的接口,

    4. UserDetailsService.是实现类中查询数据库,获取用户信息并封装为UserDetails对象或实现类User对象

    5. 认证成功

        - this.preAuthenticationChecks.check(user);  检查用户的三个Boolean值属性
        - this.additionalAuthenticationChecks  检查密码是否匹配
        - this.postAuthenticationChecks.check  检查最后一个Boolean
        - this.createSuccessAuthentication 创建成功认证信息,重新new一个UsernamePasswordAuthenticationToken 最初的那个Token

    6. 返回Authentication对象,回到UsernamePasswordAuthenticationFilter,调动登陆成功处理器.如果认证出现异常被登陆失败异常处理器

    ## 认证的结果如何在多个请求中共享

    1. AbstractAuthenticationProcessingFilter过滤器在这个过滤器链的最前面,请求进来时候检查线程中是否有SecurityContext,有则放进中session中,出去时候检查session放进线程中,doFilter方法

        - 调用successfulAuthentication()方法,把认证成功的Authentication设置到SecurityContextHolder中

            ```java
            SecurityContextHolder.getContext().setAuthentication(authResult);
            ```

        - SecurityContext的实现类包装了Authentication

    2. SecurityContextHolder是ThreadLocal的一个封装,同一个线程级别的全局变量

    ## 获取用户信息SecurityContextHolder

    

    