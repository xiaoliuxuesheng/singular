# 001_spring简介

- spring优点

# 002_003_helloworld - web模块

- spring + mvc

# 004_helloworld - 配置

1. web.xml
   - DispatcherServlet的contextConfigLocation
   - DispatcherServlet的load-on-startup
   - DispatcherServlet的url-pattern
2. spring-mvc的配置文件
   - 开启SpringIOC扫描驱动 : context:component-scan

# 005_006_helloworld - 请求处理器

1. @Controller
2. @RequestMapping
3. return + 结果视图
4. 视图解析器 : InternalResourceAndView

# 007_helloworld细节 : 运行流程

1. 客户端发送请求 : url
2. 由前端控制器DispatcherServlet接收到请求
3. 根据请求的url匹配控制器处理器的RequestMapping
4. 根据请求处理的执行结果, 完成结果响应

# 008_helloworld细节 : RequestMapping

- 作用

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