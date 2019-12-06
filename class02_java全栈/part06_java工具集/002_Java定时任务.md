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