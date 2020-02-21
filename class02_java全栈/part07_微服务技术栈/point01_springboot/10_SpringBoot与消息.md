# 第十章 SpringBoot与消息

## 10.1 消息概述

- 消息服务中间件可以提升系统异步通信和扩展解耦能力

- 消息服务的两个核心概念

  - 消息代理 : message broker : 接管发送出来的消息
  - 目的地 : destination : 消息的真实目的地

- 消息队列的目的地形式

  - 队列 : 点对点通信
    - 消息发送者发送消息,消息代理将消息放进消息队列,服务接收者从消息队列中获取消息
    - 消息被读取后被移除消息队列
  - 主题 : 发布/订阅消息通信
    - 消息发送者发送消息到主题,多个接收者监听这个主题,多个接收者可以同时收到消息

- JMS : Java Massage Server - java消息服务

  - 基于JVM消息代理规范 : ActiveMQ , HornetMQ是JMS的实现

- AMQP : Advanced Message Queuing Protocol - 高级消息队列协议,消息代理的一种规范

  - RabbitMQ是AMQP的一个实现

  - 天然跨语言跨平台

- Spring的支持
  - spring-jms : 对JMS支持
  - spirng-rabbit : 对AMQP支持

## 10.2 RabbitMQ

### 1. RabbitMQ核心概念

- Message : 消息
  - 消息是不具名的,由消息头和消息体组成
  - 消息体是不透明的,消息头是由一系列可选属性组
- Publisher : 消息生产者
  - 向交换器发布消息的客户端应用程序
- ExChange : 交换器,接收生产者发送的消息,并将这些消息路由给服务器中的队列
  - direct : (默认) 点对点 : 值匹配连接
  - fanout : 发布/订阅模式 : 广播模式
  - topic : 发布/订阅模式 : 单词匹配模式 可以使用*代表单词做通配符
  - headers : 发布/订阅模式

- Queue : 消息队列,保存消息直到发送给消费者
  - 是消息的容器,也是容器的终点
  - 一个消息和投入一个或多个队列,等待联结者从队列中取走消息
- Binding : 绑定 : 用于消息队列和交换器的绑定
- Connection : 网络连接
- Channel : 信道 : 多路复用中的一条独立的双向的数据流通道
  - 建立在真实的TCP连接内的虚拟连接
- Consumer : 消息消费者
- Virtual Host : 虚拟主机 表示一批交换器
- Broker : 表示消息队列服务器实体

### 2. RabbitMQ运行机制

### 3. 安装RabbitMQ

- Docker安装

- 登陆 : guest:guest

## 10.3 SpringBoot整合RabbitMQ

### 1. 添加依赖

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-amqp</artifactId>
</dependency>
```

### 2. 添加配置

```yaml
spring:
  rabbitmq:
    host: 192.168.80.140
    username: guest
    password: guest
    port: 5672
```

