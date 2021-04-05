# 前言

1. 微服务
   - 单体架构
   - 单体拆分
2. 微服务技术栈
   - 基础：基于Spring使用SpringBoot开发
   - 服务调用：RPC、Dubbo、Fegin（Netflix公司开发）、OpenFeign（由Spring团队开发）
   - 服务发现：ZooKeeper、Nacos、Eureka
   - 服务容错：Hystrix、Sentinel
   - 网关：Zuul、Getway
   - 配置中心：SpringCloudCOnfig、ZooKeeper、Nacos
   - 分布式事务
3. 微服务架构
   - 请求 → nginx高可用 → SecurityOAuth认证服务器 → （GetWay网关 → 负载均衡 + Sentinel限流）注册中心 → 微服务集群 → 日志采集集群 + 链路追踪 + 缓存服务集群 + 持久化集群 + 任务管理 + 分布式事务

# 001 版本选择

1. HoxtonSpringCloudAlibaba与SpringBoot兼容版本

   > - https://github.com/alibaba/spring-cloud-alibaba
   >
   > - https://spring.io/projects/spring-cloud

   | SpringBoot | SpringCloud     | SpringAlibaba |
   | ---------- | --------------- | ------------- |
   | 1.5.x      | Edgware/Dalston | 1.5.x         |
   | 2.0.x      | Finchley        | 2.0.x         |
   | 2.1.x      | Greenwich       | 2.1.x         |
   | 2.2.x      | Hoxton          | 2.2.x         |
   | 2.3.x      | Hoxton          |               |
   | 2.4.x      | 2020.0.x        |               |

2. SpringBoot依赖管理

   ```xml
   <!--方式一：使用<parent>标签添加spring-boot-starter-parent-->
   <parent>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-starter-parent</artifactId>
       <version>2.2.0.RELEASE</version>
   </parent>
   
   <!--方式二：使用<dependencyManagement>标签添加spring-boot-dependencies-->
   <properties>
       <spring.boot.version>2.2.0.RELEASE</spring.boot.version>
   </properties>
   <dependencyManagement>
       <dependencies>
           <dependency>
               <groupId>org.springframework.boot</groupId>
               <artifactId>spring-boot-dependencies</artifactId>
               <version>${spring.boot.version}</version>
               <type>pom</type>
               <scope>import</scope>
           </dependency>
       </dependencies>
   </dependencyManagement>
   ```

3. SpringCloud依赖管理

   ```xml
   <properties>
       <spring.cloud.version>Hoxton.SR8</spring.cloud.version>
   </properties>
   <dependencyManagement>
       <dependencies>
           <dependency>
               <groupId>org.springframework.cloud</groupId>
               <artifactId>spring-cloud-dependencies</artifactId>
               <version>${spring.cloud.version}</version>
               <type>pom</type>
               <scope>import</scope>
           </dependency>
       </dependencies>
   </dependencyManagement>
   ```

4. SpringAlibaba依赖管理

   ```xml
   <properties>
       <spring.cloud.alibaba.version>2.2.1.RELEASE</spring.cloud.alibaba.version>
   </properties>
   <dependencyManagement>
       <dependencies>
           <dependency>
               <groupId>com.alibaba.cloud</groupId>
               <artifactId>spring-cloud-alibaba-dependencies</artifactId>
               <version>${spring.cloud.alibaba.version}</version>
               <type>pom</type>
               <scope>import</scope>
           </dependency>
       </dependencies>
   </dependencyManagement>
   ```

# 002 注册中心原理

1. CAP理论

2. 注册中心对比

3. 注册中心安装与使用

   - 添加注册中心依赖

     ```xml
     <dependency>
         <groupId>com.alibaba.cloud</groupId>
    <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
     </dependency>
     <dependency>
         <groupId>org.springframework.cloud</groupId>
         <artifactId>spring-cloud-starter-openfeign</artifactId>
     </dependency>
     ```
     
     

# 003 服务通信

> - 需求概述
>   - User有账户余额、Order有订单列表、Product有库存
>   - User下单：余额减少 -》 订单新增 -》 库存减少
>   - User退款：余额增加 -》 退款订单 -》 库存新增

1. RestTemplate
2. 注册中心+RestTemplate
3. 注册中心 + OpenFeign
4. 注册中心 + OpenFeign + 熔断
5. 注册中心 + OpenFeign + 服务降级.

# 004 Sentinel

1. 高并发带来的问题：
   1. 服务熔断
   2. 服务降级
   3. 隔离
   4. 超时
2. 