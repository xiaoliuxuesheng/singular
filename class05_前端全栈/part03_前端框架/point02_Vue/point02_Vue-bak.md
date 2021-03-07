| 单词          | 音标          | 注释                                                         |
| ------------- | ------------- | ------------------------------------------------------------ |
| **cloak**     | /kloʊk/       | n. （尤指旧时的）披风，斗篷；遮盖物；伪装，幌子；（复数）衣帽间，行李寄存处，盥洗室；（承担的）主要角色<br />v. 遮掩；隐匿；掩盖（事实、情感等）；给……披斗篷 |
| **prevent**   | /prɪ'vent/    | vt. 预防，防止；阻止<br/>vi. 妨碍，阻止                      |
| **capture**   | /'kæptʃər/    | vt. 俘获；夺得；捕捉，拍摄，录制<br />n. 捕获；战利品，俘虏  |
| **native**    | /ˈneɪtɪv/     | adj. 本国的；土著的；天然的；与生俱来的；天赋的<br />n. 本地人；土产；当地居民 |
| **passive**   | /ˈpæsɪv/      | adj. 被动的，消极的；被动语态的<br />n. 被动语态             |
| **directive** | /daɪ'rektɪv/  | n. 指示；指令<br />adj. 指导的；管理的                       |
| **component** | /kəm'poʊnənt/ | n. 组成部分；成分；组件，元件<br />adj. 组成的；构成的       |
| **modifier**  | /ˈmɑːdɪfaɪər/ | n. [助剂] 改性剂；[语] 修饰语；修正的人                      |
| **compute**   | /kəmˈpjuːt/   | vt. 计算；估算；用计算机计算<br />vi. 计算；估算；推断<br />n. 计算；估计；推断 |

# 第一章 Vue基础

## 1.1 Vue特点

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Vue是一个JavaScript的渐进式框架：Vue框架提供了部分的基础服务和API；渐进式：声明式渲染 → 组件系统 → 客户端路由 → 集中式状态管理 → 项目管理，可以使用使用方案中的一部分或者全部，意味着Vue可以作为项目的一部分嵌入其中，或者希望在更多的功能上使用Vue技术，那么可以使用Vue逐渐替换原来的技术功能；

- 易用：熟悉HTML、CSS、JavaScript便可以快速上手Vue
- 灵活：在一个JavaScript库和前端框架之间可以做到伸缩自如，也可以用于APP项目开发
- 高效：20K的运行大小，超快高效虚拟DOM，较少不必要的DOM操作

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Vue 只关注视图层， 采用自底向上增量开发的设计。Vue 的目标是通过尽可能简单的 API 实现响应的数据绑定和组合的视图组件；Vue中还具备WEB开发中的高级功能：

- 解耦视图和数据
- 可复用组件
- 前端路由技术
- 状态管理
- 虚拟DOM

<font size=4 color=blue>**1. 使用CDN引入**</font>

- 开发环境版本，包含了有帮助的命令行警告

  ```html
  <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
  ```

- 生产环境版本，优化了尺寸和速度

  ```html
  <script src="https://cdn.jsdelivr.net/npm/vue"></script>
  ```

<font size=4 color=blue>**2. 下载Vue脚本并引入**</font>

- 开发环境：https://vuejs.org/js/vue.js
- 生产环境：https://vuejs.org/js/vue.min.js

<font size=4 color=blue>**3. 使用NPM安装**</font>

```sh
npm install vue
```

## 1.4 Vue Chrome插件

1. 下载插件工具包

   ```sh
   https://codeload.github.com/vuejs/vue-devtools/zip/master
   ```

2. NPM初始化并构建插件

   ```sh
   npm install
   npm run build
   ```

3. 修改配置文件：**chrome** 文件夹下的**manifest.json** 文件

   ```sh
   "persistent": true
   ```

4. 打开chrome浏览器，点击相关菜单，打开扩展程序页面点击“加载已解压的扩展程序”按钮，在打开的文件夹选择窗口

## 1.5 前端的MVVM和后端MVC

<font size=4 color=blue>**MVC:后端开发分层思想**</font>

- M:Model - 表示模型，主要用于存放数据
- V:View - 视图，表示展示数据的页面
- C:Controller - 控制器，用于接收视图的参数构造数据并返回给视图

<font size=4 color=blue>**MVVC:前端分层开发思想**</font>

<img src="https://s1.ax1x.com/2020/05/01/JOFGzq.png" alt="JOFGzq.png" width=600 />

- M:Model : 页面中的单独数据
- V:View: 页面展示结构，在前端开发中通常值DOM元素
- VM:View Model 核心是视图模型层:是M和V的调度者，功能一可以实现数据绑定，功能二是DOM监听

## 1.6 Vue入门

1. 入门案例

   ```html
   <body>
       <div id='app'>{{msg}}</div>
       <script src="./commons/js/vue.js"></script>
       <script>
           let vue = new Vue({
               el:"#app",
               data:{
                   msg:"你好啊"
               }
           })
       </script>
   </body>
   ```

2. Vue编程范式说明：声明式编程：只需要声明{{数据属性}}，就可以显示模型中的数据

   - VM：在编程中首先需要引入Vue，并构建Vue对象，并指明需要关联的页面区域元素，这个Vue对象便可以作为数据Model和View视图的调度者
   
   - V：表示页面中的一个HTML元素，这个元素会在页面中展示特定的区域，这个区域中的数据会交给VM对象
   
   - M：数据模型，会定义在当前元素对应的VM对象中，可能会包括基本数据，事件方法等数据
   

# 第二章 Vue与实例属性

## 2.1 API

| 全局配置                | 说明      | 选项 / DOM        | 说明     | 实例方法 / 事件         | 说明     |
| ----------------------- | --------- | ----------------- | -------- | ----------------------- | -------- |
| keyCodes                | 键盘键码  | el                |          | vm.$on                  | 定义事件 |
| optionMergeStrategies   |           | template          |          | vm.$once                | 监听单次 |
| devtools                |           | render            |          | vm.$off                 | 移除事件 |
| errorHandler            |           | renderError       |          | vm.$emit                | 触发事件 |
| warnHandler             |           | **选项 / 资源**   | **说明** | **实例方法 / 生命周期** | **说明** |
| ignoredElements         |           | directives        |          | vm.$mount               |          |
| silent                  |           | filters           | 使得啊   | vm.$forceUpdate         |          |
| performance             |           | components        |          | vm.$nextTick            |          |
| productionTip           |           | **选项 / 组合**   | **说明** | vm.$destroy             |          |
| **全局 API**            | **说明**  | parent            |          | **指令**                | **说明** |
| Vue.extend              | 组件构造  | mixins            |          | v-text                  | 文本填充 |
| Vue.component           | 组件注册  | extends           |          | v-html                  | html填充 |
| Vue.directive           |           | provide / inject  |          | v-show                  | 是否显示 |
| Vue.set                 |           | **选项 / 其它**   | **说明** | v-if                    | 是否渲染 |
| Vue.delete              |           | name              |          | v-else                  |          |
| Vue.filter              |           | delimiters        |          | v-else-if               |          |
| Vue.nextTick            |           | functional        |          | v-for                   | 迭代     |
| Vue.use                 |           | model             |          | v-on                    | 事件绑定 |
| Vue.mixin               |           | inheritAttrs      |          | v-bind                  | 属性绑定 |
| Vue.compile             |           | comments          |          | v-model                 | 双向绑定 |
| Vue.observable          |           | **实例 property** | **说明** | v-slot                  |          |
| Vue.version             |           | vm.$data          |          | v-pre                   |          |
| **选项 / 数据**         | **说明**  | vm.$props         |          | v-cloak                 |          |
| data                    | model数据 | vm.$el            |          | v-once                  |          |
| props                   |           | vm.$options       |          | **特殊 attribute**      | **说明** |
| propsData               |           | vm.$parent        |          | key                     |          |
| computed                | 属性计算  | vm.$root          |          | ref                     |          |
| methods                 | 方法/函数 | vm.$children      |          | is                      |          |
| watch                   | 监听器    | vm.$slots         |          | slot                    |          |
| **选项 / 生命周期钩子** | **说明**  | vm.$scopedSlots   |          | slot-scope              |          |
| beforeCreate            |           | vm.$refs          |          | scope                   |          |
| created                 |           | vm.$isServer      |          | **内置的组件**          | **说明** |
| beforeMount             |           | vm.$attrs         |          | component               |          |
| mounted                 |           | vm.$listeners     |          | transition              |          |
| beforeUpdate            |           | 实例方法 / 数据   | **说明** | transition-group        |          |
| updated                 |           | vm.$watch         |          | keep-alive              |          |
| activated               |           | vm.$set           |          | slot                    |          |
| deactivated             |           | vm.$delete        |          |                         |          |
| beforeDestroy           |           |                   |          |                         |          |
| destroyed               |           |                   |          |                         |          |
| errorCaptured           |           |                   |          |                         |          |

## 2.2 Vue实例

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**创建Vue实例**：一个 Vue 应用由一个通过 new Vue 创建的根 Vue 实例，当创建一个 Vue 实例时，你可以传入一个选项对象，可以通过这些选项来创建你想要的行为，虽然没有完全遵循 MVVM 模型，但是通过Vue选项的功能可以高效是完成MVVM模式开发。

```js
var vm = new Vue({
  // 选项
})
```

## 2.2 Vue选项 - DOM

1. <font size=4 style="color:blue">**el**</font>：该选项的值是一个js选择器：提供一个在页面上已存在的 DOM 元素作为 Vue 实例的挂载目标，在实例挂载之后，元素可以用 `vm.$el` 访问；如果 `render` 函数和 `template` property 都不存在，挂载 DOM 元素的 HTML 会被提取出来用作模板；

   ```js
   var vm = new Vue({
     el:'#app'
   })
   ```

2. <font size=4 color=blue>**template**</font>：该选项值是字符串，可以是html字符串实例、或者是`<template>`标签的id选择符、用 `<script type="x-template">` 包含模板。用作组件化开发

## 2.3 Vue选项 - 数据

1. <font size=4 color=blue>**data**</font>：Vue 实例的数据对象（含有零个或多个的 key/value 对），Vue 将会递归将 data 的 property 转换为 getter/setter，从而让 data 的 property 能够响应数据变化；实例创建之后，可以通过 `vm.$data` 访问原始数据对象；以 `_` 或 `$` 开头的 property **不会**被 Vue 实例代理，因为它们可能和 Vue 内置的 property、API 方法冲突。你可以使用例如 `vm.$data._property` 的方式访问这些 property；当一个**组件**被定义，`data` 必须声明为返回一个初始数据对象的函数

   ```js
   // Vue 实例
   var vm = new Vue({
     data: { a: 1 }
   })
   
   // Vue组件
   var Component = Vue.extend({
     data: function () {
       return { a: 1 }
     }
   })
   ```

2. <font size=4 color=blue>**methods**</font>：定义方法到 Vue 实例中。可以直接通过 VM 实例访问这些方法，或者在指令表达式中使用。方法中的 this 自动绑定为 Vue 实例。注意，不应该使用箭头函数来定义 method 函数 (例如 plus: () => this.a++)。理由是箭头函数绑定了父级作用域的上下文，所以 this 将不会按照期望指向 Vue 实例，this.a 将是 undefined。

   ```js
   var vm = new Vue({
     data: { a: 1 },
     methods: {
       plus: function () {
         this.a++
       }
     }
   })
   vm.plus()
   vm.a // 2
   ```

3. <font size=4 color=blue>**watch**</font>：监听数据模型中的数据，数据一旦发生变化，就通知侦听器所绑定的方法；使用场景是数据变化时候执行异步并或开销大的操作；Vue 实例将会在实例化时调用 `$watch()`，遍历 watch 对象的每一个 property。

   ```js
   let vue = new Vue({
       ... ...
       watch:{
           监听属性名称:function(变化后的值){
               
           }
       }
   })
   ```

4. <font size=4 color=blue>**computed**</font>：

   - **计算属性的使用**：计算属性是指表达式的技术逻辑可能会比较复杂，使用计算属性使模板内容更加简洁

   - **计算属性的定义**：在计算属性的函数中可以获取到模型对象中的数据，技术属性是依赖与model中的数据；

     ```js
     let vue = new Vue({
         ... ...
         computed:{
             计算属性名称:function(){
             	return 计算结果;
             }
         }
     })
     ```

   - **计算属性的使用**：直接使用函数名称即可，不可以使用函数调用的格式

     ```js
     {{计算属性名称}}
     ```

   - **计算属性与方法的区别**：计算属性是基于他们的依赖进行缓存的，方法不存在缓存

## 2.4 Vue选项 - 生命周期钩子

<img src="https://s1.ax1x.com/2020/05/03/JxfufH.png" alt="JxfufH.png" border="0" />

- <font size=4 color=blue>**挂载**</font>：初始化相关属性
  1. **beforeCreate**：在实例初始化之后，数据观测 (data observer) 和 event/watcher 事件配置之前被调用
  2. **created**：在实例创建完成后被立即调用。在这一步，实例已完成以下的配置：数据观测 (data observer)，property 和方法的运算，watch/event 事件回调。然而，挂载阶段还没开始，`$el` property 目前尚不可用。
  3. **beforeMount**：在挂载开始之前被调用：相关的 render 函数首次被调用，**该钩子在服务器端渲染期间不被调用**
  4. **mounted**：实例被挂载后调用，这时 `el` 被新创建的 `vm.$el` 替换了。如果根实例挂载到了一个文档内的元素上，当 `mounted` 被调用时 `vm.$el` 也在文档内。**该钩子在服务器端渲染期间不被调用**
- <font size=4 color=blue>**更新**</font>：元素或组件的变更操作
  1. **beforeUpdate**：数据更新时调用，发生在虚拟 DOM 打补丁之前。这里适合在更新之前访问现有的 DOM，比如手动移除已添加的事件监听器。**该钩子在服务器端渲染期间不被调用，因为只有初次渲染会在服务端进行。**
  2. **updated**：由于数据更改导致的虚拟 DOM 重新渲染和打补丁，在这之后会调用该钩子。当这个钩子被调用时，组件 DOM 已经更新，所以你现在可以执行依赖于 DOM 的操作。然而在大多数情况下，你应该避免在此期间更改状态。如果要相应状态改变，通常最好使用计算属性或 watcher 取而代之。
  3. **activated**：被 keep-alive 缓存的组件激活时调用。**该钩子在服务器端渲染期间不被调用。**
- <font size=4 color=blue>**销毁**</font>：销毁相关属性
  1. **deactivated**：被 keep-alive 缓存的组件停用时调用。**该钩子在服务器端渲染期间不被调用。**
  2. **beforeDestroy**：实例销毁之前调用。在这一步，实例仍然完全可用。**该钩子在服务器端渲染期间不被调用。**
  3. **destroyed**：实例销毁后调用。该钩子被调用后，对应 Vue 实例的所有指令都被解绑，所有的事件监听器被移除，所有的子实例也都被销毁。**该钩子在服务器端渲染期间不被调用。**
- <font size=4 color=blue>**异常**</font>：
  1. **errorCaptured**：当捕获一个来自子孙组件的错误时被调用。此钩子会收到三个参数：错误对象、发生错误的组件实例以及一个包含错误来源信息的字符串。此钩子可以返回 false 以阻止该错误继续向上传播。

## 2.5 Vue指令

### 1. 差值表达式 

- 差值表达式的格式

  ```js
  {{data对象中的key}}
  ```

- **差值表达式的特点**：

  - 差值表达式加载过程：浏览器加载模型对象中数据的过程中，首先是会加载HTML页面的DOM元素，所以首先会在页面显示`{{差值表达式}}`字符串，其次会加载外部的Vue的脚本文件，最后会new Vue对象，并且将对象中模型中的值赋值给产值表达式，最终完成数据展示，如果加载Vue延迟会在浏览器中显示出差值表达式。
  - 差值表达式会将data对象中的值以纯文本的方式加载到页面中；
  - 可以在差值表达式的前后任意添加字符串

### 2. 指令 v-cloak

- 解决差值表达式闪烁的问题：定义v-cloak样式中隐藏元素的显示，在内存中替换数据后完成数据展示

  ```html
  <style>
      [v-cloak]{
          display: none;
      }
  </style>
  ```

- 在差值表达式的DOM元素上定义v-cloak属性，并设置该属性的显示样式为none，当Vue初始化并加载完成后，Vue对象会将改区域中具有改属性的显示样式删除，从而解决差值表达式的闪烁问题；在标签内部使用差值表达式获取到model对象中的指定属性名称的数据，可以在数据前后添加其他字符；

  ```html
  <div v-cloak>{{msg}}</div>
  ```

### 3. 数据绑定指令 v-bind v-text v-html v-model v-pre v-once

- <font size=4 color=blue>**v-text**</font>：纯文本填充，相比差值表达式更简洁，**指定标签中的文本会被属性值替换**

  ```html
  <div v-text='Model属性名称'></div>
  ```

- <font size=4 color=blue>**v-html**</font>：内容按普通的HTML插入，不会作为Vue模板进行编译，**危险**：在网站上动态渲染任何HTML都是非常危险的，容易导致XSS工具（跨站脚本攻击）；**建议**：本网站的内部数据是可以使用的，如果是来自第三方数据不建议使用

  ```html
  <div v-html='Model属性名称'></div>
  ```

- <font size=4 color=blue>**v-pre**</font>：填充绑定的DOM中的原始信息，跳过编译过程（也不会编译差值表达式）

  ```html
  <div v-pre>{{Model属性名称}}</div>
  ```

- <font size=4 color=blue>**v-once**</font>：表示只会绑定一次数据，不会有数据响应式功能，**优点**：有助于提高性能

  ```html
  <div v-once>{{msg}}</div>
  <div v-once v-text='msg'></div>
  ```

- <font size=4 color=blue>**v-model**</font>：双向数据绑定：主要是针对输入框，用户输入的数据可以修改模型数据值，模型数据库值的改变页面相应到页面

  ```html
  <input type="text" v-model='Model属性名称'>
  ```

### 4. 事件绑定 v-on

- <font size=4 color=blue>**事件绑定**</font>

  1. **v-on:事件名称**：事件绑定的标准格式

     ```html
     <button v-on:click='JavaScript代码'>按钮</button>
     ```

  2. **@:事件名称**：事件绑定的简写格式

     ```html
     <button @click='JavaScript代码'>按钮</button>
     ```

- <font size=4 color=blue>**事件函数的调用方式**</font>

  1. **直接绑定函数名称**：函数默认只有一个参数就是事件对象；

     ```sh
     <button v-on:click='函数名称'>按钮</button>
     ```

  2. **采用函数调用的格式**：可以在函数调用中传递Vue模型中的属性；传递事件需要显示声明，固定参数名称：**$event**；

     ```sh
     <button @click='函数名称()'>按钮</button>
     ```

  3. **传递普通参数**：如果传递多个参数，事件参数必须放在最后

     ```sh
     <button @click='函数名称("普通参数")'>按钮</button>
     ```

- <font size=4 color=blue>**事件修饰符**</font>

  1. **常用事件修饰**：绑定事件监听器。事件类型由参数指定。表达式可以是一个方法的名字或一个内联语句，如果没有修饰符也可以省略；用在普通元素上时，只能监听原生 DOM 事件。用在自定义元素组件上时，也可以监听子组件触发的自定义事件;

     | 事件修饰符             | 作用                                                         |
     | ---------------------- | ------------------------------------------------------------ |
     | .stop                  | 调用 `event.stopPropagation()`，阻止冒泡事件                 |
     | .prevent               | 调用 `event.preventDefault()`，阻止默认事件                  |
     | .self                  | 只当事件是从侦听器绑定的元素本身触发时才触发回调。           |
     | .once                  | 只触发一次回调                                               |
     | .left                  | (2.2.0) 只当点击鼠标左键时触发                               |
     | .right                 | (2.2.0) 只当点击鼠标右键时触发                               |
     | .middle                | (2.2.0) 只当点击鼠标中键时触发                               |
     | .capture               | 添加事件侦听器时使用 capture 模式                            |
     | .{keyCode 或 keyAlias} | 只当事件是从特定键触发时才触发回调                           |
     | .passive               | (2.3.0) 以 `{ passive: true }` 模式添加侦听器,事件将会立即触发 |
     | .native                | 监听组件根元素的原生事件                                     |

  2. **事件修饰使用实例**

     ```html
     <!-- 格式：方法处理器 -->
     <button v-on:click="doThis"></button>
     <button @click="doThis"></button>
     
     <!-- 动态事件 (2.6.0+) -->
     <button v-on:[event]="doThis"></button>
     <button @[event]="doThis"></button>
     
     <!-- 内联语句 -->
     <button v-on:click="doThat('hello', $event)"></button>
     
     
     
     <!-- 停止冒泡 -->
     <button @click.stop="doThis"></button>
     
     <!-- 阻止默认行为 -->
     <button @click.prevent="doThis"></button>
     
     <!-- 仅阻止默认行为，没有表达式 -->
     <form @submit.prevent></form>
     
     <!-- 点击回调只会触发一次 -->
     <button @click.once="doThis"></button>
     
     <!--  修饰符串联 -->
     <button @click.stop.prevent="doThis"></button>
     
     <!-- 键修饰符，键别名 -->
     <input @keyup.enter="onEnter">
     
     <!-- 键修饰符，键代码 -->
     <input @keyup.13="onEnter">
     
     <!-- 对象语法 (2.4.0+) -->
     <button v-on="{ mousedown: doThis, mouseup: doThat }"></button>
     
     <!-- Alt + C -->
     <input v-on:keyup.alt.67="clear">
     
     <!-- Ctrl + Click -->
     <div v-on:click.ctrl="doSomething">Do something</div>
     ```

- <font size=4 color=blue>**按键修饰符**</font>

  1. **常用的按键码的别名**

     | 建码别名 | 按键                 |
     | -------- | -------------------- |
     | .enter   | 回车                 |
     | .tab     | 制表符               |
     | .delete  | 捕获“删除”和“退格”键 |
     | .esc     | ESC退出              |
     | .space   | 空格                 |
     | .up      | 上方向键             |
     | .down    | 下方向键             |
     | .left    | 左方向键             |
     | .right   | 右方向键             |

  2. **系统修饰键**：在和 `keyup` 事件一起用时，事件触发时修饰键必须处于按下状态

     | 建码别名 | 按键                                                         |
     | -------- | ------------------------------------------------------------ |
     | .ctrl    | Ctrl                                                         |
     | .alt     | Alt                                                          |
     | .shift   | Shift                                                        |
     | .meta    | 在 Windows 系统键盘 meta 对应 Windows 徽标键 (⊞)<br />Mac 系统键盘上，meta 对应 command 键 (⌘)<br />在 Sun 操作系统键盘上，meta 对应实心宝石键 (◆)<br />在 Symbolics 键盘上为“META”或者“Meta” |
     | .exact   | 允许你控制由精确的系统修饰符组合触发的事件                   |

     ```html
     <!-- 选中后 Ctrl + 单机  -->
     <button v-on:click.ctrl="onClick">A</button>
     
     <!-- 有且只有 Ctrl 被按下的时候才触发 -->
     <button v-on:click.ctrl.exact="onCtrlClick">A</button>
     
     <!-- 没有任何系统修饰符被按下的时候才触发 -->
     <button v-on:click.exact="onClick">A</button>
     ```

  3. **鼠标修饰符**

     | 建码别名 | 按键     |
     | -------- | -------- |
     | .left    | 单机     |
     | .right   | 右击     |
     | .middle  | 滚轮单机 |

- <font size=4 color=blue>**自定义按键修饰符**</font>

  1. **直接使用建码作为事件修饰符**：缺点是使用建码不直观

     ```html
     <input v-on:keyup.67="clear">
     ```

  2. **定义建码**

     - 使用Vue对象定义全局建码配置

       ```js
       Vue.conig.keyCode.建码名称=建码值;
       ```

     - 使用自定义建码

       ```html
       <input v-on:keyup.建码名称="clear">
       ```

### 5. 属性绑定

- 绑定格式：b-bind冒号指令后的key表示为该标签添加的一个属性，key对应的value表示是一个JavaScript表达式（可以读取data对象中的数据，也可以对data对象中的数据做合法的运算）

  ```html
  <img v-bind:src="imageSrc">
  <img :src="imageSrc">
  ```

### 6. 样式绑定

- <font size=4 color=blue>**通过class样式处理**</font>：样式绑定的本质是为元素绑定class属性，class属性绑定语法也可以与普通的class属性共存

  1. **样式名称绑定**：本质也是属性绑定，绑定的属性的class，属性的值如果是样式的名称需要使用引号，如果不使用引号则会表示为vue的model中的数据，没有会报错

     ```html
     <style>
         .size{
             font-size: 40px;
         }
     </style>
     <div id="app">
         <span :class="'size'">我是个span</span>
     </div>
     ```

  2. **样式值的绑定**：需要在Vue对象的数据model中定义样式变量并且为其制定指定的样式值；

     ```html
     <style>
         .color{
             color: red;
         }
     </style>
     <div id="app">
         <span :class="size">我是个span</span>
     </div>
     <script>
         let vm = new Vue({
             el:"#app",
             data:{
                 size:"color"
             }
         })
     </script>
     ```

  3. **数组/对象语法**：class属性绑定语法也可以与普通的 class attribute 共存，对象中的key是定义在样式文件中的样式名称；

     - 对象绑定的特点是：对于已定义的样式只能通过对象的属性值的true|false来控制样式是否有效
     - 数组绑定的特点是：数组中属性可以是model中的属性，属性值中包含的样式可以动态指定

     ```htm
     <div class='static' v-bind:class="{ active: true }"></div>
     
     <div v-bind:class="[activeClass, errorClass]"></div>
     ```

  4. **样式数据**：可以将样式相关的对象或者数组定义在Vue模型对象中，在绑定class时候使用模型对象中的数据

- <font size=4 color=blue>**内联样式style属性绑定**</font>：样式绑定的本质是为元素绑定style属性

  1. **对象语法**：看着非常像 CSS，但其实是一个 JavaScript 对象。CSS property 名可以用驼峰式 (camelCase) 或短横线分隔 (kebab-case，记得用引号括起来) 来命名

     ```html
     <div v-bind:style="{ color: activeColor, fontSize: fontSize + 'px' }"></div>
     <script>
         let vm = new Vue({
             el:"#app",
             data: {
               activeColor: 'red',
               fontSize: 30
           }
         })
     </script>
     ```

     ```html
     <div v-bind:style="styleObject"></div>
     <script>
         let vm = new Vue({
             el:"#app",
             data: {
               styleObject: {
                 	color: 'red',
               	fontSize: '13px'
               	}
             }
         })
      </script>
     ```

  2. **数组语法**：可以将多个样式对象应用到同一个元素上

     ```html
     <div v-bind:style="[baseStyles, overridingStyles]"></div>
     ```

  3. **自动添加前缀**：当 v-bind:style 使用需要添加浏览器引擎前缀的 CSS property 时，如 transform，Vue.js 会自动侦测并添加相应的前缀。

  4. **多重值**：从 2.3.0 起你可以为 `style` 绑定中的 property 提供一个包含多个值的数组，常用于提供多个带前缀的值

     ```html
     <div :style="{ display: ['-webkit-box', '-ms-flexbox', 'flex'] }"></div>
     ```

### 7.分支结构`v-if`、`v-else`、`v-else-if`、`v-show`

- <font size=4 color=blue>**v-if='条件值'**</font>：控制元素是否在HTML结构中渲染

  ```html
  <h1 v-if="awesome">Vue is awesome!</h1>
  ```

- <font size=4 color=blue>**v-else-if='条件值'**</font>：在上一个v-if的逻辑之中，如果上一个if的逻辑为真，即使当前的条件为真也不会显示

  ```html
  <div v-if="type === 'A'">A</div>
  <div v-else-if="type === 'B'">B</div>
  <div v-else-if="type === 'C'">C</div>
  <div v-else>Not A/B/C</div>
  ```

- <font size=4 color=blue>**v-else**</font>：在上一个v-if的逻辑之中，如果上一个if的逻辑为真，即使当前的条件为真也不会显示

- <font size=4 color=blue>**v-show='条件值'**</font>：控制元素的显示与隐藏

  ```html
  <h1 v-show="ok">Hello!</h1>
  ```

### 8. 循环结构 `v-for`

- <font size=4 color=blue>**遍历数组**</font>：基本类型数组、对象类型数组

  1. **遍历数组**：遍历表达式有两个参数，第一个表示列表中的元素；第二个是可选参数，表示元素对应的索引；

     ```html
     <div id="app">
         <p v-for="(item,index) in list">{{item}}--{{index}}</p>
     </div>
     <script>
         let vm = new Vue({
             el:"#app",
             data:{
                 list:[1,2,3,4,5,6,7]
             }
         })
     </script>
     ```

  2. **遍历数组对象**：遍历表达式有两个参数，第一个表示列表中的元素（对象），使用差值表达式获取对象元素中的属性；第二个是可选参数，表示元素对应的索引；

     ```html
     <div id="app">
         <p v-for="(item,index) in listMap">{{index}}--{{item.id}}--{{item.name}}</p>
     </div>
     <script>
         let vm = new Vue({
             el:"#app",
             data:{
                 listMap:[
                     {id:1,name:"aa"},
                     {id:2,name:"bb"},
                     {id:3,name:"cc"},
                     {id:4,name:"dd"},
                     {id:5,name:"ee"}
                 ]
             }
         })
     </script>
     ```

- <font size=4 color=blue>**遍历对象**</font>：遍历对象可以根据参数的数量灵活的获取对象相关的值

  ```html
  格式一:遍历获取单个参数，第一个参数表示对象属性的对应的value
  <ul>
    <li v-for="value in object">
      {{ value }}
    </li>
  </ul>
  
  
  格式二:遍历获取两个参数，第一参数标识对象的属性的value, 第二个参数标识对象属性的名称
  <div v-for="(value, key) in object">
    {{ key }}: {{ value }}
  </div>
  
  格式三:遍历获取两个参数，最后一个参数表示索引
  <div v-for="(value, name, index) in object">
    {{ index }}. {{ name }}: {{ value }}
  </div>
  <script>
      let vm = new Vue({
          el:"#app",
          data:{
              object: {
                title: 'How to do lists in Vue',
                author: 'Jane Doe',
                publishedAt: '2016-04-10'
              }
          }
      })
  </script>
  ```

- <font size=4 color=blue>**遍历范围**</font>：范围是值遍历的可迭代是一个数值，遍历从1开始，步长为1；参数设置和遍历数组是相同的

  ```html
  <div v-for="i in 10">{{i}}</div>
  <div v-for="(i,index) in 10">{{i}}-{{index}}</div>
  ```

### 9. 循环特性

- <font size=4 color=blue>**遍历绑定key属性**</font>：key属性用户标识列表中每一条元素，是唯一值；**key属性的值来自与单个元素中**

  ```html
  <ul id="example-1">
    <li v-for="item in items" :key="item.message">
      {{ item.message }}
    </li>
  </ul>
  ```

- <font size=4 color=blue>**遍历数据的作用域**</font>：在 v-for 块中，我们可以访问所有列表之外是数据的 property

  ```html
  <ul id="example-2">
    <li v-for="(item, index) in items">
      {{ parentMessage }} - {{ index }} - {{ item.message }}
    </li>
  </ul>
  <script>
      var example2 = new Vue({
        el: '#example-2',
        data: {
          parentMessage: 'Parent',
          items: [
            { message: 'Foo' },
            { message: 'Bar' }
        }
      })
  </script>
  ```


## 2.6 Vue资源 - 过滤器

- <font size=4 color=blue>**过滤器的作用**</font>：主要是用于格式化数据

- <font size=4 color=blue>**自定义过滤器**</font>：过滤器函数中的参数表示通过管道符传递过来的参数

  1. **全局过滤器**

     ```js
     Vue.filter('过滤器名称',function(value){
         // 业务逻辑
         return 处理结果
     })
     ```

  2. **局部过滤器**

     ```js
     let vue = new Vue({
     	... ...
         filters:{
             过滤器名称:function(value){
                 return 处理结果
             }
         }
     })
     ```

- <font size=4 color=blue>**过滤器的使用**</font>：|可以理解为管道符，作用是把管道符左边的值交给过滤器进行处理

  ```html
  在差值表达式中使用
  <div>{{属性名称 | 过滤器名称}}</div>
  
  在属性绑定中使用
  <div v-bind='属性名称 | 过滤器名称'></div>
  ```

- <font size=4 color=blue>**过滤器的参数**</font>：在定义过滤器和使用过滤器时候可以传递参数，默认是从第二个参数开始赋值

  ```js
  Vue.filter('过滤器名称',function(value,形参){
      // 业务逻辑
      return 处理结果
  })
  ```

  ```js
  <div v-bind='属性名称 | 过滤器名称(实参)'></div>
  ```

## 2.7 Vue资源 - 自定义指令

- <font size=4 color=blue>**自定义指令的语法规则**</font>

  - 自定义全局指令

    ```js
    Vue.directive('指令名称',{
        钩子函数: function(钩子函数参数){
            
        }
    })
    ```

  - 自定义局部指令

    ```js
    let vm = new Vue({
        el: '#app',
        directives:{
            指令名称:{
                钩子函数: function(钩子函数参数){
            		
        		}
            }
        }
    })
    ```

- <font size=4 color=blue>**钩子函数说明**</font>：一个指令定义对象可以提供如下几个钩子函数

  - **bind**：只调用一次，指令第一次绑定到元素时调用
  - **inserted**：被绑定元素插入父节点时调用 (仅保证父节点存在，但不一定已被插入文档中)
  - **update**：所在组件的 VNode 更新时调用，但是可能发生在其子 VNode 更新之前。指令的值可能发生了改变，也可能没有。但是你可以通过比较更新前后的值来忽略不必要的模板更新
  - **componentUpdated**：指令所在组件的 VNode 及其子 VNode 全部更新后调用
  - **unbind**：只调用一次，指令与元素解绑时调用

- <font size=4 color=blue>**钩子函数参数**</font>：一个指令定义对象可以提供如下几个钩子函数

  - **el**：指令所绑定的元素，可以用来直接操作 DOM。
  - **binding**：一个对象，包含以下 property：
    - name：指令名，不包括 v- 前缀。
    - value：指令的绑定值，例如：v-my-directive="1 + 1" 中，绑定值为 2。
    - oldValue：指令绑定的前一个值，仅在 update 和 componentUpdated 钩子中可用。无论值是否改变都可用。
    - expression：字符串形式的指令表达式。例如 v-my-directive="1 + 1" 中，表达式为 "1 + 1"。
    - arg：传给指令的参数，可选。例如 v-my-directive:foo 中，参数为 "foo"。
    - modifiers：一个包含修饰符的对象。例如：v-my-directive.foo.bar 中，修饰符对象为 { foo: true, bar: true }。
  - **vnode**：Vue 编译生成的虚拟节点。移步 VNode API 来了解更多详情。
  - **oldVnode**：上一个虚拟节点，仅在 update 和 componentUpdated 钩子中可用。

- <font size=4 color=blue>**自定义指令的使用**</font>：可以使用v-model完成数据双向绑定

  ```html
  <input v-指令名称/>
  ```

## 2.8 Vue基础特性

1. **Vue指令**
   - 自定义属性：传统JS的自定属性是`data-属性名称`的形式定义自定义属性
   - Vue指令本质也是自定义属性，其基本格式是`v-指定名称`，是定义在Vue挂载的DOM元素之上
2. **数据响应式**

   - **响应式**：在HTML中的响应式表示屏幕尺寸的编号会导致样式的变化，而数据响应式则表示数据的变化会导致页面内容的变化，**即修改数据在页面中是即时生效的**
   - **数据绑定**：就是将Vue对象的模型数据填充到DOM标签中
3.  **表单操作** 
   - **常用表单操作**：可以使用v-model完成数据双向绑定
     - input：单行文本：
     - textarea：多行文本：
     - select：下拉选：
     - redio：单选框：
     - checkbook：多选框：
   - **表单域修饰符**：修饰v-model输入域
     - v-model.number：转换为数值，input:type=number的输入框
     - v-model.trim：去掉开始和结尾的空格
     - v-model.lazy：将input事件切换为change事件

## 2.9 Vue高级特性

### <font size=4 color=blue>**1. 实例方法 / 事件**</font>

- **vm.$on( event, callback )**：监听当前实例上的自定义事件。事件可以由 `vm.$emit` 触发。回调函数会接收所有传入事件触发函数的额外参数。

  ```js
  // 定义好的Vue实例或者组件
  let vm = new Vue({...});
                    
  // 在当前实例上定义事件
  vm.$on('自定义事件名称', function (msg) {
    console.log(msg)
  });
  
  // $emit触发自定义的事件
  vm.$emit('自定义事件名称', '传递参数');
  ```

- **vm.$once( event, callback )**：监听一个自定义事件，但是只触发一次。一旦触发之后，监听器就会被移除。

- **vm.$off( [event, callback] )**：移除自定义事件监听器。

  - 如果没有提供参数，则移除所有的事件监听器；
  - 如果只提供了事件，则移除该事件所有的监听器；
  - 如果同时提供了事件与回调，则只移除这个回调的监听器。

- **vm.$emit( eventName, […args] )**：触发当前实例上的事件。附加参数都会传给监听器回调。

# 第三章 组件化开发

## 3.1 组件开发思想

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;前端代码开发中，程序实现是希望尽可能多的做到代码重用，然而前端在代码重用中可能会产生CSS样式和JS业务逻辑的冲突；由此产生的Web Components开发标准：其核心思想是通过创建封装特定功能的定制元素（是一个自定义标签并且具有特定功能），并且能够解决冲突问题；

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;但是这个Web Components标准没有被浏览器广泛支持，但是Vue部分实现了Web Components开发标准。把不同的功能在不同的组件中开发，通过组件组合的方式实现功能的同一实现。

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;组件设计是将不同的功能封装在不同的组件中，通过组件的整合形成完整意义上的一个应用；

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Vue中组件分为全局组件和局部组件，在Vue组件本质也是一个Vue实例，拥有Vue对象的全部属性：如data、methods等等；组件注册实际上是将定义好的组件绑定到Vue实例中，可以将组件定义在Vue对象（java中称类）上，称为全局组件，这样所有的vue实例都可以使用该组件；如果将组件定义在Vue实例上，称为局部组件，可以在当前Vue实例范围内使用；

## 3.2 组件开发

### <font size=4 color=blue>**1.  创建组件**</font>

- **全局组件**：定义在Vue类上的component属性中的组件对象，**全局组件必须定义在Vue实例对象之前**

  - 方式一：分步式创建组件对象并注册到component属性中

    ```js
    // 1. 创建组件对象
    let component = Vue.extend({
        data:function(){
            return {
                组件数据属性:组件数据值
            }
        },
        methods:{
            组件中函数
        },
        template: '组件内容的模板'
    })
    
    // 2. 注册组件到Vue类的component属性中
    // 全局组件
    Vue.component('组件名称',组件对象)
    ```

  - 方式二：创建匿名组件并注册

    ```js
    Vue.component('组件名称',Vue.extend({
        data:function(){
            return {
                组件数据属性:组件数据值
            }
        },
        methods:{
            组件中函数
        },
        template: '组件内容的模板'
    }))
    ```

  - 方式三：在新版本的Vue中，组件对象不再单独创建，由ES新的语法糖进行组件对象的应用，其源码底层也是调用了组件创建方法，即组件的创建和注册是一起实现的；

    ```js
    let component = Vue.extend({
        data:function(){
            return {
                组件数据属性:组件数据值
            }
        },
        methods:{
            组件中函数
        },
        template: '组件内容的模板'
    })
    ```

- **局部组件**：局部组件是定义在Vue实例对象的components属性中的，组件对象的的创建方式和全局组件的创建方式相同

  ```js
  let vm = new Vue({
  	el:"实例范围",
      components:{
          组件名称:组件对象
      }
  })
  ```

### <font size=4 color=blue>**2.  使用组件**</font>

- 组件的命名：
  - 在创建并定义组件时候，组件名称可以是驼峰命名或传统的标签格式（中横线）命名；
  - 在使用组件的标签如果在template的字符串中的可以使用驼峰命名或传统的标签格式（中横线）命名；
  - 在使用组件的标签如果在父组件的标签内必须转换为中横线的命名方式

- 组件的使用：将组件名称当做一个自定义的html标签，组件中的template就会替换改标签对应的页面区域，可以重复使用该自定义标签实现组件的复用；

  ```html
  <组件名称></组件名称>
  ... ...
  <组件名称></组件名称>
  ```

### <font size=4 color=blue>**3. 组件基本属性说明**</font>

- **组件名称**：在定义组件时候可以使用呢驼峰格式或者中划线的格式，在template中引用组件时候可以使用驼峰或者中划线的方式，但是**在html结构的Vue组件中引用组件必须使用中划线格式**；

- **data**：在Vue对象中的data是个对象，对象中的数据模型在整个Vue组件中都可用，但是在自定义组件中，data是个函数，函数的返回值表示自定义注解的数据模型，其作用是起到闭包的作用，使组件之间的数据相互独立

- **template**：表示是html结构的模板内容，可以使用模板字符串格式化编辑模板内容，模块内容必须只有单个根元素；其他全局组的template中也可以引入其他的全局组件；

  - 字符串格式的template：使用简单，但是代码结构混乱

    ```html
    <script>
        let component = Vue.extend({
       	 	template: '<div>这是组件</div>'
    	})
    </script>
    ```

  - 使用ES的新的模板字符串语法定义带格式的模板字符串

    ```html
    <script>
        let component = Vue.extend({
       	 	template: `
    			<div>
        			<a href="#">带格式的字符串模板</a>
        		</div>
    		`
    	})
    </script>
    ```

  - 使用script分离模板内容：使用script作为模板的根标签，script标签的type必须是`text/x-template`

    ```html
    <script type="text/x-template" id="自定义组件模板名称">
        <div>
        	组件内容
        </div>
    </script>
    <script>
        let component = Vue.extend({
       	 	template: '#id值'
    	})
    </script>
    ```

  - 使用`<template>`标签作为组件根标签

    ```html
    <template id="自定义组件模板名称">
        <div>组件内容</div>
    </template>
    <script>
        let component = Vue.extend({
       	 	template: '#id值'
    	})
    </script>
    ```

- **其他属性**：Vue组件本质也是一个Vue实例，Vue实例中的其他属性组件中的用法和在Vue实例中的用法相同；

- **父子组件**：在Vue的组件模板中如果引用了其他组件的标签作为模板内容的一部分，被应用的组件是这个组件的子组件，应用子组件的组件是这个子组件的父组件；

## 3.3 组件的数据交互方式

### <font size=4 color=blue>**1. 父组件向子组件传值**</font>

- **第一步**：把父组件的值通过属性设置或属性绑定定义在子组件的标签上

  ```html
  <组件名称 属性名1="属性值" :属性名2="父组件动态值"></组件名称>
  ```

- **第二步**：在子组件对象中定义props属性接受标签上绑定的属性，

  - props属性是数组，数组元素是接收父组件传递的属性名，
  - props中元素可以接受各种数据类型：String、Number、Boolean、Array、Object
  - props中元素名称可以是驼峰表示，向子传递的属性名必须是中横线的方式
  - props传递数据原则：单向数据流，子组件操作父组件应用类型数据会导致数据逻辑混乱

  ```js
  Vue.component('组件名称',Vue.extend({
      props:["属性名1","属性名2"],
      data:function(){
          return {
              组件数据属性:组件数据值
          }
      },
      methods:{
          组件中函数
      },
      template: '<div>{{属性名1}}{{属性名2}}</div>'
  }))
  ```

### <font size=4 color=blue>**2. 同级组件传值**</font>

- **第一步**：定义事件中心，本质是一个空的Vue实例，在Vue实例对象中定义事件与监听事件完整组件之间的传值

  ```js
  var enent = new Vue({});
  ```

- **第二步**：监听事件是在组件的生命周期钩子函数

  ```js
  Vue.component("#sub1",{
      mounted:{
          event.$on("事件名称",function(val){
      		// 监听的回调函数
  		})
      }
  })
  ```

- **第三步**：再子组件上定义方法，在方法使用$emit触发事件

  ```html
  <div id="app">
      <sub1 @click="handle"></sub1>
  </div>
  <script>
  	var vm = new Vue({
          el:"#app",
          methods:{
              handle:function(){
                  event.$emit("事件名称",[参数])
              }
          }
      })
  </script>
  ```

- **销毁事件**

  ```js
  event.$off("事件名称")
  ```

### <font size=4 color=blue>**3. 子组件向父组件传值**</font>

- **第一步**：在子组件中绑定自定义事件，采用$emit自定义在子组件中定义指定名称的事件

  ```html
  <template id="自定义组件模板名称">
      <div @click="$emit('事件名称',[第二个参数是事件传递的值])">组件内容</div>
  </template>
  ```

- **第二步**：在父组件中使用子组件标签中监听改名称的事件，监听事件的值中$event是固定值，表示子组件事件传递的参数

  ```html
  <div id="app">
      <子组件标签 @事件名称="父组件方法([$event])"></子组件标签>
  </div>
  ```

## 3.4 组件插槽

### <font size=4 color=blue>**1. 插槽概述**</font>



### <font size=4 color=blue>**2. 插槽使用-子组件接收内容**</font>



### <font size=4 color=blue>**3. 插槽使用-具名插槽**</font>



### <font size=4 color=blue>**4. 插槽使用-子组件返回值**</font>

# 第四章 vue-cli

## 4.1 前端模块化

1. JavaScript的`<script>`脚本开发：早期的js作为脚本语言，提供简单的交互动作，随着Ajax异步请求出现，前端功能越来越复杂，单独的`<script>`难以维护，需要根据功能拆分出不同的`<script>`进行管理 

   - 多个js脚本中的全局变量同名问题，通过闭包解决全局变量问题

     ```js
     <script src="m_model_a.js"></script>
     var ModelName = (function(){
         var obj = {}
         obj.flag = true;
         obj.sum = function(a,b){
             return a+b
         }
         return obj;
     })()
     
     <script src="m_model_b.js"></script>
     if(ModelName.flag){
         var res = ModelName.sum(12,23)
     }
     ```

2. 前端模块化规范

   - CommonJS规范：

     - **导出**：CommonJS规范规定，每个模块内部，`module`变量代表当前模块。这个变量是一个对象，它的`exports`属性（即`module.exports`）是对外的接口。加载某个模块，其实是加载该模块的`module.exports`属性。

       ```js
       module.exorts = {
           
       }
       
       module.exports.x = x;
       ```

     - **导入**：`require`方法用于加载模块。根据参数的不同格式，`require`命令去不同路径寻找模块文件

       - 如果参数字符串以“/”开头，则表示加载的是一个位于绝对路径的模块文件
       - 如果参数字符串以“./”开头，则表示加载的是一个位于相对路径的模块文件
       - 如果参数字符串不以“./“或”/“开头，则表示加载的是一个默认提供的核心模块（node_modules）

       ```js
       var example = require('./example.js');
       ```

   - AMD

   - CMD

   - ES6Modulles：ES6新增特性；①模块中可以导入和导出各种类型的变量，如函数，对象，字符串，数字，布尔值，类等。②每个模块都有自己的上下文，每一个模块内声明的变量都是局部变量，不会污染全局作用域。③每一个模块只加载一次（是单例的）， 若再去加载同目录下同文件，直接从内存中读取。

     - 导出/导入：入口文件引入`<script type="module"></script>`

       ```js
       export { myName, myAge, myfn, myClass }
       import { myName, myAge, myfn, myClass } from "./test.js";
       
       export { myName }
       import { myName as name1 } from "./test1.js";
       
       export default var c = "error"; 
       import b from "./xxx.js"; // 不需要加{}， 使用任意变量接收
       ```

## 4.3 webpack基础

1. webpack的下载：webpack模块打包工具，是基于Node环境开发，而且Node提供了npm包管理工具

   ```sh
   # 需要全局安装，因为vue-cli依赖webpack
   cnpm install webpack webpack-cli
   
   # 局部安装，是开发依赖，项目打包后不再依赖了-dev
   cnpm install webpack --save-dev
   ```

2. webpack的使用：-o表示打包后输出的位置，--mode表示打包模式有development和production

   ```sh
   webpack .\src\main.js -o .\dist\main.js --mode=development
   ```

3. webpack的配置文件：默认文件名称webpack.config.js；通过webpack --config选项重新指定配置文件

   ```js
   module.exports = {
       // webpack五大核心属性
   }
   ```

## 4.4 el和template

1. 下载Vue包

   ```sh
   cnpm install vue --save
   ```

2. 引入Vue

   ```js
   import Vue from 'vue'
   
   let vm = new Vue({
       el: '#app',
       data:{
           msg: "hello"
       }
   })
   ```

3. 在webpack中配置vue版本：（需要配置resolve）vue包中包含了许多版本，默认使用的vue的版本类型是`runtime-only`，该版本特点是不会解析template相关编译代码；而`runtime-compiler `这个版本包含template编译代码，对应的vue版本文件为`vue.esm.js`；

   ```js
   var path = require('path');
   
   module.exports = {
       entry: './src/main.js',
       output: {
           path: path.resolve(__dirname, './dist'),
           filename: 'build.js'
       },
       mode: "development",
       resolve: {
           alias: {
               'vue$': 'vue/dist/vue.esm.js' //内部为正则表达式  vue结尾的
           }
       }
   }
   ```

4. vue实例中的template和el属性：如果在vue实例中定义了el属性以及对应的区域后再定义template属性，那么在编译过程中，会将el区域替换为template模块的内

   ```js
   let vm = new Vue({
       el: '#app',
       template:`
           <div>
               <h1>{{msg}}</h1>
               <button>{{msg}}</button>
           </div>
       `,
       data:{
           msg: "hello"
       }
   })
   ```

5. template抽取为组件，并且在vue实例中的template属性引用组件

   ```js
   const App = {
       template:`
           <div>
               <h1>{{msg}}</h1>
               <button>{{msg}}</button>
           </div>
       `,
       data() {
           return {
               msg: "hello"
           }
       },
   }
   
   let vm = new Vue({
       el: '#app',
       template: '<App/>',
       components: {
           App
       }
   })
   ```

6. 将组件抽取为JavaScript模块并导出

   ```js
   export  default {
       template:`
           <div>
               <h1>{{msg}}</h1>
               <button>{{msg}}</button>
           </div>
       `,
       data() {
           return {
               msg: "hello"
           }
       },
   }
   
   
   import App from './vue/app.js'
   let vm = new Vue({
       el: '#app',
       template: '<App/>',
       components: {
           App
       }
   })
   ```

7. Vue的模板代码与vue实例分离开发：Vue单文件组件（xxx.vye）

   ```sh
   cnpm install vue-loader vue-template-compiler --save-dev
   ```

   ```js
   module.exports = {
       module:{
           rules:[
               {test: /\.vue$/,loader: 'vue-loader'}
           ]
       }
   }
   ```

   ```vue
   <template>
       <div>
           <h1>{{msg}}</h1>
           <button>{{msg}}</button>
       </div>
   </template>
   
   <script>
   export default {
       data() {
           return {
               msg: "hello"
           }
       }
   }
   </script>
   
   <style scoped>
   
   </style>
   ```

   ```js
   import App from './components/App.vue'
   let vm = new Vue({
       el: '#app',
       template: '<App/>',
       components: {
           App
       }
   })
   ```

## 4.5 配置文件开发

- webpack命令指定配置文件

  ```sh
  webpack --config 配置文件名称
  ```


## 4.6 vue-cli

1. 脚手架下载

   - npm配置阿里云镜像

     ```sh
     npm config set registry https://registry.npm.taobao.org
     
     # 查看npm配置
     npm config get <key>
     ```

   - 全局安装webpack：webpack 3中，webpack本身和它的CLI以前都是在同一个包中；但在第4版中，他们已经将两者分开来更好地管理它们。所以用 npm install webpack-cli -g 命令全局安装webpack-cli即可

     ```sh
     npm install webpack -g
     npm install webpack-cli -g
     # 查看版本
     webpack -v
     webpack-cli -v
     ```

   - 安装vue-cli：现在安装vue的是脚手架3，可以使用脚手架3使用脚手架2的模板

     ```sh
     npm install -g @vue/cli			# 安装脚手架3
     npm install -g @vue/cli-init	# 拉取脚手架2模板
     # 查看版本
     vue -v
     ```

2. 创建脚手架2项目

   ```sj
   vue init webpack 项目名称
   ```

   > - 项目名称：Project name
   > - 项目描述：Project description
   > - 作者：Author（读取git config）
   > - 项目构建：Runtime only：
   > - Install Router：路由
   > - EsLint：代码格式校验（学习时候不需要，开发时候需要代码风格），选择自己的规范
   > - 单元测试：（不需要）unit test
   > - 端到端测试：（不需要）e2e test
   > - npm工具：选择npm

3. 创建脚手架3项目：命令行

   ```sh
   vue create 项目名称
   ```

   > - 选择配置：选择自定义手动选择
   > - Babel、Router、Vuex、CSS
   > - 独立的配置文件：不要放在package.json

4. 创建脚手架3项目：图形页面

   ```sh
   vue ui
   ```

## 4.7 vue执行流程

- new Vue：会保存vue实例中是operations

- 将vue中template属性parse解析为抽象语法树

- 将抽象语法树编译问render函数

  - 如果vue实例中有template属性需要使用runtime-compiler中的vue解析Vue实例的template属性

  - 如果直接将render函数设置到vue实例中，则可以使用runtime-only了，直接将render函数解析为虚拟dom树

    ```js
    new Vue({
        el:"#app",
        render:h => {
            h(App)
        }
    })
    ```

- render函数最终解析为virtual dom虚拟dom树

- 根据虚拟dom树渲染为ui页面

# 第五章 vue-router

## 5.1 路由概述

- 路由：是网络工程中的属于，其核心作用是通过互联网把信息从源地址传输到目的地址的活动；路由的本质是一个URL和资源的映射表；
- 单页面富应用：显示单页面，页面的跳转是由前端路由控制

- 改变url不要页面整体刷新

  - 方式一：使用Router的url的hash（路径后的#/路由称为hash）

    ```js
    location.hash='url hash'
    ```

  - 方式二：采用html5的history模式（路由是通过/路由格式）

    ```js
    history.pushStatus({},'','url');
    history.back();	
    history.forward();
    history.replaceStatus({},'','url');
    history.go(索引);	// 索引为正数向前跳, 索引为负数向后跳
    ```

## 5.2 路由的安装与配置

- vue-router是vue官方的路由插件，与vue深度集成，适合构建单页面应用

- vue-router安装

  ```sh
  npm install vue-router --save
  ```

- 配置路由

  ```js
  // 第一步 导入路由对象,并且挂载到Vue对象中
  import Vue from 'vue'
  import VueRouter from "vue-router";
  Vue.use(VueRouter);
  // 第二步 创建路由实例,并且设置路由映射配置
  const routes = [{
          path: "/",
          name: "Home",
          component: Home,
      }
  ];
  
  const router = new VueRouter({
      mode: "history",
      routes,
  });
  export default router;
  // 第三步 在Vue实例中添加router属性,指定路由模块
  import router from './router'
  new Vue({
    router,
    store,
    render: h => h(App)
  }).$mount('#app')
  ```

## 5.3 路由的映射配置

- 路由的配置是一个数组，数组中包含映射对象，映射对象的属性说明

  ```js
  // 配置路由映射
  const router = [
      {
          name:"指定映射对象的名称",
          path:"路由",
          component:"路由对应的地址"
      }
  ]
  ```

- router-link的使用：是vue-router自动注册的全局组件

  ```html
  <router-link to='路由'>文本标识</router-link>
  ```

  > 属性to:指定要跳转的路由;
  >
  > 属性tag:表示被渲染的标签;默认被渲染为a标签
  >
  > 属性replace:修改方式为replace
  >
  > 激活class属性:默认名称是router-link-exact-active、router-active-active
  >
  > 属性：active-class；修改样式的激活的名称，可以在router对象的属性中全局添加linkActiveClass属性

- router-view：路由映射的组件的渲染，作用是占位，如果router-link获取到组件内容，组件的内容会替换这个占位标签

  ```html
  <router-view></router-view>
  ```

## 5.4 路由高级

1. 默认路由

   ```js
   const router = [
       {
           name:"默认路由重定向到其他路由",
           path:"/",
           redirect:"路由"
       }
   ]
   ```

2. 修改路由的方式为html的history模式:指定路由的mode属性为history

   ```js
   const router = new VueRouter({
       mode: "history",
       routes,
   });
   ```

3. 使用代码跳转路由

   ```js
   this.$router.push("/路由")
   this.$router.replace("/路由")
   this.$router.back()
   this.$router.forward()
   ```

4. **路由的懒加载**：路由映射的方式有两种①引入需要路由的component，在指定路由映射的组件的时候指定被引入的组件②配置路由的时候再import需要路由的组件

   ```js
   
   ```

# 第七章 Vuex详解

## 7.1 VueX介绍

- **VueX说明**：是为Vue应用程序开发的状态管理模式：采用集中式存储管理应用程序中的共享公共变量，并且以相应的规则管理这些公共变量；

- **状态管理**：VueX的状态的本质是组件内定义的变量，单页面状态本质是定义在组件的data对象中的变量；VueX主要作用是多页面的状态管理，VueX状态管理指将多个组件中的变量抽取并统一配置在VueX中，并且对状态的操作在VueX中定义；VueX一般会管理项目中的全局共享变量；

  - **单页面状态**：Vue的单组件数据的状态变化流程：数据的状态定义在data对象中，数据根据数据状态渲染在View中，在View中的执行了action改变了data中的数据状态，被改变的数据状态响应式的显示在View中；

    <img src='https://vkceyugu.cdn.bspapp.com/VKCEYUGU-b1ebbd3c-ca49-405b-957b-effe60782276/2eae72c6-f9f6-4429-a06d-f682d12fe009.png' width=50%/>

  - **多页面状态**：而在多组件的状态管理时，单向数据流的简洁性很容易被破坏：①多个组件依赖同一个状态②不同的组件需要对状态进行变更，并且其他组件可以做到响应式；VueX为解决多组件的状态管理问题，重新定义了多组件的状态的数据流：如果直接在Vue组件中改变state，DevTools是监听不到state的变化过程，必须使用VueX中定义好的规则改变VueX中的state

    - Action：组件中的异步操作
    - Mutations：组件中的同步操作
    - State：多组件共享数据
    - DevTools：Vue的浏览器插件会监听到VueX中的state的变化流

    <img src='https://vkceyugu.cdn.bspapp.com/VKCEYUGU-b1ebbd3c-ca49-405b-957b-effe60782276/42bf4d4a-be12-4346-8f60-305f1538fe41.png' width=70%/>
  
- **单一状态树**：如果项目中的状态信息是保存到多个Store对象中的，那么对状态的管理和维护都会特别困难；所有VueX采用了单一状态树（一个项目只定义一个store实例对象）管理应用层级的全部状态：单一状态树能够用最直接的方式找到某个状态的片段，并且可以做到非常方便的管理和维护；

- **vuex响应式原理**： state中属性会被加入到响应式系统中，当属性发生变化时，会通知到所有使用该属性的组件并渲染数据；

## 7.2 VueX安装与配置

1. 下载Vuex

   ```sh
   npm install vuex --save
   ```

2. 安装Vue插件：①Vue.use(插件)内部调用插件的install()方法，作用是将插件的属性添加到Vue原型上②new 插件()，然后将项目中的相关数据需要new一个插件对象，才能使用定义在插件实例之中③此时new出来的插件实例对象与Vue实例对象完全独立，最后需要将插件实例对象交给Vue实例对象进行数据管理；

   > 安装挂载后为Vue实例新增全局属性：$store属性

   ```js
   import Vue from 'vue'
   import Vuex from 'vuex'
   
   // 安装插件
   Vue.use(Vuex)
   
   // 创建仓库对象,约定创建的对象是store
   const store = new Vuex.Store({
       state: {
   		// 状态属性
       },
       getters: {
           // 状态的计算属性
       },
       mutations: {
   		// 状态的操作方法
    	},
       actions: {
        // 
       },
       modules: {
           // 状态的模块化
       }
   })
   
   export default store;
   ```

3. 挂载到Vue实例之上

   ```js
   import store from './store'
   
   createApp(App).use(store).mount('#app')
   // 或者
   new Vue({
       render: h => h(App),
       store
   }).$mount("#app");
   ```

## 7.3 VueX基础

### 1. Vuex.Store 参数

| 参数名    | 作用                                                         |
| --------- | ------------------------------------------------------------ |
| state     | 保存状态，key:value格式的数据，**推荐使用单一数据源（一个store）**<br />mutations中属性必须提前初始好的才有响应式 |
| getters   | store中对状态的计算属性：<br /> - 第一个参数state对象<br /> - 第二个对象是getters对象<br /> - 模块中是getter第三个参数是root<br /> - 在getters中返回参数，在调用getters时候可以传递自定义参数 |
| mutations | 更新VueX中states唯一的方式：提交mutation<br /> - mutations的函数分为两部分：①事件类型（方法名），②回调函数（方法体）<br /> - mutations的函数参数：第一个参数默认是states，第二个参数是自定义参数（payload）<br /> - 项目开发中将mutation的事件类型抽取为一个常量<br /> - mutation中方法推荐使用同步方法 |
| actions   | actions是用来替代mutation执行异步操作<br /> - action中方法默认参数是context：表示action执行的上下文store对象<br /> - 在模块中action中context参数表示是当前的store模块 |
| modules   | store中的模块化                                              |

### 2. 定义State

- VueX中状态的本质是变量，将共享变量定义在VueX中

  ```js
  const store = new Vuex.Store({
      state:{
          变量名称:变量初始值,
          ... ...
      }
  })
  ```

- **扩展**：使用VueAPI修改state数据做到响应式更新

  ```js
  // 修改或新增属性
  Vue.set(对象,属性名称,属性值)
  // 删除属性
  Vue.delete(对象,属性名称)
  
  // 如修改state的属性
  Vue.set(state.状态属性,"属性名称","属性值")
  Vue.delete(state.状态属性,"属性名")
  ```

### 3. 读取state

- 在Vue实例上挂载VueX插件后，Vue会新增一个`$sotre`属性：代表挂载到Vue的`new Vuex.Store()`对象

  ```js
  // 使用插值表达式读取变量
  {{$store.state.变量}}
  // 在Vue组件实例中读取变量
  this.$store.state.变量
  ```

### 4. mutation修改state

- 在VueX中共享的state支持修改，并且可以做到响应式，但是修改共享state需要根据VueX的指定规则修改，首先需要将修改state的方法定义在`new Vuex.Store()`的mutations属性中，mutations中方法的默认参数就是state，方法名称在VueX中被称为事件类型；

  ```js
  const store = new Vuex.Store({
      state:{
          counter: 1000
      },
      mutations:{
          // 定义无参操作方法
          事件类型(state){
              state.counter++
          },
          // 定义带参数操作方法payload表示调用事件的参数,
          事件类型(state,payload){
  			// payload 包含多个值会封装为一个对象
          }
      }
  })
  ```

- 在Vue组件中commit（提交）VueX中mutations的方法进行数据修改

  ```js
  export default {
      methods:{
          组件中的方法(){
              // 执行mutations中方法的无参数方法
              this.$store.commit("事件类型");
              // commit普通提交方式
               this.$store.commit("事件类型",参数);
              // commit对象类型参数 type制定事件类型
              this.$store.commit({
                  type: "事件类型",
                  参数: value,
                  参数: value
                  ... ...
              })
          }
      }
  }
  ```

- **mutations类型常量**：在VueX中事件类型在使用的过程中传递的是字符串，容易发生手误导致的错误；所有在实际开发中有的项目会将事件类型定义为常量，

### 5. getters修改state

- **getters概述**：getters可以认为是 store 的计算属性；

- **getter定义**：getters中属性对应一个用于计算的函数，函数的返回值表示该属性的计算结果，计算属性的函数的第一个参数是state对象，第二个参数是当前getter对象；

  ```js
  const store = new Vuex.Store({
      state:{
          counter: 1000
      },
      getters:{
          // 定义无参属性
          属性名称(state,getter){
              return xx;
          },
          // 定义带参数属性
          属性名称(state,getter){
              return function(形参列表){
                  return xx;
              }
          },
           // 定义在module中的getter，第三个参数是rootState
          属性名称(state,getter，rootState){
              return function(形参列表){
                  return xx;
              }
          }
      }
  })
  ```

- getter属性调用

  ```js
  // 使用插值表达式读取变量
  {{$store.getters.属性名称}}
  // 在Vue组件中使用getters中属性
  this.$store.getters.计算属性
  this.$store.getters.计算属性(实参列表)
  ```

### 6. action异步修改state

- **action概述**：在mutations中执行异步操作，devTools工具监测不到状态的变化，所以VueX的store定义了一个action属性，改属性功能类型mutations，区别是action中执行异步操作，操作完成后commit（提交）状态给mutations，最终是由mutations进行状态的操作；

- **action定义**：action 函数接受一个与 store 实例具有相同方法和属性的 context 对象，因此你可以调用 `context.commit` 提交一个 mutation，或者通过 `context.state` 和 `context.getters` 来获取 state 和 getters。如果定义在module中，action中的context参数表示当前的module；

  ```js
  const store = new Vuex.Store({
      state:{
          counter: 1000
      },
      actions:{
          // 定义无参数action事件类型
          事件类型(context){
               context.commit("mutations事件类型")
          },
          // 定义带参数action事件类型
          事件类型(context,payload){
               context.commit("mutations事件类型")
          },
          // 定义带返回值action事件类型
          事件类型(context,payload){
              return new Promise((resolve,reject)=>{
                  context.commit("mutations事件类型");
                  resolve()
              })
          },
      }
  })
  ```

- **action的使用**：

  ```js
  this.$store.dispatch("action事件类型","参数");
  this.$store.dispatch("action事件类型","参数").then(()=>{
      // 异步回调
  })
  ```

### 7. modules模块化

- 由于VueX使用单一状态树，所以当项目管理的状态太多，store对象就会变得相当臃肿；Vuex 允许将 store 分割成**模块（module）**。每个模块拥有自己的 state、mutation、action、getter、甚至是嵌套子模块——从上至下进行同样方式的分割；

  - 模块内部的 mutation 和 getter，接收的第一个参数是**模块的局部状态对象**；
  - 模块内部的getter第三个参数是rootState：表示是store对象中的state；
  - 对于模块内部的 action，局部状态通过 `context.state` 暴露出来，根节点状态则为 `context.rootState`；

  ```JS
  const moduleA = {
    state: () => ({ ... }),
    mutations: { ... },
    actions: { ... },
    getters: { ... }
  }
  
  const moduleB = {
    state: () => ({ ... }),
    mutations: { ... },
    actions: { ... }
  }
  
  const store = new Vuex.Store({
    modules: {
      a: moduleA,
      b: moduleB
    }
  })
  ```

- 调用module中的state

  ```js
  store.state.a // -> moduleA 的状态
  store.state.b // -> moduleB 的状态
  ```

### 8. 命名空间



## 7.3 VueX的模块封装

# 第八章 axios

## 8.1 Vue网络请求

### 1. 发送网络请求方式

1. 原生的XMLHTTPRequest：使用复杂，封装难度高
2. jQuery-Ajax：jQuery库太重
3. Vue1.x自带的vue-resources：停止更新
4. JSONP：跨域伪造访问
5. axios：作者推荐，功能完善
   - 支持在浏览器发送XMLHTTPRequest
   - 支持在node发送http请求
   - 支持Promise API
   - 拦截请求和响应
   - 转换请求和响应

### 2. axios初始化

- 安装axios

  ```sh
  npm install axios --save
  ```

- 配置axios

  ```js
  // 引入axios
  import axios from "axios";
  
  // 发送请求
  axios({
      url: "http://localhost:8080/mvc/get/param?param='test'",
  }).then((res) => {
      console.log(res);
  });
  ```

  

## 8.2 axios发送请求的方式

### 1. axios API

1. axios(config)
2. axios.request(config)
3. axios.get(url[,config])
4. axios.delete(url[,config])
5. axios.post(url[,data,config])
6. axios.put(url[,config])
7. axios.patch(url[,data,config])
8. axios.get(url[,data,config])
9. axios.head(url[,config])
10. axios.all([config,config])

### 2. axios config详解

- config参数详解

  ```js
  // 全局配置
  axios.defaults.baseURL = ''
  
  // 单独配置
  axios({
  	url:'',
      method:'',
      timeout:'',
      param:{
          keu:value
      },
      data:{
          key:value
      },
      transformRequest(){
  		请求转换
      },
      transformResponse(){
        	响应装换
      },
      headers:{
          
      }
  })
  ```

### 3. axios封装

- vue实例创建

  ```js
  let serverA = axios.create({
      baseUrl:''
  })
  let serverB = axios.create({
      baseUrl:''
  })
  ```


