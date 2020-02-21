**display  显示模式**

**color 文字颜色**

**font 字体**

> *font-weight  文字粗细*
>
> *font-size  字体大小*
>
> *font-style 文字样式*
>
> *font-family  文字字体*

**text-align  文本对齐** 

**text-decoration  文本装饰** 

**text-indent  文本缩进**

**line-height  行高**

**overflow  超出模式**

**background 背景属性**

> *background-color 背景颜色*
>
> *background-image  背景图片*
>
> *background-position  背景定位*
>
> *background-repeat  背景平铺*
>
> *background-attachment  背景关联*

**background-size  背景图片大小**


background-blend-mode

background-clip

background-origin



**visibility  显示隐藏**

**height  高**

**width  宽**

**border  边框**

> border-style
>
> border-color
>
> border-width

**border-radius  边框圆角**

> border-bottom-left-radius
>
> border-bottom-right-radius
>
> border-top-left-radius
>
> border-top-right-radius

border-top

> border-top-color
>
> border-top-style
>
> border-top-width

border-bottom

> border-bottom-color
>
> border-bottom-style
>
> border-bottom-width

border-left

> border-left-color
>
> border-left-style
>
> border-left-width

border-right

> border-right-color
>
> border-right-style
>
> border-right-width

**padding  内边距**

> padding-bottom
>
> padding-left
>
> padding-right
>
> padding-top

**margin  外边距**

> margin-bottom
>
> margin-left
>
> margin-right
>
> margin-top

**box-sizing**



float

clear



left

right

top

bottom



border-image
border-image-outset
border-image-repeat
border-image-slice
border-image-source
border-image-width

border-collapse
border-spacing



align-content
align-items
align-self
all
animation
animation-delay
animation-direction
animation-duration
animation-fill-mode
animation-iteration-count
animation-name
animation-play-state
animation-timing-function
appearance
backface-visibility




box-align
box-direction
box-flex
box-flex-group
box-lines
box-ordinal-group
box-orient
box-pack
box-shadow

caption-side

clip

column-count
column-fill
column-gap
column-rule
column-rule-color
column-rule-style
column-rule-width
column-span
column-width
columns
content
counter-increment
counter-reset
cursor
direction

empty-cells
filter
flex
flex-basis
flex-direction
flex-flow
flex-grow
flex-shrink
flex-wrap

@font-face

font-size-adjust

font-stretch

font-variant

grid-columns

grid-rows

hanging-punctuation

icon

justify-content

@keyframes



letter-spacing



list-style

list-style-image

list-style-position

list-style-type

max-height

max-width

@media
min-height
min-width
nav-down
nav-index
nav-left
nav-right
nav-up
opacity
order
outline
outline-color
outline-offset
outline-style
outline-width



page-break-after
page-break-before
page-break-inside
perspective
perspective-origin
position
punctuation-trim
quotes
resize

rotation
tab-size
table-layout
target
target-name
target-new
target-position

text-justify
text-outline
text-overflow
text-shadow
text-transform
text-wrap

transform
transform-origin
transform-style
transition
transition-delay
transition-duration
transition-property
transition-timing-function
unicode-bidi
vertical-align

white-space

word-break
word-spacing
word-wrap
z-index
writing-mode



*text-align-last  实用性太低*

*overflow-x*

*overflow-y*

<del>text-decoration-color</del>
<del>text-decoration-line</del>
<del>text-decoration-style</del>

# ---------------------------

## CSS

## CSS概述

## CSS属性

### 文字属性

- **作用** : 字体属性**定义字体**，**加粗**，**大小**，**文字样式**。

- **文字相关属性**

  | 属性                      | 说明                                                         |
  | ------------------------- | ------------------------------------------------------------ |
  | font-style: 样式值;       | 设置文字样式<br />    - **normal** : 正常显示的文本<br />    - **italic** : 以斜体字显示的文字<br />    - **oblique** : 文字向一边倾斜 |
  | font-weight: 粗细值       | 设置文本的粗细<br />    - **normal** : 默认值。定义标准的字符<br />    - **bold** : 定义粗体字符。<br />    - **bolder** : 定义更粗的字符。<br />    - **lighter** : 定义更细的字符。<br />    - **100-900** : 400 等同于 normal，而 700 等同于 bold |
  | font-size: 文字大小值     | 设置字体大小<br />    - **px** : 设置为一个固定像素的值<br />    - **%** : 基于父元素的一个百分比值<br />    - **smaller** : 为比父元素更小的尺寸<br />    - **larger** : 比父元素更大的尺寸。<br />    - **inherit** 从父元素继承字体尺寸<br />    - **xx-small - x-small - small - medium - large - x-large - xx-large** |
  | font - family: 字体值     | 指定一个元素的字体<br />    - 组合字体, 中文会适配英文字体, 英文字体不会适配中文字体<br />    - 前面的字体适配后, 后面的字体则会无效 |
  | font: 样式 粗细 大小 字体 | 简写属性在一个声明中设置所有字体属性<br />    - **size + family 没有默认值** : 这两个属性必须设置<br />    - **size + family** 先设置文字大小, 再设置文字的字体,顺序不能乱 |

### 文本属性

- **作用** : 用于设置文本的显示格式

- **文本相关属性**

  | 属性                    | 说明                                                         |
  | ----------------------- | ------------------------------------------------------------ |
  | text-align:对齐属性值   | 设置文本的水平对齐方式<br />    - **left** : 缺省的显示方式<br />    - **right** : 右对齐<br />    - **center** : 居中对齐<br />    - **justify** : 每一行被展开为宽度相等，左，右外边距是对齐 |
  | text-decoration: 装饰   | 规定添加到文本的修饰<br />    - **none** : 默认。定义标准的文本。<br />    - **underline** : 定义文本下的一条线<br />    - **overline** : 定义文本上的一条线。<br />    - **line-through** : 定义穿过文本下的一条线 |
  | text-indent: 文本缩进   | 规定文本块中首行文本的缩进<br />    - **px** : 定义固定的缩进<br />    - ***%*** : 基于父元素宽度的百分比的缩进<br />    - **em** : 缩进指定个字体宽度 |
  | text-transform:大小写值 | 指定在一个文本中的大写和小写字母<br />    - **uppercase** : 变成大写字母 <br />    - **lowercase** : 变成小写字母<br />    - **capitalize**  : 每个单词的首字母大写 |

### 颜色属性

- **作用 :**  设置文字的颜色

- **颜色取值说明**

  | 属性         | 说明                                                         |
  | ------------ | ------------------------------------------------------------ |
  | color:颜色值 | - 表示颜色的单词<br />   - 三原色取值 : **rgb(0-255)**<br />   - 透明度的三原色 : **rgba(0-255,0-1)**<br />   - 十六进制颜色表示 : **#十六进制的三原色值**<br />   - 十六进制颜色简写 : **#十六进制的三原色简写** |

### 背景属性

- **作用 : ** 给标签添加背景

- **背景相关属性说明**

  | 属性                            | 说明                                                         |
  | ------------------------------- | ------------------------------------------------------------ |
  | background-image: url("路径")   | 设置一个元素的背景图像<br />    - 放置在元素的左上角，并重复垂直和水平方向 |
  | background-repeat:平铺          | 设置如何平铺对象的被背景图<br />    - **repeat** : 将向垂直和水平方向重复。这是默认<br />    - **repeat-x** : 只有水平位置会重复背景图像<br />    - **repeat-y** : 只有垂直位置会重复背景图像<br />    - **no-repeat** : background-image不会重复 |
  | background-position:X位置 Y位置 | 属性设置背景图像的起始位置(第一个值是水平，第二个值是)<br>    - **left & right** 水平方式的左对齐和右对齐<br />    - **top & bottom** 垂直方向的顶对齐和底对齐<br />    - ***x% y%*** :  百分比形式设置位置<br />    - ***xpos ypos***  : 像素形式设置位置 |
  | background-color:颜色           | 颜色取值格式与文字颜色取值方式相同                           |
  | background-attachment:关联方式  | 背景图与浏览器的滚动条的关联方式<br />    - **scroll** 背景图片随页面的其余部分滚动。这是默认<br />    - **fixed** 背景图像是固定的<br />    - **local** 背景图片随滚动元素滚动 |
  | background-size:宽 高           | 指定背景图片大小<br />    - **像素** : 不指定宽或高的默认为auto<br />    - **百分比** 不指定宽或高的默认为auto<br />    - **cover** 将图像缩放成将完全覆盖背景定位区域的最小大小<br>    - **contain** 将图像缩放成将适合背景定位区域的最大大小 |
  | background : 背景属性           | 背景属性简写, 可以设置的属性分别是：<br />    - **background-color**<br />    - **background-position** <br />    - **background-size** <br />    - **background-repeat** <br />    - **background-origin** <br />    - **background-clip** <br />    - **background-attachment** <br />    - **background-image** |

* **精灵图** : 利用背景图属性和背景定位属性可以完成精灵图的设置
  * 在浏览器中的的坐标系**原点** : 左上角 (0,0)
  * 在浏览器中的的坐标系**X轴** : 从原点水平向右为正方向
  * 在浏览器中的的坐标系**Y轴** : 从原点垂直向下为正方向

### 显示模式

- 设置标签的显示特点

## CSS选择器

### 基本选择器

- id
- class
- 标签

### 组合选择器

- 后代
- 子代
- 交集
- 并集
- 兄弟
- 通用兄弟

### 序选择器

- 同级别
- 同类型

### 属性选择器

### 通配符选择器

## CSS三大特性

- 层叠性
- 继承性
- 

## HTML

### 前端开发基础

#### 浏览器的认识

#### HTTP协议

#### URL的格式

### HTML基础

#### HTML概述与发展

#### HTML基本结构



## CSS

# 第二章 HTML基础
## 2.1 HTMl概述
## 2.2 HTML发展历程
## 2.3 HTML基本结构的认识
- `<!DOCTYPE>` 	定义文档类型。
- `<html>`	定义 HTML 文档。
- `<head>`	定义关于文档的信息。
- `<title>`	定义文档的标题。
- `<body>`	定义文档的主体。
- `<meta>`	定义关于 HTML 文档的元信息。
- `<link>`	定义文档与外部资源的关系。
- `<base>`	定义页面中所有链接的默认地址或默认目标。
## 2.4 HTML标签分类
### 1. 根据标签数量
### 2. 根据标签的

# 第三章 HTML标签及常用属性
## 3.1 基础
- `<!--...-->`	定义注释。
- `<h1>` to `<h6>`	定义 HTML 标题。
- `<p>`	定义段落。
- `<br>`	定义简单的折行。
- `<hr>`	定义水平线。
- `<a>`	 
- `<nav>`	定义导航链接。

## 3.2 格式标签
- `<acronym>`	定义只取首字母的缩写。
- `<abbr>`	定义缩写。

- `<address>`	定义文档作者或拥有者的联系信息。
- `<bdi>`	定义文本的文本方向，使其脱离其周围文本的方向设置。
- `<bdo>`	定义文字方向。
- `<big>`	定义大号文本。
- `<blockquote>`	定义长的引用。
- `<cite>`	定义引用(citation)。
- `<code>`	定义计算机代码文本。
- `<dfn>`	定义定义项目。
- `<ins>`	定义被插入文本。
- `<kbd>`	定义键盘文本。
- `<mark>`	定义有记号的文本。
- `<meter>`	定义预定义范围内的度量。
- `<pre>`	定义预格式文本。
- `<progress>`	定义任何类型的任务的进度。
- `<q>`	定义短的引用。
- `<rp>`	定义若浏览器不支持 ruby 元素显示的内容。
- `<rt>`	定义 ruby 注释的解释。
- `<ruby>`	定义 ruby 注释。
- `<samp>`	定义计算机代码样本。
- `<small>`	定义小号文本。
- `<strong>`	定义语气更为强烈的强调文本。
- `<sup>`	定义上标文本。
- `<sub>`	定义下标文本。
- `<time>`	定义日期/时间。
- `<tt>`	定义打字机文本。
- `<var>`	定义文本的变量部分。
- `<wbr>`	定义可能的换行符。

## 3.3 表单标签
- `<form>`	定义供用户输入的 HTML 表单。
- `<input>`	定义输入控件。
- `<textarea>`	定义多行的文本输入控件。
- `<button>`	定义按钮。
- `<select>`	> `<option>`定义选择列表（下拉列表）。
- `<optgroup>`	定义选择列表中相关选项的组合。
- `<label>`	定义 input 元素的标注。
- `<fieldset>`	定义围绕表单中元素的边框。
- `<legend>`	定义 fieldset 元素的标题。
- `<datalist>`	定义下拉列表。
- `<keygen>`	定义生成密钥。
- `<output>`	定义输出的一些类型。


## 3.5 框架
- `<frame>`	定义框架集的窗口或框架。
- `<frameset>`	定义框架集。
- `<noframes>`	定义针对不支持框架的用户的替代内容。
- `<iframe>`	定义内联框架。

## 3.6 图像
- `<img>`	定义图像。
- `<map>`	定义图像映射。
- `<area>`	定义图像地图内部的区域。
- `<canvas>`	定义图形。
- `<figcaption>`	定义 figure 元素的标题。
- `<figure>`	定义媒介内容的分组，以及它们的标题。
## 3.7 音频/视频
- `<audio>`	定义声音内容。
- `<source>`	定义媒介源。
- `<track>`	定义用在媒体播放器中的文本轨道。
- `<video>`	定义视频。
## 3.9 列表
- `<ul>`	定义无序列表。
- `<ol>`	定义有序列表。
- `<li>`	定义列表的项目。
- `<dl>`	定义定义列表。
- `<dt>`	定义定义列表中的项目。
- `<dd>`	定义定义列表中项目的描述。
- `<menu>`	定义命令的菜单/列表。
- `<menuitem>`	定义用户可以从弹出菜单调用的命令/菜单项目。
- `<command>`	定义命令按钮。
## 3.10 表格
- `<table>`	定义表格
- `<caption>`	定义表格标题。
- `<th>`	定义表格中的表头单元格。
- `<tr>`	定义表格中的行。
- `<td>`	定义表格中的单元。
- `<thead>`	定义表格中的表头内容。
- `<tbody>`	定义表格中的主体内容。
- `<tfoot>`	定义表格中的表注内容（脚注）。
- `<col>`	定义表格中一个或多个列的属性值。
- `<colgroup>`	定义表格中供格式化的列组。
## 3.11 样式/节
- `<style>`	定义文档的样式信息。
- `<div>`	定义文档中的节。
- `<span>`	定义文档中的节。
- `<header>`	定义 section 或 page 的页眉。
- `<footer>`	定义 section 或 page 的页脚。
- `<section>`	定义 section。
- `<article>`	定义文章。
- `<aside>`	定义页面内容之外的内容。
- `<details>`	定义元素的细节。
- `<dialog>`	定义对话框或窗口。
- `<summary>`	为 `<details>` 元素定义可见的标题。
## 3.13 编程
- `<script>`	定义客户端脚本。
- `<noscript>`	定义针对不支持客户端脚本的用户的替代内容。
- `<embed>`	为外部应用程序（非 HTML）定义容器。
- `<object>`	定义嵌入的对象。
- `<param>`	定义对象的参数。



## 3.14 废弃标签
- `<i>`	不赞成使用。定义斜体字。
- `<em>`	不赞成使用。定义强调文本。
- `<b>`	不赞成使用。定义粗体字。
- `<strong>`	不赞成使用。定义强调文本。
- `<del>`	不赞成使用。定义被删除文本。
- `<applet>`	不赞成使用。定义嵌入的 applet。
- `<basefont>`	不赞成使用。定义页面中文本的默认字体、颜色或尺寸。
- `<center>`	不赞成使用。定义居中文本。
- `<dir>`	不赞成使用。定义目录列表。
- `<font>`	不赞成使用。定义文字的字体、尺寸和颜色。
- `<isindex>`	不赞成使用。定义与文档相关的可搜索索引。
- `<s>`	不赞成使用。定义加删除线的文本
- `<strike>`	不赞成使用。定义加删除线文本。
- `<u>`	不赞成使用。定义下划线文本。
- `<xmp>`	不赞成使用。定义预格式文本。

# 第三章 Html属性

| 属性                                                         | 描述                                                   |
| :----------------------------------------------------------- | :----------------------------------------------------- |
| [accesskey](https://www.w3school.com.cn/tags/att_standard_accesskey.asp) | 规定激活元素的快捷键。                                 |
| [class](https://www.w3school.com.cn/tags/att_standard_class.asp) | 规定元素的一个或多个类名（引用样式表中的类）。         |
| [contenteditable](https://www.w3school.com.cn/tags/att_global_contenteditable.asp) | 规定元素内容是否可编辑。                               |
| [contextmenu](https://www.w3school.com.cn/tags/att_global_contextmenu.asp) | 规定元素的上下文菜单。上下文菜单在用户点击元素时显示。 |
| [data-*](https://www.w3school.com.cn/tags/att_global_data.asp) | 用于存储页面或应用程序的私有定制数据。                 |
| [dir](https://www.w3school.com.cn/tags/att_standard_dir.asp) | 规定元素中内容的文本方向。                             |
| [draggable](https://www.w3school.com.cn/tags/att_global_draggable.asp) | 规定元素是否可拖动。                                   |
| [dropzone](https://www.w3school.com.cn/tags/att_global_dropzone.asp) | 规定在拖动被拖动数据时是否进行复制、移动或链接。       |
| [hidden](https://www.w3school.com.cn/tags/att_global_hidden.asp) | 规定元素仍未或不再相关。                               |
| [id](https://www.w3school.com.cn/tags/att_standard_id.asp)   | 规定元素的唯一 id。                                    |
| [lang](https://www.w3school.com.cn/tags/att_standard_lang.asp) | 规定元素内容的语言。                                   |
| [spellcheck](https://www.w3school.com.cn/tags/att_global_spellcheck.asp) | 规定是否对元素进行拼写和语法检查。                     |
| [style](https://www.w3school.com.cn/tags/att_standard_style.asp) | 规定元素的行内 CSS 样式。                              |
| [tabindex](https://www.w3school.com.cn/tags/att_standard_tabindex.asp) | 规定元素的 tab 键次序。                                |
| [title](https://www.w3school.com.cn/tags/att_standard_title.asp) | 规定有关元素的额外信息。                               |
| [translate](https://www.w3school.com.cn/tags/att_global_translate.asp) | 规定是否应该翻译元素内容。                             |

# 第四章 Html事件
## 4.1 Window 事件属性

| 属性                                                         | 值     | 描述                                             |
| :----------------------------------------------------------- | :----- | :----------------------------------------------- |
| [onafterprint](https://www.w3school.com.cn/tags/event_onafterprint.asp) | script | 文档打印之后运行的脚本。                         |
| [onbeforeprint](https://www.w3school.com.cn/tags/event_onbeforeprint.asp) | script | 文档打印之前运行的脚本。                         |
| onbeforeunload                                               | script | 文档卸载之前运行的脚本。                         |
| onerror                                                      | script | 在错误发生时运行的脚本。                         |
| onhaschange                                                  | script | 当文档已改变时运行的脚本。                       |
| [onload](https://www.w3school.com.cn/tags/event_onload.asp)  | script | 页面结束加载之后触发。                           |
| onmessage                                                    | script | 在消息被触发时运行的脚本。                       |
| onoffline                                                    | script | 当文档离线时运行的脚本。                         |
| ononline                                                     | script | 当文档上线时运行的脚本。                         |
| onpagehide                                                   | script | 当窗口隐藏时运行的脚本。                         |
| onpageshow                                                   | script | 当窗口成为可见时运行的脚本。                     |
| onpopstate                                                   | script | 当窗口历史记录改变时运行的脚本。                 |
| onredo                                                       | script | 当文档执行撤销（redo）时运行的脚本。             |
| [onresize](https://www.w3school.com.cn/tags/event_onresize.asp) | script | 当浏览器窗口被调整大小时触发。                   |
| onstorage                                                    | script | 在 Web Storage 区域更新后运行的脚本。            |
| onundo                                                       | script | 在文档执行 undo 时运行的脚本。                   |
| [onunload](https://www.w3school.com.cn/tags/event_onunload.asp) | script | 一旦页面已下载时触发（或者浏览器窗口已被关闭）。 |

## 4.2 Form 事件

| 属性                                                         | 值     | 描述                                             |
| :----------------------------------------------------------- | :----- | :----------------------------------------------- |
| [onblur](https://www.w3school.com.cn/tags/event_onblur.asp)  | script | 元素失去焦点时运行的脚本。                       |
| [onchange](https://www.w3school.com.cn/tags/event_onchange.asp) | script | 在元素值被改变时运行的脚本。                     |
| oncontextmenu                                                | script | 当上下文菜单被触发时运行的脚本。                 |
| [onfocus](https://www.w3school.com.cn/tags/event_onfocus.asp) | script | 当元素获得焦点时运行的脚本。                     |
| onformchange                                                 | script | 在表单改变时运行的脚本。                         |
| onforminput                                                  | script | 当表单获得用户输入时运行的脚本。                 |
| oninput                                                      | script | 当元素获得用户输入时运行的脚本。                 |
| oninvalid                                                    | script | 当元素无效时运行的脚本。                         |
| onreset                                                      | script | 当表单中的重置按钮被点击时触发。HTML5 中不支持。 |
| [onselect](https://www.w3school.com.cn/tags/event_onselect.asp) | script | 在元素中文本被选中后触发。                       |
| [onsubmit](https://www.w3school.com.cn/tags/event_onsubmit.asp) | script | 在提交表单时触发。                               |

## 4.2 Keyboard 事件

| 属性                                                         | 值     | 描述                   |
| :----------------------------------------------------------- | :----- | :--------------------- |
| [onkeydown](https://www.w3school.com.cn/tags/event_onkeydown.asp) | script | 在用户按下按键时触发。 |
| [onkeypress](https://www.w3school.com.cn/tags/event_onkeypress.asp) | script | 在用户敲击按钮时触发。 |
| [onkeyup](https://www.w3school.com.cn/tags/event_onkeyup.asp) | script | 当用户释放按键时触发。 |

## 4.3 Mouse 事件

| 属性                                                         | 值     | 描述                                           |
| :----------------------------------------------------------- | :----- | :--------------------------------------------- |
| [onclick](https://www.w3school.com.cn/tags/event_onclick.asp) | script | 元素上发生鼠标点击时触发。                     |
| [ondblclick](https://www.w3school.com.cn/tags/event_ondblclick.asp) | script | 元素上发生鼠标双击时触发。                     |
| ondrag                                                       | script | 元素被拖动时运行的脚本。                       |
| ondragend                                                    | script | 在拖动操作末端运行的脚本。                     |
| ondragenter                                                  | script | 当元素元素已被拖动到有效拖放区域时运行的脚本。 |
| ondragleave                                                  | script | 当元素离开有效拖放目标时运行的脚本。           |
| ondragover                                                   | script | 当元素在有效拖放目标上正在被拖动时运行的脚本。 |
| ondragstart                                                  | script | 在拖动操作开端运行的脚本。                     |
| ondrop                                                       | script | 当被拖元素正在被拖放时运行的脚本。             |
| [onmousedown](https://www.w3school.com.cn/tags/event_onmousedown.asp) | script | 当元素上按下鼠标按钮时触发。                   |
| [onmousemove](https://www.w3school.com.cn/tags/event_onmousemove.asp) | script | 当鼠标指针移动到元素上时触发。                 |
| [onmouseout](https://www.w3school.com.cn/tags/event_onmouseout.asp) | script | 当鼠标指针移出元素时触发。                     |
| [onmouseover](https://www.w3school.com.cn/tags/event_onmouseover.asp) | script | 当鼠标指针移动到元素上时触发。                 |
| [onmouseup](https://www.w3school.com.cn/tags/event_onmouseup.asp) | script | 当在元素上释放鼠标按钮时触发。                 |
| onmousewheel                                                 | script | 当鼠标滚轮正在被滚动时运行的脚本。             |
| onscroll                                                     | script | 当元素滚动条被滚动时运行的脚本。               |

## 4.4 Media 事件

| 属性               | 值     | 描述                                                         |
| :----------------- | :----- | :----------------------------------------------------------- |
| onabort            | script | 在退出时运行的脚本。                                         |
| oncanplay          | script | 当文件就绪可以开始播放时运行的脚本（缓冲已足够开始时）。     |
| oncanplaythrough   | script | 当媒介能够无需因缓冲而停止即可播放至结尾时运行的脚本。       |
| ondurationchange   | script | 当媒介长度改变时运行的脚本。                                 |
| onemptied          | script | 当发生故障并且文件突然不可用时运行的脚本（比如连接意外断开时）。 |
| onended            | script | 当媒介已到达结尾时运行的脚本（可发送类似“感谢观看”之类的消息）。 |
| onerror            | script | 当在文件加载期间发生错误时运行的脚本。                       |
| onloadeddata       | script | 当媒介数据已加载时运行的脚本。                               |
| onloadedmetadata   | script | 当元数据（比如分辨率和时长）被加载时运行的脚本。             |
| onloadstart        | script | 在文件开始加载且未实际加载任何数据前运行的脚本。             |
| onpause            | script | 当媒介被用户或程序暂停时运行的脚本。                         |
| onplay             | script | 当媒介已就绪可以开始播放时运行的脚本。                       |
| onplaying          | script | 当媒介已开始播放时运行的脚本。                               |
| onprogress         | script | 当浏览器正在获取媒介数据时运行的脚本。                       |
| onratechange       | script | 每当回放速率改变时运行的脚本（比如当用户切换到慢动作或快进模式）。 |
| onreadystatechange | script | 每当就绪状态改变时运行的脚本（就绪状态监测媒介数据的状态）。 |
| onseeked           | script | 当 seeking 属性设置为 false（指示定位已结束）时运行的脚本。  |
| onseeking          | script | 当 seeking 属性设置为 true（指示定位是活动的）时运行的脚本。 |
| onstalled          | script | 在浏览器不论何种原因未能取回媒介数据时运行的脚本。           |
| onsuspend          | script | 在媒介数据完全加载之前不论何种原因终止取回媒介数据时运行的脚本。 |
| ontimeupdate       | script | 当播放位置改变时（比如当用户快进到媒介中一个不同的位置时）运行的脚本。 |
| onvolumechange     | script | 每当音量改变时（包括将音量设置为静音）时运行的脚本。         |
| onwaiting          | script | 当媒介已停止播放但打算继续播放时（比如当媒介暂停已缓冲更多数据）运行脚本 |

## 4.5 移动端事件

| 属性        | 描述                                           |
| ----------- | ---------------------------------------------- |
| touchstart  | 当手指触摸屏幕的时候出发                       |
| touchmove   | 当手指在屏幕移动的时候                         |
| touchend    | 手指离开屏幕的时候触发                         |
| touchcancel | 当被迫中止滑动的时候触发（弹消息，来电等等）； |

# 第五章 HTTP消息

## 5.1 1xx: 信息
## 5.2 2xx: 成功
## 5.3 3xx: 重定向
## 5.4 4xx: 客户端错误
## 5.5 5xx: 服务器错误
# 第六章 HTTP方法
## 6.1 GET 方法
- 查询字符串（名称/值对）是在 GET 请求的 URL 中发送的
- GET 请求可被缓存
- GET 请求保留在浏览器历史记录中
- GET 请求可被收藏为书签
- GET 请求不应在处理敏感数据时使用
- GET 请求有长度限制
- GET 请求只应当用于取回数据

## 6.2 POST 方法
- 查询字符串（名称/值对）是在 POST 请求的 HTTP 消息主体中发送
- POST 请求不会被缓存
- POST 请求不会保留在浏览器历史记录中
- POST 不能被收藏为书签
- POST 请求对数据长度没有要求

## 6.3 PUT	
- 上传指定的 URI 表示。
## 6.4 DELETE	
- 删除指定资源。
## 6.5 OPTIONS	
- 返回服务器支持的 HTTP 方法。
## 6.6 CONNECT	
 把请求连接转换到透明的 TCP/IP 通道。
## 6.7 HEAD	
- 与 GET 相同，但只返回 HTTP 报头，不返回文档主体。

