# 第一章 Spring基础

## 1.1 Spring简介

1. <font color='blue'>**Spring是一个开源框架**</font>：是抽取出来的高度可重用的代码, 多个可重用模块的集合, 形成：JavaEE领域的整体解决方案
2. <font color='blue'>**Spring框架是是一个IOC和AOP的容器框架**</font>：基于Spring开发的应用中不依赖Spring的API，并且包含并且管理应用中的对象的关系以及生命周期
3. <font color='blue'>**Spring优良特性**</font>
   - **非浸入式**：Spring应用不依赖Spring的API
   - **依赖注入**：IOC（Bean容器的实现）、DI（依赖注入的实现）
   - **面向切面编程**：AOP（Aspect Oriented Programming）
   - **容器**：包含并管理应用中对象的生产和生命周期
   - **组件化**：通过组件配置实现多种组合式应用
   - **一站式**：在ICO和AOP的基础上可以整合各种开源第三方类库
   - **轻量级** : 可以把直接在Tomcat等符合Servlet规范的web服务器上的Java应用称为轻量级的应用

## 1.2 Spring的模块划分

<img src="https://s1.ax1x.com/2020/06/16/NiVHvd.png" alt="NiVHvd.png" border="0" />

| Spring测试模块         | 组件说明                                     |
| ---------------------- | -------------------------------------------- |
| spring-test            | 测试组件                                     |
| **Spring 核心**        | **组件说明**                                 |
| spring-beans           | Bean工厂与装配                               |
| spring-core            | 核心模块 依赖注入IOC和DI的最基本实现         |
| spring-context         | 上下文，即IOC容器                            |
| spring-expression      | 表达式语句                                   |
| spring-context-support | 对IOC的扩展，以及IOC子容器                   |
| spring-context-indexer | 类管理组件和Classpath扫描                    |
| **Spring 面向切面**    | **组件说明**                                 |
| spring-aop             | 面向切面编程，CGLB,JDKProxy                  |
| spring-aspects         | 集成AspectJ，Aop应用框架                     |
| spring-instrument      | 动态Class Loading模块                        |
| **Spring持久化支持**   | **组件说明**                                 |
| spring-jdbc            | 提供JDBC主要实现模块，用于简化JDBC操作       |
| spring-orm             | 主要集成Hibernate,jpa,jdo等                  |
| spring-tx              | spring-jdbc事务管理                          |
| spring-oxm             | 将java对象映射成xml数据或将xml映射为java对象 |
| spring-jms             | 发送和接受消息                               |
| **SpringWEB支持**      | **组件说明**                                 |
| spring-web             | 最基础的web支持，主要建立在核心容器上        |
| spring-webmvc          | 实现了spring mvc的web应用                    |
| spring-websocket       | 主要与前端页的全双工通讯协议                 |
| spring-webflux         | 一个新的非阻塞函数式Reactive Web框架         |
| **Spring消息支持**     | **组件说明**                                 |
| spring-messaging       | 主要集成基础报文传送应用                     |
| **Spring仪表盘**       | **组件说明**                                 |
| spring Instrumentation | 可视化Spring仪表盘                           |

## 1.3 Spring技术栈 

| Sping技术       | 功能说明                       |
| --------------- | ------------------------------ |
| SpringFramework | Spring核心：包含Spring各种组件 |
| SpringMVC       | SpringWEB支持                  |
| SpringData      | Spring持久化支持               |
| SpringSecurity  | Spring安全支持：认证与授权     |
| SpringBoot      | Spring场景启动自动配置         |
| SpringCloud     | Spring微服务解决方案           |

## 1.5 Spring源码中的技术特点

### <font size=4 color=blue>:anchor: **Java语言特性**</font> 

- 反射
- 动态代理
- 枚举
- 泛型
- 注解
- ARM
- Lambda语法

### <font size=4 color=blue>:anchor: **设计思想和设计模式的实现**</font> 

- OOP
- IoC
- AOP
- DDD
- TDD
- GOF23

### <font size=4 color=blue>:anchor: **JavaAPI的分装与简化**</font> 

- JDBC
- Servlet
- JPA
- JMX
- Bean Validation

### <font size=4 color=blue>:anchor: **JSR规范的适配与实现**</font> 

### <font size=4 color=blue>:anchor: **第三方框架的整合**</font> 

- Mybatis
- Hibernate
- Redis
- ... ...

## 1.4 Spring源码环境构建

1. 下载源码

   ```sh
   git clone https://gitee.com/panda-study-opensource/Spring-Framework.git
   ```

2. 定义学习分支

   ```sh
   git checkout -b panda5.2.4.RELEASE
   ```

3. 查看Git版本并将分支切换到：v5.2.4.RELEASE

   ```sh
   git reset -hard v5.2.4.RELEASE
   ```

4. Gradle安装、Groovy安装

5. 修改build.gradle文件为阿里云仓库地址

   ```groovy
   // 在文件首行添加
   buildscript {
   	repositories {
   		maven {
   			url 'http://maven.aliyun.com/nexus/content/groups/public/'
   		}
   		maven {
   			url 'http://maven.aliyun.com/nexus/content/repositories/jcenter'
   		}
   	}
   }
   
   // 在ext扩展属性之后添加仓库地址
   allprojects {
   	repositories {
   		maven {
   			url 'http://maven.aliyun.com/nexus/content/groups/public/'
   		}
   		maven {
   			url 'http://maven.aliyun.com/nexus/content/repositories/jcenter'
   		}
   	}
   }
   ```

6. 自定义学习Gradle模块，引入Spring源码模块

   ```groovy
   dependencies {
       testCompile group: 'junit', name: 'junit', version: '4.12'	// 添加外部依赖
       compile project(":spring-context")							// 引入内部模块
   }
   ```

# 第二章 SpringIOC

## 2.1 IOC概述

​		Spring的核心是一个**容器框架**：容器主要保存的在Spring应用中创建出来的对象，在Java代码中对象的创建方式是使用new关键字；然而在Spring中对象的创建也是由Spring容器实现，这种实现的方式叫做控制反转（IOC：Inversion of Control），程序从容器中获取对象的过程叫做依赖注入（DI：Dependency Injection）；

## 2.2 Spring Helloworld

1. 使用SpringXML配置文件
   - 
2. 使用Spring注解

