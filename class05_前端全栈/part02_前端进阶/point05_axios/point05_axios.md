# 前言

1. http相关
   
   - http请求基本过程：客户端（请求体）发送到服务器返回响应（响应体），浏览器拿到响应后处理数据：①浏览器显示响应体、②拿到响应回调得到响应后处理
   
   - 请求头结构：请求行、请求头、请求体
   
   - 响应头结构：响应行、响应头、响应体（JSON、二进制图片）

2. 常见响应码
   
   | 状态码 | 描述                 | 说明              |
   | --- | ------------------ | --------------- |
   | 200 | ok                 | 请求成功            |
   | 201 | Created            | 已创建，成功请求并创建新的资源 |
   | 401 | Unauthorized       | 未授权             |
   | 404 | Not Found          |                 |
   | 500 | Inner Server Error | 服务器内部请求         |

3. 请求方式与参数
   
   | 请求方式   | 说明           | 作用  |
   | ------ | ------------ | --- |
   | GET    | 从服务器读取数据     | 查   |
   | POST   | 向服务器添加数据     | 增   |
   | PUT    | 更新服务器中已存在的数据 | 改   |
   | DELETE | 删除数据         | 删   |

4. 请求参数
   
   | 请求参数   | 备注                                                                                                                                     |
   | ------ | -------------------------------------------------------------------------------------------------------------------------------------- |
   | query  | 1、参数包含在请求地址中：/user?age=18<br/>2、敏感参数不能使用query参数<br/>3、query参数又称为查询字符串参数，编码方式为urlencoded                                                |
   | params | 1、参数包含在请求地址中，是URL的一部分：/user/18<br/>2、敏感参数不能使用query参数                                                                                   |
   | body   | 1、参数包含在请求体中<br/>2、格式一：urlEncoded，对应请求头Content-Type=application/x-www-form-urlencoded<br/>3、格式二：json，对应请求头Content-Type=application/json |

5. Api分类
   
   - RestFul风格：请求方式：GET、POST、DELET、PUT
   
   - 非RestFul风格：请求方式只有GET和POST

6. json-server
   
   - 安装依赖包
     
     ```shell
     npm install -g json-server
     ```
   
   - 在指定目录新建json-server的db文件
     
     ```json
     {
         "student":{
             "id":2,
             "name": "姓名"
         }
     }
     ```
   
   - 启动json-server：文件不存在会新，启动可以访问接口
     
     ```shell
     json-server db.json
     ```

7. ajax请求：
   
   - 浏览器发送请求：只有XHR或fetch发出去的才是ajax请求

# 第一章 axios基础

## 1.1 概述

- axios是Promise对XMLHttpRequest的封装
- 基于promise的异步ajax请求库

## 1.2 XHR

## 1.3 Promise

# 第二章 axios使用

## 2.1 axios的安装

1. 基于CDN引入axios
   
   ```html
   <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
   ```

2. 基于npm安装axios
   
   ```shell
   npm install axios
   # 在模块中引入axios
   import axios from 'axios'
   ```

## 2.2 axios API

### 1. Axios入门

- 使用CDN的方式引入Axios，测试axios<!DOCTYPE html>
  
  ```html
  <!DOCTYPE html>
  <html lang="en">
  <head>
      <meta charset="UTF-8">
      <title>Title</title>
      <script src="https://unpkg.com/axios/dist/axios.min.js"></script>
  </head>
  <body>
  <button id="btn1">按钮1</button>
  <script>
      const bnt1 = document.getElementById("btn1")
      bnt1.onclick = () => {
          const result = axios({
              url: "http://127.0.0.1:4523/m1/468313-0-default/pet/1",
              method: "GET"
          })
          result.then(response => {
              console.log("成功:", response)
              console.log("成功.data:", response.data)
          }, error => {
              console.log("失败:",error)
          })
      }
  </script>
  </body>
  </html>
  ```

- 打开浏览器，发送请求，查看axios的响应
  
  ```json
  {
      "statusText":"ok",
      "status":200,
      "config":{},
      "headers":{},
      "request":{},
      "data":{}
  }
  ```

- 发送精简版
  
  ```js
      const bnt2 = document.getElementById("btn2")
      bnt2.onclick = async () => {
          const result = await axios({
              url: "http://127.0.0.1:4523/m1/468313-0-default/pet/1",
              method: "GET"
          })
          console.log(result)
          console.log(result.data)
      }
  ```

- 

### axios 基本API

| API                               | 说明  |
| --------------------------------- | --- |
| axios(config)                     |     |
| axios.request(config)             |     |
| axios.get(url[, config])          |     |
| axios.delete(url[, config])       |     |
| axios.post(url[, data[, config]]) |     |
| axios.put(url[, data[, config]])  |     |
| axios.all(iterable)               |     |

### 2. axios实例

- 创建axios实例：axios.creat([config])；例如：
  
  ```js
  var instance = axios.create({
    baseURL: 'https://some-domain.com/api/',
    timeout: 1000,
    headers: {'X-Custom-Header': 'foobar'}
  });
  ```

- 实例的配置项说明
  
  ```json
  {
      // 如果url不是绝对路径，那么会将baseURL和url拼接作为请求的接口地址
      // 用来区分不同环境，建议使用
      baseURL: 'https://some-domain.com/api/',
      // `url` 是请求的接口地址
      url: '/user',
      // `method` 是请求的方法
      method: 'get', // 默认值
  ```

      // 用于请求之前对请求数据进行操作
      // 只用当请求方法为‘PUT’，‘POST’和‘PATCH’时可用
      // 最后一个函数需return出相应数据
      // 可以修改headers
      transformRequest: [function (data, headers) {
          // 可以对data做任何操作
    
          return data;
      }],
    
      // 用于对相应数据进行处理
      // 它会通过then或者catch
      transformResponse: [function (data) {
          // 可以对data做任何操作
    
          return data;
      }],
    
      // `headers` are custom headers to be sent
      headers: {'X-Requested-With': 'XMLHttpRequest'},
    
      // URL参数
      // 必须是一个纯对象或者 URL参数对象
      params: {
          ID: 12345
      },
    
      // 是一个可选的函数负责序列化`params`
      // (e.g. https://www.npmjs.com/package/qs, http://api.jquery.com/jquery.param/)
      paramsSerializer: function(params) {
          return Qs.stringify(params, {arrayFormat: 'brackets'})
      },
    
      // 请求体数据
      // 只有当请求方法为'PUT', 'POST',和'PATCH'时可用
      // 当没有设置`transformRequest`时，必须是以下几种格式
      // - string, plain object, ArrayBuffer, ArrayBufferView, URLSearchParams
      // - Browser only: FormData, File, Blob
      // - Node only: Stream, Buffer
      data: {
          firstName: 'Fred'
      },
    
      // 请求超时时间（毫秒）
      timeout: 1000,
    
      // 是否携带cookie信息
      withCredentials: false, // default
    
      // 统一处理request让测试更加容易
      // 返回一个promise并提供一个可用的response
      // 其实我并不知道这个是干嘛的！！！！
      // (see lib/adapters/README.md).
      adapter: function (config) {
          /* ... */
      },
    
      // `auth` indicates that HTTP Basic auth should be used, and supplies credentials.
      // This will set an `Authorization` header, overwriting any existing
      // `Authorization` custom headers you have set using `headers`.
      auth: {
          username: 'janedoe',
          password: 's00pers3cret'
      },
    
      // 响应格式
      // 可选项 'arraybuffer', 'blob', 'document', 'json', 'text', 'stream'
      responseType: 'json', // 默认值是json
    
      // `xsrfCookieName` is the name of the cookie to use as a value for xsrf token
      xsrfCookieName: 'XSRF-TOKEN', // default
    
      // `xsrfHeaderName` is the name of the http header that carries the xsrf token value
      xsrfHeaderName: 'X-XSRF-TOKEN', // default
    
      // 处理上传进度事件
      onUploadProgress: function (progressEvent) {
          // Do whatever you want with the native progress event
      },
    
      // 处理下载进度事件
      onDownloadProgress: function (progressEvent) {
          // Do whatever you want with the native progress event
      },
    
      // 设置http响应内容的最大长度
      maxContentLength: 2000,
    
      // 定义可获得的http响应状态码
      // return true、设置为null或者undefined，promise将resolved,否则将rejected
      validateStatus: function (status) {
          return status >= 200 && status < 300; // default
      },
    
      // `maxRedirects` defines the maximum number of redirects to follow in node.js.
      // If set to 0, no redirects will be followed.
      // 最大重定向次数？没用过不清楚
      maxRedirects: 5, // default
    
      // `httpAgent` and `httpsAgent` define a custom agent to be used when performing http
      // and https requests, respectively, in node.js. This allows options to be added like
      // `keepAlive` that are not enabled by default.
      httpAgent: new http.Agent({ keepAlive: true }),
      httpsAgent: new https.Agent({ keepAlive: true }),
    
      // 'proxy' defines the hostname and port of the proxy server
      // Use `false` to disable proxies, ignoring environment variables.
      // `auth` indicates that HTTP Basic auth should be used to connect to the proxy, and
      // supplies credentials.
      // This will set an `Proxy-Authorization` header, overwriting any existing
      // `Proxy-Authorization` custom headers you have set using `headers`.
      // 代理
      proxy: {
          host: '127.0.0.1',
          port: 9000,
          auth: {
              username: 'mikeymike',
              password: 'rapunz3l'
          }
      },
    
      // `cancelToken` specifies a cancel token that can be used to cancel the request
      // (see Cancellation section below for details)
      // 用于取消请求？又是一个不知道怎么用的配置项
      cancelToken: new CancelToken(function (cancel) {
      })

  }

```
- response响应说明

```json
{
  // 服务端返回的数据
  data: {},

  // 服务端返回的状态码
  status: 200,

  // 服务端返回的状态信息
  statusText: 'OK',

  // 响应头
  // 所有的响应头名称都是小写
  headers: {},

  // axios请求配置
  config: {},

  // 请求
  request: {}
}    
```

## 2.2 axios拦截器

1. 请求拦截器
   
   ```js
   axios.interceptors.request.use(function (config) {
       // Do something before request is sent
       return config;
     }, function (error) {
       // Do something with request error
       return Promise.reject(error);
     });
   ```

2. 响应兰姐姐去
   
   ```js
   axios.interceptors.response.use(function (response) {
       // Do something with response data
       return response;
     }, function (error) {
       // Do something with response error
       return Promise.reject(error);
     });
   ```

3. 移除拦截器
   
   ```js
   var myInterceptor = axios.interceptors.request.use(function () {/*...*/});
   axios.interceptors.request.eject(myInterceptor);
   ```

4. 为axios添加拦截器
   
   ```json
   var instance = axios.create();
   instance.interceptors.request.use(function () {/*...*/});
   ```