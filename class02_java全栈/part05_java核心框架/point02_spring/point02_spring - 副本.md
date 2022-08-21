```tex
<font size=4 color=blue>:anchor: **
**</font> ：
```

# 前言 Spring源码构建

1. 下载源码包

   ```sh
   https://gitee.com/panda-study-opensource/Spring-Framework.git
   ```

2. 根据需要阅读的源码版本新建分支

   ```sh
   git checkout -b panda5.2.4.RELEASE
   ```

3. 将代码重置到该tag对应的分支上

   ```sh
   git reset -hard v5.2.4.RELEASE
   ```

4. Gradle编译环境准备

5. 修改build.gradle文件为阿里云仓库地址

   - 在文件首行添加

     ```groovy
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
     ```

   - 在ext扩展属性之后添加仓库地址

     ```groovy
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

6. 等待构建完成

7. 新建模块引入Spring组件

# 第一章 Spring源码

1. 加载配置文件

   ```java
   ApplicationContext context = new ClassPathXmlApplicationContext("spring-application01.xml");
   ```

2. 调用父类AbstractApplicationContext的静态代码块：主动加载ContextClosedEvent类以避免奇怪的类加载器问题

   ```java
   	static {
   		ContextClosedEvent.class.getName();
   	}
   ```

3. 调用ClassPathXmlApplicationContext的构造方法

   ```java
   	public ClassPathXmlApplicationContext(String[] configLocations, boolean refresh, ApplicationContext parent)
   			throws BeansException {
   
   		super(parent);
   		setConfigLocations(configLocations);
   		if (refresh) {
   			refresh();
   		}
   	}
   ```

   > 3.1 super(parent):调用父类构造方法,设置相关成员属性
   >
   > - 创建资源处理器对象(用于加载配置文件)
   >
   >   ```java
   >   public AbstractApplicationContext() {
   >     this.resourcePatternResolver = getResourcePatternResolver();
   >   }
   >   
   >   // AbstractApplicationContext 类中会初始化许多默认属性
   >   // String id 
   >   // List<BeanFactoryPostProcessor>
   >   ```
   >
   > - setParent如果有父容器会设置父容器,并将父容器中的环境变量信息合并到环境变量中
   >
   >   ```java
   >   public void setParent(@Nullable ApplicationContext parent) {
   >     this.parent = parent;
   >     if (parent != null) {
   >       Environment parentEnvironment = parent.getEnvironment();
   >       if (parentEnvironment instanceof ConfigurableEnvironment) {
   >         getEnvironment().merge((ConfigurableEnvironment) parentEnvironment);
   >       }
   >     }
   >   }
   >   ```
   >
   > 3.2 setConfigLocations():设置配置文件的路径到对象的一个属性中
   >
   > - 获取路径文件解析路径
   >
   >   ```java
   >   resolvePath(locations[i]).trim();
   >   ```
   >
   > - 获取环境变量
   >
   >   ```java
   >   protected String resolvePath(String path) {
   >     return getEnvironment().resolveRequiredPlaceholders(path);
   >   }
   >   protected ConfigurableEnvironment createEnvironment() {
   >     return new StandardEnvironment();
   >   }
   >   ```
   >
   > - 替换配置文件中的变量
   >
   >   ```java
   >   resolveRequiredPlaceholders()
   >   ```

4. 调用到父类AbstractApplicationContext的refresh()方法

   ```java
   @Override
   public void refresh() throws BeansException, IllegalStateException {
     synchronized (this.startupShutdownMonitor) {
       StartupStep contextRefresh = this.applicationStartup.start("spring.context.refresh");
   
       // 为刷新准备此上下文
       prepareRefresh();
   
       // 告诉子类刷新内部bean工厂
       ConfigurableListableBeanFactory beanFactory = obtainFreshBeanFactory();
   
       // 准备好bean工厂使用
       prepareBeanFactory(beanFactory);
   
       try {
         // 允许在上下文子类中对bean工厂进行后处理
         postProcessBeanFactory(beanFactory);
   
         StartupStep beanPostProcess = this.applicationStartup.start("spring.context.beans.post-process");
         // 调用在上下文中注册为bean的工厂处理器
         invokeBeanFactoryPostProcessors(beanFactory);
   
         // 注册拦截bean创建的bean处理器。 
         registerBeanPostProcessors(beanFactory);
         beanPostProcess.end();
   
         // 初始化此上下文的消息源。
         initMessageSource();
   
         // 为此上下文初始化事件多播。 
         initApplicationEventMulticaster();
   
         // 在特定的上下文子类中初始化其他特殊bean。 
         onRefresh();
   
         // 检查侦听器bean并注册它们。
         registerListeners();
   
         // 实例化所有剩余的(非lazy-init)单例。 
         finishBeanFactoryInitialization(beanFactory);
   
         // 发布相应的事件
         finishRefresh();
       }
   
       catch (BeansException ex) {
         if (logger.isWarnEnabled()) {
           logger.warn("Exception encountered during context initialization - " +
                       "cancelling refresh attempt: " + ex);
         }
   
         // Destroy already created singletons to avoid dangling resources.
         destroyBeans();
   
         // Reset 'active' flag.
         cancelRefresh(ex);
   
         // Propagate exception to caller.
         throw ex;
       }
   
       finally {
         // Reset common introspection caches in Spring's core, since we
         // might not ever need metadata for singleton beans anymore...
         resetCommonCaches();
         contextRefresh.end();
       }
     }
   }
   ```

5. ★ 扩展 prepareRefresh:设置启动时间,和容器启动状态,初始化属性源,加载配置文件时候可以使用MyPropertySource代替ClassPathXmlApplicationContext来加载配置文件,添加监听器

   ```java
   // AbstractApplicationContext#initPropertySources;
   public class MyPropertySource extends ClassPathXmlApplicationContext {
   
       public MyPropertySource(String... configLocation) throws BeansException {
           super(configLocation);
       }
   
       @Override
       protected void initPropertySources() {
           System.out.println("扩展属性资源----");
           getEnvironment().setRequiredProperties("aaa");
       }
   }
   ```

6. obtainFreshBeanFactory():创建容器对象DefaultListableBeanFactory,加载xml配置文件中的属性值到当前工厂中,BeanDefinition

7. prepareBeanFactory(beanFactory):

## 1.1 加载配置文件



## 1.2 BeanFactoryPostProcessor

## 1.3 Aware

## 1.4 BeanPostProcessor

## 1.5 InitializingBean







# 第二章 Spring容器-IOC

## 2.1 IOC Helloworld

:anchor: 添加Spring依赖 : pom.xml

```xml
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-core</artifactId>
    <version>5.1.8.RELEASE</version>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-beans</artifactId>
    <version>5.1.8.RELEASE</version>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-context</artifactId>
    <version>5.1.8.RELEASE</version>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-expression</artifactId>
    <version>5.1.8.RELEASE</version>
</dependency>
```

:anchor: 定义JavaBean : User.java

```java
@Setter
@Getter
@ToString
public class User {
    private String name;
    public User() {
        System.out.println(" User构造器被执行.... ");
    }
}
```

:anchor: 添加配置文件 : spring-ioc.xml

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xsi:schemaLocation="http://www.springframework.org/schema/beans 
                           http://www.springframework.org/schema/beans/spring-beans.xsd">
    <bean class="com.panda.ioc.beans.User" id="user"></bean>
</beans>
```

:anchor: 测试springIOC

- 初始化IOC容器

    ```java
    ApplicationContext ioc = 
        new ClassPathXmlApplicationContext("classpath:spring-ioc.xml");
    ```

- 从容器中获取组件

    ```java
    @Test
    public void testByName() throws Exception {
        Object user = ioc.getBean("user");
        System.out.println("user = " + user);
    }
    ```

## 2.2 Spring单元测试

- 将Junit运行在Spring容器中

    ```java
    @RunWith(SpringJUnit4ClassRunner.class)
    @ContextConfiguration(locations = {"classpath:spring-ioc01.xml"})
    public class SpringIocTest01 {
    
        @Autowired
        private ApplicationContext ioc;
        
        @Test
        public void testAutowiredIoc() throws Exception {
            System.out.println("ioc = " + ioc);
        }
    }
    ```

## 2.2 初始化Spring容器

:anchor: 初始化IOC容器的方式

- 根路径读取配置文件初始化IOC

    ```java
    ApplicationContext ioc = 
        new ClassPathXmlApplicationContext("classpath:配置文件路径");
    ```

- 根据磁盘文件初始化IOC

    ```java
    ApplicationContext ioc = new FileSystemXmlApplicationContext("系统磁盘路径");
    ```

:anchor: 初始化IOC容器源码

- 读取配置文件 :`new ClassPathXmlApplicationContext`

    ```xml
    public ClassPathXmlApplicationContext(String configLocation) throws BeansException {
    	this(new String[] {configLocation}, true, null);
    }
    ```

- 最终会调用`ClassPathXmlApplicationContext`构造器 :  

    ```java
    public ClassPathXmlApplicationContext(
        String[] configLocations, boolean refresh, @Nullable ApplicationContext parent)
        throws BeansException {
    
        super(parent);
        setConfigLocations(configLocations);
        if (refresh) {
            refresh();
        }
    }
    ```

- 最终会执行 : `refresh()` 方法

    ```java
    @Override
    public void refresh() throws BeansException, IllegalStateException {
        synchronized (this.startupShutdownMonitor) {
            // 准备刷新上下文
            prepareRefresh();
    
            // 告诉子类刷新内部bean工厂
            ConfigurableListableBeanFactory beanFactory = obtainFreshBeanFactory();
    
            // 准备bean工厂，以便在此上下文中使用。
            prepareBeanFactory(beanFactory);
    
            try {
                // 允许在上下文子类中对bean工厂进行后处理。
                postProcessBeanFactory(beanFactory);
    
                // 调用上下文中注册为bean的工厂处理器。
                invokeBeanFactoryPostProcessors(beanFactory);
    
                // 注册拦截bean创建的bean处理器。
                registerBeanPostProcessors(beanFactory);
    
                // 初始化此上下文的消息源。
                initMessageSource();
    
                // 初始化此上下文的事件多播程序。
                initApplicationEventMulticaster();
    
                // 在特定上下文子类中初始化其他特殊bean。
                onRefresh();
    
                // 检查侦听器bean并注册它们。
                registerListeners();
    
                // 实例化所有剩余的(非惰性初始化)单例。
                finishBeanFactoryInitialization(beanFactory);
    
                // 最后一步:发布相应的事件。
                finishRefresh();
            }
    
            catch (BeansException ex) {
                if (logger.isWarnEnabled()) {
                    logger.warn("Exception encountered during context initialization - " +
                                "cancelling refresh attempt: " + ex);
                }
    
                // 销毁已经创建的单例，以避免挂起资源。
                destroyBeans();
    
                // 重置 "active" 标记
                cancelRefresh(ex);
    
                // 将异常传播给调用者。
                throw ex;
            }
    
            finally {
                // 重置Spring核心中的公共内省缓存，因为我们可能再也不需要单例bean的元数据了……
                resetCommonCaches();
            }
        }
    }
    ```

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

:anchor:  工厂类不需要被实例化

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

## 4.1 使用代理模式实现AOP功能

1. 定义要为目标类做增强的类 : 比如日志记录

   ```java
   public class LogUtils {
       public static void start(Object ... objects){
           System.out.println("JKD动态代理解耦:方法开始执行 --- 参数为" + objects);
       }
   
       public static void excep(Object ... objects){
           System.out.println("JKD动态代理解耦:方法出现异常 --- 参数为" + objects);
       }
   
       public static void end(Object ... objects){
           System.out.println("JKD动态代理解耦:方法执行完成 --- 参数为" + objects);
       }
   }
   ```

2. 定义JDK动态代理类

   ```java
   public class TargetProxy {
   
       private Object target;
   
       public TargetProxy(Object target) {
           this.target = target;
       }
   
       public Object getProxy() {
           return Proxy.newProxyInstance(
                   target.getClass().getClassLoader(),
                   target.getClass().getInterfaces(),
                   (proxy, method, args) -> {
                       Object invoke = null;
                       try {
                           LogUtils2.start(method.getName(), Arrays.asList(args));
                           invoke = method.invoke(target, args);
                       } catch (Exception e) {
                           LogUtils2.excep(e.getMessage(), Arrays.asList(args));
                       } finally {
                           LogUtils2.end(Arrays.asList(args));
                       }
                       return invoke;
                   });
       }
   }
   ```

3. 获取代理对象, 实现AOP增强功能

   ```java
   @Test
   public void testExc() throws Exception {
       IUserDao proxy = (IUserDao) new TargetProxy(userDao2).getProxy();
       System.out.println(proxy.getClass());
       proxy.delete(2);
   }
   ```

   - 执行结果

     ```java
     class com.sun.proxy.$Proxy14
     【LogUtils2】-JKD动态代理解耦:方法开始执行 --- 参数为[Ljava.lang.Object;@78b729e6
     com.panda.aop.dao.UserDao.delete:userId=2
     【LogUtils2】-JKD动态代理解耦:方法执行完成 --- 参数为[Ljava.lang.Object;@6b4a4e18
     ```

4. JDK代理的总结

   - 真正实现目标类方法的对象是目标类的代理对象

## 4.2 Spring AOP

1. 添加依赖

   ```xml
   <dependency>
       <groupId>org.springframework</groupId>
       <artifactId>spring-aop</artifactId>
       <version>5.1.8.RELEASE</version>
   </dependency>
   <dependency>
       <groupId>org.springframework</groupId>
       <artifactId>spring-aspects</artifactId>
       <version>5.1.8.RELEASE</version>
   </dependency>
   <dependency>
       <groupId>aopalliance</groupId>
       <artifactId>aopalliance</artifactId>
       <version>1.0</version>
   </dependency>
   ```

2. 定义切面类

   ```java
   @Aspect
   @Component
   ```

3. 在切面类中定义并配置增强方法

   ```java
   @Before()
   @AfterReturning()
   @AfterThrowing()
   @After()
   @Around()
   ```

4. 开启IOC和AOP注解驱动

   ```xml
   <context:component-scan base-package="com.panda.aop"></context:component-scan>
   
   <aop:aspectj-autoproxy></aop:aspectj-autoproxy>
   ```

5. 测试AOP功能

   ```java
   @Autowired
   private EmployeeService employeeService;
   
   @Test
   public void testInterface() throws Exception{
       System.out.println(employeeService.getClass());
       employeeService.save(Employee.builder().id(1).name("aopSave").build());
   }
   
   // 执行结果
   employeeService.getClass() = class com.sun.proxy.$Proxy23
   注解式 : AOP方法开始true
   com.panda.service.EmployeeServiceImpl.saveEmployee(id=1, name=aopSave)
   注解式 : AOP方法调用结束true
   注解式 : AOP方法执行完成true
   ```

## 4.3 AOP相关术语

1. 横切关注点 : 是指对目标类的需要增强的方法的增强时机 : 方法前 | 后 | 结束 |  异常 ....
2. 通知方法 : 在横切关注点对目标方法的增强的方法
3. 切面类 : 用于保存通知方法的类
4. 连接点 : 通知方法对目标方法增强的位置描述
5. 切入点 : 真正要对目标方法增强的执行时机

## 4.4 AOP细节说明

### 1. 代理对象

- 被AOP增强的类, 在SpringIOC中保存的是该类的代理对象. 并且该类是不会被Spring管理的

- 如果被增强的类有接口 : 则该类的代理对象是JDK动态代理产生的对象
- 如果被增强的类没有接口 : 则该类的代理对象是CGLIB动态代理产生的对象

### 2. 通知方法的切入点

- 切入表达式

  ```java
  execution(方法修饰符 返回值类型 方法全类名(方法参数))
  ```

- 通配符

  - ` * ` 
    - 可以匹配一个或多个字符
    - 可以匹配任意一个参数
  - ` .. ` 
    - 可以匹配任意多个参数
    - 可以匹配任意多层路径
  - 方法权限修饰符 : 只能是 `public` 通常不写
  - 精确写法 : 一般写返回值类型
  - execution() 可以使用表达式 : `&&`  `||`  `!`

### 3. 通知方法的执行顺序

- before -> after -> afterReturning -> afterThrowing 

### 4. 抽取公用切入点 : @Pointcut()

### 5. AOP获取异常信息和方法返回值

- @AfterReturning() 的属性 : **returning** : 用于指定通知方法中的哪个参数是目标方法的返回值
- @AfterThrowing() 的属性 : **throwing** 用于指定通知方法中的哪个参数是目标方法的异常对象

### 5. 通知方法中的参数列表

- JointPoint 类型的参数 : 封装的当前目标方法的详细信息
- returning : 用于接收方法的返回值
- throwing : 用于接收方法出现的异常

### 6. 环绕通知 : @Around

- 环绕通知的本质是一个代理模式 : 是其他几个通知的集合功能体

- 环绕通知必须定义的一个参数 ProceedingJointPoint

  ```java
  ProceedingJointPoint.proceed();
  ```

  - 这个方法是执行目标方法运行
  - 必须将目标执行的返回值返回 : 即使返回类型是void

- 环绕通知方法必须有一个返回值 : 环绕通知方法的返回值就是目标方法的返回值