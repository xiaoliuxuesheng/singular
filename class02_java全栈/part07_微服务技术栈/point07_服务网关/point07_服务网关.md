# 学习内容

1. 什么是SpringCloudGateway

   - SpringCloudGateway是SpringCloud生态中的网关组件，目标是用来替代Netflix Zuul：SpringCloud中引用的Zuul是1.x，是阻塞IO不支持长链接；Zuul 2.x版本一致延期，直到2019年5月开源了支持异步模式的Zuul 2，但是SpringCloud已经不再支持Zuul 2.x了；
   - SpringCloud Gateway是基于Spring生态构建的，提供了统一的路由方式，并且基于Fliter提供了网关的基本功能；提供了简单有效的路由方式；

2. 什么是服务网关

   ![image-20220514104740801](E:\AdminCode\NoteStudy\note_blogs_docsify\class02_java全栈\part07_微服务技术栈\point07_服务网关\resource\point07_服务网关\image-20220514104740801.png)

   - API Gateway（网关）是出现在系统边界的面向API请求的强管控服务，主要作用是隔离外部访问与内部系统服务访问的作用，API网关的流程源于互联网的快速兴起，多种WEB场景对应到不同的后台服务，直接通过前后台的API请求，增加了服务的复杂性；增加API网关，面向用户的WEB场景直接对接API网关，隔离WEB和后台的直接交互；
   - 简单理解服务网关就是多个服务架构系统中所有服务的统一入口：客户端请求统一到服务网关，再由服务网关将请求路由转发到指定服务；

3. 为什么要用服务网关

   - 减少客户端与微服务的直接交互次数，由网关进行统一认证；

4. 网关解决了什么问题

   - 统一接入
   - 协议适配
   - 流量监控
   - 安全防护

5. 常用的网关解决方案

   - Nginx+Lua：Nginx适合做门户网站，作为这个那个全局网关；而gateway属于业务网关，主要用来对应不同的客户端提供服务，用于聚合业务；
   - Kong：是Mashape提供的API管理软件，是对Nginx+Lua进行二次开发，
   - Traefic：是开源GO语言开发的让部署微服务更加便捷的HTTP反向代理
   - SpringCloud Netflix zuul：开发团队延期
   - Spring Cloud gateway：替代Zuul

6. 环境准备

   - Naxos安装

   - Maven项目搭建

     ```xml
     ```

   - 

7. Nginx实现API网关

   - 默认80端口

   - 修改配置文件：根据uri路由到后台服务

     ```ini
     http {
     	server {
     		listen 80;
     		server_name localhost;
     		
     		# 如果路径中有/api-uri就会转发到http://localhost:7070并将uri后面的追加到代理服务地址后
     		location /api-uri {
     			proxy_pass http://localhostL7070/;
     		}
     	}
     }
     ```

8. Gateway实现API网关

   - Gateway核心概念

     1. 路由（Route）：是网关最基础的部分，路由信息有ID，目标URL，一组断言和一组过滤器组成

     2. 断言（Perdicate）：Java8中的断言函数，Gateway中断言函数输入类型是Spring5.0框架中的ServerWebExchange，断言函数允许开发者去定义匹配来自Http Request中的任何信息

     3. 过滤器（Filter）：一个标准的Spring Web Filter，主要包含两种类型：Gateway Filter和Global Filter

        ```yaml
        # 向访问网关服务,网关服务会检查uri
        # 检查uil是否匹配predicates的path,然后代理转发到uri配置的地址
        spring:
          cloud:
            gateway:
              # 路由规则
              routes:
                - id: user-service
                  uri: http://localhost:8301/
                  predicates:
                    - Path=/user
        ```

   - 工作原理

     - 请求发送到路由，网关处理程序Handler Mapping映射确定与请求相匹配的路由
     - 然后将其发送到网关Web处理程序Web Handler，
     - 该处理程序通过制定的过滤器链将请求发送到实际的服务执行业务逻辑
     - 处理完成后再通过网关Filter将结果返回

9. 路由规则

10. 动态路由

11. 过滤器

12. 网关限流

13. 高可用网关

# gateway

1. 环境准备

   - 注册中心：Nacos

   - Product微服务

     - Maven配置

       ```xml
       <dependency>
         <groupId>com.alibaba.cloud</groupId>
         <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
       </dependency>
       ```

     - Yaml配置

       ```yaml
       server:
         port: 8099
       spring:
         application:
           name: service-product
         cloud:
           nacos:
             discovery:
               server-addr: 1.116.215.185:8848
       ```

2. 网关服务创建

   - 添加Maven依赖

     ```xml
     <dependency>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-starter</artifactId>
     </dependency>
     <dependency>
       <groupId>org.springframework.cloud</groupId>
       <artifactId>spring-cloud-starter-gateway</artifactId>
     </dependency>
     ```

   - 配置入门路由

     ```yaml
     server:
       port: 8888
     spring:
       application:
         name: server-gateway
       cloud:
         gateway:
           routes:
             - id: service-product
               uri: http://localhost:8099/
               predicates:
                 - Path=/product/*
     ```

3. 路由规则-path

   - 速度

4. 路由规则-Query：匹配请求中参赛是否包含制定参赛

   - Query=token：匹配请求中包含token的请求
   - Query=token,abc.：匹配请求中包含token并且其参赛只满足表达式abc.的请求

5. 



# nacos 脑残

1. 1.3.2后默认启动是集群启动

2. 根据配置文件初始化数据库

3. 修改application.properties配置文件

   ```properties
   #*************** Config Module Related Configurations ***************#
   ### If use MySQL as datasource:
   spring.datasource.platform=mysql
   
   ### Count of DB:
   db.num=1
   
   ### Connect URL of DB:
   db.url.0=jdbc:mysql://1.116.215.185:3306/xlxs_nacos?characterEncoding=utf8&connectTimeout=1000&socketTimeout=3000&autoReconnect=true&useUnicode=true&useSSL=false&serverTimezone=UTC
   db.user=root
   db.password=root
   ```

4. 然后复制一份cluster.conf.example改名为cluster.conf,内容为集群的服务器ip

5. nacos 部署

   ```SH
   git clone https://github.com/alibaba/nacos.git
   cd nacos/
   mvn -Prelease-nacos -Dmaven.test.skip=true clean install -U  
   ls -al distribution/target/
   
   // change the $version to your actual path
   cd distribution/target/nacos-server-$version/nacos/bin
   
   
   mvn clean install -DskipTests -Drat.skip=true
   ```

   

# 课程

1. 什么是SpringCloudGateway
   - SpringCloud的网关组件最初采用的是Zuul，由于Zuul2.x开发延迟，SpringCloud将Gateway作为微服务生态的网关服务：目标是替代Zuul，Gateway是基于Filter链的方式提供网关的基本功能，
   - Gateway是基于SpringBoot2生态构建的API网关，SpringBoot2支持Spring5，在Spring5中支持Netty，新一代网关Gateway支持netty和http2
   
2. 什么是服务网关：在微服务之前服务网关已经存在了，随着微服务发展，网关支持到单个服务，由网关聚合服务进行统一的服务治理，隔离了外部和内部

3. 为什么要使用网关：
   - 单体服务需要多节点部署：
   - 微服务分布式部署：
   
4. 常用的网关解决方案
   - Nginx+Lua：Nginx配置Lua脚本做网关，适合做门户网关，Gateway是业务网关
   - Kong：基于Nginx+Lua，做二次封装，提供很多增强插件
   - Traefik：是Go语言开发，适合k8s
   - SpringCloudNetflixZuul：
   - SpringCloudGateway：
   
5. 环境准备：https://gitee.com/panda_code_java/demo_springcloud_nacos
   - 注册中心
   - 商品服务
   - 订单服务
   - 用户服务
   
6. 用nginx实现Gateway网关

   - 启动的服务

     - 用户服务：http://localhost:8301/user/
     - 订单服务：http://localhost:8101/
     - 商品服务：http://localhost:8201/

   - 配置nginx：客户端访问80端口（带参数），根据请求url路由到对应的微服务

     ```conf
     server{
     	listen 80;
     	server_name localhost;
     	location /api/ordere {
     		proxy_pass http://localhost:8201/;
     	}
     	location /api-user {
     		proxy_pass http://localhost:8301/;
     	}
     }
     ```

7. Gateway核心概念

   - 添加依赖

     ```xml
     
     ```

   - 核心概念

     - 路由（Route）：包括三部分①ID、②资源的URI、③一组断言；如果断言为真请求匹配则路由到指定资源URI
     - 断言（Predicate）：断言，java8中的断言函数，SpringCLoudGateway中断言函数属性类型是Spring5框架中的ServerWebExchange，SpringCloudGateway中断言函数允许开发者去定义匹配来自于http请求中的任何信息：包含请求头，请求参数；
     - Filter（过滤）：一个标准的SpringWebFilter，SpringCloudGateway中的Filter分为两种类型：分别是Gateway Filter和Global Filter；对请求和响应进行处理；

8. Gateway工作原理

   - 客户端发送请求到服务网关
   - 服务网关处理程序Handler Mapping映射到确定的相匹配的路由
   - 将其发送到网关Web处理程序Web Handler 路由
   - Web Handler经过一系列per过滤器链到达微服务
   - 微服务处理请求回到Gateway的post过滤器链返回

9. 创建网关服务

   - 添加依赖

     ```xml
     <dependency>
         <groupId>org.springframework.cloud</groupId>
         <artifactId>spring-cloud-starter-gateway</artifactId>
     </dependency>
     ```

   - 配置文件

     ```yaml
     server:
       port: 6101
     
     spring:
       application:
         name: gateway-server
     ```

   - 配置路由规则

     ```yaml
     spring:
       application:
         name: gateway-server
       cloud:
         gateway:
           # 路由规则
           routes:
             - id: user-service
               uri: http://localhost:8301/
               predicates:
                 - Path=/user/**
     ```

10. Gateway路由规则：SpringCloudGateway创建Route对象时，使用RouterPredicateFactory创建Predicate对象，Predicate对象合一赋值给Router

    - SpringCloudGateway包含许多内置的Route Predicate Factories
    - 所有这些断言都匹配Http请求的不同属性
    - 多少Route PredicateFactories可以通过逻辑与结合起来一起使用过

11. 路由规则 - Query: 

    ```yaml
    # 请求中是否包含指定参数
    predicates:
    	# 比如下面配置请求中必须有token
    	- Query=token
    	# 参数必须满足一个正则规则 abc. 点表示任意字符
    	- Query=abc.
    ```

12. 路由规则 = Method

    ```yaml
    # 请求方式路由规则
    predicates:
    	# 请求方式必须是POST
    	- Method=POST
    ```

13. 路由规则 - Datetime

    ```yaml
    # 时间匹配
    predicates:
    	# After
    	- After=2020-05-02T20:20:20.000+08:00[Asia/shanghai]
    ```

14. 路由规则 - RemoteAddr = 匹配远程地址请求

15. 路由规则 - Header = 匹配请求头参数

16. 动态路由 - 指的服务发现的路由规则:面向服务的路由,Gateway支持注册中心整合开发,根据serviceId自动从注册中心获取服务地址并请求转发,这样做可以通过单个断点来访问应用的所有服务,并且在添加或移除服务实例时不修改Gateway的路由配置

    - 添加注册中心依赖

      ```xml
      <dependency>
          <groupId>org.springframework.cloud</groupId>
          <artifactId>spring-cloud-starter-gateway</artifactId>
      </dependency>
      <dependency>
          <groupId>com.alibaba.cloud</groupId>
          <artifactId>spring-cloud-starter-alibaba-nacos-discovery</artifactId>
      </dependency>
      ```

    - 配置注册中心

      ```yaml
      server:
        port: 9102
      
      spring:
        application:
          name: gateway-server
        cloud:
          nacos:
            discovery:
              server-addr: localhost:8848
          gateway:
            # 路由规则
            routes:
              - id: user-service
                uri: lb://user-service
                predicates:
                  - Path=/user
      ```

17. 服务名称转发 : http://localhost:9102/product-service/product

    ```yaml
    spring:
      application:
        name: gateway-server
      cloud:
        nacos:
          discovery:
            server-addr: localhost:8848
        gateway:
          discovery:
            # 是否与服务发现组件进行结合 通过servicdId转发到具体的服务实例
            locator:
              enabled: true     # 是否开启基于服务发现的路由规则
              lower-case-service-id: true # 是否将服务名称转小写
    ```

18. 过滤器:

    - GatewayFilter：网关过滤器，需要通过spring.cloud.router.filters配置在具体的路由下，只在当前路由上作用或通过spring.cloud.default.filter配置在全局，作用在所有路由上
    - GlobalFilter：全局过滤器，不需要配置在配置文件中，作用在所有路由上，最终通过GatewayFilterAdapter保证成GatewayFilterChain可识别的过滤器，它为请求业务及路由的URI转为正式业务服务请求地址的核心过滤器，需要配置系统初始化时加载

19. 网关过滤器：

20. 自定义过滤器

    - 实现接口GatewayFilter和Ordered接口

    - filter方法重写：chain.filter继续向下执行

    - 注册过滤器

      ```JAVA
      @Bean
      public RouteLocator routreLocator(RouteLocatorBuilder builder){
      	return builder.routes().route(r->r.
                                       path()
                                       .url()
                                       .filter(new Filter)
                                       .id()
                                       .build())
      }
      ```

21. 自定义全局过滤器

    - 实现接口GlobalFilter和Ordered接口
    - 将Filter添加@Component注解，无需注册

22. Gateway统一鉴权

    - 