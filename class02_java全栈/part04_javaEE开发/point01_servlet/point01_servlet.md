# 前言

1. http
2. HttpServletRequest&HttpServletResponse
3. get请求与post请求
4. 转发与重定向
5. cookie与session

# 第一章 JavaWEB

## 1.1 架构模式

1. 系统架构分类
   - C/S：Client/Client，客户端访问服务器，客户端运行在独立的进程中
   - B/S：Browser/Server，本质还是CS，还是客户端访问服务器，只是客户的形式是符合Http协议的浏览器

## 1.2 JavaWEB的发展

- 1990：HTML标记语言
- 1993：动态WEB
- 1994：PHP
- 1995：Java、Applet
- 1996：ASP
- 1997：SUN公司发布Servlet规范
- 1998：JSP、EJB1.0规范
- 1999：J2EE规范是SUN公司提供的一套类库，程序员在这套类库的基础上开发出企业级的WEB应用

## 1.3 服务器

1. WEB概述
   - WEB概述：静态资源、动态资源JavaWEB
   - WEB服务器：
   - 服务器分类：开源（Tomcat、Jetty淘宝、Resin新浪）；收费（WebLogic Oracle、WebSphere）

# 第二章 Tomcat

- 支持Servlet和JSP规范 
- 安装目录：bin可执行命令文件、conf配置文件（server.xml服务器的配置、web.xml项目的配置）、lib、logs日志文件、temp临时文件、webapps存放web项目、work是项目运行时生成的文件；
- 基本命令的使用：startup.bat启动服务器（http://localhost:8080）、shutdown.bat停止服务器
- 服务器配置
  - 修改端口：
  - 项目部署与访问：①项目保存webapps中的一个目录中（一个目录代表一个项目）②在目录中新增WEB-INF目录③在WEB-INF中新增class目录、lib目录、web.xml④在项目目录中新增静态资源⑤启动项目，在浏览器使用url访问资源：http://localhost:端口/项目目录名称/静态资源名称
  - 配置Host访问路径
- 常见错误：①闪退检查JAVA_HOME②404错误③端口冲突
- Tomc安全配置：tomcat-user.xml

# 第三章 Servlet

5. Servlet基础

   - 概念：是ServerApplet的简称，指的是服务端程序，可交互式的处理看客户的发送到服务器的请求并完成操作响应。是JavaWEB开发的基础

   - 作用：①接收客户端请求，完成操作；②动态生成网页；③将包含操作结果的动态网页响应给客户端

   - 标准WB项目结构

     ```yml
     web_app: 项目根目录
     	WEB-INF: 由WEB服务器调用该目录中内容
     		class: java字节码文件目录
     		lib: java class运行依赖的jar包
     		web.xml: web应用的配置文件
     	
     ```

   - IDEA创建Servlet程序：在Tomcat的项目目录中准备基本结构，新增Java类实现Servlet接口的server方法，编译后配置web.xml，启动Tomcat访问servlet

   - Servlet程序集成Tomcat服务器：关联第三方jar包，IDEA集成Tomcat，自动部署Servlet项目，导出war包

6. HTTP协议

   - 超文本传输协议：是互联网上应用最广泛的网络协议工具，是一个基于请求与相应模式的、无状态的、应用层的协议；
   - HTTP协议特点：
     - 支持客户端-服务器模式
     - 简单快速：客户端向服务器发送请求资源的URL，服务器返回对应的资源，相应快速，请求方式简单
     - 灵活：HTTP传输任意类文本
     - 无连接：是指每次连接只处理一个或多个请求，服务器处理完请求便会断开连接，节省传输时间
     - 无状态：是指对于事务处理没有记忆的的能力
   - HTTP协议的通讯流程：三次握手四次挥手
   - HTTP请求报文
     - 请求行：请求方式、资源路径、协议版本
     - 请求头：想服务传递客户端的基本信息
     - 空行
     - 请求实体：post请求的请求数据保存
   - HTTP响应报文
     - 状态行：HTTP版本号。状态码200、302、404/50
     - 响应头：
     - 空行
     - 响应实体：
   - GET请求与POST请求
     - GET请求
     - POST请求

7. Servlet详解

   - Servlet核心接口和类：在Servlet体系结构中，还可以通过继承GenericServlet或HttpServlet类
     - Servlet接口：在ServletAPI中是最重要的接口，所有Servlet都会直接或间接的与改接口发生关系，或者直接实现改接口，
     - GenericServlet抽象类：实现的基本的init和destroy方法，service是抽象方法
     - HttpServlet：继承自GenericServlet，实现service方法更加请求方式拆分为doGet、doPost、doPut
   - Servlet配置方式
     - 2.5使用web.xml配置
       - 精确匹配
       - 后置匹配：/*.后缀
       - 通配符匹配：/*（匹配所有资源）
       - 通配符匹配：/（匹配所有请求，包含服务器所有资源，不包含jsp）
       - load-on-startup：启动加载顺序，值越小优先级越高
     - 3.0使用注解
       - 在Servlet类上添加：@WebServlet()
         - name：servlet名称，可以省略
         - value：是urlPattern的别名，配置访问路径，可以配置多个
         - loadOnStartup：起动加载顺序
     - 注解和web.xml不冲突，可以同时生效
   - Servlet生命周期：
   - Servlet请求流程

8. Servlet应用

   - HttpServletRequest对象：浏览器发送的请求都封装在这个对象中

     - get请求：请求数据在url后面。明文传输、数据量少，get请求中文乱码

     - post请求：请求在请求体中，后台传输、传输数据量大

       | 常用方法           | 说明                   |
       | ------------------ | ---------------------- |
       | getParameter       | 获取请求参数           |
       | getParamterNames   |                        |
       | setCharsetEncoding | 设置请求的字符编码     |
       | getMethod          | 获取请求方式           |
       | getRequestURI      | 获取请求资源名称       |
       | getRequestURL      | 返回浏览器地址栏信息   |
       | getContextPath     | 获取当前上下文路径     |
       | getHeader          | 获取请求头指定名称参数 |
       | getReemoteAddr     | 获取客户端IP           |

   - HttpServletResponse：

     - response常用方法

       | 方法                 | 说明                       |
       | -------------------- | -------------------------- |
       | setHeader            | 设置响应头                 |
       | setContentType       | 设置响应类型               |
       | setCharacterEncoding | 设置服务端响应内部编码格式 |
       | getWriter            | 获取打印输出流             |

     - 设置编码

       - 设置服务端的响应编码格式
       - 设置响应类型的编码格式

   - 转发与重定向

9. cookie

   - 概述：

   - 常用操作

     | 操作方法 | 说明 |
     | -------- | ---- |
     |          |      |

   - cookie生命设置

   - cookie特点

10. session

    - 概述：

    - 常用操作

      | 操作方法 | 说明 |
      | -------- | ---- |
      |          |      |

11. filter

    - 



