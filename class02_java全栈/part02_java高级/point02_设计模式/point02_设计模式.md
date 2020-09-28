# 第一章 设计模式概述

## 1.1 设计模式的理念

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;设计模式：这个术语最初并不是出现在软件设计中，而是被用于建筑领域的设计中。

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1995 年，艾瑞克·伽马（ErichGamma）、理査德·海尔姆（Richard Helm）、拉尔夫·约翰森（Ralph Johnson）、约翰·威利斯迪斯（John Vlissides）等 4 位作者合作出版了《设计模式：可复用面向对象软件的基础》（Design Patterns: Elements of Reusable Object-Oriented Software）一书，在本教程中收录了 23 个设计模式，这是设计模式领域里程碑的事件，导致了软件设计模式的突破。这 4 位作者在软件开发领域里也以他们的“四人组”（Gang of Four，GoF）匿名著称。

 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;直到今天，**狭义的设计模式还是所介绍的 23 种经典设计模式**。

## 1.2 设计模式的作用

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在软件开发中，设计模式是一套被反复使用、多数人知晓的、经过分类编目的、代码设计经验的总结。**它描述了在软件设计过程中的一些不断重复发生的问题**，以及该问题的解决方案。也就是说，它是解决特定问题的一系列套路，是前辈们的代码设计经验的总结，具有一定的普遍性，可以反复使用。其目的是为了提高代码的可重用性、代码的可读性和代码的可靠性。

- 可以提高程序员的思维能力、编程能力和设计能力。
- 使程序设计更加标准化、代码编制更加工程化，使软件开发效率大大提高，从而缩短软件的开发周期。
- 使设计的代码可重用性高、可读性强、可靠性高、灵活性好、可维护性强

## 1.3 软件开发设计原则

1. **单一职责原则**：不要存在多于一个导致类变更的原因，也就是说每个类应该实现单一的职责，如若不然，就应该把类拆分。
  
2. **里氏替换原则（Liskov Substitution Principle）**

   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;里氏代换原则面向对象设计的基本原则之一。 里氏代换原则中说，任何基类可以出现的地方，子类一定可以出现。 LSP是继承复用的基石，只有当衍生类可以替换掉基类，软件单位的功能不受到影响时，基类才能真正被复用，而衍生类也能够在基类的基础上增加新的行为。

   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;里氏代换原则是对“开-闭”原则的补充。实现“开-闭”原则的关键步骤就是抽象化。而基类与子类的继承关系就是抽象化的具体实现，所以里氏代换原则是对实现抽象化的具体步骤的规范。—— From Baidu 百科

   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;里氏代换原则中，子类对父类的方法尽量不要重写和重载。因为父类代表了定义好的结构，通过这个规范的接口与外界交互，子类不应该随便破坏它。

3. **依赖倒转原则（Dependence Inversion Principle）**：这个是开闭原则的基础，具体内容：面向接口编程，依赖于抽象而不依赖于具体。写代码时用到具体类时，不与具体类交互，而与具体类的上层接口交互。
  
4. **接口隔离原则（Interface Segregation Principle）**：这个原则的意思是：每个接口中不存在子类用不到却必须实现的方法，如果不然，就要将接口拆分。使用多个隔离的接口，比使用单个接口（多个接口方法集合到一个的接口）要好。
  
5. **迪米特法则（最少知道原则）（Demeter Principle）**
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;就是说：一个类对自己依赖的类知道的越少越好。也就是说无论被依赖的类多么复杂，都应该将逻辑封装在方法的内部，通过public方法提供给外部。这样当被依赖的类变化时，才能最小的影响该类。

   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;最少知道原则的另一个表达方式是：只与直接的朋友通信。类之间只要有耦合关系，就叫朋友关系。耦合分为依赖、关联、聚合、组合等。我们称出现为成员变量、方法参数、方法返回值中的类为直接朋友。局部变量、临时变量则不是直接的朋友。我们要求陌生的类不要作为局部变量出现在类中。

6. **合成复用原则（Composite Reuse Principle）**：原则是尽量首先使用合成/聚合的方式，而不是使用继承。

## 1.4 设计模型种类

<img src="https://s1.ax1x.com/2020/03/20/82asII.png" alt="82asII.png" border="0" />

# 第二章 创建型模式

​        创建型模式的主要功能的软件开发中对象的创建工作，主要作用是将对象的创建和对象的使用向分离；

## 2.1 简单工厂模式

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;工厂模式的作用就是创建产品；在Java中就是new一个对象：Java是面向对象的开发语言，在业务开发中会遇到各种类型的对象，如果在业务代码中仅仅为了使用特定功能而负责这个对象的创建，这个对象的创建工作对于业务功能来说是多余的操作，而且代码耦合严重；工厂模式的解决了对象的创建和使用分离，只需要在业务功能中引入工厂角色就能获取到所需要的对象，而无需关系对象的创建过程

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;简单工厂模式是采用封装方法的方式实现对象的创建，所以根据方法的签名（修饰符、方法名称、方法参数）不同，简单工厂模式分为**静态工厂**（工厂类中提供静态方法创建对象，生产对象要直接使用工厂类调用）和**实例工厂**（工厂类中定义实例方法创建对象，生成对象需要用工厂对象调用）；在Java中的方法设计灵活，对应的简单工厂的方式也有很多种；

### 1. 根据参数创建对象

> 实现思路，在工厂类中定义一个方法实现对象的创建，根据参数的不同可以创建不同的对象

- 静态工厂

  ```java
  public class SimpleFactory01 {
  
      private SimpleFactory01() {
      }
  
      public static Car createCar(String type) {
          if ("BM".equals(type)) {
              return new BMCar(type);
          } else if ("QQ".equals(type)) {
              return new QQCar(type);
          }
          return null;
      }
  }
  ```

- 实例工厂

  ```java
  public class SimpleFactory02 {
      public Car createCar(String type) {
          if ("BM".equals(type)) {
              return new BMCar(type);
          } else if ("QQ".equals(type)) {
              return new QQCar(type);
          }
          return null;
      }
  }
  ```

### 2. 根据参数创建对象：使用反射

> 实现思路，在工厂类中定义一个方法实现对象的创建，根据参数的不同可以创建对应类型的对象

- 静态工厂

  ```java
  public class SimpleFactory05 {
  
      private SimpleFactory05() {
      }
  
      public static Car createCar(String productBeanName) {
          try {
              return (Car) Class.forName(productBeanName).newInstance();
          } catch (Exception e) {
              e.printStackTrace();
          }
          return null;
      }
  
      public static Car createCar(Class<?> clz) {
          try {
              return (Car) clz.newInstance();
          } catch (Exception e) {
              e.printStackTrace();
          }
          return null;
      }
  }
  ```

- 实例工厂

  ```java
  
  public class SimpleFactory06 {
      public Car createCar(String productBeanName) {
          try {
              return (Car) Class.forName(productBeanName).newInstance();
          } catch (Exception e) {
              e.printStackTrace();
          }
          return null;
      }
  
      public Car createCar(Class<?> clz) {
          try {
              return (Car) clz.newInstance();
          } catch (Exception e) {
              e.printStackTrace();
          }
          return null;
      }
  }
  ```

### 3. 根据参数创建对象：使用泛型加反射

> 实现思路，在工厂类中定义一个方法实现对象的创建，根据参数的不同可以创建对应类型的对象

- 静态工厂

  ```java
  public class SimpleFactory07 {
  
      private SimpleFactory07() {
      }
  
      public static <T> T create(Class<T> t) {
          try {
              return t.newInstance();
          } catch (Exception e) {
              e.printStackTrace();
          }
          return null;
      }
  }
  ```

- 实例工厂

  ```java
  public class SimpleFactory08 {
      public <T> T create(Class<T> t) {
          try {
              return (T) t.newInstance();
          } catch (Exception e) {
              e.printStackTrace();
          }
          return null;
      }
  }
  ```

### 4. 根据方法创建对象

> 实现思路，在工厂类中定义一系列的方法实现对象的创建，不同的方法创建出不同的对象

- 静态工厂

  ```java
  public class SimpleFactory03 {
  
      private SimpleFactory03() {
      }
  
      public static Car createQQCar() {
          return new QQCar("QQ");
      }
  
      public static Car createBMCar() {
          return new QQCar("BM");
      }
  }
  ```

- 实例工厂

  ```java
  public class SimpleFactory04 {
      public Car createQQCar() {
          return new QQCar("QQ");
      }
  
      public Car createBMCar() {
          return new QQCar("BM");
      }
  }
  ```

## 2.2 工厂方法模式

​        简单工厂模式出现的问题是：如过需要添加新的产品，则需要修改原来的代码，对扩展和修改不友好；为解决简单工厂模式出现的问题，可以使用工厂方法模式：借鉴模板方法模式的思路，定义创建对象的抽象方法，在工厂类中具体对象的创建延迟到工厂的子类实现，即由子类来决定应该实例化（创建）哪一个类。

- 工厂方法中相关对象说明 

  | 名称     | 作用说明                                             |
  | -------- | ---------------------------------------------------- |
  | 抽象工厂 | 对创建对象的方式进行抽象，并不负责具体对象的创建     |
  | 工厂方法 | 是对抽象方法的实现，主要作用的是创建该工厂对应的对象 |
  | 抽象产品 | 规定工厂创建对象的产品类型                           |
  | 具体产品 | 是抽象产品的一个实现类，是工厂方法创建出的具体对象   |

### 1. 工厂方法模式案例

- 抽象产品：假设工厂类要创建的产品的类型是IProduct产品

  ```java
  public interface IProduct {
      void show();
  }
  ```

- 具体产品：IProduct类型的产品有多中不同的实现，比如ProductA、ProductB。。。

  ```java
  public class ProductA implements IProduct{
      public void show() {
          System.out.println(" 创建产品A成功 ");
      }
  }
  public class ProductB implements IProduct {
      public void show() {
          System.out.println(" 创建产品B成功 ");
      }
  }
  public class ProductC implements IProduct {
      public void show() {
          System.out.println(" 创建产品C成功 ");
      }
  }
  ```

- 抽象工厂：需要定义个工厂，对IProduct对象的创建进行抽象，但是不会创建具体的产品

   ```java
  public interface Factory {
      IProduct create();
  }
  ```

- 在工厂类的子类中实现抽象方法，在子类工厂中实现对具体产品的实现

  ```java
  public class ProductAFactory implements Factory {
      @Override
      public IProduct create() {
          return new ProductA();
      }
  }
  public class ProductBFactory implements Factory {
      @Override
      public IProduct create() {
          return new ProductB();
      }
  }
  public class ProductCFactory implements Factory {
  	@Override
  	public IProduct create() {
  		return new ProductC();
  	}
  }
  ```
  
## 2.3 抽象工厂模式

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在工厂方法模式中，我们使用一个工厂创建一种类型的产品。但是有时候我们需要一个工厂能够提供多个类型的产品（产品族），而且每一种类型的产品可以有多个具体产品（产品等级），可以使用抽象工厂模式：抽象工厂模式我理解的是对工厂方法的扩展，抽象工厂用于创建多种类型的多种产品的一中对象创建方式；

- 在讲解抽象工厂模式之前，我们需要理清两个概念：

  - **产品等级结构**。产品的等级结构也就是产品的继承结构。例如一个为空调的抽象类，它有海尔空调、格力空调、美的空调等一系列的子类，那么这个抽象类空调和他的子类就构成了一个产品等级结构。

  - **产品族**。产品族是在抽象工厂模式中的。在抽象工厂模式中，产品族是指由同一个工厂生产的，位于不同产品等级结构中的一组产品。比如，海尔工厂生产海尔空调。海尔冰箱，那么海尔空调则位于空调产品族中。

- 抽象工厂中相关对象说明 

| 名称     | 作用说明                                                     |
| -------- | ------------------------------------------------------------ |
| 产品族   | 定义工厂类需要创建的产品类型：比如手机类型和电脑类型         |
| 产品等级 | 定义每种类型的具体产品：比如手机又小米手机和华为手机，电脑有小米电脑和华为电脑 |
| 工厂     | 在工厂类中抽象出创建多中类型的产品的方法：比如要创建手机类型的产品和电脑类型的产品 |
| 抽象工厂 | 抽象工厂是对工厂的进一步抽象：<br />  - 比如可以抽象为小米工厂（生产小米手机和小米电脑）和华为工厂（生产华为手机和华为电脑）<br />  - 或者抽象为高端工厂（生产华为手机和小米电脑）和低端工厂（生产小米手机和华为电脑） |
| 工厂类   | 类似于工厂方法中创建对象的具体工厂的实现，没一个工厂类只能创建特定类型的产品 |

### 1. 抽象工厂模式案例

- 需要创建两种类型的产品：比如有两个产品族：手机和电脑

  ```java
  public interface NetBook {
  }
  
  public interface NetPhone {
  
  }
  ```

- 电脑类型的产品有两个产品等级：小米笔记本电脑和华为笔记本电脑

  ```java
  public class HWNetBook implements NetBook{
  }
  
  public class XMNetBook implements NetBook{
  }
  ```

- 手机类型的产品有两个产品等级：小米手机和华为手机

  ```java
  public class HWNetPhone implements NetPhone{
  }
  
  public class XMNetPhone implements NetPhone{
  
  }
  ```

- 此时我们需要使用到抽象工厂创建上面的四个产品：首先定义一个工厂规定创建手机和电脑的方法

  ```java
  public interface Factory {
      NetBook creatBook();
  
      NetPhone createPhone();
  }
  ```

- 根据产品族和产品等级对工厂进一步抽象：说明这些工厂是为了创建什么样的产品

  - 抽象方案一：根据产品类型不同抽象为小米工厂（生产小米手机和小米电脑）和华为工厂（生产华为手机和华为电脑）

    ```java
    public interface HWAbsFactory extends Factory {
    }
    
    public interface XMAbsFactory extends Factory {
    }
    ```

  - 抽象方案二：根据产品价格不同抽象为高端工厂和低端工厂

    ```java
    public interface HightAbsFactory extends Factory {
    }
    
    public interface LowAbsFactory extends Factory {
    }
    ```

- 创建具体的工厂实现抽象出来的工厂用于创建具体的产品对象

  - 根据方案一：实现抽象工厂创建华为工厂的实现创建华为手机和华为电脑，创建小米工厂的实现创建小米手机和小米电脑

    ````java
    /**
     * 华为工厂的实现
     */
    public class HWAbsFactoryImpl implements HWAbsFactory {
        @Override
        public NetBook creatBook() {
            return new HWNetBook();
        }
    
        @Override
        public NetPhone createPhone() {
            return new HWNetPhone();
        }
    }
    /**
     * 小米工厂的实现
     */
    public class XMAbsFactoryImpl implements XMAbsFactory {
        @Override
        public NetBook creatBook() {
            return new XMNetBook();
        }
    
        @Override
        public NetPhone createPhone() {
            return new XMNetPhone();
        }
    }
    ````

  - 根据方案二：实现抽象工厂创建高端工厂的实现创建华为手机和小米电脑，创建低端工厂的实现创建小米手机和华为电脑

    ```java
    /**
     * 高端工厂的实现
     */
    public class HightAbsFactoryImpl implements HightAbsFactory {
    
        @Override
        public NetBook creatBook() {
            return new HWNetBook();
        }
    
        @Override
        public NetPhone createPhone() {
            return new XMNetPhone();
        }
    }
    /**
     * 低端工厂的实现
     */
    public class LowAbsFactoryImpl implements LowAbsFactory {
        @Override
        public NetBook creatBook() {
            return new HWNetBook();
        }
    
        @Override
        public NetPhone createPhone() {
            return new XMNetPhone();
        }
    }
    ```

## 2.4 单例设计模式

### 1、学习准备

- 使用CountDownLatch和Semaphore模拟并发

  ```java
  public class TestSingle {
  
      private static final Integer TOTAL_COUNT = 10000;
      private static final Integer THREAD_COUNT = 500;
  
      private final Set<Integer> hash = new HashSet<>();
  
      /**
       * 并发模拟测试单例效率与安全性
       */
      @Test
      public void test() throws InterruptedException {
          // 创建线程池
          ExecutorService service = Executors.newCachedThreadPool();
          // 定义信号量
          final Semaphore semaphore = new Semaphore(THREAD_COUNT);
          //定义计数器闭锁
          final CountDownLatch countDownLatch = new CountDownLatch(TOTAL_COUNT);
          long start = System.currentTimeMillis();
          for (int i = 0; i < TOTAL_COUNT; i++) {
              //将需要测试的业务全部放入线程池
              service.execute(() -> {
                  try {
                      //当线程允许被执行时才执行
                      semaphore.acquire();
                  } catch (InterruptedException e) {
                      // TODO Auto-generated catch block
                      e.printStackTrace();
                  }
                  hash.add(LazySyncBlock.getInstance().hashCode());
                  //线程执行完后释放
                  semaphore.release();
                  //每次线程执行完之后，countdown一次
                  countDownLatch.countDown();
              });
          }
          try {
              //该方法可以保证clientTotal减为0.既可以保证所有的线程都执行完毕了
              countDownLatch.await();
          } catch (InterruptedException e) {
              // TODO Auto-generated catch block
              e.printStackTrace();
          }
          //所有的线程执行完了后，关闭线程池
          service.shutdown();
          System.out.println("创建实例数=" + hash.size());
          System.out.println("创建实例耗时=" + (System.currentTimeMillis() - start));
      }
  }
  ```

- 使用反射创建对象

  ```java
  public class TestSingle {
  	@Test
      public void staticFinal() throws Exception {
          Class<StaticFinal> finalClass = StaticFinal.class;
          Constructor<StaticFinal> ct = finalClass.getDeclaredConstructor();
          ct.setAccessible(true);
  
          StaticFinal single1 = ct.newInstance();
          StaticFinal single2 = ct.newInstance();
          Assert.assertEquals(single1, single2);
      }
  }
  ```

- 序列化创建对象

  ```java
  public class TestSingle {    
  	@Test
      public void testXuliehua() {
          String path = "StaticFinal";
          try (
                  FileOutputStream objStream = new FileOutputStream(path);
                  ObjectOutputStream outputObjStream = new ObjectOutputStream(objStream);
                  ObjectInputStream objectInputStream = new ObjectInputStream(new FileInputStream(path));
          ) {
              StaticFinal instance1 = StaticFinal.getInstance();
              StaticFinal instance2 = null;
              outputObjStream.writeObject(instance1);
              outputObjStream.flush();
  
              instance2 = (StaticFinal) objectInputStream.readObject();
              Assert.assertEquals(instance1, instance2);
          } catch (Exception e) {
              e.printStackTrace();
          }
      }
  }
  ```

- synchronized关键字

- volatile关键字

### 2、单例的九种实现

- ① 静态常量单例

  ```java
  public class StaticFinal {
      private static final StaticFinal INSTANCE = new StaticFinal();
  
      private StaticFinal() {
      }
  
      public static StaticFinal getInstance() {
          return INSTANCE;
      }
  }
  ```

- ② 静态代码块

  ```java
  public class StaticBlock {
      private StaticBlock() {
      }
  
      private static final StaticBlock INSTANCE;
  
      static {
          INSTANCE = new StaticBlock();
      }
  
      public static StaticBlock getInstance() {
          return INSTANCE;
      }
  }
  ```

- ③ 静态内部类

  ```java
  public class LazyInnerClass {
      private LazyInnerClass() {
  
      }
  
      private static class Inner {
          private static final LazyInnerClass INSTANCE = new LazyInnerClass();
      }
  
      public static LazyInnerClass getInstance() {
          return Inner.INSTANCE;
      }
  }
  ```

- ④ 懒加载单例-饿汉式

  ```java
  public class LazyGenerator {
  
      private static LazyGenerator instance;
  
      private LazyGenerator() {
  
      }
  
      public static LazyGenerator getInstance() {
          if (null == instance) {
              instance = new LazyGenerator();
          }
          return instance;
      }
  }
  ```

- ⑤ 懒加载单例-同步方法

  ```java
  public class LazySyncMethod {
      private LazySyncMethod() {
  
      }
  
      private static LazySyncMethod instance;
  
      public static synchronized LazySyncMethod getInstance() {
          if (null == instance) {
              instance = new LazySyncMethod();
          }
          return instance;
      }
  }
  ```

- ⑥ 懒加载单例-同步代码块

  ````java
  public class LazySyncBlock {
      private LazySyncBlock() {
  
      }
  
      private static LazySyncBlock instance;
  
      public static LazySyncBlock getInstance() {
          if (null == instance) {
              synchronized (LazySyncBlock.class) {
                  instance = new LazySyncBlock();
              }
          }
          return instance;
      }
  }
  ````

- ⑦ 懒加载单例-双重检查

  ```java
  public class LazyDoubleCheck {
      static TestSingle l = new TestSingle();
      private static LazyDoubleCheck instance;
  
      private LazyDoubleCheck() {
  
      }
  
      public static LazyDoubleCheck getInstance() {
          //先判断是否存在，不存在再加锁处理
          if (instance == null) {
              //在同一个时刻加了锁的那部分程序只有一个线程可以进入
              synchronized (l) {
                  if (instance == null) {
                      instance = new LazyDoubleCheck();
                  }
              }
          }
          return instance;
      }
  }
  ```

- ⑧ 懒加载单例-volatile

  ```java
  public class LazyVolitile {
      private static volatile LazyVolitile instance;
  
      private LazyVolitile() {
  
      }
  
      public static LazyVolitile getInstance() {
          if (instance == null) {
              synchronized (LazyVolitile.class) {
                  if (instance == null) {
                      instance = new LazyVolitile();
                  }
              }
          }
          return instance;
      }
  }
  ```

  > 关键字 `volatile` : 保证此变量对所有的线程的可见性，当一个线程修改了这个变量的值，volatile 保证了新值能立即同步到主内存，以及每次使用前立即从主内存刷新。但普通变量做不到这点，普通变量的值在线程间传递均需要通过主内存

- ⑨ 单例- 枚举

  ```java
  public enum EnumSingle {
      INSTANCE;
  
      public EnumSingle getInstance() {
          return INSTANCE;
      }
  }
  ```

### 3、破坏单例

#### 反射破坏单例

- 案例说明

  ```java
  @Test
  public void staticFinal() throws Exception {
      Class<StaticFinal> finalClass = StaticFinal.class;
      Constructor<StaticFinal> ct = finalClass.getDeclaredConstructor();
      ct.setAccessible(true);
  
      StaticFinal single1 = ct.newInstance();
      StaticFinal single2 = ct.newInstance();
      Assert.assertEquals(single1, single2);
  }
  ```

- 解决方案：反射创建对象是会调用对象的构造方法，需要为单例订单构造方法中添加显示：方式构造方法重复调用

  ```java
  public class StaticFinal implements Serializable {
      private static final StaticFinal INSTANCE = new StaticFinal();
  
      private static boolean flag = false;
  
      private StaticFinal() {
          synchronized (StaticFinal.class) {
              if (flag) {
                  throw new RuntimeException("单例对象不可以重复创建");
              }
              flag = true;
          }
      }
  
      public static StaticFinal getInstance() {
          return INSTANCE;
      }
  }
  ```

#### 序列化破坏单例

- **案例说明**：单例对象序列化然后写入到磁盘,再从磁盘中读取到对象，反序列化转化为内存对象。反序列化后的对象会重新分配内存,重新创建破坏了单例

  ```java
  @Test
  public void testXuliehua() {
      String path = "single";
      try (
          FileOutputStream objStream = new FileOutputStream(path);
          ObjectOutputStream outputObjStream = new ObjectOutputStream(objStream);
          ObjectInputStream objectInputStream = new ObjectInputStream(new FileInputStream(path));
      ) {
          StaticFinal instance1 = StaticFinal.getInstance();
          StaticFinal instance2 = null;
          outputObjStream.writeObject(instance1);
          outputObjStream.flush();
  
          instance2 = (StaticFinal) objectInputStream.readObject();
          Assert.assertEquals(instance1, instance2);
      } catch (Exception e) {
          e.printStackTrace();
      }
  }
  ```

- **序列化创建对象源码**

  - readObject()

    ```java
    public final Object readObject() throws IOException, ClassNotFoundException {
        //...
            Object obj = readObject0(false);
      	// ...
    }
    ```

  - readObject0(false)

    ```java
    /**
     * new Object.
     */
    final static byte TC_OBJECT =       (byte)0x73;
    
    // 定位到这里:序列化创建对象
    case TC_OBJECT:
    	return checkResolve(readOrdinaryObject(unshared));
    ```

  - readOrdinaryObject(unshared)

    ```java
    private Object readOrdinaryObject(boolean unshared) throws IOException {
    	// ...
            
            // new了一个对象
            obj = desc.isInstantiable() ? desc.newInstance() : null;
    	// ...
    	// 如果序列化对象中有hasReadResolveMethod()方法
        if (obj != null &&
            handles.lookupException(passHandle) == null &&
            desc.hasReadResolveMethod())
        {
            // 重点1:获取这个方法返回的对象
            Object rep = desc.invokeReadResolve(obj);
            if (unshared && rep.getClass().isArray()) {
                rep = cloneArray(rep);
            }
            if (rep != obj) {
                // Filter the replacement object
                if (rep != null) {
                    if (rep.getClass().isArray()) {
                        filterCheck(rep.getClass(), Array.getLength(rep));
                    } else {
                        filterCheck(rep.getClass(), -1);
                    }
                }
                
                // 把方法返回的对象的引用赋值给序列化的对象
                handles.setObject(passHandle, obj = rep);
            }
        }
    
        return obj;
    }
    ```

- 序列化破坏单例解决方案：在readOrdinaryObject()源码中，如果类实现了readResolveMethod()方法，那就invoke，同时之前newInstance的obj引用readOrdinaryObject()返回的对象，在源码中找到这个方法的名称是readResolve()

  ```java
  /** class-defined readResolve method, or null if none */
  private Method readResolveMethod;
  ```

  需要被序列化的类实现了Serializable接口，在Serializable接口的文档注释中也有说明

  ```java
  /**
   * This writeReplace method is invoked by serialization if the method
   * exists and it would be accessible from a method defined within the
   * class of the object being serialized. Thus, the method can have private,
   * protected and package-private access. Subclass access to this method
   * follows java accessibility rules. <p>
   *
   * Classes that need to designate a replacement when an instance of it
   * is read from the stream should implement this special method with the
   * exact signature.
   *
   * <PRE>
   * ANY-ACCESS-MODIFIER Object readResolve() throws ObjectStreamException;
   * </PRE><p>
   */
  public interface Serializable {
  }
  ```

- 标准单例

  ```java
  public class StaticFinal implements Serializable {
      private static final StaticFinal INSTANCE = new StaticFinal();
  
      private static boolean flag = false;
  
      private StaticFinal() {
          synchronized (StaticFinal.class) {
              if (flag) {
                  throw new RuntimeException("单例对象不可以重复创建");
              }
              flag = true;
          }
      }
  
      public static StaticFinal getInstance() {
          return INSTANCE;
      }
  
      /**
       * 防止单例被序列化破坏单例
       *
       * @return 序列化对象
       */
      public Object readResolve() {
          return INSTANCE;
      }
  }
  
  ```

### 4、单例的应用

- 在Spring中的应用
- 在JDK中的应用

### 5、单例模式的知识点

1. 多线程的的使用 : 用于验证单例的线程安全

2. <kbd>synchronized</kbd>, <kbd>volatile</kbd> 关键字的理解 : java基础

3. 反射的基本使用 : 创建实例与方法调用

4. 反序列化的原理的;理解 : readResolve()方法

   ```java
   new ObjectInputStream(InputStream in);
   Object o = ObjectInputStream.readObject();
   ```

5. TreadLoca线程单例 : 不能保证其创建的对象是全局唯一，但是能保证在单个线程中是唯一的，天生的线程安全

6. 反射破坏单例的解决方案

7. 序列化破坏单例的解决方案

8. ThreadLocal线程单例

## 2.5 建造者设计模式

<font color=blue size=4>**1. 概述**</font>

​		建造者（Builder）模式的定义：**指将一个复杂对象的构造与它的表示分离，使同样的构建过程可以创建不同的表示，这样的设计模式被称为建造者模式**。它是将一个复杂的对象分解为多个简单的对象，然后一步一步构建而成。它将变与不变相分离，即产品的组成部分是不变的，但每一部分是可以灵活选择的。

​		构建者模式一般用在构建流程或者组成部件固定的场合，将这些部件分开构建成为组件对象，再将这些组件对象整合成为目标对象。

<font color=blue size=4>**2. 实现原理：基本角色**</font>

- 复杂的对象以及组成复杂对象的若干个子产品对象
- 抽象的构建者：用于制定生产复杂对象以及子产品对象的生成方法规范
- 构建者实现类：在实现类中完成了对复杂对象的创建和复杂对象的子产品的创建
- 指挥者对象：选择其中的一个构建者，并选择构建的子产品最终组装为复杂对象

<font color=blue size=4>**3. 代码案例**</font>

- **标准的建造者格式**

  1. 有一个复杂的Java对象，是需要使用构造器创建该对象

     ```java
     @Setter
     @Getter
     public class Bike { 
         private IFrame frame; 
         private ISeat seat; 
         private ITire tire; 
     }
     ```

  2. 这个对象是由多个复杂对象组成，所以在抽象该对象创建方法时候也要对内部对象的创建做抽象

     ```java
     public abstract class Builder { 
         abstract void buildFrame(); 
         abstract void buildSeat(); 
         abstract void buildTire(); 
         abstract Bike createBike(); 
     } 
     ```

  3. 要构建不同的产品只需要各自实现创建产品的抽象类：在真实的建造者中完成对象的创建，做到创建和表现相分离

     ```java
     // 这个类会构建出一个摩拜单车的产品
     public class MobikeBuilder extends Builder{ 
         private Bike mBike = new Bike(); 
         @Override 
         void buildFrame() { 
             mBike.setFrame(new AlloyFrame()); 
         } 
         @Override 
         void buildSeat() { 
             mBike.setSeat(new DermisSeat()); 
         } 
         @Override 
         void buildTire() { 
             mBike.setTire(new SolidTire()); 
         } 
         @Override 
         Bike createBike() { 
             return mBike; 
         } 
     } 
     // 这个类会构建出一个ofo的产品
     public class OfoBuilder extends Builder{ 
         private Bike mBike = new Bike(); 
         @Override 
         void buildFrame() { 
             mBike.setFrame(new CarbonFrame()); 
         } 
         @Override 
         void buildSeat() { 
             mBike.setSeat(new RubberSeat()); 
         } 
         @Override 
         void buildTire() { 
             mBike.setTire(new InflateTire()); 
         } 
         @Override 
         Bike createBike() { 
             return mBike; 
         } 
     } 
     ```

  4. 指挥者类：根据不同的构建者创建出不同的产品

     ```java
     public class Director { 
         private Builder mBuilder = null; 
         public Director(Builder builder) { 
             mBuilder = builder; 
         } 
         public Bike construct() { 
             mBuilder.buildFrame(); 
             mBuilder.buildSeat(); 
             mBuilder.buildTire(); 
             return mBuilder.createBike(); 
         } 
     }
     ```

  5. 产品的创建测试

     ```java
     public class Click { 
         public static void main(String[] args) { 
             showBike(new OfoBuilder()); 
             showBike(new MobikeBuilder()); 
         } 
         private void showBike(Builder builder) {
             Director director = new Director(builder); 
             Bike bike = director.construct(); 
             bike.getFrame().frame(); 
             bike.getSeat().seat(); 
             bike.getTire().tire(); 
         } 
     } 
     ```

- **简化系统结构，可以把Director和抽象建造者进行结合**

  1. **不使用建造者模式创建产品**

     - 定义产品类

       ```java
       public class Computer { 
           private String cpu; 
           private String screen; 
           private String memory; 
           private String mainboard; 
           public Computer(String cpu, String screen, String memory, String mboard) { 
               this.cpu = cpu; 
               this.screen = screen; 
               this.memory = memory; 
               this.mainboard = mboard; 
           } 
       } 
       ```

     - 创建产品非 Builder 模式：使用传统方法使用构造器创建对象

       ```java
       Computer computer = new Computer(“cpu”, “screen”, “memory”, “mainboard”); 
       ```

  2. **使用简化方式创建产品**

     - 定义产品并定义对应的建造者对象

       ```java
       public class NewComputer { 
           private String cpu; 
           private String screen; 
           private String memory; 
           private String mainboard; 
           public NewComputer() { 
               throw new RuntimeException(“can’t init”); 
           } 
           private NewComputer(Builder builder) { 
               cpu = builder.cpu; 
               screen = builder.screen; 
               memory = builder.memory; 
               mainboard = builder.mainboard; 
           } 
           public static final class Builder { 
               private String cpu; 
               private String screen; 
               private String memory; 
               private String mainboard; 
               
           public Builder() {} 
           
           public Builder cpu(String val) { 
               cpu = val; 
               return this; 
           } 
           public Builder screen(String val) { 
               screen = val; 
               return this; 
           } 
           public Builder memory(String val) { 
               memory = val; 
               return this; 
           } 
           public Builder mainboard(String val) { 
               mainboard = val; 
               return this; 
           } 
           public NewComputer build() {
               return new  NewComputer(this);} 
           } 
       } 
       ```

     - 测试Builder模式创建产品

       ```java
       NewComputer newComputer = new NewComputer.Builder() 
               .cpu(“cpu”) 
               .screen(“screen”) 
               .memory(“memory”) 
               .mainboard(“mainboard”) 
               .build(); 
       ```

## 2.6 原型设计模式

<font color=blue size=4>**1. 概述**</font>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;原型模式的思路：Java中Object是所有类的根类，Object提供了一个clone方法，该方法可以将Java对象复制一份，但是需要实现克隆方法的Java类**必须实现一个接口Cloneable**：该接口表示实现类能够复制且具有复制的能力，这种复制方式也称为原型模式。

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;原型（Prototype）模式的定义如下：用一个已经创建的实例作为原型，通过复制该原型对象来创建一个和原型相同或相似的新对象。在这里，原型实例指定了要创建的对象的种类。用这种方式创建对象非常高效，根本无须知道对象创建的细节。

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;在Spring中指定scope=prototype（多例）的Bean的创建，就是使用的原型模式

<font color=blue size=4>**2. 实现原理**</font>

- 浅克隆：如果字段是值类型的，则对该字段执行逐位复制，如果字段是引用类型，则复制引用但不复制引用的对象；因此，原始对象及其复本引用同一对象

  ```java
  public class Resume implements Cloneable {
      private String name;
      private String sex;
      private String age;
      private String timeArea;
      private String company;
      private List<String> lists;
  	
      @Override
      protected Object clone() throws CloneNotSupportedException {
          return super.clone();
      }
  }
  ```

  > lists是引用类型，克隆后修改原修改引用类型的值，会影响到原对象

- 深克隆：复制对象的所有基本数据类型的成员变量值；为所有引用数据类型的成员变量申请存储空间，并复制每个引用类型成员变量所引用的对象，直到该对象的所有成员；（**总结一句话：深拷贝是对整个对象进行拷贝**）

  1. **深拷贝方式一**：重新clone方法来实现深拷贝
  
     ```java
     @Override
     protected Resume clone() throws CloneNotSupportedException {
         Resume clone = (Resume) super.clone();
         List<String> target = new ArrayList<>();
         target.addAll(this.lists);
         clone.lists = target;
         return clone;
     }
     ```
  
  2. **深拷贝方式二**：通过对象序列化实现深拷贝
  
     ```java
     
     ```

# 第三章 结构型设计模式

## 3.1 适配器模式

<font color=blue size=4>**1. 概述**</font>

​		适配器模式（Adapter）：将一个类的接口转换成客户希望的另外一个接口，使得原本由于接口不兼容而不能一起工作的那些类能一起工作。适配器模式分为类结构型模式和对象结构型模式两种，前者类之间的耦合度比后者高，且要求程序员了解现有组件库中的相关组件的内部结构，所以应用相对较少些。

- **主要优点**
  - 将目标类和适配者类解耦，通过引入一个适配器类来重用现有的适配者类，无须修改原有结构。
  - 增加了类的透明性和复用性，将具体的业务实现过程封装在适配者类中，对于客户端类而言是透明的，而且提高了适配者的复用性，同一个适配者类可以在多个不同的系统中复用。
  - 灵活性和扩展性都非常好，通过使用配置文件，可以很方便地更换适配器，也可以在不修改原有代码的基础上增加新的适配器类，完全符合“开闭原则”。

<font color=blue size=4>**2. 实现原理**</font>

- **Target（目标抽象类）**：目标抽象类定义客户所需接口，可以是一个抽象类或接口，也可以是具体类。
- **Adapter（适配器类）**：适配器可以调用另一个接口，作为一个转换器，对Adaptee和Target进行适配，适配器类是适配器模式的核心，在对象适配器中，它通过继承Target并关联一个Adaptee对象使二者产生联系。
- **Adaptee（适配者类）**：适配者即被适配的角色，它定义了一个已经存在的接口，这个接口需要适配，适配者类一般是一个具体类，包含了客户希望使用的业务方法，在某些情况下可能没有适配者类的源代码。

<font color=blue size=4>**3. 代码案例**</font>

- **类适配器**：由于适配器类是适配者类的子类，因此可以在适配器类中置换一些适配者的方法，使得适配器的灵活性更强。

  1. 首先有一个已存在的将被适配的类

     ```java
     public class Adaptee {
         public void adapteeRequest() {
             System.out.println("被适配者的方法");
         }
     }
     ```

  2. 定义一个目标接口：为了适配另一个API

     ```java
     public interface Target {
         void request();
     }
     ```

  3. 适配器类是需要整合已存在的API和目标接口API，所以单纯的继承或实现是不够的

     ```java
     public class Adapter extends Adaptee implements Target{
         @Override
         public void request() {
             //...一些操作...
             super.adapteeRequest();
             //...一些操作...
         }
     }
     ```

  4. 适配器完成测试适配器类

     ```java
     public class Test {
         public static void main(String[] args) {
             Target target = new ConcreteTarget();
             target.request();
     
             Target adapterTarget = new Adapter();
             adapterTarget.request();
         }
     }
     ```

- **对象适配器**：一个对象适配器可以把多个不同的适配者适配到同一个目标；可以适配一个适配者的子类，由于适配器和适配者之间是关联关系，根据“里氏代换原则”，适配者的子类也可通过该适配器进行适配。

  1. 对象适配器与类适配器不同之处在于，类适配器通过继承来完成适配，对象适配器则是通过关联来完成

     ```java
     public class Adapter implements Target{
         // 适配者是对象适配器的一个属性
         private Adaptee adaptee = new Adaptee();
     
         @Override
         public void request() {
             //...
             adaptee.adapteeRequest();
             //...
         }
     }
     ```

## 3.2 装饰器模式

<font color=blue size=4>**1. 概述**</font>

​		**装饰者模式(Decorator Pattern)**：动态地给一个对象增加一些额外的职责，增加对象功能来说，装饰模式比生成子类实现更为灵活。装饰模式是一种对象结构型模式。

​		在装饰者模式中，为了让系统具有更好的灵活性和可扩展性，我们通常会定义一个抽象装饰类，而将具体的装饰类作为它的子类

<font color=blue size=4>**2. 实现原理**</font>：**核心在于抽象装饰类的设计**

- **Component（抽象构件）**：它是具体构件和抽象装饰类的共同父类，声明了在具体构件中实现的业务方法，它的引入可以使客户端以一致的方式处理未被装饰的对象以及装饰之后的对象，实现客户端的透明操作。

- **ConcreteComponent（具体构件）**：它是抽象构件类的子类，用于定义具体的构件对象，实现了在抽象构件中声明的方法，装饰器可以给它增加额外的职责（方法）。

- **Decorator（抽象装饰类）**：它也是抽象构件类的子类，用于给具体构件增加职责，但是具体职责在其子类中实现。它维护一个指向抽象构件对象的引用，通过该引用可以调用装饰之前构件对象的方法，并通过其子类扩展该方法，以达到装饰的目的。

- **ConcreteDecorator（具体装饰类）**：它是抽象装饰类的子类，负责向构件添加新的职责。每一个具体装饰类都定义了一些新的行为，它可以调用在抽象装饰类中定义的方法，并可以增加新的方法用以扩充对象的行为。

<font color=blue size=4>**3. 代码案例**</font>

- 煎饼抽象类

  ```java
  public abstract class ABattercake {
      protected abstract String getDesc();
      protected abstract int cost();
  }
  ```

- 普通煎饼类，继承了煎饼抽象类，一个煎饼 8 块钱

  ```java
  public class Battercake extends ABattercake {
      @Override
      protected String getDesc() {
          return "煎饼";
      }
      @Override
      protected int cost() {
          return 8;
      }
  }
  ```

- 抽象装饰类，需要注意的是，**抽象装饰类通过成员属性的方式将 煎饼抽象类组合进来，同时也继承了煎饼抽象类**，且这里定义了新的业务方法 `doSomething()`

  ```java
  public abstract class AbstractDecorator extends ABattercake {
      private ABattercake aBattercake;
  
      public AbstractDecorator(ABattercake aBattercake) {
          this.aBattercake = aBattercake;
      }
  
      protected abstract void doSomething();
  
      @Override
      protected String getDesc() {
          return this.aBattercake.getDesc();
      }
      @Override
      protected int cost() {
          return this.aBattercake.cost();
      }
  }
  ```

- 鸡蛋装饰器，继承了抽象装饰类，鸡蛋装饰器在父类的基础上增加了一个鸡蛋，同时价格加上 1 块钱

  ```java
  public class EggDecorator extends AbstractDecorator {
      public EggDecorator(ABattercake aBattercake) {
          super(aBattercake);
      }
  
      @Override
      protected void doSomething() {
  
      }
  
      @Override
      protected String getDesc() {
          return super.getDesc() + " 加一个鸡蛋";
      }
  
      @Override
      protected int cost() {
          return super.cost() + 1;
      }
  
      public void egg() {
          System.out.println("增加了一个鸡蛋");
      }
  }
  ```

- 香肠装饰器，与鸡蛋装饰器类似，继承了抽象装饰类，给在父类的基础上加上一根香肠，同时价格增加 2 块钱

  ```java
  public class SausageDecorator extends AbstractDecorator{
      public SausageDecorator(ABattercake aBattercake) {
          super(aBattercake);
      }
      @Override
      protected void doSomething() {
  
      }
  
      @Override
      protected String getDesc() {
          return super.getDesc() + " 加一根香肠";
      }
      @Override
      protected int cost() {
          return super.cost() + 2;
      }
  }
  ```

- 测试装饰器

  ```java
  public class Test {
      public static void main(String[] args) {
          // 购买一个煎饼
          ABattercake aBattercake = new Battercake();
          
          
          // 购买一个加鸡蛋的煎饼
          ABattercake aBattercake = new Battercake();
          aBattercake = new EggDecorator(aBattercake);
          
          // 购买一个加两个鸡蛋的煎饼
          ABattercake aBattercake = new Battercake();
          aBattercake = new EggDecorator(aBattercake);
          aBattercake = new EggDecorator(aBattercake);
          
          // 购买一个加两个鸡蛋和一根香肠的煎饼
          ABattercake aBattercake = new Battercake();
          aBattercake = new EggDecorator(aBattercake);
          aBattercake = new EggDecorator(aBattercake);
          aBattercake = new SausageDecorator(aBattercake);
      }
  }
  ```


## 3.3 代理模式

### 8.1 概述

​		代理模式的主要作用是用于增强目标对象。在不改变目标对象的前提，对目标对象实现增强；主要思路是将调用对象和被调用对象分离，一定程度上降低了耦合度。扩展性好；而且保护了目标对象；主要优点是：职责清晰，目标对象就是实现实际的业务逻辑，不用关心其他非本职责的事务，通过后期的代理完成，附带的结果就是编程简洁清晰。

​		代理模式的缺点主要是：①对象与对象调用之间增加了一层代理，可能会导致执行的速度变慢；②实现代理的代码有时会很复杂，添加了额外的工作量；③增加系统的复杂度

### 8.2 实现原理

:anchor: **静态代理**：静态代理的实现方式有两种，一是代理类实现被代理对象的接口，二是代理类继承被代理类；这样做的目的只有一个，就是代理对象需要执行被代理对象中真实的方法。代理对象通过组合被代理对象，由代理对象间接的调用被代理对象的方法。

- 买房案例：买房消费者的实现类有个买房的人

  ```java
  // 消费者抽象接口
  public interface HouseConsumer {
      void buyHouse(Integer money);
  }
  
  // 具体的买房对象
  public class HoseOwner implements HouseConsumer {
      public void buyHouse(Integer money) {
          System.out.println("HoseOwner总共花了"+money+"元钱 ---  买了一套房子");
      }
  }
  ```

- 为买房的人定义一个代理：帮助买房人买房，代理的主要功能是讨价还价，买到房后为房子进行装修

  ```java
  public class StaticHoseProxy implements HouseConsumer {
  
      private HoseOwner hoseOwner;
  
      public StaticHoseProxy(HoseOwner hoseOwner) {
          this.hoseOwner = hoseOwner;
      }
  
      public void buyHouse(Integer money) {
          int cheep = money-money/3;
          bargain(cheep);
          hoseOwner.buyHouse(money-cheep);
          finish();
      }
  
      private void bargain(Integer money){
          System.out.println("------------>>>> 房屋代理进行讨价还价,便宜了"+money+"元");
      }
  
      private void finish(){
          System.out.println("------------>>>> 房屋代理把房子装修好了");
      }
  
  }
  ```

- 最后测试：让代理帮助买房人买房

  ```java
  @Test
  public void staticProxyTest(){
      StaticHoseProxy proxy = new StaticHoseProxy(new HoseOwner());
      proxy.buyHouse(9000);
  }
  
  
  // 买房结果
  ------------>>>> 房屋代理进行讨价还价,便宜了6000元
  HoseOwner总共花了3000元钱 ---  买了一套房子
  ------------>>>> 房屋代理把房子装修好了
  ```

**:anchor: JDK动态代理**：利用JDK的API,动态的在内存中构建代理对象。不需要继承父类，可扩展性高。前提仍然是被代理对象需要实现一个接口；其核心原理是`Proxy.newProxyInstance()`通过反射创建出代理对象，在代理对象中实现方法增强，最终也是在代理类中通过反射调用被代理对象的真实方法

- Proxy.newProxyInstance()参数说明：loader是类加载器，需要使用到被代理对象的类加载器才能在内存中创建被代理对象的代理类；创建的代理类的类型需要参考被代理对象的接口，第二个参数interface，可能会实现多个接口；handler表示调用处理程序，表示对被代理对象的增强逻辑，是个接口所以自定义JDK代理类需要实现InvocationHandler接口

  ```java
  public static Object newProxyInstance(ClassLoader loader,
                                        Class<?>[] interfaces,
                                        InvocationHandler handler){
      
  }
  ```

- 案例说明：还是买房的案例，定义一个JKD代理类

  ```java
  public class InvocationHandlerImpl implements InvocationHandler {
   
      /**
       * 这个就是我们要代理的真实对象
       */
      private Object subject;
   
      /**
       * 构造方法，给我们要代理的真实对象赋初值
       *
       * @param subject
       */
      public InvocationHandlerImpl(Object subject)
      {
          this.subject = subject;
      }
   
      /**
       * 该方法负责集中处理动态代理类上的所有方法调用。
       * 调用处理器根据这三个参数进行预处理或分派到委托类实例上反射执行
       *
       * @param proxy  代理类实例
       * @param method 被调用的方法对象
       * @param args   调用参数
       * @return
       * @throws Throwable
       */
      public Object invoke(Object proxy, Method method, Object[] args) throws Throwable {
          //在代理真实对象前我们可以添加一些自己的操作
          System.out.println("在调用之前，我要干点啥呢？");
   
   
          //当代理对象调用真实对象的方法时，其会自动的跳转到代理对象关联的handler对象的invoke方法来进行调用
          Object returnValue = method.invoke(subject, args);
   
          //在代理真实对象后我们也可以添加一些自己的操作
          System.out.println("在调用之后，我要干点啥呢？");
   
          return returnValue;
      }
  }
  ```

- 使用Proxy.newProxyInstance()创建代理对象并执行增强方法

  ```java
  @Test
  public void jdkProxyTest(){
      // 代理的真实对象
      HoseOwner owner = new HoseOwner();
      ClassLoader loader = owner.getClass().getClassLoader(); // 反射获取类加载器
      Class[] interfaces = owner.getClass().getInterfaces();	// 反射获取代理类的接口
      
      // 要代理哪个真实对象，就将该对象传进去，最后是通过该真实对象来调用其方法
      InvocationHandlerImpl handler = new InvocationHandlerImpl(owner);
  
      // 该方法用于为指定类装载器、一组接口及调用处理器生成动态代理类实例
      HouseConsumer subject = (HouseConsumer) Proxy.newProxyInstance(loader, interfaces, handler);
  
      subject.buyHouse(9000);
  }
  ```

:anchor: **SpringCGLIB动态代理**：CGLIB(Code Generation Library)是一个开源项目！是一个强大的，高性能，高质量的Code生成类库，CGLIB代理原理是通过动态为代理里生成子类，通过子类实现的代理功能

- 添加CGLIB依赖或者SpringAOP自带CGLIB

  ```xml
  <dependency>
      <groupId>cglib</groupId>
      <artifactId>cglib</artifactId>
      <version>2.2.2</version>
  </dependency>
  ```

- 实现一个业务类，注意，这个业务类并没有实现任何接口

  ```java
  public class HelloService {
   
      public HelloService() {
          System.out.println("HelloService构造");
      }
  
      // 该方法不能被子类覆盖,Cglib是无法代理final修饰的方法的,因为子类无法实现final方法
      final public void sayOthers(String name) {
          System.out.println("HelloService:sayOthers>>"+name);
      }
   
      public void sayHello() {
          System.out.println("HelloService:sayHello");
      }
  }
  
  ```

- 自定义代理增强类实现MethodInterceptor接口

  ```java
  public class CglibProxy implements MethodInterceptor {
  
      /**
       * sub：cglib生成的代理对象
       * method：被代理对象方法
       * objects：方法入参
       * methodProxy: 代理方法
       */
      @Override
      public Object intercept(Object sub, Method method, Object[] objects, MethodProxy methodProxy) throws Throwable {
          System.out.println("======插入前置通知======");
          Object object = methodProxy.invokeSuper(sub, objects);
          System.out.println("======插入后者通知======");
          return object;
      }
  }
  ```

- 测试

  ```java
  @Test
  public void testCglib() throws Exception{
      Enhancer enhancer = new Enhancer();
      // 设置enhancer对象的父类
      enhancer.setSuperclass(HelloService.class);
      // 设置enhancer的回调对象
      enhancer.setCallback(new CglibProxy());
      // 创建代理对象
      HelloService proxy= (HelloService)enhancer.create();
      // 通过代理对象调用目标方法
      proxy.sayHello();
  
  }
  ```

## 第09章 外观模式

### 9.1 概述

​		外观（Facade）模式的定义：是一种通过为多个复杂的子系统提供一个一致的接口，而使这些子系统更加容易被访问的模式。该模式对外有一个统一接口，外部应用程序不用关心内部子系统的具体的细节，这样会大大降低应用程序的复杂度，提高了程序的可维护性。

​		简单描述就是封装，封装的不是属性，封装的子系统，并将子系统的方法合并在一个方法中执行

### 9.2 实现原理

1. 外观模式基本角色

## 第10章 桥接模式

### 10.1 概述

​		桥接（Bridge）模式的定义如下：将抽象与实现分离，使它们可以独立变化。它是用组合关系代替继承关系来实现，从而降低了抽象和实现这两个可变维度的耦合度。

### 10.2 实现原理

1. 桥接（Bridge）模式包含以下主要角色。
   - 实现化（Implementor）角色：定义实现化角色的接口，供扩展抽象化角色调用。
   - 具体实现化（Concrete Implementor）角色：给出实现化角色接口的具体实现。
   - 抽象化（Abstraction）角色：定义抽象类，并包含一个对实现化对象的引用。
   - 扩展抽象化（Refined    Abstraction）角色：是抽象化角色的子类，实现父类中的业务方法，并通过组合关系调用实现化角色中的业务方法。

## 第11章 组合模式

### 11.1 概述

​		组合（Composite）模式的定义：有时又叫作部分-整体模式，它是一种将对象组合成树状的层次结构的模式，用来表示“部分-整体”的关系，使用户对单个对象和组合对象具有一致的访问性。

### 11.2 实现原理



## 第12章 享元模式
## 第13章 策略模式

### 13.2 概述

### 13.2 原理



## 第14章 模板方法模式

### 14.1 概述

​		定义一个操作中的算法骨架，而将算法的一些步骤延迟到子类中，使得子类可以不改变该算法结构的情况下重定义该算法的某些特定步骤。它是一种类行为型模式。

### 14.2 原理

1. 模板方法模式包含以下主要角色。
   - 抽象类（Abstract Class）：负责给出一个算法的轮廓和骨架。它由一个模板方法和若干个基本方法构成。这些方法的定义如下。
     -  模板方法：定义了算法的骨架，按某种顺序调用其包含的基本方法。
     - 基本方法：是整个算法中的一个步骤，包含以下几种类型。
       - 抽象方法：在抽象类中申明，由具体子类实现。
       - 具体方法：在抽象类中已经实现，在具体子类中可以继承或重写它。
       - 钩子方法：在抽象类中已经实现，包括用于判断的逻辑方法和需要子类重写的空方法两种。
   - 具体子类（Concrete Class）：实现抽象类中所定义的抽象方法和钩子方法，它们是一个顶级逻辑的一个组成步骤。

## 第15章 观察者模式
## 第16章 迭代子模式
## 第17章 责任链模式
## 第18章 命令模式
## 第19章 备忘录模式
## 第20章 状态模式
## 第21章 访问者模式
## 第22章 中介者模式
## 第23章 解释器模式
## 第24章 并发型模式
## 第25章 线程池模式   