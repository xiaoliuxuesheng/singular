day01-01 课程介绍

- 基础语法
- webpack
- 项目案例

day01-02 什么是Vue

1. 什么是Vue
   - 是目前最火的前端框架
   - 是一款JavaScript的渐进式框架
   - 属于前端三大框架:Angular  React  Vue

day01-03 前端框架作用

1. 使用框架
   - 提高开发效率,降低开发成本
   - 使用Vue更关注业务逻辑,不在重注DOM操作

day01-04 框架和库的区别

1. 区别
   - 框架是一套完整的解决方案,对项目侵入性大,更换困难但是功能完善
   - 库-插件:提供某个小的功能,功能单一,切换容易

day01-05 MVC和MVVM

1. MVC:后端开发分层思想
   - M:Model
   - V:View
   - C:Controller
2. MVVC:前端分层开发思想
   - M:Model : 页面中的单独数据
   - V:View: 页面展示结构
   - VM:View Model 核心:是M和V的调度者

day01-06 Vue代码结构与MVVM结构

1. Vue代码结构

   - 下载并引入Vue对象:引入vue框架后浏览器中会多一个Vue的构造函数

     ```js
     <script src="../resources/js/vue-dev.js"></script>
     ```

   - 构建Vue对象

     ```js
     let vm = new Vue({
         el:'#app',
         data:{
             message:'hello vue'
         }
     })
     ```

     > el 表示vue对象接管的浏览器元素区域
     >
     > data : 可以被接管的区域使用

     - M : 表示vm中的data  数据
     - V : 表示被VM接管的区域
     - VM : 表示vm对象

   day01-07 vue指令的学习

   1. 差值表达式闪烁问题
      - v-click
      - v-text
      - v-html