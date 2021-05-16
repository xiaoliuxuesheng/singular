# 第一章 模块化概述

## 1.1 模块化<a href='https://www.cnblogs.com/lvdabao/p/js-modules-develop.html'>历程</a>

1. **无模块时代**： ajax未出，js只是玩具语言：只能做表单校验，简单动画，代码堆在一起，顺序执行
2. **模块萌芽时代**：2006年ajax提出，前端业务代码越来越多
   - 暴露的问题：①全局变量灾难②函数命名冲突③js文件依赖管理复杂
   - 最初的解决方案：①用自执行函数包装代码②java风格的命名空间：包名.模块名③jQuery分隔匿名自执行函数
   - 模块化需要解决的问题：①不污染模块外的任何代码②标识一个模块③暴露模块的API，不增加全局变量④管理模块的依赖
3. **源自nodejs的CommonJs**：2009年node问世开始编写服务端代码，模块化称为必须
   - CommonJs社区发力，制定了Modules/1.0规范：①书写规范②全require函数③require包含依赖则依次加载④exports暴露API：exports只能是一个对象，暴露的API只能是exports对象的属性
4. **服务端向前端进军**：Modules/1.0规范源于服务端，无法直接用于浏览器端：①外层没有function，变量暴露在全局②浏览器需要先从服务器下载文件，然后运行代码才能得到API，没有办法让代码同步执行；下一代规范产生三种分歧：
   - **Modules/1.x派**：“保皇派“给存在的问题找解决方案，包function代码，加异步方案，制定了Modules/Transport规范
   - **Modules/Async派**：”革新派“不能沿用旧的模块标准，认为模块在定义的时候就必须指明所依赖的模块，然后把本模块的代码写在回调函数里。模块的加载也是通过下载-回调这样的过程来进行。最终从CommonJs中分裂了出去，独立制定了浏览器端的js模块化规范AMD（Asynchronous Module Definition）
   - **Modules/2.0派**：“中间派”既不想丢掉旧的规范，也不想像AMD那样推到重来；最终他们制定了一个Modules/Wrappings规范
5. **AMD/RequireJs的崛起与妥协**：部分兼容CommonJs
6. **兼容并包的CMD/seajs**：requirejs有上述种种不甚优雅的地方，所以必然会有新东西来完善它，这就是后起之秀seajs；s，seajs的作者是国内大牛淘宝前端布道者玉伯。seajs全面拥抱Modules/Wrappings规范，不用requirejs那样回调的方式来编写模块。而它也不是完全按照Modules/Wrappings规范，seajs并没有使用declare来定义模块，而是使用和requirejs一样的define；
7. **面向未来的ES6模块标准**：作为官方的ECMA必然要有所行动，js模块很早就列入草案，终于在2015年6月份发布了ES6正式版。然而，可能由于所涉及的技术还未成熟，ES6移除了关于模块如何加载/执行的内容，只保留了定义、引入模块的语法。还只是个雏形，半成品都算不上；

## 1.2 模块化规范

1. CommonJS
2. RequireJs
3. CMD
4. ES6

# 第二章 三大模块化规范

## 2.1 CommonJS

1. 规范说明

   - 每个文件都可以当做一个模块
   - 在服务器端：模块的加载和运行是同步加载的，等待时间长
   - 在浏览器端：模块需要提前编译打包处理：等待时间长，require语法不支持

2. 基本语法

   - 暴露模块：CommonJS规范规定，每个模块内部，`module`变量代表当前模块。这个变量是一个对象，它的`exports`属性（即`module.exports`）是对外的接口。加载某个模块，其实是加载该模块的`module.exports`属性。

     ```js
     module.exports = value		// 是用新的对象替换了exports对象的引用，特定是一个模块只能使用一次
     exports.xxx = value			// 不断的给exports对象添加新的属性或方法，可以使用多次，暴露多个对象
     ```

   - 引入模块：结构对象或定义变量接受暴露的exports对象；

     ```js
     // 引入第三方模块
     require('包名')
     // 引入自定义模块
     require('包所在路径')
     ```

   - commonjs应用到浏览器需要：browserify依赖进行转换commonjs

## 2.2 AMD

1. 规范说明

   - 是专门用于浏览器端的模块加载：需要依赖Require.js
   - 加载方式是异步的

2. 基本语法

   - 定义模块

     ```js
     // 定义没有依赖的模块
     define(function(){
         return 模块;
     })
     
     // 定义有依赖的模块,第一个参数是数组,数组元素是依赖的模块
     define([模块A,模块B],function(ma,mb){
         return 模块;
     })
     ```

   - 引入模块

     ```js
     requirejs.config({
         paths:{
             模块:'路径'
         }
     })
     require(['模块A','模块B'],function(ma,mb){
         // 使你ma、mb模块
     })
     ```

   - 

## 2.3 CMD 

1. 规范说明

   - 是专门用于浏览器端的模块加载：需要依赖Require.js
   - 加载方式是异步的
   - 模块在使用是才会加载

2. 基本语法

   - 定义模块

     ```js
     // 定义没有依赖的模块
     define(function(require,exports,module){
         exports.xxx = value
         // 或者
         module.exports = value
     })
     
     // 定义有依赖的模块
     define(function(require,exports,module){
         // 引入依赖的模块 - 同步
         const ma = require('模块路径')
         // 引入依赖的模块 - 异步
     	require.async('模块路径',function(mc){
             
         })
         // 暴露模块
         exports.xxx = value
     })
     ```

   - 引入模块

     ```js
     define(function(require,exports,module){
         // 引入依赖的模块 - 同步
         const ma = require('模块路径')
         // 引入依赖的模块 - 异步
     	require.async('模块路径',function(mc){})
     })
     ```

## 2.4 ES6

1. 规范说明

   - 依赖的模块需要打包处理，浏览器不知道ES6打包语法

   - 需要安装babel-cli、babel-preset-es2015和browserify：将es高级语法转为es2015

   - 定义.babelrc文件：bable-cli读取配置文件

     ```json
     {
         "presets":["es2015"]
     }
     ```

2. 基本语法

   - 定义模块export

     ```js
     // 导出默认单个对象
     export default {
         fun(){},
         obj:{},
         key:value
     }
     // 分别暴露多个对象
     export function fun(){}
     export obj = {}
     export key = value
     
     // 统一暴露多个对象
     function fun(){}
     let obj = {}
     let key = value
     export {
     	fun,
         obj,
         key
     }
     ```

   - 引入模块import

     ```js
     // import 默认模块
     import 自定义名称 form '模块路径'
     
     // import 解构变量
     import {fun,obj,key} form '模块路径'
     ```

     

