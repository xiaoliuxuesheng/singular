# 001_spring简介

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

# 002~006_helloworld - web模块

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

# 007_helloworld细节 : 运行流程

1. 客户端发送请求 : url
2. 由前端控制器DispatcherServlet接收到请求
3. 根据请求的url匹配控制器处理器的RequestMapping
4. 根据请求处理的执行结果, 完成结果响应

# 008_helloworld细节 : RequestMapping

- 作用:value的url中 / 可以不写

# 009_helloworld细节 : spring配置文件

- 默认 : /WEB-INF/xxx-servlet.xml
  - xxx : 表示为servlet-name
- 设置指定springmvc配置文件
  - DispatcherServlet.contextConfigLocation = classpath:spring配置文件

# 010_helloworld细节 : url-pattern = /

1. JavaEE应用的web.xml的配置都继承自Tomcat的web.xml
2. Tomcat中处理请求的配置是default-servlet.url-pattern = / , 而JavaEE应用中DispatcherServlet.url-pattern = / , 表示JavaEE应用的请求处理将禁用掉Tomcat的请求处理方式, 所有的请求都交由前端控制器处理
3. Tomcat中的jsp-servlet处理了JSP页面的请求
4. url-pattern = /也为RestFul请求提供基础配置

# 011_RequestMapping细节 : 标注位置

- 标注在类上 : 表示为当前类中所有的方法指定基准路径
- 标准在方法上 : 当前方法的处理请求的URL映射

# 012_RequestMapping细节 : 请求方式

- 属性 : method 表示当前方法处理的请求类型 : 

# 013_RequestMapping细节 : 规定请求参数

- 属性params : 用于规定请求中的参数表达式
  - params = {"key"} : 表示参数中必须有指定名称的参数
  - params = {"!key"} : 表示参数中必须不能有指定名称的参数
  - params = {"key=value"} :  表示请求中的指定参数必须是指定值
  - params = {"key!=key"} : 表示请求中的指定参数不可以是指定值
  -  params = {"key=value","key2=value2"} : 规定请求中的多个参数

# 014_ RequestMapping细节 : 规定请求头信息

- 属性 : headers : 用于规定请求的请求头中的参数信息才可以访问
  - header 的参数规定可以使用表达式

# 015_Ant风格的请求方式

- ? : 匹配任意一个字符
- `*` : 匹配任意多个字符
- `**`  : 匹配任意多个字符  或 多层路径

# 016_PathVariable : 获取请求路径中的占位符参数

1. 第一步 : 在请求URL中定义占位符
2. 第二步 : 在方法参数中定义参数 
3. 第三步 : 在该方法参数上标注@PathVariable获取占位符中的值

# 017_Rest风格请求

1. 什么是RestFul分隔 : 资源状态转换

# 018_019_rest 环境

1. DispatcherServlet
2. EncodingFilter
3. context:component-scan
4. InternalResourcesAndViewResover
5. 定义请求连接 : post get delete put
6. 处理请求 : method = Request.PUT...
7. 添加Rest过滤器 : HiddenMethodFilter
8. post表单添加参数 : _method=请求方式
9. 过滤器源码解读
   - 获取请求参数的值
   - 是post并且参数有值, 则过滤器执行转换请求
   - 将请求的值转换为大写字母
   - 根据请求参数转换为对应的请求对象
   - 返回转换后的请求对象

# 020_高版本Tomcat中的JSP

- 高版本中Tomcat中国没有exception对象 : 需要手动添加 , 在jsp标签中添加 `isErrorPage=true`:表示将出现的错误交给exception对象

# 021_SpringMVC请求参数_环境搭建

#022_获取请求参数

1.  @RequestParam + @RequestHeader + @CookieValue

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