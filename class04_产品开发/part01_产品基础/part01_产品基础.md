# 前言

# 第一章 入门 

## 1.1 课程大纲

<img src="https://z3.ax1x.com/2021/03/27/6x7OsS.png" alt="6x7OsS.png" border="0" />

## 1.2 行业分类

### 2. 互联网行业概述

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>产业互联网是在传统产业基础之上，使用互联网的技术和生态对传统产业内部的价值链和产业链进行重塑和改造，从而形成的互联网产业生态和形态；产业的职责就是保持自己的发展轨道合理利用互联网形成互联网产业。

# 第二章 需求管理

- 功能清单

  | 项目 | 模块 | 功能 | 描述 | 优先级 | 进度 | 备注 |
  | ---- | ---- | ---- | ---- | ------ | ---- | ---- |
  |      |      |      |      |        |      |      |

- 需求池

  | 提出时间 | 提出人 | 需求来源 | 需求类型 | 产品模块 | 需求描述 | 优先级 | 状态 | 备注 |
  | -------- | ------ | -------- | -------- | -------- | -------- | ------ | ---- | ---- |
  |          |        |          |          |          |          |        |      |      |

# 第三章 项目规划



# 第四章 产品设计

## 5.1 常见的原型图绘制工具

1. Axure功能比较强大，做中低保真完全没问题，不过学习难度也是真的大
2. Mockplus基础功能免费，几乎没有学习门槛，如果想要练手，我比较推荐这个工具。Mockplus的功能也比较多，有许多预设组件和图标，支持多人协作，演示也很方便，分享链接或二维码，在电脑端、手机端都能查看，如果担心不安全，也可以重置链接。
3. Sketch也是一款免费工具，上手相对来说比较简单，原型图相关的功能没有Axure和Mockplus那么丰富，更适合做高保真设计。另外Sketch只能在Mac使用。

## 5.2 Axure界面

### :anchor: 菜单栏 

> 主要包含文件、编辑、视图、项目、布局、发布、团队、账户、帮助几个菜单。

### :anchor: 功能区

1. 基本工具栏：控制工具列表显示
2. 样式工具栏：样式工具栏主要是对元件样式的管理

### :anchor: 功能面板

1. 页面面板：显示当前RP文件的所有页面，同时管理RP文件页面的增删改查；

2. 概要面板：显示当前操作页面的所有元件管理，可以控制某个、某些、全部元件是否在概要面板中展示。

3. 样式：样式面板包含元件样式、页面样式。

   - **元件样式：**名称、位置、尺寸、是否显示、颜色、字体、字号、边框、对齐、填充、透明度、阴影等样式控制，不同元件的样式稍有差别；

   - **页面样式：**页面尺寸、页面排列、页面背景填充。

4. 说明：说明面板主要是用于管理元件的注释，目前仅支持文本注释，可对注释内容进行富文本编辑。

5. 元件库：自带默认元件、流程元件、Icon元件，同时可通过元件面板管理外部元件库。

6. 母版：可以理解为公共元件模板，将母版应用到相应页面中后，母版内容或样式发生变化，那么引用母版的页面内容或样式同样会跟着变化，常用于制作页面头部或底部内容。

   - 母版面板主要用于管理母版元件的增删改查。

7. 交互：交互面板包含页面交互、元件交互，其中元件交互又分为事件交互、样式交互。

   - **页面交互：**页面载入时、窗口尺寸改变时、窗口滚动时、页面单击、页面鼠标操作时等
   - **元件样式交互：**鼠标悬停、鼠标按下、选中、禁用、获取焦点时交互；
   - **元件事件交互：**单击、双击、鼠标按下、鼠标移入、鼠标移出、移动时、旋转时、尺寸改变时、焦点获取时、内容改变时等交互，不同元件事件交互稍有差别

### :anchor: 操作界面

- 空格键 : 可以快捷使用抓手工具，移动画布；
- 鼠标滚轮：默认是上下移动画布；
- Shift + 鼠标滚轮：左右移动画布；
- Ctrl + 鼠标滚轮：放大缩小画布；

## 5.3 Axure基本操作

1. 对齐：对齐的参照物是以所有选中的控制中最下层的控件为准；
2. 图片控件：白色的图片边界点表示添加的图片是自适应的；.
3. 如果不做交互设计，需要添加详细的交互说明；
4. 交互设计
   - 首先为控件添加操作行为的展示效果：单机、选中、悬浮等等
   - 再为控件添加交互事件
5. 自定义元件库：新建library -->  采用包分组元件，每个元件占一个页面

## 5.4 Axure使用技巧

1. 变鼠标手
   - 选中元件 > 新建交互: 单击时获取当前元件焦点

## 5.5 原型图尺寸

### :anchor: 常用分辨率

| 机型              | 宽(px) | 高(px) |
| ----------------- | ------ | ------ |
| Web               | 1200   | 自适应 |
| iOS/iPad          | 1024   | 768    |
| iOS/iPhone6&7     | 375    | 667    |
| iOS/iPhone6&7Plus | 441    | 738    |
| Android/通用      | 360    | 640    |
| Android/平台      | 1024   | 768    |

### :anchor: 移动端尺寸

| 位置             | 高(px) |
| ---------------- | ------ |
| 顶部状态栏       | 20     |
| 状态栏下方导航栏 | 44     |
| 底部标签栏       | 49     |

- 任务流程图说明
  - 画具体任务流程的时候要注意从整体流程到局部流程，从主干流程到分支，从正常流程到异常流程。
  - 对于交互设计师来说，任务流程的主体一般是产品的用户，任务流程图反映的则是用户的行为。

### <font color=red>:anchor: 页面流程图</font>

- 页面流程图说明
  - 页面流程图的对象是页面，页面是互联网产品设计最基本的单元，大部分产品由一个个页面组成。
  - 页面流描述了用户完成一个任务需要经过哪些页面。也就是我在哪，经过什么操作，能去哪。
  - 页面流有三个要素：页面、行动点、连接线。

### <font color=red>:anchor: 文档流程图</font>

- 展示经过一个系统中的文档流的控制；

### <font color=red>:anchor: 数据流程图</font>

- 展示对一个系统中数据流的控制；

### <font color=red>:anchor: 系统流程图</font>

- 展示对于物理层面或资源层面上的控制；

###  <font color=red>:anchor: 程序流程图</font>

- 展示一个系统中对于程序的控制；

# 第五章 项目管理

# 第六章 数据分析

