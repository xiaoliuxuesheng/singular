# 第一章 开始使用Flutter

## 1.1 Dart语言概述

## 1.2 开发平台现状

## 1.3 安装和环境配置

## 1.4 开发工具配置

## 1.5 第一个Flutter应用

## 1.6 Flutter构建WEB应用

# 第二章 Flutter开发文档

## 2.1 组件基础

### 1. Widgets 介绍

​	Flutter从React中获取的灵感，采用新型的架构方式创建组件，即使用widget描述UI界面；Widget是描述在当前的配置和状态下组件所呈现出视图的样子。当Widget的状态改变时候会重新构建所呈现的视图（UI），Flutter框架则会对比前后的变化，并且对变化做出最小更改；

### 2. Material组件

​	Material组件是Flutter自带的一套强大的Widgts组件库，是Flutter中两个自带的UI库之一，如果想要以 iOS 为主的设计，可以参考 Cupertino components，它有自己版本的 CupertinoApp 和 CupertinoNavigationBar。

```DART
/// 使用material组件库
import 'package:flutter/material.dart';

/// 使用IOS组件库
import 'package:flutter/cupertino.dart';
```

### 3. HelloWorld

​	HelloWorld：创建一个最小的Flutter应用：只需要在启动方法中调用runApp()方法并传入一个Widget即可；runApp()会持有传入的Widget，并将这个Widget作为Widget树中的根节点

```dart
import 'package:flutter/material.dart';

void main() {
  runApp(
    const Center(
      child: Text(
        'Hello, world!',
        textDirection: TextDirection.ltr,
      ),
    ),
  );
}
```

### 4. 组件类型概述

​	Widgets分为有状态组件（StatefulWidget）和无状态组件（StatelessWidget），所谓状态就是组件内维护的可能被外部交互改变的数据称为组件的状态；

## 2.2 基础Widget

### 1. Text

- 构造函数Text

  ```dart
  Text(
    String data, 
    {
      Key? key, 
      TextStyle? style, 
      StrutStyle? strutStyle, 
      TextAlign? textAlign, 
      TextDirection? textDirection, 
      Locale? locale, 
      bool? softWrap, 
      TextOverflow? overflow, 
      double? textScaleFactor, 
      int? maxLines, 
      String? semanticsLabel, 
      TextWidthBasis? textWidthBasis, 
      TextHeightBehavior? textHeightBehavior, 
      Color? selectionColor
    }
  );
  Text.rich(
    InlineSpan textSpan, 
    {
      Key? key, 
      TextStyle? style, 
      StrutStyle? strutStyle, 
      TextAlign? textAlign, 
      TextDirection? textDirection, 
      Locale? locale, 
      bool? softWrap, 
      TextOverflow? overflow, 
      double? textScaleFactor, 
      int? maxLines, 
      String? semanticsLabel, 
      TextWidthBasis? textWidthBasis, 
      TextHeightBehavior? textHeightBehavior, 
      Color? selectionColor
    }
  )
  ```

- 属性

  | 属性名称    | 说明 |
  | ----------- | ---- |
  | String data |      |
  |             |      |

  

## 2.3 布局

## 2.4 组件生命周期

## 2.5 资源和图片

## 2.6 路由和导航

## 2.7 动画

## 2.8 高级组件

# 第三章 第三方组件

## 3.1 dio

