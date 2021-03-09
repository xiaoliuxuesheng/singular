

# 第一章 Element安装

- 新建Vue项目

  ```sh
  vue init webpack 项目名称		# vue-cli2脚手架
  vue create 项目名称 			# vue-cli3脚手架
  ```

- 使用npm下载element-ui

  ```sh
  npm install element-ui -S
  ```

- 在Vue项目的main.js文件中配置Element

  - 全量导入

    ```js
    import ElementUI from 'element-ui'
    import 'element-ui/lib/theme-chalk/index.css'
    
    Vue.use(ElementUI)
    ```

  - 按需导入

    ```js
    
    ```

# 第二章 Element组件

## 1.1 组件

### 



# --------

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

### 1. Layout 布局

- el-row

  | 单词    | 音标     | 注释                                                         |
  | ------- | -------- | ------------------------------------------------------------ |
  | gutter  | /ˈɡʌtər/ | n. 排水沟；槽；贫民区<br />vi. 流；形成沟<br />vt. 开沟于…；弄熄<br />adj. 贫贱的；粗俗的；耸人听闻的 |
  | justify |          |                                                              |

  

## 1.2 Form 

## 1.3 Date 

## 1.4 Notice 

## 1.5 Navigation

## 1.6 Others





