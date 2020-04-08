# 1.Java的Timer

- 1000ms是延迟启动时间，2000ms是定时任务周期，每2s执行一次

    ```java
    new Timer("testTimer").schedule(new TimerTask() {
                @Override
                public void run() {
                    System.out.println("TimerTask");
                }
            }, 1000,2000);
    ```

- date是开始时间，2000ms是定时任务周期，每2s执行一次

    ```java
    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS");
    try {
        Date date = dateFormat.parse("2018-07-11 12:00:00.000");
        new Timer("testTimer1").scheduleAtFixedRate(new TimerTask() {
            @Override
            public void run() {
                System.out.println("TimerTask");
            }
        }, date,2000);
    } catch (ParseException e) {
        e.printStackTrace();
    }
    ```

- timer有2中方法schedule和scheduleAtFixedRate，前者会等任务结束在开始计算时间间隔，后者是在任务开始就计算时间，有并发的情况

# 2.ScheduledExecutorService

- 延迟1s启动，执行一次

    ```java
    ScheduledExecutorService.schedule(new Runnable() {
                @Override
                public void run() {
                    System.out.println("ScheduledTask");
                }
            },1, TimeUnit.SECONDS);
    ```

- 延迟1s启动，每隔1s执行一次，是前一个任务开始时就开始计算时间间隔，但是会等上一个任务结束在开始下一个

    ```java
    ScheduledExecutorService scheduledExecutorService = Executors.newScheduledThreadPool(10);
            scheduledExecutorService.scheduleAtFixedRate(new Runnable() {
                @Override
                public void run() {
                    System.out.println("ScheduledTask");
                }
            }, 1, 1, TimeUnit.SECONDS);
    ```

- 延迟1s启动，在前一个任务执行完成之后，延迟1s在执行

    ```java
    ScheduledExecutorService scheduledExecutorService = Executors.newScheduledThreadPool(10);
            scheduledExecutorService.scheduleWithFixedDelay(new Runnable() {
                @Override
                public void run() {
                    System.out.println("ScheduledTask");
                }
            }, 1, 1, TimeUnit.SECONDS);
    ```

# 3.SpringTask

:one: 写任务类

- task1是每隔5s执行一次，{秒} {分} {时} {日期} {月} {星期}

- task2是延迟1s,每隔1S执行一次

    ```java
    import com.zb.controller.StudentController;
    import org.slf4j.Logger;
    import org.slf4j.LoggerFactory;
    import org.springframework.scheduling.annotation.Scheduled;
    import org.springframework.stereotype.Service;
    
    @Service
    public class SpringTask {
        private static final Logger log = LoggerFactory.getLogger(SpringTask.class);
    
        @Scheduled(cron = "1/5 * * * * *")
        public void task1(){
            log.info("springtask 定时任务！");
        }
        
        @Scheduled(initialDelay = 1000,fixedRate = 1*1000)
        public void task2(){
            log.info("springtask 定时任务！");
        }
    }
    ```

:two: 配置文件修改

- 方式一:简单版

    ```xml
    <task:annotation-driven/>
    ```

- 方式二:任务池版

    ```xml
    <task:executor id="executor" pool-size="10" />
    <task:scheduler id="scheduler" pool-size="10" />
    <task:annotation-driven executor="executor" scheduler="scheduler" />
    ```

> 假如只有一个定时任务，可以用简单版；如果有多个定时任务，则要用任务池，不然它会顺序执行。
>
> 两个任务的时间间隔为：执行时间+设定的定时间隔

# 4.SpringBootTask

- `@Scheduled`失效原因

    - `@Scheduled`注解的源码，主要说明了注解可使用的参数形式，在注解中使用了`Schedules`这个类。
    - `Spring`容器加载完`bean`之后，`postProcessAfterInitialization`将拦截所有以`@Scheduled`注解标注的方法。
    - `processScheduled`获取scheduled类参数，之后根据参数类型、相应的延时时间、对应的时区将定时任务放入不同的任务列表中。
    - 满足条件时将定时任务添加到定时任务列表中，在加入任务列表的同时对定时任务进行注册。ScheduledTaskRegistrar这个类为Spring容器的定时任务注册中心。以下为ScheduledTaskRegistrar部分源码，主要说明该类中包含的属性。Spring容器通过线程处理注册的定时任务。
    - `ScheduledTaskRegistrar`类中在处理定时任务时会调用`scheduleCronTask`方法初始化定时任务
    - 在ThreadPoolTaskShcedule这个类中，进行线程池的初始化。在创建线程池时会创建 DelayedWorkQueue()阻塞队列，定时任务会被提交到线程池，由线程池进行相关的操作，线程池初始化大小为1。当有多个线程需要执行时，是需要进行任务等待的，前面的任务执行完了才可以进行后面任务的执行。
    - 根本原因，jvm启动之后会记录系统时间，然后jvm根据CPU ticks自己来算时间，此时获取的是定时任务的基准时间。如果此时将系统时间进行了修改，当Spring将之前获取的基准时间与当下获取的系统时间进行比对时，就会造成Spring内部定时任务失效。因为此时系统时间发生变化了，不会触发定时任务。

- 解析流程图

    ![这里写图片描述](https://img-blog.csdn.net/20180618104845994?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L0RpYW1vbmRfVGFv/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

- 使用新的方法

    为了避免使用@Scheduled注解在修改服务器时间导致定时任务不执行情况的发生。在项目中需要使用定时任务场景的情况下，使ScheduledThreadPoolExecutor进行替代，它任务的调度是基于相对时间的，原因是它在任务的内部 存储了该任务距离下次调度还需要的时间（使用的是基于 System.nanoTime实现的相对时间 ，不会因为系统时间改变而改变，如距离下次执行还有10秒，不会因为将系统时间调前6秒而变成4秒后执行）。

# 5.Quartz框架

## ★ Quartz入门

:one:添加依赖

```xml
<!-- quartz -->
<dependency>
  <groupId>org.quartz-scheduler</groupId>
  <artifactId>quartz</artifactId>
  <version>2.3.0</version>
</dependency>
<!--调度器核心包-->
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-context-support</artifactId>
    <version>4.3.4.RELEASE</version>
</dependency>
```

:two: Job实现

```java
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class HelloWorldJob implements Job {
    @Override
    public void execute(JobExecutionContext jobExecutionContext) throws JobExecutionException {
        String strTime = new SimpleDateFormat("HH-mm-ss").format(new Date());
        System.out.println( strTime + ":Hello World！");
    }
}
```

:three: 调度器(可以用listener在项目启动时执行)

- 简单触发器

    ```java
    import org.quartz.*;
    import org.quartz.impl.StdSchedulerFactory;
    
    public class MyScheduler {
        public static void main(String[] args) throws SchedulerException {
            //创建调度器Schedule
            SchedulerFactory schedulerFactory = new StdSchedulerFactory();
            Scheduler scheduler = schedulerFactory.getScheduler();
            //创建JobDetail实例，并与HelloWordlJob类绑定
            JobDetail jobDetail = JobBuilder.newJob(HelloWorldJob.class).withIdentity("job1", "jobGroup1")
                    .build();
            //创建触发器Trigger实例(立即执行，每隔1S执行一次)
            Trigger trigger = TriggerBuilder.newTrigger()
                    .withIdentity("trigger1", "triggerGroup1")
                    .startNow()
                    .withSchedule(SimpleScheduleBuilder.simpleSchedule().withIntervalInSeconds(1).repeatForever())
                    .build();
            //开始执行
            scheduler.scheduleJob(jobDetail, trigger);
            scheduler.start();
        }
    }
    ```

- 用Con触发器

    ```java
    Trigger cronTrigger = TriggerBuilder.newTrigger()
                    .withIdentity("trigger2", "triggerGroup2")
                    .startNow()
                    .withSchedule(cronSchedule("0 42 10 * * ?"))
                    .build();
    ```

:four: 整合spring

- JOB

    ```java
    import java.text.SimpleDateFormat;
    import java.util.Date;
    
    public class QuarFirstJob {
        public void first() {
            String strTime = new SimpleDateFormat("HH-mm-ss").format(new Date());
            System.out.println( strTime + ":Hello World！");
        }
    }
    ```

- Spring.xml配置文件

    ```xml
    <bean id="QuarFirstJob" class="com.zb.quartz.QuarFirstJob" />
    
    <bean id="jobDetail"
          class="org.springframework.scheduling.quartz.MethodInvokingJobDetailFactoryBean">
        <property name="group" value="quartzGroup1" />
        <property name="name" value="quartzJob1" />
        <!--false表示等上一个任务执行完后再开启新的任务 -->
        <property name="concurrent" value="false" />
        <property name="targetObject">
            <ref bean="QuarFirstJob" />
        </property>
        <property name="targetMethod">
            <value>first</value>
        </property>
    </bean>
    
    <!-- 调度触发器 -->
    <bean id="myTrigger"
          class="org.springframework.scheduling.quartz.CronTriggerFactoryBean">
        <property name="name" value="trigger1" />
        <property name="group" value="group1" />
        <property name="jobDetail">
            <ref bean="jobDetail" />
        </property>
        <property name="cronExpression">
            <value>0/5 * * * * ?</value>
        </property>
    </bean>
    
    <!-- 调度工厂 -->
    <bean id="scheduler"
          class="org.springframework.scheduling.quartz.SchedulerFactoryBean">
        <property name="triggers">
            <list>
                <ref bean="myTrigger" />
            </list>
        </property>
    </bean>
    ```

    :five: 时间

    ```java
    public class QuarFirstJob {
        public void first() {
            try {
                TimeUnit.SECONDS.sleep(6);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            String strTime = new SimpleDateFormat("HH-mm-ss").format(new Date());
            System.out.println( strTime + ":Hello World！");
        }
    }
    ```

    # 总结

    Quartz是执行时间和间隔时间的最大值(比如；执行时间是3s,间隔是2s,则每3s执行一次；执行时间是3s,间隔是5s,则每5s执行一次。)
    Spring task是执行时间+间隔时间(比如；执行时间是3s,间隔是2s,则每5s执行一次；执行时间是3s,间隔是5s,则每8s执行一次。)
    timer有2中方法schedule和scheduleAtFixedRate，前者会等任务结束在开始计算时间间隔，后者是在任务开始就计算时间，有并发的情况
    ScheduledExecutorService的scheduleAtFixedRate类似Quartz，scheduleWithFixedDelay类似SpringTask

# 第五部分 Quartz框架

## 第一章 Quartz入门

### 1.1 Quartz介绍

​		Quartz是OpenSymphony开源组织在Job scheduling领域又一个开源项目，完全由Java开发，可以用来执行定时任务，类似于java.util.Timer。但是相较于Timer， Quartz增加了很多功能：持久性作业 - 就是保持调度定时的状态；作业管理 - 对调度作业进行有效的管理;

### 1.2 Quartz基本坏境

- Quartz的使用场景

  1. 可以嵌入在另一个独立应用程序
  2. 可以在用于程序服务器内被实例化，并参与事务
  3. 可以作为一个独立程序运行，可以通过远程方法调用RMI(Remote Method Invocation)
  4. 可以被实例化，作为独立项目集群，用于作业的执行

- Quartz基本依赖

  ```xml
  <dependency>
      <groupId>org.quartz-scheduler</groupId>
      <artifactId>quartz</artifactId>
      <version>2.3.0</version>
  </dependency>
  <dependency>
      <groupId>org.quartz-scheduler</groupId>
      <artifactId>quartz-jobs</artifactId>
      <version>2.3.0</version>
  </dependency>
  ```

- Quartz的SpringBoot启动器

  ```xml
  <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-quartz</artifactId>
  </dependency>
  <dependency>
      <groupId>org.quartz-scheduler</groupId>
      <artifactId>quartz-jobs</artifactId>
  </dependency>
  ```

### 1.3 Quartz入门案例

1. Quartz的基本组成部分：

   - 调度器：Scheduler - 负责Job和Trigger后结合起来
   - 任务：JobDetail - 实现Job接口的一个定时功能
   - 触发器：Trigger - 能够实现触发任务去执行的触发器，包括SimpleTrigger和CronTrigger

2. 案例代码

   ```java
   public class HelloJob implements Job {
       @Override
       public void execute(JobExecutionContext context) throws JobExecutionException {
           System.out.println("LocalDateTime.now() = " + LocalDateTime.now());
       }
   
       public static void main(String[] args) throws Exception {
           // 从调度器工厂获取调度器
           Scheduler scheduler = StdSchedulerFactory.getDefaultScheduler();
           // 创建JobDetail
           JobDetail jobDetail = JobBuilder.newJob(HelloJob.class)
                   .withIdentity(new JobKey("hello_job_name", "hello_job_gup"))
                   .build();
           // 创建触发器
           Trigger trigger = TriggerBuilder.newTrigger()
                   .withIdentity(new TriggerKey("hello_trigger_key", "hello_trigger_gup"))
                   .startNow()
                   .withSchedule(SimpleScheduleBuilder.repeatSecondlyForever(5))
                   .build();
           // 添加任务到调度执行计划列表
           scheduler.scheduleJob(jobDetail, trigger);
   
           // 启动
           scheduler.start();
       }
   }
   ```

## 第二章 Quartz详细说明

### 2.1 QuartzAPI

1. Quartz体系结构

   <img src="https://s1.ax1x.com/2020/04/07/GgyYrQ.png" alt="GgyYrQ.png" border="0" />

2. Quartz主要组件说明

   - Scheduler：用于与调度程序交互的的主程序接口；成为任务执行计划表：只有安排进执行计划的Job，符合预定义的触发时间（Trigger），该任务才会被执行；

     | 方法名称                        | 说明               |
     | ------------------------------- | ------------------ |
     | scheduleJob(jobDetail, trigger) | 添加任务到调度列表 |
     | start()                         | 启动               |
     | shutdown()                      | 停止               |
     | deleteJob(JobKey key)           | 删除               |
     | resumeAll()                     | 恢复所有           |
     | resumeJob()                     | 恢复任务           |

   - Job：自定义的希望在未来时间能够被调度执行的类，主要包含执行的业务逻辑；

     - JobExecutionContext：任务执行参数：可以访问到Quartz运行时环境和对应Job本身的明细数据，Scheduler执行Job时候，会将这个参数传递给Job接口的JobExecutionContext参数中

       | 方法名称              | 说明           |
       | --------------------- | -------------- |
       | getJobDetail()        | JobDetail      |
       | getTrigger()          | Trigger        |
       | getScheduler()        | Scheduler      |
       | getMergedJobDataMap() | JobDataMap     |
       | getFireTime()         | 第一次执行时间 |

     - JobDataMap：可以包含数据对象，在Job执行的时候可以使用其中的对象；

   - JobDetail：是对Job的进一步的包装，主要用于描述对应Job的详细信息，由JobBuilder创建；

     - JobBuilder：声明任务实例，并定义任务详情，如任务组，任务名称；

     | 方法名称         | 说明             |
     | ---------------- | ---------------- |
     | getKey()         | 获取Job详情      |
     | getJobClass()    | 获取Job执行Class |
     | getJobDataMap()  | 获取JobDataMap   |
     | getDescription() | 获取Job描述信息  |

   - Trigger：主要用于定义触发时间的类，需要添加进任务执行计划表才会生效，由TriggerBuilder创建；

     - TriggerBuilder：创建Trigger实例，并定义改实例的详情，如触发器组名，触发器名称；
     - SimpleScheduleBuilder：
     - CronScheduleBuilder：
     - CalendarIntervalScheduleBuilder：
     - DailyTimeIntervalScheduleBuilder：

     | 方法名称              | 说明             |
     | --------------------- | ---------------- |
     | getKey()              | 获取调度器详情   |
     | getNextFireTime()     | 获取下次执行时间 |
     | getPreviousFireTime() | 获取上次执行时间 |
     | getJobDataMap()       | 获取JobDataMap   |
     | getJobKey()           | 获取Job详情      |

   - JobListener、TriggerListener、SchedulerListener监听器：用于对组件的监听；

### 2.2 Quartz配置说明

- quartz.properties

  ```properties
  
  ```

### 2.3 Quartz监听器

## 第三章 Quartz与SpringBoot

 