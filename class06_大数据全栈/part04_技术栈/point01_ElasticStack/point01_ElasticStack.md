# 前言

数据的分类：

- 结构化数据：关系型表中保存的数据，由特定的结构组织和管理数据
- 半结构化数据：将数据的结构和数据内容混合在一起，如xml/html
- 非结构化数据：无法用特定结构表示的数据，如日志等等，一般是key:value格式

# 第一章 ElasticStack

## 1.1 ELK

ELK是Elasticsearch、Kibana、Logstash三个技术的组合，组合使用可以解决大部分软件开发中的日志分析与处理工作，能够安全可靠地获取任何来源、任何格式的数据，并且能够实时地对数据进行搜索、分析和可视化；其中，Logstash负责数据的收集，Kibana负责结果数据的可视化展现，Elasticsearch作为核心部分用于数据的分布式存储以及索引。

## 1.2 ElasticStack

ElasticStack表示ES技术栈，在ELK的基础设基础上新增了Beats技术成员，所以ELK重新改名为ElasticStack；ElasticStack的工作流程:

1. Beats将采集的各种数据发送到ElasticSearch或交给LogStash进行数据处理
2. Logstash的主要作用是做数据处理工作
3. ElasticSearch主要是保存数据
4. 最终Kibana连接ElasticSearch将数据可视化展示

## 1.3 ElasticSearch技术栈简介

[![GfcENQ.png](https://gitee.com/panda_code_note/commons-resources/raw/master/part01_images/GfcENQ.png)](https://imgtu.com/i/GfcENQ)

1. **ElasticSearch**：是使用Java语言编写的并且基于Lucene编写的搜索引擎框架，主要特点是：分布式，零配置，自动发现，索引自动分片，索引副本机制，RESTful风格接口，多数据源，自动搜索负载等。核心技术是倒排索引：在ElasticSrearch中数据存储在索引中，ElasticSearch会根据索引中的数据进行分词保存在分词库中；当需要检索数据时候，首先会根据检索关键字在分词库中检索出索引ID，再根据检索的索引ID去索引中直接查找对应的数据；
   - Lucene：本身就是一个搜索引擎的底层；
   - Slor：查询死数据时候，速度相对ES而言Slor更快一些，如果数据实时改变的，Slor速度会受很大影响；ES集群更容易搭建；
   - 分布式：主要是体现在横向扩展能力；
2. **LogStash**：基于Java，是一个开源的用于收集、分析和储存日志的工具
3. **Kibana**：基于Node，Kibna可以为LogStash和ElasticSearch提供友好的web界面，可以汇总，分析，搜索重要数据
4. **Beats**：是elastic公司开源的一款采集系统监控数据的agent，是在被监控的服务器上以客户端的形式运行的数据收集器统称，可以直接把数据发送给ElasticSearch或者通过LogStash发送给ElasticSearch，然后进行后续的数据分析活动。Beat主要的组成：
   - **Packetbeat**：是一个网络数据包分析器，用于监控、收集网络流量信息，Packetbeat嗅探服务器直接的流量，解析应用层协议，并关联到消息的处理，支持ICMP（IPV4 and IPV6）、DNS、HTTP、MySql、Redis、PostgrpreSQL、MongoDB等协议
   - **Filebeat**：用于监控收集服务器日志文件，以取代logstash forwarder
   - **Metricbeat**：可定期获取外部系统监控指标信息，其可以监控收集Apache、HAProxy、MongoDB、MySql、Nginx、Redis、PostgrpreSQL、Redis、System、ZooKeeper等服务
   - **Winlogbeat**：用于监控收集Windows的日志信息。

# 第二章 ElasticSearch安装

## 2.1 ElasticSearch版本说明

版本说明：ElasticSearch发展非常快，在5.0以前ELK各个版本都不统一，所以在ELK5.0以后Elasticstatic技术栈的版本都统一为一个版本号

- ElasticSearch下载地址：https://www.elastic.co/cn/downloads/elasticsearch

- Kibana下载地址：https://www.elastic.co/cn/downloads/kibana
- LogStash下载地址：
- Beats下载地址：

## 2.2 ElasticSearch安装

### 1. Linux系统安装

- 删除CentOS中预安装的Java

  ```sh
  rpm -qa | grep java
  rpm -e --nodeps xxx
  ```

- 安装ElasticSearch对应的JDK

  ```sh
  export JAVA_HOME=/opt/jdk
  export PATH=$JAVA_HOME/bin:$PATH
  export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar 
  ```

- 创建ElasticSearch用户：因为ElasticSearch默认不支持root用于运行，所以ElasticSearch需要单独创建用户

  ```sh
  useradd elsearch
  ```

- 新建ElasticSearch的安装目录，安装目录自定义，这里是安装在opt中是search目录中，并上传ElasticSearch的安装包并解压到search目录中

  ```sh
  cd /opt
  mkdir search
  chown elsearch:elsearch search/ -R
  ```

- ElasticSearch配置文件说明：在/opt/search/config/目录中的相关文件

  1. **elasticsearch.yml**：ElasticSearch的启动配置文件

     ```yml
     # ---------------------------------- Cluster -----------------------------------
     # 集群名称
     #cluster.name: my-application
     # ------------------------------------ Node ------------------------------------
     # 节点名称:
     node.name: node-1
     # 节点自定义属性:
     #node.attr.rack: r1
     # ----------------------------------- Paths ------------------------------------
     # 存储数据的目录,多个路径用逗号分隔:
     #path.data: /path/to/data
     # 日志文件目录:
     #path.logs: /path/to/logs
     # ----------------------------------- Memory -----------------------------------
     # 启动时是否锁定内存:
     #bootstrap.memory_lock: true
     # ---------------------------------- Network -----------------------------------
     # 将绑定地址设置为特定的IP (IPv4或IPv6) 0 任意端口可以访问
     network.host: 0.0.0.0
     # 为HTTP设置自定义端口:
     http.port: 9200
     # --------------------------------- Discovery ----------------------------------
     #当这个节点启动时，传递一个初始的主机列表来执行发现: 默认的主机列表是["127.0.0.1"，"[::1]"]
     #discovery.seed_hosts: ["host1", "host2"]
     # 使用主节点的初始集合引导集群:
     cluster.initial_master_nodes: ["node-1"]
     # ---------------------------------- Gateway -----------------------------------
     # 在整个集群重新启动后阻塞初始恢复，直到N个节点启动:
     #gateway.recover_after_nodes: 3
     # ---------------------------------- Various -----------------------------------
     # 删除索引时要求显式名称:
     #action.destructive_requires_name: true
     ```

  2. **jvm.options**：ElasticSearch是基于Java开发，jvm.options用于设置ElasticSearch运行时jvm环境相关配置；ElasticSearch中的host配置不是localhost或127.0.0.1会被认为是生产环境，会多ElasticSearch启动要求比较高；

     ```properties
     # Xms 表示总的堆空间的初始大小
     # Xmx 表示堆空间的最大大小
     -Xms128m
     -Xmx128m
     ```

  3. log4j2.properties

  4. role_mapping.yml

  5. roles.yml

- 配置系统的内存一个进程在VMAS（虚拟内存）创建内存映射的最大数量：**需要使用root用户进行操作**

  ```sh
  vim /etc/sysctl.conf		# 编辑配置文件,修改此文件需要重启Linux服务器
  vm.max_map_count=655360		# 修改内存最大映射数量
  sysctl -p 					# 查看配置后的信息
  ```

- 修改最大文件描述以满足ELasticSearch：max file descriptors [4096] for elasticsearch process is too low, increase to at least [65535]；\*号的位置标示支持的用户名称，\*号匹配所有用户

  ```sh
  vim /etc/security/limits.conf
  # >>>>追加 * 号表示所有用户
  * soft nofile 65536
  * hard nofile 131072
  * soft nproc 2048
  * hard nproc 4096
  ```

- 默认进程中的线程数2014太低 最少是4096：max number of threads [3756] for user [elsearch] is too low, increase to at least [4096]

  ```sh
  vim /etc/security/limits.d/20-nproc.conf
  # >>>>修改
  *          soft    nproc     4096
  ```

- 开启ElasticSearch端口：9200

  ```sh
  firewall-cmd --zone=public --add-port=9200/tcp --permanent 
  firewall-cmd --reload
  ```

- 修改ElasticSearch的安装的用户所属并切换到elsearch用户：在启动后ElasticSearch生成的日志相关文件所属也是root用户，需要将这些文件也修改为新建的elsearch（非root用户）的所属；

  ```sh
  chown elsearch:elsearch -R /opt/search
  su - elsearch
  ```

- 用elsearch（非root用户）用户启动ElasticSearch服务

  ```sh
  cd /bin
  ./elasticsearch		# 前台启动
  ./elasticsearch &  	# 后台启动
  ```

### 2. Windows系统安装

### 3. Docker安装

- 设置

  ```sh
  vim etc/sysctl.conf
  vm.max_map_count=131072
  ```

- 下载ElasticSearch

  ```sh
  docker pull elasticsearch:7.6.0
  ```

- 运行镜像启动容器

  ```sh
  mkdir -p /docker/elstatic/search/plugins
  mkdir -p /docker/elstatic/search/data
  ```

  ```sh
  chmod 777 /docker/elstatic/search/data
  ```

  ```sh
  docker run -p 9200:9200 -p 9300:9300 --name elasticsearch \
  -e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
  -e "discovery.type=single-node" \
  -e "cluster.name=elasticsearch" \
  -v /docker/elstatic/search/plugins:/usr/share/elasticsearch/plugins \
  -v /docker/elstatic/search/data:/usr/share/elasticsearch/data \
  -d elasticsearch:7.6.0
  
  
  docker run -p 9200:9200 -p 9300:9300 --name elasticsearch -e "ES_JAVA_OPTS=-Xms512m -Xmx512m" -e "discovery.type=single-node" -e "cluster.name=elasticsearch" -v D:/panda_docker_files/search/plugins:/usr/share/elasticsearch/plugins -v D:/panda_docker_files/search/data:/usr/share/elasticsearch/data -d elasticsearch:7.6.0
  ```

- 测试安装：http://120.27.22.124:9200/

- 安装：elstaticstarch-head

  - docker：需要处理服务跨域访问配置

    ```sh
    docker pull mobz/elasticsearch-head:5
    
    docker run -d --name es_head -p 9100:9100 mobz/elasticsearch-head:5
    ```

  - Github：Chrome插件的使用无需处理跨域

    ```sh
    git clone https://github.com/mobz/elasticsearch-head.git
    ```

## 2.3 IK分词器



## 2.4 Kibana安装

### 1. Linux系统安装

- 新建Kibana安装目录：/opt/kibana

- 将Kibana安装包解压到/opt/kibana目录中：Kibana的版本必须和ElasticSearch版本相同

- 修改Kibana配置文件：/opt/kibana/config/kibana.yml

  ```yml
  # Kibana 服务启动端口
  server.port: 5601
  
  # 指定Kibana服务器要绑定到的地址
  server.host: "192.168.57.129"
  
  #server.basePath: ""
  
  #server.rewriteBasePath: false
  
  # 传入服务器请求的最大负载大小(以字节为单位)
  #server.maxPayloadBytes: 1048576
  
  # Kibana服务器的名字。它用于显示目的
  #server.name: "your-hostname"
  
  # 用于所有查询的Elasticsearch实例的url
  elasticsearch.hosts: ["http://192.168.57.129:9200"]
  
  # 当这个设置的值为真时，Kibana使用server.host中指定的主机名
  #elasticsearch.preserveHost: true
  
  #kibana.index: ".kibana"
  
  # 要加载的默认应用程序.
  #kibana.defaultAppId: "home"
  
  
  #elasticsearch.username: "kibana"
  #elasticsearch.password: "pass"
  
  #server.ssl.enabled: false
  #server.ssl.certificate: /path/to/your/server.crt
  #server.ssl.key: /path/to/your/server.key
  
  #elasticsearch.ssl.certificate: /path/to/your/client.crt
  #elasticsearch.ssl.key: /path/to/your/client.key
  
  
  #elasticsearch.ssl.certificateAuthorities: [ "/path/to/your/CA.pem" ]
  
  #elasticsearch.ssl.verificationMode: full
  
  #elasticsearch.pingTimeout: 1500
  
  #elasticsearch.requestTimeout: 30000
  
  #elasticsearch.requestHeadersWhitelist: [ authorization ]
  
  #elasticsearch.customHeaders: {}
  
  #elasticsearch.shardTimeout: 30000
  
  #elasticsearch.startupTimeout: 5000
  
  #elasticsearch.logQueries: false
  
  #pid.file: /var/run/kibana.pid
  
  #logging.dest: stdout
  
  #logging.silent: false
  
  #logging.quiet: false
  
  #logging.verbose: false
  
  #ops.interval: 5000
  
  i18n.locale: "zh-CN"
  ```

- 开启kibana服务运行端口：5601

  ```sh
  firewall-cmd --zone=public --add-port=5601/tcp --permanent 
  firewall-cmd --reload
  ```

- 切换到非root用户,并将kibana安装目录指定为当前用户所属

  ```sh
  chown elsearch:elsearch -R /opt/kibana
  su - elsearch
  /opt/kibana/kibana &
  ```
  
- docker安装

  ```sh
  ```

  

## 2.5 LogStash安装

## 2.6 Beats - 安装

## 2.7 Chrome Head插件安装

- GIt源码地址：https://github.com/mobz/elasticsearch-head
- 打开下载地址找到es-head.crx文件：/elasticsearch-head/blob/master/crx/es-head.crx
- 文件后缀名".crx"改为“.rar”解压到文件夹中
- Chrome“加载已解压的扩展程序”按钮加入文件夹。

## 2.8 ES基础知识

1. ES是分布式，支持RESTFul搜索和分析的：资源根据请求状态的不同而产生不同的响应；
   - POST:支持重复请求,不具备幂等性
   - GET:支持重复请求,不具备幂等性
   - PUT:不支持重复请求,具备幂等性
   - DELETE:不知道重复请求,具备幂等性
2. 倒排索引：ES是面向文档型数据库，一条数据就是表示一个文档；可以与关系性数据库做对比：es中的索引在关系性数据库中表示为一个database，es中的type相当于表，一个文档（json格式的字符串）表示一行数据，文档中的Field（json中的key）表示列名；es中为了做到快速检索，使用倒排索引加速检索：将文档中的内容作为查询的key，而将文档ID作为对应的value；在新版es中type被淘汰了；

# 第三章 ElasticSearch基础

## 3.1 ES基本概念

### 1、集群

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;包含多个节点，每个节点属于哪个集群是通过一个配置（集群名称，默认是elasticsearch）来决定的，对于中小型应用来说，刚开始一个集群就一个节点很正常。集群的目的为了提供高可用和海量数据的存储以及更快的跨节点查询能力。

### 2、节点 

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;集群中的一个节点，节点也有一个名称（默认是随机分配的），节点名称很重要（在执行运维管理操作的时候），默认节点会去加入一个名称为“elasticsearch”的集群，如果直接启动一堆节点，那么它们会自动组成一个elasticsearch集群，当然一个节点也可以组成一个elasticsearch集群

### 3、倒排索引

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;传统的索引方式是将字段内容存储为索引结构的数据，检索时候根据内容先检索索引，在根据索引查询到数据；在ElasticSearch中使用倒排索引：其基本原理是讲字段中内容进行分词，将分词结果存储在分词库中，并记录这些分词对应的记录ID，检索时候将检索关键字进行分词后在分词库中进行匹配，然后将匹配的分词对应的记录ID进行返回，最后根据检索出的记录ID检索出数据；

### 4、索引

- 索引是ElasticSearch对数据的逻辑存储，所以它可以分为更小的部分

- 可以把索引看成关系型数据库的表，索引的结构是为快速有效的全文检索准备的，特别是它不存储原始值

- ElasticSearch可以把索引存放在一台机器或者分散在多态服务器上，每个索引有一个或多个分片（shard），每个分片可以有多个副本（replica）。

- ES服务中可以创建多个索引

  每一个索引默认被分为5片存储

  每个分片都会存在至少一个备份分片

  备份分片默认不会帮助检索数据，当ES压力特别大时候，备份分片才会检索数据

  备份的分片必须放在不同的服务器中

### 5、分片

### 6、副本

### 7、文档

- 存储在Electicsearch中的主要实体叫文档（document），用关系型数据库类比的话，一个文档相当于数据表中的一行记录。
- ElasticSearch和MongoDB中的文档相似，都可以有不同的结构，但在ElasticSearch中，相同字段必须有相同的类型。
- 文档由多个字段组成，每个字段可以多次的出现在同一文档中，这种字段称为**多值字段**，
- 每个字段的类型可以是文本、数值、日期等；字段类型也可以是复杂类型，一个字段可以包含其他子文档或数组；

### 8、类型

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;起初，我们说"索引"和关系数据库的“库”是相似的，“类型”和“表”是对等的。这是一个不正确的对比，导致了不正确的假设。在关系型数据库里,"表"是相互独立的,一个“表”里的列和另外一个“表”的同名列没有关系，互不影响。但在一个Elasticsearch索引里，在类型里字段不是这样的，所有不同类型的同名字段内部使用的是同一个lucene字段存储。举个例子：user类型的user_name字段和tweet类型的user_name字段是存储在一个字段里的，两个类型里的user_name必须有一样的字段定义。最后,在同一个索引中，存储仅有小部分字段相同或者全部字段都不相同的文档，会导致数据稀疏，影响Lucene有效压缩数据的能力。因为这些原因，从Elasticsearch7.x中移除类型的概念;

### 9、映射

所有文档写进索引之前都会先进行分析：如何将输入的文本分隔为词条、哪些词条又会被过滤；这种行为称为映射，一般由用户自定义规则，比如使用中文分词

- settings：设置索引分片和部分
- mappings：设置索引映射
  - properties：该对象包含映射到字段
    - [fields]：该对象用于说明字段相关的约束
      - type：表示字段的类型
      - format：表示字段的格式化方式，针对date类型
      - analyzer：表示使用的查询分析器
      - properties：同上表示嵌套对象，嵌套对象的type类型是默认是object

💛原文地址为https://www.cnblogs.com/haixiang/p/12040272.html，转载请注明出处!
🍎**es与SpringBoot的整合以及常用CRUD、搜索API已被作者封装,开箱即用效果很好,欢迎star谢谢!**[github](https://github.com/Motianshi/all-search)

Mapping简介[#](https://www.cnblogs.com/haixiang/p/12040272.html#1119358845)

mapping 是用来定义文档及其字段的存储方式、索引方式的手段，例如利用`mapping` 来定义以下内容：

- 哪些字段需要被定义为全文检索类型
- 哪些字段包含`number`、`date`类型等
- 格式化时间格式
- 自定义规则，用于控制动态添加字段的映射

Mapping Type

每个索引都拥有唯一的 `mapping type`，用来决定文档将如何被索引。`mapping type`由下面两部分组成

- Meta-fields
  元字段用于自定义如何处理文档的相关元数据。 元字段的示例包括文档的_index，_type，_id和_source字段。
- Fields or properties
  映射类型包含与文档相关的字段或属性的列表。

分词器最佳实践[#](https://www.cnblogs.com/haixiang/p/12040272.html#3142227410)

因为后续的`keyword`和`text`设计分词问题，这里给出分词最佳实践。即**索引时用ik_max_word，搜索时分词器用ik_smart**，这样索引时最大化的将内容分词，搜索时更精确的搜索到想要的结果。

例如我想搜索的是小米手机，我此时的想法是想搜索出小米手机的商品，而不是小米音响、小米洗衣机等其他产品，也就是说商品信息中必须只有小米手机这个词。

我们后续会使用`"search_analyzer": "ik_smart"`来实现这样的需求。

字段类型[#](https://www.cnblogs.com/haixiang/p/12040272.html#2026557297)

- 一种简单的数据类型，例如`text`、`keyword`、`double`、`boolean`、`long`、`date`、`ip`类型。
- 也可以是一种分层的json对象（支持属性嵌套）。
- 也可以是一些不常用的特殊类型，例如`geo_point`、`geo_shape`、`completion`

针对同一字段支持多种字段类型可以更好地满足我们的搜索需求，例如一个`string`类型的字段可以设置为`text`来支持全文检索，与此同时也可以让这个字段拥有`keyword`类型来做排序和聚合，另外我们也可以为字段单独配置分词方式，例如`"analyzer": "ik_max_word",`

text 类型[#](https://www.cnblogs.com/haixiang/p/12040272.html#4164760018)

`text`类型的字段用来做全文检索，例如邮件的主题、淘宝京东中商品的描述等。这种字段在被索引存储前**先进行分词**，存储的是分词后的结果，而不是完整的字段。`text`字段不适合做排序和聚合。如果是一些结构化字段，分词后无意义的字段建议使用`keyword`类型，例如邮箱地址、主机名、商品标签等。

常有参数包含以下

- analyzer：用来分词，包含**索引存储阶段**和**搜索阶段**（其中查询阶段可以被**search_analyzer**参数覆盖），该参数默认设置为index的analyzer设置或者standard analyzer
- index：是否可以被搜索到。默认是`true`
- fields：Multi-fields允许同一个字符串值同时被不同的方式索引，例如用不同的analyzer使一个field用来排序和聚类，另一个同样的string用来分析和全文检索。下面会做详细的说明
- search_analyzer：这个字段用来指定**搜索阶段**时使用的分词器，默认使用`analyzer`的设置
- search_quote_analyzer：搜索遇到短语时使用的分词器，默认使用`search_analyzer`的设置

keyword 类型[#](https://www.cnblogs.com/haixiang/p/12040272.html#3592965838)

`keyword`用于索引结构化内容（例如电子邮件地址，主机名，状态代码，邮政编码或标签）的字段，这些字段被拆分后不具有意义，所以在es中应**索引完整的字段**，而不是分词后的结果。

通常用于过滤（例如在博客中根据发布状态来查询所有已发布文章），排序和聚合。`keyword`只能按照字段精确搜索，例如根据文章id查询文章详情。如果想根据本字段进行全文检索相关词汇，可以使用`text`类型。

Copy

```json
PUT my_index
{
  "mappings": {
    "properties": {
      "tags": {
        "type":  "keyword"
      }
    }
  }
}
```

- index：是否可以被搜索到。默认是`true`
- fields：Multi-fields允许同一个字符串值同时被不同的方式索引，例如用不同的analyzer使一个field用来排序和聚类，另一个同样的string用来分析和全文检索。下面会做详细的说明
- null_value：如果该字段为空，设置的默认值，默认为`null`
- ignore_above：设置索引字段大小的阈值。该字段不会索引大小超过该属性设置的值，默认为2147483647，代表着可以接收任意大小的值。但是这一值可以被`PUT Mapping Api`中新设置的`ignore_above`来覆盖这一值。

date类型[#](https://www.cnblogs.com/haixiang/p/12040272.html#4169588024)

支持排序，且可以通过`format`字段对时间格式进行格式化。

`json`中没有时间类型，所以在es在规定可以是以下的形式：

- 一段格式化的字符串，例如`"2015-01-01"`或者`"2015/01/01 12:10:30"`
- 一段`long`类型的数字，指距某个时间的毫秒数，例如`1420070400001`
- 一段`integer`类型的数字，指距某个时间的秒数

object类型[#](https://www.cnblogs.com/haixiang/p/12040272.html#3164138260)

`mapping`中不用特意指定field为`object`类型，因为这是它的默认类型。

`json`类型天生具有层级的概念，文档内部还可以包含`object`类型进行嵌套。例如：

```json
PUT my_index/_doc/1
{ 
  "region": "US",
  "manager": { 
    "age":     30,
    "name": { 
      "first": "John",
      "last":  "Smith"
    }
  }
}
```

在es中上述对象会被按照以下的形式进行索引：

```json
{
  "region":             "US",
  "manager.age":        30,
  "manager.name.first": "John",
  "manager.name.last":  "Smith"
}
```

`mapping`可以对不同字段进行不同的设置

```json
PUT my_index
{
  "mappings": {
    "properties": { 
      "region": {
        "type": "keyword"
      },
      "manager": { 
        "properties": {
          "age":  { "type": "integer" },
          "name": { 
            "properties": {
              "first": { "type": "text" },
              "last":  { "type": "text" }
            }
          }
        }
      }
    }
  }
}
```

nest类型[#](https://www.cnblogs.com/haixiang/p/12040272.html#1806022256)

`nest`类型是一种特殊的`object`类型，它允许`object`可以以数组形式被索引，而且数组中的某一项都可以被独立检索。

而且es中没有内部类的概念，而是通过简单的列表来实现`nest`效果，例如下列结构的文档：

```json
PUT my_index/_doc/1
{
  "group" : "fans",
  "user" : [ 
    {
      "first" : "John",
      "last" :  "Smith"
    },
    {
      "first" : "Alice",
      "last" :  "White"
    }
  ]
}
```

上面格式的对象会被按照下列格式进行索引，因此会发现一个user中的两个属性值不再匹配，`alice`和`white`失去了联系

```json
{
  "group" :        "fans",
  "user.first" : [ "alice", "john" ],
  "user.last" :  [ "smith", "white" ]
}
```

range类型[#](https://www.cnblogs.com/haixiang/p/12040272.html#2473687704)

支持以下范围类型：

| 类型          | 范围                                 |
| ------------- | ------------------------------------ |
| integer_range | `-2的31次` 到 `2的31次-1`.           |
| float_range   | 32位单精度浮点数                     |
| long_range    | `-2的63次` 到 `2的63次-1`.           |
| double_range  | 64位双精度浮点数                     |
| date_range    | unsigned 64-bit integer milliseconds |
| ip_range      | ipv4和ipv6或者两者的混合             |

使用范例为：

```json
PUT range_index
{
  "settings": {
    "number_of_shards": 2
  },
  "mappings": {
    "properties": {
      "age_range": {
        "type": "integer_range"
      },
      "time_frame": {
        "type": "date_range", 
        "format": "yyyy-MM-dd HH:mm:ss||yyyy-MM-dd||epoch_millis"
      }
    }
  }
}

PUT range_index/_doc/1?refresh
{
  "age_range" : { 
    "gte" : 10,
    "lte" : 20
  },
  "time_frame" : { 
    "gte" : "2015-10-31 12:00:00", 
    "lte" : "2015-11-01"
  }
}
```

实战：同时使用keyword和text类型[#](https://www.cnblogs.com/haixiang/p/12040272.html#2674254835)

**注：term是查询时对关键字不分词，keyword是索引时不分词**

上述我们讲解过`keyword`和`text`一个不分词索引，一个是分词后索引，我们利用他们的`fields`属性来让当前字段同时具备`keyword`和`text`类型。

首先我们创建索引并指定`mapping`，为`title`同时设置`keyword`和`text`属性

Copy

```json
PUT /idx_item/
{
  "settings": {
    "index": {
        "number_of_shards" : "2",
        "number_of_replicas" : "0"
    }
  },
  "mappings": {
    "properties": {
      "itemId" : {
        "type": "keyword",
        "ignore_above": 64
      },
      "title" : {
        "type": "text",
        "analyzer": "ik_max_word", 
        "search_analyzer": "ik_smart", 
        "fields": {
          "keyword" : {"ignore_above" : 256, "type" : "keyword"}
        }
      },
      "desc" : {"type": "text", "analyzer": "ik_max_word"},
      "num" : {"type": "integer"},
      "price" : {"type": "long"}
    }
  }
}
```

我们已经往es中插入以下数据

| _index   | _type | _id                  | _score | itemId | title                     | desc                                 | num  | Price |
| -------- | ----- | -------------------- | ------ | ------ | ------------------------- | ------------------------------------ | ---- | ----- |
| idx_item | _doc  | rvsX-W4Bo-iJGWqbQ8dk | 1      | 1      | 苏泊尔煮饭SL3200          | 让煮饭更简单，让生活更快乐           | 100  | 200   |
| idx_item | _doc  | sPsY-W4Bo-iJGWqbscfU | 1      | 3      | 厨房能手威猛先生          | 你煲粥，我洗锅                       | 100  | 30    |
| idx_item | _doc  | r_sX-W4Bo-iJGWqbhMew | 1      | 2      | 苏泊尔煲粥好能手型号SL322 | 你煲粥，我煲粥，我们一起让煲粥更简单 | 100  | 190   |

`title=”苏泊尔煮饭SL3200“` 根据`text`以及最细粒度分词设置`"analyzer": "ik_max_word"`，在es中按照以下形式进行索引存储

```
{ "苏泊尔","煮饭", "sl3200", "sl","3200"}
```

`title.keyword=”苏泊尔煮饭SL3200`因为不分词，所以在es中索引存储形式为

```
苏泊尔煮饭SL3200
```

我们首先对`title.keyword`进行搜索，只能搜索到第一条数据，因为`match`搜索会将关键字分词然后去搜索，分词后的结果包含`"苏泊尔煮饭SL3200"`所以搜索成功，我们将搜索关键字改为`苏泊尔`、`煮饭`等都不会查到数据。

```json
GET idx_item/_search
{
  "query": {
    "bool": {
      "must": {
        "match": {"title.keyword": "苏泊尔煮饭SL3200"}
        }
    }
  }
}
```

我们改用`term`搜索，他搜索不会分词，正好与es中的数据精准匹配，也只有第一条数据，我们将搜索关键字改为`苏泊尔`、`煮饭`等都不会查到数据。

```json
GET idx_item/_search
{
  "query": {
    "bool": {
      "must": {
        "term": {"title.keyword": "苏泊尔煮饭SL3200"}
        }
    }
  }
}
```

我们继续对`title`使用`match`进行查询，结果查到了第一条和第三条数据，因为它们在es中被索引的数据包含`苏泊尔`关键字

```json
GET idx_item/_search
{
  "query": {
    "bool": {
      "must": {"match": {"title": "苏泊尔"}
        }
    }
  }
}
```

我们如果搜索`苏泊尔煮饭SL3200`会发现没有返回数据，因为`title`在索引时没有`苏泊尔煮饭SL3200`这一项，而`term`时搜索关键字也不分词，所以无法匹配到数据。但是我们将内容改为`苏泊尔`时，就可以搜索到第一条和第三条内容，因为第一条和第三条的`title`被分词后的索引包含`苏泊尔`字段，所以可以查出第一三条。

```jsaon
"term": {"title": "苏泊尔煮饭SL3200"}
```

实战：格式化时间、以及按照时间排序[#](https://www.cnblogs.com/haixiang/p/12040272.html#2847931562)

我们创建索引`idx_pro`，将`mytimestamp`和`createTime`字段分别格式化成两种时间格

```json
PUT /idx_pro/
{
  "settings": {
    "index": {
        "number_of_shards" : "2",
        "number_of_replicas" : "0"
    }
  },
  "mappings": {
    "properties": {
      "proId" : {
        "type": "keyword",
        "ignore_above": 64
      },
      "name" : {
        "type": "text",
        "analyzer": "ik_max_word", 
        "search_analyzer": "ik_smart", 
        "fields": {
          "keyword" : {"ignore_above" : 256, "type" : "keyword"}
        }
      },
      "mytimestamp" : {
        "type": "date",
        "format": "epoch_millis"
      },
      "createTime" : {
        "type": "date",
        "format": "yyyy-MM-dd HH:mm:ss"
      }
    }
  }
}
```

插入四组样本数据

```json
POST idx_pro/_doc
{
  "proId" : "1",
  "name" : "冬日工装裤",
  "timestamp" : 1576312053946,
  "createTime" : "2019-12-12 12:56:56"
}
POST idx_pro/_doc
{
  "proId" : "2",
  "name" : "冬日羽绒服",
  "timestamp" : 1576313210024,
  "createTime" : "2019-12-10 10:50:50"
}
POST idx_pro/_doc
{
  "proId" : "3",
  "name" : "花花公子外套",
  "timestamp" : 1576313239816,
  "createTime" : "2019-12-19 12:50:50"
}
POST idx_pro/_doc
{
  "proId" : "4",
  "name" : "花花公子羽绒服",
  "timestamp" : 1576313264391,
  "createTime" : "2019-12-12 11:56:56"
}
```

我们可以使用`sort`参数来进行排序，并且支持数组形式，即同时使用多字段排序，只要改为`[]`就行

```json
GET idx_pro/_search
{
  "sort":{"createTime": {"order": "asc"}}, 
  "query": {
    "bool": {
      "must": {"match_all": {}}
    }
  }
}
```

我们也可以使用`range`参数来搜索指定时间范围内的数据，当然`range`也支持`integer`、`long`等类型

```json
GET idx_pro/_search
{
  "query": {
    "bool": {
      "must": {
        "range": {
          "timestamp": {
            "gt": "1576313210024",
            "lt": "1576313264391"
          }
        }
      }
    }
  }
}
```

所有内容皆为个人总结或转载别人的文章，只为学习技术。 若您觉得文章有用，欢迎点赞分享！ 若无意对您的文章造成侵权，请您留言，博主看到后会及时处理，谢谢。

### 10、field

- 一个文档中包含多个属性，一行数据中的多个列

  | 类型     |               | 说明                                                 |
  | -------- | ------------- | ---------------------------------------------------- |
  | 字符串   | text          | 一般被用于全文检索，可以被分词                       |
  |          | keyword       | 不可以被分词                                         |
  | 数值     | long          |                                                      |
  |          | integer       |                                                      |
  |          | short         |                                                      |
  |          | byte          |                                                      |
  |          | double        |                                                      |
  |          | float         |                                                      |
  |          | half_float    |                                                      |
  |          | scaled_float  | long+比例表示一个浮点数                              |
  | 时间类   | date          | yyyy-MM-dd HH:mm:ss \| yyyy-MM-dd \| epoch-millis    |
  | 布尔     | boolean       |                                                      |
  | 二进制   | binary        | 支持base64的字符串                                   |
  | 范围类型 | long_range    | 赋值时无需指定具体的内容,只需要指定一个范围,gt \| lt |
  |          | flaot_range   |                                                      |
  |          | double_range  |                                                      |
  |          | integer_range |                                                      |
  |          | date_range    |                                                      |
  |          | ip_range      |                                                      |
  | 经纬度   | geo_point     | 用来存储经纬度                                       |
  | ip类型   | ip            | IPV4 \| IPV6                                         |

## 3.2 基础操作  - 索引

1. **新增结构化索引**：number_of_shards分片数据；number_of_replicas备份数；在Lucene中创建索引是需要定义字段名称以及字段类型的，在ElasticSearch中提供了非结构化索引，就是不需要创建索引结构即可写数据到索引中，实际上ElasticSearch在底层会做结构化操作，此操作对用户是透明的。

   ```json
   PUT /person
   
   {
     "settings": {
       "number_of_shards": 5,
       "number_of_replicas": 1
     }
   }
   ```

2. **查看索引信息**

   ```json
   GET /person
   ```

3. **删除索引**

   ```json
   DELETE /person
   ```

## 3.3 基础操作 - 文档

1. 创建索引指定数据结构

   ```json
   PUT /book
   {
     "settings": {
       "number_of_shards": 5,
       "number_of_replicas": 1
     },
     "mappings": {
       "properties":{
         "name":{
           "type":"text"
         },
         "author":{
           "type":"keyword"
         },
         "count":{
           "type":"long"
         },
         "onSale":{
           "type":"date",
           "format":"yyyy-MM-dd HH:mm:ss||yyyy-MM-dd"
         },
         "descr":{
           "type":"text"
         }
       }
     }
   }
   ```

2. 文档操作-新增：文档在es服务中的唯一标识（_index索引   _type类型  _id 主键自动生成）

   ```json
   # 自动生成_id
   POST /book/_doc
   {
     "name": "盘龙",
     "author": "土豆",
     "count": "652354457",
     "onSale": "2020-12-23",
     "descr": "为什么不能修改一个字段的type？原因是一个字段的类型修改以后，那么该字段的所有数据都需要重新索引。Elasticsearch底层使用的是lucene库，字段类型修改以后索引和搜索要涉及分词方式等操作，不允许修改类型在我看来是符合lucene机制的。"
   }
   ```

3. 文档操作 - 新增 手动指定ID

   ```json
   POST /book/_doc/1
   {
     "name": "凡人修仙",
     "author": "天蚕",
     "count": "652354457",
     "onSale": "2020-12-23",
     "descr": "我欲成仙"
   }
   ```

4. 文档操作 - 覆盖式修改 如果ID存在值则字段全量更新

   ```json
   POST /book/_doc/1
   {
     "name": "凡人修仙",
     "author": "天蚕",
     "count": "652354457",
     "descr": "快乐七天"
   }
   ```

5. 文档操作 - 懒修改

   ```json
   POST /book/_doc/1/_update
   {
     "doc":{
         "count": "652354457",
         "onSale": "2020-12-23"
     }
   }
   ```

6. 删除文档

   ```json
   DELETE /book/_doc/87bgvnMBZnIOh5hMwAW5
   ```

## 3.4 基础操作 - 检索

- 创建测试数据

  ```json
  PUT /sms_logs_index
  {
    "settings": {
      "number_of_shards": 5,
      "number_of_replicas": 1
    },
    "mappings": {
      "properties": {
        "createTime":{
          "type": "date",
          "format": ["yyyy-MM-dd HH:mm:ss"]
        },
        "sendTime":{
          "type": "date",
          "format": ["yyyy-MM-dd HH:mm:ss"]
        },
        "longCode":{
          "type": "keyword"
        },
        "mobile":{
          "type": "text"
        },
        "cropName":{
          "type": "text"
        },
        "smsContent":{
          "type": "text"
        },
        "status":{
          "type": "integer"
        },
        "operatorId":{
          "type": "integer"
        },
        "province":{
          "type": "text"
        },
        "ipAddr":{
          "type": "text"
        },
        "fee":{
          "type": "long"
        }
      }
    }
  }
  ```

- 添加测数据

  ```json
  POST /sms_logs_index/_doc
  {
    "createTime":"2020-07-01 12:00:00",
    "sendTime":"2020-07-01 12:00:00",
    "longCode":"2020701120000",
    "mobile":"18700136671",
    "cropName":"奇点",
    "smsContent":"短信激活成功",
    "status":1,
    "operatorId":0,
    "province":"陕西省",
    "ipAddr":"192.168.0.123",
    "fee":15
  }
  ```

  ```json
  POST /sms_logs_index/_doc
  {
    "createTime":"2020-07-02 12:00:00",
    "sendTime":"2020-07-02 12:00:00",
    "longCode":"2020702120000",
    "mobile":"18700131171",
    "cropName":"奇点",
    "smsContent":"短信激活失败",
    "status":1,
    "operatorId":0,
    "province":"浙江省",
    "ipAddr":"192.168.0.124",
    "fee":25
  }
  ```

  ```json
  POST /sms_logs_index/_doc
  {
    "createTime":"2020-07-04 12:00:00",
    "sendTime":"2020-07-04 12:00:00",
    "longCode":"2020704120000",
    "mobile":"18700134471",
    "cropName":"奇点",
    "smsContent":"短信登陆异常败",
    "status":1,
    "operatorId":0,
    "province":"浙江省",
    "ipAddr":"192.168.0.144",
    "fee":35
  }
  ```

  ```json
  POST /sms_logs_index/_doc
  {
    "createTime":"2020-07-05 12:00:00",
    "sendTime":"2020-07-05 12:00:00",
    "longCode":"2020705120000",
    "mobile":"18700135571",
    "cropName":"奇点",
    "smsContent":"短信登陆异常败",
    "status":1,
    "operatorId":0,
    "province":"山西省",
    "ipAddr":"192.168.0.244",
    "fee":65
  }
  ```

  ```json
  POST /sms_logs_index/_doc
  {
    "createTime":"2020-07-07 12:00:00",
    "sendTime":"2020-07-07 12:00:00",
    "longCode":"2020707120000",
    "mobile":"18700137771",
    "cropName":"奇点",
    "smsContent":"邮件验证码登陆异常败",
    "status":1,
    "operatorId":2,
    "province":"山东省",
    "ipAddr":"192.168.0.164",
    "fee":55
  }
  ```

  ```json
  POST /sms_logs_index/_doc
  {
    "createTime":"2020-07-08 12:00:00",
    "sendTime":"2020-07-08 12:00:00",
    "longCode":"2020708120000",
    "mobile":"187001378871",
    "cropName":"奇点",
    "smsContent":"邮件验证码登陆成功",
    "status":0,
    "operatorId":2,
    "province":"山东省",
    "ipAddr":"192.168.0.124",
    "fee":55
  }
  ```

  ```json
  POST /sms_logs_index/_doc
  {
    "createTime":"2020-07-10 12:00:00",
    "sendTime":"2020-07-10 12:00:00",
    "longCode":"2020710120000",
    "mobile":"187001377971",
    "cropName":"奇点",
    "smsContent":"不知道发什么内容了",
    "status":1,
    "operatorId":2,
    "province":"山东省",
    "ipAddr":"192.168.0.154",
    "fee":55
  }
  ```


1. term查询：代表完全匹配，搜索之前不会对搜索关键字进行分词，直接用关键字去文档分词库中去匹配内容

   ```json
   POST /sms_logs_index/_search
   {
     "from":0,
     "size":5,
     "query":{
       "term":{
         "longCode": {
           "value":"2020710120000"
         }
       }
     }
   }
   ```

2. terms查询：和term查询机制是一样的，terms针对的是一个字段中包含多个值的的时候使用

   ```json
   POST /sms_logs_index/_search
   {
     "query": {
       "terms": {
         "longCode": [
           "2020701120000",
           "2020705120000",
           "2020707120000"
         ]
       }
     }
   }
   ```

3. match查询：属于高层查询，会根据查询字段类型的不同，采用不同的查询方式，查询日期或数字时会将字符串形式转为日期或数值

   - 如果查询的的内容是一个不能被分词的内容，match查询不会对指定的查询关键字进行分词查询
   - 如果查询的内容是一个可以被分词的内容，match查询会将指定的查询关键字进行分词处理
   - match底层也是term查询，将多个term查询的结果分钟为一个结果

   ```json
   POST /sms_logs_index/_search
   {
     "query": {
       "match": {
         "smsContent": "激活"
       }
     }
   }
   ```

   - operator：表示多个条件的关系:and or

   ```json
   POST /sms_logs_index/_search
   {
     "query": {
       "match": {
         "smsContent": {
           "query": "邮 败",
           "operator": "and"
         }
       }
     }
   }
   ```

4. match_all：查询所有，默认返回10条

   ```json
   POST /sms_logs_index/_search
   {
     "query": {
       "match_all": {}
     }
   }
   ```

5. multi_match：针对多个filed进行检索

   ```json
   POST /sms_logs_index/_search
   {
     "query": {
       "multi_match": {
         "query": "山",
         "fields": ["province","smsContent"]
       }
     }
   }
   ```

6. 通过id查询

   ```json
   GET /sms_logs_index/_doc/ziHIw3MBHuQcg1zLPCJY
   ```

   ```json
   POST /sms_logs_index/_search
   {
     "query": {
       "ids": {
         "values": ["AiHKw3MBHuQcg1zLSSMz","ziHIw3MBHuQcg1zLPCJY"]
       }
     }
   }
   ```

7. perfix：前缀匹配查询

   ```json
   POST /sms_logs_index/_search
   {
     "query": {
       "prefix": {
         "mobile": {
           "value": "187"
         }
       }
     }
   }
   ```

8. fuzzy查询：模糊查询，输入字符的大概就可以查询，查询不稳定

   ```json
   POST /sms_logs_index/_search
   {
     "query": {
       "fuzzy": {
         "mobile": {
           "value": "187",
           "prefix_length": 3		# 太模糊效率低，指定前三个字符不能错
         }
       }
     }
   }
   ```

9. wildcard：和mysql的like是一个套路，在查询关键字中指定通配符*和占位符?

   ```json
   POST /sms_logs_index/_search
   {
     "query": {
       "wildcard": {
         "smsContent": {
           "value": "*信"
         }
       }
     }
   }
   
   ```

10. range：只能针对数值类型的查询，字符串范围查询无效

   - gt
   - gte
   - lt
   - lte

   ```json
   POST /sms_logs_index/_search
   {
     "query": {
       "range": {
         "fee": {
           "gte": 10,
           "lte": 60
         }
       }
     }
   }
   ```

11. regexp：正则查询，prefix、fuzzy、wildcard、regexp查询效率低

    ```json
    POST /sms_logs_index/_search
    {
      "query": {
        "regexp": {
          "mobile": "[0-9]{3}0013[-0-9]{4}"
        }
      }
    }
    ```

12. scroll

    - 分页：es对form和size查询有限制，如果form和size的范围超过一半，效率是非常非常慢，
    - scroll是深分页，效率高但是不适合实时查询

    ```json
    POST /sms_logs_index/_search?scroll=1m
    {
      "size": 2, 
      "sort": [
        {
          "createTime": {
            "order": "asc"
          }
        }
      ], 
      "query": {
        "match_all": {}
      }
    }
    ```

    - 根据scroll分页检索：每次查询都会从内存总获取下一页的数据

    ```json
    POST /_search/scroll
    {
      "scroll_id":"内存中的id",
      "scroll":"1m"
    }
    ```

    - 从内存中删除

    ```json
    DELETE /_search/scroll/scroll_id
    ```

13. delete-by-qyery：根据各种查询方式删除文档

    ```json
    POST /sms_logs_index/_delete_by_query
    {
      "query": {
        "range": {
          "fee": {
            "gte": 40,
            "lte": 50
          }
        }
      }
    }
    
    ```

14. 符合查询bool：复合过滤器，将多个查询条件，以一定逻辑组合在一起

    - mast：所有条件用mast组合，and
    - must_not：全部都不匹配，not
    - should：全部条件组合在一起,or

    ```json
    POST /sms_logs_index/_search
    {
      "query": {
        "bool": {
          "must": [
            {
              "term": {
                "status": {
                  "value": "1"
                }
              }
            },
            {
              "term": {
                "fee": {
                  "value": "15"
                }
              }
            }
          ],
          "must_not": [
            {
              "term": {
                "operatorId": {
                  "value": "1"
                }
              }
            }
          ],
          "should": [
            {
              "match": {
                "smsContent": "短"
              }
            }
          ]
        }
      }
    }
    ```

15. 复合查询boosting：帮助查询影响查询结果的scroll分数

    - positive：只有匹配上positive的内容才会放在结果集中
    - negative：匹配上positive并且匹配上negative，就可以降低文档分数
    - negative_boost：指定系数，如：必须小于1.0
    - 分数计算
      - 搜索关键字匹配次数越多，分数越高
      - 搜索是文档越短，匹配度越高
      - 搜索关键字被分词，分词的内容被分词库匹配的越多匹配越高

    ```json
    POST /sms_logs_index/_search
    {
      "query": {
        "boosting": {
          "positive": {			# 匹配结果器
            "term": {
              "smsContent": {
                "value": "激"
              }
            }
          },
          "negative": {			# 匹配结果器并且匹配negative
            "match": {
              "fee": "25"
            }
          },
          "negative_boost": 0.2	# 就把这个数据的scroll分数降低0.2
        }
      }
    }
    ```

16. filter查询：根据查询条件查询文档，不计算分数，filter会对经常过滤的数据进行缓存

    ```json
    POST /sms_logs_index/_search
    {
      "query": {
        "bool": {
          "filter": [
            {
              "term": {
                "smsContent": "短"
              }
            },
            {
              "range": {
                "fee": {
                  "gte": 20,
                  "lte": 30
                }
              }
            }
          ]
        }
      }
    }
    ```

17. 高亮显示：query的同级属性heightlight

    - fragment_size：指定高亮展示数据的字符数
    - pre_tags：指定前缀标签
    - post_tags：指定后缀标签

    ```json
    POST /sms_logs_index/_search
    {
      "query": {
        "match": {
          "smsContent": "信"
        }
      },
      "highlight": {
        "fields": {
          "smsContent":{}
        }
      }
    }
    ```

18. 聚合查询cardinality

    ```json
    POST /sms_logs_index/_search
    {
      "aggs": {
        "agg": {
          "cardinality": {
            "field": "fee"
          }
        }
      }
    }
    ```

19. 聚合查询range

    ```json
    
    ```

20. 聚合查询extended_stats

    ```json
    
    ```

21. 经纬度

    - 数据准备

      ```json
      
      ```

    - 经纬度查询

      ```json
      
      ```

## 3.5 ElasticSearch集群

1. 集群（Cluster）：一个集群就是就是由一个或多个服务器节点组织在一起，共同持有整个数据，并一起提供索引功能。一个ElasticSearch集群由一个唯一的名称标识，集群中节点只能通过指定某个集群名称来加入到这个集群

2. 节点（Node）：集群中包含很多ES服务器，一个节点就是一个服务器；

3. 集群搭建

   - Windows系统：修改配置文件、
   - Linux系统：
   - Docker环境：

4. 核心概念

   - 索引：
   - 类型：过时，默认是_doc
   - 文档
   - 字段
   - 映射：索引中文档字段的约束
   - 分片：一个索引会非常大，索引可以分片，放在不同的服务中，可以水平切割，并且支持分布式查询；
   - 副本：单个分片的服务宕机后使用分片副本保证数据

5. 系统架构：有一个master

6. 但节点集群

   - 创建索引并指定分片和副本

     ```json
     {
       "settings": {
         "number_of_shards": 5,
         "number_of_replicas": 1
       }
     }
     ```

7. 故障转移：当集群中只有一个节点在运行时，意味着会有单点故障问题（没有冗余），解决方案时再启动一个节点即可防止数据丢失。节点加入集群后副本会重新分配

8. 水平扩容：正在增长的应用添加ES服务容量，需要添加新的服务节点：为了分散负载对分片重新分配；主分片的数量在创建索引时候就确定下来了，实际上这个数目定义了这个索引能够储存的最大数据量，但是读操作可以同时被主分片和副本分片所处理，所以副本可以提高检索吞吐量；

9. 应对故障：主节点宕机后，master被从节点获取，再复活后变成了从节点；

10. 路由计算：hash主键并且对分片数量取模，计算的结果就是分片索引；查询时候由分片控制去哪个分片查询；

11. 数据写流程：客户端请求集群、协调节点将请求分发到指定节点、主分片保存数据、主分片将数据分发给副本、副本保存成功反馈、主分片反馈、客户端获取反馈；通过一致性参数进行设置

12. 数据读流程：请求发送到集群协调节点、协调节点计算数据所在分片以及全部副本位置、将请求转发给指定节点、返回查询结果

13. 更新流程：部分更新需要先读取再更新；

14. 批量新增流程：

15. 分片远离：分片是ES最小工作单元，

16. 倒排索引：

17. 文档搜索：

## 3.6 Java连接ElasticSearch

## 3.6 SpringBoot集成ElasticSearch

1. 概述：

2. 客户端类型

   - Java Client [8.1]：这是 Elasticsearch 的官方 Java API 客户端的文档。客户端为所有 Elasticsearch API 提供强类型请求和响应。
   - Java REST Client (过期) [7.17] ：Java REST 客户端已弃用，取而代之的是 Java API 客户端。包括①Java Low Level REST Client：低级客户端，允许通过 http 与 Elasticsearch 集群通信②Java High Level REST Client：基于低级客户端，它公开 API 特定的方法，并负责请求编组和响应解编组。
   - Java Transport Client (过期) [7.17]：TransportClient 已弃用，取而代之的是 Java 高级 REST 客户端，并将在 Elasticsearch 8.0 中删除。Java Transport Client是Java操作ES的一种客户端，是ES5版本就存在的一中API操作方式

3. 安装依赖

   - gradle 

     ```groovy
     dependencies {
         implementation 'co.elastic.clients:elasticsearch-java:8.1.0'
         implementation 'com.fasterxml.jackson.core:jackson-databind:2.12.3'
     }
     ```

   - maven

     ```xml
     <dependencies>
         <dependency>
             <groupId>co.elastic.clients</groupId>
             <artifactId>elasticsearch-java</artifactId>
             <version>8.1.0</version>
         </dependency>
         <dependency>
             <groupId>com.fasterxml.jackson.core</groupId>
             <artifactId>jackson-databind</artifactId>
             <version>2.12.3</version>
         </dependency>
     </dependencies>
     ```

4. 链接ES核心组件

   - API client classes：它们为 Elasticsearch API 提供强类型数据结构和方法。由于 Elasticsearch API 很大，它以功能组（也称为“命名空间”）的形式构成，每个组都有自己的客户端类。 Elasticsearch 核心功能在 ElasticsearchClient 类中实现。
   - A JSON object mapper：这会将您的应用程序类映射到 JSON 并将它们与 API 客户端无缝集成。
   - A transport layer implementation：这是所有 HTTP 请求处理发生的地方。

5. 组合三个组件，建立链接

   ```java
   // Create the low-level client
   RestClient client = RestClient.builder(new HttpHost("localhost", 9200)).build();
   // 创建 the transport with a Jackson mapper
   ElasticsearchTransport tp = new RestClientTransport(client, new JacksonJsonpMapper());
   // 创建 the API client
   ElasticsearchClient client = new ElasticsearchClient(tp);
   ```

6. 发送请求测试

   ```java
   SearchResponse<Product> search = 
       client.search(s -> s
                     .index("products")
                     .query(q -> q
                            .term(t -> t
                                  .field("name")
                                  .value(v -> v.stringValue("bicycle"))
                                 )),
                     Product.class);
   
   for (Hit<Product> hit: search.hits().hits()) {
       processProduct(hit.source());
   }
   ```

7. 从High Level Rest Client客户端迁移：Java API Client是一个权限的客户端，与旧的High Level Rest Client没有任何关系，提供了一个独立于ES服务器代码的库，并为索引的ES功能提供API，因此从HLRC迁移的开销并不大：迁移策略

   - 保持原有的API，新增的请求使用JavaAPI
   - 重写应用程序中JavaAPI客户端的部分
   - 利用新的Java API与JSON映射修改

8. 作为ES的http传输，同样可以使用HLRC

   ```java
   // Create the low-level client
   RestClientBuilder builder = RestClient.builder(new HttpHost("localhost", 9200));
   
   // Create the HLRC
   RestHighLevelClient hlrc = new RestHighLevelClient(builder);
   
   // Create the new Java Client with the same low level client
   ElasticsearchTransport tr = new RestClientTransport(hlrc.getLowLevelClient(),new JacksonJsonpMapper());
   
   ElasticsearchClient esClient = new ElasticsearchClient(tr);
   ```

9. Java Api Client

10. 源代码

    -  https://github.com/elastic/elasticsearch-java/

# 第四章 Elasticsearch优化

# 第五章 Elasticsearch 集群



# 第六章 Kibana基础



# 第五章 LogStash基础

# 第六章 Beats基础

RESTful接口说明接口

> 在ElasticSearch中，提供了丰富的RESTful API的操作完成基本的crud、创建索引、删除索引等

1. **创建非结构化索引**

   ​		在Lucene中创建索引是需要定义字段名称以及字段类型的，在ElasticSearch中提供了非结构化索引（表结构不固定），就是不需要创建索引结构即可将数据写入到索引中，实际上ElasticSearch底层会进行结构化操作，此操作用户是不需要关注的。

   - 创建空索引：<kbd>PUT 请求 --> ElasticSearch服务地址/索引名称</kbd>

     ```json
     # http://120.27.22.124:9200/panda
     {
     	"settings":{
     		"index":{
     			"number_of_shard":"2",
     			"number_of_replicas":"0"
     		}
     	}
     }
     ```

   - 删除索引：<kbd>DELETE请求 --> ElasticSearch服务地址/索引名称</kbd>

     ```json
     # http://120.27.22.124:9200/panda
     ```

2. **插入数据**

   - URL规则：<kbd>POST请求 --> ElasticSearch服务地址/{索引}/{类型}/{id}</kbd>

     ```json
     # http://120.27.22.124:9200/panda/emp/<001> ID可以不指定,会自动生成
     {
         "name":"张三",
         "age":23,
         "gender":"男"
     }
     
     # 响应：result的值是created
     {
         "result": "created",
     }
     ```

3. **更新数据：**ElasticSearch本质是不允许更新，可以采用同ID文档进行覆盖完成更新，全量覆盖

   - 全量覆盖URL规则：<kbd>PUT请求 --> ElasticSearch服务地址/{索引}/{类型}/{id}</kbd>

     ```json
     # http://127.0.0.1:9200/panda/user/1001
     {
     	"id":"1002",
         "name":"盈盈",
         "age":13,
         "gender":"女"
     }
     
     # 响应：result的值是updated并且_version的值会自增1
     {
         "_version": 2,
         "result": "updated",
     }
     ```

   - 局部更新URL规则：<kbd>POST请求 --> ElasticSearch服务地址/{索引}/{类型}/{id}/_update</kbd>，需要更新的自动用doc包装

     ```json
     # http://127.0.0.1:9200/panda/user/1001/_update
     {
     	"doc":{
     		"name":"令狐冲"
     	}
     }
     ```

4. **删除数据：**删除不存在的数据会出异常

   - 删除URL：<kbd>DELETE请求 --> ElasticSearch服务地址/{索引}/{类型}/{id}</kbd>

     ```http
     http://127.0.0.1:9200/panda/user/1001 删除不会立即移除出磁盘,等后续删除步骤一起执行
     ```

5. **搜索数据**

   - 使用ID进行搜索：<kbd>GET请求 --> ElasticSearch服务地址/{索引}/{类型}/{id}</kbd>

     ```http
     http://127.0.0.1:9200/panda/user/1001
     ```

   - 返回全部（默认10条）数据：<kbd>GET请求 --> ElasticSearch服务地址/{索引}/{类型}/{id}/_search</kbd>

     ```http
     http://127.0.0.1:9200/panda/user/_search
     ```

   - 使用查询参数：<kbd>GET请求 --> ElasticSearch服务地址/{索引}/{类型}/{id}/_search?q=字段:条件值</kbd>

     ```http
     http://127.0.0.1:9200/panda/user/_search?q=age:>20
     ```

6. **DSL搜索：**ElasticSearch提供丰富灵活的查询语言，领域特定语言

   - 基本格式：<kbd>POST请求 --> ElasticSearch服务地址/{索引}/{类型}/{id}/_search</kbd>

     ```json
     {
         "quary":{
             "查询类型":{
                 "字段":"值"
             }
         }
     }
     ```

     - 查询类型：

7. **高亮显示**

8. **聚合**

RESTful接口说明

- get请求

  ```http
  http://ip:端口/index	 				// 查询索引信息
  http://ip:端口/index/type/dock_id		// 查询指定的文档信息
  ```

- post请求

  ```http
  http://ip:端口/index/type/_search			// 查询,请求体包含json参数
  http://ip:端口/index/type/_update			// 修改,请求体包含json参数
  ```

- put请求

  ```http
  http://ip:端口/index					// 创建索引,请求体包含索引信息
  http://ip:端口/index/type/_mappings	// 代表创建索引时候,指定索引文档存储的属性的信息
  ```

- delete请求

  ```http
  http://ip:端口/index					// 删库跑路
  http://ip:端口/index/type/dock_id		// 删除指定的文档信息
  ```

3.1 文档

- 元数据：matedata

  ```json
  {
      "_index":"索引",
      "_type":"对象类型",
      "_id":"文档唯一主键"
  }
  ```

  > - _index：类似关系型数据库中的数据库，是ES存储和索引关联数据的地方；事实上，ES的数据被存储在分片上，索引只是一个把一个或多个分片组在一起的逻辑空间，而对程序而言，文档是存储在索引中
  > - _type：在应用中，万物皆对象，某一类对象可以抽象为一种类型，type用于描述数据的类型，意味着同一类型的数据表示相同的事物。在ES中每个类型都有自己 映射或者结构定义
  > - _id：如果不手动指定就由ES自动生成32为字符串，用于唯一标识文档

3.2 查询相应

1.  **pretty：格式化查询结果**

   ```http
   http://127.0.0.1:9200/panda/user/_search?pretty
   ```

2. **_source=指定相应字段**

   - `?_source=age,name`返回列表中指定字段

     ```http
     http://127.0.0.1:9200/panda/user/_search?_source=age,name
     ```

   - `/id/_source`：只返回实体数据

     ```http
     http://127.0.0.1:9200/panda/user/1001/_source
     ```

   - `/id/_source?_source=age`：返回实体数据的指定字段

     ```sh
     http://127.0.0.1:9200/panda/user/1001/_source?_source=age
     ```

3.3 判断文档是否存在

1. 根据查询结果的`found`属性：true标识存在，false表示不存在
2. 发送HEAD请求：相应200表示存在，否则表示不存在

3.4 批量操作

1. 批量查询：<kbd>POST请求 --> ElasticSearch服务地址/{索引}/{类型}/_mget</kbd>

   ```json
   # http://127.0.0.1:9200/panda/user/_mget
   {
   	"ids":["1001","1002"]
   }
   ```

2. _bulk：批量插入、修改、删除； <kbd>POST请求 --> ElasticSearch服务地址/{索引}/{类型}/\bulk</kbd>

   ```json
   {"动作":{"_index":"索引","_type":"类型","_id":"主键"}}
   {请求体}\n
   ```

   > - 动作：create=插入、update=修改、delete=删除
   >   - delete没有请求体
   > - 请求体后必须有换行符

3. 批量请求性能说明：ES批量操作的最佳性能

   - 批量请求是需要被加载到接受请求节点的内存中，所以请求越大，其他请求的内存就越小
   - 最佳的请求大小取决与硬件、文档大小、复杂度以及索引和要搜素的负载

3.5 分页

- form：起始偏移量

- size：每页显示数量

  ```json
  GET /_search?size=5
  GET /_search?size=5&from=10
  ```

3.6 映射

​		ES可以进行明确的字段类型说明，在操作数据时候可以根据数据类型判断数据与实际字段是否符合

- 自动判断规则

  | JSON Type               | 字段类型  |
  | ----------------------- | --------- |
  | Boolean值:true 或 false | "boolean" |
  | 整数数字                | "long"    |
  | 小数数字                | "double"  |
  | 日期格式的字符串        | "date"    |
  | 包含字母等字符串        | "string"  |

- ES中支持的数据类型

  | 类型     | 表示的数据类型             |
  | -------- | -------------------------- |
  | String   | string、text、keyword      |
  | number   | byte、short、integer、long |
  | floating | float、double              |
  | Boolean  | boolean                    |
  | Date     | date                       |

  > - string类型在旧版ES中使用，在ES5.x版本之后不再支持string，由text和keyword替代
  > - text类型：当一个字段是要被全文搜素的，应该使用text类型，设置text类型后，字段内容会被分析，在生成倒排索引以前，字符串会被分析器分成一个个的词项，text类型的字段不用于排序，很少用聚合
  > - keyword类型：适用于索引结构化的字段，keyword字段只能通过精确值搜索到

- 创建明确类型的索引

  ```json
  # http://127.0.0.1:9200/panda
  {
      "settings":{
          "number_of_shards":2,
          "number_of_replicas":1
       }, 
      "mappings" : {
          "properties":{
              "id":{
                  "type":"text"
              },
              "title":{
                  "type":"text"
              },
              "content":{
                  "type":"text"
              }
          }
      }
  }
  ```

- 查询映射

  ```http
  GET /索引/类型/_mapping
  ```

  

3.7 结构化查询

1. ES介绍

   

2. ES安装

3. ES基本操作

4. ES Java

5. ES练习

6. ES查询进阶