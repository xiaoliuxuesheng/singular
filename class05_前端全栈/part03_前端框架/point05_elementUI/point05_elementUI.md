# 第一章 ElementUI环境搭建

## 1.1 使用script标签

- 下载element

- 在HTML页面中引入elementUI的样式和库

  ```html
  <!-- 引入样式 -->
  <link rel="stylesheet" href="https://unpkg.com/element-ui/lib/theme-chalk/index.css">
  <!-- 引入组件库 -->
  <script src="https://unpkg.com/element-ui/lib/index.js"></script>
  ```

## 1.2 使用Vue Cli

- 初始化Vue项目

- npm安装ElementUI

  ```sh
  cnpm i element-ui -S
  ```

- 配置Element

  - 完整配置Element：在main.js中引入整个element ui 或引入部分组件：一般项目开发中会全部引入

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

## 1.3 ElementUI组件使用基本说明

1. elementUI组件名称都是以`el-`开头；
2. element组件默认的类名是标签名称；
3. element组件的属性值如果非字符串，需要使用属性绑定的格式；

# 第二章 Element组件

## 1.1 Basic 

1. 基础组件概览

   | 组件功能       | 组件名称                                                     |
   | -------------- | ------------------------------------------------------------ |
   | 容器Continer   | el-continer<br />el-header<br />el-aside<br />el-main<br />el-footere |
   | 布局Layout     | el-row                                                       |
   | 色彩Color      |                                                              |
   | 字体Typography |                                                              |
   | 边框Border     |                                                              |
   | 图标Icon       | class="el-icon-名称"                                         |
   | 按钮Button     | el-button                                                    |
   | 链接Link       | el-link                                                      |

2. 使用技巧

## 1.2 Form 

## 1.3 Date 

## 1.4 Notice 

## 1.5 Navigation

## 1.6 Others





