# 前言 面试题

## 1. 转发与重定向

:dash: 转发 - forward

- 

# 第一章 SpringMVC入门



# 第二章 SpringMVC处理请求

## 2.1 获取请求URL

:dash: <font color=red size=5>@RequestMapping</font>

​		是一个用来处理请求地址映射的注解，可用于类或方法上。用于类上，表示类中的所有响应请求的方法都是以该地址作为方法路径的前缀

:one: **value， method**

- value :  指定请求的实际地址，指定的地址可以是URI Template 模式（后面将会说明）；
- method：  指定请求的method类型， GET、POST、PUT、DELETE等；

:two: **consumes，produces**

- consumes： 指定处理请求的提交内容类型（Content-Type），例如application/json, text/html;

- produces:    指定返回的内容类型，仅当request请求头中的(Accept)类型中包含该指定类型才返回；

:three: **params，headers**

- params： 指定request中必须包含某些参数值是，才让该方法处理。

- headers： 指定request中必须包含某些指定的header值，才能让该方法处理请求。

## 2.2 规定请求方式

:dash: <font color=red size=5>方式一 : 指定RequestMapping的method属性</font>

- **@RequestMapping(method=RequestMethod)**

  ```java
  public enum RequestMethod {
  	GET, HEAD, POST, PUT, PATCH, DELETE, OPTIONS, TRACE
  }
  ```

:dash: <font color=red size=5>方式二 : 使用RequestMapping的method变体</font>

- **@GetMapping**：
- **@PostMapping**：
- **@PutMapping**：
- **@DeleteMapping**：
- **@PatchMapping**：

:two: <font color=red size=5>PostMapping</font>

:two: <font color=red size=5>PutMapping</font>

:two: <font color=red size=5>GetMapping</font>

## 2.3 规定请求参数

:dash: <font color=red size=5>指定RequestMapping的params属性</font> 

```java
@RequestMapping(params = "参数规则")
```

- 规则1：<font color=red>params = {"key"} </font>: 表示参数中必须有指定名称的参数
- 规则2：<font color=red>params = {"!key"}</font> : 表示参数中必须不能有指定名称的参数
- 规则3：<font color=red>params = {"key=value"} </font>:  表示请求中的指定参数必须是指定值
- 规则4：<font color=red>params = {"key!=key"}</font> : 表示请求中的指定参数不可以是指定值
- 规则5：<font color=red>params = {"key=value","key2=value2"}</font> : 规定请求中的多个参数

## 2.4 规定请求头

:dash: <font color=red size=5>指定RequestMapping的headers属性</font> 

```java
@RequestMapping(headers = "参数规则")
```

- 规则1：<font color=red>headers= {"key"} </font>: 表示请求头中必须有指定名称的参数
- 规则2：<font color=red>headers= {"!key"}</font> : 表示请求头中必须不能有指定名称的参数
- 规则3：<font color=red>headers= {"key=value"} </font>:  表示请求头中的指定参数必须是指定值
- 规则4：<font color=red>headers= {"key!=key"}</font> : 表示请求头中的指定参数不可以是指定值
- 规则5：<font color=red>headers= {"key=value","key2=value2"}</font> : 规定请求头中的多个参数

## 2.5 Ant风格的RequestMapping

```java
@RequestMapping(value = "带特殊符号的请求url")
```

> 如果Ant风格匹配和精确匹配都符合请求规则，以精确匹配为准

- 符号1：<kbd>?</kbd> : 匹配任意一个字符，如：@RequestMapping(value = "/test-0?")

- 符号2：<kbd>*</kbd> : 匹配任意多个字符，如：@RequestMapping(value = "/test/\*")
- 符号3：<kbd>**</kbd>  : 匹配任意多个字符  或 多层路径，如：@RequestMapping(value = "/test/\*\*")

# 第三章 SpringMVC处理请求参数

## 3.1 获取路径中的占位符参数

- 在方法的请求路径中定义占位符参数

  ```java
  @RequestMapping(value = "/test/{key}")
  ```

- @PathVariable：路径中的参数需要在方法参数中定义参数用于获取路径中的参数

  ```java
  public T method(@PathVariable("key") String key){
      return T;
  }
  ```

## 3.2 获取请求参数

:dash: <font color=red size=5>@RequestParma</font> ：获取请求参数





# 第四章 SpringMVC处理响应

# 第五章 SpringMVC过滤与拦截

# 第六章 SpringMVC异常处理

# 第七章 SpringMVC上传下载

# 第八章 SpringMVC国际化

# 第九章 SpringMVC支持RESTful

# 第十章 SpringMVC配置说明









第一章 SpringMVC入门

1.1 SpringMVC概述

- 结构松散，几乎可以在 # 中使用各类视图
- 松耦合，各个模块分离
- 与 Spring 无缝集成

1.2 SpringMVC的Helloworld

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

1.3 Helloworld细节

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

第二章 RESTful请求

2.1 RESTful概述

- 把请求URL当做请求资源
- 把请求方式当做对资源的操作行为
- 把json作为传输数据格式
- 客户端和服务器之间，传递这种资源的某种表现层；

　　（3）客户端通过四个HTTP动词，对服务器端资源进行操作，实现"表现层状态转化"。

2.2 RESTful请求方式

- **GET :**         获得一个资源
- **POST** :      创建一个新的资源
- **PUT ：**     修改一个资源的状态
- **DELETE :**   删除一个资源

2.3 RESTful请求过滤器

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

2.3 @RequestMapping 定制请求

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

2.4 ANT风格请求

> 在请求URL中使用通配符

- **?** : 代表任意一个字符
- ***** : 代表任意多个字符 或 代表一层路径
- ******  : 代表任意多个字符 或 代表多层路径

第三章 SpringMVC请求参数

3.1 CharacterEncodingFilter

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

