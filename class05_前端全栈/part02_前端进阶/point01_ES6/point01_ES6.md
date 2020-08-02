  01.课程介绍.mp4
   02.ES6-ECMAScript相关名词介绍.mp4
   03.ES6-let变量声明以及声明特性.mp4
   04.ES6-let经典案例实践.mp4
   05.ES6-const声明常量以及特点.mp4
   06.ES6-变量的解构赋值.mp4
   07.ES6-模板字符串.mp4
   08.ES6-对象的简化写法.mp4
   09.ES6-箭头函数以及声明特点.mp4
   10.ES6-箭头函数的实践与应用场景.mp4
   11.ES6-函数参数的默认值设置.mp4
   12.ES6-rest参数.mp4
   13.ES6-扩展运算符的介绍.mp4
   14.ES6-扩展运算符的应用.mp4
   15.ES6-Symbol的介绍与创建.mp4
   16.ES6-对象添加Symbol类型的属性.mp4
   17.ES6-Symbol的内置属性.mp4
   18.ES6-迭代器介绍.mp4
   19.ES6-迭代器应用-自定义遍历数据.mp4
   20.ES6-生成器函数声明与调用.mp4
   21.ES6-生成器函数的参数传递.mp4
   22.ES6-生成器函数实例.mp4
   23.ES6-生成器函数实例-2.mp4
   24.ES6-Promise介绍与基本使用.mp4
   25.ES6-Promise封装读取文件.mp4
   26.ES6-Promise封装AJAX请求.mp4
   27.ES6-Promise.prototype..then方法.mp4
   28.ES6-Promise实践练习-多个文件内容读取.mp4
   29.ES6-Promise对象catch方法.mp4
   30.ES6-集合介绍与API.mp4
   31.ES6-集合实践.mp4
   32.ES6-Map的介绍与API.mp4
   33.ES6-class介绍与初体验.mp4
   34.ES6-class静态成员.mp4
   35.ES6-ES5构造函数继承.mp4
   36.ES6-class的类继承.mp4
   37.ES6-子类对父类方法的重写.mp4
   38.ES6-class中getter和setter设置.mp4
   39.ES6-ES6的数值扩展.mp4
   40.ES6-ES6的对象方法扩展.mp4
   41.ES6-模块化介绍、优势以及产品.mp4
   42.ES6-浏览器使用ES6模块化引入模块.mp4
   43.ES6-ES6模块暴露数据语法汇总.mp4
   44.ES6-ES6引入模块数据语法汇总.mp4
   45.ES6-浏览器使用ES6模块化方式二.mp4
   46.ES6-babel对ES6模块化代码转换.mp4
   47.ES6-ES6模块化引入NPM包.mp4

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

49.ES8-async函数.mp4
   50.ES8-await表达式.mp4
   51.ES8-async与await结合读取文件内容.mp4
   52.ES8-async与await结合发送AJAX请求.mp4
   53.ES8-ES8对象方法扩展.mp4

# ES9

54.ES9-ES9扩展运算符与rest参数.mp4
   55.ES9-ES9正则扩展-命名捕获分组.mp4
   56.ES9-ES9正则扩展-反向断言.mp4
   57.ES9-ES9正则扩展-dotAll模式.mp4

# ES10

58.ES10-对象扩展方法Object.fromEntries.mp4
   59.ES10-字符串方法扩展-trimStart-trimEnd.mp4
   60.ES10-数组方法扩展-flat与flatMap.mp4
   61.ES10-Symbol.prototype.description.mp4

# ES11

   62.ES11-私有属性.mp4
   63.ES11-Promise.allSettled方法.mp4
   64.ES11-String.prototype.matchAll方法.mp4
   65.ES11-可选链操作符.mp4
   66.ES11-动态import.mp4
   67.ES11-BigInt类型.mp4
   68.ES11-绝对全局对象globalThis.mp4