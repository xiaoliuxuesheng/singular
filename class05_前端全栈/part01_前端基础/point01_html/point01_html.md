1. 环境搭建
2. html
3. css
4. js基础
5. js高级
6. 移动端开发
7. 前端框架
8. node
9. 工程化

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
   
3. 前端环境搭建

   - 右击桌面我的电脑 | 高级系统设置 | 高级 > 设置 > 视觉效果 > 调整为最佳性能
   - 文件夹设置：①列表显示②显示隐藏文件③显示文件扩展名
   - 任务栏设置为小图标

4. Windows系统快捷键

   | 快捷键     | 说明                 |
   | ---------- | -------------------- |
   | Win + D    | 显示桌面             |
   | Win + E    | 打开资源管理器       |
   | Win + R    | 运行                 |
   | Win + L    | 锁定桌面             |
   | Win + 数字 | 打开任务栏对应的程序 |

5. VSCode的使用

   | 辅助插件               | 说明           |
   | ---------------------- | -------------- |
   | Chinese (Simplified)   | 中文工具包     |
   | vscode-icons           | 文件图标       |
   | Bracket Pair Colorizer | 彩虹括号       |
   | Highlight Matching Tag | 标签匹配       |
   | **开发插件**           | **说明**       |
   | View In Browser        | 在浏览器打开   |
   | Live Server            | 临时服务器     |
   | Python                 | python语法提示 |
   | Go                     | GoLang语法     |
   | Path Autocomplete      | 文件路径提示   |
   |                        |                |
   | GitLens                | Git代码提示    |

6. WEB相关概念

   - 浏览器引擎

     | 引擎    | 内核       | 常见浏览器                               |
     | ------- | ---------- | ---------------------------------------- |
     | Blink   | Chrome     | Chrome、360极速浏览器、360安全浏览器     |
     |         | Chromium   | QQ浏览器、搜狗高速浏览器、Opera          |
     | Gecko   | Firefox    | Firefox（火狐浏览器）                    |
     | Webkit  | Safari     | Safari、Android 默认浏览器               |
     |         | U3（国产） | UC浏览器                                 |
     | Trident | Edge       | Microsoft Edge                           |
     |         | IE 内核    | IE6 - IE11、360极速浏览器、360安全浏览器 |

   - http请求与服务器

7. 网页的基本组成

   - 页面的结构：html
   - 页面的样式：css
   - 页面的行为：JavaScript

# 第一章 HTML基础

## 1.1 HTML概述

​		HTML称为超文本标记语言，是一种标识性的语言。它包括一系列标签，通过这些标签可以将网络上的文档格式统一，使分散的Internet资源连接为一个逻辑整体。

​		HTML文本是由HTML命令组成的描述性文本，HTML命令可以说明文字，图形、动画、声音、表格、链接等。

## 1.2 HTML的发展

- **h5**
  - h5不是新增的语言，是html语言第五次重大修改版本
  - 所有主流浏览器引擎都支持h5
  - 改变了用户与文档的交互方式：新增多媒体标签（audio、vodio、canvas）
  - 新增其他特性：语义特性、本地存储、网页多媒体、二维三维、动画特效

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
<html>
<head>
    <meta charset="UTF-8">
    <title>Document</title>
</head>
<body>
    
</body>
</html>
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

### 1.`<!DOCTYPE>`

- 位于文档最前面，向浏览器说明当前文档使用的HTML标准规范，默认为html表示为html5的文档规范，

### 2.  `<html>`

- 标签限定了文档的开始点和结束点，在它们之间是文档的头部和主体；属性**lang**：规定元素内容的语言。

### 3. `<head> + <title>`

### 4. `<meta>`

- 提供有关页面的元信息（meta-information），`name`属性是元信息的标识，对应`content`属性指对应元信息标识的内容；

- 基本格式

  ```html
  <meta name="" content="" />
  ```

- 元信息标识说明

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
  |                   | Refresh             | 它是来设置自动刷新并跳转新页面， 其中content第一个数字代表 5 秒后自动刷新 |
  |                   | Set-Cookie          | 设置 Cookie                                                  |
  |                   | Window-target       | 强制页面在当前窗口以独立页面显示                             |
  |                   | content-Type        | 设置页面使用的字符集                                         |
  |                   | Content-Language    | 设置页面的语言                                               |
  |                   | Cache-Control       | 设置页面缓存                                                 |
  |                   | Content-Script-Type | 设置页面中脚本的类型                                         |

- meta标签使用案例

  ```html
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
  		0    盒状收缩     			1    盒状放射   		2    圆形收缩    
  		3    圆形放射   			4    由下往上    		5    由上往下  
  		6    从左至右    			7    从右至左  			8    垂直百叶窗    
  		9    水平百叶窗			   10   水平格状百叶窗    	 11    垂直格状百叶窗  
  		12    随意溶解    			13	从左右两端向中间展开  14	  从中间向左右两端展开    
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

### 3. `<body>`

### 4. `<style>`

### 5. `<script>`

## 2.2 HTML基础标签

| 标签名称    | 标签说明           |
| ----------- | ------------------ |
| `<h1>~<h6>` | 标题标签           |
| `<div>`     | 无语义块级标签     |
| `<span>`    | 无语义行内标签     |
| `<p>`       | 段落标签：块级标签 |
| `<a>`       | 超链接：行内标签`  |
| `<br>`      | 换行符             |
| `<hr>`      | 分隔符             |
| `<!-- -->`  | 注释标签           |

## 2.3 html5语义标签

| 标签名称  | 标签说明                         |
| --------- | -------------------------------- |
| `nav`     | 表示导航                         |
| `header`  | 表示页眉：可以定义在每个模块中   |
| `footer`  | 表示页脚：可以定义在每个模块中   |
| `main`    | 文档主要内容，每个模块都可以定义 |
| `article` | 文章                             |
| `aside`   | 主题之外的内容                   |

- **语义标签的兼容处理**：

  - 方式一：IE浏览器不支持html5语义标签，需要手动创建标签添加到文档模型中，添加的标签默认是行内元素，需要手动转换标签的显示样式。

    ```html
    <script>
    	document.createElement("语义标签")
    </script>
    ```

  - 方式二：引入第三方插件（html5shiv.js）

# 第三章 列表标签

## 3.1 有序列表

```html
<ol>
    <li></li>
    ... ...
    <li></li>
</ol>
```

> ol：order lilst 表示有顺序的列表
>
> li：list item 表示列表项

## 3.2 无序列表

```html
<ul>
    <li></li>
    ... ...
    <li></li>
</ul>
```

> - ul：unorder list 表示无序的列表

## 3.3 自定义列表

```html
<dl>
    <dt></dt>
    <dd></dd>
    ... ...
</dl>
```

> - dl：definition list 表示定义的列表
> - dt：definition list title 表示定义列表中的标题
> - dd：definition list data 表示定义列表的数据项

# 第四章 表格标签

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

# 第五章 表单标签

## 5.1 form

## 5.2 input

## 5.3 button



## 5.4 process

1. **进度条（process）**：用于显示某个特定任务的时间进度这个任务的时间上限是可以确定的值，如播放一段音乐的时间；或者是不可确定的值，如上传一个文件到服务器上；max表示进度条的最大值，value表是进度条的当前进度值；

   ```html
   <progress max="100" value="30"></progress>
   ```

2. **使用说明**：在2020年的建议是这个标签仅供娱乐，慎用；不同的浏览器有不同的样式，而且样式还特别难看；兼容性还不好，Android、iOS、浏览器中使用不统一；

## 5.5 meter

1. **度量器（meter）**：与process类型，不同之处在于，它的最小值和最大值必须是确定的

   ```html
   <meter max="100" high="80" low="20" value="10" ></meter>
   <meter max="100" high="80" low="20" value="25" ></meter>
   <meter max="100" high="80" low="20" value="70" ></meter>
   <meter max="100" high="80" low="20" value="85" ></meter>
   <meter max="100" high="80" low="20" value="100" ></meter>
   ```

2. **使用说明**：**同上**；再重复一遍：在2020年的建议是这个标签仅供娱乐，慎用；不同的浏览器有不同的样式，而且样式还特别难看；兼容性还不好，Android、iOS、浏览器中使用不统一；

# 第六章 多媒体标签

## 6.1 audio



## 6.2 video

1. 