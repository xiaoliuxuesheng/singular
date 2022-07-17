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

2.  在项目根目录添加配置文件：`.prettierrc.js`
   
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



# 架构步骤

## 06、VueRouter

1. 安装
   
   ```sh
   # npm
   npm install vue-router@4
   
   # yarn
   yarn add vue-router@4
   ```

2. 在src下新增router目录，将router目录添加到路径别名中
   
   ```tsx
   import { resolve } from 'path'
   
   export default defineConfig({
     resolve:{
       alias:[
         {
           find: '@R',
           replacement: resolve(__dirname, './src/routers')
         }
       ]
     }
   })
   ```

3. 采用路由模块化配置，在routers下新建Index.ts文件和modules目录，模块化的路由添加到modules中，在Index.ts中引入modules中的配置项
   
   ```tsx
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

4. 在main.ts中引入路由组件
   
   ```tsx
   import { createApp } from 'vue'
   import App from '@/App.vue'
   import router from '@/routers'
   
   createApp(App).use(router).mount('#app')
   ```

5. 测试初始化项目中的路由功能
   
   - 在src/routers/modules中新增HelloWorld.ts文件并添加HelloWorld.vue的路由配置
     
     ```tsx
     import { RouteRecordRaw } from 'vue-router'
     const TestRouters: RouteRecordRaw[] = [
         {
             path: '/hello',
             name: 'HelloWorld',
             component: () => import('@/components/HelloWorld.vue'),
         },
     ]
     export default TestRouters
     ```
   
   - 在App.vue中添加路由router-link和router-view
     
     ```vue
     <template>
         <p>
             <router-link to="/hello">hello</router-link>
         </p>
         <div>
             <router-view></router-view>
         </div>
     </template>
     ```

## 07、pinia

1. 安装
   
   ```sh
   yarn add pinia
   # or with npm
   npm install pinia
   ```

2. 在src目录中新增stores目录，并且把stores目录添加为一个路径别名@S
   
   ```tsx
   import { resolve } from 'path'
   
   export default defineConfig({
     resolve:{
       alias:[
         {
           find: '@S',
           replacement: resolve(__dirname, './src/stores')
         }
       ]
     }
   })
   ```

3. 添加配置后在WebStom中写路径没有提示，需要在tsconfig.json中添加baseUrl和paths配置
   
   ```json
   {
     "compilerOptions": {
       "baseUrl": ".",
       "paths": {
         "@S/*": ["src/stores/*"]
       },
     }
   }
   ```

4. pinia支持模块化，不再需要stores当做一个入口文件了，只需要将各个模块的store按照约定，定义在stores目录中即可，在组件中使用到模块时候，单独引入模块即可，只需要在mian.ts中将pinia的实例对象挂载到Vue中即可
   
   ```tsx
   import { createApp } from 'vue'
   import App from '@/App.vue'
   import router from '@R/Index'
   import { createPinia } from 'pinia'
   
   createApp(App).use(router).use(createPinia()).mount('#app')
   ```

5. 定义模块化的store：HelloStore.ts
   
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

6. 测试在组件中引入store并使用
   
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
       "dev": "vite --mode=dev"
     }
   }
   ```

4. 测试读取配置文件中的VITE_BASE_URL
   
   ```tsx
   console.log(import.meta.env.VITE_BASE_URL)
   ```

## 09、sass

## 10、axios

1. 下载axios依赖
   
   ```shell
   http://www.axios-js.com/zh-cn/
   ```

2. 在src目录中新建utils目录，添加AxiosUtils.ts文件
   
   ```ts
   import axios, { AxiosRequestConfig, AxiosInstance } from 'axios'
   
   class AxiosUtil {
      // 定义内部访问的静态变量，用来保存唯一的声音实例
      private static instance: AxiosUtil
   
      private readonly http: AxiosInstance
   
      // 将构造函数私有化，禁止外部实例化创建实例
      private constructor() {
          this.http = axios.create({})
          this.init(this.http)
      }
   
      // 定义静态的实例化方法
      static Instance(): AxiosUtil {
          // 如果当前的私有实例还不存在，则内部实例化对象
          if (!AxiosUtil.instance) {
              AxiosUtil.instance = new AxiosUtil()
          }
   
          // 返回对象
          return AxiosUtil.instance
      }
   
      private init(http: AxiosInstance) {
          http.interceptors.request.use((config: AxiosRequestConfig) => {
              return config
          })
          http.interceptors.response.use((response: AxiosRequestConfig) => {
              return response.data
          })
      }
   
      get(url: string, params: {}) {
          return new Promise((resolve, reject) => {
              axios
                  .get(url, { params })
                  .then((res) => {
                      resolve(res.data)
                  })
                  .catch((err) => {
                      reject(err.data)
                  })
          })
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
   
   const axiosUtil = AxiosUtil.Instance()
   export default axiosUtil
   ```

## 11、proxy

1. 配置文件添加server添加porxy配置
   
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

## 12、nativeUI

## 13、自定义Icon

1. 安装自定义Icon插件：npm i vite-plugin-svg-icons -D
   
   ```shell
   yarn add vite-plugin-svg-icons -D
   # or
   npm i vite-plugin-svg-icons -D
   # or
   pnpm install vite-plugin-svg-icons -D
   ```

2. 配置vite.config.ts
   
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
         iconDirs: [path.resolve(process.cwd(), "src/assets/icons")],
         // 指定symbolId格式
         symbolId: "icon-[dir]-[name]",
   
         /**
          * 自定义插入位置
          * @default: body-last
          */
         // inject?: 'body-last' | 'body-first'
   
         /**
          * custom dom id
          * @default: __svg__icons__dom__
          */
         // customDomId: '__svg__icons__dom__',
       }),
     ],
   ```

```
3. 封装SvgIcon组件 src/components/SvgIcon

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

4. 全局注册 main.ts
   
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

5. 下载组件组件使用 index.vue
   
   ```html
   // 只需name绑定成icons目录下的svg文件名即可
   <SvgIcon name="heSuan" />
   ```

6. # Vue3+TS技巧
