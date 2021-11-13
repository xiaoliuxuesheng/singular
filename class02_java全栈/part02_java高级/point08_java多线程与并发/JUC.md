001-学习内容

1. 课程大纲
   - JUC概述
     - 什么是JUC
     - 线程与进程的概念
   - Lock接口
     - 复习Synchronized
     - 什么是Lock接口
     - 创建线程的方式
     - Lock卖票案例
   - 线程间通信
   - 线程间定制化通信
   - 集合的线程安全
     - 集合的不安全演示
     - 解决方案Vector
     - 解决方案Collections
     - 解决方案CopyOnWriteArrayList
   - 多线程锁
   - Callable接口
   - JUC强大辅助类
   - ReentrantReadWriteLock读写锁
   - BlockingQueue阻塞队列
   - ThreadPool线程池
   - Fork/Join分支合并框架
   - CompletableFuture异步回调

002-003-004-JUC概述 

1. 什么是JUC

2. 进程与线程

3. 线程的状态

4. wait与sleep

   - 这两个方法来自不同的类分别是，sleep来自Thread类，和wait来自Object类。

     > sleep是Thread的静态类方法，谁调用的谁去睡觉，即使在a线程里调用了b的sleep方法，实际上还是a去睡觉，要让b线程睡觉要在b的代码中调用sleep。

   - sleep方法没有释放锁，而wait方法释放了锁，使得其他线程可以使用同步控制块或者方法。

     > sleep不出让系统资源；wait是进入线程等待池等待，出让系统资源，其他线程可以占用CPU。一般wait不会加时间限制，因为如果wait线程的运行资源不够，再出来也没用，要等待其他线程调用notify/notifyAll唤醒等待池中的所有线程，才会进入就绪队列等待OS分配系统资源。sleep(milliseconds)可以用时间指定使它自动唤醒过来，如果时间不到只能调用interrupt()强行打断。
     > Thread.Sleep(0)的作用是“触发操作系统立刻重新进行一次CPU竞争”。

   - 使用范围：wait，notify和notifyAll只能在同步控制方法或者同步控制块里面使用，而sleep可以在任何地方使用

   - sleep必须捕获异常，而wait，notify和notifyAll不需要捕获异常

   - 两者都可以暂停线程的执行。

     对于sleep()方法，我们首先要知道该方法是属于Thread类中的。而wait()方法，则是属于Object类中的。

     Wait 通常被用于线程间交互/通信，sleep 通常被用于暂停执行。

     sleep()方法导致了程序暂停执行指定的时间，让出cpu该其他线程，但是他的监控状态依然保持者，当指定的时间到了又会自动恢复运行状态。

     在调用sleep()方法的过程中，线程不会释放对象锁。

     而当调用wait()方法的时候，线程会放弃对象锁，进入等待此对象的等待锁定池，只有针对此对象调用notify()方法后本线程才进入对象锁定池准备，获取对象锁进入运行状态。线程不会自动苏醒。

5. 并发与并行

   - 串行
   - 并行

6. 管程

   - 是Monitor监视器,就是平时说的锁,本身是一种那哪个同步机制,保证同一时间只能有一个线程对资源进行访问,别的线程不能访问
   - 在JVM中同步操作要进入和退出通过管程对象,每个对象都会有个Monitor管程对象,会随着Java对象一起创建或销毁

7. 用户线程与守护线程

   - 用户线程:平常的自定义线程:Thread.currentThread.isDeamon();
   - 守护线程:后台自动执行的线程,垃圾回收线程

005-006-007-Lock接口

1. 复习Synchronized

   - 修饰代码块
   - 修饰实例方法
   - 修饰静态方法
   - 修饰类

2. 线程是使用步骤

   - 创建资源类,定义资源操作方法
   - 创建线程类,调用资源的操作和方法

3. Synchronized卖票案例

4. Lock接口概述:

   - Lock和ReadWriteLock是两大锁的根接口，Lock代表实现类是ReentrantLock（可重入锁），ReadWriteLock（读写锁）的代表实现类是ReentrantReadWriteLock。

5. Lock接口API

   ```java
   // 获取锁  
   void lock()   
   
   // 如果当前线程未被中断，则获取锁，可以响应中断  
   void lockInterruptibly()   
   
   // 返回绑定到此 Lock 实例的新 Condition 实例  
   Condition newCondition()   
   
   // 仅在调用时锁为空闲状态才获取该锁，可以响应中断  
   boolean tryLock()   
   
   // 如果锁在给定的等待时间内空闲，并且当前线程未被中断，则获取锁  
   boolean tryLock(long time, TimeUnit unit)   
   
   // 释放锁  
   void unlock()
   ```

   - lock():用来获取锁。如果锁已被其他线程获取，则进行等待。在前面已经讲到，如果采用Lock，必须主动去释放锁，并且在发生异常时，不会自动释放锁。因此，一般来说，使用Lock必须在try…catch…块中进行，并且将释放锁的操作放在finally块中进行，以保证锁一定被被释放，防止死锁的发生。通常使用Lock来进行同步的话，

     ```java
     Lock lock = ...;
     lock.lock();
     try{
         //处理任务
     }catch(Exception ex){
     
     }finally{
         lock.unlock();   //释放锁
     }
     ```

   - tryLock() & tryLock(long time, TimeUnit unit):tryLock()方法是有返回值的，它表示用来尝试获取锁，如果获取成功，则返回true；如果获取失败（即锁已被其他线程获取），则返回false，也就是说，这个方法无论如何都会立即返回（在拿不到锁时不会一直在那等待）。

     　　tryLock(long time, TimeUnit unit)方法和tryLock()方法是类似的，只不过区别在于这个方法在拿不到锁时会等待一定的时间，在时间期限之内如果还拿不到锁，就返回false，同时可以响应中断。如果一开始拿到锁或者在等待期间内拿到了锁，则返回true。

     ```java
     Lock lock = ...;
     if(lock.tryLock()) {
          try{
              //处理任务
          }catch(Exception ex){
     
          }finally{
              lock.unlock();   //释放锁
          } 
     }else {
         //如果不能获取锁，则直接做其他事情
     }
     ```

   - lockInterruptibly()方法比较特殊，当通过这个方法去获取锁时，如果线程 正在等待获取锁，则这个线程能够 响应中断，即中断线程的等待状态。例如，当两个线程同时通过lock.lockInterruptibly()想获取某个锁时，假若此时线程A获取到了锁，而线程B只有在等待，那么对线程B调用threadB.interrupt()方法能够中断线程B的等待过程。

     　　由于lockInterruptibly()的声明中抛出了异常，所以lock.lockInterruptibly()必须放在try块中或者在调用lockInterruptibly()的方法外声明抛出 InterruptedException，但推荐使用后者，原因稍后阐述。因此，lockInterruptibly()一般的使用形式如下：

     ```java
     public void method() throws InterruptedException {
         lock.lockInterruptibly();
         try {  
          //.....
         }
         finally {
             lock.unlock();
         }  
     }
     ```

6. Lock的实现类

   - **ReentrantLock**:厕所的案例,进去上锁,出来释放锁
   - 

7. Lock与Synchronized对比

8. 锁的相关概念

   - 可重入锁:如果锁具备可重入性，则称作为 可重入锁 。像 synchronized和ReentrantLock都是可重入锁，可重入性在我看来实际上表明了 锁的分配机制：基于线程的分配，而不是基于方法调用的分配。举个简单的例子，当一个线程执行到某个synchronized方法时，比如说method1，而在method1中会调用另外一个synchronized方法method2，此时线程不必重新去申请锁，而是可以直接执行方法method2。

     ```java
     class MyClass {
         public synchronized void method1() {
             method2();
         }
     
         public synchronized void method2() {
     
         }
     }
     ```

   - 可中断锁:可中断锁就是可以响应中断的锁。在Java中，synchronized就不是可中断锁，而Lock是可中断锁。如果某一线程A正在执行锁中的代码，另一线程B正在等待获取该锁，可能由于等待时间过长，线程B不想等待了，想先处理其他事情，我们可以让它中断自己或者在别的线程中中断它，这种就是可中断锁。在前面演示tryLock(long time, TimeUnit unit)和lockInterruptibly()的用法时已经体现了Lock的可中断性。

   - 公平锁即 尽量 以请求锁的顺序来获取锁。比如，同是有多个线程在等待一个锁，当这个锁被释放时，等待时间最久的线程（最先请求的线程）会获得该所，这种就是公平锁。而非公平锁则无法保证锁的获取是按照请求锁的顺序进行的，这样就可能导致某个或者一些线程永远获取不到锁。

008-线程间通信案例-两个线程对同一个值进行+1 与 -1的操作

1. 使用Synchronized关键字实现:加法-如果值=0等待,否则新增;减法-如果值!=1等待,否则减一;
2. 使用Lock接口实现
3. wait虚假唤醒:从哪里睡从哪里醒,醒了之后会继续执行之后的逻辑,所以wait应该定义在while循环中,醒了后会继续判断

009-定制化通信

1. 线程约定的顺序执行:每个线程执行各自的标志位

010-集合线程安全

1. 异常演示

   ```java
   ```

2. 解决方案Vector

3. 解决方案Collections

4. 解决方案CopyOnWriteArrayList:写时复制技术-每次写的时候先复制一份内容,然后往里面写东西,最后在合并

5. HashSet与HashMap线程不安全演示

018-多线程锁

1. 锁的8个问题

   - 解决问题前，首先需要明白的是 synchronized 只会锁两样东西，一样是调用的对象，一样是Class

   - 问题一：两个普通的锁方法，new一个对象调用，调用过程中间睡1秒，执行结果是什么

     ```java
     public class Test {
         public static void main(String[] args) throws InterruptedException {
             Fun fun = new Fun();
             new Thread(()->{fun.funOne();},"A线程").start();
             TimeUnit.SECONDS.sleep(1);
             new Thread(()->{fun.funTwo();},"B线程").start();
         }
     }
     
     class Fun{
         public synchronized void funOne(){
             System.out.println(Thread.currentThread().getName()+":调用方法一");
         }
         public synchronized void funTwo(){
             System.out.println(Thread.currentThread().getName()+":调用方法二");
         }
     }
     ```

     判断执行顺序，先判断什么被锁了，这里synchronized锁的是Fun对象new出来的fun，因为先调用了funOne睡1秒后调用的funTwo，funTwo需要等到funOne释放锁后才会执行

     最终执行结果是：A线程:调用方法一   B线程:调用方法二

   - 问题二：两个普通的锁方法，new一个对象调用，调用过程中间睡1秒，且在funOne方法中睡3秒，执行结果是什么

     ```java
     public class Test {
         public static void main(String[] args) throws InterruptedException {
             Fun fun = new Fun();
             new Thread(()->{
                 try {  fun.funOne();  } catch (InterruptedException e) {  e.printStackTrace();  }
             },"A线程").start();
             TimeUnit.SECONDS.sleep(1);
             new Thread(()->{fun.funTwo();},"B线程").start();
         }
     }
     
     class Fun{
         public synchronized void funOne() throws InterruptedException {
             TimeUnit.SECONDS.sleep(3);
             System.out.println(Thread.currentThread().getName()+":调用方法一");
         }
         public synchronized void funTwo(){
             System.out.println(Thread.currentThread().getName()+":调用方法二");
         }
     }
     ```

     该情况其实和问题一 一样，synchronized锁的是Fun对象new出来的fun，当调用funOne时，fun被锁，而程序不受funOne内睡的影响继续执行，在调用funTwo的时候因为fun被锁导致等待，当funOne执行完后funTwo瞬间执行

     最终执行结果是：3 秒后同时出现 A线程:调用方法一   B线程:调用方法二

   - 问题三：一个普通的锁方法，一个普通无锁方法，new一个对象调用，在funOne方法中睡3秒，执行结果是什么

     ```java
     public class Test {
         public static void main(String[] args) throws InterruptedException {
             Fun fun = new Fun();
             new Thread(()->{
                 try {  fun.funOne();  } catch (InterruptedException e) {  e.printStackTrace();  }
             },"A线程").start();
             TimeUnit.SECONDS.sleep(1);
             new Thread(()->{fun.funTwo();},"B线程").start();
         }
     }
     
     class Fun{
         public synchronized void funOne() throws InterruptedException {
             TimeUnit.SECONDS.sleep(3);
             System.out.println(Thread.currentThread().getName()+":调用方法一");
         }
         public void funTwo(){
             System.out.println(Thread.currentThread().getName()+":调用方法二");
         }
     }
     ```

     程序执行在funOne中锁了fun并在方法中睡3秒，外部在睡1秒后调用funTwo，因为无锁因此直接执行

     最终执行结果是：1 秒后出现B线程:调用方法二 再2秒后出现 A线程:调用方法一  

   - 问题四：两个普通的锁方法，new两个对象分别调用，在funOne方法中睡3秒，执行结果是什么

     ```java
     public class Test {
         public static void main(String[] args) throws InterruptedException {
             Fun fun1 = new Fun();
             Fun fun2 = new Fun();
             new Thread(()->{
                 try {  fun1.funOne();  } catch (InterruptedException e) {  e.printStackTrace();  }
             },"A线程").start();
             TimeUnit.SECONDS.sleep(1);
             new Thread(()->{fun2.funTwo();},"B线程").start();
         }
     }
     
     class Fun{
         public synchronized void funOne() throws InterruptedException {
             TimeUnit.SECONDS.sleep(3);
             System.out.println(Thread.currentThread().getName()+":调用方法一");
         }
         public synchronized void funTwo(){
             System.out.println(Thread.currentThread().getName()+":调用方法二");
         }
     }
     ```

     程序调用funOne时锁住fun1，外部睡1秒后调用funTwo时锁funTwo，互不影响

     最终执行结果是：B线程:调用方法二   A线程:调用方法一

   - 问题五：两个静态的锁方法，new一个对象调用，在funOne方法中睡3秒，执行结果是什么

     ```java
     public class Test {
         public static void main(String[] args) throws InterruptedException {
             Fun fun = new Fun();
             new Thread(()->{
                 try {  fun.funOne();  } catch (InterruptedException e) {  e.printStackTrace();  }
             },"A线程").start();
             TimeUnit.SECONDS.sleep(1);
             new Thread(()->{fun.funTwo();},"B线程").start();
         }
     }
     
     class Fun{
         public static synchronized void funOne() throws InterruptedException {
             TimeUnit.SECONDS.sleep(3);
             System.out.println(Thread.currentThread().getName()+":调用方法一");
         }
         public static synchronized void funTwo(){
             System.out.println(Thread.currentThread().getName()+":调用方法二");
         }
     }
     ```

     这里多了静态static，因此此时锁的东西改变了，funOne和funTwo都是锁的Fun这个class，程序在执行funOne时锁住Fun class，睡1秒后调用funTwo，funTwo等待funOne内睡完释放锁后再执行

     最终执行结果是：A线程:调用方法一   B线程:调用方法二

   - 问题六：两个静态的锁方法，new两个对象分别调用，在funOne方法中睡3秒，执行结果是什么

     ```java
     public class Test {
         public static void main(String[] args) throws InterruptedException {
             Fun fun1 = new Fun();
             Fun fun2 = new Fun();
             new Thread(()->{
                 try {  fun1.funOne();  } catch (InterruptedException e) {  e.printStackTrace();  }
             },"A线程").start();
             TimeUnit.SECONDS.sleep(1);
             new Thread(()->{fun2.funTwo();},"B线程").start();
         }
     }
     
     class Fun{
         public static synchronized void funOne() throws InterruptedException {
             TimeUnit.SECONDS.sleep(3);
             System.out.println(Thread.currentThread().getName()+":调用方法一");
         }
         public static synchronized void funTwo(){
             System.out.println(Thread.currentThread().getName()+":调用方法二");
         }
     }
     ```

     要注意的是，不管现在new结果对象，调用方法后锁的都是Fun class，funTwo会被funOne阻塞

     最终执行结果是：A线程:调用方法一   B线程:调用方法二

   - 问题七：一个静态的锁方法，一个普通锁方法，new一个对象调用，在funOne方法中睡3秒，执行结果是什么

     ```java
     public class Test {
         public static void main(String[] args) throws InterruptedException {
             Fun fun = new Fun();
             new Thread(()->{
                 try {  fun.funOne();  } catch (InterruptedException e) {  e.printStackTrace();  }
             },"A线程").start();
             TimeUnit.SECONDS.sleep(1);
             new Thread(()->{fun.funTwo();},"B线程").start();
         }
     }
     
     class Fun{
         public static synchronized void funOne() throws InterruptedException {
             TimeUnit.SECONDS.sleep(3);
             System.out.println(Thread.currentThread().getName()+":调用方法一");
         }
         public synchronized void funTwo(){
             System.out.println(Thread.currentThread().getName()+":调用方法二");
         }
     }
     ```

     同样只要确认锁的是不是一个东西就知道会不会阻塞，调用funOne时阻塞的是Fun class，调用funTwo时阻塞的是fun

     最终执行结果是：B线程:调用方法二   A线程:调用方法一

   - 问题八：一个静态的锁方法，一个普通锁方法，new两个对象分别调用，在funOne方法中睡3秒，执行结果是什么

     ```java
     public class Test {
         public static void main(String[] args) throws InterruptedException {
             Fun fun1 = new Fun();
             Fun fun2 = new Fun();
             new Thread(()->{
                 try {  fun1.funOne();  } catch (InterruptedException e) {  e.printStackTrace();  }
             },"A线程").start();
             TimeUnit.SECONDS.sleep(1);
             new Thread(()->{fun2.funTwo();},"B线程").start();
         }
     }
     
     class Fun{
         public static synchronized void funOne() throws InterruptedException {
             TimeUnit.SECONDS.sleep(3);
             System.out.println(Thread.currentThread().getName()+":调用方法一");
         }
         public synchronized void funTwo(){
             System.out.println(Thread.currentThread().getName()+":调用方法二");
         }
     }
     ```

     解题跟问题七一致，调用funOne时阻塞的是Fun class，调用funTwo时阻塞的是fun2

     最终执行结果是：B线程:调用方法二   A线程:调用方法一

