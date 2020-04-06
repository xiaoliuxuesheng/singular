# 第一章 设计模式概述

## 1.1 设计模式的理念

​		“设计模式”这个术语最初并不是出现在软件设计中，而是被用于建筑领域的设计中。

​		1995 年，艾瑞克·伽马（ErichGamma）、理査德·海尔姆（Richard Helm）、拉尔夫·约翰森（Ralph Johnson）、约翰·威利斯迪斯（John Vlissides）等 4 位作者合作出版了《设计模式：可复用面向对象软件的基础》（Design Patterns: Elements of Reusable Object-Oriented Software）一书，在本教程中收录了 23 个设计模式，这是设计模式领域里程碑的事件，导致了软件设计模式的突破。这 4 位作者在软件开发领域里也以他们的“四人组”（Gang of Four，GoF）匿名著称。 	

​		直到今天，**狭义的设计模式还是所介绍的 23 种经典设计模式**。

## 1.2 设计模式的作用

​		在软件开发中，设计模式是一套被反复使用、多数人知晓的、经过分类编目的、代码设计经验的总结。**它描述了在软件设计过程中的一些不断重复发生的问题**，以及该问题的解决方案。也就是说，它是解决特定问题的一系列套路，是前辈们的代码设计经验的总结，具有一定的普遍性，可以反复使用。其目的是为了提高代码的可重用性、代码的可读性和代码的可靠性。

- 可以提高程序员的思维能力、编程能力和设计能力。
- 使程序设计更加标准化、代码编制更加工程化，使软件开发效率大大提高，从而缩短软件的开发周期。
- 使设计的代码可重用性高、可读性强、可靠性高、灵活性好、可维护性强

## 1.3 软件开发相关设计原则

1. **单一职责原则**
   不要存在多于一个导致类变更的原因，也就是说每个类应该实现单一的职责，如若不然，就应该把类拆分。

2. **里氏替换原则（Liskov Substitution Principle）**

   ​		里氏代换原则面向对象设计的基本原则之一。 里氏代换原则中说，任何基类可以出现的地方，子类一定可以出现。 LSP是继承复用的基石，只有当衍生类可以替换掉基类，软件单位的功能不受到影响时，基类才能真正被复用，而衍生类也能够在基类的基础上增加新的行为。

   ​		里氏代换原则是对“开-闭”原则的补充。实现“开-闭”原则的关键步骤就是抽象化。而基类与子类的继承关系就是抽象化的具体实现，所以里氏代换原则是对实现抽象化的具体步骤的规范。—— From Baidu 百科

   ​		里氏代换原则中，子类对父类的方法尽量不要重写和重载。因为父类代表了定义好的结构，通过这个规范的接口与外界交互，子类不应该随便破坏它。

3. **依赖倒转原则（Dependence Inversion Principle）**
   这个是开闭原则的基础，具体内容：面向接口编程，依赖于抽象而不依赖于具体。写代码时用到具体类时，不与具体类交互，而与具体类的上层接口交互。

4. **接口隔离原则（Interface Segregation Principle）**
   这个原则的意思是：每个接口中不存在子类用不到却必须实现的方法，如果不然，就要将接口拆分。使用多个隔离的接口，比使用单个接口（多个接口方法集合到一个的接口）要好。

5. **迪米特法则（最少知道原则）（Demeter Principle）**
   就是说：一个类对自己依赖的类知道的越少越好。也就是说无论被依赖的类多么复杂，都应该将逻辑封装在方法的内部，通过public方法提供给外部。这样当被依赖的类变化时，才能最小的影响该类。

   ​		最少知道原则的另一个表达方式是：只与直接的朋友通信。类之间只要有耦合关系，就叫朋友关系。耦合分为依赖、关联、聚合、组合等。我们称出现为成员变量、方法参数、方法返回值中的类为直接朋友。局部变量、临时变量则不是直接的朋友。我们要求陌生的类不要作为局部变量出现在类中。

6. **合成复用原则（Composite Reuse Principle）**
   原则是尽量首先使用合成/聚合的方式，而不是使用继承。

## 1.4 设计模型种类

<img src='./imgs/01_设计模式'/>

# 第二章 创建型模式

​		创建型模式的主要功能的软件开发中对象的创建工作，主要作用是将对象的创建和对象的使用向分离；

## 2.1 简单工厂模式

​		简单工厂模式也称为静态工厂模式或实例工厂模式，基本结构是一个类中定义一个工厂方法，在工厂方法中完成对象的创建；这工厂模式中负责生产对象的类称为工厂类，一般开发中使用Factory作为类的后缀名（约定）；

<font size=4 color=blue>1. 简单工厂涉及相关对象说明</font>

| 名称     | 说明                                                       |
| -------- | ---------------------------------------------------------- |
| 工厂     | 负责生产对象：根据传入不同参数从而创建不同具体产品类的实例 |
| 抽象产品 | 可以不用这个角色，用于为工厂类生产的对象定义规范           |
| 具体产品 | 是由工厂类生产的对象                                       |

<font size=4 color=blue>2. 案例演示</font>

- 为所需要生成的产品定义规范（抽象父类或者接口）

  ```java
  public interface IProduct {
      void show();
  }
  ```

- 根据规范设计对应的产品

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
  ```

  ```java
  // 工厂模式需要扩展创建的对象
  public class ProductC implements IProduct {
      public void show() {
          System.out.println(" 创建产品C成功 ");
      }
  }
  ```

- 定义简单工厂

  - 使用方法逻辑创建对象
  
    ```java
    public class SimpleFactory01 {
        public static IProduct create(String type) {
            switch (type) {
                // 已经开发完成的
                case "A":
                    return new ProductA();
                case "B":
                    return new ProductB();
    
                // 工厂类新增代码完成扩展要创建的对象
                case "C":
                    return new ProductC();
                default:
                    return null;
            }
        }
    }
    ```
    
  - 使用反射创建简单工厂
  
    ```java
    public class SimpleFactory02 {
        public static IProduct create(String productBeanName) {
            try {
                return (IProduct) Class.forName(productBeanName).newInstance();
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }
    }
    ```
  
  - 使用泛型创建简单工厂：本质还是反射
  
    ```java
    public class SimpleFactory03<T> {
        public static <T> T create(Class<T> t) {
            try {
                return(T) t.newInstance();
            } catch (Exception e) {
                e.printStackTrace();
            }
            return null;
        }
    }
    ```

## 2.2 工厂方法模式

​		简单工厂模式出现的问题是：如过需要添加新的产品，则需要修改原来的代码，对扩展和修改不友好；为解决简单工厂模式出现的问题，可以使用工厂方法模式：借鉴模板方法模式的思路，定义创建对象的抽象方法，将具体对象的创建延迟到子类实现，即由子类来决定应该实例化（创建）哪一个类。

<font size=4 color=blue>1. 工厂方法模式涉及相关对象说明</font>

| 名称       | 作用说明                             |
| ---------- | ------------------------------------ |
| 工厂类     | 在工厂类中定义创建对象对象的抽象方法 |
| 工厂实现类 | 是对抽象方法的具体实现               |
| 抽象产品   |                                      |
| 具体产品   |                                      |

<font size=4 color=blue>2. 工厂方法模式案例</font>

- 为所需要生成的产品定义规范（抽象父类或者接口）

  ```java
  public interface IProduct {
      void show();
  }
  ```

- 根据规范设计对应的产品

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
  ```

  ```java
  // 工厂模式需要扩展创建的对象
  public class ProductC implements IProduct {
      public void show() {
          System.out.println(" 创建产品C成功 ");
      }
  }
  ```

- 定义工厂类，定义抽象方法

  ```java
  public interface Factory {
  	IProduct create();
  }
  ```

- 在工厂子类中完成对象创建

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
  ```

  ```java
  // 为扩展的产品c创建工厂
  public class ProductCFactory implements Factory {
      @Override
      public IProduct create() {
          return new ProductC();
      }
  }
  ```

## 2.3 抽象工厂模式

## 2.4 单例设计模式

### 1. 创建单例的各种方式

<font color=blue size=4>**★ - 饿汉式-静态常量**</font>

- **实现原理**

  - 使用静态常量的方式将单例对象准备好, 可接获取即可使用

- **Java**

  ```java
  public class Single {
      
      private static final Single INSTANCE = new Single();
  
      public static Single getInstance() {
          return INSTANCE;
      }
      
      private Single() {
          if (null != INSTANCE){
              throw new RuntimeException("实例对象已存在");
          }
      }
  
      private Object readResolve() {
          return INSTANCE;
      }
  }
  ```

- **特点**

  - 在类加载的时候就立即初始化，并且创建单例对象
  - 绝对线程安全，在线程还没出现以前就是实例化了
  - 类加载的时候就初始化，不管用与不用都占着空间，浪费了内存

<font color=blue size=4>**★ - 饿汉式-静态代码块**</font>

- **实现原理**

- **Java**

  ```java
  public class Single {
      
      private static final Single INSTANCE;
      static {
          INSTANCE = new Single();
      }
  
      public static Single getInstance() {
          return INSTANCE;
      }
  
      
      private Single() {
          if (null != INSTANCE){
              throw new RuntimeException("实例对象已存在");
          }
      }
      
  	private Object readResolve() {
          return INSTANCE;
      }
  }
  ```

- **特点**

  - 特点和静态常量方式的单例模式相同

<font color=blue size=4>**☆ - 懒汉式-普通**</font>

- **实现原理**

- **Java**

  ```java
  public class Single {
      
      private static Single instance;
  
      public static Single getInstance() {
          if (null == instance){
              instance = new Single();
          }
          return instance;
      }
      
      private Single() {
          if (null != instance){
              throw new RuntimeException("实例对象已存在");
          }
      }
      
      private Object readResolve() {
          return instance;
      }
  }
  ```

- **特点**

  - 这样的单例存在线程安全隐患
  - 不推荐

<font color=blue size=4>**☆ - 懒汉式-同步方法**</font>

- **实现原理**

  - 单线程环境下实现懒加载

- **Java**

  ```java
  public class Single {
      
      private static Single instance;
  
      public static synchronized Single getInstance() {
          if (null == instance){
              instance = new Single();
          }
          return instance;
      }
      
      private Single() {
          if (null != instance){
              throw new RuntimeException("实例对象已存在");
          }
      }
  
      private Object readResolve() {
          return instance;
      }
  }
  ```

- **特点**

  - 加上 synchronized 关键字，使这个方法变成线程同步方法,会导致程序运行性能大幅下降

<font color=blue size=4>**☆ - 懒汉式-同步代码块**</font>

- **实现原理**

  - 单线程环境下实现懒加载

- **Java**

  ```java
  public class Single {
      
      private static SingleSynBlock instance;
      
      public static SingleSynBlock getInstance() {
          if (null == instance) {
              synchronized (SingleSynBlock.class) {
                  instance = new SingleSynBlock();
              }
          }
          return instance;
      }
      
      
      private Single() {
          if (null != instance){
              throw new RuntimeException("实例对象已存在");
          }
      }
  
      private Object readResolve() {
          return instance;
      }
  }
  ```

- **特点**

  - 线程不安全并且效率提升不明显,
  - 最危险的一种单例模式

<font color=blue size=4>**★ - 懒汉式-双重检查**</font>

- **实现原理**

  - 解决同步方法的单例模式中出现的问题, 使用双重判断保证单例的实现

- **Java**

  ```java
  public class Single{
      
      private static volatile Single instance = null;
  
      public static Single getInstance() {
          if (null == instance) {
              synchronized (Single.class) {
                  if (null == instance) {
                      instance = new Single();
                  }
              }
          }
          return instance;
      }
      
      private Single() {
          if (null != instance){
              throw new RuntimeException("实例对象已存在");
          }
      }
  
      private Object readResolve() {
          return instance;
      }
  }
  ```

- **特点**

  - 性能相对比较良好
  - 而且适合多线程环境
  - 关键字 `volatile` : 保证此变量对所有的线程的可见性，当一个线程修改了这个变量的值，volatile 保证了新值能立即同步到主内存，以及每次使用前立即从主内存刷新。但普通变量做不到这点，普通变量的值在线程间传递均需要通过主内存

<font color=blue size=4>**★ - 懒汉式-静态内部类**</font>

- **实现原理**

  - 枚举类中每个值代表该枚举类的一个静态实例对象,
  - 它是线程安全的，不可变的，并且很好的解决了序列化中的多实例问题

- **Java**

  ```java
  public class Single{
      
      public static Single getInstance() {
          return InnerClass.INSTANCE;
      }
      
      private static class InnerClass {
          public static final Single INSTANCE = new Single();
      }
      
      private SingleInnerClass() {
          if (InnerClass.INSTANCE != null) {
              throw new RuntimeException("实例对象已存在");
          }
      }
  
      private Object readResolve() {
          return InnerClass.INSTANCE;
      }
  }
  ```

- **特点**

  - 静态内部类不会再外部类加载时候加载, 在使用内部类时候才会被加载
  - 兼顾饿汉式的内存浪费，也兼顾 synchronized 性能问题。内部类一定是要在方法调用之前初始化，巧妙地避免了线程安全问题

<font color=blue size=4>**★ - 枚举单例**</font>

- **实现原理**

- **Java**

  ```java
  public enum SingleEnum{
      
      INSTANCE;
      
      private Single single;
  
      SingleEnum() {
          single = new Single();
      }
  
      public Single getInstance() {
          return single;
      }
  }
  ```

- **特点**

  - 在 JDK 枚举的语法特殊性，以及反射也为枚举保驾护航，让枚举式单例成为一种比较优雅的实现。###

### 2. 反射破坏单例

- Java反射可以调用私有方法,所以反射会破坏单例

  ```java
  Class<?> clz = Class.forName(clzName);
  Constructor<?> constructor = clz.getDeclaredConstructor();
  constructor.setAccessible(true);
  Object o1 = constructor.newInstance();
  Object o2 = constructor.newInstance();
  
  ```

- 解决方案 : 在构造方法中做一些限制

  ```java
  public class Single{
      private Single() {
          if (null != instance){
              throw new RuntimeException("不允许重复实例化");
          }
      }
  }
  
  ```

### 3. 序列化破坏单例

- 单例对象序列化然后写入到磁盘,再从磁盘中读取到对象，反序列化转化为内存对象。反序列化后的对象会重新分配内存,重新创建破坏了单例

  ```java
  String path = "序列化文件路径";
  
  Object instance1 = obj;
  Object instance2 = null;
  
  FileOutputStream objStream = new FileOutputStream(path);
  ObjectOutputStream outputObjStream = new ObjectOutputStream(objStream);
  outputObjStream.writeObject(instance1);
  outputObjStream.flush();
  outputObjStream.close();
  
  ObjectInputStream objectInputStream=new ObjectInputStream(new FileInputStream(path));
  instance2 = objectInputStream.readObject();
  objectInputStream.close();
  
  ```

- 序列化解决破坏单例的方式 : 只需要增加 readResolve()方法即可

  ```java
  public class Single{
      private Object readResolve(){
          return instance;
      }
  }
  ```

### 4. 标准单例的设计方式

```java
public class Single{
    private Single() {
        if (null != instance){
            throw new RuntimeException("不允许重复实例化");
        }
    }
    
    //TODU 除枚举外的其余的单例设计方式
    
    private Object readResolve(){
        return instance;
    }
}
```

### 5. 单例模式的知识点

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

​	建造者（Builder）模式的定义：指将一个复杂对象的构造与它的表示分离，使同样的构建过程可以创建不同的表示，这样的设计模式被称为建造者模式。它是将一个复杂的对象分解为多个简单的对象，然后一步一步构建而成。它将变与不变相分离，即产品的组成部分是不变的，但每一部分是可以灵活选择的。

<font color=blue size=4>**2. 实现原理：基本角色**</font>

- 复杂的对象以及组成复杂对象的若干个子产品对象
- 抽象的构建者：用于制定生产复杂对象以及子产品对象的生成方法规范
- 构建者实现类：在实现类中完成了对复杂对象的创建和复杂对象的子产品的创建
- 指挥者对象：选择其中的一个构建者，并选择构建的子产品最终组装为复杂对象

<font color=blue size=4>**3. 代码案例**</font>



## 2.6 原型设计模式

<font color=blue size=4>**1. 概述**</font>

​		原型（Prototype）模式的定义如下：用一个已经创建的实例作为原型，通过复制该原型对象来创建一个和原型相同或相似的新对象。在这里，原型实例指定了要创建的对象的种类。用这种方式创建对象非常高效，根本无须知道对象创建的细节

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

- 深克隆：把要复制的对象所引用的对象都复制一遍

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

# 第三章 结构型设计模式

### 6.1 概述

​		适配器模式（Adapter）的定义如下：将一个类的接口转换成客户希望的另外一个接口，使得原本由于接口不兼容而不能一起工作的那些类能一起工作。适配器模式分为类结构型模式和对象结构型模式两种，前者类之间的耦合度比后者高，且要求程序员了解现有组件库中的相关组件的内部结构，所以应用相对较少些。

### 6.2 实现原理

1. 因为接口规范不同，需要定义一个适配器类，在适配器类中调用真实的实现方法
2. 因为多个规范在多个接口中，需要定义一个适配器类，实现需要方法

## 第08章 代理模式

### 8.1 概述

​		由于某些原因需要给某对象提供一个代理以控制对该对象的访问。这时，访问对象不适合或者不能直接引用目标对象，代理对象作为访问对象和目标对象之间的中介。

### 8.2 实现原理

:anchor: JDK静态代理

:anchor: JDK动态代理

:anchor: SpringCGLIB动态代价

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