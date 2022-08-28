# 第一章 Spring

## 1.1 Spring简介

1. 历史背景,应用场景

2. **Spring框架的核心**

   - 是抽取出来的高度可重用的代码, 多个可重用模块的集合, 形成：JavaEE领域的整体解决方案
   - Spring框架是是一个IOC和AOP的容器框架
   - Spring容器包含并且管理应用中的对象的关系以及生命周期

3. **Spring技术栈**

   | Spring技术      | 功能说明               |
   | --------------- | ---------------------- |
   | spring farmwork | Spring核心             |
   | spring data     | Spring数据支持         |
   | spring security | Spring安全认证         |
   | spring boot     | Spring场景启动自动配置 |
   | spring cloud    | Spring微服务解决方案   |

4. **Spring优点**

   - **为JavaEE开发提供了一站式的解决方案** ：从基础的IOC容器，已经衍生为Cloud Native的基础设施
   - **非侵入** : 用Spring开发的应用不依赖Spring的API
   - **依赖注入** : 是对IOC思想的实现
   - **面向切面编程** : 是对面向对象的扩展与增强
   - **轻量级** : 可以把直接在Tomcat等符合Servlet规范的web服务器上的Java应用称为轻量级的应用
   - **模块化** : 添加特定模块可以解决特定场景的功能 

## 1.2 Spring模块划分

<img src="https://s1.ax1x.com/2020/06/16/NiVHvd.png" alt="NiVHvd.png" border="0" />

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

## 1.3 Spring技术点

| 概述                    | 技术点                                            |
| ----------------------- | ------------------------------------------------- |
| **Java语言特性**        | 反射、动态代理、枚举、泛型、注解、JVM、Lambda语法 |
| **设计模式与设计思想**  | OOP、IoC、AOP、DDD、TDD、GOF23                    |
| **JavaAPI的分装与简化** | JDBC、Servlet、JPA、JMX、Bean、Validation         |
| **第三方框架的整合**    | Mybatis、Hibernate、Redis、SpringMVC...           |

# 第二章 Spring IOC



# 第三章 Spring AOP

## 3.1 AOP基础-代理模式

### 1. 静态代理

- 代理模式从生活场景中进行理解：代理对象拿着被代理对象的委托完成某个事情，在完成事情的前后遇到的问题是由代理对象解决；代理模式作用也就是对被代理对象的增强，并且可以做到不影响被代理对象；

- 静态代理是最基础的代理模式的抽象：首先为被代理对象进行抽象出一个接口；代理对象内包含着被代理对象的引用，用于完成需要完成的工作

  ```java
  // 1. 首先有个被代理对象，并且有着某种特定的功能
  public class Target{
      public void method() {
          System.out.println(" 目标方法执行 ");
      }
  }
  
  // 2. 对目标对象进行抽象出接口，规范被代理的功能
  public interface TargetInterface {
      void method();
  }
  
  // 3. 定义代理类
  public class TargetProxy implements TargetInterface{
  
      public Target target;
  
      public TargetProxy(Target target) {
          this.target = target;
      }
  
      public void method() {
          // 增强
          target.method();
         // 增强
      }
  }
  
  // 4.测试静态代理模式：创建代理类时候指定为哪个对象做代理
  public static void main(String[] args) {
      Target proxy = new TargetProxy(new TargetImpl());
      proxy.method();
  }
  ```

### 2. JDK动态代理

- 静态代理的缺点：每一个被代理对象都需要为其定义一个代理对象，增大工作量，增加代码复杂度；为坚决这个问题，jdk提供了Proxy类动态的为接口生成子类作为代理类，从而简化接口类型的代理模式

- 通过 Proxy 的静态方法 newProxyInstance 才会动态创建代理

  ```java
  public static Object newProxyInstance(ClassLoader loader,
                                        Class<?>[] interfaces,
                                        InvocationHandler h)
  ```

  > - loader：被代理类的类加载器；
  > - interfaces：被代理类的接口类型，反射获取MaotaiJiu.class.getInterfaces()
  > - InvocationHandler：被代理对象的方法执行交由这个对象完成

- InvocationHandler接口说明

  ```java
  public interface InvocationHandler {
      public Object invoke(Object proxy, Method method, Object[] args)
          throws Throwable;
  }
  ```

  > - proxy：这个对象在代理类中不要有任何操作，由jdk调用
  > - method：被代理类要执行的方法
  > - args：执行方法所需要的参数

- 定义JDK动态代理类：实现InvocationHandler接口并重写invoke方法，目标方法的执行需要一个改方法的对象类型，所以在代理类中定义一个属性，用于接收真实对象的引用；

  ```java
  public class JdkProxyHandler implements InvocationHandler {
  
      private final Object target;
  
      public JdkProxyHandler(Object target) {
          this.target = target;
      }
  
      public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
          Advice.before();
          Object result = method.invoke(target, args);
          Advice.after();
          return result;
      }
  }
  ```

- 测试JDK动态代理

  ```java
  public static void main(String[] args) {
      JdkTarget target = new JdkTargetImpl();
      JdkTarget proxy = (JdkTarget) Proxy.newProxyInstance(
          JdkTarget.class.getClassLoader(), 
          new Class[]{JdkTarget.class}, 
          new JdkProxyHandler(target));
      // 执行方法
      proxy.method();
  }
  ```

### 3. CGLIB动态代理

- JDK动态代理的缺陷：被代理类必须要定义一个接口，否则无法生成代理对象；在Spring中整合了第三方比较流行的CGLIB，通过动态的生成被代理类的子类作为代理对象，完成对被代理对象的代理功能；

- 添加SpringAOP的依赖即可使用CGLIB实现动态代理功能

- 定义动态代理类：实现接口MethodInterceptor

  ```java
  public class CglibProxyHandler implements MethodInterceptor {
      private Object target;
      public Object getInstance(final Object target) {
          this.target = target;
          Enhancer enhancer = new Enhancer();
          enhancer.setSuperclass(this.target.getClass());
          enhancer.setCallback(this);
          return enhancer.create();
      }
      public Object intercept(Object o, Method method, Object[] args, MethodProxy methodProxy) throws Throwable {
          Advice.before();
          Object result = methodProxy.invoke(target, args);
          Advice.after();
          return result;
      }
  }
  ```

- Enhancer是一个字节码增强器，可以用来为无接口的类创建代理。它的功能与java自带的Proxy类挺相似的。它会根据某个给定的类创建子类，并且所有非final的方法都带有回调钩子。

- 代理类接收的被代理对象，而生成的是由Enhancer创建的被代理对象；

## 3.2 SpringAOP概述

### 1. AOP简介

- AOP为Aspect Oriented Programming的缩写，意为：面向切面编程，通过预编译方 式和运行期动态代理实现程序功能的统一维护的一种技术；
- AOP以OOP为基础对OOP的扩展与增强，OOP描述的类与类之间的关系，对类的扩展与增强需要定义在类中；而OOP技术可以对类进行方法级别的扩展，并且可以做到对原对象的无侵入；

### 2. AOP术语

- **连接点（Joinpoint）**：程序执行的某个特定位置：如类开始初始化前、类初始化后、类某个方法调用前、调用后、方法抛出异常后。一个类或一段程序代码拥有一些具有边界性质的特定点，这些点中的特定点就称为“连接点”。*Spring仅支持方法的连接点，即仅能在方法调用前、方法调用后、方法抛出异常时以及方法调用前后这些程序执行点织入增强*。连接点由两个信息确定：第一是用方法表示的程序执行点；第二是用相对点表示的方位。
- **切点（Pointcut）**：每个程序类都拥有多个连接点，如一个拥有两个方法的类，这两个方法都是连接点，即连接点是程序类中客观存在的事物。AOP通过“切点”定位特定的连接点。连接点相当于数据库中的记录，而切点相当于查询条件。切点和连接点不是一对一的关系，一个切点可以匹配多个连接点。在Spring中，切点通过org.springframework.aop.Pointcut接口进行描述，它使用类和方法作为连接点的查询条件，Spring AOP的规则解析引擎负责切点所设定的查询条件，找到对应的连接点。其实确切地说，不能称之为查询连接点，因为连接点是方法执行前、执行后等包括方位信息的具体程序执行点，而切点只定位到某个方法上，所以如果希望定位到具体连接点上，还需要提供方位信息。
- **增强（Advice）**：增强是织入到目标类连接点上的一段程序代码，在Spring中，增强除用于描述一段程序代码外，还拥有另一个和连接点相关的信息，这便是执行点的方位。结合执行点方位信息和切点信息，我们就可以找到特定的连接点。
- **目标对象（Target）**：增强逻辑的织入目标类。如果没有AOP，目标业务类需要自己实现所有逻辑，而在AOP的帮助下，目标业务类只实现那些非横切逻辑的程序逻辑，而性能监视和事务管理等这些横切逻辑则可以使用AOP动态织入到特定的连接点上。
- **引介（Introduction）**：引介是一种特殊的增强，它为类添加一些属性和方法。这样，即使一个业务类原本没有实现某个接口，通过AOP的引介功能，我们可以动态地为该业务类添加接口的实现逻辑，让业务类成为这个接口的实现类。
- **织入（Weaving）**：织入是将增强添加对目标类具体连接点上的过程。AOP像一台织布机，将目标类、增强或引介通过AOP这台织布机天衣无缝地编织到一起。根据不同的实现技术，AOP有三种织入的方式：Spring采用动态代理织入，而AspectJ采用编译期织入和类装载期织入。
  1. 编译期织入，这要求使用特殊的Java编译器。
  2. 类装载期织入，这要求使用特殊的类装载器。
  3. 动态代理织入，在运行期为目标类添加增强生成子类的方式。
- **代理（Proxy）**：一个类被AOP织入增强后，就产出了一个结果类，它是融合了原类和增强逻辑的代理类。根据不同的代理方式，代理类既可能是和原类具有相同接口的类，也可能就是原类的子类，所以我们可以采用调用原类相同的方式调用代理类。
- **切面（Aspect）**：切面由切点和增强（引介）组成，它既包括了横切逻辑的定义，也包括了连接点的定义，通常定义在一个类中，称为切面类；Spring AOP就是负责实施切面的框架，它将切面所定义的横切逻辑织入到切面所指定的连接点中。

### 3. SpringAOP依赖

```xml
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-context</artifactId>
    <version>5.2.6.RELEASE</version>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-aop</artifactId>
    <version>5.2.6.RELEASE</version>
</dependency>
<!-- 基本版的面向切面 -->
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-aspects</artifactId>
    <version>5.2.6.RELEASE</version>
</dependency>
<!-- 加强版的面向切面 -->
<dependency>
    <groupId>aopalliance</groupId>
    <artifactId>aopalliance</artifactId>
    <version>5.2.6.RELEASE</version>
</dependency>
<dependency>
    <groupId>cglib</groupId>
    <artifactId>cglib</artifactId>
    <version>3.2.5</version>
</dependency>
```

## 3.3 基于xml配置

### 1. 标签说明

### 2. 案例说明

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xsi:schemaLocation="http://www.springframework.org/schema/beans
       http://www.springframework.org/schema/beans/spring-beans.xsd
       http://www.springframework.org/schema/aop
       http://www.springframework.org/schema/aop/spring-aop.xsd">

    <bean id="logging" class="com.soygrow.XmlAop.Logging"/>
    <aop:config>
        <aop:pointcut id="selectAll" expression="execution(* com.soygrow.XmlAop.Student.*(..))"/>
        <aop:aspect id="log" ref="logging">
            <aop:before pointcut-ref="selectAll" method="beforeAdvice"/>
            <aop:after pointcut-ref="selectAll" method="afterAdvice"/>
            <aop:after-returning pointcut-ref="selectAll" returning="retVal" method="afterReturningAdvice"/>
            <aop:after-throwing pointcut-ref="selectAll" throwing="ex" method="AfterThrowingAdvice"/>
        </aop:aspect>
    </aop:config>

    <bean id="student" class="com.soygrow.XmlAop.Student">
        <property name="age" value="11"/>
        <property name="name" value="Zara"/>
    </bean>
</beans>
```

##  3.4 基于注解配置

### 1. Spring项目使用AOP

- 创建Spring项目，定义Spring配置文件并且开启组件扫描

  ```xml
  <context:component-scan base-package="扫描的包"/>
  ```

- 在改包下定义一个需要增强的被代理对象，并添加到IOC容器中

  ```java
  @Service
  public class SpringBaseService {
      public void method() {
          System.out.println(" SpringBaseService = 目标方法执行 ");
      }
  }
  ```

- 定义切面类并添加SpringAOP的注解@Aspect和增强时机注解如@Before：在切面类中定义通知方法并指定切点表达式，

  ```java
  @Aspect
  @Component
  public class AspectSpringBase {
  
      @Before("切点表达式")
      public void before(){
          System.out.println(" 目标方法执行前执行 ");
      }
  }
  ```

- 使用注解版的AOP需要开启AOP注解扫描

  ```java
  <aop:aspectj-autoproxy/>
  ```

- 测试：加载配类，获取IOC容器中的组件并执行目标方法

  ```java
  public static void main(String[] args) {
      ApplicationContext ioc = new ClassPathXmlApplicationContext("配置文件.xml");
      SpringBaseService bean = ioc.getBean(SpringBaseService.class);
      bean.method();
  }
  ```

### 2. AOP注解说明

#### ① @Before

- 在切点方法前执行

  ```java
  @Aspect
  public class AuthAspect {
  	//定义切点
  	@Pointcut("execution(* com.cnblogs.hellxz.service.*.*(..))")
  	public void pointCut() {}
      
  	//前置处理
  	@Before("pointCut()")
  	public void auth() {
  		System.out.println("模拟权限检查……");
  	}
  }
  ```

  > - 表达式可使用pointcut或切入表达式
  > - 切点方法没有形参与返回值
  > - pointcut定义的切点方法在@Before/@After/@Around需要写在双引号中，e.g. @Before("pointCut()")

#### ② After

- 在切点方法后执行，用法同@Before
- pointcut定义的切点方法在@Before/@After/@Around需要写在双引号中，e.g. @After("pointCut()")

#### ③ @AfterRetruning

- 在方法返回之前，获取返回值并进行记录操作

  ```java
  @Aspect
  public class AfterReturningAspect {
  
  	@AfterReturning(returning="rvt",
  			pointcut = "execution(* com.cnblogs.hellxz.service.*.*(..))")
  	//声明rvt时指定的类型会限定目标方法的返回值类型，必须返回指定类型或者没有返回值
  	//rvt类型为Object则是不对返回值做限制
  	public void log(Object rvt) {
  		System.out.println("获取目标返回值："+ rvt);
  		System.out.println("假装在记录日志……");
  	}
  	
  	/**
  	 * 这个方法可以看出如果目标方法的返回值类型与切面入参的类型相同才会执行此切面方法
  	 * @param itr
  	 */
  	@AfterReturning(returning="itr", 
  			pointcut="execution(* com.cnblogs.hellxz.service.*.*(..))")
  	public void test(Integer itr) {
  		System.out.println("故意捣乱……:"+ itr);
  	}
  }
  ```

  > - 和上边的方法不同的地方是该注解除了切点，还有一个返回值的对象名
  > - 不同的两个注解参数：returning与pointcut,其中pointcut参数可以为切面表达式，也可为切点
  > - returning定义的参数名作为切面方法的入参名，类型可以指定。如果切面方法入参类型指定Object则无限制，如果为其它类型，则当且仅当目标方法返回相同类型时才会进入切面方法，否则不会
  > - 还有一个默认的value参数，如果指定了pointcut则会覆盖value的值
  > - 与@After类似，但@AfterReturning只有方法成功完成才会被织入，而@After不管结果如何都会被织入
  > - 虽然可以拿到返回值，但无法改变返回值

#### ④ @AfterThrowing

- 在异常抛出前进行处理，比如记录错误日志

  ```java
  @Aspect
  public class AfterThrowingAspect {
  
  	@Pointcut("execution(* com.cnblogs.hellxz.test.*.*(..))")
  	public void pointcut() {}
  	
  	/**
  	 * 如果抛出异常在切面中的几个异常类型都满足，那么这几个切面方法都会执行
  	 */
  	@AfterThrowing(throwing="ex1", 
  			pointcut="pointcut()")
  	//无论异常还是错误都会记录
  	//不捕捉错误可以使用Exception
  	public void throwing(Throwable ex1) {
  		System.out.println("出现异常："+ex1);
  	}
  	
  	@AfterThrowing(throwing="ex", 
  			pointcut="pointcut()")
  	//只管IOException的抛出
  	public void throwing2(IOException ex) {
  		System.out.println("出现IO异常: "+ex);
  	}
  }
  ```

#### ⑤ @Around

- 在切点方法外环绕执行

  ```java
  @Aspect
  public class TxAspect {
      
      //环绕处理
  	@Around("execution(* com.cnblogs.hellxz.service.*.*(..))")
  	Object auth(ProceedingJoinPoint point) {
  		
  		Object object = null;
  		try {
  			System.out.println("事务开启……");
  			//放行
  			object = point.proceed();
  			System.out.println("事务关闭……");
  		} catch (Throwable e) {
  			e.printStackTrace();
  		}
  		
  		return object;
  	}
  }
  ```

  > - pointcut定义的切点方法在@Before/@After/@Around需要写在双引号中，e.g. @Before("pointCut()")
  > - 在增强的方法上`@Around("execution(* 包名.*(..))")`或使用切点`@Around("pointcut()")`
  > - 接收参数类型为`ProceedingJoinPoint`，必须有这个参数在切面方法的入参第一位
  > - 返回值为Object
  > - 需要执行ProceedingJoinPoint对象的proceed方法，在这个方法前与后面做环绕处理，可以决定何时执行与完全阻止方法的执行
  > - 返回proceed方法的返回值
  > - @Around相当于@Before和@AfterReturning功能的总和
  > - 可以改变方法参数，在proceed方法执行的时候可以传入Object[]对象作为参数，作为目标方法的实参使用。
  > - 如果传入Object[]参数与方法入参数量不同或类型不同，会抛出异常
  > - 通过改变proceed()的返回值来修改目标方法的返回值

#### ⑥ JoinPoint

- 概念
  - 顾名思义，连接点，织入增强处理的连接点
  - 程序运行时的目标方法的信息都会封装到这个连接点对象中
  - 此连接点只读
- 方法说明
  - `Object[] getArgs()`：返回执行目标方法时的参数
  - `Signature getSignature()`:返回被增强方法的相关信息，e.g 方法名 etc
  - `Object getTarget()`:返回被织入增强处理的目标对象
  - `Object getThis()`:返回AOP框架目标对象生成的代理对象

- 使用
  - 在@Before/@After/@AfterReturning/@AfterThrowing所修饰的切面方法的参数列表中加入JoinPoint对象，可以使用这个对象获得整个增强处理中的所有细节
  - 此方法不适用于@Around, 其可用ProceedingJoinPoint作为连接点

#### ⑦ ProceedingJoinPoint

- 概念
  - 是JoinPoint的子类
  - 与JoinPoint概念基本相同，区别在于是可修改的
  - 使用@Around时，第一个入参必须为ProceedingJoinPoint类型
  - 在@Around方法内时需要执行proceed()或proceed(Object[] args)方法使方法继续，否则会一直处于阻滞状态
- 方法说明：ProceedingJoinPoint是JoinPoint的子类，包含其所有方法外，还有两个公有方法
  - `Object proceed()`:执行此方法才会执行目标方法
  - `Object proceed(Object[] args)`:执行此方法才会执行目标方法，而且会使用Object数组参数去代替实参,如果传入Object[]参数与方法入参数量不同或类型不同，会抛出异常
  - 通过修改proceed方法的返回值来修改目标方法的返回值

#### ⑧ 执行流程图

<img src='https://images2018.cnblogs.com/blog/1149398/201809/1149398-20180911092943285-1678031734.png'/>

### 3. 切点表达式

- Spring AOP 支持10种切点指示符

  - **execution**: 用来匹配执行方法的连接点的指示符。
    用法相对复杂，格式如下:`execution(权限访问符 返回值类型 方法所属的类名包路径.方法名(形参类型) 异常类型)`
    e.g. execution(public String com.cnblogs.hellxz.test.Test.access(String,String))
    权限修饰符和异常类型可省略，返回类型支持通配符，类名、方法名支持*通配，方法形参支持..通配

  - **within**: 用来限定连接点属于某个确定类型的类。
    within(com.cnblogs.hellxz.test.Test)
    within(com.cnblogs.hellxz.test.*) //包下类
    within(com.cnblogs.hellxz.test..*) //包下及子包下

  - **this和target**: this用于没有实现接口的Cglib代理类型，target用于实现了接口的JDK代理目标类型
    举例：this(com.cnblogs.hellxz.test.Foo) //Foo没有实现接口，使用Cglib代理，用this
    实现了个接口public class Foo implements Bar{...}
    target(com.cnblogs.hellxz.test.Test) //Foo实现了接口的情况

  - **args**: 对连接点的参数类型进行限制，要求参数类型是指定类型的实例。
    args(Long)

  - **@target**: 用于匹配**类头有指定注解**的连接点
    @target(org.springframework.stereotype.Repository)

  - **@args**: 用来匹配连接点的参数的，@args指出连接点在运行时传过来的参数的类必须要有指定的注解

    ```java
    @Pointcut("@args(org.springframework.web.bind.annotation.RequestBody)")  
    public void methodsAcceptingEntities() {}
    ```

  - **@within**: 指定匹配必须包括某个注解的的类里的所有连接点
    @within(org.springframework.stereotype.Repository)

  - **@annotation**: 匹配那些有指定注解的连接点
    @annotation(org.springframework.stereotype.Repository)

  - **bean**: 用于匹配指定Bean实例内的连接点，传入bean的id或name,支持使用*通配符

- 切点表达式组合

  - 使用&&、||、!、三种运算符来组合切点表达式，表示与或非的关系
    `execution(* com.cnblogs.hellxz.test.*.*(..)) && args(arg0, arg1)`

# 第四章 Spring Transaction

## 4.1 事务概述

- **原子性（Atomicity）**：事务是一个原子操作，由一系列动作组成。事务的原子性确保动作要么全部完成，要么完全不起作用。
- **一致性（Consistency）**：一旦事务完成（不管成功还是失败），系统必须确保它所建模的业务处于一致的状态，而不会是部分完成部分失败。在现实中的数据不应该被破坏。
- **隔离性（Isolation）**：可能有许多事务会同时处理相同的数据，因此每个事务都应该与其他事务隔离开来，防止数据损坏。
- **持久性（Durability）**：一旦事务完成，无论发生什么系统错误，它的结果都不应该受到影响，这样就能从任何系统崩溃中恢复过来。通常情况下，事务的结果被写到持久化存储器中。

## 4.2 Spring事务管理器

### 1. Spring的事务支持

- **编程式事务管理**：是侵入性事务管理，使用TransactionTemplate或者直接使用PlatformTransactionManager，对于编程式事务管理，Spring推荐使用TransactionTemplate。
- **声明式事务管理**：建立在AOP之上，其本质是对方法前后进行拦截，然后在目标方法开始之前创建或者加入一个事务，执行完目标方法之后根据执行的情况提交或者回滚。

### 2. Spring事务核心接口

<img src="https://s3.ax1x.com/2021/01/12/sGyMzq.png" alt="sGyMzq.png" border="0" />

- JDBC事务：如果应用程序中直接使用JDBC来进行持久化，DataSourceTransactionManager会为你处理事务边界。

  ```xml
  <bean id="transactionManager" class="org.springframework.jdbc.datasource.DataSourceTransactionManager">
      <property name="dataSource" ref="dataSource" />
  </bean>
  ```

- Hibernate事务：如果应用程序的持久化是通过Hibernate实习的，那么你需要使用HibernateTransactionManager。

  ```xml
  <bean id="transactionManager" class="org.springframework.orm.hibernate3.HibernateTransactionManager">
      <property name="sessionFactory" ref="sessionFactory" />
  </bean>
  ```

- Java持久化API事务（JPA）：Hibernate多年来一直是事实上的Java持久化标准，但是现在Java持久化API作为真正的Java持久化标准进入大家的视野。如果你计划使用JPA的话，那你需要使用Spring的JpaTransactionManager来处理事务。

  ```xml
  <bean id="transactionManager" class="org.springframework.orm.jpa.JpaTransactionManager">
      <property name="sessionFactory" ref="sessionFactory" />
  </bean>
  ```

-  Java原生API事务：如果你没有使用以上所述的事务管理，或者是跨越了多个事务管理源（比如两个或者是多个不同的数据源），你就需要使用JtaTransactionManager

  ```xml
  <bean id="transactionManager" class="org.springframework.transaction.jta.JtaTransactionManager">
      <property name="transactionManagerName" value="java:/TransactionManager" />
  </bean>
  ```

## 4.3 Spring事务属性

### 1. 只读

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>事务的第三个特性是它是否为只读事务。如果事务只对后端的数据库进行该操作，数据库可以利用事务的只读特性来进行一些特定的优化。通过将事务设置为只读，你就可以给数据库一个机会，让它应用它认为合适的优化措施。

### 2. 超时

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>为了使应用程序很好地运行，事务不能运行太长的时间。因为事务可能涉及对后端数据库的锁定，所以长时间的事务会不必要的占用数据库资源。事务超时就是事务的一个定时器，在特定时间内事务如果没有执行完毕，那么就会自动回滚，而不是一直等待其结束。

### 3. 回滚规则

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>这些规则定义了哪些异常会导致事务回滚而哪些不会。默认情况下，事务只有遇到运行期异常时才会回滚，而在遇到检查型异常时不会回滚（这一行为与EJB的回滚行为是一致的） 
但是你可以声明事务在遇到特定的检查型异常时像遇到运行期异常那样回滚。同样，你还可以声明事务遇到特定的异常不回滚，即使这些异常是运行期异常。

- rollbackFor：让原本不回滚的异常发生时候事务回滚；
- noRollbackFor：让原本会回滚的异常发生时候事务不回滚；

### 4. 隔离规则

1. **事务并发存在的问题**

   - 脏读（Dirty reads）——脏读发生在一个事务读取了另一个事务改写但尚未提交的数据时。如果改写在稍后被回滚了，那么第一个事务获取的数据就是无效的。
   - 不可重复读（Nonrepeatable read）——不可重复读发生在一个事务执行相同的查询两次或两次以上，但是每次都得到不同的数据时。这通常是因为另一个并发事务在两次查询期间进行了更新。
   - 幻读（Phantom read）——幻读与不可重复读类似。它发生在一个事务（T1）读取了几行数据，接着另一个并发事务（T2）插入了一些数据时。在随后的查询中，第一个事务（T1）就会发现多了一些原本不存在的记录。

2. **事务的隔离级别**

   | 隔离级别                   | 含义                                                         |
   | -------------------------- | ------------------------------------------------------------ |
   | ISOLATION_DEFAULT          | 使用后端数据库默认的隔离级别                                 |
   | ISOLATION_READ_UNCOMMITTED | 最低的隔离级别，允许读取尚未提交的数据变更，可能会导致脏读、幻读或不可重复读 |
   | ISOLATION_READ_COMMITTED   | 允许读取并发事务已经提交的数据，可以阻止脏读，但是幻读或不可重复读仍有可能发生 |
   | ISOLATION_REPEATABLE_READ  | 对同一字段的多次读取结果都是一致的，除非数据是被本身事务自己所修改，可以阻止脏读和不可重复读，但幻读仍有可能发生 |
   | ISOLATION_SERIALIZABLE     | 最高的隔离级别，完全服从ACID的隔离级别，确保阻止脏读、不可重复读以及幻读，也是最慢的事务隔离级别，因为它通常是通过完全锁定事务相关的数据库表来实现的 |

### 5. 传播行为

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>事务的第一个方面是传播行为（propagation behavior）。当事务方法被另一个事务方法调用时，必须指定事务应该如何传播。例如：方法可能继续在现有事务中运行，也可能开启一个新事务，并在自己的事务中运行。Spring定义了七种传播行为：

| 传播行为         | 含义                                                         |
| ---------------- | ------------------------------------------------------------ |
| **REQUIRED**     | 表示当前方法必须运行在事务中。如果当前事务存在，方法将会在该事务中运行。否则，会启动一个新的事务 |
| **REQUIRED_NEW** | 表示当前方法必须运行在它自己的事务中。一个新的事务将被启动。如果存在当前事务，在该方法执行期间，当前事务会被挂起。如果使用JTATransactionManager的话，则需要访问TransactionManager |
| SUPPORTS         | 表示当前方法不需要事务上下文，但是如果存在当前事务的话，那么该方法会在这个事务中运行 |
| MANDATORY        | 表示该方法必须在事务中运行，如果当前事务不存在，则会抛出一个异常 |
| NOT_SUPPORTED    | 表示该方法不应该运行在事务中。如果存在当前事务，在该方法运行期间，当前事务将被挂起。如果使用JTATransactionManager的话，则需要访问TransactionManager |
| NEVER            | 表示当前方法不应该运行在事务上下文中。如果当前正有一个事务在运行，则会抛出异常 |
| NESTED           | 表示如果当前已经存在一个事务，那么该方法将会在嵌套事务中运行。嵌套的事务可以独立于当前事务进行单独地提交或回滚。如果当前事务不存在，那么其行为与PROPAGATION_REQUIRED一样。注意各厂商对这种传播行为的支持是有所差异的。可以参考资源管理器的文档来确认它们是否支持嵌套事务 |

## 4.4 Spring - 编程式事务

### 1. TransactionTemplate

```java
TransactionTemplate tt = new TransactionTemplate(); // 新建一个TransactionTemplate
Object result = tt.execute(
    new TransactionCallback(){  
        public Object doTransaction(TransactionStatus status){  
            updateOperation();  
            return resultOfUpdateOperation();  
        }  
    }); // 执行execute方法进行事务管理
```

### 2. PlatformTransactionManager

```java
//定义一个某个框架平台的TransactionManager，如JDBC、Hibernate
DataSourceTransactionManager dataSourceTransactionManager = new DataSourceTransactionManager(); 
dataSourceTransactionManager.setDataSource(this.getJdbcTemplate().getDataSource()); // 设置数据源
DefaultTransactionDefinition transDef = new DefaultTransactionDefinition(); // 定义事务属性
transDef.setPropagationBehavior(DefaultTransactionDefinition.PROPAGATION_REQUIRED); // 设置传播行为属性
TransactionStatus status = dataSourceTransactionManager.getTransaction(transDef); // 获得事务状态
try {
    // 数据库操作
    dataSourceTransactionManager.commit(status);// 提交
} catch (Exception e) {
    dataSourceTransactionManager.rollback(status);// 回滚
}
```

## 4.5 Spring - 声明式事务

### 1. 基于注解的声明式事务

- 在配置文件中指定事务管理器，并开启基于注解的transaction

  ```xml
  <?xml version="1.0" encoding="UTF-8"?>
  <beans xmlns="http://www.springframework.org/schema/beans"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xmlns:context="http://www.springframework.org/schema/context" xmlns:tx="http://www.springframework.org/schema/tx"
         xmlns:aop="http://www.springframework.org/schema/aop"
         xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context https://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx.xsd http://www.springframework.org/schema/aop https://www.springframework.org/schema/aop/spring-aop.xsd">
  
      <context:component-scan base-package="com.spring5"/>
      <!-- Hikari Datasource -->
      <bean id="dataSource" class="com.zaxxer.hikari.HikariDataSource">
          <property name="driverClassName" value="com.mysql.cj.jdbc.Driver"/>
          <property name="jdbcUrl"
                    value="jdbc:mysql://localhost:3306/case-project?serverTimezone=UTC&amp;useUnicode=true&amp;characterEncoding=utf-8&amp;useSSL=false"/>
          <property name="username" value="root"/>
          <property name="password" value="root"/>
          <!-- 连接只读数据库时配置为true， 保证安全 -->
          <property name="readOnly" value="false"/>
          <!-- 等待连接池分配连接的最大时长（毫秒），超过这个时长还没可用的连接则发生SQLException， 缺省:30秒 -->
          <property name="connectionTimeout" value="30000"/>
          <!-- 一个连接idle状态的最大时长（毫秒），超时则被释放（retired），缺省:10分钟 -->
          <property name="idleTimeout" value="600000"/>
          <!-- 一个连接的生命时长（毫秒），超时而且没被使用则被释放（retired），缺省:30分钟，建议设置比数据库超时时长少30秒，参考MySQL
              wait_timeout参数（show variables like '%timeout%';） -->
          <property name="maxLifetime" value="1800000"/>
          <!-- 连接池中允许的最大连接数。缺省值：10；推荐的公式：((core_count * 2) + effective_spindle_count) -->
          <property name="maximumPoolSize" value="60"/>
          <property name="minimumIdle" value="10"/>
      </bean>
  
      <!-- 声明式事务管理器 -->
      <bean class="org.springframework.jdbc.datasource.DataSourceTransactionManager" name="transactionManager">
          <property name="dataSource" ref="dataSource"/>
      </bean>
      <!-- 开启基于注解是事务 -->
      <tx:annotation-driven transaction-manager="transactionManager"/>
  </beans>
  ```

- 事务注解标签

  ```java
  @Service
  public class xxxService{
      @Transactional(
              readOnly = false,
              timeout = 3,
              rollbackFor = ArrayIndexOutOfBoundsException.class,
              isolation = Isolation.DEFAULT,
              propagation = Propagation.REQUIRES_NEW)
      public void updateBayBook(String user, String book, int store) {
      	// TODO
      }
  }
  ```

### 2. 基于AOP配置的声明式事务

```xml
<?xml version="1.0" encoding="UTF-8"?>
<beans xmlns="http://www.springframework.org/schema/beans"
       xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
       xmlns:context="http://www.springframework.org/schema/context" 
       xmlns:tx="http://www.springframework.org/schema/tx"
       xmlns:aop="http://www.springframework.org/schema/aop"
       xsi:schemaLocation="http://www.springframework.org/schema/beans 
                           http://www.springframework.org/schema/beans/spring-beans.xsd 
                           http://www.springframework.org/schema/context 
                           https://www.springframework.org/schema/context/spring-context.xsd 
                           http://www.springframework.org/schema/tx 
                           http://www.springframework.org/schema/tx/spring-tx.xsd 
                           http://www.springframework.org/schema/aop 
                           https://www.springframework.org/schema/aop/spring-aop.xsd">

    <context:component-scan base-package="com.spring5"/>
    <!-- Hikari Datasource -->
    <bean id="dataSource" class="com.zaxxer.hikari.HikariDataSource">
        <property name="driverClassName" value="com.mysql.cj.jdbc.Driver"/>
        <property name="jdbcUrl"
                  value="jdbc:mysql://localhost:3306/case-project?serverTimezone=UTC&amp;useUnicode=true&amp;characterEncoding=utf-8&amp;useSSL=false"/>
        <property name="username" value="root"/>
        <property name="password" value="root"/>
        <!-- 连接只读数据库时配置为true， 保证安全 -->
        <property name="readOnly" value="false"/>
        <!-- 等待连接池分配连接的最大时长（毫秒），超过这个时长还没可用的连接则发生SQLException， 缺省:30秒 -->
        <property name="connectionTimeout" value="30000"/>
        <!-- 一个连接idle状态的最大时长（毫秒），超时则被释放（retired），缺省:10分钟 -->
        <property name="idleTimeout" value="600000"/>
        <!-- 一个连接的生命时长（毫秒），超时而且没被使用则被释放（retired），缺省:30分钟，建议设置比数据库超时时长少30秒，参考MySQL
            wait_timeout参数（show variables like '%timeout%';） -->
        <property name="maxLifetime" value="1800000"/>
        <!-- 连接池中允许的最大连接数。缺省值：10；推荐的公式：((core_count * 2) + effective_spindle_count) -->
        <property name="maximumPoolSize" value="60"/>
        <property name="minimumIdle" value="10"/>
    </bean>

    <!-- 声明式事务管理器 -->
    <bean class="org.springframework.jdbc.datasource.DataSourceTransactionManager" name="transactionManager">
        <property name="dataSource" ref="dataSource"/>
    </bean>

    <!-- 配置AOP切面表达式关联切点 -->
    <aop:config>
        <aop:pointcut id="txPoint" expression="execution(* com.spring5.demo03.*Service(..))"/>
        <aop:advisor advice-ref="txConfig" pointcut-ref="txPoint"/>
    </aop:config>
    <!-- 事务切点 -->
    <tx:advice id="txConfig" transaction-manager="transactionManager">
        <tx:attributes>
            <tx:method name="update*" propagation="REQUIRED"/>
        </tx:attributes>
    </tx:advice>
</beans>
```

# 第五章 Sring注解

## 5.1 Spring IOC注解

### 1. 组件注册

- @Configuration
- @Bean

### 2. 声明周期

### 3. 属性赋值

### 4. 自动注入

## 5.2 Spring AOP注解

## 5.3 Spring TX注解

## 5.4 Spring MVC注解

## 5.5 Spring 扩展

1. 自动任务
2. 监听器
3. bean的初始化回调

# 第六章 Spring源码解析

## 6.1 Spring源码基础

### 1. SpringBean生命周期

<img src='https://gitee.com/panda_code_note/commons-resources/raw/master/part01_images/image-20220826233138162'/>

### 2. SpringBean功能扩展

- ①通过BeanFactoryPostProcessor修改BeanDefinition

  ```java
  public class IocUserBeanFactoryPostProcessor implements BeanFactoryPostProcessor {
  
      @Override
      public void postProcessBeanFactory(ConfigurableListableBeanFactory factory) throws BeansException {
          // 修改Bean定义信息
          String[] names = factory.getBeanDefinitionNames();
          for (String name : names) {
              if ("iocUser".equals(name)) {
                  BeanDefinition def = factory.getBeanDefinition(name);
                  MutablePropertyValues va = def.getPropertyValues();
                  va.addPropertyValue("name", "test");
              }
          }
      }
  }
  ```

- ②实例化Bean,执行Bean的默认无参构造方法

- ③通过Aware接口获取SpringIOC容器对象相关的Bean

  ```java
  @Getter
  @Setter
  public class Xxx implements ApplicationContextAware {
      private ApplicationContext context;
      @Override
      public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
          this.context = applicationContext;
      }
  }
  ```

- ④通过BeanPostProcessor接口,在Bean实例化后的初始化前后执行

  ```java
  public class IocUserBeanPostProcessor implements BeanPostProcessor {
  
    @Override
    public Object postProcessBeforeInitialization(Object bean, String beanName) throws BeansException {
      if ("xxx".equals(beanName)) {
        System.out.println("Bean初始化方法之前执行"+bean.getClass());
      }
      return BeanPostProcessor.super.postProcessBeforeInitialization(bean, beanName);
    }
    // postProcessBeforeInitialization方法执行完成后执行InitializingBean的afterPropertiesSet方法
    
    // InitializingBean的afterPropertiesSet方法之后执行Bean的init方法
    @Override
    public Object postProcessAfterInitialization(Object bean, String beanName) throws BeansException {
      if ("xxx".equals(beanName)) {
        System.out.println("Bean初始化方法后前执行"+bean.getClass());
      }
      return BeanPostProcessor.super.postProcessAfterInitialization(bean, beanName);
    }
  }
  ```

- ⑤InitializingBean的afterPropertiesSet方法在Bean初始化之后执行

  ```java
  @Getter
  @Setter
  public class IocUser implements InitializingBean {
    @Override
    public void afterPropertiesSet() throws Exception {
      
    }
  }
  ```

- ⑥为Bean指定初始化方法

  ```java
  public class Xxx {
      public void init(){
      }
  }
  ```

  > ```xml
  > <bean id="iocUser" class="com.bean.Xxx" init-method="init">
  > </bean>
  > ```

- ⑦AOP对Bean中的方法进行扩展

## 6.2 循环依赖

### 1. 学习步骤

- 第一:①什么是循环依赖②三级缓存③执行流程

- 第二:源码解读
- 第三:为什么要用三级缓存

### 2. 基础知识

- 什么是循环依赖:一个或多个对象之间存在直接或间接的依赖关系，这种依赖关系构成一个环形调用

- 三级缓存:DefaultSingletonBeanRegistry中的Map集合

  ```java
  // 一级缓存
  private final Map<String, Object> singletonObjects = new ConcurrentHashMap<>(256);
  // 三缓存
  private final Map<String, ObjectFactory<?>> singletonFactories = new HashMap<>(16);
  // 二级缓存
  private final Map<String, Object> earlySingletonObjects = new ConcurrentHashMap<>(16);
  ```

  - 第一级缓存：singletonObjets:用于存储实例化、初始化完成的SpringBean
  - 第二级缓存：earlySingletonObjects：用于保存实例化完成、未初始化的半成品SpringBean
  - 第三级缓存：singletonFactories：用于保存SpringBean的创建工厂，在一定条件下会创建代理对象

- 执行基本逻辑

  - 首先会从第一级缓存中找对象，如果没有找到就从第二级缓存中找
  - 然后重第二级缓存中找对象，没有找到就从第三级缓存找
  - 第三级缓存中找到了，就创建对象放到第二级缓存，然后从第三级缓存中移除

### 3. 源码执行流程说明

![image-20220824203704551](https://gitee.com/panda_code_note/commons-resources/raw/master/part01_images/image-20220824203704551)

- 第一层中，先回获取A的Bean，发现没有就准备创建一个，此时会将A的代理工厂放入到三级缓存，然后继续执行A的创建过程之，给A的属性进行初始化，A中的属性又依赖B，所以必须创建B
- 第二层中，准备创建B，又发现B有依赖A，所以又去创建A（在创建A之前会从缓存中找）
- 第三层中，创建A之前，会从缓存中找，因为第一层已经创建的A的代理工厂，直接从三级缓存中拿到代理工厂，获取A的代理对象放入到二级缓存中，并清除三级缓存，此时二级缓存中的A对象是未初始的SpringBean
- 回到第二层，此时二级缓存中有了A的SpringBean对象，B对A的依赖完成，B对象的创建流程执行完成，B对象初始化完成，保存到第一层缓存中，
- 回到第一层，B初始已经完成，此时需要对A中的B属性进行赋值，完成对A对象的初始化，然后将A对象保存入一级缓存，因为是对象引用，此时B对象中A属性也变成了完整对象，到此循环依赖对象创建完成，

### 4. 源码解读

1. 源码解读-入口

   - 循环依赖的Java对象:A和B

     ```java
     @Setter
     @Getter
     public class A {
         private B b;
     }
     
     @Getter
     @Setter
     public class B {
         private A a;
     }
     ```

   - 使用xml配置文件将循环引用的对象配置到容器中

     ```xml
     <?xml version="1.0" encoding="UTF-8"?>
     <beans xmlns="http://www.springframework.org/schema/beans"
            xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:aop="http://www.springframework.org/schema/aop"
            xmlns:context="http://www.springframework.org/schema/context"
            xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/aop https://www.springframework.org/schema/aop/spring-aop.xsd http://www.springframework.org/schema/context https://www.springframework.org/schema/context/spring-context.xsd">
     
         <bean name="a" class="com.spring.demo03.bean.A">
             <property name="b" ref="b"/>
         </bean>
         <bean name="b" class="com.spring.demo03.bean.B">
             <property name="a" ref="a"/>
         </bean>
     </beans>
     ```

   - 加载配置文件:ClassPathXmlApplicationContext读取xml配置文件

     ```java
     new ClassPathXmlApplicationContext("spring-application.xml");
     ```

   - 在ClassPathXmlApplicationContext构造方法中最终进入到AbstractApplicationContext#refresh方法,refresh方法中的finishBeanFactoryInitialization作用是实例化所有非懒加载的单例Bean

     ```java
     public void refresh() throws BeansException, IllegalStateException {
       // 实例化非懒加载的单例Bean对象
       finishBeanFactoryInitialization(beanFactory);
     }
     ```

   - 调用finishBeanFactoryInitialization方法参数中的preInstantiateSingletons方法用于实例化Bean

     ```java
     protected void finishBeanFactoryInitialization(ConfigurableListableBeanFactory beanFactory) {
     	beanFactory.preInstantiateSingletons();
     }
     ```

   - ConfigurableListableBeanFactory接口的默认实现类DefaultListableBeanFactory,从beanDefinition中获取所有的Bean的名称,根据名称创建单例Bean并且是非懒加载的

     ```java
     public void preInstantiateSingletons() throws BeansException {
     	getBean(beanName);
     }
     ```

2. 源码解读-第一层,把A对象的工厂添加到第三级缓存中,并且根据工厂创建出A对象并赋值给B对象

   ![图片](https://gitee.com/panda_code_note/commons-resources/raw/master/part01_images/640)

   - 进入doGetBean(),调用getSingleton方法,第一个参数bean名称,二个参数匿名内部类,会在getSingleton方法中调用匿名内部类的createBean方法

     ```java
     if (mbd.isSingleton()) {
       sharedInstance = getSingleton(beanName, () -> {
         try {
           return createBean(beanName, mbd, args);
         }
         catch (BeansException ex) {
           // Explicitly remove instance from singleton cache: It might have been put there
           // eagerly by the creation process, to allow for circular reference resolution.
           // Also remove any beans that received a temporary reference to the bean.
           destroySingleton(beanName);
           throw ex;
         }
       });
       beanInstance = getObjectForBeanInstance(sharedInstance, name, beanName, mbd);
     }
     ```

     > ```java
     > public Object getSingleton(String beanName, ObjectFactory<?> singletonFactory) {
     >   // 先从一级缓存中查询
     >   Object singletonObject = this.singletonObjects.get(beanName);
     >   try {
     >     // 调用ObjectFactory的getObject方法执行匿名内部类参数的createBean方法
     >     singletonObject = singletonFactory.getObject();
     >     newSingleton = true;
     >   }
     >   catch (IllegalStateException ex) {
     >   }
     > }
     > ```

   - 在createBean()方法中进入doCreateBean(),调用addSingletonFactory方法,用创建匿名内部类的方式将工厂接口的实现类添加到的三级缓存的工厂中,这个内部类包含了创建这个Bean所需要的相关参数;

     ```java
     protected Object doCreateBean(String beanName, RootBeanDefinition mbd, @Nullable Object[] args){
       if (earlySingletonExposure) {
         if (logger.isTraceEnabled()) {
           logger.trace("Eagerly caching bean '" + beanName +
                        "' to allow for resolving potential circular references");
         }
         addSingletonFactory(beanName, () -> getEarlyBeanReference(beanName, mbd, bean));
       }
     }
     ```

   - 在addSingletonFactory()方法中,将工厂参数添加到三级缓存中

     ```java
     protected void addSingletonFactory(String beanName, ObjectFactory<?> singletonFactory) {
       Assert.notNull(singletonFactory, "Singleton factory must not be null");
       synchronized (this.singletonObjects) {
         if (!this.singletonObjects.containsKey(beanName)) {
           this.singletonFactories.put(beanName, singletonFactory);
           this.earlySingletonObjects.remove(beanName);
           this.registeredSingletons.add(beanName);
         }
       }
     }
     ```

   - 继续执行A对象的初始化过程,接下来的流程是需要给A对象的B属性进行赋值,进入populateBean()方法

     ```java
     if (earlySingletonExposure) {
       if (logger.isTraceEnabled()) {
         logger.trace("Eagerly caching bean '" + beanName +
                      "' to allow for resolving potential circular references");
       }
       // 已经将A对象的工厂类添加到三级缓存中
       addSingletonFactory(beanName, () -> getEarlyBeanReference(beanName, mbd, bean));
     }
     
     // 给A对象进行初始化 进入 populateBean方法
     Object exposedObject = bean;
     try {
       populateBean(beanName, mbd, instanceWrapper);
       exposedObject = initializeBean(beanName, exposedObject, mbd);
     }
     ```

   - 在populateBean()方法中调用applyPropertyValues()方法,获取属性并给属性赋值

     ```java
     protected void populateBean(String beanName, RootBeanDefinition mbd, @Nullable BeanWrapper bw) {
       if (pvs != null) {
         applyPropertyValues(beanName, mbd, bw, pvs);
       }
     }
     ```

   - 获取属性名称和属性类型,执行resolveValueIfNecessary方法

     ```java
     protected void applyPropertyValues(String beanName, BeanDefinition mbd, BeanWrapper bw, PropertyValues pvs) {		
       // 属性名称
       String propertyName = pv.getName();
       // 属性名对应的运行时类型:RuntimeBeanReference
       Object originalValue = pv.getValue();
       if (originalValue == AutowiredPropertyMarker.INSTANCE) {
         Method writeMethod = bw.getPropertyDescriptor(propertyName).getWriteMethod();
         if (writeMethod == null) {
           throw new IllegalArgumentException("Autowire marker for property without write method: " + pv);
         }
         originalValue = new DependencyDescriptor(new MethodParameter(writeMethod, 0), true);
       }
       Object resolvedValue = valueResolver.resolveValueIfNecessary(pv, originalValue);
     }
     ```

   - 判断参数类型如果是RuntimeBeanReference类型,执行resolveReference()方法

     ```java
     public Object resolveValueIfNecessary(Object argName, @Nullable Object value) {
       if (value instanceof RuntimeBeanReference) {
         RuntimeBeanReference ref = (RuntimeBeanReference) value;
         return resolveReference(argName, ref);
       }
     }
     ```

   - 进入resolveReference方法,第二次看到调用getBean的流程中了

     ```java
     private Object resolveReference(Object argName, RuntimeBeanReference ref) {
       resolvedName = String.valueOf(doEvaluate(ref.getBeanName()));
       bean = this.beanFactory.getBean(resolvedName);
     }
     ```

3. 源码解读第二层-获取B的Bean对象

   ![image-20220825001656612](https://gitee.com/panda_code_note/commons-resources/raw/master/part01_images/image-20220825001656612)

   - getBean到将B的工厂添加到三级缓存的过程省略,此时三级缓存singletonFactories中有两个代理工厂,从getBean的开始到resolveReference()方法

     ```java
     public Object resolveValueIfNecessary(Object argName, @Nullable Object value) {
       // We must check each value to see whether it requires a runtime reference
       // to another bean to be resolved.
       if (value instanceof RuntimeBeanReference) {
         RuntimeBeanReference ref = (RuntimeBeanReference) value;
         return resolveReference(argName, ref);
       }
     }
     ```

   - 进入resolveReference方法,第三次看到调用getBean的流程中了:这次getBean的作用是获取B对象中A属性的Bean对象

     ```java
     private Object resolveReference(Object argName, RuntimeBeanReference ref) {
       resolvedName = String.valueOf(doEvaluate(ref.getBeanName()));
       bean = this.beanFactory.getBean(resolvedName);
     }
     ```

   - 从第三次getBean方法中执行getSingleton方法

     ```java
     	protected <T> T doGetBean(String name, @Nullable Class<T> requiredType, @Nullable Object[] args, boolean typeCheckOnly){
     		Object sharedInstance = getSingleton(beanName);
       }
     ```

   - 完整的getSingleton方法,此时从三级缓存中获取A对象的代理工厂并创建出半成品的A对象并存入二级缓存,代理工厂从三级缓存中移除

     ```java
     protected Object getSingleton(String beanName, boolean allowEarlyReference) {
       // 1. 从一级缓存中获取
       Object singletonObject = this.singletonObjects.get(beanName);
       if (singletonObject == null && isSingletonCurrentlyInCreation(beanName)) {
         // 2. 从二级缓存中获取
         singletonObject = this.earlySingletonObjects.get(beanName);
         if (singletonObject == null && allowEarlyReference) {
           synchronized (this.singletonObjects) {
             // 3. 上锁,再次冲一级缓存中获取
             singletonObject = this.singletonObjects.get(beanName);
             if (singletonObject == null) {
               // 4.一级缓存中没有后从二级缓存中获取
               singletonObject = this.earlySingletonObjects.get(beanName);
               if (singletonObject == null) {
                 // 5. 二级缓存中没有后从三级缓存中获取,如果没有返回null
                 ObjectFactory<?> singletonFactory = this.singletonFactories.get(beanName);
                 if (singletonFactory != null) {
                   // 6. 如果三级缓存中有,则使用代理工厂创建对象
                   singletonObject = singletonFactory.getObject();
                   // 7. 创建的对象保存到二级缓存
                   this.earlySingletonObjects.put(beanName, singletonObject);
                   // 8. 从三级缓存中删除该对象的代理工厂
                   this.singletonFactories.remove(beanName);
                 }
               }
             }
           }
         }
       }
       return singletonObject;
     }
     ```

     > 使用代理工厂创建对象:AOP的重点,创建代理对象

   - 此时正在初始化的B对象,继续执行,在getSingleton方法中执行addSingleton()方法

     ```java
     public Object getSingleton(String beanName, ObjectFactory<?> singletonFactory) {
       if (newSingleton) {
         addSingleton(beanName, singletonObject);
       }
     }
     ```

   - addSingleton处理一、二级缓存的逻辑，将二级缓存清除，放入一级缓存。

     ```java
     protected void addSingleton(String beanName, Object singletonObject) {
       synchronized (this.singletonObjects) {
         // 1. 一级缓存中放入B的Bean,此时B中A属性是半成品
         this.singletonObjects.put(beanName, singletonObject);
         // 2. 三级缓存中将B的工厂移除
         this.singletonFactories.remove(beanName);
         // 3. 二级缓存中将B对象移除
         this.earlySingletonObjects.remove(beanName);
         this.registeredSingletons.add(beanName);
       }
     }
     ```

4. 源码解读第三层:A对象的getBean方法获取B对象的实例,此时可以从一级缓存中直接获取,并赋值给A对象中的B属性

   

   - 继续执行A对象的getBean方法

     ```java
     	protected <T> T doGetBean(String name, @Nullable Class<T> requiredType, @Nullable Object[] args, boolean typeCheckOnly){
     		Object sharedInstance = getSingleton(beanName);
       }
     ```

     > 此时正在初始化的A对象,继续执行,在getSingleton方法中执行addSingleton()方法,将B属性赋值给A并将A对象添加到Spring容器中
     >
     > ```java
     > protected Object getSingleton(String beanName, boolean allowEarlyReference) {
     >   // 1. 从一级缓存中获取
     >   Object singletonObject = this.singletonObjects.get(beanName);
     >   if (singletonObject == null && isSingletonCurrentlyInCreation(beanName)) {
     >     // 2. 从二级缓存中获取
     >     singletonObject = this.earlySingletonObjects.get(beanName);
     >     if (singletonObject == null && allowEarlyReference) {
     >       synchronized (this.singletonObjects) {
     >         // 3. 上锁,再次冲一级缓存中获取
     >         singletonObject = this.singletonObjects.get(beanName);
     >         if (singletonObject == null) {
     >           // 4.一级缓存中没有后从二级缓存中获取
     >           singletonObject = this.earlySingletonObjects.get(beanName);
     >           if (singletonObject == null) {
     >             // 5. 二级缓存中没有后从三级缓存中获取,如果没有返回null
     >             ObjectFactory<?> singletonFactory = this.singletonFactories.get(beanName);
     >             if (singletonFactory != null) {
     >               // 6. 如果三级缓存中有,则使用代理工厂创建对象
     >               singletonObject = singletonFactory.getObject();
     >               // 7. 创建的对象保存到二级缓存
     >               this.earlySingletonObjects.put(beanName, singletonObject);
     >               // 8. 从三级缓存中删除该对象的代理工厂
     >               this.singletonFactories.remove(beanName);
     >             }
     >           }
     >         }
     >       }
     >     }
     >   }
     >   return singletonObject;
     > }
     > ```

5. 源码解析:代理工厂创建实例

   - 向三级缓存中添加代理工厂时候是一个匿名内部类

     ```java
     addSingletonFactory(beanName, () -> getEarlyBeanReference(beanName, mbd, bean));
     ```

   - 进入getEarlyBeanReference方法

     ```java
     	protected Object getEarlyBeanReference(String beanName, RootBeanDefinition mbd, Object bean) {
     		Object exposedObject = bean;
     		if (!mbd.isSynthetic() && hasInstantiationAwareBeanPostProcessors()) {
     			for (SmartInstantiationAwareBeanPostProcessor bp : getBeanPostProcessorCache().smartInstantiationAware) {
     				exposedObject = bp.getEarlyBeanReference(exposedObject, beanName);
     			}
     		}
     		return exposedObject;
     	}
     ```

   - 进入实现SmartInstantiationAwareBeanPostProcessor接口的getEarlyBeanReference方法的实现类:AbstractAutoProxyCreator

     ```java
     public Object getEarlyBeanReference(Object bean, String beanName) {
       Object cacheKey = getCacheKey(bean.getClass(), beanName);
       this.earlyProxyReferences.put(cacheKey, bean);
       return wrapIfNecessary(bean, beanName, cacheKey);
     }
     // 调用本类方法wrapIfNecessary
     protected Object wrapIfNecessary(Object bean, String beanName, Object cacheKey) {
       // Create proxy if we have advice.
       // 判断是否实现创建代理对象,
       Object[] specificInterceptors = getAdvicesAndAdvisorsForBean(bean.getClass(), beanName, null);
       if (specificInterceptors != DO_NOT_PROXY) {
         this.advisedBeans.put(cacheKey, Boolean.TRUE);
         Object proxy = createProxy(
           bean.getClass(), beanName, specificInterceptors, new SingletonTargetSource(bean));
         this.proxyTypes.put(cacheKey, proxy.getClass());
         return proxy;
       }
       this.advisedBeans.put(cacheKey, Boolean.FALSE);
       // 否则返回原始地形
       return bean;
     }
     
     // 继续调用本类方法createProxy
     protected Object createProxy(Class<?> beanClass, @Nullable String beanName,
                                  @Nullable Object[] specificInterceptors, TargetSource targetSource) {
       ProxyFactory proxyFactory = new ProxyFactory();
       return proxyFactory.getProxy(classLoader);
     }
     ```

   - 查看ProxyFactory中的getProxy方法:createAopProxy()方法返回AopProxy接口类型

     ```java
     public Object getProxy(@Nullable ClassLoader classLoader) {
       return createAopProxy().getProxy(classLoader);
     }
     ```

   - 查看AopProxy接口getProxy的实现类:CglibAopProxy和JdkDynamicAopProxy

     ```java
     // 1. CglibAopProxy
     class CglibAopProxy implements AopProxy, Serializable {
     }
     // 2. JdkDynamicAopProxy
     final class JdkDynamicAopProxy implements AopProxy, InvocationHandler, Serializable {
     }
     ```

   - Cglib动态代理和JDK动态代理源码解析

6. 源码解析:反射创建对象,反射属性赋值

### 5. 总结

1. 为什么要有三级缓存

   - 首先一级缓存singletonObjets类型是Map<String, Object>作用是保存初始化好的对象,用来保证SpringBean的单例;
   - 然后直接看“三级缓存”的作用:变量命名为 singletonFactories，结构是 Map<String, ObjectFactory<?>>，Value 是一个对象的代理工厂，所以“三级缓存”的作用，其实就是用来存放对象的代理工厂,这个代理工厂的作用就是生成半成品的单例Bean;
   - 二级缓存的作用就是存放由三级缓存生成的半成品对象,如果创建的对象有AOP就创建代理对象,如果没有AOP就创建真实对象,所以**这个对象可能是原对象，也可能是个代理对象。**

2. 能干掉二级缓存么:二级缓存的目的是为了避免因为 AOP 创建多个对象，其中存储的是半成品的 AOP 的单例 bean

   > ```java
   > @Service
   > public class A {
   > 
   >     @Autowired
   >     private B b;
   > 
   >     @Autowired
   >     private C c;
   > 
   >     public void test1() {
   >     }
   > }
   > 
   > @Service
   > public class B {
   >     @Autowired
   >     private A a;
   > 
   >     public void test2() {
   >     }
   > }
   > 
   > @Service
   > public class C {
   > 
   >     @Autowired
   >     private A a;
   > 
   >     public void test3() {
   >     }
   > }
   > ```
   >
   > 场景说明:根据上面的套娃逻辑，A需要找B和C，但是B需要找A，C也需要找A。假如A需要进行AOP，因为代理对象每次都是生成不同的对象，如果干掉第二级缓存，只有第一、三级缓存：通过A的工厂的代理对象，生成了两个不同的对象A1和A2
   >
   > - B 找到 A 时，直接通过三级缓存的工厂的代理对象，生成对象 A1。
   > - C 找到 A 时，直接通过三级缓存的工厂的代理对象，生成对象 A2。

# SpringBoot

1. new SpringApplication(Class<?> primarySources)
   - `Set<Class<?>> SpringApplication.primarySources`：将主启动类赋值给该属性
   - `WebApplicationType SpringApplication.webApplicationType`：如果存在DispatcherServlet以WEB应用启动
   - `List<BootstrapRegistryInitializer> SpringApplication.bootstrapRegistryInitializers`：读取/META-INFO/spring.actories配置文件汇中key为`org.springframework.boot.BootstrapRegistryInitializer`的配置的全类名反射生成实例对象存储在集合中；作用：
   - `List<ApplicationListener<?>> SpringApplication.listeners`：读取/META-INFO/spring.actories配置文件汇中key为`org.springframework.context.ApplicationListener`的配置的全类名反射生成实例对象存储在集合中；SpringBoot监听器：作用是在Spring容器初始化Bean时候的回调；
   - `Class<?> SpringApplication#mainApplicationClass`：获取到主启动类类名，获取main方法所在类的类名；
2. SpringApplication#run(String... args)
   1. getRunListeners(args) & starting()：获取并启动监听器
      - 读取/META-INFO/spring.actories配置文件汇中key为`org.springframework.boot.SpringApplicationRunListener`：主要负责SpringBoot启动不同阶段广播出不同消息，传递给ApplicationListener监听器器实现类；
   2. prepareEnvironment()：启动并构造应用Context
      - 创建环境对象StandardEnvironment：
        - ①读取系统配置
        - ②添加应用启动命令行参数
        - ③启动ConfigFileApplicationListener
        - ④应用配置文件属性：
   3. createApplicationContext()：初始化Context，就是包含了当前环境所依赖的属性的一个对象
      - AnnotationConfigServletWebServerApplicationContext初始化两个属性AnnotatedBeanDefinitionReader和ClassPathBeanDefinitionScanner
      - 创建了BeanFactory：DefaultListableBeanFactory
   4. prepareContext()：刷新Context的准备阶段
      - 设置环境变量Environment
      - 执行容器后置处理器：给IOC容器添加内置转换器
      - 向各个监听器发送容器准备完成：
      - 主启动类对象定义到BeanDefinitionRegistry中，
   5. refreshContext()：刷新Context-执行SpringBean的创建
   6. afterRefresh()：刷新Context后的扩展接口
      - 是空实现：模板方法模式；