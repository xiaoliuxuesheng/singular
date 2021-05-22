# day01

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

   ``` html
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

# day02

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

day02_09_v-on参数问题

1. 情况一：如果监听事件不需要传递参数，调用事件方法时候的方法调用的括号可以省略，则浏览器会将事件方法中第一个形参被赋值给事件对象
2. 情况二：如果监听事件不需要传递参数，如果没有省略小括号，则事件方法第一个参数这是undefined
3. 情况三：如果监听事件需要传递参数，如果还需要传递事件对象，则事件对象的固定写法是$event

day02_10_v-on修饰符

1.  @click.stop 阻止事件冒泡 ：`<button @click.stop="button">div里面的按钮</button>`
2. @click.prevent 阻止默认事件： <input type="submit" value="提交" @click.prevent="submitClick">
3. 监听按键，只会监听enter键： <input type="text" @keyup.enter="keyup">
4. @事件.once : 只会监听一次回调

day02_11_v-if 和 v-else

- v-if：会删除DOM，需要渲染
- v-else
- v-else if

day02_12 v-if案例

- 点击切换登陆方式

day02_13 登陆案例input复用问题

- 存在的问题：切换登陆方式后，登陆表单中的内容不会被清空，会将上个的内容保留
- 原型是vue底层在虚拟DOM放进内存中，为性能考虑，虚拟DOM会尽可能复用DOM，然后将虚拟DOM中元素渲染到DOM中
- 解决方案：给标签添加key属性，作为虚拟DOM复用的标识

day02_14 v-show

- v-show：不会渲染DOM

day02_15 v-for 遍历数组

- 遍历数组: 第一个变量是数组中元素, 第二个参数是元素对应的下标

  ```js
  <li v-for="(item,idnex) in arr">{{idnex}} --- {{item}} </li>
  ```

- 遍历对象

day02_16 v-for 绑定key

- 官方建议:使用v-for的时候给元素或组件添加不重复的key属性,保证组件的复用

- key唯一 性能更好

day02_17 数组中的算法

- 数据是响应式的
- 数组的响应式的API
  - push("")
  - pop()  从数组后删除
  - shift() 从数组第一个元素
  - unshift() 从数组最前面添加元素
  - splice(starter, 删除个数, 追加元素)
  - sort() 排序
  - reverse() 反转
  - Vue.set(数组,索引,修改的值) vue实现的根据索引修改数组的可以做到响应式
- 数组非响应式API
  - 通过索引修改数组中元素: arr[索引] = 新值

day02_18 作业讲解

- 当前index为红色 这个逻辑

day02_19 购物车图书馆环境

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        #app {
            width: 800px;
            margin: 0 auto;
        }
        table,
        thead {
            width: 800px;
            background: #000000;
        }
        td,
        th {
            text-align: center;
            background-color: #fff;
        }
    </style>
</head>
<body>
    <div id="app">
        <table>
            <thead>
                <tr>
                    <th></th>
                    <th>书籍名称</th>
                    <th>出版日期</th>
                    <th>价格</th>
                    <th>购买数量</th>
                    <th>操作</th>
                </tr>
            </thead>
            <tbody>
                <tr v-for="book,index in books">
                    <td>{{index}}</td>
                    <td>{{book.name}}</td>
                    <td>{{book.date}}</td>
                    <td>￥{{book.price}}</td>
                    <td>
                        <button @click="add">+</button> {{book.count}}
                        <button @click="min">-</button>
                    </td>
                    <td><button>移除</button></td>
                </tr>
            </tbody>
            <tfoot>
                <tr>
                    <td>合计:</td>
                    <td colspan="5">￥{{total}}</td>
                </tr>
            </tfoot>
        </table>
    </div>
    <script src="../resources/js/vue.js"></script>
    <script>
        const vm = new Vue({
            el: "#app",
            data: {
                books: [{
                    name: "java基础",
                    date: "2020-01-27",
                    price: 23,
                    count: 0
                }, {
                    name: "JavaScript",
                    date: "2020-02-27",
                    price: 23,
                    count: 0
                }, {
                    name: "Go",
                    date: "2020-03-27",
                    price: 23,
                    count: 0
                }, {
                    name: "Python",
                    date: "2020-04-27",
                    price: 23,
                    count: 0
                }, {
                    name: "Shell",
                    date: "2020-05-27",
                    price: 23,
                    count: 0
                }]
            },
            computed: {
                total() {
                    return 100;
                }
            },
            methods: {
                add() {

                },
                min() {

                }
            }
        })
    </script>
</body>
</html>
```

day02_20 过滤器

- vue - options ：filters - 过滤器给价格保留两位小数， 并且给价格之前拼接一个￥符号

  ```js
  <td>{{book.price | priceFilter}}</td>
  
  filters: {
       priceFilter(price) {
           return "￥ " + price.toFixed(2)
       }
   }
  ```

day02_21 改变购买数量

```js
methods: {
    add(index) {
        this.books[index].count++
    },
        min(index) {
            if (this.books[index].count > 0) {
                this.books[index].count--
            }
        }
}
```

day02_22 统计价格

```js
computed: {
    total() {
        let total = 0;
        this.books.forEach(book => {
            total += book.price * book.count

        });
        return total;
    }
}
```

# day03

day03_01 JavaScript高级函数

- foreach - 数组长度为0会报错

- for - in : 拿到的是元素的索引

  ```js
  for (let index in books) {
      console.log(books[index])
  }
  ```

- for of : 遍历拿到元素

  ```js
  for (let item of books) {
      console.log(item)
  }
  ```

- filter : filter中的回调函数有一个要求,必须返回boolean值, 当返回为true会将当前参数添加到新的数组总,如果返回false当前参数会过滤掉

  ```js
  let arr1 = [12, 23, 12, 34, 545, 74634, 23, 454, 5, 56575, 2323]
  arr1.filter(function(n) {
      return n < 100;
  })
  var res1 = arr1.filter(n => n < 100)
  ```

- map : 接受数组的每个元素并转换为另外的元素并返回新数组

  ```js
  let map = res1.map(n => n * 3);
  ```

- reduce : 规约 作用是用于汇总需要遍历数组中的某个值, 与给定的初始值进行汇总,最后返回一个值,每次函数的返回值都赋值给第一个参数

  ```js
   let reduce = map.reduce(function(preValu, n) {
       return preValu + n
   }, 0)
  ```

day03_02 v-model 双向绑定

- v-model : 双向绑定的原理:① v-bind:value 将表单的属性绑定到表单②v-on:input事件将表单的值设置到遍历

  ```js
  <input type="text" v-model="msg"> {{msg}}
  ```

day03_03 radio类型的表单

- v-model 绑定的属性名相同, radio选项会互斥,可以不要name属性

day03_04_checkbox类型表单

- 单选框:绑定一个变量  表示是否选中
- 复选框:绑定的是一个数组, 多选框的选中的元素会添加到数组中

day03_05 select 下拉选

- 下拉单选:① 默认是单选 ② v-model绑定的select元素上
- 下拉多选: ① select标签添加属性 multiple ② v-model绑定一个数组

day03_06 input的值绑定

- 核心是动态的给 需要绑定的值进行赋值
- 首先是要具有初始值,通过加载初始值得到 动态的value值

day03_07 v-model 修饰符

- v-model..lazy : 懒加载 失去焦点或回车才会触发数据绑定
- v-model.num : 表示只能绑定数字, 但是输入的类型也会转为number
- v-model.trim : 会将表单输入的字符串两边的空格去除

day03_08 组件化

1. 组件化的介绍
   - 举个例子:有一堆复杂的问题要解决,人们会将问题分离成一个个的,然后分步解决一个个的小问题
   - 组件化的例子:原始的业务代码是放在一个js模块中, 为了方便复用抽离了很多方法(函数), 最后可以将表示一组功能的函数再抽离为组件,这个组件就可以重复使用
2. vue中的组件思想
   - 提供了一种抽象,让我们可以开发出一个个独立可复用的小组件来构造我们的应用
   - 任何的应用都会被抽象成一颗组件树
3. vue组件使用的基本步骤
   - 创建组件构造器 : 构造出组件对象
   - 注册组件 : 将组件对象关联的到Vue对象之上
   - 使用组件 : 可以在当前vue管理的DOM中使用DOM之外有其他组件管理的DOM

day03_09 组件化基本使用

1. 创建组件对象: extend 创建组件构造器, 传入组件选项 创建组件选项,template标识组件的DOM内容(template  会被渲染为render函数)

   ```js
   const cmp = Vue.extend({
       template: `
           <div>
               <h2>是个标题啊</h2>
               <p>是个段落啊</p>
           </div>
   	`
   })
   ```

2. 注册组件:给组件定义名称 - 使用组件的标识 Vue.component将组件注册为全局组件 

   ```js
   Vue.component("test-cmp", cmp)
   ```

3. 使用组件 ; 组件必须在vue实例范围内使用

   ```html
   <div id="app">
       <test-cmp></test-cmp>
       <test-cmp></test-cmp>
       <test-cmp></test-cmp>
       <test-cmp></test-cmp>
   </div>
   ```

day03_10 全局组件和局部组件

1. 全局组件 : 在多个Vue实例对象下使用

   ```js
   Vue.component("test-cmp", cmp)
   ```

2. 局部组件: 只能在当前vue实例范围内使用

   ```js
   const vm = new Vue({
       components: {
           "cpm-b": cmpB
       }
   })
   ```

day03_11 父组件和子组件

1. 组件概述: 组件本质也是一个vue实例对象, 在组件内也具有vue实例的大部分属性,包括组件注册, 如果在组件内注册了其他组件,那么则可以在这个组件内使用注册的组件, 被注册的组件称为这个组件的子组件, 这个组件是子组件的父组件
2. vue实例也是一个组件,是组件树中的根组件
3. 组件只能使用全局组件和自己的直接子组件: 在渲染组件模板内容时候首先会在自己实例的组件中查找,找不到再去全局组件查找

day03_12 组件注册的语法糖 省略extend函数 直接传递组件对象

1. 注册到全局组件

   ```js
           const cmpB = Vue.extend({
               template: `
                   <div>
                       <h2>局部组件</h2>
                       <p>是个段落啊</p>
                   </div>
               `
           })
   ```

2. 注册到局部组件

   ```js
   components: {
       "cpm-b": cmpB,
   	"cpm-c": cpmC,
   	"cpm-d": {
           template: `
               <div>
               <h2>局部组件</h2>
               <p>是个段落啊</p>
               </div>
   		`
   	}
   }
   ```

day03_13 组件模板的抽离

1. 方式一：将模块字符定义在script标签中，指定标签类型 text/x-template ,在template中挂载script标签元素

   ```html
   <script type="text/x-template" id="scr">
           <div>
               <h1>模板字符串抽离script</h1>
       </div>
   </script>
   <script>
       Vue.component("scr", {
           template: "#scr"
       })
   </script>
   ```

2. 方式二: 使用template标签抽离模板

   ```html
   <template id="tem">
       <div>
           <h1>模板字符串抽离 template</h1>
       </div>
   </template>
   <script>
       Vue.component("tem", {
           template: "#tem"
       })
   </script>
   ```

day03_14 组件内部的model

- 组件内的data属性必须是一个函数返回的Object对象

  ```js
  Vue.component("tem", {
      template: "#tem",
      data: function() {
          return {
              title: "title"
          }
      }
  })
  ```

- vue中的data必须是一个函数

  - 保证函数返回的对象是独立的

day03_15 父子组件通信

1. 父传子 : 通过props向子组件传递

   - 第一步 : 在父组件中定义需要传递的变量数据

     ```js
     data: {
         vue: 'Wellcome Vue',
        	list: ["海王", "海贼王", "全职高手"]
     },
     ```

   - 第二步 : 定义子组件, 并且注册在父组件中

     ```html
     <template id="sube">
         <div>
             <h2>sube</h2>
             5. 在子组件中使用父组件中传递过来的值
             {{vue}}
             {{list}}
         </div>
     </template>
     <script>
         const sube = {
             template: "#sube",
             // 4. 子组件中定义props 字符串数组接收父组件传递过来的变量
             props: ["vue", "list"]
     
         };
         const vm = new Vue({
             components: {
                 sube
             }
         })
     </script>
     ```

   - 第三步 : 使用子组件 并将父组件的属性绑定到子组件上

     ```html
     <div id='app'>
         <h1>{{vue}}</h1>
         <sube v-bind:vue='vue' :list='list'></sube>
     </div>
     ```

   - 第四步   在子组件中使用props字符串数据接收组件上绑定的变量

     ```js
     props: ["vue", "list"]
     ```

   - props接收变量的方式 使用对象

     ```js
     # 使用对象接收并限定变量类型
     props:{
         变量名: 数据类型,
         变量名:[数据类型A, 数据类型B]
     }
     
     # 使用对象接收并指定变量的多种属性
     props:{
         变量:{
             type: 变量的类型
             default: 如果不传值的默认值
             required: true 必传的值  false 不是必传的值
         }
     }
     
     # 自定义验证函数
     props:{
         valider: function(){
             return 验证结果;
         }
     }
     ```

     > props变量支持的数据类型
     >
     > - String
     > - Number
     > - Boolean
     > - Array
     > - Object
     > - Date
     > - Function
     > - Symbol
     > - 自定义类型

2. 子传父 : 通过自定义事件发送消息

   - 第一步  在子组件中定义事件并接受事件的参数

     ```html
     <button @click="subClick(item)">{{item.name}}</button>
     ```

   - 第二步 在子组件的方法中发送事件和参数

     ```js
     methods: {
         subClick(item) {
             this.$emit("subclick", item)
         }
     ```

   - 第三步  在父组件模板中的子组件标签上监听改名称的事件

     ```html
      <sube @subclick="fatherEvent"></sube>
     ```

   - 第四步  在父组件的方法中定义事件的方法和接受参数  默认第一个参数是由子组件发送事件传递的参数

     ```js
     methods: {
         fatherEvent(item) {
             console.log('fatherEvent', item)
         }
     }
     ```

day03_16 父传子 props中的驼峰标识

- 在标签中属性不支持驼峰单词, 所以父组件在子组件上绑定数据时候,如果有驼峰单词,将单词转为中横线的方式传递, 在子组件的props属性中仍然使用驼峰方式接受父组件传递的值

day03_17 子传父

- 通过事件告诉父组件在子组件发生了什么事;

day03_18_19 今日回顾

# day04

day04_01 父子通信数据双向绑定

- 通过v-model实现数据在父子组件的双向绑定

day04_02 画图分析父子组件双向绑定

day04_03 vue watch 属性

- watch作用 : 用于监听属性的改变

day04_04 父访问子

- 从父组件中拿到子组件对象, 从而操作子组件的属性
  - 父组件访问子组件: $children  或 $refs是一个数组类型,包含所有的子组件对象
    - **默认refs是空对象, 如果组件中有<组件元素 ref="key"> ,name子组件才会加入到refs对象中,对象元素的属性名称是ref的值,属性值是组件对象**
  - 子组件访问父组件: $parent  

day04_05 子访问父

- 在开发中不建议这么用,
- $parent 访问父组件
- $root 访问根组件

day04_06 slot 插槽

- 组件的插槽
  - 为了让组件更具备扩展性,让使用者决定组件内部的一些内容的展示

1. 插槽的基本使用slot : 定义组件时候预留插槽位置, 使用组件时候在组件内定义插槽内容, vue会解析并替换到slot位置

   ```html
       <div id='app'>
           <h1>{{vue}}</h1>
           <cpn>
               <button>插槽的基本使用</button>
           </cpn>
       </div>
       <template id="cpn">
           <div>
               <h2>我是子组件</h2>
               <slot></slot>
           </div>
       </template>
   ```

2. 插槽的默认值 : 可以为插槽指定默认值

   ```html
       <template id="cpn">
           <div>
               <h2>我是子组件</h2>
               <slot>
                   <button>插槽的默认值</button>
               </slot>
           </div>
       </template>
   ```

3. 插槽的替换特性 : 使用组件时候 组件内的插槽内容会全部替换掉插槽位置

day04_07 具名插槽

- 如果组件内定义了多个插槽, 需要为插槽定义名称

  ```html
  <slot name="aaa"></slot>
  <slot name="bbb"></slot>
  ```

- 要使用插槽时候需要声明替换的是那个插槽

  ```html
  <cpn name="aaa">
      <button>具名插槽</button>
  </cpn>
  ```

day04_08 编译的作用域

- 在模板内使用变量, 变量的作用域是模板对应的实例上的数据,模板内的变量都在vue实例作用域内进行编译

day04_09 作用域插槽

- 描述作用域插槽：父组件替换插槽的标签，但是内容由子组件来提供

- 获取子组件的内容

  1. 定义子组件实例, 实例中有数据对象,用于测试给父组件传递数据

     ```js
     components: {
         cpn: {
             template: "#cpn",
                 data() {
                 return {
                     list: ["aaa", "bbb", "ccc"]
                 }
             }
         }
     }
     ```

  2. 定义子组件作用域: 用指定属性绑定实例上的数据

     ```html
     <template id="cpn">
         <div>
             // 绑定的属性名称自定义
             <slot :data="list"></slot>
         </div>
     </template>
     ```

  3. 在父组件上使用插槽 : 插槽封装在template标签内 并且指定插槽的作用域slot 或指定名称的slot, 使用slot作用域可以获取绑定在子组件上的数据, 父组件可以使用到子组件的数据

     ```html
     <cpn>
         <template slot-scope='slot'>
             <span v-for="item in slot.data">{{item}}</span>
         </template>
     </cpn>
     ```

  day04_10 模块化 前端代码的复杂性

  1. 在前端疯狂扩张的年代 : 
   - 前端初期只有html和css静态页面
     - 为了让页面具有交互功能,发明了JavaScript脚本语言, 是写在`<script>`标签之中写js代码
     - 随着ajax的产生,前后端分离,前端承担了部分的业务逻辑,导致前端代码量剧增,所以JavaScript代码定义在独立的js文件中,  在htnl中使用`<script>`标签中引入js文件
     - 引入文件意味着引入引入文件中是所有变量,所有函数,如果引入很多的js文件,那么产生的更严重的代码问题, 全局命名冲突
     - 解决问题 : 前端提出模块化概念,
  
  day04_11 模块化雏形
  
  - 解决方案一: 在js文件中的文件写在匿名闭包中,但是存在的问题 存在代码复用问题, 在匿名闭包中定义一个对象, 作为匿名函数的返回值用变量接收 变量被成为模块的出口
  
  - 解决方案二：前端规范好很多的模块化规范
  
    - CommonJS Node实现了模块的
  
      ```js
      # 导出
      module.exxport={
          
      }
      # 导入
      var obj = require("../模块文件.js) 
      ```
  
    - AMD
  
    - CMD
  
    - ES6

day04_12 ES6的模块化

- 导入和导出  ES6 一个JS文件就是一个模块

  ```js
  # 导出
  export let 变量 = 值;	// 直接导出
  export {
  	变量A,变量B
  }
  export function(){}		// 批量导出
  
  
  export default(){		// 一个模块只能有一个默认导出，导出时候没有名称，导入时候自定义命名
      
  }
  # 导入
  import obj from 'xxx.js';			// 接受批量导出
	import {解构语法} from 'xxx.js';	// 结构方式导入
  import 自定义命名 form 'xxx.js';	// 自定义命名只能接受默认导出的东西
  import 变量 as 别名 from  'xxx.js'; // 导入可以为导出的名称起别名
  import * as 别名 from  'xxx.js'; // 统一导入指定模块的所有导出
  ```
  
- 使用script脚本使用es6模块化功能，需要在script脚本上添加type=module属性

  ```html
   <script src="./es6_ma.js"  type="module"></script>
  ```

day04_13 webpack介绍和安装

day04_14 webpack基本使用

- 在JavaScript的开发时候制定一个入口文件
- JavaScript的开发在src目录中使用任何模块化进行开发
- 开发完成后执行webpack命令打包入口文件输出到dist目录中
- 项目的index.html只引入打包后的打包文件即可在浏览器执行

day04_15 webpack.cofig.js 和 package.json

day04_16 webpack 的css配置

