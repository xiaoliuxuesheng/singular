# 前言

:anchor: Gradle特点

- 最新的, 功能强大的构建工具

  > 可以完成Maven和Ant所有功能
  >
  > 是使用程序代替xml配置, 构建灵活
  >
  > 是一门程序语言又非常多的第三方插件

- 完善开发技术体系, 提示自动化构建技术深度

- 进阶高级开发工程师

# 第一章 Gradle介绍与环境搭建

## 1.1 Gradle相关介绍

:anchor: 领域特定语言DSL : **求专不求全**

- 特定领域的专用语言
- 使用范围小, 功能专一

:anchor: Groovy 编程语言

- 是一种基于JVM的敏捷开发语言
- 结合Python, Ruby等脚本语言的有许多强大特性
- Groovy可以和Java完美结合 - 而且可以使用Java的所有的库

:anchor: Groovy 语言特性

- 语法上支持动态类型, 闭包等新一代语言特性
- 无缝集成所有已存在的Java类库
- 支持面向对象编程, 也支持面向过程编程

:anchor: Groovy 优势

- 更加敏捷的编程语言 : 非常多的语法糖
- 入门非常容器 , 功能非常强大
- 既可以用作编程也可以用作编写脚本

## 1.2 开发坏境搭建

:anchor: Groovy 基于JVM : 需要安装JDK

:anchor: Groovy的快捷搭建 : [Groovy官网](http://www.groovy-lang.org)

- Mac系统的Groovy安装 : 解压并配置`~/bin`坏境变量
- Win系统的Groovy安装 : 解压并配置`~/bin`坏境变量

:anchor: IDEA开发坏境的Groovy环境配置

- 开启IDEA的Groovy插件
- 创建Groovy工程 : 选择本地的Groovy坏境

# 第二章 Gradle核心语法

## 2.1 Groovy基础语法

### :anchor: 变量

1. **变量的类型**

   - Groovy中的变量的类型本质上都是对象类型
   - Groovy中的基本类型本质是基本类型的包装类

2. **变量的定义** : *建议使用强类型定义变量*

   - **强类型定义** : 定义变量时候指定了变量的类型

     ```groovy
     变量类型 变量名 = 变量值 			# 定义方式与Java变量定义方式相同
     ```

   - **弱类型定义** `关键字 : def`: 可以根据变量值推算出变量的类型

     ```groovy
     def 变量名称 = 变量值
     ```

3. **Sting与GString类型**

   - String类型的使用与Java中String类使用相同

   - GString定义的方式

     | 定义方式 | 使用说明                                   |
     | -------- | ------------------------------------------ |
     | 单引号   | 普通无格式字符串                           |
     | 双引号   | 可扩展字符串 : 可以使用`${}`引用变量表达式 |
     | 三单引号 | 格式化输出字符串                           |

### :anchor: Groovy中String方法

> java.lang.String
>
> DefaultGroovyMethods
>
> StringGroovyMethods

:one: 普通类型参数的方法

- String类的方法

- StringGroovyMethods的方法

  | API                                                          | 使用说明   |
  | ------------------------------------------------------------ | ---------- |
  | center(CharSequence self, Number numberOfChars)              | 字符串填充 |
  | padRight(CharSequence self, Number numberOfChars, CharSequence padding) | 右填充     |
  | padLeft(CharSequence self, Number numberOfChars, CharSequence padding) | 左填充     |
  | String capitalize(CharSequence self)                         | 首字母大写 |
  | getAt(String text, int index)                                | 获取子串   |
  | string[]   或者   string[开始索引..结束索引]                 |            |
  | reverse(CharSequence self)                                   | 反转字符串 |
  | is包装类型(CharSequence self)                                | 类型判断   |

:two: 闭包类型参数方法

- StringGroovyMethods的方法

  | API  | 使用说明 |
  | ---- | -------- |
  |      |          |

###  :anchor: Groovy语句

**:one: 顺序语句**

**:two: 条件逻辑** 

- if/else

- switch/case : 可以传入任意类型变量和`case`匹配

  ```txt
  case 字符串
  case List
  case 范围   			# 范围[范围开始..范围介绍]
  case 指定数据的类型
  ```

**:three: 循环语句**

- while循环

- for循环 : in表达式

  ```groovy
  for(变量 in 范围){
      
  }
  ```

  ```groovy
  for(变量 in [集合]){
      
  }
  ```

  ```groovy
  for(变量 in [map]){
      
  }
  ```

## 2.2 Groovy闭包

###  :anchor: 闭包基础

:one: **闭包的概念 :** 闭包的本质就是一段代码块

:two: **闭包的定义与使用**

- 定义基本闭包 : {}

  ```groovy
  def 闭包名称 = {}
  ```

- 闭包的调用

  ```groovy
  # 方式一 : 调用闭包函数
  	闭包名称.call()	
  # 方式二 : 直接使用闭包函数
  	闭包名称()
  ```

:three: **闭包的参数**

- 定义闭包参数格式

  ```groovy
  def 闭包名称 = { 参数类型 参数名称, ... ... ->
      # 闭包体
  }
  ```

  > 多个参数用逗号分隔

- 闭包参数传递

  ```groovy
  闭包名称(实际参数)
  ```

- 闭包的默认参数 : 如果闭包中没有定义参数, 则该闭包会有一个默认参数 **it**

:four: 闭包的返回值

- 闭包返回值需要使用`return`关键字声明闭包的返回
- 闭包的默认返回值是null

## 2.3 Gradle常见数据结构

## 2.4 Gradle面向对象特性

# 第三章 Gradle高级用法

## 3.1 json文件处理

## 3.2 xml文件读取和生成

## 3.3 普通文件的读写

## 3.4 网络请求json转换

## 3.5 文件下载功能

# 第四章 Gradle核心 - Project 

## 4.1 Project类核心作用

## 4.2 核心API讲解

## 4.3 Gradle生命周期流程

## 4.4 版本统一管理脚本编写

# 第五章 Gradle核心 - Task

## 5.1 Task定义和使用

## 5.2 Task依赖输入和输出

## 5.3 Task修改默认构建流程

# 第六章 Gradle核心 - 其他模块

## 6.1 第三方库依赖管理

## 6.2 工程初始化核心类Setting类作用

## 6.3 源码管理类SourceSet讲解

# 第七章 Gradle核心 - 自定义插件

## 7.1 插件类Pluging的定义和使用

## 7.2 Gradle 如何管理插件的依赖

# 第八章 Gradle修改默认打包流程

## 8.1 Android 和 Java的打包流程

## 8.2 将脚本嵌入到打包流程

## 8.3 打包流程核心Task