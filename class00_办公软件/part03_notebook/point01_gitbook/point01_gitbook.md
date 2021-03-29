# 第一章 gitbook简介

## 1.1 基本概述

- GitBook 是一个基于 Node.js 的命令行工具，支持 Markdown 和 AsciiDoc 两种语法格式，可以输出 HTML、PDF、eBook 等格式的电子书

- 使用 GitBook 管理文档，预览、制作电子书
- 使用的搭配是 `GitBook + Typora + Git`

# 第二章 gitbook安装

- 第一步 下载安装[Node.js](https://nodejs.org/en/download/)

  > 安装 `Node.js` 都会默认安装 `npm`（node 包管理工具）

- 第二步 使用`npm`安装`gitbook`

  ```sh
  npm install -g gitbook-cli
  ```

  > - -g : 表示全局安装, 在本地其他任何位置都可以使用`gitbook`命令

- 第三步 下载Markdown 编辑软件[Typora](https://typora.io/)

- 第四步  安装[Git](https://git-scm.com/downloads)

# 第三章 gitbook基本应用

## 3.1 初始化书籍

1. 新建文件夹 : 保存书籍内容文件

2. 在书籍文件夹中使用命令构建书籍基本结构

   ```sh
   gitbook init
   ```

   - 执行完后会生成两个文件 : `README.md` 和 `SUMMARY.md`
   - README.md : 表示说明文件 ;
   - SUMMARY.md ： 摘要, 书籍的目录结构在这里配置

3. 配置摘要基本格式

   ```sh
   # 目录
   
   * [结构内容](存放结构的文件路径)
   ```

   > 列表 + 超链接的格式配置摘要
   >
   > 超链接的链接是摘要的对应的文件位置

4. 根据摘要构建书籍

   ```sh
   gitbook init
   ```

## 3.2 gitbook预览

1. 使用浏览器服务预览书籍

   ```sh
   gitbook serve --port 端口号
   ```

   - --port 端口号` : 可以省略(默认端口号4000)

   - 浏览器访问路径 : `http://localhost:4000`

2. 生成PDF文档

   ```sh
   gitbook pdf 书籍目录 文档存放目/文档名称.pdf
   ```

3. 生成 epub 格式的电子书

   ```sh
   gitbook epub 书籍目录 文档存放目/文档名称.epub
   ```

4. 生成 mobi 格式的电子书

   ```sh
   gitbook mobi 书籍目录 文档存放目/文档名称.mobi
   ```

5. 生成的静态网站输出到 _book 目录

   ```sh
   gitbook build [书籍路径] [输出路径]
   ```

# 第四章 gitbook使用解析

## 4.1 SUMMARY.md

- 主要决定 GitBook 的章节目录，它通过 Markdown 中的列表语法来表示文件的父子关系

## 4.2 book.json

| 属性名称      | 说明                                                     |
| ------------- | -------------------------------------------------------- |
| title         | 本书标题                                                 |
| author        | 本书作者                                                 |
| description   | 本书描述                                                 |
| language      | 本书语言，中文设置 "zh-hans" 即可                        |
| gitbook       | 指定使用的 GitBook 版本                                  |
| styles        | 自定义页面样式                                           |
| structure     | 指定 Readme、Summary、Glossary 和 Languages 对应的文件名 |
| links         | 在左侧导航栏添加链接信息                                 |
| plugins       | 配置使用的插件                                           |
| pluginsConfig | 配置插件的属性                                           |

## 4.3 插件



