# SpringBoot任务

## 异步任务

### :anchor: Springboot异步任务说明

​		在Java应用中，绝大多数情况下都是通过同步的方式来实现交互处理的；但是在处理与第三方系统交互的时候，容易造成响应迟缓的情况，之前大部分都是使用多线程来完成此类任务，其实，在spring 3.x之后，就已经内置了@Async来完美解决这个问题。

​		同步就是整个处理过程顺序执行，当各个过程都执行完毕，并返回结果。 异步调用则是只是发送了调用的指令，调用者无需等待被调用的方法完全执行完毕；而是继续执行下面的流程。

### :anchor: @Async基本使用

1. 在Spring中启用@Async

   - 基于Java配置

     ```java
     @Configuration
     @EnableAsync
     public class SpringAsyncConfig {
         ... 
     }
     ```

   - 基于XML配置

     ```xml
     <task:executor id="myexecutor" pool-size="5"  />
     <task:annotation-driven executor="myexecutor"/>
     ```

2. @Async方法调用

   - 基于@Async无返回值调用

     ```java
     @Async  //标注使用
     public void methodName() {
         ...
     }
     ```

   - 基于@Async返回值的调用

     ```java
     @Async
     public Future<String> methodName() {
         ...
         return new AsyncResult<String>("hello world !!!!");
     }
     ```

     > 返回的数据类型为Future类型，其为一个接口。具体的结果类型为AsyncResult

## 定时任务

### :anchor: 基于注解(@Scheduled)

1. 开启SpringBoot基于注解的定时任务

   ```java
   @SpringBootApplication
   @EnableScheduling
   public class SpringAsyncConfig {
       ... 
   }
   ```

2. 为需要定时执行的方法添加定时器

   ```java
   @Scheduled(cron = "定时表达式")
   public void methodName() {
       ... 
   }
   ```

3. 定时表达式用法

   - 7个字段说明

     | 字段 | 允许值                               | 运行特殊符号  |
     | ---- | ------------------------------------ | ------------- |
     | 秒   | 0-59                                 | , - * /       |
     | 分   | 0-59                                 | , - * /       |
     | 时   | 0-23                                 | , - * /       |
     | 日期 | 2-31                                 | , - * / L W C |
     | 月份 | 1-12                                 | , - * /       |
     | 星期 | 0-7<br />MON TUE WED THU FRI SAT SUN | , - * ? L C # |

   - 特殊符号说明

     | 符号 | 作用                                                         |
     | ---- | ------------------------------------------------------------ |
     | ,    | 枚举，表达一个列表值                                         |
     | -    | 区间，表达一个范围                                           |
     | *    | 任意，可用在所有字段中，表示对应时间域的每一个时刻           |
     | /    | 步长，x/y 表达一个等步长序列，x 为起始值，y 为增量步长值     |
     | ?    | 日/星期冲突匹配，只在日期和星期字段中使用，相当于占位符      |
     | L    | 最后，只在日期和星期字段中使用，代表“Last”的意思             |
     | W    | 工作日，只能出现在日期字段里，是对前导日期的修饰，表示离该日期最近的工作日 |
     | C    | 和calendar联系后计算过的值                                   |
     | #    | 星期：4#2 表示第二个星期三                                   |

### :anchor: 基于接口（SchedulingConfigurer）

1. 导入依赖包

   ```xml
   <parent>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-starter</artifactId>
       <version>2.0.4.RELEASE</version>
   </parent>
   
   <dependencies>
       <dependency><!--添加Web依赖 -->
           <groupId>org.springframework.boot</groupId>
           <artifactId>spring-boot-starter-web</artifactId>
       </dependency>
       <dependency><!--添加MySql依赖 -->
           <groupId>mysql</groupId>
           <artifactId>mysql-connector-java</artifactId>
       </dependency>
       <dependency><!--添加Mybatis依赖 配置mybatis的一些初始化的东西-->
           <groupId>org.mybatis.spring.boot</groupId>
           <artifactId>mybatis-spring-boot-starter</artifactId>
           <version>1.3.1</version>
       </dependency>
       <dependency><!-- 添加mybatis依赖 -->
           <groupId>org.mybatis</groupId>
           <artifactId>mybatis</artifactId>
           <version>3.4.5</version>
           <scope>compile</scope>
       </dependency>
   </dependencies>
   ```

2. 定义配置配置类查询数据库，制定定时任务

   ```java
   @Configuration
   @EnableScheduling
   public class DynamicScheduleTask implements SchedulingConfigurer {
   	 @Override
       public void configureTasks(ScheduledTaskRegistrar taskRegistrar) {
       	taskRegistrar.addTriggerTask(Runnable task, Trigger trigger);
       }
   }
   ```

   - Runnable task：表示需要执行的定时任务
   - Trigger trigger：表示从数据库查询的定时任务，返回执行周期。

3. 数据库和定时任务表可以自定义设计，在Trigger接口的实现中完成查询即可；

### :anchor: 基于注解设定多线程定时任务

1. 定义一个用作执行定时任务的类，在这个定时任务类中定义多个方法使用注解使其成为定时任务

   ```java
   import org.springframework.scheduling.annotation.Async;
   import org.springframework.scheduling.annotation.EnableAsync;
   import org.springframework.scheduling.annotation.EnableScheduling;
   import org.springframework.scheduling.annotation.Scheduled;
   import org.springframework.stereotype.Component;
   
   import java.time.LocalDateTime;
   
   
   @Component
   @EnableScheduling   // 1.开启定时任务
   @EnableAsync        // 2.开启多线程
   public class MultithreadScheduleTask {
   
       @Async
       @Scheduled(fixedDelay = 1000)  //间隔1秒
       public void first() throws InterruptedException {
           System.out.println("第一个定时任务开始 : " + LocalDateTime.now().toLocalTime());
           System.out.println();
           Thread.sleep(1000 * 10);
       }
   
       @Async
       @Scheduled(fixedDelay = 2000)
       public void second() {
           System.out.println("第二个定时任务开始 : " + LocalDateTime.now().toLocalTime());
       }
   }
   ```

## 发送邮件任务

