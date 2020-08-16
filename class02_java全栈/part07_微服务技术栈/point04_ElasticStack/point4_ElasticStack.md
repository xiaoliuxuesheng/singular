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

<img src='http://m.qpic.cn/psc?/V52xXkY417Nw310rbooN1OUGO41S4u1u/TmEUgtj9EK6.7V8ajmQrEF4zy*CieSN8Uhj8zeDpSgTlBYc5LHj1RyWWS.gDe9xDGXNAQ0cW8YvecBKZpC7ms8MzIKOkg3ybCpIgajVKeH8!/b&bo=LwUlAy8FJQMDORw!&rf=viewer_4&t=5'/>

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

- 新建elk安装目录并上传安装包，并修改elk目录所属

  ```sh
  cd /opt
  mkdir search
  chown elsearch:elsearch search/ -R
  ```

- 切换到elsearch用户完成ElasticSearch的安装

  ```sh
  su - elsearch
  ```

- 将安装包解压到/usr/local/elk/search目录中，解压后需要调整安装包中文件目录

  ```sh
  tar -xzvf xxx.tar.gz -C search/
  ```

- ElasticSearch配置文件详解：/config/

  1. elasticsearch.yml
  
     ```yml
   # ======================== Elasticsearch Configuration =========================
     # https://www.elastic.co/guide/en/elasticsearch/reference/index.html
     # ---------------------------------- Cluster -----------------------------------
     # 集群名称
     #cluster.name: my-application
     # ------------------------------------ Node ------------------------------------
     # 节点名称:
     #node.name: node-1
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
     #cluster.initial_master_nodes: ["node-1", "node-2"]
     # ---------------------------------- Gateway -----------------------------------
     # 在整个集群重新启动后阻塞初始恢复，直到N个节点启动:
     #gateway.recover_after_nodes: 3
     # ---------------------------------- Various -----------------------------------
     # 删除索引时要求显式名称:
     #action.destructive_requires_name: true
     ```
  
  2. jvm.options：ElasticSearch中的host配置不是localhost或127.0.0.1会被认为是生产环境，会多ElasticSearch启动要求比较高；
  
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
  vim /etc/sysctl.conf
  vm.max_map_count=655360
  sysctl -p # 刷新使配置生效
  ```

- root用户开启9200端口

  ```sh
  firewall-cmd --zone=public --add-port=9200/tcp --permanent 
  firewall-cmd --zone=public --add-port=9200/tcp --permanent 
  ```

- elsearch用户启动ElasticSearch服务

  ```sh
  cd /bin
   ./elasticsearch		# 前台启动
   ./elasticsearch -d  	# 后台启动
  ```

- 启动日志：修改系统级的属性，重启服务器

  ```txt
  [1]: max file descriptors [4096] for elasticsearch process is too low, increase to at least [65535]
  [2]: max number of threads [3756] for user [elsearch] is too low, increase to at least [4096]
  [3]: the default discovery settings are unsuitable for production use; at least one of [discovery.seed_hosts, discovery.seed_providers, cluster.initial_master_nodes] must be configured
  ```

- 解决方案

  ```sh
  # ① 最大文件描述不足以满足ELasticSearch
  vim /etc/security/limits.conf
  # >>>>追加 * 号表示所有用户
  * soft nofile 65536
  * hard nofile 131072
  * soft nproc 2048
  * hard nproc 4096
  
  
  # ② 默认进程中的线程数2014太低 最少是4096
  vim /etc/security/limits.d/20-nproc.conf
  # >>>>修改
  *          soft    nproc     4096
  
  # ③ 修改elasticsearch.yml
  cluster.initial_master_nodes: ["node-1"] #这里的node-1为node-name配置的值
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

## 2.5 LogStash安装

## 2.6 Beats - 安装

# 第三章 ElasticSearch基础

## 3.1 ES基本概念

### 1. 索引

- 索引是ElasticSearch对逻辑数据的存储，所以它可以分为更小的部分

- 可以把索引看成关系型数据库的表，索引的结构是为快速有效的全文检索准备的，特别是它不存储原始值

- ElasticSearch可以把索引存放在一台机器或者分散在多态服务器上，每个索引有一个或多个分片（shard），每个分片可以有多个副本（replica）。

- ES服务中可以创建多个索引

  每一个索引默认被分为5片存储

  每个分片都会存在至少一个备份分片

  备份分片默认不会帮助检索数据，当ES压力特别大时候，备份分片才会检索数据

  备份的分片必须放在不同的服务器中

### 2. 文档

- 存储在Electicsearch中的主要实体叫文档（document），用关系型数据库类比的话，一个文档相当于数据表中的一行记录。
- ElasticSearch和MongoDB中的文档相似，都可以有不同的结构，但在ElasticSearch中，相同字段必须有相同的类型。
- 文档由多个字段组成，每个字段可以多次的出现在同一文档中，这种字段称为**多值字段**，
- 每个字段的类型可以是文本、数值、日期等；字段类型也可以是复杂类型，一个字段可以包含其他子文档或数组；

### 3. 映射

- 所有文档写进索引之前都会先进行分析：如何将输入的文本分隔为词条、哪些词条又会被过滤；这种行为称为映射，一般由用户自定义规则，比如使用中文分词

### 4. 文档类型

- 在ElasticSearch中，一个索引对象可以存储很对不同用途的对象。例如：博客中的文章也可以存储评论数据，是根据文档类型进行区分
- 一个索引下可以有多个类型，每个类型下可以有多个文档，每个文档类型可以有不同的结构
  - 在ES5.x中一个索引下可能有多个Type
  - 在ES6.x中一个索引下只有一个Type
  - 在ES7.x中一个索引下没有Type
- 不同的文档类型不能为相同的属性设置不同的类型，例如：同一索引中的所有文档类型中，有一个字段title字段的必须具有相同的类型。

### 5. field

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

1. 新增索引：number_of_shards分片数据；number_of_replicas备份数

   ```json
   PUT /person
   {
     "settings": {
       "number_of_shards": 5,
       "number_of_replicas": 1
     }
   }
   ```

2. 查看索引信息

   ```json
   GET /person
   ```

3. 删除索引

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

## 3.6 Java连接ElasticSearch

## 3.6 SpringBoot集成ElasticSearch

# 第四章 Kibana基础



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