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

     





