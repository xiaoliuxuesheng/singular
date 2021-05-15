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

   ```sh
   临时使用npm --registry https://registry.npm.taobao.org install express
   持久使用npm config set registry https://registry.npm.taobao.org
   ```

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

   - --dev：是开发环境的包
   - -save：表示会将包 保存到package.json中
   - -S：生产环境的包,dependencies包, 是线上代码运行也依赖的包
   - -D：开发环境的包--dev-save，分到devDependencies包中,是开发环境编码时候需要依赖的包

6. 执行本地安装包中的包命令

   ```sh
   # 方式一：直接根据命令的路径执行命令
   ./node_modules/.bin/。。
   # 方式二：将命令定义在package.接送的script中,在package.json中不需要指定命令所在的路径
   scripts:{
   	"命令名称":"下载的包的的命令(默认会在node_modules的.bin中的文件)"
   }
   ```

7. 本地安装：初始化package中开发环境或测试环境的包

   - npm list 查看项目中包的依赖树

   - npm list | grep 筛选

   - 初始化生产环境的包

     ```sh
     npm install --production
     ```

   - 初始化测试环境的包

     ```sh
     npm install 
     ```

   - 初始化package.json

     ```sh
     npm install
     ```

8. package.json的版本说明

   - 使用npm查看包的版本

     ```sh
     npm view 包名 versions
     ```

   - 使用npm安装指定版本的包

     ```sh
     npm install 包名@版本 -S
     ```

   - "jquery":"^1.12.4"

     ```sh
     # 使用npm 安装指定版本
     npm install jquery@1
     # 版本号命名规则
     # 第一部分:major-主版本号 表示核心功能的更新
     # 第二部分:minor-次版本好 表示功能添加或修改
     # 第三部分:batch-补丁好 补丁修复 偶数稳定 奇数不稳定
     ```

   - package.json版本说明

     ```sh
     ^ - 表示是这个配置只锁定主版本号,很后面的取最新的版本
     ~ - 表示只锁定主版本号和此版本号,补丁好取最新
     缺省 - 表示确定的版本号
     * - 表示这个包只取最新版本
     ```

   - npm outdated 查看当前的过期版本,版本号不能不存在

   - npm update 更新当前项目的包

9. 清理npm缓存:第一次安装错误,缓存后再装就会失败

   ```sh
   npm cache clean --force
   ```

10. npm上传自己的包

    - node的包的分类

      - node内置的包:fs/http/htps/path等等

      - 第三方模块:vue/webpack/axios

      - 自定义包:

        - 注册npm账号:https://www.npmjs.com/ panda6671 @Panda03lxd

        - 本地初始化npm项目:package.json

        - 完善包信息:main:别人使用我的包的时候入口文件是哪个?name就是包名,version就是上传的包版本,description 是网页上对包的描述,作者和开源协议

        - 编写模块代码:使用commonjs规范导出外部接口:modules.export = 模块名称

        - 使用npm远程仓库

          ```sh
          # 切换npm源为 https://registry.npmjs.org
          npm config set registry https://registry.npmjs.org
          
          npm adduser
          # 输入用户名密码登陆完成
          # 发布
          npm publish
          ```

11. npm scripts 脚本:是在package.json里的scripts里面设置的内容,在脚本里的命令特点①首先重全局找②再从上到下寻找node_modules/.bin里的命令

    - 一个命令同时运行多个命令,命令直接用& || &&分隔,使用 &链接特点 是多个命令的运行时间不确定,并行执行,使用&&链接运行是串行执行

    - 脚本变量:在模块代码中使用package.json中的变量,应用变量的格式:通过进程访问process.npm_package_name_key(最终需要访问到遍历)

      ```js
      prcess.env.npm_package_前缀_key
      "show": "echo $npm_package_name && echo $npm_package_version"
      ```

    - window系统会获取不到package.json中的变量,需要运行跨平台设置和使用脚本,windows上的bash是本机的bash, window不支持NODE_ENV,cross-env可以使用单个命令,而不需要设置平台

      ```sh
      npm install --save-dev cross-env
      ```

    - 执行命令时候指定命令的环境

      ```sh
       "dev": "cross-env NODE_ENM=development node ./01_package.js"
       
       获取命令行的变量  process.env.NODE_ENV
      ```

12. 使用npm安装git上发布的包

    - 安装命令

      ```sh
      npm install git+http://
      # ssh
      npm install git+ssh://
      ```

13. nrm: npm registry manager:是npm的仓库源管理器

    - 查看当前源

      ```sh
      npm config git registry
      ```

    - 切换淘宝源

      ```sh
      npm config set registry https://registry.npm.taobao.org
      ```

14. 使用nrm管理源:是npm的镜像管理工具,可以快速切换npm源

    - 安装nrm:

      ```sh
      npm install -g nrm
      ```

    - 使用nrm

      ```sh
      # 查看可用的原
      nrm ls
      # 切开源
      nrm use taobao
      # 测试源
      nrm test
      ```

15. npx:npm从5.2开始增加了npx命令,

    -  如果不能用,需要手动安装

      ```sh
      npm install -g npx
      ```

    - 作用:如果需要在命令行使用node_modules中的命令,只能在package里的脚本里面,在命令行调用必须使用路径调用,npx解决了在命令行调用项目内部的模块

      ```sh
      npx 命令
      npx -no-install 命令  # 本地没有就没有
      npx --ignore-existing 命令 	# 忽略是否存在都安装
      ```

      > - 如果npx命令不存在,或下载到临时文件,运行完毕后删除缓存,如果安装到全局,在脚本中使用的命令,依赖全局,其他人就不知道启动失败

16. 模块包

    - 模块分类三类
    - 模块定义,包,commonjs

17. node的commonsjs

    - 原生js不支持模块化,是nodejs的规范,浏览器不知道commonjs;

    ```js
    //定义模块
    const name = {}
    const age = {}
    //暴露模块 
    module.exports = obj  
    // module.exports只能写一个所以上面的修改为
    module.exports = {name,age}
    
    // 暴露多次 exports 是 module.exports的引用
    exports.name = name
    exports.age = age
    // default 
    exports.default.xxx
    exports.default = {}
    
    
    // 引入 可以省略文件的js
    const name = require('模块所在文件.js')
    cosnt {name,age} = require('模块所在文件.js')
    ```

18. es6 模块化 import