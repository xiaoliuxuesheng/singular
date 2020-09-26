1. Quartz概念：OpenSymphony开源组织的在job scheduling领域的开源项目

   - 可以集成任何java项目，也可以部署独立应用；
   - Quartz包含企业级特性：事务、集群的支持；
   - 执行万量级的任务；

2. Quartz运行环境

   - 可以运行嵌入在另一个独立应用程序
   - 可以在应用程序服务区内部被实例化，并且参与事务
   - 可以作为独立的程序运行，可以通过RMI使用
   - 可以被实例化，作为杜磊的项目集群（负载平衡和故障转移功能），用于作业的执行

3. Quartz设计模式

   - Builder模式
   - Factory模式
   - 组件模式
   - 链式编程

4. Quartz核心概念

   - 任务（Job）：就是想要执行的业务类，每个job必须实现Job接口，且实现接口的execute()方法；
   - 触发器（Trigger）：指执行任务的触发器，即执行任务的时机：主要有SimpleTrigger和CronTrigger
   - 调度器（Scheduler）：任务的调度器，用于整合任务Job和触发器Trigger，使任务类在指定时间被执行；

5. Quartz体系结构

   - JobDetail + Trigger：Simple、Cron
   - Scheduler：starter、stop、create、drop

6. Quartz API

   - Scheduler：
   - Job：Job实例在Quartz的生命周期，每次调度器执行Job时，他在调用execute方法前会新建一个job实例，有新的job实例调用execute方法
     - JobDetail：为Job提供设置属性，以及JobDataMap成员变量，存储调度参数；其他主要属性：name、group、jobClass、jobDateMap
     - JobDataMap
     - JobBuilder
   - Trigger
     - TriggerBuilder
   - JobListener、TriggerListener、SchedulerListener

7. Quartz的使用

   - 

8. Quartz监听器：监听器用于当任务调度中所关注事件发生时，能够及时获取这一事件的通知。

   - 监听器的种类：JobListener、TriggerListener、SchedulerListener

   - 全局监听器：能够接收所有Job和Trigger的事件通知

   - 非全局监听器：只能够在其上注册Job或Trigger事件

   - JobListener的使用：在任务调度中与任务Job相关的事件包括：job要开始执行的提示，Job执行完成的提示

     ```java
     public class DemoJobListener implements JobListener {
         /**
          * 获取JobListener的名称
          */
         public String getName() {
             return null;
         }
     
         /**
          * Scheduler在JobDetail将要执行的时调用这个方法
          */
         public void jobToBeExecuted(JobExecutionContext jobExecutionContext) {
     
         }
     
         /**
          * Scheduler在JobDetail即将给执行,但有被TriggerListener否决时调用该方法
          */
         public void jobExecutionVetoed(JobExecutionContext jobExecutionContext) {
     
         }
     
         /**
          * Scheduler在JobDetail执行之后调用这个方法
          */
         public void jobWasExecuted(JobExecutionContext jobExecutionContext, JobExecutionException e) {
     
         }
     }
     ```

   - JobListener的使用：触发器触发，触发器未正常触发，触发器完成

     ```java
     public interface TriggerListener {
         /**
          * 获取触发器名称
          */
         String getName();
         /**
          * 当与监听器相关联的Trigger被触发,Job树上的execute方法将被执行,Scheduler就调用该方法
          */
         void triggerFired(Trigger var1, JobExecutionContext var2);
         /**
          * 在Trigger触发后,Job将要被执行时,Scheduler调用这个方法,如果返回FALSE会否决job的执行
          */
         boolean vetoJobExecution(Trigger var1, JobExecutionContext var2);
         /**
          * Scheduler调用这个方法是Trigger错过触发,此方法不能太复杂
          */
         void triggerMisfired(Trigger var1);
         /**
          * Trigger被触发并且完成Job的执行时,Scheduler调用这个方法
          */
         void triggerComplete(Trigger var1, JobExecutionContext var2, CompletedExecutionInstruction var3);
     }
     ```

   - SchedulerListener：相关事件增加、删除、异常、关闭

     ```java
     
     public interface SchedulerListener {
         // 部署JobDetail时调用
         void jobScheduled(Trigger var1);
     	// 卸载JobDetail调用
         void jobUnscheduled(TriggerKey var1);
     	// 一个Trigger永远不被触发的状态
         void triggerFinalized(Trigger var1);
     	// 被暂停
         void triggerPaused(TriggerKey var1);
     	// 
         void triggersPaused(String var1);
     	// 恢复
         void triggerResumed(TriggerKey var1);
     	// 
         void triggersResumed(String var1);
     	// 添加
         void jobAdded(JobDetail var1);
     	// 删除
         void jobDeleted(JobKey var1);
     	// 暂停
         void jobPaused(JobKey var1);
     
         void jobsPaused(String var1);
     	// 
         void jobResumed(JobKey var1);
     
         void jobsResumed(String var1);
     	// 错误
         void schedulerError(String var1, SchedulerException var2);
     	// Scheduler处于StandBy模式时改方法被调用
         void schedulerInStandbyMode();
     	// 开启后
         void schedulerStarted();
     	// 开启
         void schedulerStarting();
     	// 停止
         void schedulerShutdown();
     	// 停止
         void schedulerShuttingdown();
     	// 数据被清除时
         void schedulingDataCleared();
     }
     
     ```

     