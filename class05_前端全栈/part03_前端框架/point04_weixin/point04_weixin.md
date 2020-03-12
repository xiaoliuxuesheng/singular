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
<view wx:for="{{可迭代数据对象}}" wx:for-item="变量名" ws:for-index="索引">
  {{person.id}}:{{person.name}}--{{index}}
</view>
```

## 2.4 条件渲染

```js

```



# 第三章 内置组件

# 第四章 页面生命周期

# 第五章 自定义组件

# 第六章 其他

