# day09

01-网络请求模块的选择-axios

1. jsonp的原理和封装

2. axios技术 

   - vue中可选择的网络请求:①基于Ajax的XMLHttpRequest②JQuery-ajax（在框架中基本不在使用jQuery的技术）③Vue1退出的Vue-resource的网络请求插件（在Vuex这个插件不再维护）④axios是vue-resource的替代品⑤使用jsonp解决跨域请求

   - axios介绍：①支持在浏览器发送XMLHTTPRequest请②在node中发送http请求③支持PromiseAPI④拦截请求和响应⑤转换请求和响应数据

02-axios框架的基本使用

1. axios的支持是请求方式

   | API                            | 说明 |
   | ------------------------------ | ---- |
   | axios(config)                  |      |
   | axios.request(config)          |      |
   | axios.get(url,[config])        |      |
   | axios.delete(url.[config])     |      |
   | axios.head(url.[config])       |      |
   | axios.post(url,[data,config])  |      |
   | axios.put(url,[data,config])   |      |
   | axios.patch(url,[data,config]) |      |

2. axios的使用

   - 下载axios插件

     ```js
     npm install axios --save
     ```

   - 引入依赖

     ```js
     import axios from 'axios'
     ```

3. 基本使用

   - 基本的使用

     ```js
     axios({
         url: "https://httpbin.org/get"
     }).then(res => {
         console.log(res)
     })
     ```

   - 添加参数

     ```js
     axios({
         url: "https://httpbin.org/get",
         method: "POST",
         params: {
             key1: "value",
             key2: 23
         }
     }).then(res => {
         console.log(res);
     });
     ```

03-axios发送并发请求

- axios.all([axios(),axios()]).then(axios.spread(单独将结果封装为参数))

04-axios的配置信息相关

- axios全局配置

  - axios.defaults.base'Url=""
  - axios.defaults.headers.key="value"
  - axios.defaults.timeout=

- config相关的属性

  | 属性                           | 说明           |
  | ------------------------------ | -------------- |
  | url                            |                |
  | method                         |                |
  | baseUrl                        |                |
  | transformRequest:function(){}  | 请求前数据处理 |
  | transformResponse:function(){} | 请求后数据处理 |
  | headers:{}                     | 请求头         |
  | param:{}                       | 请求参数       |
  | data:{}                        | 请求体         |
  | timeout                        | 超时           |
  | responseType                   | json           |

  

  

05-axios的实例和模块封装

06-axios的拦截器的使用

