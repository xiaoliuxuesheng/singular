# 第一章 JVM与Java体系结构

## 1.1 前言

- 线上调优无从下手
- 面试问题无从答起
- 对于Java技术的核心Java虚拟机了解甚少：侧重的关注了上层框架，没关注底层技术；
- 计算机系统体系对开发人员越来越远，可以不通过底层技术使用高级语言就可以开发应用；
- 如何让系统变的更快？
- 如何避免系统出现故障？

## 1.2 Java与JVM介绍

## 1.3 Java发展

## 1.4 虚拟机与Java虚拟机

## 1.5 JVM整体结构

<img src='./imgs/02_JVM内存模型'/>

## 1.6 Java代码执行流程



## 1.7 JVM架构模型

1. 基于栈的指令集架构
2. 基于寄存器的指令集架构

## 1.8 JVM生命周期

1. JVM的生命周期

   - JVM实例的诞生：当一个程序启动，伴随的就是一个jvm实例的诞生，当这个程序关闭退出，这个jvm实例就随之消亡。
   - JVM实例的运行：main()作为该程序初始线程的起点，任何其他线程均由该线程启动。JVM内部有两种线程：守护线程和非守护线程，main()属于非守护线程，守护线程通常由JVM自己使用。
   - JVM实例的消亡：当程序中的所有非守护线程都终止时，JVM才退出；

2. java类的生命周期

   <img src='./imgs/01_Java类的生命周期'/>	

## 1.9 JVM发展历程

1. Sun Classic

   Classic VM是世界上第一款商用Java虚拟机。这款虚拟机只能使用纯解释器方式来执行Java代码，如果要使用JIT编译器，就必须进行外挂。但是假如外挂了JIT编译器，JIT编译器就完全接管了虚拟机的执行系统，解释器便不再工作了。此时解释器和编译器不能配合工作。

2. Exact VM

   Exact VM因它使用准确式内存管理而得名，即虚拟机可以知道内存中某个位置的数据具体是什么类型。具备现代高性能虚拟机的雏形：如两级即时编译器、编译器与解释器混合工作模式等。

3. Sun HotSpot VM

   HotSpot VM既继承了Sun之前两款商用虚拟机的优点，HotSpot指的就是它的热点代码探测技术，HotSpot VM的热点代码探测能力可以通过执行计数器找出最具有编译价值的代码，然后通知JIT编译器以方法为单位进行编译。如果一个方法被频繁调用，或方法中有效循环次数很多，将会分别触发标准编译和OSR（栈上替换）编译动作。通过编译器与解释器恰当地协同工作，可以在最优化的程序响应时间与最佳执行性能中取得平衡，而且无须等待本地代码输出才能执行程序，即时编译的时间压力也相对减小，这样有助于引入更多的代码优化技术，输出质量更高的本地代码。

4.  BEA JRockit

   号称“世界上速度最快的Java虚拟机”（广告词），BEA公司将其发展为一款专门为服务器硬件和服务器端应用场景高度优化的虚拟机，由于专注于服务器端应用，它可以不太关注程序启动速度，因此JRockit内部不包含解析器实现，全部代码都靠即时编译器编译后执行。除此之外，JRockit的垃圾收集器和MissionControl服务套件等部分的实现，在众多Java虚拟机中也一直处于领先水平。

5. IBM J9 VM

   IBM J9 VM是IBM公司目前主力发展的Java虚拟机，它是一款设计上从服务器端到桌面应用再到嵌入式都全面考虑的多用途虚拟机，J9的开发目的是作为IBM公司各种Java产品的执行平台，它的主要市场是和IBM产品（如IBM WebSphere等）搭配以及在IBM AIX和z/OS这些平台上部署Java应用。

6. Azul VM

   特定硬件平台专有的虚拟机，Azul VM是Azul Systems公司在HotSpot基础上进行大量改进，运行于Azul Systems公司的专有硬件Vega系统上的Java虚拟机，每个Azul VM实例都可以管理至少数十个CPU和数百GB内存的硬件资源，并提供在巨大内存范围内实现可控的GC时间的垃圾收集器、为专有硬件优化的线程调度等优秀特性。

7. BEA Liquid VM

   特定硬件平台专有的虚拟机，是BEA公司开发的，可以直接运行在自家Hypervisor系统上的JRockit VM的虚拟化版本，Liquid VM不需要操作系统的支持，或者说它自己本身实现了一个专用操作系统的必要功能，如文件系统、网络支持等。由虚拟机越过通用操作系统直接控制硬件可以获得很多好处，如在线程调度时，不需要再进行内核态/用户态的切换等，这样可以最大限度地发挥硬件的能力，提升Java程序的执行性能。

8. Apache Harmony

   是一个Apache软件基金会旗下以Apache License协议开源的实际兼容于JDK 1.5和JDK 1.6的Java程序运行平台，Apache基金会曾要求Sun公司提供TCK的使用授权，但是一直遭到拒绝，直到Oracle公司收购了Sun公司之后，双方关系越闹越僵，最终导致Apache愤然退出JCP（Java Community Process）组织。 	

# 第二章 类加载与子系统

## 2.1 内存结构概述

<img src='./imgs/03_JVM完整简图'/>

## 2.2 类加载器与类加载过程

<img src='./imgs/04_类加载子系统'/>

:anchor: 类加载器子系统作用

- 负责从文件系统或网络中加载具有特定文件头标识的class文件，并转换成`java.lang.Class`类的一个实例，这个实例是读取方法区内存中该类的唯一入口；
  - 可以根据Class实例获取到加载这个类的类加载器的类型；
  - 有Class实例生成的对象可以获取到Class对象；
- ClassLoader只负责class文件的加载，至于是否可以运行是由ExcutionEngine决定；
- 将加载的类的信息存放在称为方法区的内存空间：方法区出来类信息还会存放运行时常量信息，可以包括字符串字面量和数字常量

:anchor: 类加载过程

1. 装载（加载）

   - 作用：负责找到二进制字节码并加载至JVM中，JVM通过类名、类所在的包名通过ClassLoader来完成类的加载
- 首先将类`.class`文件中的二进制数据读入到内存中，将其放在运行时数据区的方法区内;
   - 然后在堆区创建一个java.lang.Class对象，用来封装类在方法区中的数据结构
   
2. 链接

   - 链接验证：校验是防止不合法的.class文件；
   - 链接准备：为类变量分配内存并设置该类变量的初始值，final修饰的static在编译时候就分配好了，这个阶段不会为实例变量分配和初始化，实例变量是随着对象的创建从而分配；
   - 链接解析：将常量池内的符号引用转换为直接引用

3. 初始化

   - 初始化过程即为执行类中的静态初始化代码、构造器代码以及静态属性的初始化，clinit()的过程；
   - clinit()是javac编译器自动收集类中所有类变量的赋值动作和静态代码块语句的过程；
   - JVM保证子类的clinit()执行之前，父类的clinit()已经执行完毕；
   - 虚拟机必须保证一个类的clinit()方法在多线程下是同步加锁。

## 2.3 类加载器分类

### :anchor: 类加载器类型

<img src='./imgs/05_类加载器类型'/>

- JVM加载器类型理论上只有两种：引导类加载器和自定义类加载器；
- 自定义类加载器的定义：将所有派生于抽象类ClassLoader的类加载器都划分为自定义类加载器；

### :anchor:引导类加载器

- 这是JVM的根ClassLoader，它是用C++实现的，

- JVM启动时初始化此ClassLoader，并由此ClassLoader完成$JAVA_HOME中`jre/lib/rt.jar`、`resources.jar`、`sun.boot.class.path`中所有class文件的加载，这个jar中包含了java规范定义的所有接口以及实现。

  ```java
  // 获取BootStrapClassLoader能够加载的路径
  URL[] urls = sun.misc.Laucher.BootstrapClasspath().getUrls();
  ```

- BootstrapClassLoader是最先加载的，它然后依次加载出ExtClassLoader、AppClassLoader对象。

- 出于安全考虑，bootstrap启动类加载器只加载java、javax、sun开头的类。

### :anchor: 扩展类加载器

- 是派生于Classloader类，由Java语言编写，父类（上级）类加载器是启动类加载器；

- JVM用此扩展类加载器来加载扩展功能的一些jar包：JDK安装目录`jre/lib/ext`子目录下的类库

  ```java
  // 获取扩展类加载器能够加载的路径
  String property = System.getProperty("java.ext.dirs");
  ```

### :anchor: 系统类加载器

- 是派生于Classloader类，由Java语言编写，父类（上级）类加载器是启动类加载器；
- JVM用此classloader来加载启动参数中指定的Classpath中的jar包以及目录，在Sun JDK中ClassLoader对应的类名为AppClassLoader。

### :anchor: 用户自定义类加载器

1. 为什么要用用户自定义类加载器
   - 因为安全性更高一点，子类加载器是没法加载父类加载器加载的类的，父类加载过的类不需要重复加载，这样防止恶意代码冒充java核心库
   - 可以修改类的加载方式
2. 如果自定类加载器
   - 思路：继承ClassLoader，覆盖核心方法findClass，定义私有方法loadClass将其转化成二进制数据流，从而加载到Class类。

## 2.4 Classloader的使用说明

### 1. 获取类的类加载器的方式

```java
// 扩展类加载器Main
ClassLoader classLoader = MainTest.class.getClassLoader();
// 表示当前线程的类加载器——应用程序类加载器
ClassLoader contextClassLoader = Thread.currentThread().getContextClassLoader();
// 启动类加载器
ClassLoader systemClassLoader = ClassLoader.getSystemClassLoader();
```

### 2. 类加载器常用API



## 2.5 双亲委派机制与沙箱机制

<img src='./imgs/06_双亲委派机制'/>

- 双亲委派模型的工作过程是：如果一个类加载器收到了类加载请求，它首先不会自己去尝试加载这个类，而是把这个请求委派给父类加载器去完成，每一个层次的类加载器都是如此，因此所有的加载请求都应该传送到顶层的启动类加载器中，只有当父加载器反馈自己无法完成这个加载请求（它的搜索范围中没有找到所需的类）时，子加载器才会尝试自己去加载。

## 2.6 其他

:anchor: JVM中两个Class是否是同一个

- 类的全限定名是否相同
- 类的类加载器是否是同一个

:anchor:JVM必须指定一个类是由启动类加载器加载的还是由用户类加载器加载的

- 如果一个类是由用户类加载器加载的，那么JVM会将这个类加载器的应用作为类信息的一部分保存在方法区

:anchor: 类的主动加载和被动加载

- 判断标准是这个类是否导致类的初始化，被动初始化会调用clinit()初始化方法；

# 第三章 运行时数据区与线程

## 3.1 JVM内存基本结构图

<img src='./imgs/07_JVM基础基本模型'/>

1. 字节码文件被加载完毕后，会在内存中保存一份数据结构，JVM执行引擎在运行时数据在这块内存中获取
2. 线程共享的数据结构：方法区、堆；
3. 线程独享的数据结构：程序计数器、本地方法栈、虚拟机栈；
4. 每个JVM运行都有一个Runtime实例：运行时实例；

## 3.2 线程

- 线程是一个程序里的运行单元，在JVM中允许一个应用有多个线程并行执行
- 在Hotspot VM中每个线程与操作系统的本地线程直接映射，操作系统负责所有线程的安排调度到任何一个可用的CUP上：本地线程初始化成功就会调用Java线程的run（）方法

# 第四章 程序计数器

- PC寄存器（ PC register ）：每个线程启动的时候，都会创建一个PC（Program Counter，程序计数器）寄存器。PC寄存器里保存有当前正在执行的JVM指令的地址。 
- 每一个线程都有它自己的PC寄存器，也是该线程启动时创建的。保存下一条将要执行的指令地址的寄存器是 ：PC寄存器。PC寄存器的内容总是指向下一条将被执行指令的地址，这里的地址可以是一个本地指针，也可以是在方法区中相对应于该方法起始指令的偏移量。
- 每个线程都有一个程序计数器，是线程私有的,就是一个指针，指向方法区中的方法字节码（用来存储指向下一条指令的地址,也即将要执行的指令代码），由执行引擎读取下一条指令，是一个非常小的内存空间，几乎可以忽略不记。
- 这块内存区域很小，它是当前线程所执行的字节码的行号指示器，字节码解释器通过改变这个计数器的值来选取下一条需要执行的字节码指令。
- 如果执行的是一个Native方法，那这个计数器是空的。

# 第五章 虚拟机栈



# 第六章 本地方法接口

# 第七章 本地方法栈

# 第八章 堆

# 第九章 方法区

# 第十章 直接内存

# 第十一章 执行引擎

# 第十二章 StringTable

# 第十三章 垃圾回收概述

# 第十四章 垃圾回收相关算法

# 第十五章 垃圾回收相关概念

# 第十六章 垃圾回收器



# 第一章 JVM概述

1. 什么是JVM：Java Virtual Machine，是java程序（二进制class字节码）的运行环境
   - Java代码一次编写，到处运行的基础
   - 自动内存管理，垃圾回收机制
2. JVM、JRE、JDK
   - JDK是运行环境
   - JDK + 基础类库 = JRE
   - JRE + 编译工具 = JDK（JavaSE程序、JavaEE程序）
3. JVM作用
   - 面试
   - 理解Java程序的底层实现原理
   - 中高级Java程序员的基础功力
   - 线上调优无从下手
   - 面试问题无从答起
   - 对于Java技术的核心Java虚拟机了解甚少：侧重的关注了上层框架，没关注底层技术；
   - 计算机系统体系对开发人员越来越远，可以不通过底层技术使用高级语言就可以开发应用；
   - 如何让系统变的更快？
   - 如何避免系统出现故障？
4. JDK学习路径
   - JVM内存机制
   - JVM垃圾回收机制
   - Java字节码
   - Java类加载器
   - Java即时编译

# 第二章 JVM内存机制

1. 程序计数器：JVM将java代码编译为java字节码（JVM指令），解释器将JVM指令解释为机器指令，再将机器指令交给CPU；

   - 程序计数器就是机主下一条JVM指令的执行地址
   - 传给你洗计数器的读取速度在JVM中最快
   - 程序计数器线程私有：因为线程会进行切换，当线程重新切换回来后需要知道当前线程上次的执行地址，从而可以继续执行
   - 是唯一一个不会内存溢出的区域

2. 虚拟机栈：栈的数据结构特点是先进后出，虚拟机栈是线程运行所需要的内存空间，虚拟机栈中的元素称为栈帧：

   - 一个栈帧表示一个方法（保存着方法参数，局部变量，返回地址等等）所占内存，
   - 一个方法可以调用其他方法，被调用的方法会被加入到栈顶；
   - 每个线程只能有一个活动栈帧（对应着正在执行的方法）

   > 垃圾回收不会也不需要回收栈内存中的垃圾：方法调用后会自动释放方法内存
   >
   > -Xss size：为占内存指定大小，默认大小是1024kb，Windows被虚拟内存影响，栈内存越大，会影响线程数变小
   >
   > 方法内存的局部变量如果没有逃离方法的作用范围，就是线程安全的；如果局部变量是对象并且逃离的方法作用范围是线程不安全的
   >
   > 栈内存溢出：①栈帧过多导致占内存溢出（方法的递归调用）②栈帧过大也会导致栈内存溢出

   - 线程运行诊断：

     - top：查看进程占用CPU消耗情况：查询出进程编号

     - ps：命令查询线程对CPU的占用，可以得到搞CPU对应的线程ID（显示是十进制的需要转为为16进制）

       ```sh
       ps H -ef | grep 进程编号
       ```

     - 使用jdk提供的工具查看指定进程中线程运行，根据转换为16进制的线程编号找到对应的线程和对应的Java位置

       ```sh
       jstack 进程id
       ```

3. 本地方法栈：是指不是由Java代码编写的，在Java中是被native修饰的方法；

   - native方法主要是由C、C++编写进行调用操作系统底层的API
   - 本地方法栈：是由JVM调用本地方法时分配的内存空间

4. 堆：通过new关键字创建的对象会在堆内存中，

   - 堆内存是线程共享的：需要考虑线程安全问题

   - 堆内存的是会被垃圾回收机制管理

   - Xmx：设置堆空间大小的参数

   - 堆内存诊断工具

     1. jsp工具：查看当前堆中有哪些java进程

     2. jmap：查看某一进程堆内存占用情况，只能查看某一时间的状况

        ```sh
        jmap -heap 进程id
        ```

     3. jconsole：图形界面的，多功能的检测，可以连续检测

     4. jvisualvm：图形界面工具

5. 方法区：

   - 是JVM所有线程共享的区域；存储类相关的信息：成员变量，构造方法，成员方法等信息
   - 是在虚拟机启动时被创建
   - 方法区是一个规范：在不同的虚拟机版本有不同的实现，在JVM6之前方法区定义在永久代中，在JVM8方法区是由元空间实现，元空间引用的是本地内存
   - 方法区设置参数：-XX:MaxMetaspaceSize=8m

6. 方法区-常量池：二进制自己吗的组成①类的基本信息②常量池③类方法定义

   - java反编译工具查看字节码文件

     ```sj
     javap -c class字节码
     ```

   - 常量池是为方法区中的局面指令提供参数的内存地址;

   - 运行时常量池：当类被加载后，就会被放入运行时常量池，在运行时常量池中jvm指令的地址编号就会被替换为真实的地址

   - StringTable：常量池中字符串池

     - 常量池中的字符串仅是符号，第一次用到时候才会变为对象
     - 利用串池机制，来避免重复创建字符串对象
     - 字符拼接原理是StringBuilder
     - string.intern()：尝试将字符串放入字符串常量池

7. [P3737_StringTable_垃圾回收](https://www.bilibili.com/video/BV1yE411Z7AP?p=37)



