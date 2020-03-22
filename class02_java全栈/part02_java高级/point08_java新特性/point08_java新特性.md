# 第一部分 Java8

## 1.1 Lambda表达式

### 1. Lambda表达式的演化

​		Lambda是一个匿名函数，可以把Lambda表达式理解为一段可以传递的代码（即一个方法）；

- 案例：存在一段匿名函数

  ```java
  Comparator<Integer> comparator = new Comparator<Integer>() {
      public int compare(Integer o1, Integer o2) {
          return Integer.compare(o1, o2);
      }
  };
  ```

1. 在Lambda之前，需要首先将上面匿名函数实现，并作为参数传递

   ```java
   TreeSet<Integer> treeSet = new TreeSet<>(comparator);
   ```

2. 如果匿名函数使用一次，也可以省略匿名函数的初始化步骤，直接作为参数使用时候完成实现

   ```java
   TreeSet<Integer> treeSet = new TreeSet<>(new Comparator<Integer>() {
       @Override
       public int compare(Integer o1, Integer o2) {
           return Integer.compare(o1, o2);
       }
   });
   ```

3. 在上面的Java代码中，是可以从`new TreeSet<>(参数类型)`的参数中推断出所需要的类型，并且该类型中只有一个方法（函数式接口），所以可以省略方法名，而且可以从函数式接口中推断出方法参数个数与参数类型，从而Lambda表达式中也可以推断出参数类型，所以步骤2的Java表达式可以使用Lambda基本规则简化

   ```java
   TreeSet<Integer> treeSet = new TreeSet<>((o1,o2) -> {
       return Integer.compare(o1,o2);
   });
   ```

4. 最终的Lambda的简化版

   ```java
   TreeSet<Integer> treeSet = new TreeSet<>(Integer::compareTo);
   ```

### 2. Lambda基本规则

- <font size=4 color=blue>标准格式</font>

  ```java
  (形参列表) -> {
      // TUDO 函数体
      return ;
  }
  ```

  > Lambda体被` -> `分隔，也称为箭头函数，箭头左边**圆括号**表示接口参数，箭头右边**大括号**表示接口方法的实现

- <font size=4 color=blue>参数列表简写格式</font>
  1. 没有参数：参数的圆括号不可以省略
  2. 有一个以上参数：参数的圆括号不可以省略
  3. 有一个参数：参数的圆括号可以省略
  4. 参数类型可以省略：在接口抽象方法中推断出参数类型
- <font size=4 color=blue>Lambda体简写格式</font>
  
  1. 没有返回值：如果函数体只有一句话，大括号可以省略
  2. 有返回值：如果函数体只有一句话，return关键字可大括号都可以省略，否则不可以省略

### 3. 方法引用与构造器引用

##  1.2 Java8内置函数式接口

### 1. 基本函数式接口

-  <font size=4 color=blue>Consumer</font>：消费型接口，用来消费数据的，如何消费，消费规则自己定义

  ```java
  public interface Consumer<T> {
      void accept(T t);
  }
  ```

- <font size=4 color=blue>Supplier</font>：供给型接口，目的是生产数据

  ```java
  public interface Supplier<T> {
      T get();
  }
  ```

- <font size=4 color=blue>Predicate</font>：断言型接口

  ```java
  public interface Predicate<T> {
      boolean test(T t);
  }
  ```

- <font size=4 color=blue>Function</font>：函数式接口，简单描述就是有来有回，传递参数并且需要返回结果

  ```java
  public interface Function<T, R> {
  	R apply(T t);
  }
  ```

### 2. 扩展函数式接口

- BiConsumer
  BiFunction
  BinaryOperator
  BiPredicate
  BooleanSupplier

  DoubleBinaryOperator
  DoubleConsumer
  DoubleFunction
  DoublePredicate
  DoubleSupplier
  DoubleToIntFunction
  DoubleToLongFunction
  DoubleUnaryOperator

  IntBinaryOperator
  IntConsumer
  IntFunction
  IntPredicate
  IntSupplier
  IntToDoubleFunction
  IntToLongFunction
  IntUnaryOperator
  LongBinaryOperator
  LongConsumer
  LongFunction
  LongPredicate
  LongSupplier
  LongToDoubleFunction
  LongToIntFunction
  LongUnaryOperator
  ObjDoubleConsumer
  ObjIntConsumer
  ObjLongConsumer

  ToDoubleBiFunction
  ToDoubleFunction
  ToIntBiFunction
  ToIntFunction
  ToLongBiFunction
  ToLongFunction
  UnaryOperator

## 1.3 Java8 Stream

### 1. Stream概述

- <font size=4 color=blue>概述</font>：Java 8 API添加了一个新的抽象称为流Stream，可以让你以一种声明的方式处理数据。Stream 提供一种对 Java 集合运算和表达的高阶抽象将要处理的元素集合看作一种流， 流在管道中传输， 并且可以在管道的节点上进行处理， 比如筛选， 排序，聚合等并产生新流的过程
- <font size=4 color=blue>Stream的特点</font>：
  - Stream不会存储数据
  - Stream不会改变源
  - Stream的操作是延迟的:需要结果时才会执行
- <font size=4 color=blue>Stream的执行步骤</font>：
  - 创建Stream ：获取一个流
  - 中间操作 ：对数据流进行处理
  - 终止操作：执行中间链 ，产生结果

### 2. 创建Stream

### 3. Stream中间操作

- <font size=4 color=blue>过滤：filter(Predicate<T>)</font>：
- <font size=4 color=blue>截断流：limit(long maxSize)</font>：
- <font size=4 color=blue>忽略（跳过）：skip(long maxSize)</font>：
- <font size=4 color=blue>去重：distinct()</font>：
- <font size=4 color=blue>元素映射：map(Function<T, R>)</font>：这个函数会作用到流中每个元素,并返回新流
- <font size=4 color=blue>流映射：flatmap(Function<T, R>)</font>：将流中的每个元素转换为一个流,然后把所有流合并为一个流
- <font size=4 color=blue>自然排序：sort()</font>：根据对象的`compareTo(User o)`方法实现的排序
- <font size=4 color=blue>定制排序：sorted(Comparator<? super T> comparator)</font>：定制`Comparator`接口的方法实现排序

### 4. Stream终止操作

- <font size=4 color=blue>检查是否匹配所有：allMatch(Predicate<T>)</font>：

- <font size=4 color=blue>检查是否至少匹配一个：anyMatch(Predicate<T>)</font>：

- <font size=4 color=blue>返回没有匹配所有的：noneMatch(Predicate<T>)</font>：

- <font size=4 color=blue>返回流中任意一个：findAny()</font>：

- <font size=4 color=blue>返回流中第一个：findFirst()</font>：

- <font size=4 color=blue>返回流中元素个数：count()</font>：

- <font size=4 color=blue>返回流中最大值：max(Comparator<? super T> comparator)</font>：

- <font size=4 color=blue>返回流中最小值：max(Comparator<? super T> comparator)</font>：

- <font size=4 color=blue>归约：reduce</font>：将流中的元素反复结合得到一个新值

  - 二元运算：将identity作为初始值，交给BinaryOperator完成二元运算，最终返回T

    ```java
    T reduce(T identity, BinaryOperator<T> accumulator);
    ```

  - 规约统计：将流中的元素反复结合得到一个新值

    ```java
    T reduce(BinaryOperator<T> accumulator);
    ```

- <font size=4 color=blue>收集：collect()</font>：Collector收集器，用于定制手机方法，Collectors提供了很多静态方法，可以方便的创建常见收集器实例

  - 

# 第二部分 Java9

# 第三部分 Java11

# 第四部分 Java12

# 第五部分 Java13

