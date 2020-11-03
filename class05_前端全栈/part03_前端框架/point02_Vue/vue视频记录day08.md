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

1. 在style标签中引入其他样式文件：@import 路径
2. tabBar的高度：49px

day07_13 - tabbar - TabBar和TabBarItem组件封装

1. vue3点击路由重复报错

   ```js
   const originalReplace = VueRouter.prototype.replace;
   VueRouter.prototype.replace = function replace(location) {
       return originalReplace.call(this, location).catch(err => err);
   };
   ```

   

day07_14 - tabbar - 给TabBarItem传入active图片

day07_15 - tabbar - TabBarItem和路由结合效果

day07_16 - tabbar - TabBarItem的颜色动态控制

day07_17 - (了解) 知识回顾

# day08

01_路径别名

- @代替src

  ```js
  resolve:{
      alias:{
          '@': resolve('src')
      }
  }
  ```

  - 在import语句中可以直接使用路径别名
  - 如果在非import语句中的路径必须使用~作为别名的前缀

02_Promise

- Promise是异步编程的一种解决方案；
  - 网络请求之间有顺序，下一个请求依赖上一个请求的数据，如果网络请求比较复杂，会出现严重的回调地狱
- Promise基本使用
  1. 创建Promise对象：new Promise(resolve，reject){}：resolve，reject本身也是个函数
  2. promise异步回调
     1. resolve(成功回调)
     2. reject(失败回调)
     3. 返回promise对象：返回的promise对象是成功则回调成功，否则回调失败
  3. 回调
     1. promise.then(function(succ){},function(err){})：Promise中的resolve回调后执行then方法
     2. promise.catch(function(err){})：等于then的第二个参数

03_Promise三种状态

- pending：等待状态
- fulfile：满足状态，主动resolve回调
- reject：拒绝状态，主动调用reject回调，并且回调cache方法

04_Promise链式调用你

- then方法返回的仍然是Promise对象，Promise的值是then方法的返回值
- Promise.resolve()：

05_Promise的all方法

- Promise.all([可迭代Promise对象]).then(results)：返回结果也是对应的可迭代的结果

06-vuex-Vuex概念和作用解析

1. vuex功能概述:作为vue应用程序的状态管理器
   1. 模式:采用集中式存储应用里所有组件的某些状态,并以一种响应的规则保证以一种可预测的方式进行变化
2. 状态管理:可以理解成多个组件共享变量存储在一个对象中
   1. vuex的状态管理可以对管理的数据具有响应式的功能
3. 需要管理的数据:多个页面都需要的一些数据
   1. token
   2. 用户信息
   3. 全局唯一的:比如购物车.我的收藏等等

07-vuex-单界面到多界面状态管理切换

- 单页面的状态管理stats -> view -> actions -> stats
  - stats：表示状态，需要更改的数据
  - view：表示状态在页面的表示
  - actions：在页面对数据的动作，导致数据的变更

- 安装vuex

  - 下载vuex:

    ```js
    npm install vuex --save
    ```

  - 安装vuex:像router一样新增一个vuex的模块,固定名称store仓库的意思:保存共享的变量,新建index.js

    ```js
    import Vue from 'vue'
    import Vuex from 'vuex'
    
    
    // 安装插件
    Vue.use(Vuex)
    
    // 创建仓库对象
    const store = new Vuex.Store({
        state: {
    		// 保存状态
        },
        mutations: {
    		// 
        },
        actions: {
    
        },
        getters: {
    
        },
        modules: {
    
        }
    
    })
    
    export default store;
    ```

  - 在入口函数上挂载上store

    ```js
    import Vue from 'vue'
    import App from './App'
    import store from './store/index'
    
    Vue.config.productionTip = false
    
    /* eslint-disable no-new */
    new Vue({
        el: '#app',
        store,	// 最终结果会为Vue.prototype.$store属性, 在vue实例中全局使用
        render: h => h(App)
    })
    ```

- 多页面的状态管理，用最直接的方式直接读取state中的共享数据

  ```js
  state: {
      conter: 1
  }
  <p>{{$store.state.conter}}</p>
  ```

- vue不建议直接操作store中的数据,需要按照规定好的规则进行访问和修改共享数据,因为vue提供的浏览器devtools可以记录按照规定修改vuex共享数据的操作记录,如果跳过Mutation,则devTools监测不到.定位不到数据的操作信息

08-vuex-devtools和mutations

- devTools安装

  - 第一步：找到vue-devtools的github项目，并将其clone到本地. [vue-devtools](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fvuejs%2Fvue-devtools)

    ```js
    git clone https://github.com/vuejs/vue-devtools.git
    ```

  - 第二步：安装项目所需要的npm包

    ```js
    npm install //如果太慢的话，可以安装一个cnpm, 然后命令换成 cnpm install
    ```

  - 第三步：编译项目文件

    ```sh
    npm run build
    ```

  - 第四步：添加至chrome游览器

    ```js
    游览器输入地址“chrome://extensions/”进入扩展程序页面，点击“加载已解压的扩展程序...”按钮，选择vue-devtools>shells下的chrome文件夹。
    
    /**
    *如果看不见“加载已解压的扩展程序...”按钮，则需要勾选“开发者模式”。
    */
    ```

- 使用mutation中的方法操作数据: mutation中定义方法,定义的方法中默认就带有state对象参数,直接获取state中的数据

  ```js
  mutations: {
      add(state) {
          state.conter++
      },
      sub(state) {
          state.conter--
      }
  }
  ```

- 在组件中执行mutation中的方法:commit方法提交mutations中方法的标识

  ```js
  methods:{
      helloAdd(){
          this.$store.commit("add")
      },
          helloSub(){
              this.$store.commit("sub")
          }
  }
  ```

09-vuex-state单一状态树的理解

1. State：主要存储数据，
2. Getters：类似于计算属性
3. Mutation：操作State的数据的方法
4. Actions：执行异步操作
5. Modules：拆分为多个模块

- 单一状态树，也指单一数据源；vuex也推荐使用一个store管理状态

10-vuex-getters的使用详解

- getters功能类似计算属性，获取state中的数据，并且需要计算后展示给用户,计算属性的使用方式相同,方法参数默认带有stats

  ```js
      getters: {
          pf(state) {
              return state.conter * state.conter
          }
      }
  ```

- 使用计算属性

  ```js
  {{$store.getters.pf}}
  ```
  
- getters方法的第二个参数 是getters对象,可以调用其他getters中的属性

  ```js
      getters: {
          pf(state,getters) {
              return state.conter * state.conter
          }
      }
  ```

- getters接受其他参数

  ```js
      getters: {
          pf(state,getters) {
              return function(参数){
                  return 计算属性根据参数的值;
              }
          }
      }
  ```

11-vuex-mutations的携带参数

1. Vuex.store状态更新的唯一的方式：提交Mutation

2. Mutation主要包含两部分

   1. 字符类型的实践类型type
   2. 一个回调函数handler，改回调函数第一个参数就是status

3. Mutation携带参数 payload 负载/载荷

   1. 在commit的第二个参数传递参数

      ```js
       helloSub(参数){
           this.$store.commit("sub",参数)
       }
      ```

   2. 在定义mutation时候的是的第二个参数就是传递过去的参数

      ```js
          mutations: {
              sub(state,参数) {
                  state.conter--
              }
          }
      ```

   3. 如果要传递多个参数,将参数分装在对象中

12-vuex-mutations的提交风格

1. 普通提交风格:this.$store.commit("sub",参数)

2. 特殊提交风格

   ```js
   this.$store.commit({
   	type:"sub",
       参数 
   })
   
   如果对象中参数有多个key:value ,mutations中的第二个参数会变成对象
       mutations: {
           sub(state,参数) {
               state.conter--
           }
       }
   ```

13-vuex-数据的响应式原理

- vuex数据响应式的规则，对属性修改值时候会响应式
  1. 提前在store中初始化好所有属性
  2. 当给store中对象添加新属性时,使用下面的方式
     1. 方式1：Vue.set（obj，新属性，值）
        1. 删除属性。Vue.delete（对象，属性）
     2. 方式2：用新对象给旧对象重新赋值

14-vuex-mutations的类型常量

- mutation中会定义很多方法，在提交方法时候还需要手写方法字符串，写错之后字符串没有错误提示。建议在定义方法时候将方法名称定义为常量，将项目的常量抽取在一个常量模块中

  ```js
      mutations: {
          [常量](state,参数) {
              state.conter--
          }
      }
   this.$store.commit([常量],参数)
  ```

15-vuex-actions的使用详解

- mutation中方法必须是同步方法,如果有异步方法需要将方法定义在action中,developTool中可以捕获数据的快照,如果子啊异步方法中devTools中对数据监测不完整

- action类似mutation是用来替代mutation执行异步操作, 在异步方法中提交mutation中的方法,不然devTools监测不到,使用dispatch方法;

  ```js
      actions: {
          update(context) {
              setTimeout(() => {
                  context.commit('add')
              }, 100);
          }
      }
  // 执行action中飞方法
   this.$store.dispatch([常量],参数)
  ```

- action参数传递的方式和mutation的方式相同

- 异步方法可以返回函数回调

- 异步方法可以返回Promise对象,在dispatch action方法时候获取返回的promise对象,完成异步结果

16-vuex-modules的使用详解

- Module是模块的意思,

  - Vue使用单一状态树意味着很多状态都会交给Vuex管理
  - 当应用变的非常复杂时候,store就会变的相当臃肿
  - 在store中提供module可以抽离多个模块,每个模块拥有自己的五大属性

- 定义模块

  ```js
  modules: {
      a: ModuleA
  }
  ```

- 使用模块中的store:提交模块中的mutation也是直接commit,所以模块中的mutation的名称和主store中的名称不能重复

  ```js
   this.$store.commit([常量],参数)
  ```

- 模块中的getters:直接调用模块中的计算属性

  ```js
       getters: {
          pf(state,getters,第三个参数是rootStates) {
              return state.conter * state.conter
          }
      }
  this.$store.getter.技术性属性
  ```

- action中方法中的context,只能调用自己模块上下文的对象

17-vuex-store文件夹的目录组织

```txt
|-- store
	|-- index			# 组装模块并导出store
	|-- actions.js		# 根级别的actions
	|-- mutation.js		# 根级别的mutation
	|-- mudules
		|-- cart.js		# 购物车模块
		|-- product.js 	# 商品模块
```

