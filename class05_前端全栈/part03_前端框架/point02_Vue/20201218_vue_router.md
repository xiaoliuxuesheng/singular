06_路由
    1. 学习内容
        - vue-router 基本使用
        - vue-router 嵌套路由
        - vue-router 参数传递
        - vue-router 导航守卫
        - keep-alive
    2. 路由概述
        - 概述：路由在互联网中用网络把信息从源地址传输到目的地址的过程；
        - 路由表：本质是一个映射表，把源地址映射到目的地址，决定了数据的指向；
        - 后端路由：将路由映射关系定义在服务器后端，前端通过URL请求后端，后端匹配对应的页面并返回；
        - 前后端分离：后端只提供数据，不负责页面渲染，静态资源存储在静态资源服务器中；
        - 前端路由：将路由映射关系定义在前端，页面的跳转通过资源的URL映射到前端的页面；
        - 单页面富应用：（SPA-Simple Page web Application）整个网站只有一个html页面，需要使用前端路由做技术支撑；
    3. hash路由和history路由
        - 改变浏览器中URL但是不会向服务器进行请求，方案有两种：hash和history
        - hash：URL的hash也就是锚点（#），本质上是改window.location的href属性：window.location.hash = '改变的hash路由'
        - html5提供的history：本质是一个栈，浏览器只显示栈顶记录
            - ①window.history.pushStatus({},null,'history路由')：为历史记录栈新增一条记录
            - ②window.history.back()：历史记录栈顶记录弹出，显示上一个记录路由；
            - ②window.history.forward()：显示下一个记录路由；
            - ③window.history.replaceStatus()：替换当前栈顶记录；
            - ④window.history.go(栈位置索引)：索引为整数，向前弹出栈；索引为负数，向后弹出栈；
    4. vue-router
        - 是vue官方的路由插件，他和vue是深度集成的，适合构建单页面应用；
        - 安装路由：npm install --save vue-router
        - 配置路由：
            4.1. 路由分包：统一命令为routers目录，index.js文件表示路由的入口配置文件
            4.2. 在index.js导入路由对象，并配置到Vue对象之上，为Vue新增路由相关属性：Vue.use(VueRouter)
                import VueRouter from 'vue-router'
                import Vue from 'vue'
                Vue.use(VueRouter)
            4.2. 创建路由实例，并定义路由映射配置
                const routers = [
                    {name: 'Category', path: '/category', component: () => import('@/views/Category')}
                ]
                const router = new VueRouter({
                    mode: 'history',
                    routes: routers
                })
                export default router;
            4.3. 在Vue实例之上挂载创建的路由实例
                import router from "@/routers";
                new Vue({
                  router,
                  render: h => h(App),
                }).$mount('#app')
            4.4. 在App.vue中定义路由渲染:Vue.use(VueRouter)作用① 全局添加组件<router-link>和<router-view> ②Vue上添加全局属性$router
                <router-link to="/category">category</router-link>
                <router-view></router-view>
    5. 路由配置
        5.1 路由组件映射:path+component
        5.2 路由重定向：redirect
        5.3 修改路由模式：hash模式:'hash'；history模式：mode:'history'；
        5.3 router-link属性说明:
            - ①to：跳转的路由；
            - ②tag：router-link默认被渲染为a标签，tag标签声明被渲染的标签；
            - ③replace：表示使用history的替换模式；
            - ④：被激活router-link添加router-link-action类，active-class：修改被激活的类名
            - ⑤ 全局修改别激活的router-link的class属性值：new VueRouter({linkActiveClass:"自定义类名"})
        5.3 代码的路由跳转:Vue.use(VueRouter)则为所有组件添加了全局属性,$router表示全局路由对象；$route表示当前活跃的路由
            - this.$router.push("/路由"):向栈顶添加
            - this.$router.replace("/路由"):替换当前栈顶记录；
        5.4 动态路由
            - 设置动态路由：/路由/:key；:key就是动态路由的标志,作为动态值的key
            - 获取路由中的动态值：this.$route.params.key(params是一个对象,key是动态的key)
        5.5 路由的懒加载：{name: 'Category', path: '/category', component: () => import('@/views/Category')} : 作用:项目开发中的代码量非常大,app.js打包文件会非常大,使用懒加载不会将业务代码打包到app.js中,单个路由打包为单个js中,路由被访问的时候才加载对应的js中
        5.6 vue-router打包解析:vue打包程序时候会将css抽离为一个css文件并引入到index.html文件中,将项目中的js文件抽离为三个文件:①app.js是当前应用程序中的业务代码②vendor.js文件提供商的第三方框架的代码③mainifest.js为打包的代码做底层支撑的,比如项目中的导入导出,语法解析等等
        5.7 路由的嵌套使用: ①子路由不需要路径前缀反斜杠②router-link需要指定完整路径③如果有子路由,父路由的name需要删除
            const product = [
                {
                    name: 'Category',
                    path: '/category',
                    component: () => import('@/views/product/Category'),
                    children: [
                        {
                            path: 'pay',
                            component: () => import('@/views/product/order/PayOrder')
                        },
                        {
                            path: 'refund',
                            component: () => import('@/views/product/order/RefundOrder')
                        }
                    ]
                }
            ]
        5.8 参数传递
            - 方式一 : 路由动态参数
            - 方式二 : query类型:?key=value
                <router-link tag="button" :to="{path:'/profile',query:query}">query传递参数</router-link>
                {{$route.query}} = { "name": "张三", "age": "34" }
            - 方式三 : 使用代码进行跳转并带query参数 : this.$router.push({path:'路由',query:{key:value}})
        5.9 $route 和 $router
            - $router : 是在router的index中新建的router对象
            - $route : 是router数组中某个活跃状态的路由
        5.10 导航守卫: 监听路由跳转
            - 全局前置守卫
                router.beforeEach((to, from, next)=>{
                    console.log(to)
                    console.log(from)
                    next()
                })
            - 全局后置钩子
                router.afterEach(((to, from) => {
                    console.log(to)
                    console.log(from)
                }))
            - 路由独享守卫
                const product = [
                    {
                        name: 'Category',
                        path: '/category',
                        component: () => import('@/views/product/Category'),
                        beforeEnter: ((to, from, next)=>{
                            console.log(to)
                            console.log(from)
                            next()
                        })
                    }
                ]
            - 组件内守卫: 将路由监听定义在组件内
        5.11 keep-alive:组件不需要重复渲染,并且缓存之前的组件
            - include：包含需要渲染的路由name值
            - exclude：排除不需要渲染的路由的name值