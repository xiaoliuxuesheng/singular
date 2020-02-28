# 第一章 消息中间件

## 1.1 消息中间件概述

​		衡量消息中间件的指标：服务性能，数据存储，集群架构

## 1.2 业界主流的消息中间件

### <font size=4 color=blue> ▲ ActiveMQ</font>

​		ActiveMQ是Apache出品的，最流行的能力，强劲的开源消息总线，并且他完全支持Java的JMs规范。丰富的API，多种集群构建模式使得它成为业界老牌的消息中间件，在中小型企业应用广泛。但是相比于kafka，rabbitmq等MQ来说，性能太弱，**在如今的高并发，大数据处理的场景下显得力不从心**，经常会出现一些小问题，消息延迟，堆积，堵塞等，不过其多种集群架构是优势。

​		<img src='./imgs/01_activemq架构'/>

**ActiveMQ的两种集群架构**

1. master-slave模式:通过zk确立一个主节点，主节点对外提供服务，从节点不对外提供服务。当主节点不可用，另外一个节点就转成主节点，对外提供服务，已达到高可用的目的。

2. network模式就相当于两组master-slave组合在一起。

### <font size=4 color=blue> ▲ Kafka</font>

​		kafka是linkedin开源的分布式发布-订阅消息系统，目前归属于Apache的顶级项目。主要特点是基于pull模式来处理消息消费，**追求高吞吐量**，一开始的目的是日志的收集和传输。0.8版本开始支持复制，**不支持事务，对消息的丢失，重复，错误没有严格要求** 适用于产生大量数据的互联网服务的数据收集业务。在廉价的服务器上都能有很高的性能，这个主要是基于操作系统底层的pagecache，不用内存胜似使用内存。

<img src='./imgs/02_kafka架构'/>

​		Kafka集群也是采用zk进行集群，当一个数据存放在一个节点中，会通过relicate同步到其他节点，所以我们不需要更多的关注kafka有可能丢失消息，因为其他节点会有这份数据，除非你这个地区的kafka都挂了。可靠性高的场景不适用。

### <font size=4 color=blue> ▲ RocketMQ</font>

RocketMQ是阿里开源的，目前是也是Apache的顶级项目，纯Java开发，**具有高吞吐量，高可用，适合大规模分布式系统应用的特点**。其思路起源于kafka，它对消息的可靠传输以及事务性做了优化，目前在阿里被广泛应用于交易/充值/流计算/消息推送/日志流式处理/Binglog分发等场景。不过其维护是一个痛点。不过它能保证消息的顺序性，集群模式也丰富，在双十一等高并发场景承受上亿访问，三大指标都很好，但是它的**商业版要收费！！！**

<img src='./imgs/03_rocketmq架构'/>

​		RocketMQ集群它刚开始也是依赖zk做集群的，但是觉得太慢就自己开发了Name Server。

### <font size=4 color=blue> ▲ RabbitMQ</font>

​	RabbitMQ是使用erlang语言开发的开源消息队列系统，基于AMQP协议来实现。AMQP的主要特征是面向消息/队列/路由(包括点对点的发布/订阅)可靠性，安全。AMQP协议更多用在企业系统内，**对数据一致性/稳定性和可靠性要求很高的场景，对性能和吞吐量的要求还在其次**。rabbitMQ的可靠性很高，性能比不上kafka，但是也很高了，集群模式也有多种。

<img src='./imgs/04_rabbitmq架构'/>

# 第二章 RabbitMQ的安装与管控台

## 2.1 不同环境下安装RabbitMQ

### <font size=4 color=blue> ▲ Windows系统安装 </font>

### <font size=4 color=blue> ▲ Linux系统安装 </font>

### <font size=4 color=blue> ▲ Docker安装 </font>

## 2.2 RabbitMQ命令行与管控台

### <font size=4 color=blue> ▲ Rabbit命令行</font>

- rabbitmqctl start_app：启动应用
- rabbitmqctl stop_app：关闭应用
- rabbitmqctl status：节点状态
- rabbitmqctl add_user <用户名> <密码>：添加用户
- rabbitmqctl list_users：列出所有用户
- rabbitmqctl delete_user <用户名>：删除用户
- rabbitmqctl clear_permissions -p <虚拟主机地址> <用户名>：清除用户权限
- rabbitmqctl list_user_permissions  <用户名>：列出用户权限
- rabbitmqctl change_password <用户名> <密码>：修改密码
- rabbitmqctl set_permissions -p <虚拟主机地址> <用户名> ".\*"  ".\*"   ".*"：设置权限
- rabbitmqctl add_vhost <虚拟主机地址>：创建虚拟主机
- rabbitmqctl list_vhost：查看虚拟主列表
- ：移除所有数据
- ：组成集群命令
- ：修改集群节点存储形式
- ：忘记节点
- ：修改节点名称

### <font size=4 color=blue> ▲ Rabbit管控台</font>



# 第三章 RabbitMQ基础

## 3.1 AMQP协议

​		AMQP（Adviced Message Queuing Protocol）：是具有现代特征的二进制协议。是一个提供统一消息服务的应用层标准高级消息队列协议，是应用层协议的一个开放标准，为面向消息的中间件设计。

<img src='/imgs/05_AMQP协议模型'/>

- 发布者（Publisher）发布消息（Message），经由交换机（Exchange）。
- 交换机根据**路由规则**将收到的消息分发给与该交换机绑定的队列（Queue）。
- 最后 AMQP 代理会将消息投递给订阅了此队列的消费者，或者消费者按照需求自行获取。

## 3.2 RabbitMQ介绍

​		RabbitMQ是一个开源的消息代理和队列服务器，用来通过普通协议在完全不同的应用之间数据共享，RabbitMQ是基于Erlang语言编写的（安装RabbitMQ需要提前准备Erlang坏境），RabbitMQ是基于AMQP协议的。

​		RabbitMQ特点：

​			① 开源、性能优秀、稳定性保障

​			② 提供可靠性消息投递模式（confirm）、返回模式（return）

​			③ 与SpringAMQP完美整合：API丰富

​			④ 集群模式丰富、表达式配置（配置集群策略）：HA模式、镜像队列模式；

​			⑤ 保证数据不丢失的前提做到可靠性、可用性；

​		RabbitMQ高性能的原因：Erlang语言最初在于交换机领域的架构模式，是的RabbitMQ在Broker直接进行数据交互的的性能是非常优秀的；Erlang的特点是原生Socket一样的延迟；

## 3.3 RabbitMQ核心概念

### <font size=4 color=blue> ▲ Server</font>

- 又称Broker，接受客户端的连接，实现AMQP实体服务

### <font size=4 color=blue> ▲ Connection</font>

- 连接，应用程序与Broker的网络连接

### <font size=4 color=blue> ▲ Channel</font>

- 网络信道，几乎所有的操作都在Channel中进行，Channel是进行消息读写的通道。客户端可以建立多个Channel，每个Channel代表一个会话任务。

### <font size=4 color=blue> ▲ Message</font>

- 消息，服务器之间和应用程序之间传输的数据：由Properties和Body组成；
  - Properties可以对消息进行修饰，比如消息的优先级、延迟等高级特性；
  - Body：消息的主体内容；

### <font size=4 color=blue> ▲ Virtual Host</font>

- 虚拟主机，用于进行逻辑隔离，是最上层的消息路由；一个Virtual Host中可以有若干个Exchange和Queue，统一Virtual Host中不能有相同名称的Exchange和Queue。

### <font size=4 color=blue> ▲ Exchange</font>

1. **交换机作用**：接受消息，根据路由键转发消息到绑定的队列

   <img src='./imgs/08_exchange路由'/>

2. **交换机相关属性**

   - Name：交互机名称，同一个virtual host里面的Name不能重复；不同的virtual host是可以重复的

   - Type：交换机类型

     - **Default Excante**：名字是空字符串

       > 1. 默认的Exchange不能进行Binding操作
       > 2. 任何发送到该Exchange的消息都会被转发到Routing key和queue名字相同的Queue中
       > 3. 如果vhost中不存在Routing key中指定的队列名，则该消息会被抛弃

     - **Direct Exchange**：将消息中的Routing key与该Exchange关联的所有Binding中的Routing key进行比较，如果相等，则发送到该Binding对应的Queue中

       > 1. 一个Exchange可以Binding一个或多个Queue
       > 2. 绑定可以指定Routing key， Binding的多个Queue可以使用相同的Routing key，也可以使用不同的Routing key

       <img src='./imgs/09_direct'/>

     - **Topic Exchange**：将消息中的Routing key与该Exchange关联的所有Binding中的Routing key进行比较，如果匹配上了（匹配上规则），则发送到该Binding对应的Queue中

       > - `*`匹配一个单词，只能写在 `.` 号左右，且不能挨着字符
       > - `#`匹配0个或多个字符，只能写在 `.` 号左右，且不能挨着字符
       > - 单词和单词之间需要用 `.` 隔开

     - **Fanout Exchange**：直接将消息转发到所有Binding的对应的Queue中这种Exchange在路由转发的时候，忽略Routing key这种Exchange效率最高

     - **Headers Exchange**：将消息中的headers与该Exchange关联的所有Binding中的参数进行匹配，如果匹配上了，则发送到该Binding对应的Queue中

   - Durability：交换机是否需要持久化

     > - Durable：是，Transient：否
     > - 如果不持久化，当break重启之后，当前的exchange会消失

   - Auto Delete：当最后一个绑定被删除后，该exchange自动被删除

     > 在exchange创建之后，并且已经设置好binding，如果该exchange的所有binding都被删除，则该exchange被删除。当然如果当前的exchange还没有开始binding，是不会被删除的。

   - Internal：是否是内部专用exchange，是的话，就意味着我们不能往该exchange里面发送消息

   - Arguments：参数，是AMQP协议留给AMQP实现做扩展用的

     > 其中rabbit提供了一个属性alternate-exchange，当发送的消息，当前的exchange，根据路由信息没有找到对应的Queue的时候，就会将消息转发到alternate-exchange属性指定的exchange中。如果最总都没有路由到队列中，就会将该条消息丢弃。

### <font size=4 color=blue> ▲ Binding</font>

- Exchange和Queue的虚拟连接，binding中可以包含routing key

### <font size=4 color=blue> ▲ Routing Key</font>

- 一个路由规则，虚拟机可用它来确定如何路由一个特定的消息

### <font size=4 color=blue> ▲ Queue</font>

- 消息队列，保存消息，消费者消费消息主要是通过连接到交换机，根据Queue的路由规则消费消息

## 3.4 RabbitMQ的整体架构

<img src='./imgs/06_rabbitmq架构'/>



## 3.5 RabbitMQ消息流转

<img src='./imgs/07_rabbitmq消息路由'/>

## 3.6 RabbitMQ快速入门

<font size=4 color=blue> ▲ 案例坏境准备</font>

1. 启动RabbitMQ：{用户名：guest，密码：guest}

2. 新建Maven项目，添加RabbitMQ原生依赖

   ```xml
   <dependency>
       <groupId>com.rabbitmq</groupId>
       <artifactId>amqp-client</artifactId>
       <version>5.4.3</version>
   </dependency>
   ```

3. 编写获取连接的工具类

   ```java
   public class ConnectionUtil {
       public static Connection getCon() throws Exception {
           // 1. 创建链接工厂:主机端口+虚拟主机
           ConnectionFactory factory = new ConnectionFactory();
           factory.setHost("127.0.0.1");
           factory.setPort(5672);
           factory.setVirtualHost("/");
   
           // 2. 新建链接
           return factory.newConnection();
       }
   }
   ```

4. 设计消费者，用于接收消息（RabbitMQ新版需要继承DefaultConsumer实现handleDelivery方法）

   ```java
   public class Consumer extends DefaultConsumer {
   
       public Consumer(Channel channel) {
           super(channel);
       }
   
       @Override
       public void handleDelivery(String consumerTag, 
                                  Envelope envelope, 
                                  AMQP.BasicProperties properties, 
                                  byte[] body) throws IOException {
           
           out.println("-----------Consumer接受到消息开始----------");
           out.println("Consumer consumerTag: " + consumerTag);
           out.println("Consumer envelope: " + envelope);
           out.println("Consumer properties: " + properties);
           out.println("Consumer body: " + new String(body));
       }
   }
   ```

<font size=4 color=blue> ▲ 消息的发送与接收</font>

1. 使用RabbitMQ默认的交换机发送并接受消息

   - 消息接受

     ```java
     public static void main(String[] args) throws Exception {
         Connection connection = ConnectionUtil.getCon();
         Channel channel = connection.createChannel();
         String queue = DefuProducer.routingKey;
         channel.queueDeclare(queue, true, false, false, null);
         channel.basicConsume(queue, true, new Consumer(channel));
     }
     ```

     > Channel.queueDeclare：声明一个队列
     >
     > - **name**：队列名字，如果没有声明交换机，会从RabbitMQ的默认交换机中查询与这个名称相同的路由key的消息；
     > - **autoDelete**：是否自动删除队列，当最后一个消费者断开连接之后队列是否自动被删除，可以通过RabbitMQ Management，查看某个队列的消费者数量，当consumers = 0时队列就会自动删除
     > - **exclusive**：是否排外的，有两个作用，一：当连接关闭时connection.close()该队列是否会自动删除；二：该队列是否是私有的private，如果不是排外的，可以使用两个消费者都访问同一个队列，没有任何问题，如果是排外的，会对当前队列加锁，其他通道channel是不能访问的，如果强制访问会报异常；
     > - **noWait**：是否等待服务器返回
     > - **args**：相关参数

## 3.7 RabbitMQ继承SpringBoot



# 第四章 RabbitMQ用户组管理



# 第五章 RabbitMQ集群架构



# 第六章 消息中间件与架构设计
