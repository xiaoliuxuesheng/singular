# 第一章 GraphQL介绍

## 1.1 基本介绍

- 由Facebook提出的 **应用层查询语言** : 客户端就可以请求所需要的数据集
  - 用于 API 的查询语言，是一个在运行时使用基于类型系统来执行查询的服务端
- 解决了管理REST API中的最大的问题 : 客户端数据需求和响应是固定的
  - GraphQL 服务是通过定义类型和类型上的字段来创建的
- GraphQL是一个规范 : 它可以用于任何平台或语言

# 第二章 搭建GraphQL学习环境

## 2.1 基于SpringBoot

> ① 首先构建基于SpringBoot的Rest请求接口
>
> ② 再使用GraphQL查询API实现与Rest同样的功能

### 1. SpringBoot环境依赖

```xml
<!-- ① SpringBoot相关 -->   
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-test</artifactId>
            <scope>test</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-devtools</artifactId>
            <scope>runtime</scope>
            <optional>true</optional>
        </dependency>

<!-- ② Web支持 -->
		<dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>

<!-- ③ MySQL数据源 -->
        <dependency>
            <groupId>org.mybatis.spring.boot</groupId>
            <artifactId>mybatis-spring-boot-starter</artifactId>
            <version>2.0.1</version>
        </dependency>
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>com.alibaba</groupId>
            <artifactId>druid</artifactId>
            <version>1.1.10</version>
        </dependency>

<!-- 其他工具 -->
        <dependency>
            <groupId>org.projectlombok</groupId>
            <artifactId>lombok</artifactId>
            <optional>true</optional>
        </dependency>

```

### 2. mybatis相关配置

```yaml
spring:
  datasource:
    driverClassName: com.mysql.cj.jdbc.Driver
    url: jdbc:mysql://localhost:3306/case-project?serverTimezone=UTC
    username: root
    password: root


mybatis:
  typeAliasesPackage: com.graphql
  mapperLocations: classpath:mapper文件的路径
  config-location: classpath:mybatis配置文件的路径


logging:
  level:
    日志管理的包名: debug
```

### 3. 基于Mybatis的基本操作

- 使用Rest请求实现基本的增删改查

### 4. 添加GraphQL场景启动器依赖

```xml
        <dependency>
            <groupId>com.graphql-java</groupId>
            <artifactId>graphql-spring-boot-starter</artifactId>
            <version>4.0.0</version>
        </dependency>
        <dependency>
            <groupId>com.graphql-java</groupId>
            <artifactId>graphql-java-tools</artifactId>
            <version>4.3.0</version>
        </dependency>
```

### 5. 添加GraphQL配置

```yaml
graphql:
  servlet:
    mapping: /graphql
    enabled: true
    corsEnabled: true
```

### 6. 定义GraphQL分析器

- **查询 : QueryResolver**  : 实现 GraphQLQueryResolver接口

  ```java
  @Component
  public class EmployeeQueryResolver implements GraphQLQueryResolver {
      
      @Autowired
      private EmployeeService employeeService;
  
      EmployeeEntity queryEmpById(String id) {
          return employeeService.selectEmpById(id);
      }
  
      boolean deleteEmployeeById(String id) {
          return employeeService.deleteEmployeeById(id);
      }
  
      public List<EmployeeEntity> empList(EmployeeRequest request) {
          return employeeService.empList(request);
      }
  }
  ```

  ```java
  type Query {
      queryEmpById (id: String ):EmployeeEntity
      empList(request: EmployeeRequest ):[EmployeeEntity]
  }
  type EmployeeEntity{
      id: String
      name: String
      password: String
      birthday: String
      card: String
      salary: String
  }
  input EmployeeRequest{
      id:String
      name: String
      card:String
      minAge:Int
      maxAge:Int
  }
  ```

- **更新 : MutationResolver** : 需要实现GraphQLMutationResolver接口

  ```java
  @Component
  public class EmployeeMutationResolver implements GraphQLMutationResolver {
      @Autowired
      private EmployeeService employeeService;
  
      boolean deleteEmployeeById(String id) {
          return employeeService.deleteEmployeeById(id);
      }
  }
  ```

  ```java
  type Mutation {
      deleteEmployeeById(id: String!):Boolean
  }
  ```

### 7.Graphql API测试



## 2.2 基于Node

# 第三章 GraphQL类型系统

# 第四章 GraphQL API

## 4.1 Query:查询

## 4.2 Mutation:更新









# 1. 请求字段 - Fields

- Graphql服务根据请求的字段可以做出不同的响应

- ▲ 案例

  - 定义服务端数据

    ```json
    {
      "data": {
        "hero": {
          "name": "R2-D2",
          "friends": [
            {
              "name": "Luke Skywalker"
            },
            {
              "name": "Han Solo"
            },
            {
              "name": "Leia Organa"
            }
          ]
        }
      }
    }
    ```

  - 请求字段 : name

    | 请求                                                      | 响应                                                         |
    | --------------------------------------------------------- | ------------------------------------------------------------ |
    | {<br />     hero {<br />         name<br />     }<br /> } | {<br />   "data": {<br />     "hero": {<br />        "name": "R2-D2"<br />     }<br />   }<br />  } |

# 2. 参数 - Arguments

- 在 GraphQL 中，每一个字段和嵌套对象都能有自己的一组参数

- 参数的定义方式

  ```json
  {
    human(id: "1000") {
      name
      height
    }
  }
  ```

# 3. 别名 - Aliases

- 再一次查询期间 , 如果因为参数不同而需要不同的响应结果 , 可以为响应结果定义别名

- 别名的定义方式 : 给需要别名的属性字段前添加

  ```json
  {
    别名1: hero(episode: EMPIRE) {
      name
    }
    别名2: hero(episode: JEDI) {
      name
    }
  }
  ```

# 4. 片段 - Fragments

- GraphQL 包含了称作**片段**的可复用单元。片段使你能够组织一组字段，然后在需要它们的的地方引入

- 经常用于将复杂的应用数据需求分割成小块

- 片段的定义 : 在查询外定义

  ```json
  fragment 片段名称 on 该片段所属的类型(属性的真实类型){
  	片段字段1
      片段字段2
  }
  ```

- 片段的引用

  ```json
  属性{
        ...片段名称
  }
  ```

  > 片段定义时候的真实类型就是引用**片段属性的**真实类型

# 5. 操作名称 - Operation name

- **操作类型** : 描述你打算做什么类型的操作

  - **query** : 查询 (缺省是query)
  - **mutation** : 修改
  - **subscription** : 消息订阅

- **操作名称** : 是你的操作的有意义和明确的名称

  ```json
  操作类型 操作名称 {
    hero {
      name
      friends {
        name
      }
    }
  }
  ```

  

# 6. 变量 - Variables

- 查询时候字段的参数可能是动态的 , 

  - 客户端需要动态地在运行时操作这些查询字符串，再把它序列化成 GraphQL 专用的格式

- 使用变量的三个步骤

  1. 使用变量替换查询时候的参数名称 : 查询中变量提前表示变量的定义

     - 变量的基本定义

       ```json
       query 查询名称($变量名: 变量类型) {
         
       }
       ```

     - 为变量指定默认值

       ```json
       query 查询名称($变量名: 变量类型 = 默认值) {
         
       }
       ```

     > 变量定义的前缀必须是 : <kbd>**$**</kbd>

  2. 使用查询参数接受变量值 : 查询中变量置后表示接收变量值

     ```json
     query 查询名称($变量名: 变量类型) {
       hero(episode: $变量名) {
        
       }
     }
     ```

  3. 变量值的传输 : 通过专用的变量字典

     ```json
     {
       "变量名": "变量值"
     }
     ```

# 7. 指令 - Directives

- 一个指令可以附着在字段或者片段包含的字段上，然后以任何服务端期待的方式来改变查询的执行

- 指定的说明

  - `@include(if: Boolean)` 仅在参数为 `true` 时，**包含此字段**
  - `@skip(if: Boolean)` 如果参数为 `true`，**跳过此字段**

- 指令的使用方式

  ```json
  操作方式 操作名称 {
    hero{
      friends @include(if: true | false) {
        name
      }
    }
  }
  ```

# 8. 变更 - Mutations

- GraphQL中约定 : 任何写入操作的操作类型统一为 `mutation`

- 使用格式

  - 定义变更字段

    ```json
    mutation 操作名称($ep: Episode!, $review: ReviewInput!) {
      createReview(episode: $ep, review: $review) {
        stars
        commentary
      }
    }
    ```

  - 定义参数

    ```json
    {
      "ep": "JEDI",
      "review": {
        "stars": 5,
        "commentary": "This is a great movie!"
      }
    }
    ```

# 9. 内联片段 - Inline Fragments

- 定义接口和联合类型的能力

  - 如果你查询的字段返回的是接口或者联合类型，那么需要使用**内联片段**来取出下层具体类型的数据

- 使用格式

  ```json
  查询类型 查询名称 {
    hero {
      ... on 类型一 {
        primaryFunction
      }
      ... on 类型二 {
        height
      }
    }
  }
  ```

  > 如果符合对应类型 : 则对应的字段会显示对应的值

# 10. 元字段

- 在查询的任何位置请求 `__typename`，一个元字段，以获得那个位置的对象类型名称





==GraphQL 类型系统作用 : 如何描述可以查询的数据==

# 3.1 类型系统

> - 每一个 GraphQL 服务都会定义一套类型，用以描述你可能从那个服务查询到的数据。
> - 每当查询到来，服务器就会根据 schema 验证并执行查询

## 1. 对象类型 : type

- ==定义schema中的普通类型==

  ```java
  type 类型名称{
      字段: 标量
  }
  ```

## 2. 枚举类型 : enum

- 定义枚举类型

  ```java
  enum 枚举类型名称{
      枚举值
  }
  ```

## 3. 接口类型 : interface

- **接口**是一个抽象类型，它包含某些字段，而对象类型必须包含这些字段，才能算实现了这个接口

- 定义接口

  ```java
  interface 接口名称{
      共用的字段
  }
  ```

- 实现接口

  ```java
  type 类型名称 implements 接口名称{
      特有的字段
  }
  ```

## 4. 联合类型 : union

- 不指定类型之间的任何共同字段

- 联合类型的成员需要是具体对象类型；你不能使用接口或者其他联合类型来创造一个联合类型

- 定义联合类型

  ```java
  union 联合类型名称 = 普通类型1 普通类型2 ... ...
  ```

## 5. 输入类型 : input

- 变更（mutation）中 : 需要传递一整个对象作为新建对象

- 定义输入格式 : 和普通格式定义方式一样 : 关键字是input

  ```java
  input 输入类型名称{
      类型的字段
  }
  ```

# 3.2 类型语言

- ==GraphQL 服务可以用任何语言编写，因为我们并不依赖于任何特定语言的句法句式==

## 1. 字段与标量

- **字段的定义**

  ```java
  type 类型名称{
      字段1: 字段标量
      字段2: 字段标量
      ... ...
  }
  ```

  > - 多个字段用空格分隔即可
  > - 字段标量可以是系统自带也可以是自定义类型

- **字段标量**

  | 标量名称 | 标量说明            |
  | -------- | ------------------- |
  | ID       | 表示一个唯一标识符  |
  | Int      | 有符号 32 位整数。  |
  | Float    | 有符号双精度浮点值  |
  | String   | UTF‐8 字符序列      |
  | Boolean  | `true` 或者 `false` |

## 2. 字段与参数

- 象类型上的每一个字段都可能有零个或者多个参数

- 定义普通参数

  ```java
  type 类型名称{
      字段1(参数名: 参数标量): 字段标量
  }
  ```

- 定义默认参数

  ```java
  type 类型名称{
      字段1(参数名: 参数标量 = 默认值): 字段标量
  }
  ```

## 3. 字段与约束

- 非空约束 : ! 感叹号 

  ```java
  type 类型名称{
      字段1(参数名: 参数标量): 字段标量!
  }
  ```

  > 在字段标量后添加感叹号 表示该字段的被非空约束

- 数组

  ```java
  type 类型名称{
      字段1(参数名: 参数标量): [字段标量]
  }
  ```

  > 一对中括号的字段标量表示该字段是一个指定类型的数组





# 4.1 验证

- ==让服务器和客户端可以在无效查询创建时就有效地通知开发者，而不用依赖运行时检查==

# 4.2 执行

- 查询在被验证后，GraphQL 服务器会将之执行，并返回与请求的结构相对应的结果，
- 该结果通常会是 JSON 的格式

# 4.3 内省

- 内省系统 : 获取GraphQL Schema 它支持哪些查询
- 通过查询 `__schema` 字段来向 GraphQL 询问哪些类型是可用的

