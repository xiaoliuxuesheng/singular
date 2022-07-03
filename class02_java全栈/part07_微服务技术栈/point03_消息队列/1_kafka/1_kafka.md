# 第一部分 Kafka基础

## 第一章 概述

### 1.1 介绍

1. Kafka介绍
   - Kafka是采用Scala语言开发的一个多分区、多副本并且基于Zookeeper协议的分布式消息系统。目前Kafka已经定位为衣蛾分布式流式处理平台，它以高吞吐、可持久化、可水平扩展、支持流处理等对种特性而被广泛应用。
   - Kakfa是一个分布式的发布-订阅消息系统，能够支撑海量数据的传输；
   - Kafka将消息持久化到磁盘中，并对消息创建了备份保证数据的安全；
   - Kafka在保证了较高的处理速度的同时，又能保证数据处理的低延迟和零丢失；
2. Kafka特性
   - 高吞吐量、低延迟：每秒处理几十万条，延迟最低只有几毫秒，每个主题可以分多个分区，消费者对分区进行消费
   - 可扩展性：支持热扩展
   - 持久性、可靠性：消息持久化到磁盘，并支持数据备份
   - 容错性：允许集群节点失败
   - 高并发：支持数千个客户同时读写
   - 可伸缩：
3. Kafka使用场景
   - 日志收集：通过Kaka以统一接口服务的方式开放给各种consumer
   - 消息系统：结构生成和消费者；缓存消息
   - 用户活动跟踪：记录用户活动
   - 运营指标：记录运营监控数据
   - 流式处理：

### 1.2 消息队列

目前常见的消息队列：ActiveMQ、Kafka、RabbitMQ、RocketMQ

### 1.3 Kafka架构

<img src="https://s1.ax1x.com/2020/05/10/Y8ArjI.png" alt="Y8ArjI.png" border="0" />

- **Producer**：生产者即数据发布者，该角色将消息发布到Kafka的Topic中。broker接收到生产者发送的消息后，broker将该消息追加到当前用于追加数据的segment文件中。生产者发送的消息，存储到一个partition中，生产者也可以指定数据存储的partition
- **consumer**：消费者可以冲broker中读取数据。消费者可以效仿多个topic中的数据
- **topic**：在kafka中，使用一个类表属性来划分数据段所属类，划分数据的这个类称为topic。如果把kafka看做一个数据库，topic可以理解为数据库中的一张表，topic的名字即为表名。物理上不同Topic的消息分开存储；逻辑上一个Topic的消息虽然保存于一个或多个broker上，但用户只需指定消息的Topic即可生产或消费数据而不必关心数据存于何处
- **partition**：分区，topic中的数据分割为一个或多个partition。每个topic至少有一个partition。每个partition中的数据使用多个segment文件存储。partition中的数据是有序的，partition间的数据不一定是有序的。如果topic有对个partition，消费数据时就不能保证数据的顺序。在需要严格保证消息的消费顺序的场景下，需要将partition的数目设置为1。
- **partition offset**：每条消息都有一个档期partition下唯一的64字节的offset，他指明了这条消息的起始位置
- **replicas of partition**：副本是一个分区的副本。副本不会被消费者消费，副本只用于防止数据丢失，即消费者不从为follwer的partition中消费数据，而是从为leader的partition中读取数据。副本之间是一主多从的关系。
- **broker**：Kafka 集群包含一个或多个服务器，服务器节点称为broker。broker存储topic的数据。如果某topic有N个partition，集群有N个broker，那么每个broker存储该topic的一个partition。如果某topic有N个partition，集群有(N+M)个broker，那么其中有N个broker存储该topic的一个partition，剩下的M个
  broker不存储该topic的partition数据。如果某topic有N个partition，集群中broker数目少于N个，那么
  一个broker存储该topic的一个或多个partition。在实际生产环境中，尽量避免这种情况的发生，这种
  情况容易导致Kafka集群数据不均衡
- **leader + follower**：Follower跟随Leader，所有写请求都通过Leader路由，数据变更会广播给所有Follower，Follower与Leader保持数据同步。如果Leader失效，则从Follower中选举出一个新的Leader。当Follower与Leader挂掉、卡住或者同步太慢，leader会把这个follower从“in sync replicas”（ISR）列表中删除，重新创建一个Follower。
- **zookeeper**：zookeeper负责维护和协调broker。当kafka系统中新增broker或某个broker发生故障失效时，由zookeeper通知生产者和消费者。生产者和消费者依据zookeeper的broker状态与broker协调数据段发布和订阅任务
- **AR（Assigned Replicas）**：分区中所有的副本统称为AR
- **ISR（In-Sync Replicas）**：所有与Leader部分保持一定程度的副本（包括Leader副本在内）组成ISR
- **OSR（Out-of-Sync Replicas）**：与Leader副本同步滞后过多的副本
- **HW（High Watermark）**：高水位，标识了一个特定的offset，消费者只能拉取到这个offset之前的消息
- **LEO（Log End Offset）**：日志末尾位移（log end offset），记录是该副本底层日志（log）中下一条消息的位移值（注意：是下一条），如果LEO=10，那么表示该副本保存了10条消息，位移范围为[0,9]。

## 第二章 快速入门

### 2.1 环境准备

1. 安装VMware，并且准备安装Kafka集群的3台虚拟机
2. 配置虚拟机：①固定IP、②关闭防火墙、③修改主机名称、④配置host用主机名称、⑤ssh免密登陆
3. Kafka环境准备：①JDK安装、②Zookeeper集群安装
4. Kafka安装包下载：https://kafka.apache.org/downloads

### 2.2 Kafka安装

1. 解压安装包，配置Kafka环境变量

   ```sh
   # KAFKA 环境变量
   export KAFKA_HOME=/opt/module/kafka3
   export PATH=$PATH:$KAFKA_HOME/bin
   ```

2. 修改Kafka配置文件：`$KAFKA_HOME/config/server.properties`

   ```sh
   # 唯一,每台机器的broker.id必须保证不相同
   broker.id=0
   # 日志目录
   log.dirs=/opt/module/kafka3/logs
   # zookeeper集群：Zookeeper中新建kafka目录
   zookeeper.connect=BigDataNode101:2181,BigDataNode102:2181,BigDataNode103:2181/kafka
   ```

3. 启动Kafka集群之前需要提前准备好Zookeeper集群，关闭Zookeeper集群之前确保Kafka全部关闭

4. 在虚拟机中准备Kafka集群启动脚本

   ```sh
   #!/bin/bash
   
   case $1 in
   "start"){
   	for i in BigDataNode101 BigDataNode102 BigDataNode103
   	do
   		echo  ------------- kafka $i 启动 ------------
   		ssh $i "/opt/module/kafka3/bin/kafka-server-start.sh -daemon /opt/module/kafka3/config/server.properties"
   	done
   }
   ;;
   "stop"){
   	for i in BigDataNode101 BigDataNode102 BigDataNode103
   	do
   		echo  ------------- kafka $i 停止 ------------
   		ssh $i "/opt/module/kafka3/bin/kafka-server-stop.sh"
   	done
   }
   ;;
   "clean"){
   	for i in BigDataNode101 BigDataNode102 BigDataNode103
   	do
   		echo  ------------- kafka.meta $i 删除 ------------
   		ssh $i "rm -rf /opt/module/kafka3/logs/ meta.properties"
   	done
   }
   ;;
   esac
   ```

### 2.3 Kafka安装包

1. Kafka安装包根据开发语言和功能场景分为三个部分

   - broker：是kafka服务，由Scala语言开发
   - consumer：消费者，由Java语言开发
   - producer：生产者，由java语言开发

2. Kafka服务脚本

   | 内置Zookeeper             | 说明                                   |
   | ------------------------- | -------------------------------------- |
   | zookeeper-server-start.sh | 单机启动Kafka时不需要单独安装Zookeeper |
   | zookeeper-server-stop.sh  |                                        |
   | **Kafka服务**             | **说明**                               |
   | kafka-server-start.sh     | 启动Kafka服务                          |
   | kafka-server-stop.sh      | 关闭Kafka服务                          |
   | kafka-topics.sh           | Kafka服务Topic                         |
   | **生产者和消费者**        | **说明**                               |
   | kafka-console-consumer.sh | 生产者                                 |
   | kafka-console-producer.sh | 消费者                                 |

### 2.4 Kafka基本操作

1. 启动/停止kafka服务

   ```sh
   # 启动Kafka服务
   kafka-server-start.sh -daemon /opt/module/kafka3/config/server.properties
   
   # 关闭Kafka服务
   kafka-server-stop.sh
   ```

2. Kafka主题（topic）操作

   ```sh
   # --create: 创建Topic，--partitions 分区数；--replication-factor 副本数
   kafka-topics.sh --bootstrap-server BigDataNode101:9092 --topic test --create --partitions 1 --replication-factor 3
   
   # --list: 查看Kafka中全部Topic
   kafka-topics.sh --bootstrap-server BigDataNode101:9092 --list
   
   # --describe: 查看指定Topic详细信息
   kafka-topics.sh --bootstrap-server BigDataNode101:9092 --describe test
   
   # --alter: 修改Topic
   
   # --delete： 删除Topic
   kafka-topics.sh --bootstrap-server BigDataNode101:9092 --topic test --delete
   ```

3. Kafka生产者基本操作

   ```sh
   # 执行命令后向test主题中发送消息
   kafka-console-producer.sh --bootstrap-server BigDataNode101:9092 --topic test
   ```

4. Kafka消费者基本操作

   ```sh
   # 执行命令后从test主题中获取消息
   kafka-console-consumer.sh --bootstrap-server BigDataNode101:9092 --topic test
   ```

## 第三章 Kafka生产者

### 3.1 Kafka生产者发送原理

在消息发送过程中，设计到两个线程：mian线程和sender线程；main线程中创建了几个双端队列（RecordAccumulator）。Sender线程不断从RecordAccumulator中拉取消息发送到Kafka Broker；

![image-20220703151731636](.\resource\image-20220703151731636.png)

- 拦截器：
- 序列化器：
- 分区器：

### 3.3 Kafka异步发送

1. 异步发送：在Kafka中异步发送是指将外部数据发送到队列中即完成，不再等待数据发送到Kafka中的Broker

2. 分区

   - 分区的作用

     - 便于合理使用存储资源：可以把海量数据按照分区切割成一块一块的数据存储在多个Broker上
     - 提高并行度：生产者可以根据分区为单位发送数据，消费者可以根据分区为单位消费数据；

   - 默认的分区策略

     - 指明partition情况下，partition的值就是传入的值；

     - 在没有指定partition值，但是有key的情况下，将key的hash值与topic的partition数进行取余得到partition值；

     - 既没有指定partition也没有key的情况，Kafka采用年限分区器,会随机选择一个分区，并且尽可能一直使用该分区，知道分区的batch已满或者已完成，Kafka会再随机一个分区使用；

3. 案例演示：

   -  引入Maven依赖

     ```xml
     <dependency>
       <groupId>org.apache.kafka</groupId>
       <artifactId>kafka-clients</artifactId>
       <version>3.1.0</version>
     </dependency>
     ```

   - 连接Kafka集群，发送普通消息

     ```java
     public class CustomProducerDemo01 {
         public static void main(String[] args) {
             // 连接
             Properties properties = new Properties();
             properties.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG,"BigDataNode101:9092,BigDataNode102:9092");
             properties.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
             properties.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
             // 创建对象
             KafkaProducer<String, String> producer = new KafkaProducer<>(properties);
     
             // 发送消息
             for(int i = 0; i < 5; i++) {
                 producer.send(new ProducerRecord<>("test", "小刘学生"));
             }
             // 关闭资源
             producer.close();
         }
     }
     ```

   - 连接Kafka集群，发送带回调消息

     ```java
     public class CustomProducerDemo02 {
         public static void main(String[] args) {
             // 连接
             Properties properties = new Properties();
             properties.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG,"BigDataNode101:9092,BigDataNode102:9092");
             properties.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
             properties.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
             // 创建对象
             KafkaProducer<String, String> producer = new KafkaProducer<>(properties);
     
             // 发送消息
             for(int i = 0; i < 5; i++) {
                 producer.send(new ProducerRecord<>("test", "小刘学生"),(meta,e)->{
                     if (e == null) {
                         System.out.println("主题: " + meta.topic() + ",分区: " + meta.partition());
                     }
                 });
             }
             // 关闭资源
             producer.close();
         }
     }
     ```

   - 同步发送

     ```java
     // send发送后调用get()方法
     producer.send(new ProducerRecord<>("test", "小刘学生")).get();
     ```

### 3.4 自定义分区器

1. 自定义类实现接口

   ```java
   public class MyPartitioner implements Partitioner {
       @Override
       public int partition(String topic, Object key, byte[] keyBytes, Object values, byte[] valBytes, Cluster cluster) {
           // 自定义key或者value计算需要发送的分区值
           return 0;
       }
   
       @Override
       public void close() {
   
       }
   
       @Override
       public void configure(Map<String, ?> map) {
   
       }
   }
   ```

2. 关联自定义分区器

   ```java
   properties.put(ProducerConfig.PARTITIONER_CLASS_CONFIG, MyPartitioner.class.getName());
   ```

### ★3.5 生产者提高吞吐量

[【尚硅谷】2022版Kafka3.x教程（从入门到调优，深入全面）_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1vr4y1677k?p=17)

## 第四章 Kafka Broker

## 第五章 Kafka 消费者

## 第六章 Kafka Eagle监控

## 第七章 Kafka Kraft模式

# 第二部分 外部系统集成

## 第一章 集成Flume

## 第二章 集成Flink

## 第三章 集成SpringBoot

## 第四章 集成Spark

# 第三部分 生产调优

## 第一章  Kafka硬件配置

## 第二章 Kafka生产者

## 第三章 Kafka Broker

## 第四章 Kafka 消费者

## 第五章 总结

# 第四部分 源码解析

## 第一章 源码准备

## 第二章 生产者源码

## 第三章 消费者源码

## 第四章 服务器源码