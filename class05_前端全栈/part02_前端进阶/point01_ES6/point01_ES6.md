# ES6

## 001_变量声明

1. let关键字
   - let声明的变量不能重复声明：var变量可以重复声明
   - let声明的变量是块级作用域：块中var变量外部可以读到
   - let声明的变量不存在声明提升：var变量存在声明提升
   - let变量不影响作用域链
2. const关键字
   - const变量声明时必须赋值
   - const变量声明后不可以更改值（或引用地址），对应常量中的元素更改不会导致常量的引用改变
   - const变量也是块级作用域

## 002_解构赋值

- 解构赋值主要分为对象的解构和数组的解构：在赋值号左边定义变量，赋值号右边是需要给变量赋值的数据结构，解构赋值的的特点是左边的结构和右边的结构相同，并且每个变量都在对应的位置唯一对应右边数据结构中的一组数据；

- 数组的解构赋值

  ```js
  // 基本用法
  let arr = [0,1,2]
  let [a,b,c] = arr
  
  // 根据位置设置默认值
  let arr = [,1,2]
  let [a='我是默认值',b,c] = arr
  ```

- 对象的解构赋值

  ```js
  let {name,age} = {name:"swr",age:28}
  ```

## 003_模板字符串

- 模板字符的定义使用反引号

  ```js
  let str = `模板字符串`;
  ```

- 模板字符串的特点

  - 模板字符串可以表示带换行的字符
  - 模板字符串中使用`${}`作为变量占位符，引入其他变量的值

## 004_对象的简化写法

1. 属性的简化写法：如果属性值和属性名称相同，可以合并

2. 方法的简化写法：可以省略function关键字

   ```js
   let obj = {
       name,
       hello(){
           
       }
   }
   ```

## 005_箭头函数

- 基本格式

  ```js
  let fun = (形参) => {
      // 函数体
  }
  ```

- 箭头函数特点

  - 箭头函数中的this是静态的，this始终指向函数声明时所在作用域下的this值
  - 不能作为构造函数创建对象
  - 不能使用arguments变量
  - 建议箭头函数的使用场景是与this无关的函数调用中

- 箭头函数的简写

  - 如果参数有且只有一个，函数形参的括号可以省略
  - 如果函数体有且只有一句并且是返回语句，函数体的花括号可以省略，return关键字必须省略

## 006_函数参数定义默认值

- 基本格式：主要使用在结构赋值时接收对象或数组类型变量时使用或者普通函数定义中使用参数默认值

  ```js
  let  fun = hello(a,b="默认值"){
      
  }
  ```

## 007_ES6 Rest参数

- Rest 参数接受函数的多余参数，组成一个数组，放在形参的最后

  ```JS
  function func(a, b, ...rest参数名称){
      console.log(rest参数名称)
  }
  ```

- Rest参数和arguments对象的区别：

  - rest参数只包括那些没有给出名称的参数，arguments包含所有参数
  - arguments 对象不是真正的数组，而rest 参数是数组实例，可以直接应用sort, map, forEach, pop等方法
  - arguments 对象拥有一些自己额外的功能

## 008_扩展运算符...

- 对象中的扩展运算符(...)用于取出参数对象中的所有可遍历属性，拷贝到当前对象之中

  ```js
  let bar = { a: 1, b: 2 };
  let baz = { ...bar }; // { a: 1, b: 2 }
  
  let bar = {a: 1, b: 2};
  let baz = {...bar, ...{a:2, b: 4}};  // {a: 2, b: 4}
  ```

## 009_Symbol

迭代器

生成器

Promise

set

map

class

数值扩展

ES6模块化

# ES7

Array.prototype.Includes

指数操作符

# ES8

async 和 await

对象扩展

# ES9

rest参数和spread扩展运算符

扩展运算符对对象的扩展

ES9对正则的扩展命名分组

ES9正则反向断言

dotALL模式

# ES10

Object.formEntries()

Sring.trimStart  String.srimEnd

Array.flat  Array.flatMap

Symbol.prototype.description()

# ES11

私有属性

Promise.allSettled

String.prototype.matchAll()

可选链操作符

动态import()

Bigint

绝对全局属性