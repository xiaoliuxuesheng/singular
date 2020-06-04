# 01 初见Less 

1. **less是什么**：Less 是一门 CSS 预处理语言，它扩展了 CSS 语言，增加了变量、Mixin、函数等特性，使 CSS 更易维护和扩展。

2. **Less官网**

   - 中文网：http://lesscss.cn/
   - 官网：http://lesscss.org/

3. **Less的基本格式**：less代码必须写到.less后缀的脚本文件中

   - 标准的CSS格式的写法

     ```css
     .content ul{
         list-style: none;
     }
     .content li{
         height: 25px;
         line-height: 25px;
     }
     .content li a{
         text-decoration: none;
     }
     ```

   - 使用Less格式的写法

     ```less
     .content{
         ul{
             list-style: none;
         }
         li{
             height: 22px;
             line-height: 22px;
             a{
                 text-decoration: none;
             }
         }
     }
     ```

4. **Less的注释**

   ```less
   // 双斜线表示单行注释
   
   /*
   	多行注释
   */
   ```

# 02 正确的使用Less 

1. **如何使用Less**：Less文件只有在编译后才能被浏览器使用

2. **Less的编译工具**

   - **[Koala](http://koala-app.com/)**：国产开发全平台全平台Less编译工具
   - **[WinLess](https://www.winless.org/)**：Windows系统中的Less编译工具
   - **[CodeKit](https://codekitapp.com/)**：Mac平台下的Less编译工具

3. **客户端调试工具**

   - 首先引入less脚本文件：在用link引入是，需要声明rel=“stylesheet/less”

     ```html
     
     ```

   - 然后引入less.js：引入方式与普通js脚本一致，但是必须放置在less的link之后

     ```html
     
     ```

     

# 03 变量（variables）

# 04 混合（mixins）

# 05 嵌套规则（nested-rules）

# 06 运算（operations）

# 07 函数（function）

# 08 命名空间

# 09 作用域

# 10 引入（importing）

# 11 关键字（important）

# 12 条件表达式

# 13 循环（loop）

# 14 合并属性

# 15 函数库