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

4. 



★ Linux安装



★ Windows安装



★ Docker安装

1. 设置

   ```sh
   vim etc/sysctl.conf
   vm.max_map_count=163840
   
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
   ```

   

## 2.3 基本概念说明

## 2.4 RESTful接口说明



# 第二章 Elasticsearch安装

## 2.1 版本说明

## 2.2 Linux系统安装

## 2.3 Windows安装

# 第三章 Elasticsearch入门

## 3.1 Elasticsearch术语



# 第四章 ElasticStack核心

# 第五章 中文分词

# 第六章 ElasticStack集群

# 第七章 集成Java客户端

