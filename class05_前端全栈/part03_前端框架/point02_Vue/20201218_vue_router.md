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
			1. 导入路由对象，并配置到Vue对象之上，为Vue新增路由相关属性：Vue.use(VueRouter)
				import VueRouter from 'vue-router'
				import Vue from 'vue'
				Vue.use(VueRouter)
			2. 创建路由实例，并定义路由映射配置
				const router = new VueRouter({
					routes: [
						{ path: '/index', component: import ('../views/index') }
					],
				});
				export default router;
			3. 在Vue实例之上挂载创建的路由实例