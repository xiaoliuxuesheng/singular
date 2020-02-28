# 2-1 6 RabbitMQ的前世今生

## 1. 本章导航

- 互联网大厂为什么使用RabbitMQ
- RabbitMQ高性能是如何做到的
- 什么是AMQP高级协议
- AMQP核心概念是什么
- RabbitMQ整体架构模型
- RabbitMQ消息是如何流转的
- 命令行与管控台
- RabbitMQ交换机
- RabbitMQ队列 - 绑定 - 虚拟主机 - 消息

## 2. RabbitMQ介绍

- 是开源的消息代理和消息队列服务器
- 用来通过普通协议在不同的应用之间实现数据共享
- 是基于AMQP协议

## 3. 哪些大厂使用RabbitMQ

> 滴滴 - 艺龙 - 美团 - 头条 - 去哪

- 开源 - 性能优秀,稳定性保障
- 提供可靠的消息投递模式,返回模式
- 与SpringAMQP完美整合
- 集群模式丰富,使用表达式配置, 高可用 支持镜像队列模式
- 保证数据不丢失的前提下做到可靠性与可用性

## 4. RabbitMQ高性能原因

- Erlang语言最初是用作交换机领域,在数据交互的性能是非常优秀的
- Erlang有着和原生socket一样的延迟

## 5. 什么是AMPQ

> Advanced Message Queueing Protocol : 高级消息队列

- 是具有现代特征的二进制协议,是一个提供统一消息服务的应用层标准高级消息队列协议,是应用层协议的一个开放标准,为面向消息中间件设计
- 第一层 : 将生产者和主机做连接
- 第二层 : 生产者的消息投递给主机中的Exchange
- 第三层 : Exchange与MessageQueue关联绑定
- 第四层 : 消费者接受queue中的消息

## 6. AMQP核心概念

- Server : 又称Broker 用户接受客户端的链接
- Connection : 链接,应用和服务器的网络链接
- Channel : 网络信道 , 几乎所有的操作都是在channel中进行,channel进行消息的读写通道
  - 客户端可建立多个channel代表一个会话
- message : 消息 传递的实体数据
  - propetics : 对消息进行装饰, 优先级  发送时间等等
  - body 消息体
- Virtual host : 虚拟主机,用于消息隔离,是最上层的路由
  - 一个host里可以有多个Exchange和Queue
  - 一个Host里面的Exchange或Queue不可以同名
- Exchange 交换机 接受消息,并根据路由建转发消息到绑定的队列
- Binding :绑定 Exchange与Queue之间的虚拟链接,可以保护routing key
- routing key : 路由key,路由规则,虚拟机可用他来确定如何路由一个特定消息
- Queue : 消息队列,保存消息,发送消息

## 7. Rabbit整体架构

1. Produce : 生成者,也是个客户端 需要和RabbitMQ服务器链接
   - 与服务器虚拟机主机建立链接
   - 将消息发送给虚拟主机中的Exchange
2. Server: MQ服务器
   - Exchange , 接受 绑定  路由给Queue
   - Queue : 接收 保存  发送
3. COnsumer : 消费者 也是个客户端
   - 与服务器虚拟机主机建立链接
   - 接受queue中的消息

# 2-7 8 RabbitMQ的安装

1. 环境准备

   - Erlang包与RabbitMQ的准备
   - Linux环境配置,gcc, rpm  等等

2. 安装

   - 第一安装Erlang
   - 第二安装socat  Erlang的解密
   - 安装 rabbitMQ

3. 修改配置文件

   - ./ebin/rabbit.app : 是个json文件
   - {env:[{loopback_users,[guest]}]}

4. 启动

   > rabbitmq-ctl : 控制相关,增减消息队列 , 用户 命令
   >
   > rabbitmq-plugins : 插件启停
   >
   > rabbitmq-server : 服务启停

   - 启动server : rabbit-server start & : 后台启动
   - 停止server : rabbitmq-cttl stop
   - 管理插件 : rabbitmq-plugins enable rabbitmq_management
   - 访问管理页面 : http://ip:15672/
     - username : guest
     - pwd : guest

# 2-9 命令行与管控台操作

1. 命令行操作
2. 管控台操作

# 2-10 11 生产者与消费者模型构建

1. 基本类型说明

   - ConnectionFactory : 链接工厂,用于创建连接对象,需要制定主机与IP与虚拟主机

     ```java
     ConnectionFactory factory = new ConnectionFactory();
     factory.setHost("127.0.0.1");
     factory.setPort(5672);
     factory.setVirtualHost("/");
     ```

   - Connection : 连接对象

     ```java
     Connection connection = factory.newConnection();
     ```

   - Channel : 信道, 用于发送与接收消息

     ```java
     Channel channel = connection.createChannel();
     
     // 发送消息
     channel.basicPublish(String exchange, 
                          String routingKey, 
                          BasicProperties props, 
                          byte[] body);
     ```

   - Queue:队列 , 从信道声明Queue

     ```java
     channel.queueDeclare(String queue, 
                          boolean durable, 
                          boolean exclusive, 
                          boolean autoDelete,
                          Map<String, Object> arguments);
     ```

   - Produce与Consumer : 自定义应用

     ```java
     Consumer consumer = new DefaultConsumer(channel) {
     	@Override
     	public void handleDelivery(String consumerTag,
                                    Envelope envelope,
                                    AMQP.BasicProperties properties,
                                    byte[] body) throws IOException {
     		String message = new String(body, "UTF-8");
     		System.out.println("Received '" + message + "'");
     		}
     	};
     	channel.basicConsume(queue, true, consumer);
     ```

2. 默认说明

   - 发送消息如果不指定交换机, 会使用RabbitMQ中第一个默认的交换机,匹配规则是路由key和队列名称进行匹配.

# 2-12 14交换机

接受消息,并根据路由建转发到所绑定的队列

交互机属性

- durability 是否持久化
- autodelete 自动删除
- internal  当前交换机是否用户内部使用
- arguments   扩展参数

https://www.cnblogs.com/vipstone/p/9295625.html

1. direct交换器

   direct为默认的交换器类型，也非常的简单，如果路由键匹配的话，消息就投递到相应的队列

   **公平调度**

   当接收端订阅者有多个的时候，direct会轮询公平的分发给每个订阅者（订阅者消息确认正常）

   **消息的发后既忘特性**

   发后既忘模式是指接受者不知道消息的来源，如果想要指定消息的发送者，需要包含在发送内容里面，这点就像我们在信件里面注明自己的姓名一样，只有这样才能知道发送者是谁。

   ### 消息确认

   看了上面的代码我们可以知道，消息接收到之后必须使用channel.basicAck()方法手动确认（非自动确认删除模式下），那么问题来了。

   **消息收到未确认会怎么样？**

   如果应用程序接收了消息，因为bug忘记确认接收的话，消息在队列的状态会从“Ready”变为“Unacked”

   如果消息收到却未确认，Rabbit将不会再给这个应用程序发送更多的消息了，这是因为Rabbit认为你没有准备好接收下一条消息。

   此条消息会一直保持Unacked的状态，直到你确认了消息，或者断开与Rabbit的连接，Rabbit会自动把消息改完Ready状态，分发给其他订阅者。

   当然你可以利用这一点，让你的程序延迟确认该消息，直到你的程序处理完相应的业务逻辑，这样可以有效的防治Rabbit给你过多的消息，导致程序崩溃。

   **总结：消费者消费的每条消息都必须确认。**

   ### 消息拒绝

   消息在确认之前，可以有两个选择：

   选择1：断开与Rabbit的连接，这样Rabbit会重新把消息分派给另一个消费者；

   选择2：拒绝Rabbit发送的消息使用channel.basicReject(long deliveryTag, boolean requeue)，参数1：消息的id；参数2：处理消息的方式，如果是true，Rabbib会重新分配这个消息给其他订阅者，如果设置成false的话，Rabbit会把消息发送到一个特殊的“死信”队列，用来存放被拒绝而不重新放入队列的消息。

2. fanout交换器——发布/订阅模式

   fanout是一种发布/订阅模式的交换器，当你发送一条消息的时候，交换器会把消息广播到所有附加到这个交换器的队列上。我们在发送消息的时候新增channel.exchangeDeclare(ExchangeName, "fanout")，这行代码声明fanout交换器。

   fanout和direct的区别最多的在接收端，fanout需要绑定队列到对应的交换器用于订阅消息。

   其中channel.queueDeclare().getQueue()为随机队列，Rabbit会随机生成队列名称，一旦消费者断开连接，该队列会自动删除。

   **注意：**对于fanout交换器来说routingKey（路由键）是无效的，这个参数是被忽略的。

3. topic交换器——匹配订阅模式

   topic交换器运行和fanout类似，但是可以更灵活的匹配自己想要订阅的信息，这个时候routingKey路由键就排上用场了，使用路由键进行消息（规则）匹配。

   topic路由器的关键在于定义路由键，定义routingKey名称不能超过255字节，

   消费消息的时候routingKey可以使用下面字符匹配消息：

   - "*"匹配一个分段(用“.”分割)的内容；
   - "#"匹配0和多个字符；

   **注意：**fanout、topic交换器是没有历史数据的，也就是说对于中途创建的队列，获取不到之前的消息。

扩展部分—自定义线程池

```java
ExecutorService es = Executors.newFixedThreadPool(20);
Connection conn = factory.newConnection(es);
```

```java
private ExecutorService sharedExecutor;
public Connection newConnection() throws IOException, TimeoutException {
        return newConnection(this.sharedExecutor, 
                             Collections.singletonList(new Address(getHost(), getPort())));
}
public void setSharedExecutor(ExecutorService executor) {
        this.sharedExecutor = executor;
}
```

其中this.sharedExecutor就是默认的线程池，可以通过setSharedExecutor()方法设置ConnectionFactory的线程池，如果不设置则为null。

用户如果自己设置了线程池，像本小节第一段代码写的那样，那么当连接关闭的时候，不会自动关闭用户自定义的线程池，所以用户必须自己手动关闭，通过调用shutdown()方法，否则可能会阻止JVM的终止。

官方的建议是只有在程序出现严重性能瓶颈的时候，才应该考虑使用此功能。

# 2-15 绑定 队列 消息

1. binding 绑定
2. queue
3. message
4. 