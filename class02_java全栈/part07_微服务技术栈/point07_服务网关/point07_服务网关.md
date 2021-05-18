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
5. 环境准备
   - 注册中心
   - 商品服务
   - 订单服务
   - 用户服务
6. 