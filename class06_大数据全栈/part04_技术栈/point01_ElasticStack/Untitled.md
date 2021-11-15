# 什么是ElasticSearch

- 为了搜索和分析
- Elasticsearch是Elastic Stack的核心，Elastic Stack中的Logstash 和 Beats 用于于收集、聚合和丰富数据并将其存储在 Elasticsearch 中Kibana 使您能够以交互方式探索、可视化和共享对数据的洞察，并管理和监控堆栈。
- Elasticsearch 为所有类型的数据提供近乎实时的搜索和分析
- Elasticsearch 都可以以支持快速搜索的方式高效地存储和索引它
- 随着您的数据和查询量的增长，Elasticsearch 的分布式特性使您的部署能够随之无缝增长。 

## 数据输入：文档和索引编辑

- 当集群中有多个 Elasticsearch 节点时，存储的文档分布在整个集群中，并且可以从任何节点立即访问
-  Elasticsearch 是一个分布式文档存储。 Elasticsearch 是存储已序列化为 JSON 文档的复杂数据结构。
- 存储文档后，它会被编入索引，并且可以近乎实时地（在 1 秒内）完全搜索。 倒排索引列出出现在任何文档中的每个唯一单词，并标识每个单词出现在的所有文档。 索引可以被认为是文档的优化集合，每个文档都是字段的集合，这些字段是包含数据的键值对。默认情况下，Elasticsearch 索引每个字段中的所有数据，每个索引字段都有一个专用的、优化的数据结构。
- 启用动态映射后，Elasticsearch 会自动检测并将新字段添加到索引中。这种默认行为使索引和探索数据变得容易——只需开始索引文档，Elasticsearch 就会检测并将布尔值、浮点和整数值、日期和字符串映射到适当的 Elasticsearch 数据类型。
- 可以定义规则来控制动态映射并显式定义映射以完全控制字段的存储和索引方式。 定义您自己的映射使您能够： 区分全文字符串字段和精确值字符串字段 执行特定于语言的文本分析 优化部分匹配的字段 使用自定义日期格式 使用无法自动检测的数据类型，

## 信息输出：搜索和分析编辑 

- 构建在 Apache Lucene 搜索引擎库上的全套搜索功能。 Elasticsearch 提供了一个简单、一致的 REST API 来管理您的集群以及索引和搜索您的数据。
-  Elasticsearch REST API 支持结构化查询、全文查询和将两者结合的复杂查询。结构化查询类似于您可以在 SQL 中构造的查询类型。
- 全文查询查找与查询字符串匹配的所有文档，并按相关性排序返回它们
- 您还可以构建 SQL 样式的查询以在 Elasticsearch 内部搜索和聚合本地数据，而 JDBC 和 ODBC 驱动程序使广泛的第三方应用程序能够通过 SQL 与 Elasticsearch 交互。 

 7.15 中的新功能 

- 索引磁盘使用 API 编辑 有一个新的 API 支持分析索引的每个字段的磁盘使用情况，包括整个索引本身。 
- 搜索矢量平铺 API 编辑 有一个新的端点可以从存储在 Elasticsearch 中的地理空间数据生成矢量切片。此功能对于想要在地图上呈现存储在 Elasticsearch 中的地理空间信息的任何应用程序都很有用
- 复合运行时字段编辑 运行时字段支持 grok 和 dissect 模式，但之前仅针对单个字段发出值。您现在可以使用复合运行时字段从单个字段发出多个值。请参阅定义复合运行时字段。

# 快速开始

## 在测试环境中安装和运行 Elasticsearch 

1. ElasticSearchCoud
2. Docker
3. Linux
4. Windows

## 向ElasticSearch发送请求

1. sh

   ```sh
   curl -X GET http://localhost:9200/
   ```

2. kibana

   ```sh
   GET _search
   ```

3. postman

   ```sh
   GET http://localhost:9200/
   ```

## 将数据添加到 Elasticsearch 

1. 添加数据编辑 您将数据作为称为文档的 JSON 对象添加到 Elasticsearch。 Elasticsearch 将这些文档存储在可搜索索引中。 对于时间序列数据，例如日志和指标，您通常将文档添加到由多个自动生成的支持索引组成的数据流中。 数据流需要与其名称匹配的索引模板。 Elasticsearch 使用此模板来配置流的支持索引。发送到数据流的文档必须有一个@timestamp 字段。

   - 添加单个文档

     ```json
     POST logs-my_app-default/_doc
     {
       "@timestamp": "2099-05-06T16:21:15.000Z",
       "event": {
         "original": "192.0.2.42 - - [06/May/2099:16:21:15 +0000] \"GET /images/bg.jpg HTTP/1.0\" 200 24736"
       }
     }
     
     # 响应结果包含元数据:①_index自动生成索引名称②_id自动生成文档ID
     {
       "_index": ".ds-logs-my_app-default-2099-05-06-000001",
       "_type": "_doc",
       "_id": "gl5MJXMBMk1dGnErnBW8",
       "_version": 1,
       "result": "created",
       "_shards": {
         "total": 2,
         "successful": 1,
         "failed": 0
       },
       "_seq_no": 0,
       "_primary_term": 1
     }
     ```

   - 添加多个文档

     ```json
     PUT logs-my_app-default/_bulk
     { "create": { } }
     { "@timestamp": "2099-05-07T16:24:32.000Z", "event": { "original": "192.0.2.242 - - [07/May/2020:16:24:32 -0500] \"GET /images/hm_nbg.jpg HTTP/1.0\" 304 0" } }
     { "create": { } }
     { "@timestamp": "2099-05-08T16:25:42.000Z", "event": { "original": "192.0.2.255 - - [08/May/2099:16:25:42 +0000] \"GET /favicon.ico HTTP/1.0\" 200 3638" } }
     ```

2. 查询数据

   - 近乎实时

     ```json
     GET logs-my_app-default/_search
     {
       "query": {
         "match_all": { }
       },
       "sort": [
         {
           "@timestamp": "desc"
         }
       ]
     }
     # 返回
     {
       "took": 2,
       "timed_out": false,
       "_shards": {
         "total": 1,
         "successful": 1,
         "skipped": 0,
         "failed": 0
       },
       "hits": {
         "total": {
           "value": 3,
           "relation": "eq"
         },
         "max_score": null,
         "hits": [
           {
             "_index": ".ds-logs-my_app-default-2099-05-06-000001",
             "_type": "_doc",
             "_id": "PdjWongB9KPnaVm2IyaL",
             "_score": null,
             "_source": {
               "@timestamp": "2099-05-08T16:25:42.000Z",
               "event": {
                 "original": "192.0.2.255 - - [08/May/2099:16:25:42 +0000] \"GET /favicon.ico HTTP/1.0\" 200 3638"
               }
             },
             "sort": [
               4081940742000
             ]
           },
           ...
         ]
       }
     }
     ```

   - 获取特定字段编辑

     ```json
     GET logs-my_app-default/_search
     {
       "query": {
         "match_all": { }
       },
       "fields": [
         "@timestamp"
       ],
       "_source": false,
       "sort": [
         {
           "@timestamp": "desc"
         }
       ]
     }
     # 返回
     {
       ...
       "hits": {
         ...
         "hits": [
           {
             "_index": ".ds-logs-my_app-default-2099-05-06-000001",
             "_type": "_doc",
             "_id": "PdjWongB9KPnaVm2IyaL",
             "_score": null,
             "fields": {
               "@timestamp": [
                 "2099-05-08T16:25:42.000Z"
               ]
             },
             "sort": [
               4081940742000
             ]
           },
           ...
         ]
       }
     }
     ```

   - 时间范围查找

     ```json
     GET logs-my_app-default/_search
     {
       "query": {
         "range": {
           "@timestamp": {
             "gte": "2099-05-05",
             "lt": "2099-05-08"
           }
         }
       },
       "fields": [
         "@timestamp"
       ],
       "_source": false,
       "sort": [
         {
           "@timestamp": "desc"
         }
       ]
     }
     ```

   - 是的

     ```json
     GET logs-my_app-default/_search
     {
       "query": {
         "range": {
           "@timestamp": {
             "gte": "now-1d/d",
             "lt": "now/d"
           }
         }
       },
       "fields": [
         "@timestamp"
       ],
       "_source": false,
       "sort": [
         {
           "@timestamp": "desc"
         }
       ]
     }
     ```

     

## 搜索和排序数据 

## 在搜索期间从非结构化内容中提取字段 

设置弹性搜索 

升级 Elasticsearch 

索引模块 

# 映射 

## 删除映射类型

> 在 Elasticsearch 7.0.0 或更高版本中创建的索引不再接受 _default_ 映射。在 6.x 中创建的索引将继续像以前在 Elasticsearch 6.x 中一样运行。类型在 7.0 中的 API 中已弃用，对索引创建、放置映射、获取映射、放置模板、获取模板和获取字段映射 API 进行了重大更改。

### 什么是映射类型？

从 Elasticsearch 的第一个版本开始，每个文档都存储在一个索引中并分配了一个映射类型。映射类型用于表示被索引的文档或实体的类型，例如 Twitter 索引可能具有用户类型和推文类型。 每个映射类型都可以有自己的字段，因此用户类型可能有一个 full_name 字段、一个 user_name 字段和一个电子邮件字段，而推文类型可能有一个内容字段、一个 tweeted_at 字段，以及像用户类型一样，一个 user_name 字段。

每个文档都有一个包含类型名称的 _type 元数据字段，并且可以通过在 URL 中指定类型名称来将搜索限制为一种或多种类型：

```json
GET twitter/user,tweet/_search
{
  "query": {
    "match": {
      "user_name": "kimchy"
    }
  }
}
```

_type 字段与文档的 _id 结合生成 _uid 字段，因此具有相同 _id 的不同类型的文档可以存在于单个索引中。 映射类型还用于在文档之间建立父子关系，因此类型 question 的文档可以是类型 answer 文档的父级。	

文本分析 

索引模板 

数据流 

摄取管道 

别名 

搜索您的数据 

查询DSL 

聚合 

均衡器 

SQL 脚本编写 

数据管理 ILM：

管理索引生命周期 

自动缩放 

监控集群 

汇总或转换您的数据 

设置集群以实现高可用性 

快照和恢复 

保护弹性堆栈 

守望者 

命令行工具 

如何 REST API 

迁移指南 

发行说明 

依赖和版本

# 第二阶段

