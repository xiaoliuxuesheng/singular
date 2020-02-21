# 第七章 Hystrix断路器

## 7.1 功能简介

- 在一个分布式系统里，许多依赖不可避免的会调用失败，比如超时、异常等，如何能够保证在一个依赖出问题的情况下，不会导致整体服务失败，这个就是Hystrix需要做的事情。
- Hystrix提供了熔断、隔离、Fallback、cache、监控等功能，能够在一个、或多个依赖同时出现问题时保证系统依然可用

## 7.2 Hystrix如何解决依赖隔离

1. Hystrix使用命令模式HystrixCommand(Command)包装依赖调用逻辑，每个命令在单独线程中/信号授权下执行。
2. 可配置依赖调用超时时间,超时时间一般设为比99.5%平均时间略高即可.当调用超时时，直接返回或执行fallback逻辑。
3. 为每个依赖提供一个小的线程池（或信号），如果线程池已满调用将被立即拒绝，默认不采用排队.加速失败判定时间。
4. 依赖调用结果分:成功，失败（抛出异常），超时，线程拒绝，短路。 请求失败(异常，拒绝，超时，短路)时执行fallback(降级)逻辑。
5. 提供熔断器组件,可以自动运行或手动调用,停止当前依赖一段时间(10秒)，熔断器默认错误率阈值为50%,超过将自动运行。
6. 提供近实时依赖的统计和监控

## 7.3 Hystrix服务熔断的使用

### 1. 什么是服务熔断

- 熔断机制是应对雪崩效应的一种微服务的链路保护机制

- 当扇出的链路出现异常,会进行服务降级,进而会熔断该服务的使用,并快速响应错误的信息
- 当检测到该节点的微服务调用正常后恢复该链路

### 2. 服务熔断的基本配置

- 新建具有熔断功能的服务供应者服务

  - 添加依赖

    ```pom
            <dependency>
                <groupId>org.springframework.cloud</groupId>
                <artifactId>spring-cloud-starter-hystrix</artifactId>
            </dependency>
    ```

  - 设置配置

    ```yml
    eureka:
      client:
        service-url:
          defaultZone: 注册中心集群
      instance:
        instance-id: cloud-server-dept-provider-hystrix
        prefer-ip-address: true     #访问路径可以显示IP地址
    ```

- 定义服务提供者接口访问并控制熔断FallBack

  ```java
  
  @GetMapping(value = "/{id}")
  @HystrixCommand(fallbackMethod = "HystrixCommandFindById")
  public Employee findById(@PathVariable(value = "id") Long id){
      Employee byId = this.employeeServiceImpl.findById(id);
      if (null == byId){
          throw new RuntimeException("员工id为"+id+"不存在,查找失败");
      }
      return byId;
  
  }
  
  public Employee HystrixCommandFindById(@PathVariable(value = "id") Long id){
      Employee e = new Employee();
      e.setUsername("员工id为\"+id+\"不存在,查找失败");
      return e;
  }
  ```

  > fallbackMethod : 表示可处理的备选相应

- 在该微服务的主启动类添加

  ```java
  @EnableCircuitBreaker
  ```

  > 表示开启服务熔断功能

- 缺点
  - 接口方法与熔断处理严重耦合
  - 一个接口方法要对应设计一个熔断方法 : 方法量膨胀

## 7.3 服务降级

### 1. 服务降级描述

- Fallback相当于是降级操作. 对于查询操作, 我们可以实现一个fallback方法, 当请求后端服务出现异常的时候, 可以使用fallback方法返回的值. fallback方法的返回值一般是设置的默认值或者来自缓存.告知后面的请求服务不可用了，不要再来了。

### 2. 配置服务接口的服务降级

- 给服务接口添加FallbackFactory类

  - 实现接口 `FallbackFactory<泛型为服务接口>`

  - 实现接口方法

    ```java
    public EmployeeFeignService create(Throwable throwable) {
    	//new 服务接口 : 采用匿名类的方式返回接口并设置接口降级方法的实现
    }
    ```

- 将工厂类注入Spring容器

  ```java
  @Component
  ```

- 修改服务接口的标签

  ```java
  @FeignClient(name = "注册中心服务名称",fallbackFactory = 工厂类的类对象)
  ```

- 在访问客户端添加yml配置

  ```yml
  feign:
    hystrix:
      enabled: true
  ```

- 关闭服务提供者测试服务降级

## 7.4 服务监控

### 1. 基本环境配置

- 新建服务监控服务

- 添加依赖

  ```pom
  		<dependency>
              <groupId>org.springframework.cloud</groupId>
              <artifactId>spring-cloud-starter-hystrix</artifactId>
          </dependency>
          <dependency>
              <groupId>org.springframework.cloud</groupId>
              <artifactId>spring-cloud-starter-hystrix-dashboard</artifactId>
          </dependency>
          <dependency>
              <groupId>org.springframework.boot</groupId>
              <artifactId>spring-boot-starter-actuator</artifactId>
          </dependency>
  ```

- 修改配置文件 : 端口信息之类

  ```yml
  server:
    port: 9001
  ```

- 配置主启动类 : 启动服务监控

  ```java
  @EnableHystrixDashboard
  ```

- 给需要监控的服务添加依赖支持

  ```pom
          <dependency>
              <groupId>org.springframework.boot</groupId>
              <artifactId>spring-boot-starter-actuator</artifactId>
          </dependency>
  ```

- 启动主启动类 : 访问页面客户端

  ```url
  http://localhost:9001/hystrix
  ```

### 2. 填写监控地址

- 监控的服务地址

  ```url
  http://hystrix-app:端口/hystrix.stream 
  ```

- Delay : 延迟监控时间 : 默认2000毫秒

- Title : 服务别名

### 3. 服务管理页面信息

- 七色 : Success | Short-Circuited | Bad Request | Timeout | Rejected | Failure | Error %
- 一圈 : 通过颜色的变化代表实例安全 : 绿色 < 黄色 < 橙色 < 红色
- 一线 : 访问走势

