# 第四章 SpringBoot与web开发

## 4.1 静态资源映射规则

### 1. webjars映射规则

- webjars : 表示以jar包方式打包的静态资源
- 映射 : 访问`/webjars/**` 都会请求到`/META-INF/resource/webjars`路径下

### 2. 静态资源文件夹

- 静态资源文件夹 : 表示项目中用到的页面以及样式文件

- 映射 : 访问`/**`  都会请求到静态资源文件夹

  ```txt
  ① classpath : /META-INF/resource/
  ② classpath : /resource/
  ③ classpath : /static/
  ④ classpath : /public/
  ⑤ /
  ```

### 3. 默认映射的欢迎页

- 默认 : 欢迎页资源位置为 : 静态资源文件下/index.html

### 4. 默认网页图标设置

- 默认 : 网页图标位置 : 静态资源文件下/favorite.ico

### 5. 修改web资源默认配置

-  `org.springframework.boot.autoconfigure.web.servlet.WebMvcAutoConfiguration`
- 查看源码修改需要配置的信息

## 4.2 模板引擎 : thymeleaf

### 1. 引入thymeleaf启动器

```xml
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-thymeleaf</artifactId>
        </dependency>
```

### 2. thymeleaf默认规则

- 源码

  ```java
      public static final String DEFAULT_PREFIX = "classpath:/templates/";
      public static final String DEFAULT_SUFFIX = ".html";
  ```

  > 视图解析器 的前缀和后缀

### 3. thymeleaf语法规则

- 属性绑定
  -  <kbd>th:属性名称</kbd> : 可以替换HTML标签中的属性以及属性值
- 片段包含
  - <kbd>th:insert</kbd> : 
  - <kbd>th:replace</kbd> : 
- 语法格式
  - <kbd>th:each</kbd> : 
  - <kbd>th:if</kbd> : 
  - <kbd>th:unless</kbd> : 
  - <kbd>th:switch</kbd> : 
  - <kbd>th:case</kbd> : 
- 属性修改
  - <kbd>th:attr</kbd> : 
  - <kbd>th:attrprepend</kbd> : 
  - <kbd>th:append</kbd> : 
- 标签内如修改
  - <kbd>th:text</kbd> : 文本内容会被转义
  - <kbd>th:utext</kbd> : 文本内容不会被转义

### 4. thymeleaf表达式语法

```properties
基本表达式 : 
    ${} :--> 获取变量值,OGNL表达式
        :--> 使用内置基本对象 : #ctx;#vars;#locale;#request;#response;#session;#servletContext
        :--> 内置工具对象
    *{} :--> 功能和${}一样
        :--> 配合th:object使用,可以获取对象属性
    #{} :--> 获取国际化内容
    @{} :--> 定义url链接 : 可以拼接url参数
    ~{} :--> 片段引用表达式
字面量值 : 
字符串运算 :
布尔运算 :
比较运算 :
条件运算 :	
```

## 4.3 SpringMVC自动配置原理

### 1. 配置视图解析器

- 可以根据方法的返回值得多视图对象,自动配置的ViewResolver

  - ContentNegotiatingViewResolver : 组合所有的视图解析器

  - 自己给容器中添加视图解析器,并将自定义容器注册进Spring容器

    > 自定义视图解析器 : 实现ViewResolver接口即可

### 2. 静态资源映射和WebJars资源映射

### 3. 自动注册的转换器

- Conventer : 请求参数和属性映射时类型转换
- Fomatter : 格式化 ,可以转换日期类型
- 自定义格式化器 : 只需要将转换器注入Converter即可

### 4. 自动注册消息转换器

- HttpMessageConverter : 转换http消息 : 请求与相应

- 自定义消息转换器 : 需要将自定义组件注册进容器

### 5. 观察源码修改SpringBoot默认配置

- SpringBoot自动配置时候,首先会查看容器中有没有用户自定义的配置,如果没有才会自动配置,如果有些组件可以有多个,会将自定义组件和框架自带的完成自动配置

## 4.3 国际化

### 1. 定义国际化文件

- 文件规范 : properties文件

  ```text
  ① 默认的国际化文件 	 : 基础名.properties	
  ② 指定类型的国家文件 : 基础名_国家小写字母_语言大写字母.properties
  ```

  > key=value的形式设置国家级数据
  >
  > 同一基础名的key必须保持一致

### 2. 添加配置,使SpringBoot可以识别到国家化文件

- 配置信息

  ```yaml
  spring:
    messages:
      basename: 文件目录.基础名称
  ```

- 自动配置源码

  ```java
  MessageSourceAutoConfiguration自动配置类完成
  //默认的国家化文件名称
  private String basename = "messages";
  ```

### 3. 使用thymeleaf模板修改页面数据

- `#{}` 可以读取国际化文件中的配置
- `th:属性` : 通过标签可以完成属性修改
- `th:text` : 修改标签文本
- `[[#{}]]` : 读取标签之外的文本

### 4. 自定义国家化解析器

- 自定义解析器类 : 通过请求参数改变国家化效果

- Locale 对象表示是区域对象

- LocaleResolver 表示区域解析器

  ```java
  public class MyLocalResolver implements LocaleResolver {
      @Override
      public Locale resolveLocale(HttpServletRequest request) {
          String l = request.getParameter("l");
          Locale locale = Locale.getDefault();
          if (!StringUtils.isEmpty(l)){
              String[] s = l.split("_");
              locale = new Locale(s[0],s[1]);
          }
          return locale;
      }
  }
  ```

- 将自定义解析器配置到容器中

  ```java
      @Bean
      public LocaleResolver localeResolver(){
          return new MyLocalResolver();
      }
  ```

### 5. 修改通过请求参数改变国家化

```xml
<a class="btn btn-sm" th:href="@{/index.html(l='zh_CN')}">中文</a>
<a class="btn btn-sm" th:href="@{/index.html(l='en_US')}">English</a>
```

## 4.4 自定义拦截器

### 1.自定义拦截器类实现HandlerInterceptor接口

### 2. 将拦截器添加入拦截器栈

```java
@Bean
public WebMvcConfigurer webMvcConfigurer(){
    WebMvcConfigurer adapter = new WebMvcConfigurerAdapter() {
        @Override
        public void addInterceptors(InterceptorRegistry registry) {
            registry.addInterceptor(new LoginInterceptor()).addPathPatterns("/**")
                .excludePathPatterns("/","/index.html","user/login");
        }
    };
    return adapter;
}
```

## 4.5 SpringBoot默认错误处理机制

