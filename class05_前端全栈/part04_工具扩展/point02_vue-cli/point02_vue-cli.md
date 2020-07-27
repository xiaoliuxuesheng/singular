# 1. vue-cli简介

# 2. vue-cli安装

- 安装node

- 安装cnpm

- 安装最新vue-clie

  ```sh
  cnpm install -g @vue/cli
  ```

- 使用脚手架初始化vue项目

  1. 基于交互命令的方式创建项目

     ```sh
     vue create 项目名称
     ```

     - Manually select features：手动方式安装依赖
     - 空格选择：Babel、Router、Linter回车确定
     - 不要选择安装history方式的路由，推荐使用hash模式路由
     - 选择ESlint语法版本为：Standard config
     - Lint on save时候设置语法规则校验
     - 将配置文件生成到单独的配置文件中：In dedicated config file
     - 不需要保留模板创建项目

  2. 基于图形化界面的方式创建项目

     ```sh
     vue ui
     ```

     - 

  3. 基于2.x旧版面的创建模式

     ```sh
     cnpm install -g @vue/cli-init
     
     vue init webpack 项目名称
     ```

# 3. vue脚手架结构

- 目录结构

  ```yml
  node_modules/		# 依赖包目录
  public/				# 静态资源目录
  src/				# 源码目录
  	assets/			# 资源文件
  	components/		# 是小组件
  	containers/		# 组件	是是容器级组件
  	views/			# 视图组件 是页面级组件
  	router/			# 路由	
  	App.vue			# 根组件
  	main.js			# 打包入口文件
  babel.config.js		# bable配置文件
  package.json		# npm 配置文件
  .eslintrc.js		# eslint语法配置文件
  
  ```

- 脚手架的自定义配置

  - 通过package.json配置文件中追加vue属性的配置

    ```json
    "vue":{
        "devServer":{
            "port":端口,
            "open":true
        }
    }
    ```

  - 建议将vue脚手架的配置单独设置到vue.config.js配置文件中：需要创建vue.config.js

    ```js
    module.exports={
        devServer:{
            open:true,
            port:8888
        }
    }
    ```


# 4. 项目语法约束

- `ey: value`格式冒号后必须带有空格
- vue组件文件的最后一行必须是空行
- 组件中不可以有空行