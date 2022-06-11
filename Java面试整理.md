# 001_Java基础

## 1. Map

- HashMap底层原理：是数组+链表的数据结构，put添加数据的流程
  - 根据key计算得到hashCode
  - 根据hashCode通过散列算法得到对应数组的下标
  - 根据key，value，hashCode组成Entry对象
  - 最后把这个Entry对象添加到hashCode对应数组下标处的链表中；
- CurrentHashMap：
  - CurrentHashMap内部有两层数组：第一层数组元素类型是Segment，继承ReentrantLock，支持并发锁，每个Segment的数据结构是HashEntry（类型HashMap）结构
  - put添加数据时候会先根据key计算出对应Segment数组的下标
  - 获取这个位置Segment上的锁
  - 根据put的信息生成Entry对象
  - 将Entry对象添加到Segment内部的数组或链表上，
  - 释放这个位置的Segment上的锁

# 002_JavaWEB

# 003_数据库

## MySQL架构

> 为什么要学MySQL架构
>
> 1. MySQL服务器执行SQL语句的执行顺序就是架构中组件的调用关系，学习MySQL架构有助于理解SQL执行机制；

- MySQL主要组成部分：连接池、SLQ接口、解析器、优化器、缓存、存储引擎

- MySQL架构分层：

  1. MySQL Server 连接层：应用程序通过协议（JDBC、ODBC等）连接MySQL，处理连接信息：包括通讯协议、线程处理、用户名密码认证三部分

     > - 通讯协议检查客户端版本是否兼容MySQL服务端
     >
     > - 线程处理是指每个链接请求都会分配一个对应的线程
     >
     > - 用户名密码认证是用来验证用户名、密码以及主机授权是否连接到服务器

  2. MySQL Server SQL层：包含MySQL服务的核心

     > - 权限判断：审核用户是否可以访问SQL语句中的库、表、行的权限
     > - 查询缓存：（MySQL 8已废弃）根据SQL语句检查缓存 是否命中
     > - 解析器：解析SQL，判断语法，对SQL语义进行处理
     > - 查询优化器：优化SQL，生成执行计划，调用执行引擎接口，访问数据

  3. 存储引擎层：不同的存储引擎，表中数据的存储形式是不同的，根据优化后的SQL语句，存储引擎从文件系统中获取数据；

  4. 文件系统层：表的数据会根据存储引擎的要求，将数据以不同的文件格式持久化到文件系统中，为存储引擎操作数据提供支持；

## MySQL存储引擎

> 为什么学存储引擎：
>
> 1. 

- MySQL存储引擎主要有InnoDB和MyISAM，两者主要区别：①持久化的文件格式②对事务的支持③性能

  |          | InnoDB                        | MyISAM                                        |
  | -------- | ----------------------------- | --------------------------------------------- |
  | 物理存储 | ibd（InnoDB Data）：数据+索引 | MYD(Data)：数据文件<br />MYI(Index)：索引文件 |
  | 事务支持 | 支持事务：行级锁定            | 不支持事务：表级锁定                          |
  | 查询性能 | （5版本后）支持全文检索       | 支持全文检索                                  |

## SQL语句执行机制

![image-20220605170914142](.\resource\Java面试整理\image-20220605170914142.png)

1. 建立连接（Connectors&Connection Pool）
2. 查询缓存（Cache&Buffer）
3. 解析器（Parser）：客户端发送的SQL会被解析器进行语法解析，生成【解析树】
4. 预处理器（preprocessor）：检查生成的解析树，解决解析器无法解析的语义
5. 查询优化器（Optimizer）：根据【解析树】生成不同的执行计划，然后选择一种最优的执行计划，explain语句就是得到SQL的优化后的执行计划；
6. 操作引擎执行 SQL 语句：用对应的API接口与底层存储引擎和物理文件的交互，直到完成所有的数据查询。

## SQL语句执行顺序

1. from 对查询指定的表计算笛卡尔积
2. on 按照 join_condition 过滤数据
3. join 添加关联外部表数据
4. where 按照where_condition过滤数据
5. group by 进行分组操作
6. having 按照having_condition过滤数据
7. select 选择指定的列
8. distinct 指定列去重
9. order by 按照order_by_condition排序
10. limit 取出指定记录量

## 事务隔离级别

1. 

## MySQL优化方案

1. 

## MySql日志

1. 错误日志

2. 通用日志：也称查询日志，查询日志在 MySQL 中被称为 general log，查询日志里面记录了数据库执行的所有命令，不管语句是否正确，都会被记录

3. 慢日志 ：慢查询会导致 CPU、IOPS、内存消耗过高，当数据库遇到性能瓶颈时，大部分时间都是由于慢查询导致的。开启慢查询日志，可以让MySQL记录下查询超过指定时间的语句，之后运维人员通过定位分析，能够很好的优化数据库性能。默认情况下，慢查询日志是不开启的，只有手动开启了，慢查询才会被记录到慢查询日志中。

   ```sql
   -- 使用命令开启慢查询日志
   set global slow query log='ON';
   -- 修改配置文件 my.cnf
   slow query log=1 
   ```

4.  redo log（重做日志） ：为了最大程度的避免数据写入时，因为 IO 瓶颈造成的性能问题，MySQL采用了这样一种缓存机制，先将数据写入内存中，再批量把内存中的数据统一刷回磁盘。为了避免将数据刷回磁盘过程中，因为掉电或系统故障带来的数据丢失问题，InnoDB采用 redo log 来解决此问题。

5. undo log（回滚日志） ：用于存储日志被修改前的值，从而保证如果修改出现异常，可以使用 undo log 日志来实现回滚操作。 undo
   log 和 redo log 记录物理日志不一样，它是逻辑日志，可以认为当 delete 一条记录时，undo log 中会记录一条对应的 insert记录，反之亦然，当 update 一条记录时，它记录一条对应相反的 update 记录，当执行 rollback 时，就可以从 undo log中的逻辑记录读取到相应的内容并进行回滚。undo log 默认存放在共享表空间中，在 ySQL 5.6 中，undo log 的存放位置还可以通过变量innodb undo directory 来自定义存放目录，默认值为“.”表示 datadir 目录。

# 004_Spring

## 1. Spring启动流程

![image-20220529165121797](.\resource\Java面试整理\image-20220529165121797.png)

- 核心接口

  - BeanFactory
  - Aware
  - BeanDefinition
  - BeanDefinitionReader
  - BeanFactoryPostProcessor
  - BeanPostProcessor
  - Environment > StandardEnvironment
  - FactoryBean：都是用来创建对象的，当使用BeanFactory时候，创建bean遵循Bean的完成创建流程；而使用FactoryBean时整个对象的创建流程有用户自己来控制；
  - BeanDefinitionRegistry

- 源码解析

  - AbstractApplicationContext

    ```java
    public class AbstractApplicationContext{
      public void refresh() throws BeansException, IllegalStateException {
        synchronized(this.startupShutdownMonitor) {
          StartupStep contextRefresh = this.applicationStartup.start("spring.context.refresh");
          // 1. 刷新前准备：①启动时间②获取环境信息③ApplicationListener监听器
          this.prepareRefresh();
          // 2. ①获取一个Bean的容器:DefaultListableBeanFactory②加载配置文件中属性值到当前工程:BeanDefinition
          ConfigurableListableBeanFactory beanFactory = this.obtainFreshBeanFactory();
          // 3. 准备BeanFactory: 给工厂设置各种属性值
          this.prepareBeanFactory(beanFactory);
          try {
            // 4. 空方法:留给扩展实现
            this.postProcessBeanFactory(beanFactory);
            // 5. 实例化并注册BeanFactoryPostProcessor
            StartupStep beanPostProcess = this.applicationStartup.start("spring.context.beans.post-process");
            // 6. 实例化之前的准备工作:①
            this.invokeBeanFactoryPostProcessors(beanFactory);
            this.registerBeanPostProcessors(beanFactory);
            beanPostProcess.end();
            this.initMessageSource();
            this.initApplicationEventMulticaster();
            this.onRefresh();
            this.registerListeners();
            this.finishBeanFactoryInitialization(beanFactory);
            this.finishRefresh();
          } catch (BeansException var10) {
            if (this.logger.isWarnEnabled()) {
              this.logger.warn("Exception encountered during context initialization - cancelling refresh attempt: " + var10);
            }
            this.destroyBeans();
            this.cancelRefresh(var10);
            throw var10;
          } finally {
            this.resetCommonCaches();
            contextRefresh.end();
          }
        }
      }
    }
    ```


## 2. 循环依赖

