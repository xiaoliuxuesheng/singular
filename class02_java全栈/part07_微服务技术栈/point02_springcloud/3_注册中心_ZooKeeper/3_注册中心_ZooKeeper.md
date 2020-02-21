# [Zookeeper学习之路 （一）初识](https://www.cnblogs.com/qingyunzong/p/8618965.html)

讨论QQ：1586558083



**目录**

- [引言](https://www.cnblogs.com/qingyunzong/p/8618965.html#_label0)
- [分布式协调技术](https://www.cnblogs.com/qingyunzong/p/8618965.html#_label1)
- 分布式锁的实现
  - [面临的问题](https://www.cnblogs.com/qingyunzong/p/8618965.html#_label2_0)
  - [分布式锁的实现者](https://www.cnblogs.com/qingyunzong/p/8618965.html#_label2_1)
- [ZooKeeper概述](https://www.cnblogs.com/qingyunzong/p/8618965.html#_label3)
- ZooKeeper数据模型
  - [ZooKeeper数据模型Znode](https://www.cnblogs.com/qingyunzong/p/8618965.html#_label4_0)
  - [ZooKeeper中的时间](https://www.cnblogs.com/qingyunzong/p/8618965.html#_label4_1)
  - [ZooKeeper节点属性](https://www.cnblogs.com/qingyunzong/p/8618965.html#_label4_2)
- [ZooKeeper服务中操作](https://www.cnblogs.com/qingyunzong/p/8618965.html#_label5)
- 监听机制
  - [watch触发器](https://www.cnblogs.com/qingyunzong/p/8618965.html#_label6_0)
  - [监听工作原理](https://www.cnblogs.com/qingyunzong/p/8618965.html#_label6_1)
- ZooKeeper应用举例　
  - [分布式锁应用场景](https://www.cnblogs.com/qingyunzong/p/8618965.html#_label7_0)
  - [传统解决方案](https://www.cnblogs.com/qingyunzong/p/8618965.html#_label7_1)
  - [ ZooKeeper解决方案](https://www.cnblogs.com/qingyunzong/p/8618965.html#_label7_2)

 

**正文**

本文引用自 http://www.cnblogs.com/sunddenly/p/4033574.html

[回到顶部](https://www.cnblogs.com/qingyunzong/p/8618965.html#_labelTop)

## 引言

　　Hadoop 集群当中 N 多的配置信息如何做到全局一致并且单点修改迅速响应到整个集群？ --- 配置管理

　　Hadoop 集群中的 namonode 和 resourcemanager 的单点故障怎么解决？ --- 集群的主节点的单点故障

[回到顶部](https://www.cnblogs.com/qingyunzong/p/8618965.html#_labelTop)

## 分布式协调技术

　　在给大家介绍ZooKeeper之前先来给大家介绍一种技术——分布式协调技术。那么什么是分布式协调技术？那么我来告诉大家，其实分布式协调技术 主要用来解决分布式环境当中多个进程之间的同步控制，让他们有序的去访问某种临界资源，防止造成"脏数据"的后果。这时，有人可能会说这个简单，写一个调 度算法就轻松解决了。说这句话的人，可能对分布式系统不是很了解，所以才会出现这种误解。如果这些进程全部是跑在一台机上的话，相对来说确实就好办了，问 题就在于他是在一个分布式的环境下，这时问题又来了，那什么是分布式呢？这个一两句话我也说不清楚，但我给大家画了一张图希望能帮助大家理解这方面的内 容，如果觉得不对尽可拍砖，来咱们看一下这张图，如图1.1所示。

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321183326491-1621444258.png)

　　给大家分析一下这张图，在这图中有三台机器，每台机器各跑一个应用程序。然后我们将这三台机器通过网络将其连接起来，构成一个系统来为用户提供服务，对用户来说这个系统的架构是透明的，他感觉不到我这个系统是一个什么样的架构。那么我们就可以把这种系统称作一个**分布式系统**。

　　那我们接下来再分析一下，在这个分布式系统中如何对进程进行调度，我假设在第一台机器上挂载了一个资源，然后这三个物理分布的进程都要竞争这个资源，但我们又不希望他们同时进行访问，这时候我们就需要一个**协调器**，来让他们有序的来访问这个资源。这个协调器就是我们经常提到的那个**锁**，比如说"进程-1"在使用该资源的时候，会先去获得锁，"进程1"获得锁以后会对该资源保持**独占**，这样其他进程就无法访问该资源，"进程1"用完该资源以后就将锁释放掉，让其他进程来获得锁，那么通过这个锁机制，我们就能保证了分布式系统中多个进程能够有序的访问该临界资源。那么我们把这个分布式环境下的这个锁叫作**分布式锁**。这个分布式锁也就是我们**分布式协调技术**实现的核心内容，那么如何实现这个分布式呢，那就是我们后面要讲的内容。

[回到顶部](https://www.cnblogs.com/qingyunzong/p/8618965.html#_labelTop)

## 分布式锁的实现



### 面临的问题

　　在看了图1.1所示的分布式环境之后，有人可能会感觉这不是很难。无非是将原来在同一台机器上对进程调度的原语，通过网络实现在分布式环境中。是的，表面上是可以这么说。但是问题就在网络这，在分布式系统中，所有在同一台机器上的假设都不存在：因为网络是不可靠的。

　　比如，在同一台机器上，你对一个服务的调用如果成功，那就是成功，如果调用失败，比如抛出异常那就是调用失败。但是在分布式环境中，由于网络的不可靠，你对一个服务的调用失败了并不表示一定是失败的，可能是执行成功了，但是响应返回的时候失败了。还有，A和B都去调用C服务，在时间上 A还先调用一些，B后调用，那么最后的结果是不是一定A的请求就先于B到达呢？ 这些在同一台机器上的种种假设，我们都要重新思考，我们还要思考这些问题给我们的设计和编码带来了哪些影响。还有，在分布式环境中为了提升可靠性，我们往往会部署多套服务，但是如何在多套服务中达到一致性，这在同一台机器上多个进程之间的同步相对来说比较容易办到，但在分布式环境中确实一个大难题。

　　所以分布式协调远比在同一台机器上对多个进程的调度要难得多，而且如果为每一个分布式应用都开发一个独立的协调程序。一方面，协调程序的反复编写浪费，且难以形成通用、伸缩性好的协调器。另一方面，协调程序开销比较大，会影响系统原有的性能。所以，急需一种高可靠、高可用的通用协调机制来用以协调分布式应用。



### 分布式锁的实现者

　　目前，在分布式协调技术方面做得比较好的就是Google的Chubby还有Apache的ZooKeeper他们都是分布式锁的实现者。有人会问既然有了Chubby为什么还要弄一个ZooKeeper，难道Chubby做得不够好吗？不是这样的，主要是Chbby是非开源的，Google自家用。后来雅虎模仿Chubby开发出了ZooKeeper，也实现了类似的分布式锁的功能，并且将ZooKeeper作为一种开源的程序捐献给了Apache，那么这样就可以使用ZooKeeper所提供锁服务。而且在分布式领域久经考验，它的可靠性，可用性都是经过理论和实践的验证的。所以我们在构建一些分布式系统的时候，就可以以这类系统为起点来构建我们的系统，这将节省不少成本，而且bug也 将更少。

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321183640661-941556187.png)

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321183649854-1229808958.png)

[回到顶部](https://www.cnblogs.com/qingyunzong/p/8618965.html#_labelTop)

## ZooKeeper概述

　　ZooKeeper 是一个分布式的，开放源码的分布式应用程序协调服务，是 Google 的 Chubby 一个开源的实现。它提供了简单原始的功能，分布式应用可以基于它实现更高级的服务，比 如**分布式同步，配置管理，集群管理，命名管理，队列管理**。它被设计为易于编程，使用文 件系统目录树作为数据模型。服务端跑在 java 上，提供 java 和 C 的客户端 API 众所周知，协调服务非常容易出错，但是却很难恢复正常，例如，协调服务很容易处于 竞态以至于出现死锁。我们设计 ZooKeeper 的目的是为了减轻分布式应用程序所承担的协 调任务 ZooKeeper 是集群的管理者，监视着集群中各节点的状态，根据节点提交的反馈进行下 一步合理的操作。最终，将简单易用的接口和功能稳定，性能高效的系统提供给用户。

　　前面提到了那么多的服务，比如分布式锁、配置维护、组服务等，那它们是如何实现的呢，我相信这才是大家关心的东西。ZooKeeper在实现这些服务时，首先它设计一种新的**数据结构——Znode**，然后在该数据结构的基础上定义了一些**原语**，也就是一些关于该数据结构的一些操作。有了这些数据结构和原语还不够，因为我们的ZooKeeper是工作在一个分布式的环境下，我们的服务是通过消息以网络的形式发送给我们的分布式应用程序，所以还需要一个**通知机制**——Watcher机制。那么总结一下，ZooKeeper所提供的服务主要是通过：数据结构+原语+watcher机制，三个部分来实现的。那么我就从这三个方面，给大家介绍一下ZooKeeper。

[回到顶部](https://www.cnblogs.com/qingyunzong/p/8618965.html#_labelTop)

## ZooKeeper数据模型



### ZooKeeper数据模型Znode

　　ZooKeeper拥有一个层次的命名空间，这个和标准的文件系统非常相似，如下图所示。

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321184146535-356798741.png)![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321184159174-840503430.png)

　　从图中我们可以看出ZooKeeper的数据模型，在结构上和标准文件系统的非常相似，都是采用这种树形层次结构，ZooKeeper树中的每个节点被称为—Znode。和文件系统的目录树一样，ZooKeeper树中的每个节点可以拥有子节点。但也有不同之处：

**(1) 引用方式**

　　Zonde通过**路径引用**，如同Unix中的文件路径。**路径必须是绝对的，因此他们必须由斜杠字符来开头。**除此以外，他们必须是唯一的，也就是说每一个路径只有一个表示，因此这些路径不能改变。在ZooKeeper中，路径由Unicode字符串组成，并且有一些限制。字符串"/zookeeper"用以保存管理信息，比如关键配额信息。

**(2)** **Znode结构**

　　ZooKeeper命名空间中的**Znode，兼具文件和目录两种特点。既像文件一样维护着数据、元信息、ACL、时间戳等数据结构，又像目录一样可以作为路径标识的一部分。**图中的每个节点称为一个Znode。 每个**Znode由3部分组成**:

　　**①** stat：此为状态信息, 描述该Znode的版本, 权限等信息

　　**②** data：与该Znode关联的数据

　　**③** children：该Znode下的子节点

　　ZooKeeper虽然可以关联一些数据，但并没有被设计为常规的数据库或者大数据存储，相反的是，它用来**管理调度数据**，比如分布式应用中的配置文件信息、状态信息、汇集位置等等。这些数据的共同特性就是它们都是很小的数据，通常以KB为大小单位。ZooKeeper的服务器和客户端都被设计为严格检查并限制每个Znode的数据大小至多1M，但常规使用中应该远小于此值。

**(3) 数据访问**

　　ZooKeeper中的每个节点存储的数据要被**原子性的操作**。也就是说读操作将获取与节点相关的所有数据，写操作也将替换掉节点的所有数据。另外，每一个节点都拥有自己的ACL(访问控制列表)，这个列表规定了用户的权限，即限定了特定用户对目标节点可以执行的操作。

**(4) 节点类型**

　　ZooKeeper中的节点有两种，分别为**临时节点**和**永久节点**。节点的类型在创建时即被确定，并且不能改变。

　　**① 临时节点：**该节点的生命周期依赖于创建它们的会话。一旦会话(Session)结束，临时节点将被自动删除，当然可以也可以手动删除。虽然每个临时的Znode都会绑定到一个客户端会话，但他们对所有的客户端还是可见的。另外，ZooKeeper的临时节点不允许拥有子节点。

　　**② 永久节点：**该节点的生命周期不依赖于会话，并且只有在客户端显示执行删除操作的时候，他们才能被删除。

**(5)** **顺序节点**

　　当创建Znode的时候，用户可以请求在ZooKeeper的路径结尾添加一个**递增的计数**。这个计数**对于此节点的父节点来说**是唯一的，它的格式为"%10d"(10位数字，没有数值的数位用0补充，例如"0000000001")。当计数值大于232-1时，计数器将溢出。

**(6) 观察**

　　客户端可以在节点上设置watch，我们称之为**监视器**。当节点状态发生改变时(Znode的增、删、改)将会触发watch所对应的操作。当watch被触发时，ZooKeeper将会向客户端发送且仅发送一条通知，因为watch只能被触发一次，这样可以减少网络流量。



### ZooKeeper中的时间

致使ZooKeeper节点状态改变的每一个操作都将使节点接收到一个Zxid格式的时间戳，并且这个时间戳全局有序。也就是说，每个对节点的改变都将产生一个唯一的Zxid。如果Zxid1的值小于Zxid2的值，那么Zxid1所对应的事件发生在Zxid2所对应的事件之前。实际上，ZooKeeper的每个节点维护者三个Zxid值，为别为：cZxid、mZxid、pZxid。

**①** **cZxid**： 是节点的创建时间所对应的Zxid格式时间戳。

**② mZxid**：是节点的修改时间所对应的Zxid格式时间戳。

**③ pZxid**： 是与 该节点的子节点（或该节点）的最近一次 创建 / 删除 的时间戳对应

实现中Zxid是一个64为的数字，它高32位是epoch用来标识leader关系是否改变，每次一个leader被选出来，它都会有一个 新的epoch。低32位是个**递增计数**。 **(2) 版本号**

对节点的每一个操作都将致使这个节点的版本号增加。每个节点维护着三个版本号，他们分别为：

**① version**：节点数据版本号
**② cversion**：子节点版本号
**③ aversion**：节点所拥有的ACL版本号



### ZooKeeper节点属性

通过前面的介绍，我们可以了解到，一个节点自身拥有表示其状态的许多重要属性，如下图所示。

图 4.2 Znode节点属性结构

 ![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321185102856-38150331.png)

[回到顶部](https://www.cnblogs.com/qingyunzong/p/8618965.html#_labelTop)

## ZooKeeper服务中操作

在ZooKeeper中有9个基本操作，如下图所示：

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321185148807-650930580.png)

　　更新ZooKeeper操作是有限制的。delete或setData必须明确要更新的Znode的版本号，我们可以调用exists找到。如果版本号不匹配，更新将会失败。

　　更新ZooKeeper操作是非阻塞式的。因此客户端如果失去了一个更新(由于另一个进程在同时更新这个Znode)，他可以在不阻塞其他进程执行的情况下，选择重新尝试或进行其他操作。

　　尽管ZooKeeper可以被看做是一个文件系统，但是处于便利，摒弃了一些文件系统地操作原语。因为文件非常的小并且使整体读写的，所以不需要打开、关闭或是寻地的操作。

[回到顶部](https://www.cnblogs.com/qingyunzong/p/8618965.html#_labelTop)

## 监听机制



### watch触发器

**(1) watch概述**

ZooKeeper可以为所有的**读操作**设置watch，这些读操作包括：exists()、getChildren()及getData()。watch事件是**一次性的触发器**，当watch的对象状态发生改变时，将会触发此对象上watch所对应的事件。watch事件将被**异步**地发送给客户端，并且ZooKeeper为watch机制提供了有序的**一致性保证**。理论上，客户端接收watch事件的时间要快于其看到watch对象状态变化的时间。

**(2) watch类型**

ZooKeeper所管理的watch可以分为两类：

**①** 数据watch(data watches)：**getData**和**exists**负责设置数据watch
**②** 孩子watch(child watches)：**getChildren**负责设置孩子watch

我们可以通过操作**返回的数据**来设置不同的watch：

**① getData和exists：**返回关于节点的数据信息
**② getChildren：**返回孩子列表

因此

**①** 一个成功的**setData操作**将触发Znode的数据watch

**②** 一个成功的**create操作**将触发Znode的数据watch以及孩子watch

**③** 一个成功的**delete操作**将触发Znode的数据watch以及孩子watch

**(3) watch注册与处触发**

下图 watch设置操作及相应的触发器如图下图所示：

 ![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321185250656-1651342915.png)

**①** exists操作上的watch，在被监视的Znode**创建**、**删除**或**数据更新**时被触发。
**②** getData操作上的watch，在被监视的Znode**删除**或**数据更新**时被触发。在被创建时不能被触发，因为只有Znode一定存在，getData操作才会成功。
**③** getChildren操作上的watch，在被监视的Znode的子节点**创建**或**删除**，或是这个Znode自身被**删除**时被触发。可以通过查看watch事件类型来区分是Znode，还是他的子节点被删除：NodeDelete表示Znode被删除，NodeDeletedChanged表示子节点被删除。

Watch由客户端所连接的ZooKeeper服务器在本地维护，因此watch可以非常容易地设置、管理和分派。当客户端连接到一个新的服务器时，任何的会话事件都将可能触发watch。另外，当从服务器断开连接的时候，watch将不会被接收。但是，当一个客户端重新建立连接的时候，任何先前注册过的watch都会被重新注册。

**(4) 需要注意的几点**

**Zookeeper的watch实际上要处理两类事件：**

**① 连接状态事件**(type=None, path=null)

这类事件不需要注册，也不需要我们连续触发，我们只要处理就行了。

**② 节点事件**

节点的建立，删除，数据的修改。它是one time trigger，我们需要不停的注册触发，还可能发生事件丢失的情况。

上面2类事件都在Watch中处理，也就是重载的**process(Event event)**

**节点事件的触发，通过函数exists，getData或getChildren来处理这类函数，有双重作用：**

**① 注册触发事件**

**② 函数本身的功能**

函数的本身的功能又可以用异步的回调函数来实现,重载processResult()过程中处理函数本身的的功能。



### 监听工作原理

ZooKeeper 的 Watcher 机制主要包括**客户端线程、客户端 WatcherManager、Zookeeper 服务器**三部分。客户端在向 ZooKeeper 服务器注册的同时，会将 Watcher 对象存储在客户端的 WatcherManager 当中。当 ZooKeeper 服务器触发 Watcher 事件后，会向客户端发送通知， 客户端线程从 WatcherManager 中取出对应的 Watcher 对象来执行回调逻辑

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180323130005216-2010659721.png)

[回到顶部](https://www.cnblogs.com/qingyunzong/p/8618965.html#_labelTop)

## ZooKeeper应用举例　

　　为了方便大家理解ZooKeeper，在此就给大家举个例子，看看ZooKeeper是如何实现的他的服务的，我以ZooKeeper提供的基本服务**分布式锁**为例。



### 分布式锁应用场景

在分布式锁服务中，有一种最典型应用场景，就是通过对集群进行**Master选举**，来解决分布式系统中的**单点故障**。什么是分布式系统中的单点故障：通常分布式系统采用主从模式，就是一个主控机连接多个处理节点。主节点负责分发任务，从节点负责处理任务，当我们的主节点发生故障时，那么整个系统就都瘫痪了，那么我们把这种故障叫作单点故障。如下图7.1和7.2所示：

　　　　　　　　　　**图 7.1 主从模式分布式系统       　　　　　　　　　　　　　　　图7.2 单点故障**

 ![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321185416310-550971524.png)![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321185441409-1399135850.png)



### 传统解决方案

　　传统方式是采用一个备用节点，这个备用节点定期给当前主节点发送ping包，主节点收到ping包以后向备用节点发送回复Ack，当备用节点收到回复的时候就会认为当前主节点还活着，让他继续提供服务。如图7.3所示：

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321185516404-1937045489.png)

　　当主节点挂了，这时候备用节点收不到回复了，然后他就认为主节点挂了接替他成为主节点如下图7.4所示：

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321185538957-1424549949.png)

但是这种方式就是有一个隐患，就是网络问题，来看一网络问题会造成什么后果，如下图7.5所示：

　　　　　　　　　　　　图 7.5 网络故障

 ![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321185608755-1964949358.png)

 也就是说我们的主节点的并没有挂，只是在回复的时候网络发生故障，这样我们的备用节点同样收不到回复，就会认为主节点挂了，然后备用节点将他的Master实例启动起来，这样我们的分布式系统当中就有了两个主节点也就是---**双Master**，出现Master以后我们的从节点就会将它所做的事一部分汇报给了主节点，一部分汇报给了从节点，这样服务就全乱了。为了防止出现这种情况，我们引入了ZooKeeper，它虽然不能避免网络故障，但它能够保证每时每刻只有一个Master。我么来看一下ZooKeeper是如何实现的。



###  ZooKeeper解决方案

 

**1) Master启动**

在引入了Zookeeper以后我们启动了两个主节点，"主节点-A"和"主节点-B"他们启动以后，都向ZooKeeper去注册一个节点。我们假设"主节点-A"锁注册地节点是"master-00001"，"主节点-B"注册的节点是"master-00002"，注册完以后进行选举，编号最小的节点将在选举中获胜获得锁成为主节点，也就是我们的"主节点-A"将会获得锁成为主节点，然后"主节点-B"将被阻塞成为一个备用节点。那么，通过这种方式就完成了对两个Master进程的调度。

　　　　　　　　　　　　　　图7.6 ZooKeeper Master选举

![img](https://images0.cnblogs.com/blog/671563/201411/301535008567950.png)

**(2) Master故障**

如果"主节点-A"挂了，这时候他所注册的节点将被自动删除，ZooKeeper会自动感知节点的变化，然后再次发出选举，这时候"主节点-B"将在选举中获胜，替代"主节点-A"成为主节点。

　　　　　　　　　　　　　　　　图7.7 ZooKeeper Master选举

![img](https://images0.cnblogs.com/blog/671563/201411/301535012773122.png)

**(3) Master 恢复**

　　　　　　　　　　　　　　图7.8 ZooKeeper Master选举

![img](https://images0.cnblogs.com/blog/671563/201411/301535016997293.png)

如果主节点恢复了，他会再次向ZooKeeper注册一个节点，这时候他注册的节点将会是"master-00003"，ZooKeeper会感知节点的变化再次发动选举，这时候"主节点-B"在选举中会再次获胜继续担任"主节点"，"主节点-A"会担任备用节点。



## ZooKeeper 软件安装须知

鉴于 ZooKeeper 本身的特点，服务器集群的节点数推荐设置为奇数台。我这里我规划为三台， 为别为 hadoop1,hadoop2,hadoop3

[回到顶部](https://www.cnblogs.com/qingyunzong/p/8619184.html#_labelTop)

## ZooKeeper 的集群安装



### ZooKeeper 的下载

下载地址：http://mirrors.hust.edu.cn/apache/ZooKeeper/

此处使用的是3.4.10版本



### 解压安装到自己的目录

```
[hadoop@hadoop1 ~]$ tar -zxvf zookeeper-3.4.10.tar.gz -C apps/
```

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321191339360-1714821050.png)

ZooKeeper 运行最重要的四个东西



### 修改配置文件

```
[hadoop@hadoop1 zookeeper-3.4.10]$ cd conf/
[hadoop@hadoop1 conf]$ mv zoo_sample.cfg zoo.cfg
[hadoop@hadoop1 conf]$ vi zoo.cfg 
```

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321193822614-1308390878.png)

#### **基本配置**

**tickTime**

心跳基本时间单位，毫秒级，ZK基本上所有的时间都是这个时间的整数倍。

**initLimit**

tickTime的个数，表示在leader选举结束后，followers与leader同步需要的时间，如果followers比较多或者说leader的数据灰常多时，同步时间相应可能会增加，那么这个值也需要相应增加。当然，这个值也是follower和observer在开始同步leader的数据时的最大等待时间(setSoTimeout)

**syncLimit**

tickTime的个数，这时间容易和上面的时间混淆，它也表示follower和observer与leader交互时的最大等待时间，只不过是在与leader同步完毕之后，进入正常请求转发或ping等消息交互时的超时时间。

**dataDir**

内存数据库快照存放地址，如果没有指定事务日志存放地址(dataLogDir)，默认也是存放在这个路径下，建议两个地址分开存放到不同的设备上。

**clientPort**

配置ZK监听客户端连接的端口

在配置文件末尾添加

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321192901178-1927079508.png)

**server.serverid=host:tickpot:electionport**

server：固定写法
serverid：每个服务器的指定ID（必须处于1-255之间，必须每一台机器不能重复）
host：主机名
tickpot：心跳通信端口
electionport：选举端口

#### 高级配置

**dataLogDir**

将事务日志存储在该路径下，比较重要，这个日志存储的设备效率会影响ZK的写吞吐量。

globalOutstandingLimit

(Java system property: zookeeper.globalOutstandingLimit)默认值是1000，限定了所有连接到服务器上但是还没有返回响应的请求个数(所有客户端请求的总数，不是连接总数)，这个参数是针对单台服务器而言，设定太大可能会导致内存溢出。

preAllocSize

(Java system property: zookeeper.preAllocSize)默认值64M，以KB为单位,预先分配额定空间用于后续transactionlog 写入，每当剩余空间小于4K时，就会又分配64M，如此循环。如果SNAP做得比较频繁(snapCount比较小的时候)，那么请减少这个值。

snapCount

(Java system property: zookeeper.snapCount)默认值100,000，当transaction每达到snapCount/2+rand.nextInt(snapCount/2)时，就做一次SNAPSHOT,默认情况下是50,000~100,000条transactionlog就会做一次，之所以用随机数是为了避免所有服务器可能在同一时间做snapshot.

traceFile (Java system property: requestTraceFile)

**maxClientCnxns**

**默认值是10，一个客户端能够连接到同一个服务器上的最大连接数，根据IP来区分。如果设置为0，表示没有任何限制。设置该值一方面是为了防止DoS攻击。**

clientPortAddress

与clientPort匹配，表示某个IP地址，如果服务器有多个网络接口(多个IP地址),如果没有设置这个属性，则clientPort会绑定到所有IP地址上，否则只绑定到该设置的IP地址上。

minSessionTimeout

最小的session time时间，默认值是2个tick time,客户端设置的session time 如果小于这个值，则会被强制协调为这个最小值。

maxSessionTimeout

最大的session time 时间，默认值是20个tick time. ,客户端设置的session time 如果大于这个值，则会被强制协调为这个最大值。

#### 集群配置选项

electionAlg

领导选举算法，默认是3(fast leader election，基于TCP)，0表示leader选举算法(基于UDP)，1表示非授权快速选举算法(基于UDP)，2表示授权快速选举算法(基于UDP),目前1和2算法都没有应用，不建议使用，0算法未来也可能会被干掉，只保留3(fast leader election)算法，因此最好直接使用默认就好。

initLimit

tickTime的个数，表示在leader选举结束后，followers与leader同步需要的时间，如果followers比较多或者说leader的数据灰常多时，同步时间相应可能会增加，那么这个值也需要相应增加。当然，这个值也是follower和observer在开始同步leader的数据时的最大等待时间(setSoTimeout)

syncLimit

tickTime的个数，这时间容易和上面的时间混淆，它也表示follower和observer与leader交互时的最大等待时间，只不过是在与leader同步完毕之后，进入正常请求转发或ping等消息交互时的超时时间。

leaderServes

(Java system property: zookeeper.leaderServes)  如果该值不是no，则表示该服务器作为leader时是需要接受客户端连接的。为了获得更高吞吐量，当服务器数三台以上时一般建议设置为no。

cnxTimeout 

(Java system property: zookeeper.cnxTimeout) 默认值是5000,单位ms 表示leaderelection时打开连接的超时时间，只用在算法3中。

#### **ZK的不安全配置项**

skipACL

(Java systemproperty: zookeeper.skipACL) 默认值是no,忽略所有ACL检查，相当于开放了所有数据权限给任何人。

forceSync

(Java systemproperty: zookeeper.forceSync) 默认值是yes, 表示transactionlog在commit时是否立即写到磁盘上，如果关闭这个选项可能会在断电时丢失信息。

jute.maxbuffer

(Java system property: jute.maxbuffer)默认值0xfffff，单位是KB，表示节点数据最多1M。如果要设置这个值，必须要在所有服务器上都需要设置。

授权认证配置项

DigestAuthenticationProvider.superDigest

(Java system property only: zookeeper.DigestAuthenticationProvider.superDigest)  设置这个值是为了确定一个超级用户，它的值格式为

super:<base64encoded(SHA1(idpassword))> ，一旦当前连接addAuthInfo超级用户验证通过，后续所有操作都不会checkACL.



### 将配置文件分发到集群其他机器中

```
[hadoop@hadoop1 apps]$ scp -r zookeeper-3.4.10/ hadoop2:$PWD
[hadoop@hadoop1 apps]$ scp -r zookeeper-3.4.10/ hadoop3:$PWD
```

然后是最重要的步骤，一定不能忘了。 去你的各个 ZooKeeper 服务器节点，新建目录 dataDir=/home/hadoop/data/zkdata，这个 目录就是你在 zoo.cfg 中配置的 dataDir 的目录，建好之后，在里面新建一个文件，文件 名叫 myid,里面存放的内容就是服务器的 id,就是 server.1=hadoop01:2888:3888 当中的 id, 就是 1，那么对应的每个服务器节点都应该做类似的操作 拿服务器 hadoop1 举例：

```
[hadoop@hadoop1 ~]$ mkdir /home/hadoop/data/zkdata
[hadoop@hadoop1 ~]$ cd data/zkdata/
[hadoop@hadoop1 zkdata]$ echo 1 > myid
```

当以上所有步骤都完成时，意味着我们 ZooKeeper 的配置文件相关的修改都做完了。



### 配置环境变量

```
[hadoop@hadoop1 ~]$ vi .bashrc 
#Zookeeper
export ZOOKEEPER_HOME=/home/hadoop/apps/zookeeper-3.4.10
export PATH=$PATH:$ZOOKEEPER_HOME/bin
```

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321194127450-1457537206.png)

保存退出

```
[hadoop@hadoop1 ~]$ source .bash
```

[回到顶部](https://www.cnblogs.com/qingyunzong/p/8619184.html#_labelTop)

## 启动软件，并验证安装是否成功

命令

启动：zkServer.sh start
停止：zkServer.sh stop
查看状态：zkServer.sh status

**注意：虽然我们在配置文件中写明了服务器的列表信息，但是，我们还是需要去每一台服务 器去启动，不是一键启动集群模式**

每启动一台查看一下状态再启动下一台

#### 启动hadoop1

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
[hadoop@hadoop1 ~]$ zkServer.sh start
ZooKeeper JMX enabled by default
Using config: /home/hadoop/apps/zookeeper-3.4.10/bin/../conf/zoo.cfg
Starting zookeeper ... STARTED
[hadoop@hadoop1 ~]$ zkServer.sh status
ZooKeeper JMX enabled by default
Using config: /home/hadoop/apps/zookeeper-3.4.10/bin/../conf/zoo.cfg
Error contacting service. It is probably not running.
[hadoop@hadoop1 ~]$ 
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

#### 启动hadoop2

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
[hadoop@hadoop2 ~]$ zkServer.sh start
ZooKeeper JMX enabled by default
Using config: /home/hadoop/apps/zookeeper-3.4.10/bin/../conf/zoo.cfg
Starting zookeeper ... STARTED
[hadoop@hadoop2 ~]$ zkServer.sh status
ZooKeeper JMX enabled by default
Using config: /home/hadoop/apps/zookeeper-3.4.10/bin/../conf/zoo.cfg
Mode: leader
[hadoop@hadoop2 ~]$ 
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321194857733-1063430189.png)

此时在查看hadoop1的状态

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321194820580-2029878677.png)

#### 启动hadoop3

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
[hadoop@hadoop3 ~]$ zkServer.sh start
ZooKeeper JMX enabled by default
Using config: /home/hadoop/apps/zookeeper-3.4.10/bin/../conf/zoo.cfg
Starting zookeeper ... STARTED
[hadoop@hadoop3 ~]$ zkServer.sh status
ZooKeeper JMX enabled by default
Using config: /home/hadoop/apps/zookeeper-3.4.10/bin/../conf/zoo.cfg
Mode: follower
[hadoop@hadoop3 ~]$ 
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321195002508-939618781.png)



### 查看进程

3台机器上都有**QuorumPeerMain进程**

```
[hadoop@hadoop1 ~]$ jps
2499 Jps
2404 QuorumPeerMain
[hadoop@hadoop1 ~]$ 
```

## Zookeeper的shell操作



### Zookeeper命令工具

在启动Zookeeper服务之后，输入以下命令，连接到Zookeeper服务：

```
[hadoop@hadoop1 ~]$ zkCli.sh -server hadoop2:2181
```

![img](https://images.cnblogs.com/OutliningIndicators/ExpandedBlockStart.gif)

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1 [hadoop@hadoop1 ~]$ zkCli.sh -server hadoop2:2181
 2 Connecting to hadoop2:2181
 3 2018-03-21 19:55:53,744 [myid:] - INFO  [main:Environment@100] - Client environment:zookeeper.version=3.4.10-39d3a4f269333c922ed3db283be479f9deacaa0f, built on 03/23/2017 10:13 GMT
 4 2018-03-21 19:55:53,748 [myid:] - INFO  [main:Environment@100] - Client environment:host.name=hadoop1
 5 2018-03-21 19:55:53,749 [myid:] - INFO  [main:Environment@100] - Client environment:java.version=1.8.0_73
 6 2018-03-21 19:55:53,751 [myid:] - INFO  [main:Environment@100] - Client environment:java.vendor=Oracle Corporation
 7 2018-03-21 19:55:53,751 [myid:] - INFO  [main:Environment@100] - Client environment:java.home=/usr/local/jdk1.8.0_73/jre
 8 2018-03-21 19:55:53,751 [myid:] - INFO  [main:Environment@100] - Client environment:java.class.path=/home/hadoop/apps/zookeeper-3.4.10/bin/../build/classes:/home/hadoop/apps/zookeeper-3.4.10/bin/../build/lib/*.jar:/home/hadoop/apps/zookeeper-3.4.10/bin/../lib/slf4j-log4j12-1.6.1.jar:/home/hadoop/apps/zookeeper-3.4.10/bin/../lib/slf4j-api-1.6.1.jar:/home/hadoop/apps/zookeeper-3.4.10/bin/../lib/netty-3.10.5.Final.jar:/home/hadoop/apps/zookeeper-3.4.10/bin/../lib/log4j-1.2.16.jar:/home/hadoop/apps/zookeeper-3.4.10/bin/../lib/jline-0.9.94.jar:/home/hadoop/apps/zookeeper-3.4.10/bin/../zookeeper-3.4.10.jar:/home/hadoop/apps/zookeeper-3.4.10/bin/../src/java/lib/*.jar:/home/hadoop/apps/zookeeper-3.4.10/bin/../conf::/usr/local/jdk1.8.0_73/lib:/usr/local/jdk1.8.0_73/jre/lib
 9 2018-03-21 19:55:53,751 [myid:] - INFO  [main:Environment@100] - Client environment:java.library.path=/usr/java/packages/lib/amd64:/usr/lib64:/lib64:/lib:/usr/lib
10 2018-03-21 19:55:53,751 [myid:] - INFO  [main:Environment@100] - Client environment:java.io.tmpdir=/tmp
11 2018-03-21 19:55:53,751 [myid:] - INFO  [main:Environment@100] - Client environment:java.compiler=<NA>
12 2018-03-21 19:55:53,752 [myid:] - INFO  [main:Environment@100] - Client environment:os.name=Linux
13 2018-03-21 19:55:53,752 [myid:] - INFO  [main:Environment@100] - Client environment:os.arch=amd64
14 2018-03-21 19:55:53,752 [myid:] - INFO  [main:Environment@100] - Client environment:os.version=2.6.32-573.el6.x86_64
15 2018-03-21 19:55:53,752 [myid:] - INFO  [main:Environment@100] - Client environment:user.name=hadoop
16 2018-03-21 19:55:53,752 [myid:] - INFO  [main:Environment@100] - Client environment:user.home=/home/hadoop
17 2018-03-21 19:55:53,752 [myid:] - INFO  [main:Environment@100] - Client environment:user.dir=/home/hadoop
18 2018-03-21 19:55:53,755 [myid:] - INFO  [main:ZooKeeper@438] - Initiating client connection, connectString=hadoop2:2181 sessionTimeout=30000 watcher=org.apache.zookeeper.ZooKeeperMain$MyWatcher@5c29bfd
19 Welcome to ZooKeeper!
20 2018-03-21 19:55:53,789 [myid:] - INFO  [main-SendThread(hadoop2:2181):ClientCnxn$SendThread@1032] - Opening socket connection to server hadoop2/192.168.123.103:2181. Will not attempt to authenticate using SASL (unknown error)
21 JLine support is enabled
22 2018-03-21 19:55:53,931 [myid:] - INFO  [main-SendThread(hadoop2:2181):ClientCnxn$SendThread@876] - Socket connection established to hadoop2/192.168.123.103:2181, initiating session
23 2018-03-21 19:55:53,977 [myid:] - INFO  [main-SendThread(hadoop2:2181):ClientCnxn$SendThread@1299] - Session establishment complete on server hadoop2/192.168.123.103:2181, sessionid = 0x262486284b70000, negotiated timeout = 30000
24 
25 WATCHER::
26 
27 WatchedEvent state:SyncConnected type:None path:null
28 [zk: hadoop2:2181(CONNECTED) 0] 
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

连接成功之后，系统会输出Zookeeper的相关环境及配置信息，并在屏幕输出“welcome to Zookeeper！”等信息。

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321195759304-642290839.png)

输入help之后，屏幕会输出可用的Zookeeper命令，如下图所示

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180321195909767-971823545.png)



### 使用Zookeeper命令的简单操作步骤

(1) 使用ls命令查看当前Zookeeper中所包含的内容：ls /

```
[zk: hadoop2:2181(CONNECTED) 1] ls /
[zookeeper]
[zk: hadoop2:2181(CONNECTED) 2] 
```

(2) 创建一个新的Znode节点"aa"，以及和它相关字符，执行命令：create /aa "my first zk"，默认是不带编号的

```
[zk: hadoop2:2181(CONNECTED) 2] create /aa "my first zk"
Created /aa
[zk: hadoop2:2181(CONNECTED) 3] 
```

　　创建带编号的持久性节点"bb"，

```
[zk: localhost:2181(CONNECTED) 1] create -s /bb "bb"
Created /bb0000000001
[zk: localhost:2181(CONNECTED) 2] 
```

　　创建不带编号的临时节点"cc"

```
[zk: localhost:2181(CONNECTED) 2] create -e /cc "cc"
Created /cc
[zk: localhost:2181(CONNECTED) 3] 
```

 

　　创建带编号的临时节点"dd"

```
[zk: localhost:2181(CONNECTED) 3] create -s -e /dd "dd"
Created /dd0000000003
[zk: localhost:2181(CONNECTED) 4] 
```

(3) 再次使用ls命令来查看现在Zookeeper的中所包含的内容：ls /

[zk: localhost:2181(CONNECTED) 4] ls /
[cc, dd0000000003, zookeeper, bb0000000001]
[zk: localhost:2181(CONNECTED) 5]

此时看到，aa节点已经被创建。 

关闭本次连接回话session，再重新打开一个连接

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
[zk: localhost:2181(CONNECTED) 5] close
2018-03-22 13:03:29,137 [myid:] - INFO  [main:ZooKeeper@684] - Session: 0x1624c10e8d90000 closed
[zk: localhost:2181(CLOSED) 6] 2018-03-22 13:03:29,139 [myid:] - INFO  [main-EventThread:ClientCnxn$EventThread@519] - EventThread shut down for session: 0x1624c10e8d90000

[zk: localhost:2181(CLOSED) 6] ls /
Not connected
[zk: localhost:2181(CLOSED) 7] connect hadoop1:2181
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

重新查看，临时节点已经随着上一次的会话关闭自动删除了

```
[zk: hadoop1:2181(CONNECTED) 8] ls /
[zookeeper, bb0000000001]
[zk: hadoop1:2181(CONNECTED) 9] 
```

(4) 使用get命令来确认第二步中所创建的Znode是否包含我们创建的字符串，执行命令：get /aa

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
[zk: hadoop2:2181(CONNECTED) 4] get /aa
my first zk
cZxid = 0x100000002
ctime = Wed Mar 21 20:01:02 CST 2018
mZxid = 0x100000002
mtime = Wed Mar 21 20:01:02 CST 2018
pZxid = 0x100000002
cversion = 0
dataVersion = 0
aclVersion = 0
ephemeralOwner = 0x0
dataLength = 11
numChildren = 0
[zk: hadoop2:2181(CONNECTED) 5] 
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

(5) 接下来通过set命令来对zk所关联的字符串进行设置，执行命令：set /aa haha123

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
[zk: hadoop2:2181(CONNECTED) 6] set /aa haha123 
cZxid = 0x100000002
ctime = Wed Mar 21 20:01:02 CST 2018
mZxid = 0x100000004
mtime = Wed Mar 21 20:04:10 CST 2018
pZxid = 0x100000002
cversion = 0
dataVersion = 1
aclVersion = 0
ephemeralOwner = 0x0
dataLength = 7
numChildren = 0
[zk: hadoop2:2181(CONNECTED) 7] 
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

(6) 再次使用get命令来查看，上次修改的内容，执行命令：get /aa

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
[zk: hadoop2:2181(CONNECTED) 7] get /aa
haha123
cZxid = 0x100000002
ctime = Wed Mar 21 20:01:02 CST 2018
mZxid = 0x100000004
mtime = Wed Mar 21 20:04:10 CST 2018
pZxid = 0x100000002
cversion = 0
dataVersion = 1
aclVersion = 0
ephemeralOwner = 0x0
dataLength = 7
numChildren = 0
[zk: hadoop2:2181(CONNECTED) 8] 
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

(7) 下面我们将刚才创建的Znode删除，执行命令：delete /aa

```
[zk: hadoop2:2181(CONNECTED) 8] delete /aa
[zk: hadoop2:2181(CONNECTED) 9] 
```

(8) 最后再次使用ls命令查看Zookeeper中的内容，执行命令：ls /

```
[zk: hadoop2:2181(CONNECTED) 9] ls /
[zookeeper]
[zk: hadoop2:2181(CONNECTED) 10] 
```

经过验证，zk节点已经删除。

(9) 退出，执行命令：quit

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
[zk: hadoop2:2181(CONNECTED) 10] quit
Quitting...
2018-03-21 20:07:11,133 [myid:] - INFO  [main:ZooKeeper@684] - Session: 0x262486284b70000 closed
2018-03-21 20:07:11,139 [myid:] - INFO  [main-EventThread:ClientCnxn$EventThread@519] - EventThread shut down for session: 0x262486284b70000
[hadoop@hadoop1 ~]$ 
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)



### 状态信息

查看一个文件的状态信息

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
[zk: localhost:2181(CONNECTED) 1] stat /a
cZxid = 0x200000009
ctime = Thu Mar 22 13:07:19 CST 2018
mZxid = 0x200000009
mtime = Thu Mar 22 13:07:19 CST 2018
pZxid = 0x200000009
cversion = 0
dataVersion = 0
aclVersion = 0
ephemeralOwner = 0x0
dataLength = 1
numChildren = 0
[zk: localhost:2181(CONNECTED) 2] 
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

详细解释：

zxid： 一个事务编号，zookeeper集群内部的所有事务，都有一个全局的唯一的顺序的编号

　　它由两部分组成： 就是一个 64位的长整型 long

　　**高32位: 用来标识leader关系是否改变，如  0x2**　　

 

　　**低32位： 用来做当前这个leader领导期间的全局的递增的事务编号，如  00000009**

 

| **状态属性**   | **说明**                                                     |
| -------------- | ------------------------------------------------------------ |
| cZxid          | 数据节点创建时的事务ID                                       |
| ctime          | 数据节点创建时的时间                                         |
| mZxid          | 数据节点最后一次更新时的事务ID                               |
| mtime          | 数据节点最后一次更新时的时间                                 |
| pZxid          | 数据节点的子节点列表最后一次被修改（是子节点列表变更，而不是子节点内容变更）时的事务ID |
| cversion       | 子节点的版本号                                               |
| dataVersion    | 数据节点的版本号                                             |
| aclVersion     | 数据节点的ACL版本号                                          |
| ephemeralOwner | 如果节点是临时节点，则表示创建该节点的会话的SessionID；如果节点是持久节点，则该属性值为0 |
| dataLength     | 数据内容的长度                                               |
| numChildren    | 数据节点当前的子节点个数                                     |

 

 

 

 

 

 

 

 

（1）修改节点a的数据，**mZxid、****dataVersion、****dataLength 存储信息发生变化**

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
[zk: localhost:2181(CONNECTED) 2] set /a 'aaa'
cZxid = 0x200000009
ctime = Thu Mar 22 13:07:19 CST 2018
mZxid = 0x20000000a
mtime = Thu Mar 22 13:12:53 CST 2018
pZxid = 0x200000009
cversion = 0
dataVersion = 1
aclVersion = 0
ephemeralOwner = 0x0
dataLength = 3
numChildren = 0
[zk: localhost:2181(CONNECTED) 3] 
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

（2）创建新的节点b，状态信息都会发生变化，zxid的事物ID也会增加

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
[zk: localhost:2181(CONNECTED) 5] stat /b
cZxid = 0x20000000b
ctime = Thu Mar 22 13:15:56 CST 2018
mZxid = 0x20000000b
mtime = Thu Mar 22 13:15:56 CST 2018
pZxid = 0x20000000b
cversion = 0
dataVersion = 0
aclVersion = 0
ephemeralOwner = 0x0
dataLength = 1
numChildren = 0
[zk: localhost:2181(CONNECTED) 6]  
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

（3）在a节点下面新增节点c，**pZxid、****cversion、****numChildren 发生改变**

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
[zk: localhost:2181(CONNECTED) 6] create /a/c 'c'
Created /a/c
[zk: localhost:2181(CONNECTED) 7] stat /a
cZxid = 0x200000009
ctime = Thu Mar 22 13:07:19 CST 2018
mZxid = 0x20000000a
mtime = Thu Mar 22 13:12:53 CST 2018
pZxid = 0x20000000c
cversion = 1
dataVersion = 1
aclVersion = 0
ephemeralOwner = 0x0
dataLength = 3
numChildren = 1
[zk: localhost:2181(CONNECTED) 8] 
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

（4）ephemeralOwner 持久性的节点信息是0x0临时的几点信息是本次会话的sessionid，如图

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180322132219641-524856760.png)

(5) 将leader干掉，此时第二台机器成为leader，重新创建一个文件y，此时发现czxid的前3位和之前发生变化，说明换了leader

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180322132450294-640720361.png)

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180322132507158-644407845.png)

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
[zk: localhost:2181(CONNECTED) 0] create /y 'yy'
Created /y
[zk: localhost:2181(CONNECTED) 2] stat /y
cZxid = 0x300000003
ctime = Thu Mar 22 13:25:51 CST 2018
mZxid = 0x300000003
mtime = Thu Mar 22 13:25:51 CST 2018
pZxid = 0x300000003
cversion = 0
dataVersion = 0
aclVersion = 0
ephemeralOwner = 0x0
dataLength = 2
numChildren = 0
[zk: localhost:2181(CONNECTED) 3] 
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 一、eclipse中配置zookeeper开发环境

1）将zookeeper eclipse plugin中的6个jar包放到eclipse安装目录下的plugins文件中，重启eclipse

 ![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180322134811169-1401065425.png)

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180322134727825-938906620.png)

(2) 在 Eclipse 菜单打开Window->Show View->Other…->ZooKeeper 3.2.2。

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180322135049202-1710241397.png)

(3) 点击下图中的按钮进行zookeeper连接的相关配置

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180322135207208-917249171.png)

（4）填写连接名，根路径，超时时间，服务器的地址以及端口

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180322135426384-165658384.png)

（5）连接成功之后可以看到zookeeper文件系统的目录树结构

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180322135616018-718106068.png)

（6）点击一个文件可以在右边看到文件里面的信息，子节点、权限控制、状态等信息。

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180322135733846-195222883.png)

[回到顶部](https://www.cnblogs.com/qingyunzong/p/8623309.html#_labelTop)

##  二、新建java项目，导入zookeeper相关jar包

新建一个java项目，起名为zookeeper-test[
](http://www.cnblogs.com/qingyunzong/p/8623309.html)

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180322140145087-1676849836.png)

新建zookeeper项目的jar包引用

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180322140255787-752932652.png)

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180322140316201-1799992171.png)

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180322140335375-115339854.png)

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180322140414559-250679732.png)

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180322140458273-1470021066.png)

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180322140531237-2008388955.png)

导入zookeeper安装包下的jar包和lib目录下的依赖jar包

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180322141016711-1163726937.png)

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180322141128474-1643461579.png)

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180322141154420-224288217.png)

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180322141224272-1380554055.png)

zookeeper文件系统的增删改查

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
public class ZKDemo1 {
    
    private static final String CONNECT_STRING = "hadoop1:2181,hadoop2:2181,hadoop3:2181";
    //如果zookeeper使用的是默认端口的话，此处可以省略端口号
    //private static final String CONNECT_STRING = "hadoop1,hadoop2,hadoop3";
    
    //设置超时时间
    private static final int SESSION_TIMEOUT = 5000;
    
    public static void main(String[] args) throws Exception {
        //获取zookeeper的连接
        //没有配置监听的话，最后一个参数设为null
        ZooKeeper zk = new ZooKeeper(CONNECT_STRING, SESSION_TIMEOUT, null);
        
        
        
        //创建一个节点
        /**
         * 四个参数path, data, acl, createMode
         * path:创建节点的绝对路径
         * data：节点存储的数据
         * acl:权限控制
         * createMode：节点的类型----永久、临时    有编号的、没有编号的
         * 
         * */
        //String create = zk.create("/xx", "xx".getBytes(), Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT_SEQUENTIAL);
        //System.out.println(create);//输出的结果是：/xx0000000008
        
        /**
         * 判断节点是否存在
         * */
        Stat exists = zk.exists("/xx0000000008", null);
        if(exists == null) {
            System.out.println("节点不存在");
        }else {
            System.out.println("节点存在");
        }
        
        
        /**
         * 查看节点的数据
         * 
         * */
        /*byte[] data = zk.getData("/xx0000000008", false, null);
        System.out.println(new String(data));*/
        
        
        /**
         * 修改节点的数据
         * */
        /*Stat setData = zk.setData("/xx0000000008", "xyz".getBytes(), -1);
        if(setData == null) {
            System.out.println("节点不存在 --- 修改不成功");
        }else {
            System.out.println("节点存在 --- 修改成功");
        }*/
        
        
        /**
         * 删除节点
         * */
        
        /*zk.delete("/xx0000000008", -1);*/
        
        
        
        
        //关闭zookeeper的连接
        zk.close();
    }

}
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

监听设置

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1 public class ZKDemo2 {
 2     
 3     private static final String CONNECT_STRING = "hadoop1,hadoop2,hadoop3";
 4     private static final int SESSION_TIMEOUT = 5000;
 5     
 6     public static void main(String[] args) throws Exception {
 7 
 8         // 获取连接
 9         // 当前的这个匿名内部类不是已经添加好的监听， 以后只要是当前这个zk对象添加了任何的监听器响应了之后，都会调用这个process方法
10         ZooKeeper zk = new ZooKeeper(CONNECT_STRING, SESSION_TIMEOUT, new Watcher() {
11             
12             @Override
13             public void process(WatchedEvent event) {
14                 
15                 System.out.println("1111111111111111111111");
16                 KeeperState state = event.getState();
17                 String path = event.getPath();
18                 EventType type = event.getType();
19                 
20                 System.out.println(state+"\t"+path+"\t"+type);
21             }
22         });
23         
24         System.out.println("2222222222222222222222");
25         
26         /**
27          * 注册监听
28          * 第二个参数有三种传法：
29          * 
30          * 1、false, 表示不使用监听器
31          * 
32          * 2、watcher对象， 表示当前的这次监听如果响应不了的话，就会回调当前这个watcher的process方法
33          * 
34          * 3、true,  表示如果当前的会话/zk 所注册或者添加的所有的监听器的响应，都会会调用 获取连接时  初始化的 监听器对象中 的 process 方法
35          */
36         zk.getData("/a/c", true, null);
37         
38         System.out.println("3333333333333333333333333333");
39         Thread.sleep(5000);
40         
41         zk.setData("/a/c", "hehe666".getBytes(), -1);
42         
43         System.out.println("4444444444444444444444444444");
44         
45         zk.close();
46         
47         
48         
49     }
50 
51 }
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

输出结果

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
2222222222222222222222
1111111111111111111111
SyncConnected    null    None
3333333333333333333333333333
1111111111111111111111
SyncConnected    /a/c    NodeDataChanged
4444444444444444444444444444
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

## 编程思维训练

1、级联查看某节点下所有节点及节点值
2、删除一个节点，不管有有没有任何子节点
3、级联创建任意节点
4、清空子节点

ZKTest.java

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1 public class ZKTest {
 2 
 3     private static final String CONNECT_STRING = "hadoop1,hadoop2,hadoop3";
 4     private static final int SESSION_TIMEOUT = 5000;
 5     private static ZooKeeper zk = null;
 6 
 7     public static void main(String[] args) throws Exception {
 8         zk = new ZooKeeper(CONNECT_STRING, SESSION_TIMEOUT, null);
 9         
10         //1、级联查看某节点下所有节点及节点值 
11         /*Map<String, String> map = new HashMap<>();
12         Map<String, String> maps = ZKUtil.getChildNodeAndValue("/a",zk,map);
13         maps.forEach((key, value) -> System.out.println(key + "\t" + value));*/
14         
15         //2、删除一个节点，不管有有没有任何子节点 
16         /*boolean flag = ZKUtil.rmr("/x", zk);
17         if(flag) {
18             System.out.println("删除成功！");
19         }else {
20             System.out.println("删除失败");
21         }*/
22         
23         
24         //3、级联创建任意节点 
25         /*boolean createZNode = ZKUtil.createZNode("/x/y/z/bb", "bb", zk);
26         if(createZNode) {
27             System.out.println("创建成功！");
28         }else {
29             System.out.println("创建失败");
30         }*/
31         
32         
33         //4、清空子节点
34         boolean clearChildNode = ZKUtil.clearChildNode("/x", zk);
35         if(clearChildNode) {
36             System.out.println("删除成功！");
37         }else {
38             System.out.println("删除失败");
39         }
40         
41     
42         zk.close();
43     }
44 
45     
46 }
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

ZKUtil.java

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
  1 public class ZKUtil {
  2     
  3     private ZooKeeper zk;
  4     
  5     public ZKUtil() {}
  6 
  7     public ZooKeeper getZk() {
  8         return zk;
  9     }
 10 
 11     public void setZk(ZooKeeper zk) {
 12         this.zk = zk;
 13     }
 14 
 15     /**
 16      * 级联查看某节点下所有节点及节点值
 17      * @throws Exception 
 18      * @throws KeeperException 
 19      */
 20     public static Map<String, String> getChildNodeAndValue(String path,ZooKeeper zk,Map<String, String> map) throws Exception{
 21         
 22         //看看传入的节点是否存在
 23         if (zk.exists(path, false) != null) {
 24             //存在的话将该节点的数据存放到map中，key是绝对路径，value是存放的数据
 25             map.put(path, new String(zk.getData(path, false, null)));
 26             //查看该节点下是否还有子节点
 27             List<String> list = zk.getChildren(path, false);
 28             if (list.size() != 0) {
 29                 //遍历子节点,递归调用自身的方法
 30                 for (String child : list) {
 31                     getChildNodeAndValue( path + "/" + child,zk,map);
 32                 }
 33             }
 34         }
 35         
 36         return map;
 37     }
 38 
 39     /**
 40      * 删除一个节点，不管有有没有任何子节点
 41      */
 42     public static boolean rmr(String path, ZooKeeper zk) throws Exception {
 43         //看看传入的节点是否存在
 44         if((zk.exists(path, false)) != null) {
 45             //查看该节点下是否还有子节点
 46             List<String> children = zk.getChildren(path, false);
 47             //如果没有子节点，直接删除当前节点
 48             if(children.size() == 0) {
 49                 zk.delete(path, -1);
 50             }else {
 51                 //如果有子节点，则先遍历删除子节点
 52                 for(String child : children) {
 53                     rmr(path+"/"+child,zk);
 54                 }
 55                 //删除子节点之后再删除之前子节点的父节点
 56                 rmr(path,zk);
 57             }
 58             return true;
 59         }else {
 60             //如果传入的路径不存在直接返回不存在
 61             System.out.println(path+" not exist");
 62             return false;
 63         }
 64         
 65         
 66     
 67     }
 68 
 69     /**
 70      * 级联创建任意节点
 71      * create znodePath data
 72      * create /a/b/c/xx 'xx'
 73      * @throws Exception 
 74      * @throws KeeperException 
 75      
 76      */
 77     public static boolean createZNode(String znodePath, String data, ZooKeeper zk) throws Exception{
 78         
 79         //看看要创建的节点是否存在
 80         if((zk.exists(znodePath, false)) != null) {
 81             return false;
 82         }else {        
 83             //获取父路径
 84             String parentPath = znodePath.substring(0, znodePath.lastIndexOf("/"));
 85             //如果父路径的长度大于0，则先创建父路径，再创建子路径
 86             if(parentPath.length() > 0) {
 87                 createZNode(parentPath, data, zk);
 88                 zk.create(znodePath, data.getBytes(), Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);
 89             }else {
 90                 //如果父路径的长度=0，则直接创建子路径
 91                 zk.create(znodePath, data.getBytes(), Ids.OPEN_ACL_UNSAFE, CreateMode.PERSISTENT);
 92             }
 93             return true;
 94         }    
 95     }
 96 
 97     /**
 98      * 清空子节点
 99      */
100     public static boolean clearChildNode(String znodePath, ZooKeeper zk) throws Exception {
101         
102         List<String> children = zk.getChildren(znodePath, false);
103         
104         for (String child : children) {    
105             String childNode = znodePath + "/" + child;    
106             if (zk.getChildren(childNode, null).size() != 0) {    
107                 clearChildNode(childNode, zk);    
108             }    
109             zk.delete(childNode, -1);    
110         }    
111 
112         return true;
113     }
114 }
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 ZooKeeper 特点/设计目的

ZooKeeper 作为一个集群提供数据一致的协调服务，自然，最好的方式就是在整个集群中的 各服务节点进行数据的复制和同步。



### 数据复制的好处

1、容错：一个节点出错，不至于让整个集群无法提供服务

2、扩展性：通过增加服务器节点能提高 ZooKeeper 系统的负载能力，把负载分布到多个节点上

3、高性能：客户端可访问本地 ZooKeeper 节点或者访问就近的节点，依次提高用户的访问速度



### 设计目的

1、最终一致性：client不论连接到哪个Server，展示给它都是同一个视图，这是zookeeper最重要的性能。 
2、可靠性：具有简单、健壮、良好的性能，如果消息被到一台服务器接受，那么它将被所有的服务器接受。 
3、实时性：Zookeeper保证客户端将在一个时间间隔范围内获得服务器的更新信息，或者服务器失效的信息。但由于网络延时等原因，Zookeeper不能保证两个客户端能同时得到刚更新的数据，如果需要最新数据，应该在读数据之前调用sync()接口。 
4、等待无关（wait-free）：慢的或者失效的client不得干预快速的client的请求，使得每个client都能有效的等待。 
5、原子性：更新只能成功或者失败，没有中间状态。 
6、顺序性：包括全局有序和偏序两种：全局有序是指如果在一台服务器上消息a在消息b前发布，则在所有Server上消息a都将在消息b前被发布；偏序是指如果一个消息b在消息a后被同一个发送者发布，a必将排在b前面。 

[回到顶部](https://www.cnblogs.com/qingyunzong/p/8629775.html#_labelTop)

## ZooKeeper 典型应用场景



### 命名服务

　　命名服务是分布式系统中较为常见的一类场景，分布式系统中，被命名的实体通常可以是集 群中的机器、提供的服务地址或远程对象等，通过命名服务，客户端可以根据指定名字来获 取资源的实体、服务地址和提供者的信息。Zookeeper 也可帮助应用系统通过资源引用的方 式来实现对资源的定位和使用，广义上的命名服务的资源定位都不是真正意义上的实体资源， 在分布式环境中，上层应用仅仅需要一个全局唯一的名字。Zookeeper 可以实现一套分布式 全局唯一 ID 的分配机制。

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180323130841988-1850309318.png)



### 配置管理

　　程序总是需要配置的，如果程序分散部署在多台机器上，要逐个改变配置就变得困难。现在 把这些配置全部放到 ZooKeeper 上去，保存在 ZooKeeper 的某个目录节点中，然后所有相关应用程序对这个目录节点进行监听，一旦配置信息发生变化，每个应用程序就会收到 ZooKeeper 的通知，然后从 ZooKeeper 获取新的配置信息应用到系统中就好

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180323130923189-956578368.png)



### 集群管理

所谓集群管理无在乎两点：**是否有机器退出和加入、选举 master**。

　　对于第一点，所有机器约定在父目录 GroupMembers 下创建临时目录节点，然后监听父目录 节点的子节点变化消息。一旦有机器挂掉，该机器与 ZooKeeper 的连接断开，其所创建的 临时目录节点被删除，所有其他机器都收到通知：某个兄弟目录被删除，于是，所有人都知 道：有兄弟挂了。新机器加入也是类似，所有机器收到通知：新兄弟目录加入，又多了个新 兄弟。

　　对于第二点，我们稍微改变一下，所有机器创建临时顺序编号目录节点，每次选取编号最小 的机器作为 master 就好。当然，这只是其中的一种策略而已，选举策略完全可以由管理员 自己制定。

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180323131011417-525375570.png)



### 分布式锁

有了 ZooKeeper 的一致性文件系统，锁的问题变得容易。 锁服务可以分为两三类

**一个是写锁，对写加锁，保持独占，或者叫做排它锁，独占锁**

**一个是读锁，对读加锁，可共享访问，释放锁之后才可进行事务操作，也叫共享锁**

**一个是控制时序，叫时序锁**

　　对于第一类，我们将 ZooKeeper 上的一个 znode 看作是一把锁，通过 createznode 的方式来 实现。所有客户端都去创建 /distribute_lock 节点，最终成功创建的那个客户端也即拥有了 这把锁。用完删除掉自己创建的 distribute_lock 节点就释放出锁

　　对于第二类， /distribute_lock 已经预先存在，所有客户端在它下面创建临时顺序编号目录 节点，和选 master 一样，编号最小的获得锁，用完删除，依次有序

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180323131201823-1074371713.png)



### 队列管理

　　两种类型的队列：

　　1、同步队列：当一个队列的成员都聚齐时，这个队列才可用，否则一直等待所有成员到达。

　　2、先进先出队列：队列按照 FIFO 方式进行入队和出队操作。

　　第一类，在约定目录下创建临时目录节点，监听节点数目是否是我们要求的数目。

　　第二类，和分布式锁服务中的控制时序场景基本原理一致，入列有编号，出列按编号。 同步队列的流程图：

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180323131249093-509462062.png)

 

## ZooKeeper中的各种角色

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180323183446458-933789136.png)

[回到顶部](https://www.cnblogs.com/qingyunzong/p/8632995.html#_labelTop)

## ZooKeeper与客户端

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180323183652969-965453511.png)

　　每个Server在工作过程中有三种状态：
　　　　LOOKING：当前Server不知道leader是谁，正在搜寻
　　　　LEADING：当前Server即为选举出来的leader
　　　　FOLLOWING：leader已经选举出来，当前Server与之同步

[回到顶部](https://www.cnblogs.com/qingyunzong/p/8632995.html#_labelTop)

## **Zookeeper节点数据操作流程**

![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180323184113970-414957166.png)

 

 

注：　　　　

　　1.在Client向Follwer发出一个写的请求

　　2.Follwer把请求发送给Leader

　　3.Leader接收到以后开始发起投票并通知Follwer进行投票

　　4.Follwer把投票结果发送给Leader

　　5.Leader将结果汇总后如果需要写入，则开始写入同时把写入操作通知给Leader，然后commit;

　　6.Follwer把请求结果返回给Client

 Follower主要有四个功能：

　　1. 向Leader发送请求（PING消息、REQUEST消息、ACK消息、REVALIDATE消息）；

　　2 .接收Leader消息并进行处理；

　　3 .接收Client的请求，如果为写请求，发送给Leader进行投票；

　　4 .返回Client结果。

Follower的消息循环处理如下几种来自Leader的消息：

　　1 .PING消息： 心跳消息；

　　2 .PROPOSAL消息：Leader发起的提案，要求Follower投票；

　　3 .COMMIT消息：服务器端最新一次提案的信息；

　　4 .UPTODATE消息：表明同步完成；

　　5 .REVALIDATE消息：根据Leader的REVALIDATE结果，关闭待revalidate的session还是允许其接受消息；

　　6 .SYNC消息：返回SYNC结果到客户端，这个消息最初由客户端发起，用来强制得到最新的更新。

[回到顶部](https://www.cnblogs.com/qingyunzong/p/8632995.html#_labelTop)

## Paxos 算法概述（ZAB 协议） 

 　Paxos 算法是莱斯利•兰伯特（英语：Leslie Lamport）于 1990 年提出的一种基于消息传递且 具有高度容错特性的一致性算法。

　　分布式系统中的节点通信存在两种模型：**共享内存（Shared memory）和消息传递（Messages passing）**。基于消息传递通信模型的分布式系统，不可避免的会发生以下错误：进程可能会 慢、被杀死或者重启，消息可能会延迟、丢失、重复，在基础 Paxos 场景中，先不考虑可能 出现消息篡改即拜占庭错误（**Byzantine failure，即虽然有可能一个消息被传递了两次，但是 绝对不会出现错误的消息**）的情况。**Paxos 算法解决的问题是在一个可能发生上述异常的分 布式系统中如何就某个值达成一致，保证不论发生以上任何异常，都不会破坏决议一致性。**

　　Paxos 算法使用一个希腊故事来描述，在 Paxos 中，存在三种角色，分别为

　　　　**Proposer**（提议者，用来发出提案 proposal）

　　　　**Acceptor**（接受者，可以接受或拒绝提案）

　　　　**Learner**（学习者，学习被选定的提案，当提案被超过半数的 Acceptor 接受后为被批准）

　　下面更精确的定义 Paxos 要解决的问题：

　　　　1、决议(value)只有在被 proposer 提出后才能被批准

　　　　2、在一次 Paxos 算法的执行实例中，只批准(chose)一个 value

　　　　3、learner 只能获得被批准(chosen)的 value

　　ZooKeeper 的选举算法有两种：一种是基于 **Basic Paxos**（Google Chubby 采用）实现的，另外 一种是基于 **Fast Paxos**（ZooKeeper 采用）算法实现的。系统默认的选举算法为 Fast Paxos。 并且 ZooKeeper 在 3.4.0 版本后只保留了 FastLeaderElection 算法。

　　ZooKeeper 的核心是原子广播，这个机制保证了各个 Server 之间的同步。实现这个机制的协 议叫做 ZAB 协议（Zookeeper Atomic BrodCast）。 ZAB 协议有两种模式，它们分别是**崩溃恢复模式（选主）和原子广播模式（同步）**。

　　1、当服务启动或者在领导者崩溃后，ZAB 就进入了恢复模式，当领导者被选举出来，且大 多数 Server 完成了和 leader 的状态同步以后，恢复模式就结束了。状态同步保证了 leader 和 follower 之间具有相同的系统状态。

   2、当 ZooKeeper 集群选举出 leader 同步完状态退出恢复模式之后，便进入了原子广播模式。 所有的写请求都被转发给 leader，再由 leader 将更新 proposal 广播给 follower

 　为了保证事务的顺序一致性，zookeeper 采用了递增的事务 id 号（zxid）来标识事务。所有 的提议（proposal）都在被提出的时候加上了 zxid。实现中 zxid 是一个 64 位的数字，它高 32 位是 epoch 用来标识 leader 关系是否改变，每次一个 leader 被选出来，它都会有一个新 的 epoch，标识当前属于那个 leader 的统治时期。低 32 位用于递增计数。　　

 　这里给大家介绍以下 Basic Paxos 流程：

> 1、选举线程由当前 Server 发起选举的线程担任，其主要功能是对投票结果进行统计，并选 出推荐的 Server
>
> 2、选举线程首先向所有 Server 发起一次询问(包括自己)
>
> 3、选举线程收到回复后，验证是否是自己发起的询问(验证 zxid 是否一致)，然后获取对方 的 serverid(myid)，并存储到当前询问对象列表中，最后获取对方提议的 leader 相关信息 (serverid,zxid)，并将这些信息存储到当次选举的投票记录表中
>
> 4、收到所有 Server 回复以后，就计算出 id 最大的那个 Server，并将这个 Server 相关信息设 置成下一次要投票的 Server
>
> 5、线程将当前 id 最大的 Server 设置为当前 Server 要推荐的 Leader，如果此时获胜的 Server 获得 n/2 + 1 的 Server 票数， 设置当前推荐的 leader 为获胜的 Server，将根据获胜的 Server 相关信息设置自己的状态，否则，继续这个过程，直到 leader 被选举出来。

 　通过流程分析我们可以得出：要使 Leader 获得多数 Server 的支持，则 Server 总数必须是奇 数 2n+1，且存活的 Server 的数目不得少于 n+1。 每个 Server 启动后都会重复以上流程。在恢复模式下，如果是刚从崩溃状态恢复的或者刚 启动的 server 还会从磁盘快照中恢复数据和会话信息，zk 会记录事务日志并定期进行快照， 方便在恢复时进行状态恢复。 Fast Paxos 流程是在选举过程中，某 Server 首先向所有 Server 提议自己要成为 leader，当其 它 Server 收到提议以后，解决 epoch 和 zxid 的冲突，并接受对方的提议，然后向对方发送 接受提议完成的消息，重复这个流程，最后一定能选举出 Leader

[回到顶部](https://www.cnblogs.com/qingyunzong/p/8632995.html#_labelTop)

## ZooKeeper 的选主机制



### 选择机制中的概念

#### 服务器ID

比如有三台服务器，编号分别是1,2,3。

> 编号越大在选择算法中的权重越大。

#### 数据ID

服务器中存放的最大数据ID.

>  值越大说明数据越新，在选举算法中数据越新权重越大。

#### 逻辑时钟

或者叫投票的次数，同一轮投票过程中的逻辑时钟值是相同的。每投完一次票这个数据就会增加，然后与接收到的其它服务器返回的投票信息中的数值相比，根据不同的值做出不同的判断。

#### 选举状态

- LOOKING，竞选状态。
- FOLLOWING，随从状态，同步leader状态，参与投票。
- OBSERVING，观察状态,同步leader状态，不参与投票。
- LEADING，领导者状态。



### 选举消息内容

在投票完成后，需要将投票信息发送给集群中的所有服务器，它包含如下内容。

- 服务器ID
- 数据ID
- 逻辑时钟
- 选举状态



### 选举流程图

因为每个服务器都是独立的，在启动时均从初始状态开始参与选举，下面是简易流程图。

 ![img](https://images2018.cnblogs.com/blog/1228818/201803/1228818-20180323185434643-1237203995.png)



### ZooKeeper 的全新集群选主

　　以一个简单的例子来说明整个选举的过程：假设有五台服务器组成的 zookeeper 集群，它们 的 serverid 从 1-5，同时它们都是最新启动的，也就是没有历史数据，在存放数据量这一点 上，都是一样的。假设这些服务器依序启动，来看看会发生什么

　　1、服务器 1 启动，此时只有它一台服务器启动了，它发出去的报没有任何响应，所以它的 选举状态一直是 LOOKING 状态

　　2、服务器 2 启动，它与最开始启动的服务器 1 进行通信，互相交换自己的选举结果，由于 两者都没有历史数据，所以 id 值较大的服务器 2 胜出，但是由于没有达到超过半数以上的服务器都同意选举它(这个例子中的半数以上是 3)，所以服务器 1、2 还是继续保持 LOOKING 状态

   3、服务器 3 启动，根据前面的理论分析，服务器 3 成为服务器 1,2,3 中的老大，而与上面不 同的是，此时有三台服务器(超过半数)选举了它，所以它成为了这次选举的 leader

　　4、服务器 4 启动，根据前面的分析，理论上服务器 4 应该是服务器 1,2,3,4 中最大的，但是 由于前面已经有半数以上的服务器选举了服务器 3，所以它只能接收当小弟的命了

　　5、服务器 5 启动，同 4 一样，当小弟



### ZooKeeper 的非全新集群选主

　　那么，初始化的时候，是按照上述的说明进行选举的，但是当 zookeeper 运行了一段时间之 后，有机器 down 掉，重新选举时，选举过程就相对复杂了。

　　需要加入数据 version、serverid 和逻辑时钟。

　　**数据 version**：数据新的 version 就大，数据每次更新都会更新 version

　　**server id**：就是我们配置的 myid 中的值，每个机器一个

　　**逻辑时钟**：这个值从 0 开始递增，每次选举对应一个值，也就是说：如果在同一次选举中， 那么这个值应该是一致的；逻辑时钟值越大，说明这一次选举 leader 的进程更新，也就是 每次选举拥有一个 zxid，投票结果只取 zxid 最新的

　　选举的标准就变成：

　　　　**1、逻辑时钟小的选举结果被忽略，重新投票**

　　　　**2、统一逻辑时钟后，数据 version 大的胜出**

　　　　**3、数据 version 相同的情况下，server id 大的胜出**

 根据这个规则选出 leader。