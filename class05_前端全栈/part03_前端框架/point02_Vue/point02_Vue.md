# 前言

# 第一章 Vue 基础

## 1.1 Vue概述

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;Vue是一个JavaScript的渐进式框架：Vue框架提供了部分的基础服务和API；&nbsp;Vue 只关注视图层， 采用自底向上增量开发的设计。Vue 的目标是通过尽可能简单的 API 实现响应的数据绑定和组合的视图组件；Vue中还具备WEB开发中的高级功能：①解耦视图和数据、②可复用组件、③前端路由技术④状态管理⑤虚拟DOM

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>渐进式开发即项目开发使用的功能特性，如：声明式渲染 → 组件系统 → 客户端路由 → 集中式状态管理 → 项目管理；可以使用使用方案中的一部分或者全部，意味着Vue可以作为项目的一部分嵌入其中，或者希望在更多的功能上使用Vue技术，那么可以使用Vue逐渐替换原来的技术功能；Vue框架的主要特点：

- 易用：熟悉HTML、CSS、JavaScript便可以快速上手Vue
- 灵活：在一个JavaScript库和前端框架之间可以做到伸缩自如，也可以用于APP项目开发
- 高效：20K的运行大小，超快高效虚拟DOM，较少不必要的DOM操作

## 1.2 前端的MVVM和后端MVC

1. **后端MVC设计模型**
   
   - `M:Model`：表示模型，主要用于存放数据
   - `V:View`：视图，表示展示数据的页面
   - `C:Controller`：控制器，用于接收视图的参数构造数据并返回给视图

2. **前端MVVM设计模型**
   
   - `M:Model` ：页面中的单独数据
   - `V:View`：页面展示结构，在前端开发中通常值DOM元素
   - `VM:View`：Model 核心是视图模型层:是M和V的调度者，功能一可以实现数据绑定，功能二是DOM监听
   
   <img src="https://s1.ax1x.com/2020/05/01/JOFGzq.png" alt="JOFGzq.png" width=600 />

## 1.3 Vue的安装方式

1. 使用CDN引入
   
   ```js
   // 开发环境版本，包含了有帮助的命令行警告
   <script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
   // 生产环境版本，优化了尺寸和速度
   <script src="https://cdn.jsdelivr.net/npm/vue"></script>
   ```

2. 下载Vue库并添加到Html标签中
   
   - 开发环境：https://vuejs.org/js/vue.js
   - 生产环境：https://vuejs.org/js/vue.min.js

3. 使用npm包管理工具
   
   ```sh
   npm install vue
   ```

## 1.4 Vue-Devtools

1. 下载插件工具包
   
   ```sh
   git  clone https://codeload.github.com/vuejs/vue-devtools/zip/master
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

## 1.5 Vue-Helloworld

- **入门案例代码**
  
  ```html
  <body>
      <div id='app'>{{msg}}</div>
      <script src="./commons/js/vue.js"></script>
      <script>
          let vue = new Vue({
              el:"#app",
              data:{
                  msg:"Helloworld"
              }
          })
      </script>
  </body>
  ```

- **Vue编程范式说明**
  
  - VM：在编程中首先需要引入Vue，并构建Vue对象，并指明需要关联的页面区域元素，这个Vue对象便可以作为数据Model和View视图的调度者
  
  - V：表示页面中的一个HTML元素，这个元素会在页面中展示特定的区域，这个区域中的数据会交给VM对象
  
  - M：数据模型，会定义在当前元素对应的VM对象中，可能会包括基本数据，事件方法等数据

# 第二章 Vue 实例对象

## 2.1 Vue Api

| 全局配置                  | 说明      | \|  | 选项 / DOM         | 说明      | \|  | 实例方法 / 事件        | 说明     |
| --------------------- | ------- | --- | ---------------- | ------- | --- | ---------------- | ------ |
| keyCodes              | 键盘键码    | \|  | el               | Vue实例标签 | \|  | vm.$on           | 定义事件   |
| optionMergeStrategies | 合并策略    | \|  | template         | Vue模板标签 | \|  | vm.$once         | 监听单次   |
| devtools              |         | \|  | render           |         | \|  | vm.$off          | 移除事件   |
| errorHandler          |         | \|  | renderError      |         | \|  | vm.$emit         | 触发事件   |
| warnHandler           |         | \|  | **选项 / 资源**      | **说明**  | \|  | **实例方法 / 生命周期**  | **说明** |
| ignoredElements       |         | \|  | directives       |         | \|  | vm.$mount        |        |
| silent                |         | \|  | filters          |         | \|  | vm.$forceUpdate  |        |
| performance           |         | \|  | components       |         | \|  | vm.$nextTick     |        |
| productionTip         |         | \|  | **选项 / 组合**      | **说明**  | \|  | vm.$destroy      |        |
| **全局 API**            | **说明**  | \|  | parent           |         | \|  | **指令**           | **说明** |
| Vue.extend            | 构建组件    | \|  | mixins           |         | \|  | v-text           | 文本填充   |
| Vue.component         | 组件注册    | \|  | extends          |         | \|  | v-html           | html填充 |
| Vue.directive         |         | \|  | provide / inject |         | \|  | v-show           | 是否显示   |
| Vue.set               | 属性设置    | \|  | **选项 / 其它**      | **说明**  | \|  | v-if             | 条件指令   |
| Vue.delete            | 属性删除    | \|  | name             |         | \|  | v-else           | 条件指令   |
| Vue.filter            | 过滤器     | \|  | delimiters       |         | \|  | v-else-if        | 条件指令   |
| Vue.nextTick          |         | \|  | functional       |         | \|  | v-for            | 迭代     |
| Vue.use               | 挂载插件    | \|  | model            |         | \|  | v-on             | 事件绑定   |
| Vue.mixin             |         | \|  | inheritAttrs     |         | \|  | v-bind           | 属性绑定   |
| Vue.compile           |         | \|  | comments         |         | \|  | v-model          | 双向绑定   |
| Vue.observable        |         | \|  | **实例 property**  | **说明**  | \|  | v-slot           |        |
| Vue.version           |         | \|  | vm.$data         |         | \|  | v-pre            |        |
| **选项 / 数据**           | **说明**  | \|  | vm.$props        |         | \|  | v-cloak          |        |
| data                  | model数据 | \|  | vm.$el           |         | \|  | v-once           |        |
| props                 | 父组件传值   | \|  | vm.$options      |         | \|  | **特殊 attribute** | **说明** |
| propsData             |         | \|  | vm.$parent       |         | \|  | key              |        |
| computed              | 属性计算    | \|  | vm.$root         |         | \|  | ref              |        |
| methods               | 方法/函数   | \|  | vm.$children     |         | \|  | is               |        |
| watch                 | 监听器     | \|  | vm.$slots        |         | \|  | slot             |        |
| **选项 / 生命周期钩子**       | **说明**  | \|  | vm.$scopedSlots  |         | \|  | slot-scope       |        |
| beforeCreate          |         | \|  | vm.$refs         | 子组件实例   | \|  | scope            |        |
| created               |         | \|  | vm.$isServer     |         | \|  | **内置的组件**        | **说明** |
| beforeMount           |         | \|  | vm.$attrs        |         | \|  | component        |        |
| mounted               |         | \|  | vm.$listeners    |         | \|  | transition       |        |
| beforeUpdate          |         | \|  | 实例方法 / 数据        | **说明**  | \|  | transition-group |        |
| updated               |         | \|  | vm.$watch        |         | \|  | keep-alive       |        |
| activated             |         | \|  | vm.$set          |         | \|  | slot             |        |
| deactivated           |         | \|  | vm.$delete       |         |     |                  |        |
| beforeDestroy         |         | \|  |                  |         |     |                  |        |
| destroyed             |         | \|  |                  |         |     |                  |        |
| errorCaptured         |         | \|  |                  |         |     |                  |        |

## 2.2 Vue实例

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**创建Vue实例**：一个 Vue 应用由一个通过 new Vue 创建的根 Vue 实例，当创建一个 Vue 实例时，你可以传入一个选项对象，可以通过这些选项来创建你想要的行为，虽然没有完全遵循 MVVM 模型，但是通过Vue选项的功能可以高效是完成MVVM模式开发。

```js
var vm = new Vue({
  // 选项
})
```

## 2.2 Vue选项 - DOM

1. el：该选项的值是一个js选择器：提供一个在页面上已存在的 DOM 元素作为 Vue 实例的挂载目标，在实例挂载之后，元素可以用 `vm.$el` 访问；如果 `render` 函数和 `template` property 都不存在，挂载 DOM 元素的 HTML 会被提取出来用作模板；
   
   ```js
   var vm = new Vue({
     el:'#app'
   })
   ```

2. template：该选项值是字符串，可以是html字符串实例、或者是`<template>`标签的id选择符、用 `<script type="x-template">` 包含模板。用作组件化开发

## 2.3 Vue选项 - 数据

1. data：Vue 实例的数据对象（含有零个或多个的 key/value 对），Vue 将会递归将 data 的 property 转换为 getter/setter，从而让 data 的 property 能够响应数据变化；实例创建之后，可以通过 `vm.$data` 访问原始数据对象；以 `_` 或 `$` 开头的 property **不会**被 Vue 实例代理，因为它们可能和 Vue 内置的 property、API 方法冲突。你可以使用例如 `vm.$data._property` 的方式访问这些 property；当一个**组件**被定义，`data` 必须声明为返回一个初始数据对象的函数
   
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

2. methods：定义方法到 Vue 实例中。可以直接通过 VM 实例访问这些方法，或者在指令表达式中使用。方法中的 this 自动绑定为 Vue 实例。注意，不应该使用箭头函数来定义 method 函数 (例如 plus: () => this.a++)。理由是箭头函数绑定了父级作用域的上下文，所以 this 将不会按照期望指向 Vue 实例，this.a 将是 undefined。
   
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

3. watch：监听数据模型中的数据，数据一旦发生变化，就通知侦听器所绑定的方法；使用场景是数据变化时候执行异步并或开销大的操作；Vue 实例将会在实例化时调用 `$watch()`，遍历 watch 对象的每一个 property。
   
   ```js
   let vue = new Vue({
       ... ...
       watch:{
           监听属性名称:function(变化后的值){
   
           }
       }
   })
   ```

4. computed：
   
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

- 挂载：初始化相关属性
  1. **beforeCreate**：在实例初始化之后，数据观测 (data observer) 和 event/watcher 事件配置之前被调用
  2. **created**：在实例创建完成后被立即调用。在这一步，实例已完成以下的配置：数据观测 (data observer)，property 和方法的运算，watch/event 事件回调。然而，挂载阶段还没开始，`$el` property 目前尚不可用。
  3. **beforeMount**：在挂载开始之前被调用：相关的 render 函数首次被调用，**该钩子在服务器端渲染期间不被调用**
  4. **mounted**：实例被挂载后调用，这时 `el` 被新创建的 `vm.$el` 替换了。如果根实例挂载到了一个文档内的元素上，当 `mounted` 被调用时 `vm.$el` 也在文档内。**该钩子在服务器端渲染期间不被调用**
- 更新：元素或组件的变更操作
  1. **beforeUpdate**：数据更新时调用，发生在虚拟 DOM 打补丁之前。这里适合在更新之前访问现有的 DOM，比如手动移除已添加的事件监听器。**该钩子在服务器端渲染期间不被调用，因为只有初次渲染会在服务端进行。**
  2. **updated**：由于数据更改导致的虚拟 DOM 重新渲染和打补丁，在这之后会调用该钩子。当这个钩子被调用时，组件 DOM 已经更新，所以你现在可以执行依赖于 DOM 的操作。然而在大多数情况下，你应该避免在此期间更改状态。如果要相应状态改变，通常最好使用计算属性或 watcher 取而代之。
  3. **activated**：被 keep-alive 缓存的组件激活时调用。**该钩子在服务器端渲染期间不被调用。**
- 销毁：销毁相关属性
  1. **deactivated**：被 keep-alive 缓存的组件停用时调用。**该钩子在服务器端渲染期间不被调用。**
  2. **beforeDestroy**：实例销毁之前调用。在这一步，实例仍然完全可用。**该钩子在服务器端渲染期间不被调用。**
  3. **destroyed**：实例销毁后调用。该钩子被调用后，对应 Vue 实例的所有指令都被解绑，所有的事件监听器被移除，所有的子实例也都被销毁。**该钩子在服务器端渲染期间不被调用。**
- 异常：
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

- v-text：纯文本填充，相比差值表达式更简洁，**指定标签中的文本会被属性值替换**
  
  ```html
  <div v-text='Model属性名称'></div>
  ```

- v-html：内容按普通的HTML插入，不会作为Vue模板进行编译，**危险**：在网站上动态渲染任何HTML都是非常危险的，容易导致XSS工具（跨站脚本攻击）；**建议**：本网站的内部数据是可以使用的，如果是来自第三方数据不建议使用
  
  ```html
  <div v-html='Model属性名称'></div>
  ```

- v-pre：填充绑定的DOM中的原始信息，跳过编译过程（也不会编译差值表达式）
  
  ```html
  <div v-pre>{{Model属性名称}}</div>
  ```

- v-once：表示只会绑定一次数据，不会有数据响应式功能，**优点**：有助于提高性能
  
  ```html
  <div v-once>{{msg}}</div>
  <div v-once v-text='msg'></div>
  ```

- v-model：双向数据绑定：主要是针对输入框，用户输入的数据可以修改模型数据值，模型数据库值的改变页面相应到页面
  
  ```html
  <input type="text" v-model='Model属性名称'>
  ```
  
  > - 学习资料：https://xiaoman.blog.csdn.net/article/details/123187523
  > - 在vue3中v-model是破坏性更新的：其实是一个语法糖，通过props和emit组合而成的
  > - 可以定义在子组件中，并且在子组件中使用emit可以操作v-model的值也会影响到父组件中的值，
  > - 在vue3中一个组件可以绑定多个值
  > - 自定义修饰符，在子组件中可以接收
  
  > 1. v-model绑定组件,组件默认接受值的属性是:modelValue
  >
  >    ```vue
  >    父组件
  >    <template>
  >        <div>
  >            <Dialog v-model="flag"></Dialog>
  >        </div>
  >    </template>
  >    
  >    子组件
  >    <script setup lang="ts">
  >    import { defineProps, defineEmits } from 'vue'
  >    
  >    type Props = {
  >        modelValue: boolean
  >    }
  >    defineProps<Props>()
  >    </script>
  >    ```
  >
  > 2. 子组件中可以通过emit修改v-model的值实现值双向绑定
  >
  >    ```vue
  >    <script setup lang="ts">
  >    const emit = defineEmits(['update:modelValue'])
  >    const closeSub = () => {
  >        emit('update:modelValue', false)
  >    }
  >    </script>
  >    ```
  >
  > 3. v-modle可以自定义属性名称
  >
  >    ```vue
  >    父组件中绑定多个属性
  >    <template>
  >        <div>
  >            <Dialog v-model="flag" v-model:title="title"></Dialog>
  >        </div>
  >    </template>
  >    
  >    子组件修改属性值
  >    <script setup lang="ts">
  >    const emit = defineEmits(['update:modelValue', 'update:title'])
  >    const closeSub = () => {
  >        emit('update:modelValue', false)
  >        emit('update:title', '子组件修改了标题')
  >    }
  >    </script>
  >    ```
  >
  > 4. v-model添加自定义修饰符
  >
  >    ```vue
  >    在父组件中的model中添加修饰符
  >    <template>
  >        <div>
  >            <Dialog v-model="flag" v-model:title.xlxs="title"></Dialog>
  >        </div>
  >    </template>
  >          
  >    子组件中接收修饰符的值: 修饰符Modifiers对象
  >    <script setup lang="ts">
  >    import { defineProps, defineEmits } from 'vue'
  >          
  >    type Props = {
  >        modelValue: boolean
  >            
  >      	// title属性和title属性的修饰符(非必传)
  >        title: string
  >        titleModifiers?: {
  >            xlxs: boolean
  >        }
  >    }
  >    const propsData = defineProps<Props>()
  >          
  >    const emit = defineEmits(['update:modelValue', 'update:title'])
  >    const closeSub = () => {
  >        console.log(propsData.titleModifiers)
  >    }
  >    </script>
  >    ```

### 4. 事件绑定 v-on

- 事件绑定
  
  1. **v-on:事件名称**：事件绑定的标准格式
     
     ```html
     <button v-on:click='JavaScript代码'>按钮</button>
     ```
  
  2. **@:事件名称**：事件绑定的简写格式
     
     ```html
     <button @click='JavaScript代码'>按钮</button>
     ```

- 事件函数的调用方式
  
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

- 事件修饰符
  
  1. **常用事件修饰**：绑定事件监听器。事件类型由参数指定。表达式可以是一个方法的名字或一个内联语句，如果没有修饰符也可以省略；用在普通元素上时，只能监听原生 DOM 事件。用在自定义元素组件上时，也可以监听子组件触发的自定义事件;
     
     | 事件修饰符                 | 作用                                             |
     | --------------------- | ---------------------------------------------- |
     | .stop                 | 调用 `event.stopPropagation()`，阻止冒泡事件            |
     | .prevent              | 调用 `event.preventDefault()`，阻止默认事件             |
     | .self                 | 只当事件是从侦听器绑定的元素本身触发时才触发回调。                      |
     | .once                 | 只触发一次回调                                        |
     | .left                 | (2.2.0) 只当点击鼠标左键时触发                            |
     | .right                | (2.2.0) 只当点击鼠标右键时触发                            |
     | .middle               | (2.2.0) 只当点击鼠标中键时触发                            |
     | .capture              | 添加事件侦听器时使用 capture 模式                          |
     | .{keyCode 或 keyAlias} | 只当事件是从特定键触发时才触发回调                              |
     | .passive              | (2.3.0) 以 `{ passive: true }` 模式添加侦听器,事件将会立即触发 |
     | .native               | 监听组件根元素的原生事件                                   |
  
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
     ```
     
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

- 按键修饰符
  
  1. **常用的按键码的别名**
     
     | 建码别名    | 按键           |
     | ------- | ------------ |
     | .enter  | 回车           |
     | .tab    | 制表符          |
     | .delete | 捕获“删除”和“退格”键 |
     | .esc    | ESC退出        |
     | .space  | 空格           |
     | .up     | 上方向键         |
     | .down   | 下方向键         |
     | .left   | 左方向键         |
     | .right  | 右方向键         |
  
  2. **系统修饰键**：在和 `keyup` 事件一起用时，事件触发时修饰键必须处于按下状态
     
     | 建码别名   | 按键                                                                                                                                                  |
     | ------ | --------------------------------------------------------------------------------------------------------------------------------------------------- |
     | .ctrl  | Ctrl                                                                                                                                                |
     | .alt   | Alt                                                                                                                                                 |
     | .shift | Shift                                                                                                                                               |
     | .meta  | 在 Windows 系统键盘 meta 对应 Windows 徽标键 (⊞)<br />Mac 系统键盘上，meta 对应 command 键 (⌘)<br />在 Sun 操作系统键盘上，meta 对应实心宝石键 (◆)<br />在 Symbolics 键盘上为“META”或者“Meta” |
     | .exact | 允许你控制由精确的系统修饰符组合触发的事件                                                                                                                               |
     
     ```html
     <!-- 选中后 Ctrl + 单机  -->
     <button v-on:click.ctrl="onClick">A</button>
     
     <!-- 有且只有 Ctrl 被按下的时候才触发 -->
     <button v-on:click.ctrl.exact="onCtrlClick">A</button>
     
     <!-- 没有任何系统修饰符被按下的时候才触发 -->
     <button v-on:click.exact="onClick">A</button>
     ```
  
  3. **鼠标修饰符**
     
     | 建码别名    | 按键   |
     | ------- | ---- |
     | .left   | 单机   |
     | .right  | 右击   |
     | .middle | 滚轮单机 |

- 自定义按键修饰符
  
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

- 通过class样式处理：样式绑定的本质是为元素绑定class属性，class属性绑定语法也可以与普通的class属性共存
  
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

- 内联样式style属性绑定：样式绑定的本质是为元素绑定style属性
  
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

- v-if='条件值'：控制元素是否在HTML结构中渲染
  
  ```html
  <h1 v-if="awesome">Vue is awesome!</h1>
  ```

- v-else-if='条件值'：在上一个v-if的逻辑之中，如果上一个if的逻辑为真，即使当前的条件为真也不会显示
  
  ```html
  <div v-if="type === 'A'">A</div>
  <div v-else-if="type === 'B'">B</div>
  <div v-else-if="type === 'C'">C</div>
  <div v-else>Not A/B/C</div>
  ```

- v-else：在上一个v-if的逻辑之中，如果上一个if的逻辑为真，即使当前的条件为真也不会显示

- v-show='条件值'：控制元素的显示与隐藏
  
  ```html
  <h1 v-show="ok">Hello!</h1>
  ```

### 8. 循环结构 `v-for`

- 遍历数组：基本类型数组、对象类型数组
  
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

- 遍历对象：遍历对象可以根据参数的数量灵活的获取对象相关的值
  
  ```html
  格式一:遍历获取单个参数，第一个参数表示对象属性的对应的value
  <ul>
    <li v-for="value in object">
      {{ value }}
    </li>
  </ul>
  ```
  
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
- 遍历范围：范围是值遍历的可迭代是一个数值，遍历从1开始，步长为1；参数设置和遍历数组是相同的

```html
<div v-for="i in 10">{{i}}</div>
<div v-for="(i,index) in 10">{{i}}-{{index}}</div>
```

### 9. 循环特性

- 遍历绑定key属性：key属性用户标识列表中每一条元素，是唯一值；**key属性的值来自与单个元素中**
  
  ```html
  <ul id="example-1">
    <li v-for="item in items" :key="item.message">
      {{ item.message }}
    </li>
  </ul>
  ```

- 遍历数据的作用域：在 v-for 块中，我们可以访问所有列表之外是数据的 property
  
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

### 10. 自定义指令

- Vue3指令的钩子函数

  | 钩子函数      | 作用                                |
  | ------------- | ----------------------------------- |
  | created       | 元素初始化的时候                    |
  | beforeMount   | 指令绑定到元素后调用一次,只调用一次 |
  | mounted       | 元素插入父级DOM调用                 |
  | beforeUpdate  | 元素被更新前调用                    |
  | updated       | 修改后调用                          |
  | beforeUnmount | 元素被移除前调用                    |
  | unmounted     | 指令被移除后调用,只调用一次         |

- 自定义指令定义:命名格式v{名称}OfDirective的形式来命名本地自定义指令,这样才能直接在模板中使用

  ```vue
  <script setup lang="ts">
  import { ref, Directive, DirectiveBinding } from 'vue'
  import A from '@/components/vue3model/ModelDirectiveA.vue'
  type Dir = {
      key: string
  }
  const flag = ref(true)
  const vMove: Directive = {
      created() {
          console.log('created')
      },
      beforeMount() {
          console.log('onBeforeMount')
      },
      mounted(el: Element, dir: DirectiveBinding<Dir>) {
          console.log('mounted', el, dir.value.key)
      },
      beforeUpdate() {
          console.log('beforeUpdate')
      },
      updated() {
          console.log('updated')
      },
      beforeUnmount() {
          console.log('beforeUnmount')
      },
      unmounted() {
          console.log('unmounted')
      },
  }
  </script>
  
  <template>
      <n-button @click="flag = !flag">卸载</n-button>
      <A v-move="{ key: 'val' }" v-if="flag"></A>
  </template>
  
  <style></style>
  ```

- 自定义指令的函数简写:在mounted和updated时触发相同的行为,而且不关心其他函数,可以使用函数简写模式实现

  ```vue
  <script setup lang="ts">
  import { ref, Directive, DirectiveBinding } from 'vue'
  import A from '@/components/vue3model/ModelDirectiveA.vue'
  type Dir = {
      key: string
  }
  const text = ref('')
  const vMove: Directive = (el, dir: DirectiveBinding<Dir>) => {
      el.style.background = dir.value.key
  }
  </script>
  
  <template>
      <input v-model="text" />
      <A v-move="{ key: text }"></A>
  </template>
  ```

### 11. 自定义hooks

- 概述
  - Vue3的hook函数相当于vue2的mixin,不同是在于hooks是函数
  - Vue3的hook函数可以提高代码的复用性,在不用的组件都能利用hooks函数
- 

### 12. 全局函数和全局变量

- Vue3中没有Prototype属性,使用app.config.globalProperties代替,然后去定义变量和函数

  ```tsx
  // VUE2
  Vue.propotype.$http = () => {}
  
  // VUE3
  const app = createApp({})
  app.config.globalProperties.$http  = () => {}
  ```

- 过滤器:在Vue中移除了过滤器,可以使用全局函数代替过滤器

  ```tsx
  const app = createApp(App)
  
  // 自定义Filter是一个函数
  type Filter = {
      format: <T>(str: T) => string
  }
  
  // Filter声明文件
  declare module '@vue/runtime-core' {
      export interface ComponentCustomOptions {
          $filter: Filter
      }
  }
  // 添加全局函数
  app.config.globalProperties.$filter = {
      format<T>(str: T): string {
          return `真·${str}`
      },
  }
  
  // 使用全局变量
  $filter.format('test')
  ```
  
  

## 2.6 Vue资源 - 过滤器

- 过滤器的作用：主要是用于格式化数据

- 自定义过滤器：过滤器函数中的参数表示通过管道符传递过来的参数
  
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

- 过滤器的使用：|可以理解为管道符，作用是把管道符左边的值交给过滤器进行处理
  
  ```html
  在差值表达式中使用
  <div>{{属性名称 | 过滤器名称}}</div>
  
  在属性绑定中使用
  <div v-bind='属性名称 | 过滤器名称'></div>
  ```

- 过滤器的参数：在定义过滤器和使用过滤器时候可以传递参数，默认是从第二个参数开始赋值
  
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

- 自定义指令的语法规则
  
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

- 钩子函数说明：一个指令定义对象可以提供如下几个钩子函数
  
  - **bind**：只调用一次，指令第一次绑定到元素时调用
  - **inserted**：被绑定元素插入父节点时调用 (仅保证父节点存在，但不一定已被插入文档中)
  - **update**：所在组件的 VNode 更新时调用，但是可能发生在其子 VNode 更新之前。指令的值可能发生了改变，也可能没有。但是你可以通过比较更新前后的值来忽略不必要的模板更新
  - **componentUpdated**：指令所在组件的 VNode 及其子 VNode 全部更新后调用
  - **unbind**：只调用一次，指令与元素解绑时调用

- 钩子函数参数：一个指令定义对象可以提供如下几个钩子函数
  
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

- 自定义指令的使用：可以使用v-model完成数据双向绑定
  
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

3. **表单操作** 
   
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

### 1. 实例方法 / 事件

- `vm.$on( event, callback)`：监听当前实例上的自定义事件。事件可以由 `vm.$emit` 触发。回调函数会接收所有传入事件触发函数的额外参数。
  
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

### 2. 自定义Vue插件

- 插件概述:

  - 插件是自包含的代码,通常向Vue添加全局功能,如果一个对象需要有install方法,Vue会帮助这个对象自动注入到install方法,如果是function就直接当install方法使用

- 自定义插件

  - 插件入口ts:在插件中使用组件

    ```ts
    import { App, createVNode, render, VNode } from 'vue'
    import Loadding from '@/plugin/LoadingCom.vue'
    
    export default {
        install(app: App) {
            // 转为虚拟DOM
            const vnode: VNode = createVNode(Loadding)
            // 创建为真实DOM
            render(vnode, document.body)
            app.config.globalProperties.$loadding = {
                show: vnode.component?.exposed?.show,
                hide: vnode.component?.exposed?.hide,
            }
        },
    }
    ```

### 3. scoped和样式穿透

### 4. css Style完整特性

- 插槽选择器
- 全局选择器
- 动态css

### 5. 打包



## 2.10 Vue3 Setup

### 1. ref家族

- 在setup中直接定义的变量是没有响应式的，如下：修改变量的值，不会再页面同步修改
  
  ```ts
  let msg1 = 'test'
  ```

- ref的基本用法：①从vue中引入ref函数、②定义基本类型变量使用ref函数、③修改ref变量中的值使用ref对象的value属性
  
  ```ts
  // 引入ref函数
  import { ref } from 'vue'
  // 定义ref引用变量
  const msg2 = ref('test')
  // 修改变量值
  msg2.value = '修改后的值'
  ```

- 使用ref函数定义的变量的类型是`Ref<nwrapRef<T>>`，所以定义变量的方式也可以用如下方式
  
  ```ts
  const msg3: Ref<string> = ref('test')
  ```

- `shallowRef()`只处理基本数据类型的响应式, 不进行对象的响应式处理。如果需要修改对象的响应式，需要配合triggerRef
  
  ```ts
  // 定义基本类型的shallowRef引用的变量
  const baseShall = shallowRef('基本类型的Shall')
  // 修改shallowRef的值
  baseShall.value = '修改基本类型是Shall变量'
  ```

- `triggerRef()`配合shallowRef一起使用；  可以使用triggerRef(xxx)强制使括号内属性进行同步（即触发一次响应）
  
  ```ts
  import { triggerRef , shallowRef} from 'vue'
  let message = shallowRef({
    tags: 'helloworld'
  })
  const changeTag = () => {
    message.value.tags = 'goodbyeworld'
    triggerRef(message)   // 强制触发响应
  }
  ```

- `customRef()`自定义`ref`指令，作用：在修改某些变量时候，当值发生改变后可以发送请求，实现防抖操作
  
  ```ts
  // ①首先需要自定义函数，返回值是customRef的回调
  function myRef<T>(value: T) {
      return customRef((trank, trigger) => {
            // ②customRef中获取值时触发get方法，修改值时触发set方法
            return {
              get() {
                  // ③用来收集依赖
                  trank()
                  return value
              },
              set(newVal: T) {
                  value = newVal
                  // ④触发更新操作
                  trigger()
              },
          }
      })
  }
  // 使用自定义ref修改变量
  const customRefVal = myRef<number>(1)
  const customRefCheck = () => {
      customRefVal.value = 2
  }
  ```

### 2. reactive家族

- reactive用于定义具有响应式的复杂对象类型，修改reactive变量可以直接修改对象中的值
  
  ```ts
  // 定义
  const r1 = reactive({
      name: '张三',
  })
  // 修改
  r1.name = '修改reactive对象属性'
  ```

- readonly：定义只读对象，对象和对象属性不允许被修改
  
  ```ts
  const r2 = readonly({
      name: '只读对象',
  })
  ```

- shallowReactive：只修改对象浅层属性，并且响应到页面；修改对象深层属性时候可以修改对象的值，但是不会响应到页面
  
  ```ts
  const r3 = shallowReactive({
      name: '外层',
      address: {
          city: '陕西',
          subArr: ['aaa', 'bbb'],
          subObj: {
              name: '内层',
          },
      },
  })
  // 修改并且具备响应式
  const changeR31 = () => {
      r3.name = '修改外层属性'
  }
  // 可以修改，但是不会响应
  const changeR32 = () => {
      r3.address.subArr.push('cc')
  }
  // 
  const changeR33 = () => {
      r3.address.subObj.name = '修改内层属性'
  }
  ```

### 3. toRef、toRefs、toRaw

- toRef应用的对象属性，也会影响原始对象的属性，但是不会更新页面
  
  ```tsx
  const obj1 = {
      name: '姓名',
      age: 13,
  }
  
  const toR1 = toRef(obj1, 'age') 
  
  toR1.value++
  ```

- toRefs：用来解构reactive对象，并且解构后的属性具有响应式，原理是每个属性都调用toRef函数，所以通过属性的value属性修改属性值；
  
  ```tsx
  const obj2 = reactive({
      name1: '姓名',
      age1: 13,
  })
  const { name1, age1 } = toRefs(obj2)
  // 修改toRefs解构后的值
  const changeReactive2 = () => {
      name1.value = '修改名称'
      age1.value++
  }
  ```

- toRaw：将reactive代理对象转为原始对象
  
  ```tsx
  const obj3 = reactive({
      test: 'test',
  })
  const raw = toRaw(obj3)
  ```

### 4. computed计算属性

- 函数形式：可以使用计算属性的返回值作为变量使用
  
  ```tsx
  const c1 = computed(() => {
      return '$.' + t1.value
  })
  ```

- 对象形式：获取计算属性的值调用get方法，但是这种形式的set方法是不会触发的，绝大多数情况下使用函数的简写形式
  
  ```tex
  const c2 = computed({
      get() {
          return t2.value + '###'
      },
      set(val) {
          t2.value = val
          console.log(111)
      },
  })
  ```

### 5. watch监听

- 作用：侦听特定的数据源，并在单独的回调函数中执行

- watch参数说明
  
  - 第一个参数：监听源
  
  - 第二个参数：回调函数(vueVal,oldVal)
  
  - 第三个参数：一个配置对象，①immediate=true是否立即调用，②deep=true是否开启深度监听

- 监听单个参数
  
  ```tsx
  const ma1 = ref('aaa')
  
  watch(ma1, (newVal, oldVal) => {
      console.log('1.newVal=', newVal)
      console.log('1.oldVal=', oldVal)
  })
  ```

- 监听多个参数：当监听的数据源是ref类型的值时，设置deep属性可以控制ref对象是否监听深层属性，如果是reactive类型对象，无论是否设置deep都会监听深层属性。
  
  ```tsx
  const mb1 = ref('aaa')
  const mb2 = ref({
      one: {
          two: {
              three: 3,
          },
      },
  })
  watch(
      [mb1, mb2],
      (newVal, oldVal) => {
          console.log('2.newVal=', newVal)
          console.log('2.oldVal=', oldVal)
      },
      {
          deep: false,
          immediate: true,
      }
  )
  ```

- 设置需要监听的参数：如果要多个参数中监听其中的一个参数，第一个参数是回调形式的参数，回调函数的返回值是需要监听的参数
  
  ```tsx
  const mc1 = ref('aaa')
  const mc2 = reactive({
      one: {
          two: {
              three: 3,
          },
      },
  })
  watch(
      () => mc2.one.two.three,
      (newVal, oldVal) => {
          console.log('2.newVal=', newVal)
          console.log('2.oldVal=', oldVal)
      }
  )
  ```

- watchEffect高级监听器：只需要在监听函数内定使用需要监听的变量即可生效，并且高级监听默认都会执行一次；before参数是指在监听的值修改之前触发的回调；watchEffect的配置项：①flush指定监听器触发的时机②onTrigger用来捕获触发监听时候捕获的事件。
  
  ```tsx
  const md1 = ref('高级监听1')
  const md2 = ref('高级监听2')
  const watchObj = watchEffect(
      (before) => {
          console.log(md1.value)
          console.log(md2.value)
          before(() => {
              console.log('before', md1.value)
              console.log('before', md2.value)
          })
      },
      {
          // flush: 'pre', // 组件更新前执行
          // flush: 'sync', // 签好字效果始终同步触发
          flush: 'post', // 组件更新后执行
          onTrigger(event) {
              debugger
          },
      }
  )
  ```

### 6. 生命周期

```tsx
import { onBeforeMount, onBeforeUpdate, onMounted, onUpdated } from 'vue'
import { onUnmounted, onBeforeUnmount } from 'vue'
```

### 7. less与scope

- 在style中添加scope属性用来隔离样式，打包后会保证样式不重复

  ```tml
  <style lang="scss" scoped>
  h1 {
      color: $MyColor;
  }
  </style>
  ```

# 第三章 组件化开发

## 3.1 组件开发思想

        前端代码开发中，程序实现是希望尽可能多的做到代码重用，然而前端在代码重用中可能会产生CSS样式和JS业务逻辑的冲突；由此产生的Web Components开发标准：其核心思想是通过创建封装特定功能的定制元素（是一个自定义标签并且具有特定功能），并且能够解决冲突问题；

        但是这个Web Components标准没有被浏览器广泛支持，但是Vue部分实现了Web Components开发标准。把不同的功能在不同的组件中开发，通过组件组合的方式实现功能的同一实现。

        组件设计是将不同的功能封装在不同的组件中，通过组件的整合形成完整意义上的一个应用；

        Vue中组件分为全局组件和局部组件，在Vue组件本质也是一个Vue实例，拥有Vue对象的全部属性：如data、methods等等；组件注册实际上是将定义好的组件绑定到Vue实例中，可以将组件定义在Vue对象（java中称类）上，称为全局组件，这样所有的vue实例都可以使用该组件；如果将组件定义在Vue实例上，称为局部组件，可以在当前Vue实例范围内使用；

## 3.2 组件开发

### 1.  创建组件

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

### 2.  使用组件

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

### 3. 组件基本属性说明

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

### 1. 父组件向子组件传值

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

### 2. 同级组件传值

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

### 3. 子组件向父组件传值

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

### 4. vue3组件传值

- defineProps：子组件接收父组件传递的值

  - 父组件中引入子组件，并且给子组件添加属性，给属性赋值表示 传递的值

    ```vue
    <template>
        <h1>父组件</h1>
        <son title="在父组件中定义的标题" />
    </template>
    ```

  - 子组件中定义Props的type，定义属性以及对应类型，在使用defineProps接受类型,也可以使用withDefault默认值,接收defineProps,在第二个参数中定义变量的默认值

    ```vue
    <script setup lang="ts">
    import { defineProps } from 'vue'
    type Props = {
        title?: string
    }
    
    withDefaults(defineProps<Props>(), {
        title: '默认值',
    })
    </script>
    
    <template>
        <h1>子组件</h1>
        <p>接受父组件中传递的值: {{ title }}</p>
    </template>
    ```

- defineEmits：子组件给父组件派发事件，在派发事件时候传递参数

  - 首先在子组件中定义需要派发的事件名称，再根据定义好的事件名称派发事件并带参数

    ```vue
    <script setup lang="ts">
    import { defineProps, ref, defineEmits } from 'vue'
    const sonValue = ref<string>()
    
    const emit = defineEmits(['son-click'])
    const sengValueToParent = () => {
        emit('son-click', sonValue.value, 2, false)
    }
    </script>
    ```

  - 父组件中引入子组件，并在子组件中绑定需要接收的派发事件

    ```vue
    <script setup lang="ts">
    import { ref } from 'vue'
    import son from '@/components/vue3/Demo09Son.vue'
    
    const getParentValue = ref<string>()
    const sonClick = (val: string, num: number, boo: boolean) => {
        console.log(val)
        console.log(num)
        console.log(boo)
        getParentValue.value = val
    }
    </script>
    
    <template>
        <h1>父组件: -- {{ getParentValue }}</h1>
        <son title="在父组件中定义的标题" @son-click="sonClick" />
    </template>
    ```

  - 在子组件中触发事件后会将组件的值发送给父组件

- defineExpose：子组件暴露给父组件内部属性

  - 在父组件使用ref拿到子组件的实例，ref指定的名称就是定义的变量名

    ```vue
    <script setup lang="ts">
    import { ref } from 'vue'
    import son from '@/components/vue3/Demo09Son.vue'
    
    const sonObj = ref(null)
    console.log(sonObj)
    </script>
    
    <template>
        <h1>父组件: -- {{ getParentValue }}</h1>
        <son ref="sonObj" title="在父组件中定义的标题" @son-click="sonClick" />
    </template>
    ```

  - 然后在子组件中暴露变量

    ```vue
    <script setup lang="ts">
    import { defineProps, ref, defineEmits, defineExpose } from 'vue'
    
    const sonValue = ref<string>()
    const falg = ref<boolean>(false)
    
    defineExpose({
        sonValue,
        falg,
    })
    </script>
    ```

## 3.4 组件插槽

### 1. 插槽概述

​		在定义Vue组件的时候，在组件内预留指定位置作为插槽（slot），当在使用组件的时候在这个插槽位置的展示内容可以由使用者指定，所以插槽的目的是为了让Vue组件更具有扩展性

​		子组件中提供给父组件使用的一个占位符，用`<slot></slot>`表示，父组件template中添加子组件的标签胡后，可以在标签内部填充任何模板代码（html或者Vue组件），填充的内容会替换子组件的`<slot></slot>`

### 2. 插槽使用

- **插槽的基本使用**：①在子组件内定义`<slot>`作为插槽②父组件使用子组件时候，在组件内自定义内容替换子组件的插槽
  
  ```html
  定义子组件,在子组件内指定<slot></slot>
  <template id="cpn">
      <div>
          <p>我是组件</p>
          <slot></slot>
      </div>
  </template>
  在父组件中使用子组件时候,在组件内自定义内容
  <cpn>
      <button>用按钮代替插槽内容</button>
  </cpn>
  ```

### 3. 插槽分类

- 匿名插槽：默认只有一个插槽，不需要给插槽定义名称，直接替换

  ```vue
  // 在子组件中指定位置定义插槽
  <template>
      <slot></slot>
  </template>
  // 父组件中引入子组件并在子组件中添加内容用来替换子组件的插槽
  <script setup lang="ts">
  import Slot1 from '@/components/vue3/Demo12Slot1.vue'
  </script>
  
  <template>
      <div>
          <h2>匿名插槽</h2>
          <Slot1>
              <template v-slot>
                  <n-button>父组件中把按钮给到子组件</n-button>
              </template>
          </Slot1>
      </div>
  </template>
  ```

- **具名插槽**：如果在子组件中要定义多个没有命名的slot，子组件的多个插槽都会被父组件提供的内容替换

  ```vue
  // 在子组件中定义插槽时候为slot指定name值
  <template id="cpnB">
      <div>
          <p>我是组件B</p>
          <slot name="a"></slot>
          <slot name="b"></slot>
          <slot name="c"></slot>
      </div>
  </template>
  // 在父组件总中使用组件时候，给替换的内容添加slot属性并指定插槽的名称
  <cpn-b>
      <button slot="a">替换插槽A</button>
      <button slot="b">替换插槽B</button>
      <button slot="c">替换插槽C</button>
  </cpn-b>
  ```

- **作用域插槽**：在父组件替换子组件时候，定义在插槽上的数据是来自子组件，而不是来自使用组件的实例；

  ```html
  第一步 首先在子组件中定义插槽并定义data
  <script setup lang="ts">
  import { reactive } from 'vue'
  const list = reactive<string[]>(['Java', 'C++', 'Ptyhon'])
  </script>
  
  第二步 在子组件中定义插槽并在插槽中绑定数据
  <template>
      <div>
          <slot :result="list"></slot>
      </div>
  </template>
  
  第三步 父组件中在使用子组件的插槽时候, 在插槽中定义根标签, 在标签中添加slot-scope属性绑定到插槽并使用插槽作用域中数据
  <div>
    <h2>插槽作用域</h2>
    <Slot3>
      <template v-slot="{ result }">
        <a :key="index" href="#" v-for="(item, index) in result">{{ item }}</a>
      </template>
    </Slot3>
    <h2>插槽作用域 简写方式v-slot用#号代替</h2>
    <Slot3>
      <template #default="{ result }">
        <a :key="index" href="#" v-for="(item, index) in result">{{ item }}</a>
      </template>
    </Slot3>
  </div>
  ```

- 动态插槽：子组件中定义了多个插槽，在父组件中使用子组件时候可以指定插槽名称，动态的改变插入的插槽

  ```vue
  // 在子组件中定义多个插槽
  <template>
      <div>
          <h4>a</h4>
          <slot name="a"></slot>
          <hr />
          <h4>b</h4>
          <slot name="b"></slot>
          <hr />
          <slot name="c"></slot>
          <h4>c</h4>
      </div>
  </template>
  // 父组件引入插槽时候名称采用动态,修改name的值可以动态的插入到子组件的对应插槽中
  <script setup lang="ts">
  import Slot4 from '@/components/vue3/Demo12Slot4.vue'
  import { ref } from 'vue'
  const name = ref('a')
  </script>
  <template>
    <Slot4>
      <template #[name]>
        <div>
          <h4>输入框输入a,b,c会动态的插入</h4>
      </div>
      </template>
    </Slot4>
  </template>
  ```

## 3.5 组件封装

1. 全局组件：封装全局组件

   - 定义一个vue作为全局组件

   - 在main.ts中引入全局组件

     ```ts
     createApp(App)
         .use(router)
         .use(createPinia())
         .component('Card', Card)
         .mount('#app')
     ```

   - 在其他组件中可以直接使用全局组件，不需要使用import

2. 局部组件：使用import引入的组

3. 递归组件：例如自己调用自己，通过某个条件来结束递归，防止内存泄漏

   - 在当前组件中引入自己，在使用自己的时候，给一定的条件

     ```vue
     <script setup lang="ts">
     import { defineProps } from 'vue'
     import Tree from '@/components/vue3/Demo10Tree.vue'
     type MenuList = {
         name: string
         child: MenuList[]
     }
     type Props = {
         list: MenuList[]
     }
     defineProps<Props>()
     </script>
     
     <template>
         <div :key="index" v-for="(item, index) in list">
             {{ item.name }}
             <Tree v-if="item?.child?.length" :list="item.child" />
         </div>
     </template>
     ```

   - 方式二：不引入自己，给自己的组件定义名称

     ```vue
     <script setup lang="ts">
     import { defineProps } from 'vue'
     type MenuList = {
         name: string
         child: MenuList[]
     }
     type Props = {
         list: MenuList[]
     }
     defineProps<Props>()
     </script>
     // 单独定义一个script并指定名称
     <script lang="ts">
     export default {
         name: 'TreeItem',
     }
     </script>
     <template>
         <div :key="index" v-for="(item, index) in list">
             {{ item.name }}
             <TreeItem v-if="item?.child?.length" :list="item.child" />
         </div>
     </template>
     ```

4. 动态组件：

   - markRaw:封装组件跳过代理

   - 动态组件使用,首先获取到所有的组件,在定义一个默认的当前组件,在使用component的is属性表示当前激活的组件

     ```vue
     <script setup lang="ts">
     import { reactive, markRaw } from 'vue'
     import A from '@/components/vue3/Demo11D1.vue'
     import B from '@/components/vue3/Demo11D2.vue'
     import C from '@/components/vue3/Demo11D3.vue'
     
     type Types = {
         name: string
         component: any
     }
     // 从其他类型在摘取出一个属性的类型
     type Com = Pick<Types, 'component'>
       
     // ① 获取所有组件
     const com = reactive<Types[]>([
         { name: 'a', component: markRaw(A) },
         { name: 'b', component: markRaw(B) },
         { name: 'c', component: markRaw(C) },
     ])
     // ② 定义当前显示的组件
     const current = reactive<Com>({
         component: com[0].component,
     })
     
     const nextCom = (e: Types) => {
         current.component = e.component
     }
     </script>
     
     <template>
         <div class="content">
             <div class="tab">
                 <div @click="nextCom(item)" :key="index" v-for="(item, index) in com">
                     {{ item.name }}
                 </div>
             </div>
             <component :is="current.component"></component>
         </div>
     </template>
     
     <style></style>
     ```

## 3.6 异步组件

- 首先定义一个组件,组件内使用awat方法

  ```vue
  <script setup lang="ts">
  const getArticleInfo = async () => {
      await new Promise((resolve) => setTimeout(resolve, 5000))
      const article = {
          title: 'Vue3 中使用 defineAsyncComponent 延迟加载组件',
          author: 'lio',
      }
      return article
  }
  const article = await getArticleInfo()
  </script>
  
  <template>
      <div>
          {{ article }}
      </div>
  </template>
  ```

- 在父组件中使用defineAsyncComponent异步引入组件,并使用Suspense组件中的插槽实现异步执行效果,并且打包时候也会单独打包

  ```vue
  <script setup lang="ts">
  import { defineAsyncComponent } from 'vue'
  const Data = defineAsyncComponent(() => import('@/components/vue3/Demo13Data.vue'))
  </script>
  
  <template>
      <h1>异步组件</h1>
      <div>
          <Suspense>
              <template #default>
                  <Data />
              </template>
              <template #fallback>
                  <div>loadding...</div>
              </template>
          </Suspense>
      </div>
  </template>
  ```

- defineAsyncComponent的用法

  - 简单用法

    ```tsx
    import { defineAsyncComponent } from 'vue'
    
    // 简单用法
    const ArticleList = defineAsyncComponent(() =>
      import('@/components/ArticleList.vue')
    )
    ```

  - 完整的选项对象,一般默认就已足够

    ```tsx
    const AsyncPopup = defineAsyncComponent({
      loader: () => import('./ArticleList.vue'),
      // 加载异步组件时使用的组件
      loadingComponent: LoadingComponent,
      // 加载失败时使用的组件
      errorComponent: ErrorComponent
      // 在显示加载组件之前延迟。默认值：200ms。
      delay: 1000,
      // 超过给定时间，则会显示错误组件。默认值：Infinity。
      timeout: 3000
    })
    ```

## 3.7 Teleport传送组件

- Teleport是一种能够将我们的模板渲染值DOM节点，不受父级style、v-show等属性的影响，但data、prop数据依旧能够使用的技术，主要解决的问题：Teleport节点挂载到其他指定DOM节点下，完全不受父级Style样式影响

- 通过to属性插入指定元素位置：支持html、class、id等选择器

  ```vue
  <template>
      <Teleport to="body">
          <h2>Teleport</h2>
      </Teleport>
      <hr />
      <Teleport to=".model">
          <p>插入到Index中的自定义类标签中</p>
      </Teleport>
  </template>
  ```

## 3.8 keep-alive组件

- 不希望组件被重写渲染影响使用体验，重写渲染会刷新数据，也可以避免多次渲染降低性能，而是希望组件可以缓存下来，维持当前状态

- 开启keep-alive生命周期的变化

  - 初期进入时：onMounted > onActivated
  - 退出后触发：deactivated
  - 再次进入只会触发onActivated
  - 时间挂载等方法等，只执行一次的放在onMounted中，组件每次进去执行的方法放在onActivated中

- 基本用法：对需要缓存的组件使用keep-alive组件

  ```vue
  <keep-alive>
    <Alive1 v-if="falg" />
    <Alive2 v-else />
  </keep-alive>
  ```

  > 使用keep-alive组件会产生两个声明周期
  >
  > ```tsx
  > import { onMounted, onActivated, onDeactivated } from 'vue'
  > 
  > onMounted(() => {
  >     console.log('22 onMounted')
  > })
  > onActivated(() => {
  >     console.log('22 onActivated')
  > })
  > 
  > onDeactivated(() => {
  >     console.log('22 onDeactivated')
  > })
  > ```

- 可以指定需要缓存的组件:keep-alive的include或exclude属性,max表示需要缓存的前10个

  ```vue
  <template>
      <n-button @click="change">切换</n-button>
      <keep-alive :max=10 :include=['Alive1']>
          <Alive1 v-if="falg" />
          <Alive2 v-else />
      </keep-alive>
  </template>
  ```

## 3.9 组件动画

1. Vue提供了transition的封装组件，在下列情形中，可以给任何元素和组件添加进入和离开过渡

   - 条件渲染：v-if
   - 条件展示：v-show
   - 动态组件
   - 组件根节点

2. 自定义transition：对transition组件的name属性自定义，并在css中写入对应的样式，在进入离开的过滤中会有6个class切换

   - v-enter-from：定义进入过渡的开始状态，在元素被插入前生效，在元素插入后的下一帧移除

   - v-enter-active：定义进入过渡生效时的状态，在整个过渡阶段中应用，在元素插入之前生效，在过渡或动画完成后移除，主要用来定义过渡期间的时间、延迟、曲线函数

   - v-enter-to：定义进入过渡的结束状态，在元素插入后下一帧生效（于此同时v-enter-form被移除），在过渡/动画完成后被移除

     ```css
     .tran01-enter-from {
         width: 0;
         height: 0;
     }
     .tran01-enter-active {
         transition: all 1.5s ease;
     }
     .tran01-enter-to {
         width: 200px;
         height: 200px;
     }
     ```

   - v-leave-from：定义离开过渡的开始状态。在离开过渡被触发时立刻生效，下一帧被移除。

   - `v-leave-active`：定义离开过渡生效时的状态。在整个离开过渡的阶段中应用，在离开过渡被触发时立刻生效，在过渡/动画完成之后移除。这个类可以被用来定义离开过渡的过程时间，延迟和曲线函数。

   - v-leave-to：离开过渡的结束状态。在离开过渡被触发之后下一帧生效 (与此同时 v-leave-from 被移除)，在过渡/动画完成之后移除。

     ```css
     .tran01-leave-from {
         width: 100px;
         height: 100px;
         transform: rotate(360deg);
     }
     .tran01-leave-active {
         transition: all 1.5s ease;
     }
     .tran01-leave-to {
         width: 0;
         height: 0;
     }
     ```

3. 自定义过渡 class 类名：在trasnsition 组件中的属性指定需要自定义的类名

   - `enter-from-class`
   - `enter-active-class`
   - `enter-to-class`
   - `leave-from-class`
   - `leave-active-class`
   - `leave-to-class`

4. 动画库animate css

   - 安装动画库animate css：https://animate.style/

     ```shell
     npm install animate.css
     ```

   - 在使用动画库的组件中引入动画组件

     ```tsx
     import 'animate.css'
     ```

   - 给trasnsition组件添加动画样式：animate__animated固定值，在后面添加动画样式

     ```vue
     <transition
                 leave-active-class="animate__animated animate__backOutUp"
                 enter-active-class="animate__animated animate__bounceInRight"
                 >
       <div class="def" v-if="flag3">使用animateChange切换</div>
     </transition>
     ```

5. transition 生命周期8个：当只用 JavaScript 过渡的时候，在 enter 和 leave 钩子中必须使用 done 进行回调

   ```tsx
     @before-enter="beforeEnter" //对应enter-from
     @enter="enter"//对应enter-active
     @after-enter="afterEnter"//对应enter-to
     @enter-cancelled="enterCancelled"//显示过度打断
     @before-leave="beforeLeave"//对应leave-from
     @leave="leave"//对应enter-active
     @after-leave="afterLeave"//对应leave-to
     @leave-cancelled="leaveCancelled"//离开过度打断
   ```

   ```vue
   <script>
     const enterBefore = (el: Element) => {
       console.log('进入之前', el)
     }
     const enterActive = (el: Element, done: Function) => {
       console.log('进入', el)
       setTimeout(() => {
         done()
       }, 1000)
     }
     const enterAfter = (el: Element) => {
       console.log('进入之后', el)
     }
     const leaveBefore = (el: Element) => {
       console.log('离开之前', el)
     }
     const leaveActive = (el: Element, done: Function) => {
       console.log('离开', el)
       setTimeout(() => {
         done()
       }, 5000)
     }
     const leaveTo = (el: Element) => {
       console.log('离开之后', el)
     }
     const enterCancel = (el: Element) => {
       console.log('过渡被打断', el)
     }
   </script>
   <template>
   <div>
     <h3 @click="tranChange">使用transition切换</h3>
     <transition
                 name="tran01"
                 @before-enter="enterBefore"
                 @enter="enterActive"
                 @after-enter="enterAfter"
                 @before-leave="leaveBefore"
                 @leave="leaveActive"
                 @after-leave="leaveTo"
                 >
       <div class="def" v-if="flag2">使用transition切换</div>
     </transition>
     </div>
   </template>
   ```

   > - 可以配合js动画库生成动画效果：gsap官网：https://greensock.com/
   >
   >   ```tsx
   >             
   >   ```

6. transition appear属性：设置初始节点过度 就是页面加载完成就开始动画 对应三个状态

   - appear-active-class=""

   - appear-from-class=""

   - appear-to-class=""

   - appear

     ```vue
     <template>
     <div>
       <h3 @click="tranChange">使用transition切换</h3>
       <transition
                   name="tran01"
                   appear
                   appear-from-class="appearForm"
                   appear-active-class="appearActove"
                   appear-to-class="appearTo"
                   >
         <div class="def" v-if="flag2">使用transition切换</div>
       </transition>
       </div>
     </template>
     <style>
       .appearForm {
         width: 0;
         height: 0;
       }
       .appearActove {
         transition: all 1.5s ease;
       }
       .appearTo {
         width: 200px;
         height: 200px;
       }
     </style>
     ```

7. transition-group过渡列表：v-for在这种场景下，需要使用 `<transition-group>` 组件。

   - 默认情况下，被渲染的组件不会添加一个包裹元素，通过tag属性指定被渲染组件的一个包裹属性
   - 渲染列表必须提供一个唯一的key属性值
   - css过渡的类将会应用在内部的元素中，而不是group容器本身

   ```vue
   <template>    
   	<div>
       <n-button @click="Pop">pop</n-button>
       <n-button @click="Push">Push</n-button>
       <transition-group
                         leave-active-class="animate__animated animate__backOutUp"
                         enter-active-class="animate__animated animate__bounceInRight"
                         >
         <div style="margin: 10px" :key="item" v-for="item in list">{{ item }}</div>
       </transition-group>
     </div>
   </template>
   <script>
   const list = reactive<number[]>([1, 2, 4, 5, 6, 7, 8, 9])
   const Push = () => {
       list.push(123)
   }
   const Pop = () => {
       list.pop()
   }
   </script>
   ```

8. transition-group列表移动过：修改列表中元素位置，添加动画；新增的 v-move 类可以为定位的改变添加动画，它的前缀可以通过 name attribute 来自定义，也可以通过 move-class attribute 手动设置

   ```vue
   <template>
       <div>
           <button @click="shuffle">Shuffle</button>
           <transition-group class="wraps" name="mmm" tag="ul">
               <li class="cell" v-for="item in items" :key="item.id">{{ item.number }}</li>
           </transition-group>
       </div>
   </template>
     
   <script setup  lang='ts'>
   import _ from 'lodash'
   import { ref } from 'vue'
   let items = ref(Array.apply(null, { length: 81 } as number[]).map((_, index) => {
       return {
           id: index,
           number: (index % 9) + 1
       }
   }))
   const shuffle = () => {
       items.value = _.shuffle(items.value)
   }
   </script>
     
   <style scoped lang="less">
   .wraps {
       display: flex;
       flex-wrap: wrap;
       width: calc(25px * 10 + 9px);
       .cell {
           width: 25px;
           height: 25px;
           border: 1px solid #ccc;
           list-style-type: none;
           display: flex;
           justify-content: center;
           align-items: center;
       }
   }
    
   .mmm-move {
       transition: transform 0.8s ease;
   }
   </style>
   ```

9. 状态过渡：可以给数字 Svg 背景颜色等添加过度动画 

   ```vue
   <template>
       <div>
           <input step="20" v-model="num.current" type="number" />
           <div>{{ num.tweenedNumber.toFixed(0) }}</div>
       </div>
   </template>
       
   <script setup lang='ts'>
   import { reactive, watch } from 'vue'
   import gsap from 'gsap'
   const num = reactive({
       tweenedNumber: 0,
       current:0
   })
    
   watch(()=>num.current, (newVal) => {
       gsap.to(num, {
           duration: 1,
           tweenedNumber: newVal
       })
   })
    
   </script>
   ```

## 3.10 依赖注入

1. 概述：通常父组件向子组件传递数据库时使用props，如果有深嵌套的组件，而且只需要父组件给最深子组件传递数据，如果仍然使用pops就会变的很麻烦；provide可以在祖先组件中指定我们需要提供给后代的数据或方法，而在任何后代组件中可以使用inject来接受 provide提供的数据或方法

2. 使用方法：使用ref或者reactive类型变量，使数据具有响应式，数值修改会修改每一层的数据

   - 在父级组件中添加一个属性，并且给这个属性赋值

     ```tsx
     const flag = ref<number>(1)
     provide('flag', flag)
     ```

   - 在子组件中使用Inject函数接收父组件中添加的属性

     ```tsx
     import { inject, Ref, ref } from 'vue'
     // 直接使用inject会在ts中有类型推断错误，需要给一个默认值或者兜底函数
     // const flag = inject('flag')
     const flag = inject<Ref<number>>('flag', ref(1))
     const change = () => {
         flag.value = 2
     }
     ```

3. 实现原理：provide是在setup语法糖的语法中可以使用，读取父级的provide属性然后赋值给自己

## 3.11 兄弟组件传值

1. 用父组件充当桥梁，接受A组件的值，传递给B组件

   - 在A组件中使用defineEmits将事件和数据传递给父组件

     ```tsx
     const emit = defineEmits(['a-click'])
     const aValueChange = () => {
         emit('a-click', aValue.value)
     }
     ```

   - 在父组件中接受A组件的数据，在传递给B组件

     ```vue
     <script setup lang="ts">
     import { ref } from 'vue'
     import A from './Demo16A.vue'
     import B from './Demo16B.vue'
     
     const toBValue = ref<string>('')
     const getAValue = (val: string) => {
         toBValue.value = val
     }
     </script>
     
     <template>
         <div>
             <h1>使用父组件作为中间件桥梁</h1>
             <A @a-click="getAValue" />
             <B :bValue="toBValue" />
         </div>
     </template>
     ```

2. 自定义EmitUtil工具类，进行封装回调并监听，手写一个发布订阅模式

   - 自定义封装EmitUtil工具类

     ```tsx
     type BusClass = {
         // name: 自定义事件名称
         emit: (name: string) => void
         // name: 自定义事件名称, 参数传给callback函数
         on: (name: string, callback: Function) => void
     }
     
     type PramsKey = string | number | symbol
     
     type List = {
         [key: PramsKey]: Array<Function>
     }
     
     class Bus implements BusClass {
         list: List
         constructor() {
             this.list = {}
         }
     
         emit(name: string, ...args: Array<any>) {
             const eventName: Array<Function> = this.list[name] || []
             eventName.forEach((fn) => {
                 fn.apply(this, args)
             })
             console.log(eventName)
         }
     
         on(name: string, callback: Function) {
             const fn: Array<Function> = this.list[name] || []
             fn.push(callback)
             this.list[name] = fn
         }
     }
     
     export default new Bus()
     
     ```

   - 在组件A中emit事件并发送数据

     ```tsx
     import Bus from '@/utils/BusUtil'
     const aValue2 = ref<string>('')
     const aValueChange2 = () => {
         Bus.emit('a-bus-click', aValue2.value)
     }
     ```

   - 在B组件中直接使用Bus中的事件接收数据

     ```tsx
     import Bus from '@/utils/BusUtil'
     const value2 = ref('')
     Bus.on('a-bus-click', (val: string) => {
         value2.value = val
     })
     ```

3. Mitt：在vue3中$on、$off、$off方法已被移除，组件实例不能在实现事件触发接口，因此EventBus无法使用，可以使用mitt库，实现了发布订阅模式

   - 安装mitt库

     ```shell
     npm install mitt -S
     ```

   - 在main.ts中初始化：挂载全局总线

     ```tsx
     const app = createApp(App)
     const Mit = mitt()
     
     declare module 'vue' {
         export interface ComponentCustomProperties {
             $Bus: typeof Mit
         }
     }
     
     app.config.globalProperties.$Bus = Mit
     ```

   - 在A组件的事件中定义事件并传递数据

     ```tsx
     import { ref, defineEmits, getCurrentInstance } from 'vue'
     const instence = getCurrentInstance()
     const aValue3 = ref<string>('')
     const aValueChange3 = () => {
         instence?.proxy?.$Bus.emit('emit-change', aValue3.value)
     }
     ```

   - 在兄弟组件B中获取 事件以及事件回调中带过来的参数

     ```tsx
     import { ref, defineEmits, getCurrentInstance } from 'vue'
     
     const instance = getCurrentInstance()
     const value3 = ref<any>('')
     instance?.proxy?.$Bus.on('emit-change', (value) => {
         value3.value = value
     })
     ```

   - 清空所有事件

     ```tsx
     instance?.proxy?.$Bus.all.clear()
     ```

## 3.12 jsx

1. 在vue中可以使用Template写模板，现在可以扩展另一种风格TSX风格，Vue3对Typescript的支持，jsx的写法也越来越好用

2. 安装插件

   ```shell
   npm install @vitejs/plugin-vue-jsx -D
   ```

3. 配置插件

   ```tsx
   import vueJsx from '@vitejs/plugin-vue-jsx'
   
   export default defineConfig({
     plugins: [vueJsx()]
   })
   ```

4. 配置ts配置文件:**`tsconfig.json`**

   ```json
   {
     "jsx":"perserve",
     "jsxFactory":"h",
     "jsxFragmentFactory":"Fragment"
   }
   ```

5. 定义jsx文件

   ```jsx
   const renderDom = () => {
       return (
           <div>
               <h1>我的JSX的模板</h1>
           </div>
       )
   }
   
   export default renderDom
   ```

6. 引入jsx模板并使用

   ```vue
   import renderDom from '@/components/jsx/Demo01.jsx'
   
   <template>
       <div>
           <h1>JSX</h1>
           <renderDom></renderDom>
       </div>
   </template>
   ```

7. vue中tsx的使用

   - tsx中使用vue指令：v-model、v-show支持；v-for、v-if不支持，需要使用jsx的表达式，
   - https://blog.csdn.net/m0_38066007/article/details/121237370
   
8. 

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
   ```
   
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
     npm install -g @vue/cli            # 安装脚手架3
     npm install -g @vue/cli-init    # 拉取脚手架2模板
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

## 6.1 路由概述

> 改变浏览器中URL，但是不刷新页面

1. Router默认采用location的hash属性
   
   ```js
   location.hash='路由'
   ```

2. 采用Html5的history模式
   
   ```js
   history.pushStatus({},'','url');
   history.replaceStatus({},'','url');
   history.back();
   history.forward();
   ```

## 6.2 路由的安装配置

- vue-router是vue官方的路由插件，与vue深度集成，适合构建单页面应用

- vue-router安装：路由插件是在运行时也需要支持的
  
  ```sh
  npm install vue-router --save
  ```

- **配置路由**：①导入VueRouter组件②将VueRouter组件挂载到Vue之上（Vue实例就有了router-link、router-view等全局组件和$router全局属性）③创建Router实例对象，并配置路由映射④将Router实例对象添加到Vue实例属性中
  
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

## 6.3 路由的使用

- **路由使用的基本说明**：①上一步已经定义好了路由与组件的映射②默认是只有App组件被挂载到Vue实例上，所以首先要在App组件中定义可以触发路由的动作（使用代码方式或使用router-link组件）③可以触发路由并切换浏览器URL后还需要将路由映射的组件显示在App组件中，才能做到改变URL不刷新页面，所以必须在App组件中定义router-view组件（作用是切换路由后，路由所映射的组件会替换router-view的位置而显示在App组件中，最终渲染为UI页面）。

- **路由使用的案例说明**：
  
  ① 配置了路由组件映射：路由的配置是一个数组，数组中包含映射对象，映射对象的属性说明
  
  ```js
  const router = [
      {
          name:"指定映射对象的名称",
          path:"路由",
          component:"路由对应的地址"
      }
  ]
  ```
  
  ② router-link的使用：是vue-router自动注册的全局组件
  
  ```html
  <router-link to='路由'>文本标识</router-link>
  ```
  
  > - 属性to:指定要跳转的路由;
  > - 属性tag:表示被渲染的标签;默认被渲染为a标签
  > - 属性replace:修改方式为replace
  > - 激活class属性:默认名称是router-link-exact-active、router-active-active
  > - 属性：active-class；修改样式的激活的名称，可以在router对象的属性中全局添加linkActiveClass属性
  
  ③ router-view：路由映射的组件的渲染，作用是占位，如果router-link获取到组件内容，组件的内容会替换这个占位标签
  
  ```html
  <router-view></router-view>
  ```

## 6.4 路由高级用法

### 1. **默认路由（路由转发redirect）**

> 启动Vue默认的URL是`/`后没有路由信息，需要将`/`转发到其他路由

```js
const router = [
    {
        name:"默认路由重定向到其他路由",
        path:"/",
        redirect:"路由"
    }
]
```

### 2. 修改路由模式

> 默认是使用hash方式（`#/路由的方式`），修改常规的html的history模式

```js
const router = new VueRouter({
    mode: "history",
    routes,
});
```

### 3. 使用代码的方式触发路由

> 挂载Router后全局会有`$router`属性

```js
this.$router.push("/路由")
this.$router.replace("/路由")
this.$router.back()
this.$router.forward()
```

### 4. 路由动态匹配

# 第五章 vue-router4

## 5.1 路由入门

### 1. 安装与配置

1. 下载
   
   ```sh
   npm install vue-router@4 --save
   # 或者
   npm install vue-router@next --save
   ```

2. 创建一个vue视图：Xxx.vue

3. 添加路由配置：src/router/index.ts
   
   ```tsx
   // 1. 导入创建路由对象需要的依赖
   import { RouteRecordRaw, createRouter, createWebHistory } from 'vue-router';
   // 2. 定义路由映射表
   export const routes: RouteRecordRaw[] = [
     path: '/xxx',
     name: 'Xxx',
     component: () => import("@/view/Xxx.vue")
   ]
   // 3. 创建路由对象:添加路由映射表
   const router = createRouter({
       history: createWebHistory(),
       routes,
   });
   // 4. 导出路由对象
   export default router;
   ```

4. 将路由对象挂载到Vue实例中：main.ts
   
   ```tsx
   import { createApp } from 'vue'
   import App from './App.vue'
   
   import router from "@/router";
   
   createApp(App)
       .use(router)
       .mount('#app')
   ```

5. 最后在App.vue中添加路由容器
   
   ```html
   <router-view></router-view>
   ```

6. 访问路由测试

### 2. 路由说明

- createRouter：创建一个可以被 Vue 应用程序使用的路由实例。查看 [`RouterOptions`](https://next.router.vuejs.org/zh/api/#routeroptions) 中的所有可以传递的属性列表。

- createWebHistory：创建一个 hash 历史记录

- createWebHashHistory：创建一个基于内存的历史记录

- `<router-link>`：是定义在VueRouter中的组件
  
  | 属性                 | 类型               | 说明                                                                         |
  | ------------------ | ---------------- | -------------------------------------------------------------------------- |
  | to                 | RouteLocationRaw | 表示目标路由的链接                                                                  |
  | replace            | boolean          | 导航后是否会留下历史记录<br /> = true:  router.replace()<br /> = falsue: router.push() |
  | active-class       | string           | 链接激活时，应用于渲染的标签的 class                                                      |
  | exact-active-class |                  | 链接精准激活时，应用于渲染的标签的 class                                                    |
  | aria-current-value |                  | 当链接激活时，传递给属性 `aria-current` 的值                                             |
  | custom             | boolean          |                                                                            |
  | `v-slot`           |                  |                                                                            |
  
  > 1. to示例
  >    
  >    ```tsx
  >    <!-- 字符串 -->
  >    <router-link to="/home">Home</router-link>
  >    <!-- 渲染结果 -->
  >    <a href="/home">Home</a>
  >                            
  >    <!-- 使用 v-bind 的 JS 表达式 -->
  >    <router-link :to="'/home'">Home</router-link>
  >                            
  >    <!-- 同上 -->
  >    <router-link :to="{ path: '/home' }">Home</router-link>
  >                            
  >    <!-- 命名的路由 -->
  >    <router-link :to="{ name: 'user', params: { userId: '123' }}">User</router-link>
  >                            
  >    <!-- 带查询参数，下面的结果为 `/register?plan=private` -->
  >    <router-link :to="{ path: '/register', query: { plan: 'private' }}">
  >      Register
  >    </router-link>
  >    ```

- `<router-view>`
  
  | 属性       | 类型                      | 说明                                             |
  | -------- | ----------------------- | ---------------------------------------------- |
  | name     | string                  | 命名视图                                           |
  | route    | RouteLocationNormalized | 如果所有组件都被懒加载                                    |
  | `v-slot` |                         | 使用 `<transition>` 和 `<keep-alive>` 组件来包裹你的路由组件 |

## 5.2 路由基础

### 1. 基本用法

> 如上路由安装配置中的基本用法

### 2. 动态路由

- ### 3. 路由嵌套

### 4. 编程式导航

- push
  
  ```tsx
  // 字符串路径
  router.push('/users/eduardo')
  
  // 带有路径的对象
  router.push({ path: '/users/eduardo' })
  
  // 命名的路由，并加上参数，让路由建立 url
  router.push({ name: 'user', params: { username: 'eduardo' } })
  
  // 带查询参数，结果是 /register?plan=private
  router.push({ path: '/register', query: { plan: 'private' } })
  
  // 带 hash，结果是 /about#team
  router.push({ path: '/about', hash: '#team' })
  const username = 'eduardo'
  // 我们可以手动建立 url，但我们必须自己处理编码
  router.push(`/user/${username}`) // -> /user/eduardo
  // 同样
  router.push({ path: `/user/${username}` }) // -> /user/eduardo
  // 如果可能的话，使用 `name` 和 `params` 从自动 URL 编码中获益
  router.push({ name: 'user', params: { username } }) // -> /user/eduardo
  // `params` 不能与 `path` 一起使用
  router.push({ path: '/user', params: { username } }) // -> /user
  ```

- replace
  
  ```tsx
  router.push({ path: '/home', replace: true })
  // 相当于
  router.replace({ path: '/home' })
  ```

- go
  
  ```tsx
  // 向前移动一条记录，与 router.forward() 相同
  router.go(1)
  
  // 返回一条记录，与router.back() 相同
  router.go(-1)
  
  // 前进 3 条记录
  router.go(3)
  
  // 如果没有那么多记录，静默失败
  router.go(-100)
  router.go(100)
  ```

### 5. 命名路由

### 6. 命名视图

### 7. 重定向和别名

### 8. 路由传参

# 第六章 Vuex详解

## 6.1 VueX介绍

1. **VueX说明**：是为Vue应用程序开发的状态管理模式：采用集中式存储管理应用程序中的共享公共变量，并且以相应的规则管理这些公共变量；

2. **状态管理**：VueX的状态的本质是组件内定义的变量，单页面状态本质是定义在组件的data对象中的变量；VueX主要作用是多页面的状态管理，VueX状态管理指将多个组件中的变量抽取并统一配置在VueX中，并且对状态的操作在VueX中定义；VueX一般会管理项目中的全局共享变量；
   
   - **单页面状态**：Vue的单组件数据的状态变化流程：数据的状态定义在data对象中，数据根据数据状态渲染在View中，在View中的执行了action改变了data中的数据状态，被改变的数据状态响应式的显示在View中；
     
     <img src='https://vkceyugu.cdn.bspapp.com/VKCEYUGU-b1ebbd3c-ca49-405b-957b-effe60782276/2eae72c6-f9f6-4429-a06d-f682d12fe009.png' width=50%/>
   
   - **多页面状态**：而在多组件的状态管理时，单向数据流的简洁性很容易被破坏：①多个组件依赖同一个状态②不同的组件需要对状态进行变更，并且其他组件可以做到响应式；VueX为解决多组件的状态管理问题，重新定义了多组件的状态的数据流：如果直接在Vue组件中改变state，DevTools是监听不到state的变化过程，必须使用VueX中定义好的规则改变VueX中的state
     
     - Action：组件中的异步操作
     
     - Mutations：组件中的同步操作
     
     - State：多组件共享数据
     
     - DevTools：Vue的浏览器插件会监听到VueX中的state的变化流
       
       <img src='https://vkceyugu.cdn.bspapp.com/VKCEYUGU-b1ebbd3c-ca49-405b-957b-effe60782276/42bf4d4a-be12-4346-8f60-305f1538fe41.png' width=70%/>

3. **单一状态树**：如果项目中的状态信息是保存到多个Store对象中的，那么对状态的管理和维护都会特别困难；所有VueX采用了单一状态树（一个项目只定义一个store实例对象）管理应用层级的全部状态：单一状态树能够用最直接的方式找到某个状态的片段，并且可以做到非常方便的管理和维护；

4. **vuex响应式原理**： state中属性会被加入到响应式系统中，当属性发生变化时，会通知到所有使用该属性的组件并渲染数据；

## 6.2 VueX安装与配置

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

## 6.3 VueX基础

### 1. Vuex.Store 参数

| 参数名       | 作用                                                                                                                                                                                                      |
| --------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| state     | 保存状态，key:value格式的数据，**推荐使用单一数据源（一个store）**<br />mutations中属性必须提前初始好的才有响应式                                                                                                                               |
| getters   | store中对状态的计算属性：<br /> - 第一个参数state对象<br /> - 第二个对象是getters对象<br /> - 模块中是getter第三个参数是root<br /> - 在getters中返回参数，在调用getters时候可以传递自定义参数                                                                   |
| mutations | 更新VueX中states唯一的方式：提交mutation<br /> - mutations的函数分为两部分：①事件类型（方法名），②回调函数（方法体）<br /> - mutations的函数参数：第一个参数默认是states，第二个参数是自定义参数（payload）<br /> - 项目开发中将mutation的事件类型抽取为一个常量<br /> - mutation中方法推荐使用同步方法 |
| actions   | actions是用来替代mutation执行异步操作<br /> - action中方法默认参数是context：表示action执行的上下文store对象<br /> - 在模块中action中context参数表示是当前的store模块                                                                                |
| modules   | store中的模块化                                                                                                                                                                                              |

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

- 概述：Vuex由于使用单一状态树，即应用的所有状态都会集中到一个比较大的对象；当应用变得复杂时候，store对象就会变得相当臃肿。因此，Vuex允许将store分隔为模块（module），每个模块都拥有自己的state、mutation、action、getter甚至是嵌套子模块（但是不建议这么用）。默认情况模块内的action、mutation和getter都是注册在全局名命空间的，如果使用分隔模块（module）具有封装性和复用性，就需要使用到moduel到命名空间（namespaced）

- 设置模块（module）为一个命名空间：在模块中添加熟悉namespaced:true
  
  ```js
  const moduleA ={
      namespaced:true,  //开启namespace:true，该模块就成为命名空间模块了
      state:{
          count:10,
          countA:888
      },
      getters:{...},
      mutations:{...},
      actions:{...}
  }
  ```

- 获取module中数据
  
  1. 获取state数据
     
     ```js
     // 1. 基本方式
     this.$store.state.moduleA.countA
     
     // 2. mapState辅助函数方式
       ...mapState({
         count:state=>state.moduleB.countB
       })
     ```
  
  2. 获取getters
     
     ```js
     // 共有三种方式，如下：
     // 1.
     commonGetter(){
         this.$store.getters['moduleA/moduleAGetter']
     },
     // 2. 此处的moduleA，不是以前缀的形式出现！！！
     ...mapGetters('moduleA',['moduleAGetter'])
     // 3.别名状态下
     ...mapGetters({
         paramGetter:'moduleA/moduleAGetter'
     }),
     ```
  
  3. 获取mutations
     
     ```js
     // 共有三种方式，如下：
     //1,3加个前缀moduleA/，都可以实现。2使用辅助函数未变名称的特殊点！！！
     //1.
     commonMutation(){
         this.$store.commit('moduleA/moduleAMutation');
     },
     //2.
     ...mapMutations('moduleA',['moduleAMutation']),
     //3.别名状态下
     ...mapMutations({
         changeNameMutation:'moduleA/moduleAMutation'
     }),
     ```
  
  4. 获取actions
     
     ```js
     //共有三种方式，如下：
     //1,3加个前缀moduleA/，都可以实现。2使用辅助函数未变名称的特殊点！！！
     //1.
     commonAction(){
         this.$store.dispatch('moduleA/moduleAAction')
     },
     //2.
     ...mapActions('moduleA',['moduleAAction']),
     //3.别名状态下
     ...mapActions({
         changeNameAction:'moduleA/moduleAAction'
     })
     ```

- 获取根store，当前模块，兄弟模块中的action，mutations ，getters
  
  - **state数据**： 通过rootState参数   即：rootState.属性名
  
  - **getter方法**：通过rootGetters参数来获取  即:rootGetters.increNum
  
  - 获取根store模块中的：
    
              state数据： 通过rootState参数    即：rootState.属性名
              
              getter方法：通过rootGetters参数来获取   即:rootGetters.increNum
              
                                    附：向根getters中传递参数方式：rootGetters.increNum({id:11,name:'lucy'});
                                           根store中getters定义接多参数：getters:{   //目前个人研究：只能传递一个参数，或者一个对象
                                                                                                      increNum:(state)=>(obj)=>{
                                                                                                            console.log(obj)
                                                                                                      }
                                                                                               }
              
              提交mutations：commit('increment',null,{root:true});       //increment为根store中的mutation
              
              分发actions：dispatch('incrementAction',null,{root:true});   //incrementAction为根store中的action
              
               参数部分示例：actions:{
                                               moduleAAction({state,commit,dispatch,getters,rootState,rootGetters}){
                                                          //处理逻辑
                                               }
                                         }
    
    获取当前模块中的：
    
               state数据：通过state参数来获取     即：state.属性名
        
               getter方法：通过getters参数来执行    即：getters.moduleAIncreNum();  //传递参数：可以是多个，也可以是一个obj对象
        
               提交mutations：通过commit参数来执行   即：commit('moduleAMutation);  
        
               分发actions：通过dispatch参数来执行   即：dispatch('nextmoduleAAction');
        
               参数部分示例：actions:{
                                              moduleAAction({state,commit,dispatch,getters,rootState,rootGetters}){
                                                           //处理逻辑
                                              }
                                        }
    
    获取兄弟模块中的：(当前模块名：moduleA)
    
                state数据：通过rootState参数来获取     即：rootState.moduleA.属性名
        
                getter方法：通过getters参数来执行    即：rootGetters['moduleB/moduleBGetter']  
        
                提交mutations：通过commit参数来执行   即：commit('moduleB/moduleBMutation',{},{root:true}); 
        
                分发actions：通过dispatch参数来执行   即：dispatch('moduleB/moduleBAction',{},{root:true});
    
    7.在带命名空间的模块中，如何将action注册为全局actions
    
         两个条件：
        
               ①添加 root: true
               ②并将这个 action 的定义放在函数 handler 中
    
    //storeAction在命名空间moduleA中，但是它是一个全局actions
    const moduleA = {
    
        namespaced:true,
        storeAction:{
            root:true,  //条件1
            handler(namespacedContext, payload){//条件2：handler
                //namespacedContext 上下文信息
                //payload 载荷，即参数
                console.log(namespacedContext)
                console.log(payload)
                alert("我是模块A中的全局storeAction")
            }
        }
    
    }
    8.当使用 mapState, mapGetters, mapActions 和 mapMutations 这些函数来绑定带命名空间的模块时，写起来可能比较繁琐，该怎么解决呢？
    computed: {
    
        ...mapState({
            a: state => state.some.nested.module.a,
            b: state => state.some.nested.module.b
        })
    
    },
    methods: {
    
        ...mapActions([
            'some/nested/module/foo', // -> this['some/nested/module/foo']()
            'some/nested/module/bar' // -> this['some/nested/module/bar']()
        ])
    
    }
    解决办法：对于这种情况，你可以将模块的空间名称字符串作为第一个参数传递给上述函数，这样所有绑定都会自动将该模块作为上下文。于是上面的例子可以简化为：
    
    computed: {
    
        ...mapState('some/nested/module', {
            a: state => state.a,
            b: state => state.b
        })
    
    },
    methods: {
    
        ...mapActions('some/nested/module', [
            'foo', // -> this.foo()
            'bar' // -> this.bar()
        ])
    
    }
    9.除了8中的将空间名称作为第一个参数传递外，还有其它别的方法吗？
    
           你可以通过使用 createNamespacedHelpers 创建基于某个命名空间辅助函数。它返回一个对象，对象里有新的绑定在给定命名空间值上的组件绑定辅助函数：
    
    import { createNamespacedHelpers } from 'vuex'
    
    const { mapState, mapActions } = createNamespacedHelpers('some/nested/module')
    
    export default {
      computed: {
    
        // 在 `some/nested/module` 中查找
        ...mapState({
          a: state => state.a,
          b: state => state.b
        })
    
      },
      methods: {
    
        // 在 `some/nested/module` 中查找
        ...mapActions([
          'foo',
          'bar'
        ])
    
      }
    }

## 6.4 mapXxx

1. mapState

2. mapGetters

3. mapMutations

4. mapActions
- 使用方式：每个组件都有自己的computed计算属性，从vuex中引入mapGetters
  
  ```js
  import { mapGetters } from 'vuex'
  export default{
    computed: {
      // 通过结构赋值将指定的属性添加到组件的计算属性中
      ...mapGetters(['vuex中getter计算属性字符串'])
    }
  }
  ```

# 第七章 Pinia

## 7.1 简介

1. 概述：代替Vuex，是更好用的状态管理工具，其核心特点：①完整的ts支持、②足够轻量级、③去除了mutations，只有state、getters、actions（支持异步和同步）、④代码扁平化没有模块嵌套，只有store的概念，store之间可以自由使用，每个store都是独立的、⑤无需手动添加store，store创建会自动添加，直接引入即可使用、⑥支持vue2、vue3

2. 安装

   ```shell
   # 下载pinia依赖
   npm install pinia
   
   # 在Vue3的main.ts中配置pinia
   import { createPinia } from 'pinia'
   createApp(App)
       .use(router)
       .use(createPinia())
       .mount('#app')
   ```

## 7.2 基本用法

1. 初始化store仓库：①新建src/store文件夹，②在store中定义一个独立的XxxStore.ts作为一个store文件

   ```tsx
   import { defineStore } from 'pinia'
   // 第一个参数id:作用的唯一的命名空间,用于标识不同的store
   export const helloStore = defineStore('helloStore', {
     	// 状态管理，返回对象即是需要管理的状态
       state: () => {
           return {}
       },
     	// store的一个计算属性
       getters: {},
     	// 可以做同步或异步，提交stats
       actions: {},
   })
   ```

2. 在组件中使用定义好的一个store

   ```tsx
   // 结构store并且具备响应式
   import { storeToRefs } from 'pinia'
   // 引入自定义的store
   import { helloStore } from '@/stores/HelloStore'
   // 实例化store,用于获取store对象中的值
   const hello = helloStore()
   // 解构store中的属性值
   const { getCounter, getName, notAdmin } = storeToRefs(hello)
   ```

## 7.2 state

1. 直接修改store中的状态值

   ```tsx
   const { counter } = storeToRefs(hello)
   counter.value++
   ```

2. 使用store对象的$patch对象修改

   ```ts
       hello.$patch({
           counter: 999,
           name: '批量修改',
       })
   ```

3. 使用store对象的$patch回调修改

   ```tsx
       hello.$patch((state) => {
           state.counter++
           state.name = '函数回调'
       })
   ```

4. 使用store对象的$state对象将状态对象中的state完全覆盖

   ```tsx
       hello.$state = {
           counter: 2323,
           name: '整体覆盖',
           isAdmin: false,
       }
   ```

5. 使用actions方法修改state

   ```tsx
   import { defineStore } from 'pinia'
   // 第一个参数id:作用的唯一的命名空间,用于标识不同的store
   export const helloStore = defineStore('helloStore', {
     	// 状态管理，返回对象即是需要管理的状态
       state: () => {
           return {}
       },
     	// store的一个计算属性
       getters: {},
     	// 可以做同步或异步，提交stats
       actions: {
         actionCounter() {
               this.counter++
           },
       },
   })
   
   // 在组件中直接调用actions中的方法,也可以传递参数
   hello.actionCounter()
   ```

## 7.3 解构state

1. 直接解构state对象是不具备响应式的

   ```tsx
   // 引入自定义的store
   import { helloStore } from '@/stores/HelloStore'
   // 实例化store,用于获取store对象中的值
   const hello = helloStore()
   // 解构store中的属性值是不具备响应式的
   const { getCounter, getName, notAdmin } = hello
   ```

2. 使用pinia提供的storeToRefs进行结果store对象

   ```tsx
   // 结构store并且具备响应式
   import { storeToRefs } from 'pinia'
   // 引入自定义的store
   import { helloStore } from '@/stores/HelloStore'
   // 实例化store,用于获取store对象中的值
   const hello = helloStore()
   // 解构store中的属性值
   const { getCounter, getName, notAdmin } = storeToRefs(hello)
   ```

## 7.4 actions

1. 同步actions

   ```tsx
   import { defineStore } from 'pinia'
   // 第一个参数id:作用的唯一的命名空间,用于标识不同的store
   export const helloStore = defineStore('helloStore', {
     	// 状态管理，返回对象即是需要管理的状态
       state: () => {
           return {}
       },
     	// store的一个计算属性
       getters: {},
     	// 可以做同步或异步，提交stats
       actions: {
         actionCounter() {
               this.counter++
           },
       },
   })
   
   // 在组件中直接调用actions中的方法,也可以传递参数
   hello.actionCounter()
   ```

2. 异步actions

   ```tsx
   import { defineStore } from 'pinia'
   // 第一个参数id:作用的唯一的命名空间,用于标识不同的store
   export const helloStore = defineStore('helloStore', {
     	// 状态管理，返回对象即是需要管理的状态
       state: () => {
           return {}
       },
     	// store的一个计算属性
       getters: {},
     	// 可以做同步或异步，提交stats
       actions: {
         async actionSync() {
               const res: any = await mockUser()
               this.user = res
           },
       },
   })
   
   // 在组件中直接调用actions中的方法,也可以传递参数
   hello.actionSync()
   ```

## 7.5 getters

1. 函数式定义getter

   ```tsx
   import { defineStore } from 'pinia'
   // 第一个参数id:作用的唯一的命名空间,用于标识不同的store
   export const helloStore = defineStore('helloStore', {
     	// 状态管理，返回对象即是需要管理的状态
       state: () => {
           return {
             newName: '默认值'
           }
       },
     	// store的一个计算属性,函数式定义函数的返回值类型
       getters: {
         newName(): string {
               return this.name + '函数式'
           },
       },
     	// 可以做同步或异步，提交stats
       actions: {},
   })
   
   // 在组件中直接调用getter的属性,也可以传递参数
   <p>{{ hello.newName }}</p>
   ```

2. 属性回调形式

   ```tsx
   import { defineStore } from 'pinia'
   // 第一个参数id:作用的唯一的命名空间,用于标识不同的store
   export const helloStore = defineStore('helloStore', {
     	// 状态管理，返回对象即是需要管理的状态
       state: () => {
           return {
             newName: '默认值'
           }
       },
     	// store的一个计算属性
       getters: {
         getCounter: (state) => state.counter * 2,
       },
     	// 可以做同步或异步，提交stats
       actions: {},
   })
   
   // 在组件中直接调用getter的属性,也可以传递参数
   <p>{{ hello.getCounter }}</p>
   ```

### 7.6 实例Api

1. $reset：重置state到他的初始状态

2. 订阅store的改变：$subscribe()，只要状态发生改变就会触发

   ```tsx
   hello.$subscribe((args, state) => {
       console.log(args)
       console.log(state)
   })
   ```

3. $onAction：触发action方法时调用

   ```tsx
   hello.$onAction((arg) => {
       console.log({ arg })
       arg.after(() => {
           console.log('after')
       })
   },true)
   ```

### 7.7 Pinia持久化插件

- pinia和Vuex有个通病：刷新页面状态会丢失。可以通过pinia插件缓存刷新前的值

- 下载pinia插件，

  ```shell
  pnpm i pinia-plugin-persistedstate
  npm i pinia-plugin-persistedstate
  yarn add pinia-plugin-persistedstate
  ```

- 在main.ts文件中给pinia实例中加入插件

  ```tsx
  import { createPinia } from 'pinia'
  // 引入持久化插件
  import piniaPluginPersistedstate from 'pinia-plugin-persistedstate'
  // 实例化pinia
  const store = createPinia()
  // pinia使用
  store.use(piniaPluginPersistedstate)
  // 挂载store到vue
  createApp(App)
      .use(store)
      .mount('#app')
  ```

- 在store中添加持久化配置

  ```tsx
  // 开启持久化:会使用id名称作为storeage中的key
  export const helloStore = defineStore('helloStore', {
      persist: true,
  })
  // 自定义持久化配置
  export const helloStore = defineStore('helloStore', {
      persist: {
      key: "给一个要保存的名称",
      //保存的位置
      storage: window.sessionStorage,//localstorage
    },
  })
  ```

# 第八章axios

## 7.1 前端网络请求

1. XMLHTTPRequest：原生JavaScript请求
2. jQuery：ajax网络qingq
3. JSONP：跨域伪造访问
4. Axios：基于promise的HTTP 库，可以用在浏览器和node.js中

## 7.2 Vue中安装Axios

1. 加载axios安装包
   
   ```sh
   npm install axios --save
   ```

2. 配置axios到Vue实例
   
   - **方案一**：将axios挂载到Vue实例，可以全局访问axios的API
     
     ```js
     // main.js
     import axios from 'axios'
     Vue.prototype.$axios = axios
     
     new Vue({
       axios
       render: h => h(App)
     }).$mount('#app')
     
     // 在其他模块的方法中可以使用axios api
     methods: {
         funcName() {
             this.$axios.get({
                 url: 'xxx'
             }).then(res => {
     
             })
         }
     }
     ```
   
   - **方案二**：将axios单独封装为模块，创建并配置axios实例对象，然后将实例对象导出到main.js入口文件中，那么和接口请求的相关配置都可以定义在这个单独的axios模块中了;
     
     ```js
     // 自定义api目录：/api/index.js
     import axios from 'axios'
     const requests = axios.create()
     
     export default {
       requests
     }
     
     // main.js
     import '@/api'
     
     // 其他模块可以引用api模块进行接口调用
     import request from '@/api'
     methods: {
         funcName() {
             request.get({
                 url: 'xxx'
             }).then(res => {
     
             })
         }
     }
     ```
   
   - **方案三**：一般项目开发中会将接口的请求与业务方法分离，第一步会定义独立模块封装接口调用的方法，第二步在业务模块中调用接口模块传入接口参数获取接口响应；在方案二的基础上需要额外定义一个封装接口的模块：如order模块的相关接口都定义在一个js文件中；
     
     ```js
     // @/api/order/index.js
     import request from '@/api'
     export function getList (param) {
       return order({
         url: '/order/list',
         method: 'get',
         data: param
       })
     }
     
     // 然后在order组件的method中直接调用
     import {getList} from '@/api/order/index'
     methods: {
         funcName() {
             const param = {}
             getList(param).then(res => {
     
             })
         }
     }
     ```
   
   - **方案四**：如果前端项目需要调用多个服务的接口，而且接口的规则不统一，则需要将axios模块化，不同的服务对应各自的axios实例对象，并分别配置
     
     ```js
     // @/api/index.js
     import axios from 'axios'
     
     const order = axios.create({
       timeout: 5000
     })
     
     const user = axios.create({
       timeout: 5000
     })
     
     const axiosReq = axios.create({
       timeout: 5000
     })
     
     export default {
       order, user, axiosReq
     }
     // @/api/order/index.js
     import Api from '../'
     export function orderList (param) {
       return Api.order({
         url: '/order/list',
         method: 'get',
         data: param
       })
     }
     ```

# 第九章 前端库

1. animate.css

2. gsap

3. lodash

4. unplugin-auto-imports

5. element-plus:https://element-plus.gitee.io/zh-CN/

   ```json
   "types": ["element-plus/golbal", "node"]
   ```

6. naiveui:https://www.naiveui.com/zh-CN/light

   ```json
   "types": ["naive-ui/volar", "node"]
   ```

7. antDesign:https://ant.design/index-cn

8. tailwindcss:https://tailwindcss.com/
