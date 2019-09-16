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
2. 

