# 第一章 webpack介绍

## 1.1 webpack概述

​		web前端开发的场景越来越复杂，对性能和适用性的要求越来越高，同时web前端是由灵活的javascript代码和许多相关依赖包完成，为简化开发的负责度，所以引入了模块化的的概念：把复杂的程序分解为细小的功能模块，通过模块之间的依赖建立关系；

​		webpack被称为模块打包机：可以通过一个入口文件，将入口文件所依赖的模块以及对应模块的所有依赖打包为一个输出文件。

## 1.2 webpack功能描述

1. 许多在javascript基础上扩展的开发语言（类似Typescript）、以及ES6等高级语法的新特性目前浏览器不可以直接使用，webpack可将其转换为浏览器可识别js文件；
2. 是Scss、Less等css预处理器；
3. 前端三大框架语法的解析；
4. 文件压缩与混淆
5. 图片、字体等文件的压缩

## 1.3 webpack特点

- 规范前端工作流，团队开发协作；
- Node社区的第三方组件丰富，适用webpack可以实现快速复用
- webpack配置灵活，功能强大，快速加载第三方模块，没有固定规范，掌握难度稍微有点大

## 1.4 webpack使用准备

1. 安装npm

   ​	webpack可以使用npm安装,所以需要提前准备好npm环境

2. 在项目目录中准备`package.json`文件

   ```sh
   npm init
   ```

   - package.json基本格式

     ```json
     {
       "name": "web_webpack_02",
       "version": "1.0.0",
       "description": "",
       "main": "index.js",
       "scripts": {
         "test": "echo \"Error: no test specified\" && exit 1",
         "dev": "webpack"
       },
       "keywords": [],
       "author": "",
       "license": "ISC",
       "devDependencies": {
         "webpack": "^4.41.2",
         "webpack-cli": "^3.3.10"
       }
     }
     ```

3. 安装webpack

   ```sh
   npm install webpack webpack-cli --save-dev
   ```

   > - webpack4之后将webpack核心分解为`webpack`和`webpack-cli`
   > - 模块的局部安装会在`node_module/.bin/`目录中创建一个软链接，`package.json`默认是可以读取到`.bin`目录中的命令，使用`scripts`对象可以加载命令

# 第二章 webpack基础

## 1.1 认识配置文件

- webpack的默认配置文件是`webpack.config.js`，可以使用命令：webpack --config重新指定配置文件

  ```js
  const webpack = require('webpack');
  const HtmlWebpackPlugin = require('html-webpack-plugin');
  const ExtractTextPlugin = require('extract-text-webpack-plugin');
  
  module.exports = {
          entry: __dirname + "/app/main.js", 	// 表示打包的入口文件
          output: {							// 表示打包后的输出文件
              path: __dirname + "/build",
              filename: "bundle-[hash].js"
          },
          devtool: 'none',
          devServer: {
              contentBase: "./public", 		//本地服务器所加载的页面所在的目录
              historyApiFallback: true, 		//不跳转
              inline: true,
              hot: true
          },
          module: {							// Loader配置（数组）
              rules: [{
                      test: /(\.jsx|\.js)$/,
                      use: {
                          loader: "babel-loader"
                      },
                      exclude: /node_modules/
                  }, {
                      test: /\.css$/,
                      use: ExtractTextPlugin.extract({
                          fallback: "style-loader",
                          use: [{
                              loader: "css-loader",
                              options: {
                                  modules: true,
                                  localIdentName: '[name]__[local]--[hash:base64:5]'
                              }
                          }, {
                              loader: "postcss-loader"
                          }],
                      })
                  }
              }
          ]
      },
      plugins: [								// 插件（数组）
          new webpack.BannerPlugin('版权所有，翻版必究'),
          new HtmlWebpackPlugin({
              template: "/index.html" //new一个这个插件的实例，并传入相关的参数
          }),
          new webpack.optimize.OccurrenceOrderPlugin(),
          new webpack.optimize.UglifyJsPlugin(),
          new ExtractTextPlugin("style.css")
      ]
  };
  
  ```

## 2.1 配置文件详细说明

### 1. entry：打包入口

​		打包机制：项目中所有资源成为模块，模块之间存在依赖关系形成依赖树，从入口文件开始，将所有依赖树中的模块打包为一个输出文件。

:dash: 单入口文件

```js
module.exports = {
	entry: __dirname + "/app/main.js", 
    ... ...
}
```

:dash: 多入口文件

```js
module.exports = {
	entry: {
        '入口名称1':__dirname + "/app/main1.js",
        '入口名称2':__dirname + "/app/main2.js",
    } 
    ... ...
}
```

### 2. output：打包输出

​		用于指定打包输出的磁盘目录。

:dash: 输出配置

```js
module.exports = {
	output: {
        path: path.join(__dirname,'dist'),
        filename: "[name].js"
    } 
    ... ...
}
```

> - [name]表示名称占位符，对应的是入口名称

### 3. loaders：

​		webpack默认只支持`js`文件和`json`文件，通过使用不同的`loader`，`webpack`有能力调用外部的脚本或工具，实现对不同格式的文件的处理，比如说分析转换scss为css，或者把下一代的JS文件（ES6，ES7)转换为现代浏览器兼容的JS文件，对React的开发而言，合适的Loaders可以把React的中用到的JSX文件转换为JS文件。

​		Loaders的配置包括以下几方面：

​			:point_right: `test`：一个用以匹配loaders所处理文件的拓展名的正则表达式（必须）

​			:point_right:` loader`：loader的名称（必须）

​			:point_right:`include/exclude`:手动添加必须处理的文件/文件夹或屏蔽不需要处理的文件/文件夹（可选）；

​			:point_right:`query`：为loaders提供额外的设置选项（可选）

### 4. plugin：插件

​		插件（Plugins）是用来拓展Webpack功能的，它们会在整个构建过程中生效，执行相关的任务。

​		Loaders和Plugins常常被弄混，但是他们其实是完全不同的东西，可以这么来说，loaders是在打包构建过程中用来处理源文件的（JSX，Scss，Less..），一次处理一个，插件并不直接操作单个文件，它直接对整个构建过程起作用。

### 5. mode：

# 第三章 webpack第三方模块



