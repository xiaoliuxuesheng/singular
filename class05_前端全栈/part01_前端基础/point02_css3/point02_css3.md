# 第一部分 CSS基础

## 第一章 CSS基础语法

### 1.1 CSS样式规则

1. **<font size=4 color=blue>行内样式</font>**：

   ```css
   style="属性名: 属性值; 属性名: 属性值; ... ..."
   ```

2. **<font size=4 color=blue>文档样式</font>**：

   ```css
   选择器{
       属性名: 属性值;
       属性名: 属性值;
       ... ...
   }
   ```

3. **<font size=4 color=blue>CSS脚本文件</font>**：

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

1. **<font size=4 color=blue>行内样式：</font>**样式定义在html标签的style属性上

   ```html
   <div style="background-color: red;">
       行内样式,
   </div>
   ```
   
2. **<font size=4 color=blue>嵌入样式：</font>**样式写在 `<style>`标签内，`<style>`标签定义在html文件的`<head>`标签内

   ```html
   <style rel="stylesheet" type="text/css">
       .app2{
           background-color: red;
       }
   </style>
   ```
   
   - 属性`rel`：不能省略，是用来指定文档和链接资源的关系
   - 属性`type`：rel指定后，type也会被确定，所有type是可以省略的
   
3. **<font size=4 color=blue>外部样式</font>**

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

​	**<font size=4 color=blue>行内样式 > 嵌入样式 > 外部样式</font>**

### 1.4 注释

```html
<style rel="stylesheet" type="text/css">
    /*
    注释描述
    */
</style>
```

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

# 第二部分 CSS选择器

## 第一章 基本选择器

| 选择器     | 示例      | 描述                                                         |
| :--------- | --------- | :----------------------------------------------------------- |
| 通用选择器 | *         | 匹配所有选择器                                               |
| 标签选择器 | 标签名称  | 根据HTML标签名称匹配元素                                     |
| 类选择器   | .类名     | 匹配标签class属性值的所有元素，<br />一个元素可以定义多个类，用空格分隔 |
| ID选择器   | #id属性值 | 匹配标签id属性值的一个元素                                   |

## 第二章 结构选择器

| 选择器         | 示例              | 描述                                       |
| :------------- | ----------------- | :----------------------------------------- |
| 后代选择器     | 选择器A  选择器B  | 匹配是选择器A内部的所有**选择器B**         |
| 儿子选择器     | 选择器A > 选择器B | 匹配是选择器A儿子元素为**选择器B**的       |
| 交集选择器     | 选择器A选择器B    | 匹配是**选择器A**并且并且是**选择器B**元素 |
| 并集选择器     | 选择器A , 选择器B | 匹配**所有选择器**选中的元素               |
| 相邻兄弟选择器 | 选择器A + 选择器B | 匹配选择器A**平级的相邻的选择器B**         |
| 通用兄弟选择器 | 选择器A ~ 选择器B | 匹配选择器A**平级的选择器B**               |

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

**<font color=blue size=4>▲ 文字样式：font-style</font>**

| 值      | 描述                                   |
| :------ | :------------------------------------- |
| normal  | 默认值。浏览器显示一个标准的字体样式。 |
| italic  | 浏览器会显示一个斜体的字体样式。       |
| oblique | 浏览器会显示一个倾斜的字体样式。       |
| inherit | 规定应该从父元素继承字体样式。         |

**<font color=blue size=4>▲ 文字粗细：font-weight</font>**

| 值        | 描述                                                        |
| :-------- | :---------------------------------------------------------- |
| normal    | 默认值。定义标准的字符。                                    |
| bold      | 定义粗体字符。                                              |
| bolder    | 定义更粗的字符。                                            |
| lighter   | 定义更细的字符。                                            |
| 100 ~ 900 | 定义由粗到细的字符。400 等同于 normal，而 700 等同于 bold。 |
| inherit   | 规定应该从父元素继承字体的粗细。                            |

**<font color=blue size=4>▲ 文字大小：font-size</font>**

| 值                                                           | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| xx-small<br />x-small<br />small<br />medium<br />large<br />x-large<br />xx-large | 把字体的尺寸设置为不同的尺寸，从 xx-small 到 xx-large。<br />默认值：medium。 |
| smaller                                                      | 把 font-size 设置为比父元素更小的尺寸。                      |
| larger                                                       | 把 font-size 设置为比父元素更大的尺寸。                      |
| px                                                           | 把 font-size 设置为一个固定的值。                            |
| %                                                            | 把 font-size 设置为基于父元素的一个百分比值。                |
| inherit                                                      | 规定应该从父元素继承字体尺寸。                               |

**<font color=blue size=4>▲ 文字字体：font-family</font>**

| 值      | 描述                           |
| :------ | :----------------------------- |
| inherit | 规定应该从父元素继承字体系列。 |

- 通常会设置多个字体，用逗号分隔，如果前面的字体不匹配会使用后面设置的字体；
- 英文字体无法解析中文，中文字体可以解析英文；
- 设置字体必须是系统已安装字体，否则会显示系统默认字体；

### <font color=blue size=4>▲ 文字属性缩写：font </font>

```css
font: 样式 粗细 大小 字体;
```

- 注意事项
  1. 样式属性和粗细属性可以省略，也可以相互交互位置
  2. 大小属性和字体属性**必须设置**；
  3. 大小属性和字体属性**必须放在属性最后**；
  4. 大小属性和字体属性**不可以交换**位置。

## 第二章 文本属性

### <font color=blue size=4>▲ 文本装饰：text-decoration</font>

| 值           | 描述                                          |
| :----------- | :-------------------------------------------- |
| none         | 默认。定义标准的文本。                        |
| underline    | 定义文本下的一条线。                          |
| overline     | 定义文本上的一条线。                          |
| line-through | 定义穿过文本下的一条线。                      |
| blink        | 定义闪烁的文本。                              |
| inherit      | 规定应该从父元素继承 text-decoration 属性的值 |

### <font color=blue size=4>▲ 文本对齐：text-align</font>

| 值      | 描述                                       |
| :------ | :----------------------------------------- |
| left    | 把文本排列到左边。默认值：由浏览器决定。   |
| right   | 把文本排列到右边。                         |
| center  | 把文本排列到中间。                         |
| justify | 实现两端对齐文本效果。                     |
| inherit | 规定应该从父元素继承 text-align 属性的值。 |

### <font color=blue size=4>▲ 文本缩进：text-indent</font>

| 值      | 描述                                        |
| :------ | :------------------------------------------ |
| px      | 默认值：0。                                 |
| *%*     | 定义基于父元素宽度的百分比的缩进。          |
| inherit | 规定应该从父元素继承 text-indent 属性的值。 |

### <font color=blue size=4>▲ 字母文本：text-transform</font>

| 值         | 描述                                           |
| :--------- | :--------------------------------------------- |
| none       | 默认。定义带有小写字母和大写字母的标准的文本。 |
| capitalize | 文本中的每个单词以大写字母开头。               |
| uppercase  | 定义仅有大写字母。                             |
| lowercase  | 定义无大写字母，仅有小写字母。                 |
| inherit    | 规定应该从父元素继承 text-transform 属性的值。 |

### <font color=blue size=4>▲ 行高：line-height</font>

- 如果没有给盒子设置高度，默认行高和内容高度相同；
- 如果行高和盒子高度相同，则文本等内容在盒子中会垂直居中；
- 如果需要多行文字居中，需要给盒子添加padding实现文字居中；

### <font color=blue size=4>▲ 超出模式：overflow  </font>

| 值      | 描述                                                     |
| :------ | :------------------------------------------------------- |
| visible | 默认值。内容不会被修剪，会呈现在元素框之外。             |
| hidden  | 内容会被修剪，并且其余内容是不可见的。                   |
| scroll  | 内容会被修剪，但是浏览器会显示滚动条以便查看其余的内容。 |
| auto    | 如果内容被修剪，则浏览器会显示滚动条以便查看其余的内容。 |
| inherit | 规定应该从父元素继承 overflow 属性的值。                 |

## 第三章 颜色属性

### <font color=blue size=4>▲ 文本颜色：color</font>

| 值                    | 描述                                                         |
| :-------------------- | :----------------------------------------------------------- |
| color_name            | 规定颜色值为颜色名称的颜色                                   |
| #ff0000               | 规定颜色值为十六进制值的颜色或使用十六进制的缩写             |
| rgb(255,0,0)          | 规定颜色值为 rgb 代码的颜色：三原色色域0~255                 |
| rgba(255,0,0,0)       | 规定颜色值为 rgb 代码的颜色与透明：三原色色域`0~255`，透明度：`0~1` |
| hsl(色相,亮度,饱和度) |                                                              |
| inherit               | 规定应该从父元素继承颜色。                                   |

## 第四章 背景属性

**<font color=blue size=4>▲ 背景颜色：background-color</font>**

- 颜色取值和颜色属性相同

**<font color=blue size=4>▲ 背景图片：background-image</font>**

```css
background-image:url('图片链接');
```

- 背景图片和插入图片的区别
  - 背景图片不占页面空间；
  - 背景图片的位置等属性容易控制；

**<font color=blue size=4>▲ 背景平铺：background-repeat</font>**

| 值        | 说明                                         |
| :-------- | :------------------------------------------- |
| repeat    | 背景图像将向垂直和水平方向重复。这是默认     |
| repeat-x  | 只有水平位置会重复背景图像                   |
| repeat-y  | 只有垂直位置会重复背景图像                   |
| no-repeat | background-image不会重复                     |
| inherit   | 指定background-repea属性设置应该从父元素继承 |

**<font color=blue size=4>▲ 背景定位：background-position</font>**

| 值                                               | 描述                                                         |
| :----------------------------------------------- | :----------------------------------------------------------- |
| left  <br/>right<br/>center<br/>top  <br/>bottom | 如果仅指定一个关键字，其他值将会是"center"                   |
| *x% y%*                                          | 第一个值是水平位置，第二个值是垂直。左上角是0％0％。右下角是100％100％。如果仅指定了一个值，其他值将是50％。 。默认值为：0％0％ |
| *xpos ypos*                                      | 第一个值是水平位置，第二个值是垂直。左上角是0。单位可以是像素（0px0px）或任何其他 CSS单位。如果仅指定了一个值，其他值将是50％。你可以混合使用％和positions |
| inherit                                          | 指定background-position属性设置应该从父元素继承              |

**<font color=blue size=4>▲ 背景关联：background-attachment  </font>**

| 值      | 描述                                              |
| :------ | :------------------------------------------------ |
| scroll  | 背景图片随着页面的滚动而滚动，这是默认的。        |
| fixed   | 背景图片不会随着页面的滚动而滚动。                |
| local   | 背景图片会随着元素内容的滚动而滚动。              |
| inherit | 指定 background-attachment 的设置应该从父元素继承 |

### <font color=blue size=4>▲ 背景属性：background</font>

```css
background: 颜色 图片 平铺 关联 定位;
```

- 任意一个属性都可以省略

### <font color=blue size=4>▲ 指定背景绘制区域：background-clip</font>

| 值          | 说明                                             |
| :---------- | :----------------------------------------------- |
| border-box  | 默认值。背景绘制在边框方框内（剪切成边框方框）。 |
| padding-box | 背景绘制在衬距方框内（剪切成衬距方框）。         |
| content-box | 背景绘制在内容方框内（剪切成内容方框）。         |

## 第五章 盒子模型

​		所有的文档标签都是一个矩形框，被称为元素框（element box）：主要是描述了这个文档元素在浏览器中所占的位置大小；**所以每个盒子除了有自己的大小和位置外，还会影响到其他盒子的位置。**

<img src="https://s1.ax1x.com/2020/06/04/twUi2F.jpg" alt="twUi2F.jpg" border="0" />

### <font color=blue size=4>▲ 内容宽度：width</font>

### <font color=blue size=4>▲ 内容高度：height</font>

### <font color=blue size=4>▲ 边框：border</font>

- **边框圆角：border-redius**

  ```css
  border-redius: 上 右 下 左;
  ```

  > 如果值设置一个圆角，则四个圆的属性都有效；
  >
  > 如果对应位置缺省设置圆角，则该位置的圆角和对角的角度相同

- **边框样式：border-style**

  ```css
  border-style: 上 右 下 左;
  ```

  | 常用边框样式值 | 描述                                                         |
  | :------------- | :----------------------------------------------------------- |
  | **none**       | 定义无边框。                                                 |
  | **solid**      | 定义实线。                                                   |
  | **dashed**     | 定义虚线。在大多数浏览器中呈现为实线。                       |
  | hidden         | 与 "none" 相同。不过应用于表时除外，对于表，hidden 用于解决边框冲突。 |
  | dotted         | 定义点状边框。在大多数浏览器中呈现为实线。                   |
  | double         | 定义双线。双线的宽度等于 border-width 的值。                 |
  | groove         | 定义 3D 凹槽边框。其效果取决于 border-color 的值。           |
  | ridge          | 定义 3D 垄状边框。其效果取决于 border-color 的值。           |
  | inset          | 定义 3D inset 边框。其效果取决于 border-color 的值。         |
  | outset         | 定义 3D outset 边框。其效果取决于 border-color 的值。        |
  | inherit        | 规定应该从父元素继承边框样式。                               |

- **边框颜色：border-color**

  ```css
  border-color: 上 右 下 左;
  ```

- **边框宽度：border-width**

  ```css
  border-width: 上 右 下 左;
  ```

- **边框综合：border**

  ```css
  border: 宽度 颜色 样式;
  ```

- **分别设置边框**

  1. 顶部边框：border-top

     > border-top-color
     >
     > border-top-style
     >
     > border-top-width

  2. 底部边框：border-bottom

     > border-bottom-color
     >
     > border-bottom-style
     >
     > border-bottom-width

  3. 左边框：border-left

     > border-left-color
     >
     > border-left-style
     >
     > border-left-width

  4. 右边框：border-right

     > border-right-color
     >
     > border-right-style
     >
     > border-right-width

### <font color=blue size=4>▲ 内边距：padding</font>

- **内边距是指元素内容到边框的距离**；
- 内边距首先会考虑到父元素的边界，所以会有垂直方向内边距塌陷现象；
- 内边距会修改盒子模型的大小
- 内边距会有背景属性

```css
padding: 上 右 下 左;
```

1. padding-bottom
2. padding-left
3. padding-right
4. padding-top

### <font color=blue size=4>▲ 外边距：margin</font>

- **外边距是指元素与元素之间的距离**；

  ```css
  margin: 上 右 下 左;
  ```

  1. margin-bottom
  2. margin-left
  3. margin-right
  4. margin-top

- **外边距合并现象**

  - **平级盒子**：在默认布局的垂直方向的外边距，默认情况下外边距是不会叠加，会出现合并现象，哪个盒子的外边距大以哪个为主；尽量避免：在垂直方向只给一个盒子设置外边距；
  - **嵌套盒子**：嵌套盒子在垂直方式同时设置外边距会出现外边距塌陷现象：子盒子的外边距会影响到父盒子的位置；
    - 给父盒子设置边框或者内边距进行限制子元素；
    - 根据BFC机制：为父盒子设置溢出隐藏（overflow:hidden）属性；

- **盒子水平居中**：设置左右方向为auto：`margin 垂直距离 auto`

  ```css
  margin: 0 auto;
  ```

### <font color=blue size=4>▲ 容器最终尺寸：box-sizing</font>

- 默认的盒子尺寸计算方式是外盒尺寸：即修改盒子模型的属性会改变盒子的大小，box-sizing用于修改容器的最终尺寸计算模式为内盒尺寸（根据width和height属性确定尺寸）
  - 外盒尺寸：空间宽高 = 内容 + padding + border + margin
  - 内盒尺寸：width/height = 内容 + padding + border

| 值          | 说明                                                         |
| :---------- | :----------------------------------------------------------- |
| content-box | 这是 CSS2.1 指定的宽度和高度的行为。指定元素的宽度和高度（最小/最大属性）适用于box的宽度和高度。元素的填充和边框布局和绘制指定宽度和高度除外 |
| border-box  | 指定宽度和高度（最小/最大属性）确定元素边框。也就是说，对元素指定宽度和高度包括了 padding 和 border 。通过从已设定的宽度和高度分别减去边框和内边距才能得到内容的宽度和高度。 |
| inherit     | 指定 box-sizing 属性的值，应该从父元素继承                   |

### <font color=blue size=4>▲ 显示隐藏：visibility</font>

| 值       | 描述                                                         |
| :------- | :----------------------------------------------------------- |
| visible  | 默认值。元素是可见的。                                       |
| hidden   | 元素是不可见的。                                             |
| collapse | 当在表格元素中使用时，此值可删除一行或一列，但是它不会影响表格的布局。被行或列占据的空间会留给其他内容使用。如果此值被用在其他的元素上，会呈现为 "hidden"。 |
| inherit  | 规定应该从父元素继承 visibility 属性的值。                   |

### <font color=blue>▲ 元素显示模式转换：display</font>

| 值                 | 描述                                                         |
| :----------------- | :----------------------------------------------------------- |
| **none**           | 此元素不会被显示。                                           |
| **block**          | 此元素将显示为块级元素，此元素前后会带有换行符。             |
| **inline**         | 默认。此元素会被显示为内联元素，元素前后没有换行符。         |
| **inline-block**   | 行内块元素。（CSS2.1 新增的值）                              |
| list-item          | 此元素会作为列表显示。                                       |
| run-in             | 此元素会根据上下文作为块级元素或内联元素显示。               |
| table              | 此元素会作为块级表格来显示（类似 <table>），表格前后带有换行符。 |
| inline-table       | 此元素会作为内联表格来显示（类似 <table>），表格前后没有换行符。 |
| table-row-group    | 此元素会作为一个或多个行的分组来显示（类似 <tbody>）。       |
| table-header-group | 此元素会作为一个或多个行的分组来显示（类似 <thead>）。       |
| table-footer-group | 此元素会作为一个或多个行的分组来显示（类似 <tfoot>）。       |
| table-row          | 此元素会作为一个表格行显示（类似 <tr>）。                    |
| table-column-group | 此元素会作为一个或多个列的分组来显示（类似 <colgroup>）。    |
| table-column       | 此元素会作为一个单元格列显示（类似 <col>）                   |
| table-cell         | 此元素会作为一个表格单元格显示（类似 <td> 和 <th>）          |
| table-caption      | 此元素会作为一个表格标题显示（类似 <caption>）               |
| inherit            | 规定应该从父元素继承 display 属性的值。                      |

## 第六章 浮动属性

### <font color=blue size=4>▲ 浮动元素：float</font>

> 将标准流中元素转换为浮动流

| 值      | 描述                                                 |
| :------ | :--------------------------------------------------- |
| left    | 元素向左浮动。                                       |
| right   | 元素向右浮动。                                       |
| none    | 默认值。元素不浮动，并会显示在其在文本中出现的位置。 |
| inherit | 规定应该从父元素继承 float 属性的值。                |

### <font color=blue size=4>▲ 清除浮动：clear</font>

| 值      | 描述                                  |
| :------ | :------------------------------------ |
| left    | 在左侧不允许浮动元素。                |
| right   | 在右侧不允许浮动元素。                |
| both    | 在左右两侧均不允许浮动元素。          |
| none    | 默认值。允许浮动元素出现在两侧。      |
| inherit | 规定应该从父元素继承 clear 属性的值。 |

# 第四部分 CSS布局

​		网页中展示的元素是文字、图片、音频、视频；网页布局就是要合理的分配这样网页元素，网页布局的本质就是将页面元素放置在不同的盒子里，通过CSS对盒子的排列布局从而实现网页的搭建；

## 第一章 标准流

:dash: 浏览器默认的排版方式就是标准流

:dash: 标准流排版特点：标准流中有两种排版方式：水平排版、垂直排版

2. 水平排版：如果元素是行内或行内块元素会水平排版
3. 垂直排版：如果元素是块级元素会垂直排版；

## 第二章 浮动布局

### <font color=blue size=4>▲ 浮动流排版特点</font>

1. 浮动流是一种“半脱离标准流”的排版方式；
   - 标准流设置浮动属性后，元素在原标准流中等于删除效果；
   - 原来的位置会释放；
   - 浮动元素会覆盖掉标准元素。
2. 浮动流的排版方式只有水平排版；
3. 浮动流是不可以设置`margin 0 auto`的；
4. 浮动流中是不区分行内元素、块级元素或行内块元素；
5. 浮动流中的所有元素都可以设置宽和高；
6. 浮动元素是不能撑起父元素的高度；

### <font color=blue size=4>▲ 浮动元素排版规则</font>

1. 相同方向的浮动元素：先浮动的元素会显示在前面，后浮动的元素会显示在后面；
2. 不懂方向的浮动元素：左浮动会找左浮动，右浮动会找右浮动；
3. 浮动元素浮动后的位置：右浮动元素在浮动之前在标准流中的位置确定，只在原来所在行浮动；

### <font color=blue size=4>▲ 浮动元素贴靠现象</font>

- 当父元素的宽度足够放置浮动元素时，浮动元素会按顺序贴靠；
- 当父元素宽度不够时，浮动元素会找现在贴靠元素的上一个浮动元素，直到贴靠在父元素；

### <font color=blue size=4>▲ 浮动元素字围现象</font>

- 浮动元素不会覆盖标准流元素总的文本内容；
- 浮动元素浮动后显示位置任然会保留；

### <font color=blue size=4>▲ 消除浮动</font>

- 给父元素设置高度：企业开发中一般盒子的高度是由内容决定，所以不推荐使用盒子高度；
- 为浮动元素添加clear属性：添加了clear属性的元素margin属性会失效
- 隔墙法清除浮动
  - 外墙法：在浮动的元素之间添加一个块级元素，并且为该元素设置属性`clear: both`属性，外墙法的第一个浮动元素不要使用`margin-buttom`属性，外墙法的第二个浮动元素不要使用`margin-top`属性，直接为外墙设置高度属性即可；
  - 内墙法：在第一个浮动元素的所有子元素之后添加一个块级元素，并且为该元素设置属性`clear: both`属性，内墙法可以让浮动元素使用margin属性；
- 使用伪元素选择器为元素前后添加块级元素：`::before` 或`::after`伪元素的content属性，并且设置`height`属性设置为0，`visibility`属性设置为hidden，`clear`属性设置为both；
- 使用`overflow: hidden`属性：在IE6中无效，需要添加兼容属性`*zoom:1`值；

## 第三章定位布局



## 第四章 弹性布局

## 第五章 栅格系统

### 5.1 栅格系统概述

<font size=4 color=blue>▲ 栅格系统的介绍</font>

​		CSS 网格布局(Grid Layout) 是CSS中最强大的布局系统。 这是一个二维系统，可以同时处理列和行，它将网页划分成一个个网格，可以任意组合不同的网格，做出各种各样的布局。

​		栅格系统与FLEX弹性布局有相似之处理，都是由父容器包含多个项目元素的使用。Flex 布局是轴线布局，只能指定"项目"针对轴线的位置，可以看作是**一维布局**。Grid 布局则是将容器划分成"行"和"列"，产生单元格，然后指定"项目所在"的单元格，可以看作是**二维布局**。Grid 布局远比 Flex 布局强大。

​		在CSS早期的布局设计中，使用table标签作为布局元素，后来被div取代，随着移动互联网的快速发展，div布局兼容性不足，栅格布局采用类似表格的单元格的方式，并且拥有div的灵活特点。栅格布局的整体是一个容器，用纵横的栅格线分隔为一个个的单元格，布局原理是将元素填充到栅格容器的单元格中。

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

## 第一章 变形动画

## 第二章 过渡延迟

## 第三章 帧动画

## 第四章 媒体查询
