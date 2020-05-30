# 第五章 Ribbon负载均衡

## 5.1 Ribbon简介

- Spring Cloud Ribbon是一个基于HTTP和TCP的客户端负载均衡工具，它基于Netflix Ribbon实现
- 可以让我们轻松地将面向服务的REST模版请求自动转换成客户端负载均衡的服务调用。
- 它几乎存在于每一个Spring Cloud构建的微服务和基础设施中

## 5.2 负载均衡

- 为负载均衡是对系统的高可用、网络压力的缓解和处理能力扩容的重要手段之一。
- 我们通常所说的负载均衡都指的是服务端负载均衡，其中分为硬件负载均衡和软件负载均衡

## 5.3 Ribbon配置

### 1. 初步配置

- 微服务是客户端的负载均衡 : 服务消费者访问时候的配置 

- 添加Ribbon依赖 : Ribbon是依赖Eureka的

  ```pom
          <dependency>
              <groupId>org.springframework.cloud</groupId>
              <artifactId>spring-cloud-starter-eureka</artifactId>
          </dependency>
          <dependency>
              <groupId>org.springframework.cloud</groupId>
              <artifactId>spring-cloud-starter-ribbon</artifactId>
          </dependency>
          <dependency>
              <groupId>org.springframework.cloud</groupId>
              <artifactId>spring-cloud-starter-config</artifactId>
          </dependency>
  ```

- 添加Ribbon配置 : 给服务的客户端添加配置

  ```yml
  eureka:
    client:
      register-with-eureka: false
      service-url:
        defaultZone: 添加服务注册集群的地址,用逗号分隔
  ```

- 给Rest请求添加负载均衡算法 : @LoadBalanced

  ```java
  @Bean
  @LoadBalanced
  public RestTemplate getRestTemplate(){
      return new RestTemplate();
  }
  ```

- 在服务端主启动类开启Eureka客户端

  ```java
  @EnableEurekaClient
  ```

- 修改Rest访问地址 : 从访问服务生产者该为访问注册心的服务名称

  ```java
  //之前访问的是生产者地址
  public static final String PROVIDER_URL = "http://127.0.0.1:8001";
  
  //配置服务注册中心的服务名称 : Application
  public static final String PROVIDER_URL = "http://CLOUD-SERVER-PROVIDER-8001";
  ```

### 2. 负载均衡环境搭建

- 定义多个生产者并注册进服务中心
  - 服务名称不可以修改

    ```properties
    spring.application.name=这个表示注册中心的名称,表示这个微服务在这个注册中心中
    ```

  - 修改主机与端口

    ```properties
    server.port=这个微服务的端口
    ```

  - 修改微服务的主机名称

    ```properties
    eureka.instance.instance-id=这个微服务的名称
    ```

### 3. Ribbon核心组件IRule

#### ▲ 简介

- 根据特定的算法中从服务列表中选取一个要访问的服务

#### ▲ Ribbon提供的IRule算法

| IRule实现类               | 功能描述                                                     |
| ------------------------- | ------------------------------------------------------------ |
| RoundRobinRule            | 轮询，依次执行每个执行一次**(默认)**                         |
| RandomRule                | 随机                                                         |
| AvailabilityFilteringRule | 1.会先过滤掉多次访问故障而处于断路器跳闸状态的服务<br/>2.和过滤并发的连接数量超过阀值得服务，然后对剩余的服务列表安装轮询策略进行访问 |
| WeightedResponseTimeRule  | 1、根据平均响应时间计算所有的服务的权重，响应时间越快服务权重越大，容易被选中的概率就越高。<br />2、刚启动时，如果统计信息不充中，则使用RoundRobinRule(轮询)策略，等统计的信息足够了会自动的切换到WeightedResponseTimeRule |
| RetryRule                 | 1、先按照RoundRobinRule(轮询)的策略获取服务，如果获取的服务失败侧在指定的时间会进行重试，进行获取可用的服务<br />2、如多次获取某个服务失败，这不会再再次获取该服务 |
| BestAvailableRule         | 会先过滤掉由于多次访问故障而处于断路器跳闸状态的服务，然后选择一个并发量最小的服务 |
| ZoneAvoidanceRule         | 默认规则，复合判断Server所在区域的性能和Server的可用性选择服务器 |

### 4. 自定义Ribbon负载均衡算法

- 自定义负载均衡算法类 : 仿照Ribbon提供的算法实现类

  ```java
  public class 自定义实现类 extends AbstractLoadBalancerRule
  ```

- 自定义负载均衡配置类

  - 注意点一 : 配置类不能在主启动类包以及子包下**,否则这个配置会被所有Ribbon客户端共享**
  - 注意点二 : 这个配置类需要添加 配置类标签 : `@Configuration`
  - 注意点三 : 在这个配置类中注入Bean : 自定义的算法类 `@Bean`

- 在服务端的主启动类上开启Ribbon客户端功能

  ```java
  @RibbonClient(name = "",configuration = MySelfRuleConfig.class)
  ```

  - name : 表示这个这个负载均衡算法约束的服务中心
  - configuration : 表示这个复杂均衡的配置类是哪个

# 第六章 Feign负载均衡

## 6.1 Feign的简介

- 是一个声明式WebService客户端
- 使用 接口 + 注解的方式声明
- Feign可以与Eureka和Ribbon组合使用以支持负载均衡

## 6.2 Feign环境搭建

- 新建一个Feign类型的微服务 : 添加依赖 与配置文件

  ```pom
          <dependency>
              <groupId>org.springframework.cloud</groupId>
              <artifactId>spring-cloud-starter-feign</artifactId>
          </dependency>
  ```

  ```yml
  server:
    port: 80
  
  eureka:
    client:
      register-with-eureka: false
      service-url:
        defaultZone: http://eurake7001.com:7001/eureka,http://eurake7002.com:7002/eureka,http://eurake7003.com:7003/eureka
  ```

  

- 在供API中定义公共接口 : 外部服务可以访问接口

- 接口类的标签 : `@FeignClient`

  ```java
  @FeignClient(name = "CLOUD-SERVER-EMP-PROVIDER")
  ```

  > name : 表示负载均衡约束的注册中心名称

- 接口方法的标签

  - `@RequestMapping` : 接口真实访问的服务提供者的访问URL
  - `@PathVariable` : 接收URL中参数

- 在Feign主启动类添加Feign支持

  ```java
  @SpringBootApplication
  @EnableEurekaClient
  @EnableFeignClients(basePackages = {"com.panda"})
  ```

  