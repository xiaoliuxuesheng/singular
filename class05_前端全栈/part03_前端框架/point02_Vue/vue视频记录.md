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

# day05

day05_01 webpack 的less配置

dat05_02 webpack-图片文件的处理

day05_03 webpack-ES6转ES5的babel

day05_04 webpack vue配置

1. 初始化webpack项目结构,下载vue

   ```sh
   npm install vue --save
   ```

   - runtime-only：vue构建版本时候的一类版本，代码中不可以有任何template
   - runtime-compiler：代码中可以有template

2. 默认是runtime-only，添加webpack.config.js的配置文件修改为runtime-compiler版本可以解析template

   ```js
   resolve: {
       alias: {
           'vue$': 'vue/dist/vue.esm.js' // 用 webpack 1 时需用 'vue/dist/vue.common.js'
       }
   }
   ```

3. 打包运行测试vue脚本

   ```js
   import Vue from 'vue'
   
   const vm = new Vue({
       el: '#app',
       data: {
           msg: "webpack vue"
       }
   })
   ```

day05_05 创建Vue时template和el关系

1. SPA（单页面应用）：通过路由跳转实现页面，所以在vue开发中一般只有一个入口的HTML页面，通过vue路由跳转其他页面；所以在入口html页面中只有一个根vue实例的根元素；所以在开发中的HTML是不会修改的

2. 那么如果需要在HTML中引入data中的属性或methods中的方法，则需要在vue实例中定义处理el之外的template属性；el和template的区别

   1. 在vue的实例同时有el和template，则template属性中的内容在编译的时候会将模板的内容复制到#app标签内进行渲染

   ```js
   import Vue from 'vue'
   const vm = new Vue({
       el: '#app',
       template: `<div>{{msg}}</div>`,
       data: {
           msg: "webpack vue"
       }
   })
   ```

day05_06 Vue的终极使用方案

1. vue实例中现在的方案是写template模板，需要将template进一步抽取

   ```js
   import Vue from 'vue'
   const vm = new Vue({
       el: '#app',
       // 将 el: '#app' 中的内容抽取到vue实例的template属性中
       template: `<div>{{msg}}</div>`,
       data: {
           msg: "webpack vue"
       }
   })
   ```

2. 将template对象抽取为template的模块

   ```js
   
   import Vue from 'vue'
   
   // 将template模板内容抽取为组件, 在vue实例中注册组件
   const App = {
       template: `<div>{{msg}}</div>`,
       data() {
           return {
               msg: "webpack vue"
           }
       }
   }
   
   const vm = new Vue({
       el: '#app',
       template: `<app></app>`,
       components: {
           App
       }
   })
   ```

3. 将组件抽取为模块：

   - 抽取的模块 app.js

     ```js
     export default {
         template: `<div>{{msg}}</div>`,
         data() {
             return {
                 msg: "webpack vue"
             }
         }
     }
     ```

   - 在入口的index.js中引入模块

     ```js
     import Vue from 'vue'
     import App from './vue/app.js'
     
     const vm = new Vue({
         el: '#app',
         template: `<app></app>`,
         components: {
             App
         }
     })
     ```

4. 将template模块修改为.vue模块

   - 定义vue模块

     ```html
     <template>
         <div>{{msg}}</div>
     </template>
     
     <script>
     export default {
         name:"App",
         data() {
             return {
                 msg: "webpack vue"
             }
         }
     }
     </script>
     
     <style scoped>
     </style>
     ```

   - 入口index.js引入模块：app.vue

     ```js
     import Vue from 'vue'
     import App from './vue/app.vue'
     
     const vm = new Vue({
         el: '#app',
         template: `<app></app>`,
         components: {
             App
         }
     })
     ```

   - app.vue模块vue是不识别的，需要下载vue loader

     ```sh
     npm config set registry http://registry.npm.taobao.org
     npm i vue-loader vue-template-compiler  vue-html-loader vue-style-loader --save-dve
     ```

   - 配置vue-loader

     ```js
     const { resolve } = require('path')
     const VueLoaderPlugin = require('vue-loader/lib/plugin')
     
     module.exports = {
         mode: 'development',
         entry: './src/index.js',
         output: {
             path: resolve(__dirname, 'dist')
         },
         module: {
             rules: [{
                 test: /\.vue$/,
                 loader: 'vue-loader'
             }]
         },
         plugins: [
             new VueLoaderPlugin()
         ],
         resolve: {
             alias: {
                 'vue$': 'vue/dist/vue.esm.js' // 用 webpack 1 时需用 'vue/dist/vue.common.js'
             }
         }
     }
     ```

5. 需要定义其他组件，有app.vue组件进行引入

day05_07-(掌握)webpack-横幅Plugin的使用

1. plugin是什么

   1. plugin是webpack插件，通常作用是对现有的架构进行扩展
   2. webpack的主要功能是比如打包、压缩、命名等功能的扩展

2. loader和plugin的区别

   1. loader是对现有内容的转换，是一个转换器
   2. plugin插件是对webpack本身的扩展，是一个扩展器

3. plugin的使用步骤

   1. 第一：下载插件
   2. 第二：（导入）引入插件
   3. 第三：在plugins配置中new插件并添加必要的配置项

4. 版权声明插件

   - webpack.BannerPlugin

     ```js
     import webpack from 'webpack'
     plugins: [
     	//... ... 
         new webpack.BannerPlugin("最终版权:xiaoliuxuesheng")
     ]
     ```

day05_08-(掌握)webpack-HtmlWebpackPlugin的使用

- HtmlWebpackPlugin：作用是打包后根据指定html模板或生成新的html文件，并将打包的资源文件添加到html的指定的标签中

- 下载插件

  ```sh
  npm install html-webpack-plugin --save-dev
  ```

- 导入插件并配置：如果不指定模板，则会生成新的HTML文件

  ```js
  const HtmlWebpackPlugin = require('html-webpack-plugin')    
  plugins: [
  	// ... ...
      new HtmlWebpackPlugin({
          template: './src/index.html'
      })
  ]
  ```

day05_09-(掌握)webpack-UglifyjsWebpackPlugin的使用

- bable-loader

  - 下载

    ```sh
    
    ```

  - 配置

    ```js
    
    ```

---

- UglifyjsWebpackPlugin：压缩（丑化）就是文件，UglifyjsWebpackPlugin不能压缩es6的代码文件

- 下载

  ```sh
  npm install uglifyjs-webpack-plugin --save-dve
  ```

- 引入插件配置

  ```js
   const UglifyjsWebpackPlugin = require("uglifyjs-webpack-plugin")
   plugins: [
  	// .. ..
       new UglifyjsWebpackPlugin()
   ]
  ```

day05_10-(掌握)webpack-dev-server搭建本地服务器

- 下载

  ```sh
  npm install webpack-dev-server --save-dev
  ```

- 配置webpack

  ```js
  
  ```

day05_11-(掌握)webpack-配置文件的分离

- config目录下存放配置文件

  - base.config.js：公共的配置
  - prod.config.js：生成配置
  - dev.config.js：测试环境的配置
  - uat.config.js：

- 配置文件合并插件：webpack-merge

  ```sh
  npm install webpack-merge --save--dev
  ```

- 合并配置文件：prod、uat、dev

  ```js
  consit webpackMerge = require('webpack-merge')
  consit bsseConfig = require('./base.config.js')
  
  module.export = webpackMerge(bsseConfig,{
      plugins:[
          
      ]
  })
  ```

- 启动加载指定配置文件：package.json

  ```js
  "scripts": {
      "prod": "webpack-dev-server --config ./config/prod.config.js",
  	"uat": "webpack-dev-server --config ./config/uat.config.js",
  	"dev": "webpack-dev-server --config ./config/dev.config.js"
  }
  ```

- 打包会打包在配置文件所在的目录，修改webpack输出目录的路径

day05_12-(理解)vuecli-脚手架的介绍和安装

- 脚手架：是cli的俗称，使用大型项目时候，开发的项目目录，版本依赖，统一配置都需要管理，可以通过脚手架工具完成统一的基础工作；cli是命令行界面：vue-cli可以快速搭建Vue的开发环境和Webpack的配置

- 脚手架的使用前提：node8.9+、npm、webpack、

  ```sh
  node --version
  npm --version
  webpack --version
  webpack-cli --version
  ```

- vue脚手架使用

  1. 安装vue脚手架3：在脚手架3上可以使用脚手架2

     ```sh
     # 安装脚手架3
     npm install @vue/cli -g
     
     # 如果需要使用脚手架3构建脚手架2的项目,拉取一个脚手架2模板
     npm install @vue/cli-init -g
     ```

day05_13-(掌握)vuecli-CLI2初始化项目过程

- 脚手架3创建脚手架2的项目

  - 创建脚手架2项目：会自动生成一些模板，根据项目名创建一个文件夹

    ```sh
    vue init webpack 项目名称
    ```

  - Project name：输入项目名称（默认是文件夹）

  - Project description：项目描述

  - Author：gitconfig的全局信息

  - Runtime + Compiler | **Runtime-only**：上下键选择

  - Install Router：是否按照路由（Y）

  - Use ESLint：是否要代码校验（Y）

    - Standard：标准规范
    - Airbnb：
    - none：自定义

  - Set up unit test：单元测试（N）

  - Setup e2e test：端到端测试（N）

  - Should we run

    - num
    - yarn

day05_14-(理解)vuecli-CLI2的目录结构解析

- vue脚手架2的目录结构介绍
  - build：从package.json开始读
  - config：配置文件
  - static：静态资源文件夹
  - src：源码包
    - assets：
    - components：
  - .babelrc：babel配置，详细指定es转换环境
  - .editorconfig：代码风格配置
  - package-lock.json：安装的npm包的真实版本

day05_15-(了解)知识回顾

- 

# day06

day06_01-(掌握)安装CLI错误和ESLint规范

- ESLint代码检测
  - useESlint:false 关闭代码检测

day06_02-(理解)runtime-compiler和runtime-only的区别

- runtime-compiler：首先将App组件注册，最后在template中使用

  ```js
  new Vue({
    el: '#app',
    components: { App },
    template: '<App/>'
  })
  ```

- runtime-only：直接将template转为虚拟dom，效率更高；用到的vue源代码更少；

  ```js
  new Vue({
    el: '#app',
    render: h => h(App)
  })
  ```

  - vue运行流程：①template传给vue时候，vue内部将template设置到options中②将template解析成ast（抽象语法树）③抽象语法树再编译为render函数④根据render函数转为虚拟DOM树⑤虚拟DOM最后渲染为DOM页面

- render函数：

  ```js
  // 组件
  const cpn = {
      template:""
  }
  
  render: function(creatElement){
      // 1. 用法1 : 将创建的元素替换el的DOM
      return creatElement('标签名称',{标签属性:标签值},[标签的内容])
      // 2. 用法2 : 传入一个组件对象
      return creatElement(cpn)
  }
  ```

- 引入vue模块时称为对象的时候，已经将template解析为render函数了

day06_03-(掌握)VueCLI3创建项目和目录结构

- cli3介绍

  - vue-cli3是基于webpack4打造
  - vue-cli3的设计原则是0配置，移除了配置目录：build和config
  - vue-cli3提供了vue ui命令，用于可视化配置，创建vue脚手架项目
  - 移除static文件夹，提供public文件夹中，并且index.html移动到public目录中

- 使用cli3创建项目

  1. 第一步创建项目

     ```sh
     vue create 项目名称
     ```

  2. pick preset：default、**Manually select features（手动）**

  3. check features：空格选择（**Babel**、Router、Vuex、css、Typesript、pwa）回车

  4. config 是独立还是整合到package.josn：**dedicated config file**

  5. 是否保存模板：保存的保存名称

  6. 选择npm

- vue-cli3项目目录结构

  - public
  - src

- vue入口函数说明

  ```js
  new Vue({
      (h) => 
  }).$mount("#app")
  ```

day06_04-(掌握)VueCLI3配置文件的查看和修改

- 使用vue ui指令，启动一个本地服务，打开vue项目管理器

- 在node_modules/@vue/cli-service/webpack.config.js中隐藏的全部配置文件

- 自定义：需要在项目中添加配置：固定名称（vue.config.js）

  ```js
  module.exports = {
  	// 添加配置后,会覆盖默认配置
  }
  ```

day06_05-(掌握)箭头函数的使用和this指向

- ES6箭头函数：①无参数②有一个参数不要括号③有多个参数要括号④有一个函数体不要大括号⑤多个函数体要大括号

  ```js
  let func = function(){}
  
  let func = () => {}
  ```

- 箭头函数的this和函数的this

  - 箭头函数：使用场景，将一个函数作为参数传递时候使用箭头函数比较多
    - 箭头函数的this指向的是最近作用域的this，找最近的this

day06_06-(理解)什么是路由和其中映射关系

1. 路由：是网络工程中的一个概念，百科中路由的定义就是通过互联的网络把信息从源地址传输到目的地的活动；
2. 学习内容
   - vue-router基本使用
   - vue-router嵌套路由
   - vue-router参数传递
   - vue-router导航守卫
   - keep-alive

day06_07-(理解)前端渲染后端渲染和前端路由后端路由

1. 后端路由：是由服务器负责url和页面的映射关系
2. 前后端分离阶段：ajax负责数据请求，服务端不再负责页面映射，
3. 单页面富应用阶段：真个网站只有一个页面，前端发送一个url，不会向服务器发送请求，而是跳转到
   1. 前端路由：

day06_08-(掌握)url的hash和HTML5的history

1. url的hash：也是是锚点（#）本质上也是改变location的href属性；通过location.hash改变href的值而且页面不刷新
2. html5的history模式：pushStatus（history.pushStatus({},'','url')）,栈结构,向栈中push url,先进后出
3. html5的history模式：replaceStatus，替换url，不会返回
4. html5的history模式：go（前进后退），跳转到history中的
   1. history.back() = history.go(-1)
   2. history.forward()=history.go(1)

day06_09-(掌握)vue-router-安装和配置方式

1. 前端三大框架都有路由技术的实现，vue中的vue-router是vue官方提供的插件，与vue深度集成，是基于路由和组件

2. 安装vue-router

   ```sh
   npm install vue-router --save
   ```

3. 导入路由对象，是vue的一个插件，可以通过Vue.use来安装路由

   1. 第一步导入路由对象

      ```js
      import Router from 'vue-router'
      ```

   2. 调用Vue.use（VueRouter）

      ```js
      import Vue from 'vue'
      Vue.use(Router)
      ```

   3. 第二步创建路由实例：传入路由映射配置：如果导入一个目录会默认导入目录中的index名称的文件。

      ```js
      import HelloWorld from '@/components/HelloWorld'
      new Router({
        routes: [
          {
            path: '/',
            name: 'HelloWorld',
            component: HelloWorld
          }
        ]
      })
      ```

   4. 第三步在Vue实例中挂载创建的路由 

      ```js
      
      new Vue({
        el: '#app',
        router,
        render: h => h(App)
      })
      ```

day06_10-(掌握)路由映射配置和呈现出来

1. 路由映射的配置的基本步骤

   1. 创建一些组件

   2. 添加映射配置

      ```js
      routes: [
          {
              path: '/',
              name: 'HelloWorld',
              component: HelloWorld
          }
      ]
      ```

   3. 在APP组件中定义路由连接:

      ```html
      <div id='app'>
          <router-link to='/home'>首页</router-link>
          <router-view></router-view>
      </div>
      ```

2. router-link是一个全局组件,默认会被渲染为a标签

3. router-view占位,用于显示路由映射组件的内容,路由切换时候，切换的是挂载的组件

day06_11-(掌握)路由的默认值和修改为history模式

1. 路由的默认值

   ```js
   routes: [
       {
           path: '',
           redirect: '/重定向到默认路径'
       }
   ]
   ```

2. 默认路径显示的方式是hash，可以修改为history模式

   ```js
   const VueRouter = new Router({
       routes,
       mode: 'history'
   })
   ```

day06_12-(掌握)router-link的其他属性补充

1. router-link其他属性

   1. to属性:跳转的路由链接

   2. tag属性：默认被渲染为a标签，修改router-link渲染的标签名称

   3. replace属性：不需要属性值，说明这个链接是replaceStatus，不可以使用history功能

   4. 点击会给指定元素添加两个类名：router-link-active、router-link-exact-active，修改默认的class名称添加link属性active-class，也可以全局修改

      ```js
      const VueRouter = new Router({
          routes,
          mode: 'history',
          linkActiveClass:'自定义类名'
      })
      ```

day06_13-(掌握)通过代码跳转路由

- 通过代码跳转路径

  ```js
  this.$router.push('/路由')
  this.$router.replace('/路由')
  ```

# day07

day07_01 - vue - router - 动态路由的使用

1. 动态路由：rest风格请求的动态ID,在path后的使用冒号指定动态值的属性名称
2. 如果需要绑定变量,to属性修改为属性绑定:to="'/路由/' + 变量"
3. 获取动态路由的参数:{{}$route.params.属性}  $route是当前激活的路由

day07_02 - vue - router - 打包文件的解析

- vue项目打包后将css和js进行分包,js也会划分为三个文件

  - app:是值当前应用程序的所有业务代码

  - vendor:提供商 , 指引入第三方的代码,比如vue/vue-router
  - mainfast:为打包的代码做底层支撑的,

day07_03 - vue - router - 路由懒加载的使用

- 路由懒加载：默认所有路由都会打包到appjs中，导致appjs太大，一次请求耗费资源，需要将资源根据路由进行拆分，一个路由对应一个js，只需要加载当前路由对应的js，其他路由对应的js先不需要

- 路由懒加载的配置:在使用路径的时候才动态的请求

  ```js
  routes: [
      {
          path: '/',
          name: 'HelloWorld',
          component: () => import('/vue/xxx.vue')
      }
  ]
  ```

day07_04 - vue - router - 路由的嵌套使用

- 使用多层路径,父级路由下可以有多个子路由

- 路由嵌套

  - 首先在组件中引入子组件,因为需要在组件中定义router-view标签,占位显示子组件的内容,path的/不能省

    ```js
    routes: [
        {
            path: '/',
            name: 'HelloWorld',
            component: () => import('/vue/xxx.vue'),
            children:[
            	{path:'/sub',component: () => import('/vue/xxx.vue')}
            ]
        }
    ]
    ```

day07_05 - vue - router - 参数传递(一)

- 方式一:$route.param的获取动态路由的值

- 方式二:query的方式传递，对象中使用query的key作为传递方式，最后形成url?key=value&key=value格式

  ```html
  <router-link :to="{path:'',query:{key:val}}"></router-link>
  <div>
      {{$route.query.key}}
  </div>
  ```

day07_06 - vue - router - 参数传递(二)

- 使用代码方式传递query参数

  ```js
  this.$route.push({
      path:'',
      query:{
          
      }
  })
  ```

day07_07 - vue - router - router和route的由来

- router：this.$router是注册在vue实例上的router
- route:所有路由配置处于活跃的一个route对象
- 所有的组件都继承自Vue原型,源码分析

day07_08 - vue - router - 全局导航守卫

- 监听路由跳转的过程：在监听过程函数处理一些事情

  ```js
  const VueRouter = new Router({
      routes,
      mode: 'history',
      linkActiveClass:'自定义类名'
  })
  // 路由可以添加meta属性
  routes: [
      {
          path: '/',
          name: 'HelloWorld',
          component: () => import('/vue/xxx.vue'),
          meta:{
          	key:value
      	}
      }
  ]
  // 前置守卫
  VueRouter.beforeEach((to,form,next)=>{
      打印to对象获取属性
      next()
  })
  // 后置钩子
  VueRouter.afterEach((to,form,next)=>{
      打印to对象获取属性
      next()
  })
  ```

day07_09 - vue - router - 导航守卫的补充

- 什么时候使用导航守卫：路由独享守卫（配置在路由之中）、组件内的守卫（定义在组件内的守卫函数）

day07_10 - vue - router - keep - alive及其他问题

- keep-alive：路由跳转后再返回原理的路由，原来的路由会失去状态，重新加载一次，keep-alive是vue内置的一个组件，可以使被包含的的组件保留状态，为避免重新渲染，所有匹配的路径的路由都会被缓存

  ```html
  <keep-alive>
  	<router-view></router-view>
  </keep-alive>
  ```

  - activeted()
  - deactived()会生效

day07_11 - vue - router - keep - alive属性介绍

- include：包含，如果有多个用逗号分隔，但是不能加空格
- exclude：不包含，路由的name的值

day07_12 - tabbar - 基本结构的搭建

- 案例演示：tabBar的封装

day07_13 - tabbar - TabBar和TabBarItem组件封装

day07_14 - tabbar - 给TabBarItem传入active图片

day07_15 - tabbar - TabBarItem和路由结合效果

day07_16 - tabbar - TabBarItem的颜色动态控制

day07_17 - (了解) 知识回顾