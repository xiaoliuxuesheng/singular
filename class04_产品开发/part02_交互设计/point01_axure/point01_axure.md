# 第一章 原型图

## 1.1 原型图作用

## 1.2 常用原型图工具

### <font size=4 color=blue>★ Axure</font>

### <font size=4 color=blue>★ 墨刀</font>

## 1.3 Axure基本介绍

1. 菜单栏：

2. 功能区：包含了绘制原型图常用操作，熟练应用快捷键的使用

   - **文字编辑**：颜色、大小、字体

   - **填充**：快捷填充颜色

   - **线条**：快速编辑线条基本要素

   - **位置与尺寸**：默认与原点对齐 

     | 设备类型 | 型号 | 设置尺寸 |
     | -------- | ---- | -------- |
     | 移动端   |      | 375*812  |

3. 功能面板
   - **页面面板**：主要用于显示当前RP文件的所有页面，同时管理RP文件页面的增删改查
   - **母版面板**：可以简单理解为公共元件模板，将母版应用到相应页面中后，母版内容或样式发生变化，那么引用母版的页面内容或样式同样会跟着变化，常用于制作页面头部或底部内容。
   - **概要面板**：当前操作页面的所有元件管理，可以控制某个、某些、全部元件是否在概要面板中展示。
   - **元件库面板**：自带默认元件、流程元件、Icon元件，同时可通过元件面板管理外部元件库。用于绘制页面元素
   - **样式面板**：样式面板包含元件样式、页面样式；自由灵活设置各类型元件的样式
   - **交互面板**：包含页面交互、元件交互，其中元件交互又分为事件交互、样式交互。
   - **说明面板**：说明面板主要是用于管理元件的注释，目前仅支持文本注释，可对注释内容进行富文本编辑。

# 第二章 Axure功能区

- [x] <kbd><font size=4 color=blue>Ctrl + C</font></kbd>：复制
- [x] <kbd><font size=4 color=blue>Ctrl + X</font></kbd>：剪切
- [x] <kbd><font size=4 color=blue>Ctrl + V</font></kbd>：粘贴
- [x] <kbd><font size=4 color=blue>空格</font></kbd>：抓手工具：移动工作区面板
- [x] <kbd><font size=4 color=blue>Ctrl + 滚轮</font></kbd>：放大、缩小工作区
- [x] <kbd><font size=4 color=blue>Shift + 滚轮</font></kbd>：水平移动工作区
- [x] <kbd><font size=4 color=blue>Alt + 滚轮</font></kbd>：垂直移动工作区
- [ ] <kbd><font size=4 color=blue>Ctrl + Alt + 1</font></kbd>：相交选中
- [ ] <kbd><font size=4 color=blue>Ctrl + Alt + 2</font></kbd>：包含选中
- [ ] <kbd><font size=4 color=blue>e</font></kbd>：连接线工具
- [ ] <kbd><font size=4 color=blue>p</font></kbd>：钢笔工具
- [ ] <kbd><font size=4 color=blue>r</font></kbd>：矩形工具
- [ ] <kbd><font size=4 color=blue>o</font></kbd>：椭圆工具
- [ ] <kbd><font size=4 color=blue>l</font></kbd>：直线工具
- [ ] <kbd><font size=4 color=blue>t</font></kbd>：文字工具
- [ ] <kbd><font size=4 color=blue>Ctrl + Alt + p</font></kbd>：边界点工具；为控件添加边界点或操作控件的边界点
- [ ] <kbd><font size=4 color=blue>Ctrl + Shift + [ </font></kbd>：置于底层
- [ ] <kbd><font size=4 color=blue>Ctrl + Shift + ] </font></kbd>：置于顶层
- [x] <kbd><font size=4 color=blue>Ctrl + g</font></kbd>：组合
- [ ] <kbd><font size=4 color=blue>Ctrl + Shift + g</font></kbd>：取消组合
- [ ] <kbd><font size=4 color=blue>Ctrl + Alt + L</font></kbd>：左对齐 - left
- [ ] <kbd><font size=4 color=blue>Ctrl + Alt + C</font></kbd>：左右居中对齐 - center
- [ ] <kbd><font size=4 color=blue>Ctrl + Alt + R</font></kbd>：右对齐 - right
- [ ] <kbd><font size=4 color=blue>Ctrl + Alt + T</font></kbd>：顶对齐 - top
- [ ] <kbd><font size=4 color=blue>Ctrl + Alt + M</font></kbd>：上下居中对齐 - middle
- [ ] <kbd><font size=4 color=blue>Ctrl + Alt + B</font></kbd>：底对齐 - bottom
- [ ] <kbd><font size=4 color=blue>Ctrl + Shift + H</font></kbd>：水平分布
- [ ] <kbd><font size=4 color=blue>Ctrl + Shift + U</font></kbd>：垂直分布

# 第三章 Axure页面

- 根据页面层级和文件夹管理页面的层级结构

# 第四章 Axure概要

- 根据筛选按钮快速找到需要的元素
- 需要为页面的重要元素命名

- 隐藏的元件不会在预览中显示
- 层级：在概要面板中显示元件的层级，越下的元件层级越低，会被上层元件覆盖

# 第五章 Axure元件库

## 5.1 Axure默认元件

### 1. Default

| 基本元件       | 使用场景                                                     |
| -------------- | ------------------------------------------------------------ |
| 矩形元件       | 使用最多的组件，页面结构                                     |
| 图片元件       | 形状元件：用作容纳图片                                       |
| 占位符元件     | 形状元件：内置对角线，起占位作用                             |
| 按钮元件       | 形状元件：具有按钮基本样式                                   |
| 标题元件       | 具有特殊字体的文本                                           |
| 水平线与垂直线 | 水平或垂直相关的样式                                         |
| 热区           | 浮在最顶层的透明图层，为所覆盖元件设置可点击区域             |
| 动态面板       | 可以创建多个状态，每个状态可以当做是一个全新的页面，特定是所有状态占在同一个区域 |
| 中继器         | 由中继器数据集和中继器项两部分构成。中继器可以用于需要重复设置的元件<br />用于模仿数据库的数据集，可以重复的显示特定项 |
| 内联框架       | 需要引用页面或页面中某个部分的内容时，可以使用内部框架达到引用的效果 |
| **表单元件**   | **使用场景**                                                 |
| 文本框         |                                                              |
| 文本域         |                                                              |
| 列表框         |                                                              |
| 复选框         |                                                              |
| 单选框         |                                                              |
| 下拉列表       |                                                              |
| **菜单和表格** | **使用场景**                                                 |
| 树形菜单       |                                                              |
| 水平菜单       |                                                              |
| 表格           |                                                              |
| **标记元件**   | **使用场景**                                                 |
| PRD便签        |                                                              |
| 页面快照       |                                                              |
| 标记           |                                                              |

### 2. Flow

- 流程图基本元素

### 3. Icon

- 默认自带图标

## 5.2 使用自定义元件库

- 自定义：菜单 》 New Library（新建元件库后会单独打开Axure操作界面，在此界面保存的文件即为元件库）
- 新增元件：在元件面板中使用文件夹为元件分类，在元件文件夹中，建议使用一个页面保存一个自定义元件
- 保存：新增文件为rplib文件
- 使用：将自定义元件库加入到软件根目录`/DefaultSettings/Libraries`里面，重启Axure会自动加载元件库，也可以在Axure工作面板的元件面板中点击Add Library打开外部的元件库完成加载。

# 第六章 Axure母版

# 第七章 Axure说明

# 第八章 Axure样式

# 第九章 Axure交互

## 9.1 交互样式

> 交互样式表示再执行交互动作时候针对某个元件的表现形式，只为元件添加静态样式，无需定义额外动作

- 鼠标按下：mousedown
- 鼠标悬浮：mouseover
- 选中状态：selected
- 禁用样式：disabled
- 获取焦点：focused

## 9.2 交互效果

> 交互效果的制作指的是对界面的元件做了什么动作（事件），这个事件产生了什么结果，并且对这个结果进行配置的过程

### 1. 交互事件

| 鼠标单击时     | 鼠标双击时     | 鼠标右击时         | 鼠标按下时         |
| -------------- | -------------- | ------------------ | ------------------ |
| **鼠标松开时** | **鼠标移动时** | **鼠标移入时**     | **鼠标移出时**     |
| **鼠标停放时** | **鼠标长按时** | **键盘按键按下时** | **键盘按键松开时** |
| **移动时**     | **旋转时**     | **尺寸改变时**     | **显示时**         |
| **隐藏时**     | **获取焦点时** | **失去焦点时**     | **载入时**         |

### 2. 元件动作结果

- <font size=4 color=blue>超链接动作：link action</font>

  | 打开链接             | 关闭窗口               |
  | -------------------- | ---------------------- |
  | **在框架中打来链接** | **滚动到元件（锚点）** |

- <font size=4 color=blue>元件装饰动作：widget action</font>

  | 显示隐藏     | 设置面板状态         | 设置文本           | 设置图片       |
  | ------------ | -------------------- | ------------------ | -------------- |
  | **设置选中** | **设置类表首选项**   | **启用、禁用**     | **移动**       |
  | **旋转**     | **设置尺寸**         | **置于底层、顶层** | **设置不透明** |
  | **获取焦点** | **展开、折叠树节点** |                    |                |

- <font size=4 color=blue>中继器动作：repeater action</font>

  | 添加排序             | 移除排序             | 添加删选   | 移除筛选   |
  | -------------------- | -------------------- | ---------- | ---------- |
  | **设置当前显示页面** | **设置每页项目数量** | **添加行** | **标记行** |
  | **取消标记**         | **更新行**           | **删除行** |            |

- <font size=4 color=blue>其他动作：other action</font>

  | 设置自适应视图 | 设置变量值 | 其他 |
  | -------------- | ---------- | ---- |
  | **触发事件**   | **等待**   |      |

## 9.3 动作配置

1. <font size=4 color=blue>条件判断</font>：如果有添加时候，需要首先设置对应的条件，然后对条件添加动作

![image-20200328102227253](./imgs/image-20200328102227253.png)

2. <font size=4 color=blue>局部变量和全局变量</font>：
   - 局部变量：调用其他元件的参数，只在当前取值的页面中起作用
   - 全局变量：调用其他元件的参数，在当前文档中所有的页面中其作用呢

# 第十章 Axure预览与规范

## 10.1 Axure预览方式

1. 导出Axure页面为图片
2. 导出Axure页面为Html，点击start.html文件进行预览
3. 使用F5自定义预览，使用F6进行预览设置
4. 将Axure文件push到Axure share平台

## 10.2 Chrome插件

1. 原型Html预览插件：[Axure RP Extension for Chrome](https://ext.chrome.360.cn/webstore/search/Axure)
2. 矢量图复制插件：[Axhub icon](https://axhub.im/chrome/)

## 10.3 Axure设计规范

<img src='http://www.25xt.com/wp-content/uploads/2018/05/appsize_01.jpg'/>

<img src='http://www.25xt.com/wp-content/uploads/2018/05/appsize_02.jpg'/>

1. 移动端结构尺寸规范

   | 机型       | IPhone6@2x          | IPhone6@1x | plus |
   | ---------- | ------------------- | ---------- | ---- |
   | 设计稿     | 750 * 1334px        |            |      |
   | 状态栏     | 40px                |            |      |
   | 导航栏     | 88px                |            |      |
   | 导航栏图标 | 44px * 44px         |            |      |
   | 导航栏文字 | 34px                |            |      |
   | 标签栏     | 98px                |            |      |
   | 标签栏图标 | 50px * 50px         |            |      |
   | 标签栏文字 | 24px、26px ... 34px |            |      |

2. 颜色规范

   | 颜色     | 说明 |
   | -------- | ---- |
   | #333333  | 黑色 |
   | #ccccccc | 灰色 |
   | #F2F2F2  | 浅色 |

   

1.WEB：
页面尺寸：推荐`1600*900`（min）px
版心尺寸：推荐`1000*600`（min）px

2.Software：
NO.1-推荐尺寸：`1366*768`PX（16:9）
NO.2-推荐尺寸：`1024*768`PX（4:3）

3.APP：
Phone:
NO.1-最小尺寸：`320*570`PX；
NO.2-推荐尺寸：`393*700`PX;
NO.3-最大尺寸：`456*821`PX;
Pad：
NO.1-推荐尺寸：`553*738`PX（`738*553`PX）；
NO.2-最大尺寸：`768*1024`PX（`1024*768`PX）;