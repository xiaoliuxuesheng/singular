# 项目架构

## 1.1 环境准备

1. 安装Node

2. 安装vue

   ```sh
   npm install -g vue@next
   ```

3. vue脚手架cli

   ```sh
   yarn global add @vue/cli
   # 或
   npm install -g @vue/cli
   ```

4. vite

   ```sh
   npm init vite
   # 或
   yarn create vite
   # 或
   pnpm create vite
   ```

## 1.2 项目初始化

- vite+vue3+ts初始依赖

  ```json
  {
      "dependencies": {
          "vue": "^3.2.25"
      },
      "devDependencies": {
          "@vitejs/plugin-vue": "^2.2.0",
          "typescript": "^4.5.4",
          "vite": "^2.8.0",
          "vue-tsc": "^0.29.8"
      }
  }
  ```

## 1.3 安装Eslint

1. 安装eslint

   ```sh
   npm i eslint -D
   ```

2. 在Vue+TS项目中初始化eslint

   ```sh
   npx eslint --init
   
   # 步骤一：打算怎么使用eslint？检查语法、查找问题并强制执行代码样式
   ? How would you like to use ESLint? … 
     To check syntax only
     To check syntax and find problems
   ❯ To check syntax, find problems, and enforce code style
   # 步骤二：Eslint配置文件的打包模式（项目src外统一使用CommonJS）
   ? What type of modules does your project use? … 
     JavaScript modules (import/export)
   ❯ CommonJS (require/exports)
     None of these
   # 步骤三：使用vue框架
   ? Which framework does your project use? … 
   ❯ React
     Vue.js
     None of these
   # 步骤四：使用Typescript
   ? Does your project use TypeScript? › No / Yes
   # 步骤五：运行环境，输入a表示全选
   ? Where does your code run? …  (Press <space> to select, <a> to toggle all, <i> to invert selection)
   ✔ Browser
   ✔ Node
   # 步骤六：Eslint的使用方式，选择受欢迎的样式，这个配置少，后续还需要修改
   ? How would you like to define a style for your project? … 
   ❯ Use a popular style guide
     Answer questions about your style
     Inspect your JavaScript file(s)
   # 步骤七：选择standard规范包
   ? Which style guide do you want to follow? … 
     Airbnb: https://github.com/airbnb/javascript
   ❯ Standard: https://github.com/standard/standard
     Google: https://github.com/google/eslint-config-google
     XO: https://github.com/xojs/eslint-config-xo
   # 步骤八：配置文件格式选择js
   ? What format do you want your config file to be in? … 
   ❯ JavaScript
     YAML
     JSON
   # 步骤九：安装需要的依赖包
   eslint-plugin-vue@latest @typescript-eslint/eslint-plugin@latest eslint-config-standard@latest eslint@^7.12.1 eslint-plugin-import@^2.22.1 eslint-plugin-node@^11.1.0 eslint-plugin-promise@^4.2.1 || ^5.0.0 @typescript-eslint/parser@latest
   ? Would you like to install them now with npm? › No / Yes
   
   # 目的：为了安装Eslint以及依赖的规范包
   + eslint-plugin-promise@5.2.0
   + eslint-plugin-vue@8.5.0
   + eslint@7.32.0
   + eslint-plugin-node@11.1.0
   + eslint-plugin-import@2.25.4
   + eslint-config-standard@16.0.3
   + @typescript-eslint/parser@5.15.0
   + @typescript-eslint/eslint-plugin@5.15.0
   ```

3. 生成eslint配置文件：.eslintrc.js

   ```js
   module.exports = {
     env: {
       browser: true,
       es2021: true,
       node: true
     },
     extends: [
       'plugin:vue/essential',
       'standard'
     ],
     parserOptions: {
       ecmaVersion: 12,
       parser: '@typescript-eslint/parser',
       sourceType: 'module'
     },
     plugins: [
       'vue',
       '@typescript-eslint'
     ],
     rules: {
     }
   }
   ```

4. eslint-define-config：为.eslintrc.js文件提供defineConfig函数，在配置时候做代码提示

   - 下载依赖

     ```sh
     npm i eslint-define-config -D
     ```

   - 修改配置文件：.eslintrc.js

     ```js
     const { defineConfig } = require('eslint-define-config')
     module.exports = defineConfig({
         // TODO
     })
     ```

5. 安装vite-plugin-eslint插件，用于和Vitem项目集成

   - 下载依赖

     ```sh
     npm i vite-plugin-eslint -D
     ```

   - 在vite.config.ts配置文件添加插件

     ```tsx
     import eslintPlugin from 'vite-plugin-eslint'
     export default defineConfig({
       plugins: [
           eslintPlugin({
             cache: false,
             include: ['src/**/*.vue', 'src/**/*.ts', 'src/**/*.js', 'src/**/*.scss']
           })
       ]
     })
     ```

   - 启动项目：`npm run dev`，Eslint检查报错，Eslint生效

6. 配置Eslint

   ```js
   const { defineConfig } = require('eslint-define-config')
   module.exports = defineConfig({
     //
     root: true,
     // 运行环境的内置变量，不需要检查
     env: {
       browser: true,
       es2021: true,
       node: true,
       "vue/setup-compiler-macros": true
     },
     //
     extends: [
       'plugin:vue/vue3-essential',  // 使用的是Vue，把plugin:vue/essential替换掉
       'standard'
     ],
     parserOptions: {
       ecmaVersion: 12,
       parser: '@typescript-eslint/parser',
       sourceType: 'module'
     },
     plugins: [
       'vue',
       '@typescript-eslint'
     ],
     rules: {
     }
   })
   ```

## 1.4 安装prettier

1. 下载prettier以及相关插件

   ```sh
   npm i --save-dev prettier eslint-config-prettier eslint-plugin-prettier
   ```

   > - `prettier`：prettier插件的核心代码
   > - `eslint-config-prettier`：解决ESLint中的样式规范和prettier中样式规范的冲突，以prettier的样式规范为准，使ESLint中的样式规范自动失效
   > - `eslint-plugin-prettier`：将prettier作为ESLint规范来使用

2. 添加配置文件：.prettierrc.js

   ```js
   module.exports = {
       printWidth: 120, // 换行字符串阈值
       tabWidth: 2, // 设置工具每一个水平缩进的空格数
       useTabs: false,
       semi: false, // 句末是否加分号
       vueIndentScriptAndStyle: true,
       singleQuote: true, // 用单引号
       trailingComma: 'none', // 最后一个对象元素加逗号
       bracketSpacing: true, // 对象，数组加空格
       jsxBracketSameLine: true, // jsx > 是否另起一行
       arrowParens: 'always', // (x) => {} 是否要有小括号
       requirePragma: false, // 不需要写文件开头的 @prettier
       insertPragma: false // 不需要自动在文件开头插入 @prettier
   }
   ```

3. 集成Eslint

   ```js
   const { defineConfig } = require('eslint-define-config')
   module.exports = defineConfig({
     extends: [
       'prettier',
       'plugin:prettier/recommended'
     ],
   })
   ```

   > - `prettier/@typescript-eslint`：使得@typescript-eslint中的样式规范失效，遵循prettier中的样式规范
   > - `plugin:prettier/recommended`：使用prettier中的样式规范，且如果使得ESLint会检测prettier的格式问题，同样将格式问题以error的形式抛出

4. 修改编辑器的自动格式化功能

# 项目架构(过期)

## 1.1 环境准备

1. 安装Node

2. 安装vue

   ```sh
   npm install -g vue@next
   ```

3. vue脚手架cli

   ```sh
   yarn global add @vue/cli
   # 或
   npm install -g @vue/cli
   ```

4. vite

   ```sh
   npm init vite
   # 或
   yarn create vite
   # 或
   pnpm create vite
   ```

## 1.21 项目搭建

1. vite+vue3+ts初始依赖

   ```json
   {
       "dependencies": {
           "vue": "^3.2.25"
       },
       "devDependencies": {
           "@vitejs/plugin-vue": "^2.2.0",
           "typescript": "^4.5.4",
           "vite": "^2.8.0",
           "vue-tsc": "^0.29.8"
       }
   }
   ```

2. 安装eslint

   ```sh
   npm i eslint -D
   ```

3. 

## 1.2 项目搭建

1. vite+vue+ts初始依赖

   ```json
   {
       "dependencies": {
           "vue": "^3.2.25"
       },
       "devDependencies": {
           "@vitejs/plugin-vue": "^2.2.0",
           "typescript": "^4.5.4",
           "vite": "^2.8.0",
           "vue-tsc": "^0.29.8"
       }
   }
   ```

2. 路径别名配置

   - 安装依赖

     ```sh
     npm i @types/node -D
     ```

   - 修改配置文件

     ```tsx
     import { resolve } from 'path'
     export default defineConfig({
         resolve: {
             alias: [
                 {find: '@', replacement: resolve(__dirname, 'src')}
             ]
         }
     })
     ```

3. 安装配置Eslint

   - 安装Eslint

     ```sh
     npm i eslint -D
     ```

   - 初始化eslint

     ```sh
      npx eslint --init
      
      You can also run this command directly using 'npm init @eslint/config'.
     npx: installed 40 in 1.918s
     ? How would you like to use ESLint? … 
       To check syntax only
       To check syntax and find problems
     ❯ To check syntax, find problems, and enforce code style
     
     ✔ How would you like to use ESLint? · problems
     ? What type of modules does your project use? … 
     ❯ JavaScript modules (import/export)
       CommonJS (require/exports)
       None of these
     
     ? Which framework does your project use? … 
       React
     ❯ Vue.js
       None of these
     
     ? Does your project use TypeScript? › Yes
     
     ? What format do you want your config file to be in? … 
     ❯ JavaScript
       YAML
       JSON
     
     eslint-plugin-vue@latest @typescript-eslint/eslint-plugin@latest @typescript-eslint/parser@latest eslint@latest
     ✔ Would you like to install them now with npm? · Yes
     ```

     > - eslint-plugin-vue 是对 .vue 文件进行代码校验的插件
     >   - plugin:vue/base：基础
     >   - plugin:vue/essential：预防错误的（用于 Vue 2.x）
     >   - plugin:vue/recommended：推荐的，最小化任意选择和认知开销（用于 Vue 2.x）；
     >   - plugin:vue/strongly-recommended：强烈推荐，提高可读性（用于 Vue 2.x）；
     >   - plugin:vue/vue3-essential：（用于 Vue 3.x）
     >   - plugin:vue/vue3-strongly-recommended：（用于 Vue 3.x）
     >   - plugin:vue/vue3-recommended：（用于 Vue 3.x）

   - 安装eslint-define-config依赖，修改生成的eslintrc配置文件

     ```sh
     npm i eslint-define-config -D
     ```

     ```ts
     import {defineConfig} from 'eslint-define-config'
     module.exports = defineConfig({
         // TODO
     })
     ```

4. 安装Vite-Eslint插件

   - 下载依赖

     ```sh
     npm i vite-plugin-eslint -D
     ```

   - 配置

     ```sh
     plugin:vue/base：基础
     
     plugin:vue/essential：预防错误的（用于 Vue 2.x）
     
     plugin:vue/recommended：推荐的，最小化任意选择和认知开销（用于 Vue 2.x）；
     
     plugin:vue/strongly-recommended：强烈推荐，提高可读性（用于 Vue 2.x）；
     
     plugin:vue/vue3-essential：（用于 Vue 3.x）
     
     plugin:vue/vue3-strongly-recommended：（用于 Vue 3.x）
     
     plugin:vue/vue3-recommended：（用于 Vue 3.x）
     ```

5. 安装Pretty

   - 安装

     ```sh
     npm i prettier -D  
     ```

   - 添加pritty配置文件：.prettierrc.js

     ```js
     module.exports = {
         printWidth: 80,                    //（默认值）单行代码超出 80 个字符自动换行
         tabWidth: 2,                       //（默认值）一个 tab 键缩进相当于 2 个空格
         useTabs: true,                     // 行缩进使用 tab 键代替空格
         semi: false,                       //（默认值）语句的末尾加上分号
         singleQuote: true,                 // 使用单引号
         quoteProps: 'as-needed',           //（默认值）仅仅当必须的时候才会加上双引号
         jsxSingleQuote: true,              // 在 JSX 中使用单引号
         trailingComma: 'all',              // 不用在多行的逗号分隔的句法结构的最后一行的末尾加上逗号
         bracketSpacing: true,              //（默认值）在括号和对象的文字之间加上一个空格
         jsxBracketSameLine: true,          // 把 > 符号放在多行的 JSX 元素的最后一行
         arrowParens: 'avoid',              // 当箭头函数中只有一个参数的时候可以忽略括弧
         vueIndentScriptAndStyle: false,    //（默认值）对于 .vue 文件，不缩进 <script> 和 <style> 里的内容
         embeddedLanguageFormatting: 'off', // 不允许格式化内嵌的代码块，比如 markdown  文件里的代码块
     };
     ```

   - 忽略不需要格式化的文件

     ```tex
     /node_modules/**
     /dist/
     /dist*
     /public/*
     /docs/*
     /docs/**/*
     ```

   - Prettier 和 ESLint 一起干活更配哦

     ```sh
     npm i eslint-plugin-prettier -D
     ```

     

# vue3+ts+vite

## 1.1 下载

1. 安装vue3

   ```sh
   npm install -g vue@next
   ```

2. 安装vite

   ```sh
   
   ```

3. 创建vue3项目 + ts

   ```sh
   npm init @vitejs/app
   ```

   > - 输入项目名称
   >
   >   ```tex
   >   Project name: 
   >   ```
   >
   > - 选择框架：上下选择回车确认
   >
   >   ```text
   >    Select a framework: › - Use arrow-keys. Return to submit.
   >       vanilla
   >   ❯   vue
   >       react
   >       preact
   >       lit
   >       svelte
   >   ```
   >
   > - 选择TS模式：上下选择回车确认
   >
   >   ```text
   >   ? Select a variant: › - Use arrow-keys. Return to submit.
   >       vue
   >   ❯   vue-ts
   >   ```

## 1.2 配置-server

- 项目启动时候不指定host会提示添加：在配置文件`vite.config.ts`添加server配置

  ```tsx
  export default defineConfig({
    // ...
    server:{
      host: '0.0.0.0',
      port: 18081,
      open: true
    }
    // ...
  })
  ```

## 1.3 配置别名

- 下载别名插件

  ```sh
  npm install @types/node --save-dev
  ```

- 在配置文件`vite.config.ts`添加resolve配置

  ```ts
  import {resolve} from 'path'
  
  export default defineConfig({
    // ...
    resolve:{
      alias:[
        {find: '@', replacement: resolve(__dirname,'src')}
      ]
    }
    // ...
  })
  ```

- 还需要在ts的配置文件中添加配置

  ```json
  {
    "compilerOptions": {
      // ...
      "baseUrl": "./",
      "paths":{
        "@": ["src"],
        "@/*": ["src/*"],
      }
    },
    // ...
  }
  ```

## 1.4 router

- 下载router4

  ```sh
  npm install vue-router@4
  ```

- 新建`src/router/index.ts`

  ```tsx
  
  ```

- 挂载到Vue实例中

  ```tsx
  import { createApp } from 'vue'
  import App from './App.vue'
  // 引入路由配置
  import router from "@/router";
  
  createApp(App)
  		 // 挂载
      .use(router)
      .mount('#app')
  ```

## 1.5 Vuex

- 下载Vuex

  ```sh
  npm install vuex@next --save 
  ```

- 新建`src/store/index.ts`

  ```tex
  
  ```

- Vuex4的使用

  1. 在setup函数中获取store：与在组件中使用选项式 API 访问 `this.$store` 是等效的。

     ```js
     import { useStore } from 'vuex'
     
     export default {
       setup () {
         const store = useStore()
       }
     }
     ```

  2. 访问 state 和 getter，需要创建 `computed` 引用以保留响应性

     ```js
     import { computed } from 'vue'
     import { useStore } from 'vuex'
     
     export default {
       setup () {
       	// 获取store对象
         const store = useStore()
     
         return {
           // 在 computed 函数中访问 state
           count: computed(() => store.state.count),
     
           // 在 computed 函数中访问 getter
           double: computed(() => store.getters.double)
         }
       }
     }
     ```

  3. 使用 mutation 和 action 时，只需要在 `setup` 钩子函数中调用 `commit` 和 `dispatch` 函数。

     ```js
     import { useStore } from 'vuex'
     
     export default {
       setup () {
         const store = useStore()
     
         return {
           // 使用 mutation
           increment: () => store.commit('increment'),
     
           // 使用 action
           asyncIncrement: () => store.dispatch('asyncIncrement')
         }
       }
     }
     ```

  4. 在Typescript中使用

     





