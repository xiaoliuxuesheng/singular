# 第一章 Spring相关概念

## 1.1 Spring概述

- Spring框架是轻量级的开源的JavaEE框架
- Spring解决企业应用开发的复杂性
- Spring的核心功能：IOC和AOP
- Spring框架的特定
  - 方便解耦、简化开发
  - AOP编程的支持
  - 方便程序的测试
  - 方便整合其他框架
  - 降低JavaEE应用的开发
  - 方便的事务操作

## 1.2 Spring概念

1. IOC（控制反转）：把创建对象的过程交给Spring进行管理；
2. AOP（面向切面编程）：是对OOP（面向对象）的扩展，即在不改变对象原有结构的前提下，完成对对象方法层面的增强；

## 1.3 Spring的组件化

| spring 测试模块 | 测试组件说明 |
| --------------- | ------------ |
| spring-test     | 测试组件     |

| spring 核心            | 核心模块说明                         |
| ---------------------- | ------------------------------------ |
| spring-beans           | Bean工厂与装配                       |
| spring-core            | 核心模块 依赖注入IOC和DI的最基本实现 |
| spring-context         | 上下文，即IOC容器                    |
| spring-context-support | 对IOC的扩展，以及IOC子容器           |
| spring-context-indexer | 类管理组件和Classpath扫描            |
| spring-expression      | 表达式语句                           |

| spring AOP        | 切面编程说明                |
| ----------------- | --------------------------- |
| spring-aop        | 面向切面编程，CGLB,JDKProxy |
| spring-aspects    | 集成AspectJ，Aop应用框架    |
| spring-instrument | 动态Class Loading模块       |

| spring Data | 说明                                         |
| ----------- | -------------------------------------------- |
| spring-jdbc | 提供JDBC主要实现模块，用于简化JDBC操作       |
| spring-orm  | 主要集成Hibernate,jpa,jdo等                  |
| spring-tx   | spring-jdbc事务管理                          |
| spring-oxm  | 将java对象映射成xml数据或将xml映射为java对象 |
| spring-jms  | 发送和接受消息                               |

| spring web       | 说明                                  |
| ---------------- | ------------------------------------- |
| spring-web       | 最基础的web支持，主要建立在核心容器上 |
| spring-webmvc    | 实现了spring mvc的web应用             |
| spring-websocket | 主要与前端页的全双工通讯协议          |
| spring-webflux   | 一个新的非阻塞函数式Reactive Web框架  |

| spring message   | 说明                     |
| ---------------- | ------------------------ |
| spring-messaging | 主要集成基础报文传送应用 |

| spring Instrumentation | 说明 |
| ---------------------- | ---- |
| spring-instrument      |      |

## 1.4 Spring入门案例

1. 新建Maven项目

2. 添加Spring依赖

   ```xml
   <dependency>
       <groupId>org.springframework</groupId>
       <artifactId>spring-context</artifactId>
       <version>5.2.6.RELEASE</version>
   </dependency>
   <dependency>
       <groupId>commons-logging</groupId>
       <artifactId>commons-logging</artifactId>
       <version>1.1.3</version>
   </dependency>
   <dependency>
       <groupId>junit</groupId>
       <artifactId>junit</artifactId>
       <version>4.12</version>
   </dependency>
   <dependency>
       <groupId>org.projectlombok</groupId>
       <artifactId>lombok</artifactId>
       <version>1.18.10</version>
   </dependency>
   ```

3. 定义普通的Java类：需要被Spring管理的对象都称为一个Spring组件，这些组件有统一的名称称为bean

   ```java
   public class User {
       public void show(){
           System.out.println("use对象调用了show方法");
       }
   }
   ```

4. 创建Spring配置文件

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <beans xmlns="http://www.springframework.org/schema/beans"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="
          http://www.springframework.org/schema/beans 
          http://www.springframework.org/schema/beans/spring-beans.xsd">
   
       <bean name="user" class="com.spring5.demo01.User"></bean>
   </beans>
   ```

5. 测试：从Spring容器中获取User类的对象并调用User类中的API

   ```java
   @Test
   public void testGetBeanToSpring() {
       ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext("bean-01.xml");
       User user = context.getBean("user", User.class);
       System.out.println("user = " + user);
       user.show();
   }
   ```

# 第二章 IOC容器

## 2.1 IOC概述

## 2.2 IOC 相关操作

### 1. 初始化IOC容器

- **ClassPathXmlApplicationContext**：通过加载项目根目录中的Spring的xml配置文件初始化IOC容器；

  ```java
  ApplicationContext ioc = 
      new ClassPathXmlApplicationContext("classpath:配置文件路径");
  ```

- **FileSystemXmlApplicationContext**：通过加载系统磁盘中Spring的xml配置文件初始化IOC容器；

  ```java
  ApplicationContext ioc = new FileSystemXmlApplicationContext("系统磁盘路径");
  ```

- **AnnotationConfigApplicationContext**：通过加载Java的Spring配置类初始化IOC容器；

  ```java
  ApplicationContext context = new AnnotationConfigApplicationContext(Java配置类.class);
  ```

### 2. 从IOC容器中获取Bean

- **根据bean的标识名称**：在xml中bean的标识是bean标签的name属性值，在java代码中bean的标识是方法名称；在IOC容器中，一个Bean可以有多个name标识，但是一个name标识不能用在多个Bean上

  ```java
  org.springframework.beans.factory.BeanFactory#getBean(java.lang.String)
  ```

- **根据Bean的类型**：如果IOC中改类型的Bean有多个 ，用类型获取Bean会报错

  ```java
  org.springframework.beans.factory.BeanFactory#getBean(java.lang.Class<T>)
  ```

- **根据Bean标识和Bean类型**：

  ```java
  org.springframework.beans.factory.BeanFactory#getBean(java.lang.String, java.lang.Class<T>)
  ```

### 3. 向IOC容器中注入Bean

### 4. 为Bean的各种属性赋值

### 5. 注入Bean的高级特性

## 2.3 IOC底层原理

### 1. 核心接口

- BeanFactory
  - 只提供的最基本的IOC功能
  - 在容器启动时候不会实例化bean

- ApplicationContext
  - 继承自BeanFactory工厂, 而且提供了容器之外的功能
  - 在容器启动时就会实例化bean

### 2. 源码准备

- xml解析
- 注解解析与自定义注解
- 单例模式
- 工厂模式

### 3. 源码解析

- 

第三章 AOP

第四章 JDBCTemplate

 第五章 事物管理

第六章 Spring5新特性

