

# ES6

## 01、let

- **作用**
  - 声明变量
- **特点**
  - let关键字声明的变量不可以重复声明；（var声明的变量可以重复声明）
  - let关键字声明的变量只在块级作用域，适用于作用域链；（var声明的变量只有函数内作用域和函数外作用域）
  - let关键字声明的变量不会变量提升，使用必须在声明之后；（var声明的变量会声明提升，赋值在后）
- **案例演示**

## 02、const

- **作用**
  - 声明常量
- **特点**
  - 常量在声明后必须赋值；
  - let变量的特殊适用于const常量；
  - const常量声明后不可修改是指不可修改常量的内存引用；
- **案例演示**

## 03、解构赋值

- **作用**

  - 从有组织的数据结构中提取信息片段并赋值给另一组具有相同组织结构的变量中

- **特点**：解构赋值的的特点是左边的结构和右边的结构相同

  - 对象解构：仍由对象接收解构后的值，根据属性的名称批量赋值；
  - 数组解构：仍由数组接收结构后的值，根索引位置批量赋值；

- **案例演示**

  - 对象解构

    ```js
    // 基本用法
    let node = {
        type: "Identifier",
        name: "foo"
    };
    let { type, name } = node;
    
    //如果指定的局部变量名称在对象中不存在，那么这个局部变量会被赋值为undefined
    let node = {
        type: "Identifier",
        name: "foo"
    };
    let { type, name, value } = node;
    
    //  默认值 
    let node = {
        type: "Identifier",
        name: "foo"
    };
    let { type, name, value = true } = node;
    
    // 为非同名局部变量赋值
    let node = {
        type: "Identifier",
        name: "foo"
    };
    let { type: localType, name: localName } = node;
    
    // 嵌套对象解构
    let node = {
      type: "Identifier",
        name: "foo",
      loc: {
            start: {
                line: 1,
                column: 1
          },
        end: {
            line: 1,
            column: 4
        }
    }
    };
    let { loc: { start }} = node;
    ```
  
  - 数组解构
  
    ```js
    // 基本用法
    let colors = [ "red", "green", "blue" ];
    let [ firstColor, secondColor ] = colors;
    
    // 变量交换
    let a = 1,
        b = 2;
    [ a, b ] = [ b, a ];
    
    // 默认值
    let colors = [ "red" ];
    let [ firstColor, secondColor = "green" ] = colors;
    
    // 嵌套数组解构
    let colors = [ "red", [ "green", "lightgreen" ], "blue" ];
    let [ firstColor, [ secondColor ] ] = colors;
    
    // 不定元素
    let colors = [ "red", "green", "blue" ];
    let [ firstColor, ...restColors ] = colors;
    
    
    ```

## 04、模板字符串

- **作用**

  - 模板字面量

- **特点**

  - 模板字符串使用反引号 (``) 来代替普通字符串中的用双引号和单引号;
  - 允许嵌入表达式的字符串字面量：可以包含特定语法（${expression}）的占位符。

- **案例演示**

  - 字符串的格式化表示

    ```js
    
    ```

  - bianl

    ```js
    
    ```

## 05、对象简化写法

- 属性简化格式

  ```js
  let name = "姓名";
  let obj = {
      name,
      name:name
  }
  ```

- 方法简化格式

  ```js
  let obj = {
  	function hello(){
          
      },
      hello(){
          
      }
  }
  ```

## 06、箭头函数

- 箭头函数格式
  1. 没参数的箭头函数
  2. 有一个参数的箭头函数
  3. 有多个参数的箭头函数
  4. 有一句函数体的箭头函数
  5. 有多句函数体的箭头函数
- 箭头函数特点
  - this

## 07、函数形参默认值

## 08、函数形参rest参数



## 09、扩展运算符

- **作用**

  - 将一个数组转为用逗号分隔的参数序列

- 案例演示

  1. 合并数组

     ```js
     var arr1 = ['a', 'b'];  
     var arr2 = ['c'];  
     var arr3 = ['d', 'e'];  
     // ES5 的合并数组  
     arr1.concat(arr2, arr3);  
     // ES6 的合并数组  
     [...arr1, ...arr2, ...arr3]  
     ```

  2. 与解构赋值结合

     ```js
     const [first, ...rest] = [1, 2, 3, 4, 5];
     ```

## 10、Symbol数据类型

- **作用**

  - 是JavaScript一种新的数据类型，表示独一无二的值；

- **定义Symbol类型变量**

  ```js
  // 定义无标识变量
  let s1 = Symble()
  
  // 定义带参数标识变量:在控制台输出时便于区分
  let s2 = Symbol('参数')
  
  // for方法会根据给定的键 `key`，来从运行时的symbol注册表中找到对应的symbol;
  // 如果找到了，则返回它，否则，新建一个与该键关联的 symbol，并放入全局 symbol 注册表中
  let s4 = Symbol.for("中国")
  ```

- Symbol类型的使用

  1. Symbol值作为属性名时不能使用点运算；定义属性时，必须放在方括号内，与普通键值进行区分。

     ```js
     var a = Symbol('a');
     var obj = {
        a: 'normal key',
       [a]: 'symbol key'    
     }
     ```

  2. Symbol值定义的属性属于公开属性，普通方法无法遍历。

     ```js
     Obj.getOwnProperty()   //['a']
     Obj.getOwnPropertySymbols() //[Symbol('a')]
     
     Refelect.ownKeys() // ['a', Symbol('a')]
     ```

  3. 利用Symbol的特性可定义内部私有属性或方法

     ```js
     function getObj (obj) {
        let privateKey = symbol('privateKey')，
            objCopy = ...obj || {};
        objCopy[privateKey] = function privateFunc () {
            console.log('privateFunc ')
        }
        return objCopy;
     }
     
     let newObj = getObj();
     newObj[privateKey]  // 报错，外部无法获取到privateKey的值
     newObj[symbol('privateKey')]  //undefined,此时的symbol已经变成新的symbol值
     ```

  4. Symbol值不能进行隐式转换，因此它与其他类型的值进行运算，会报错。

  5. Symbol值可显示地转换成字符串。

     ```js
     var a = Symbol('a');
     a.toString() // 'Symbol(a)'
     ```

  6. 可以显示或隐式转成Boolen，却不能转成数值。

     ```js
     var a = Symbol('a');
     Boolean(a)  //true
     if (a) { 
        console.log(a);
     }
     ```

## 11、Promise

1. 介绍：是ES6新增的API，主要作用是提供异步编程的解决方案，比如多层异步回调具有依赖关系导致的回调地狱；

2. 异步操作案例：setTimeout函数中的操作的动作是异步执行

   ```js
   console.log("开始执行");
   setTimeout(() => {
       console.log('执行异步操作');
   }, 1000);
   console.log("执行结束");
   ```

3. Promise基本使用

   ```js
   let p = new Promise((resolve,reject)=>{
       setTimeout(() => {
           resolve();
       }, 1000);
   });
   p.then(()=>{
       console.log("promise resolve");
   }).catch(()=>{
       console.log("promise reject");
   })
   ```

   - Promise是一个类，new这个类是时候需要指定构造参数，Promise构造参数是一个函数，在初始化完成后立即回调构造的函数；
   - 回调构造函数时候会传递两个参数：第一个参数resolve函数，第二个参数reject函数；
   - 在回调构造函数中如果执行了resolve函数，则会调用Promise对象的then方法，作用是在Promise中封装了异步操作，异步操作完成后调用resolve方法，执行then方法，将异步操作的请求与处理分离；then方法也可以接受两个函数，第二个函数表示reject的回调；
   - 在回调构造函数中如果执行了reject函数，则会调用Promise对象的cache方法，作用是处理异常信心；

4. Promise是API说明

  - Promise三种状态：
  
    - pending：等待状态，表示正在执行异步操作
    - fullfile：满足状态，表示主动回调了resolve，并且会回调then方法
    - reject：拒绝状态，表示主动回调了reject，并且会回调cache方法
  
  - Promise链式调用：在resolve中返回一个新的Promise对象
  
  - Promise的all方法：如果一个操作依赖多个异步的结果，可以将多个异步封装在一起，并获取所有的结果
  
    ```js
    let p1 = new Promise((resolve,reject)=>{
        resolve("结果1");
    })
    let p2 = new Promise((resolve,reject)=>{
        resolve("结果2");
    })
    Promise.all([p1,p2]).then(res=>{
        console.log(res[0]);
        console.log(res[1]);
    })
    ```
  
    