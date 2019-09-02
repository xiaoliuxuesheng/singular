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

