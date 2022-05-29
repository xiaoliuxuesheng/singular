# 第一章 React入门

## 1.1 入门

1. 入门案例

   - 创建一个html页面，添加一个根dom并指定一个ID

     ```html
     <div id="test">
     </div>
     ```

   - 在这个根标签下引入React相关的组件

     ```html
     <!-- 加载 React。-->
     <!-- 注意: 部署时，将 "development.js" 替换为 "production.min.js"。-->
     <script src="https://unpkg.com/react@17/umd/react.development.js" crossorigin></script>
     <script src="https://unpkg.com/react-dom@17/umd/react-dom.development.js" crossorigin></script>
     <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
     ```

   - 自定义一个React组件

     ```html
     <!-- 加载我们的 React 组件。-->
     <script type="text/babel">
         const ODOM = <h1>Hello React</h1>
         const domContainer = document.querySelector('#test');
         ReactDOM.render(ODOM, domContainer);
     </script>
     ```

2. 不使用JSX创建虚拟DOM

   ```html
   <script type="text/javascript">
     // 创建虚拟DOM
     const ODOM = React.createElement('h1',{id:'title'},'Hello react, 不用JSX')
     const domContainer = document.querySelector('#test');
     ReactDOM.render(ODOM, domContainer);
   </script>
   ```

## 1.2 JSX语法规则

1. 什么是jsx：全程JavaScript XML
   - React定义的一种类型与xml的JS扩展语法：js+xml
   - 本质是React.crateElement方法的语法糖
   - 作用：用来简化创建虚拟DOM
   - 标签名称任意：HTML标签或其他标签
2. jsx语法规则
   - 定义虚拟DOM不需要用引号
   - jsx中如果使用变量需要使用花括号读取变量:{}
   - jsx中DOM的样式名称不是class（是一个关键字），是className
   - jsx的DOM中内联样式是对象格式：`style={{color:'red',size:'29px'}}`
   - jsx中的DOM只能定义在一个根标签中
   - jsx中定义的DOM的标签名称是小写字母会转换为HTML标签，如果转换不了会报错，如果是自定义标签，标签名称是首字母大写，React会渲染对应的组件，如果组件找不到会报错；
3. jsx表达式和jsx语句
   - jsx表达式都有一个返回值，虚拟dom根据返回值组成完整DOM
   - if、for、switch、case这些属于语句，不能定义在jsx表达式中

# 第二章 面向组件

## 2.1 模块化与组件化

1. 模块：是指具有特定功能的JS程序，一般一个JS文件就是一个模块，主要是用于复用，简化JS的编写
2. 组件：是指在浏览器页面具有特定显示区域的部分称为组件，组件化开发，可以复用相同功能的的组件

## 2.2 

[尚硅谷React技术全家桶全套完整版（零基础入门到精通/男神天禹老师亲授）_哔哩哔哩_bilibili](https://www.bilibili.com/video/BV1wy4y1D7JT?p=9&spm_id_from=pageDriver)

# 第三章 React脚手架

# 第四章 React Ajax

# 第五章 react-router

# 第六章 React UI库

# 第七章 Rectx

