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

# 第一章 Vue概述

## 1.1 Vue特点

 		Vue是一个JavaScript的渐进式框架：Vue框架提供了部分的基础服务和API；渐进式：声明式渲染 → 组件系统 → 客户端路由 → 集中式状态管理 → 项目管理，可以使用使用方案中的一部分或者全部，意味着Vue可以作为项目的一部分嵌入其中，或者希望在更多的功能上使用Vue技术，那么可以使用Vue逐渐替换原来的技术功能；

- 易用：熟悉HTML、CSS、JavaScript便可以快速上手Vue
- 灵活：在一个JavaScript库和前端框架之间可以做到伸缩自如，也可以用于APP项目开发
- 高效：20K的运行大小，超快高效虚拟DOM，较少不必要的DOM操作

​		Vue 只关注视图层， 采用自底向上增量开发的设计。Vue 的目标是通过尽可能简单的 API 实现响应的数据绑定和组合的视图组件；Vue中还具备WEB开发中的高级功能：

- 解耦视图和数据
- 可复用组件
- 前端路由技术
- 状态管理
- 虚拟DOM


## 1.3 Vue的安装

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

# 第二章 Vue基础语法

## 2.1 Vue对象的参数解析

1. **Vue指令**

   - 自定义属性：传统JS的自定属性是`data-属性名称`的形式定义自定义属性
   - Vue指令本质也是自定义属性，其基本格式是`v-指定名称`，是定义在Vue挂载的DOM元素之上

2. **数据响应式**

   - **响应式**：在HTML中的响应式表示屏幕尺寸的编号会导致样式的变化，而数据响应式则表示数据的变化会导致页面内容的变化，**即修改数据在页面中是即时生效的**
   - **数据绑定**：就是将Vue对象的模型数据填充到DOM标签中

3. **Vue对象**

   ```js
   let vue = new Vue({
       el:"#app",
       data:{
           msg:"值"
       },
       methods:{
           函数名称:function(){
               ... ...
           },
           函数名称(){
               ... ...
           }
       },
       directives:{
           指令名称:{
            钩子函数:function(el){
                   
            }
           }
    	},
       computed:{
           计算属性名称:function(){
           	return 计算结果;
           }
       },
       watch:{
           监听属性名称:function(变化后的值){
               
           }
       },
       filters:{
           过滤器名称:function(value){
               return 处理结果
           }
       }，
       beforeCreate(){
           console.log("beforeCreate")
       },
       created(){
           console.log("created")
       },
       beforeMount(){
       	console.log("beforeMount")
       },
       mounted(){
           console.log("mounted")
       },
       beforeUpdate(){
           console.log("beforeUpdate")
       },
       updated(){
           console.log("updated")
       },
       activated(){
           console.log("activated")
       },
       deactivated(){
           console.log("deactivated")
       },
       beforeDestroy(){
           console.log("beforeDestroy")
       },
       destroyed(){
           console.log("destroyed")
       },
       errorCaptured(){
           console.log("destroyed")
       }
   })
   ```
   
   <font size=4 color=blue>**:dash: el**</font>：是View Model对象挂载的DOM区域，采用JavaScript的元素选择器
   
   <font size=4 color=blue>**:dash: data**</font>：是数据模型对象，对照的值是key：value的格式
   
   <font size=4 color=blue>**:dash: methods**</font>：是函数对象，主要是定义针对Vue对象的一些函数，函数的定义是JavaScript语法
   
   <font size=4 color=blue>**:dash: directive**</font>：局部指令，可以定义多个指令；指令详情参考2.3.2的全局指令
   
   <font size=4 color=blue>**:dash: computed**</font>：计算属性，用于简化属性值绑定的表达式
   
   <font size=4 color=blue>**:dash: watch**</font>：侦听器，用于侦听data区域的属性数据的变化，触发值执行的逻辑
   
   <font size=4 color=blue>**:dash: filters**</font>：过滤器，主要用户数据格式化

## 2.2 Vue模板语法

### 1. 差值表达式

- 差值表达式的格式

  ```js
  {{data对象中的key}}
  ```

- **差值表达式的特点**：

  - 差值表达式加载过程：浏览器加载模型对象中数据的过程中，首先是会加载HTML页面的DOM元素，所以首先会在页面显示`{{差值表达式}}`字符串，其次会加载外部的Vue的脚本文件，最后会new Vue对象，并且将对象中模型中的值赋值给产值表达式，最终完成数据展示，如果加载Vue延迟会在浏览器中显示出差值表达式。
  - 差值表达式会将data对象中的值以纯文本的方式加载到页面中；
  - 可以在差值表达式的前后任意添加字符串

### 2. 指令v-cloak

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

### 3. 数据绑定指令

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

### 4. 事件绑定

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

### 7.分支结构

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

### 8. 循环结构

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

  

## 2.3 Vue常用特性

### 1. 表单操作 

- <font size=4 color=blue>**常用表单操作**</font>：可以使用v-model完成数据双向绑定
  - input：单行文本：
  - textarea：多行文本：
  - select：下拉选：
  - redio：单选框：
  - checkbook：多选框：

- <font size=4 color=blue>**表单域修饰符**</font>：修饰v-model输入域
  - v-model.number：转换为数值，input:type=number的输入框
  - v-model.trim：去掉开始和结尾的空格
  - v-model.lazy：将input事件切换为change事件

### 2. 自定义指令 

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


### 3. 计算属性 

- <font size=4 color=blue>**计算属性的使用**</font>：计算属性是指表达式的技术逻辑可能会比较复杂，使用计算属性使模板内容更加简洁

- <font size=4 color=blue>**计算属性的定义**</font>：在计算属性的函数中可以获取到模型对象中的数据，技术属性是依赖与model中的数据；

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

- <font size=4 color=blue>**计算属性的使用**</font>：直接使用函数名称即可，不可以使用函数调用的格式

  ```html
  {{计算属性名称}}
  ```

- <font size=4 color=blue>**计算属性与方法的区别**</font>：计算属性是基于他们的依赖进行缓存的，方法不存在缓存

### 4. 过滤器 

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

### 5. 侦听器 

- <font size=4 color=blue>**侦听器作用**</font>：监听数据模型中的数据，数据一旦发生变化，就通知侦听器所绑定的方法；使用场景是数据变化时候执行异步并或开销大的操作

  ```js
  let vue = new Vue({
      ... ...
      watch:{
          监听属性名称:function(变化后的值){
              
          }
      }
  })
  ```

### 6. 生命周期

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

# 第三章 组件化开发

## 3.1 组件开发思想

​		前端代码开发中，程序实现是希望尽可能多的做到代码重用，然而前端在代码重用中可能会产生CSS样式和JS业务逻辑的冲突；由此产生的Web Components开发标准：其核心思想是通过创建封装特定功能的定制元素（是一个自定义标签并且具有特定功能），并且能够解决冲突问题；

​		但是这个Web Components标准没有被浏览器广泛支持，但是Vue部分实现了Web Components开发标准。把不同的功能在不同的组件中开发，通过组件组合的方式实现功能的同一实现。

​		组件设计是将不同的功能封装在不同的组件中，通过组件的整合形成完整意义上的一个应用；

## 3.2 组件注册与使用

<font size=4 color=blue>**1. 全局组件注册**</font>

```js
Vue.component('组件名称',{
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

- **组件名称**：在定义组件时候可以使用呢驼峰格式或者中划线的格式，在template中引用组件时候可以使用驼峰或者中划线的方式，但是**在html结构的Vue组件中引用组件必须使用中划线格式**；
- **data**：在Vue对象中的data是个对象，对象中的数据模型在整个Vue组件中都可用，但是在自定义组件中，data是个函数，函数的返回值表示自定义注解的数据模型，其作用是起到闭包的作用，使组件之间的数据相互独立
- **template**：表示是html结构的模板内容，可以使用模板字符串格式化编辑模板内容，**模块内容必须只有单个根元素**；其他全局组的template中也可以引入其他的全局组件；

<font size=4 color=blue>**2. 布局组件注册**</font>

```js
let vue = new Vue({
	... ...
    components:{
        '组件名称':组件对象
    }
})
```

- 局部组件中可以定义多个组件
- 局部组件只能在父组件中使用，不能在全局组件中使用

## 3.3 组件的数据交互方式



## 3.4 组件插槽

## 3.5 Vue调试工具

# 第四章 Vue CLI详解

# 第五章 vue-router

# 第六章 Vuex详解

# 第七章 网络封装

# 第八章 项目实战

# 第九章 项目部署