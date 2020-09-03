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

- 在CMD窗口执行Maven命令打包源码

  ```sh
  mvn -Prelease-nacos -Dmaven.test.skip=true clean install -U  
  ```

- 查看打包完成后的文件：打包后的安装包目录distribution/target/

  ```sh
  ls -al distribution/target/
  ```

## 1.2 安装与配置

### 1、配置说明

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

# 第三章 Nacos服务中心

# 第四章 Nacos运维

