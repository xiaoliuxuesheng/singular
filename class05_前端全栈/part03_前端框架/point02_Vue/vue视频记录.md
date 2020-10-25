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
   - 







