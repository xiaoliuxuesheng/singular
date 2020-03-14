# 第一章 小程序概述

## 1.1 介绍

- **JS-SDK**：一整套网页开发工具包，开放了拍摄、录音、语音识别、二维码、地图、支付、分享、卡券等几十个API，解决了移动网页能力不足的问题，通过暴露微信的接口使得 Web 开发者能够拥有更多的能力
- **开发语言**：主要开发语言是 JavaScript，小程序的逻辑层和渲染层是分开的，逻辑层运行在 JSCore 中，并没有一个完整浏览器对象，因而缺少相关的DOM API和BOM API。

## 1.2 开发者工具

- **账号申请**：[小程序注册](https://mp.weixin.qq.com/wxopen/waregister?action=step1)
- **AppID**：相当于小程序平台的一个身份证，后续你会在很多地方要用到 AppID 
- **开发者工具**：[下载开发者工具](https://developers.weixin.qq.com/miniprogram/dev/devtools/download.html)，可以在工具的左侧模拟器界面看到这个小程序的表现，也可以点击预览按钮，通过微信的扫一扫在手机上体验你的第一个小程序。

## 1.3 小程序代码

- **`.json` 后缀的 `JSON` 配置文件**

  - **小程序配置 app.json**：是当前小程序的全局配置，包括了小程序的所有页面路径、界面表现、网络超时时间、底部 tab 等

    ```json
    {
      "pages": [ 				# 
        "pages/index/index",
        "pages/logs/logs"
      ],
      "window": {
        "backgroundTextStyle": "light",
        "navigationBarBackgroundColor": "#ccc",
        "navigationBarTitleText": "panda",
        "navigationBarTextStyle": "black"
      },
      "tabBar": {
        "list": [{
          "pagePath": "pages/index/index",
          "text": "one",
          "iconPath": "resources/icon/d8.png",
          "selectedIconPath": "resources/icon/d8.png"
        },
        {
          "pagePath": "pages/barone/barone",
          "text": "two",
          "iconPath": "resources/icon/d8.png",
          "selectedIconPath": "resources/icon/d8.png"
        }]
      },
      "style": "v2",
      "sitemapLocation": "sitemap.json"
    }
    ```

    > - pages：数组中的第一条默认是首页，在pages中添加页面目录会自动新增目录中的文件
    > - window：值的小程序所有页面的顶部颜色和字体
    > - tabBar：配置表示部标签页，最少需要配置2个tabBar;
    >   - color：统一的颜色
    >   - position：显示位置
    >   - list：表示bar的数量
    >     - pagePath表示要跳转的页面
    >     - text：表示标题
    >     - iconPath：表示未选择图标，必填
    >     - selectedIconPath：表示选中图标，必填

  - **工具配置 project.config.json**：在使用一个工具的时候，都会针对各自喜好做一些个性化配置

  - **页面配置 page.json**：可以独立定义每个页面的一些属性，例如刚刚说的顶部颜色、是否允许下拉刷新等等。

- **`.wxml` 后缀的 `WXML` 模板文件**：`WXML` 充当的就是类似 `HTML` 的角色

- **`.wxss` 后缀的 `WXSS` 样式文件**： `WXSS` 具有 `CSS` 大部分的特性

  - 新增了尺寸单位rpx：换算一些像素单位
  - 全局的样式和局部样式：一个 `app.wxss` 作为全局样式，会作用于当前小程序的所有页面，局部页面样式 `page.wxss` 仅对当前页面生效
  - 此外 `WXSS` 仅支持部分 `CSS` 选择器

- **`.js` 后缀的 `JS` 脚本逻辑文件**：

## 1.4 基本概念说明

- **渲染层和逻辑层**：小程序的运行环境分成渲染层和逻辑层，其中 WXML 模板和 WXSS 样式工作在渲染层，JS 脚本工作在逻辑层。小程序的渲染层和逻辑层分别由2个线程管理：渲染层的界面使用了WebView 进行渲染；逻辑层采用JsCore线程运行JS脚本
- **程序与页面**：微信客户端在打开小程序之前，会把整个小程序的代码包下载到本地。紧接着通过 app.json 的 pages 字段就可以知道你当前小程序的所有页面路径；通过小程序底层的一些机制，就可以渲染出这个首页
- **组件**：小程序提供了丰富的基础组件给开发者，开发者可以像搭积木一样，组合各种组件拼合成自己的小程序。就像 HTML 的 div, p 等标签一样，在小程序里边，你只需要在 WXML 写上对应的组件标签名字就可以把该组件显示在界面上
- **API**：让开发者可以很方便的调起微信提供的能力

## 1.5 结构目录

![1583995195379](./imgs/1583995195379.png)

# 第二章 模板语法

标签介绍

```html
<text>	--> span	行内
<view>	--> div		块级
<checkbook>	input.checkbox		复选框
<block>		占位符的标签,写代码的时候可以看到标签存在,渲染后标签移除	
```

## 2.1 数据绑定

<font size=4 color=blue>★ 普通格式</font>

1. 在js脚本中的数据区定义数据

   ```js
   Page({
     data: {
       "msg":"hello 微信"
     },
   })
   ```

2. 在模板页面引用数据区数据

   ```html
   {{msg}}
   ```

   > - 可以获取对象中的属性
   >
   > - 可以定义在标签的属性中，字符串可以引用符号中间不可以添加空格

<font size=4 color=blue>★ 属性绑定</font>

1. 在模板文件中定义标签的属性中引用属性

   ```html
   
   ```

   

## 2.2 运算

<font size=4 color=blue>★ 普通运算</font>

```js
{{1=1}}
```

<font size=4 color=blue>★ 字符拼接</font>

```js
{{a+b}}
```

<font size=4 color=blue>★ 三元运算</font>

```js
{{逻辑表达式?true:false}}
```

## 2.3 列表渲染

```js
<view wx:for="{{list}}" wx:for-item="person" ws:for-index="index" wx:key="id">
  {{person.id}}:{{person.name}}--{{index}}
</view>
```

> - for表示需要遍历的列表对象
> - key表示遍历没一条后标识这条数据唯一的一个值,需要指定提高性能

## 2.4 条件渲染

1. wx:if - wx:elif - wx:else：if条件渲染会直接改变标签来判断显示隐藏，性能比较差

   ```html
   <view>
     <view wx:if="{{show}}">条件渲染</view>
     <view wx:elif="{{show}}">elif</view>
     <view wx:else>else</view>
   </view>
   ```

2. 使用hidden隐藏：通过修改样式实现显示隐藏

   ```html
   <view hidden="{{show}}">hidden</view>
   ```

   > hidden属性不能和display属性一起设置

## 2.5 小程序事件绑定

> - 小程序事件,通过bind关键字来实现，如：bindinpu、bindchange
> - 不同的组件支持不同的事件，查看具体组件即可

1. 在模板页面的标签中绑定事件并指定时间名称

   ```html
   <input type="text" bindinput="handleInput"/>	
   
   <button bindtap="handletap" data-param="{{1}}">+</button>
   <button bindtap="handletap" data-param="{{-1}}">-</button>
   ```

   > - 不能在事件绑定中传递参数
   > - 通过自定义属性的方式传递参数，再在事件源中获取该元素的自定义属性

2. 在脚本文件中定义事件，事件定义和data是同级

   ```js
   Page({
     data: {
       "num":0
     },
     // 定义事件函数
     handleInput(e){
       this.setData({
         num: e.detail.value
       })
     }
   })
   ```

   > - 不能直接使用this.data.属性进行赋值，需要使用this.setData({}}中重新定义data中的属性值

## 2.6 样式

<font size=4 color=blue>★ 尺寸单位</font>

- rpx：可以根据屏幕宽度进行自适应，

  > 如：IPhone6规定屏幕宽度为750rpx，屏幕宽度为375px，共有750个物理像素，则750prx = 375px = 750物理像素（1rpx = 0.5px = 1物理像素）

- 使用步骤：建议微信小程序开发设计可以用IPhone6作为视觉稿的标准

  1. 确定设计稿中元素的宽度：已知大小的一个像素值

  2. 计算比例：设计固定宽度是750rpx

     - 页面的宽度page = 750rpx

     - 则可以计算出一个像素的prx：1px = 750rpx / page

     - 根据1px的rpx可以得到具体的像素值，在小程序的样式文件中使用公式

       ```css
       width:calc(750prx * 元素宽度 / 屏幕宽度像素值)
       ```

<font size=4 color=blue>★ 样式导入</font>

> - 小程序中支持样式导入，也可以支持less中的导入混用
> - 使用@import语句可以导入外联样式，只支持相对路径

- 微信小程序样式定义

  ```css
  .small-p{
  	padding:5px;
  }
  ```

- 导入外部样式

  ```css
  @import 'common.wxss';
  .small-p{
  	padding:5px;
  }
  ```

<font size=4 color=blue>★ 选择器</font>

> 小程序不支持通配符选择器

- 小程序支持的选择器

  | 选择器       | 示例              | 描述                     |
  | ------------ | ----------------- | ------------------------ |
  | .class       | .info             | 选择class=info的所有元素 |
  | \#id         | \#id              | 选择id职位id的元素       |
  | element      | view              | 选择所有的view元素       |
  | e1,e2        | 并集选择器        | 选择e1和e2类型的元素     |
  | nth-child(n) | view:nth-child(2) | 子元素序选择器           |
  | ::after      | view::after       | 在元素后面插入内容       |
  | ::before     | view::before      | 在元素前面插入内容       |

<font size=4 color=blue>★ 使用less</font>

- 原生小程序不支持less，其他基于小程序的框架大部分都支持，为了引入一个less而引入一个框架不显示

- 使用less的方式

  1. 使用编辑器vscode

  2. 安装easy less插件

  3. 在vscode中设置中加入如下配置

     ```json
     "less.compile":{
         "outExt":".wxss"
     }
     ```

  4. 在要编写样式的地方，新建less文件，正常编辑即可

# 第三章 内置组件snipaste

## 3.1 视图容器

view：代替div标签

- hover-class：按下时候自动添加的样式类
- hover-stop-propagation：指定私服阻止本节点的祖先节点出现点击状态

text：文本标签，只能嵌套text，只有改标签长按文字可以复制

- selectable属性：添加改属性才可以长按复制
- decode属性：是否解码

image：图片标签，默认宽度是320px，高度240px

- src：图片资源地址

- mode：图片裁剪模式

  | 模式名称 | 说明 |
  | -------- | ---- |
  |          |      |

- lazy-load：图片懒加载，默认是false

swiper：微信内置轮播图组件，要配置swiper-item完成轮播效果

- swiper是轮播外层容器，每个轮播项的swiper-item，在swiper-item中添加图片组件
- 默认宽度是100%，默认高度是150px，需要根据原图的高度和高度，
- 属性：autoplay - 自动轮播
- 属性：interval - 轮播时间
- 属性：circular - 循环轮播
- 属性：indicator-dots - 显示轮播指示点
- 属性：indicator-color - 指示点颜色
- 属性：indicator-active-color - 当前选中的指示点颜色

navigate：导航组件，类似超链接，是一个块级元素

- target：在哪个目标上发生跳转
- url：当前小程序内的跳转链接
- open-type：跳转方式
  - navigate：保留当前页面，跳转到应用内的某个页面
  - redirect：关闭当前页面，跳转到应用内的某个页面
  - switchTab：跳转到tabBar页面，并关闭其他非tabBar页面
  - reLaunch：关闭所有页面
  - navigateBack：关闭当前页面，返回到上级页面数
  - exit：退出小程序

rich-text：富文本标签，可以将字符串继续成对应的标签

- nodes接受标签字符串或接受对象数组，对象需要知道标签名，与标签属性、或子节点

button：按钮标签

1. 外观属性
   - size：大小 - default mini
   - type：控制按钮颜色：default灰色  primary-绿色 warn - 红色
   - plain：是否镂空
   - disabled：是否禁用
   - loading：加载图片

2. 内置API ：open-type
   - contact：打开客服会话
   - share：触发用户分享
   - getPhoneNumber：获取用户手机号
   - getUserInfo：获取用户信息
   - launchApp：打开App
   - openSetting：打开设置
   - feedback： 打开已经反馈

icon：内置封装的小图标

- type：类型
- size：大小
- color：颜色

radio：单选框，要和父元素redio-group组合使用

checkbook：复选框，要和父元素checkbox-group组合使用

## 3.2 基础内容

## 3.3 表单组件

## 3.4 导航

## 3.5 媒体组件

## 3.6 地图

## 3.7 画布

# 第四章 自定义组件



# 第五章 页面生命周期

# 第六章 其他

