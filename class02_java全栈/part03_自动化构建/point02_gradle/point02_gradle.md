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

- String类的基本方法:同Java的String类

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

-----

6-1 gradle概述

1. gradle概念
    - gradle是AndroidStudio的默认构建工具
2. gradle作用呢
    - gradle是一种编程框架
    - gradle有独立的语法、API、build script 包
3. gradle优势
    - 灵活：
    - 粒度：可以独立的定制构建task
    - 扩展：可以自定义插件和使用第三方插件
    - 兼容：兼容maven和alt项目

6-2 gradle生命周期-执行流程

1. gradle执行过程
    - Initialization：初始化阶段 - 解析整个工程中虽有Project对应的project对象
    - Configuration：配置阶段 - 解析所有project对象中的task，构建好所有task的拓补图
    - Execution：执行阶段 - 执行具体的task以及依赖的task

6-3 测试监听执行流程

1. 配置阶段开始前的监听回调

    ```groovy
    this.beforeEvaluate {}
    this.gradle.beforeProject {}
    ```

2. 配置阶段完成后的回调

    ```groovy
    this.afterEvaluate {}
    this.gradle.afterProject {}
    ```

3. 执行完毕后回调监听

    ```groovy
    this.gradle.buildFinished {}
    ```

7-1 project详解

1. project概述
    
    - 在Idea的项目结构有根工程为Project，子项目成为Module；对于Gradle项目而言，根项目是一个project，一个个的子项目也被成为一个project。
    
        > 根project称为:rootProject 
        >
        > 其他project称为subProject
    
    - 一个Project对应一个build.gradle配置文件，project是由build.gradle文件进行配置和管理
    
    - 实际开发中gradle项目的project最多定义两级
    
    - 一个子project对应一个输出，

7-2 gradle核心API

1. API分类
    - gradle生命周期相关
    - project相关：管理根project与subProject
    - task相关：新增和管理已有的task的能力
    - 属性相关：属性的使用与定义
    - file相关：操作gradle项目下的文件的处理
    - 其他API：依赖+外部配置

7-3 project相关APi

1. 查看项目中的所有project,树的形式保存

    ```groovy
    this.getAllprojects()		// 获取所有Project
    this.getSubprojects()		// 获取当前Project的子Project
    this.getParent()			// 获取当前Project的父Project
    this.getRootProject()		// 获取当前项目的根Project
    ```

7-4 project相关的API

1. 通过API管理Project:为project指定特殊配置, 三个函数作用范围不同

    ```groovy
    project("project名称") {}		// 获取指定名称的project,并添加配置
    allprojects {}				 // 获取全部的project并为所有Project添加配置
    subprojects {}				 // 为当前project所有的子project添加配置,不包括当前工程
    ```

    ```groovy
    apply from:'引入其他groovy文件'
    ```

7-5 属性相关api

1. gradle内置属性

    ```groovy
    String DEFAULT_BUILD_FILE = "build.gradle";		// 默认的构建文件
    String PATH_SEPARATOR = ":";					// 路径分隔符
    String DEFAULT_BUILD_DIR_NAME = "build";		// 默认的输出文件
    String GRADLE_PROPERTIES = "gradle.properties";	// 默认的属性配置文件
    ```

2. gradle扩展属性 - 方式一:扩展属性

    - 常量改为变量 的等价方式

    - 扩展属性

        ```groovy
        // 定义扩展属性
        ext{
            属性名称: 值
        }
        
        // 引入扩展属性
        this.属性名称
        ```

    - 可以将扩展属性定义在指定的project中

        ```groovy
        // 表示为所有子project中定义一个:在编译时候所有的子project都会定义一遍扩展属性
        subproject{
            ext{
                属性名称:值
            }
        }
        ```

    - 扩展属性定义在根工程,在其他子project中直接引用,父project中的属性都会被子project继承

        ```groovy
        // 在根project中定义扩展属性
        ext{
            属性名称:值
        }
        
        // 在其他project中引用
        this.属性名称
        ```

    - 将扩展属性单独定义在groovy文件中

        ```groovy
        // 在独立的groovy中定义扩展属性
        ext{
            属性名:值
        }
        ```

        ```groovy
        // 根project中引入外部文件
        apply from: this.file("外部文件名称")
        
        // 引用扩展属性
        rootProject.ext.属性名
        ```

3. gradle扩展属性 - 方式二:gradle.properties  属性配置文件

    ```properties
    # 定义gradle.properties的配置文件,是key value的格式,
    key=value
    ```

    - value是字符串的格式
    - 自定义属性不可以和已有方法重复,编译不会保存,使用会出现异常

    ```groovy
    // groovy中可以直接获取配置文件中的值
    hasProperty("key")		// 判断是否有指定key
    key						// 可以使用使用key得到value
    ```

7-7 file相关API

1. 路径获取API

    ```groovy
    // 获取根工程目录的路径
    File getRootDir()
    
    // 获取构建目录的路径
    File getBuildDir()
    
    // 获取当前工程目录路径
    File getProjectDir()
    ```

2. 文件操作-定位

    ```groovy
    File file(Object path);
    ConfigurableFileCollection files(Object... paths);
    ```

3. 文件操作-拷贝

    ```groovy
    copy {
        from files("目标文件目录")
        into 拷贝目的地
        exclude{
            排序不需要的拷贝文件
        }
        rename{
            重命名
        }
    }
    ```

4. 文件操作-遍历

    ```groovy
    fileTree("build/"){ FileTree fileTree ->
        fileTree.visit {
            FileTreeElement element ->
                println element.file.name
        }
    }
    ```

7-8 其他类型API

1. 依赖相关API

    ```groovy
    buildscript { ScriptHandler handler ->
        // 配置工程仓库地址
        handler.repositories { RepositoryHandler repositories ->
            repositories.mavenCentral()
            repositories.mavenLocal()
            repositories.maven {MavenArtifactRepository artifactRepository ->
                artifactRepository.name '仓库名称'
                artifactRepository.url '内部仓库地址'
            }
        }
        // 配置工程插件依赖地址:gradle本身就是框架,这里是框架的插件
        handler.dependencies {DependencyHandler dependencyHandler ->
    
        }
    }
    ```

2. Project.

3. 外部命令执行API