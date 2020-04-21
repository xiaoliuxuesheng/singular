# 第一章 ElasticStack简介

## 1.1 ES的前身ELK

- ELK是Elasticsearch、Logstash、Kibana三大开源框架首字母大写简称，现在对ELK扩展后市面上也被成为Elastic Stack。

## 1.2 ElasticStack简介

[![GfcENQ.png](https://s1.ax1x.com/2020/04/08/GfcENQ.png)](https://imgchr.com/i/GfcENQ)

- 对ELK扩展后对Elastic技术栈的统称，主要包括 Elasticsearch、Kibana、Logstash 以及 Beats 等，能够安全可靠地获取任何来源、任何格式的数据，并且能够实时地对数据进行搜索、分析和可视化。其中，Logstash和Beats负责数据的收集，Kibana负责结果数据的可视化展现，作为核心部分用于数据的分布式存储以及索引。

## 1.3 ES技术栈概要

1. Elasticsearch：是基于Java的分布式搜索引擎，主要特点是：分布式，零配置，自动发现，索引自动分片，索引副本机制，RESTful风格接口，多数据源，自动搜索负载等。
2. logstash：基于Java，是一个开源的用于收集、分析和储存日志的工具
3. Kibana：基于Node，Kibna可以为LogStash和ElasticSearch提供友好的web界面，可以汇总，分析，搜索重要数据
4. Beats是elastic公司开源的一款采集系统监控数据的agent，是在被监控的服务器上以客户端的形式运行的数据收集器统称，可以直接把数据发送给ElasticSearch或者通过LogStash发送给ElasticSearch，然后进行后续的数据分析活动。Beat主要的组成：
   - Packetbeat：是一个网络数据包分析器，用于监控、收集网络流量信息，Packetbeat嗅探服务器直接的流量，解析应用层协议，并关联到消息的处理，支持ICMP（IPV4 and IPV6）、DNS、HTTP、MySql、Redis、PostgrpreSQL、MongoDB等协议
   - Filebeat：用于监控收集服务器日志文件，以取代logstash forwarder
   - Metricbeat：可定期获取外部系统监控指标信息，其可以监控收集Apache、HAProxy、MongoDB、MySql、Nginx、Redis、PostgrpreSQL、Redis、System、ZooKeeper等服务
   - Winlogbeat：用于监控收集Windows的日志信息。

# 第二章 ElasticSearch

## 2.1 简介

​		Elasticsearch 是一个分布式、RESTful 风格的搜索和数据分析引擎，能够解决不断涌现出的各种用例。 作为 Elastic Stack 的核心，它集中存储您的数据，帮助您发现意料之中以及意料之外的情况。

## 2.2 安装

​		版本说明：ElasticSearch发展非常快，在5.0以前ELK各个版本都不统一，所以在ELK5.0以后Elasticstatic技术栈的版本都统一为一个版本号

★ 单机版安装：ElasticSearch不支持root用户运行

1. 创建ElasticSearch用户

   ```sh
   user add elsearch
   ```

2. 解压安装包到安装目录

   ```sh
   
   ```

3. 修改配置文件

   ```sh
   vim conf/elasticsearch.yml
   ```

   ```yaml
   network.host: 0.0.0.0 # 任意IP都可访问
   ```

★ Linux安装



★ Windows安装



★ Docker安装

1. 设置

   ```sh
   vim etc/sysctl.conf
   vm.max_map_count=131072
   
   ```

2. 下载ElasticSearch

   ```sh
   docker pull elasticsearch:7.6.0
   ```

3. 运行镜像启动容器

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

4. 测试安装：http://120.27.22.124:9200/

5. 安装：elstaticstarch-head

   - docker：需要处理服务跨域访问配置

     ```sh
     docker pull mobz/elasticsearch-head:5
     
     docker run -d --name es_head -p 9100:9100 mobz/elasticsearch-head:5
     ```

   - Github：Chrome插件的使用无需处理跨域

     ```sh
     git clone https://github.com/mobz/elasticsearch-head.git
     ```

## 2.3 基本概念说明

### 1. 索引

- 索引是ElasticSearch对逻辑数据的存储，所以它可以分为更小的部分
- 可以把索引看成关系型数据库的表，索引的结构是为快速有效的全文检索准备的，特别是它不存储原始值
- ElasticSearch可以把索引存放在一台机器或者分散在多态服务器上，每个索引有一个或多个分片（shard），每个分片可以有多个副本（replica）。

### 2. 文档

- 存储在Electicsearch中的主要实体叫文档（document），用关系型数据库类比的话，一个文档相当于数据表中的一行记录。
- ElasticSearch和MongoDB中的文档相似，都可以有不同的结构，但在ElasticSearch中，相同字段必须有相同的类型。
- 文档由多个字段组成，每个字段可以多次的出现在同一文档中，这种字段称为**多值字段**，
- 每个字段的类型可以是文本、数值、日期等；字段类型也可以是复杂类型，一个字段可以包含其他子文档或数组；

### 3. 映射

- 所有文档写进索引之前都会先进行分析：如何将输入的文本分隔为词条、哪些词条又会被过滤；这种行为称为映射，一般由用户自定义规则，比如使用中文分词

### 4. 文档类型

- 在ElasticSearch中，一个索引对象可以存储很对不同用途的对象。例如：博客中的文章也可以存储评论数据，是根据文档类型进行区分
- 每个文档类型可以有不同的结构
- 不同的文档类型不能为相同的属性设置不同的类型，例如：同一索引中的所有文档类型中，有一个字段title字段的必须具有相同的类型。

## 2.4 RESTful接口说明

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

# 第三章 ElasticSearch核心详解

## 3.1 文档

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

## 3.2 查询相应

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

## 3.3 判断文档是否存在

1. 根据查询结果的`found`属性：true标识存在，false表示不存在
2. 发送HEAD请求：相应200表示存在，否则表示不存在

## 3.4 批量操作

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

## 3.5 分页

- form：起始偏移量

- size：每页显示数量

  ```json
  GET /_search?size=5
  GET /_search?size=5&from=10
  ```


## 3.6 映射

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

  

## 3.7 结构化查询

