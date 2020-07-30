# 第一章 基础知识与核心知识准备

## 1.1 并发与高并发相关概念

1. 并发：在单核处理器上同时运行多个线程，多个线程将会交替的换入或换出内存，此时的多线程同时存在于执行中，但是处于执行中的某个状态。

   >  **重点**： 多个线程操作相同资源，保证线程安全问题 和 资源合理分配问题

2. 高并发（High Concurrency）：通常是指系统能够同时并行处理很多请求，并且可以保证程序性能，是互联网分布式系统架构设计中必须考虑的因素之一；

   > **重点**：服务可以同时处理很多请求，提高程序性能

## 1.2 CPU多级缓存

1. **CPU内部结构**：CPU的结构主要由运算器、控制器、寄存器三大块组成。运算器就是中央机构里负责执行任务的部门，也就是专门干活的；而控制器就是中央机构的领导小组，针对不同需要，给运算器下达不同的命令；寄存器可以理解为控制器和运算器之间的联络小组，主要工作就是协调控制器和运算器。

   <img src='https://m.qpic.cn/psc?/V52xXkY417Nw310rbooN1OUGO41S4u1u/bqQfVz5yrrGYSXMvKr.cqaNbNPiwAciJTBgHcgViVEX2k3jAoYda2K63QIcEvZ1jT*PsVAwXf2FsO3IAKp7VwohN*XItbZgtzdz9CO*Xul4!/b&bo=oANPAqADTwIDCSw!&rf=viewer_4&t=5' width='70%'/>

2. **CPU多核缓存架构**：为了提高程序运行的性能，现代CPU在很多方面会对程序进行优化。CPU的处理速度是很快的，内存的速度次之，硬盘速度最慢。在cpu处理内存数据中，内存运行速度太慢，就会拖累cpu的速度。为了解决这样的问题，cpu设计了多级缓存策略。

   - **L1 Cache (一级缓存)**是CPU第一层高速缓存，分为数据缓存和指令缓存。它是封装在CPU芯片内部的高速缓存，用于暂时存储CPU运算时的部分指令和数据，存取速度与CPU主频相近。内置的L1高速缓存的容量和结构对CPU的性能影响较大，一级缓存容量越大，则CPU处理速度就会越快，对应的CPU价格也就越高。一般服务器的CPU的L1缓存的容量通常在32-4096K
   - **L2 Cache (二级缓存)**是CPU外部的高速缓存，由于L1高速缓存的容量限制，为了再次提高CPU的运算速度，在CPU外部放置一高速存储器，即二级缓存。像一级缓存一样，二级缓存越大，则CPU处理速度就越快，整台计算机性能也就越好。一级缓存和二级缓存都位于CPU和内存之间，用于缓解高速CPU与慢速内存速度匹配问题。
   - **L3 Cache (三级缓存)** 都是内置的，它的作用是进一步降低内存延迟，同时提升大数据量计算时处理器的性能。具有较大L3缓存的处理器，能提供更有效的文件系统缓存行为及较短的消息和队列长度。一般多核共享一个L3缓存。

   <img src='https://m.qpic.cn/psc?/V52xXkY417Nw310rbooN1OUGO41S4u1u/bqQfVz5yrrGYSXMvKr.cqaNbNPiwAciJTBgHcgViVEUEUHnPup62sWfH4ygta4dU*lxF94rlZAKa55BhAI0Vr4SERmZGV4kwNbq2Erk*eZE!/b&bo=2gLxAdoC8QEDCSw!&rf=viewer_4&t=5' width='70%'/>

3. **为什么要CPU缓存**：CPU的频率太快，快到主存根本跟不上，这样在处理周时钟期内，CPU常常需要等待缓存，严重浪费资源。CPU Cache的出现为了缓解CPU和内存之间速度不匹配的问题；

4. **CPU缓存的意义**

   - 时间局部性：如果某个数据被访问，那么不久的将来它很可能再次被访问（**可能频繁访问统一数据**）；
   - 空间局部性：如果某个数据被访问，那么与他相邻的数据很快也有可能被访问（**个属性的相邻属性可能被访问**）；

5. **CPU缓存一致性（MESI）**：用于保证多个CPU cache之间缓存共享数据的一致，因为每个CPU都有自己的缓存，容易导致一种情况就是 如果多个CPU的缓存(多CPU读取同样的数据进行缓存，进行不同运算后，写入内存中)中都有同样一份数据，那这个数据要如何处理呢？已谁的为准？ 这个时候就需要一个缓存同步协议了！**MESI协议** 规定每条缓存都有一个状态位，同时定义了一下四种状态

   - **修改态 (Modified)** ：此缓存被修改过，内容与住内存不同，为此缓存专有
   - **专有态 (Exclusive)** ：此缓存与主内存一致，但是其他CPU中没有
   - **共享态 (Shared)** ：此缓存与住内存一致，但也出现在其他缓存中。
   - **无效态 (Invalid)**： 此缓存无效，需要从主内存中重新读取。

   <img src='https://m.qpic.cn/psc?/V52xXkY417Nw310rbooN1OUGO41S4u1u/bqQfVz5yrrGYSXMvKr.cqTU4XoG*alc4FwVTQz3nICE*7lWAdbeV0MZqiLNhywd59XTHHhxSod1JtPwjlL1fEDwyB7Acb7MtW3iiENa5qpY!/b&bo=lgTNAZYEzQEDCSw!&rf=viewer_4&t=5'/>

6. **引起缓存状态改变的方法**

   <img src='https://m.qpic.cn/psc?/V52xXkY417Nw310rbooN1OUGO41S4u1u/bqQfVz5yrrGYSXMvKr.cqSt0.XiLZ6**SenSnYT8bjm3USg1VkD2CsAr5OQTfbThbhJFkNN1rOndfzeOr4ZoRN3JZZvOD7zzW2.xQxFO5.E!/b&bo=zwLbAc8C2wEDCSw!&rf=viewer_4&t=5'/>

   - **local read** : 读取本地缓存中数据
   - **local write** : 将数据写到本地缓存中
   - **remote read** : 读取内存数据
   - **remote write** : 将数据写入到主存中

7. **CPU乱序执行优化**

   - 指处理器为了提高运算速度而做出违背代码原有顺序的优化
   - 在多核处理器下, 乱序执行优化有一定风险

## 1.3 Java内存模型

## 1.4 并发优势与风险

## 1.5 并发模拟

# 第二章 多线程并发与线程安全

## 2.1 线程安全性

## 2.2 安全发布对象

## 2.3 线程封闭,同步容器,并发容器

## 2.4 AQS等JUC组件

## 2.5 线程调度

## 2.6 线程安全补充内容

###  :anchor: 线程基础

1. 创建线程的三种方式
   - 方式一：继承Thread类

     ```java
     public class ThreadRuning extends Thread{
     
         //重写构造，可以对线程添加名字
         public ThreadRuning(String name){  
             super(name);
         }
         @Override
         public void run() {
            ...
         }
     }
     ```

   - 方式二：实现Runable接口：Runable接口没有返回值

     ```java
     public class RunableTest implements Runnable {
         @Override
         public void run() {
             ...
         }
     }
     ```

   - 实现Callable接口:

     ```java
     public class CallTest implements Callable {
         @Override
         public Object call() throws Exception {
             return "hello world";
         }
     }
     ```

     > 可以获取线程执行的返回值
     >
     > ```java
     > FutureTask<String> futureTask = new FutureTask<String>(new CallTest());
     > new Thread(futureTask).start();
     > String result = futureTask.get();
     > ```

2. 线程状态转换方法

   - 线程状态说明

     <img src='./imgs/线程_状态'/>

     - **NEW：**状态是指线程刚创建, 尚未启动

       **RUNNABLE：**状态是线程正在正常运行中, 当然可能会有某种耗时计算/IO等待的操作/CPU时间片切换等, 这个状态下发生的等待一般是其他系统资源, 而不是锁, Sleep等

       **BLOCKED：**这个状态下, 是在多个线程有同步操作的场景, 比如正在等待另一个线程的synchronized 块的执行释放, 或者可重入的 synchronized块里别人调用wait() 方法, 也就是这里是线程在等待进入临界区

       **WAITING：**这个状态下是指线程拥有了某个锁之后, 调用了他的wait方法, 等待其他线程/锁拥有者调用 notify / notifyAll 一遍该线程可以继续下一步操作, 这里要区分 BLOCKED 和 WATING 的区别, 一个是在临界点外面等待进入, 一个是在理解点里面wait等待别人notify, 线程调用了join方法 join了另外的线程的时候, 也会进入WAITING状态, 等待被他join的线程执行结束

       **TIMED_WAITING：**这个状态就是有限的(时间限制)的WAITING, 一般出现在调用wait(long), join(long)等情况下, 另外一个线程sleep后, 也会进入TIMED_WAITING状态

       **TERMINATED：** 这个状态下表示 该线程的run方法已经执行完毕了, 基本上就等于死亡了(当时如果线程被持久持有, 可能不会被回收)

   - 线程状态转换函数

     <img src='./imgs/线程_状态转换方法'/>

     - **start()**
     - **yield()**
     - **sleep()**
     - **join()**
     - **wait()**
     - **notify()**
     - **notifyAll()**

### :anchor: 线程池

1. 线程池特点

   - 线程是稀缺资源，使用线程池可以减少创建和销毁线程的次数，每个工作线程都可以重复使用。
   - 可以根据系统的承受能力，调整线程池中工作线程的数量，防止因为消耗过多内存导致服务器崩溃。

2. 线程池类说明：ThreadPoolExecutor

   ```java
   public ThreadPoolExecutor(int corePoolSize,
                                  int maximumPoolSize,
                                  long keepAliveTime,
                                  TimeUnit unit,
                                  BlockingQueue<Runnable> workQueue,
                                  RejectedExecutionHandler handler) 
   ```

   - corePoolSize：线程池核心线程数量

   - maximumPoolSize:线程池最大线程数量

   - keepAliverTime：当活跃线程数大于核心线程数时，空闲的多余线程最大存活时间

   - unit：存活时间的单位

   - workQueue：存放任务的队列

   - handler：超出线程范围和队列容量的任务的处理程序

     > 设置策略的方式
     >
     > - 方式一：构建线程池将处理测试设置为参数
     >
     > ```java
     > RejectedExecutionHandler handler = new ThreadPoolExecutor.DiscardPolicy();
     > ThreadPoolExecutor threadPool = 
     >      new ThreadPoolExecutor(2, 5, 60, TimeUnit.SECONDS, queue,handler);
     > ```
     >
     > - 方式二：为已经构建好的线程池指定新的处理策略
     >
     > ```java
     > ThreadPoolExecutor threadPool=
     >     new ThreadPoolExecutor(2,5,60,TimeUnit.SECONDS,queue);
     > threadPool.setRejectedExecutionHandler(new ThreadPoolExecutor.AbortPolicy());
     > ```

     - AbortPolicy：直接抛出异常(默认策略)
     - CallerRunsPolicy：只用调用所在的线程运行任务
     - DiscardOldestPolicy：丢弃队列里最近的一个任务，并执行当前任务。
     - DiscardPolicy：不处理，丢弃掉。

3. 线程池实现原理

   <img src='./imgs/线程_原理'/>

   - 判断**线程池里的核心线程**是否都在执行任务，如果不是（核心线程空闲或者还有核心线程没有被创建）则创建一个新的工作线程来执行任务。如果核心线程都在执行任务，则进入下个流程。
   - 线程池判断工作队列是否已满，如果工作队列没有满，则将新提交的任务存储在这个工作队列里。如果工作队列满了，则进入下个流程。
   - 判断**线程池里的线程**是否都处于工作状态，如果没有，则创建一个新的工作线程来执行任务。如果已经满了，则交给饱和策略来处理这个任务

4. 线程池API说明

   | 方法名称  | 方法说明 |
   | --------- | -------- |
   | execute() |          |

5. Executor框架类图

   <img src='./imgs/线程_Executor类图'/>

   - **Executor**，是一个可以提交可执行（Runnable）任务的Object，这个接口解耦了任务提交和执行细节（线程使用、调度等），Executor主要用来替代显示的创建和运行线程；
   - **ExecutorService**提供了异步的管理一个或多个线程终止、执行过程(Future)的方法；
     AbstractExecutorService提供了ExecutorService的一个默认实现，这个类通过RunnableFuture（实现类FutureTask）实现了submit, invokeAny, invokeAll几个方法；
   - **ThreadPoolExecutor**是ExecutorService的一个可配置的线程池实现，它的两个重要的配置参数：corePoolSize（线程池的基本大小，即在没有任务需要执行的时候线程池的大小，并且只有在工作队列满了的情况下才会创建超出这个数量的线程。这里需要注意的是：在刚刚创建ThreadPoolExecutor的时候，线程并不会立即启动，而是要等到有任务提交时才会启动，除非调用了prestartCoreThread/prestartAllCoreThreads事先启动核心线程。再考虑到keepAliveTime和allowCoreThreadTimeOut超时参数的影响，所以没有任务需要执行的时候，线程池的大小不一定是corePoolSize。）, maximumPoolSize（线程池中允许的最大线程数，线程池中的当前线程数目不会超过该值。如果队列中任务已满，并且当前线程个数小于maximumPoolSize，那么会创建新的线程来执行任务。这里值得一提的是largestPoolSize，该变量记录了线程池在整个生命周期中曾经出现的最大线程个数。为什么说是曾经呢？因为线程池创建之后，可以调用setMaximumPoolSize() 改变运行的最大线程的数目。）；
   - **ScheduledExecutorService** 是添加了调度特性（延迟或者定时执行）的ExecutorService；
   - **ScheduledThreadPoolExecutor**是具有调度特性的ExecutorService的池化实现；
   - **Executors**是一个Executor, ExecutorService, ScheduledExecutorService, ThreadFactory, Callable的工具类，它能满足大部分的日常应用场景

6. **Executors创建线程池**

   - SingleThreadExecutor：单线程线程池
   - FixedThreadExecutor：固定大小线程池
   - CachedThreadPool:无界线程池
   - ScheduledThreadPool

7. 自定义线程池

   

# 第三章 高并发处理思路与手段

## 3.1 扩容

## 3.2 缓存

## 3.3 队列

## 3.4 应用拆分

## 3.5 限流

## 3.6 服务降级与服务熔断

## 3.7 数据库切分,分库分表

## 3.8 高可用的一些手段

