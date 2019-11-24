# 第九章 Redis Sentinel

https://www.cnblogs.com/biglittleant/p/7770960.html

## 9.1 主从复制存在的问题

- 主从复制的故障转移需要手动执行；
- 写能力与存储能力受限：只能在一个节点写，其他节点是从库；

## 9.2 sentinel架构

1. 作用：监控节点、故障迁移、客户端通知
2. 架构
   - 准备Redis主从服务器；
   - 配置sentinel节点：对Redis服务器故障的判断和转移；
   - 客户端从sentinel获取Redis信息；
   - 发现故障和故障转移
     - 可以由多个sentinel发现并确认master的故障
     - 选出一个slave作为新的master
     - 通知其他slave成为新master的从节点
     - 通知客户端主从变化
     - 等待老master复活成为新master的从节点
   - 可以实现监控多套Redis主从

## 9.3 安装与配置

1. 首先需要配置并启动Redis主从

2. 配置sentinel

   ```properties
   port 26379
   daemonize no
   bind 192.168.56.11
   logfile "/data/app/redis/logs/sentinel_26379.log"
   dir "/data/db/sentinel_26379"
   sentinel monitor mymaster 192.168.56.11 6379 2
   sentinel down-after-milliseconds mymaster 30000
   sentinel parallel-syncs mymaster 1
   sentinel failover-timeout mymaster 180000
   ```

   接下来我们将一行一行地解释上面的配置项：

   ```
   sentinel monitor mymaster 192.168.56.11 6379 2
   ```

   这一行代表sentinel监控的master的名字叫做mymaster,地址为`192.168.56.11:6379`，行尾最后的一个2代表什么意思呢？我们知道，网络是不可靠的，有时候一个sentinel会因为网络堵塞而误以为一个master redis已经死掉了，当sentinel集群式，解决这个问题的方法就变得很简单，只需要多个sentinel互相沟通来确认某个master是否真的死了，这个2代表，当集群中有2个sentinel认为master死了时，才能真正认为该master已经不可用了。（sentinel集群中各个sentinel也有互相通信，通过gossip协议）。

   除了第一行配置，我们发现剩下的配置都有一个统一的格式:

   ```
   sentinel <option_name> <master_name> <option_value>
   ```

   接下来我们根据上面格式中的option_name一个一个来解释这些配置项：

   ```
   down-after-milliseconds
   ```

   sentinel会向master发送心跳PING来确认master是否存活，如果master在“一定时间范围”内不回应PONG 或者是回复了一个错误消息，那么这个sentinel会主观地(单方面地)认为这个master已经不可用了(subjectively down, 也简称为SDOWN)。而这个down-after-milliseconds就是用来指定这个“一定时间范围”的，单位是毫秒。
   不过需要注意的是，这个时候sentinel并不会马上进行failover主备切换，这个sentinel还需要参考sentinel集群中其他sentinel的意见，如果超过某个数量的sentinel也主观地认为该master死了，那么这个master就会被客观地(注意哦，这次不是主观，是客观，与刚才的subjectively down相对，这次是objectively down，简称为ODOWN)认为已经死了。需要一起做出决定的sentinel数量在上一条配置中进行配置。

   ```
   parallel-syncs
   ```

   在发生failover主备切换时，这个选项指定了最多可以有多少个slave同时对新的master进行同步，这个数字越小，完成failover所需的时间就越长，但是如果这个数字越大，就意味着越多的slave因为replication而不可用。可以通过将这个值设为 1 来保证每次只有一个slave处于不能处理命令请求的状态。
   其他配置项在sentinel.conf中都有很详细的解释。
   所有的配置都可以在运行时用命令SENTINEL SET command动态修改

3. 启动sentinel

   ```sh
   redis-sentinel sentinel_6379.conf
   redis-server sentinel_6379.conf --sentinel
   ```

   