# 1. Stream简介

- Java 8 API添加了一个新的抽象称为流Stream，可以让你以一种声明的方式处理数据。
- Stream 提供一种对 Java 集合运算和表达的高阶抽象
- 将要处理的元素集合看作一种流， 流在管道中传输， 并且可以在管道的节点上进行处理， 比如筛选， 排序，聚合等并产生新流的过程
  - Stream不会存储数据
  - Stream不会改变源
  - Stream的操作是延迟的:需要结果时才会执行

# 2. 使用Stream的基本步骤

- 创建Stream : 获取一个流
- 中间操作 : 对数据流进行处理
- 终止操作 : 执行中间链 ,产生结果

# 3. 创建流

## ▲ 并行流

```java
java.util.Collection.stream()
```

## ▲ 串行流

```java
java.util.Collection.parallelStream()
```

> 并行流就是把内容分割成多个数据块，每个数据块对应一个流，然后用多个线程分别处理每个数据块中的流
>
> 并行流底层使用的是forkjoin框架，对于一些计算量比较大的任务，使用并行流可能极大的提升效率。

## ▲ 数组流

```java
java.util.Arrays.stream(T[] array)
```

## ▲ StreamAPI

```java
java.util.stream.Stream.of(T obj)
```

## ▲ 无限流

- 迭代

  ```java
  java.util.stream.Stream.iterate(T 运算的起始值,UnaryOperator<T> extends Function<T, T>)
  ```

  > - `UnaryOperator<T>` 操作一元运算的函数式接口 : 接受参数并返回值
  > - 核心方法 :  <kbd>R apply(T t);</kbd>

- 生成

  ```java
  java.util.stream.Stream.generate(Supplier<T>)
  ```

  > - `Supplier<T>` 供给型接口 : 不接收参数,但是有返回值 T
  > - 核心方法 : <kbd>T get();</kbd>

# 4. 筛选和切片

##▲ 过滤 : `filter`

```java
java.util.stream.Stream.filter(Predicate<T>)
```

> `Predicate<T>` 断言型接口 : 接收一个参数T类型,并返回Boolean值
>
> 核心方法 : <kbd>boolean test(T t);</kbd>

##▲ 截断流 : `limit`

```java
java.util.stream.Stream.limit(long maxSize)
```

> 使其元素不超过给定的数量

##▲ 跳过元素 : `skip`

```java
java.util.stream.Stream.skip(long maxSize)
```

> 跳过指定数量的元素 : 返回的流扔掉了跳过的数据量

##▲ 去重 : `distinct`

```java
java.util.stream.Stream.distinct()
```

> 通过流元素的hashCode()方法和equals()方法判断元素是否相同

# 5.映射

## ▲ 元素映射 : `map`

- 接收一个函数为参数 : 这个函数会作用到流中每个元素,并返回新流

  ```java
  java.util.stream.Stream.map(Function<T, R>)
  ```

  > `Function<T, R>` 函数型接口 : 接收参数T类型,返回值R
  >
  > 核心方法 : <kbd>R apply(T t);</kbd>

##▲ 流映射 : `flatmap`

- 接收一个函数作为参数 : 将流中的每个元素转换为一个流,然后把所有流合并为一个流

  ```java
  java.util.stream.Stream.flatmap(Function<T, R>)
  ```

  > `Function<T, R>` 函数型接口 : 接收参数T类型,返回值是个流
  >
  > 核心方法 : <kbd>Stream<R> apply(T t);</kbd>

# 6. 排序

## ▲ 自然排序 : `sort`

- 根据对象的`compareTo(User o)`方法实现的排序

  ```java
  java.util.stream.Stream.sort()
  ```

## ▲ 定制排序

- 通过定制`Comparator`接口的方法实现排序

  ```java
  java.util.stream.Stream.sorted(Comparator<? super T> comparator)
  ```

# 7. 查询与匹配

## ▲ 判断是否匹配所有`allMatch`

```java
java.util.stream.Stream.allMatch(Predicate<T>)
```

> `Predicate<T>` 断言型接口 : 接收一个参数T类型,并返回Boolean值
>
> 核心方法 : <kbd>boolean test(T t);</kbd>

## ▲ 判断是否有匹配的元素

```java
java.util.stream.Stream.anyMatch(Predicate<T>)
```

## ▲ 判断是否没有匹配所有元素

```java

```

