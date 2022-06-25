# 第一章 React入门

## 1.1 入门

1. 入门案例

   - 创建一个html页面，添加一个根dom并指定一个ID

     ```html
     <div id="test">
     </div>
     ```

   - 在这个根标签下引入React相关的组件

     ```html
     <!-- 加载 React。-->
     <!-- 注意: 部署时，将 "development.js" 替换为 "production.min.js"。-->
     <script src="https://unpkg.com/react@17/umd/react.development.js" crossorigin></script>
     <script src="https://unpkg.com/react-dom@17/umd/react-dom.development.js" crossorigin></script>
     <script src="https://unpkg.com/@babel/standalone/babel.min.js"></script>
     ```

   - 自定义一个React组件

     ```html
     <!-- 加载我们的 React 组件。-->
     <script type="text/babel">
         const ODOM = <h1>Hello React</h1>
         const domContainer = document.querySelector('#test');
         ReactDOM.render(ODOM, domContainer);
     </script>
     ```

2. 不使用JSX创建虚拟DOM

   ```html
   <script type="text/javascript">
     // 创建虚拟DOM
     const ODOM = React.createElement('h1',{id:'title'},'Hello react, 不用JSX')
     const domContainer = document.querySelector('#test');
     ReactDOM.render(ODOM, domContainer);
   </script>
   ```

## 1.2 JSX语法规则

1. 什么是jsx：全程JavaScript XML
   - React定义的一种类型与xml的JS扩展语法：js+xml
   - 本质是React.crateElement方法的语法糖
   - 作用：用来简化创建虚拟DOM
   - 标签名称任意：HTML标签或其他标签
2. jsx语法规则
   - 定义虚拟DOM不需要用引号
   - jsx中如果使用变量需要使用花括号读取变量:{}
   - jsx中DOM的样式名称不是class（是一个关键字），是className
   - jsx的DOM中内联样式是对象格式：`style={{color:'red',size:'29px'}}`
   - jsx中的DOM只能定义在一个根标签中
   - jsx中定义的DOM的标签名称是小写字母会转换为HTML标签，如果转换不了会报错，如果是自定义标签，标签名称是首字母大写，React会渲染对应的组件，如果组件找不到会报错；
3. jsx表达式和jsx语句
   - jsx表达式都有一个返回值，虚拟dom根据返回值组成完整DOM
   - if、for、switch、case这些属于语句，不能定义在jsx表达式中

# 第二章 面向组件

## 2.1 模块化与组件化

1. 模块：是指具有特定功能的JS程序，一般一个JS文件就是一个模块，主要是用于复用，简化JS的编写
2. 组件：是指在浏览器页面具有特定显示区域的部分称为组件，组件化开发，可以复用相同功能的的组件

## 2.2 组件定义

1. 函数式组件：自定义组件是首字母大写

   ```html
   <script type="text/babel">
   	// 自定义组件: 返回一个html，函数中的this是undefined，被bable翻译后this指向不能是window
     function Com() {
       return <h2>这是个函数式组件</h2>
     }
     // 使用组件
     ReactDOM.render(<Com/>,document.getElementById("test"))
   </script>
   ```

   > - 使用组件时候以标签的形式使用，React会根据组件名称调用这个函数

2. 类式组件：

   - 定义类

     ```js
     class Person{
       // 实例属性
       属性名称;
       
       // 构造函数
       constructor(){}
       
       // 实例方法:开启了严格模式
       方法名称(){}
     }
     ```

   - React中类式组件：类组件中this指向是组件实例对象的

     ```jsx
     class MyCom extends React.Component{
       render(){
         return <h2>必须包含render函数</h2>
       }
     }
     
     ReactDOM.render(<MyCom/>,document.getElementById("test"))
     ```

   - 组件三大属性：继承React.Component的组件具有三大属性

     - state：表示 组件状态，有状态的是指复杂组件，反之称为简单组件；组件的状态的作用是驱动页面，意思是组件中的数据是存放在状态中的；①值搜索对象，包含多个key-value的组合②通过更新组件的state来更新对应页面的显示

       ```jsx
       // 绑定事件的原生方式
       el.addEventListener('事件名称'.()=>{})
       el.onclick = ()=>{}
       el onclick=方法名称()
       
       // React绑定事件:推荐在元素上添加方法,需要解决方法上的this的指向问题
       class MyCom extends React.Component{
         constructor(props) {
           super(props);
           this.state = {
             isHot: false
           }
           this.changeWither = this.changeWither.bind(this)
         }
         render(){
           return <h2 onClick={this.changeWither}>静态天气{this.state.isHot?  '炎热' : '凉爽'}</h2>
         }
       
         changeWither(){
           // 错误写法
           this.state.isHot = !this.state.isHot
         }
       }
       // status不可以直接更改,需要使用内置api修改,且更新是合并更新,构造器调用一次,render调用1+n(首次会调用一次)
       changeWither(){
         this.setState({isHot: !this.state.isHot})
       }
       
       // state的简写方式:成员变量status ,箭头函数
       class MyCom extends React.Component{
         state = {
           isHot: false
         }
       
         constructor(props) {
           super(props);
         }
         render(){
           return <h2 onClick={this.changeWither}>静态天气{this.state.isHot?  '炎热' : '凉爽'}</h2>
         }
       
         // 箭头函数没有this,会找其外部调用该方法的this
         changeWither = () =>{
           this.setState({isHot: !this.state.isHot})
         }
       }
       ```

     - props：组件传值，在定义标签的时候在标签上添加到属性会封装到组件对象的props对象中

       ```jsx
       class Person extends React.Component{
         render(){
           return (
                   <ul>
                     <li>姓名: {this.props.name}</li>
                   </ul>
           )
         }
       }
       
       ReactDOM.render(<Person name='tom' />, document.getElementById("test1"))
       ReactDOM.render(<Person name='Jerry' />, document.getElementById("test2"))
       ReactDOM.render(<Person name='Age' />, document.getElementById("test3"))
       ```
     
       > - 使用展开运算符
       >
       >   ```jsx
       >   class Person extends React.Component{
       >     render(){
       >       const {name} = this.props
       >       return (
       >               <div>
       >                 <h1>props封装</h1>
       >                 <ul>
       >                   <li>props: {name}</li>
       >                 </ul>
       >               </div>
       >       )
       >     }
       >   }
       >   const p = {name:"tom"}
       >   // ...运算符不能展开对象, {...对象}表示复制一个对象
       >   ReactDOM.render(<Person {...p}/>, document.getElementById("test"));
       >   ```
       >
       > - 简写方式：
       >
       > - 构造函数和props：①通过给this.state复制对象来初始化内部state②为事件处理函数绑定实例，③如果使用了构造函数，但是没有调用super会出bug④构造器中是否super不传props，则构造器中使用不了poprs
     
     - refs：给自定义组件中的html中定义res属性，React会将这些标签收集到当前组件对象的refs对象中，key是ref的值，value是这个组件的DOM对象
     
       - 字符串形式的ref：后续的字符串的ref是不可用的，字符串ref的效率不高。
     
         ```jsx
             class Test extends React.Component {
                 showData = () => {
                     console.log(this.refs['input1'])
                     let {input1} = this.refs
                     alert(input1.value)
                 }
                 showData2 = () => {
                     let {input2} = this.refs
                     alert(input2.value)
                 }
         
                 render() {
                     return (
                         <div>
                             <input ref="input1" type="text" placeholder="点击按钮提示"/>
                             <button ref="btn" onClick={this.showData}>点击提示</button>
                             <input ref="input2" onBlur={this.showData2} type="text" placeholder="失去焦点提示"/>
                         </div>
                     )
                 }
             }
         
             ReactDOM.render(<Test/>, document.getElementById("test"));
         ```
     
       - 回调形式ref：回调函数默认的一个参数是这个ref所在的节点，在回调函数中把这个参数赋值给组件实例之中，获取回调ref中定义的属性直接从实例上去；这个回调函的调用次数：
     
         ```jsx
           class Test extends React.Component {
             render() {
               return (
                       <div>
                         <input ref={cn => this.input1 = cn} type="text" placeholder="点击按钮提示"/>
                         <button onClick={this.showData}>点击提示</button>
                         <input onBlur={this.showData2} type="text" placeholder="失去焦点提示"/>
                       </div>
               )
             }
             showData = () => {
               let {input1} = this
               alert(input1.value)
             }
           }
           ReactDOM.render(<Test/>, document.getElementById("test"));
         ```
     
     - context：https://www.bilibili.com/video/BV1wy4y1D7JT?p=29
     

# 第三章 React脚手架

# 第四章 React Ajax

# 第五章 react-router

# 第六章 React UI库

# 第七章 Rectx

