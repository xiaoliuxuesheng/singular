# 前言

- Gradle是最新的, 功能最强大的构建工具：①可以完成Maven和Ant所有功能②是使用程序代替xml配置, 构建灵活③是一门程序语言又非常多的第三方插件；
- Gradle技术可以完善开发技术体系, 提示自动化构建技术深度；
- 进阶高级开发工程师的必备工具；

# 第一章 Gradle介绍与环境搭建

## 1.1 项目构建工具

1. Ant:Apache推出的纯Java编写的构建工具,同xml管理项目,但是Ant没有强加任何编码约定,开发人员需要编写繁杂的xml文件
2. Maven:2004年Apache推出的使用xml管理项目的构建工具,项目构建僵化,配置文件不灵活,不方便自定义组件
3. Gradle:2012年Google推出的基于Groovy语言的构建工具,集成了Ant和Maven的优势,侧重于大项目构建,但是学习成本高,脚本灵活,版本兼容性差

## 1.2 Gradle相关介绍

1. **领域特定语言DSL** : **求专不求全**，如UML建模语言、html语言等等；特点是①特定领域的专用语言②使用范围小, 功能专一
2. **Groovy 编程语言**：①是一种基于JVM的敏捷开发语言②结合Python, Ruby等脚本语言的有许多强大特性③Groovy可以和Java完美结合 - 而且可以使用Java的所有的库
3. **Groovy 语言特性**：①语法上支持动态类型, 闭包等新一代语言特性②无缝集成所有已存在的Java类库③支持面向对象编程, 也支持面向过程编程
4. **Groovy 优势**：①更加敏捷的编程语言 : 非常多的语法糖②入门非常容器 , 功能非常强大③既可以用作编程也可以用作编写脚本

## 1.3 开发坏境搭建

1. Groovy是基于JVM的一种编程语言：Groovy需要准备JDK环境

2. Groov下载并快捷环境搭建 : [Groovy官网](http://www.groovy-lang.org/)
   - Mac系统的Groovy安装 : 解压并配置`~/bin`坏境变量

   - Win系统的Groovy安装 : 解压并配置`~/bin`坏境变量

     ```sh
     GRADLE_HOME=
     path=%GRADLE_HOME%/bin
     GRADLE_USER_HOME=
     ```

3. IDEA开发工具的Groovy环境配置
   - 开启IDEA的Groovy插件
   - 创建Groovy工程 : 选择本地的Groovy坏境

## 1.4 Gradle项目创建

1. 使用Idea工具创建Gradle项目

2. 使用命令行工具创建Gradle项目

   ```sh
   gradle init
   ```

3. Gradle项目目录结构

   ```text
   |-- /build:封装编译后的字节码
   |--	/gradle:封装包装器文件夹
   			|--	/wrapper
   					|-- gradle-wrapper.jar
   					|--	gradle-wapper.properties
   |--	/src
   |--	gradlew:包装器启动脚本(linux)
   |--	gradlew.bat:包装器启动脚本(windowns)
   |--	build.gradle:构建脚本
   |--	settings.gradle:设置文件,定义项目及子项目信息
   ```

## 1.5 Gradle常用指令

> gradle指令需要在含有build.gradle文件的目录中执行

| 指令                 | 作用                      |
| -------------------- | ------------------------- |
| gradle clean         | 情况build目录             |
| gradle classes       | 编译业务代码和配置文件    |
| gradle test          | 编译测试代码,生成测试报告 |
| gradle build         | 构建项目                  |
| gradle build -x test | 跳过测试构建项目          |

## 1.6 Gradle源设置

1. 在Gradle安装目录中的init.d目录中新建`.gradle`结尾的初始化脚本:init.gradle

   > 阿里云仓库镜像源地址:https://developer.aliyun.com/mvn/guide

   ```groovy
   buildscript {
     repositories {
       mavenLocal()
       maven {
         url 'https://maven.aliyun.com/repository/public/'
       }
       maven {
         url 'https://maven.aliyun.com/repository/spring/'
       }
       mavenCentral()
     }
   }
   ```

2. 启用init.gradle文件的方式

   - 在命令行指定文件:`gradle --init-script [init.gradle目录]`
   - 把init.gradle放到家目录的`.gradle`目录下
   - 把以`.gradle`结尾的文件放到用户家目录的`.gradle/init.d/`目录下
   - 把以`.gradle`结尾的文件放到`GRADLE_HOME/init.d`目录下

3. 仓库地址说明

   - mavenLocal():指定使用本地Maven仓库,Maven在配置时的settings文件指定的仓库地址,查找jar包的顺序:①家目录/.m2/settings.xml②M2_HOME/conf/settings.xml③家目录/.m2/repository
   - maven(url):指定maven仓库,一般用私有仓库地址或其他第三方仓库
   - mavenCentral():maven的中央仓库

## 1.7 Wrapper包装器

- GradleWrapper实际上是对Gradle的一层包装,用于解决实际开发中不同的项目遇到的不同Gradle版本的问题,比如把代码分享给别人,别人可能没有安装gradle或者安装的gradle版本不一致,这个时候可以考虑使用gradleWrapper,实际上有了GradleWrapper后本地实际上可以不配做Gradle,使用gradle项目自带的wrapper也是可以的

- GradleWrapper的使用:项目中gradlew和gradlew.cmd就是wrapper中规定了gradle版本,或者通过命令指定gradle版本

  | gradlew指令参数           | 说明                              |
  | ------------------------- | --------------------------------- |
  | --gradle-version          | 用于指定使用的Gradle版本          |
  | --gradle-distribution-url | 用于指定下载Gradle发行版的url地址 |

- gradlewrapper.properties配置文件说明

  | 参数字段         | 说明                                 |
  | ---------------- | ------------------------------------ |
  | distributionBese | 通过gradlewrapper下载Gradle的目录    |
  | distributionPath | 相对distributionBese解压Gradle的目录 |
  | distributionUrl  | Gradle发行版压缩包下载地址           |
  | zipStoreBase     | 存在zip压缩包                        |
  | zipStorePath     | 存在zip压缩包                        |

  > distributionBese指定的GRALE_USER_HOME环境变量如果没有会去家目录的.gradle文件夹中

# 第二章 Gradle核心语法

## 2.1 Groovy简介

Groovy可以被视为Java的一种脚本化的改良版,Groovy也可以运行在jvm上,所以亏与java代码以及java和核心库交互,是一种成熟的面向对象的编程语言,并且可以用于纯粹的脚本语言,groovy代码的特点:

- 功能强大:提供动态类型转换、闭包、元编程的支持
- 支持函数式编程：不需要main函数
- 默认导入常用的包
- 类不支持default作用域，且默认作用域为public
- Groovy中基本类型也是对象，可以直接调用对象的方法

Groovy基本是指

- Groovy作为类使用：编译后默认继承GroovyObject
- Groovy作为脚本使用：编译后默认继承Script
- Groovy混合脚本和类使用：脚本中的类不能和文件重名

## 2.2 Groovy基础语法

### 1. 变量

- 变量的类型：在Groovy中变量分为基本类型和对象类型：本质上都是对象类型，基本类型本质是基本类型的包装类

- **变量的定义：建议使用强类型定义变量**：变量的定义方式有强类型方式定义和弱类型方式定义（弱类型变量类型根据值推断），弱类型定义的变量默认会添加get和set方法

  ```groovy
  变量类型 变量名 = 变量值 			# 定义方式与Java变量定义方式相同
  
  //弱类型定义关键字 def,可以根据变量值推算出变量的类型
  def 变量名称 = 变量值
  ```

### 2. 字符串String

- 是Java的String和GStringImpl作为参数可以相互替换和相互调用，在Groovy中的String定义格式有三种

  | 定义方式 | 使用说明                                                     |
  | -------- | ------------------------------------------------------------ |
  | 单引号   | 普通无格式字符串                                             |
  | 双引号   | 可扩展字符串 : 可以使用`${}`引用变量表达式<br /> - 大括号也可以省略 |
  | 三单引号 | 格式化输出字符串                                             |

### 3. 字符串GString

- 双引号字符串也称为可扩展字符串：使用了扩展表达式则该字符串会转为GStringImpl类型

  ```groovy
  String str = '变量'
  
  String gString = "${str}扩展字符串表达式"
  
  gString.class == class org.codehaus.groovy.runtime.GStringImpl
  ```

### 4. Groovy字符串API

- **StringAPI来源一**：String类的基本方法；使API的使用同Java的String类

- **StringAPI来源二**：DefaultGroovyString是Groovy对所有对象的扩展

- **StringAPI来源三**：**StringGroovyMethods**的方法是对String的扩展，重写了DefaultGroovyString的方法，普通类型参数方法

  - **字符串填充**：如果不传填充的字符串，则默认是以空格填充

    ```groovy
    println "aaa".center(5,"c")			// caaac
    println "aaa".padLeft(5,"c")		// ccaaa
    println "aaa".padRight(5,"c")		// aaacc
    ```

  - **首字母大写**

    ```groovy
    println "aaa".capitalize()			// Aaa
    ```

  - **字符串操作符**

    ```groovy
    println "abc".compareTo("abc")		// 使用API比较
    println "abc" > "abb"				// true 比较大小
    
    println "abc".minus("abc")		// 使用API减法
    println "abc abb cdd" - "abb"		// abc  cdd		字符串的减法
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

- **StringAPI来源四**：**StringGroovyMethods**闭包类型参数方法（查看闭包使用详解）

### 5. Groovy语句

- **顺序语句**

- **条件逻辑**：①if、②if - else、③if - else if、④if - else if -else、⑤switch/case : 可以传入任意类型变量和`case`匹配

  - switch-case语法：支持任意类型的判断

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

- **循环语句**

  - while循环

  - for循环：①for - i 、②for - in

    ```groovy
    // for - in 格式循环range
    for (i in 10..20){
        sum2 += i
    }
    // for - in 格式循环map
    for (i in ["key":"value"]){
        i.key + i.value 
    }
    ```

## 2.3 Groovy闭包

### 1. ​​ 闭包基础

- **闭包的概念 :**闭包的本质就是一段代码块

  ```groovy
  // 闭包的定义
  def 闭包名称 = {}
  
  // 比较的调用
  闭包名称.call()			// 方式一 : 调用闭包函数
  闭包名称()				// 方式二 : 直接使用闭包函数
  ```

- **闭包参数**

  ```groovy
  // 定义闭包参数格式,多个参数用逗号分隔
  def 闭包名称 = { 参数类型 参数名称, ... ... ->
      // 闭包体
  }
  
  // 定义闭包时指定参数默认值,有默认值一般定义在最后,条用闭包的时候
  def 闭包名称 = { 参数类型 参数名称 = 默认值 ->
      // 闭包体
  }
  
  // 闭包的默认参数:如果闭包中没有定义参数,则该闭包会有一个默认参数it，如果为闭包指定参数后，默认参数则失效
  def 闭包 = {
      // 闭包体
      println it
  }
  ```

- **闭包的返回值**

  - 闭包返回值需要使用`return`关键字声明闭包的返回
  - 闭包的默认返回值是null
  
- **闭包的变形写法：闭包作为方法参数**

  ```groovy
  number.times() {
      n -> sum += n
  }
  // 或者
  number.times {
      n -> sum += n
  }
  ```

  - 闭包作为参数，向闭包传递参数的格式是根据源码中闭包调动时决定的

  - 如果闭包是方法中唯一的形式参数，调用方法时方法的圆括号可以不写，

- 如果闭包是参数的最后一个，闭包的大括号`{}`可以写在方法圆括号`()`外面

  ```groovy
  number.times {
      n -> sum += n
  }
  ```

### 2. ​​ 闭包使用详解

**★ 与基本类型的结合使用**

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

**★ 闭包与String结合使用**

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

**★ 闭包与数据结构结合使用**

**★ 闭包与文件结合使用**

### 3. ​​ 闭包进阶

**★ 闭包关键变量**

- this：代表闭包定义处的类

  - 如果定义在类中或内部类中，则会指向最近的类对象，并且this、owner、delegate都是指向同一个对象

- owner：代表闭包定义处的类或者对象，闭包可以嵌套定义闭包

  - 如果是定义闭包中的闭包，owner会执行最近的闭包对象

- delegate：delegate默认是和owner是一样的，delegate对象可以手动修改，修改委托策略的作用：

  ```groovy
  内部闭包名.delegate = 其他对象
  ```

**★ 闭包委托策略**：闭包的委托测试即是闭包的内存引用，修改委托策略即可以调用其他对象的API

- 闭包默认的委托策略就是：OWNER_FIRST（）

  ```groovy
  闭包.pretty.resolveStrategy = Closure.OWNER_FIRST	// 以Owner优先
  ```

- 修改闭包委托策略：

  ```groovy
  闭包.pretty.resolveStrategy = Closure.OWNER_FIRST	// 以Delegate优先
  ```

- 其他委托策略

  ```groovy
  public static final int OWNER_FIRST = 0;	//	以owner优先
  public static final int DELEGATE_FIRST = 1;	//	以delegate优先，找不到再从owner中
  public static final int OWNER_ONLY = 2;		//	仅仅owner
  public static final int DELEGATE_ONLY = 3;	//	仅仅delegate
  ```

## 2.4 Gradle常见数据结构

> groovy支持List、Map集合操作，并且扩展了API

### 1. Groovy列表:List

### 2. Groovy映射:Map

### 3. Groovy范围

## 2.5 Gradle面向对象特性

1. 使用def定义变量：默认会给变量添加get和set方法

   ```groovy
   class ClassName {
       def name
   }
   
   def a = new ClassName()
   a.setName("aaa")
   a.getName()
   ```

2. 对象取值可以使用方括号

   ```groovy
   class ClassName {
       def name
   }
   
   def a = new ClassName()
   a.setName("aaa")
   a["name"]
   ```

3. 方法调用的时候，一个参数可以不使用小括号

4. 

# 第三章 Gradle高级用法

## 3.1 json文件处理

## 3.2 xml文件读取和生成

## 3.3 普通文件的读写

## 3.4 网络请求json转换

## 3.5 文件下载功能

# 第六章 Gradle概述

## 6.1 gradle基本概述

1. gradle是Java项目的一种构建工具，用于构建打包应用程序；
2. gradle是AndroidStudio的默认构建工具；
3. gradle可以看做是一个编程框架：gradle包含有①groovy语法；②build scrpt block（定制化的构建代码块）；③自身还有独立的API；具有框架的所有特点，使用编程实现应用程序的打包构建；

## 6.2 gradle优势

1. 灵活性：Maven和Ant的源码和构建过程分离；Gradle可以查看构建源码，自定义构建过程；
2. 粒度：可以独立定制构建任务（task）
3. 扩展：可以包含自定义插件和使用第三方插件
4. 兼容性：兼容Maven和Ant所有的构建功能

## 6.3 gradle生命周期

<img src="https://s1.ax1x.com/2020/05/06/YEbVyj.png" width='600'/>

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

## 7.1 深入了解Project

​		在IDEA的Java的项目的结构中，根工程被称为Project，子模块被称为Module；然而对于Gradle而言，根项目是一个Project对象（**rootProject** ），而且子模块也被称为一个Project对象（**subProject**）；执行命令`gradle projects`会输出项目中的所有Project，项目中如果有子模块，这些子模块也会作为Project并且输出相关信息；

​		在gradle项目中，一个Project对应一个build.gradle配置文件，project是由build.gradle文件进行配置和管理；gradle对Project的管理是采用树形结构：只有一个根Project，其余为子Project，实际开发中gradle项目的project最多定义两级；

​		根Project的作用是用于管理子Project，子Project的重点是对应输出，并且一个子project对应一个输出（如jar包、war包等等）；

## 7.2 Project核心API

### <font size=4 color=blue>**1. Gradle生命周期相关API**</font>

| API                                                          | 使用说明                   |
| ------------------------------------------------------------ | -------------------------- |
| Project.beforeEvaluate()<br />Project.gradle.beforeProject() | 初始化阶段之前配置阶段之前 |
| Project.afterEvaluate()<br />Project.gradle.afterProject()   | 配置阶段之后执行阶段之前   |
| Project.gradle.buildFinished()                               | 执行阶段完成后             |

### <font size=4 color=blue>**2. Project相关API**</font>

> 在gradle应用中，每个build.gradle文件都是一个groovy脚本，经过编译后会生成为一个Project字节码，所以每个build.gradle本身就是一个Project类的实例，在配置脚本中可以使用Project的API

| API：操作父Project和管理子Project | 使用说明                                            |
| --------------------------------- | --------------------------------------------------- |
| getAllprojects()                  | 获取所有Project                                     |
| getSubprojects()                  | 获取当前Project的子Project                          |
| getParent()                       | 获取当前Project的父Project                          |
| getRootProject()                  | 获取当前项目的根Project                             |
| **通过API管理Project**            | **为project指定特殊配置, 三个函数作用范围不同**     |
| project("project名称") {}         | 获取指定名称的project,并添加配置                    |
| allprojects {}                    | 获取全部的project并为所有Project添加配置            |
| subprojects {}                    | 为当前project所有的子project添加配置,不包括当前工程 |

### <font size=4 color=blue>**3. Task相关API**</font>

| API：新增Task、使用Task | 使用说明 |
| ----------------------- | -------- |
|                         |          |

### <font size=4 color=blue>**4. 属性相关API**</font>

- **gradle内置属性**：定义在Project类中

  | 属性名称                                        | 使用说明           |
  | ----------------------------------------------- | ------------------ |
  | String DEFAULT_BUILD_FILE = "build.gradle";     | 默认的构建文件     |
  | String PATH_SEPARATOR = ":";                    | 路径分隔符         |
  | String DEFAULT_BUILD_DIR_NAME = "build";        | 默认的输出文件目录 |
  | String GRADLE_PROPERTIES = "gradle.properties"; | 默认的属性配置文件 |

- **gradle扩展属性 - 属性块**

  ```groovy
  // 定义属性块：属性块中的值可以是单个键值对，也可以是键值对的map
  ext {
      属性名称=属性值
  }
  
  // 引用属性值
  this.属性名
  ```

- **gradle扩展属性 - 在project中定义属性块**：在build.gradle编译过程中，会为每个对应的Project添加一遍扩展属性块；可以定义在根project或者任何一个project中，父Project中的扩展属性会被子Project继承；

  ```groovy
  // 使用gradle的Project的API获取到Project对象,就可以为这个对象设置属性块
  subprojects {
      ext{
          属性名称=属性值
      }
  }
  
  // 在对应的Project的build.gradle中直接可以应用这个属性名
  ```

- **gradle扩展属性 - 配置文件提取**：在项目中额外定义gradle配置文件，在项目的build.gradle引入这个配置文件，则在Project中就会读取到外部配置文件的属性

  ```groovy
  // 把外部配置文件引入到build.gradle中
  apply from: this.file('文件名称')
  
  // 在Project的build.gradle可以直接使用外部配置文件中的属性
  ```

- **gradle扩展属性 - gradle默认配置文件`gradle.properties`**：该配置文件是gradle项目的默认配置文件，配置文件添加到项目中，框架会自动识别并加载配置文件中的属性；在配置文件中格式只可以是key=value的格式；读取到配置属性的key默认是字符串；配置文件中的key不可以是build.gradle中方法重名，编译正常，运行参数会冲突；

### <font size=4 color=blue>**5. File相关API**</font>

| API：路径获取相关API                                         | 使用说明                               |
| ------------------------------------------------------------ | -------------------------------------- |
| File getRootDir()                                            | 获取根工程文件对象                     |
| File getBuildDir()                                           | 获取build目录文件对象                  |
| File getProjectDir()                                         | 获取当前工程文件对象                   |
| **API：文件操作相关API**                                     | **使用说明**                           |
| file(String path)                                            | 以当前Project为相对路径定位文件        |
| files(Object ... path)                                       | 以当前Project为相对路径定位多个文件    |
| copy{<br />    form  file(目标文件)<br />    into 目的地目录文件或路径<br />    exclude {文件过滤}<br />    rename{文件重命名}<br /> } | 文件拷贝：可以拷贝整个目录或单个文件； |
| fileTree(String path){<br />    操作文件树<br />}            | 将制定路径映射为文件树                 |
| delete(Object ... path)                                      | 删除文件                               |
| mkdir(Object path)                                           | 新建文件                               |

### <font size=4 color=blue>**6. 其他API**</font>

- **Project.buildscript**：为项目配置构建脚本路径

  ```groovy
  this.buildscript { ScriptHandler scriptHandler ->
  	// ScriptHandler脚本处理器类
  }
  ```

  1. **ScriptHandler.repositories**：配置工程中仓库地址

     ```groovy
     scriptHandler.repositories { RepositoryHandler repositoryHandler ->
         repositoryHandler.flatDir()		// 文件夹依赖,本地libs库
         repositoryHandler.jcenter()		// Android中开发需要的库
         repositoryHandler.mavenCentral()// Maven远程仓库
         repositoryHandler.mavenLocal()	// 本地Maven仓库
         repositoryHandler.maven { MavenArtifactRepository repository -> //maven私有仓库
             repository.name = ''	// 仓库别名
             repository.url = ''		// 仓库地址
             repository.credentials { PasswordCredentials credentials ->
                 credentials.username = ''	// 仓库用户名
                 credentials.password = ''	// 仓库地址
             }
         }
     }
     ```

  2. **ScriptHandler.dependencies**：Gradle框架的第三方库的依赖，Gradle本身也是一个编程框架，在编写Gradle脚本时候可以引用第三方的库，需要在这里添加对应的依赖

     ```groovy
     scriptHandler.dependencies { DependencyHandler dependencyHandler ->
         // DependencyHandler
     }
     ```

- **Project.dependencies**：为开发的应用添加第三方依赖

  ```groovy
  this.dependencies { DependencyHandler dependencyHandler ->
      provided 'group:name:version'			// 只编译不打包
      compile 'group:name:version'            // 打包编译会加入到最终打包结果中
      compile group: '', name: '', version: ''// 格式二
      testCompile 'group:name:version'        // 测试环境依赖
      compile files('hibernate.jar', 'libs/spring.jar')
      compile fileTree('libs')
      compile project(本地源码工厂名)			// 引入本地源码工程
      compile('group:name:version') { 
          force = true                			// 版本冲突以当前版本为准
          exclude module: 'name'      			// 根据 name 排除
          exclude group: 'group'      			// 根据 group 排除
          exclude group: 'group', module: 'name'  //同时根据name和group排除
          transitive = false          			// 是否启用传递依赖,默认为false
      }
  }
  ```


- **外部命令执行API**

# 第八章 Gradle核心-Task

## 8.1 Task的定义及配置

### <font size=4 color=blue>**1. 使用gradle命令查看Task**</font>

```sh
gradle tasks		# 查看当前工程下的task以及相关描述
```

### <font size=4 color=blue>**2. 定义Task**</font>

- **方式一**：Project.tesk()方法

  ```groovy
  Project.tesk 自定义任务名称{
      
  }
  ```

- **方式二**：使用Task容器创建Task，一个Project中会有非常多的Task，Gradle是通过TaskContainer管理Project中的Task；TaskContainer会根据Task的依赖将Task构建出拓补图，在执行Task时执行所依赖的Task

  ```groovy
  Project.tasks.create("name":"Task名称"){
      //
  }
  ```
  
> - TaskContainer常用API
  >
  >   | 方法名称                              | 使用说明           |
  >   | ------------------------------------- | ------------------ |
  >   | Task findByPath(String path)          | 找不到结果为null   |
  >   | Task getByPath(String path)           | 找不到抛出异常     |
  >   | Task create(String name, Closure col) | 创建Task           |
  >   | Task replace(String name)             | 替换指定名称的Task |

### <font size=4 color=blue>**3. 配置Task**</font>

- **Task的配置属性**

  | 属性        | 说明              |
  | ----------- | ----------------- |
  | name        | 指定名称          |
  | description | 添加说明          |
  | group       | 指定分组,同一组的 |
  | type        | 指定Task的处理类  |
  | dependsOn   | 依赖的其他Task    |
  | overwrite   | 重写Task          |
  | action      | 执行逻辑          |

- **Task配置格式一** : 在Task名称后使用参数的格式设置属性与值；推荐在定义Task时候定义task属性

  ```groovy
  task Task名称("属性名":"值"){
      // code
  }
  ```

- **Task配置格式二** : 使用API的方式配置Task

  ```groovy
  task Task名称{
      setDescription("值") 
  }
  ```

## 8.2 Task执行顺序

​		在Project的配置阶段中，gradle中的配置代码都会被执行到，所以在配置阶段所有的Task中的代码都会执行到，但是不会执行Task的逻辑，Task逻辑的执行是在执行阶段完成的，执行逻辑需要定义在task的在doFirst和doLast代码块中；

- **配置Task在执行阶段执行doFirst或doLast的特点**
  
  - doFirst用于给已存在的Task之前添加逻辑
  - doLast用于给已存在的Task之后添加逻辑
  - doFirst或doLast代码块在Task中可以定义多个，执行顺序是编写顺序
  - 可以将Task的中的执行时间修改为执行阶段执行
  - 在外部定义的doFirst或doLas优先执行于内部定义的
  
- **格式一 : 在Task内部定义**

  ```groovy
  task Task名称 {
      doFirst {
          // code
      }
      doLast{
      	// code
      }
  }
  
  // 使用追加符简化task的的doLast定义
  task Task名称 << {
  	// 不需要再指定doLast代码块
  }
  ```

- **格式二 : 在Task外部执行Task的doFirst与doLast的API**

  ```groovy
  Task名称.doFirst{
  	// code
  }
  Task名称.doLast{
  	// code
  }
  ```

## 8.3 Task依赖执行顺序

### <font size=4 color=blue>**1. dependsOn强依赖方式**</font>

​		task有依赖关系时候，执行task会优先执行所依赖的Task；使用dependsOn依赖task时，必须是在当前task之前已经定义好的task，如果需要依赖多个，则要用列表的方式添加依赖的Task；如果依赖的多个Task直接没有依赖关系，则这些task的执行顺序是随机的；

- **方式一 : task的dependsOn参数**

  ```groovy
  task task名称(dependsOn: [依赖Task1, 依赖Task2]) {
      dependsOn(taskA)
  }
  ```

- **方式二 : 通过Task的dependsOn属性**

  ```groovy
  // 直接指定Task名称
  task task名称 {
      dependsOn(taskA)
  }
  
  // 通过匹配的方式指定以来的task
  task task名称 {
      dependsOn this.tasks.findAll { task ->
          return task
      }
  }
  ```

- **方式三 : 通过task的dependsOn方法**

  ```groovy
  task名称.dependsOn{
  	
  }
  ```

### <font size=4 color=blue>**2. 通过Task输入输出**</font>

<img src="https://s1.ax1x.com/2020/05/12/YUAq2T.png" alt="YUAq2T.png" border="0" />

​		inputs和outputs是Task的两个属性，如果一个Task的输出是另一个Task的输入，则这两个Task就有的关联关系，即为这两个Task同时执行指定了执行顺序，首先被执行的是资源输出类型的Task；

​		Task的输入和输出的执行逻辑是在Task的执行代码块中完成的；

- inputs：输入类型是接收文件、目录或者key：value的任意数据对象

  ```groovy
  inputs.files("文件A","文件B")
  inputs.file("文件路径")
  inputs.dir("文件目录路径")
  inputs.properties("key":任意类型Value)
  ```

- outputs：输出类型只能是文件类型

  ```groovy
  outputs.files("文件A","文件B")
  outputs.file("文件路径")
  outputs.dir("文件目录路径")
  ```

### <font size=4 color=blue>**3. 通过API连接到构建生命周期**</font>

:anchor: 

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

## 8.5 连接到构建生命周期

# 第六章 Gradle核心 - 其他模块

## 6.1 Setting类作用

​		在Gradle的初始化阶段会执行build.gradle文件构建Project对象，在此之前会加载settings.gradle文件构建Settings对象，settings.gradle主要作用是决定项目的哪些project要被Gradle管理。在Gradle的初始化阶段就是在执行settings.gradle相关配置

- **include(String... var1)**：引入程序中的项目交由Gradle管理

## 6.2 SourceSet类讲解

​		Gradle从读取源码从src/mian中读取的的原因是因为这个配置默认是定义在SourceSet这个类中；可以通过修改SourceSet默认配置修改约定的结构；

## 6.3 Pluging的定义和使用

​		plugin主要体现的封装的作用，将定义好的多个Task封装为一个Plugin，每个Plugin可以完成一个特定的流程或功能；

1. 创建一个Plugin的工程：定义在工程的buildSrc目录中
   - 与Java程序不同是在main文件夹中是groovy包而不是java包
   - 在build.gradle文件中配置SourceSet说明groovy包和source包的位置
2. 定义Plugin类：继承Plugin<Project>作为泛型表示当前引入这个插件的Project
3. 在resources中定义插件的标识
4. 在其他工程中引入自定义的plugin

## 6.4 Android插件对Gradle的扩展

## 6.5 如何迁移到Gradle

# 第七章 Gradle核心 - 自定义插件

## 7.1 插件类

## 7.2 Gradle 如何管理插件的依赖

# 第八章 Gradle修改默认打包流程

## 8.1 Android 和 Java的打包流程

## 8.2 将脚本嵌入到打包流程	

## 8.3 打包流程核心Task