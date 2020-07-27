1. 简介：element ui 是基于vue的ui框架：改框架基于vue开发了很多vue组件方便款速开发

2. element ui在vue脚手架项目中的安装

   - 方式一：使用CND引入

     ```html
     <!-- 引入样式 -->
     <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
     <!-- 引入组件库 -->
     <script src="https://unpkg.com/element-ui/lib/index.js"></script>
     ```

   - 方式二：使用npm安装（创建好vue脚手架项目）

     ```sh
     cnpm i element-ui -S
     ```

3. 在脚手架中使用element ui

   - 在main.js中引入整个element ui 或引入部分组件：一般项目开发中会全部引入

     ```js
     import Vue from 'vue';
     import ElementUI from 'element-ui';					// 引入elementUI全部组件
     import 'element-ui/lib/theme-chalk/index.css';		// 引入elementUI的CSS样式
     import App from './App.vue';
     
     Vue.use(ElementUI);									// 需要将elementUI进行全局注册，才能使用UI框架
     
     new Vue({
       el: '#app',
       render: h => h(App)
     });
     ```

4. element UI的使用要素

   - elementUI组件名称都是以`el-`开头
   - 每个组件都有自己的属性，组件的属性必须写在组名标签之上
   - 组件属性值是boolean值的属性默认是true
   - 