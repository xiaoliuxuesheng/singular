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

1. 在HTML页面中嵌入JavaScript脚本：在 HTML 页面中嵌入 JavaScript 脚本需要使用 `<script> `标签，用户可以在` <script> `标签中直接编写 JavaScript 代码

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

2. 在HTML页面中引入外部的JavaScript脚本文件

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

### 2.1 JS标识符/关键字/保留字

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

### 2.2 变量



### 2.3 JavaScript中数据类型

| 数据类型  |               说明               |
| :-------: | :------------------------------: |
|   null    |         空值，表示非对象         |
| undefined | 未定义的值，表示未赋值的初始化值 |
|  number   |        数字，数学运算的值        |
|  string   |        字符串，表示信息流        |
|  boolean  |       布尔值，逻辑运算的值       |
|  object   |    对象，表示复合结构的数据集    |

1. null
2. undefined
3. number
4. string
5. boolean
6. object

### 2.4 操作符

1. 算术运算符
2. 逻辑运算符
3. 赋值运算符
4. 位运算符
5. 对象运算符
6. 三元运算符
7. 逗号运算符
8. void 是一元运算符：在任意类型的操作数之前执行操作数，返回一个 undefined

### 2.5 JavaScript语句

1. 声明
2. 分支控制
3. 循环控制
4. 流程控制
5. 异常处理
6. 其他

## 第四章 JavaScript面向对象



## 第五章 JavaScript内置对象API

- array
- map
- json

## 第六章 正则表达式

# 第二部分 DOM

## 第一章 DOM的操作

## 第二章 DOM事件

# 第三部分 BOM

#第四部分 Ajax

