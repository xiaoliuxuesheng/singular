# **F**第一部分 EcmaScript

## 第一章 JavaScript入门

### 1.1 JavaScript介绍

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;1995 年 2 月，Netscape 公司发布 Netscape Navigator 2 浏览器，并在这个浏览器中免费提供了一个开发工具：**LiveScript**。这是最初的 JavaScript 1.0 版本。

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;由于 JavaScript 1.0 很受欢迎，微软在 Internet Explorer 3 中也加入了脚本编程功能。将其命名为 JScript。1997 年，欧洲计算机制造商协会（ECMA）以 JavaScript 1.1 为基础制订了脚本语言标准——ECMA-262，并命名为 ECMAScript，至此ECMAScript成为JavaScript语法标准；

### 1.2 ECMAScript的发展

| 发展年份      | 版本说明                                                     |
| ------------- | ------------------------------------------------------------ |
| 1997 年       | ECMA 发布 262 号标准文件（ECMA-262）的第一版也就是 ECMAScript 1.0 版 |
| 1998 年 6 月  | ECMAScript 2.0 版发布                                        |
| 1999 年 12 月 | ECMAScript 3.0 版发布，并成为 JavaScript 的通用标准，获得广泛支持 |
| 2007 年 10 月 | ECMAScript 4.0 版草案发布，由于 4.0 版的目标过于激进，各方产生严重分歧 |
| 2008 年 7月   | 中止 ECMAScript 4.0 的开发，发布为 ECMAScript 3.1后来改名改名为 ECMAScript 5 |
| 2009 年 12 月 | ECMAScript 5.0 版正式发布                                    |
| 2011 年 6 月  | ECMAScript 5.1 版发布，并且成为 ISO 国际标准                 |
| 2013 年 12 月 | ECMAScript 6 版草案发布                                      |
| 2015 年 6 月  | ECMAScript 6 发布正式版本，并更名为 ECMAScript 2015          |
| 从此以后      | JavaScript 开始以年份命名，新版本将按照 “ECMAScript+年份” 的形式发布 |

### 1.3 JavaScript 构成

- **核心（ECMAScript）**：语言核心部分。
- **文档对象模型（Document Object Model，DOM）**：网页文档操作标准。
- **浏览器对象模型（BOM）**：客户端和浏览器窗口操作基础。

### 1.4 JavaScript特点

1. **脚本语言**：JavaScript是一种解释型的脚本语言
2. **基于对象**：JavaScript是一种基于对象的脚本语言,它不仅可以创建对象,也能使用现有的对象。
3. **简单**：JavaScript语言中采用的是弱类型的变量类型，对使用的数据类型未做出严格的要求，是基于Java基本语句和控制的脚本语言，其设计简单紧凑。
4. **动态性**：JavaScript是一种采用事件驱动的脚本语言,它不需要经过Web服务器就可以对用户的输入做出响应。
5. **跨平台性**：JavaScript脚本语言不依赖于操作系统,仅需要浏览器的支持。因此一个JavaScript脚本在编写后可以带到任意机器上使用,前提上机器上的浏览器支 持JavaScript脚本语言,JavaScript已被大多数的浏览器所支持。
6. 不需要服务器的支持。所以在早期程序员比较青睐于JavaScript以减少对服务器的负担，而与此同时也带来另一个问题：安全性。
7. 而随着服务器的强壮，虽然程序员更喜欢运行于服务端的脚本以保证安全，但JavaScript仍然以其跨平台、容易上手等优势大行其道。同时，有些特殊功能（如AJAX）必须依赖Javascript在客户端进行支持。

### 1.5 编写第一个程序

1. 在html标签中定义JavaScript代码

   ```html
   1. 在事件中使用JavaScript代码
   <button onclick="alter(1);">按钮</button>
   
   2. 在超链接中定义JavaScript代码
   <a href="javascript:alter(1);">超链接</a>
   ```
   
2. 在HTML页面中嵌入JavaScript脚本：在 HTML 页面中嵌入 JavaScript 脚本需要使用 `<script> `标签，用户可以在` <script> `标签中直接编写 JavaScript 代码

   ```html
   <!DOCTYPE html>
   <html>
   <head>
       <meta charset="UTF-8">
       <title>第一个JavaScript程序</title>
       <script type="text/javascript">
           document.write("<h1>Hi,JavaScript!</h1>");
       </script>
   </head>
   <body>
   </body>
   </html>
   ```

3. 在HTML页面中引入外部的JavaScript脚本文件

   - 定义JavaScript脚本文件：xxx.js

     ```js
     document.write("<h1>Hi,JavaScript!</h1>");
     ```

   - 在HTML页面中引入外部的xxx.js文件

     ```html
     <!DOCTYPE html>
     <html>
     <head>
         <meta charset="UTF-8">
         <title>第一个JavaScript程序</title>
         <script type="text/javascript" src="xxx.js"></script>
     </head>
     <body>
     </body>
     </html>
     ```

### 1.6 `<script>`标签说明

- 浏览器在解析 HTML 文档时，将根据文档流从上到下逐行解析和显示。JavaScript 代码也是 HTML 文档的组成部分，因此 JavaScript 脚本的执行顺序也是根据 `<script> `标签的位置来确定的。
-   在文档的 `<head>` 标签中包含 JavaScript 脚本，或者导入的 JavaScript 文件。这意味着必须等到全部 JavaScript 代码都被加载、解析和执行完以后，才能继续解析后面的 HTML 部分。如果加载的 JavaScript 文件很大， HTML 文档解析就容易出现延迟。为了避免这个问题，在开发 Web 应用程序时，建议把导入 JavaScript 文件的操作放在 `<body>` 后面，让浏览器先 将网页内容解析并呈现出来后，再去加载 JavaScript 文件，以便加快网页响应速度。  
- 异步加载JavaScript文件：可以为 <script> 标签设置 async 属性，让浏览器异步加载 JavaScript 文件，即在加载 JavaScript 文件时，浏览器不会暂停，而是继续解析。这样能节省时间，提升响应速度
- **代码块**：就是使用`<script>`标签包含的 JavaScript 代码段，JavaScript 是按块执行的，但是不同块都属于同一个作用域（全局作用域）

## 第二章 JavaScript基础

### 2.1 JavaScript语法基础

1. 注释
   - 单行注释
   - 多行注释

2. JavaScript语句使用分号结尾：建议使用分号结尾，良好的编码规范；
3. JavaScript严格区分大小写；

4. JavaScript代码中会忽略空格和换行

### 2.2 JavaScript标识符/关键字/保留字

1. **标识符**：就是名称的专业术语。JavaScript 标识符包括变量名、函数名、参数名和属性名

   - 第一个字符必须是字母、下划线（_）或美元符号（$）。
   - 除了第一个字符外，其他位置可以使用 Unicode 字符。一般建议仅使用 ASCII 编码的字母，不建议使用双字节的字符。
   - 不能与 JavaScript 关键字、保留字重名。
   - 可以使用 Unicode 转义序列。例如，字符 a 可以使用“\u0061”表示。

2. **关键字**：是 ECMA-262 规定的 JavaScript 语言内部使用的一组名称（或称为命令）。这些名称具有特定的用途，用户不能自定义同名的标识符

   | break                             | delete       | if             | this       | while    |
   | --------------------------------- | ------------ | -------------- | ---------- | -------- |
   | **case**                          | **do**       | **in**         | **throw**  | **with** |
   | **catch**                         | **else**     | **instanceof** | **try**    |          |
   | **continue**                      | **finally**  | **new**        | **typeof** |          |
   | **debugger（ECMAScript 5 新增）** | **for**      | **return**     | **var**    |          |
   | **default**                       | **function** | **switch**     | **void**   |          |

3. **保留字**：是 ECMA-262 规定的 JavaScript 语言内部预备使用的一组名称（或称为命令）。这些名称目前还没有具体的用途，是为 JavaScript 升级版本预留备用的，建议用户不要使用

   - ECMAScript 保留字

     | abstract    | double      | goto           | native        | static           |
     | ----------- | ----------- | -------------- | ------------- | ---------------- |
     | **boolean** | **enum**    | **implements** | **package**   | **super**        |
     | **byte**    | **export**  | **import**     | **private**   | **synchronized** |
     | **char**    | **extends** | **int**        | **protected** | **throws**       |
     | **class**   | **final**   | **interface**  | **public**    | **transient**    |
     | **const**   | **float**   | **long**       | **short**     | **volatile**     |

   - ECMAScript 3 将 Java 所有关键字都列为保留字，JavaScript 预定义全局变量和函数

     | arguments              | encodeURL              | Infinity     | Number             | RegExp          |
     | ---------------------- | ---------------------- | ------------ | ------------------ | --------------- |
     | **Array**              | **encodeURLComponent** | **isFinite** | **Object**         | **String**      |
     | **Boolean**            | **Error**              | **isNaN**    | **parseFloat**     | **SyntaxError** |
     | **Date**               | **eval**               | **JSON**     | **parseInt**       | **TypeError**   |
     | **decodeURL**          | **EvalError**          | **Math**     | **RangeError**     | **undefined**   |
     | **decodeURLComponent** | **Function**           | **NaN**      | **ReferenceError** | **URLError**    |

### 2.2 变量和变量

1. 字面量：指值不可以变的

2. 变量

   - **变量的声明**

     ```js
     var 变量名;
     let 变量名;
     const 变量名;
     ```

     - **var**：var命令会发生“变量提升”现象，即变量可以在声明之前使用，值为`undefined`；
     - **let**：①let所声明的变量只在let命令所在的代码块内有效；②let命令不存在变量提升；③let声明变量存在暂时性死区（即变量会绑定某个区域，不受外部影响）
     - **const**：①声明一个只读的常量；②一旦声明，常量的值就不能改变，一旦声明变量，就必须立即初始化，不能留到以后赋值；③`const`的作用域与`let`命令相同：只在声明所在的块级作用域内有效。

   - **变量的赋值**：值可以是字面量或者是其他变量

     ```js
     变量名 = 值;
     ```

   - **变量的声明并赋值**：值可以是字面量或者是其他变量

     ```js
     var 变量 = 值;
     ```

### 2.3 JavaScript中数据类型

| 数据类型  |               说明               |
| :-------: | :------------------------------: |
|   null    |         空值，表示非对象         |
| undefined | 未定义的值，表示未赋值的初始化值 |
|  number   |        数字，数学运算的值        |
|  string   |        字符串，表示信息流        |
|  boolean  |       布尔值，逻辑运算的值       |
|  object   |    对象，表示复合结构的数据集    |

<font size=4 color='blue'>1. 基本数据类型</font>：被定义在栈中，栈属于key：value结构的，基本数据的类型的在栈中key是变量名，value是变量的值

- null
- undefined
- number
- string
- boolean

<font size=4 color='blue'>2. 引用数据类型</font>：引用数据类型中是被定义在堆空间中，引用数据类型的变量名是定义在栈中的，栈中的key存储引用数据类型的名称，栈中value保存的引用数据类型的内存地址，所有被称为应用数据类型；

- object

### 2.4 JavaScript运算符

#### <font size=4 color='blue'>1. 算数运算符</font>

| 运算符 | 描述                                                      |
| :----- | :-------------------------------------------------------- |
| +      | 加法                                                      |
| -      | 减法                                                      |
| *      | 乘法                                                      |
| **     | 幂（[ES2016](https://www.w3school.com.cn/js/js_es6.asp)） |
| /      | 除法                                                      |
| %      | 系数                                                      |
| ++     | 递增                                                      |
| --     | 递减                                                      |

#### <font size=4 color='blue'>2. 赋值运算符</font>

| 运算符 | 例子     | 等同于      |
| :----- | :------- | :---------- |
| =      | x = y    | x = y       |
| +=     | x += y   | x = x + y   |
| -=     | x -= y   | x = x - y   |
| *=     | x *= y   | x = x * y   |
| /=     | x /= y   | x = x / y   |
| %=     | x %= y   | x = x % y   |
| <<=    | x <<= y  | x = x << y  |
| >>=    | x >>= y  | x = x >> y  |
| >>>=   | x >>>= y | x = x >>> y |
| &=     | x &= y   | x = x & y   |
| ^=     | x ^= y   | x = x ^ y   |
| \|=    | x \|= y  | x = x \| y  |
| **=    | x **= y  | x = x ** y  |

#### <font size=4 color='blue'>3. 比较运算符</font>

| 运算符 | 描述           |
| :----- | :------------- |
| ==     | 等于           |
| ===    | 等值等型       |
| !=     | 不相等         |
| !==    | 不等值或不等型 |
| >      | 大于           |
| <      | 小于           |
| >=     | 大于或等于     |
| <=     | 小于或等于     |
| ?      | 三元运算符     |

#### <font size=4 color='blue'>4. 逻辑运算符</font>

| 运算符 | 描述   |
| :----- | :----- |
| &&     | 逻辑与 |
| \|\|   | 逻辑或 |
| !      | 逻辑非 |

#### <font size=4 color='blue'>5. 类型运算符</font>

| 运算符     | 描述                                |
| :--------- | :---------------------------------- |
| typeof     | 返回变量的类型。                    |
| instanceof | 返回 true，如果对象是对象类型的实例 |

#### <font size=4 color='blue'>6.位运算符</font>

| 运算符 | 描述         | 例子    | 等同于       | 结果 | 十进制 |
| :----- | :----------- | :------ | :----------- | :--- | :----- |
| &      | 与           | 5 & 1   | 0101 & 0001  | 0001 | 1      |
| \|     | 或           | 5 \| 1  | 0101 \| 0001 | 0101 | 5      |
| ~      | 非           | ~ 5     | ~0101        | 1010 | 10     |
| ^      | 异或         | 5 ^ 1   | 0101 ^ 0001  | 0100 | 4      |
| <<     | 零填充左位移 | 5 << 1  | 0101 << 1    | 1010 | 10     |
| >>     | 有符号右位移 | 5 >> 1  | 0101 >> 1    | 0010 | 2      |
| >>>    | 零填充右位移 | 5 >>> 1 | 0101 >>> 1   | 0010 | 2      |

#### <font size=4 color='blue'>7. 运算符优先级</font>

| 运算符                             | 描述                                         |
| ---------------------------------- | -------------------------------------------- |
| . [] ()                            | 字段访问、数组下标、函数调用以及表达式分组   |
| ++ -- - ~ ! delete new typeof void | 一元运算符、返回数据类型、对象创建、未定义值 |
| * / %                              | 乘法、除法、取模                             |
| + - +                              | 加法、减法、字符串连接                       |
| << >> >>>                          | 移位                                         |
| < <= > >= instanceof               | 小于、小于等于、大于、大于等于、instanceof   |
| == != === !==                      | 等于、不等于、严格相等、非严格相等           |
| &                                  | 按位与                                       |
| ^                                  | 按位异或                                     |
| \|                                 | 按位或                                       |
| &&                                 | 逻辑与                                       |
| \|\|                               | 逻辑或                                       |
| ?:                                 | 条件                                         |
| = oP=                              | 赋值、运算赋值                               |
| ,                                  | 多重求值                                     |

### 2.5 JavaScript流程控制

#### <font size=4 color='blue'>1. 顺序结构</font>

- 声明语句：变量声明、标签声明
- 表达式语句：变量赋值语句、函数调用语句、属性赋值语句、方法调用语句

#### <font size=4 color='blue'>2. 分支结构</font>

- **if (条件表达式) 语句**

  ```js
  if (laber< 50) {
  
  }
  ```

- **if (条件表达式) {语句;} else {语句;}**

  ```js
  if (laber > 50) {
      //条件为true，执行这个代码块
  } else {
      //条件为false，执行这个代码块
  } 
  ```

- **if (条件表达式) {语句;} else if (条件表达式) {语句;} ... else {语句;}**

  ```js
  var laber = 100;
  if (laber >= 100) {                        //如果满足条件，不会执行下面任何分支
      alert('甲');
  } else if (laber>= 90) {
      alert('乙');
  } else if (laber >= 80) {
      alert('丙');
  } else if (laber >= 70) {
      alert('丁');
  } else if (laber >= 60) {
      alert('及格');
  } else {                                //如果以上都不满足，则输出不及格
      alert('不及格');
  }
  ```

- **switch...case**：语句是多重条件判断，用于多个值相等的比较

  ```js
  var laber = 1;
  switch ( laber) {                            //用于判断box相等的多个值
      case 1 :
          alert('one');
          break;                        		//break;用于防止语句的穿透
      case 2 : 
          alert('two');
          break;
      case 3 : 
          alert('three');
          break;
  
      default :                            	//相当于if语句里的else，否则的意思
          alert('error');
  }
  ```

#### <font size=4 color='blue'>3. 循环结构</font>

- **for**：是一种先判断，后运行的循环语句。但它具有在执行循环之前初始变量和定义循环后要执行代码的能力。

  ```js
  // 第一步，声明变量var laber = 1;
  // 第二步，判断laber <= 5
  // 第三步，alert(laber )
  // 第四步，laber ++
  // 第五步，从第二步再来，直到判断为false
  for (var laber = 1; laber <= 5 ; laber ++) {        
      alert(laber );                                  
  }                                         
  ```

- **for...in**：是一种精准的迭代语句，可以用来枚举对象的属性。

  ```js
  var laber = {                            	//创建一个对象
      'name' : 'moxiaobo',                    //键值对，左边是属性名，右边是值
      'age' : 28,
      'height' : 178
  };
  for (var p in laber) {                     	//列举出对象的所有属性
      alert(p);
  }
  ```

- **while**：是一种先判断，后运行的循环语句。也就是说，必须满足条件了之后，方可运行循环体。

  ```js
  var laber = 1;        
  // 先判断，再执行
  while (laber <= 5) {                        
      alert(laber);
      laber++;
  }
  ```

- **do...while**：是一种先运行，后判断的循环语句。也就是说，不管条件是否满足，至少先运行一次循环体。

  ```js
  var laber = 1;
  
  // 先运行一次，再判断
  do {
      alert(laber);
      laber++;
  } while (laber<= 5);                        
  ```

#### <font size=4 color='blue'>4. 流程控制</font>

- **return**：终止当前流程的执行，无论是分支结构还是循环结构或顺序结构；

- **break**：用于在循环中精确地控制代码的执行。break语句会立即退出循环，强制继续执行循环体后面的语句

  ```js
  for (var laber = 1; laber <= 10; laber++) {
      //如果laber 是5，就退出循环
      if (laber == 5) break;                        
      document.write(laber );
      document.write('<br />');
  }
  ```

- **continue**：用于在循环中精确地控制代码的执行。continue语句退出当前循环，继续后面的循环。

  ```js
  for (var laber = 1; laber <= 10; laber++) {
      // 如果laber 是5，就退出当前循环
      if (laber == 5) continue;                    
      document.write(laber );
      document.write('<br />');
  }
  ```

- **throw**：

  - **ECMA-262 规范了 7 种错误类型，具体说明如下。其中 Error 是基类，其他 6 种错误类型是子类，都继承 Error 基类**。

    - Error：普通异常。主要用途是自定义错误对象。属性 name 可以读写异常类型，message 属性可以读写详细错误信息。
    - EvalError：不正确的使用 eval() 方法时抛出。
    - SyntaxError：出现语法错误时抛出。
    - RangeError：数字超出合法范围时抛出、
    - ReferenceError：读取不存在的变量时抛出。
    - TypeError：值得类型发生错误时抛出。
    - URIError：URI 编码和解码错误时抛出。

  - **throw**：能够主动抛出异常

    ```js
    throw new 异常类();
    ```

#### <font size=4 color='blue'>5. 异常结构</font>

- **try {} catch () {}** 

  ```js
  try{
  	var age=5;
  }catch(e){
      throw new Error("年龄太小啦")
  }
  ```

- **try {} catch () {} finally {}**

  ```js
  try{
  	var age=5;
  }catch(e){//e是异常的封装对象
  	document.write("出错："+e.message);
  }finally{
  	document.write("总会执行的finally块");
  }
  ```

#### <font size=4 color='blue'>6. 其他</font>

- 空语句

- **with**：作用是将代码的作用域设置到一个特定的对象中。

  ```js
  var laber = {                                	//创建一个对象
      'name' : 'moxiaobo', 
      'age' : 28,
      'height' : 178
  };
  
  var n = laber.name;                            //从对象里取值赋给变量
  var a = laber.age;
  var h = laber.height;
  
  
  with (laber) {                                //可以将上面的三段赋值操作改写成with语句：省略了laber对象名
      var n = name;
      var a = age;
      var h = height;
  }
  ```

## 第三章 JavaScript函数

### 3.1 函数概念

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;函数是由事件驱动的或者当它被调用时执行的可重复使用的具有特定功能的代码块；JavaScript函数是属于Function类型的一种对象；

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;函数是分类：①普通函数②构造函数③匿名函数

### 3.2 函数定义

<font size=4 color=blue>1. 普通函数</font>：定义函数关键字`function`

- **Function对象**，函数体是一段字符串格式的JavaScript脚本

  ```js
  let 函数名 = new Function("函数体");
  ```

- **声明式函数**：使用var关键字定义的函数，函是声明会提前，函数的定义根据函数为的位置顺序执行

  ```js
  let 函数名 = function([形参列表]){
      // 函数体
  }
  ```

- **函数表达式**：函数的定义在索引的代码之前被创建

  ```js
  function 函数名([形参列表]){
      // 函数体
  }
  ```

<font size=4 color=blue>2. 构造函数</font>：使用new关键字调用的函数称为构造函数；构造函数是一种特殊的函数，约定构造函数的函数名使用首字母大写

- 定义构造函数：构造函数和普通函数相同，如果不用new关键字，其本身就是一个函数

  ```js
  function 首字母大写(){
  	// 函数体
  }
  ```

- 构造函数的使用

  ```js
  let 构造实例 = new 构造函数名();
  ```

<font size=4 color=blue>3. 匿名函数</font>：没有名称的函数称为匿名函数，匿名函数没有名称所有无法手动调用，必须在编译器加载JavaScript脚本时候执行一次，加载完成便不会再执行

- 匿名函数的定义：定义普通函数一样，匿名函数不给指定函数名称

  ```js
  function(){
      // 函数体
  }
  ```

- 由于匿名函数不符合JavaScript语法规范，JavaScript执行器会不识别这段代码，需要使用括号标注这段代码是一个整体

  ```js
  (function(){
      // 函数体
  })
  ```

- 匿名函数只是声明如果不调用是不会执行的，所以匿名函数在声明后必须调用，否则这段代码会是无效代码，匿名函数的调用也称为自调用函数；

  ```js
  (function([形参列表]){
      // 函数体
  })([实参列表])
  ```

### 3.3 函数调用

- 函数调用：使用函数名并传递实际参数，参数要用圆括号之内，不能省略，如果省略则属于函数对象引用

  ```js
  函数名([实际参数]);
  ```

### 3.4 函数参数

<font size=4 color=blue>1. 形式参数</font>：是在定义函数时候设置的参数，形式参数作为函数体的一部分，但是参数值的实际值由函数调用的实际参数决定；

<font size=4 color=blue>2. 实际参数</font>：调用函数时候传递的参数称为实际参数，

- 实际参数可以是任意数据类型；
- 实际参数根据参数位置对应着形式参数，多余的实际参数不会被处理，多余的形式参数值是undefined；
- 实际参数是基本数据类型：是将数据的值传递给形式参数；
- 实际参数是引用数据类型：是将数据的地址引用传递给实际参数；

### 3.5 函数返回值

- **关键字return**：return语句将终止当前函数并返回当前函数的值；return后面可以跟一个value，可以是javascript中的任何数据类型，数字，字符串，对象等，也可是再返回一个函数

### 3.6 全局作用域和局部作用域

- **全局作用域**：定义在`<script>`标签内的变量并且在function的函数体以外的变量都属于全局作用域，全局作用域的变量属于window对象的属性
- **局部作用域**：定义在function的函数体内部的变量作用范围再函数内有效，属于局部作用域；

### 3.7 闭包



## 第四章 JavaScript面向对象

### 4.1 对象数据类型

1. **对象的基本介绍**
   - 对象的数据类型是Object，Object是JavaScript中所有对象的基类
   - 在JavaScript中除了5中基本数据类型之外都属于对象，属于引用数据类型
   - 对象是一种复合结构的数据类型：可以包含多个基本数据类型或其他引用类型对象
2. **对象的分类**
   - 内置对象：是EcmaScript内置的JavaScript对象
   - 宿主对象：是由JavaScript代码运行环境提供的对象
   - 自定义对象：通过自定义构造函数创建的对象

3. **对象的相关概念**
   - 类型
   - 实例
   - 属性
   - 方法
   - 原型

### 4.2 创建对象

<font size=4 color=blue>1. 创建Object对象</font>：创建Object对象，通过对创建的对象的属性扩展完成对象的自定义

<font size=4 color=blue>2. 构造函数创建对象</font>：通过构造函数创建的对象是同一类型的对象，在面向对象对象的概念中，创建同一种类型的对象的构造函数称为类，由类new出来的对象称为改类的实例对象

<font size=4 color=blue>3. 对象字面量创建对象</font>：`{}` - 一对花括号称为对象字面量

### 4.3 对象的操作

- 新增属性
- 删除属性
- 修改属性
- 查找属性
- 判断属性
- 遍历属性

### 4.4 this

- this指向的是一个对象：这个对象被称为函数执行的上下文对象，根据调用者的不同，this会指向当前调用对象的应用；

### 4.5 原型

1. 构造函数的执行流程

   - 调用函数构造器在堆空间创建出一个对象
   - 将新建的对象的引用赋值给this关键字
   - 顺序执行函数体中的代码，初始化对象相关属性（每次构造函数都会在函数内部完成全部的构建）
   - 将new出的对象作为返回值返回

2. 原型的详解：prototype

   - 每创建一个函数对象，解析器都会为这个函数添加一个prototype对象被称为原型对象
   - 如果函数是普通函数，prototype也是函数本身；
   - 如果使用函数构造器，创建的实例对象也有prototype属性并指向和构造器同一个prototype
   - 给prototype对象扩展属性，则该类创建的实例对象都会包含这些属性
   - 访问对象属性，如果实例对象没有则会在原型对象中查找，原型对象没有则会去父类的原型对象中查找，知道Object的对象中

3. 属性判断（只判断当前对象不包括原型对象中的属性）

   ```js
   实例对象.hasOwnProperty();
   ```

### 4.6 toString()

- 对象的toString()方法默认的调用Object原型对象中的方法
- 通过对类原型对象重新定义toString()方法，根据原型链调用规则，会使用自定义的toString()方法

## 第五章 JavaScript内置对象API

| 值属性                   | 全局属性返回一个简单值，这些值没有自己的属性和方法   |
| ------------------------ | ---------------------------------------------------- |
| Infinity                 |                                                      |
| NaN                      |                                                      |
| undefined                |                                                      |
| globalThis               |                                                      |
| **函数属性**             | **全局函数可以直接调用，不需要在调用时指定所属对象** |
| eval()                   |                                                      |
| uneval()                 |                                                      |
| isFinite()               |                                                      |
| isNaN()                  |                                                      |
| parseFloat()             |                                                      |
| parseInt()               |                                                      |
| decodeURI()              |                                                      |
| decodeURIComponent()     |                                                      |
| encodeURI()              |                                                      |
| encodeURIComponent()     |                                                      |
| **基本对象**             |                                                      |
| Object                   |                                                      |
| Function                 |                                                      |
| Boolean                  |                                                      |
| Symbol                   |                                                      |
| **错误对象**             |                                                      |
| Error                    |                                                      |
| AggregateError           |                                                      |
| EvalError                |                                                      |
| InternalError            |                                                      |
| RangeError               |                                                      |
| ReferenceError           |                                                      |
| SyntaxError              |                                                      |
| TypeError                |                                                      |
| URIError                 |                                                      |
| **数字和日期对象**       |                                                      |
| Number                   |                                                      |
| BigInt                   |                                                      |
| Math                     |                                                      |
| Date                     |                                                      |
| **字符串**               |                                                      |
| String                   |                                                      |
| RegExp                   |                                                      |
| **可索引的集合对象**     |                                                      |
| Array                    |                                                      |
| Int8Array                |                                                      |
| Uint8Array               |                                                      |
| Uint8ClampedArray        |                                                      |
| Int16Array               |                                                      |
| Uint16Array              |                                                      |
| Int32Array               |                                                      |
| Uint32Array              |                                                      |
| Float32Array             |                                                      |
| Float64Array             |                                                      |
| BigInt64Array            |                                                      |
| BigUint64Array           |                                                      |
| **使用键的集合对象**     |                                                      |
| Map                      |                                                      |
| Set                      |                                                      |
| WeakMap                  |                                                      |
| WeakSet                  |                                                      |
| **结构化数据**           |                                                      |
| ArrayBuffer              |                                                      |
| SharedArrayBuffer        |                                                      |
| Atomics                  |                                                      |
| DataView                 |                                                      |
| JSON                     |                                                      |
| **控制抽象对象**         |                                                      |
| Promise                  |                                                      |
| Generator                |                                                      |
| GeneratorFunction        |                                                      |
| AsyncFunction            |                                                      |
| **反射**                 |                                                      |
| Reflect                  |                                                      |
| Proxy                    |                                                      |
| **国际化**               |                                                      |
| Intl                     |                                                      |
| Intl.Collator            |                                                      |
| Intl.DateTimeFormat      |                                                      |
| Intl.ListFormat          |                                                      |
| Intl.NumberFormat        |                                                      |
| Intl.PluralRules         |                                                      |
| Intl.RelativeTimeFormat  |                                                      |
| Intl.Locale              |                                                      |
| **WebAssembly**          |                                                      |
| WebAssembly              |                                                      |
| WebAssembly.Module       |                                                      |
| WebAssembly.Instance     |                                                      |
| WebAssembly.Memory       |                                                      |
| WebAssembly.Table        |                                                      |
| WebAssembly.CompileError |                                                      |
| WebAssembly.LinkError    |                                                      |
| WebAssembly.RuntimeError |                                                      |
| **其他**                 |                                                      |
| arguments                |                                                      |

### 5.1 String对象

### 5.2 Number对象

### 5.3 Date对象 

### 5.3 Boolean对象

### 5.4 Array对象

### 5.5 Map

### 5.6 Math对象

### 5.7 Object对象

### 5.8 RegExp对象

### 5.9 Global对象

### 5.10 Function对象

# 第二部分 DOM

## 第一章 DOM Document

## 第二章 DOM Element

## 第三章 DOM Attribute

## 第四章 DOM Event 

# 第三部分 BOM

## 第一章 Window

### 1.1 Window 对象

- 所有浏览器都支持 window对象。它代表浏览器的窗口。

- 所有全局 JavaScript 对象，函数和变量自动成为 window 对象的成员。

- 全局变量是 window 对象的属性。

- 全局函数是 window 对象的方法。

- 甚至（HTML DOM 的）document 对象也是 window 对象属性：

  ```js
  window.document.getElementById("header");
  // 等价于
  document.getElementById("header");
  ```

### 1.2 Window对象相关API

1. **窗口尺寸**：Window对象有两个属性用于确定窗口尺寸，这个尺寸不包含工具栏和滚动条

   - 非IE浏览器的尺寸属性

     ```js
     window.innerHeight
     window.innerWidth
     ```

   - IE6/7/8浏览器的尺寸属性

     ```js
     document.documentElement.clientHeight
     document.documentElement.clientWidth
     
     // 或者
     
     document.body.clientHeight
     document.body.clientWidth
     ```

2. **获取窗口尺寸浏览器兼容解决方案**

   ```js
   var w = window.innerWidth
   || document.documentElement.clientWidth
   || document.body.clientWidth;
   
   var h = window.innerHeight
   || document.documentElement.clientHeight
   || document.body.clientHeight; 
   ```

## 第二章 Navigator

- 包含有关访问者的信息
- **navigator 数据可被浏览器使用者更改**
- **一些浏览器对测试站点会识别错误**
- **浏览器无法报告晚于浏览器发布的新操作系统**

## 第三章 Screen

### 3.1 Screen对象

- window.screen 对象包含有关用户屏幕的信息

### 3.2 Screen相关API

| API                | 描述                                                         |
| ------------------ | ------------------------------------------------------------ |
| screen.width       | 返回以像素计的访问者屏幕宽度                                 |
| screen.height      | 返回以像素计的访问者屏幕高度                                 |
| screen.availWidth  | 返回访问者屏幕的宽度，以像素计，减去诸如窗口工具条之类的界面特征 |
| screen.availHeight | 返回访问者屏幕的高度，以像素计，减去诸如窗口工具条之类的界面特征 |
| screen.colorDepth  | 返回用于显示一种颜色的比特数                                 |
| screen.pixelDepth  | 返回屏幕的像素深度                                           |

## 第四章 Location

| History对象属性      | 描述                                     |
| -------------------- | ---------------------------------------- |
| location.href        | 返回当前页面的 URL                       |
| location.protocol    | 返回所使用的 web 协议（http: 或 https:） |
| location.hostname    | 返回 web 主机的域名                      |
| location.port        | 返回 web 主机的端口 （80 或 443）        |
| location.pathname    | 返回当前页面的路径和文件名               |
| **History对象API**   | **描述**                                 |
| location.assign(url) | 加载新的文档                             |

## 第五章 History

- history.back() - 与在浏览器点击后退按钮相同
- history.forward() - 与在浏览器中点击向前按钮相同

## 第六章 弹窗

- **window.alert()** ：警告框经常用于确保用户可以得到某些信息

- **window.confirm()** ：确认框通常用于验证是否接受用户操作，点击 "确认", 确认框返回 true， 如果点击 "取消", 确认框返回 false

- **window.prompt()** ：提示框经常用于提示用户在进入页面前输入某个值，输入某个值，然后点击确认或取消按钮才能继续操纵。

  如果用户点击确认，那么返回值为输入的值。如果用户点击取消，那么返回值为 null。

## 第七章 计时器

### 1. 设置间隔计时器

```js
var 计时器名称 = window.setInterval("javascript function",milliseconds);
```

- 第一个参数触发执行函数（function）
- 第二个参数间隔的毫秒数

### 2. 定时器

 ```js
var 定时器名称 = window.setTimeout("javascript function", milliseconds);
 ```

### 3. 停止计时

```js
window.clearTimeout(计时器名称);
```

# 第四部分 Ajax

## 第一章 Ajax概述

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;AJAX即“Asynchronous Javascript And XML”（异步JavaScript和XML），是指一种创建交互式网页应用的网页开发技术。AJAX 最大的优点是在不重新加载整个页面的情况下，可以与服务器交换数据并更新部分网页内容。AJAX 不需要任何浏览器插件，但需要用户允许JavaScript在浏览器上执行。

| 浏览器的普通交互方式                                | 浏览器的Ajax交互方式                                |
| --------------------------------------------------- | --------------------------------------------------- |
| ![img](https://img-blog.csdn.net/20150716193857795) | ![img](https://img-blog.csdn.net/20150716193904120) |

## 第二章 Ajax基本步骤

1. **创建Ajax对象**：XMLHttpRequest 是 AJAX 的基础，现代浏览器均支持 XMLHttpRequest 对象，例外是IE5 和 IE6 使用 ActiveXObject

   ```js
   var ajax;
   if (window.XMLHttpRequest){
       ajax = new XMLHttpRequest();					// IE7+, Firefox, Chrome, Opera, Safari 浏览器执行代码
   }else{
       ajax = new ActiveXObject("Microsoft.XMLHTTP");	// IE6, IE5 浏览器执行代码
   }
   ```

2. **配置请求**：ajax.open("请求方式","url","异步:true | 同步:false")

   ```js
   ajax.open("GET","/try/ajax/demo_get.php",true);
   ```

3. **发送请求**

   ```js
   ajax.send([data])
   ```

4. **获取响应**

   - `ajax.responseText`：获得字符串形式的响应数据。
   - `ajax.responseXML`：获得 XML 形式的响应数据。

5. **响应成功回调函数**

   - 方式一：根据响应成功回调函数

     ```js
     ajax.onload = function(){
         // 从ajax属性中获取响应结果
     }
     ```

   - 方式二：根据响应请求和响应状态码

     ```js
     ajax.onreadystatechange=function(){
       if (ajax.readyState==4 && ajax.status==200){
           // 从ajax属性中获取响应结果
       }
     }
     ```

## 第三章 XMLHttpRequest 对象详解

### 3.1 **创建XHR对象**

| 方法                                   | 说明                                        |
| -------------------------------------- | ------------------------------------------- |
| new ActiveXObject(“Microsoft.XMLHTTP”) | 适用于i支持window.ActiveXObject的ie5和ie6等 |
| new XMLHttpRequest()                   | 适用于ie7+/ff/chrome/safari/opera等         |

### 3.2 **XMLHttpRequest 对象说明**

| 属性                        | 说明                                                         |
| --------------------------- | ------------------------------------------------------------ |
| readyState                  | 通信状态，取值0~4<br /> - 0	代表一个未初始化的状态。以创建未初始化的XHR对象<br/> - 1	代表连接状态。已经调用了open方法，准备发送请求<br/> - 2	代表发送状态。已经调用了send方法，尚未得到响应数据<br/> - 3	代表正在接收状态，已经接收了HTTP响应的头部信息，正在接收响应内容<br/>-  4	代表已经加载状态，此时响应内容已经被完全接收 |
| status                      | 状态码，如100，200,404,500等                                 |
| statusText                  | 状态码对应的文本（OK/Not Found)                              |
| responseText                | 服务器返回的文本格式文档                                     |
| responseXML                 |                                                              |
| **方法**                    | **说明**                                                     |
| abort()                     | 中止当前请求                                                 |
| open(method,url,sync)       | 打开一个请求                                                 |
| send(args)                  | 发送请求：post参数需要在请求体中                             |
| setRequestHeader(key,value) | 设置请求的头部                                               |
| getResponseHeader(key)      | 获取响应的头部值                                             |
| getAllResponseHeaders()     | 以键值对形式返回所有头部信息                                 |
| **回调函数**                | **说明**                                                     |
| onreadystatechange          | IE的script 元素只支持onreadystatechange事件，不支持onload事件 |
| onload                      | FF的script 元素不支持onreadystatechange事件，只支持onload事件 |
| onerror                     | 当加载js文件报错的时候会被调用，比如文件路径错误、网络不可用等情况 |
| upload                      | 返回一个 XMLHttpRequestUpload对象，用来表示上传的进度。<br /> - onloadstart	获取开始<br/> - onprogress	数据传输进行中<br/> - onabort	获取操作终止<br/> - onerror	获取失败<br/> - onload	获取成功<br/> - ontimeout	获取操作在用户规定的时间内未完成<br/> - onloadend	获取完成（不论成功与否） |

### 3.3 **setRequestHeader请求头**

- **Content-Type说明**：MediaType，即是Internet Media Type，互联网媒体类型；也叫做MIME类型，在Http协议消息头中，使用Content-Type来表示具体请求中的媒体类型信息。

  | 常见的媒体格式类型                  | 说明                                          |
  | ----------------------------------- | --------------------------------------------- |
  | text/html                           | HTML格式                                      |
  | text/plain                          | 纯文本格式                                    |
  | text/xml                            | XML格式                                       |
  | image/gif                           | gif图片格式                                   |
  | image/jpeg                          | jpg图片格式                                   |
  | image/png                           | png图片格式                                   |
  | **常见的application开头的媒体格式** | **说明**                                      |
  | application/xhtml+xml               | XHTML格式                                     |
  | application/xml                     | XML数据格式                                   |
  | application/atom+xml                | Atom XML聚合格式                              |
  | application/json                    | JSON数据格式                                  |
  | application/pdf                     | pdf格式                                       |
  | application/msword                  | Word文档格式                                  |
  | application/octet-stream            | 二进制流数据（如常见的文件下载）              |
  | application/x-www-form-urlencoded   | form表单数据被编码为key/value格式发送到服务器 |
  | **上传文件之时**                    | **说明**                                      |
  | multipart/form-data                 | 在表单中进行文件上传时                        |

## 第四章 Ajax请求案例

### 4.1 **GET请求**

```html
<script>
    // 1. 创建ajax对象
    var xmlhttp;
    if (window.XMLHttpRequest) {
        xmlhttp=new XMLHttpRequest();
    } else {
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    // 2. 配置GET请求
    xmlhttp.open("GET","/try/ajax/demo_get.php",true);
	xmlhttp.send();
    // 3. 处理响应结果
    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
        var result = xmlhttp.responseText;
    }
</script>
```

### 4.2 **POST请求**

```html
<script>
    // 1. 创建ajax对象
    var xmlhttp;
    if (window.XMLHttpRequest) {
        xmlhttp=new XMLHttpRequest();
    } else {
        xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
    }
    // 2. 配置GET请求
    xmlhttp.open("POST","/try/ajax/demo_post2.php",true);
	xmlhttp.setRequestHeader("Content-type","application/x-www-form-urlencoded");
	xmlhttp.send("fname=Henry&lname=Ford");
    // 3. 处理响应结果
    xmlhttp.onreadystatechange=function() {
        if (xmlhttp.readyState==4 && xmlhttp.status==200) {
        var result = xmlhttp.responseText;
    }
}
</script>
```

# 第五部分 JavaScript高级

## 第一章 核心对象扩展

### 1.  Formdate对象

- **Formdate对象基本介绍**： FormData类型是XMLHttpRequest 2级定义的，它是为序列化表以及创建与表单格式相同的数据提供便利。与普通Ajax相比，使用FormData的最大**优点**：可以异步上传二进制文件。
  - 作用1：利用一些键值对来模拟一系列表单控件：即将form中的所有表单元素的**name**和**value**组装成一个queryString；
  - 作用2：异步上传二进制文件

- **Formdate API说明**

  | 创建FormData                       | 描述                                                         |
  | ---------------------------------- | ------------------------------------------------------------ |
  | let formdata = new FormData();     | 创建一个空的FormData对象，可以使用formdata.append(key,value)来添加数据 |
  | let formdata = new FormData(form); | 使用已有的表单来初始化一个FormData对象。                     |
  | **FormData API**                   | **描述**                                                     |
  | formdata.get(key)                  | 获取数据                                                     |
  | formdata.append(key,value)         | 添加数据                                                     |
  | formdata.set(key,value)            | 设置/修改数据 如果key不存在则新增一条数据，如果存在，则会修改对应的value值。 |
  | formdata.has(key)                  | 判断是否存在某条数据                                         |
  | formdata.delete(key)               | 删除数据                                                     |
  | entries() values()                 | 遍历获取一个遍历器                                           |

- **使用FormData上传文件**

  ```html
  <form id="advForm">
      <p>广告名称：<input type="text" name="advName" value="xixi"></p>
      <p>广告类别：<select name="advType">
          <option value="1">轮播图</option>
          <option value="2">轮播图底部广告</option>
          <option value="3">热门回收广告</option>
          <option value="4">优品精选广告</option>
      </select></p>
      <p>广告图片：<input type="file" name="advPic"></p>
      <p>广告地址：<input type="text" name="advUrl"></p>
      <p>广告排序：<input type="text" name="orderBy"></p>
      <p><input type="button" id="btn" value="添加"></p>
  </form>
  <script>
  var btn=document.querySelector("#btn");
  btn.onclick=function(){
      var formdata=new FormData(document.getElementById("advForm"));
      var xhr=new XMLHttpRequest();
      xhr.open("post","http://127.0.0.1/adv");
      xhr.send(formdata);
      xhr.onload=function(){
          if(xhr.status==200){
              //...
          }
      }
  }
  </script>
  ```

### 2. FileReader

- **FileReader对象介绍**： 从文件中读取数据和保存到JS变量中。此API特意设计成跟`XMLHttpRequest` 一样因为都是从外部读取数据。读取过程都是异步的不会造成浏览器阻塞。

- **FileReader API说明**

  | 创建FileReader              | 描述                   |
  | --------------------------- | ---------------------- |
  | new FileReader()            | 创建读取文件对象       |
  | **FileReader接口的方法**    | **描述**               |
  | readAsBlnaryString(file)    | 将文件取取为二进制编码 |
  | readAsText(file,[encoding]) | 将文件取取为文本       |
  | readAsDataURL(file)         | 将文件取取为DataURL    |
  | abort()                     | 中断读取操作           |
  | **FileReader接口事件**      | **描述**               |
  | onabort                     | 中断                   |
  | onerror                     | 出错                   |
  | onloadstart                 | 开始                   |
  | onprogress                  | 正在读取               |
  | **onload**                  | **成功读取**           |
  | onloadend                   | 读取完成，无论成功失败 |

- **FileReader读取文件案例**

  ```html
  <p>  
      <label>请选择一个文件：</label>  
      <input type="file" id="file" />  
      <input type="button" value="读取图像" onclick="readAsDataURL()" />  
      <input type="button" value="读取二进制数据" onclick="readAsBinaryString()" />  
      <input type="button" value="读取文本文件" onclick="readAsText()" />  
  </p>  
  <div id="result" name="result"></div>
  <script type="text/javascript">  
      var result=document.getElementById("result");  
      var file=document.getElementById("file");  
  
      //判断浏览器是否支持FileReader接口  
      if(typeof FileReader == 'undefined'){  
          result.InnerHTML="<p>你的浏览器不支持FileReader接口！</p>";  
          //使选择控件不可操作  
          file.setAttribute("disabled","disabled");  
      }  
  
      function readAsDataURL(){  
          //检验是否为图像文件  
          var file = document.getElementById("file").files[0];  
          if(!/image\/\w+/.test(file.type)){  
              alert("看清楚，这个需要图片！");  
              return false;  
          }  
          var reader = new FileReader();  
          //将文件以Data URL形式读入页面  
          reader.readAsDataURL(file);  
          reader.onload=function(e){  
              var result=document.getElementById("result");  
              //显示文件  
              result.innerHTML='<img src="' + this.result +'" alt="" />';  
          }  
      }  
  
      function readAsBinaryString(){  
          var file = document.getElementById("file").files[0];  
          var reader = new FileReader();  
          //将文件以二进制形式读入页面  
          reader.readAsBinaryString(file);  
          reader.onload=function(f){  
              var result=document.getElementById("result");  
              //显示文件  
              result.innerHTML=this.result;  
          }  
      }  
  
      function readAsText(){  
          var file = document.getElementById("file").files[0];  
          var reader = new FileReader();  
          //将文件以文本形式读入页面  
          reader.readAsText(file);  
          reader.onload=function(f){  
              var result=document.getElementById("result");  
              //显示文件  
              result.innerHTML=this.result;  
          }  
      }  
  </script>
  ```

  