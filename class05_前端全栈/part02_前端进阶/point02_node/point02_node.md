---
title: 0602-NodeJS
date: 2006-02-01 00:03:00
tags:

---

# 第一章 Node.js基础

## 1.1 Node.js概述

1. Node.js介绍：是一个基于 Chrome V8 引擎的 JavaScript 运行时环境；
2. Node.js特性：可以解析js代码，并且没有浏览器年安全级别限制（使用ajax请求不通域名通过浏览器访问会被CSOR拦截），而且提供了很多系统级别的API。如：
   - 文件读写File System
   - 进程管理Process：进程管理
   - 网络通信：http、https请求

## 1.2 Node.js工具nvm

1. nvm概述：是Node.js的版本管理工具

2. linux安装nvm

   - 安装nvm

     ```sh
     curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh | bash
     # 或者
     wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.31.1/install.sh | bash
     ```

   - 刷新

     ```sh
     source .bash_profile
     ```

3. nvm常用命令

   - 使用nvm安装node

     ```sh
     nvm install stable
     # 或者
     nvm install v0.12.7 #安装 0.12.7 版本
     ```

   - 查看本地安装的所有版本；有可选参数available，显示所有可下载的版本。

     ```sh
     nvm list [available]
     ```

   - 使用指定版本

     ```sh
     nvm use 11.13.0
     ```

   - 切换默认版本

     ```sh
     nvm alias default 0.10.32 
     ```

   - 卸载node

     ```sh
     nvm uninstall 11.13.0
     ```

## 1.3 Node.js工具npm

1. npm概述：包管理工具

2. 全局安装包：安装成功后在任何目录都可以执行包中命令:全局包安装目录

   ```sh
   npm install 包名 --global
   npm install 包名 -g
   ```

3. 卸载全局包

   ```sh
   npm uninstall 包名 --global
   npm uninstall 包名 -g
   ```

4. 本地安装包，因为没有环境变量，需要有专门的包配置文件：package.json，初始化本地宝配置文件

   ```sh
   npm init -y
   ```

   > - name
   > - version
   > - description
   > - main
   > - script
   > - keyword
   > - author
   > - license

5. 本地安装：安装在了当前目录的node_modules目录中

   ```sh
   npm i 包名 --dev-save
   ```

   - --dev
   - -save：表示会将包 保存到package.json中
   - -S：开发环境的包
   - -D：--dev-save

6. 执行本地安装包中的包命令

   ```sh
   # 方式一：直接根据命令的路径执行命令
   ./node_modules/。。。
   # 方式二：将命令定义在package.接送的script中,在package.json中不需要指定命令所在的路径
   script:{
   	"命令别名":"node_modules中的命令"
   }
   ```

   