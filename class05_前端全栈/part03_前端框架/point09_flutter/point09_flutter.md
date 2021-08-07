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
   7. sysbols

