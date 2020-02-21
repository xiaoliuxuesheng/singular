# 第四章 Eureka服务注册与发现

## 4.1 Eureka简介

- Netflix在设计Eureka时遵守的是AP原则
- 是以及Rest的服务
- 用于服务注册与发现

## 4.2 Eureka基本原理

- 是采用C-S设计架构
  - Eureka-sever : 作为服务注册中心
  - Eureka-client
    - 系统中的其他微服务通过客户端连接Eureka-sever
    - 管理人员可以通过监控客户端状态查看客户端服务

## 4.3 Eureka服务注册中心配置

### 1. 基本配置

- 新建服务注册中心微服务 

- 添加eureka-server依赖

  ```pom
          <dependency>
              <groupId>org.springframework.cloud</groupId>
              <artifactId>spring-cloud-starter-config</artifactId>
          </dependency>
          <dependency>
              <groupId>org.springframework.cloud</groupId>
              <artifactId>spring-cloud-starter-eureka-server</artifactId>
          </dependency>
  ```

- 修改配置文件

  ```yml
  server:
    port: 7001
  
  
  eureka:
    instance:
      hostname: locaohost
    client:
      register-with-eureka: false
      fetch-registry: false
      service-url:
        defaultZone: http://${eureka.instance.hostname}:${server.port}/eureka
  ```

- 配置启动类

  ```java
  @EnableEurekaServer
  ```

- 访问测试

  ```url
  http://localhost:7001/
  ```

### 2. 注册中心自我保护机制

- 默认情况下，如果Eureka Server在一定时间内没有接收到某个微服务实例的心跳，Eureka Server将会注销该实例（默认90秒）。但是当网络分区故障发生时，微服务与Eureka Server之间无法正常通信，以上行为可能变得非常危险了——因为微服务本身其实是健康的，此时本不应该注销这个微服务。

- Eureka通过“自我保护模式”来解决这个问题——当Eureka Server节点在短时间内丢失过多客户端时（可能发生了网络分区故障），那么这个节点就会进入自我保护模式。一旦进入该模式，Eureka Server就会保护服务注册表中的信息，不再删除服务注册表中的数据（也就是不会注销任何微服务）。当网络故障恢复后，该Eureka Server节点会自动退出自我保护模式。

- 自我保护模式是一种应对网络异常的安全保护措施。它的架构哲学是宁可同时保留所有微服务（健康的微服务和不健康的微服务都会保留），也不盲目注销任何健康的微服务。使用自我保护模式，可以让Eureka集群更加的健壮、稳定。

- 禁用自我保护机制

  ```yml
  eureka: 
    server: 
      enable-self-preservation: false
  ```

### 3. Eureka集群配置

- 新建集群注册中心微服务

- 配置每个注册中心

  ```yml
  server:
    port: 7003
  eureka:
    instance:
      hostname: eurake7003.com
        defaultZone: 多个集群的访问地址,用逗号分隔
  ```

  > 修改端口与主机
  >
  > 添加Eureka集群注册中心

- 微服务客户端注册集群环境

  ```yml
  eureka:
    client:
      service-url:
        defaultZone: 所有集群环境的注解地址,用逗号分隔
  ```

## 4.4 服务注册

### 1. 基本配置

- 给需要注册的服务添加依赖

  ```pom
          <dependency>
              <groupId>org.springframework.cloud</groupId>
              <artifactId>spring-cloud-starter-eureka</artifactId>
          </dependency>
          <dependency>
              <groupId>org.springframework.cloud</groupId>
              <artifactId>spring-cloud-starter-config</artifactId>
          </dependency>
  ```

- 给注册的服务添加配置

  ```yml
  eureka:
    client:
      service-url:
        defaultZone: http://localhost:7001/eureka
  ```

  > 指定注册中的地址

- 配置启动类

  ```java
  @EnableEurekaClient
  ```

- 访问测试

  ```url
  http://localhost:7001/
  ```

### 2. 微服务主机名称修改

```yml
eureka:
  instance:
    instance-id:主机名称
```

### 3. 微服务访问信息IP提示

```yml
eureka:
  instance:
    prefer-ip-address: true
```

### 4. 微服务/info信息添加

- 添加信息监控依赖

  ```pom
          <dependency>
              <groupId>org.springframework.boot</groupId>
              <artifactId>spring-boot-starter-actuator</artifactId>
          </dependency>
  ```

- 父工程添加<build>配置

  ```xml
  <build>
      <finalName>microservicecloud</finalName>
      <resources>
          <resource>
              <directory>src/main/resources</directory>
              <filtering>true</filtering>
          </resource>
      </resources>
      <plugins>
          <plugin>
              <groupId>org.apache.maven.plugins</groupId>
              <artifactId>maven-resources-plugin</artifactId>
              <configuration>
                  <delimiters>
                      <delimit>$</delimit>
                  </delimiters>
              </configuration>
          </plugin>
      </plugins>
  </build>
  ```

- 在微服务中添加属于自己的info信息

  ```yml
  info:
    app_name: cloud-server-provider-8001
    company_name: www.atguigu.com
    build_artifactId: $project.artifactId$
    build_version: $project.version$
  ```

## 4.5 Eureka与Zookeeper

- 