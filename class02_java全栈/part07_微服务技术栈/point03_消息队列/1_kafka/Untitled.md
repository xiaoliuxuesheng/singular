| 单词            | 音标            | 注释                                                         |
| :-------------- | --------------- | ------------------------------------------------------------ |
| **broker**      | /‘broʊkər/      | n. 经纪人，掮客<br />vi. 作为权力经纪人进行谈判<br />vt. 以中间人等身分安排 |
| **partition**   | /pɑːr’tɪʃn/     | n. 划分，分开；[数] 分割；隔墙；隔离物<br />vt. [数] 分割；分隔；区分 |
| **segment**     | /‘seɡmənt/      | n. 段，部分；（水果或花的）瓣，（动物的）节；弓形；音段；<br />v. 分割；（细胞）分裂 |
| **offset**      | /ˈɔːfset/       | n. 抵消，补偿；偏离量；（测绘）支距；（电子）偏离；侧枝；（山的）支脉；（建筑）壁阶；弯管，支管；平版印刷<br />v. 抵消，弥补；衬托出；使偏离直线方向；用平版印刷术印刷，转印下一页；装支管 |
| **replicas**    |                 | 复制品                                                       |
| **leader**      | /ˈliːdər/       | n. 领导者；首领；指挥者                                      |
| **follower**    | /ˈfɑːloʊər/     | n. 追随者；信徒；属下                                        |
| **assign**      | /əˈsaɪn/        | vt. 分配；指派；[计][数] 赋值<br />vi. 将财产过户（尤指过户给债权人） |
| **watermark**   | /'wɔːtərmɑːrk/  | n. 水印；水位标志<br />vt. 在…上印水印（图案）               |
| **distributed** | /dɪ'strɪbjʊtɪd/ | adj. 分布式的，分散式的                                      |
| **mirror**      | /ˈmɪrər/        | n. 镜子；真实的写照；榜样<br />vt. 反射；反映                |
| **maker**       | /ˈmeɪkər/       | n. 制造者；造物主；出期票人；创客                            |
| **standalone**  | /'stændə,lon/   | adj. （计算机）独立运行的；（公司）独立的<br />n. 脱机       |

# 第一章 初始Kafka

## 1.1 基本概念讲解

1. kakfa基本介绍

   ​	Kafka是采用Scala语言开发的一个多分区、多副本并且基于Zookeeper协议的分布式消息系统。目前Kafka已经定位为衣蛾分布式流式处理平台，它以高吞吐、可持久化、可水平扩展、支持流处理等对种特性而被广泛应用。

   ​	Kakfa是一个分布式的发布-订阅消息系统，能够支撑海量数据的传输；

   ​	Kafka将消息持久化到磁盘中，并对消息创建了备份保证数据的安全；

   ​	Kafka在保证了较高的处理速度的同时，又能保证数据处理的低延迟和零丢失；

2. Kafka特性

   - 高吞吐量、低延迟：每秒处理几十万条，延迟最低只有几毫秒，每个主题可以分多个分区，消费者对分区进行消费
   - 可扩展性：支持热扩展
   - 持久性、可靠性：消息持久化到磁盘，并支持数据备份
   - 容错性：允许集群节点失败
   - 高并发：支持数千个客户同时读写
   - 可伸缩：

3. 使用场景

   - 日志收集：通过Kaka以统一接口服务的方式开放给各种consumer
   - 消息系统：结构生成和消费者；缓存消息
   - 用户活动跟踪：记录用户活动
   - 运营指标：记录运营监控数据
   - 流式处理：

4. 概念详解

   <img src="https://s1.ax1x.com/2020/05/10/Y8ArjI.png" alt="Y8ArjI.png" border="0" />

   - **Producer**：生产者即数据发布者，该角色将消息发布到Kafka的Topic中。broker接收到生产者发送的消息后，broker将该消息追加到当前用于追加数据的segment文件中。生产者发送的消息，存储到一个partition中，生产者也可以指定数据存储的partition
   - **consumer**：消费者可以冲broker中读取数据。消费者可以效仿多个topic中的数据
   - **topic**：在kafka中，使用一个类表属性来划分数据段所属类，划分数据的这个类称为topic。如果把kafka看做一个数据库，topic可以理解为数据库中的一张表，topic的名字即为表名。
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

## 1.2 安装与配置

1. 安装

   - Kafka需要安装Java环境：Windows和Linux
   - 安装ZooKeeper：

2. 配置

   - kafka安装包的组成：三部分

     - broker：是kafka服务，由Scala语言开发
     - consumer：消费者，由Java语言开发
     - producer：生产者，由java语言开发

   - config配置信息

     - server.properties

       ```properties
       # 唯一
       broker.id=0
       # 日志目录
       log.dirs=/opt/module/kafka3/logs
       # zookeeper集群
       zookeeper.connect=BigDataNode101:2181,BigDataNode102:2181,BigDataNode103:2181/kafka
       ```

     - producer.properties

     - consumer.properties

   - 添加kafka的bin到环境变量中

   - zookeeper集群配置

     ```sh
     # 先把dataDir=/tmp/zookeeper注释掉，然后添加以下核心配置,目录需要创建
     dataDir=/usr/local/zookeeper/data
     server.1=BigDataNode101:2888:3888
     server.2=BigDataNode102:2888:3888
     server.3=BigDataNode103:2888:3888
     ```

   - dataDir中添加myid文件, 文件中添加对应server是数字

   - 启动zookeeper，启动报错，看报错信息修改配置文件，并且创建kafka节点

     ```sh
     #!/bin/bash
     
     case $1 in
     "start"){
     	for i in BigDataNode101 BigDataNode102 BigDataNode103
     	do
     		echo  ------------- zookeeper $i 启动 ------------
     		ssh $i "/opt/module/zookeeper3.7.1/bin/zkServer.sh start"
     	done
     }
     ;;
     "stop"){
     	for i in hadoop102 hadoop103 hadoop104
     	do
     		echo  ------------- zookeeper $i 停止 ------------
     		ssh $i "/opt/module/zookeeper3.7.1/bin/zkServer.sh stop"
     	done
     }
     ;;
     "status"){
     	for i in hadoop102 hadoop103 hadoop104
     	do
     		echo  ------------- zookeeper $i 状态 ------------
     		ssh $i "/opt/module/zookeeper3.7.1/bin/zkServer.sh status"
     	done
     }
     ;;
     esac
     ```

   - 查看启动进程

     ```sh
     xcall jps
     ```

   - 启动kafka，关闭zookeeper之前必须提前关闭kafka

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
     esac
     
     ```

3. 启动执行脚本

   | kafka服务                 | 执行参数 | 说明 |
   | ------------------------- | -------- | ---- |
   | zookeeper-server-start.sh |          |      |
   | zookeeper-server-stop.sh  |          |      |
   | kafka-server-start.sh     |          |      |
   | kafka-server-stop.sh      |          |      |
   | kafka-topics.sh           | 主题     |      |
   | **kafka生产者和消费者**   |          |      |
   | kafka-console-consumer.sh |          |      |
   | kafka-console-producer.sh |          |      |

   

   | 启动执行                             | 执行参数                    | 使用说明                         |
   | ------------------------------------ | --------------------------- | -------------------------------- |
   | **connect-distributed**              |                             |                                  |
   | **connect-mirror-maker**             |                             |                                  |
   | **connect-standalone**               |                             |                                  |
   | **kafka-acls**                       |                             |                                  |
   | **kafka-broker-api-versions**        |                             |                                  |
   | **kafka-console-consumer**           |                             | **kafka命令行工具模拟消费端**    |
   |                                      | --bootstrap-server IP:端口  | 连接到的kafka服务地址            |
   |                                      | --topic topic名称           | 消费指定名称的Topic              |
   | **kafka-console-producer**           |                             | **kafka命令行工具模拟发送端**    |
   | **kafka-consumer-groups**            |                             |                                  |
   | **kafka-consumer-perf-test**         |                             |                                  |
   | **kafka-delegation-tokens**          |                             |                                  |
   | **kafka-delete-records**             |                             |                                  |
   | **kafka-dump-log**                   |                             |                                  |
   | **kafka-leader-election**            |                             |                                  |
   | **kafka-log-dirs**                   |                             |                                  |
   | **kafka-mirror-maker**               |                             |                                  |
   | **kafka-preferred-replica-election** |                             |                                  |
   | **kafka-producer-perf-test**         |                             |                                  |
   | **kafka-reassign-partitions**        |                             |                                  |
   | **kafka-replica-verification**       |                             |                                  |
   | **kafka-run-class**                  |                             |                                  |
   | **kafka-server-start**               |                             | **启动kafka服务**                |
   | **kafka-server-stop**                |                             | **关闭kafka服务**                |
   | **kafka-streams-application-reset**  |                             |                                  |
   | **kafka-topics**                     |                             | **kafka的Topic命令行工具**       |
   |                                      | --create \| deletet \| list | Topic的创建 \| 删除 \|  列表查询 |
   |                                      | --zookeeper host:port       | 连接指定的zookeeper              |
   |                                      | --partitions 分区数         | 创建的topic的分区数              |
   |                                      | --replication-factor 副本数 | 创建的Topic副本数                |
   |                                      | --topic 名称                | 创建指定名称的topic              |
   | kafka-verifiable-consumer            |                             |                                  |
   | kafka-verifiable-producer            |                             |                                  |
   | trogdor                              |                             |                                  |
   | zookeeper-security-migration         |                             |                                  |
   | zookeeper-server-start               |                             | 启动内置的ZooKeeper注册中心      |
   | zookeeper-server-stop                |                             | 停止内置的ZooKeeper服务          |
   | zookeeper-shell                      |                             |                                  |

1.3 Java程序连接

1.4 服务参数说明

1. server.properties
   - broker.id=0：表示broker的编号，如果集群中有多个broker，每个broker设置的编号应该不同
   - listeners=PLAINTEXT://:9092：broker对外提供的服务入口地址
   - log.dirs=/tmp/kafka-logs：kafka日志文件目录地址
   - zookeeper.connect=localhost:2181：kafka连接的ZooKeeper注册中心地址

## 1.5 Kafka命令行操作

1. kafka-topics.sh

   - 链接kafka服务端

     ```sh
     # --bootstrap-server 主机:端口
     kafka-topics.sh --bootstrap-server BigDataNode101:9092 --list
     # --topic 名称: 链接指定topic
     kafka-topics.sh --bootstrap-server BigDataNode101:9092 --topic teset --delete
     ```

   - 操作topic

     ```sh
     # --create
     kafka-topics.sh --bootstrap-server BigDataNode101:9092 --topic test --create --partitions 1 --replication-factor 1
     # --delete
     kafka-topics.sh --bootstrap-server BigDataNode101:9092 --topic test --delete
     # --alter
     
     # --list 查询所有topic
     kafka-topics.sh --bootstrap-server BigDataNode101:9092 --list
     # --describe
     kafka-topics.sh --bootstrap-server BigDataNode101:9092 --describe
     # --partitions 分区数
     
     # --replication-factor 副本数
     
     ```

     

# 第二章 生产者

2.1 消息发送

1. kafka消息的producer发送消息流程

   <img src="https://s1.ax1x.com/2020/05/11/YJ51zj.png" alt="YJ51zj.png" border="0" />

   - **ProducerRecord**：表示一条待发送的消息记录，主要由5个字段构成。ProducerRecord允许用户在创建消息对象的时候就直接指定要发送的分区，这样producer后续发送该消息时可以直接发送到指定分区，而不用先通过Partitioner计算目标分区了；还可以直接指定消息的时间戳——但一定要慎重使用这个功能，因为它有可能会令时间戳索引机制失效。

     | 字段      | 说明      |
     | --------- | --------- |
     | topic     | 所属topic |
     | partition | 所属分区  |
     | key       | 键值      |
     | value     | 消息体    |
     | timestrap | 时间戳    |

   - **RecordMetaData**：该类表示Kafka服务器端返回给客户端的消息元数据

     | 字段                | 说明                 |
     | ------------------- | -------------------- |
     | offset              | 该条消息的位移       |
     | timestrap           | 时间戳               |
     | topic+partition     | 所属topic的分区      |
     | checksum            | 消息CRC32码          |
     | serializedKeySize   | 序列化后消息键字节数 |
     | serializedValueSize | 序列化后消息值字节数 |

2. 消息发送流程描述

   - 用户首先构建待发送的消息对象ProducerRecord，然后调用KafkaProducer#send方法进行发送。
   - KafkaProducer接收到消息后首先对其进行序列化
   - 然后结合本地缓存的元数据信息一起发送给partitioner去确定目标分区
   - 最后追加写入到内存中的消息缓冲池(accumulator)
   - 此时KafkaProducer#send方法成功返回。同时，KafkaProducer中还有一个专门的Sender IO线程负责将缓冲池中的消息分批次发送给对应的broker，完成真正的消息发送逻辑。

3. producer关键参数

   - **batch.size** 我把它列在了首位，因为该参数对于调优producer至关重要。之前提到过新版producer采用分批发送机制，该参数即控制一个batch的大小。默认是16KB
   - **acks**关乎到消息持久性(durability)的一个参数。高吞吐量和高持久性很多时候是相矛盾的，需要先明确我们的目标是什么？ 高吞吐量？高持久性？亦或是中等？因此该参数也有对应的三个取值：0， -1和1
   - **linger.ms**减少网络IO，节省带宽之用。原理就是把原本需要多次发送的小batch，通过引入延时的方式合并成大batch发送，减少了网络传输的压力，从而提升吞吐量。当然，也会引入延时
   - **compression.type  producer**所使用的压缩器，目前支持gzip, snappy和lz4。压缩是在用户主线程完成的，通常都需要花费大量的CPU时间，但对于减少网络IO来说确实利器。生产环境中可以结合压力测试进行适当配置
   - **max.in.flight.requests.per.connection** 关乎消息乱序的一个配置参数。它指定了Sender线程在单个Socket连接上能够发送未应答PRODUCE请求的最大请求数。适当增加此值通常会增大吞吐量，从而整体上提升producer的性能。不过笔者始终觉得其效果不如调节batch.size来得明显，所以请谨慎使用。另外如果开启了重试机制，配置该参数大于1可能造成消息发送的乱序(先发送A，然后发送B，但B却先行被broker接收)
   - **retries** 重试机制，对于瞬时失败的消息发送，开启重试后KafkaProducer会尝试再次发送消息。对于有强烈无消息丢失需求的用户来说，开启重试机制是必选项

4. 内部流程

   - https://www.jianshu.com/p/46cb44c6b96c

2.2 原理剖析

2.3 生产者参数说明

第三章 消费者

3.1 概念入门

3.2 消息接收

第四章 主题

4.1 管理

4.2 增加分区

第五章 分区

5.1 副本机制

5.2 Leader选举机制

5.3 分区重新分配

5.4 自动再均衡

5.5 分区分配策略

第六章 物理存储

6.1 日志存储概述

6.2 日志存储

6.3 磁盘存储

第七章 稳定性

7.1 事务

7.2 控制器

7.3 可靠性保证

7.4 一致性验证

7.5 消息重复的场景及解决方案

第八章 高级应用

8.1 命令行工具

8.2 数据管理Connect

8.3 延时队列

8.4 重拾队列

8.5 流式处理

8.6 SpringBootKafka

8.7 消息中间件对比

第九章 集群

9.1 集群搭建

9.2 多集群同步

第十章 监控

10.1 监控度量指标

10.2 broker监控

10.3 主题分区监控

10.4 生产者架空

10.5 消费者监控

10.6 监控工具kafkaEagle

# 第一章 初始Kafka

## 1.1 Kafka介绍

:anchor: <font size=4 color=blue>Kafka介绍</font>

​		Kafka是由LinkedIn公司采用Scala语言开发的一个多分区、多副本并且基于ZooKeeper协调的分布式消息系统。

​		Kafka目前定位与一个分布式的流式处理平台：高吞吐、可持久化、可水平扩展、支持流式处理等高性能，能支持海量数据传递，Kafka将消息持久化到磁盘中，保证数据的安全；Kafka在保证较高的处理速度的同时，又可以保证数据处理的低延时和数据的零丢失。

:anchor: <font size=4 color=blue>Kafka特性</font>

1. 高吞吐、低延时
2. 可扩展
3. 持久性、可靠性
4. 容错性
5. 高并发

:anchor: <font size=4 color=blue>Kafka使用场景</font>

1. 日志收集
2. 消息系统服务
3. 用户活动跟踪
4. 运营指标
5. 流式处理

## 1.3 案例入门

:anchor: <font size=4 color=blue>Java连接Kafka</font>

1. 新建SpringBoot项目，并添加依赖

   ```xml
   <dependency>
       <groupId>org.springframework.kafka</groupId>
       <artifactId>spring-kafka</artifactId>
   </dependency>
   
   <dependency>
       <groupId>com.google.code.gson</groupId>
       <artifactId>gson</artifactId>
   </dependency>
   ```

2. 使用Java模拟Producer

   ```java
   import org.apache.kafka.clients.producer.KafkaProducer;
   import org.apache.kafka.clients.producer.ProducerConfig;
   import org.apache.kafka.clients.producer.ProducerRecord;
   import org.apache.kafka.common.serialization.StringSerializer;
   import java.util.Properties;
   
   public class TestProducer {
   
       public static final String BROKER_LIST = "localhost:9092";
       public static final String TOPIC = "panda";
   
       public static void main(String[] args) {
           Properties properties = new Properties();
           // key的序列化器
           properties.put(ProducerConfig.KEY_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
           // 设置重置次数
           properties.put(ProducerConfig.RETRIES_CONFIG, 10);
           // 设置值序列化器
           properties.put(ProducerConfig.VALUE_SERIALIZER_CLASS_CONFIG, StringSerializer.class.getName());
           // 设置集群地址
           properties.put(ProducerConfig.BOOTSTRAP_SERVERS_CONFIG, BROKER_LIST);
           KafkaProducer<String, String> producer = new KafkaProducer<String, String>(properties);
           ProducerRecord<String, String> record = new ProducerRecord<>(TOPIC, "kafka-demo", "hello kafka");
           producer.send(record);
           producer.close();
       }
   }
   ```

3. 使用Java模拟Consumer

   ```java
   import org.apache.kafka.clients.consumer.ConsumerConfig;
   import org.apache.kafka.clients.consumer.ConsumerRecord;
   import org.apache.kafka.clients.consumer.ConsumerRecords;
   import org.apache.kafka.clients.consumer.KafkaConsumer;
   import org.apache.kafka.common.serialization.StringDeserializer;
   import java.time.Duration;
   import java.util.Collections;
   import java.util.Properties;
   
   public class TestConsumer {
   
       public static final String BROKER_LIST = "localhost:9092";
       public static final String TOPIC = "panda";
       public static final String GROUP_CONSUMER = "panda_consumer";
   
       public static void main(String[] args) {
           Properties properties = new Properties();
           // key的序列化器
           properties.put(ConsumerConfig.KEY_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class.getName());
           // 设置值序列化器
           properties.put(ConsumerConfig.VALUE_DESERIALIZER_CLASS_CONFIG, StringDeserializer.class.getName());
           // 设置集群地址
           properties.put(ConsumerConfig.BOOTSTRAP_SERVERS_CONFIG, BROKER_LIST);
           // 设置消费者组
           properties.put(ConsumerConfig.GROUP_ID_CONFIG, GROUP_CONSUMER);
   
           KafkaConsumer<String, String> consumer = new KafkaConsumer<String, String>(properties);
           consumer.subscribe(Collections.singletonList(TOPIC));
           while (true) {
               ConsumerRecords<String, String> records = consumer.poll(Duration.ofMillis(1000));
               for (ConsumerRecord<String, String> record : records) {
                   if ("kafka-demo".equals(record.key())) {
                       System.out.println("record = " + record);
                   }
               }
           }
       }
   }
   ```

## 1.4 服务端配置参数

- /config/server.properties

  ```properties
  # 当前机器在集群中的唯一标识，和zookeeper的myid性质一样
  broker.id=0
  # 当前kafka对外提供服务的端口默认是9092
  port=9092
  # 这个参数默认是关闭的，在0.8.1有个bug，DNS解析问题，失败率的问题。
  host.name=hadoop1
  # 这个是borker进行网络处理的线程数
  num.network.threads=3
  # 这个是borker进行I/O处理的线程数
  num.io.threads=8
  # 发送缓冲区buffer大小，数据不是一下子就发送的，先回存储到缓冲区了到达一定的大小后在发送，能提高性能
  socket.send.buffer.bytes=102400
  # kafka接收缓冲区大小，当数据到达一定大小后在序列化到磁盘
  socket.receive.buffer.bytes=102400
  # 这个参数是向kafka请求消息或者向kafka发送消息的请请求的最大数，这个值不能超过java的堆栈大小
  socket.request.max.bytes=104857600
  # 消息存放的目录，这个目录可以配置为“，”逗号分割的表达式，上面的num.io.threads要大于这个目录的个数这个目录，
  # 如果配置多个目录，新创建的topic他把消息持久化的地方是，当前以逗号分割的目录中，那个分区数最少就放那一个
  log.dirs=/home/hadoop/log/kafka-logs
  # 默认的分区数，一个topic默认1个分区数
  num.partitions=1
  # 每个数据目录用来日志恢复的线程数目
  num.recovery.threads.per.data.dir=1
  # 默认消息的最大持久化时间，168小时，7天
  log.retention.hours=168
  # 这个参数是：因为kafka的消息是以追加的形式落地到文件，当超过这个值的时候，kafka会新起一个文件
  log.segment.bytes=1073741824
  # 每隔300000毫秒去检查上面配置的log失效时间
  log.retention.check.interval.ms=300000
  # 是否启用log压缩，一般不用启用，启用的话可以提高性能
  log.cleaner.enable=false
  # 设置zookeeper的连接端口
  zookeeper.connect=192.168.123.102:2181,192.168.123.103:2181,192.168.123.104:2181
  # 设置zookeeper的连接超时时间
  zookeeper.connection.timeout.ms=6000
  ```

- /config/producer.properties：设计连接的zookeeper集群

  ```properties
  metadata.broker.list=192.168.123.102:9092,192.168.123.103:9092,192.168.123.104:9092
  ```

- /config/consumer.properties：设计连接的zookeeper集群

  ```properties
  zookeeper.connect=192.168.123.102:2181,192.168.123.103:2181,192.168.123.104:2181
  ```

# 第二章 生产者



# 第三章 消费者

# 第四章 主题

## 4.1 Topic管理

# 第五章 分区

# 第六章 物理存储

# 第七章 稳定性

# 第八章 高级应用

# 第九章 集群管理

# 第十章 监控

 

# 第二章 Kafka架构原理

## 2.1 Kafka工作流程



## 2.2 Kafka的架构

![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180507192145249-1414897650.png)

如上图所示，一个典型的Kafka集群中包含若干Producer（可以是web前端产生的Page View，或者是服务器日志，系统CPU、Memory等），若干broker（Kafka支持水平扩展，一般broker数量越多，集群吞吐率越高），若干Consumer Group，以及一个Zookeeper集群。Kafka通过Zookeeper管理集群配置，选举leader，以及在Consumer Group发生变化时进行rebalance。Producer使用push模式将消息发布到broker，Consumer使用pull模式从broker订阅并消费消息。

## 二、Topics和Partition

Topic在逻辑上可以被认为是一个queue，每条消费都必须指定它的Topic，可以简单理解为必须指明把这条消息放进哪个queue里。为了使得Kafka的吞吐率可以线性提高，物理上把Topic分成一个或多个Partition，每个Partition在物理上对应一个文件夹，该文件夹下存储这个Partition的所有消息和索引文件。创建一个topic时，同时可以指定分区数目，分区数越多，其吞吐量也越大，但是需要的资源也越多，同时也会导致更高的不可用性，kafka在接收到生产者发送的消息之后，会根据均衡策略将消息存储到不同的分区中。因为每条消息都被append到该Partition中，属于顺序写磁盘，因此效率非常高（经验证，顺序写磁盘效率比随机写内存还要高，这是Kafka高吞吐率的一个很重要的保证）。

![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180507192840409-1435311830.png)

对于传统的message queue而言，一般会删除已经被消费的消息，而Kafka集群会保留所有的消息，无论其被消费与否。当然，因为磁盘限制，不可能永久保留所有数据（实际上也没必要），因此Kafka提供两种策略删除旧数据。一是基于时间，二是基于Partition文件大小。例如可以通过配置$KAFKA_HOME/config/server.properties，让Kafka删除一周前的数据，也可在Partition文件超过1GB时删除旧数据，配置如下所示：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
# The minimum age of a log file to be eligible for deletion
log.retention.hours=168
# The maximum size of a log segment file. When this size is reached a new log segment will be created.
log.segment.bytes=1073741824
# The interval at which log segments are checked to see if they can be deleted according to the retention policies
log.retention.check.interval.ms=300000
# If log.cleaner.enable=true is set the cleaner will be enabled and individual logs can then be marked for log compaction.
log.cleaner.enable=false
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

因为Kafka读取特定消息的时间复杂度为O(1)，即与文件大小无关，所以这里删除过期文件与提高Kafka性能无关。选择怎样的删除策略只与磁盘以及具体的需求有关。另外，Kafka会为每一个Consumer Group保留一些metadata信息——当前消费的消息的position，也即offset。这个offset由Consumer控制。正常情况下Consumer会在消费完一条消息后递增该offset。当然，Consumer也可将offset设成一个较小的值，重新消费一些消息。因为offet由Consumer控制，所以Kafka broker是无状态的，它不需要标记哪些消息被哪些消费过，也不需要通过broker去保证同一个Consumer Group只有一个Consumer能消费某一条消息，因此也就不需要锁机制，这也为Kafka的高吞吐率提供了有力保障。

[回到顶部](https://www.cnblogs.com/qingyunzong/p/9004593.html#_labelTop)

## 三、Producer消息路由

Producer发送消息到broker时，会根据Paritition机制选择将其存储到哪一个Partition。如果Partition机制设置合理，所有消息可以均匀分布到不同的Partition里，这样就实现了负载均衡。如果一个Topic对应一个文件，那这个文件所在的机器I/O将会成为这个Topic的性能瓶颈，而有了Partition后，不同的消息可以并行写入不同broker的不同Partition里，极大的提高了吞吐率。可以在$KAFKA_HOME/config/server.properties中通过配置项num.partitions来指定新建Topic的默认Partition数量，也可在创建Topic时通过参数指定，同时也可以在Topic创建之后通过Kafka提供的工具修改。

在发送一条消息时，可以指定这条消息的key，Producer根据这个key和Partition机制来判断应该将这条消息发送到哪个Parition。Paritition机制可以通过指定Producer的paritition. class这一参数来指定，该class必须实现kafka.producer.Partitioner接口。

[回到顶部](https://www.cnblogs.com/qingyunzong/p/9004593.html#_labelTop)

## 四、Consumer Group

使用Consumer high level API时，同一Topic的一条消息只能被同一个Consumer Group内的一个Consumer消费，但多个Consumer Group可同时消费这一消息。

![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180507193553697-2141118410.png)

这是Kafka用来实现一个Topic消息的广播（发给所有的Consumer）和单播（发给某一个Consumer）的手段。一个Topic可以对应多个Consumer Group。如果需要实现广播，只要每个Consumer有一个独立的Group就可以了。要实现单播只要所有的Consumer在同一个Group里。用Consumer Group还可以将Consumer进行自由的分组而不需要多次发送消息到不同的Topic。

实际上，Kafka的设计理念之一就是同时提供离线处理和实时处理。根据这一特性，可以使用Storm这种实时流处理系统对消息进行实时在线处理，同时使用Hadoop这种批处理系统进行离线处理，还可以同时将数据实时备份到另一个数据中心，只需要保证这三个操作所使用的Consumer属于不同的Consumer Group即可。

[回到顶部](https://www.cnblogs.com/qingyunzong/p/9004593.html#_labelTop)

## 五、Push vs. Pull

作为一个消息系统，Kafka遵循了传统的方式，选择由Producer向broker push消息并由Consumer从broker pull消息。一些logging-centric system，比如Facebook的Scribe和Cloudera的Flume，采用push模式。事实上，push模式和pull模式各有优劣。

push模式很难适应消费速率不同的消费者，因为消息发送速率是由broker决定的。push模式的目标是尽可能以最快速度传递消息，但是这样很容易造成Consumer来不及处理消息，典型的表现就是拒绝服务以及网络拥塞。而pull模式则可以根据Consumer的消费能力以适当的速率消费消息。

对于Kafka而言，pull模式更合适。pull模式可简化broker的设计，Consumer可自主控制消费消息的速率，同时Consumer可以自己控制消费方式——即可批量消费也可逐条消费，同时还能选择不同的提交方式从而实现不同的传输语义。

[回到顶部](https://www.cnblogs.com/qingyunzong/p/9004593.html#_labelTop)

## 六、Kafka delivery guarantee

有这么几种可能的delivery guarantee：

> At most once 　　消息可能会丢，但绝不会重复传输
>
> At least one 　　 消息绝不会丢，但可能会重复传输
>
> Exactly once 　　 每条消息肯定会被传输一次且仅传输一次，很多时候这是用户所想要的。

当Producer向broker发送消息时，一旦这条消息被commit，因数replication的存在，它就不会丢。但是如果Producer发送数据给broker后，遇到网络问题而造成通信中断，那Producer就无法判断该条消息是否已经commit。虽然Kafka无法确定网络故障期间发生了什么，但是Producer可以生成一种类似于主键的东西，发生故障时幂等性的重试多次，这样就做到了Exactly once。

接下来讨论的是消息从broker到Consumer的delivery guarantee语义。（仅针对Kafka consumer high level API）。Consumer在从broker读取消息后，可以选择commit，该操作会在Zookeeper中保存该Consumer在该Partition中读取的消息的offset。该Consumer下一次再读该Partition时会从下一条开始读取。如未commit，下一次读取的开始位置会跟上一次commit之后的开始位置相同。当然可以将Consumer设置为autocommit，即Consumer一旦读到数据立即自动commit。如果只讨论这一读取消息的过程，那Kafka是确保了Exactly once。但实际使用中应用程序并非在Consumer读取完数据就结束了，而是要进行进一步处理，而数据处理与commit的顺序在很大程度上决定了消息从broker和consumer的delivery guarantee semantic。

**Kafka默认保证At least once**，并且允许通过设置Producer异步提交来实现At most once。而Exactly once要求与外部存储系统协作，幸运的是Kafka提供的offset可以非常直接非常容易得使用这种方式。

## 2.2 高可用的由来

### 1. 为何需要Replication

　　在Kafka在0.8以前的版本中，是没有Replication的，一旦某一个Broker宕机，则其上所有的Partition数据都不可被消费，这与Kafka数据持久性及Delivery Guarantee的设计目标相悖。同时Producer都不能再将数据存于这些Partition中。

　　如果Producer使用同步模式则Producer会在尝试重新发送message.send.max.retries（默认值为3）次后抛出Exception，用户可以选择停止发送后续数据也可选择继续选择发送。而前者会造成数据的阻塞，后者会造成本应发往该Broker的数据的丢失。

　　如果Producer使用异步模式，则Producer会尝试重新发送message.send.max.retries（默认值为3）次后记录该异常并继续发送后续数据，这会造成数据丢失并且用户只能通过日志发现该问题。同时，Kafka的Producer并未对异步模式提供callback接口。

　　由此可见，在没有Replication的情况下，一旦某机器宕机或者某个Broker停止工作则会造成整个系统的可用性降低。随着集群规模的增加，整个集群中出现该类异常的几率大大增加，因此对于生产系统而言Replication机制的引入非常重要。



### 1. Leader Election

　　引入Replication之后，同一个Partition可能会有多个Replica，而这时需要在这些Replication之间选出一个Leader，Producer和Consumer只与这个Leader交互，其它Replica作为Follower从Leader中复制数据。

　　因为需要保证同一个Partition的多个Replica之间的数据一致性（其中一个宕机后其它Replica必须要能继续服务并且即不能造成数据重复也不能造成数据丢失）。如果没有一个Leader，所有Replica都可同时读/写数据，那就需要保证多个Replica之间互相（N×N条通路）同步数据，数据的一致性和有序性非常难保证，大大增加了Replication实现的复杂性，同时也增加了出现异常的几率。而引入Leader后，只有Leader负责数据读写，Follower只向Leader顺序Fetch数据（N条通路），系统更加简单且高效。

# 第三章 Kafka HA

## 3.1 高可用设计解析

### 1. 如何将所有Replica均匀分布到整个集群

为了更好的做负载均衡，Kafka尽量将所有的Partition均匀分配到整个集群上。一个典型的部署方式是一个Topic的Partition数量大于Broker的数量。同时为了提高Kafka的容错能力，也需要将同一个Partition的Replica尽量分散到不同的机器。实际上，如果所有的Replica都在同一个Broker上，那一旦该Broker宕机，该Partition的所有Replica都无法工作，也就达不到HA的效果。同时，如果某个Broker宕机了，需要保证它上面的负载可以被均匀的分配到其它幸存的所有Broker上。

Kafka分配Replica的算法如下：

1.将所有Broker（假设共n个Broker）和待分配的Partition排序

2.将第i个Partition分配到第（i mod n）个Broker上

3.将第i个Partition的第j个Replica分配到第（(i + j) mode n）个Broker上

### 2. Data Replication（副本策略）

Kafka的高可靠性的保障来源于其健壮的副本（replication）策略。

#### 消息传递同步策略

Producer在发布消息到某个Partition时，先通过ZooKeeper找到该Partition的Leader，然后无论该Topic的Replication Factor为多少，Producer只将该消息发送到该Partition的Leader。Leader会将该消息写入其本地Log。每个Follower都从Leader pull数据。这种方式上，Follower存储的数据顺序与Leader保持一致。Follower在收到该消息并写入其Log后，向Leader发送ACK。一旦Leader收到了ISR中的所有Replica的ACK，该消息就被认为已经commit了，Leader将增加HW并且向Producer发送ACK。

为了提高性能，每个Follower在接收到数据后就立马向Leader发送ACK，而非等到数据写入Log中。因此，对于已经commit的消息，Kafka只能保证它被存于多个Replica的内存中，而不能保证它们被持久化到磁盘中，也就不能完全保证异常发生后该条消息一定能被Consumer消费。

Consumer读消息也是从Leader读取，只有被commit过的消息才会暴露给Consumer。

Kafka Replication的数据流如下图所示：

![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180507194612622-1788087919.png)

#### ACK前需要保证有多少个备份

对于Kafka而言，定义一个Broker是否“活着”包含两个条件：

- 一是它必须维护与ZooKeeper的session（这个通过ZooKeeper的Heartbeat机制来实现）。
- 二是Follower必须能够及时将Leader的消息复制过来，不能“落后太多”。

Leader会跟踪与其保持同步的Replica列表，该列表称为ISR（即in-sync Replica）。如果一个Follower宕机，或者落后太多，Leader将把它从ISR中移除。这里所描述的“落后太多”指Follower复制的消息落后于Leader后的条数超过预定值（该值可在$KAFKA_HOME/config/server.properties中通过replica.lag.max.messages配置，其默认值是4000）或者Follower超过一定时间（该值可在$KAFKA_HOME/config/server.properties中通过replica.lag.time.max.ms来配置，其默认值是10000）未向Leader发送fetch请求。

Kafka的复制机制既不是完全的同步复制，也不是单纯的异步复制。事实上，完全同步复制要求所有能工作的Follower都复制完，这条消息才会被认为commit，这种复制方式极大的影响了吞吐率（高吞吐率是Kafka非常重要的一个特性）。而异步复制方式下，Follower异步的从Leader复制数据，数据只要被Leader写入log就被认为已经commit，这种情况下如果Follower都复制完都落后于Leader，而如果Leader突然宕机，则会丢失数据。而Kafka的这种使用ISR的方式则很好的均衡了确保数据不丢失以及吞吐率。Follower可以批量的从Leader复制数据，这样极大的提高复制性能（批量写磁盘），极大减少了Follower与Leader的差距。

需要说明的是，Kafka只解决fail/recover，不处理“Byzantine”（“拜占庭”）问题。一条消息只有被ISR里的所有Follower都从Leader复制过去才会被认为已提交。这样就避免了部分数据被写进了Leader，还没来得及被任何Follower复制就宕机了，而造成数据丢失（Consumer无法消费这些数据）。而对于Producer而言，它可以选择是否等待消息commit，这可以通过request.required.acks来设置。这种机制确保了只要ISR有一个或以上的Follower，一条被commit的消息就不会丢失。

#### Leader Election算法

Leader选举本质上是一个分布式锁，有两种方式实现基于ZooKeeper的分布式锁：

- 节点名称唯一性：多个客户端创建一个节点，只有成功创建节点的客户端才能获得锁
- 临时顺序节点：所有客户端在某个目录下创建自己的临时顺序节点，只有序号最小的才获得锁

一种非常常用的选举leader的方式是“Majority Vote”（“少数服从多数”），但Kafka并未采用这种方式。这种模式下，如果我们有2f+1个Replica（包含Leader和Follower），那在commit之前必须保证有f+1个Replica复制完消息，为了保证正确选出新的Leader，fail的Replica不能超过f个。因为在剩下的任意f+1个Replica里，至少有一个Replica包含有最新的所有消息。这种方式有个很大的优势，系统的latency只取决于最快的几个Broker，而非最慢那个。Majority Vote也有一些劣势，为了保证Leader Election的正常进行，它所能容忍的fail的follower个数比较少。如果要容忍1个follower挂掉，必须要有3个以上的Replica，如果要容忍2个Follower挂掉，必须要有5个以上的Replica。也就是说，在生产环境下为了保证较高的容错程度，必须要有大量的Replica，而大量的Replica又会在大数据量下导致性能的急剧下降。这就是这种算法更多用在ZooKeeper这种共享集群配置的系统中而很少在需要存储大量数据的系统中使用的原因。例如HDFS的HA Feature是基于majority-vote-based journal，但是它的数据存储并没有使用这种方式。

Kafka在ZooKeeper中动态维护了一个ISR（in-sync replicas），这个ISR里的所有Replica都跟上了leader，只有ISR里的成员才有被选为Leader的可能。在这种模式下，对于f+1个Replica，一个Partition能在保证不丢失已经commit的消息的前提下容忍f个Replica的失败。在大多数使用场景中，这种模式是非常有利的。事实上，为了容忍f个Replica的失败，Majority Vote和ISR在commit前需要等待的Replica数量是一样的，但是ISR需要的总的Replica的个数几乎是Majority Vote的一半。

虽然Majority Vote与ISR相比有不需等待最慢的Broker这一优势，但是Kafka作者认为Kafka可以通过Producer选择是否被commit阻塞来改善这一问题，并且节省下来的Replica和磁盘使得ISR模式仍然值得。

#### 如何处理所有Replica都不工作

在ISR中至少有一个follower时，Kafka可以确保已经commit的数据不丢失，但如果某个Partition的所有Replica都宕机了，就无法保证数据不丢失了。这种情况下有两种可行的方案：

1.等待ISR中的任一个Replica“活”过来，并且选它作为Leader

2.选择第一个“活”过来的Replica（不一定是ISR中的）作为Leader

这就需要在可用性和一致性当中作出一个简单的折衷。如果一定要等待ISR中的Replica“活”过来，那不可用的时间就可能会相对较长。而且如果ISR中的所有Replica都无法“活”过来了，或者数据都丢失了，这个Partition将永远不可用。选择第一个“活”过来的Replica作为Leader，而这个Replica不是ISR中的Replica，那即使它并不保证已经包含了所有已commit的消息，它也会成为Leader而作为consumer的数据源（前文有说明，所有读写都由Leader完成）。Kafka0.8.*使用了第二种方式。根据Kafka的文档，在以后的版本中，Kafka支持用户通过配置选择这两种方式中的一种，从而根据不同的使用场景选择高可用性还是强一致性。

#### 选举Leader

最简单最直观的方案是，所有Follower都在ZooKeeper上设置一个Watch，一旦Leader宕机，其对应的ephemeral znode会自动删除，此时所有Follower都尝试创建该节点，而创建成功者（ZooKeeper保证只有一个能创建成功）即是新的Leader，其它Replica即为Follower。

但是该方法会有3个问题：

1.split-brain 这是由ZooKeeper的特性引起的，虽然ZooKeeper能保证所有Watch按顺序触发，但并不能保证同一时刻所有Replica“看”到的状态是一样的，这就可能造成不同Replica的响应不一致

2.herd effect 如果宕机的那个Broker上的Partition比较多，会造成多个Watch被触发，造成集群内大量的调整

3.ZooKeeper负载过重 每个Replica都要为此在ZooKeeper上注册一个Watch，当集群规模增加到几千个Partition时ZooKeeper负载会过重。

Kafka 0.8.*的Leader Election方案解决了上述问题，它在所有broker中选出一个controller，所有Partition的Leader选举都由controller决定。controller会将Leader的改变直接通过RPC的方式（比ZooKeeper Queue的方式更高效）通知需为为此作为响应的Broker。同时controller也负责增删Topic以及Replica的重新分配。

[回到顶部](https://www.cnblogs.com/qingyunzong/p/9004703.html#_labelTop)

## 3.2 HA相关ZooKeeper结构

![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180507195223218-1719228508.png)



### 1 admin

该目录下znode只有在有相关操作时才会存在，操作结束时会将其删除

/admin/reassign_partitions用于将一些Partition分配到不同的broker集合上。对于每个待重新分配的Partition，Kafka会在该znode上存储其所有的Replica和相应的Broker id。该znode由管理进程创建并且一旦重新分配成功它将会被自动移除。



### 2 broker

即/brokers/ids/[brokerId]）存储“活着”的broker信息。

topic注册信息（/brokers/topics/[topic]），存储该topic的所有partition的所有replica所在的broker id，第一个replica即为preferred replica，对一个给定的partition，它在同一个broker上最多只有一个replica,因此broker id可作为replica id。



### 3 controller

/controller -> int (broker id of the controller)存储当前controller的信息

/controller_epoch -> int (epoch)直接以整数形式存储controller epoch，而非像其它znode一样以JSON字符串形式存储。

## 3.3 **producer发布消息**

### 1 写入方式

producer 采用 push 模式将消息发布到 broker，每条消息都被 append 到 patition 中，属于顺序写磁盘（顺序写磁盘效率比随机写内存要高，保障 kafka 吞吐率）。



### 2 消息路由

producer 发送消息到 broker 时，会根据分区算法选择将其存储到哪一个 partition。其路由机制为：

```
1、 指定了 patition，则直接使用；
2、 未指定 patition 但指定 key，通过对 key 的 value 进行hash 选出一个 patition
3、 patition 和 key 都未指定，使用轮询选出一个 patition。
```



### 3 写入流程

producer 写入消息序列图如下所示：

![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180507200019142-182025107.png)

流程说明：

> ```
> 1、 producer 先从 zookeeper 的 "/brokers/.../state" 节点找到该 partition 的 leader 
> 2、 producer 将消息发送给该 leader 
> 3、 leader 将消息写入本地 log 
> 4、 followers 从 leader pull 消息，写入本地 log 后 leader 发送 ACK 
> 5、 leader 收到所有 ISR 中的 replica 的 ACK 后，增加 HW（high watermark，最后 commit 的 offset） 并向 producer 发送 ACK
> ```

[回到顶部](https://www.cnblogs.com/qingyunzong/p/9004703.html#_labelTop)

## 3.4 broker保存消息



### 1 存储方式

物理上把 topic 分成一个或多个 patition（对应 server.properties 中的 num.partitions=3 配置），每个 patition 物理上对应一个文件夹（该文件夹存储该 patition 的所有消息和索引文件），如下：

![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180507200226759-1617322728.png)



### 2 存储策略

无论消息是否被消费，kafka 都会保留所有消息。有两种策略可以删除旧数据：

```
1、 基于时间：log.retention.hours=168 
2、 基于大小：log.retention.bytes=1073741824
```

## 3.5 Topic的创建和删除

### 1 创建topic

创建 topic 的序列图如下所示：

![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180507200343317-1340406332.png)

流程说明：

> ```
> 1、 controller 在 ZooKeeper 的 /brokers/topics 节点上注册 watcher，当 topic 被创建，则 controller 会通过 watch 得到该 topic 的 partition/replica 分配。
> 2、 controller从 /brokers/ids 读取当前所有可用的 broker 列表，对于 set_p 中的每一个 partition：
>   2.1、 从分配给该 partition 的所有 replica（称为AR）中任选一个可用的 broker 作为新的 leader，并将AR设置为新的 ISR 
>   2.2、 将新的 leader 和 ISR 写入 /brokers/topics/[topic]/partitions/[partition]/state 
> 3、 controller 通过 RPC 向相关的 broker 发送 LeaderAndISRRequest。
> ```

### 2 删除topic

删除 topic 的序列图如下所示：

![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180507200533571-310409492.png)

流程说明：

> ```
> 1、 controller 在 zooKeeper 的 /brokers/topics 节点上注册 watcher，当 topic 被删除，则 controller 会通过 watch 得到该 topic 的 partition/replica 分配。 
> 2、 若 delete.topic.enable=false，结束；否则 controller 注册在 /admin/delete_topics 上的 watch 被 fire，controller 通过回调向对应的 broker 发送 StopReplicaRequest。
> ```

## 3.6 broker failover

kafka broker failover 序列图如下所示：

**![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180507200729833-108400321.png)**

流程说明：

> ```
> 1、 controller 在 zookeeper 的 /brokers/ids/[brokerId] 节点注册 Watcher，当 broker 宕机时 zookeeper 会 fire watch
> 2、 controller 从 /brokers/ids 节点读取可用broker 
> 3、 controller决定set_p，该集合包含宕机 broker 上的所有 partition 
> 4、 对 set_p 中的每一个 partition 
>  4.1、 从/brokers/topics/[topic]/partitions/[partition]/state 节点读取 ISR 
>  4.2、 决定新 leader 
>  4.3、 将新 leader、ISR、controller_epoch 和 leader_epoch 等信息写入 state 节点
> 5、 通过 RPC 向相关 broker 发送 leaderAndISRRequest 命令
> ```

[回到顶部](https://www.cnblogs.com/qingyunzong/p/9004703.html#_labelTop)

## 八、**controller failover**

当 controller 宕机时会触发 controller failover。每个 broker 都会在 zookeeper 的 "/controller" 节点注册 watcher，当 controller 宕机时 zookeeper 中的临时节点消失，所有存活的 broker 收到 fire 的通知，每个 broker 都尝试创建新的 controller path，只有一个竞选成功并当选为 controller。

当新的 controller 当选时，会触发 KafkaController.onControllerFailover 方法，在该方法中完成如下操作：

> ```
> 1、 读取并增加 Controller Epoch。 
> 2、 在 reassignedPartitions Patch(/admin/reassign_partitions) 上注册 watcher。 
> 3、 在 preferredReplicaElection Path(/admin/preferred_replica_election) 上注册 watcher。 
> 4、 通过 partitionStateMachine 在 broker Topics Patch(/brokers/topics) 上注册 watcher。 
> 5、 若 delete.topic.enable=true（默认值是 false），则 partitionStateMachine 在 Delete Topic Patch(/admin/delete_topics) 上注册 watcher。 
> 6、 通过 replicaStateMachine在 Broker Ids Patch(/brokers/ids)上注册Watch。 
> 7、 初始化 ControllerContext 对象，设置当前所有 topic，“活”着的 broker 列表，所有 partition 的 leader 及 ISR等。 
> 8、 启动 replicaStateMachine 和 partitionStateMachine。 
> 9、 将 brokerState 状态设置为 RunningAsController。 
> 10、 将每个 partition 的 Leadership 信息发送给所有“活”着的 broker。 
> 11、 若 auto.leader.rebalance.enable=true（默认值是true），则启动 partition-rebalance 线程。 
> 12、 若 delete.topic.enable=true 且Delete Topic Patch(/admin/delete_topics)中有值，则删除相应的Topic。
> ```

## 一、Kafka在zookeeper中存储结构图

![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180508101652574-1613892176.png)

[回到顶部](https://www.cnblogs.com/qingyunzong/p/9007107.html#_labelTop)

## 二、分析



### 2.1　topic注册信息

/brokers/topics/[topic] :

存储某个topic的partitions所有分配信息

```
[zk: localhost:2181(CONNECTED) 1] get /brokers/topics/topic2
```

![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180508103023550-1689525175.png)

```
Schema:
{
    "version": "版本编号目前固定为数字1",
    "partitions": {
        "partitionId编号": [
            同步副本组brokerId列表
        ],
        "partitionId编号": [
            同步副本组brokerId列表
        ],
        .......
    }
}
Example:
{
"version": 1,
"partitions": {
"2": [1, 2, 3],
"1": [0, 1, 2],
"0": [3, 0, 1],
}
}
```

### 2.2　partition状态信息

/brokers/topics/[topic]/partitions/[0...N]  其中[0..N]表示partition索引号

/brokers/topics/[topic]/partitions/[partitionId]/state

![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180508103535274-360887579.png)

```
Schema:
{
"controller_epoch": 表示kafka集群中的中央控制器选举次数,
"leader": 表示该partition选举leader的brokerId,
"version": 版本编号默认为1,
"leader_epoch": 该partition leader选举次数,
"isr": [同步副本组brokerId列表]
}
 
Example:
{
"controller_epoch": 1,
"leader": 3,
"version": 1,
"leader_epoch": 0,
"isr": [3, 0, 1]
}
```

### 2.3　Broker注册信息

/brokers/ids/[0...N]         

每个broker的配置文件中都需要指定一个数字类型的id(全局不可重复),此节点为临时znode(EPHEMERAL)

![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180508103818455-1476762306.png)

```
Schema:
{
"jmx_port": jmx端口号,
"timestamp": kafka broker初始启动时的时间戳,
"host": 主机名或ip地址,
"version": 版本编号默认为1,
"port": kafka broker的服务端端口号,由server.properties中参数port确定
}
 
Example:
{
"jmx_port": -1,
"timestamp":"1525741823119"
"version": 1,
"host": "hadoop1",
"port": 9092
}
```

### 2.4　Controller epoch

/controller_epoch --> int (epoch)  

此值为一个数字,kafka集群中第一个broker第一次启动时为1，以后只要集群中center controller中央控制器所在broker变更或挂掉，就会重新选举新的center controller，每次center controller变更controller_epoch值就会 + 1; 

![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180508104057913-1808088971.png)



### 2.5　Controller注册信息

/controller -> int (broker id of the controller)  存储center controller中央控制器所在kafka broker的信息

![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180508104206487-400676103.png)

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
Schema:
{
"version": 版本编号默认为1,
"brokerid": kafka集群中broker唯一编号,
"timestamp": kafka broker中央控制器变更时的时间戳
}
 
Example:
{
"version": 1,
"brokerid": 0,
"timestamp": "1525741822769"
}
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 



### 2.6　补充Consumer and Consumer group

![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180508104651193-86573907.png)

**a.每个consumer客户端被创建时,会向zookeeper注册自己的信息;**
**b.此作用主要是为了"负载均衡".**
**c.同一个Consumer Group中的Consumers，Kafka将相应Topic中的每个消息只发送给其中一个Consumer。**
**d.Consumer Group中的每个Consumer读取Topic的一个或多个Partitions，并且是唯一的Consumer；**
**e.一个Consumer group的多个consumer的所有线程依次有序地消费一个topic的所有partitions,如果Consumer group中所有consumer总线程大于partitions数量，则会出现空闲情况;**

> **举例说明：**

> **kafka集群中创建一个topic为report-log  4 partitions 索引编号为0,1,2,3**

> **假如有目前有三个消费者node：注意-->一个consumer中一个消费线程可以消费一个或多个partition.**

> **如果每个consumer创建一个consumer thread线程,各个node消费情况如下，node1消费索引编号为0,1分区，node2费索引编号为2,node3费索引编号为3**

> **如果每个consumer创建2个consumer thread线程，各个node消费情况如下(是从consumer node先后启动状态来确定的)，node1消费索引编号为0,1分区；node2费索引编号为2,3；node3为空闲状态**

**总结：**
**从以上可知，Consumer Group中各个consumer是根据先后启动的顺序有序消费一个topic的所有partitions的。**

**如果Consumer Group中所有consumer的总线程数大于partitions数量，则可能consumer thread或consumer会出现空闲状态**。



### 2.7　Consumer均衡算法

**当一个group中,有consumer加入或者离开时,会触发partitions均衡.均衡的最终目的,是提升topic的并发消费能力.**
**1) 假如topic1,具有如下partitions: P0,P1,P2,P3**
**2) 加入group中,有如下consumer: C0,C1**
**3) 首先根据partition索引号对partitions排序: P0,P1,P2,P3**
**4) 根据(consumer.id + '-'+ thread序号)排序: C0,C1**
**5) 计算倍数: M = [P0,P1,P2,P3].size / [C0,C1].size,本例值M=2(向上取整)**
**6) 然后依次分配partitions: C0 = [P0,P1],C1=[P2,P3],即Ci = [P(i \* M),P((i + 1) \* M -1)]**



### 2.8　Consumer注册信息

每个consumer都有一个唯一的ID(consumerId可以通过配置文件指定,也可以由系统生成),此id用来标记消费者信息.

/consumers/[groupId]/ids/[consumerIdString]

是一个临时的znode,此节点的值为请看consumerIdString产生规则,即表示此consumer目前所消费的topic + partitions列表.

consumerId产生规则：

> StringconsumerUuid = null;
> if(config.consumerId!=null && config.consumerId)
> consumerUuid = consumerId;
> else {
> String uuid = UUID.randomUUID()
> consumerUuid = "%s-%d-%s".format(
>  InetAddress.getLocalHost.getHostName, System.currentTimeMillis,
>  uuid.getMostSignificantBits().toHexString.substring(0,8));
>
> }
> String consumerIdString = config.groupId + "_" + consumerUuid;

```
[zk: localhost:2181(CONNECTED) 11] get /consumers/console-consumer-2304/ids/console-consumer-2304_hadoop2-1525747915241-6b48ff32
```

 

![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180508105321039-416763241.png)

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
Schema:
{
"version": 版本编号默认为1,
"subscription": { //订阅topic列表
"topic名称": consumer中topic消费者线程数
},
"pattern": "static",
"timestamp": "consumer启动时的时间戳"
}
 
Example:
{
"version": 1,
"subscription": {
"topic2": 1
},
"pattern": "white_list",
"timestamp": "1525747915336"
}
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)



### 2.9　Consumer owner

/consumers/[groupId]/owners/[topic]/[partitionId] -> consumerIdString + threadId索引编号

a) 首先进行"Consumer Id注册";

b) 然后在"Consumer id 注册"节点下注册一个watch用来监听当前group中其他consumer的"退出"和"加入";只要此znode path下节点列表变更,都会触发此group下consumer的负载均衡.(比如一个consumer失效,那么其他consumer接管partitions).

c) 在"Broker id 注册"节点下,注册一个watch用来监听broker的存活情况;如果broker列表变更,将会触发所有的groups下的consumer重新balance.

![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180508105839526-553140898.png)



### 2.10　Consumer offset

/consumers/[groupId]/offsets/[topic]/[partitionId] -> long (offset)

用来跟踪每个consumer目前所消费的partition中最大的offset

此znode为持久节点,可以看出offset跟group_id有关,以表明当消费者组(consumer group)中一个消费者失效,

重新触发balance,其他consumer可以继续消费.

![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180508110049469-140963000.png)



### 2.11　Re-assign partitions

/admin/reassign_partitions

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
{
   "fields":[
      {
         "name":"version",
         "type":"int",
         "doc":"version id"
      },
      {
         "name":"partitions",
         "type":{
            "type":"array",
            "items":{
               "fields":[
                  {
                     "name":"topic",
                     "type":"string",
                     "doc":"topic of the partition to be reassigned"
                  },
                  {
                     "name":"partition",
                     "type":"int",
                     "doc":"the partition to be reassigned"
                  },
                  {
                     "name":"replicas",
                     "type":"array",
                     "items":"int",
                     "doc":"a list of replica ids"
                  }
               ],
            }
            "doc":"an array of partitions to be reassigned to new replicas"
         }
      }
   ]
}
 
Example:
{
  "version": 1,
  "partitions":
     [
        {
            "topic": "Foo",
            "partition": 1,
            "replicas": [0, 1, 3]
        }
     ]            
}
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)



### 2.12　Preferred replication election

/admin/preferred_replica_election

```
{
   "fields":[
      {
         "name":"version",
         "type":"int",
         "doc":"version id"
      },
      {
         "name":"partitions",
         "type":{
            "type":"array",
            "items":{
               "fields":[
                  {
                     "name":"topic",
                     "type":"string",
                     "doc":"topic of the partition for which preferred replica election should be triggered"
                  },
                  {
                     "name":"partition",
                     "type":"int",
                     "doc":"the partition for which preferred replica election should be triggered"
                  }
               ],
            }
            "doc":"an array of partitions for which preferred replica election should be triggered"
         }
      }
   ]
}
 
例子:
 
{
  "version": 1,
  "partitions":
     [
        {
            "topic": "Foo",
            "partition": 1         
        },
        {
            "topic": "Bar",
            "partition": 0         
        }
     ]            
}
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)



### 2.13　删除topics

/admin/delete_topics

![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180508110442336-511702454.png)

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
Schema:
{ "fields":
    [ {"name": "version", "type": "int", "doc": "version id"},
      {"name": "topics",
       "type": { "type": "array", "items": "string", "doc": "an array of topics to be deleted"}
      } ]
}
 
例子:
{
  "version": 1,
  "topics": ["foo", "bar"]
}
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)



### 2.14　Topic配置

/config/topics/[topic_name]

![img](https://images2018.cnblogs.com/blog/1228818/201805/1228818-20180508110605357-406763586.png)