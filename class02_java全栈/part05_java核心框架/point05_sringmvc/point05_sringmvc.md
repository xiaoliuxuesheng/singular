# Hello Spring MVC
# 视图定位
# 注解方式
# 接受表单数据
# 客户端跳转
# Session
# 中文问题
# 上传文件
# 拦截器

# 第一章 SpringMVC入门

## 1.1 SpringMVC概述

- 结构松散，几乎可以在 # 中使用各类视图
- 松耦合，各个模块分离
- 与 Spring 无缝集成

## 1.2 SpringMVC的Helloworld

1. 添加依赖

    ```xml
    org.springframework.spring-webmvc
    ```

2. 配置

    - web.xml : 配置前端过滤器

        ```xml
        <?xml version="1.0" encoding="UTF-8"?>
        <web-app xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
                 xmlns="http://xmlns.jcp.org/xml/ns/javaee"
                 xsi:schemaLocation="
                 http://xmlns.jcp.org/xml/ns/javaee
                 http://xmlns.jcp.org/xml/ns/javaee/web-app_3_1.xsd"
                 id="WebApp_ID" version="3.1">
            <servlet>
                <servlet-name>springmvc</servlet-name>
                <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
                <init-param>
                    <param-name>contextConfigLocation</param-name>
                    <param-value>classpath:spring-mvc.xml</param-value>
                </init-param>
                <load-on-startup>1</load-on-startup>
            </servlet>
            <servlet-mapping>
                <servlet-name>springmvc</servlet-name>
                <url-pattern>/</url-pattern>
            </servlet-mapping>
        </web-app>
        ```

    - spring-mvc.xml 

        ```xml
        <?xml version="1.0" encoding="UTF-8"?>
        <beans xmlns="http://www.springframework.org/schema/beans"
               xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
               xmlns:context="http://www.springframework.org/schema/context"
               xmlns:mvc="http://www.springframework.org/schema/mvc"
               xsi:schemaLocation="http://www.springframework.org/schema/beans 
                                   http://www.springframework.org/schema/beans/spring-beans.xsd 
                                   http://www.springframework.org/schema/context 
                                   https://www.springframework.org/schema/context/spring-context.xsd 
                                   http://www.springframework.org/schema/mvc 
                                   https://www.springframework.org/schema/mvc/spring-mvc.xsd">
        
            <!-- 开启注解解析器 -->
            <context:component-scan base-package="com.panda"/>
        
            <!-- 配置视图解析器 -->
            <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
                <property name="prefix" value="/WEB-INF/pages/"></property>
                <property name="suffix" value=".jsp"></property>
            </bean>
        </beans>
        ```

3. 测试

    - 定义请求处理器

        ```java
        @Controller
        public class HelloController {
            @RequestMapping(value = "/hello")
            public String hello(){
                return "success";
            }
        }
        ```

## 1.3 Helloworld细节

1. **url-pattern**

    - web项目的`web.xml`继承自Tomcat中的`web.xml`
    - Tomcat中处理静态资源的配置`<default-servlet>` 是 `/`, 是Tomcat处理静态资源
    - Tomcat中的配置`<sjsp-servlet>` 不会 拦截`jsp`文件
    -  web项目的`web.xml`的`<servlet>`的`/`会交给Tomcat处理
    - url-pattern = `/*`  会直接拦截所有请求

2. **context:component-scan**

    > 开启Spring的注解功能

3. InternalResourceViewResolver

    - 视图解析器 : 根据处理器返回的视图名称拼接相应结果页面路径

4. @Controller

    - 声明一个请求处理器类

5. @RequestMapping

    - 处理指定url的请求

6. return String

    - 将处理结果响应, 利用视图解析器拼装响应视图

# 第二章 RESTful请求

## 2.1 RESTful概述

- 把请求URL当做请求资源
- 把请求方式当做对资源的操作行为
- 把json作为传输数据格式
- 客户端和服务器之间，传递这种资源的某种表现层；

　　（3）客户端通过四个HTTP动词，对服务器端资源进行操作，实现"表现层状态转化"。

## 2.2 RESTful请求方式

- **GET :**         获得一个资源
- **POST** :      创建一个新的资源
- **PUT ：**     修改一个资源的状态
- **DELETE :**   删除一个资源

## 2.3 RESTful请求过滤器

```xml
<filter>
    <filter-name>hiddenHttpMethodFilter</filter-name>
    <filter-class>org.springframework.web.filter.HiddenHttpMethodFilter</filter-class>
</filter>
<filter-mapping>
    <filter-name>hiddenHttpMethodFilter</filter-name>
    <url-pattern>/*</url-pattern>
</filter-mapping>
```

- 在处理GET和DELETE请求本质是一个`POST`请求

- 在处理GET和DELETE请求时候, 需要发送一个`_method`参数 参数值指定为请求方式

    ```java
    public static final String DEFAULT_METHOD_PARAM = "_method";
    
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
        throws ServletException, IOException {
    
        HttpServletRequest requestToUse = request;
    
        if ("POST".equals(request.getMethod()) && request.getAttribute(WebUtils.ERROR_EXCEPTION_ATTRIBUTE) == null) {
            String paramValue = request.getParameter(this.methodParam);
            if (StringUtils.hasLength(paramValue)) {
                String method = paramValue.toUpperCase(Locale.ENGLISH);
                if (ALLOWED_METHODS.contains(method)) {
                    requestToUse = new HttpMethodRequestWrapper(request, method);
                }
            }
        }
    
        filterChain.doFilter(requestToUse, response);
    }
    ```

## 2.3 @RequestMapping 定制请求

:anchor: **@RequestMapping** : 用于将web请求映射到请求处理类中的方法

-  **@GetMapping** 
- **@PostMapping**
- **@PutMapping**
- **@DeleteMapping**

:anchor:  **@RequestMapping(params = {})**

- **params = {"name"}**  : 表示请求必须带指定名称的参数
-  **params = {"!name"}** : 表示请求不可以带指定名称的参数
- **params = {"name=value"}** : 表示请求必须带指定参数并且参数值必须等于指定值
-  **params = {"name!=value"}** : 表示请求必须带指定参数并且参数值不等于指定值

:anchor: **@RequestMapping(headers = {})**

- 对请求头约束的方式与**param**相同

## 2.4 ANT风格请求

> 在请求URL中使用通配符

- **?** : 代表任意一个字符
- ***** : 代表任意多个字符 或 代表一层路径
- ******  : 代表任意多个字符 或 代表多层路径

# 第三章 SpringMVC请求参数

## 3.1 CharacterEncodingFilter

> 请求编码过滤器

:anchor: 配置方式

```xml
<filter>
    <filter-name>encodingFilter</filter-name>
    <filter-class>org.springframework.web.filter.CharacterEncodingFilter</filter-class>
    <init-param>
        <param-name>encoding</param-name>
        <param-value>UTF-8</param-value>
    </init-param>
    <init-param>
        <param-name>forceResponseEncoding</param-name>
        <param-value>true</param-value>
    </init-param>
</filter>
```

- encoding : 表示请求编码格式
- forceResponseEncoding : 是否设置相应编码格式

:anchor: 源码解读

```java
private String encoding;

private boolean forceRequestEncoding = false;

private boolean forceResponseEncoding = false;

protected void doFilterInternal(
    HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
    throws ServletException, IOException {

    String encoding = getEncoding();
    if (encoding != null) {
        if (isForceRequestEncoding() || request.getCharacterEncoding() == null) {
            request.setCharacterEncoding(encoding);
        }
        if (isForceResponseEncoding()) {
            response.setCharacterEncoding(encoding);
        }
    }
    filterChain.doFilter(request, response);
}
```

3.2获取指定名称的请求参数



3.3 使用原生API获取参数

3.4 获取cookie中的值

3.5 获取header中的值

3.6 请求参数封装为Pojo

第四章 请求数据的相应

4.1 响应数据存入Map

4.2 响应数据存入ModelMap

4.4 返回ModelAndView对象

4.5 数据保存入session

4.5 ModelAttribute

