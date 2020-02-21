# 第八章 Zuul路由

## 8.1 Zuul路由介绍

- 包含了对请求的路由和过滤两大功能
  - 路由功能负责将外部请求转发到具体的微服务上
  - 过滤功能负责对请求过程进行干预,是实现请求校验服务聚合
- Zuul和Eureka整合,将Zuul自身注册为Eureka服务治理下的应用,获取其他服务的信息

## 8.2 Zuul功能介绍

- 验证与安全保障: 识别面向各类资源的验证要求并拒绝那些与要求不符的请求。
- 审查与监控: 在边缘位置追踪有意义数据及统计结果，从而为我们带来准确的生产状态结论。
- 动态路由: 以动态方式根据需要将请求路由至不同后端集群处。
- 压力测试: 逐渐增加指向集群的负载流量，从而计算性能水平。
- 负载分配: 为每一种负载类型分配对应容量，并弃用超出限定值的请求。
- 静态响应处理: 在边缘位置直接建立部分响应，从而避免其流入内部集群。
- 多区域弹性: 跨越AWS区域进行请求路由，旨在实现ELB使用多样化并保证边缘位置与使用者尽可能接近

## 8.3 路由服务环境配置

### 1. 基本环境配置

- 新建路由项目 : 并添加依赖

  ```
  <dependency>
      <groupId>org.springframework.cloud</groupId>
      <artifactId>spring-cloud-starter-zuul</artifactId>
  </dependency>
  <dependency>
      <groupId>org.springframework.cloud</groupId>
      <artifactId>spring-cloud-starter-eureka</artifactId>
  </dependency>
  <!-- actuator监控 -->
  <dependency>
      <groupId>org.springframework.boot</groupId>
      <artifactId>spring-boot-starter-actuator</artifactId>
  </dependency>
  <!-- hystrix容错 -->
  <dependency>
      <groupId>org.springframework.cloud</groupId>
      <artifactId>spring-cloud-starter-hystrix</artifactId>
  </dependency>
  <dependency>
      <groupId>org.springframework.cloud</groupId>
      <artifactId>spring-cloud-starter-config</artifactId>
  </dependency>
  ```

- 添加配置文件并配置

  - 配置端口

    ```yml
    server:
      port: 9870
    ```

  - 配置路由服务名称

    ```yml
    spring:
      application:
        name: microservicecloud-zuul-gateway
    ```

  - 将路由服务注册到服务注册中心

    ```yml
    eureka:
      client:
        service-url:
          defaultZone: 注册中心集群URL
      instance:
        instance-id: gateway-9870.com
        prefer-ip-address: true
    ```

  - 配置服务信息

    ```yml
    info:
      app_name: atguigu-microcloud
      company_name: www.atguigu.com
      build_artifactId: $project.artifactId$
      build_version: $project.version$
    ```

- 配置主启动类

  ```java
  @EnableZuulProxy
  ```

- 启动集群 + 启动服务提供者 + 路由

- 测试

  - 访问服务提供中接口

  - 路由访问服务提供者接口

    ```url
    http://路由域名:路由端口/注册中心服务名称/接口标识
    ```

### 2. 路由映射规则

```yml
zuul:
  routes:
    mydept.serviceId: 注册中心服务名称
    mydept.path: /自定义名称/**
```

> 此时 注册中心服务名称 和 自定义名称都可以使用

### 3 . 忽略注册中心服务名称

```yml
zuul:
  ignored-services: 将注册中心服务名称忽略
```

``` yml
zuul:
  ignored-services: "*"  # 忽略所有微服务路由访问
```

> 路由访问路径 :` http://路由域名:路由端口/自定义映射名称/接口标识`

#### 4. 设置统一公共前缀

```yml
zuul:
  prefix: /前缀资源url
```

> 路由访问路径 :` http://路由域名:路由端口/前缀/自定义映射名称/接口标识`

