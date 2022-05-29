---
title: 0801-ElasticStack
date: 2008-01-01 00:01:00
tags:
   - ELK
categories: 大数据
---

# 前言

## ElasticSearch

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>ElasticSearch是基于ApacheLucene的开源搜索引擎，Lucene可以被认为迄今为止最先进、性能最好、功能最全的搜索引擎库；但是Lucene是Java语法开发，并且非常复杂，需要对其工作原理要有深入理解；ElasticSearch也使用Java开发并使用Lucene来实现核心功能：分布式索引和搜索功能；ElasticSearch通过RESTful API来隐藏Lucene的复杂性，实现搜索引擎的高可用。

## ELK

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>ELK是Elasticsearch、Kibana、Logstash三个技术的组合，组合使用可以解决大部分软件开发中的日志分析与处理工作，能够安全可靠地获取任何来源、任何格式的数据，并且能够实时地对数据进行搜索、分析和可视化；其中，Logstash负责数据的收集，Kibana负责结果数据的可视化展现，Elasticsearch作为核心部分用于数据的分布式存储以及索引。

## ElasticStack

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>ElasticStack表示ES技术栈，在ELK的基础设基础上新增了Beats技术成员，所以ELK重新改名为ElasticStack；ElasticStack的基本工作流程如下图:

1. Beats将采集的各种数据发送到ElasticSearch或交给LogStash进行数据处理
2. Logstash的主要作用是做数据处理工作
3. ElasticSearch主要是保存数据
4. 最终Kibana连接ElasticSearch将数据可视化展示

![GfcENQ.png](https://s1.ax1x.com/2020/04/08/GfcENQ.png)

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

# 第一部分 ElasticSearch

## 第一章 ES入门

### 1.1 单机版安装

#### 1. Windows系统

- 下载ElasticSearch：`https://www.elastic.co/cn/downloads/elasticsearch`
- 解压下载安装包到指定目录
- 执行es软件包中进入/bin目录：启动elasticsearch.bat脚本文件
- 测试访问：`http://localhost:9200/`

#### 2. Mac系统

#### 3. Linux系统

- 下载Elastic安装包并解压到软件目录：`https://www.elastic.co/cn/downloads/elasticsearch`

- **环境准备**

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

- **修改系统配置**

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

- **ElasticSearch配置文件说明**：在/opt/search/config/目录中的相关文件

  - **elasticsearch.yml**：ElasticSearch的启动配置文件

    ```yaml
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

  - **jvm.options**：ElasticSearch是基于Java开发，jvm.options用于设置ElasticSearch运行时jvm环境相关配置；ElasticSearch中的host配置不是localhost或127.0.0.1会被认为是生产环境，会多ElasticSearch启动要求比较高；

    ```properties
    # Xms 表示总的堆空间的初始大小
    # Xmx 表示堆空间的最大大小
    -Xms128m
    -Xmx128m
    ```

  - log4j2.properties

- 启动ElasticSearch：安装包/bin目录中执行启动脚本，测试ES服务

  ```sh
  curl 127.0.0.1:9200
  ```

#### 4. Docker命令行

- 使用Docker命令行安装

  - 下载ElasticSearch镜像

    ```sh
    docker pull elasticsearch:8.0.1
    ```

  - 将镜像中的配置文件备份到宿主机中的config目录中

  - 使用命令行安装docker：①需要准备好宿主机中config中的配置文件②修改下面命令行中的数据集容器卷路径

    ```sh
    docker run -d --name es801 \
    -p 9200:9200 -p 9300:9300 \
    -v ~/source_docker/es/data:/usr/share/elasticsearch/data \
    -v ~/source_docker/es/config:/usr/share/elasticsearch/config \
    -v ~/source_docker/es/logs:/usr/share/elasticsearch/logs \
    -v ~/source_docker/es/plugins:/usr/share/elasticsearch/plugins \
    -e ES_JAVA_OPTS="-Xms64m -Xmx512m" \
    -e "discovery.type=single-node" elasticsearch:8.0.1
    ```

#### 5. DockerFile安装



#### 6. DockerCompose安装

- 使用Docker命令下载镜像

  ```sh
  docker pull elasticsearch:8.2.0
  docker pull kibana:8.2.0
  docker pull elasticsearch:7.17.3
  docker pull kibana:7.17.3
  ```

- 初始化DockerCompose安装目录

  ```tex
  ElasticSearch8/
  	es8/
  		/data/
  		/logs/
  		/config/
  			/elasticsearch.yml
  			/jvm.options
  			/log4j2.properties
  	kibana/
  		config/kibana.yml
  ```

- 准备配置文件：elasticsearch.yml

  ```yaml
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
  # cluster.initial_master_nodes: ["node-1"]
  # ---------------------------------- Gateway -----------------------------------
  # 在整个集群重新启动后阻塞初始恢复，直到N个节点启动:
  #gateway.recover_after_nodes: 3
  # ---------------------------------- Various -----------------------------------
  # 删除索引时要求显式名称:
  #action.destructive_requires_name: true
  xpack.security.enabled: false
  ```

- 启动需要JVM配置文件：jvm.options

  ```properties
  ## GC configuration
  8-13:-XX:+UseConcMarkSweepGC
  8-13:-XX:CMSInitiatingOccupancyFraction=75
  8-13:-XX:+UseCMSInitiatingOccupancyOnly
  
  ## G1GC Configuration
  # to use G1GC, uncomment the next two lines and update the version on the
  # following three lines to your version of the JDK
  # 8-13:-XX:-UseConcMarkSweepGC
  # 8-13:-XX:-UseCMSInitiatingOccupancyOnly
  14-:-XX:+UseG1GC
  
  ## JVM temporary directory
  -Djava.io.tmpdir=${ES_TMPDIR}
  
  ## heap dumps
  
  # generate a heap dump when an allocation from the Java heap fails; heap dumps
  # are created in the working directory of the JVM unless an alternative path is
  # specified
  -XX:+HeapDumpOnOutOfMemoryError
  
  # exit right after heap dump on out of memory error. Recommended to also use
  # on java 8 for supported versions (8u92+).
  9-:-XX:+ExitOnOutOfMemoryError
  
  # specify an alternative path for heap dumps; ensure the directory exists and
  # has sufficient space
  -XX:HeapDumpPath=data
  
  # specify an alternative path for JVM fatal error logs
  -XX:ErrorFile=logs/hs_err_pid%p.log
  
  ## GC logging
  -Xlog:gc*,gc+age=trace,safepoint:file=logs/gc.log:utctime,pid,tags:filecount=32,filesize=64m
  
  ```

- log4j2.properties：安装包默认的log4j2日志文件

  ```properties
  status = error
  
  appender.console.type = Console
  appender.console.name = console
  appender.console.layout.type = PatternLayout
  appender.console.layout.pattern = [%d{ISO8601}][%-5p][%-25c{1.}] [%node_name]%marker %m%n
  
  ######## Server JSON ############################
  appender.rolling.type = RollingFile
  appender.rolling.name = rolling
  appender.rolling.fileName = ${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs.cluster_name}_server.json
  appender.rolling.layout.type = ECSJsonLayout
  appender.rolling.layout.dataset = elasticsearch.server
  
  appender.rolling.filePattern = ${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs.cluster_name}-%d{yyyy-MM-dd}-%i.json.gz
  appender.rolling.policies.type = Policies
  appender.rolling.policies.time.type = TimeBasedTriggeringPolicy
  appender.rolling.policies.time.interval = 1
  appender.rolling.policies.time.modulate = true
  appender.rolling.policies.size.type = SizeBasedTriggeringPolicy
  appender.rolling.policies.size.size = 128MB
  appender.rolling.strategy.type = DefaultRolloverStrategy
  appender.rolling.strategy.fileIndex = nomax
  appender.rolling.strategy.action.type = Delete
  appender.rolling.strategy.action.basepath = ${sys:es.logs.base_path}
  appender.rolling.strategy.action.condition.type = IfFileName
  appender.rolling.strategy.action.condition.glob = ${sys:es.logs.cluster_name}-*
  appender.rolling.strategy.action.condition.nested_condition.type = IfAccumulatedFileSize
  appender.rolling.strategy.action.condition.nested_condition.exceeds = 2GB
  ################################################
  ######## Server -  old style pattern ###########
  appender.rolling_old.type = RollingFile
  appender.rolling_old.name = rolling_old
  appender.rolling_old.fileName = ${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs.cluster_name}.log
  appender.rolling_old.layout.type = PatternLayout
  appender.rolling_old.layout.pattern = [%d{ISO8601}][%-5p][%-25c{1.}] [%node_name]%marker %m%n
  
  appender.rolling_old.filePattern = ${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs.cluster_name}-%d{yyyy-MM-dd}-%i.log.gz
  appender.rolling_old.policies.type = Policies
  appender.rolling_old.policies.time.type = TimeBasedTriggeringPolicy
  appender.rolling_old.policies.time.interval = 1
  appender.rolling_old.policies.time.modulate = true
  appender.rolling_old.policies.size.type = SizeBasedTriggeringPolicy
  appender.rolling_old.policies.size.size = 128MB
  appender.rolling_old.strategy.type = DefaultRolloverStrategy
  appender.rolling_old.strategy.fileIndex = nomax
  appender.rolling_old.strategy.action.type = Delete
  appender.rolling_old.strategy.action.basepath = ${sys:es.logs.base_path}
  appender.rolling_old.strategy.action.condition.type = IfFileName
  appender.rolling_old.strategy.action.condition.glob = ${sys:es.logs.cluster_name}-*
  appender.rolling_old.strategy.action.condition.nested_condition.type = IfAccumulatedFileSize
  appender.rolling_old.strategy.action.condition.nested_condition.exceeds = 2GB
  ################################################
  
  rootLogger.level = info
  rootLogger.appenderRef.console.ref = console
  rootLogger.appenderRef.rolling.ref = rolling
  rootLogger.appenderRef.rolling_old.ref = rolling_old
  
  ######## Deprecation JSON #######################
  appender.deprecation_rolling.type = RollingFile
  appender.deprecation_rolling.name = deprecation_rolling
  appender.deprecation_rolling.fileName = ${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs.cluster_name}_deprecation.json
  appender.deprecation_rolling.layout.type = ECSJsonLayout
  # Intentionally follows a different pattern to above
  appender.deprecation_rolling.layout.dataset = deprecation.elasticsearch
  appender.deprecation_rolling.filter.rate_limit.type = RateLimitingFilter
  
  appender.deprecation_rolling.filePattern = ${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs.cluster_name}_deprecation-%i.json.gz
  appender.deprecation_rolling.policies.type = Policies
  appender.deprecation_rolling.policies.size.type = SizeBasedTriggeringPolicy
  appender.deprecation_rolling.policies.size.size = 1GB
  appender.deprecation_rolling.strategy.type = DefaultRolloverStrategy
  appender.deprecation_rolling.strategy.max = 4
  
  appender.header_warning.type = HeaderWarningAppender
  appender.header_warning.name = header_warning
  #################################################
  
  logger.deprecation.name = org.elasticsearch.deprecation
  logger.deprecation.level = WARN
  logger.deprecation.appenderRef.deprecation_rolling.ref = deprecation_rolling
  logger.deprecation.appenderRef.header_warning.ref = header_warning
  logger.deprecation.additivity = false
  
  ######## Search slowlog JSON ####################
  appender.index_search_slowlog_rolling.type = RollingFile
  appender.index_search_slowlog_rolling.name = index_search_slowlog_rolling
  appender.index_search_slowlog_rolling.fileName = ${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs\
    .cluster_name}_index_search_slowlog.json
  appender.index_search_slowlog_rolling.layout.type = ECSJsonLayout
  appender.index_search_slowlog_rolling.layout.dataset = elasticsearch.index_search_slowlog
  
  appender.index_search_slowlog_rolling.filePattern = ${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs\
    .cluster_name}_index_search_slowlog-%i.json.gz
  appender.index_search_slowlog_rolling.policies.type = Policies
  appender.index_search_slowlog_rolling.policies.size.type = SizeBasedTriggeringPolicy
  appender.index_search_slowlog_rolling.policies.size.size = 1GB
  appender.index_search_slowlog_rolling.strategy.type = DefaultRolloverStrategy
  appender.index_search_slowlog_rolling.strategy.max = 4
  #################################################
  
  #################################################
  logger.index_search_slowlog_rolling.name = index.search.slowlog
  logger.index_search_slowlog_rolling.level = trace
  logger.index_search_slowlog_rolling.appenderRef.index_search_slowlog_rolling.ref = index_search_slowlog_rolling
  logger.index_search_slowlog_rolling.additivity = false
  
  ######## Indexing slowlog JSON ##################
  appender.index_indexing_slowlog_rolling.type = RollingFile
  appender.index_indexing_slowlog_rolling.name = index_indexing_slowlog_rolling
  appender.index_indexing_slowlog_rolling.fileName = ${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs.cluster_name}\
    _index_indexing_slowlog.json
  appender.index_indexing_slowlog_rolling.layout.type = ECSJsonLayout
  appender.index_indexing_slowlog_rolling.layout.dataset = elasticsearch.index_indexing_slowlog
  
  
  appender.index_indexing_slowlog_rolling.filePattern = ${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs.cluster_name}\
    _index_indexing_slowlog-%i.json.gz
  appender.index_indexing_slowlog_rolling.policies.type = Policies
  appender.index_indexing_slowlog_rolling.policies.size.type = SizeBasedTriggeringPolicy
  appender.index_indexing_slowlog_rolling.policies.size.size = 1GB
  appender.index_indexing_slowlog_rolling.strategy.type = DefaultRolloverStrategy
  appender.index_indexing_slowlog_rolling.strategy.max = 4
  #################################################
  
  
  logger.index_indexing_slowlog.name = index.indexing.slowlog.index
  logger.index_indexing_slowlog.level = trace
  logger.index_indexing_slowlog.appenderRef.index_indexing_slowlog_rolling.ref = index_indexing_slowlog_rolling
  logger.index_indexing_slowlog.additivity = false
  
  
  logger.com_amazonaws.name = com.amazonaws
  logger.com_amazonaws.level = warn
  
  logger.com_amazonaws_jmx_SdkMBeanRegistrySupport.name = com.amazonaws.jmx.SdkMBeanRegistrySupport
  logger.com_amazonaws_jmx_SdkMBeanRegistrySupport.level = error
  
  logger.com_amazonaws_metrics_AwsSdkMetrics.name = com.amazonaws.metrics.AwsSdkMetrics
  logger.com_amazonaws_metrics_AwsSdkMetrics.level = error
  
  logger.com_amazonaws_auth_profile_internal_BasicProfileConfigFileLoader.name = com.amazonaws.auth.profile.internal.BasicProfileConfigFileLoader
  logger.com_amazonaws_auth_profile_internal_BasicProfileConfigFileLoader.level = error
  
  logger.com_amazonaws_services_s3_internal_UseArnRegionResolver.name = com.amazonaws.services.s3.internal.UseArnRegionResolver
  logger.com_amazonaws_services_s3_internal_UseArnRegionResolver.level = error
  
  
  appender.audit_rolling.type = RollingFile
  appender.audit_rolling.name = audit_rolling
  appender.audit_rolling.fileName = ${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs.cluster_name}_audit.json
  appender.audit_rolling.layout.type = PatternLayout
  appender.audit_rolling.layout.pattern = {\
                  "type":"audit", \
                  "timestamp":"%d{yyyy-MM-dd'T'HH:mm:ss,SSSZ}"\
                  %varsNotEmpty{, "cluster.name":"%enc{%map{cluster.name}}{JSON}"}\
                  %varsNotEmpty{, "cluster.uuid":"%enc{%map{cluster.uuid}}{JSON}"}\
                  %varsNotEmpty{, "node.name":"%enc{%map{node.name}}{JSON}"}\
                  %varsNotEmpty{, "node.id":"%enc{%map{node.id}}{JSON}"}\
                  %varsNotEmpty{, "host.name":"%enc{%map{host.name}}{JSON}"}\
                  %varsNotEmpty{, "host.ip":"%enc{%map{host.ip}}{JSON}"}\
                  %varsNotEmpty{, "event.type":"%enc{%map{event.type}}{JSON}"}\
                  %varsNotEmpty{, "event.action":"%enc{%map{event.action}}{JSON}"}\
                  %varsNotEmpty{, "authentication.type":"%enc{%map{authentication.type}}{JSON}"}\
                  %varsNotEmpty{, "user.name":"%enc{%map{user.name}}{JSON}"}\
                  %varsNotEmpty{, "user.run_by.name":"%enc{%map{user.run_by.name}}{JSON}"}\
                  %varsNotEmpty{, "user.run_as.name":"%enc{%map{user.run_as.name}}{JSON}"}\
                  %varsNotEmpty{, "user.realm":"%enc{%map{user.realm}}{JSON}"}\
                  %varsNotEmpty{, "user.run_by.realm":"%enc{%map{user.run_by.realm}}{JSON}"}\
                  %varsNotEmpty{, "user.run_as.realm":"%enc{%map{user.run_as.realm}}{JSON}"}\
                  %varsNotEmpty{, "user.roles":%map{user.roles}}\
                  %varsNotEmpty{, "apikey.id":"%enc{%map{apikey.id}}{JSON}"}\
                  %varsNotEmpty{, "apikey.name":"%enc{%map{apikey.name}}{JSON}"}\
                  %varsNotEmpty{, "authentication.token.name":"%enc{%map{authentication.token.name}}{JSON}"}\
                  %varsNotEmpty{, "authentication.token.type":"%enc{%map{authentication.token.type}}{JSON}"}\
                  %varsNotEmpty{, "origin.type":"%enc{%map{origin.type}}{JSON}"}\
                  %varsNotEmpty{, "origin.address":"%enc{%map{origin.address}}{JSON}"}\
                  %varsNotEmpty{, "realm":"%enc{%map{realm}}{JSON}"}\
                  %varsNotEmpty{, "url.path":"%enc{%map{url.path}}{JSON}"}\
                  %varsNotEmpty{, "url.query":"%enc{%map{url.query}}{JSON}"}\
                  %varsNotEmpty{, "request.method":"%enc{%map{request.method}}{JSON}"}\
                  %varsNotEmpty{, "request.body":"%enc{%map{request.body}}{JSON}"}\
                  %varsNotEmpty{, "request.id":"%enc{%map{request.id}}{JSON}"}\
                  %varsNotEmpty{, "action":"%enc{%map{action}}{JSON}"}\
                  %varsNotEmpty{, "request.name":"%enc{%map{request.name}}{JSON}"}\
                  %varsNotEmpty{, "indices":%map{indices}}\
                  %varsNotEmpty{, "opaque_id":"%enc{%map{opaque_id}}{JSON}"}\
                  %varsNotEmpty{, "trace.id":"%enc{%map{trace.id}}{JSON}"}\
                  %varsNotEmpty{, "x_forwarded_for":"%enc{%map{x_forwarded_for}}{JSON}"}\
                  %varsNotEmpty{, "transport.profile":"%enc{%map{transport.profile}}{JSON}"}\
                  %varsNotEmpty{, "rule":"%enc{%map{rule}}{JSON}"}\
                  %varsNotEmpty{, "put":%map{put}}\
                  %varsNotEmpty{, "delete":%map{delete}}\
                  %varsNotEmpty{, "change":%map{change}}\
                  %varsNotEmpty{, "create":%map{create}}\
                  %varsNotEmpty{, "invalidate":%map{invalidate}}\
                  }%n
  # "node.name" node name from the `elasticsearch.yml` settings
  # "node.id" node id which should not change between cluster restarts
  # "host.name" unresolved hostname of the local node
  # "host.ip" the local bound ip (i.e. the ip listening for connections)
  # "origin.type" a received REST request is translated into one or more transport requests. This indicates which processing layer generated the event "rest" or "transport" (internal)
  # "event.action" the name of the audited event, eg. "authentication_failed", "access_granted", "run_as_granted", etc.
  # "authentication.type" one of "realm", "api_key", "token", "anonymous" or "internal"
  # "user.name" the subject name as authenticated by a realm
  # "user.run_by.name" the original authenticated subject name that is impersonating another one.
  # "user.run_as.name" if this "event.action" is of a run_as type, this is the subject name to be impersonated as.
  # "user.realm" the name of the realm that authenticated "user.name"
  # "user.run_by.realm" the realm name of the impersonating subject ("user.run_by.name")
  # "user.run_as.realm" if this "event.action" is of a run_as type, this is the realm name the impersonated user is looked up from
  # "user.roles" the roles array of the user; these are the roles that are granting privileges
  # "apikey.id" this field is present if and only if the "authentication.type" is "api_key"
  # "apikey.name" this field is present if and only if the "authentication.type" is "api_key"
  # "authentication.token.name" this field is present if and only if the authenticating credential is a service account token
  # "authentication.token.type" this field is present if and only if the authenticating credential is a service account token
  # "event.type" informs about what internal system generated the event; possible values are "rest", "transport", "ip_filter" and "security_config_change"
  # "origin.address" the remote address and port of the first network hop, i.e. a REST proxy or another cluster node
  # "realm" name of a realm that has generated an "authentication_failed" or an "authentication_successful"; the subject is not yet authenticated
  # "url.path" the URI component between the port and the query string; it is percent (URL) encoded
  # "url.query" the URI component after the path and before the fragment; it is percent (URL) encoded
  # "request.method" the method of the HTTP request, i.e. one of GET, POST, PUT, DELETE, OPTIONS, HEAD, PATCH, TRACE, CONNECT
  # "request.body" the content of the request body entity, JSON escaped
  # "request.id" a synthetic identifier for the incoming request, this is unique per incoming request, and consistent across all audit events generated by that request
  # "action" an action is the most granular operation that is authorized and this identifies it in a namespaced way (internal)
  # "request.name" if the event is in connection to a transport message this is the name of the request class, similar to how rest requests are identified by the url path (internal)
  # "indices" the array of indices that the "action" is acting upon
  # "opaque_id" opaque value conveyed by the "X-Opaque-Id" request header
  # "trace_id" an identifier conveyed by the part of "traceparent" request header
  # "x_forwarded_for" the addresses from the "X-Forwarded-For" request header, as a verbatim string value (not an array)
  # "transport.profile" name of the transport profile in case this is a "connection_granted" or "connection_denied" event
  # "rule" name of the applied rule if the "origin.type" is "ip_filter"
  # the "put", "delete", "change", "create", "invalidate" fields are only present
  # when the "event.type" is "security_config_change" and contain the security config change (as an object) taking effect
  
  appender.audit_rolling.filePattern = ${sys:es.logs.base_path}${sys:file.separator}${sys:es.logs.cluster_name}_audit-%d{yyyy-MM-dd}-%i.json.gz
  appender.audit_rolling.policies.type = Policies
  appender.audit_rolling.policies.time.type = TimeBasedTriggeringPolicy
  appender.audit_rolling.policies.time.interval = 1
  appender.audit_rolling.policies.time.modulate = true
  appender.audit_rolling.policies.size.type = SizeBasedTriggeringPolicy
  appender.audit_rolling.policies.size.size = 1GB
  appender.audit_rolling.strategy.type = DefaultRolloverStrategy
  appender.audit_rolling.strategy.fileIndex = nomax
  
  logger.xpack_security_audit_logfile.name = org.elasticsearch.xpack.security.audit.logfile.LoggingAuditTrail
  logger.xpack_security_audit_logfile.level = info
  logger.xpack_security_audit_logfile.appenderRef.audit_rolling.ref = audit_rolling
  logger.xpack_security_audit_logfile.additivity = false
  
  logger.xmlsig.name = org.apache.xml.security.signature.XMLSignature
  logger.xmlsig.level = error
  logger.samlxml_decrypt.name = org.opensaml.xmlsec.encryption.support.Decrypter
  logger.samlxml_decrypt.level = fatal
  logger.saml2_decrypt.name = org.opensaml.saml.saml2.encryption.Decrypter
  logger.saml2_decrypt.level = fatal
  
  ```

- docker-compose.yml

  ```yaml
  # docker network create elk
  version: "3.8"
  services:
    es8:
      image: elasticsearch:8.2.0
      container_name: es8
      ports:
        - "9200:9200"
        - "9300:9300"
      volumes:
        - ./es8/data:/usr/share/elasticsearch/data
        - ./es8/logs:/usr/share/elasticsearch/logs
        - ./es8/config:/usr/share/elasticsearch/config
        - ./es8/plugins:/usr/share/elasticsearch/plugins
      environment:
        - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
        - discovery.type=single-node
    kibana8:
      image: kibana:8.2.0
      container_name: kibana8
      ports:
        - "5601:5601"
      volumes:
        - ./kibana8/config:/usr/share/kibana/config
      environment:
        ELASTICSEARCH_HOSTS: http://es8:9200
        I18N_LOCALE: zh-CN
      depends_on:
          - es8
  networks:
    default:
      external:
        ## 此处名称与上面创建的网络名称一致
        name: elk
  ```

### 1.2 术语

1. **集群（Cluster）**：包含多个节点，每个节点属于哪个集群是通过一个配置（集群名称，默认是elasticsearch）来决定的，集群的目的为了提供高可用和海量数据的存储以及更快的跨节点查询能力。

2. **节点（Node）**：集群中的一个节点，节点也有一个名称（默认是随机分配的），节点名称很重要（在执行运维管理操作的时候），默认节点会去加入一个名称为“elasticsearch”的集群，如果直接启动一堆节点，那么它们会自动组成一个elasticsearch集群，当然一个节点也可以组成一个elasticsearch集群

3. **索引（Index）**：包含一堆有相似结构的文档数据，一个index包含很多document。在关系型数据库中的概念类似于数据库；

4. **类型（type）**：在ElasticSearch版本7以后废除了type概念，但是保留的type代表的意义，ElasticSearch7以后Type默认值是`_doc`；而Type的这个概念任然保持一致，都是用来表示索引中文档的基本模型，在关系型数据库中的概念类似数据表，意思是你个索引（数据库）中包含多个Type（数据表），但是在版本7以后一个索引中只包含一个Type（_doc）

5. **文档（Document）**：是ElasticSearch中最小数据单元，一个document代表一条数据，可以理解为关系型数据库中一行数据；

6. **字段（field）**：一个document里面有多个field，每个field就是一个数据字段，可以理解为关系型数据库中一行数据中的每一列；

7. **映射（mapping）**：非常类似于静态语言中的数据类型或者关系型数据库的表结构。mapping还有一些其他的含义，mapping不仅告诉ES一个field中是什么类型的值， 它还告诉ES如何索引数据以及数据是否能被搜索到。

8. **分片（shard）**：也称 Primary Shard，单台机器无法存储大量数据，es可以将一个索引中的数据切分为多个shard，分布在多台服务器上存储。有了shard就可以横向扩展，存储更多数据，让搜索和分析等操作分布到多台服务器上去执行，提升吞吐量和性能。每个shard都是一个lucene index。primary shard（建立索引时一次设置，不能修改，默认5个）。

9. **副本（Replica）**：任何一个服务器随时可能故障或宕机，此时shard可能就会丢失，因此可以为每个shard创建多个replica副本。replica可以在shard故障时提供备用服务，保证数据不丢失，多个replica还可以提升搜索操作的吞吐量和性能。replica shard（随时修改数量，默认1个）。

10. **正向索引和倒排索引**：索引的最终目的都是通过搜索的关键字检索到关键字对应的完整数据；

    - 正向索引：正向索引的检索过程首先将完整数据的关键数据进行分词，然后通过搜索关键字判断哪些分词中包含有搜索关键字，然后将搜索关键字对应的数据唯一值返回，最后通过这个唯一值查找到完整数据；

      | document的唯一值 | 对数据进行分词，并且使用“中国”查询数据 |
      | ---------------- | -------------------------------------- |
      | 1001             | 我爱中国 -》 我、爱、中国              |
      | 1002             | 我是中国人-》我、是、中国、中国人      |
      | 1003             | 发展中的国家-》发展、发展中、国家      |

    - 倒排索引：倒排索引的索引方式做了改变，也是将数据中的关键数据进行分词，不同的是倒排索引将分词对应的数据的唯一值做映射，如果使用搜索关键字查询时候，如果匹配到分词也就可以得到对应的数据唯一值，然后通过这个唯一值查找到完整数据；比如用上面的三句话用倒排索引生成的结构如下：

      | 分词信息 | <span title='使用假数据演示分词对应的数据的唯一ID值'>数据唯一值</span> |
      | -------- | ------------------------------------------------------------ |
      | 我       | 1001、1002                                                   |
      | 爱       | 1001                                                         |
      | 中国     | 1001、1002                                                   |
      | 中国人   | 1002                                                         |
      | 发展     | 1003                                                         |
      | 发展中   | 1003                                                         |

11. **RestFul风格**

    - GET 请求：获取服务器中的对象，
    - POST 请求：在服务器上更新对象，
    - PUT 请求：在服务器上创建对象，PUT是幂等操，有些接口重复执行不会影响结果，有些接口重复操作会抛出异常
    - DELETE 请求：删除服务器中的对象
    - HEAD 请求：仅仅用于获取对象的基础信息

### 1.3 分词器

#### 1. 分词器概述

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>ElasticSearch是基于Lucene构建的分布式搜索引擎，而分词是词Search是一个构建于Lucene之上的优秀的分布式全文检索引擎（服务器）；ElasticSearch倒排索引的第一步需要将需要被全文检索的内容拆分为可检索的关键字，不同的分词器就会有不同的拆分结果，会直接影响ElasticSearch的检索效率和精确度；总结来说：分词就是**把全文本转换成一系列单词（term/token）的过程**，也叫**文本分析**。在 ES 中，Analysis 是通过**分词器（Analyzer）** 来实现的，可使用 ES 内置的分析器或者按需定制化分析器。

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>分词器主要有三部分组成，三个部分是有顺序的，从上到下依次经过 `Character Filters`，`Tokenizer` 以及 `Token Filters`，这个顺序比较好理解，一个文本进来肯定要先对文本数据进行处理，再去分词，最后对分词的结果进行过滤。

- Character Filters：针对原始文本处理，比如去除 html 标签
- Tokenizer：按照规则切分为单词，比如按照空格切分
- Token Filters：将切分的单词进行加工，比如大写转小写，删除 stopwords，增加同义语

#### 2. 常用分词器

> - 分词关键关键字
>
>   - `analyzer`指定需要的分词器;
>   - `text`指定要拆分的文本
>
> - 分词结果关键字
>
>   -  `token` 为分词结果；
>   -  `start_offset` 为起始偏移；
>   -  `end_offset` 为结束偏移；
>   -  `position` 为分词位置

- **standard**：默认分词器，按词切分，小写处理，默认的 stopwords 是关闭的。

  ```json
  POST /_analyze
  {
      "analyzer": "standard",
      "text": "I bought a computer，8761元"
  }
  // 分词结果
  {
      "tokens": [
          {
              "token": "i",
              "start_offset": 0,
              "end_offset": 1,
              "type": "<ALPHANUM>",
              "position": 0
          },
          {
              "token": "bought",
              "start_offset": 2,
              "end_offset": 8,
              "type": "<ALPHANUM>",
              "position": 1
          },
          {
              "token": "a",
              "start_offset": 9,
              "end_offset": 10,
              "type": "<ALPHANUM>",
              "position": 2
          },
          {
              "token": "computer",
              "start_offset": 11,
              "end_offset": 19,
              "type": "<ALPHANUM>",
              "position": 3
          },
          {
              "token": "8761",
              "start_offset": 20,
              "end_offset": 24,
              "type": "<NUM>",
              "position": 4
          },
          {
              "token": "元",
              "start_offset": 24,
              "end_offset": 25,
              "type": "<IDEOGRAPHIC>",
              "position": 5
          }
      ]
  }
  ```

- **simple**：按照非字母切分（符号被过滤），小写处理

  ```json
  POST /_analyze
  {
      "analyzer": "simple",
      "text": "I bought a computer，8761元"
  }
  // 分词结果
  {
      "tokens": [
          {
              "token": "i",
              "start_offset": 0,
              "end_offset": 1,
              "type": "word",
              "position": 0
          },
          {
              "token": "bought",
              "start_offset": 2,
              "end_offset": 8,
              "type": "word",
              "position": 1
          },
          {
              "token": "a",
              "start_offset": 9,
              "end_offset": 10,
              "type": "word",
              "position": 2
          },
          {
              "token": "computer",
              "start_offset": 11,
              "end_offset": 19,
              "type": "word",
              "position": 3
          },
          {
              "token": "元",
              "start_offset": 24,
              "end_offset": 25,
              "type": "word",
              "position": 4
          }
      ]
  }
  ```

- **whitespace**：按照空格切分，不转小写

  ```json
  POST /_analyze
  {
      "analyzer": "whitespace",
      "text": "I bought a computer，8761元"
  }
  // 分词结果
  {
      "tokens": [
          {
              "token": "I",
              "start_offset": 0,
              "end_offset": 1,
              "type": "word",
              "position": 0
          },
          {
              "token": "bought",
              "start_offset": 2,
              "end_offset": 8,
              "type": "word",
              "position": 1
          },
          {
              "token": "a",
              "start_offset": 9,
              "end_offset": 10,
              "type": "word",
              "position": 2
          },
          {
              "token": "computer，8761元",
              "start_offset": 11,
              "end_offset": 25,
              "type": "word",
              "position": 3
          }
      ]
  }
  ```

- **ik_smart**： 会根据词库进行标准分词，[下载地址](https://github.com/medcl/elasticsearch-analysis-ik)：下载解压到plugins目录并重启es

  ```json
  POST /_analyze
  {
      "analyzer": "ik_smart",
      "text": "我买了一台计算机"
  }
  // 分词结果
  {
      "tokens": [
          {
              "token": "我",
              "start_offset": 0,
              "end_offset": 1,
              "type": "CN_CHAR",
              "position": 0
          },
          {
              "token": "买了",
              "start_offset": 1,
              "end_offset": 3,
              "type": "CN_WORD",
              "position": 1
          },
          {
              "token": "一台",
              "start_offset": 3,
              "end_offset": 5,
              "type": "CN_WORD",
              "position": 2
          },
          {
              "token": "计算机",
              "start_offset": 5,
              "end_offset": 8,
              "type": "CN_WORD",
              "position": 3
          }
      ]
  }
  ```

- **ik_max_word**：会根据词库列表所有的分词结果

  ```json
  POST /_analyze
  {
      "analyzer": "ik_max_word",
      "text": "我买了一台计算机"
  }
  // 分词结果
  {
      "tokens": [
          {
              "token": "我",
              "start_offset": 0,
              "end_offset": 1,
              "type": "CN_CHAR",
              "position": 0
          },
          {
              "token": "买了",
              "start_offset": 1,
              "end_offset": 3,
              "type": "CN_WORD",
              "position": 1
          },
          {
              "token": "一台",
              "start_offset": 3,
              "end_offset": 5,
              "type": "CN_WORD",
              "position": 2
          },
          {
              "token": "一",
              "start_offset": 3,
              "end_offset": 4,
              "type": "TYPE_CNUM",
              "position": 3
          },
          {
              "token": "台",
              "start_offset": 4,
              "end_offset": 5,
              "type": "COUNT",
              "position": 4
          },
          {
              "token": "计算机",
              "start_offset": 5,
              "end_offset": 8,
              "type": "CN_WORD",
              "position": 5
          },
          {
              "token": "计算",
              "start_offset": 5,
              "end_offset": 7,
              "type": "CN_WORD",
              "position": 6
          },
          {
              "token": "算机",
              "start_offset": 6,
              "end_offset": 8,
              "type": "CN_WORD",
              "position": 7
          }
      ]
  }
  ```

#### 3. 分词器使用

- 分词器有索引时的分词器及搜索时的分词器，可以在mapping中设置，索引分词器采用analyzer进行设置，搜索分词器采用search_analyzer设置，如果没有设置分词器，则索引和搜索分词器都用默认的standard分词器，如果只是设置索引分词器没有设置搜索分词器，则搜索分词器也采用索引分词器，如果analyzer和search_analyzer都设置则使用各自设置的分词器。

  ```json
  // 设置mapping - 定义analyzer索引分词，和搜索分词器使用同一个
  {
      "mappings":{
          "properties":{
              "title":{
                  "type":"text",
                  "analyzer":"ik_smart"
              }
          }
      }
  }
  // 设置mapping - 分别定义analyzer索引分词 和 search_analyzer搜索分词器
  {
      "mappings":{
          "properties":{
              "title":{
                  "type":"text",
                  "analyzer":"english",
                  "search_analyzer":"standard"
              }
          }
      }
  }
  // 查询时候指定分词器
  {
      "query": {
          "match": {
              "title":{
                  "query" : "洗衣液",
                  "analyzer" : "standard"
              }
          }
      }
  }
  ```

#### 3. 扩展IK词库

- 下载并解压ik分词器到ElasticSearch的home下的plugins文件夹：
- 在ES的安装路径下找到配置目录custom(如果没有就mkdir),创建用户自定义的词典myTest.dic
- ES词典的配置文件为IKAnalyzer.cfg.xml。编辑该文件,加入我们自定义的词典
- 重启ES

## 第二章 ES数据类型

![5aRcLT.png](https://z3.ax1x.com/2021/10/18/5aRcLT.png)

### 2.1 基本类型

1. **基本类型概述**：分为字符串类型、数字类型、日期类型、布尔类型、基于 BASE64 的二进制类型、范围类型

   - string类型再ES7.0以后就不再支持了，字符串只有两种字符串类型：text 和 keyword
   - text 类型适用于需要被全文检索的字段，但是**不能被用于排序**如果需要使用该类型的字段只需要在定义映射时指定 JSON 中对应字段的 type 为 text。
   - keyword 适合简短、结构化字符串，例如主机名、姓名、商品名称等，**可以用于过滤、排序、聚合检索，也可以用于精确查询**。
   - 数字类型：尽量选择范围较小的数据类型，字段长度越短，搜索效率越高，对于浮点数，可以优先考虑使用 scaled_float 类型，该类型可以通过缩放因子来精确浮点数，例如 12.34 可以转换为 1234 来存储。
   - 日期类型：格式化的日期字符串，例如 2020-03-17 00:00、2020/03/17
   - 布尔类型：JSON 字符串类型也可以被 ES 转换为布尔类型存储，前提是字符串的取值为 true 或者 false
   - 二进制类型：二进制类型 binary 接受 BASE64 编码的字符串，默认 store 属性为 false，并且不可以被搜索。
   - 范围类型：用来表达一个数据的区间，可以分为5种：integer_range、float_range、long_range、double_range 以及 date_range。

2. 基本类型使用案例

   ```json
   PUT /user02
   {
       "mappings": {
           "properties": {
               "name":{
                   "type": "keyword"
               },
               "address":{
                   "type": "text"
               }
           }
       }
   }
   ```

   > - **text**：类型适用于需要被全文检索的字段，`text` 类型会被 Lucene 分词器（Analyzer）处理为一个个词项，并使用 Lucene 倒排索引存储，**text 字段不能被用于排序**，
   > - **keyword**：用于过滤、排序、聚合检索，也可以用于精确查询。

### 2.2 复杂类型

1. 复杂类型概述：主要有对象类型（object）和嵌套类型（nested）

   - 对象类型：JSON 字符串允许嵌套对象，一个文档可以嵌套多个、多层对象。可以通过对象类型来存储二级文档，不过由于 Lucene 并没有内部对象的概念，ES 会将原 JSON 文档扁平化，如下

     ```json
     {
       "name":{
         "first":"fn",
         "last":"ln"
       }
     }
     # 会被扁平化处理
     {
       "name.first":"fn",
       "name.last":"ln"
     }
     ```

   - 嵌套类型：可以看成是一个特殊的对象类型，可以让对象数组独立检索，嵌套类型将数组中的每个 JSON 对象作为独立的隐藏文档来存储，每个嵌套的对象都能够独立地被搜索，所以下面案例中虽然表面上只有 1 个文档，但实际上是存储了2个文档。

     ```json
     {
       "users":[
         {"first":"fa", "last":"la"},
         {"first":"fb", "last":"lb"}
       ]
     }
     ```

2. 复杂类型使用案例

### 2.3 地理类型

1. 地理类型概述：分为经纬度类型和地理区域类型
   - 经纬度类型字段（geo_point）：可以存储经纬度相关信息，通过地理类型的字段，可以用来实现诸如查找在指定地理区域内相关的文档、根据距离排序、根据地理位置修改评分规则等需求。
   - 经纬度类型：可以表达一个点，而 geo_shape 类型可以表达一块地理区域，区域的形状可以是任意多边形，也可以是点、线、面、多点、多线、多面等几何类型。
2. 地理类型使用案例

### 2.4 特殊类型

1. 特殊类型概述：包括 IP 类型、过滤器类型、Join 类型、别名类型等

   - IP 类型：可以用来存储 IPv4 或者 IPv6 地址，如果需要存储 IP 类型的字段，需要手动定义映射

     ```json
     {
         "mappings":{
             "properties":{
                 "work_ip":{
                     "type":"ip"
                 }
             }
         }
     }
     ```

   - Join 类型是 ES 6.x 引入的类型，以取代淘汰的 `_parent` 元字段，用来实现文档的一对一、一对多的关系，主要用来做父子查询

     ```json
     // 例如:my_join_field 为 Join 类型字段的名称；relations 指定关系：question 是 answer 的父类。
     PUT my_index
     {
         "mappings": {
             "properties": {
                 "my_join_field": { 
                     "type": "join",
                     "relations": {
                         "question": "answer" 
                     }
                 }
             }
         }
     }
     
     // 例如定义一个 ID 为 1 的父文档：
     PUT my_join_index/1?refresh
     {
         "text": "This is a question",
         "my_join_field": "question" 
     }
     // 接下来定义一个子文档，该文档指定了父文档 ID 为 1：
     PUT my_join_index/_doc/2?routing=1&refresh 
     {
         "text": "This is an answer",
         "my_join_field": {
             "name": "answer", 
             "parent": "1" 
         }
     }
     ```

     

2. 特殊类型使用案例

## 第三章 ES Mapping

### 3.1 Mapping映射

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>ElasticSearch中的数据是以JSON文档的格式存储在索引中，ES中文档的格式称为Type；为提高ES检索性能，Type中字段对应的值会处理成特定的数据类型，这些数据类型与文档的对应关系就是Type的Mapping；在早期的版本中一个索引下可以添加多个Type类型的文档；从7.0开始，一个索引只有一个Type，也可以说一个 Type 有一个 Mapping 定义（可以理解为MySQL的表结构，用来约束字段的数据类型）；ES中Mapping的作用如下：

- 定义索引中的字段的名称以及字段对应的数据类型，日期的格式等等；
- 字段的倒排索引的方式，或者设置是否可以被索引；
- 自定义规则，用于控制动态添加字段的映射

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>mapping有三种不同的特性，即设置mapping的dynamic属性的三种取值：①当 dynamic 设置为 `true` 时，这个文档可以被索引进 ES，这个字段也可以被索引，也就是这个字段可以被搜索，Mapping 也同时被更新；②当 dynamic 被设置为 `false` 时候，存在新增字段的数据写入，该数据可以被索引，但是新增字段被丢弃；③当设置成 `strict` 模式时候，数据写入直接出错。

|               | true | false | strict |
| ------------- | ---- | ----- | ------ |
| 文档可索引    | ✅    | ✅     | ❎      |
| 字段可索引    | ✅    | ❎     | ❎      |
| mapping可更新 | ✅    | ❎     | ❎      |

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>ES的Type映射方式有两中：①mapping：类似于数据库的schema的定义，mapping会把文档映射成lucene需要的扁平格式，一个mapping属于一个索引的type，一个type中有一个mapping定义；②dynamic mapping：写入文档的时候，索引不存在，会自动创建索引， 无需手动创建，ES会根据内容推断字段的类型，推断会不准确，可能造成某些功能无法使用，例如 范围查询。

### 3.2 动态映射

- 类型的自动识别关系

  | JSON类型 | ElasticSearch dynamic mapping                                |
  | :------: | ------------------------------------------------------------ |
  |  字符串  | 匹配日期格式，设置为date<br />匹配数字，设置为float或者long，功能默认关闭<br />设置为text，并增加keyword子字段 |
  |  布尔值  | boolean                                                      |
  |  浮点数  | float                                                        |
  |   整数   | long                                                         |
  |   对象   | object                                                       |
  |   数组   | 由第一个非空数值的类型决定                                   |
  |   空值   | 忽略                                                         |

- 查看索引的映射

  ```http
  GET http://ip:port/索引名称/_mapping
  ```

- 关闭动态映射

  ```json
  PUT /_settings 
  {
    "index.mapper.dynamic":false
  }
  ```

- 

### 3.3 映射

- 每个索引都拥有唯一的 `mapping type`，用来决定文档将如何被索引。`mapping type`由下面两部分组成

  - Meta-fields：元字段用于自定义如何处理文档的相关元数据。 元字段的示例包括文档的`_index`，`_type`，`_id`和`_source`字段。
  - Fields or properties：映射类型包含与文档相关的字段或属性的列表。

- mapping

  - **初始化mapping**：在新增索引的时候添加mapping

    ```json
    PUT /twitter
    {
        "mappings": {
            "properties": {
                "message": {
                    "type": "text"
                }
            }
        }
    }
    ```

  - **新增字段**：为索引增加新的mapping，对fields的映射进行设置

    ```json
    PUT /twitter/_mapping
    {
        "properties": {
            "name": {
                "type": "keyword"
            }
        }
    }
    ```

  - **修改字段：mapping在建好之后不可以更改字段类型**，但是可以通过重建索引和索引别名完成索引的字段重建

    ```json
    # 原索引
    PUT my_index
    {
        "mappings": {
            "properties": {
                "create_date": {
                    "type":   "date",
                    "format": "yyyy-MM-dd ||yyyy/MM/dd"
                }
            }
        }
    }
    # 创建新索引,重置原索引的字段
    PUT my_index2
    {
        "mappings": {
            "properties": {
                "create_date": {
                    "type":   "text"
                }
            }
        }
    }
    # 同步数据
    POST _reindex                   
    {
        "source": {
            "index": "my_index"
        },
        "dest": {
            "index": "my_index2"
        }
    }
    # 删除原索引
    DELETE my_index
    # 设置新索引别名
    POST /_aliases
    {
        "actions": [
            {"add": {"index": "my_index2", "alias": "my_index"}}
        ]
    }
    ```

## 第四章 ES基础操作

### 4.1 ES服务查询

1. **查询ES服务信息**

   ```json
   GET /
   {
       "name" : "8eaa5a50b54d",
       "cluster_name" : "docker-cluster",
       "cluster_uuid" : "cyhnwUkJR7eCj2Hb01r88Q",
       "version" : {
           "number" : "8.0.1",
           "build_flavor" : "default",
           "build_type" : "docker",
           "build_hash" : "801d9ccc7c2ee0f2cb121bbe22ab5af77a902372",
           "build_date" : "2022-02-24T13:55:40.601285296Z",
           "build_snapshot" : false,
           "lucene_version" : "9.0.0",
           "minimum_wire_compatibility_version" : "7.17.0",
           "minimum_index_compatibility_version" : "7.0.0"
       },
       "tagline" : "You Know, for Search"
   }
   ```

2. **_cat指令**

   - 指令说明：&是参数连接符，可以多个参数一起使用

     | 参数         | 说明                 | 案例                                                         |
     | ------------ | -------------------- | ------------------------------------------------------------ |
     | v（verbose） | 显示指令的详细信息   | **GET _cat/health?v**                                        |
     | help         | 示指令返回参数的说明 | **GET _cat/health?help**                                     |
     | h（header）  | 选择要显示的列       | **GET _cat/count?h=timestamp,count**                         |
     | format       | 设置返回内容的格式   | **GET _cat/master?format=json<br />** - 支持json,yaml,text,smile,cbor |
     | s（sort）    | 排序                 | **GET _cat/indices?s=store.size:desc**                       |

   - **_cat指令结果说明**

     | 指令            | 说明                           | 案例                                                         |
     | --------------- | ------------------------------ | ------------------------------------------------------------ |
     | **indices**     | 查看索引信息                   | **GET _cat/indices?v** <br />  -  health：索引的健康状态<br/> - status：索引的开启状态<br/> - index：索引名字<br/> - uuid：索引的uuid<br/> - pri：索引的主分片数量<br/> - rep：索引的复制分片数量<br/> - docs.count：索引下的文档总数<br/> - docs.deleted：索引下删除状态的文档数<br/> - store.size：主分片+复制分片的大小<br/> - pri.store.size：主分片的大小 |
     | **plugins**     | 显示每个运行插件节点的视图     | **GET _cat/plugins?v** <br /> - name：节点名称<br/> - component：插件名称<br/> - version：插件版本 |
     | **shards**      | 查看分片信息                   | **GET _cat/shards?v** <br />- index：索引名称<br/> - shard：分片序号<br/> - prirep：分片类型，p主，r复<br/> - state：分片状态<br/> - docs：该分片存放的文档数量<br/> - store：该分片占用的存储空间大小<br/> - ip：该分片所在的服务器ip<br/> - node：该分片所在的节点名称 |
     | **allocation**  | 显示每个节点分片数量、占用空间 | **GET _cat/allocation?v**<br /> - shards：节点承载的分片数量<br /> - disk.indices：索引占用的空间大小<br /> - disk.used：已使用的磁盘空间大小<br /> - disk.avail：节点可用空间大小<br /> - disk.total：节点总空间大小<br /> - disk.percent：节点磁盘占用百分比<br /> - host：节点的host地址<br /> - ip：节点的ip地址<br /> - node：节点名称 |
     | **thread_pool** | 查看线程池信息                 | **GET _cat/thread_pool?v**<br /> - node_name：节点名称<br/> - name：线程池名称<br/> - active：活跃线程数量<br/> - queue：当前队列中的任务数<br/> - rejected：被拒绝的任务数 |
     | aliases         | 显示别名、过滤器、路由信息     | **GET _cat/aliases?v**<br /> - alias：别名<br /> - iindex：索引别名指向<br /> - filter：过滤规则<br /> - routing.index：索引路由<br /> - routing.search：搜索路由 |
     | count           | 显示索引文档数量               | **GET _cat/count?v**<br /> - epoch：自标准时间以来的秒数 <br />- timestamp：时间<br /> - count：文档总数 |
     | **health**      | 查看集群健康状况               | **GET _cat/health?v**<br /> - epoch：自标准时间以来的秒数 <br /> - timestamp：时间<br /> - cluster：集群名称<br /> - status：集群状态<br /> - node.total：节点总数<br /> - node.data：数据节点总数<br /> - shards：分片总数<br /> - pri：主分片总数<br /> - repo：复制节点的数量<br /> - init： 初始化节点的数量<br /> - unassign：未分配分片的数量<br /> - pending_tasks：待定任务数<br /> - max_task_wait_time：最长任务等待时间<br /> - active_shards_percent：活动分片百分比 |
     | **master**      | 显示master节点信息             | **GET _cat/master?v**<br /> - id：节点ID<br/> - host：主机名称<br/> - ip：主机IP<br/> - node：节点名称 |
     | nodeattrs       | 显示node节点属性               | **GET _cat/nodeattrs?v**<br /> - node：节点名称<br/> - host：主机地址<br/> - ip：主机ip<br/> - attr：属性描述<br/> - value：属性值 |
     | nodes           | 显示node节点信息               | **GET _cat/nodes?v** <br /> - ip：node节点的IP<br/> - heap.percent：堆内存占用百分比<br/> - ram.percent：内存占用百分比<br/> - cpu：CPU占用百分比<br/> - load_1m：1分钟的系统负载<br/> - load_5m：5分钟的系统负载<br/> - load_15m：15分钟的系统负载<br/> - node.role：node节点的角色<br/> - master：是否是master节点<br/> - name：节点名称 |
     | pending_tasks   | 显示正在等待的任务             | **GET _cat/pending_tasks?v** <br /> - insertOrder：任务插入顺序<br/> - timeInQueue：任务排队了多长时间<br/> - priority：任务优先级<br/> - source：任务源 |
     | recovery        | 显示索引碎片恢复的视图         | **GET _cat/recovery?v**<br /> - index：索引名称<br/> - shard：分片名称<br/> - time：恢复时间<br/> - type：恢复类型<br/> - stage：恢复阶段<br/> - source_host：源主机<br/> - source_node：源节点名称<br/> - target_host：目标主机<br/> - target_node：目标节点名称<br/> - repository：仓库<br/> - snapshot：快照<br/> - files：要恢复的文件数<br/> - files_recovered：已恢复的文件数<br/> - files_percent：恢复文件百分比<br/> - files_total：文件总数<br/> - bytes：要恢复的字节数<br/> - bytes_recovered：已恢复的字节数<br/> - bytes_percent：恢复字节百分比<br/> - bytes_total：字节总数<br/> - translog_ops：要恢复的数<br/> - translog_ops_recovered：已恢复的数<br/> - translog_ops_percent：恢复的百分比 |
     | segments        | 显示碎片中的分段信息           | **GET _cat/segments?v**<br /> - index：索引名称<br/> - shard：分片名称<br/> - prirep：主分片还是副本分片<br/> - ip：所在节点IP<br/> - segment：segments段名<br/> - generation：分段生成<br/> - docs.count：段中的文档树<br/> - docs.deleted：段中删除的文档数<br/> - size：段大小，以字节为单位<br/> - size.memory：段内存字节大小<br /> - committed：段是否已提交<br/> - searchable：段是否可搜索<br/> - version：版本<br/> - compound：compound模式 |

### 4.2 索引操作

#### 1. 新建索引

- **创建索引**：使用PUT方式请求表示该请求具有幂等性，同样的请求只有发送一次，否则会报错

- 创建空索引：索引配置使用默认的配置值

  ```json
  PUT /索引名称
  ```

- 禁止自动创建索引：在全局配置文件 elasticsearch.yml 中

  > - 如果直接执行新增文档的操作，默认会直接创建这个索引；并且type字段也会自动创建。也就是说，ES并不需要像传统的数据库事先定义表的结构。
  > - 每个索引中的类型都有一个mapping映射，这个映射是动态生成的，因此当增加新的字段时，会自动增加mapping的设置。
  > - 通过在配置文件中设置action.auto_create_index为false，可以关闭自动创建index这个功能。
  > - 也可以设置黑名单或者白名单，比如：设置action.auto_create_index为`+aaa*,-bbb*`，`+`号意味着允许创建aaa开头的索引，`-`号意味着不允许创建bbb开头的索引。
  >

  ```yaml
  action.auto_create_index:false
  ```

- 创建索引并设置分片和副本

  ```json
  PUT /索引名称
  {
    "settings":{
      "number_of_shards": 分片数量,
      "number_of_replicas": 副本数量
    }
  }
  ```

- 创建指定名称的索引并设置索引mapping：详细用法参考mapping

  ```json
  PUT /索引名称
  {
    "mapping":{
      "properties":{
        "<字段>":{
          "type":"字段的数据类型"
        }
      }
    }
  }
  ```

#### 2. 查询索引

```sh
# 查看所有索引
GET /_cat/indices

# 查看所有索引完整信息
GET /_all
# 查看单个索引完整信息
GET /user_empty
# 查看多个索引完整信息
GET /user_empty,user_setting
# 查看集群中所有索引的setting信息
GET /_all/_settings
# 查看集群中所有索引的mapping信息
GET /_all/_mapping

# 查看索引的setting信息
GET /user_setting/_settings

# 查看索引的mapping信息
GET /user_mapping/_mapping

# 查看多个索引的settings信息
GET /user_empty,user_mapping/_settings
# 查看多个索引的mapping信息
GET /user_empty,user_mapping/_mapping
```

#### 3. 编辑索引

- **修改索引的副本数**：分片数据创建后不能修改

  ```sh
  PUT /<索引名称>/_settings
  {
    "settings": {
      "number_of_replicas": 2
    }
  }
  ```

- **增加索引字段**：已定义好的字段不允许被修改

  ```sh
  PUT /<索引名称>/_mapping
  {
    "properties":{
      "字段名称":{
        "type":"自动类型"
      }
    }
  }
  ```

#### 4.删除索引

```json
DELETE /<索引名称>
{
  "acknowledged" : true
}
```

#### 5. 索引打开和关闭

> 索引关闭以后就几乎不会占用系统资源

```http
# 关闭单个索引
POST /索引名称/_close

# 关闭多个索引
POST /索引名称1,索引名称2/_close

# 关闭所以并添加ignore_unavailable参数:如果关闭不存在索引,设置是否抛异常
POST /索引名称1,索引名称2/_close?ignore_unavailable=true

# 关闭集群中所有索引
POST /_all/_close

# 使用通配符关闭索引
POST /test*/_close
```

#### 6. 索引别名

- 创建索引别名

  ```http
  POST /_aliases
  {
    "actions": [
      {
        "add": {
          "index": "索引名称",
          "alias": "索引名称对应的别名"
        }
      }
    ]
  }
  ```

- 移除索引别名

  ```sh
  POST /_aliases
  {
    "actions": [
      {
        "remove": {
          "index": "索引名称",
          "alias": "索引名称对应的别名"
        }
      }
    ]
  }
  ```

- 查看索引的别名

  ```sh
  GET /索引名称/_aliases
  ```

- 查看一个别名所对应的索引

  ```json
  GET /索引别名/_aliases
  ```

- 查看集群中所有可用别名

  ```json
  GET /_all/_aliases
  或
  GET /_aliases
  ```

### 4.3 文档操作

#### 1. document详解

- document核心元数据

  ```json
  {
    "_index": "music",
    "_type": "children",
    "_id": "1",
    "_version": 1,
    "found": true,
    "_source": {
      // ... ...
    }
  }
  ```

  > 1. _index元数据：代表这个document存放在哪个index中，名称小写，**`不能以'_', '-', 或 '+'开头`**。
  > 2. _type元数据：ES 6.0.0之后一个index下面只能有一个type，高版本ES没有这个字段了；
  > 3. _id元数据：document的唯一标识，与index一起唯一标识和定位一个document，可以手动指定，也可以由ES自动创建。
  > 4. _version元数据：ES内部使用乐观锁对document的写操作进行控制，version版本号最初是1，更新操作成功后自动+1。
  > 5. _source元数据：真正的ES需要存储的数据；

#### 2. 新建文档

- 添加数据并指定ID

  ```http
  # 
  ```

  

  



> - 新版es中索引中type默认为_doc

```sh
# 添加文档,返回的内置信息中会包含随机生成的id,POST新增请求不是幂等性,每次都是一个新请求,PUT请求要求是幂等性,每次请求要求唯一
POST http://localhost:9200/索引名称/_doc
{
	"key":"value",
	... ...
}
# 添加文档并设置自定义ID,带唯一ID后POST请求是具有幂等性,此时新增请求方式也可以是PUT
POST http://localhost:9200/索引名称/_doc/唯一ID
{
	"key":"value",
	... ...
}
```

#### 2. 编辑文档

> - put 整个文档的更新
> - put 只更新单个字段
> - put 增量字段
> - put 基于乐观锁的更新

```sh
完全修改,覆盖元数据
PUT http://localhost:9200/索引名称/_doc/覆盖的ID
{
	"key":"value",
	... ...
}

局部数据更新,修改请求不是幂等性,必须使用post,局部修改需要说明修改doc中的某个字段
POST http://localhost:9200/索引名称/_doc/修改的文档ID
{
	"doc":{
		"修改的属性":"修改的值",
		... ...
	}
}
```

#### 3. 删除文档

```sh
DELET http://localhost:9200/索引名称/_doc/删除ID
```

## 第五章 ES检索分析

### 5.1 检索

1. 主键查询

   ```json
   GET http://localhost:9200/索引名称/_doc/查询ID
   ```

2. query查询

   ```http
   GET http://localhost:9200/索引名称/_search?q=key:查询的值&... ...
   ```

3. match_all

4. match

5. term

6. 区间检索

7. _source检索需要的字段、过滤字段

8. range区间查

9. 复合查询bool

10. filter与match

11. fuzzy近似查询

12. match_phrase断句匹配,查询的是整个断句

13. multi_match:多字段查询,一个只从多个字段匹配

14. terms

15. should

16. must_not

17. post_filter

18. HEAD /索引/_doc/ID:判断文档是否存在

19. 用ID批量差:`_doc/_mget`

20. 批量操作:_bulk,新增,修改,删除

21. 分页查询

22. 排序

23. 高亮

24. 主键查询

    ```tex
    GET http://localhost:9200/索引名称/_doc/查询ID
    ```

25. 查询所有:_search

    ```tex
    GET http://localhost:9200/索引名称/_search
    ```

26. 条件查询1- 使用query参数查询

    ```txt
    
    ```

27. 条件查询2 - 使用请求体查询 query表示是一个查询参数

    ```tex
    GET http://localhost:9200/索引名称/_doc
    {
    	"query":{
    		"查询条件":{
    			"条件匹配字段":"查询的值"
    		}
    	}
    }
    ```

    > - match - 表示匹配查询,需要指定匹配字段和匹配值
    > - match_al - 表示全部匹配, 无需指定匹配字段

28. 分页查询: form表示查询起始位置 size表示需要查询的条数

    ```tex
    GET http://localhost:9200/索引名称/_doc
    {
    	"from":"",
    	"to":"",
    	"query":{
    		"match":{
    			"条件匹配字段":"查询的值"
    		}
    	}
    }
    ```

29. 查询需要的字段: _source数组中说明需要返回的字段

    ```tex
    GET http://localhost:9200/索引名称/_doc
    {
    	"from":"",
    	"to":"",
    	"_source":["需要返回的字段"],
    	"query":{
    		"match":{
    			"条件匹配字段":"查询的值"
    		}
    	}
    }
    ```

30. 排序查询

    ```tex
    GET http://localhost:9200/索引名称/_doc
    {
    	"from":"",
    	"to":"",
    	"_source":["需要返回的字段"],
    	"sort":{
    		"排序字段":{
    			"order":"asc|desc"
    		}
    	},
    	"query":{
    		"match":{
    			"条件匹配字段":"查询的值"
    		}
    	}
    }
    ```

31. 多条件查询: bool -> must | should | filter（过滤：可以范围查询range -> gt | lt | eq | ）

    ```json
    {
      "query":{			// 表示是查询
        "bool":{		// 表示使用条件查询
          "must":[	// 表示这个集合中的条件必须全部匹配
            {
              "match":{
                "匹配字段":""
              }
            },{
              "match":{
                "匹配字段":""
              }
            }
          ]
        }
      }
    }
    ```

32. 全文检索

    ```tex
    es text类型默认是standard分词
    全文匹配: match_phrase
    高亮显示:显示需要高亮的字段,默认前缀是<em>
    highlight:{
    	"fields":{
    		"高亮的字段":{
    		}
    	}
    }
    ```

33. 聚合查询:查询结果分析

    ```json
    {
    	"aggs":{		// 表示是聚合操作
        "自定义的聚合名称":{
          "terms":{		// terms关键字表示分组
            "分组字段"
          },
          "avg":{		// avg关键字表示统计平均值
            "求平均字段"
          }
        }
      }	
    }
    ```

### 5.2 分析

- aggs
- avg
- terms:根据什么字段分组

## 第六章 ES Java Client

### 6.1 Java客户端类型

1. Java Client [8.1]：这是 Elasticsearch 的官方 Java API 客户端的文档。客户端为所有 Elasticsearch API 提供强类型请求和响应。
2. Java REST Client (过期) [7.17] ：Java REST 客户端已弃用，取而代之的是 Java API 客户端。包括①Java Low Level REST Client：低级客户端，允许通过 http 与 Elasticsearch 集群通信②Java High Level REST Client：基于低级客户端，它公开 API 特定的方法，并负责请求编组和响应解编组。
3. Java Transport Client (过期) [7.17]：TransportClient 已弃用，取而代之的是 Java 高级 REST 客户端，并将在 Elasticsearch 8.0 中删除。Java Transport Client是Java操作ES的一种客户端，是ES5版本就存在的一中API操作方式

### 6.2 JavaClient

1. 添加依赖

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

2. JavaClient核心组件

   - API client classes：它们为 Elasticsearch API 提供强类型数据结构和方法。由于 Elasticsearch API 很大，它以功能组（也称为“命名空间”）的形式构成，每个组都有自己的客户端类。 Elasticsearch 核心功能在 ElasticsearchClient 类中实现。
   - A JSON object mapper：这会将您的应用程序类映射到 JSON 并将它们与 API 客户端无缝集成。
   - A transport layer implementation：这是所有 HTTP 请求处理发生的地方。

3. 组合三个组件，建立链接

   ```java
   // Create the low-level client
   RestClient client = RestClient.builder(new HttpHost("localhost", 9200)).build();
   // 创建 the transport with a Jackson mapper
   ElasticsearchTransport tp = new RestClientTransport(client, new JacksonJsonpMapper());
   // 创建 the API client
   ElasticsearchClient client = new ElasticsearchClient(tp);
   
   // Create the low-level client
   RestClientBuilder builder = RestClient.builder(new HttpHost("localhost", 9200));
   
   // Create the HLRC
   RestHighLevelClient hlrc = new RestHighLevelClient(builder);
   
   // Create the new Java Client with the same low level client
   ElasticsearchTransport tr = new RestClientTransport(hlrc.getLowLevelClient(),new JacksonJsonpMapper());
   
   ElasticsearchClient esClient = new ElasticsearchClient(tr);
   ```

4. 发送请求

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

### 6.3 RestHighLevelClient



## 第七章 ES集群

# 第二部分 Kibana

## 第一章 Kibana入门

### 1.1 Kibana介绍

### 1.2 Kibana安装

1. Linux系统安装

   - 下载解压

     > - 新建Kibana安装目录：/opt/kibana
     > - 将Kibana安装包解压到/opt/kibana目录中：Kibana的版本必须和ElasticSearch版本相同

   - 修改配置：/opt/kibana/config/kibana.yml

     ```yaml
     # Kibana 服务启动端口
     server.port: 5601
     
     # 指定Kibana服务器要绑定到的地址
     server.host: "192.168.57.129"
     
     # 用于所有查询的Elasticsearch实例的url
     elasticsearch.hosts: ["http://192.168.57.129:9200"]
     
     # 中文管理页
     i18n.locale: "zh-CN"
     ```

   - Linux服务器开启kibana服务运行端口：5601

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

2. Docker命令行

   - 下载Kibana镜像

     ```sh
     docker pull kibana:8.0.1
     ```

   - 使用命令行安装docker：①需要准备好宿主机中config中的配置文件②修改下面命令行中的数据集容器卷路径

     ```sh
     docker run -it --name kibana1 -p 5601:5601 \
     -v ~source_docker/kibana/config:/usr/share/kibana/config kibana:8.0.1
     ```

3. DockerCompose

   - 下载Kibana镜像

     ```sh
     docker pull kibana:8.2.0
     ```

   - 定义主机容器卷的目录如下结构：同一套版本的ElasticSearch和Kibana定义在同一目录ElasticSearch8，es和Kibana定义在各自的文件目录中

     ```tex
     ElasticSearch8/
     	es8/
     		/data/
     		/logs/
     		/config/
     			/elasticsearch.yml
     			/jvm.options
     			/log4j2.properties
     	kibana/
     		config/kibana.yml
     ```

   - 定义docker-compose.yml文件在ElasticSearch8的根目录中

     ```yaml
     # docker network create elk
     version: "3.8"
     services:
       es8:
         image: elasticsearch:8.2.0
         container_name: es8
         ports:
           - "9200:9200"
           - "9300:9300"
         volumes:
           - ./es8/data:/usr/share/elasticsearch/data
           - ./es8/logs:/usr/share/elasticsearch/logs
           - ./es8/config:/usr/share/elasticsearch/config
           - ./es8/plugins:/usr/share/elasticsearch/plugins
         environment:
           - "ES_JAVA_OPTS=-Xms512m -Xmx512m"
           - discovery.type=single-node
       kibana8:
         image: kibana:8.2.0
         container_name: kibana8
         ports:
           - "5601:5601"
         volumes:
           - ./kibana8/config:/usr/share/kibana/config
         environment:
           ELASTICSEARCH_HOSTS: http://es8:9200
           I18N_LOCALE: zh-CN
         depends_on:
             - es8
     ```

### 1.3 Kibana配置文件详解



# 第三部分 LogStash

# 第四部分 Beats