# 第一章 Spring相关概念

## 1.1 Spring概述

- Spring框架是轻量级的开源的JavaEE框架
- Spring是一个容器框架，解决企业应用开发的复杂性
- Spring的核心功能：IOC和AOP
- Spring框架的特点
  - **为JavaEE开发提供了一站式的解决方案** ：从基础的IOC容器，已经衍生为Cloud Native的基础设施
  - **非侵入** : 用Spring开发的应用不依赖Spring的API
  - **依赖注入** : 是对IOC思想的实现
  - **面向切面编程** : 是对面向对象的扩展与增强
  - **轻量级** : 可以把直接在Tomcat等符合Servlet规范的web服务器上的Java应用称为轻量级的应用
  - **模块化** : 添加特定模块可以解决特定场景的功能 

## 1.2 Spring概念

1. **IOC（控制反转）**：把创建对象的过程交给Spring进行管理；IOC在Spring中的作用是快速整合其他框架
2. **AOP（面向切面编程）**：是对OOP（面向对象）的扩展，即在不改变对象原有结构的前提下，完成对对象方法层面的增强；AOP在Spring中的作用是开发声明式事务的功能；

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

## 1.5 入们案例总结

1. ApplicationContext（IOC容器接口）：接口的两个实现类ClassPathXmlApplicationContext、FileSystemXmlApplicationContext、AnnotationConfigApplicationContext；
2. 组件对象的创建工作是由IOC容器完成，容器中组件对象的创建是在容器创建时候完成的；
3. 同一个组件在IOC容器中是单实例的；
4. 获取容器中不存在的组件会报错；
5. 组件的属性赋值：组件的属性名是根据get/set方法决定；

# 第二章 IOC容器

## 2.1 IOC概述

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Inversion of Control：控制反转， 是面向对象编程中的一种设计原则，可以用来减低代码之间的耦合度。其中最常见的方式叫做依赖注入（Dependency Injection，简称DI），还有一种方式叫“依赖查找”（Dependency Lookup）。IOC容器管理着所有组件（有功能的类），并管理组件之间的关系：容器通过反射形式进行组件之间的属性赋值。

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

- <font size=4 color='blue'>**注入Bean并根据set方法属性赋值**</font>

  ```java
  @Setter
  @Getter
  public class User {
      private String name;
      private Integer age;
  }
  ```

  ```xml
  <bean name="user" class="com.spring5.demo01.User">
      <property name="name" value="Tom"/>
      <property name="age" value="12"/>
  </bean>
  ```

- <font size=4 color='blue'>**注入bean并根据构造器赋值**</font>：在JavaBean中定义了有参构造器，在xml配置文件中使用构造器为属性赋值

  ```java
  @Setter
  @Getter
  @ToString
  public class User {
  
      private String name;
      private Integer age;
  
      public User(String name, Integer age) {
          this.name = name;
          this.age = age;
      }
  }
  ```

  - **根据构造器参数默认位置**：每个`<constructor-arg>`表示一个构造器参数，默认将参数值赋值给构造器中对应位置的参数上；

    ```xml
    <bean name="user2" class="com.spring5.demo01.User">
        <constructor-arg value="Tom"/>
        <constructor-arg value="23"/>
    </bean>
    ```

  - **指定构造器参数名称**：为标签`<constructor-arg>`指定name属性，IOC容器会根据参数名称进行属性赋值

    ```xml
    <bean name="user3" class="com.spring5.demo01.User">
        <constructor-arg name="name" value="Tom"/>
        <constructor-arg name="age" value="23"/>
    </bean>
    ```

  - **指定构造器参数位置**：在JavaBean中构造器参数的位置是索引标识，在xml配置中指定参数所在索引进行赋值

    ```xml
    <bean name="user4" class="com.spring5.demo01.User">
        <constructor-arg index="0" value="Tom"/>
        <constructor-arg index="1" value="23"/>
    </bean>
    ```

- <font size=4 color='blue'>**定义xml中的名称空间为属性赋值**</font>

- <font size=4 color='blue'>**自定义静态工厂类创建对象**</font>

- <font size=4 color='blue'>**自定义实例工厂类创建对象**</font>

- <font size=4 color='blue'>**用Spring的bean工厂创建对象**</font>

- <font size=4 color='blue'>**指定Bean的生命周期方法**</font>

- <font size=4 color='blue'>**为Bean定义后置处理器**</font>

- <font size=4 color='blue'>**声明Bean的作用域**</font>：创建单实例bean和多实例bean

- <font size=4 color='blue'>**基于xml：配置bean之间的依赖关系改变bean的创建顺序**</font>：默认bean的创建顺序与bean的配置顺序相同

  - depends-on = "依赖的bean,用逗号分隔,按顺序创建"

### 4. 为Bean的各种属性赋值

- 基于xml：为属性赋值：null

- 基于xml：为引用类型赋值：外部bean

- 基于xml：为引用类型赋值：内部bean

- 基于xml：为List属性赋值

- 基于xml：为Map类型属性赋值

- 基于xml：为properties属性赋值

- 基于xml：使用<kbd>util</kbd>名称空间在spring中定义集合

- 基于xml：级联属性赋值

- 基于xml：通过Bean的继承实现配置信息的重用：在xml配置文件中声明`<bean>`标签的parent属性用来指定当前Bean的配置是从哪个Bean继承

  ```xml
  <bean id = "" class = "" parent = ""></bean>
  ```

  - 在xml中定义一个抽象的bean：作用是只能用来被继承，不能获取这个bean的实例

    ```xml
    <bean id = "" class = "" abstract = "true"></bean>
    ```

- **基于xml：的自动装配（自动赋值）**：仅限于为自定义类型的属性根据某种赋值规则进行自动赋值：注入Bean时候自动从IOC容器中获取对应的组件并为Bean中的属性进行赋值；在xml配置文件中声明`<bean>`标签的autowire属性

  ```xml
  <bean id = "" class = "" autowire = ""></bean>
  ```

  > - **autowire = "default | no"**：不自动装配
  > - **autowire = "byType"**：根据属性类型从IOC容器中获取组件并注入到对应的属性中；
  >   - 找不到装配null，
  >   - 找到多个会抛出异常：；
  > - **autowire = "byName"**：根据属性名称从IOC容器中获取组件并注入到对应名称的属性中
  >   - 找不到装配null
  > - **autowire = "byConstructor"**：根据构造器自动装配
  >   - 首先会根据构造器的类型从IOC容器中获取进行装配，没有会装配null
  >   - 如果按照类型从IOC中匹配多个，再根据参数名作为id继续匹配，没有匹配就赋值null

### 5. SpEL

- **简介**：Spring Expression Language，Spring表达式语言，支持运行时查询并操作对象

- **基本语法**：使用**<kbd>#{...}</kbd>**作为定界符,所有在大括号中的字符都将被认为是SpEL表达式

- **案例说明**

  ```xml
  1. 字面量
  <property name="" value="#{5}"></property>
  <property name="" value="#{5*30}"></property>
  
  2. 调用组件的属性
  <property name="" value="#{bean.属性}"></property>
  
  3. 引用其他bean:等价于ref="bean"
  <property name="" value="#{bean}"></property>
  
  4. 调用静态方法
  <property name="" value="#{T(静态类全类名).静态方法名(实参列表)}"></property>
  
  5. 调用实例方法
  <property name="" value="#{bean.实例方法(实参列表)}"></property>
  ```

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

