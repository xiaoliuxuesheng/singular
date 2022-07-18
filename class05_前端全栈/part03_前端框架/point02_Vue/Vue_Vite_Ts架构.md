# ★ 参考资料

★ Vite官网：https://cn.vitejs.dev/

★ vue-router4：https://router.vuejs.org/zh/

★ pinia：https://pinia.vuejs.org/

★ axios：http://www.axios-js.com/zh-cn/

# ★ 环境准备

1. Node环境要求：ode.js 版本 >= 14.18.0
   
   ```shell
   node -v
   ```

# ★ 项目构建

## 01、使用Vite构建Vue3项目

1. 使用命令行创建vue项目
   
   ```shell
   npm create ite@latest
   
   # 输入项目名称: 默认项目名称vite-project
   ? Project name: » vite-project
   
   # 选项项目框架
   ? Select a framework: » - Use arrow-keys. Return to submit.
       vanilla
   >   vue
       react
       preact
       lit
       svelte
   
   # 选择项目语法类型
   ? Select a variant: » - Use arrow-keys. Return to submit.
       vue
   >   vue-ts
   ```

2. 进入项目根目录，安装依赖包，启动项目
   
   ```shell
   # 安装依赖包
   npm install
   # 启动项目
   npm run dev
   ```

3. 启动项目后检查运行环境
   
   ```http
   http://127.0.0.1:5173/
   ```

4. 安装vue浏览器插件vue-devtools 6.1.4：[指导参考文档](https://www.cnblogs.com/kousum/p/14396401.html)

## 02、路径别名配置

1. 安装node文件解析依赖包
   
   ```shell
   npm i @types/node -D
   ```

2. 配置文件中添加别名配置项：vite.config.ts中的resolve
   
   ```ts
   import {defineConfig} from 'vite'
   import vue from '@vitejs/plugin-vue'
   import {resolve} from 'path'
   
   export default defineConfig({
       plugins: [vue()],
       resolve: {
           // 配置alias别名时候,使用绝对路径,需要依赖path包
           alias: [
               {find: '@', replacement: resolve(__dirname, './src')}
           ]
       }
   })
   ```

3. 添加vue配置后，继续添加ts的对路径别名的配置，使路径解析过程有代码提示，需要在tsconfig.json中添加baseUrl和paths配置，tsconfig.json配置文件在项目的根目录，作用是在代码中使用`@/*`匹配的路径配置时，会从baseUrl开始，`@/*`对应的`src/*`目录中开始匹配
   
   ```json
   {
     "compilerOptions": {
       "baseUrl": ".",
       "paths": {
         "@/*": ["src/*"]
       }
     }
   }
   ```

4. 检查配置结果：如：修改项目中App.vue组件默认组件的路径配置，并且修改配置时候会有路径提示，重启项目，项目访问正常。
   
   ```v
   <script setup lang="ts">
   import HelloWorld from '@/components/HelloWorld.vue'
   </script>
   ```

## 03、局域网服务配置

> 如果需要通过局域网中的电脑或手机访问服务调试时，需要添加配置将服务暴露在网络中

1. 方式一：修改 vite.config.js 配置
   
   ```ts
   export default defineConfig({
       server:{
           // 设置为 0.0.0.0 或者 true 将监听所有地址
           host: '0.0.0.0',
           // 端口已经被使用，会自动尝试下一个可用的端口
           port: 8090,
           // 设为 true 时若端口已被占用则会直接退出
           strictPort: false,
           // 启动时自动在浏览器中打开应用程序
           open: true
       }
   })
   ```

2. 方式二：通过 Vite CLI 配置
   
   ```shell
   npx vite --host 0.0.0.0
   ```

3. 方式三：修改 package.json 文件中 scripts 节点下的脚本
   
   ```json
   "scripts": {
     "dev": "vite --host 0.0.0.0"
   }
   ```

## 04、ESlint

1. 下载ESlint依赖包
   
   ```shell
   npm i eslint -D
   ```

2. 在Vue+TS项目中初始化eslint
   
   ```shell
   npm init @eslint/config
   
   # ESLint的使用方式选择: 检查语法问题、统一代码风格
   ? How would you like to use ESLint? ...
     To check syntax only
     To check syntax and find problems
   > To check syntax, find problems, and enforce code style
   
   # ES module类型: JavaScript=import,CommonJS=require
   ? What type of modules does your project use? ...
   > JavaScript modules (import/export)
     CommonJS (require/exports)
     None of these
   
   # 选择Vue框架
   ? Which framework does your project use? ...
     React
   > Vue.js
     None of these
   
   # 选择TypeScript
   ? Does your project use TypeScript? » Yes
   
   # 项目运行环境是浏览器,键盘输入a表示全选
   ? Where does your code run? ...  (Press <space> to select, <a> to toggle all, <i> to invert selection)
   √ Browser
   √ Node
   
   # ESlint风格选择通用的,后续需要整合prettier,自定义选择的风格可能不兼容
   ? How would you like to define a style for your project? ...
   > Use a popular style guide
     Answer questions about your style
   
   # ESlint风格选择Standa的,后续需要整合prettier,会替换掉Standard
   ? Which style guide do you want to follow? ...
     Airbnb: https://github.com/airbnb/javascript
   > Standard: https://github.com/standard/standard
     Google: https://github.com/google/eslint-config-google
     XO: https://github.com/xojs/eslint-config-xo
   
   # ESLint配置文件格式:JavaScript
   ? What format do you want your config file to be in? ...
   > JavaScript
     YAML
     JSON
   
   # 以上操作的目的：为了安装Eslint以及依赖的规范包
   Checking peerDependencies of eslint-config-standard@latest
   The config that you've selected requires the following dependencies:
   
   eslint-plugin-vue@latest @typescript-eslint/eslint-plugin@latest eslint-config-standard@latest eslint@^8.0.1 eslint-plugin-import@^2.25.2 eslint-plugin-n@^
   15.0.0 eslint-plugin-promise@^6.0.0 @typescript-eslint/parser@latest
   ? Would you like to install them now with npm? » Yes
   ```

3. 查看生成eslint配置文件：.eslintrc.cjs
   
   ```js
   module.exports = {
     env: {
       browser: true,
       es2021: true
     },
     extends: [
       'plugin:vue/essential',
       'standard'
     ],
     parserOptions: {
       ecmaVersion: 'latest',
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

4. 此时Eslint未生效，安装vite-plugin-eslint插件，用于和Vitem项目集成，下载继承ESlint继承Vite项目的插件依赖包
   
   ```shell
   npm i vite-plugin-eslint -D 
   ```

5. 在Viet项目的配置文件vite.config.ts中配置插件
   
   ```ts
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

6. 此时启动项目会检查报错：`The template root requires exactly one element  vue/no-multiple-template-root`，Vue3的项目是在Vue文件中是不需要根目录了，需要修改.eslintrc.js，将语法检查包升级到支持Vue3的规则：plugin:vue/vue3-essential
   
   ```js
   module.exports = {
     extends: [
       // plugin:vue/essential 改为支持Vue3的语法检查包
       'plugin:vue/vue3-essential',
       'standard',
     ]
   }
   ```

7. 再次启动项目， 如果项目会报错`error 'defineProps' is not defined no-undef`，是因为不支持Vue3中的setup函数的语法糖格式，需要添加setup函数运行环境的支持
   
   ```js
   module.exports = {
     env: {
       // 使用的是Vue3，新增配置适配vue3 setup语法糖
       'vue/setup-compiler-macros': true
     }
   }
   ```

## 05、prettier

1. 安装prettier相关包
   
   ```shell
   npm i -D prettier eslint-config-prettier eslint-plugin-prettier
   ```
   
   > - `prettier`：prettier插件的核心代码
   > - `eslint-config-prettier`：解决ESLint中的样式规范和prettier中样式规范的冲突，以prettier的样式规范为准，使ESLint中的样式规范自动失效
   > - `eslint-plugin-prettier`：将prettier作为ESLint规范来使用

2. 在项目根目录添加配置文件：`.prettierrc.js`
   
   ```js
   module.exports = {
      // 一行最多 100 字符
      printWidth: 100,
      // 不使用缩进符，而使用空格
      useTabs: false,
      // 使用 2 个空格缩进
      tabWidth: 4,
      tabSize: 4,
      // 行尾需要有分号
      semi: false,
      // 使用单引号
      singleQuote: true,
      // 对象的 key 仅在必要时用引号
      quoteProps: 'as-needed',
      // jsx 不使用单引号，而使用双引号
      jsxSingleQuote: false,
      // 末尾不需要逗号 'es5'  none
      trailingComma: 'es5',
      // 大括号内的首尾需要空格
      bracketSpacing: true,
      // jsx 标签的反尖括号需要换行
      jsxBracketSameLine: false,
      // 箭头函数，只有一个参数的时候，也需要括号
      arrowParens: 'always',
      // 每个文件格式化的范围是文件的全部内容
      rangeStart: 0,
      rangeEnd: Infinity,
      // 不需要写文件开头的 @prettier
      requirePragma: false,
      // 不需要自动在文件开头插入 @prettier
      insertPragma: false,
      // 使用默认的折行标准
      proseWrap: 'preserve',
      // 根据显示样式决定 html 要不要折行
      htmlWhitespaceSensitivity: 'css',
      // 换行符使用 lf 结尾是 \n \r \n\r auto
      endOfLine: 'lf',
   };
   ```

3. 集成Eslint：添加格式化配置文件之后，需要集成Eslin，将Eslint的检查规则交个格式化方式
   
   ```js
   module.exports = {
     extends: [
         // 集成Eslint检查规则
       'prettier',
       'plugin:prettier/recommended'
     ]
   }
   ```

4. 设置编辑器格式化文件跨借鉴
   
   - WebStom：File | Settings | Keymap | Plugins | Prettier | Reformat with Prettier

5. 重启项目代码`prettier/prettier`检查报错，prettier组件集成成功，修改代码格式

## 06、VueRouter

1. 安装VueRouter
   
   ```shell
   # npm
   npm install vue-router@4
   
   # yarn
   yarn add vue-router@4
   ```

2. 采用路由模块化配置，在routers下新建Index.ts文件和modules目录，模块化的路由添加到modules中，在Index.ts中引入modules中的配置项
   
   ```ts
   import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router'
   
   const routes: RouteRecordRaw[] = []
   // 加载成功: Record的key是文件的相对路径字符串,value是这个文件中export的路由对象
   const constRouters: Record<string, any> = import.meta.globEager('./modules/*.ts')
   Object.keys(constRouters).forEach((key) => {
       routes.push(...constRouters[key].default)
   })
   
   export const dynamicRouter: RouteRecordRaw[] = []
   
   const router = createRouter({
       history: createWebHistory(),
       routes,
   })
   
   export default router
   ```

3. 在main.ts中引入路由组件
   
   ```ts
   import router from '@/routers'
   
   createApp(App).use(router).mount('#app')
   ```

4. 测试初始化项目中的路由功能
   
   - 在src/routers/modules中新增HelloRouter.ts文件并添加HelloWorld.vue的路由配置
     
     ```ts
     import { RouteRecordRaw } from 'vue-router'
     const HelloRouter: RouteRecordRaw[] = [
         {
             path: '/hello',
             name: 'HelloWorld',
             component: () => import('@/components/HelloWorld.vue'),
         },
     ]
     export default HelloRouter
     ```
   
   - 在App.vue中添加路由router-link和router-view
     
     ```html
     <script setup lang="ts"></script>
     
     <template>
         <p>
             <router-link to="/hello">hello</router-link>
         </p>
         <hr />
         <div>
             <router-view></router-view>
         </div>
     </template>
     
     <style scoped></style>
     ```

## 07、pinia

1. 安装
   
   ```sh
   yarn add pinia
   # or with npm
   npm install pinia
   ```

2. pinia支持模块化，不再需要stores当做一个入口文件了，只需要将各个模块的store按照约定，定义在stores目录中即可，在组件中使用到模块时候，单独引入模块即可，只需要在mian.ts中将pinia的实例对象挂载到Vue中即可
   
   ```tsx
   import { createApp } from 'vue'
   import App from '@/App.vue'
   import router from '@R/Index'
   import { createPinia } from 'pinia'
   
   createApp(App).use(router).use(createPinia()).mount('#app')
   ```

3. 定义模块化的store：HelloStore.ts
   
   ```tsx
   import { defineStore } from 'pinia'
   
   export const helloStore = defineStore('helloStore', {
       state: () => {
           return {
               counter: 10,
               name: 'Eduardo',
               isAdmin: true,
           }
       },
       getters: {
           getCounter: (state) => state.counter * 2,
           getName: (state) => state.name + '-》teset ',
           notAdmin: (state) => !state.isAdmin,
       },
       actions: {
           actionCounter() {
               this.counter++
           },
           actionName() {
               this.name = this.name + '-》action '
           },
           actionAdmin() {
               this.isAdmin = !this.isAdmin
           },
       },
   })
   ```

4. 新增测试组件HelloStore.vue，在组件中引入store并使用
   
   ```tsx
   <script setup lang="ts">
   import { ref } from 'vue'
   import { storeToRefs } from 'pinia'
   import { helloStore } from '@S/HelloStore'
   const count = ref(0)
   
   const hello = helloStore()
   const { getCounter, getName, notAdmin } = storeToRefs(hello)
   </script>
   
   <template>
       <h1>HelloWorld Router Test</h1>
       <p>
           {{ count }}
       </p>
       <h1>HelloWorld Store Tst</h1>
       <ul>
           <li>{{ getCounter }}</li>
           <li>{{ getName }}</li>
           <li>{{ notAdmin }}</li>
       </ul>
   </template>
   ```

5. 在测试路由模块中添加store组件的路由
   
   ```ts
   import { RouteRecordRaw } from 'vue-router'
   const HelloRouter: RouteRecordRaw[] = [
       {
           path: '/hello',
           name: 'HelloWorld',
           component: () => import('@/components/HelloWorld.vue'),
       },
       {
           path: '/store',
           name: 'HelloStore',
           component: () => import('@/components/HelloStore.vue'),
       },
   ]
   export default HelloRouter
   ```

6. 在App.vue中添加路由按钮，重启项目检查pinia
   
   ```html
       <p>
           <router-link to="/store">store</router-link>
       </p>
   ```

## 08、env

1. 添加三个配置文件
   
   ```txt
   .env.dev
   .env.prod
   .env.test
   ```

2. 在.evn配置文件中添对应的环境标识配置项：VITE_MODE_NAME
   
   ```properties
   VITE_MODE_NAME=dev
   VITE_BASE_URL=http://localhost:9002/dev/
   ```

3. 在package.json中添加运行脚本
   
   ```json
   {
     "scripts": {
        "mock": "vite --mode=mock",
       "dev": "vite --mode=dev",
       "test": "vite --mode=test",
       "prod": "vite --mode=prod",
     }
   }
   ```

4. 测试读取配置文件中的VITE_BASE_URL
   
   ```tsx
   console.log(import.meta.env.VITE_BASE_URL)
   ```

## 09、sass

1. 下载sass组件
   
   ```shell
   npm install --save-dev sass
   ```

2. 在src/assets中准备sass入口文件index.scss
   
   ```sass
   @import "base";
   ```

3. 模块化sass文件以下划线开头_base.scss，初始化测试数据
   
   ```sass
   $MyColor: red
   ```

4. 在配置文件vite.config.ts添加sass配置
   
   ```ts
   export default defineConfig({
       css: {
           preprocessorOptions: {
               scss: {
                   javascriptEnabled: true,
                   additionalData: '@import "@/assets/scss/index.scss";',
               },
           },
       },
   })
   ```

5. 在Vue组件中引入sass中变量值
   
   ```html
   <style scoped lang="scss">
   a,
   ul {
       color: $MyColor;
   }
   </style>
   ```

## 10、axios

1. 下载axios依赖
   
   ```shell
   # npm
   npm install axios
   
   # bower
   bower install axios
   ```

2. 在src目录中新建utils目录，添加AxiosUtils.ts文件
   
   ```ts
   import axios, { AxiosRequestConfig, AxiosInstance } from 'axios'
   
   class AxiosUtil {
       // 定义内部访问的静态变量，用来保存唯一的实例
       public static INSTANCE = new AxiosUtil()
   
       private readonly http: AxiosInstance
   
       // 将构造函数私有化，禁止外部实例化创建实例
       private constructor() {
           this.http = axios.create({
               baseURL: import.meta.env.VITE_BASE_URL,
               timeout: import.meta.env.VITE_TIMEOUT ? import.meta.env.VITE_TIMEOUT : 3000,
           })
           this.init(this.http)
       }
   
       private init(http: AxiosInstance) {
           http.interceptors.request.use((config: AxiosRequestConfig) => {
               return config
           })
           http.interceptors.response.use((response: AxiosRequestConfig) => {
               return response.data.data
           })
       }
   
       public get<T>(url: string, param: any): Promise<T> {
           return this.http.get(url, param)
       }
   
       post(url: string, params: {}) {
           return new Promise((resolve, reject) => {
               this.http
                   .post(url, JSON.stringify(params))
                   .then((res) => {
                       resolve(res.data)
                   })
                   .catch((err) => {
                       reject(err.data)
                   })
           })
       }
   
       upload(url: string, file: Object) {
           return new Promise((resolve, reject) => {
               this.http
                   .post(url, file, {
                       headers: { 'Content-Type': 'multipart/form-data' },
                   })
                   .then((res) => {
                       resolve(res.data)
                   })
                   .catch((err) => {
                       reject(err.data)
                   })
           })
       }
   
       download(url: string) {
           const iframe = document.createElement('iframe')
           iframe.style.display = 'none'
           iframe.src = url
           iframe.onload = function () {
               document.body.removeChild(iframe)
           }
           document.body.appendChild(iframe)
       }
   }
   
   const axiosUtil = AxiosUtil.INSTANCE
   export default axiosUtil
   ```

3. 在src/apis目录中封装Api请求UserApi.ts
   
   ```ts
   import axiosUtil from '@/utils/AxiosUtils'
   import { CatModel } from '@/apis/models/CatModel'
   
   export async function loginApi(params: {}): Promise<CatModel> {
      return await axiosUtil.get('/m1/468313-0-default/pet/1', params)
   }
   ```

4. 在src/apis/models目录中添加请求响应实体类型CatModel.ts
   
   ```ts
   export interface CatModel{
       id: string,
       name: string,
       photoUrls: string[],
       category: Category,
       tags: Tag[]
   }
   
   export interface Category{
       id: number,
       name: string
   }
   
   export interface Tag{
       id: number,
       name: string
   }
   ```

5. 在vue组件中发送请求测试axios封装
   
   ```html
   <script setup lang="ts">
   import { loginApi } from '@/apis/UserApi'
   import { CatModel } from '@/apis/models/CatModel'
   
   function login() {
       loginApi({ name: 23 }).then((res: CatModel) => {
           console.log(res.category)
       })
   }
   </script>
   
   <template>
       <p>
           <button @click="login">login</button>
       </p>
   </template>
   
   <style scoped>
   .read-the-docs {
       color: #888;
   }
   </style>
   ```

```
## 11、proxy

1. 修改.env.dev配置文件

```properties
VITE_MODE_NAME=dev
VITE_BASE_URL=http://172.17.240.1:10199/
```

2. 配置文件添加server添加porxy配置
   
   ```ts
   export default defineConfig({
       server:{
           proxy: {
               '/m1': {
                   target: 'http://127.0.0.1:4523',
                   changeOrigin: true,
                 }
           }
       }
   }
   ```

## 12、MockJS

1. 安装vite-plugin-mock
   
   ```shell
   npm install mockjs --save-dev
   npm i vite-plugin-mock -D
   ```

2. 根目录创建文件 mock\index.ts，这个文件用来编写总的mock管理
   
   ```ts
   import { MockMethod } from 'vite-plugin-mock'
   import userApi from "./source/login";
   export default [
       ...userApi
   ] as MockMethod[]
   ```

3. 继续创建文件mock\source\login.ts,这个文件放一个我们的测试模拟接口
   
   ```ts
   import { MockMethod } from 'vite-plugin-mock'
   
   export default [
       {
           url: '/mock/user',
           method: 'get',
           response: () => {
               return {
                   code: 200,
                   msg: 'SUCCESS',
                   data: {
                       nickname: '@cname',
                       age: '@integer(10-100)',
                       uid: '@id',
                       url: '@image',
                       city: '@city',
                       country: '@county(true)',
                       province: '@province',
                       mobile_phone: '@phone',
                       email: '@email',
                       region: '@region',
                       menus: [
                           {
                               menu_name: '一级导航',
                               id: '@id',
                               code: 'Nav1',
                               children: [
                                   {
                                       code: 'about',
                                       menu_url: 'views/about',
                                       access_permissions: '["about"]',
                                       children: [],
                                       menu_name: '测试1',
                                       id: '@id'
                                   },
                                   {
                                       code: 'home',
                                       menu_url: 'views/home',
                                       access_permissions: '["home"]',
                                       children: [],
                                       menu_name: '测试2',
                                       id: '@id'
                                   }
                               ]
                           }
                       ]
                   }
               }
           }
       },
       {
           url: '/mock/token',
           method: 'post',
           response: ({ body }: any) => {
               if (body.username === 'root') {
                   return {
                       code: 200200,
                       msg: 'SUCCESS',
                       data: {
                           timestamp: 20220229123030,
                           assetsToken: 'root',
                           refreshToken: 'root'
                       }
                   }
               } else {
                   return {
                       code: 200200,
                       msg: 'SUCCESS',
                       data: {
                           timestamp: 20220229123030,
                           assetsToken: 'test',
                           refreshToken: 'test'
                       }
                   }
               }
           }
       },
       {
           url: '/mock/menu/list',
           method: 'get',
           response: ({ query }: any) => {
               console.log(query)
               if (query.assetsToken == 'root') {
                   return {
                       code: 200200,
                       msg: 'SUCCESS',
                       data: [
                           {
                               path: '/account',
                               name: 'Account',
                               component: '/src/components/layout/Home.vue',
                               children:[
                                   {
                                       path: '/account/list',
                                       name: 'AccountList',
                                       component: '/src/views/merch/account/AccountList.vue'
                                   },
                                   {
                                       path: '/account/type',
                                       name: 'AccountType',
                                       component: '/src/views/merch/account/AccountType.vue'
                                   }
                               ]
                           },
                           {
                               path: '/emp',
                               name: 'Emp',
                               component: '/src/components/layout/Home.vue',
                               children:[
                                   {
                                       path: '/emp/dept',
                                       name: 'EmpDept',
                                       component: '/src/views/merch/emp/DeptList.vue'
                                   },
                                   {
                                       path: '/emp/list',
                                       name: 'EmpList',
                                       component: '/src/views/merch/emp/EmpList.vue'
                                   },
                                   {
                                       path: '/emp/role',
                                       name: 'EmpRole',
                                       component: '/src/views/merch/emp/RoleList.vue'
                                   }
                               ]
                           },
                           {
                               path: '/setting',
                               name: 'Setting',
                               component: '/src/components/layout/Home.vue',
                               children:[
                                   {
                                       path: '/setting/user',
                                       name: 'UserSetting',
                                       component: '/src/views/merch/setting/UserSetting.vue'
                                   }
                               ]
                           },
                           {
                               path: '/shop',
                               name: 'Shop',
                               component: '/src/components/layout/Home.vue',
                               children:[
                                   {
                                       path: '/shop/list',
                                       name: 'ShopList',
                                       component: '/src/views/merch/shop/ShopList.vue'
                                   },
                                   {
                                       path: '/shop/boss',
                                       name: 'ShopBoss',
                                       component: '/src/views/merch/shop/BossList.vue'
                                   }
                               ]
                           }
                       ]
                   }
               } else {
                   return {
                       code: 200200,
                       msg: 'SUCCESS',
                       data: [
                       ]
                   }
               }
           }
       }
   ] as MockMethod[]
   ```

4. 在userAPI测试API文件中添加mock接口
   
   ```ts
   export async function mockUser() {
       return await axiosUtil.get('/mock/user', {})
   }
   export async function mockToken() {
       return await axiosUtil.post('/mock/token', {})
   }
   ```

5. 在组件中测试调用接口
   
   ```html
   <script setup lang="ts">
   import { ref } from 'vue'
   import { loginApi, mockUser, mockToken } from '@/apis/UserApi'
   import { CatModel } from '@/apis/models/CatModel'
   
   function user() {
       mockUser().then((res) => {
           console.log(res)
       })
   }
   function token() {
       mockToken().then((res) => {
           console.log(res)
       })
   }
   </script>
   
   <template>
       <p>
           <button @click="user">mockUser</button>
       </p>
       <p>
           <button @click="token">mockToken</button>
       </p>
   </template>
   ```

6. 在vite配置文件中添加mockjs插件配置
   
   ```ts
   import { viteMockServe } from 'vite-plugin-mock'
   export default defineConfig({
       plugins: [
           viteMockServe({
               // ↓解析根目录下的mock文件夹
               mockPath: 'mock',
               localEnabled: true, // 开发打包开关
               prodEnabled: false, // 生产打包开关
               supportTs: true, // 打开后，可以读取 ts 文件模块。 请注意，打开后将无法监视.js 文件。
               watchFiles: true, // 监视文件更改
           }),
       ]
   })
   ```

## 13、naiveui

1. 下载native ui库
   
   ```shell
   npm i -D naive-ui
   ```

2. 按需自动引入native插件
   
   ```shell
   npm i -D unplugin-vue-components
   ```

3. 在配置文件中添加naive插件
   
   ```ts
   import Components from 'unplugin-vue-components/vite'
   import { NaiveUiResolver } from 'unplugin-vue-components/resolvers
   '
   export default defineConfig({
       plugins: [
           Components({
               resolvers: [NaiveUiResolver()]
           }),
       ]
   })
   ```

4. 在组件送使用native组件
   
   ```html
       <n-button>Default</n-button>
       <n-button type="tertiary"> Tertiary </n-button>
       <n-button type="primary"> Primary </n-button>
       <n-button type="info"> Info </n-button>
       <n-button type="success"> Success </n-button>
       <n-button type="warning"> Warning </n-button>
       <n-button type="error"> Error </n-button>
   ```

## 14、自定义Icon

1. 在开源矢量库下载icon组件,添加到src/assets目录的icons目录中
   
   ```tex
   src/assets/icons/sweet.svg
   src/assets/icons/sub/tee.svg
   ```

2. 安装自定义Icon插件：npm i vite-plugin-svg-icons -D
   
   ```shell
   yarn add vite-plugin-svg-icons -D
   # or
   npm i vite-plugin-svg-icons -D
   # or
   pnpm install vite-plugin-svg-icons -D
   ```

3. 配置vite.config.ts
   
   ```tsx
   //插件引入
   import { createSvgIconsPlugin } from 'vite-plugin-svg-icons'
   import path from 'path'
   
     plugins: [
       vue(),
       Components({
         // UI库
         resolvers: [ArcoResolver()],
       }),
       createSvgIconsPlugin({
         // 指定需要缓存的图标文件夹
         iconDirs: [resolve(__dirname, "src/assets/icons")],,
         // 指定symbolId格式
         symbolId: "icon-[dir]-[name]",
       }),
     ],
   ```

4. 封装SvgIcon组件 src/components/SvgIcon
   
   ```ts
   <template>
    <svg aria-hidden="true">
      <use :href="symbolId" :fill="color" />
    </svg>
   </template>
   
   <script>
   import { defineComponent, computed } from 'vue'
   
   export default defineComponent({
    name: 'SvgIcon',
    props: {
      prefix: {
        type: String,
        default: 'icon',
      },
      name: {
        type: String,
        required: true,
      },
      color: {
        type: String,
        default: '#333',
      },
    },
    setup(props) {
      const symbolId = computed(() => `#${props.prefix}-${props.name}`)
      return { symbolId }
    },
   })
   </script>
   ```

5. 全局注册 main.ts
   
   ```ts
   import { createApp } from "vue";
   import App from "./App.vue";
   // 路由 router 4.0
   import router from "./router/router";
   // 状态管理器  Pinia
   import { createPinia } from "pinia";
   const pinia = createPinia();
   // UI库 ardo.design
   import ArcoVue from "@arco-design/web-vue";
   import "@arco-design/web-vue/dist/arco.css";
   // svg封装插件
   import SvgIcon from "@/components/SvgIcon.vue"; +++
   import "virtual:svg-icons-register";            +++      
   createApp(App)
     .use(router)
     .use(pinia)
     .component("svg-icon", SvgIcon)               +++  
     .use(ArcoVue, {
       componentPrefix: "arco",
     })
     .mount("#app");
   ```

6. 下载组件组件使用 index.vue
   
   ```html
   // 只需name绑定成icons目录下的svg文件名即可
   <SvgIcon name="heSuan" />
   ```

# ★ Vue3+TS技巧
