# 1. Vuex

- 安装Vuex
  
  ```sh
  npm i vuex -S
  ```

- 基本配置
  
  1. 新建src/store目录，新增index.js，添加如下基本结构
     
     ```js
     import Vue from 'vue'
     import Vuex from 'vuex'
     
     Vue.use(Vuex)
     const store = new Vuex.Store({
     
     })
     
     export default store
     ```
  
  2. main.js中添加store的index
     
     ```js
     import store from "./store";
     
     new Vue({
       store
       render: h => h(App),
     }).$mount('#app')
     ```
  
  3. 模块化store：新增src/store/modules目录，新增app.js并且namespaced: true
     
     ```js
     const state = {
       name: ''
     }
     const mutations = {
     }
     const actions = {
     }
     
     export default {
         namespaced: true,
         state,
         mutations,
         actions
     }
     ```
  
  4. 独立抽取getters：与index同级新增getters.js
     
     ```js
     const getters = {
         name: state => state.app.name,
     }
     
     export default getters
     ```

# 2. VueRouter

- 安装VueRouter
  
  ```sh
  npm i vue-router -S
  ```

- 配置VueRouter
  
  1. 新增router配置文件：/src/router/index.js
     
     ```js
     
     ```

# 3. Axios

- 安装Axios
  
  ```sh
  npm i axios qs -S        
  ```

- 配置Axios：
  
  - 单域名axios配置：/src/api/http.js
    
    ```js
    import axios from "axios";
    import qs from "qs";
    import {getToken,responseApp} from "../uitls/commons";
    ```
    
    /**
    
    * 根据环境变量匹配不同的Axios请求url
    * - 在package.json中的script中指定环境变量
        
        <code>
        "scripts": {
           // win系统：用set和&&连接多参数
           "serve:dev": "set NODE_ENV=development&&vue-cli-service serve"
           // mac系统：不用set， &&符号用空格
           "serve:dev": "NODE_ENV=development vue-cli-service serve"
         },
        </code>
        */
        switch (process.env.NODE_ENV) {
        case 'production':
           axios.defaults.baseURL = 'http://localhost:8080';
           break;
        case 'development':
           axios.defaults.baseURL = 'http://localhost:8081';
           break;
        case 'test':
           axios.defaults.baseURL = 'http://localhost:8082';
           break;
        default:
           console.log("环境变量配置错误")
        }
        /**
    * 设置超时时间和Token验证
      */
      axios.defaults.timeout = 10 * 1000;
      /**
    * 如果不加该配置，跨域请求不允许携带凭证cookie
    * @type {boolean}
      */
      axios.defaults.withCredentials = true;
      /**
    * 设置请求头：告知服务器请求主体的数据格式
      */
      axios.defaults.headers['Content-Type'] = 'application/x-www-form-urlencoded'
      axios.defaults.transformRequest = data => qs.stringify(data)
      /**
    * 请求拦截器
      */
      axios.interceptors.request.use(config => {
       let token = getToken();
       token && (config.headers.Authorization = token);
       return config;
      },error => {
       return Promise.reject(error)
      })
    
    /**
    
    * 自定义相应状态吗,状态吗不符合才会进到interceptors.response的error
      */
      axios.defaults.validateStatus = status => {
       return /^(2|3)\d{2}$/.test(status.toString())
      }
      /**
    * 相应拦截器
      */
    
    axios.interceptors.response.use(response => {
    
        return responseApp(response)
    
    },error => {
    
        let {response} = error
        if (response){
            switch (response.status){
                case 401:
                    console.log('跳转到401');
                    break;
                case 403:
                    console.log('跳转到403')
                    break;
                case 404:
                    console.log("404")
                    break;
                default:
                    console.log('未知错误')
            }
        }else {
            if (!window.navigator.onLine) {
                console.log('网络中断')
                return;
            }else {
                return Promise.reject(error);
            }
        }
    
    })
    
    export default axios
    
    ```
    
    ```

- 多域名http配置