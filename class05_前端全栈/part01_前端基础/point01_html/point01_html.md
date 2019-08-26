# 001 浏览器 和 服务器

▲ 浏览器以及常用浏览器

▲ 服务器

# 002 浏览器访问网页原理

▲ 浏览器访问网页原理

# 003 浏览器请求数据过程

▲ 请求与相应

# 004 URL格式

▲ http:// 域名:端口/路径

# 005 HTTP协议



# 007 html

▲ 概述:超文本标记语言, 用于添加语义

# 008 HTML发展史

# 009 HTML基本结构

- html
  - head
    - title
  - body

# 010 基本结构详解

- html 声明网页的结构范围
- head 网页的配置信息
- title 网页标题
- body 网页显示的主体

# 011 字符集

- mete 
  - charset=UTF-8

# 012 标签分类

- 按标签个数
  - 单标签 & 双标签
- 层级关系 并列
  - 父标签 & 子标签 & 兄弟标签

# 013 文档声明

- !DOCTYPE html

# 015 html xhtml html5

- html 语言宽松  容错性强
- xhtml 要求非常严格
- html5  容错性强 新特性支持

# 016 webstom 安装

# 017 h p hr

- h系列标签 : 独占一行 的标题系列标签
  - h1 ~ h6
- p : 独占一行的段落标签
- hr : 与父元素等宽的分割线

# ★ 018 练习

# 019 注释

- 格式 : 

  ```html
  <!--  注释  -->
  ```

# 020 img

- img 图片标签
  - src = "" : 图片的路径
  - title = "" : 鼠标悬浮提示
  - alt="" : 错误地址提示
  - width 宽度
  - height : 高度

# 021 br

- br : 不另起一行换行

# 022 023 路径

- 绝对路径
- 相对路径

# 024 a

- a : 超链接

  - href 链接地址

  - target 是否跳转

    > - _self : 当前选项卡
    > - _blank : 在空白选项卡

  - title

# 025 base

- base : 设置整个网页a标签的跳转方式
  - target

# 026 假链接

- 格式一 : href="#"   会自动回到网页顶部
- 格式二 : href = "javascript"   不会回到网页顶部

# 027 锚点

- 锚点 : 跳到当前页面的指定位置
  - 步骤一  给 目标位置的标签添加id属性并且给指定的值
  - 步骤二 : 告诉a标签的href的假链接后添加id值

> 没有过渡动画的

# 029 无序列表 030 032

- ul > li

# 033 有序列表

- ol > li

# 035 定义列表

- dl
  - dt
  - dd
  - ... ...

# 036 表格标签

- table 表格
  - tr  表格中的一行
    - td  行中的单元格

# 037 表格的属性

- 宽度 和 高度
  - table & td
- 水平对齐
  - table  & tr & td
- 垂直对齐
  - tr & td

- 外边距 和 内边距
  - table

# 038 细线表格

- table 背景色改为黑色
- tr 背景色改为白色

# 039 表格的其他标签

- table > caption : 给表格添加标题属性

# 040 表格的完整结构

# 041 单元格合并 042 

# 043 表单标签

- 表单标签 : form 

  > action 表单提交地址

- input : 表单标签

  - text
  - password
  - button
  - submit
  - reset
  - checkbook  + name
  - radio  + name
  - hidden

# 044 lable

- lable > input 

# 055 datalist

- 步骤一 定义数据 : datalist > option

- 定义输入框 绑定待选项 : list = datalist的id

# 056 标签标签新特性

- number
- email
- url
- search
- date
- color

# 057 其他表单标签

- select > optgroup > option
- textarea

# 050 多媒体标签

- video
- audio
- marquee
- 废弃标签
- 字符实体