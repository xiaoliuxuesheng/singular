# 6. 项目模块和依赖项

在Spring Security 3.0中，代码库被细分为独立的jar，更清晰地区分了不同的功能区域和第三方依赖。

# 7. 例子

- [地址](https://github.com/spring-projects/spring-security-samples/tree/5.5.1)

# 8. Hello Spring Security

## 8.1 添加依赖

## 8.2 开始以及SpringBoot的Security

- 运行项目控制台输出

  ```tex
  Using generated security password: 8e557245-73e2-4286-969a-ff57fe326336
  ```

## 8.3 SpringBoot 自动配置

Spring Boot 自启动

- 启用Spring Security的默认配置，它将创建一个名为springSecurityFilterChain的bean作为servlet过滤器。此bean负责应用程序中的所有安全性(保护应用程序url、验证提交的用户名和密码、重定向到登录表单，等等)。
- 创建一个UserDetailsService bean，该bean具有用户名user和随机生成的登录到控制台的密码。
- 为每个请求向Servlet容器注册一个名为springSecurityFilterChain的bean的过滤器

Spring Boot没有配置很多，但是它做了很多。功能概述如下:

- 与应用程序的任何交互都需要经过身份验证的用户
- 为您生成一个默认的登录表单
- 让用户名为user和密码的用户登录到控制台，使用基于表单的身份验证(在前面的示例中，密码为8e557245-73e2-4286-969a-ff57fe326336)
- 使用BCrypt保护密码存储
- 让用户退出
- CSRF攻击预防
- session固定保护
- 安全头集成
  - HTTP严格传输安全用于安全请求
  - X-Content-Type-Options集成
  - 缓存控制(稍后可以被应用程序覆盖，以允许缓存静态资源)
  - X-XSS-Protection集成
  - X-Frame-Options集成，帮助防止点击劫持
- 与以下Servlet API方法集成:
  - [`HttpServletRequest#getRemoteUser()`](https://docs.oracle.com/javaee/6/api/javax/servlet/http/HttpServletRequest.html#getRemoteUser())
  - [`HttpServletRequest.html#getUserPrincipal()`](https://docs.oracle.com/javaee/6/api/javax/servlet/http/HttpServletRequest.html#getUserPrincipal())
  - [`HttpServletRequest.html#isUserInRole(java.lang.String)`](https://docs.oracle.com/javaee/6/api/javax/servlet/http/HttpServletRequest.html#isUserInRole(java.lang.String))
  - [`HttpServletRequest.html#login(java.lang.String, java.lang.String)`](https://docs.oracle.com/javaee/6/api/javax/servlet/http/HttpServletRequest.html#login(java.lang.String, java.lang.String))
  - [`HttpServletRequest.html#logout()`](https://docs.oracle.com/javaee/6/api/javax/servlet/http/HttpServletRequest.html#logout())

# 9. Servlet Security: 大背景

> 本节讨论Spring Security在基于Servlet的应用程序中的高层体系结构。我们在引用的Authentication、Authorization、Protection Against exploit部分中建立了这种高层次的理解。

## 9.1 Filter 概述

Spring Security的Servlet支持是基于Servlet过滤器的，所以首先看看过滤器的作用是很有帮助的。下图显示了单个HTTP请求的处理程序的典型分层。

<img src='https://docs.spring.io/spring-security/site/docs/current/reference/html5/images/servlet/architecture/filterchain.png'/>

客户端向应用程序发送请求，容器创建一个包含过滤器和Servlet的FilterChain，这些过滤器和Servlet应该基于请求URI的路径来处理HttpServletRequest。在Spring MVC应用程序中，Servlet是DispatcherServlet的一个实例。最多一个Servlet可以处理单个HttpServletRequest和HttpServletResponse。但是，可以使用多个Filter:

- 防止调用下游过滤器或Servlet。在这个实例中，过滤器通常会编写HttpServletResponse。
- 修改下游过滤器和Servlet使用的HttpServletRequest或HttpServletResponse

Filter的强大功能来自传递给它的FilterChain:因为Filter只影响下游的Filters和Servlet，所以调用每个Filter的顺序非常重要。

```java
public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) {
    // do something before the rest of the application
    chain.doFilter(request, response); // invoke the rest of the application
    // do something after the rest of the application
}
```

## 9.2 DelegatingFilterProxy

Spring提供了一个名为DelegatingFilterProxy的过滤器实现，它允许在Servlet容器的生命周期和Spring的ApplicationContext之间进行桥接。Servlet容器允许使用它自己的标准注册过滤器，但是它不知道Spring定义的bean。DelegatingFilterProxy可以通过标准的Servlet容器机制注册，但是可以将所有的工作委托给实现Filter的Spring Bean。

下面是DelegatingFilterProxy如何适应过滤器和FilterChain的图片。

<img src='https://docs.spring.io/spring-security/site/docs/current/reference/html5/images/servlet/architecture/delegatingfilterproxy.png'/>

De SecurityFilterChainlgatingFilterProxy从ApplicationContext查找Bean Filter0，然后调用Bean Filter0。DelegatingFilterProxy的伪代码如下所示。

```java
public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) {
    // Lazily get Filter that was registered as a Spring Bean
    // For the example in DelegatingFilterProxy delegate is an instance of Bean Filter0
    Filter delegate = getFilterBean(someBeanName);
    // delegate work to the Spring Bean
    delegate.doFilter(request, response);
}
```

DelegatingFilterProxy的另一个好处是它允许延迟查看Filter bean实例。这很重要，因为容器在启动之前需要注册Filter实例。然而，Spring通常使用一个ContextLoaderListener来加载Spring bean，这在需要注册Filter实例之后才会完成。

## 9.3 FilterChainProxy

Spring Security的Servlet支持包含在FilterChainProxy中。FilterChainProxy是Spring Security提供的一个特殊的过滤器，它允许通过SecurityFilterChain委托给许多Filter实例。由于FilterChainProxy是一个Bean，它通常被封装在DelegatingFilterProxy中。

<img  src='https://docs.spring.io/spring-security/site/docs/current/reference/html5/images/servlet/architecture/filterchainproxy.png'/>

## 9.4 SecurityFilterChain

SecurityFilterChain被FilterChainProxy用来确定应该为这个请求调用哪个Spring安全过滤器。

<img src='https://docs.spring.io/spring-security/site/docs/current/reference/html5/images/servlet/architecture/securityfilterchain.png'/>

SecurityFilterChain中的安全过滤器通常是bean，但是它们注册在FilterChainProxy而不是DelegatingFilterProxy上。FilterChainProxy为直接注册Servlet容器或DelegatingFilterProxy提供了许多优势。首先，它为所有Spring Security的Servlet支持提供了一个起点。因此，如果您试图排除Spring Security的Servlet支持，那么在FilterChainProxy中添加一个调试点是一个很好的开始。

第二，由于FilterChainProxy是Spring安全使用的中心，它可以执行一些不是可选的任务。例如，它清除SecurityContext以避免内存泄漏。它还应用Spring Security的HttpFirewall来保护应用程序免受某些类型的攻击。

此外，它在确定何时应该调用SecurityFilterChain方面提供了更多的灵活性。在Servlet容器中，只根据URL调用过滤器。然而，FilterChainProxy可以通过利用RequestMatcher接口来根据HttpServletRequest中的任何内容来确定调用。

事实上，FilterChainProxy可以用来确定应该使用哪个SecurityFilterChain。这允许为应用程序的不同部分提供完全独立的配置。

<img src='https://docs.spring.io/spring-security/site/docs/current/reference/html5/images/servlet/architecture/multi-securityfilterchain.png'/>

> 在Multiple SecurityFilterChain图中，FilterChainProxy决定应该使用哪个SecurityFilterChain。只有第一个匹配的SecurityFilterChain将被调用。如果请求一个/api/messages/的URL，它将首先匹配SecurityFilterChain0的/api/**模式，所以只有SecurityFilterChain0将被调用，即使它也匹配SecurityFilterChainn。如果请求的URL是/messages/，它将不匹配SecurityFilterChain0的/api/**模式，所以FilterChainProxy将继续尝试每个SecurityFilterChain。假设没有其他的SecurityFilterChain实例

注意，SecurityFilterChain0只配置了三个安全过滤器实例。然而，SecurityFilterChainn配置了四个安全过滤器。需要注意的是，每个SecurityFilterChain都可以是唯一的，并且可以独立配置。事实上，如果应用程序希望Spring security忽略某些请求，那么SecurityFilterChain可能没有安全过滤器。

## 9.5 Security Filters

安全过滤器通过SecurityFilterChain API插入到FilterChainProxy中。过滤器的顺序很重要。通常不需要知道Spring Security过滤器的顺序。然而，有时知道顺序是有益的

下面是Spring Security Filter排序的综合列表:

- ChannelProcessingFilter
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
- [`UsernamePasswordAuthenticationFilter`](https://docs.spring.io/spring-security/site/docs/current/reference/html5/#servlet-authentication-usernamepasswordauthenticationfilter)
- OpenIDAuthenticationFilter
- DefaultLoginPageGeneratingFilter
- DefaultLogoutPageGeneratingFilter
- ConcurrentSessionFilter
- [`DigestAuthenticationFilter`](https://docs.spring.io/spring-security/site/docs/current/reference/html5/#servlet-authentication-digest)
- BearerTokenAuthenticationFilter
- [`BasicAuthenticationFilter`](https://docs.spring.io/spring-security/site/docs/current/reference/html5/#servlet-authentication-basic)
- RequestCacheAwareFilter
- SecurityContextHolderAwareRequestFilter
- JaasApiIntegrationFilter
- RememberMeAuthenticationFilter
- AnonymousAuthenticationFilter
- OAuth2AuthorizationCodeGrantFilter
- SessionManagementFilter
- [`ExceptionTranslationFilter`](https://docs.spring.io/spring-security/site/docs/current/reference/html5/#servlet-exceptiontranslationfilter)
- [`FilterSecurityInterceptor`](https://docs.spring.io/spring-security/site/docs/current/reference/html5/#servlet-authorization-filtersecurityinterceptor)
- SwitchUserFilter

## 9.6 Security异常处理

ExceptionTranslationFilter允许将AccessDeniedException和AuthenticationException转换为HTTP响应。

ExceptionTranslationFilter作为一个安全过滤器被插入到FilterChainProxy中

<img src='https://docs.spring.io/spring-security/site/docs/current/reference/html5/images/servlet/architecture/exceptiontranslationfilter.png'/>

> 1. 首先，ExceptionTranslationFilter调用FilterChain。doFilter(请求、响应)来调用应用程序的其余部分
> 2. 如果用户未经过身份验证或是AuthenticationException，则启动身份验证。
>    - 清除SecurityContextHolder
>    - HttpServletRequest保存在RequestCache中。当用户成功通过身份验证时，将使用RequestCache重放原始请求。
>    - AuthenticationEntryPoint用于从客户端请求凭据。例如，它可能重定向到一个登录页面或发送一个WWW-Authenticate头。
> 3. 否则，如果是AccessDeniedException，则拒绝访问。调用AccessDeniedHandler来处理拒绝访问。
> 4. 如果应用程序没有抛出AccessDeniedException或AuthenticationException，那么ExceptionTranslationFilter不会做任何事情。

ExceptionTranslationFilter的伪代码如下所示:

```java
try {
    filterChain.doFilter(request, response); 
} catch (AccessDeniedException | AuthenticationException ex) {
    if (!authenticated || ex instanceof AuthenticationException) {
        startAuthentication(); 
    } else {
        accessDenied(); 
    }
}
```

> 1. 您将从调用FilterChain的过滤器回顾中回忆起。doFilter(请求、响应)相当于调用应用程序的其余部分。
>
>    这意味着如果应用程序的另一部分(如FilterSecurityInterceptor或方法安全性)抛出AuthenticationException或AccessDeniedException，它将在这里被捕获和处理。
>
> 2. 如果用户未经过身份验证或是AuthenticationException，则启动身份验证。
>
> 3. 否则,拒绝访问

# 10 Authentication

- 架构组件
  - SecurityContextHolder - SecurityContextHolder是Spring Security存储身份验证的详细信息的地方。
  - SecurityContext - 从SecurityContextHolder中获取，包含当前认证用户的Authentication信息。
  - Authentication - 可以是AuthenticationManager的输入，以提供用户已提供的用于身份验证的凭据，也可以是来自SecurityContext的当前用户。
  - GrantedAuthority - 在身份验证上授予主体的授权(即角色、范围等)。
  - AuthenticationManager - 定义Spring Security的过滤器如何执行身份验证的API。
  - ProviderManager - AuthenticationManager最常见的实现。
  - AuthenticationProvider - 由ProviderManager用于执行特定类型的身份验证。
  - Request Credentials with AuthenticationEntryPoint - 用于从客户端请求凭证(即重定向到一个登录页面，发送一个WWW-Authenticate响应，等等)。
  - AbstractAuthenticationProcessingFilter - 用于身份验证的基本过滤器。这还可以很好地了解高层次的身份验证流程以及各个部分如何协同工作。
- 用户认证机制
  - Username and Password - 使用用户名/密码进行身份验证
  - OAuth 2.0 Login - OAuth 2.0登录使用OpenID连接和非标准的OAuth 2.0登录(例如GitHub)
  - SAML 2.0 Login - SAML 2.0 Login
  - Central Authentication Server (CAS) - Central Authentication Server (CAS)支持
  - Remember Me -如何记住用户会话过期
  - JAAS Authentication - JAAS Authentication
  - OpenID - OpenID身份验证(不要与OpenID连接混淆)
  - Pre-Authentication Scenarios  - 使用外部机制(如SiteMinder或Java EE安全性)进行身份验证，但仍然使用Spring security进行授权和保护，以防止常见攻击。
  - X509 Authentication - X509 Authentication

## 10.1 SecurityContextHolder

Spring Security的身份验证模型的核心是SecurityContextHolder。它包含SecurityContext。

<img src = 'https://docs.spring.io/spring-security/site/docs/current/reference/html5/images/servlet/authentication/architecture/securitycontextholder.png'/>

SecurityContextHolder是Spring Security存储身份验证的详细信息的地方。Spring Security并不关心SecurityContextHolder是如何填充的。如果它包含一个值，那么它就被用作当前经过身份验证的用户。

指示用户身份验证的最简单方法是直接设置SecurityContextHolder

```java
SecurityContext context = SecurityContextHolder.createEmptyContext(); 
Authentication authentication =
    new TestingAuthenticationToken("username", "password", "ROLE_USER"); 
context.setAuthentication(authentication);

SecurityContextHolder.setContext(context); 
```

> 1. 我们首先创建一个空的SecurityContext。重要的是要创建一个新的SecurityContext实例，而不是使用securitycontexthholder . getcontext (). setauthentication(身份验证)，以避免多线程之间的竞争条件。
> 2. 接下来，我们创建一个新的Authentication对象。Spring Security并不关心在SecurityContext上设置了什么类型的身份验证实现。这里我们使用TestingAuthenticationToken，因为它非常简单。更常见的生产场景是UsernamePasswordAuthenticationToken(userDetails、密码、权限)。
> 3. 最后，我们在SecurityContextHolder上设置SecurityContext。Spring Security将使用此信息进行授权。

如果希望获得关于经过身份验证的主体的信息，可以通过访问SecurityContextHolder来实现。

```java
SecurityContext context = SecurityContextHolder.getContext();
Authentication authentication = context.getAuthentication();
String username = authentication.getName();
Object principal = authentication.getPrincipal();
Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();
```

默认情况下，SecurityContext使用ThreadLocal来存储这些详细信息，这意味着SecurityContext对于同一个线程中的方法总是可用的，即使SecurityContext没有显式地作为参数传递给这些方法。以这种方式使用ThreadLocal是相当安全的，如果在处理当前主体的请求后小心地清除线程。Spring Security的FilterChainProxy确保SecurityContext总是被清除。

有些应用程序并不完全适合使用ThreadLocal，因为它们处理线程的特定方式。例如，Swing客户机可能希望Java虚拟机中的所有线程都使用相同的安全上下文。SecurityContextHolder可以在启动时配置一个策略，以指定您希望如何存储上下文。对于独立的应用程序，您将使用SecurityContextHolder。MODE_GLOBAL策略。其他应用程序可能希望安全线程生成的线程也采用相同的安全标识。这是通过使用securitycontext实现的

## 10.2 SecurityContext

SecurityContext从SecurityContextHolder中获取。SecurityContext包含一个Authentication对象。

## 10.3 Authentication

在Spring Security中，身份验证有两个主要目的:

- AuthenticationManager的输入，用于提供用户为进行身份验证而提供的凭据。在此场景中使用时，isAuthenticated()返回false。
- 表示当前通过身份验证的用户。当前的认证可以从SecurityContext中获取。

Authentication 包含属性

- principal  - 识别用户。当使用用户名/密码进行身份验证时，这通常是UserDetails的一个实例。
- credentials  - 通常一个密码。在许多情况下，这将在用户身份验证后清除，以确保不会泄漏。
- authorities - GrantedAuthority为用户被授予的高级权限。一些例子是角色或作用域。

## 10.4 GrantedAuthority

GrantedAuthority可以从authentication . getaauthorys()方法获得。此方法提供了一个GrantedAuthority对象集合。GrantedAuthority是授予主体的权限，这并不奇怪。这样的权限通常是“角色”，例如ROLE_ADMINISTRATOR或ROLE_HR_SUPERVISOR。稍后将为web授权、方法授权和域对象授权配置这些角色。Spring Security的其他部分能够解释这些权限，并期望它们存在。当使用基于用户名/密码的认证时授予

通常，GrantedAuthority对象是应用程序范围的权限。它们不是特定于给定的域对象。因此，您不太可能拥有一个GrantedAuthority来表示对Employee对象编号54的权限，因为如果有数千个这样的权限，您将很快耗尽内存(或者至少导致应用程序花很长时间来验证用户)。当然，Spring Security是专门设计来处理这一常见需求的，但是您可以使用项目的域对象安全功能来实现这一目的。

## 10.5 AuthenticationManager

AuthenticationManager是定义Spring Security的过滤器如何执行身份验证的API。然后，调用AuthenticationManager的控制器(即Spring Security的Filterss)在SecurityContextHolder上设置返回的身份验证。如果你没有集成Spring Security的过滤器，你可以直接设置SecurityContextHolder，而不需要使用AuthenticationManager。

虽然AuthenticationManager的实现可以是任何东西，但最常见的实现是ProviderManager。

## 10.6 ProviderManager

ProviderManager是AuthenticationManager最常用的实现。ProviderManager委托给AuthenticationProviders列表。每个AuthenticationProvider都有机会表明身份验证应该是成功的，失败的，或者表明它不能做出决定，并允许下游的AuthenticationProvider来做出决定。如果配置的AuthenticationProviders中没有一个可以进行身份验证，那么身份验证将失败，并会出现ProviderNotFoundException异常，这是一个特殊的AuthenticationException，指示ProviderManager没有被配置为支持类型

<img  src='https://docs.spring.io/spring-security/site/docs/current/reference/html5/images/servlet/authentication/architecture/providermanager.png'/>

实际上，每个AuthenticationProvider都知道如何执行特定类型的身份验证。例如，一个AuthenticationProvider可能能够验证用户名/密码，而另一个AuthenticationProvider可能能够验证SAML断言。这允许每个AuthenticationProvider执行特定类型的身份验证，同时支持多种类型的身份验证，并且只公开一个AuthenticationManager bean。

ProviderManager还允许配置一个可选的父AuthenticationManager，当AuthenticationProvider不能执行身份验证时，会咨询该父AuthenticationManager。父类可以是任何类型的AuthenticationManager，但它通常是ProviderManager的一个实例。

<img src='https://docs.spring.io/spring-security/site/docs/current/reference/html5/images/servlet/authentication/architecture/providermanager-parent.png'/>

事实上，多个ProviderManager实例可能共享相同的父AuthenticationManager。这在多个SecurityFilterChain实例具有某些共同身份验证(共享的父类AuthenticationManager)和不同身份验证机制(不同的ProviderManager实例)的场景中有些常见。

<img src='https://docs.spring.io/spring-security/site/docs/current/reference/html5/images/servlet/authentication/architecture/providermanagers-parent.png'/>

默认情况下，ProviderManager将尝试从成功的身份验证请求返回的Authentication对象中清除任何敏感凭据信息。这可以防止密码等信息在HttpSession中保留的时间超过必要时间。

当您使用用户对象的缓存(例如，在无状态应用程序中提高性能)时，这可能会导致问题。如果Authentication包含对缓存中的对象(如UserDetails实例)的引用，并且该引用已删除其凭证，那么将不再可能根据缓存的值进行身份验证。如果您正在使用缓存，则需要考虑到这一点。一个明显的解决方案是，首先在缓存实现中或在创建返回的Authentication对象的AuthenticationProvider中复制一个对象。或者，您可以禁用ProviderManager上的eraseCredentialsAfterAuthentication属性。更多信息请参见Javadoc。

## 10.7 AuthenticationProvider

多个AuthenticationProviders可以被注入到ProviderManager中。每个AuthenticationProvider执行特定类型的身份验证。例如，DaoAuthenticationProvider支持基于用户名/密码的身份验证，而JwtAuthenticationProvider支持验证JWT令牌

## 10.8 Request Credentials with AuthenticationEntryPoint

AuthenticationEntryPoint用于发送HTTP响应，该响应从客户端请求凭据。

有时，客户端会主动包含用户名/密码等凭据来请求资源。在这些情况下，Spring Security不需要提供从客户机请求凭据的HTTP响应，因为它们已经包含在内。

在其他情况下，客户端将向未被授权访问的资源发出未经身份验证的请求。在本例中，AuthenticationEntryPoint的实现用于从客户端请求凭据。AuthenticationEntryPoint实现可能执行重定向到一个登录页面，响应一个WWW-Authenticate头，等等。

## 10.9 AbstractAuthenticationProcessingFilter

AbstractAuthenticationProcessingFilter被用作验证用户凭据的基本过滤器。在验证凭据之前，Spring Security通常使用AuthenticationEntryPoint请求凭据。

*：*接下来，AbstractAuthenticationProcessingFilter可以验证提交给它的任何身份验证请求。

<img src='https://docs.spring.io/spring-security/site/docs/current/reference/html5/images/servlet/authentication/architecture/abstractauthenticationprocessingfilter.png'/>

> 1. 当用户提交他们的凭据时，AbstractAuthenticationProcessingFilter从HttpServletRequest创建一个身份验证来进行身份验证。创建的身份验证类型依赖于AbstractAuthenticationProcessingFilter的子类。例如，UsernamePasswordAuthenticationFilter从HttpServletRequest中提交的用户名和密码创建UsernamePasswordAuthenticationToken。
> 2. 接下来，将身份验证传递给AuthenticationManager进行身份验证
> 3. 如果身份验证失败，则失败
>    - 清除SecurityContextHolder。
>    - RememberMeServices。loginFail被调用。如果我还没配置好，这是不可能的。
>    - AuthenticationFailureHandler被调用。
> 4. 如果身份验证成功，则Success。
>    - SessionAuthenticationStrategy会在新登录时得到通知。
>    - 认证在SecurityContextHolder上设置。稍后，securitycontextpersistencfilter将SecurityContext保存到HttpSession。
>    - RememberMeServices。loginSuccess被调用。如果我还没配置好，这是不可能的。
>    - ApplicationEventPublisher发布一个InteractiveAuthenticationSuccessEvent。
>    - *：*AuthenticationSuccessHandler被调用。

## 10.10 Username/Password Authentication

验证用户身份的最常见方法之一是验证用户名和密码。因此，Spring Security提供了对使用用户名和密码进行身份验证的全面支持。

Spring Security提供了以下内置机制来从HttpServletRequest读取用户名和密码:

- 登录表单
- 基本认证
- 摘要式身份验证

赋存机制 - 每种受支持的读取用户名和密码的机制都可以利用任何受支持的存储机制:

- 简单的存储与内存认证
- 使用JDBC身份验证的关系数据库
- 使用UserDetailsService自定义数据存储
- LDAP存储与LDAP认证

#### 10.10.1  Form Login

Spring Security支持通过html表单提供用户名和密码。本节详细介绍基于表单的身份验证如何在Spring Security中工作。

让我们看看基于表单的登录是如何在Spring Security中工作的。首先，我们将看到如何将用户重定向到登录表单。

<img src='https://docs.spring.io/spring-security/site/docs/current/reference/html5/images/servlet/authentication/unpwd/loginurlauthenticationentrypoint.png'/>

> 该图构建了我们的SecurityFilterChain图。
>
> 1. 首先，用户向未授权的资源/私有发出未经身份验证的请求
> 2. Spring Security的FilterSecurityInterceptor通过抛出AccessDeniedException来拒绝未经身份验证的请求。
> 3. 由于用户没有经过身份验证，ExceptionTranslationFilter将启动Start Authentication并发送一个重定向到配置了AuthenticationEntryPoint的登录页面。在大多数情况下，AuthenticationEntryPoint是LoginUrlAuthenticationEntryPoint的一个实例。
> 4. 然后，浏览器将请求被重定向到的登录页面。
> 5. 应用程序内的某些东西必须呈现登录页面。

提交用户名和密码后，UsernamePasswordAuthenticationFilter将对用户名和密码进行验证。UsernamePasswordAuthenticationFilter扩展了AbstractAuthenticationProcessingFilter，所以这个图看起来应该很相似。

<img src='https://docs.spring.io/spring-security/site/docs/current/reference/html5/images/servlet/authentication/unpwd/usernamepasswordauthenticationfilter.png'/>

> 该图构建了我们的SecurityFilterChain图。
>
> 1. 当用户提交他们的用户名和密码时，UsernamePasswordAuthenticationFilter通过从HttpServletRequest中提取用户名和密码创建UsernamePasswordAuthenticationToken，这是一种身份验证类型。
>
> 2. 接下来，将UsernamePasswordAuthenticationToken传递到AuthenticationManager中进行身份验证。AuthenticationManager的详细信息取决于用户信息的存储方式。
>
> 3. 如果身份验证失败，则失败
>
>    - ... ...
>
> 4. 如果身份验证成功，则Success
>
>    - ... ...
>
>    - authenticationsuccessshandler被调用。通常这是一个SimpleUrlAuthenticationSuccessHandler，当我们重定向到登录页面时，它将重定向到ExceptionTranslationFilter保存的请求

Spring Security表单登录在默认情况下是启用的。但是，只要提供了任何基于servlet的配置，就必须显式地提供基于表单的登录。一个最小的、显式的Java配置可以在下面找到:

```java
protected void configure(HttpSecurity http) {
    http
        // ...
        .formLogin(withDefaults());
}
```

> 在这个配置中，Spring Security将呈现一个默认的登录页面。大多数生产应用程序都需要一个自定义的登录表单。

下面的配置演示了如何在表单中提供自定义日志。

```java
protected void configure(HttpSecurity http) throws Exception {
    http
        // ...
        .formLogin(form -> form
            .loginPage("/login")
            .permitAll()
        );
}
```

> 当在Spring Security配置中指定登录页面时，您将负责呈现该页面。下面是一个Thymeleaf模板，它生成一个HTML登录表单，符合/login登录页面:
>
> ```html
> <!DOCTYPE html>
> <html xmlns="http://www.w3.org/1999/xhtml" xmlns:th="https://www.thymeleaf.org">
>     <head>
>         <title>Please Log In</title>
>     </head>
>     <body>
>         <h1>Please Log In</h1>
>         <div th:if="${param.error}">
>             Invalid username and password.</div>
>         <div th:if="${param.logout}">
>             You have been logged out.</div>
>         <form th:action="@{/login}" method="post">
>             <div>
>             <input type="text" name="username" placeholder="Username"/>
>             </div>
>             <div>
>             <input type="password" name="password" placeholder="Password"/>
>             </div>
>             <input type="submit" value="Log in" />
>         </form>
>     </body>
> </html>
> ```
>
> 关于默认HTML表单有几个关键点:
>
> 1. 表单应该执行到/login的发帖
> 2. 该表单将需要包括一个CSRF令牌，由Thymeleaf自动包含。
> 3. 表单应该在名为username的参数中指定用户名
> 4. 表单应该在名为password的参数中指定密码
> 5. 如果发现HTTP参数error，则表示用户未能提供有效的用户名/密码
> 6. 如果查询到HTTP参数logout，则表示用户注销成功

许多用户只需要定制登录页面。但是，如果需要的话，上面的一切都可以通过额外的配置进行定制。

如果您正在使用Spring MVC，您将需要一个控制器，将GET /login映射到我们创建的登录模板。LoginController的最小示例如下:

```java
@Controller
class LoginController {
    @GetMapping("/login")
    String login() {
        return "login";
    }
}
```

#### 10.10.2 Basic Authentication

让我们看看HTTP基本身份验证是如何在Spring Security中工作的。首先，我们看到WWW-Authenticate头被发回给一个未经过身份验证的客户端。

<img src='https://docs.spring.io/spring-security/site/docs/current/reference/html5/images/servlet/authentication/unpwd/basicauthenticationentrypoint.png'/>

> 1. 首先，用户向未授权的资源/私有发出未经身份验证的请求。
> 2. Spring Security的FilterSecurityInterceptor通过抛出AccessDeniedException来拒绝未经身份验证的请求。
> 3. 由于用户没有经过身份验证，ExceptionTranslationFilter将启动启动身份验证。配置的AuthenticationEntryPoint是一个BasicAuthenticationEntryPoint的实例，它发送一个WWW-Authenticate报头。RequestCache通常是一个不保存请求的NullRequestCache，因为客户机能够重放它最初请求的请求。

当客户端接收到WWW-Authenticate报头时，它知道应该用用户名和密码重试。下面是正在处理的用户名和密码的流程。

<img src='https://docs.spring.io/spring-security/site/docs/current/reference/html5/images/servlet/authentication/unpwd/basicauthenticationfilter.png'/>

> 1. *：*当用户提交他们的用户名和密码时，BasicAuthenticationFilter通过从HttpServletRequest中提取用户名和密码来创建UsernamePasswordAuthenticationToken，这是一种身份验证类型。
> 2. 接下来，将UsernamePasswordAuthenticationToken传递到AuthenticationManager中进行身份验证。AuthenticationManager的详细信息取决于用户信息的存储方式。
> 3. 如果身份验证失败，则失败
> 4. 如果身份验证成功，则Success。

默认情况下，Spring Security的HTTP基本身份验证支持是启用的。但是，只要提供了任何基于servlet的配置，就必须显式地提供HTTP Basic。

一个最小的，显式的配置可以找到如下:

```java
protected void configure(HttpSecurity http) {
    http
        // ...
        .httpBasic(withDefaults());
}
```

####  10.10.3 Digest Authentication

本节详细介绍Spring Security如何提供摘要身份验证支持，摘要身份验证是由DigestAuthenticationFilter提供的。

> 您不应该在现代应用程序中使用摘要身份验证，因为它被认为不安全。最明显的问题是必须以明文、加密或MD5格式存储密码。所有这些存储格式都是不安全的。相反，您应该使用单向自适应密码散列(即bCrypt, PBKDF2, SCrypt等)存储凭证，这是摘要认证不支持的。

#### 10.10.4 In-Memory Authenticatio

Spring Security的InMemoryUserDetailsManager实现了UserDetailsService，以支持在内存中检索的基于用户名/密码的身份验证。InMemoryUserDetailsManager通过实现UserDetailsManager接口来提供对UserDetails的管理。当Spring Security配置为接受用户名/密码进行身份验证时，将使用基于UserDetails的身份验证。

在这个示例中，我们使用Spring Boot CLI对password的密码进行编码，并获得编码后的密码{bcrypt}$2a$10$GRLdNijSQMUvl/au9ofL.eDwmoohzzS7.rmNSJZ.0FxO/BTk76klW。

```java
@Bean
public UserDetailsService users() {
    UserDetails user = User.builder()
        .username("user")
        .password("{bcrypt}$2a$10$GRLdNijSQMUvl/au9ofL.eDwmoohzzS7.rmNSJZ.0FxO/BTk76klW")
        .roles("USER")
        .build();
    UserDetails admin = User.builder()
        .username("admin")
        .password("{bcrypt}$2a$10$GRLdNijSQMUvl/au9ofL.eDwmoohzzS7.rmNSJZ.0FxO/BTk76klW")
        .roles("USER", "ADMIN")
        .build();
    return new InMemoryUserDetailsManager(user, admin);
}
```

> 上面的示例以安全的格式存储密码，但在入门经验方面还有很多不足之处。

在下面的示例中，我们利用了User。withDefaultPasswordEncoder来确保存储在内存中的密码是受保护的。但是，它不能通过反编译源代码来防止获得密码。出于这个原因，用户。withDefaultPasswordEncoder应该只用于“开始”，而不是用于生产。

```java
@Bean
public UserDetailsService users() {
    // The builder will ensure the passwords are encoded before saving in memory
    UserBuilder users = User.withDefaultPasswordEncoder();
    UserDetails user = users
        .username("user")
        .password("password")
        .roles("USER")
        .build();
    UserDetails admin = users
        .username("admin")
        .password("password")
        .roles("USER", "ADMIN")
        .build();
    return new InMemoryUserDetailsManager(user, admin);
}
```

没有简单的方法来使用User。withDefaultPasswordEncoder基于XML的配置。对于演示或刚刚开始，您可以选择在密码前加上{noop}，以表示不应该使用编码。

*：*<user-service> {noop} XML配置

```xml
<user-service>
    <user name="user"
        password="{noop}password"
        authorities="ROLE_USER" />
    <user name="admin"
        password="{noop}password"
        authorities="ROLE_USER,ROLE_ADMIN" />
</user-service>
```

#### 10.10.5  JDBC Authentication

Spring Security的JdbcDaoImpl实现了UserDetailsService来提供对使用JDBC检索的基于用户名/密码的身份验证的支持。JdbcUserDetailsManager扩展了JdbcDaoImpl，通过UserDetailsManager接口提供对UserDetails的管理。当Spring Security配置为接受用户名/密码进行身份验证时，将使用基于UserDetails的身份验证。

在下面的章节中，我们将讨论:

- Spring安全JDBC身份验证使用的默认模式
- 设置数据源
- JdbcUserDetailsManager bean

**Default Schema**

Spring Security为基于JDBC的身份验证提供默认查询。本节提供与默认查询相对应的默认模式。您将需要调整模式，以匹配与您正在使用的查询和数据库方言相匹配的定制。

**User Schema**

JdbcDaoImpl需要表来加载用户的密码、帐户状态(启用或禁用)和权限(角色)列表。需要的默认模式可以在下面找到。默认模式也公开为一个名为org/springframework/security/core/userdetails/jdbc/users.ddl的类路径资源。

- Default User Schema

  ```sql
  create table users(
      username varchar_ignorecase(50) not null primary key,
      password varchar_ignorecase(500) not null,
      enabled boolean not null
  );
  
  create table authorities (
      username varchar_ignorecase(50) not null,
      authority varchar_ignorecase(50) not null,
      constraint fk_authorities_users foreign key(username) references users(username)
  );
  create unique index ix_auth_username on authorities (username,authority);
  ```

- Oracle是一种流行的数据库选择，但是需要略微不同的模式。您可以在下面找到用于用户的默认Oracle Schema。

  ```sql
  CREATE TABLE USERS (
      USERNAME NVARCHAR2(128) PRIMARY KEY,
      PASSWORD NVARCHAR2(128) NOT NULL,
      ENABLED CHAR(1) CHECK (ENABLED IN ('Y','N') ) NOT NULL
  );
  
  
  CREATE TABLE AUTHORITIES (
      USERNAME NVARCHAR2(128) NOT NULL,
      AUTHORITY NVARCHAR2(128) NOT NULL
  );
  ALTER TABLE AUTHORITIES ADD CONSTRAINT AUTHORITIES_UNIQUE UNIQUE (USERNAME, AUTHORITY);
  ALTER TABLE AUTHORITIES ADD CONSTRAINT AUTHORITIES_FK1 FOREIGN KEY (USERNAME) REFERENCES USERS (USERNAME) ENABLE;
  ```

**Group Schema**

如果您的应用程序利用组，您将需要提供组模式。组的默认模式可以在下面找到。

```sql
create table groups (
    id bigint generated by default as identity(start with 0) primary key,
    group_name varchar_ignorecase(50) not null
);

create table group_authorities (
    group_id bigint not null,
    authority varchar(50) not null,
    constraint fk_group_authorities_group foreign key(group_id) references groups(id)
);

create table group_members (
    id bigint generated by default as identity(start with 0) primary key,
    username varchar(50) not null,
    group_id bigint not null,
    constraint fk_group_members_group foreign key(group_id) references groups(id)
);
```

**Setting up a DataSource**

在配置JdbcUserDetailsManager之前，必须创建一个数据源。在我们的示例中，我们将设置一个使用默认用户模式初始化的嵌入式数据源

```java
@Bean
DataSource dataSource() {
    return new EmbeddedDatabaseBuilder()
        .setType(H2)
        .addScript("classpath:org/springframework/security/core/userdetails/jdbc/users.ddl")
        .build();
}
```

> 在生产环境中，您将希望确保建立到外部数据库的连接。

**JdbcUserDetailsManager Bean**

在这个示例中，我们使用Spring Boot CLI对password的密码进行编码，并获得编码后的密码{bcrypt}$2a$10$GRLdNijSQMUvl/au9ofL.eDwmoohzzS7.rmNSJZ.0FxO/BTk76klW。有关如何存储密码的更多细节，请参阅PasswordEncoder一节。

#### 10.10.6. UserDetails

UserDetails由UserDetailsService返回。DaoAuthenticationProvider验证UserDetails，然后返回一个Authentication，该Authentication有一个主体，该主体是由已配置的UserDetailsService返回的UserDetails。

#### 10.10.7. UserDetailsService

DaoAuthenticationProvider使用UserDetailsService检索用户名、密码和其他属性，以验证用户名和密码。Spring Security提供了UserDetailsService的内存和JDBC实现。

您可以通过将自定义UserDetailsService公开为bean来定义自定义身份验证。例如，以下将自定义身份验证，假设CustomUserDetailsService实现了UserDetailsService:

> 只有当AuthenticationManagerBuilder没有被填充并且AuthenticationProviderBean没有被定义时才会使用。

```java
@Bean
CustomUserDetailsService customUserDetailsService() {
    return new CustomUserDetailsService();
}
```

#### 10.10.8. PasswordEncoder

Spring Security的servlet通过与PasswordEncoder集成来支持安全存储密码。定制Spring Security使用的PasswordEncoder实现可以通过公开PasswordEncoder Bean来完成

####  10.10.9. DaoAuthenticationProvider

DaoAuthenticationProvider是一个AuthenticationProvider实现，它利用UserDetailsService和PasswordEncoder来验证用户名和密码。

让我们看看DaoAuthenticationProvider是如何在Spring Security中工作的。图中解释了读取用户名和密码中的AuthenticationManager如何工作的细节。

<img src='https://docs.spring.io/spring-security/site/docs/current/reference/html5/images/servlet/authentication/unpwd/daoauthenticationprovider.png'/>

> 1. 读取用户名和密码的身份验证过滤器将UsernamePasswordAuthenticationToken传递给AuthenticationManager，这是由ProviderManager实现的。
> 2. ProviderManager被配置为使用DaoAuthenticationProvider类型的AuthenticationProvider。
> 3. DaoAuthenticationProvider从UserDetailsService中查找UserDetails。
> 4. 然后，DaoAuthenticationProvider使用PasswordEncoder验证上一步返回的UserDetails上的密码。
> 5. 当身份验证成功时，返回的身份验证类型为UsernamePasswordAuthenticationToken，并且具有一个主体，该主体是由已配置的UserDetailsService返回的UserDetails。最终，返回的UsernamePasswordAuthenticationToken将由身份验证过滤器在SecurityContextHolder上设置。

#### 10.10.10. LDAP Authentication

LDAP经常被组织用作用户信息的中心存储库和身份验证服务。它还可以用于存储应用程序用户的角色信息。

当Spring Security被配置为接受用户名/密码进行身份验证时，Spring Security将使用基于LDAP的身份验证。但是，尽管利用用户名/密码进行身份验证，但它并没有使用UserDetailsService集成，因为在绑定身份验证中，LDAP服务器没有返回密码，因此应用程序不能执行密码验证。

对于如何配置LDAP服务器，有许多不同的场景，因此Spring Security的LDAP提供者是完全可配置的。它使用单独的策略接口进行身份验证和角色检索，并提供可以配置为处理各种情况的缺省实现。

**预备知识**

在尝试将LDAP与Spring Security一起使用之前，您应该熟悉LDAP。下面的链接很好地介绍了相关的概念，并提供了使用免费LDAP服务器OpenLDAP设置目录的指南:https://www.zytrax.com/books/ldap/。熟悉一些用于从Java访问LDAP的JNDI api可能也很有用。我们在LDAP提供程序中没有使用任何第三方LDAP库(Mozilla、JLDAP等)，但是Spring LDAP得到了广泛的使用，所以如果您计划添加自己的自定义，对该项目有所了解可能会有所帮助。

在使用LDAP身份验证时，一定要确保正确配置LDAP连接池。如果您不熟悉如何做到这一点，可以参考Java LDAP文档。

**设置嵌入式LDAP服务器**

您需要做的第一件事是确保有一个LDAP Server来指向您的配置。为简单起见，最好从嵌入式LDAP Server开始。Spring Security支持使用以下任意一种:

- 嵌入式UnboundID服务器
- 嵌入式ApacheDS服务器

在下面的示例中，我们将以下内容作为用户公开。ldif作为类路径资源来初始化嵌入的LDAP服务器，其中用户user和admin的密码都是password。

```

```

**嵌入式UnboundID服务器**

如果你想使用UnboundID，请指定以下依赖项:

```xml
<dependency>
    <groupId>com.unboundid</groupId>
    <artifactId>unboundid-ldapsdk</artifactId>
    <version>4.0.14</version>
    <scope>runtime</scope>
</dependency>
```

然后可以配置嵌入式LDAP服务器

```java
@Bean
UnboundIdContainer ldapContainer() {
    return new UnboundIdContainer("dc=springframework,dc=org",
                "classpath:users.ldif");
}
```

**嵌入式ApacheDS服务器**

> Spring Security使用ApacheDS 1。X不再保持。不幸的是,ApacheDS 2。X只发布了里程碑版本，没有稳定的版本。一旦ApacheDS 2稳定发布。X有了，我们会考虑更新

如果你想使用Apache DS，那么指定以下依赖项:

```xml
<dependency>
    <groupId>org.apache.directory.server</groupId>
    <artifactId>apacheds-core</artifactId>
    <version>1.5.5</version>
    <scope>runtime</scope>
</dependency>
<dependency>
    <groupId>org.apache.directory.server</groupId>
    <artifactId>apacheds-server-jndi</artifactId>
    <version>1.5.5</version>
    <scope>runtime</scope>
</dependency>
```

然后可以配置嵌入式LDAP服务器

```java
@Bean
ApacheDSContainer ldapContainer() {
    return new ApacheDSContainer("dc=springframework,dc=org",
                "classpath:users.ldif");
}
```

**LDAP ContextSource**



# 12 OAuth2

## 12.1 OAuth2 登陆

OAuth2.0 登陆特性提供一个应用程序：这个特性的能力可以使允许用户在OAuth 2.0提供商(如GitHub)或OpenID Connect 1.0提供商(如谷歌)上使用现有帐户登录应用程序的能力，OAuth 2.0登录实现了用例:“用谷歌登录”或“用GitHub登录”。

> 在OAuth 2.0授权框架和OpenID Connect Core 1.0中，使用授权码授权来实现OAuth 2.0登录。

### 12.1.1 Spring Boot 2.x 样例

为OAuth 2.0 Login带来了完全的自动配置功能。

本节展示如何配置使用谷歌作为认证提供者的OAuth 2.0登录样例，包括以下主题:

- 初始设置
- 设置重定向URI
- 配置application.yml
- 启动应用程序

#### 初始设置

要使用谷歌的OAuth 2.0认证系统登录，必须在谷歌API Console中建立一个项目来获取OAuth 2.0凭据。

> 谷歌的认证OAuth 2.0实现符合OpenID Connect 1.0规范，是OpenID认证的。

按照OpenID连接页面上的说明，从“设置OAuth 2.0”一节开始。

完成“获取OAuth 2.0凭据”指令后，您应该拥有一个新的OAuth客户端，其中包含一个客户端ID和一个客户端秘密凭据。

#### 设置重定向URI

重定向URI是应用程序中的路径，最终用户的用户代理在通过谷歌的身份验证并在Consent页面上授予对OAuth客户端(在上一步中创建的)的访问权后被重定向回该路径。

在“Set a redirect URI”小节中，确保Authorized redirect URI字段设置为http://localhost:8080/login/oauth2/code/google。

> 默认的重定向URI模板是{baseUrl}/login/oauth2/code/{registrationId}。registrationId是ClientRegistration的唯一标识符。
>
> 如果OAuth Client运行在代理服务器后，建议检查代理服务器配置，以确保应用程序配置正确。另外，请参阅重定向URI支持的URI模板变量。

#### Configure application.yml

现在您有了一个带有谷歌的新OAuth客户端，您需要配置应用程序以使用OAuth客户端进行身份验证。这样做:

1. 去应用。Yml，设置如下配置:

   ```YAML
   spring:
     security:
       oauth2:
         client:
           registration:
             github:
               client-id: bf0e6f788e19b270cbf7
               client-secret: 50d9565199fd4e2467530c91c6859473c070dd7f
   ```

   > 基本属性前缀后面是ClientRegistration的ID，例如谷歌。

2. 用前面创建的OAuth 2.0凭据替换client-id和client-secret属性中的值。

#### 启动应用程序

启动Spring Boot 2。X样本，请登录http://localhost:8080。然后，您将被重定向到自动生成的默认登录页面，该页面显示了谷歌的链接。

单击谷歌链接，然后将被重定向到谷歌进行身份验证。

验证您的谷歌帐户凭据后，呈现给您的下一页是同意屏幕。Consent屏幕要求您允许或拒绝访问您先前创建的OAuth客户端。单击“允许”授权OAuth客户端访问您的电子邮件地址和基本配置文件信息。

此时，OAuth客户端从UserInfo端点检索您的电子邮件地址和基本配置文件信息，并建立一个经过身份验证的会话。

### 12.1.2 Spring boot2.0 属性映射

下表概述了Spring Boot 2的映射。x OAuth客户端属性到ClientRegistration属性 

> 通过指定spring.security.oauth2.client.provider.[providerId]，可以使用OpenID连接提供商的配置端点或授权服务器的元数据端点来初始化配置ClientRegistration。issuer-uri财产。

```yaml
spring:
  security:
    oauth2:
      client:
        registration:
          github:
            client-id: bf0e6f788e19b270cbf7
            client-secret: 50d9565199fd4e2467530c91c6859473c070dd7f
            client-authentication-method: clientAuthenticationMethod
            authorization-grant-type: authorizationGrantType
            redirect-uri: redirectUri
            scope: scope
            client-name: clientName
        provider:
          github:
            authorization-uri: authorizationUri
            token-uri: providerDetails.tokenUri
            jwk-set-uri: providerDetails.jwkSetUri
            issuer-uri: providerDetails.issuerUri
            user-info-uri: providerDetails.userInfoEndpoint.uri
            user-info-authentication-method: authenticationMethod
            user-name-attribute: userNameAttributeName
```

### 12.1.3 CommonOAuth2Provider

CommonOAuth2Provider为许多知名的提供商预先定义了一组默认的客户端属性:谷歌，GitHub, Facebook和Okta。

例如，Provider的授权uri、令牌uri和用户信息uri不经常更改。因此，提供默认值以减少所需的配置是有意义的。如前所述，在配置谷歌客户机时，只需要client-id和client-secret属性。

下面的清单显示了一个示例:

```yaml
spring:
  security:
    oauth2:
      client:
        registration:
          google:
            client-id: google-client-id
            client-secret: google-client-secret
```

> 客户端属性的自动默认值在这里无缝工作，因为registrationId(谷歌)匹配CommonOAuth2Provider中的谷歌enum(不区分大小写)。

对于可能希望指定不同的registrationId(如google-login)的情况，仍然可以通过配置provider属性来利用客户端属性的自动默认值。

```yaml
spring:
  security:
    oauth2:
      client:
        registration:
          google-login: 
            provider: google    
            client-id: google-client-id
            client-secret: google-client-secret
```

> 1. registrationId设置为google-login。
> 2. provider属性被设置为google，这将利用CommonOAuth2Provider.GOOGLE.getBuilder()中设置的客户端属性的自动默认值。

### 12.1.4 Configuring Custom Provider Properties

有一些OAuth 2.0提供者支持多租户，这导致每个租户(或子域)有不同的协议端点。例如，一个注册到Okta的OAuth客户端被分配到一个特定的子域，并且有自己的协议端点。

对于这些情况，Spring Boot 2。x提供了以下基本属性用于配置自定义提供程序属性:spring.security.oauth2.client.provider.[providerId]。

下面的清单显示了一个示例:

```yaml
spring:
  security:
    oauth2:
      client:
        registration:
          okta:
            client-id: okta-client-id
            client-secret: okta-client-secret
        provider:
          okta: 
            authorization-uri: https://your-subdomain.oktapreview.com/oauth2/v1/authorize
            token-uri: https://your-subdomain.oktapreview.com/oauth2/v1/token
            user-info-uri: https://your-subdomain.oktapreview.com/oauth2/v1/userinfo
            user-name-attribute: sub
            jwk-set-uri: https://your-subdomain.oktapreview.com/oauth2/v1/keys
```

> provider.okta: base属性允许对协议端点位置进行自定义配置。

### 12.1.5 覆盖Spring Boot 2.x自动配置

SpringBoot 2 支持OAuth Client的自动配置类是oauth2clienttautoconfiguration。

它执行以下任务:

1. 从配置的OAuth客户端属性注册一个由客户端注册组成的ClientRegistrationRepository @Bean。
2. 提供WebSecurityConfigurerAdapter @Configuration，并通过httpSecurity.oauth2Login()启用OAuth 2.0登录。

如果您需要根据您的具体需求覆盖自动配置，您可以采用以下方式:

1. 注册ClientRegistrationRepository @Bean
2. 提供一个WebSecurityConfigurerAdapter
3. 完全覆盖自动配置

#### 注册ClientRegistrationRepository @Bean

下面的例子展示了如何注册一个ClientRegistrationRepository @Bean:

```java
@Configuration
public class OAuth2LoginConfig {

    @Bean
    public ClientRegistrationRepository clientRegistrationRepository() {
        return new InMemoryClientRegistrationRepository(this.googleClientRegistration());
    }

    private ClientRegistration googleClientRegistration() {
        return ClientRegistration.withRegistrationId("google")
            .clientId("google-client-id")
            .clientSecret("google-client-secret")
            .clientAuthenticationMethod(ClientAuthenticationMethod.CLIENT_SECRET_BASIC)
            .authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
            .redirectUri("{baseUrl}/login/oauth2/code/{registrationId}")
            .scope("openid", "profile", "email", "address", "phone")
            .authorizationUri("https://accounts.google.com/o/oauth2/v2/auth")
            .tokenUri("https://www.googleapis.com/oauth2/v4/token")
            .userInfoUri("https://www.googleapis.com/oauth2/v3/userinfo")
            .userNameAttributeName(IdTokenClaimNames.SUB)
            .jwkSetUri("https://www.googleapis.com/oauth2/v3/certs")
            .clientName("Google")
            .build();
    }
}
```

#### 提供一个WebSecurityConfigurerAdapter

下面的例子展示了如何提供一个带有@EnableWebSecurity的WebSecurityConfigurerAdapter，并通过httpSecurity.oauth2Login()启用OAuth 2.0登录

```java
@EnableWebSecurity
public class OAuth2LoginSecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .authorizeRequests(authorize -> authorize
                .anyRequest().authenticated()
            )
            .oauth2Login(withDefaults());
    }
}
```

#### 完全覆盖自动配置

下面的示例展示了如何通过注册ClientRegistrationRepository @Bean并提供WebSecurityConfigurerAdapter来完全覆盖自动配置。

```java
@Configuration
public class OAuth2LoginConfig {

    @EnableWebSecurity
    public static class OAuth2LoginSecurityConfig extends WebSecurityConfigurerAdapter {

        @Override
        protected void configure(HttpSecurity http) throws Exception {
            http
                .authorizeRequests(authorize -> authorize
                    .anyRequest().authenticated()
                )
                .oauth2Login(withDefaults());
        }
    }

    @Bean
    public ClientRegistrationRepository clientRegistrationRepository() {
        return new InMemoryClientRegistrationRepository(this.googleClientRegistration());
    }

    private ClientRegistration googleClientRegistration() {
        return ClientRegistration.withRegistrationId("google")
            .clientId("google-client-id")
            .clientSecret("google-client-secret")
            .clientAuthenticationMethod(ClientAuthenticationMethod.CLIENT_SECRET_BASIC)
            .authorizationGrantType(AuthorizationGrantType.AUTHORIZATION_CODE)
            .redirectUri("{baseUrl}/login/oauth2/code/{registrationId}")
            .scope("openid", "profile", "email", "address", "phone")
            .authorizationUri("https://accounts.google.com/o/oauth2/v2/auth")
            .tokenUri("https://www.googleapis.com/oauth2/v4/token")
            .userInfoUri("https://www.googleapis.com/oauth2/v3/userinfo")
            .userNameAttributeName(IdTokenClaimNames.SUB)
            .jwkSetUri("https://www.googleapis.com/oauth2/v3/certs")
            .clientName("Google")
            .build();
    }
}
```

### 12.1.6 Java配置脱离Spring Boot 2.x

如果你不能使用Spring Boot 2。如果想要配置CommonOAuth2Provider(例如谷歌)中的一个预定义的提供程序，请应用以下配置:

```java
@Configuration
public class OAuth2LoginConfig {

    @EnableWebSecurity
    public static class OAuth2LoginSecurityConfig extends WebSecurityConfigurerAdapter {

        @Override
        protected void configure(HttpSecurity http) throws Exception {
            http
                .authorizeRequests(authorize -> authorize
                    .anyRequest().authenticated()
                )
                .oauth2Login(withDefaults());
        }
    }

    @Bean
    public ClientRegistrationRepository clientRegistrationRepository() {
        return new InMemoryClientRegistrationRepository(this.googleClientRegistration());
    }

    @Bean
    public OAuth2AuthorizedClientService authorizedClientService(
            ClientRegistrationRepository clientRegistrationRepository) {
        return new InMemoryOAuth2AuthorizedClientService(clientRegistrationRepository);
    }

    @Bean
    public OAuth2AuthorizedClientRepository authorizedClientRepository(
            OAuth2AuthorizedClientService authorizedClientService) {
        return new AuthenticatedPrincipalOAuth2AuthorizedClientRepository(authorizedClientService);
    }

    private ClientRegistration googleClientRegistration() {
        return CommonOAuth2Provider.GOOGLE.getBuilder("google")
            .clientId("google-client-id")
            .clientSecret("google-client-secret")
            .build();
    }
}
```

### 12.1.7 进阶配置

oauth2login()提供了许多用于定制OAuth 2.0登录的配置选项。主要配置选项被分组到对应的协议端点中。

例如，oauth2Login(). authorizationendpoint()允许配置授权端点，而oauth2Login(). tokenendpoint()允许配置Token端点。

下面的代码显示了一个示例:

```java
@EnableWebSecurity
public class OAuth2LoginSecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .oauth2Login(oauth2 -> oauth2
                .authorizationEndpoint(authorization -> authorization
                        ...
                )
                .redirectionEndpoint(redirection -> redirection
                        ...
                )
                .tokenEndpoint(token -> token
                        ...
                )
                .userInfoEndpoint(userInfo -> userInfo
                        ...
                )
            );
    }
}
```

oauth2Login() DSL的主要目标是与规范中定义的命名紧密一致。

OAuth 2.0授权框架定义了如下协议端点:

授权过程利用两个授权服务器端点(HTTP资源):

- Authorization Endpoint:由客户端使用，通过用户代理重定向从资源所有者获得授权。
- Token Endpoint: 由客户端用于交换访问令牌的授权授权，通常使用客户端身份验证。

以及一个客户端端点:

- Redirection Endpoint: 授权服务器用于通过资源所有者用户代理向客户机返回包含授权凭据的响应。

OpenID Connect Core 1.0规范定义UserInfo端点如下:

UserInfo端点是一个OAuth 2.0保护资源，它返回关于经过身份验证的最终用户的声明。为了获得所请求的关于最终用户的声明，客户端使用通过OpenID连接身份验证获得的访问令牌向UserInfo端点发出请求。这些声明通常由一个JSON对象表示，该对象包含声明的一组名称-值对。

下面的代码显示了oauth2Login() DSL的完整配置选项:

```java
@EnableWebSecurity
public class OAuth2LoginSecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .oauth2Login(oauth2 -> oauth2
                .clientRegistrationRepository(this.clientRegistrationRepository())
                .authorizedClientRepository(this.authorizedClientRepository())
                .authorizedClientService(this.authorizedClientService())
                .loginPage("/login")
                .authorizationEndpoint(authorization -> authorization
                    .baseUri(this.authorizationRequestBaseUri())
                    .authorizationRequestRepository(this.authorizationRequestRepository())
                    .authorizationRequestResolver(this.authorizationRequestResolver())
                )
                .redirectionEndpoint(redirection -> redirection
                    .baseUri(this.authorizationResponseBaseUri())
                )
                .tokenEndpoint(token -> token
                    .accessTokenResponseClient(this.accessTokenResponseClient())
                )
                .userInfoEndpoint(userInfo -> userInfo
                    .userAuthoritiesMapper(this.userAuthoritiesMapper())
                    .userService(this.oauth2UserService())
                    .oidcUserService(this.oidcUserService())
                )
            );
    }
}
```

除了oauth2Login() DSL之外，还支持XML配置。

以下代码显示了安全命名空间中可用的完整配置选项:

```xml
<http>
    <oauth2-login client-registration-repository-ref="clientRegistrationRepository"
                  authorized-client-repository-ref="authorizedClientRepository"
                  authorized-client-service-ref="authorizedClientService"
                  authorization-request-repository-ref="authorizationRequestRepository"
                  authorization-request-resolver-ref="authorizationRequestResolver"
                  access-token-response-client-ref="accessTokenResponseClient"
                  user-authorities-mapper-ref="userAuthoritiesMapper"
                  user-service-ref="oauth2UserService"
                  oidc-user-service-ref="oidcUserService"
                  login-processing-url="/login/oauth2/code/*"
                  login-page="/login"
                  authentication-success-handler-ref="authenticationSuccessHandler"
                  authentication-failure-handler-ref="authenticationFailureHandler"
                  jwt-decoder-factory-ref="jwtDecoderFactory"/>
</http>
```

下面的章节将详细介绍每个可用的配置选项:

- OAuth 2.0登录页面
- 重定向端点
- 用户信息端点

#### OAuth 2.0登录页面

默认情况下，OAuth 2.0登录页面由DefaultLoginPageGeneratingFilter自动生成。默认登录页面显示每个配置的OAuth客户端及其ClientRegistration。clientName作为一个链接，它能够发起授权请求(或OAuth 2.0登录)。

> 为了让DefaultLoginPageGeneratingFilter显示配置的OAuth客户端的链接，注册的ClientRegistrationRepository也需要实现Iterable<ClientRegistration>。参见InMemoryClientRegistrationRepository以获得参考。

每个OAuth客户端的链接目的地默认如下:`OAuth2AuthorizationRequestRedirectFilter.DEFAULT_AUTHORIZATION_REQUEST_BASE_URI + "/{registrationId}"`

下面一行显示了一个示例:

```xml
<a href="/oauth2/authorization/google">Google</a>
```

要覆盖默认登录页面，配置oauth2Login(). loginpage()和(可选)oauth2Login(). authorizationendpoint (). baseuri()。

下面的清单显示了一个示例:

```java
@EnableWebSecurity
public class OAuth2LoginSecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .oauth2Login(oauth2 -> oauth2
                .loginPage("/login/oauth2")
                ...
                .authorizationEndpoint(authorization -> authorization
                    .baseUri("/login/oauth2/authorization")
                    ...
                )
            );
    }
}
```

> 您需要为@Controller提供一个@RequestMapping("/login/oauth2")，它能够呈现自定义登录页面。

> 如前所述，配置oauth2Login(). authorizationendpoint (). baseuri()是可选的。但是，如果您选择自定义它，请确保到每个OAuth客户机的链接与authorizationEndpoint(). baseuri()匹配。
>
> 下面一行显示了一个示例:
>
> ```xml
> <a href="/login/oauth2/authorization/google">Google</a>
> ```

#### 重定向端点

授权服务器使用重定向端点通过资源所有者用户代理向客户机返回授权响应(其中包含授权凭证)。

> OAuth 2.0 Login利用了授权代码授权。因此，授权凭据就是授权码。

默认的授权响应baseUri(重定向端点)是/login/oauth2/code/*，它在OAuth2LoginAuthenticationFilter.DEFAULT_FILTER_PROCESSES_URI中定义。

如果你想自定义授权响应baseUri，按照下面的示例配置它:

```java
@EnableWebSecurity
public class OAuth2LoginSecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .oauth2Login(oauth2 -> oauth2
                .redirectionEndpoint(redirection -> redirection
                    .baseUri("/login/oauth2/callback/*")
                    ...
                )
            );
    }
}
```

> 您还需要确保ClientRegistration。redirectUri匹配自定义授权响应baseUri。
>
> 下面的清单显示了一个示例:
>
> ```java
> return CommonOAuth2Provider.GOOGLE.getBuilder("google")
>     .clientId("google-client-id")
>     .clientSecret("google-client-secret")
>     .redirectUri("{baseUrl}/login/oauth2/callback/{registrationId}")
>     .build();
> ```

#### 用户信息端点

UserInfo端点包括许多配置选项，如下面的小节所述:

- 映射用户部门
- OAuth 2.0 UserService
- OpenID连接1.0用户服务

##### 映射用户部门

当用户通过OAuth 2.0提供者成功验证后，oauth2user . getauthority()(或oidcuser . getauthority())可能会映射到一组新的grant authority实例，这些实例将在完成验证时提供给OAuth2AuthenticationToken。

> oauth2authenticationtoken . getauauthorities()用于授权请求，例如在hasRole('USER')或hasRole('ADMIN')中。

当映射用户权限时，有两个选项可供选择:

- 使用GrantedAuthoritiesMapper
- 使用OAuth2UserService的基于委托的策略

使用GrantedAuthoritiesMapper

提供一个grantedauthortiesmapper的实现，并按照下面的示例配置它:

```java
@EnableWebSecurity
public class OAuth2LoginSecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .oauth2Login(oauth2 -> oauth2
                .userInfoEndpoint(userInfo -> userInfo
                    .userAuthoritiesMapper(this.userAuthoritiesMapper())
                    ...
                )
            );
    }

    private GrantedAuthoritiesMapper userAuthoritiesMapper() {
        return (authorities) -> {
            Set<GrantedAuthority> mappedAuthorities = new HashSet<>();

            authorities.forEach(authority -> {
                if (OidcUserAuthority.class.isInstance(authority)) {
                    OidcUserAuthority oidcUserAuthority = (OidcUserAuthority)authority;

                    OidcIdToken idToken = oidcUserAuthority.getIdToken();
                    OidcUserInfo userInfo = oidcUserAuthority.getUserInfo();

                    // Map the claims found in idToken and/or userInfo
                    // to one or more GrantedAuthority's and add it to mappedAuthorities

                } else if (OAuth2UserAuthority.class.isInstance(authority)) {
                    OAuth2UserAuthority oauth2UserAuthority = (OAuth2UserAuthority)authority;

                    Map<String, Object> userAttributes = oauth2UserAuthority.getAttributes();

                    // Map the attributes found in userAttributes
                    // to one or more GrantedAuthority's and add it to mappedAuthorities

                }
            });

            return mappedAuthorities;
        };
    }
}
```

或者，你也可以注册一个grantedauthortiesmapper @Bean，让它自动应用到配置中，如下面的例子所示:

```java
@EnableWebSecurity
public class OAuth2LoginSecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .oauth2Login(withDefaults());
    }

    @Bean
    public GrantedAuthoritiesMapper userAuthoritiesMapper() {
        ...
    }
}
```

使用OAuth2UserService的基于委托的策略

与使用grant authortiesmapper相比，这种策略更先进，但是，它也更灵活，因为它允许你访问OAuth2UserRequest和OAuth2User(当使用OAuth 2.0 UserService时)或OidcUserRequest和OidcUser(当使用OpenID Connect 1.0 UserService时)。

OAuth2UserRequest(和OidcUserRequest)为您提供了对相关OAuth2AccessToken的访问，这在委托器需要从受保护资源中获取权限信息，然后才能为用户映射自定义权限的情况下非常有用。

下面的例子展示了如何使用OpenID Connect 1.0 UserService实现和配置基于委托的策略:

```java
@EnableWebSecurity
public class OAuth2LoginSecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .oauth2Login(oauth2 -> oauth2
                .userInfoEndpoint(userInfo -> userInfo
                    .oidcUserService(this.oidcUserService())
                    ...
                )
            );
    }

    private OAuth2UserService<OidcUserRequest, OidcUser> oidcUserService() {
        final OidcUserService delegate = new OidcUserService();

        return (userRequest) -> {
            // Delegate to the default implementation for loading a user
            OidcUser oidcUser = delegate.loadUser(userRequest);

            OAuth2AccessToken accessToken = userRequest.getAccessToken();
            Set<GrantedAuthority> mappedAuthorities = new HashSet<>();

            // TODO
            // 1) Fetch the authority information from the protected resource using accessToken
            // 2) Map the authority information to one or more GrantedAuthority's and add it to mappedAuthorities

            // 3) Create a copy of oidcUser but use the mappedAuthorities instead
            oidcUser = new DefaultOidcUser(mappedAuthorities, oidcUser.getIdToken(), oidcUser.getUserInfo());

            return oidcUser;
        };
    }
}
```

##### OAuth 2.0 UserService

DefaultOAuth2UserService是OAuth2UserService的一个实现，它支持标准的OAuth 2.0 Provider。

> OAuth2UserService从UserInfo端点获得最终用户(资源所有者)的用户属性(通过在授权流中使用授予客户端的访问令牌)，并以OAuth2User的形式返回AuthenticatedPrincipal。

当在UserInfo端点请求用户属性时，DefaultOAuth2UserService使用RestOperations。

## 12.2 OAuth2 客户端

OAuth 2.0客户端特性支持在OAuth 2.0授权框架中定义的客户端角色。在高层次上，可用的核心特性是:

- 授权给予支持
  - 授权代码
  - 刷新令牌
  - 客户端凭证
  - 资源所有者密码凭据
  - JWT Bearer
- 客户端身份验证的支持
  - JWT Bearer
- HTTP客户端支持
  - Servlet环境的集成(用于请求受保护的资源)

HttpSecurity.oauth2Client() DSL提供了许多配置选项，用于定制OAuth 2.0客户端使用的核心组件。另外，HttpSecurity.oauth2Client(). authorizationcodegrant()允许自定义授权代码授权。

下面的代码显示了HttpSecurity.oauth2Client() DSL提供的完整配置选项:

```java
@EnableWebSecurity
public class OAuth2ClientSecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    protected void configure(HttpSecurity http) throws Exception {
        http
            .oauth2Client(oauth2 -> oauth2
                .clientRegistrationRepository(this.clientRegistrationRepository())
                .authorizedClientRepository(this.authorizedClientRepository())
                .authorizedClientService(this.authorizedClientService())
                .authorizationCodeGrant(codeGrant -> codeGrant
                    .authorizationRequestRepository(this.authorizationRequestRepository())
                    .authorizationRequestResolver(this.authorizationRequestResolver())
                    .accessTokenResponseClient(this.accessTokenResponseClient())
                )
            );
    }
}
```

除了HttpSecurity.oauth2Client() DSL之外，还支持XML配置。以下代码显示了安全命名空间中可用的完整配置选项:

```xml
<http>
    <oauth2-client client-registration-repository-ref="clientRegistrationRepository"
                   authorized-client-repository-ref="authorizedClientRepository"
                   authorized-client-service-ref="authorizedClientService">
        <authorization-code-grant
                authorization-request-repository-ref="authorizationRequestRepository"
                authorization-request-resolver-ref="authorizationRequestResolver"
                access-token-response-client-ref="accessTokenResponseClient"/>
    </oauth2-client>
</http>
```

OAuth2AuthorizedClientManager负责管理OAuth 2.0客户端的授权(或重新授权)，与一个或多个OAuth2AuthorizedClientProvider(s)协作。

下面的代码演示了如何注册OAuth2AuthorizedClientManager @Bean，并将其与OAuth2AuthorizedClientProvider组合关联，该组合提供了对authorization_code、refresh_token、client_credentials和密码授权授权类型的支持:

```java
@Bean
public OAuth2AuthorizedClientManager authorizedClientManager(
        ClientRegistrationRepository clientRegistrationRepository,
        OAuth2AuthorizedClientRepository authorizedClientRepository) {

    OAuth2AuthorizedClientProvider authorizedClientProvider =
            OAuth2AuthorizedClientProviderBuilder.builder()
                    .authorizationCode()
                    .refreshToken()
                    .clientCredentials()
                    .password()
                    .build();

    DefaultOAuth2AuthorizedClientManager authorizedClientManager =
            new DefaultOAuth2AuthorizedClientManager(
                    clientRegistrationRepository, authorizedClientRepository);
    authorizedClientManager.setAuthorizedClientProvider(authorizedClientProvider);

    return authorizedClientManager;
}
```

下面几节将详细介绍OAuth 2.0客户端使用的核心组件和可用的配置选项:

- 核心接口/类
  - ClientRegistration - 新客户注册
  - ClientRegistrationRepository - 客户端注册库
  - OAuth2AuthorizedClient - OAuth2授权客户端
  - OAuth2AuthorizedClientRepository / OAuth2AuthorizedClientService - 授权客户端存储库/授权客户端服务
  - OAuth2AuthorizedClientManager / OAuth2AuthorizedClientProvider - 
- 授权给予支持
  - Authorization Code - 授权码
  - Refresh Token - 刷新令牌
  - Client Credentials - 客户端凭证
  - Resource Owner Password Credentials - 资源所有者密码凭据
  - JWT Bearer
- 客户端身份验证的支持
  - JWT Bearer
- 附加功能
  - 解析授权客户端
- 用于Servlet环境的WebClient集成

### 12.2.1 核心接口和类

#### ClientRegistration

客户注册(ClientRegistration)是用OAuth 2.0或OpenID Connect 1.0提供者注册的客户的表示。

客户端注册包含信息，如客户端id、客户端机密、授权授权类型、重定向URI、范围、授权URI、令牌URI和其他详细信息。

ClientRegistration及其属性定义如下:

```java
public final class ClientRegistration {
    // 唯一标识客户注册的ID。
    private String registrationId;  
    // 客户端标识符。
    private String clientId;    
    // 客户密码
    private String clientSecret;   
    /**
    	使用提供者对客户端进行身份验证的方法。支持的值为
    	client_secret_basic
    	client_secret_post
    	private_key_jwt
    	client_secret_jwt
    	none(public clients)
    */
    private ClientAuthenticationMethod clientAuthenticationMethod;  
     /**
    	OAuth 2.0授权框架定义了四种授权授权类型。支持的值是
    	authorization_code
    	client_credentials
    	password
    	以及扩展授权类型urn:ietf:params:oauth:grant-type:jwt- bearing
    */
    private AuthorizationGrantType authorizationGrantType;  
    // 客户端已注册的重定向URI，授权服务器将最终用户的用户代理重定向到最终用户通过身份验证并授权访问客户端之后的URI。
    private String redirectUri; 
    // 客户端在授权请求流(如openid、电子邮件或配置文件)期间请求的范围
    private Set<String> scopes; 
    private ProviderDetails providerDetails;
     // 用于客户端的描述性名称。该名称可能用于某些场景，例如在自动生成的登录页面中显示客户机的名称时
    private String clientName;  

    public class ProviderDetails {
        // 授权服务器的授权端点URI。
        private String authorizationUri;   
        // 授权服务器的令牌端点URI。
        private String tokenUri;    
        
        private UserInfoEndpoint userInfoEndpoint;
        // 用于从授权服务器检索JSON Web密钥(JWK)集的URI，它包含用于验证ID令牌的JSON Web签名(JWS)的加密密钥，还可以选择UserInfo响应。
        private String jwkSetUri;   
        // 返回OpenID Connect 1.0提供程序或OAuth 2.0授权服务器的颁发者标识符uri。
        private String issuerUri;   
        //OpenID提供程序配置信息。此信息仅在Spring Boot 2时可用spring.security.oauth2.client.provider.[providerId].issuerUri配置。
        private Map<String, Object> configurationMetadata;  

        public class UserInfoEndpoint {
            // 用于访问经过身份验证的最终用户的声明/属性的UserInfo端点URI。
            private String uri; 
            // 向UserInfo端点发送访问令牌时使用的身份验证方法。支持的值是header、form和query。
            private AuthenticationMethod authenticationMethod;  
            // UserInfo响应中返回的属性的名称，该属性引用最终用户的名称或标识符。
            private String userNameAttributeName;   

        }
    }
}

```

最初可以使用OpenID连接提供者的配置端点或授权服务器的元数据端点发现来配置ClientRegistration。

ClientRegistration提供了方便的方法来配置ClientRegistration，如下所示:

```java
ClientRegistration clientRegistration =
    ClientRegistrations.fromIssuerLocation("https://idp.example.com/issuer").build();
```

上面的代码将在系列查询https://idp.example.com/issuer/.well-known/openid-configuration, https://idp.example.com/.well-known/openid-configuration/issuer, https://idp.example.com/.well-known/oauth-authorization-server/issuer,最后停在第一个返回一个200响应。

作为一种替代方法，你可以使用ClientRegistrations.fromOidcIssuerLocation()来只查询OpenID连接提供商的配置端点。

#### ClientRegistrationRepository

ClientRegistrationRepository作为OAuth 2.0 / OpenID Connect 1.0 ClientRegistration(s)的存储库。

> 客户端注册信息最终由关联的授权服务器存储和拥有。此存储库提供检索主客户端注册信息的子集的能力，这些信息存储在Authorization Server中。

Spring boot2.X的自动配置绑定了spring.security.oauth2.client.registration下的每个属性.[registrationId]到ClientRegistration的一个实例，然后在ClientRegistrationRepository中组成每个ClientRegistration实例。

> ClientRegistrationRepository的默认实现是InMemoryClientRegistrationRepository。

自动配置还将ClientRegistrationRepository注册为ApplicationContext中的@Bean，以便在应用程序需要时可以进行依赖注入。

下面的清单显示了一个示例:

```java
@Controller
public class OAuth2ClientController {

    @Autowired
    private ClientRegistrationRepository clientRegistrationRepository;

    @GetMapping("/")
    public String index() {
        ClientRegistration oktaRegistration =
            this.clientRegistrationRepository.findByRegistrationId("okta");

        ...

        return "index";
    }
}
```

#### OAuth2AuthorizedClient

OAuth2AuthorizedClient是授权客户端的表示。当终端用户(资源所有者)授予客户端访问其受保护资源的授权时，就认为客户端已被授权。

OAuth2AuthorizedClient用于将OAuth2AccessToken(和可选的OAuth2RefreshToken)与ClientRegistration(客户端)和资源所有者关联，后者是授予授权的Principal最终用户。

#### OAuth2AuthorizedClientRepository / OAuth2AuthorizedClientService

OAuth2AuthorizedClientRepository负责在web请求之间持久化OAuth2AuthorizedClient。然而，OAuth2AuthorizedClientService的主要角色是在应用程序级管理OAuth2AuthorizedClient。

从开发人员的角度来看，oauth2authorizedclientpository或OAuth2AuthorizedClientService提供了查找与客户端关联的OAuth2AccessToken的功能，以便可以使用它来发起受保护的资源请求。

下面的清单显示了一个示例:

```java
@Controller
public class OAuth2ClientController {

    @Autowired
    private OAuth2AuthorizedClientService authorizedClientService;

    @GetMapping("/")
    public String index(Authentication authentication) {
        OAuth2AuthorizedClient authorizedClient =
            this.authorizedClientService.loadAuthorizedClient("okta", authentication.getName());

        OAuth2AccessToken accessToken = authorizedClient.getAccessToken();

        ...

        return "index";
    }
}
```

> Spring Boot2。x自动配置在ApplicationContext中注册一个OAuth2AuthorizedClientRepository和/或OAuth2AuthorizedClientService @Bean。但是，应用程序可以选择覆盖并注册自定义oauth2authorizedclientpository或OAuth2AuthorizedClientService @Bean。

OAuth2AuthorizedClientService的默认实现是InMemoryOAuth2AuthorizedClientService，它将OAuth2AuthorizedClient存储在内存中。

或者，可以将JDBC实现JdbcOAuth2AuthorizedClientService配置为在数据库中持久化OAuth2AuthorizedClient。JdbcOAuth2AuthorizedClientService依赖于OAuth 2.0客户端模式中描述的表定义。

#### OAuth2AuthorizedClientManager / OAuth2AuthorizedClientProvider

OAuth2AuthorizedClientManager负责OAuth2AuthorizedClient(s)的整体管理。主要职责包括:

- 使用OAuth2AuthorizedClientProvider授权(或重新授权)OAuth 2.0客户端。
- 委托OAuth2AuthorizedClient的持久性，通常使用OAuth2AuthorizedClientService或OAuth2AuthorizedClientRepository。
- 当OAuth 2.0客户端已被成功授权(或重新授权)时，委托给oauth2authorizationsucceshandler。
- 当OAuth 2.0客户端授权失败(或重新授权)时，委托给OAuth2AuthorizationFailureHandler。

OAuth2AuthorizedClientProvider实现了对OAuth 2.0客户端进行授权(或重新授权)的策略。实现通常会实现授权授权类型，例如。authorization_code, client_credentials等等。

OAuth2AuthorizedClientManager的默认实现是DefaultOAuth2AuthorizedClientManager，它与OAuth2AuthorizedClientProvider相关联，OAuth2AuthorizedClientProvider可以使用基于委托的组合支持多种授权授权类型。OAuth2AuthorizedClientProviderBuilder可以用来配置和构建基于委托的组合。

下面的代码演示了如何配置和构建一个OAuth2AuthorizedClientProvider组合，该组合提供了对authorization_code、refresh_token、client_credentials和密码授权授权类型的支持:

```java
@Bean
public OAuth2AuthorizedClientManager authorizedClientManager(
        ClientRegistrationRepository clientRegistrationRepository,
        OAuth2AuthorizedClientRepository authorizedClientRepository) {

    OAuth2AuthorizedClientProvider authorizedClientProvider =
            OAuth2AuthorizedClientProviderBuilder.builder()
                    .authorizationCode()
                    .refreshToken()
                    .clientCredentials()
                    .password()
                    .build();

    DefaultOAuth2AuthorizedClientManager authorizedClientManager =
            new DefaultOAuth2AuthorizedClientManager(
                    clientRegistrationRepository, authorizedClientRepository);
    authorizedClientManager.setAuthorizedClientProvider(authorizedClientProvider);

    return authorizedClientManager;
}
```

当授权尝试成功时，DefaultOAuth2AuthorizedClientManager将委托给OAuth2AuthorizationSuccessHandler，后者(默认情况下)将通过OAuth2AuthorizedClientRepository保存OAuth2AuthorizedClient。在重新授权失败的情况下，例如。刷新令牌不再有效，之前保存的OAuth2AuthorizedClient将通过removeauthorizedclienttoauth2authorizationfailurehandler从OAuth2AuthorizedClientRepository中删除。默认行为可以通过setAuthorizationSuccessHandler(OAuth2AuthorizationSuccessHandler)和setAuthorizationFailureHandler(OAuth2AuthorizationFailureHandler)来定制。

DefaultOAuth2AuthorizedClientManager也伴随着contextAttributesMapper Function&lt型;OAuth2AuthorizeRequest, Map&lt;字符串,Object&gt;祝辞,负责从OAuth2AuthorizeRequest映射属性(s)的地图OAuth2AuthorizationContext属性有关。当你需要提供OAuth2AuthorizedClientProvider所需(支持)的属性时，这很有用。PasswordOAuth2AuthorizedClientProvider要求资源所有者的用户名和密码在OAuth2AuthorizationContext.getAttributes()中可用。

下面的代码显示了contextAttributesMapper的一个例子:

```java
@Bean
public OAuth2AuthorizedClientManager authorizedClientManager(
        ClientRegistrationRepository clientRegistrationRepository,
        OAuth2AuthorizedClientRepository authorizedClientRepository) {

    OAuth2AuthorizedClientProvider authorizedClientProvider =
            OAuth2AuthorizedClientProviderBuilder.builder()
                    .password()
                    .refreshToken()
                    .build();

    DefaultOAuth2AuthorizedClientManager authorizedClientManager =
            new DefaultOAuth2AuthorizedClientManager(
                    clientRegistrationRepository, authorizedClientRepository);
    authorizedClientManager.setAuthorizedClientProvider(authorizedClientProvider);

    // Assuming the `username` and `password` are supplied as `HttpServletRequest` parameters,
    // map the `HttpServletRequest` parameters to `OAuth2AuthorizationContext.getAttributes()`
    authorizedClientManager.setContextAttributesMapper(contextAttributesMapper());

    return authorizedClientManager;
}

private Function<OAuth2AuthorizeRequest, Map<String, Object>> contextAttributesMapper() {
    return authorizeRequest -> {
        Map<String, Object> contextAttributes = Collections.emptyMap();
        HttpServletRequest servletRequest = authorizeRequest.getAttribute(HttpServletRequest.class.getName());
        String username = servletRequest.getParameter(OAuth2ParameterNames.USERNAME);
        String password = servletRequest.getParameter(OAuth2ParameterNames.PASSWORD);
        if (StringUtils.hasText(username) && StringUtils.hasText(password)) {
            contextAttributes = new HashMap<>();

            // `PasswordOAuth2AuthorizedClientProvider` requires both attributes
            contextAttributes.put(OAuth2AuthorizationContext.USERNAME_ATTRIBUTE_NAME, username);
            contextAttributes.put(OAuth2AuthorizationContext.PASSWORD_ATTRIBUTE_NAME, password);
        }
        return contextAttributes;
    };
}
```

DefaultOAuth2AuthorizedClientManager被设计为在HttpServletRequest的上下文中使用。当在HttpServletRequest上下文之外操作时，使用AuthorizedClientServiceOAuth2AuthorizedClientManager代替。

当使用AuthorizedClientServiceOAuth2AuthorizedClientManager时，服务应用程序是一个常见的用例。服务应用程序通常在后台运行，不需要任何用户交互，并且通常在系统级帐户而不是用户帐户下运行。配置了client_credentials授权类型的OAuth 2.0客户端可以被认为是一种服务应用程序类型。

下面的代码展示了如何配置一个AuthorizedClientServiceOAuth2AuthorizedClientManager，它提供了对client_credentials授权类型的支持:

```java
@Bean
public OAuth2AuthorizedClientManager authorizedClientManager(
        ClientRegistrationRepository clientRegistrationRepository,
        OAuth2AuthorizedClientService authorizedClientService) {

    OAuth2AuthorizedClientProvider authorizedClientProvider =
            OAuth2AuthorizedClientProviderBuilder.builder()
                    .clientCredentials()
                    .build();

    AuthorizedClientServiceOAuth2AuthorizedClientManager authorizedClientManager =
            new AuthorizedClientServiceOAuth2AuthorizedClientManager(
                    clientRegistrationRepository, authorizedClientService);
    authorizedClientManager.setAuthorizedClientProvider(authorizedClientProvider);

    return authorizedClientManager;
}
```

