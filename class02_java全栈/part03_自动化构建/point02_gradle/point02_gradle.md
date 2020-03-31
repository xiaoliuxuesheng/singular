# 前言

:anchor: Gradle特点

- 最新的, 功能最强大的构建工具

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

### :anchor: Groovy中String方法

> java.lang.String
>
> DefaultGroovyMethods
>
> StringGroovyMethods

:one: Strng定义格式

| 定义方式 | 使用说明                                   |
| -------- | ------------------------------------------ |
| 单引号   | 普通无格式字符串                           |
| 双引号   | 可扩展字符串 : 可以使用`${}`引用变量表达式 |
| 三单引号 | 格式化输出字符串                           |

> 双引号字符串中使用了扩展表达式则该字符串会转为GStringImpl类型
>
> String 和 GStringImpl作为参数可以相互替换和相互调用

:two: Groovy对String的扩展

- StringAPI来源一：String类的基本方法:同Java的String类

- StringAPI来源二：DefaultGroovyString是Groovy对所有方法的扩展

- StringAPI来源三：**StringGroovyMethods**的方法是对String的扩展，重写了DefaultGroovyString的方法，普通类型参数方法

  - **字符串填充**

    ```groovy
    println "aaa".center(5,"c")			// caaac
    println "aaa".padLeft(5,"c")		// ccaaa
    println "aaa".padRight(5,"c")		// aaacc
    ```

  - **首字母大写**

    ```groovy
    println "aaa".capitalize()			// Aaa
    println "abc abb cdd" - "abb"		// abc  cdd
    ```

  - **字符串比较**

    ```groovy
    println "abc" > "abb"				// true
    ```

  - **获取子串**

    ```groovy
    println "abcd".getAt(3)
    println "abcd"[3]
    println "abcd"[1..3]
    ```

  - **String其他API**

    ```groovy
    println "abcd".reverse()			// dcba
    println "abcd".capitalize()			// Abcd
    println "1234".toInteger()			// 1234
    ```

- StringAPI来源四：**StringGroovyMethods**闭包类型参数方法（查看闭包使用详解）

### :anchor: Groovy语句

**:one: 顺序语句**

**:two: 条件逻辑** 

- if

- if - else

- if - else if

- if - else if -else

- switch/case : 可以传入任意类型变量和`case`匹配

  ```groovy
  switch (a) {
      case 11:
          result = 1
          break
      case "string":
          result = "string"
          break
      case ["list"]:
          result = ["list"]
          break
      case 10..20:
          result = 10..20
          break
      default: result = "default"
  }
  ```

**:three: 循环语句**

- while循环

- for循环 

  - for - i 格式循环

    ```groovy
    for (int i = 0; i < 20; i++) {
        sum1 += i
    }
    ```

  - for - in 格式循环列表

    ```groovy
    for (i in 10..20){
        sum2 += i
    }
    ```

  - for - in 格式循环map

    ```groovy
    for (i in ["key":"value"]){
        i.key + i.value 
    }
    ```

## 2.2 Groovy闭包

### :anchor: 闭包基础

:one: **闭包的概念 :**

- 闭包的概念：闭包的本质就是一段代码块

- 闭包的定义

  ```groovy
  def 闭包名称 = {}		
  ```

- 闭包的调用

  ```groovy
  闭包名称.call()			// 方式一 : 调用闭包函数
  闭包名称()				// 方式二 : 直接使用闭包函数
  ```

:two: **闭包参数**

- 定义闭包参数格式

  ```groovy
  def 闭包名称 = { 参数类型 参数名称, ... ... ->
      // 闭包体
  }
  ```

  > 多个参数用逗号分隔

- 定义闭包时指定参数默认值

  ```groovy
  def 闭包名称 = { 参数类型 参数名称 = 默认值 ->
      // 闭包体
  }
  ```

- 闭包的默认参数 : 如果闭包中没有定义参数, 则该闭包会有一个默认参数 **it**，如果为闭包指定参数后，默认参数则失效

  ```groovy
  def 闭包 = {
      // 闭包体
      println it
  }
  ```

:three: **闭包的返回值**

- 闭包返回值需要使用`return`关键字声明闭包的返回
- 闭包的默认返回值是null

:four: **闭包的变形写法：闭包作为方法参数**

- 闭包作为参数，向闭包传递参数的格式是根据源码中闭包调动时决定的

- 如果闭包是方法中唯一的形式参数，调用方法时方法的圆括号可以不写，

  ```groovy
  number.times() {
      n -> sum += n
  }
  // 或者
  number.times {
      n -> sum += n
  }
  ```

- 如果闭包是参数的最后一个，闭包的大括号`{}`可以写在方法圆括号`()`外面

  ```groovy
  number.times {
      n -> sum += n
  }
  ```

### :anchor: 闭包使用详解

:one: **与基本类型的结合使用**

- upto方法源码：对Integer数求阶乘

  ```groovy
  public static void upto(Number self, Number to, @ClosureParams(FirstParam.class) Closure closure) {
      int self1 = self.intValue();
      int to1 = to.intValue();
      if (self1 > to1) {
          throw new GroovyRuntimeException("The argument (" + to + ") to upto() cannot be less than the value (" + self + ") it's called on.");
      } else {
          for(int i = self1; i <= to1; ++i) {
              closure.call(i);
          }
  
      }
  }
  ```

- times：累加操作

  ```groovy
  public static void times(Number self, @ClosureParams(value = SimpleType.class,options = {"int"}) Closure closure) {
      int i = 0;
      for(int size = self.intValue(); i < size; ++i) {
          closure.call(i);
          if (closure.getDirective() == 1) {
              break;
          }
      }
  }
  ```

:two: **与String结合使用**

- each：遍历字符串

  ```groovy
  public static <T> T each(T self, Closure closure) {
      each(InvokerHelper.asIterator(self), closure);
      return self;
  }
  ```

- find

  ```groovy
  public static Object find(Object self, Closure closure) {
      BooleanClosureWrapper bcw = new BooleanClosureWrapper(closure);
      Iterator iter = InvokerHelper.asIterator(self);
      Object value;
      do {
          if (!iter.hasNext()) {
              return null;
          }
          value = iter.next();
      } while(!bcw.call(new Object[]{value}));
      return value;
  }
  ```

- any：判断是否包含则返回true

- every：每箱都符合条件后返回true

- collect：遍历字符并处理后返回一个集合

:three: **与数据结构结合使用**

:four: **与文件结合使用**

### :anchor: 闭包进阶

:one: **闭包关键变量**

- this：代表闭包定义处的类

  - 如果定义在类中或内部类中，则会指向最近的类对象，并且this、owner、delegate都是指向同一个对象

- owner：代表闭包定义处的类或者对象，闭包可以嵌套定义闭包

  - 如果是定义闭包中的闭包，owner会执行最近的闭包对象

- delegate：delegate默认是和owner是一样的，delegate对象可以手动修改

  ```groovy
  内部闭包名.delegate = 其他对象
  ```

:two: **闭包委托策略**

- 闭包默认的委托策略就是：OWNER_FIRST

  ```groovy
  闭包.delegate = Closure.OWNER_FIRST	// 以Owner优先
  ```

- 修改闭包委托策略：

  ```groovy
  闭包.delegate = Closure.OWNER_FIRST	// 以Delegate优先
  ```

- 其他委托策略

  ```groovy
  public static final int OWNER_FIRST = 0;	//	
  public static final int DELEGATE_FIRST = 1;	//	
  public static final int OWNER_ONLY = 2;		//	仅仅owner
  public static final int DELEGATE_ONLY = 3;	//	仅仅delegate
  ```

## 2.3 Gradle常见数据结构

### ⚓️ Groovy列表



### ⚓️ Groovy映射

### ⚓️ Groovy范围

## 2.4 Gradle面向对象特性

# 第三章 Gradle高级用法

## 3.1 json文件处理

## 3.2 xml文件读取和生成

## 3.3 普通文件的读写

## 3.4 网络请求json转换

## 3.5 文件下载功能

# 第六章 Gradle概述

## 6.1 gradle基本概述

1. gradle是Java项目的一种构建工具
2. gradle是AndroidStudio的默认构建工具
3. gradle可以看做是一个编程框架：gradle包含有groovy语法；build scrpt block（定制化的构建代码块）；自身还有独立的API

## 6.2 gradle优势

1. 灵活性：可以自定义构建过程
2. 粒度：可以独立定制构建任务（task）
3. 扩展：可以包含自定义插件和使用第三方插件
4. 兼容性：兼容Maven和Ant所有的构建功能

## 6.3 gradle生命周期

### :anchor: Initialization：初始化阶段

> 解析整个工程中所有Project对应的project对象，根project以及相关的子project；

- 初始化阶段监听方法

  ```groovy
  this.beforeEvaluate {}
  this.gradle.beforeProject {}
  
  ```

### :anchor: Configuration：配置阶段

> 解析所有project对象中的task，构建好所有task的拓补图

- 配置阶段监听方法

  ```groovy
  this.afterEvaluate {}
  this.gradle.afterProject {}
  
  ```

### :anchor: Execution：执行阶段

> 执行具体的task以及依赖的task：每个gradle命令本质都是一个task，执行这个task需要先执行这个task相关联的其他task，相关联的task是在这个阶段执行完成

- 执行阶段完成的监听回调方法

  ```groovy
  this.gradle.buildFinished {}
  
  ```

# 第七章 Gradle核心API

## 7.1 Project核心API

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

## 7.2 属性相关API

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



## 7.3 文件相关API

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



## 7.4 其他API

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

# 第八章 Gradle核心-Task

## 8.1 Task的定义及配置

:anchor: 当前Project中的所有Task

```sh
gradle tasks

```

:anchor: 定义Task

1. 格式一 : 使用Task函数定义`Task task(String name, Closure configureClosure);`

   ```groovy
   task Task名称{
       // 
   }
   
   ```

2. 格式二 : 使用Task容器创建

   ```groovy
   this.tasks.create("name":"Task名称"){
       //
   }
   
   ```

:anchor: TaskContainer(容器)相关API

> 一个Project中会有非常多的Task，Gradle是通过TaskContainer管理Project中的Task
>
> TaskContainer会根据Task的依赖将Task构建出拓补图，在执行Task时执行所依赖的Task

| 方法名称                              | 使用说明           |
| ------------------------------------- | ------------------ |
| Task findByPath(String path)          | 找不到结果为null   |
| Task getByPath(String path)           | 找不到抛出异常     |
| Task create(String name, Closure col) | 创建Task           |
| Task replace(String name)             | 替换指定名称的Task |

:anchor: 配置Task

1. Task的配置属性

   | 属性        | 说明              |
   | ----------- | ----------------- |
   | name        | 指定名称          |
   | description | 添加说明          |
   | group       | 指定分组,同一组的 |
   | type        | 指定Task的处理类  |
   | dependsOn   | 依赖的其他Task    |
   | overwrite   | 重写Task          |
   | action      | 执行逻辑          |

2. Task配置格式一 : 在Task名称后使用参数的格式设置属性与值

   ```groovy
   task Task名称("group":"值"){
       // code
   }
   
   ```

3. Task配置格式二 : 使用API的方式配置Task

   ```groovy
   task Task名称{
       setDescription("值")
   }
   
   ```

## 8.2 Task执行详解

:anchor: 默认的Task执行

​		在Project的配置阶段中，gradle中的配置代码都会被执行到，所以在配置阶段所有的Task中的代码都会执行到，但是不会执行Task的逻辑，Task逻辑的执行是在执行阶段完成的

:anchor: 配置Task在执行阶段执行 : doFirst 与 doLast

- doFirst或doLast特点
  - doFirst用于给已存在的Task之前添加逻辑
  - doLast用于给已存在的Task之后添加逻辑
  - 可以将Task的中的执行时间修改为执行阶段执行
  - 一个Task中可以定义多个doFirst或doLas
  - 在外部定义的doFirst或doLas优先执行于内部定义的

1. 格式一 : 在Task内部定义

   ```groovy
   task Task名称 {
       doFirst {
           // code
       }
       doLast{
       	// code
       }
   }
   
   ```

2. 格式二 : 在Task外部执行Task的doFirst与doLast的API

   ```groovy
   Task名称.doFirst{
   	// code
   }
   Task名称.doLast{
   	// code
   }
   
   ```

## 8.3 Task依赖执行顺序

:anchor: dependsOn强依赖方式

> task有依赖关系时候,执行task会优先执行所依赖的Task

1. 方式一 : task的dependsOn属性

   ```groovy
   // 格式一
   task task名称(dependsOn: [依赖Task1, 依赖Task2]) {
       
   }
   
   // 格式二
   task名称.dependsOn{
   	
   }
   
   ```

2. 方式二 : 通过Task的dependsOn方法

   ```groovy
   task task名称 {
       dependsOn this.tasks.findAll { task ->
           
           return task
       }
   }
   
   ```

:anchor: 通过Task输入输出

1. 输入输出的作用

   ​	一个Task的输出可以设置为另一个Task的输入，通过输入和输出关联Task之间的关系，这样可以通过制定Task的输入和输出改变Task的执行顺序

2. Task的输入与输

   - TaskInputs:代表Task的输入类，可以接收任意数据类型和文件类型
   - TaskOutputs:代表Task的输出类，只可以接收文件类型

3. 定义输入与输出

   ```groovy
   task 任务1{ Task task ->
       // 为Task指定输出
       task.outputs 目标文件
   }
   
   task 任务1{ Task task ->
       // 为Task指定输入
       task.inputs 目标文件
   }
   
   ```

- Task.inputs指定TaskInputs
  - Task.outputs指定TaskOutputs
  - 通过同一个目标文件将两个Task关联起来，如果其他的Task同时依赖的输入输出相关联的Task，gradle会将输出类型的Task先执行

:anchor: 通过API连接到构建生命周期

- 让指定Task指定运行在指定Task之后，这几个Task需要同时执行

  ```groovy
  task taskY {
      mustRunAfter taskX		// 强制
  }
  
  ```

  ```groovy
  task taskY {
      shouldRunAfter taskX	// 不是强制
  }
  
  ```

## 8.4 Task类型

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