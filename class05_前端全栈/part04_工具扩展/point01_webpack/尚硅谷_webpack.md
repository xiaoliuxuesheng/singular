# 目录

第一章 webpack简介

第二章 webpack初体验

第三章 webpack开发环境配置

第四章 webpack生产环境配置

第五章 webpack优化配置

第六章 webpack原理分析

第七章 webpack5

# webpack

## 1. loader

### ★ css

- 下载

  ```sh
  npm i style-loader css-loader -D
  ```

- 配置

  ```js
  module: {
      rules: [
          {
              test: /\.css$/,
              use: [‘style-loader’,‘css-loader’]
          }
      ]
  }
  ```

### ★ less

- 下载

  ```sh
  npm - less less-loader style-loader css-loader -D
  ```

- 配置

  ```js
  module: {
      rules: [
          {
              test: /\.less$/,
              use: [‘less-loader’,‘style-loader’,‘css-loader’]
          }
      ]
  }
  ```

★ jpg|png|gif

- 下载

  ```sh
  npm i url-loader file-loader -D
  ```

- 配置

  ```js
  module: {
      rules: [
          {
              test: /\.(jpg|png|gif)$/,
              loader: 'url-loader',
              options:{
              	limit: 8 * 1024,
                  esModule: false,
                  name:[hash:10].[ext]
              }
          }
      ]
  }
  ```

★ html>img

- 下载

  ```sh
  npm i html-loader -D
  ```

- 配置

  ```js
  module: {
      rules: [
          {
              test: /\.html$/,
              loader: 'html-loader'
          }
      ]
  }
  ```

  

## 2. plugin

### ★ html-webpack-plugin

- 下载

  ```sh
  npm i html-webpack-plugin
  ```

- 引入并配置

  ```js
  const HtmlWebpackPlugin = require('html-webpack-plugin')
  plugins:[
      new HtmlWebpackPlugin({
          template:'./src/index.html'
      })
  ]
  ```

  

# 视频记录

01、课程介绍

- 能学到什么：webpack详细配置①基本配置②详细配置

  | loader      | plugin       | devtool | 性能优化 | tree shaking |
  | ----------- | ------------ | ------- | -------- | ------------ |
  | caching     | lazy loading | library | shimming | HMR          |
  | resolve     | optimization | dll     | webpack5 | production   |
  | development | eslint       | bable   | pwa      | code split   |

- 学习准备：① node②webpack4.26+③nodejs知识④npm指令⑤es6语法

02、webpack简介

- webpack是一个前端资源构建工具，一个静态模块打包器
- 打包原理描述
  - webpack可以根据入口文件将所依赖的包形成依赖树
  - 解析依赖树，将模块转换为浏览器可以识别的代码
  - 然后将文件输出到指定目录，完成打包操作
  - 部署打包后的结果，浏览器运行

03、webpack五个核心概念

1. entry：入口指示webpack以哪个文件作为入口起点开始打包，分析构建内部依赖图

2. output：输出指示webpack打包后的资源输出到哪里以及命名

3. loader：让webpack能够处理非JavaScript文件（webpack自身只能识别解析JavaScript文件）

4. plugins：插件可以用于执行范围更广的任务：插件的范围包括打包优化、压缩、定义环境变量等等

5. mode：开发模式

   1. development：将process.evn.NODE_ENV=development；启用NameChunksPlugin和NameModulePlugin；一些没有依赖的方法 变量 文件会保留，production则会移除

      ```js
      // webpack.development.config.js
      module.exports = {
      	mode: 'development'
      		plugins: [
      		new webpack.NamedModulesPlugin(),
      		new webpack.DefinePlugin({ "process.env.NODE_ENV": JSON.stringify("development") }),
      	]
      }
      ```

   2. production：将process.evn.NODE_ENV=production；启用 FlagDependencyUsagePlugin, UglifyJsPlugin，FlagIncludedChunksPlugin, ModuleConcatenationPlugin, NoEmitOnErrorsPlugin, OccurrenceOrderPlugin, SideEffectsFlagPlugin；代码会进行压缩，比development的文件小。

      ```js
      // webpack.production.config.js
      module.exports = {
      	mode: 'production',
      	plugins: [
      		new UglifyJsPlugin(/* ... */),
      		new webpack.DefinePlugin({ "process.env.NODE_ENV": JSON.stringify("production") }),
      		new webpack.optimize.ModuleConcatenationPlugin(),
      		new webpack.NoEmitOnErrorsPlugin()
      	]
      }
      ```

04、webpack初体验

1. 初始化包环境：执行命令生成package.json文件

   ```sh
   npm init
   ```

2. 全局安装webpack、webpack-cli如果已经安装会更新

   ```sh
   npm i webpack webpack-cli -g
   ```

3. 进入工作目录、将webpack、webpack-cli添加到开发依赖

   ```sh
   npm i webpack webpack-cli -D
   ```

4. 体验webpack打包js文件和json文件

   > - src：源码包
   >   - main.js：入口文件
   > - dist：打包输出目录

   - webpack打包js测试开发环境质指令：使用webpack命令将入口文件打包，输出（-o）指定文件路径，打包的模式（--mode）是开发模式；

   - 在测试打包css、image文件

     ```sh
     webpack ./src/main.js -o ./dist/bundle.js --mode=development
     ```

5. 总结

   - webpack默认可以打包js文件、json文件；不可以打包css、image等其他静态资源文件；
   - 生成环境和开发环境都可以把ES6模块打包编译成浏览器可以识别的模块
   - 生成环境的打包可以压缩文件

05、打包样式资源

- 

06、打包html

07、打包图片资源

08、打包其他资源

- 不需要做任何处理的资源：比如字体

09、devServer

10、开发环境配置

- 分包
- 构建分包

