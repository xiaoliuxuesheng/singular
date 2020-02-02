# 1-1_导学

- 如何学习 
- 认识什么是登陆和认证

- Spring Security导学
    1. spring security : 认证授权
    2. spring socal : 第三方认证
    3. spring security oauth : token管理
- 课程安排
    1. 开发环境
    2. RESTfulAPI
    3. spring security 表单认证 其他认证
    4. 第三方认证
    5. oauth app token认证
    6. spring security 授权

# 2-1_开发坏境

- 基础坏境 : jdk8 + mysql5.7 + redis3.6 + postman + idea (maven)

# 2-2_代码结构

- home : 父模块
    - core : 核心模块 : 通过用第三方依赖
        - browser : 浏览器模块的依赖
        - app : app模块的依赖
- demo : 真实项目

```jar
spring-social-security

spring-cloud-starter-oauth2

spring-social-core
spring-social-web

mysql-connector-java
druid-spring-boot-starter
mybatis-plus-boot-starter

spring-boot-starter-data-redis
spring-boot-starter-jdbc
```

# 2-3-security hello

1. 配置mysql数据源
2. 配置redis地址
3. 暂时关闭spring session 存储
4. security 默认配置 关闭

- 测试maven的打包与发布 : 打包插件与使用

# 3-1_Rest简介

- 用SpringMVC编写RESTFul
    - 用URL描述资源
    - 用HTTP方法描述对资源的操作行为
    - 用json作为数据交互

# 3-2_Rest查询

- RESTful测试用例 : MockMvc
    - spring 测试框架 : spring-boot-start-test
    - @RunWith
    - @SpringBootTest
    - 初始化MockMvc
    - jsonpath

- 使用注解声明RestAPI
    - @RestController
    - @RequestMapping
        - @PostMapping
        - @DeleteMapping
        - @PutMapping
        - @GetMapping
    - @RequestParam 
    - SpringData模块的 : @Pageable

# 3-3 用户详情

- @PathVariable : 路径占位符取值
- @JsonView : 接口指定视图 + 处理器方法启用JsonView

# 3-4 创建用户

- @RequestBody : 将json映射为实体
- 日期类型的值请求与相应
- 实体映射约束@Valid  参数校验 + BindingResult封装校验结果

# 3-5 修改和删除

- 常用验证的注解
- 自定义校验注解

# 3-6 异常处理机制

- SpringBoot默认的错误处理机制

    - 默认是浏览器访问请求头有`text/html`,出现异常将返回HTML页面
    - 默认是非浏览器访问出现异常 : 返回是JOSN错误信息

- 自定义错误处理方式 : 处理浏览器错误

    - 在根目录中定义/resource/error文件夹
    - 在文件夹中定义状态码对应名称相同的html页面

- 自定义错误处理方式 : 处理非浏览器错误信息

    - 自定义异常类 :
    - 自定义控制器错误处理器 : @ControllerAdvice : 用于处理其他Controller抛出的异常
    - 处理其中的方法用于处理指定异常 : @ExceptionHandler(异常信息)
        - @ResponseBody  +  @ResponseStatus   = 错误状态与错误json信息

    # 3-7 拦截

    - 过滤器
        - 注解的方式定义过滤器
            - 自定义过滤器 : 实现接口  `javax.servlet.Filter`
            - 将过滤器添加到Spring : @Component
        - 配置的方式定义过滤器
            - 自定义过滤器 : 实现接口  `javax.servlet.Filter`
            - 自定义配置类 : @Configuration + Bean
            - 将自定义过滤器添加到过滤器链中 : FilterRegistrationBean 
    - 拦截器
        - 自定义拦截器类 需要实现接口HandlerInterceptor接口
        - 将拦截器添加到Spring中 : @Component
        - 将拦截器配置到拦截器栈中
            - 拦截器配置类继承WebMvcConfigurAdapter : addInterceptors()
            - 将自定义拦截器添加到拦截器中

# 3-8 切面

- 自定义切面类 : @Aspectj 表示当前类是切面类
- 将切面类添加到Spring中 : @Component
- 在切面类中定义通知方法 : 用通知标签注解方法
    - @Before 
    - @After
    - @AfterReturning
    - @AfterThrowing
    - @Around
- 为通知标签添加 切面表达式   ||    切点表达式
- 各种拦截的作用顺序

# 3-9 文件上传下载

- 上传文件
    - 定时接受处理文件的方法 
    - 上传文件的请求类型 : `multipart/form-data` , 请求方式:POST
    - 接受文件的控制器方法MultipartFile : 封装了请求上传的文件对象
    - 处理文件API
- 文件下载
    - 文件下载方法需要有请求与相应参数  获取相应流 : response.getOutputStream
    - 设置下载 : response.setContentType(applicaion/x-dowload)  : 浏览器识别为文件下载
    - 设置下载 : response.setHeader("Content-Disposition","attachment;filename=文件名称")
    - 将文件写入到相应中 : 将输入流写入到相应流中
    - 最后手动刷新输出流 

# - 3-10 多线程提高Rest服务性能

- 使用CallAble定义多线程处理逻辑
- 用DeferredResult : 定义监听器实现 ApplicationListener<ContetRefreshedEvent>

# 3-11 swagger

# 3-12 Wiremock



# 第一章 Security坏境搭建

## 1.1 Security概述



## 1.2 RESTful概述



## 1.3 Security + RESTful坏境配置



## 1.4 RESTful与 MVC注解

### :anchor: RestFul请求类型

### :anchor: @RestController

### :anchor: @RequestMapping

### :anchor: @RequestParam

### :anchor:@PathVariable

### :anchor: @PageableDefault & Pageable

### :anchor: @RequestBody 

### :anchor: @Valid 和 BindingResult

### :anchor: @JsonView

## 1.5 RESTful拦截

### :anchor: 过滤器

### :anchor: 拦截器

### :anchor: 切面

## 1.6 RESTful高级

### :anchor: 文件上传

### :anchor:文件下载

### :anchor: 异常处理机制

### :anchor: 异步处理

## 1.5 RsetFul辅助框架

### :anchor: swagger

### :anchor: wiremock

# 001_导学

- 学习目的
- Security基本学习结构

# 002_开发坏境

# 003_代码结构以及依赖

- 代码结构

  > - parent
  >   - core
  >     - app
  >     - browser
  > - demo

- 相关依赖 : git项目

# 004_security hello world

- springboot启动类
- 配置mysql数据源
- 配置redis
- 关闭spring session管理
- 关闭security基础认证

- springboot打包与部署

# 005_第三章 RestFull概述

- SpringMVC的RestFull : 常用注解与请求

  > - RestAPI介绍
  > - 常用注解

- SpringMVC处理各种场景

  > - 过滤器
  > - 拦截器
  > - 异常处理

- RestFul辅助框架

  > - swagger
  > - WireMock

# 006_查询请求@Get

- 编写RestFulAPI的测试用例:使用Spring的MockMVC测试

  > Jsonpath 表达式

- 常用注解

  > @RestController
  >
  > @RequestMapping(value = "/manager",,method = RequestMethod.GET)
  >
  >  @RequestParam(value = "id",required = false)

- Pageable : 分页信息类

  > 请求参数 : size
  >
  > 请求参数 : page
  >
  > @PageableDefault(size = 2,page = 1)

# 007_用户详情@Get

- @PathVariable(value = "id")
- URL声明中使用正则表达式
- @JsonView 设置相应

# 008_用户创建请求@Post

- RequestBody 
- 日期类型参数处理
- @Valid 和 BindingResult 处理类

# 009_修改和删除@Put & @Delete

- 属性校验标签
- 自定义属性注解类与解析器

# 010_错误处理机制

- SringBoot默认的错误处理机制
- 自定义错误处理机制

# 011_rest的拦截 : filter , interceptor

# 012_rest的拦截 : aspect

# 013_文件上传下载

# 014_异步处理服务

- Runable异步处理
- 使用DefaultResult异步处理Rest
- 异步处理配置

# 015_swagger

# 016_WireMock

# 前言

# 第一章 Security入门

## 1.1 学习前提

1. Spring的注解
2. 自定义Filter
3. 自定义Interceptor
4. 使用注解实现APO
5. RESTful接口开发

## 1.2 Security坏境搭建

1. 添加依赖

   - 依赖的管理平台

     ```xml
     <dependencyManagement>
         <dependencies>
             <dependency>
                 <groupId>io.spring.platform</groupId>
                 <artifactId>platform-bom</artifactId>
                 <version>Brussels-SR4</version>
                 <type>pom</type>
                 <scope>import</scope>
             </dependency>
             <dependency>
                 <groupId>org.springframework.cloud</groupId>
                 <artifactId>spring-cloud-dependencies</artifactId>
                 <version>Dalston.SR2</version>
                 <type>pom</type>
                 <scope>import</scope>
             </dependency>
         </dependencies>
     </dependencyManagement>
     ```

   - Security相关依赖

     ```xml
     <!-- ★ SpringSecurity核心：-->
     <dependency>
         <groupId>org.springframework.cloud</groupId>
         <artifactId>spring-cloud-starter-security</artifactId>
     </dependency>
     <dependency>
         <groupId>org.springframework.social</groupId>
         <artifactId>spring-social-security</artifactId>
     </dependency>
     ```

2. 启用Security功能

   ```yaml
   security:
     basic:
       enabled: true
   ```

3. 添加Security配置文件

   ```java
   @Configuration
   public class SecurityWebConfig extends WebSecurityConfigurerAdapter{
   	@Override
       protected void configure(HttpSecurity http) throws Exception {
           HttpSecurity = http.and()
       }
   }
   ```

4. 常用配置说明

   - csrf跨站点请求伪造

# 第二章 SpringSecurity认证



