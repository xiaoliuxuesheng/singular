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

   

# 学习内容

- 什么是SpringCloudGateway
- 什么是服务网关
- 为什么要用服务网关
- 网关解决的什么问题
- 常用网关解决方案
- 环境准备
- Nginx实现API网关
- Gateway实现API网关
- 路由规则
- 动态路由
- 过滤器
- 网关限流
- 高可用网关

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