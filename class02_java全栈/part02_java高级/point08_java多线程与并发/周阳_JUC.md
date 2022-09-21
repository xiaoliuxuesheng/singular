# 前言



# 1. 学习要求

1. JUC是什么
   - java.util.current并发工具包
2. 学习背景
   - 了解Java开发技术栈
   - 掌握Java基础:①IDEA基本操作②Lombok插件③Java新特性④JUC初级⑤JVM

# 2. 线程基础

1. JUC历史:Doug Lea,对Java并发提出意见并亲自操刀开发出并发工具包

2. 摩尔定律:CPU主频升级空间很慢,未来发展趋势是多核,程序的并发的要求更高

3. 线程创建的四种方式

   - new Thread()类
   - 实现Runable接口
   - 实现Callable接口
   - 线程池

4. 线程底层:native start()方法,底层使用C++语言,start源码解读:最终是通过JVM最终由操作系统创建了一个线程

5. 对线程相关概念

   - 锁:synchronized
   - 并行：parallel：多台处理器在某个时间段处理多个任务
   - 并发：current：单台处理器在某个时间段处理多个任务
   - 进程：应用级别
   - 线程：应用中处理任务的线程，干活的基本单元
   - 管程：Monitor（监视器），平时说的锁，任务是保证统一时间只有一个线程可以访问被保护的数据和代码

6. 用户线程与守护线程

   - 用户线程：默认都是用户线程，是指用户自己创建的线程，一般是包含需要执行的业务代码

   - 守护线程：系统为了良好运行，JVM会在系统层面创建出的线程称为守护线程，守护线程停止，用户线程也会停止，没有了用户线程，守护线程会自动退出

   - 获取线程类型：返回true是后台的守护线程

     ```java
     // 查看线程类型
     public final boolean isDeamon(){
       return deamon;
     }
     
     // 设置线程类型
     void seteDeamon(boolean deamon){
       
     }
     ```

# 3. CompletableFuture

1. Future接口:定义异步执行,并且可以获取任务执行结果,取消任务执行,判断任务是否被取消,判断任务事务是否执行完毕,默认实现类FutureTask

   - FutureTask实现了RunnableFuture
   - RunnableFuture继承了Runnable和Future接口
   - 所以new Thread()可以接收FutureTask类型异步任务

   ```java
   public static void main(String[] args) throws ExecutionException, InterruptedException {
     FutureTask<String> task = new FutureTask<>(() -> {
       return "test";
     });
     Thread thread = new Thread(task, "t1");
     thread.start();
     String s = task.get();
     System.out.println(s);
   }
   ```

   > 优点
   >
   > - future结合线程池,提高异步执行效率
   >
   > 缺点
   >
   > - get()获取异步执行结果容易造成阻塞,会等待执行结果才会继续执行主线程
   > - isDone()轮询会造成CPU空转

2. CompletableFuture:①任务执行完成回调通知②多个任务前后依赖后组合处理

   > Java8设计了CompletableFuture提供了类似观察者模式的机制,可以让任务执行完成后通知监听的一方
   >
   > - CompletableFuture实现了Future<T>, CompletionStage<T>:提供了Future的扩展功能,简化异步编程的复杂性,并且提供函数式编程的能力
   > - Future:执行异步执行功能
   > - CompletionStage:提供任务执行阶段

3. CompletableFuture:四个静态方法创建异步任务,如果没有指定Executor,使用默认的线程池ForkJoinPool

   ```java
   // 创建无返回值的异步CompletableFuture
   static CompletableFuture<Void> runAsync(Runnable runnable);
   static CompletableFuture<Void> runAsync(Runnable runnable, Executor executor);
   
   // 创建有返回值的异步CompletableFuture
   static <U> CompletableFuture<U> supplyAsync(Supplier<U> supplier);
   static <U> CompletableFuture<U> supplyAsync(Supplier<U> supplier, Executor executor)
   ```

4. runAsync:使用自定义线程池,CompletableFuture.runAsync的基本用法

   ```java
   public static void main(String[] args) throws ExecutionException, InterruptedException {
     ExecutorService ex = Executors.newFixedThreadPool(3);
     CompletableFuture<Void> f = CompletableFuture.runAsync(() -> {
       try {
         TimeUnit.SECONDS.sleep(3);
       } catch (InterruptedException e) {
         e.printStackTrace();
       }
       System.out.println(Thread.currentThread().getName());
     },ex);
     System.out.println(f.get());
     ex.shutdown();
   }
   ```

5. supplyAsync:CompletableFuture.supplyAsync基本用法,获取执行结果

   ```java
   public static void main(String[] args) throws ExecutionException, InterruptedException {
     CompletableFuture<String> f = CompletableFuture.supplyAsync(() -> {
       try {
         TimeUnit.SECONDS.sleep(3);
       } catch (InterruptedException e) {
         e.printStackTrace();
       }
       return "异步执行结果";
     });
     System.out.println(f.get());
   }
   ```

6. CompletableFuture异步编程:用法类型JavaScript中Promise的then和catch

   ```java
   public static void main(String[] args) throws ExecutionException, InterruptedException {
     CompletableFuture<String> f = CompletableFuture.supplyAsync(() -> {
       try {
         TimeUnit.SECONDS.sleep(3);
       } catch (InterruptedException e) {
         e.printStackTrace();
       }
       return "异步执行结果";
     }).whenComplete((v,e)->{
       if (e == null) {
         System.out.println("whenComplete-->"+v);
       }
     }).exceptionally(e->{
       e.printStackTrace();
       return null;
     });
   	// ForkJoinPool线程池,如果守护线程执行完成,线程池会立刻关闭
     TimeUnit.SECONDS.sleep(3);
     System.out.println("main-->"+Thread.currentThread().getName());
   }
   ```

7. CompletableFuture:链式语法,join不会报出编译时异常

   ```java
   public class DemoCompletableFuture04 {
       static ExecutorService service = Executors.newFixedThreadPool(4);
       // 三个销售平台
       static List<NetMall> malls = Arrays.asList(
               new NetMall("jd"),
               new NetMall("tb"),
               new NetMall("dd")
       );
   
       // 普通的方式: 获取某本书在每个平台上的价格
       public static List<String> prices(List<NetMall> malls, String bookName) {
           return malls.stream()
                   .map(mall -> String.format(bookName + " in %s price is %.2f", mall.getName(), mall.bookPrice(bookName)))
                   .collect(Collectors.toList());
       }
   
       public static List<String> pricesByCompleteFuture(List<NetMall> malls, String bookName) {
           return malls.stream()
                   .map(mall -> CompletableFuture.supplyAsync(() -> {
                       return String.format(bookName + " in %s price is %.2f", mall.getName(), mall.bookPrice(bookName));
                   }))
                   .collect(Collectors.toList())
                   .stream()
                   .map(CompletableFuture::join)
                   .collect(Collectors.toList());
       }
   
       public static void main(String[] args) throws ExecutionException, InterruptedException {
           long start1 = System.currentTimeMillis();
           List<String> mysql = pricesByCompleteFuture(malls, "mysql");
           mysql.forEach(System.out::println);
           System.out.println("异步执行" + (System.currentTimeMillis() - start1));
   
           long start2 = System.currentTimeMillis();
           List<String> mysql2 = prices(malls, "mysql");
           mysql2.forEach(System.out::println);
           System.out.println("同步执行" + (System.currentTimeMillis() - start2));
       }
   }
   
   /**
    * 电商平台
    */
   @Getter
   @AllArgsConstructor
   class NetMall {
       private String name;
   
       public double bookPrice(String bookName) {
           try {
               TimeUnit.SECONDS.sleep(1);
           } catch (InterruptedException e) {
               e.printStackTrace();
           }
           return ThreadLocalRandom.current().nextDouble() * 2 + bookName.charAt(0);
       }
   }
   ```

8. CompletableFuture常用API

   | 获取结果                        | 说明                                                         |
   | ------------------------------- | ------------------------------------------------------------ |
   | get()                           | 获取结果,有编译异常                                          |
   | get(long timeout,TimeUnit unit) | 获取结果,设置超时时间                                        |
   | join()                          | 获取结果,没有编译异常                                        |
   | getNow(T value)                 | 获取结果,如果没有结果返回参数                                |
   | **主动触发计算**                |                                                              |
   | complete(T value)               | 触发计算,如果没有结果返回参数                                |
   | **对计算结果处理**              |                                                              |
   | thenApply                       | 计算结果存在依赖,线程串行                                    |
   | handle                          | 计算结果存在依赖,线程串行,可以处理异常                       |
   | **对计算结果消费**              |                                                              |
   | thenAccept                      | 拿到执行结果,直接消费,没有返回                               |
   | thenRun<br />thenRunAsync       | 自定义任务线程池<br /> - 第一个定义了线程池,后续也会使用<br /> - 异步线程池独立 |
   | **对计算速度筛选**              |                                                              |
   | applyToEither                   | 和其他Future做对比,返回先执行完成的                          |
   | **对介绍结果合并**              |                                                              |
   | thenCombine                     | 合并多个任务                                                 |

# 4. Java锁

1. 乐观锁和悲观锁

   - 乐观锁:认为自己在使用数据时候不会有其他线程修改数据,在获取数据时候不会添加锁,但是会给数据打标识,修改最后修改数据时间检查一下数据标识,如果没有被其他线程修改就修改数据,如果被其他线程修改,会放弃修改或重新获取锁;,最常用采用的是CAS算法那,java原子类的递增操作就是
   - 悲观锁:认为自己在使用数据的时候一定会有其他线程类修改数据,因此在获取数据时候会先加锁,确保数据不会被其他线程修改,synchronized关键字和Lock的实现都是悲观锁

2. 8中锁案例

   1. 标准访问: 一个对象里面有个多个synchronized方法,某一时刻,只要有一个线程调用了synchronized方法,其他线程只能等待,锁的是当前对象;

   2. 邮件延迟3秒:也是先发邮件

      ```java
      class Phone {
        public synchronized void sendEmail() {
          System.out.println("发送邮件");
        }
      
        public synchronized void sendMsg() {
          System.out.println("发送短信");
        }
      }
      public static void lock01() throws InterruptedException {
        Phone phone1 = new Phone();
        Phone phone2 = new Phone();
        new Thread(() -> {
          phone1.sendEmail();
        }, "a").start();
        TimeUnit.SECONDS.sleep(1);
        new Thread(() -> {
          phone1.sendMsg();
        }, "a").start();
      }
      ```

   3. 添加普通的hello方法:没有竞争关系,先发hello

      ```java
      class Phone {
        public synchronized void sendEmail() {
          System.out.println("发送邮件");
        }
      
        public synchronized void sendMsg() {
          System.out.println("发送短信");
        }
      
        public void hello() {
          System.out.println("hello");
        }
      }
      public static void lock01() throws InterruptedException {
        Phone phone1 = new Phone();
        new Thread(() -> {
          phone1.sendEmail();
        }, "a").start();
        TimeUnit.SECONDS.sleep(1);
        new Thread(() -> {
          phone1.hello();
        }, "a").start();
      }
      ```

   4. 两部手机分步发送:锁的是对象,如果用两个对象,锁不会产生竞争

   5. 两个静态同步方法 或 两部手机两个静态同步方法:静态同步方法,加锁的是类,

      ```java
      class Phone {
          public static synchronized void sendEmail() {
              System.out.println("发送邮件");
          }
      
          public static synchronized void sendMsg() {
              System.out.println("发送短信");
          }
      }
      ```

   6. 静态同步方法的锁不会和对象锁发生竞争:锁的位置和锁的对象都不一致

3. synchronized 同步代码块

   - 编写同步代码块

     ```java
     public class Demo02Synchronized {
         Object object = new Object();
         public void m1(){
             synchronized (object) {
                 System.out.println("hello");
             }
         }
     }
     ```

   - 使用javap -c查看:同步代码块实现使用monitorenter和monitorexit指令,两个monitorexit是为了保证出现异常也能释放锁;

     ```tex
       public void m1();
         descriptor: ()V
         flags: ACC_PUBLIC
         Code:
           stack=2, locals=3, args_size=1
              0: aload_0
              1: getfield      #7                  // Field object:Ljava/lang/Object;
              4: dup
              5: astore_1
              6: monitorenter
              7: getstatic     #13                 // Field java/lang/System.out:Ljava/io/PrintStream;
             10: ldc           #19                 // String hello
             12: invokevirtual #21                 // Method java/io/PrintStream.println:(Ljava/lang/String;)V
             15: aload_1
             16: monitorexit
             17: goto          25
             20: astore_2
             21: aload_1
             22: monitorexit
             23: aload_2
             24: athrow
             25: return
     ```

4. synchronized 同步方法

   - 定义同步方法

     ```java
     public class Demo02Synchronized {
         public synchronized void m2() {
             System.out.println("hello");
         }
     }
     ```

   - 使用javap -v查看:会添加ACC_SYNCHRONIZED标识,JVM会根据这个标识执行线程会 先持有monitor锁,最后方法完成后是否锁

     ```tex
       public synchronized void m2();
         descriptor: ()V
         flags: ACC_PUBLIC, ACC_SYNCHRONIZED
         Code:
           stack=2, locals=1, args_size=1
              0: getstatic     #13                 // Field java/lang/System.out:Ljava/io/PrintStream;
              3: ldc           #19                 // String hello
              5: invokevirtual #21                 // Method java/io/PrintStream.println:(Ljava/lang/String;)V
              8: return
           LineNumberTable:
             line 13: 0
             line 14: 8
           LocalVariableTable:
             Start  Length  Slot  Name   Signature
                 0       9     0  this   Lcom/juc/demo04/Demo02Synchronized;
     ```

5. synchronized 静态同步方法

   - 静态同步方法

     ```java
     public class Demo02Synchronized {
       public synchronized void m2() {
         System.out.println("hello");
       }
       public static synchronized void m3() {
         System.out.println("hello");
       }
     }
     ```

   - 使用javap -v查看m2和m3:静态同步方法会添加ACC_STATIC标识

     ```tex
       public synchronized void m2();
         descriptor: ()V
         flags: ACC_PUBLIC, ACC_SYNCHRONIZED
         Code:
           stack=2, locals=1, args_size=1
              0: getstatic     #13                 // Field java/lang/System.out:Ljava/io/PrintStream;
              3: ldc           #19                 // String hello
              5: invokevirtual #21                 // Method java/io/PrintStream.println:(Ljava/lang/String;)V
              8: return
           LineNumberTable:
             line 13: 0
             line 14: 8
           LocalVariableTable:
             Start  Length  Slot  Name   Signature
                 0       9     0  this   Lcom/juc/demo04/Demo02Synchronized;
     
       public static synchronized void m3();
         descriptor: ()V
         flags: ACC_PUBLIC, ACC_STATIC, ACC_SYNCHRONIZED
         Code:
           stack=2, locals=0, args_size=0
              0: getstatic     #13                 // Field java/lang/System.out:Ljava/io/PrintStream;
              3: ldc           #19                 // String hello
              5: invokevirtual #21                 // Method java/io/PrintStream.println:(Ljava/lang/String;)V
              8: return
           LineNumberTable:
             line 17: 0
             line 18: 8
     ```

6. synchronized锁的是什么:管程也称为监视器,是一种程序结构,结构内的多个子程序,形成多个工作线程互斥访问共享资源,monitor是通过OjbectMonitor实现,每个对象都可以成为锁

7. 锁的类型

   - 公平锁和非公平锁:java多线程抢夺同一份资源为了避免乱序,保证数据的一致性和安全性

     - 公平锁:多个线程按照申请锁的顺序来获取锁,会增加线程切换的开销

       ```java
       ReentrantLock lock = new ReentrantLock(true);
       ```

     - 非公平锁:不是按照申请顺序获取锁,默认是非公平锁.可以尽可能的利用CPU

       ```java
       ReentrantLock lock = new ReentrantLock();
       ReentrantLock lock = new ReentrantLock(false);
       ```

   - 可重入锁(递归锁):是指在同一个线程在外层方法获取锁的时候,在进入线程内层方法会自动获取锁(锁对象是同一个对象),不会应为之前已经获取过锁还没释放而阻塞,ReentrantLock和synchronized都是可重入锁;

   - 死锁:两个线程相互等待对方释放锁

     ```sh
     jps -l
     jstack 进程编号
     
     # 或者 
     jconsole图形化工具
     ```

   - 写锁与读锁

   - 自旋锁

   - 无锁->独占锁->读写锁->邮戳锁

   - 无锁->偏向锁->轻量锁->重量锁

# 5. LockSupport与线程中断

1. LockSupport:java.util.current.locks包中,是AQS的基础,
2. 线程中断机制:首先,一个线程不应该由其他线程来强制中断或者停止,应该由线程自己停止,其次,Java中没有方法立即停止一个线程,因此Java提供了停止线程的协商机制--中断,即中断标识协商机制,但是中断只是协商机制,Java没有提供中断的语法,中断过程由程序员自己实现,要中断一个线程需要调用该线程的interrupt方法,改方法仅仅将线程对象的中断标识设置为true,需要不断的检查当前线程的标识为位,如果为true标识其他线程请求中断,具体如何操作需要自己实现
3.  

# 6. Java内存模型

# 7. volatile

# 8. CAS

# 9. 原子操作类

# 10. ThreadLocal

# 11. Java对象内存布局

# 12. Synchronized

# 13. AbstractQueuedSynchronizer:AQS 

# 14. ReentrantLock