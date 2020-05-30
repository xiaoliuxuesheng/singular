# 第一章 Eureka介绍

## 1.1 Eureka的介绍

​		Eureka包含两种组件：**Eureka Server**和**Eureka Client**。

​		**Eureka Server**提供服务注册服务，各个节点启动后，会在Eureka Server中进行注册，这样Eureka Server中的服务注册表中将会存储所有可用服务节点的信息，服务节点的信息可以在界面中直观的看到。Eureka Server本身也是一个服务，默认情况下会自动注册到Eureka注册中心。如果搭建单机版的Eureka Server注册中心，则需要配置取消Eureka Server的自动注册逻辑。毕竟当前服务注册到当前服务代表的注册中心中是一个说不通的逻辑。Eureka Server通过Register、Get、Renew等接口提供服务的注册、发现和心跳检测等服务。server端会不断的检查client端是否存活，心跳检测，健康检查，负载均衡功能

​		Eureka Client是一个java客户端，用于简化与Eureka Server的交互，**客户端同时也具备一个内置的、使用轮询(round-robin)负载算法的负载均衡器。在应用启动后**，将会向Eureka Server发送心跳,**默认周期为30秒**，如果Eureka Server在多个心跳周期内没有接收到某个节点的心跳，Eureka Server将会从服务注册表中把这个**服务节点移除(默认90秒)**。Eureka Client分为两个角色，分别是：Application Service(Service Provider)服务提供方，是注册到Eureka Server中的服务,Application Client(Service Consumer)服务消费方，通过Eureka Server发现服务，并消费。

## 1.2 SpringCloud与SpringBoot版本选择

- SpringCloud是Spring在微服务领域提供的一整套的解决方案，而大部分的技术方案是基于SpringBoot而开发的，所以在选择SpringCloud版本时候，需要特别注意SpringBoot的版本，需要查看[SpringCloud官网](https://cloud.spring.io/spring-cloud-static/Hoxton.SR3/reference/html/spring-cloud.html)

## 1.3 Eureka停更说明

- Eureka 2.0 的开源工作已经停止，依赖于开源库里面的 Eureka 2.x 分支构建的项目或者相关代码，风险自负！

# 第二章 Eureka Server

## 2.1 开发版本选择

```xml
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-dependencies</artifactId>
            <version>Hoxton.SR3</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-dependencies</artifactId>
            <version>2.2.5.RELEASE</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
<build>
    <plugins>
        <plugin>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-maven-plugin</artifactId>
        </plugin>
        <plugin>
            <groupId>org.apache.maven.plugins</groupId>
            <artifactId>maven-compiler-plugin</artifactId>
            <configuration>
                <source>1.8</source>
                <target>1.8</target>
            </configuration>
        </plugin>
    </plugins>
</build>
```

## 2.2 新增Eurake Server

1. 添加依赖：netflix-eureka-server

   ```xml
   <dependencies>
       <dependency>
           <groupId>org.springframework.boot</groupId>
           <artifactId>spring-boot-starter-web</artifactId>
       </dependency>
       <dependency>
           <groupId>org.springframework.cloud</groupId>
           <artifactId>spring-cloud-starter-netflix-eureka-server</artifactId>
       </dependency>
   </dependencies>
   ```

2. 单机吧Eurake配置详解

   ```yaml
   server:
     port: 7001
   
   eureka:
     instance:
       hostname: eureka7001.com 
     client:
       register-with-eureka: false 
       fetch-registry: false 
       service-url:
         defaultZone: http://eureka7001.com:7001/eureka/
   ```

3. 添加Eureka Server启动类

   ```java
   @SpringBootApplication
   @EnableEurekaServer
   public class Service7001 {
       public static void main(String[] args) {
           SpringApplication.run(Service7001.class, args);
       }
   }
   ```

# 第三章 Eureka Client

1. 新建注册中心，添加依赖

   ```xml
   <dependencies>
       <dependency>
           <groupId>org.springframework.boot</groupId>
           <artifactId>spring-boot-starter-web</artifactId>
       </dependency>
       <dependency>
           <groupId>org.springframework.cloud</groupId>
           <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
       </dependency>
   </dependencies>
   ```

2. 添加Eurake注册中心配置文件

   ```yaml
   server:
     port: 8002
   
   spring:
     application:
       name: provider-eurake-order
   
   eureka:
     instance:
       instance-id: provider-eurake-order8002
       prefer-ip-address: true
     client:
       register-with-eureka: true 
       fetch-registry: true
       service-url:
         defaultZone: http://eureka7001.com:7001/eureka/
   ```

3. 新增主启动类，启用Eurake功能

   ```java
   @SpringBootApplication
   @EnableEurekaClient
   public class ProviderOrConsumer {
       public static void main(String[] args) {
           SpringApplication.run(ProviderOrConsumer.class, args);
       }
   }
   ```

# 第四章 Eureka的负载均衡

1. 定义服务消费端

   ```xml
   <dependencies>
       <dependency>
           <groupId>org.springframework.boot</groupId>
           <artifactId>spring-boot-starter-web</artifactId>
       </dependency>
       <dependency>
           <groupId>org.springframework.cloud</groupId>
           <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
       </dependency>
   </dependencies>
   ```

2. 添加配置

   ```yaml
   server:
     port: 80
   
   spring:
     application:
       name: consumer-eurake-client
   
   eureka:
     instance:
       instance-id: cloud-consumer-order80
       prefer-ip-address: true
     client:
       register-with-eureka: true
       fetch-registry: true
       service-url:
         defaultZone: http://eureka7001.com:7001/eureka/
   ```

3. 设置主启动类

   ```java
   @SpringBootApplication
   @EnableEurekaClient
   public class Client80 {
       public static void main(String[] args) {
           SpringApplication.run(Client80.class, args);
       }
   }
   ```

4. 配置负载均衡的RestTemplate

   ```java
   @Bean
   @LoadBalanced
   public RestTemplate restTemplate(){
       return new RestTemplate();
   }
   ```

5. 定义接口，消费服务

   ```java
   @RestController
   public class ClientController {
   
       public static final String URL = "http://provider-eurake-order/";
       
       @Autowired
       private RestTemplate restTemplate;
   
       @GetMapping(value = "/client/{id}")
       public Map<String, Object> getByOrder(@PathVariable("id") Integer id){
           return restTemplate.getForEntity(URL + "order/" + id, Map.class).getBody();
       }
   
   }
   ```

   