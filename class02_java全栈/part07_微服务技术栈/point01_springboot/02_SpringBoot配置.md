# 第二章 SpringBoot配置

## 2.1 配置文件格式以及使用说明

### 1. application.properties

- 以`key = value` 的格式表示配置

### 2. application.yml

- **简介**

  - 是以数据为中心的一种配置文件

- **基本语法**

  ```yaml
  key: value
  ```

  > 冒号和value直接必须有一个空格
  >
  > 是以换行和空格缩进表示配置属性的层级关系 

- **值的属性格式**

  - 字面量值 : 直接书写

    - 双引号 : 不会转义字符串中的特殊字符
    - 单引号 : 会转义字符串中的特殊字符,一字符串的形式表示

  - 对象 (key: value)格式的值

    - 格式一 : 单行格式

      ```ml
      map: {key1: value1, key2: value2 ... ...}
      ```

    - 格式二 : 用缩进表示属性层级关系

      ```yaml
      map:
      	key1: value1
      	key2: value2
      	... ...
      ```

  - 数组 : 

    - 格式一 : 一行显示数组数据

      ```yaml
      arr: [value1,value2, ... ... valuen]
      ```

    - 格式二 : 逐行显示数据

      ```yaml
      arr:
      	- value1
      	- value2
      	... ...
      	- valuen
      ```

## 2.1 获取配置文件中数据

### 1. 配置文件的编码问题

- properties文件默认是ASCII
- 修改软件的配置文件格式 : `File Encoding`

### 2. 基本格式一 : @ConfigurationProperties

- 定义JavaBean : 属性和配置文件中的属性一一对应
- 将这个Bean 添加入Spring容器 : `@Component`
- 添加注解 : `@ConfigurationProperties(prefix = "属性层级入口")`
  - 配置前缀用于读取配置文件中的的第一层的属性之后的值

### 3. 基本格式二 : @Value

- 定义JavaBean : 属性和配置文件中的属性一一对应
- 将这个Bean 添加入Spring容器 : `@Component`
- 给这个bean的属性上添加 贴标签 : `@Value(${key})`

### 4. @Value和@ConfigurationProperties的区别

| 功能           | @Value       | @ConfigurationProperties    |
| -------------- | ------------ | --------------------------- |
| 注入方式       | 一个个的注入 | 可以批量注入属性            |
| 松散绑定(驼峰) | 不支持       | 支持                        |
| SpEL表达式     | 支持 `#{}`   | 不支持                      |
| JSR303         | 不支持       | 支持 `@Validate + 校验规则` |
| 复杂类型封装   | 不支持       | 支持                        |

## 2.2 加载配置文件

### 1. @PropertySource(value = {"classpath:其他配置文件"})

- 可以加载除了 : application之外的配置文件
- 需要指定前缀 : `@ConfigurationProperties(prefix = "属性前缀")`

- 只可以读取 : `properties`类型的文件

### 2. @ImportResource : 定义在主配置类上

- 导入Spring配置文件并使配置文件生效

### 3. SpringBoot推荐的配置组件的方式

- 定义一个配置类 : `@Configuration` 标注
- 定义方法 : 方法返回值为需要注入的组件,然后new一个对象并返回
- @Bean注解 标注这个方法 : 将方法的返回值添加到容器中
  - **组件的默认ID是方法名**

## 2.3 配置文件占位符

### 1. 占位符定义随机数

- ${random.value}
- ${random.int(value,[max])}
- ${random.long}
- ${random.uuid}

### 2. 属性绑定与默认值

- 属性绑定 : 可以调用在之前定义好的属性值

  ```yaml
  ${key}
  ```

- 属性默认值 

  ```yaml
  ${属性key:默认值}
  ```

  > 如果属性key不存在,则将表达式整体输出
  >
  > 如果属性key不存在,如果设置的默认值,则输出默认值

## 2.4 profile多环境支持

### 1. 定义多个 - profile文件

- 文件格式 : `application-profile标识.yml`

- 默认使用的是 : `application.yml`的配置文件

- 指定激活指定profile文件 

  ```yml
  spring: 
  	profile: 
  		active: profile标识
  ```

### 2. 多文档块 : profile文档块

- 在同一文件中 : `---` 标识文档分隔符

- 定义每个文档的profile标识

  ```yaml
  spring: 
  	profiles: profile文档标识
  ```

- 默认使用第一个文档中的环境

- 指定激活指定profile文档

  ```yaml
  spring: 
  	profile: 
  		active: profile文档标识
  ```

### 3. 使用命令行的方式指定profile

```sh
--spring.profile.active=profile文档标识
```

> 在启动项目时候配置的参数

### 4. 打包部署时候使用命令行参数

```sh
java -jar xxx --spring.profile.active=profile文档标识
```

### 5. 定义虚拟机参数

```sh
-Dspring.profile.active=profile文档标识
```

## 2.5 SpringBoot配置文件加载路径顺序

- SpringBoot会扫描默认配置文件

  ```properties
  ① : /config/application.yml
  ② : /application.yml
  ③ : classpath/config/application.yml
  ④ : classpath/application.yml
  ```

  > 优先级从高到低的排序
  >
  > 优先级高的配置内容会覆盖优先级低的配置内容

- 修改默认的配置文件位置

  ```properties
  spring.config.location=配置文件的位置
  ```

  > 是在启动项目时候以命令行参数的方式指定 , 和项目的配置文件形成互补配置

## 2.6 外部配置的加载顺序

1. 命令行参数
   - 所有的配置都可以在命令行上进行指定；
   - 多个配置用空格分开； –配置项=值
2. 来自java:comp/env的JNDI属性 
3. Java系统属性（System.getProperties()） 
4. 操作系统环境变量 
5. RandomValuePropertySource配置的random.*属性值
6. jar包外部的application-{profile}.properties或application.yml(带spring.profile)配置文件
7. jar包内部的application-{profile}.properties或application.yml(带spring.profile)配置文件
8. jar包外部的application.properties或application.yml(不带spring.profile)配置文件 
9. jar包内部的application.properties或application.yml(不带spring.profile)配置文件

## 2.7 自动配置原理

