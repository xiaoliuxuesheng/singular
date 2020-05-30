# 第九章 SpringCloud Config配置中心

## 9.1 配置中心介绍

- 解决分布式系统的配置问题 : 每个微服务的系统中都会有数量众多的微服务和与之对应的配置文件
- 在分布式系统中，由于服务数量巨多，为了方便服务配置文件统一管理，实时更新，所以需要分布式配置中心组件。
- Config为微服务架构中的微服务提供集中化的外部配置支持,配置服务器为各个不同微服务应用的所有环境提供了一个中性化的外部配置

- SpringCloud Config分为服务端和客户端
  - 服务端 : 分布式配置中心 , 是一个独立的微服务应用,用来连接配置服务器并为客户端提供配置信息

## 9.2 config服务端配置

### 1. 初步配置

- 新建远程Git仓库 , 并克隆到本地

- 新建application.yml文件,修改并提交到远程

  ```yml
  spring: 
    profiles: 
      active: 
      - dev
      
  ---
  spring: 
    profiles: dev
    application:
      name: springcloud-config-dev
    
  ---
  spring: 
    profiles: test
    application:
      name: springcloud-config-test
  ```

- 新建config微服务,添加依赖

  ```pom
          <dependency>
              <groupId>org.springframework.cloud</groupId>
              <artifactId>spring-cloud-config-server</artifactId>
          </dependency>
  ```

- 配置config类

  ```yml
  server:
    port: 3344
  
  spring:
    application:
      name:  microservicecloud-config
    cloud:
      config:
        server:
          git:
            uri: GitHub上面的git仓库名字
  ```

- 添加主启动类

  ```java
  @EnableConfigServer
  ```

- 测试访问

  ```url
  http://config服务于民:端口/application-配置模块名称.yml
  ```

  - 配置文件读取规则

    > application-{profile}.yml
    >
    > application/{profile}/{lable}
    >
    > {lable}/application-{profile}.yml

### 2. 通过客户端获取Git远程配置

- 新建客户端配置文件,并上传

  ```yml
  spring: 
    profiles: 
      active: 
      - dev
      
  ---
  server: 
    port: 8201
  spring: 
    profiles: dev
    application:
      name: springcloud-config-dev
  eureka: 
    client: 
      service-uri: 
        defaultZone: http://eurake-dev:7001/eurake/
  ---
  spring: 
    profiles: test
    application:
      name: springcloud-config-test
  eureka: 
    client: 
      service-uri: 
        defaultZone: http://eurake-test:7001/eurake/
  ```

- 新增config客户端微服务,添加依赖

  ```yml
          <dependency>
              <groupId>org.springframework.cloud</groupId>
              <artifactId>spring-cloud-starter-config</artifactId>
          </dependency>
  ```

- 添加配置文件 : bootstrap.yml

  ```yml
  spring:
    cloud:
      config:
        name: github上客户端配置文件的文件名称
        label: 文件所在的分支
        profile: dev
        uri: config服务端地址
  ```

  - application.yml : 是用户级别的配置文件
  - bootstrap.yml : 是系统级别的配置文件,bootstrap配置文件的属性具有高优先级,和用户配置文件配置分离

- 添加主启动类

- 测试配置controller读取git配置文件

  ```java
      @Value(value = "${spring.application.name}")
      private String applicationName;
  
      @Value(value = "${eureka.client.service-uri.defaultZone}")
      private String eurekaServer;
  
      @Value(value = "${server.port}")
      private String serverPort;
  ```

  