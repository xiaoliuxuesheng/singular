# 第六章 瑞士军刀Redis

> Redis 还提供了注入慢查询分析, Redis Shell 、 Pipeline 、事务、与 Lua 脚本、 Bitmaps 、 HyperLogLog 、 PubSub 、 GEO 等附加功能

## 6.1 慢查询

1. <font size=5><b>Redis命令执行的生命周期</b></font>

    ```mermaid
     graph LR
     A(1.发送命令) --> B(2.单线程命令排队) 
     B --> C(3.执行命令)
     C --> D(4.返回结果)
    ```

    :anchor: 慢查询发生在命令执行阶段

    :anchor: 客户端超时不一定是慢查询

2. <font size=5><b>Redis慢查询说明</b></font>

    ​		许多存储系统(如: MySQL )提供慢查询日志帮助开发与运维人员定位系统存在的慢操作.所谓慢查询日志就是系统在命令执行前后计算每条命令的执行时间,当超过预设阈值,就将这条命令的相关信息(例如:发生时间,耗时,命令的详细信息)记录到慢查询日志中

    ​		慢查询只统计步骤 3 的时间,所以没有慢查询并不代表客户端没有超时问题.

3. <font size=5><b>Redis慢查询配置</b></font>

    :anchor: **配置说明**

    - 实际上 Redis 使用了一个列表来存储慢查询日志, slowlog-max-len 就是列表的最大长度.一个新的命令满足慢查询条件时被插入到这个列表中,当慢查询日志列表已处于其最大长度时,最早插入的一个命令将从列表中移出
    - 每个查询日志有4个属性组成,分别是慢查询日志的表示 id 、发生时间戳、命令耗时、执行命令和参数
    - 由于慢查询日志是一个先进先出的队列,也就是说如果慢查询比较多的情况下,可能会丢失部分慢查询命令,为了防止这种情况发生,可以定期执行 slowlog get 命令将慢查询日志持久化到其他存储中(例如: MySQL 、 ElasticSearch 等),然后可以通过可视化工具进行查询

    :anchor: **查看当前Redis服务器慢查询参数**

    ```sh
    onfig get slowlog-max-len			# 慢查询队列的长度，默认是128
    config get slowlog-log-slower-than	# 慢查询阈值(微妙)，默认是10000
    lowlog-log-slower-than=0			# 记录所有命令
    slowlog-log-slower-than<0			# 对于任何命令都不会进行记录
    ```

    :anchor: **设置慢查询参数**

    - 方式一 : 修改配置文件然后重启Redis服务器

    - 方式二 : 动态配置即时生效 

        ```sh
        onfig set slowlog-max-len 1000
        ```

    :anchor: **查询慢查询队列的命令**

    ```sh
    slowlog get [n]		# 获取慢查询队列中n个元素
    slowlog len			# 获取慢查询队列的长度
    slowlog rest		# 清空慢查询队列
    ```

    :anchor: **慢查询推荐优化方案**

    - slowlog-log-slower-than不要设置过大，默认是10ms，通常设置1ms
    - slowlog-max-len不要设置过小，通常设置1000左右
    - 理解命令生命周期
    - 定期持久化慢查询

## 6.2 pipeline

1. <font size=5><b>Redis命令的执行周期</b></font>

  ```mermaid
   graph LR
   A(1.发送命令) --> B(2.单线程命令排队) 
   B --> C(3.执行命令)
   C --> D(4.返回结果)
  ```
  
  - Redis的命令执行在毫秒级别，命令的执行主要的消耗时间是在命令的传输与执行结果的相应；
  - 如果需要执行批量的简单命令，那么大量的时间将会消耗在命令的传输中
  
2. <font size=5><b>pipeline命令的执行特点</b></font>

    - 传统批量命令执行方式

        ```mermaid
        sequenceDiagram
        Client ->> RedisServer:命令1
        RedisServer ->> RedisServer:执行命令1
        RedisServer -->> Client:返回结果1
        Client ->> RedisServer:命令2
        RedisServer ->> RedisServer:执行命令2
        RedisServer -->> Client:返回结果2
        Client ->> RedisServer:命令3
        RedisServer ->> RedisServer:执行命令3
        RedisServer -->> Client:返回结果3
        ```

    - pipeline执行批量命令

        ```mermaid
        sequenceDiagram
        Client ->> RedisServer:命令1+命令2+命令3...
        RedisServer ->> RedisServer:执行命令1
        
        RedisServer ->> RedisServer:执行命令2
        
        
        RedisServer ->> RedisServer:执行命令3
        RedisServer -->> Client:返回结果1+2+3...
        ```

    - pipeline机制可以优化吞吐量，但无法提供原子性/事务保障，而这个可以通过Redis-Multi等命令实现。
    - 部分读写操作存在相关依赖，无法使用pipeline实现，可利用Script机制，但需要在可维护性方面做好取舍

3. <font size=5><b>使用Java执行Pipeline</b></font>

    - Jedis中的pipeline使用

        ```java
        // 先创建一个pipeline的链接对象.
        Pipeline pipe = jedis.pipelined();
        
        // 批量命令
        for (int i = 0; i < 10000; i++) {
            pipe.set(String.valueOf(i), String.valueOf(i));
        }
        
        // 获取所有的response
        pipe.sync();
        List<Object> list = pipe.syncAndReturnAll();
        ```

    - RedisTemplate使用PipeLine

        > 注意事项:
        >
        > - 这里的connect是redis原生链接，所以connection的返回结果是基本上是byte数组
        > - 在doInRedis中返回值必须返回为null
        > - connection.openPipeline()可以调用，也可以不调用，但是connection.closePipeline()不能调用，调用了拿不到返回值。因为调用的时候会直接将结果返回，同时也不会对代码进行反序列化。
        > - 

        ```java
        redisTemplate.execute(new RedisCallback<Long>() {
             @Nullable
             @Override
             public Long doInRedis(RedisConnection connection) throws Exception {
                 connection.openPipeline();
                 for (int i = 0; i < 1000000; i++) {
                     String key = "123" + i;
                     connection.zCount(key.getBytes(), 0,Integer.MAX_VALUE);
                 }
                 return null;
             }
         });
        ```

        > 这个list是放在匿名类内部，对于数据处理不太友好，代码会看起来相当难受，想取出来使用还是不可变的

        ```java
         List<Long> List = redisTemplate.executePipelined(new RedisCallback<Long>() {
                    @Nullable
                    @Override
                    public Long doInRedis(RedisConnection connection) throws Exception {
                        connection.openPipeline();
                       for (int i = 0; i < 1000000; i++) {
                            String key = "123" + i;
                            connection.zCount(key.getBytes(), 0,Integer.MAX_VALUE);
                        }
                        return null;
                    }
                });
        
        ```

        > 可以返回我们需要的结果，下面我们可以对得到list进行操作。

## 6.3 发布订阅

## 6.4 Bitmap

## 6.5 HyperLogLog

## 6.6 GEO

# 第七章 Redis持久化选择

# 第八章 Redis复制原理和优化

# 第九章 Redis Sentinel

# 第十章 Redis Cluster

