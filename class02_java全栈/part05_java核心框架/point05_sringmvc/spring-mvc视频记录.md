# 001、spring简介

- SpringMVC简介：是Spring实现MVC设计理念的WEB模块，强大的注解简化web开发；
- 核心功能：
  - 请求映射
  - 请求数据处理
  - 视图和视图解析器，数据转换
  - 国际化
  - 上传与下载
  - 异常处理
  - 源码解析
- SpringMVC流程图：请求图网上下载

# 002~006、helloworld -案例

- 配置web.xml：/会拦截除了jsp的所有请求。/*可以看了包含jsp的所有请求

  ```xml
  <servlet>
      <servlet-name>SpringMVC</servlet-name>
      <servlet-class>org.springframework.web.servlet.DispatcherServlet</servlet-class>
      <init-param>
          <param-name>contextConfigLocation</param-name>
          <param-value>classpath:spring-mvc.xml</param-value>
      </init-param>
      <load-on-startup>1</load-on-startup>
  </servlet>
  <servlet-mapping>
      <servlet-name>SpringMVC</servlet-name>
      <url-pattern>/</url-pattern>
  </servlet-mapping>
  ```

- 定义spring-mvc.xml配置文件，在/WEB-INF目录下新增pages目录中添加success.jsp文件

  ```xml
  <context:component-scan base-package="com.mvc.controller"></context:component-scan>
  
  <bean class="org.springframework.web.servlet.view.InternalResourceViewResolver">
      <property name="prefix" value="/WEB-INF/pages/"/>
      <property name="suffix" value=".jsp"/>
  </bean>
  ```

- 定义Controller

  ```java
  @RequestMapping(value = "/hello", method = RequestMethod.GET)
  public String hello() {
      return "seccess";
  }
  ```

# 007~011、helloworld - 细节

- 细节一：运行流程
  - 客户端发送/hello请求
  - Tomcat服务接收到请求，url-pattern拦截
  - 由DispatcherServlet处理请求
  - DispatcherServlet根据请求url映射到RequestMapping对应的处理器
  - DispatcherServlet使用反射执行目标方法，获取返回值
  - 根据返回值被InternalResourceViewResolver解析器拼接完整地址
  - 拿到页面地址并转发到页面
- 细节二：RequestMapping
  - 作用是告诉SpringMVC处理的请求url：value的url中 / 可以不写，默认从当前项目下开始
  - 可以标注在方法上和类上
- 细节三：spring配置文件
  - 不指定配置文件路径：SpringMVC会指定一个默认的配置文件：/WEB-INF/#{servlet-name}-servlet.xml
  - 设置指定springmvc配置文件：DispatcherServlet.contextConfigLocation = classpath:spring配置文件
- 细节四：url-pattern = /
  - JavaEE应用的web.xml的配置都继承自Tomcat的web.xml
  - Tomcat中处理请求的配置是default-servlet.url-pattern = / , 而JavaEE应用中DispatcherServlet.url-pattern = / , 表示JavaEE应用的请求处理将禁用掉Tomcat的请求处理方式, 所有的请求都交由前端控制器处理
  - default-servlet是Tomcat处理静态资源的，Tomcat会找到这个资源原样返回；但是Tomcat的default-servlet被web应用禁用了，会来到SpringMVC的前端控制器
  - Tomcat中的jsp-servlet处理了JSP页面的请求，
  - url-pattern = /也为RestFul请求提供基础配置

# 012~016、RequestMapping

- 细节一：**@RequestMapping.value**：标注位置
  - 标注在类上 : 表示为当前类中所有的方法指定基准路径
  - 标准在方法上 : 当前方法的处理请求的URL映射
- 细节二：**@RequestMapping.method**：表示当前方法处理的请求类型
  - RequestMethod.GET：缺省的默认请求方式
  - RequestMethod.POST：
  - RequestMethod.PUT：
  - RequestMethod.DELETE：
  - RequestMethod.PATCH：
  - RequestMethod.HEAD：
  - RequestMethod.GET：
  - RequestMethod.OPTIONS：
  - RequestMethod.TRACE：

- 细节三：**@RequestMapping.params={}**：规定请求参数，并且可以规定请求参数限制表达式
  - params = {"key"} : 表示参数中必须有指定名称的参数
  - params = {"!key"} : 表示参数中必须不能有指定名称的参数
  - params = {"key=value"} :  表示请求中的指定参数必须是指定值
  - params = {"key!=key"} : 表示请求中的指定参数不可以是指定值
  - params = {"key=value","key2=value2"} : 规定请求中的多个参数
- 细节四：**@RequestMapping.headers ={}**：规定请求头中的参数信息才可以访问，并且可以规定请求参数限制表达式
  - 表达式同上
- 细节五：**@RequestMapping.consumes={}**：规定请求头中的ContentType
- 细节六：**@RequestMapping.produces={}**：规定告诉浏览器返回的内容是什么类型，给响应头添加的ContentType
- 细节七：Ant风格的请求url
  - ? : 匹配任意一个字符
  - `*` : 匹配任意多个字符
  - `**`  : 匹配任意多个字符  或 多层路径
- 细节八：**@PathVariable**
  - 在请求路径中定义变量，在请求方法的参数上获取请求路径中的占位符参数
    - 第一步 : 在请求URL中定义占位符：/path/{id}；在该方法参数上标注获取占位符中的值
    - 第二步 : 在方法参数中定义参数：public void method(@PathVariable("id") String id)

# 017~020、Rest风格请求

- Rest风格概念：Representational Status Transfer（资源状态转换），即客服端发送请求就是需要向服务请求资源，不同的URL能请求到不同的资源，因此每个URL就是每个资源的的独一无二的标识，状态转换：同一个URL如果用不同的请求方式，那么对资源的操作方式也会不同，因此根据请求方式对资源的操作方式进行状态转换；
- 增删改查环境搭建：用html表达只能发送GET请求和POST请求，所有搭建REST的html环境需要添加配置
  - 基本配置：DispatcherServlet、context:component-scan、InternalResourcesAndViewResover
  - 添加字符编码过滤器：EncodingFilter
  - 添加Rest过滤器 : HiddenMethodFilter
  - 表单发送Rest请求：delete、put需要使用POST方式，在表单域中添加参数 _method=请求方式
- HiddenMethodFilter源码解读
  - 获取请求参数的值
  - 是post并且参数有值, 则过滤器执行转换请求
  - 将请求的值转换为大写字母
  - 根据请求参数转换为对应的请求对象
  - 返回转换后的请求对象，重写了getMethod()方法
- 高版本Tomcat中的JSP
  - 高版本中Tomcat中没有exception对象 : 需要手动添加 , 在jsp标签中添加 `isErrorPage=true`:表示将出现的错误交给exception对象

# 021~SpringMVC请求参数

- @RequestParam
- @RequestHeader
- @CookieValue

# 022_获取请求参数

1.  + + 

- 使用原生HttpRequest获取请求参数
- 在处理器方法中定义参数获取同名请求参数
- 给方法参数标注@RequestParam获取指定请求参数

# 023_RequestHader

- 给方法参数标注@RequestHader获取请求头参数

# 024_CookieValue

- 给方法参数标注@CookieValue获取Cookie中的参数

# 025_请求处理POJO

- 将多个参数封装为pojo

# 026_请求处理 操作原生API

1. HttpServletRequest
2. HttpServletResponse
3. HTTPSession
4. java.security.Principe
5. Location
6. InputStream
7. OutputStream
8. Writer
9. Reader

# 027_SpringMVC乱码

1. 请求乱码/响应乱码
2. GET请求乱码处理方案
3. POST乱码处理方案
4. SpringMVC乱码方案

# 101_响应环境搭建

# 102_数据输出

1. 参数中定义Map
   - 向Map中put数据会添加到请求域中
2. 方法参数定义Model对象
   - 给Model对象设置属性,添加到请求域中
3. 方法参数定义ModelMap

# 103_Model 和 ModelMap的关系

- 最终类都是BindingAwareModelMap类型
  - ModelMap是Model的实现类
  - BindingAwareModelMap是Model 和 ModelMap的子类

# 104_ModelAndView响应返回值

- 处理器方法返回值ModelAndView
  - new ModelAndView
  - mv.addObject

# 106_数据输出SessionAttribute

1. 标注在类上
   - value：表示给BindingAwareModelMap绑定的数据同时也给SessionAttribute绑定一份对应value的值，多个key用逗号分隔
   - type：表示给BindingAwareModelMap绑定的数据同时也给SessionAttribute绑定一份对应type的值

# 107_数据输出ModelAttribute

- 封装请求的POJO默认是反射new出来的对象，在处理器类中定义被@ModelAttribute标注的方法，改方法会提前与处理器方法执行，并向BIndingAwareModelMap中注入