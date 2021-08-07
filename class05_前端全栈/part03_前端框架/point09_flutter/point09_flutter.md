1. 简介

   - Google开发的跨平台UI框架：支持IOS、Android、WEB、桌面端、嵌入式
   - 发展历程
     - 2017-5：发布第一个版本
     - 2018-12：发布第一个稳定版本
     - 2019：MWC发布1.2版本
   - 技术核心点：采用虚拟DOM技术：三个层次的树结构
     - ①Widget树（UI控件）
     - ②Element树（渲染树）
     - ③RenderObject树（渲染上下文）
   - flutter架构图：
     - Framework：框架层
     - Engine：引擎层
     - Embedder：嵌入层

2. Win安装

   - 网络配置：需要将网络配置到Win环境变量中

     ```sh
     PUB_HOSTED_URL=https://pub.flutter-io.cn
     FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn
     ```

   - 安装GIT

   - 安装Gradle

   - 下载Flutter SDK：[WIN]([Flutter SDK releases - Flutter](https://flutter.dev/docs/development/tools/sdk/releases#windows))

     - 配置Fluuter环境变量

       ```sh
       FLUUTER_HOME=
       Path=%FLUUTER_HOME%/bin
       ```

   - 安装AndroidStudio

     - 下载
     - 安装
     - 配置AndroidSDK
       - 检查工具网站：http://ping.chinaz.com/dl.google.com
       - 配置host：180.163.151.33 dl.google.com

   - 配置AndroidSDK

     - 

3. Dart概述

   - Dart是Google2011年推出
   - Dart属于应用层编程语言，有自己的DartVM，但是也可以编译成Native Code运行在硬件上
   - 比Java简单，易于理解；比JavaScript更加规范，工程化；

4. Dart SDK安装

   - 官网：https://dart.dev/get-dart

   - win环境检查

     ```sh
     Get-ExecutionPolicy
     > Restricted
     Set-ExecutionPolicy AllSigned
     or
     Set-ExecutionPolicy Bypass -Scope Process.
     ```

   - Powershell

     ```sh
     Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
     ```
   
   - 安装Dart

     ```sh
     choco install dart-sdk
     ```
   
5. Dart语言风格

   - 所有能够使用变量引用的都是对象；
   - 下划线开头表示私有属性
   - 程序执行入口是main函数

6. 变量和常量

   - 使用var关键字声明变量：可以赋予不同类型的值

   - 未初始化时，默认值是null

   - 变量使用final声明只能赋值一次

   - dynamic 声明的变量是

   - const声明常量：同时也是final，比final更加严格，final的值可以在编译时候赋值，

     ```dart
     final a = getNum()
     ```

7. 内置数据类型
   1. numbers：变量关键字（int、double、num）：强类型声明变量
   
   2. strings：变量关键字（String）：
      1. 可以使用单引号、双引号、三单引号（多行字符串）
      2. 双引号中使用·`$变量`引用变量
      3. 字符前添加`r`表示原始字符串：不转义特殊字符
      
   3. booleans：变量关键字（bool）：
   
   4. lists：使用变量字面量（`[]`）、List、
      1. 定义方式：①[]、②List 变量、③var 变量 = new List()
      2. 操作下标：
      3. const[]：表示不可变数组，不可变
      
   5. maps：
      1. 定义Map：使用Map字面量{}
      2. 使用Map关键字：Map 变量 = {}
      3. 使用new Map()：定义字典
      
   6. runes：在Dart中，Runes代表字符串的UTF32字符集，
      1. Dart中字符串是UTF-16的字符序列，
      2. 定义一个Runter：使用\uXXXX或\u{XXXXX}表示
      3. 强类型声明：Runter r = new Runter("\uXXX")
      4. Runter转字符串：new String.formatCharCodes(runter)
      
   7. sysbols：Dart语言的标识符，在反射中使用很普及
   
      1. 一个Symbol对象代表Dart程序中声明的操作符或标识符
   
      2. 作用：混淆后的代码，标识符名称别混淆了，但是Symbol的名字不会变，使用Symbol字面量来获取标识符的symble对象，在标识符签名添加一个#号
   
         ```dart
         var sm2 = #name;
         var sm1 = Symbol("name");
         ```
   
8. 运算符：可以创建表达式，可以重新表达式

   | 运算符   | 符号                                               |
   | -------- | -------------------------------------------------- |
   | 一元后缀 | expr++、expr--、()、[]、？、.                      |
   | 一元前缀 | ++expr、--expr、!expr、~expr、-expr                |
   | 乘法     | *、/、%、~/                                        |
   | 加法     | +、-                                               |
   | 移位     | <<、>>                                             |
   | 与       | &                                                  |
   | 或       | \|                                                 |
   | 关系类型 | \>=、、<=、>、<、as、is、is！                      |
   | 等式     | ==、!=                                             |
   | 逻辑与   | &&                                                 |
   | 逻辑或   | \|\|                                               |
   | 三元     | bool ？ true : false                               |
   | 级联     | ..                                                 |
   | 赋值     | +=、-=、*=、/=、~=、%=、>>=、<<=、&=、\|=、^=、??= |

9. 流程控制：同JavaScript

10. 方法定义：在Dart中方法（函数）也是对象，其类型是Function，所以方法可以赋值给变量也可以当做其他方法的参数；同时Dart中的函数对象也是方法；

    - 函数定义：标准定义，同java

    - dynamic返回值类型推断的方式

    - 使用箭头函数：=>：表示{return }

      ```dart
      String getName(String name) => name;
      ```

    - 必传参数：默认在方法上声明的参数就是必传参数；

    - 可选参数：位置参数：将参数定义在[]中，参数传递时是根据参数的位置赋值，如果不传也要赋值null；

    - 可选参数：命名参数：将参数定义在字典中：{k，v}；参数传递时候需要指定名称（key:v）

    - 参数默认值：定义参数参数时候给参数赋值称为默认值

    - 匿名方法：是匿名或者闭包

11. 变量作用域：指定义在代码块中的变量在代码块内有效

12. 函数闭包：是一个方法的对象，不论改对象子啊何处被调用，该对象都能访问自己作用域内的变量；

    ```dart
    count(){
      int n = 0;
      return (){
        return n++;
      };
    }
    ```

13. 面向对象

    - 定义类关键字：class：包含构造方法、成员变量、成员方法、类变量（静态变量）、类方法（静态方法）
    - 实例化对象：new 类名()；
      - 一个类只有一个构造方法
      - 类中的构造方法不支持重载
      - 使用命名的构造方法来实现构造方法的重载；
    - 常量构造方法：创建对象后不允许被修改
    - 常量私有属性设置：变量名称使用下划线开头；

14. 对象的仿真函数：如果类实现的call方法，则该类的对象可以作为方法使用

    ```dart
    
    ```

15. 类的基础与构造方法的继承：单继承：extends，与方法的重写，构造方法的重写；

16. 抽象类：abstract

17. 接口定义：可以使用implements关键字，可以把需要继承的类当做一个接口用；接口中的属性或方法子类都需要实现，可以使用多继承

18. 混合：minx：实现类的多继承 with关键字

19. 枚举：class关键字是enum关键字

20. 泛型：是指类型的参数化；泛型类，泛型方法

21. 异步编程：Dart是单线程语言，异步代码主要是用async  await实现；类似JavaScript

    - Future类型Promise：为了解决异步回调，方法内使用await关键字，当前方法必须是async方法

22. dart库

    1. 自定义库：使用import as指定库名关键字引入库,使用下划线就不会被导出
    2. 内置库：dart SDK内置的库，默认导入dart.core库：
    3. 第三方库：管理在pub包,依赖配置文件:pubspec.yaml

