# 目录

[TOC]

# 第一章 泛型概述

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;泛型，即“参数化类型”。一提到参数，最熟悉的就是定义方法时有形参，然后调用此方法时传递实参。那么参数化类型怎么理解呢？顾名思义，就是将类型由原来的具体的类型参数化，类似于方法中的变量参数，此时类型也定义成参数形式（可以称之为类型形参），然后在使用/调用时传入具体的类型（类型实参）。

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;泛型的本质是为了参数化类型（在不创建新的类型的情况下，通过泛型指定的不同类型来控制形参具体限制的类型）。也就是说在泛型使用过程中，操作的数据类型被指定为一个参数，这种参数类型可以用在类、接口和方法中，分别被称为泛型类、泛型接口、泛型方法。

# 第二章 泛型的使用

## 2.1 泛型类 

1. **定义泛型类**：在类上定义泛型标识，则当前类可以用该标识作为一个类型使用

   ```java
   // 可以随便写任意标识号，标识指定的泛型的类型
   class 类名称 <泛型标识>{
     private 泛型标识 /*（成员变量类型）*/ var; 
     .....
   }
   ```

2. **泛型类相关说明**

   - 在实例化泛型类时，必须指定泛型标识的具体类型：泛型是形参，调用时用到泛型必须传递实参
   - 泛型标识可以用在属性类型上、方法返回值、参数类型等等
   - 泛型的泛型是继承自父类：泛型类标识必须和父类标识相同
   - 泛型类的泛型是实现父类泛型：泛型标识必须是具体类型
   - 泛型类中的静态方法不能使用泛型类上的泛型标识

## 2.2 泛型接口 

- 泛型接口与泛型类的定义及使用基本相同

## 2.3 泛型通配符 

## 2.4 泛型方法

1. 定义泛型方法：修饰符 与 返回值中间`<泛型标识>`非常重要，可以理解为声明此方法为泛型方法

   ```java
   修饰符 <泛型标识> 返回值 方法名称(形参列表){
       
   }
   ```

2. 泛型方法说明

   - 定义了泛型标识的方法：泛型标识可以在方法内使用该泛型标识
   - 在调用泛型方法时必须制定泛型的真实类型
   - 泛型类上的泛型标识和泛型方法上的泛型标识是独立的类型，可以混合使用，但是要区分类型标识
   - 无论何时，如果你能做到，你就该尽量使用泛型方法。也就是说，如果使用泛型方法将整个类泛型化
   - static的方法无法访问泛型类的参数，所以如果static方法要使用泛型能力，就必须使其成为泛型方法。


## 2.5 泛型上下边界

1. extends：指定泛型的上边界，即泛型必须是继承自改类
2. supper：指定泛型的下边界，即泛型的真实必须是该类型的子类

## 2.6 泛型数组

## 2.7 泛型擦除