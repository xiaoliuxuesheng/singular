# 第一部分 CSS基础

## 第一章 CSS基础语法

### 1.1 CSS样式规则

### 1.2 CSS引用规则

1. **<font size=4 color=blue>行内样式：</font>**样式定义在html标签的style属性上

   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
    	...
   </head>
   <body>
   <div style="background-color: red;">
       行内样式,
   </div>
   </body>
   </html>
   ```

2. **<font size=4 color=blue>嵌入样式：</font>**样式写在 <kbd>\<style\></kbd>标签内，<kbd>\<style\></kbd>标签定义在html文件的<kbd>\<head\></kbd>标签内

   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
       <style rel="stylesheet" type="text/css">
           .app2{
               background-color: red;
           }
       </style>
   </head>
   <body>
   	...
   </body>
   </html>
   ```

   - 属性`rel`：
   - 属性`type`：

3. **<font size=4 color=blue>外部样式</font>**

   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
   	<link rel="stylesheet"  type="text/css" href="./css/01_外部css.css">
   </head>
   <body>
   	...
   </body>
   </html>
   ```

4. **<font size=4 color=blue>引入样式</font>**

   ```html
   <!DOCTYPE html>
   <html lang="en">
   <head>
   	<style rel="stylesheet" type="text/css">
           @import "./css/02_导入css.css";
           或者
           @import url("./css/02_导入css.css");
       </style>
   </head>
   <body>
   	...
   </body>
   </html>
   ```

### 1.3 CSS样式优先级

​	**<font size=4 color=blue>行内样式 > 嵌入样式 > 外部样式</font>**

### 1.4 注释

```html
<!DOCTYPE html>
<html lang="en">
<head>
	<style rel="stylesheet" type="text/css">
        /*
            注释描述
        */
    </style>
</head>
<body>
	...
</body>
</html>
```

# 第二部分 CSS选择器

## 第一章 基本选择器

1. ID选择器
2. 类选择器
3. 标签选择器

## 第二章 结构选择器

## 第三章 属性选择器

## 第四章 伪类选择器

## 第五章 结构伪类

## 第六章 表单伪类

## 第七章 字符伪类

## 第八章 权重选择

| 规则            | 粒度 |
| --------------- | ---- |
| 行内样式        | 1000 |
| ID              | 0100 |
| class，类属性值 | 0010 |
| 标签,伪元素     | 0001 |
| *               | 0000 |

# 第三部分 CSS属性

## 第一章 文字属性

## 第二章 颜色属性

## 第三章 背景属性

## 第四章 表单属性

# 第四部分 CSS布局

## 第一章 盒子模型

## 第二章 浮动布局

## 第三章定位布局

## 第四章 弹性布局

## 第五章 栅格系统

# 第五部分 CSS新特性

## 第一章 变形动画

## 第二章 过渡延迟

## 第三章 帧动画

## 第四章 媒体查询

# -------------------------------

# 第一章 基础知识

## 1.1 样式声明

> - link 标签放在 head 标签内部
> - 样式文件要以 .css 为扩展名

1. 外部样式

   ```css
   <link rel="stylesheet" href="houdunren.css" type="text/css">
   ```

   > - rel	定义当前文档与被链接文档之间的关系
   > - href	外部样式文件
   > - type	文档类型

2. 嵌入样式

   ```css
   <style>
   	body {
   		background: red;
   	}
   </style>
   ```

3. 内联样式 : 可以为某个标签单独设置样式。

   ```css
   <h1 style="color:green;">houdunren.com</h1>
   ```

4. 导入样式

   - 使用 `@import` 可以在原样式规则中导入其他样式表，可以在外部样式、`style`标签中使用。
   - 导入样式要放在样式规则前面定义。

   ```css
   <style>
   	@import url("hdcms.css");
   	body {
   		background: red;
   	}
   </style>
   ```







