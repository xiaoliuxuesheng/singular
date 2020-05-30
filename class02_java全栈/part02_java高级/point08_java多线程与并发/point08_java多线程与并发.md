# 第一章 基础知识与核心知识准备

## 1.1 并发与高并发相关概念

### 1. 并发

- 并发指在单核处理器上同时拥有两个以上的线程, 多个线程将交替的换入和换出内存的运行方式
- 并发时的线程同时存在, 但是这些线程都处于执行过程中的某种状态
- **并发特点** 多个线程操作相同资源, 存在线程安全问题 和 资源合理分配问题

### 2. 高并发

- 高并发是指系统可以同时并行处理很多请求, 并且可以保证程序性能

## 1.2 CPU多级缓存

### 1. CUP缓存与多级缓存

- 因为CPU的频率远远大于主存, 在处理器执行周期内, CPU需要等待主存, 浪费资源;
- CPU缓存的出现是为了缓解CPU和主存之间的速度不匹配的问题

### 2. CPU缓存的意义

- 时间局部性 : 可能频繁访问统一数据
- 空间局部性 : 一个属性的相邻属性可能被访问

### 3. CPU缓存一致性

:anchor: **概念 :** 用于保证多个CPU cache之间缓存共享数据的一致

:anchor: CPU缓存的状态

- **M (Modify) : 被修改**

- **E (Enclosed) : 独享**

- **S (Share) : 共享**

- **I (Ivalid) : 失效**

:anchor: 引起缓存状态改变的方法

- **local read** : 读取本地缓存中数据
- **local write** : 将数据写到本地缓存中
- **remote read** : 读取内存数据
- **remote write** : 将数据写入到主存中

### 4. CPU乱序执行优化

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

