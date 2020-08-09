# 第一部分 并发编程

## 1. 概览

### 1.1 课程内容

- 学习内容：进程、线程、并发、并行

### 1.2 为什么学并发

- 应用程序服务器底层设计基础

### 1.3 课程特殊

- 课程大纲
  - 进程
  - 线程
  - 并发共享模型
    - 管程-悲观锁
    - JMM：原子性、可见性、有序性
    - 无锁-乐观锁
    - 不可变
    - 并发工具：线程池、JUC、disruptor、guava
    - 异步编程：ComoletableFuture、反应式
  - 并发非共享模型
    - 私有
    - Actor
  - 并行
    - 函数式编程
    - 并行编程：隐射、规约
  - 应用：效率、限流、同步、异步、缓存、队列、分治、统筹
  - 原理
  - 模式：Balking、Guarded Suspension、控制顺序、两阶段退出、workThread、Thread per Message、生产者消费者

### 1.4 预备知识

1. 基础知识

   - 不是初学者：需要框架学习经验
   - 基于JDK8
   - 为每个线程定义名称

2. 添加依赖

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 https://maven.apache.org/xsd/maven-4.0.0.xsd">
       <modelVersion>4.0.0</modelVersion>
       <parent>
           <groupId>org.springframework.boot</groupId>
           <artifactId>spring-boot-starter-parent</artifactId>
           <version>2.2.1.RELEASE</version>
       </parent>
       <groupId>com.pamda</groupId>
       <artifactId>framework-easyexcel</artifactId>
       <version>0.0.1-SNAPSHOT</version>
       <name>framework-easyexcel</name>
       <description>Demo project for Spring Boot</description>
       <packaging>jar</packaging>
   
       <properties>
           <java.version>1.8</java.version>
       </properties>
   
       <dependencies>
           <dependency>
               <groupId>org.springframework.boot</groupId>
               <artifactId>spring-boot-starter-web</artifactId>
           </dependency>
           <dependency>
               <groupId>com.alibaba</groupId>
               <artifactId>easyexcel</artifactId>
               <version>2.1.6</version>
           </dependency>
           <dependency>
               <groupId>org.projectlombok</groupId>
               <artifactId>lombok</artifactId>
               <optional>true</optional>
           </dependency>
           <dependency>
               <groupId>org.springframework.boot</groupId>
               <artifactId>spring-boot-starter-test</artifactId>
               <scope>test</scope>
               <exclusions>
                   <exclusion>
                       <groupId>org.junit.vintage</groupId>
                       <artifactId>junit-vintage-engine</artifactId>
                   </exclusion>
               </exclusions>
           </dependency>
           <dependency>
               <groupId>junit</groupId>
               <artifactId>junit</artifactId>
               <scope>test</scope>
           </dependency>
       </dependencies>
   
       <build>
           <plugins>
               <plugin>
                   <groupId>org.springframework.boot</groupId>
                   <artifactId>spring-boot-maven-plugin</artifactId>
               </plugin>
           </plugins>
       </build>
   </project>
   ```

## 2. 进程与线程

### 2.1 本章内容

- 进程和线程的概念
- 并行和并发的概念
- 线程的基本使用

### 2.2 概念

1. 进程
   - 程序有指令和数据组成，单这些指令要运行，数据要读写，就必须将指令加载至CPU，将数据加载至内存。在指令运行的过程中还需要用到磁盘、网络等设备；进程就是用来加载指令、管理内存、管理IO的
   - 当一个程序被运行，从磁盘加载这个程序的代码至内存，这时就开启了一个进程
   - 进程就可以视为一个程序的实例。大部分程序可以同时运行多个实例进程，或一个实例进程
2. 线程
   - 一个进程可以分为一到多个线程
   - 一个线程就是一个指令流，将指令流中的一条条指令以一定的顺序交给CPU执行
   - Java中，线程作为最小调度单位，进程作为资源分配的最小单位。在windows中进程是不活动的，只是作为线程的容器
3. 对比
   - 进程基本上相互独立，而线程存在与内存中，是进程的一个子集
   - 进程拥有共享的资源：如内存空间、供其内部的线程共享
   - 进程间通信较为复杂：同一台计算机进程通信称IPC，不同计算机进程通信共同协议:HTTP、RPC
   - 线程通信相对简单，因为他们共享进程内的内存：如多个线程可以访问统一个共享变量
   - 线程更轻量，线程上下文切换成本一般上要比进程上下文切换低

### 2.4 并行与并发

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在同一时间的单核CPU只能执行一条线程，而线程的执行顺序哟操作系统中的任务调度器分配，线程实际上是串行执行，通过执行线程的切换实现不同进程同时运行，微观串行、宏观并行

1. 并发（concurrent）：指线程轮流使用CPU的做法（同一时间应对多件事情的能力）
2. 并行（parallel）：多核CPU同时执行多个线程的能力（同一时间执行多件事情的能力）

### 2.5 应用

1. 异步调用：异步不需要结果返回就能继续执行，同步需要结果返回才能继续执行

   ```java
   /**
    * 异步执行
    */
   private static void async() {
       new Thread(() -> {
           log.info("开始执行");
           try {
               Thread.sleep(2000);
           } catch (InterruptedException e) {
               e.printStackTrace();
           }
       }).start();
       log.info("继续执行其他操作");
   }
   
   /**
    * 同步执行
    */
   private static void sync() throws InterruptedException {
       log.info("开始执行");
       Thread.sleep(2000);
       log.info("继续执行其他操作");
   }
   ```

2. 提示效率：并行执行串行的流程，在多核上有作用，因为单核在线程执行上本质还是串行执行

## 3. java线程

### 3.1 本章内容

- 创建和运行线程
- 查看线程
- 线程API
- 线程状态

### 3.2 创建和运行线程

1. 方法一：直接使用Thread

   ```java
   Thread t = new Thread("线程名称") {
       @Override
       public void run() {
           log.info("线程任务");
       }
   };
   // 启动线程
   t.start();
   ```

2. 方法二：使用Runnable配合Thread，Thread表示线程，Runnable代表可运行的任务

   ```java
   Runnable run = new Runnable() {
       @Override
       public void run() {
           log.info("线程任务");
       }
   };
   Thread t = new Thread(run, "Runnable");
   t.start();
   ```

3. Lambda简化线程创建

   ```java
   Runnable run = () ->{
       log.info("线程任务");
   };
   Thread thread = new Thread(run);
   thread.start();
   ```

4. Lambda简化线程创建：使用Runnable更容易与线程池等高级API配合,用Runnable脱离Thread继承体系后更灵活

   ```java
   new Thread(()->{
       log.info("线程任务");
   }).start();
   ```

5. FutureTask配合Thread：FutureTask可以接收Callable类型参数，用来处理返回结果

   ```java
   FutureTask<Integer> task = new FutureTask<>(()->{
       log.info("执行任务");
       return 100;
   });
   new Thread(task,"FutureTask").start();
   Integer integer = task.get();
   log.info("获取返回结果:{}", integer);
   ```

### 3.3 查看进程和线程

- windows
  - 任务管理器可以查看进程数和线程数，也可以用来杀死进程
  - tasklist：查看进程
  - taskkill：杀死进程
- Linux
  - ps -ef：查看所有进程
  - ps -fT -p [PID]：查看某个进程
  - kill PID：杀死进程
  - top：安装大小H切换是否显示线程
  - top -H -p [PID]：插件某个进程
- Java
  - jps：命令查看所有java进程
  - jstack [PID]：查看某个Java进程的所有线程状态
  - jconsole：查看某个Java进程中线程的运行状态（图形界面）

### 3.4 线程运行原理

1. 栈与栈帧：Java Virtual Machine Stacks（Java虚拟机栈）；JVM中有堆、栈、方法区组成，其中栈就是给线程使用的，每个线程启动后，虚拟机就好为其分配一块内存。
   - 每个栈由多个栈帧组成：栈帧对应着每次方法调用时所占用的内存
   - 每个线程只能有一个活动栈帧，对应值当前正在执行的那个方法
2. 线程上下文切换：因为一些原因导致CPU不在执行当前线程，转而执行另一个线程的代码：①线程的COU时间用完② 垃圾回收③有更高优先级的线程需要运行④线程自己带哦用了sleep、yeild、wait、join、park、synchronized、lock等方法
   - 当Context Switch发生时，需要有操作系统保存当前线程的状态，并恢复另一个线程的状态，java中对应的概念就是程序计数器，它的作用是记住下一条JVM指令的执行地址，是线程私有的：状态包含程序计数器、虚拟机栈中每个栈帧的信息

### 3.5 线程操作API

| 方法名             | 功能说明                                                | 备注                                                         |
| ------------------ | ------------------------------------------------------- | ------------------------------------------------------------ |
| start()            | 启动一个线程，<br />在新的线程运行run方法中的代码       | start方法只让线程进入就绪<br />就绪的线程不一定立刻运行，CPU分配时间片<br />每个线程对象的start方法只能调优一次 |
| run()              | 新线程启动后调用的方法                                  | 构造Thread对象时传递了Runable参数,则运行run<br/>可以创建Thread子类对象,覆盖默认行为join |
| join()             | 等待线程运行结束                                        |                                                              |
| join(long n )      | 等待线程运行结束<br />最多等待n毫秒                     |                                                              |
| getId()            | 获取线程长整型的ID                                      | ID唯一                                                       |
| getName()          | 获取线程名                                              |                                                              |
| setName(String n)  | 修改线程名                                              |                                                              |
| getPriority()      | 获取线程优先级                                          |                                                              |
| setPriority(int i) | 修改线程优先级                                          | java中规定线程优先级是1-10的整数,能提高被调用几率            |
| getState()         | 获取线程状态                                            | NEW<br />RUNABLE                                             |
| isInterrupted()    | 判断是否被打断                                          | 不会清除打断标记                                             |
| isAlive()          | 线程是否存活                                            |                                                              |
| interrupt()        | 打断线程                                                | 如果被打断的线程正在sleep、wait、join会导致被打断的线程抛出异常，并清除打断标记，如果打断正在运行的线程，则会设置打断标记；park的线程被打断也会设置打断标记 |
| interrupted()      | 判断当前线程是否被打断                                  |                                                              |
| currentThread()    | 获取当前正在执行的线程                                  |                                                              |
| sleep(long s)      | 让当前执行的线程休眠n毫秒,休眠时让出CPU时间片给其他线程 |                                                              |
| yield()            | 提示线程调度器让出当前CPU的使用                         | 主要为了测试和调试                                           |

1. start与run：start()方法将线程设置为就绪状态，不能重复调用，等待CPU调用，run()方法只是单纯的当前线程的方法调用;

2. sleep与yield

   - sleep

     > - 调用sleep会让当前线程从Running计入Thread Waiting状态，调度器不会调度waiting状态
     > - 其他线程可以使用interrupt方法打断正在睡眠的线程，这时sleep方法抛出InterruptedException
     > - 睡眠结束后的线程未必会立刻被执行
     > - 建议用TimeUnit的sleep代替Thread的sleep来获取更好的可读性

     - 应用：在没用利用cpu来计算时，不要让while(true)空转浪费CUP,这时可使用yield或sleep让出CPU使用权给其他程序
       - 可以用wait或条件变量达到类型的效果，不同的是后两种都需要加锁，并且需要相应的唤醒操作，一般适用于需要进行同步的场景。sleep适用于无需锁同步的场景
   
   - yield
   
     > - 调用yield会让线程从Running进入Runnable状态，然后调度执行其他同优先级的线程，如果这时没有同优先级的线程，name不能保证让当前线程暂停的效果
     >
     > - 具体的实现依赖于操作系统的任务调度器

3. 线程优先级：线程的优先级会提示调度器优先调度改线程，仅仅是个提示，调度器可以忽略它，
4. join方法详解：等待线程运行结束，应用于线程同步；join带参数表示等待的最大时间