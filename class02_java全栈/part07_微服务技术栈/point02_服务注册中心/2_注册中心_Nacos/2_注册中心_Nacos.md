# 前言

[TOC]

# 第一章 Nacos基础

## 1.1 概述

**1、Nacos简介**

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Nacos 致力于发现、配置和管理微服务。更敏捷和容易地构建、交付和管理微服务平台。 Nacos 是构建以“服务”为中心的现代应用架构 (例如微服务范式、云原生范式) 的服务基础设施。Nacos 支持几乎所有主流类型的“服务”的发现、配置和管理：

- Kubernetes Service
- gRPC & Dubbo RPC Service
- Spring Cloud RESTful Service

**2、Nacos特性**

- **服务发现和服务健康监测**：Nacos 支持基于 DNS 和基于 RPC 的服务发现
- **动态配置服务**：动态配置服务可以让您以中心化、外部化和动态化的方式管理所有环境的应用配置和服务配置。动态配置消除了配置变更时重新部署应用和服务的需要，让配置管理变得更加高效和敏捷。配置中心化管理让实现无状态服务变得更简单，让服务按需弹性扩展变得更容易。
- **动态 DNS 服务**：动态 DNS 服务支持权重路由，让您更容易地实现中间层负载均衡、更灵活的路由策略、流量控制以及数据中心内网的简单DNS解析服务。
- **服务及其元数据管理**：Nacos 能让您从微服务平台建设的视角管理数据中心的所有服务及元数据，包括管理服务的描述、生命周期、服务的静态依赖分析、服务的健康状态、服务的流量管理、路由及安全策略、服务的 SLA 以及最首要的 metrics 统计数据。

**3、Nacos架构**

<img src="https://s1.ax1x.com/2020/09/03/wPkLDg.png" alt="wPPlA1.png" border="0" />

**4、官网文档**

- Nacos官网：https://nacos.io/zh-cn/
- Nacos官网文档：https://nacos.io/zh-cn/docs/what-is-nacos.html
- GitHub地址：https://github.com/alibaba/nacos

**5、Nacos源码编译**

- 安装并配置JDK：64 bit JDK 1.8+（Nacos 依赖 Java环境来运行）

- 安装并配置Maven：Maven 3.2.x+（如果是从代码开始构建并运行Nacos，还需要配置Maven环境）

- 下载Nacos源码

  ```sh
   git clone https://github.com/alibaba/nacos.git
  ```

- 查看Naocs的tag信息：使用Maven构建建议将代码指定为指定版本的源码环境

  ```sh
  git tag
  ```

- 切换到指定分支：如使用当前稳定版本为1.3.1

  ```sh
  git checkout 1.3.1
  ```

- 检查Maven镜像地址，最好将地址修改为国内镜像地址，将setting.xml配置文件保存于maven目录的conf文件夹中

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
            xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
  
    <localRepository>E:/repository/maven</localRepository>
    <pluginGroups></pluginGroups>
    <proxies></proxies>
    <servers></servers>
  
    <mirrors>
      <mirror>  
        <id>alimaven</id>  
        <name>aliyun maven</name>  
        <url>https://maven.aliyun.com/nexus/content/groups/public/</url>  
        <mirrorOf>central</mirrorOf>
  	 </mirror>
    </mirrors>
    <profiles></profiles>
  </settings>
  ```

- 在CMD窗口执行Maven命令打包源码

  ```sh
  mvn -Prelease-nacos -Dmaven.test.skip=true clean install -U  
  ```

- 查看打包完成后的文件：打包后的安装包目录distribution/target/

  ```sh
  ls -al distribution/target/
  ```

## 1.2 安装与配置

### 1、目录说明

### 2. nacos服务配置说明

| Spring引导相关配置                                           | 作用                       |
| ------------------------------------------------------------ | -------------------------- |
| server.servlet.contextPath=/nacos                            | 启动后控制台访问路径       |
| server.port=8848                                             | 默认端口号                 |
| **网络相关的配置**                                           | **作用**                   |
| nacos.inetutils.prefer-hostname-over-ip=false                |                            |
| nacos.inetutils.ip-address=                                  | 指定本地服务器的IP         |
| **配置模块相关配置**                                         | **作用**                   |
| spring.datasource.platform=mysql                             | 数据源                     |
| db.num=1                                                     |                            |
| db.url.0=                                                    |                            |
| db.user                                                      |                            |
| db.password                                                  |                            |
| **命名模块相关配置**                                         | **作用**                   |
| nacos.naming.distro.taskDispatchPeriod=200                   | 数据调度任务执行周期       |
| nacos.naming.distro.batchSyncKeyCount=1000                   | 批处理同步任务的数据计数   |
| nacos.naming.distro.syncRetryDelay                           | 如果同步任务失败，重试延迟 |
| nacos.naming.data.warmup=true                                | 启用数据预热               |
| nacos.naming.expireInstance=true                             | 启用实例自动过期           |
| nacos.naming.empty-service.auto-clean=true<br/>nacos.naming.empty-service.clean.initial-delay-ms=50000<br/>nacos.naming.empty-service.clean.period-time-ms=30000 |                            |
| **CMDB模块相关配置**                                         | **作用**                   |
| nacos.cmdb.labelTaskInterval=300                             | 转储外部CMDB的间隔         |
| nacos.cmdb.loadDataAtStart=false                             | 是否打开数据加载任务       |
| **指标相关的配置**                                           | **作用**                   |
| management.endpoints.web.exposure.include=*                  | 指标的普罗米修斯           |
| management.metrics.export.elastic.enabled=false<br />management.metrics.export.elastic.host=es地址 | es搜索指标                 |
| management.metrics.export.influx.enabled=false<br/>management.metrics.export.influx.db=springboot<br/>management.metrics.export.influx.uri=http://localhost:8086<br/>management.metrics.export.influx.auto-create-db=true<br/>management.metrics.export.influx.consistency=one<br/>management.metrics.export.influx.compressed=true | 指标的涌入                 |

### 3. nacos集群配置说明



## 1.3 启动

1. **Linux/Unix/Mac**：单机启动(()standalone代表着单机模式运行，非集群模式）

   ```sh
   sh startup.sh -m standalone
   ```

2. **Windows启动命令**

   ```sh
   cmd startup.cmd
   ```

3. **Docker**

   

## 1.4 启动验证

1. **服务注册与发现**

   ```sh
   # 服务注册
   curl -X POST 'http://127.0.0.1:8848/nacos/v1/ns/instance?serviceName=nacos.naming.serviceName&ip=20.18.7.10&port=8080'
   
   # 服务发现
   curl -X GET 'http://127.0.0.1:8848/nacos/v1/ns/instance/list?serviceName=nacos.naming.serviceName'
   ```

2. **发布配置与获取配置**

   ```sh
   # 发布配置
   curl -X POST "http://127.0.0.1:8848/nacos/v1/cs/configs?dataId=nacos.cfg.dataId&group=test&content=HelloWorld"
   
   # 获取配置
   curl -X GET "http://127.0.0.1:8848/nacos/v1/cs/configs?dataId=nacos.cfg.dataId&group=test"
   ```

3. **访问Nacos控制台**：默认人用户名和密码为**nacos**

   ```sh
   http://localhost:8848/nacos/
   ```

# 第二章 Nacos配置中心

## 2.1 Nacos配置相关概念

1. 命名空间：命名空间可用于进行不同环境的配置隔离。一般一个环境划分到一个命名空间

2. Group：配置分组用于将不同的服务可以归类到同一分组。一般将一个项目的配置分到一组
3. Data ID：在系统中，一个配置文件通常就是一个配置集。一般微服务的配置就是一个配置集

## 2.2 Nacos配置控制台

1. **命名空间**：在控制台可以实现命名空间的基本操作；默认的public命名空间不可以删除；命令空间的ID是在SpringCloud的配置项的值，如果需要在项目中切换工作环境的配置除了需要指定`spring.profiles.active`的标识外，还需要重新指定`spring.clond.nacos.config.namespace`的值为对应命名空间的id。
2. **发布配置**：在配置列表实现对配置的基本操作；Data Id的命名规范是：`{spring.application.name}-{spring.profiles.active}.{spring.clond.nacos.config.file-extension}`（应用名称-profile.文件后缀名）；
3. **修改配置**：配置的基本操作
4. **回滚配置**：配置的基本操作
5. **导出与导入**：配置的管理

## 2.3 SpringCloud引入Nacos配置

1. 新建Maven项目，配置SpringCloud环境：Nacos是SpringAlibaba技术栈

   ```xml
    <dependencyManagement>
           <dependencies>
               <!--SpringCloudDependencies-->
               <dependency>
                   <groupId>org.springframework.cloud</groupId>
                   <artifactId>spring-cloud-dependencies</artifactId>
                   <version>Hoxton.SR1</version>
                   <type>pom</type>
                   <scope>import</scope>
               </dependency>
   
               <!--SpringBootDependencies-->
               <dependency>
                   <groupId>org.springframework.boot</groupId>
                   <artifactId>spring-boot-dependencies</artifactId>
                   <version>2.2.2.RELEASE</version>
                   <type>pom</type>
                   <scope>import</scope>
               </dependency>
   
               <!--SpringCloudAlibabaDependencies-->
               <dependency>
                   <groupId>com.alibaba.cloud</groupId>
                   <artifactId>spring-cloud-alibaba-dependencies</artifactId>
                   <version>2.1.0.RELEASE</version>
                   <type>pom</type>
                   <scope>import</scope>
               </dependency>
           </dependencies>
       </dependencyManagement>
   ```

2. 添加Nacos相关依赖以及测试环境依赖

   ```xml
       <dependencies>
           <dependency>
               <groupId>org.springframework.boot</groupId>
               <artifactId>spring-boot-starter-web</artifactId>
           </dependency>
           <dependency>
               <groupId>com.alibaba.cloud</groupId>
               <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
           </dependency>
           <dependency>
               <groupId>com.alibaba.cloud</groupId>
               <artifactId>spring-cloud-starter-alibaba-nacos-config</artifactId>
           </dependency>
       </dependencies>
   ```

3. 新增主启动类，并添加Nacos相关配置：bootstrap.yml

   -  **bootstrap.yml（bootstrap.properties）**用来在程序引导时执行，应用于更加早期配置信息读取，如可以使用来配置application.yml中使用到参数等
   - **application.yml（application.properties)** 应用程序特有配置信息，可以用来配置后续各个模块中需使用的公共参数等。

   ```yaml
   server:
     port: 3377
   
   spring:
     application:
       name: alibaba-config
     cloud:
       nacos:
         discovery:
           server-addr: 127.0.0.1:8848
         config:
           server-addr: 127.0.0.1:8848
           file-extension: yaml
           group: DEFAULT_GROUP
   ```
   

## 2.4 配置管理

1. 使用@Value读取配置属性

2. 使用@Configuration + @ConfigurationProperties封装配置属性

3. 扩展dataId（读取多个配置文件）：ext-config[0++]，从0开始

   ```yaml
   spring:
     application:
       name: alibaba-config
     cloud:
       nacos:
         config:
         	ext-config[0]: 
         		data-id: 
         		group: 
           ext-config[1]: 
         		data-id: 
         		group: 
         		refresh: true
   ```

4. 配置共享data-id：

# 第三章 Nacos服务中心

# 第四章 Nacos运维

## 4.1 单机模式-试用

## 4.2 集群模式-高可用

## 4.3 多集群模式-多数据中心



