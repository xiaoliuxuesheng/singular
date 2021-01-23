# **前言**

[TOC]

# 第一部分 CSS基础

## 第一章 CSS基础语法

### 1.1 CSS样式规则

1. <font size=4 color=blue>**行内样式**</font>：

   ```css
   style="属性名: 属性值; 属性名: 属性值; ... ..."
   ```

2. <font size=4 color=blue>**文档样式**</font>：

   ```css
   选择器{
       属性名: 属性值;
       属性名: 属性值;
       ... ...
   }
   ```

3. <font size=4 color=blue>**CSS脚本文件**</font>：

   - 使用html内嵌样式时候，css的编码格式和html的编码格式相同

   - 使用css外链引入css样式时候，需要单独为CSS文件指定编码格式，@charset指定样式表中使用的字符编码。它必须是样式表中的第一个元素，而前面不得有任何字符。因为它不是一个嵌套语句，所以不能在@规则条件组中使用。如果有多个 **`@charset `**@规则被声明，只有第一个会被使用，而且不能在HTML元素或HTML页面的字符集相关`<style>`元素内的样式属性内使用。

     ```css
     @charset "utf-8";
     选择器{
         属性名: 属性值;
         属性名: 属性值;
         ... ...
     }
     ```

### 1.2 CSS引用规则

1. <font size=4 color=blue>**行内样式：**</font>样式定义在html标签的style属性上

   ```html
   <div style="background-color: red;">
       行内样式,
   </div>
   ```
   
2. <font size=4 color=blue>**嵌入样式：**</font>样式写在 `<style>`标签内，`<style>`标签定义在html文件的`<head>`标签内

   ```html
   <style rel="stylesheet" type="text/css">
       .app2{
           background-color: red;
       }
   </style>
   ```
   
   - 属性`rel`：不能省略，是用来指定文档和链接资源的关系
   - 属性`type`：rel指定后，type也会被确定，所有type是可以省略的
   
3. <font size=4 color=blue>**外部样式**</font>

   ```html
   <link rel="stylesheet"  type="text/css" href="./css/01_外部css.css">
   ```
   
4. **<font size=4 color=blue>引入样式</font>**：可以同时使用多个@import，而且在单独的css文件中也可以使用@import引如其他的css文件

   ```html
   <style rel="stylesheet" type="text/css">
       @import "./css/02_导入css.css";
       或者
       @import url("./css/02_导入css.css");
   </style>
   ```

### 1.3 CSS样式优先级

- **<font size=4 color=blue>行内样式 > 嵌入样式 > 外部样式</font>**

### 1.4 注释

```html
<style rel="stylesheet" type="text/css">
    /*
    注释描述
    */
</style>
```

### 1.5 CSS命名规范

1. 命名要求
   - css命令建议用中横线字符；
   - 建议使用纯文英文字符，不建议使用中文和拼音；
   - 长名称或多个英文词组使用中横线分隔；
   - 不可以使用纯数字或数字开头命名
2. WEB前端命名规范

**❤ 主体**

| 头部:header             |                               |                   |                      |                |
| ----------------------- | ----------------------------- | ----------------- | -------------------- | -------------- |
| 内容：content/container | 尾部：footer                  | 导航：nav         | 侧栏：sidebar        | 栏目：column   |
| 整体布局：wrapper       | 左右中：left / right / center | 登录条：loginbar  | 标志：logo           | 广告：banner   |
| 页面主体：main          | 热点：hot                     | 新闻：news        | 下载：download       | 子导航：subnav |
| 菜单：menu              | 子菜单：submenu               | 搜索：search      | 友情链接：friendlink | 页脚：footer   |
| 版权：copyright         | 滚动：scroll                  | 标签页：tab       | 文章列表：list       | 提示信息：msg  |
| 小技巧：tips            | 栏目标题：title               | 加入：join        | 指南：guild          | 服务：service  |
| 注册：regsiter          | 投票：vote                    | 合作伙伴：partner | 状态：status         |                |
|                         |                               |                   |                      |                |

  **❤ id的命名规范**

| **(1)页面结构**   |                      |                         |                       |                           |
| ----------------- | -------------------- | ----------------------- | --------------------- | ------------------------- |
| 容器: container   | 页头：header         | 内容：content/container | 页面主体：main        | 页尾：footer              |
| 导航：nav         | 侧栏：sidebar        | 栏目：column            | 整体布局宽度：wrapper | 左右中：left right center |
| **(2)导航**       |                      |                         |                       |                           |
| 导航：nav         | 菜单：menu           | 子导航：subnav          | 顶导航：topnav        | 边导航：sidebar           |
| 摘要: summary     | 右导航：rightsidebar | 左导航：leftsidebar     | 子菜单：submenu       | 标题: title               |
| 主导航：mainnav   |                      |                         |                       |                           |
| **(3)功能**       |                      |                         |                       |                           |
| 标志：logo        | 广告：banner         | 登陆：login             | 登录条：loginbar      | 注册：regsiter            |
| 搜索：search      | 功能区：shop         | 标题：title             | 加入：joinus          | 状态：status              |
| 按钮：btn         | 滚动：scroll         | 标签页：tab             | 文章列表：list        | 提示信息：msg             |
| 当前的: current   | 小技巧：tips         | 图标: icon              | 注释：note            | 指南：guide               |
| 服务：service     | 热点：hot            | 新闻：news              | 下载：download        | 投票：vote                |
| 合作伙伴：partner | 友情链接：link       | 版权：copyright         |                       |                           |

**❤ class的命名:**

- **颜色：使用颜色的名称或者16进制代码，如：**

  ```css
  .red { color: red; } 
  .f60 { color: #f60; } 
  .ff8600 { color: #ff8600; }
  ```

- **字体大小，直接使用“font+字体大小”作为名称，如：**

  ```css
  .font12px { font-size: 12px; } 
  .font9pt {font-size: 9pt; }
  ```

- **对齐样式，使用对齐目标的英文名称，如：**

  ```css
  .left { float:left; } 
  .bottom { float:bottom; }
  ```

- **标题栏样式，使用“类别+功能”的方式命名，如：**

  ```css
  .barnews { } 
  .barproduct { }
  ```

**❤！注意事项：**

- 　**一律小写；**
- **尽量用英文；**
- **尽量不加中杠和下划线；**
- **尽量不缩写，除非一看就明白的单词，如：wrapper可以写成wrap。**
- **css文件命名规范：**
  - **主要的 master.css；**
  - **模块 module.css；**
  - **基本共用 base.css；**
  - **布局，版面layout.css；**
  - **主题 themes.css；**
  - **专栏 columns.css；**
  - **文字 font.css；**
  - **表单 forms.css；**
  - **补丁 mend.css；**
  - **打印print.css**

## 第二章 CSS模型

### 2.1 CSS元素显示模式

| 元素格式                             | 特点                                                         |
| ------------------------------------ | ------------------------------------------------------------ |
| <font color=blue>▲ 块级元素</font>   | 独占一行； <br />如果没有设置宽度默认和父元素宽度相同； <br />可以为元素设置宽和高； |
| <font color=blue>▲ 行内元素</font>   | 不会独占一行； <br />如果没有设置宽度默认和内容一样宽<br />为元素设置宽和高无效； |
| <font color=blue>▲ 行内块元素</font> | 为了让元素既不会独占一行，又可以设置宽度和高度；             |

### 2.2 CSS三大特性

| 特性                             | 说明                                                         |
| -------------------------------- | ------------------------------------------------------------ |
| <font color=blue>▲ 继承性</font> | 只有color、font-、text-开头的属性才会被继承，<br />只要是被嵌套的后代就会被继承；<br /> a标签的中文字的颜色和下划线不能被继承； <br />标题标签的文字大小不能被继承； |
| <font color=blue>▲ 层叠性</font> | 是CSS处理样式设置冲突的能力：层叠样式表；                    |
| <font color=blue>▲ 优先级</font> | ID > class > 标签 > 通配符 > 继承 > 默认<br />行内样式        --->    权重：1000<br />id                    --->    权重：0100<br />class/伪类      --->    权重：0010<br />标签                --->    权重：0001<br />*                      --->    权重：0000 |

- **!import**：官方认为!import和优先级没一点关系。不建议使用!import：Never绝不要在全站使用!import。要优先考虑使用样式规则的优先级来解决问题而不是 `!important`

1. **层叠性**：是指多种CSS样式的叠加，如果是一个属性通过不同的选择器作用到了同一个元素上，这时候其中的一个属性会被另一个属性层叠掉；**属性层叠基本的规则：就近原则**
2. **继承性**：子标签会继承父标签的**某些**样式，可以继承是样式如上表格中的说明；
3. **优先级**：五大基本选择器有各自的权重，根据选择器权重相加，权重大的优先级高；
   - 级别之间的权重不可跨越：0010的权重永远大于000n的权重
   - 继承的权重为0

## 第三章 移动端

### 3.1 移动端基础

1. 互联网市场浏览器分类：

   - PC浏览器（谷歌、火狐、360等）：发展的早有兼容问题；
   - 移动端浏览器（UC、QQ、百度、360、谷歌猎豹等待）：发展较晚，使用webkit内核，但是兼容好；并且移动端尺寸非常多

2. 常见移动端屏幕尺寸

   | 设备         | 尺寸（英寸） | 开发尺寸（px） | 物理像素比（dpr） |
   | ------------ | ------------ | -------------- | ----------------- |
   | iphone3G     | 3.5          | 320*480        | 1.0               |
   | iphone4/4s   | 3.5          | 320*480        | 2.0               |
   | iphone5/5s   | 4.0          | 320*568        | 2.0               |
   | iphone6      | 4.7          | 375*667        | 2.0               |
   | iphone6 Plus | 5.5          | 414-736        | 3.0               |
   | IPad Mini    | 7.9          | 768-1024       | 1.0               |

### 3.2 视口

1. 概念：视口（viewport）是浏览器显示页面内容的屏幕区域，视口可以分为布局视口、视觉视口、理想视口；

   - 布局视口（layout viewport）：一般移动设备的浏览器都默认设置了一个布局视口，用于解决早期PC端页面在手机上显示问题，一般的布局视口是980px（将980px压缩到手机视口大小）；
   - 视觉视口（visual viewpoint）：是用户在手机上看到的网站区域，可以通过缩放去操作视觉视口，单不会影响布局视口，布局视口仍然保持原来的宽度；
   - 理想视口（ideal viewpoint）：为了使网站在移动端有最理想的浏览器和阅读而设定的；对设备来讲，是最理想的视口尺寸，需要手动添加meta视口标签通知浏览器操作；meta视口标签的主要目的：布局视口的宽度应该与理想视口的宽度一致；

2. meta视口标签

   ```html
   <meta name="viewport" content="属性名=属性值,...">
   ```

   > | 视口属性      | 属性值说明                                                |
   > | ------------- | --------------------------------------------------------- |
   > | width         | 设置的是viewpoint的宽度，特殊值device-width表示设备的宽度 |
   > | initial-scale | 初始缩放比，大于0的数字：一般为1.0                        |
   > | maximum-scale | 最大缩放波，大于0的数字：一般为1.0                        |
   > | minimum-scale | 最小缩放比，大于0的整数：一般为1.0                        |
   > | user-scalable | 用户是否可以缩放：yes或no（1或0）                         |

3. 物理像素和物理像素比
   - 物理像素：物理像素点指的是屏幕显示的最小颗粒，是真实存在的，屏幕分辨率，在PC端1px=1像素
   - 物理像素比（屏幕像素比）：指一个px能显示的物理像素点的个数
4. 多倍图：在viewpoint设置中使用倍图提高图片质量，解决在图片在高清设备中的模糊问题；

### 3.3 移动端开发

1. 移动端开发选择：单独制作移动端页面、响应式页面兼容移动端
2. 移动端技术方案：移动端使用webkit内核
   - 流式布局：百分比布局
   - flex弹性布局：栅格布局
   - less+rem+媒体查询布局
   - 混合布局
   - bootstrap布局框架：

### 3.4 移动端特殊属性

1. 链接背景
2. 按钮外观
3. 长按页面跳出菜单

# 第二部分 CSS选择器

## 第一章 基本选择器

| 选择器     | 示例      | 描述                                                         |
| :--------- | --------- | :----------------------------------------------------------- |
| 通用选择器 | *         | 匹配所有选择器                                               |
| 标签选择器 | 标签名称  | 根据HTML标签名称匹配元素                                     |
| 类选择器   | .类名     | 匹配标签class属性值的所有元素，<br />一个元素可以定义多个类，用空格分隔 |
| ID选择器   | #id属性值 | 匹配标签id属性值的一个元素                                   |

## 第二章 结构选择器

| 选择器         | 示例              | 描述                                                         |
| :------------- | ----------------- | :----------------------------------------------------------- |
| 后代选择器     | 选择器A  选择器B  | 匹配是选择器A内部的所有**选择器B**                           |
| 儿子选择器     | 选择器A > 选择器B | 匹配是选择器A儿子元素为**选择器B**的                         |
| 交集选择器     | 选择器A选择器B    | 第一个为标签选择器，第二个为class选择器<br />将匹配是**选择器A**并且并且是**选择器B**元素 |
| 并集选择器     | 选择器A , 选择器B | 匹配**所有选择器**选中的元素                                 |
| 相邻兄弟选择器 | 选择器A + 选择器B | 匹配选择器A**平级的相邻的选择器B**                           |
| 通用兄弟选择器 | 选择器A ~ 选择器B | 匹配选择器A**平级的选择器B**                                 |

## 第三章 属性选择器

| 选择器               | 示例            | 描述                                        |
| :------------------- | --------------- | :------------------------------------------ |
| 属性名称选择器       | [target]        | 选择带有 target 属性所有元素                |
| 属性值选择器         | [target=_blank] | 选择 title 属性包含单词 "flower" 的所有元素 |
| 属性值子串包含选择器 | a[src*="abc"]   | 选择其 src 属性中包含 "abc" 子串的每个 元素 |
| 属性值前缀选择器     | a[src^="https"] | 选择其 src 属性值以 "https" 开头的每个 元素 |
| 属性值后缀选择器     | a[src$=".pdf"]  | 选择其 src 属性以 ".pdf" 结尾的所有 元素    |

## 第四章 伪类选择器

| 状态                 | 示例                  | 说明                                       |
| -------------------- | --------------------- | ------------------------------------------ |
| :link                | a:link                | 选择所有未被访问的链接                     |
| :visited             | a:visited             | 选择所有已被访问的链接                     |
| :hover               | a:hover               | 鼠标移动到元素上时                         |
| :active              | a:active              | 点击正在发生时                             |
| :focus               | input::focus          | 选择获得焦点的 input 元素                  |
| :root                | :root                 | 选择文档的根元素即html。                   |
| :empty               | p:empty               | 选择没有子元素的每个元素（包括文本节点）。 |
| **同级别**           |                       |                                            |
| :first-child         | p:first-child         | 选择属于父元素的第一个子元素的每个元素     |
| :last-child          | p:last-child          | 选择属于其父元素最后一个子元素每个元素。   |
| :nth-child(n)        | p:nth-child(2)        | 选择属于其父元素的第二个子元素的每个元素。 |
|                      | p:nth-child(odd)      | 选择属于其父元素的奇数元素。               |
|                      | p:nth-child(even)     | 选择属于其父元素的偶数元素。               |
| :nth-last-child(n)   | p:nth-last-child(2)   | 从最后一个子元素开始计数。                 |
| :only-child          | p:only-child          | 选择属于其父元素的唯一子元素的每个元素。   |
| **同类型**           |                       |                                            |
| :first-of-type       | p:first-of-type       | 选择属于其父元素的首个元素的每个元素       |
| :last-of-type        | p:last-of-type        | 选择属于其父元素的最后元素的每个元素。     |
| :only-of-type        | p:only-of-type        | 选择属于其父元素唯一的元素的每个元素。     |
| :nth-of-type(n)      | p:nth-of-type(2)      | 选择属于其父元素第二个元素的每个元素。     |
| :nth-last-of-type(n) | p:nth-last-of-type(2) | 是从最后一个子元素开始计数。               |
| :not(selector)       | :not(p)               | 选择非元素的每个元素                       |

## 第五章 表单伪类

| 选择器    | 示例           | 说明                        |
| --------- | -------------- | --------------------------- |
| :enabled  | input:enabled  | 选择每个启用的 input 元素   |
| :disabled | input:disabled | 选择每个禁用的 input 元素   |
| :checked  | input:checked  | 选择每个被选中的 input 元素 |
| :required | input:required | 包含`required`属性的元素    |
| :optional | input:optional | 不包含`required`属性的元素  |
| :valid    | input:valid    | 验证通过的表单元素          |
| :invalid  | input:invalid  | 验证不通过的表单            |

## 第六章 字符伪类

| 状态           | 示例           | 说明                         |
| -------------- | -------------- | ---------------------------- |
| ::first-letter | p:first-letter | 选择每个元素的首字母         |
| ::first-line   | p:first-line   | 选择每个元素的首行           |
| ::before       | p:before       | 在每个元素的内容之前插入内容 |
| ::after        | p:after        | 在每个元素的内容之后插入内容 |

# 第三部分 CSS属性

## 第一章 文字属性

| 字体样式属性    | 常用取值                                                     | 说明            |
| --------------- | ------------------------------------------------------------ | --------------- |
| **font-style**  | normal：一般是用于将被标签修改的字体恢复正常                 |                 |
| **font-weight** | normal：一般是用于将被标签修改的字体恢复正常<br />100 ~ 900定：义由粗到细的字符。400 等同于 normal，而 700 等同于 bold。 |                 |
| **font-size**   | px：把 font-size 设置为一个固定的像素值。<br />%：把 font-size 设置为基于父元素的一个百分比值。 |                 |
| **font-family** |                                                              | ①常用           |
| **font**        | font: 样式 粗细 大小/行高 字体;                              | ②注意事项：顺序 |

①字体引入

②注意事项：顺序

1. 样式属性和粗细属性可以省略，也可以相互交互位置，因为文字样式默认为系统样式，文档粗细默认为细线问题；
2. 大小属性和字体属性**必须设置**；
3. 大小属性和字体属性**必须放在属性最后**；
4. 大小属性和字体属性**不可以交换**位置。

## 第二章 文本属性

| 文本属性        | 常用属性值                                                   | 说明               |
| --------------- | ------------------------------------------------------------ | ------------------ |
| line-height     | 如果行高和盒子高度相同，则文本等内容在盒子中会垂直居中<br />如果需要多行文字居中，需要给盒子添加padding实现文字居中 | 行高               |
| text-align      | left<br />right<br />center<br />justify                     | 文本对齐           |
| text-decoration | none：默认。定义标准的文本。一般用户去掉默认的样式           | 文本装饰           |
| text-indent     | px<br />em                                                   | 文本缩进           |
| text-transform  | capitalize：文本中的每个单词以大写字母开头。<br />uppercase：定义仅有大写字母。<br />lowercase：定义无大写字母，仅有小写字母。 | 字母文本           |
| text-shadow     | text-shadow: 必需水平阴影 必需垂直阴影 可选模糊的距离 可选阴影颜色 | 文字阴影           |
| vertical-align  | text-top：把元素的顶端与父元素字体的顶端对齐<br />middle：把此元素放置在父元素的中部<br />text-bottom：把元素的底端与父元素字体的底端对齐。 | 设置元素的垂直对齐 |
| color           | color_name：规定颜色值为颜色名称的颜色<br />#ff0000：规定颜色值为十六进制值的颜色或使用十六进制的缩写<br />rgb(255,0,0)：规定颜色值为 rgb 代码的颜色：三原色色域0~255<br />rgba(255,0,0,0)： rgb 代码的颜色与透明：三原色色域`0~255`，透明度：`0~1` | 文本颜色           |

## 第三章 背景属性

| 背景属性              | 取值                                                         | 说明                                                     |
| --------------------- | ------------------------------------------------------------ | -------------------------------------------------------- |
| background-color      |                                                              | 背景颜色                                                 |
| background-image      | background-image:url('图片链接');                            | 背景图片不占页面空间<br />背景图片的位置等属性容易控制； |
| background-repeat     | repeat-x：只有水平位置会重复背景图像<br />repeat-y：只有垂直位置会重复背景图像<br />no-repeat：background-image不会重复 |                                                          |
| background-position   | left  <br/>right<br/>center<br/>top  <br/>bottom<br />xpos：水平位置px <br />ypos：垂直位置px | 背景定位                                                 |
| background            | background: 颜色 图片 平铺 关联 定位;                        |                                                          |
| background-attachment | scroll：背景图片随着页面的滚动而滚动，这是默认的。<br />fixed：背景图片不会随着页面的滚动而滚动。<br />local：背景图片会随着元素内容的滚动而滚动。 | 背景关联                                                 |
| background-size       |                                                              | 背景尺寸                                                 |
| background-clip       | border-box：默认背景绘制在边框方框内（剪切成边框方框）<br />padding-box：背景绘制在衬距方框内（剪切成衬距方框）<br />content-box：背景绘制在内容方框内（剪切成内容方框） | 背景绘制区域                                             |

## 第四章 盒子模型

### 4.1 传统盒模型

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;所有的文档标签都是一个矩形框，被称为元素框（element box）：主要是描述了这个文档元素在浏览器中所占的位置大小；**所以每个盒子除了有自己的大小和位置外，还会影响到其他盒子的位置。**

<img src="https://s1.ax1x.com/2020/06/04/twUi2F.jpg" alt="twUi2F.jpg" border="0" />

| 盒属性                      | 方位属性                                                     | 说明                                                         |
| --------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| width                       |                                                              | 内容宽度                                                     |
| height                      |                                                              | 内容高度                                                     |
| margin: 上 右 下 左;        | margin-bottom<br/>margin-left<br/>margin-right<br/>margin-top | 元素与元素之间的距离                                         |
| padding: 上 右 下 左;       | padding-bottom<br/>padding-left<br/>padding-right<br/>padding-top | 元素内容到边框的距离**                                       |
| border-redius: 上 右 下 左; | 单位是像素（px）                                             | 边框圆角                                                     |
| border-style: 上 右 下 左;  | solid定义实线。<br />dashed定义虚线。在大多数浏览器中呈现为实线。<br />hidden与 "none" 相同。对于table，hidden 用于解决边框冲突。 | 边框样式                                                     |
| border-color: 上 右 下 左;  |                                                              |                                                              |
| border-width: 上 右 下 左;  |                                                              |                                                              |
| border: 宽度 样式 颜色;     | 顶部边框：border-top                                         | border-top-color<br />border-top-style<br />border-top-width |
|                             | 底部边框：border-bottom                                      | border-bottom-color<br />border-bottom-style<br />border-bottom-width |
|                             | 左边框：border-left                                          | border-left-color<br />border-left-style<br />border-left-width |
|                             | 右边框：border-right                                         | border-right-color<br />border-right-style<br />border-right-width |

- 内边距：padding
  - **内边距是指；
  - 内边距首先会考虑到父元素的边界，所以会有垂直方向内边距塌陷现象；
  - 内边距会修改盒子模型的大小
  - 内边距会有背景属性

- **外边距合并现象**

  - **平级盒子**：在默认布局的垂直方向的外边距，默认情况下外边距是不会叠加，会出现合并现象，哪个盒子的外边距大以哪个为主；尽量避免：在垂直方向只给一个盒子设置外边距；
  - **嵌套盒子**：嵌套盒子在垂直方式同时设置外边距会出现外边距塌陷现象：子盒子的外边距会影响到父盒子的位置；
    - 给父盒子设置边框或者内边距进行限制子元素；
    - 根据BFC机制：为父盒子设置溢出隐藏（overflow:hidden）属性；

- **盒子水平居中**：设置左右方向为auto：`margin 垂直距离 auto`

  ```css
  margin: 0 auto;
  ```

### 4.2 css3盒子模型：box-sizing

- 默认的盒子尺寸计算方式是外盒尺寸：即修改盒子模型的属性会改变盒子的大小，box-sizing用于修改容器的最终尺寸计算模式为内盒尺寸（根据width和height属性确定尺寸）
  - 外盒尺寸：空间宽高 = 内容 + padding + border + margin
  - 内盒尺寸：width/height = 内容 + padding + border

| 值             | 说明                                                       |
| :------------- | :--------------------------------------------------------- |
| **border-box** | CSS3新特性，CSS3的盒子模型，pading、border不会改变盒子大小 |
| content-box    | 这是 CSS2.1 指定的宽度和高度的行为。传统盒子模型           |
| inherit        | 指定 box-sizing 属性的值，应该从父元素继承                 |

## 第五章 布局属性

### 5.1 浮动布局

1. 浮动元素：float（将标准流中元素转换为浮动流）

   | 值      | 描述                                                 |
   | :------ | :--------------------------------------------------- |
   | left    | 元素向左浮动。                                       |
   | right   | 元素向右浮动。                                       |
   | none    | 默认值。元素不浮动，并会显示在其在文本中出现的位置。 |
   | inherit | 规定应该从父元素继承 float 属性的值。                |

2. 清除浮动：clear

   | 值      | 描述                                  |
   | :------ | :------------------------------------ |
   | left    | 在左侧不允许浮动元素。                |
   | right   | 在右侧不允许浮动元素。                |
   | both    | 在左右两侧均不允许浮动元素。          |
   | none    | 默认值。允许浮动元素出现在两侧。      |
   | inherit | 规定应该从父元素继承 clear 属性的值。 |

### 5.2 流式布局



## 第六章 其他属性

### 1. 超出模式：overflow

| 值      | 描述                                                     |
| :------ | :------------------------------------------------------- |
| visible | 默认值。内容不会被修剪，会呈现在元素框之外。             |
| hidden  | 内容会被修剪，并且其余内容是不可见的。                   |
| scroll  | 内容会被修剪，但是浏览器会显示滚动条以便查看其余的内容。 |
| auto    | 如果内容被修剪，则浏览器会显示滚动条以便查看其余的内容。 |
| inherit | 规定应该从父元素继承 overflow 属性的值。                 |

### 2.  显示隐藏：visibility

| 值         | 描述                                                         |
| :--------- | ------------------------------------------------------------ |
| **hidden** | 元素是不可见的。但是位置会保留：仍然会影响布局。             |
| visible    | 默认值。元素是可见的。                                       |
| collapse   | 当在表格元素中使用时，此值可删除一行或一列，但是它不会影响表格的布局。被行或列占据的空间会留给其他内容使用。如果此值被用在其他的元素上，会呈现为 "hidden"。 |
| inherit    | 规定应该从父元素继承 visibility 属性的值。                   |

### 3. 元素显示模式转换：display

| 值                 | 描述                                                         |
| :----------------- | :----------------------------------------------------------- |
| none               | 此元素不会被显示。隐藏后不保留位置                           |
| **block**          | 此元素将显示为块级元素，此元素前后会带有换行符。             |
| **inline**         | 默认。此元素会被显示为内联元素，元素前后没有换行符。         |
| **inline-block**   | 行内块元素。（CSS2.1 新增的值）                              |
| list-item          | 此元素会作为列表显示。                                       |
| run-in             | 此元素会根据上下文作为块级元素或内联元素显示。               |
| table              | 此元素会作为块级表格来显示（类似 `<table>`），表格前后带有换行符。 |
| inline-table       | 此元素会作为内联表格来显示（类似 `<table>`），表格前后没有换行符。 |
| table-row-group    | 此元素会作为一个或多个行的分组来显示（类似 `<tbody>`）。     |
| table-header-group | 此元素会作为一个或多个行的分组来显示（类似 `<thead>`）。     |
| table-footer-group | 此元素会作为一个或多个行的分组来显示（类似 `<tfoot>`）。     |
| table-row          | 此元素会作为一个表格行显示（类似 `<tr>`）。                  |
| table-column-group | 此元素会作为一个或多个列的分组来显示（类似 `<colgroup>`）。  |
| table-column       | 此元素会作为一个单元格列显示（类似 `<col>`）                 |
| table-cell         | 此元素会作为一个表格单元格显示（类似 `<td>` 和 `<th>`）      |
| table-caption      | 此元素会作为一个表格标题显示（类似 `<caption>`）             |
| inherit            | 规定应该从父元素继承 display 属性的值。                      |

# 第四部分 CSS布局

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>网页布局值的是浏览器对HTML元素的排版方式，浏览器的排版方式主要由：①标准流排版；②浮动流排版；③定位流排版；④栅格布局；

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>网页中展示的元素是文字、图片、音频、视频；网页布局就是要合理的分配这样网页元素，网页布局的本质就是将页面元素放置在不同的盒子里，通过CSS对盒子的排列布局从而实现网页的搭建；

## 第一章 标准流

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>**标准流**也称为普通流或文档流，就是指标签按照规定好的默认方式镜像排列；在标准流中的元素分为行内元素、块级元素、行内块元素；其在标准流中排列特点是：

- 块级元素：在标准流中独占一行（垂直排版），具有width和height属性；
- 行内块元素：水平排版，并且具有width和height属性；
- 行内元素水平排版，但是width和height无效；

## 第二章 浮动布局

### 1、浮动流概述

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>为什么要使用浮动流？在网页布局中可以使块级元素水平布局，并且可以控制元素之间的距离；在网页布局中可以指定盒子在水平方向的位置；

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>浮动流的概述：浮动是给盒子添加float属性，给盒子创建了一个浮动框，具有浮动框的元素会从原标准流的位置脱离出来，浮动框根据浮动属性的值，浮动框的左边缘或右边缘会贴靠到所包含的块边缘或另一个浮动框的左右边缘；

**浮动元素的特点**：为元素添加`float:left | right`属性就可以将标准流元素转换为浮动流

1. **浮动元素会脱离标准流**

   - 元素浮动后会基于父元素的位置进行左右排版：父级的盒子如果装不下浮动的元素，后面浮动的元素会另起一行；
   - 浮动流是一种“半脱离标准流”的排版方式，浮动后会移动到父元素中指定的位置；
   - 元素浮动后，原来的位置会被释，浮动区域会覆盖掉标准元素，但是浮动的区域不会覆盖对应位置标准流元素中的文本内容

   - 元素浮动不会超越父元素的padding区域和margin区域；

2. **浮动元素会在一行内显示并且元素顶部对齐**

   - 相同方向的浮动元素：先浮动的元素会显示在前面，后浮动的元素会显示在后面；
   - 不同方向的浮动元素：左浮动会找左浮动，右浮动会找右浮动；
   - 浮动元素浮动后的位置：右浮动元素在浮动之前在标准流中的位置确定，只在原来所在行浮动；

3. **浮动元素具有行内块的特性**

   - 浮动流是不区分行内元素、块级元素或行内块元素：浮动所有元素都可以设置宽和高；
   - 浮动元素是不能撑起父元素的高度；
   - 浮动元素是不可以设置`margin 0 auto`的；

### 2、版心和布局流程

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>网页布局是根据网页中元素中内容特点进行排版，其中版心布局的基础，版心是指网页中主题内容所在的区域，一般在浏览器窗口中水平居中显示；主要的布局流程：

1. 确定页面版心：即确浏览器中页面展示的最宽的宽度
2. 第一步从垂直方向拆分页面模块：流式布局的方式
3. 第二步再拆分每个垂直的模块中拆分需要水平布局或流式布局
4. 根据初始的布局结构制作HTML结构
5. CSS初始化，根据盒子模型和各种布局模式，使用DIV+CSS布局控制网页中的各个模块；

### 3、浮动元素贴靠现象

- 当父元素的宽度足够放置浮动元素时，浮动元素会按顺序贴靠；
- 当父元素宽度不够时，浮动元素会找现在贴靠元素的上一个浮动元素，直到贴靠在父元素；

### 4、消除浮动

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>浮动的注意点：①浮动和标准流的父元素搭配使用（先用标准流排列水平结构，再在水平布局的父元素中定义元素设置浮动属性）②一个元素浮动了理论上该元素的兄弟元素都需要浮动，因为浮动元素会影响后面的标准流；

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>在实际开发中，浮动元素的标准流的父盒子是不会设置高度的，父盒子的高度应该是被子盒子的内容撑开的，但是父盒子中的所有元素浮动后，浮动元素是撑不开父盒子的高度的，所以会导致父盒子的高度为0，下一个标准流元素会被浮动造的影响：浮动不占有原文档流中的位置，所以会对后面的元素排版产生影响，为了解决这些问题，所以要为该元素清除浮动后造成的影响：元素浮动后不会撑开父元素的高度，父元素的高度为0的问题；清除浮动后父盒子会根据子盒子自动检测高度，就不会影响下面的标注流了；清除浮动属性：clear=both，清除浮动的策略是闭合浮动（）

1. 额外标签法：也称隔墙法，是w3c推荐；在最后浮动元素的元素后新增一个空盒子（**必须是块级元素，不能是行内元素**），并且给盒子设置clear属性，缺点是添加无语义的标签，不优雅；
2. 给父元素添加overflow属性：给父元素添加overflow属性，本义是处理溢出样式的；缺点是无法显示溢出的部分，
3. 给父元素添加after伪元素：本质是也是隔墙法，只是墙是通过样式添加的；原理是after伪元素必须要用content属性，需要将content转为块级元素（display=block），转为块级元素后可以为元素设置clear属性，并且这个内容不再浏览器显示（visibility=hidden），缺点是IE不兼容，需要给添加额外样式（*zoom=1）
4. 给父元素添加双伪元素：after是给父盒子后面添加一个虚拟的墙，再加个before属性给父盒子前面添加一个墙，表示浮动元素完全在父盒子中浮动了

- **<del>清除浮动方式一</del>**：给父元素设置高度：企业开发中一般盒子的高度是由内容决定，所以不推荐使用盒子高度；
- **清除浮动方式二**：为浮动元素添加clear属性：添加了clear属性的元素margin属性会失效；解决浮动的本质是把浮动的盒子圈到里面，让父盒子闭合出口和入口不让他们出来影响其他元素；
- **清除浮动方式三**：隔墙法清除浮动
  
  - 外墙法：在浮动的元素之间添加一个块级元素，并且为该元素设置属性`clear: both`属性，外墙法的第一个浮动元素不要使用`margin-buttom`属性，外墙法的第二个浮动元素不要使用`margin-top`属性，直接为外墙设置高度属性即可；
  
  - 内墙法：在第一个浮动元素的所有子元素之后添加一个块级元素，并且为该元素设置属性`clear: both`属性，内墙法可以让浮动元素使用margin属性；
  
  - 使用伪元素选择器为元素前后添加块级元素：`::before` 或`::after`伪元素的content属性，并且设置`height`属性设置为0，`visibility`属性设置为hidden，`clear`属性设置为both；
  
    ```css
    .clear-fix:after{
        content:"不建议填空";
        height:0px;
        visibality:hidden;
        display:block;
        clear:both;
    }
    
    /** 伪元素有兼容问题:添加兼容处理方式 */
    .clear-fix{
        *zoom:1;
    }
    ```
  
  - 双伪元素清除浮动：触发bfc，防止外边距合并
  
    ```css
    .clear-fix:after,.clear-fix:before{
        content:"";
        display:block;
    }
    .clear-fix{
        clear:both;
    }
    /** 伪元素有兼容问题:添加兼容处理方式 */
    .clear-fix{
        *zoom:1;
    }
    ```
- **清除浮动方式四**：使用`overflow: hidden`属性：在IE6中无效，需要添加兼容属性`*zoom:1`值；缺点子元素中过多的内容被隐藏；

##  第三章 定位布局

1. 定义边便宜属性
   - left
   - right
   - top
   - bottom
2. 定义模式：position
   - static：元素默认的定位方式，将元素定位于静态位置：指元素在HTML文档中的静态位置，无法使用边便宜属性，一般用来清除定位属性；
   - relative：相对定位，相对于自己在原文档流中的位置，通过边便宜属性定位，但是原来占有的位置任然占有
   - absolute：绝对定位，绝对定位可以通过边偏移属性移动位置，边偏移基础位置是父级的有定位属性的元素，如果父级定义都没有定位属性则会根据浏览器的原点为基准点对齐；绝对定位完全脱标
   - fix：固定定位的一种特殊的绝对定位，总是以浏览器为基础点的元素定位，特点是完全脱标，并且不随着滚动条滚动
3. 层叠次序属性：z-index：取值越大，层叠次序越高，位置越上

## 第四章 流式布局

 

## 第五章 弹性布局

###  5.1 Flex布局特点

- **传统布局特点**：①兼容性好（PC和移动端都适应）、②布局繁琐（布局属性多且乱）、③局限性，在移动端效果不好
- **Flex布局特点**：①操作方便，布局极为简单、②是CSS新特性，对PC端浏览器支持较差

### 5.2 Flex布局原理

1. Flex是Flexible Box的（弹性盒子）缩写，用来为盒装模型提供最大的灵活性，任何一个容器都可以指定为flex布局。

2. 采用了flex的元素称为Flex Container，容器中所有的元素自动称为容器中的Flex Item；

   - Flex Container（FLex容器）：默认有两条轴：默认主轴是水平方向向右，默认测轴是垂直方向向下
   - Flex Item（项）：元素的float、clear、vertical-align 的属性将会失效

3. **布局原理**：Flex布局就是通过flex container中属性的item的属性设置子元素在主轴方向和测轴方向的摆放方式；

4. **display：flex**：①flex：父盒子是块级元素，使用flex属性值后父盒子仍然保留块级元素特点，独占一行②inline-flex：父盒子是块级元素，使用inline-flex属性值后父盒子会有行内块元素特点（如果设置父盒子的宽度和高度，flex容器的的宽度将有子元素宽度决定）

   ```css
   .container {
       display: flex | inline-flex;       //可以有两种取值
   }
   ```

   > 例：<img src="https://s3.ax1x.com/2021/01/23/sTMZ60.png" alt="sTMZ60.png" border="0" />
   >
   > ```html
   > <!DOCTYPE html>
   > <html>
   > <head>
   >     <meta charset="UTF-8">
   >     <title>Container</title>
   >     <style>
   >         .box1 {background: red;display: flex;}
   >         .box1 div { width: 100px;height: 50px;background: green;}
   >         
   >         .box2 {background: red; display: inline-flex;}
   >         .box2 div {width: 100px;height: background: green;}
   >     </style>
   > </head>
   > <body>
   > <div class="box1">
   >     <div>1</div>
   >     <div>2</div>
   >     <div>3</div>
   >     <div>4</div>
   > </div>
   > <br>
   > <div class="box2">
   >     <div>1</div>
   >     <div>2</div>
   >     <div>3</div>
   >     <div>4</div>
   > </div>
   > </body>
   > </html>
   > ```

### 5.3 Flex Container

| 容器属性            | 属性值及说明                                                 |
| ------------------- | ------------------------------------------------------------ |
| **flex-direction**  | **设置主轴的方向(即item的排列方向)**<br />row：默认值，主轴为水平方向，从左向右<br />row-reverse：主轴为水平方向，从右向左<br />column：主轴为垂直方向，从上向下<br />column-reverse：主轴为垂直方向，从下向上 |
| **justify-content** | **定义了项目在主轴的对齐方式。**<br />flex-start：默认值，左对齐<br />flex-end：右对齐<br />center：居中<br />space-between：两端对齐，项目之间的间隔相等，即剩余空间等分成间隙。<br />space-around：每个项目两侧的间隔相等 |
| **flex-wrap**       | **设置容器内item是否可换行：如果支持换行，侧轴可以有多条**<br />nowrap：不换行，当主轴尺寸固定但当空间不足时，item尺寸会调整而并不会挤到下一行。<br/>wrap：item主轴总尺寸超出容器时换行，第一行在上方<br />wrap-reverse：item主轴总尺寸超出容器时换行，，第一行在下方 |
| **align-items**     | **定义了项目在侧轴上的对齐方式**<br />默认值为 stretch 即如果项目未设置高度或者设为 auto，将占满整个容器的高度。<br />flex-start：交叉轴的起点对齐<br />flex-end：交叉轴的终点对齐<br />center：交叉轴的中点对齐<br />baseline: 项目的第一行文字的基线对齐 |
| **align-content**   | **定义了多根轴线的对齐方式，如果项目只有一根轴线，那么该属性将不起作用**<br />默认值为 stretch多条轴线平分容器的垂直方向上的空间。<br />flex-start：轴线全部在交叉轴上的起点对齐<br />flex-end：轴线全部在交叉轴上的终点对齐<br />center：轴线全部在交叉轴上的中间对齐<br />space-between：轴线两端对齐，之间的间隔相等，即剩余空间等分成间隙。<br />space-around：每个轴线两侧的间隔相等 |
| flex-flow           | **flex-direction 和 flex-wrap 的简写形式**<br />没什么卵用，老老实实分开写就好了 |

### 5.3 Flex Item属性

| item属性       | 属性说明                                                     |
| -------------- | ------------------------------------------------------------ |
| **flex**       | **item用来定义分配剩余空间的范式，用flex表示占的比例**       |
| **align-self** | **item设置自己在测轴的排列方式**<br />                       |
| **order**      | **定义item在容器中的排列顺序**<br />数值越小，排列越靠前，默认值为 0 |

## 第六章 栅格系统

### 5.1 栅格系统概述

<font size=4 color=blue>▲ 栅格系统的介绍</font>

CSS 网格布局(Grid Layout) 是CSS中最强大的布局系统。 这是一个二维系统，可以同时处理列和行，它将网页划分成一个个网格，可以任意组合不同的网格，做出各种各样的布局。

栅格系统与FLEX弹性布局有相似之处理，都是由父容器包含多个项目元素的使用。Flex 布局是轴线布局，只能指定"项目"针对轴线的位置，可以看作是**一维布局**。Grid 布局则是将容器划分成"行"和"列"，产生单元格，然后指定"项目所在"的单元格，可以看作是**二维布局**。Grid 布局远比 Flex 布局强大。

在CSS早期的布局设计中，使用table标签作为布局元素，后来被div取代，随着移动互联网的快速发展，div布局兼容性不足，栅格布局采用类似表格的单元格的方式，并且拥有div的灵活特点。栅格布局的整体是一个容器，用纵横的栅格线分隔为一个个的单元格，布局原理是将元素填充到栅格容器的单元格中。

<font size=4 color=blue>▲ 栅格容器中相关术语</font>

- **容器（container）**：采用网格布局的区域；
- **项目（item）**：容器内部采用网格定位的子元素，  **项目只能是容器的顶层子元素**
- **行（row）**：容器里面的水平区域
- **列（column）**：容器里面的垂直区域  
- **单元格**：行和列的交叉区域
- **网格线（grid line）**：划分网格的线，
  - 水平网格线划分出行：水平网格线的编号从1开始，从上到下；
  - 垂直网格线划分出列：垂直网格线的编号从1开始，从左到右；
- 单元格的边：单元格必须是个矩形，所以是由四条边围成的，每个单元格的每条表都有编号和名称；
  - 行起始边 和 行结束边
  - 列起始边 和 列结束边
- 偏移：指单元格的偏移，单元格偏移后会占用被偏移单元格的从而形成一个新是栅格
  - 行偏移：指单元格列起始线到下一个单元格列起始线为一个偏移；
  - 列偏移：指单元格行起始线到下一个单元格行起始线为一个偏移；
- **Grid 布局的属性分成两类：**
  - 一类定义在容器上面，称为容器属性；
  - 另一类定义在项目上面，称为项目属性。

### 5.2 栅格的声明

####  <font size=4 color=blue>▲ 块级容器声明栅格</font>

- 定义一个简答的容器级html元素

  ```html
  <div class="grid">
      <div class="item01"></div>
  </div>
  ```

- 将定义好的容器级元素声明为一个栅格系统

  ```css
  <style>
      .grid{
          display: grid;
          grid-template-rows: 100px 100px 100px;
          grid-template-columns:  100px 100px 100px;
      }
      .item01{
          width: 100px;
          height: 100px;
          background-color: #cccccc;
          border: 1px saddlebrown solid;
          padding: 10px;
          background-clip: content-box;
          box-sizing: border-box;
      }
  </style>
  ```

  > - 栅格的三要素：
  >   - ① 有一个容器级标签并且设置显示属性为：display: grid;
  >   - ② 需要指定栅格容器的行数和每一行的高度：grid-template-rows: 100px 100px 100px;
  >   - ③ 需要指定栅格容器中的列和每一列的宽度：grid-template-columns:  100px 100px 100px;

- 显示效果

  <img src='./imgs/栅格定义01' width=30%/>

  

### 5.3 栅格系统的元素填充

# 第五部分 CSS新特性

## 第一章 过渡

### 1. transition-property: 过渡属性

- 默认值： all表示指定元素所有支持transition-property属性的样式，一般都是使用默认值；
- 可选值: none | all | 过渡样式（不是所有的CSS样式值都可以过渡，只有具有中间值的属性（比如颜色、宽高、位置、大小等属性值可以转换为数字的相关属性）才具备过渡效果）；

### 2. transition-duration: 过渡持续时间

- 持续时间是必选属性：该属性的单位是秒s或毫秒ms

### 3. transiton-timing-function: 过渡函数

- 过渡时间函数用于定义元素过渡属性随时间变化的过渡速度变化效果
- 过渡时间函数共三种取值，分别是关键字、steps函数和bezier函数
  - **关键字**：
    - **ease**: 开始和结束慢；
    - linear: 匀速；
    - ease-in: 开始慢；
    - ease-out: 结束慢；
    - ease-in-out: 和ease类似；
    - steps步进函数将过渡时间划分成大小相等的时间时隔来运行，步长

### 4. transition-delay: 过渡延迟时间

- 默认值是0s：该属性定义元素属性延迟多少时间后开始过渡效果，该属性的单位是秒s或毫秒ms

### 5. transition: 复合属性

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**过渡描述**：当元素的部分属性发生改变时，是经过一定的时间后过渡到了最终状态，而不是直接从一个状态变为另一个状态；

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;**过渡属性添加规则**：谁做过渡给谁加，然后配合`:hover`选择器修改元素的属性实现对元素的变化产生过渡效果；

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;过渡transition的这四个子属性只有`transition-duration`是必需值且不能为0。其中，`transition-duration`和`transition-delay`都是时间。当两个时间同时出现时，第一个是`transition-duration`，第二个是`transition-delay`；当只有一个时间时，它是`transition-duration`，而`transition-delay`为默认值0

```css
transition: 过渡属性  持续时间 过渡函数 延迟时间, 过渡属性  持续时间 过渡函数 延迟时间, ... ...
```

- **多值**：transition的多个属性值用逗号分隔开表示可以同时为多个值设置过渡属性

### 6. 触发方式

- 伪类触发：`:hover`、`:focus`、`:active`
- 符合媒体查询条件时触发：@media触发
- 点击事件触发

## 第二章 transform - 2D

### 1. 移动 translate

| 移动属性       | 说明                       |
| -------------- | -------------------------- |
| translate(x,y) | 水平方向和垂直方向同时移动 |
| ranslateX(x)   | 水平方向移动               |
| translateY(Y)  | 垂直方向移动               |

### 2. 缩放 scale

| 缩放属性    | 说明                       |
| ----------- | -------------------------- |
| scale(x, y) | 水平方向和垂直方向同时缩放 |
| scaleX(x)   | 水平方向缩放               |
| scaleY(y)   | 垂直方向缩放               |

### 3. 旋转 rotate(deg)

| 旋转属性      | 说明                                     |
| ------------- | ---------------------------------------- |
| rotate(n deg) | n大于0，顺时针旋转；n小于0，逆时针旋转； |

### 4. 倾斜 skew(deg, deg)

| 倾斜属性         | 说明                                |
| ---------------- | ----------------------------------- |
| skew(xdeg,ydeg); | 把元素水平方向上倾斜,和垂直方向倾斜 |

### 5. 转换原点

| 原点属性         | 说明                            |
| ---------------- | ------------------------------- |
| transform-origin | 调整元素转换的原点，默认50% 50% |

- 取值方位名词：left、right、top、bottom；
- 取值：X轴和Y轴的像素位置；

```css
/* 改变元素原点到左上角，然后进行顺时旋转45度 */ 
div{
	transform-origin: left top;
    transform: rotate(45deg);
}
```

## 第三章 动画 

 ### 1. 动画概述

动画可以通过设置多个节点来精确控制一个或一组动画，常用来实现复杂的动画效果

### 2. 动画定义与使用

- **定义动画：@keyframes**

  ```css
  @keyframes 动画名称{
      动画序列: {
      	/* 元素在该时间序列位置的样式属性 */
      }
      ...
  }
  ```

  > 动画序列说明：为了得到最佳的浏览器支持，您应该始终定义 0% 和 100% 选择器。
  >
  > - 使用关键字作为动画发生时间：关键词 "from" 和 "to"，等同于 0% 和 100%。
  > - 百分比来规定变化发生的时间：百分比对应的时间是动画持续时间的百分比；

- **使用动画**

  ```css
  元素选择器{
      animation-name: 动画名称;
      animation-duration: 动画持续时间;
      /* 其他动画属性 */
  }
  ```

### 3. 动画属性说明

| 属性                      | 描述                                                         |
| :------------------------ | :----------------------------------------------------------- |
| **@keyframes**            | 规定动画。                                                   |
| **animation**             | 所有动画属性的简写属性，除了 animation-play-state 属性。     |
| **animation-name**        | 规定 @keyframes 动画的名称。                                 |
| **animation-duration**    | 规定动画完成一个周期所花费的秒或毫秒。默认是 0。             |
| animation-timing-function | 规定动画的速度曲线。默认是 "ease"。                          |
| animation-delay           | 规定动画何时开始。默认是 0。                                 |
| animation-iteration-count | 规定动画被播放的次数。默认是 1。infinite是无限播放           |
| animation-direction       | 规定动画是否在下一周期逆向地播放。默认是 "normal"。反向"alternate" |
| animation-play-state      | 规定动画是否正在运行或暂停。默认是 "running"。暂停是"paused" |
| animation-fill-mode       | 规定动画结束后状态：保持forwards。回到起始backwards          |

## 第四章 transform - 3D

## 第五章 多媒体