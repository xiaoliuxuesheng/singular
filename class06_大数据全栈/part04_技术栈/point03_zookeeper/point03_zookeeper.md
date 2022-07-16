# 第一部分 基础操作

## 第一章 Zookeeper入门

### 1.1 概述

Zookeeper是一个开源的分布式的：作用是为分布式框架提供协调服务的项目；

> 题外话：大数据技术栈的logo都是动物，但是其中Zookeeper的Logo是一个动物园管理员的图标，其目的就是管理协调大数据技术栈的一个作用；

### 1.2 特点

1. **Zookeeper工作机制（从设计模式角度理解）**：是一个基于观察者模式设计的分布式服务管理框架，他负责存储和管理大家都关系的数据，然后接受观察者的注册，一旦这些数据发生变化，Zookeeper就将负责通知在Zookeeper上注册的那些观察者
2. **Zookeeper的特点**：
   - Zookeeper集群组成：一个领导者（Leader），多个跟随者（Follower）；
   - 集群中只要有半数以上节点存在，Zookeeper集群就能正常服务（Zookeeper适合安装奇数台服务器）；
   - 全局数据一致：每个Server保存一份相同的数据副本，数据都是一致的；
   - 更新请求顺序执行：来自同一个Client的更新请求按其发送顺序依次执行；
   - 数据更新原子性：一次数据的更新要不全部成功，要不失败；
   - 实时性：在一定时间范围内，Client能读到最新的数据；

### 1.3 数据结构

Zookeeper数据模型的结构与Unix文件系统很类似：整体上看做一棵树，每个节点称作一个ZNode，每个ZNode默认能够存储1MB的数据，每个ZNode都可以通过其路径作为唯一标识；
![[Pasted image 20220703012810.png]]

### 1.4 应用场景

1. 统一命名服务：在分布式环境下，经常徐亚对应用进行统一命名，便于识别；
2. 统一配置管理：分布式环境下，对配置文件的同步也很重要；
3. 统一集群管理：根据节点实时状态做一些调整；
4. 服务器动态上下线：
5. 软负载均衡：记录每台服务器的访问数，让访问数最少的服务器去处理请求；

## 第二章 Zookeeper本地安装

### 2.1 本地模式安装

1. 官网地址：https://zookeeper.apache.org/

2. 下载[Zookeeper](https://zookeeper.apache.org/releases.html)，并解压到需要的安装目录中

3. zookeeper可视化桌面工具：https://github.com/vran-dev/PrettyZoo/releases

4. Linux系统安装
   
   - 安装配置JDK8环境
   
   - 进入Zookeeper安装目录中，修改`$ZK_HOME/config`路径中的配置文件，将`zoo_sample.cfg`拷贝一份并修名称为`zoo.cfg`
   
   - 修改配置文件
     
     ```properties
     # 修改数据保存目录
     dataDir=D:/AppProgram/zookeeper3.7.1/data
     ```
   
   - 启动Zookeeper：`$ZK_HOME/bin/zkServer.sh`

### 2.2 配置参数说明

| zoo.cfg    | 默认值  | 说明                      |
| ---------- | ---- | ----------------------- |
| tickTime   | 2000 | 通信心跳时间，单位毫秒             |
| initLimit  | 10   | Leader和Follower初始化通信时限  |
| syncLimit  | 5    | Leader和Follower通信时间超时时限 |
| dataDir    |      | 默认样例配置，需要修改             |
| clientPort | 2181 | 默认端口号                   |

## 第三章 Zookeeper集群操作

### 3.1 集群安装

1. 集群规划：需要安装多少台的节点？需要是奇数台服务器，服务器IP设置为静态IP，并且修改服务器主机名称，在host配置主机对应的IP地址；比如：
   
   ```sh
   192.168.10.101 BigDataNode101
   192.168.10.102 BigDataNode102
   192.168.10.103 BIgDataNode103
   ```

2. 解压安装，修改配置文件并且重置dataDIR配置项

3. 配置服务器编号：在`$ZK_HOME/config/zoo.cfg`中`dataDir`配置项的目录中新建`myid`的文件，在文件中添加server对应的编号
   
   > 编号上下不能有空行、左右不能有空格

4. 修改配置文件`$ZK_HOME/config/zoo.cfg`，增加zookeeper的集群配置项
   
   ```sh
   server.服务器编号=服务器IP:2888:3888
   ... ...
   ```
   
   > - 服务器编号：是一个数字，表示是第几号服务器，就是每台机器下的myid中配置的值；
   > - 服务器IP：服务器的地址；
   > - 2888：是服务器Follower与集群中Leader服务器交换信息的端口；
   > - 3888：万一集群中Leader服务器挂了，需要一个端口来重新选举出一个新的Leader，这个端口用来执行选举时服务器相互通信的端口；

### 3.2 集群启动选举机制

1. 相关概念
   
   - SID：服务器ID，用来唯一标识一台Zookeeper集群中的机器，每台机器不能重复
   - ZXID：事务ID，ZXID是一个事务ID，用来标识一次服务器状态的更改，在某一时刻，机器中的每台机器的ZXID值不一定完全一致；
   - Epoch：每个Leader任期的代号，没有Leader时同一轮投票过程中的逻辑时钟值是相同的，每投完一次这个数据就会增加；

2. 第一次启动
   
   - 服务器1启动，发起第一次选举：投自己1票，不够半数，服务器保持LOOKING；
   - 服务器2启动，再发起一次选举：服务器1和2分别头自己一票并交换选票信息，此时服务器1发现服务器2的myid比自己的大，服务器1更改选举为服务器2，仍然没有达到半数，服务器1,2保持LOOKING；
   - 服务器3启动，再次发起一次选举：服务器1,2,3根据myid更改选举为服务器3，此时服务器票数超过集群总数的半数，服务器3选举为Leader，服务器1,2更改状态为FLLOWING，服务器3更改状态为LEADING；
   - 服务器4启动，再次发起一次选举：此时服务器3为Leader，那么服务器4更改状态为FLLOWING；
   - 服务器5启动，同服务器4一样当小弟；

3. 非第一次启动：服务器发现以下两种情况之一时，集群再发起Leader选举：①服务器初始化启动②服务器在运行期间无法和Leader保持联系；当情况②发生时，集群可能会有两种状态：
   
   - 集群中本来就已经存在一个Leader：该机器仅仅需要和Leader机器建立连接，并进行状态同步即可；
   - 集群中确实不存在Leader：假设Zookeeper集群有5台机器，SID分别是1,2,3,4,5；ZXID分步是8,8,87,7；此时3和5机器故障，剩余三台机器进行Leader选举，投票情况为（EPoch，ZXID，SID）
     - 投票情况：机器1（1,8,1）、机器2（1,8,2）、机器1（1,7,4）
     - Leader选举规则：①EPoch大的直接胜出②EPoch相同，事务id大的胜出

4. 集群启动脚本：自学时使用，在VMware虚拟器创建的3台虚拟机，
   
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
       for i in BigDataNode101 BigDataNode102 BigDataNode103
       do
           echo  ------------- zookeeper $i 停止 ------------
           ssh $i "/opt/module/zookeeper3.7.1/bin/zkServer.sh stop"
       done
   }
   ;;
   "status"){
       for i in BigDataNode101 BigDataNode102 BigDataNode103
       do
           echo  ------------- zookeeper $i 状态 ------------
           ssh $i "/opt/module/zookeeper3.7.1/bin/zkServer.sh status"
       done
   }
   ;;
   esac
   ```

### 3.2 客户端命令操作

> [【尚硅谷】大数据技术之Zookeeper 3.5.7版本教程_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1to4y1C7gw?p=13)
> 
> - 课程第13课：节点类型

1. 启动zookeeper客户端
   
   ```sh
   zkCli.sh -server BigDataNode101:21821
   ```

2. 基本命令
   
   | 命令  | 说明  |
   | --- | --- |
   |     |     |

3. ls
   
   ```sh
   [zk: BigDataNode101:2181(CONNECTED) 1] ls -s /
   [kafka, zookeeper]
   cZxid = 0x0
   # znode的创建时间
   ctime = Thu Jan 01 08:00:00 CST 1970
   # znode最后更新事务的ID
   mZxid = 0x0
   # znode最后修改的时间
   mtime = Thu Jan 01 08:00:00 CST 1970
   pZxid = 0x2
   cversion = 0
   # znode数据变化号
   dataVersion = 0
   # znode访问控制列表变化号
   aclVersion = 0
   # 如果是临时节点,这个znode拥有者的sessionId,如果不是临时节点则是0;
   ephemeralOwner = 0x0
   # znode的数据长度
   dataLength = 0
   # znode子节点数量
   numChildren = 2
   ```

4. 节点类型：持久、短暂、有序号、无序号
   
   - 持久：客户端和服务端断开连接后，创建的节点不删除
   - 短暂：客户端和服务端断开连接后，创建的节点自己删除
   - 

### 3.3 客户端AP操作

### 3.4 客户端向服务端写数据流程

## 第四章 服务器动态监听

### 4.1 监听说明

### 4.2 动态监听

## 第五章 Zookeeper分布式锁

### 5.1 选举机制

### 5.2 集群安装说明

### 5.2 常用命令

## 第六章 技术点总结

# 第二部分 算法源码

## 第一章 算法基础

### 1.1 拜占庭将军问题

### 1.2 Paxos算法

### 1.3 ZAB协议

### 1.4 CAP

## 第二章 源码讲解

### 2.1 辅助源码

### 2.2 ZK服务端初始化

### 2.3 ZK服务端紧挨着数据

### 2.4 ZK选举

### 2.5 Follower和Leader状态同步

### 2.6 服务端Leader启动

### 2.7 服务端Follower启动
