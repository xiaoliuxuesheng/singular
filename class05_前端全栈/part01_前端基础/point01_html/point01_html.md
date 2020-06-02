# 前言 

1. 自学练习经典网站
   - [百度](https://www.baidu.com/)
   - [简书](https://www.jianshu.com/)
   - [腾讯新闻](https://news.qq.com/)
   - [优酷TV](https://tv.youku.com/)
   - [小米官网](https://www.mi.com/)
   - [京东首页](https://www.jd.com/)
   - [考拉海购](https://www.kaola.com/)
2. 前端学习体系
   - React + Native：可以开发IOS、Android、移动端
   - Weex + Vue：可以开发IOS、Android、移动端
   - Flutter（Dart语言）：可以开发IOS、Android、移动端、PC端

# 第一章 HTML基础

## 1.1 HTML概述

​		HTML称为超文本标记语言，是一种标识性的语言。它包括一系列标签，通过这些标签可以将网络上的文档格式统一，使分散的Internet资源连接为一个逻辑整体。

​		HTML文本是由HTML命令组成的描述性文本，HTML命令可以说明文字，图形、动画、声音、表格、链接等。

## 1.2 HTML的发展

## 1.3 浏览器引擎

| 引擎    | 内核       | 常见浏览器                               |
| ------- | ---------- | ---------------------------------------- |
| Blink   | Chrome     | Chrome、360极速浏览器、360安全浏览器     |
|         | Chromium   | QQ浏览器、搜狗高速浏览器、Opera          |
| Gecko   | Firefox    | Firefox（火狐浏览器）                    |
| Webkit  | Safari     | Safari、Android 默认浏览器               |
|         | U3（国产） | UC浏览器                                 |
| Trident | Edge       | Microsoft Edge                           |
|         | IE 内核    | IE6 - IE11、360极速浏览器、360安全浏览器 |

## 1.4 HTML标签的分类

1. 根据标签的个数
   - 单标签
   - 双标签：开始标签和结束标签
2. 根据标签的嵌套关系
   - 祖先标签
   - 父标签
   - 兄弟标签
   - 子标签
   - 后代标签
3. 根据标签的页面占位
   - 块标签：标签元素独占一行
   - 行内标签：标签元素不会独占一行，并且不可以设置高和宽
   - 行内块标签：标签元素不会独占一行，但是可以为其指定高和宽

## 1.5 标签的属性

1. id：为标签指定唯一标识，一个html文档标签的id属性值不能重复
2. class：根据class属性值的名称将标签分类
3. title：为标签指定标题属性值

## 1.5 HTML标准结构

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>
    
</body>
</html>
```

- lang="en"：可以删除，如果不删除的，用谷歌之类打开，它会认为是英文的，会提示翻译，可以改成zh-cn表示中文网站，就不会提示翻译了；

- charset="UTF-8"：设置文档编码为UTF-8；

- meta：`name`属性主要是用于描述网页的，对应`content`属性中的内容是便于搜索引擎查找和分类信息。主要作用有：1、搜索引擎（SEO）优化；2、定义页面使用语言；3、自动刷新页面；4、控制页面缓存；5、网页定级评价；6、控制页面显示的窗口；等等...；标准格式如下和案例说明：

  ```html
  <meta name="" content="" />
  ```

  | name              | content             | 说明                                                         |
  | ----------------- | ------------------- | ------------------------------------------------------------ |
  | **keywords**      |                     | 它是用来设置，让搜索引擎获取网页的关键字                     |
  | **description**   |                     | 设置让搜索引擎获取网页的内容描述(浏览器中标题下的描述)       |
  | **robots**        |                     | 设置让搜索引擎哪些页面需要索引，哪些页面不需要索引           |
  |                   | all                 | 文件将被检索，且页面上的链接可以被查询                       |
  |                   | none                | 文件将不被检索，且页面上的链接不可以被查询                   |
  |                   | index               | 文件将被检索                                                 |
  |                   | noindex             | 文件将不被检索，但页面上的链接可以被查询                     |
  |                   | follow              | 页面上的链接可以被查询                                       |
  |                   | nofollow            | 文件将被检索，但页面上的链接不可以被查询                     |
  | **author**        |                     | 设置页面的作者                                               |
  | **generator**     |                     | 设置网站采用什么软件制作的                                   |
  | **COPYRIGHT**     |                     | 设置网站的版权信息的                                         |
  | **revisit-after** | 30day               | 设置网站的重访，30day代表30天                                |
  | **viewport**      |                     | 它是来控制浏览器窗口的大小和缩放的,影响布局                  |
  | **http-equiv**    |                     | 相当于 HTTP 的文件头的设置                                   |
  |                   | Page-Enter          | 设定进入页面时的特殊效果                                     |
  |                   | Page-Exit           | 设定离开页面时的特殊效果                                     |
  |                   | expires             | 它是来设置网页的过期时间的                                   |
  |                   | Pragma              | 设置禁止浏览器从本地缓存中访问页面                           |
  |                   | Refresh             | 它是来设置自动刷新并跳转新页面，<br />其中content第一个数字代表 5 秒后自动刷新 |
  |                   | Set-Cookie          | 设置 Cookie                                                  |
  |                   | Window-target       | 强制页面在当前窗口以独立页面显示                             |
  |                   | content-Type        | 设置页面使用的字符集                                         |
  |                   | Content-Language    | 设置页面的语言                                               |
  |                   | Cache-Control       | 设置页面缓存                                                 |
  |                   | Content-Script-Type | 设置页面中脚本的类型                                         |

  - 使用案例

  ```html
  <!-- 基本格式 -->
  <meta name="" content="" />
  
  
  <!-- 使用案例 -->
  <meta name="keywords" content="活动,聚会，拓展，团建，培训，讲座" />
  
  <meta name="description" content="百场汇是中国最大的会议活动和工作场地短租平台，..." />
  
  <meta name="robots" content="all" />
  
  <meta name="author" content="jay" />
  
  <meta name="generator" content="hobbit" />
  
  <meta name="COPYRIGHT" content="百场汇" />
  
  <meta name="revisit-after" content="30day" />
  
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1" />
  
  <meta http-equiv="Page-Enter" contect="revealTrans(duration=1.0,transtion=12)">   
  <meta http-equiv="Page-Exit" contect="revealTrans(duration=1.0,transtion=12)">
  <!--
  	★ Duration的值为网页动态过渡的时间，单位为秒
  	★ Transition是过渡方式，它的值为0到23，分别对应24种过渡方式
  		0    盒状收缩     		1    盒状放射   		2    圆形收缩    
  		3    圆形放射   		4    由下往上    		5    由上往下  
  		6    从左至右    		7    从右至左  			8    垂直百叶窗    
  		9    水平百叶窗		   10   水平格状百叶窗    	 11    垂直格状百叶窗  
  		12    随意溶解    		13	从左右两端向中间展开  14	  从中间向左右两端展开    
  		15	 从上下两端向中间展开  	16	从中间向上下两端展开  17    从右上角向左下角展开  
  		18    从右下角向左上角展开    19    从左上角向右下角展开  
  		20    从左下角向右上角展开    21    水平线状展开  
  		22    垂直线状展开    	   23    随机产生一种过渡方式   
  -->
  
  <meta http-equiv="expires" content="Fri May 13 2016 22:49:44 GMT+0800 (CST)" />
  
  <meta http-equiv="Pragma" content="no-cache" />
  
  <meta http-equiv="Refresh" content="5;URL=http://m.baichanghui.com" />
  
  <meta http-equiv="Set-Cookie" content="cookie value=xxx;expires=Friday,12-Jan-200118:18:18GMT；path=/" />
  
  <meta http-equiv="Window-target" content="top" />
  
  <meta http-equiv="content-Type" content="text/html;charset=gb2312" />
  
  <meta http-equiv="Content-Language" content="zh-cn" />
  
  <meta http-equiv="Cache-Control" content="no-cache" />
  
  <meta http-equiv="Content-Script-Type" content="text/javascript" />
  ```


# 第二章 基础标签

## 2.1 HTML元信息标签

| 标签名称     | 标签说明                                                     |
| ------------ | ------------------------------------------------------------ |
| `<!DOCTYPE>` | 定义文档类型                                                 |
| `<html>`     | 定义了整个 HTML 文档                                         |
| `<head>`     | 头部标签是所有头部元素的容器：可以引用脚本、指示样式表、提供元信息等等。 |
| `<meta>`     | 有关页面的元信息：如针对搜索引擎和更新频度的描述和关键词     |
| `<title>`    | 页面标题                                                     |
| `<link>`     | 引入外部css样式                                              |
| `<script>`   | 用于定义客户端脚本                                           |
| `<style>`    | 用于为 HTML 文档定义样式信息。                               |
| `<body>`     | 包含文档的所有内容                                           |

## 2.2 HTML基础标签

| 标签名称 | 标签说明           |
| -------- | ------------------ |
| `<div>`  | 无语义块级标签     |
| `<span>` | 无语义行内标签     |
| `<p>`    | 段落标签：块级标签 |
| `<a>`    | 超链接：行内标签   |

## 2.3 布局标签

| 标签名称 | 标签说明 |
| -------- | -------- |
| ``       |          |
| ``       |          |
| ``       |          |
| ``       |          |

# 第三章 列表标签

## 3.1 有序列表

```html
<ol>
    <li></li>
    ... ...
    <li></li>
</ol>
```

## 3.2 无序列表

```html
<ul>
    <li></li>
    ... ...
    <li></li>
</ul>
```

## 3.3 自定义列表

```html

```

# 第四章 表格标签

## 4.1 标签完整结构

```html
<table width="100%" 
       height="193" 
       border="1" 
       cellpadding="0" 
       cellspacing="0" 
       bordercolor="#000000" 
       bgcolor="#FFFFFF"
       background="#FFFFFF">
    <thead>
        <tr>
            <th>标题</th>
            <th>标题</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td colspan="2">合并横向单元格</td>
        </tr>
        <tr>
            <td></td>
            <td rowspan="2">合并纵向单元格</td>
        </tr>
        <tr>
            <td></td>
        </tr>
    </tbody>
    <tfoot>
        <tr>
            <td>tfoot</td>
            <td>tfoot</td>
        </tr>
    </tfoot>
</table>
```

## 4.2 表格属性说明

| 属性名 | 作用 |
| ------ | ---- |
|        |      |

# 第五章 表单标签

## 5.1 form

## 5.2 input

## 5.3 button

# 第六章 多媒体标签

## 6.1 audio

## 6.2 video

## 6.3 process

## 6.4 meter