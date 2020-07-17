# 第一部分 EcmaScript

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
| ==  !=  \===    !==                | 等于、不等于、严格相等、非严格相等           |
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

- **空语句**

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

```js
var obj = new Object();
```

<font size=4 color=blue>2. 构造函数创建对象</font>：通过构造函数创建的对象是同一类型的对象，在面向对象对象的概念中，创建同一种类型的对象的构造函数称为类，由类new出来的对象称为改类的实例对象

```js
function Person(){
    this.name = null;
}
var person = new Person();
```

<font size=4 color=blue>3. 对象字面量创建对象</font>：`{}` - 一对花括号称为对象字面量

```js
var obj = {
    name:"value"
}
```

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

1. **创建String对象**

   ```js
   new String(s);
   String(s);
   ```

2. **String 对象属性**

   | 属性        | 描述                       |
   | :---------- | :------------------------- |
   | constructor | 对创建该对象的函数的引用   |
   | length      | 字符串的长度               |
   | prototype   | 允许您向对象添加属性和方法 |

3. **String 对象方法**

   | 方法                    | 描述                                                         |
   | :---------------------- | :----------------------------------------------------------- |
   | **charAt()**            | 返回在指定位置的字符。                                       |
   | **charCodeAt()**        | 返回在指定的位置的字符的 Unicode 编码。                      |
   | **indexOf()**           | 检索字符串第一次出现的索引,不存在返回-1                      |
   | **lastIndexOf()**       | 从后向前检索字符串第一次出现的索引,不存在返回-1              |
   | **concat()**            | 连接字符串。                                                 |
   | **localeCompare()**     | 用本地特定的顺序来比较两个字符串。                           |
   | **match()**             | 找到一个或多个正则表达式的匹配。                             |
   | **replace()**           | 替换与正则表达式匹配的子串。                                 |
   | **search()**            | 检索与正则表达式相匹配的值。                                 |
   | **split()**             | 把字符串分割为字符串数组。                                   |
   | **slice()**             | 提取字符串的片断，并在新的字符串中返回被提取的部分。<br /> - 返回值是一个新的字符串 |
   | **substr()**            | 从起始索引号提取字符串中指定数目的字符。<br /> - *参数star*t：要抽取的子串的起始下标。必须是数值。如果是负数，那么该参数声明从字符串的尾部开始算起的位置<br /> - *参数length：*可选。子串中的字符数 |
   | **substring()**         | 提取字符串索引号之间的字符。substring() 不接受负的参数       |
   | **link()**              | 将字符串显示为链接。                                         |
   | **toLocaleLowerCase()** | 把字符串转换为小写。                                         |
   | **toLocaleUpperCase()** | 把字符串转换为大写。                                         |
   | **toLowerCase()**       | 把字符串转换为小写。                                         |
   | **toUpperCase()**       | 把字符串转换为大写。                                         |
   | anchor(锚名称)          | `str`  => `<a name="锚名称">str</a>`                         |
   | big()                   | `str` => `<big>str</big>`                                    |
   | blink()                 | `str` => `<blink>str</blink>`                                |
   | bold()                  | `str` => `<b>str</b>`                                        |
   | fixed()                 | `str` => `<tt>str</tt>`                                      |
   | fontcolor()             | `str` => `<font color="red">str</font>`                      |
   | fontsize()              | `str` => `<font size="50">str</font>`                        |
   | italics()               | `str` => `<i>str</i>`                                        |
   | small                   | `str` => `<small>str</small>`                                |
   | strike()                | `str` => `<strike>str</strike>`                              |
   | sub()                   | `str` => `<sub>str</sub>`                                    |
   | sup()                   | `str` => `<sup>str</sup>`                                    |
   | String.fromCharCode()   | String.fromCharCode(112) => p                                |
   | toString()              | 返回字符串。                                                 |
   | valueOf()               | 返回某个字符串对象的原始值。                                 |

### 5.2 Number对象

1. **创建Number对象**

   ```js
   var n = new Number(value);
   var n = Number(value);
   ```

2. **Number 对象属性**

   | 属性              | 描述                                   |
   | :---------------- | :------------------------------------- |
   | constructor       | 返回对创建此对象的 Number 函数的引用。 |
   | MAX_VALUE         | 可表示的最大的数。                     |
   | MIN_VALUE         | 可表示的最小的数。                     |
   | NaN               | 非数字值。                             |
   | NEGATIVE_INFINITY | 负无穷大，溢出时返回该值。             |
   | POSITIVE_INFINITY | 正无穷大，溢出时返回该值。             |
   | prototype         | 使您有能力向对象添加属性和方法。       |

3. **Number 对象方法**

   | 方法             | 描述                                                 |
   | :--------------- | :--------------------------------------------------- |
   | toString()       | 把数字转换为字符串，使用指定的基数。                 |
   | toLocaleString() | 把数字转换为字符串，使用本地数字格式顺序。           |
   | toFixed          | 把数字转换为字符串，结果的小数点后有指定位数的数字。 |
   | toExponential    | 把对象的值转换为指数计数法。                         |
   | toPrecision      | 把数字格式化为指定的长度。                           |
   | valueOf          | 返回一个 Number 对象的基本数字值。                   |

### 5.3 Date对象 

1. **创建Date对象**

   ```js
   var d=new Date()
   ```

2. **Date 对象方法**

   | Local时间标准                                  | 描述                                                         |
   | :--------------------------------------------- | :----------------------------------------------------------- |
   | new Date()                                     | 返回当日的日期和时间。                                       |
   | <del>getYear/setYear()</del>                   | 请使用 getFullYear() /setFullYear()方法代替。                |
   | getFullYear()<br />setFullYear()               | 从 Date 对象以四位数字返回年份。<br />设置 Date 对象中的年份（四位数字）。 |
   | getMonth()<br />setMonth()                     | 从 Date 对象返回月份 (0 ~ 11)。<br />设置 Date 对象中月份 (0 ~ 11)。 |
   | getDate()<br />setDate()                       | 从 Date 对象返回一个月中的某一天 (1 ~ 31)。<br />设置 Date 对象中月的某一天 (1 ~ 31)。 |
   | getDay()                                       | 从 Date 对象返回一周中的某一天 (0 ~ 6)。                     |
   | getHours()<br />setHours()                     | 返回 Date 对象的小时 (0 ~ 23)。<br />设置 Date 对象中的小时 (0 ~ 23)。 |
   | getMinutes()<br />setMinutes()                 | 返回 Date 对象的分钟 (0 ~ 59)。<br />设置 Date 对象中的分钟 (0 ~ 59)。 |
   | getSeconds()<br />setSeconds()                 | 返回 Date 对象的秒数 (0 ~ 59)。<br />设置 Date 对象中的秒钟 (0 ~ 59)。 |
   | getMilliseconds()<br />setMilliseconds()       | 返回 Date 对象的毫秒(0 ~ 999)。<br />设置 Date 对象中的毫秒 (0 ~ 999)。 |
   | **UTC时间标准**                                | **描述**                                                     |
   | getUTCFullYear()<br />setUTCFullYear()         | 根据世界时从 Date 对象返回四位数的年份。<br />根据世界时设置 Date 对象中的年份（四位数字）。 |
   | getUTCMonth()<br />setUTCMonth()               | 根据世界时从 Date 对象返回月份 (0 ~ 11)。<br />根据世界时设置 Date 对象中的月份 (0 ~ 11)。 |
   | getUTCDate()<br />setUTCDate()                 | 根据世界时从 Date 对象返回月中的一天 (1 ~ 31)。<br />根据世界时设置 Date 对象中月份的一天 (1 ~ 31)。 |
   | getUTCDay()                                    | 根据世界时从 Date 对象返回周中的一天 (0 ~ 6)。               |
   | getUTCHours()<br />setUTCHours()               | 根据世界时返回 Date 对象的小时 (0 ~ 23)。<br />根据世界时设置 Date 对象中的小时 (0 ~ 23)。 |
   | getUTCMinutes()<br />setUTCMinutes()           | 根据世界时返回 Date 对象的分钟 (0 ~ 59)。<br />根据世界时设置 Date 对象中的分钟 (0 ~ 59)。 |
   | getUTCSeconds()<br />setUTCSeconds()           | 根据世界时返回 Date 对象的秒钟 (0 ~ 59)。<br />根据世界时设置 Date 对象中的秒钟 (0 ~ 59)。 |
   | getUTCMilliseconds()<br />setUTCMilliseconds() | 根据世界时返回 Date 对象的毫秒(0 ~ 999)。<br />根据世界时设置 Date 对象中的毫秒 (0 ~ 999)。 |
   | getTime()<br />setTime()                       | 返回 1970 年 1 月 1 日至今的毫秒数。<br />以毫秒设置 Date 对象。 |
   | **日期转换相关**                               | **描述**                                                     |
   | toString()                                     | 把 Date 对象转换为字符串。                                   |
   | toTimeString()                                 | 把 Date 对象的时间部分转换为字符串。                         |
   | toDateString()                                 | 把 Date 对象的日期部分转换为字符串。                         |
   | toUTCString()                                  | 根据世界时，把 Date 对象转换为字符串。                       |
   | toLocaleString()                               | 根据本地时间格式，把 Date 对象转换为字符串。                 |
   | toLocaleTimeString()                           | 根据本地时间格式，把 Date 对象的时间部分转换为字符串。       |
   | toLocaleDateString()                           | 根据本地时间格式，把 Date 对象的日期部分转换为字符串。       |
   | **其他**                                       | **描述**                                                     |
   | parse()<br />UTC()                             | 返回1970年1月1日午夜到指定日期（字符串）的毫秒数。<br />根据世界时返回 1970 年 1 月 1 日 到指定日期的毫秒数。 |
   | valueOf()                                      | 返回 Date 对象的原始值。                                     |
   | getTimezoneOffset()                            | 返回本地时间与格林威治标准时间 (GMT) 的分钟差。              |

### 5.3 Boolean对象

```js
new Boolean(value);	//构造函数
Boolean(value);		//转换函数
```

### 5.4 Array对象

1. **创建Array对象**

   ```js
   new Array();
   new Array(size);
   new Array(element0, element1, ..., elementn);
   ```

2. **Array 对象方法**

   | 方法             | 描述                                                         |
   | :--------------- | :----------------------------------------------------------- |
   | concat()         | 连接两个或更多的数组，并返回结果。                           |
   | join()           | 把数组的所有元素放入一个字符串。元素通过指定的分隔符进行分隔。 |
   | pop()            | 删除并返回数组的最后一个元素                                 |
   | push()           | 向数组的末尾添加一个或更多元素，并返回新的长度。             |
   | reverse()        | 颠倒数组中元素的顺序。                                       |
   | shift()          | 删除并返回数组的第一个元素                                   |
   | unshift()        | 向数组的开头添加一个或更多元素，并返回新的长度。             |
   | slice()          | 从某个已有的数组返回选定的元素                               |
   | sort()           | 对数组的元素进行排序                                         |
   | splice()         | 删除元素，并向数组添加新元素。                               |
   | toSource()       | 返回该对象的源代码。                                         |
   | toString()       | 把数组转换为字符串，并返回结果。                             |
   | toLocaleString() | 把数组转换为本地数组，并返回结果。                           |
   | valueOf()        | 返回数组对象的原始值                                         |

### 5.5 Map

### 5.6 Math对象

1. **Math 对象属性**

   | 属性    | 描述                                              |
   | :------ | :------------------------------------------------ |
   | E       | 返回算术常量 e，即自然对数的底数（约等于2.718）。 |
   | LN2     | 返回 2 的自然对数（约等于0.693）。                |
   | LN10    | 返回 10 的自然对数（约等于2.302）。               |
   | LOG2E   | 返回以 2 为底的 e 的对数（约等于 1.414）。        |
   | LOG10E  | 返回以 10 为底的 e 的对数（约等于0.434）。        |
   | PI      | 返回圆周率（约等于3.14159）。                     |
   | SQRT1_2 | 返回返回 2 的平方根的倒数（约等于 0.707）。       |
   | SQRT2   | 返回 2 的平方根（约等于 1.414）。                 |

2. **Math 对象方法**

   | 方法         | 描述                                                         |
   | :----------- | :----------------------------------------------------------- |
   | abs(x)       | 返回数的绝对值。                                             |
   | round(x)     | 把数四舍五入为最接近的整数。                                 |
   | random()     | 返回 0 ~ 1 之间的随机数。                                    |
   | ceil(x)      | 对数进行上舍入。                                             |
   | floor(x)     | 对数进行下舍入。                                             |
   | pow(x,y)     | 返回 x 的 y 次幂。                                           |
   | sqrt(x)      | 返回数的平方根。                                             |
   | max(x,y)     | 返回 x 和 y 中的最高值。                                     |
   | min(x,y)     | 返回 x 和 y 中的最低值。                                     |
   | exp(x)       | 返回 e 的指数。                                              |
   | log(x)       | 返回数的自然对数（底为e）。                                  |
   | **三角函数** | **描述**                                                     |
   | acos(x)      | 返回数的反余弦值。                                           |
   | asin(x)      | 返回数的反正弦值。                                           |
   | atan(x)      | 以介于 -PI/2 与 PI/2 弧度之间的数值来返回 x 的反正切值。     |
   | atan2(y,x    | 返回从 x 轴到点 (x,y) 的角度（介于 -PI/2 与 PI/2 弧度之间）。 |
   | cos(x)       | 返回数的余弦。                                               |
   | sin(x)       | 返回数的正弦。                                               |
   | tan(x)       | 返回角的正切。                                               |
   | toSource()   | 返回该对象的源代码。                                         |
   | valueOf()    | 返回 Math 对象的原始值。                                     |

### 5.7 Object对象

### 5.8 RegExp对象

### 5.9 Global对象

### 5.10 Function对象

# 第二部分 DOM

## 第一章 DOM Document

### 1.1 DOM概述

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**DOM（Document Object Model）**：文档对象模型是将 web 页面与到脚本或编程语言连接起来，HTML、XML文档机构的建模并不是JavaScript语言的一部分，JavaScript中定义的DOM模型用一个逻辑树表示一个文档，树的每个分支的终点都是一个节点(node)，每个节点都包含着对象(objects)。DOM的方法(methods)让你可以用特定方式操作这个树，用这些方法你可以改变文档的结构、样式或者内容。节点可以关联上事件处理器，一旦某一事件被触发了，那些事件处理器就会被执行。

<img src="https://s1.ax1x.com/2020/07/17/UsEUSJ.png" alt="UsEUSJ.png" border="0" />

- **DOM节点类型**

  | 节点名称         | nodeType                            | nodeName | nodeValue |
  | ---------------- | ----------------------------------- | -------- | --------- |
  | 元素节点         | Node.ELEMENT_NODE(1)                |          |           |
  | 属性节点         | Node.ATTRIBUTE_NODE(2)              |          |           |
  | 文本节点         | Node.TEXT_NODE(3)                   |          |           |
  | CDATA节点        | Node.CDATA_SECTION_NODE(4)          |          |           |
  | 实体引用名称节点 | Node.ENTRY_REFERENCE_NODE(5)        |          |           |
  | 实体名称节点     | Node.ENTITY_NODE(6)                 |          |           |
  | 处理指令节点     | Node.PROCESSING_INSTRUCTION_NODE(7) |          |           |
  | 注释节点         | Node.COMMENT_NODE(8)                |          |           |
  | 文档节点         | Node.DOCUMENT_NODE(9)               |          |           |
  | 文档类型节点     | Node.DOCUMENT_TYPE_NODE(10)         |          |           |
  | 文档片段节点     | Node.DOCUMENT_FRAGMENT_NODE(11)     |          |           |
  | DTD声明节点      | Node.NOTATION_NODE(12)              |          |           |

### 1.2 Document 对象集合

| 集合      | 描述                                                         |
| :-------- | :----------------------------------------------------------- |
| all[]     | 返回对文档中所有 HTML 元素的引用<br /> - document.all[i] <br /> - document.all[name] <br /> - document.all.tags[tagname] |
| anchors[] | 返回对文档中所有 Anchor（锚） 对象的引用。                   |
| applets   | 返回对文档中所有 Applet 对象的引用。                         |
| forms[]   | 返回对文档中所有 Form 对象引用。                             |
| images[]  | 返回对文档中所有 Image 对象引用。                            |
| links[]   | 返回对文档中所有 Area 和 Link 对象引用。                     |

## 1.3 Document 对象属性

| 属性         | 描述                                                         |
| :----------- | :----------------------------------------------------------- |
| body         | 提供对`<body>` 元素的直接访问。对于定义了框架集的文档，该属性引用最外层的 `<frameset>` |
| cookie       | 设置或返回与当前文档有关的所有 cookie。                      |
| domain       | 返回当前文档的域名。                                         |
| lastModified | 返回文档被最后修改的日期和时间。                             |
| referrer     | 返回载入当前文档的文档的 URL。                               |
| title        | 返回当前文档的标题。                                         |
| URL          | 返回当前文档的 URL。                                         |

## 1.4 Document 对象方法

| 方法                   | 描述                                                         |
| :--------------------- | :----------------------------------------------------------- |
| getElementById()       | 返回对拥有指定 id 的第一个对象的引用。                       |
| getElementsByName()    | 返回带有指定名称的对象集合。                                 |
| getElementsByTagName() | 返回带有指定标签名的对象集合。                               |
| open()                 | 打开一个流，以收集来自任何 document.write() 或 document.writeln() 方法的输出。 |
| close()                | 关闭用 document.open() 方法打开的输出流，并显示选定的数据。  |
| write()                | 向文档写 HTML 表达式 或 JavaScript 代码。                    |
| writeln()              | 等同于 write() 方法，不同的是在每个表达式之后写一个换行符。  |

## 第二章 DOM Element

## 2.1 Element概述

## 2.2 属性和方法

| 属性 / 方法                                                  | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [element.accessKey](https://www.w3school.com.cn/jsref/prop_html_accesskey.asp) | 设置或返回元素的快捷键。                                     |
| [element.appendChild()](https://www.w3school.com.cn/jsref/met_node_appendchild.asp) | 向元素添加新的子节点，作为最后一个子节点。                   |
| [element.attributes](https://www.w3school.com.cn/jsref/prop_node_attributes.asp) | 返回元素属性的 NamedNodeMap。                                |
| [element.childNodes](https://www.w3school.com.cn/jsref/prop_node_childnodes.asp) | 返回元素子节点的 NodeList。                                  |
| [element.className](https://www.w3school.com.cn/jsref/prop_html_classname.asp) | 设置或返回元素的 class 属性。                                |
| element.clientHeight                                         | 返回元素的可见高度。                                         |
| element.clientWidth                                          | 返回元素的可见宽度。                                         |
| [element.cloneNode()](https://www.w3school.com.cn/jsref/met_node_clonenode.asp) | 克隆元素。                                                   |
| [element.compareDocumentPosition()](https://www.w3school.com.cn/jsref/met_node_comparedocumentposition.asp) | 比较两个元素的文档位置。                                     |
| [element.contentEditable](https://www.w3school.com.cn/jsref/prop_html_contenteditable.asp) | 设置或返回元素的文本方向。                                   |
| [element.dir](https://www.w3school.com.cn/jsref/prop_html_dir.asp) | 设置或返回元素的内容是否可编辑。                             |
| [element.firstChild](https://www.w3school.com.cn/jsref/prop_node_firstchild.asp) | 返回元素的首个子。                                           |
| [element.getAttribute()](https://www.w3school.com.cn/jsref/met_element_getattribute.asp) | 返回元素节点的指定属性值。                                   |
| [element.getAttributeNode()](https://www.w3school.com.cn/jsref/met_element_getattributenode.asp) | 返回指定的属性节点。                                         |
| [element.getElementsByTagName()](https://www.w3school.com.cn/jsref/met_element_getelementsbytagname.asp) | 返回拥有指定标签名的所有子元素的集合。                       |
| element.getFeature()                                         | 返回实现了指定特性的 API 的某个对象。                        |
| element.getUserData()                                        | 返回关联元素上键的对象。                                     |
| [element.hasAttribute()](https://www.w3school.com.cn/jsref/met_element_hasattribute.asp) | 如果元素拥有指定属性，则返回true，否则返回 false。           |
| [element.hasAttributes()](https://www.w3school.com.cn/jsref/met_node_hasattributes.asp) | 如果元素拥有属性，则返回 true，否则返回 false。              |
| [element.hasChildNodes()](https://www.w3school.com.cn/jsref/met_node_haschildnodes.asp) | 如果元素拥有子节点，则返回 true，否则 false。                |
| [element.id](https://www.w3school.com.cn/jsref/prop_html_id.asp) | 设置或返回元素的 id。                                        |
| [element.innerHTML](https://www.w3school.com.cn/jsref/prop_html_innerhtml.asp) | 设置或返回元素的内容。                                       |
| [element.insertBefore()](https://www.w3school.com.cn/jsref/met_node_insertbefore.asp) | 在指定的已有的子节点之前插入新节点。                         |
| [element.isContentEditable](https://www.w3school.com.cn/jsref/prop_html_iscontenteditable.asp) | 设置或返回元素的内容。                                       |
| [element.isDefaultNamespace()](https://www.w3school.com.cn/jsref/met_node_isdefaultnamespace.asp) | 如果指定的 namespaceURI 是默认的，则返回 true，否则返回 false。 |
| [element.isEqualNode()](https://www.w3school.com.cn/jsref/met_node_isequalnode.asp) | 检查两个元素是否相等。                                       |
| [element.isSameNode()](https://www.w3school.com.cn/jsref/met_node_issamenode.asp) | 检查两个元素是否是相同的节点。                               |
| [element.isSupported()](https://www.w3school.com.cn/jsref/met_node_issupported.asp) | 如果元素支持指定特性，则返回 true。                          |
| [element.lang](https://www.w3school.com.cn/jsref/prop_html_lang.asp) | 设置或返回元素的语言代码。                                   |
| [element.lastChild](https://www.w3school.com.cn/jsref/prop_node_lastchild.asp) | 返回元素的最后一个子元素。                                   |
| [element.namespaceURI](https://www.w3school.com.cn/jsref/prop_node_namespaceuri.asp) | 返回元素的 namespace URI。                                   |
| [element.nextSibling](https://www.w3school.com.cn/jsref/prop_node_nextsibling.asp) | 返回位于相同节点树层级的下一个节点。                         |
| [element.nodeName](https://www.w3school.com.cn/jsref/prop_node_nodename.asp) | 返回元素的名称。                                             |
| [element.nodeType](https://www.w3school.com.cn/jsref/prop_node_nodetype.asp) | 返回元素的节点类型。                                         |
| [element.nodeValue](https://www.w3school.com.cn/jsref/prop_node_nodevalue.asp) | 设置或返回元素值。                                           |
| [element.normalize()](https://www.w3school.com.cn/jsref/met_node_normalize.asp) | 合并元素中相邻的文本节点，并移除空的文本节点。               |
| element.offsetHeight                                         | 返回元素的高度。                                             |
| element.offsetWidth                                          | 返回元素的宽度。                                             |
| element.offsetLeft                                           | 返回元素的水平偏移位置。                                     |
| element.offsetParent                                         | 返回元素的偏移容器。                                         |
| element.offsetTop                                            | 返回元素的垂直偏移位置。                                     |
| [element.ownerDocument](https://www.w3school.com.cn/jsref/prop_node_ownerdocument.asp) | 返回元素的根元素（文档对象）。                               |
| [element.parentNode](https://www.w3school.com.cn/jsref/prop_node_parentnode.asp) | 返回元素的父节点。                                           |
| [element.previousSibling](https://www.w3school.com.cn/jsref/prop_node_previoussibling.asp) | 返回位于相同节点树层级的前一个元素。                         |
| [element.removeAttribute()](https://www.w3school.com.cn/jsref/met_element_removeattribute.asp) | 从元素中移除指定属性。                                       |
| [element.removeAttributeNode()](https://www.w3school.com.cn/jsref/met_element_removeattributenode.asp) | 移除指定的属性节点，并返回被移除的节点。                     |
| [element.removeChild()](https://www.w3school.com.cn/jsref/met_node_removechild.asp) | 从元素中移除子节点。                                         |
| [element.replaceChild()](https://www.w3school.com.cn/jsref/met_node_replacechild.asp) | 替换元素中的子节点。                                         |
| element.scrollHeight                                         | 返回元素的整体高度。                                         |
| element.scrollLeft                                           | 返回元素左边缘与视图之间的距离。                             |
| element.scrollTop                                            | 返回元素上边缘与视图之间的距离。                             |
| element.scrollWidth                                          | 返回元素的整体宽度。                                         |
| [element.setAttribute()](https://www.w3school.com.cn/jsref/met_element_setattribute.asp) | 把指定属性设置或更改为指定值。                               |
| [element.setAttributeNode()](https://www.w3school.com.cn/jsref/met_element_setattributenode.asp) | 设置或更改指定属性节点。                                     |
| element.setIdAttribute()                                     |                                                              |
| element.setIdAttributeNode()                                 |                                                              |
| element.setUserData()                                        | 把对象关联到元素上的键。                                     |
| element.style                                                | 设置或返回元素的 style 属性。                                |
| [element.tabIndex](https://www.w3school.com.cn/jsref/prop_html_tabindex.asp) | 设置或返回元素的 tab 键控制次序。                            |
| [element.tagName](https://www.w3school.com.cn/jsref/prop_element_tagname.asp) | 返回元素的标签名。                                           |
| [element.textContent](https://www.w3school.com.cn/jsref/prop_node_textcontent.asp) | 设置或返回节点及其后代的文本内容。                           |
| [element.title](https://www.w3school.com.cn/jsref/prop_html_title.asp) | 设置或返回元素的 title 属性。                                |
| element.toString()                                           | 把元素转换为字符串。                                         |
| [nodelist.item()](https://www.w3school.com.cn/jsref/met_nodelist_item.asp) | 返回 NodeList 中位于指定下标的节点。                         |
| [nodelist.length](https://www.w3school.com.cn/jsref/prop_nodelist_length.asp) | 返回 NodeList 中的节点数。                                   |

1. 查询或设置节点相关的属性和方法

   

2. 操作节点相关属性和方法

   

3. 其他属性和方法

   

## 第三章 DOM Attribute

## 第四章 DOM Event 

# 第三部分 BOM

## 第一章 Window

## 第二章 Navigator

## 第三章 Screen

## 第四章 History

## 第五章 Location

# 第四部分 Ajax

