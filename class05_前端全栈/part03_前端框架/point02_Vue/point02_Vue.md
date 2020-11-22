# 第一章 Vue 基础

## 1.1 Vue概述

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;Vue是一个JavaScript的渐进式框架：Vue框架提供了部分的基础服务和API；渐进式：声明式渲染 → 组件系统 → 客户端路由 → 集中式状态管理 → 项目管理，可以使用使用方案中的一部分或者全部，意味着Vue可以作为项目的一部分嵌入其中，或者希望在更多的功能上使用Vue技术，那么可以使用Vue逐渐替换原来的技术功能；

- 易用：熟悉HTML、CSS、JavaScript便可以快速上手Vue
- 灵活：在一个JavaScript库和前端框架之间可以做到伸缩自如，也可以用于APP项目开发
- 高效：20K的运行大小，超快高效虚拟DOM，较少不必要的DOM操作

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;Vue 只关注视图层， 采用自底向上增量开发的设计。Vue 的目标是通过尽可能简单的 API 实现响应的数据绑定和组合的视图组件；Vue中还具备WEB开发中的高级功能：

- 解耦视图和数据
- 可复用组件
- 前端路由技术
- 状态管理
- 虚拟DOM

## 1.2 前端的MVVM和后端MVC

1. MVC设计思想

   - M:Model - 表示模型，主要用于存放数据
   - V:View - 视图，表示展示数据的页面
   - C:Controller - 控制器，用于接收视图的参数构造数据并返回给视图

2. MVVM设计思想

   <img src="https://s1.ax1x.com/2020/05/01/JOFGzq.png" alt="JOFGzq.png" width=600 />

   - M:Model : 页面中的单独数据
   - V:View: 页面展示结构，在前端开发中通常值DOM元素
   - VM:View Model 核心是视图模型层:是M和V的调度者，功能一可以实现数据绑定，功能二是DOM监听

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

```js
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

> - VM：在编程中首先需要引入Vue，并构建Vue对象，并指明需要关联的页面区域元素，这个Vue对象便可以作为数据Model和View视图的调度者
> - V：表示页面中的一个HTML元素，这个元素会在页面中展示特定的区域，这个区域中的数据会交给VM对象
>
> - M：数据模型，会定义在当前元素对应的VM对象中，可能会包括基本数据，事件方法等数据

# 第二章 Vue基础操作

## 2.1 插值表达式

- 差值表达式的格式

  ```js
  {{data对象中的key}}
  ```

- **差值表达式的特点**：

  - 差值表达式加载过程：浏览器加载模型对象中数据的过程中，首先是会加载HTML页面的DOM元素，所以首先会在页面显示`{{差值表达式}}`字符串，其次会加载外部的Vue的脚本文件，最后会new Vue对象，并且将对象中模型中的值赋值给产值表达式，最终完成数据展示，如果加载Vue延迟会在浏览器中显示出差值表达式。
  - 差值表达式会将data对象中的值以纯文本的方式加载到页面中；
  - 可以在差值表达式的前后任意添加字符串

## 2.2 插值闪烁

- 指令（v-cloak）：定义v-cloak样式中隐藏元素的显示，在内存中替换数据后完成数据展示:；在差值表达式的DOM元素上定义v-cloak属性，并设置该属性的显示样式为none，当Vue初始化并加载完成后，Vue对象会将改区域中具有改属性的显示样式删除，从而解决差值表达式的闪烁问题；在标签内部使用差值表达式获取到model对象中的指定属性名称的数据，可以在数据前后添加其他字符；

  ```html
  <style>
      [v-cloak]{
          display: none;
      }
  </style>
  
  <div v-cloak>{{msg}}</div>
  ```

## 2.3 数据绑定

| 指令                                                         | 特点                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| <span title="<div v-text='Model属性名称'></div>">v-text</span> | 纯文本填充，相比差值表达式更简洁，<br />**指定标签中的文本会被属性值替换** |
| <span title="<div v-html='Model属性名称'></div>">v-html</span> | 内容按普通的HTML插入，不会作为Vue模板进行编译，<br />**建议**：本网站的内部数据是可以使用的，如果是来自第三方数据不建议使用 |
| <span title="<div v-pre>{{Model属性名称}}</div>">v-pre</span> | 填充绑定的DOM中的原始信息，跳过编译过程（也不会编译差值表达式） |
| <span title="<div v-once>{{msg}}</div>">v-once</span>        | 表示只会绑定一次数据，不会有数据响应式功能，**优点**：有助于提高性能 |
| <span title="<input type='text' v-model='Model属性名称'>">v-model</span> | 双向数据绑定：主要是针对输入框，<br />用户输入的数据可以修改模型数据值，模型数据库值的改变页面相应到页面 |

## 2.4 事件绑定v-on

1. 事件绑定的基本使用方式
2. 时间绑定的方法调用与参数说明
3. 事件修饰符
4. 按键修饰符
5. 自定义按键修饰符

## 2.5 属性绑定v-bind

1. 属性绑定
2. class属性
3. style属性

## 2.6 Vue-流程控制

1. v-if
2. v-else
3. v-show
4. v-for

# 第三章 Vue-Operations

## 3.1 el 与 template

## 3.2 数据属性

## 3.3 计算属性

## 3.4 方法

## 3.5 过滤器

## 生命周期函数

## 组件

## 插槽

# 第四章 Vue-全局属性

# 第五章 Vue-cli

# 第六章 Vue 路由

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



# 第七章 VueX

# 第八章 Vue Axios



