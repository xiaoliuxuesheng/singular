day01_01_vue js课程介绍

1. 课程大纲
   - 概述
   - 基础语法
   - 组件开发
   - vue cli 脚手架 + webpack
   - vue router 路由
   - vuex
   - 网络封装
   - 项目实战
   - 项目部署

day01_02_vue邂逅

1. 认识vue
   - vue官网：https://cn.vuejs.org/
   - vue是一个渐进式框架
     - 可以将vue作为应用的一部分嵌入其中，添加更丰富的体验，可以在一部分页面使用vue
     - vue可以作为核心库以及其生态系统
     - 可以完全使用vue脚手架作为项目的基础：vue全家桶
2. vue高级功能
   - 解耦视图和数据
   - 可复用组件
   - 前端路由技术
   - 状态管理
   - 虚拟DOM

day01_03_vue 安装

1. vue安装

   - 使用`<script>`脚本引入
     - 开发版下载地址：https://cn.vuejs.org/js/vue.js
     - 生产版下载地址：https://cn.vuejs.org/js/vue.min.js

   - CDN

     ```html
     制作原型或学习
     <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
     
     生产环境
     <script src="https://cdn.jsdelivr.net/npm/vue@2.6.11"></script>
     ```

   - NPM：

     ```sh
     npm install vue
     ```

   - 使用vue-cli工具

day01_04_第一个vue代码

1. 引入vue.js

   ```html
   <script src="../resources/js/vue.js"></script>
   ```

2. 定义html元素

   ```html
   <div id="app">
       {{msg}}
   </div>
   ```

3. 创建vue对象,挂载并管理html元素

   ```html
   <script>
       let vm = new Vue({
           el: '#app',
           data: {
               msg: "hello vue"
           }
       })
   </script>
   ```

day01_05_vue 列表展示案例

1. v-for的体验

day01_06_计数器案例

1. 案例代码

   ```html
   <div id="app">
       <h2>当前计数{{count}}</h2>
       <button v-on:click="count++">+</button>
       <button @click="count--">-</button>
       <hr>
       <button v-on:click="add">+</button>
       <button @click="sub">-</button>
   </div>
   <script src="../resources/js/vue.js"></script>
   <script>
       let vm = new Vue({
           el: "#app",
           data: {
               count: 0
           },
           methods: {
               add() {
                   this.count++
               },
               sub: function() {
                   this.count--
               }
           },
       })
   </script>
   ```

day01_07_mvvm

1. mvvm概述
   - M（Model）：数据
   - View Model（VM）：数据和视图的桥梁，负责数据通信
   - V（View）：视图，在页面上展示Model

day01_08_vue opentions

1. el：（String|HTMLElement），作用：决定vue实例管理哪一个DOM
2. data：（Object：Function），作用：Vue实例的数据对象
3. methods：（key[String]:Function）：作用：定义属于Vue的方法，可以在指令中使用，或其他地方使用

day01_09_vue生命周期

1. Vue生命周期是指从初始化到消亡的整个过程，在声明周期可以调用指定API

day01_10_声明周期函数 -》 

1. 声明周期API

   - 初始化事件和生命周期
     - beforeCreate:function(){}：

   - created:function(){}：
   - mounted:function(){}：

day01_11_vue template

1. Vue代码编辑的模板
2. Vue代码规范

day01_12_mustache语法

- 插值语法：mustache语法（胡子）
  - 直接读取变量值：{{变量}}
  - 使用+号连接多个变量：{{变量a + 变量b}}
  - 在mustache语法中可以使用数学计算表达式

day01_13_v-once指令

- v-once：只绑定一次，数据失去响应式特性
  - 格式：`<h1 v-once>{{变量}}</h1>` 该指令表示元素和组件只渲染一次,不会随着数据改变而改变
- v-html：插值表达式直接将字符串显示给页面不会解析字符串中的特殊符号，v-html可以解析html标签并渲染到页面
  - 格式：`<h1 v-html="变量"></h1>` 变量的值会直接覆盖标签中间,
- v-text：和插值语法相似，都用于将数据显示在页面
  - 格式：`<h1 v-text="变量"></h1>` 变量的值会直接覆盖标签中间
- v-pre：将指令描述的变量原封不动的展示出来
  - 格式：`<h1 v-pre>{{变量}}</h1>` 不会解析标签内的任何东西
- v-cloak：（斗篷）解决插值表达式闪动现象
  - 第一步给需要解决的标签添加v-cloak属性：`<h1 v-cloak>{{变量}}</h1>`
  - 第二步全局添加样式：改属性的标签初始都是：display：none；当vue解析v-cloak的插值表达式后会把标签的v-cloak属性删除

day01_14_v-bind

- v-bind：给标签绑定属性，并动将属性的值赋值给变量
  - 格式：`<h1 v-bind:标签属性="变量">标签内容{{变量}}</h1>`:将属性添加给该标签并且将变量的值赋值给标签的属性
  - 简写格式：`<h1 :标签属性="变量">标签内容{{变量}}</h1>`：直接使用冒号：省略v-bind关键字，vue提供的语法糖

day01_15_v-bind案例css特殊值(对象)

- `<h1 :class="{类名:boolean}"></h1>`:boolean值为true改class样式会生效,Boolean值可以定义在数据区的变量中,动态更新
- 可以和普通class共存

day01_16_v-bind案例css特殊值(列表)

- `<h1 :class="[类a,类b,...]"></h1>`: 给标签绑定多个样式,如果是普通类名需要加单引号,如果是变量不可以加引号

day01_17_v-bind 和 v-for结合的作业

- 有个列表
- 默认第一条红色
- 之后点击谁谁变红

day01_18_v-bind案例绑定style属性对象

- `<h1 :style="{样式属性名:属性值}"></h1>`:样式属性名可以是驼峰格式或中横线语法,属性值如果是普通值必须是引号,如果属性值是变量则不可以带引号;

day01_19_v-bind案例绑定style属性数组

- `<h1 :style="[变量a,变量b]"></h1>`:每个变量在data中是个对象,数组中可以定义多个对象

day01_20_计算属性

- 概述：在DOM中可以使用插值语法展示data中数据，而有时候的需要展示的属性是通过多个data中的数据计算而得到的，如果将计算表达式定义在插值表达式中，做不到代码复用，而且代码耦合严重；计算属性：作用就是封装一个属性计算的表达式对外提供一个结果变量作为计算表达式的结果，在插值表达式中直接使用
- 关键字：vue operations：computed:{计算属性:function(){return 属性表达式}}
- 计算属性优点：① 可以使用插值表达式{{计算属性}}获取计算属性的表达式的值②可以缓存计算结果

day01_21_计算属性复杂操作

- 计算属性函中使用复杂属性的表达式

day01_22_回顾课程

day02_01_计算属性getter和setter

- 完整的计算属性

  ```js
  new Vue({
      el:'#app',
      computed:{
          计算属性:{
          	set: function(value){
                  // 一般set方法不会被使用,只读属性,set方法会被删除的
                  // 定义set方法后  每次修改都会被调用
              },
              get: function(){
                  // 返回结果就是计算属性的结果,
                  // 只有get方法,为了简写get也会被省略
              }
          },
          计算属性简写: function(){
          	
          }
      }
  })
  ```

day02_02_计算属性和methods的区别

- 计算属性会将属性的计算结果缓存，重复使用时候不会被频繁计算
- 方法调用每次都会重新计算

day02_03_块级作用域let 和 var

- 事实上 var 的设计可以看做是JavaScript语言上的错误，因为要向后兼容，所以一直没有修复；

  - 添加新的关键字let ， 更完美的var

- 块级作用域

  | var                                                      | let                                  |
  | -------------------------------------------------------- | ------------------------------------ |
  | 没有块级作用域，if、for语句中var变量全局有效             | 有块级作用域，只能在大括号范围内有效 |
  | var的作用域只会区分函数内核函数外：闭包可以解决var的问题 |                                      |

day02_04_es5没有块级作用域和es6 的 let

1. ES5的没有块级作用域：for循环变量var i（i变量的原理）
2. ES5中使用闭包解决for循环的问题：var对应函数有作用域
3. ES6的块级作用域：for循环的变量let i（区分var变量i的原理）

day02_05_const原理

- ES6的变量关键字：const（将变量修饰为常量，不可被修改内存应用，可以修改变量内部的属性）
- 在ES6中优先使用const修饰变量
- const变量必须初始化

day02_06_对象字面量增强写法

1. const obj = new Object();

2. const obj = {key:value,key:function(){}}

3. 增强写法

   - 属性的增强写法：如果属性名和属性值对应的变量是相同，则属性的增强写法中只可以编写变量，默认将变量的名称作为对象属性

   - 函数的增强写法:函数名作为函数的key

     ```js
     const obj = {
         函数名: function(){
     		// 传统语法
     	},
         函数名(){
         	// 函数增强写法
     	}
     }
     ```

day02_07_v-on基本用法

- v-on：事件监听，绑定事件监听器

  - 基本用法：

    ```html
    // 基本写法
    <button v-on:click="方法名称"></button>
    // 语法糖
    <button @:click="方法名称"></button>
    ```

day02_08_事件参数

- 在事件箭筒调用方法时候,如果方法没有参数,方法调用的方法括号可以不写
- 如果函数需要参数,函数调用时候没有传递参数,默认参数的undifined
- 在Vue中方法调用事件监听方法时候,如果省略小括号,会将event事件对象传递给方法
  - 同时需要event和其他参数时候：如果不传参数第一个参数被event赋值，如果需要获取event对象，方法实参固定写法$event









