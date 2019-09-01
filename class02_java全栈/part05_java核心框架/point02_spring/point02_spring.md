# 第一章 框架与Spring

## 1.1 框架

:anchor: **框架概述**

- 框架是抽取出的高度可重用的代码;
- 框架是多个可重用模块的集合, 形成某个领域的整体解决方案

:anchor: **开源组织**

- [**Spring**](https://spring.io)
- [**Apache **](https://www.apache.org) 

## 1.2 Spring概述

:anchor: **Spring框架**

- Spring框架是是一个IOC和AOP的容器框架
- Spring容器包含并且管理应用中的对象的关系以及生命周期

:anchor: **Spring技术栈**

- spring farmwork
- spring data
- spring security
- spring boot
- spring cloud
- spring session
- spring io platform

## 1.3 Spring特点

- 非侵入 : 用Spring开发的应用不依赖Spring的API
- 依赖注入 : 是对IOC思想的实现
- 面向切面编程 : 是对面向对象的扩展与增强
- 为JavaEE开发提供了一站式的解决方案 
- 轻量级 : 相比较传统的JavaEE规范, 把直接在Tomcat等符合Servlet规范的web服务器上的Java应用称为轻量级的应用

## 1.4 Spring的模块划分

:anchor: **Test : 测试模块**

- spring-aop-XX.RELEASE

:anchor:**​ Core Container : 核心模块**

- spring-beans-XX.RELEASE
- spring-core-XX.RELEASE
- spring-context-XX.RELEASE
- spring-expression-XX.RELEASE

:anchor: **AOP : 面向切面**

- spring-aop-XX.RELEASE
- spring-aspects-XX.RELEASE

:anchor: **Data Access : 数据访问**

- spring-jdbc-XX.RELEASE
- spring-orm-XX.RELEASE
- spring-tx-XX.RELEASE
- spring-oxm-XX.RELEASE
- spring-jms-XX.RELEASE

:anchor: **WEB**

- spring-web-XX.RELEASE
- spring-webmvc-XX.RELEASE
- spring-websocket-XX.RELEASE
- spring-webflux-XX.RELEASE

:anchor: **Messaging : 消息**

- spring-messaging-5.1.9.RELEASE

:anchor: **Instrumentation : 设备**

- spring-instrument-XX.RELEASE

# 第二章 Spring容器-IOC

## 2.1 初始化Spring容器

:anchor: **IOC - Inverce of Controller**

- 把对象的实例化工作交给Spring容器

:anchor: **Spring配置文件**

- Spring是存放Java对象的容器, Spring的配置文件相当于Spring容器
- 每个`<bean>`代表要存放的一个对象

:anchor: 根路径读取配置文件初始化IOC

```java
ApplicationContext ioc = 
    new ClassPathXmlApplicationContext("classpath:配置文件路径");
```

:anchor: 根据磁盘文件初始化IOC

```java
ApplicationContext ioc = new FileSystemXmlApplicationContext("系统磁盘路径");
```

:anchor: **Spring中对象加载过程**

1. 初始化Spring容器实例
2. 读取配置文件
3. 加载配置文件中的信息
4. 通过反射创建bean并完成初始化,并保存到容器

:anchor: Spring单元测试

- 高手Junit需要运行在Spring容器中
- 需要设置Spring容器的配置文件

## 2.2 从容器中获取bean

### 1. 根据bean标签的属性

```java
org.springframework.beans.factory.BeanFactory#getBean(java.lang.String)
```

### 2. 根据bean的类型

```java
org.springframework.beans.factory.BeanFactory#getBean(java.lang.Class<T>)
```

> 如果容器中该类型的bean有多个,则会报错

### 3. 根据bean的标识和类型

```java
org.springframework.beans.factory.BeanFactory#getBean(java.lang.String, java.lang.Class<T>)
```

## 2.3 给容器中添加bean及其属性

### 1. property标签 : set方法

```xml
<bean class="com.panda.ioc.Person" id="person1">
    <property name="name" value="set方法进行属性赋值"/>
</bean>
```

> :no_entry:  区分属性与字段

### 2. 构造器赋值

:anchor: **根据构造器参数名称赋值**

- 定义构造器

    ```java
    public Person(String name) {
        this.name = name;
    }
    ```

- 配置bean : 根据属性名称赋值

    ```xml
    <bean class="com.panda.ioc.Person" id="person2">
        <constructor-arg name="name" value="构造器给属性赋值"/>
    </bean>
    ```

:anchor: **根据构造器参数索引赋值**

- 定义构造器

    ```java
    public Person(String name, String nickname) {
        this.name = name;
        this.nickname = nickname;
    }
    
    public Person(String name, Integer age) {
        this.name = name;
        this.age = age;
    }
    ```

- 配置bean : 根据构造器参数

    ```xml
    <bean class="com.panda.ioc.Person" id="person3">
        <constructor-arg index="0" value="第一个参数"/>
        <constructor-arg index="1" value="第二个参数"/>
    </bean>
    ```

    > 值根据参数索引默认会匹配第一个能匹配到的构造器

:anchor: **根据构造器参数索引和类型赋值**

- 定义构造器

    ```java
    public Person(String name, String nickname) {
        this.name = name;
        this.nickname = nickname;
    }
    
    public Person(String name, Integer age) {
        this.name = name;
        this.age = age;
    }
    ```

- 配置bean : 根据构造器参数和索引

    ```xml
    <bean class="com.panda.ioc.Person" id="person5">
        <constructor-arg index="0" type="java.lang.String" value="0"/>
        <constructor-arg index="1" type="java.lang.Integer" value="1"/>
    </bean>
    ```

### 3. 通过<kbd>p</kbd>名称空间

:anchor: 名称空间 

- 在xml 中名称空间是用来防止标签重复
- 通过名称空间作为标签前缀来区分标签

:anchor: Spring的<kbd>p</kbd>名称空间

- 导入<kbd>p</kbd>名称空间

    ```xml
    xmlns:p="http://www.springframework.org/schema/p"
    ```

- 使用名称空间为属性赋值

    ```xml
    <bean class="com.panda.ioc.Person" id="person6"
          p:name="p名称空间赋值">
    
    </bean>
    ```

### 4. 自定义静态工厂类创建对象

:anchor: : 工厂类不需要被实例化

- 自定义工厂类 : 在工厂类的静态方法中创建指定对象

    ```java
    public class PersonFactoryStatic {
        public static Person instance(String name, Integer age){
            return new Person(name, age);
        }
    }
    ```

- 将工厂类配置为Spring组件,该组件就可以说生产出改工厂中的对象

    - 方式一 : 

        ```xml
        <bean class="com.panda.ioc.factory.PersonFactoryStatic" id="factoryStatic"
              factory-method="instance">
            <constructor-arg name="name" value="静态工厂的参数"/>
            <constructor-arg name="age" value="23"/>
        </bean>
        ```

    - 方式二 :

        ```xml
        <bean class="com.panda.ioc.factory.PersonFactoryStatic" id="factoryStatic"
              factory-method="instance">
            <constructor-arg name="name" value="静态工厂的参数"/>
            <constructor-arg name="age" value="23"/>
        </bean>
        
        <bean class="com.panda.ioc.Person" id="person8"
              factory-bean="factoryStatic">
            <constructor-arg name="name" value="静态工厂的额外参数"/>
            <constructor-arg name="age" value="200"/>
        </bean>
        ```

### 5. 自定义实例工厂创建对象

:anchor: 需要首先实例化工厂类, 工厂类产生的对象是由工厂类创建而来

- 自定义工厂类 : 工厂类的实例方法中创建对象

    ```java
    public class PersonFactoryInstance {
        public Person instance(String name, Integer age){
            return new Person(name, age);
        }
    }
    ```

- 配置bean : bean的创建方式是由工厂类完成

    ```xml
    <bean class="com.panda.ioc.factory.PersonFactoryInstance" name="factoryInstance">
    
    </bean>
    <bean class="com.panda.ioc.Person" id="person7"
          factory-bean="factoryInstance" factory-method="instance">
        <constructor-arg name="name" value="实例工厂的参数"/>
        <constructor-arg name="age" value="44"/>
    </bean>
    ```

### 6. Spring的bean工厂创建对象

- 创建Spring的bean工厂

    ```java
    public class PersonSpringBean implements FactoryBean<Person> {
        public Person getObject() throws Exception {
            return new Person();
        }
    
        public Class<?> getObjectType() {
            return Person.class;
        }
    
        public boolean isSingleton() {
            return false;
        }
    }
    ```

    > - getObject() : 返回需要被创建的对象
    > - getObjectType() : 指定返回的bean的真实类型
    > - isSingleton() : 设置bean的作用域

- 配置Spring的bean工厂 : 将bean工厂添加为Spring组件

    ```xml
    <bean class="com.panda.ioc.factory.PersonSpringBean" id="springBean">
    
    </bean>
    ```

## 2.4 为bean的各种属性赋值

### 1. 给属性赋null值

```xml
<bean class="com.panda.ioc.Person" id="person1">
    <property name="name">
        <null/>
    </property>
</bean>
```

> - <property> 标签为属性赋值 
>
> - 子标签可以作为属性标签的值

### 2. 给属性赋值外部bean

- 定义外部bean

    ```xml
    <bean class="com.panda.ioc.Car" id="carr1">
        <property name="carName" value="DG"/>
        <property name="color" value="white"/>
    </bean>
    ```

- 给属性引用外部bean

    ```xml
    <bean class="com.panda.ioc.Person" id="person2">
        <property name="car" ref="car1"/>
    </bean>
    ```

### 3. 给属性赋值内部bean

```xml
<bean class="com.panda.ioc.Person" id="person3">
    <property name="car">
        <bean class="com.panda.ioc.Car">
            <property name="carName" value="innerName"/>
            <property name="color" value="red"/>
        </bean>
    </property>
</bean>
```

### 4. 为List属性赋值

```xml
<bean class="com.panda.ioc.Person" id="person4">
    <property name="books">
        <list>

        </list>
    </property>
</bean>
```

### 5. 为map属性赋值

```xml
<bean class="com.panda.ioc.Person" id="person5">
    <property name="map">
        <map>
            <entry key="key" value="value"/>
            <entry key="" value-ref=""/>
        </map>
    </property>
</bean>
```

### 6. 为properties属性赋值

```xml
<bean class="com.panda.ioc.Person" id="person5">
    <property name="map">
        <map>
            <entry key="key" value="value"/>
        </map>
    </property>
</bean>
```

### 7. 使用<kbd>util</kbd>名称空间在spring中定义集合

:anchor: 定义List集合

- 导入名称空间

    ```xml
    xmlns:util="http://www.springframework.org/schema/util"
    
    xsi:schemaLocation="http://www.springframework.org/schema/util 
    https://www.springframework.org/schema/util/spring-util.xsd"
    ```

- 定义集合List

    ```xml
    <util:list id="books">
        <bean class="com.panda.ioc.Book">
            <property name="bookName" value="java"/>
        </bean>
        <bean class="com.panda.ioc.Book">
            <property name="bookName" value="python"/>
        </bean>
    </util:list>
    ```

- 引用集合List

    ```xml
    <bean class="com.panda.ioc.Person" id="person7">
        <property name="books" ref="books"/>
    </bean>
    ```

:anchor: 定义集合Map

```xml
<util:map id="map">
    <entry key="" value=""/>
</util:map>
```

:anchor: 定义集合Properies

:anchor: 定义集合Set

### 8. 级联属性赋值

- 引用外部bean时候可以对外部bean的属性进行修改

    ```xml
    <bean class="com.panda.ioc.Person" id="person8">
        <property name="car" ref="car1"/>
        <property name="car.carName" value="rename"/>
    </bean>
    ```

### 9. 配置信息继承

:anchor: bean的继承属性 : parent

```xml
<bean class="com.panda.ioc.Person" id="person" parent="person1">

</bean>
```

:anchor: orbean的抽象 : abstract

```xml
<bean class="com.panda.ioc.Person" id="person10" abstract="true">

</bean>
```

### 10. 基于xml的自动装配

> 用于装备容器中bean中的属性

:anchor: 根据Spring容器中bean的标识匹配

- 定义与属性名称相同的bean

    ```xml
    <bean class="com.panda.ioc.Car" id="car">
        <property name="carName" value="auto"/>
        <property name="color" value="blue"/>
    </bean>
    ```

- 根据名称自动装配

    ```xml
    <bean class="com.panda.ioc.Person" id="person11" autowire="byName">
    </bean>
    ```

- 只要Sring容器中有名称相同的bean就会被注入到对应的bean的属性中

:anchor: 根据Spring容器中bean的类型匹配

- 根据类型自动转配

    ```xml
    <bean class="com.panda.ioc.Person" id="person12" autowire="byType">
    
    </bean>
    ```

:anchor: 根据构造器的参数类型与名称匹配

> 仅限于自定义类型

- 定义构造器

    ```java
    public Person(Car car) {
        this.car = car;
    }
    ```

- 配置参数类型的bean

    ```xml
    <bean class="com.panda.ioc.Car" id="car">
        <property name="carName" value="auto"/>
        <property name="color" value="blue"/>
    </bean>
    ```

- 根据构造器自动装配

    ```xml
    <bean class="com.panda.ioc.Person" id="person12" autowire="constructor">
    
    </bean>
    ```

## 2.4 bean的扩展

### 1. bean的声明周期方法

> - 把定义在bean的声明周期属性的方法定义在对应的java类中

:anchor: bean的初始化属性 : init-method

```xml
<bean init-method="">

</bean>
```

:anchor: bean的销毁属性

```xml
<bean destroy-method="">

</bean>
```

### 2. bean的后置处理器

> - 可以在bean的初始化前后调用的方法

:anchor: **Spring的后置处理器接口 : BeanPostProcessor**

```xml
public class MyBeanPost implements BeanPostProcessor {
    public Object postProcessAfterInitialization(Object bean, String beanName) throws BeansException {
        return null;
    }

    public Object postProcessBeforeInitialization(Object bean, String beanName) throws BeansException {
        return null;
    }
}
```

- postProcessAfterInitialization: 表示初始化之前调用

- postProcessBeforeInitialization:表示初始化方法之后调用

> - bean : 那个bean要被初始化
> - beanName : bean的name
> - 需要将要初始化的bean返回

**:anchor:将后置处理器注册进spring** 

### 3. bean的作用域



## 2.5 Spring的Bean工厂

### 1. BeanFactory

- 只提供的最基本的IOC功能
- 在容器启动时候不会实例化bean

### 2. ApplicationContext

- 继承自BeanFactory工厂, 而且提供了容器之外的功能
- 在容器启动时就会实例化bean

# 第三章 Spring注解

## 3.1 注解使用

### 1. 标签的三要素

- 被标注的元素
- 标签类本身
- 标签的解释器程序

### 2. Spring注解的使用步骤

- 开启注解解析器 : context名称空间
- 使用注解代替xml配置

## 3.2 IOC注解

### 1. IOC 注解说明

:anchor: **IOC注解作用** : 通过注解将bean加入到Spring容器

:anchor: **context名称空间** : 在Spring配置中开启IOC注解解析器

- 基本用法

  ```xml
  <context:component-scan base-package="需要扫描的包"/>
  ```

- 设置排除指定的组件

  ```xml
  <context:exclude-filter type="设置类型" expression="类型的值"/>
  ```

  > type="annotation" : 表示指定注解类型的设置
  >
  > type="assignable" : 表示指定类型的类设置
  >
  > type="aspectj" : 表示使用aspect表达式设置
  >
  > type="regex" : 表示使用正则表达式设置
  >
  > type="custom" : 表示使用自定义TypeFilter的实现设置

- 设置只包含指定的组件

  ```xml
  <context:include-filter type="设置类型" expression="类型的值"/>
  ```

  > 使用包含设置规则时候, 需要禁用掉默认的过滤规则
  >
  > use-default-filters="false"

### 2. IOC注解类型

- **Spring规范的IOC注解**

  > 添加的Spring中组件的id名默认是类名首字母小写

  :anchor: **@Component**  : 是通用注解, 一般用于标注工具栏

  :anchor: **@Repository** : 一般用于标注Dao仓库

  :anchor: **@Service** : 一般用于标注Service组件
  
  :anchor: **@Controller** : 一般用于标注Controller前端控制器
  
- **向容器添加bean时候指定bean的名称**

  ```java
  给IOC标签指定value属性值
  ```

- **向容器添加bean时候指定bean的作用域**

  ```java
  在类上添加@Scope标签 : 使用value属性指定该bean的作用域
  ```

## 3.3 DI注解

:anchor:**​ @Autowire**

- 自动装配原理

  > 第一 : 会根据属性类型匹配
  >
  > 第二 : 如果找到多个类型, 则以属性名作为bean的id名继续匹配
  >
  > 第三 : 如果找不到会抛出异常

- 设置匹配指定id名称的bean

  ```java
  @Qualifier("指定名称")
  ```

- 设置如果匹配不到会取消装配

  ```java
  
  ```

- @Autowire给方法上添加

  > 会对方法的参数上实现自动装配
  >
  > 对参数的装配过程和属性的装配过程相同

:anchor: **@Resources**

- 是Java中制定的规范, 用于自动注入, 功能没有Spring的Autowire强大
- @Resources 的扩展性好, 如果切换其他容器框架也可以使用

## 3.4 Spring的泛型注入

- Spring中使用泛型匹配时候, 采用反射获取泛型类型, 从而对对应的类型实现自动注入

# 第四章 面向切面 AOP



