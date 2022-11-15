# 第一章 Flutter概述

## 1.1 移动开发

### 1. 原生开发

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>原生应用程序是指某一个移动平台（比如iOS或安卓）所特有的应用，使用相应平台支持的开发工具和语言，并直接调用系统提供的SDK API。比如Android原生应用就是指使用Java或Kotlin语言直接调用Android SDK开发的应用程序；而iOS原生应用就是指通过Objective-C或Swift语言直接调用iOS SDK开发的应用程序。原生开发优缺点：

- 主要优势：①可访问平台全部功能（GPS、摄像头）；②速度快、性能高、可以实现复杂动画及绘制，整体用户体验好；
- 主要缺点：①平台特定，开发成本高；不同平台必须维护不同代码，人力成本随之变大；②内容固定，动态化弱，大多数情况下，有新功能更新时只能发版；

总结一下，纯原生开发主要面临动态化和开发成本两个问题，而针对这两个问题，诞生了一些跨平台的动态化框架。

### 2. 跨平台技术

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>针对原生开发面临问题，业界一直都在努力寻找好的解决方案，而时至今日，已经有很多跨平台框架（注意，本书中所指的“跨平台”若无特殊说明，即特指 Android 和 iOS 两个平台），根据其原理，主要分为三类：

- H5 + 原生（Cordova、Ionic、微信小程序）：主要原理就是将 App 中需要动态变动的内容通过HTML5（简称 H5）来实现，通过原生的网页加载控件WebView （Android）或 WKWebView（iOS）来加载；H5 部分是可以随时改变而不用发版，动态化需求能满足；同时，由于 H5 代码只需要一次开发，就能同时在 Android 和 iOS 两个平台运行，这也可以减小开发成本，混合应用的优点是动态内容是 H5，Web 技术栈，社区及资源丰富，缺点是性能体验不佳，对于复杂用户界面或动画，WebView 有时会不堪重任。
- JavaScript 开发 + 原生渲染 （React Native、Weex）：React Native （简称 RN ）是 Facebook 于 2015 年 4 月开源的跨平台移动应用开发框架，是 Facebook 早先开源的 Web 框架 React 在原生移动应用平台的衍生产物，目前支持 iOS 和 Android 两个平台
- 自绘UI + 原生 (Qt for mobile、Flutter)：自绘UI + 原生。这种技术的思路是：通过在不同平台实现一个统一接口的渲染引擎来绘制UI，而不依赖系统原生控件，所以可以做到不同平台UI的一致性。

## 1.2 Flutter概述

### 1. Flutter简介

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>Flutter 是 Google 发布的一个用于创建跨平台、高性能移动应用的框架。Flutter 和 Qt mobile 一样，都没有使用原生控件，相反都实现了一个自绘引擎，使用自身的布局、绘制系统。但是Flutter是背靠Google，有着丰富的社区资源，并且性能高，在 iOS 和 Android 模拟器或真机上可以实现毫秒级热重载，并且不会丢失状态。Flutter 提供了丰富的组件、接口，开发者可以很快地为 Flutter 添加 Native 扩展。

| 技术类型              | UI渲染方式      | 性能 | 开发效率        | 动态化     | 框架代表       |
| --------------------- | --------------- | ---- | --------------- | ---------- | -------------- |
| H5 + 原生             | WebView渲染     | 一般 | 高              | 支持       | Cordova、Ionic |
| JavaScript + 原生渲染 | 原生控件渲染    | 好   | 中              | 支持       | RN、Weex       |
| 自绘UI + 原生         | 调用系统API渲染 | 好   | Flutter高, Qt低 | 默认不支持 | Qt、Flutter    |

### 2. Flutter框架

- Flutter 从上到下可以分为三层：框架层、引擎层和嵌入层

  <img src='https://s4.ax1x.com/2022/01/06/TzVD5n.png' width='80%'/>

- **Flutter Framework，即框架层**。这是一个纯 Dart实现的 SDK，它实现了一套基础库

- 底下两层（Foundation 和 Animation、Painting、Gestures）在 Google 的一些视频中被合并为一个dart UI层，对应的是Flutter中的`dart:ui`包，它是 Flutter Engine 暴露的底层UI库，提供动画、手势及绘制能力。

- Rendering 层，即渲染层，这一层是一个抽象的布局层，它依赖于 Dart UI 层，渲染层会构建一棵由可渲染对象的组成的**渲染树**，当动态更新这些对象时，渲染树会找出变化的部分，然后更新渲染。渲染层可以说是Flutter 框架层中最核心的部分，它除了确定每个渲染对象的位置、大小之外还要进行坐标变换、绘制（调用底层 dart:ui ）。

- Widgets 层是 Flutter 提供的的一套基础组件库，在基础组件库之上，Flutter 还提供了 Material 和 Cupertino 两种视觉风格的组件库，它们分别实现了 Material 和 iOS 设计规范。

- **Engine，即引擎层**。毫无疑问是 Flutter 的核心， 该层主要是 C++ 实现，其中包括了 Skia 引擎、Dart 运行时、文字排版引擎等。在代码调用 `dart:ui`库时，调用最终会走到引擎层，然后实现真正的绘制和显示。

- **Embedder，即嵌入层**。Flutter 最终渲染、交互是要依赖其所在平台的操作系统 API，嵌入层主要是将 Flutter 引擎 ”安装“ 到特定平台上。嵌入层采用了当前平台的语言编写，例如 Android 使用的是 Java 和 C++， iOS 和 macOS 使用的是 Objective-C 和 Objective-C++，Windows 和 Linux 使用的是 C++。 Flutter 代码可以通过嵌入层，以模块方式集成到现有的应用中，也可以作为应用的主体。Flutter 本身包含了各个常见平台的嵌入层，假如以后 Flutter 要支持新的平台，则需要针对该新的平台编写一个嵌入层。

### 3. Flutter应用结构

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>在Flutter应用中一切兼是Weight，不同的类型的Weight有着不同的功能，可以理解为HTML中内容是由标签标记，不同的标签有不同的样式；在HTML中有html基础骨架：html、head、title、body，FLutter也有自己的骨架，如上图，MaterialApp组件是根组件，根组件的home属性是Scaffold组件，表示是页面脚手架：如appBar是页面的头部，body是页面的主要内容区，floatingActionButton是页面底部导航栏；

## 1.3 Flutter环境

### 1. Window系统

### 2. Mac系统

- 下载FlutterSDK：

  - 中文网址：https://flutter.cn/
  - 官网网址：https://flutter.dev/

- 解压并配置环境变量：`~/.bash——profile`

  ```sh
  export PATH=[FLUTTER_INSTALL_PATH]/flutter/bin:$PATH
  ```

  > - FLUTTER_INSTALL_PATH：表示flutter的解压安装目录
  > - 配置完成后执行source $HOME/.bash_profile刷新变量，Mac系统需要在`～/.zshrc` ，在其中添加：source ～/.bash_profile保证每次打开终端可以刷新.bash_profile配置文件

- 安装开发必须软件：xCode、AndroidStudio（或VSCode）、Chrome等等

- 安装开发工具的Flutter插件：flutter

- Flutter升级：Flutter SDK有多个分支，如beta、dev、master、stable，其中stable分支为稳定分支；安装flutter后，你可以运行`flutter channel`查看所有分支，切换分支只需要执行命令flutter channel 分支名称 `即可，升级Flutter只需要一条命令

  ```sh
  flutter upgrade
  ```

# 第二章 Flutter基础

## 2.1 Flutter项目结构

- 使用AndroidStudio或者VSCode开发工具创建Flutter项目：目录结构说明

  | 文件或目录      | 说明                                                         |
  | --------------- | ------------------------------------------------------------ |
  | .dart_tool      | 记录了一些dart工具库所在的位置和信息                         |
  | .idea           | android studio 是基于idea开发的，.idea 记录了项目的一些文件的变更记录 |
  | android         | Android项目文件夹                                            |
  | ios             | iOS项目文件夹                                                |
  | lib             | lib文件夹内存放我们的dart语音代码                            |
  | test            | 用于存放我们的测试代码                                       |
  | .gitignore      | git忽略配置文件                                              |
  | .metadata       | IDE 用来记录某个 Flutter 项目属性的的隐藏文件                |
  | .packages       | pub 工具需要使用的，包含 package 依赖的 yaml 格式的文件      |
  | flutter_app.iml | 工程文件的本地路径配置                                       |
  | pubspec.lock    | 当前项目依赖所生成的文件                                     |
  | pubspec.yaml    | 当前项目的一些配置文件，包括依赖的第三方库、图片资源文件等   |
  | README.md       | READEME文件                                                  |

## 2.2 Flutter UI风格

1. **Material**：Material Design是由谷歌推出的全新设计语言，这种设计语言旨在为手机、平板电脑、台式机和其他平台提供更一致、更广泛的外观和感觉。Material Design风格是一直非常有质感的设计风格，并会提供一些默认的交互动画，对于搞Android开发的来说应该耳熟能详了。MaterialApp代表使用Material Design风格的应用，里面包含了其他所需的基本控件。

   ```dart
   import 'package:flutter/material.dart';
   ```

2. **Cupertino**：Cupertino风格组件即IOS风格组件。主要有CupertinoTabBar、CupertinoPageScaffold、CupertinoTabScaffold、CupertinoTabView等。目前组件库还没有Material Design风格组件丰富。

   ```dart
   import 'package:flutter/cupertino.dart';
   ```

## 2.3 Widget概述

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>Flutter Widget采用现代响应式框架构建，这是从React中获得的灵感，中心思想是用widget构建你的UI。 Widget描述了他们的视图在给定其当前配置和状态时应该看起来像什么。当widget的状态发生变化时，widget会重新构建UI，Flutter会对比前后变化的不同， 以确定底层渲染树从一个状态转换到下一个状态所需的最小更改。

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>在Flutter中几乎所有的对象都是一个 widget，它不仅可以表示UI元素，也可以表示一些功能性的组件。在 Flutter中widget 的功能是“描述一个UI元素的配置信息（是 Widget 接收的参数）”，它就是说， Widget 其实并不是表示最终绘制在设备屏幕上的显示元素，而是根据配置信息最终生成Layer树然后显示。Flutter中根据Widget的布局绘制流程如下：

1. 根据 Widget 树生成一个 Element 树，Element 树中的节点都继承自 `Element` 类。
2. 根据 Element 树生成 Render 树（渲染树），渲染树中的节点都继承自`RenderObject` 类。
3. 根据渲染树生成 Layer 树，然后上屏显示，Layer 树中的节点都继承自 `Layer` 类。

**这里需要注意：**

1. 三棵树中，Widget 和 Element 是一一对应的，但并不和 RenderObject 一一对应。比如 `StatelessWidget` 和 `StatefulWidget` 都没有对应的 RenderObject。
2. 渲染树在上屏前会生成一棵 Layer 树

## 2.4 MaterialApp结构

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>一个最简单的Flutter应用程序，只需一个widget即可！如下面示例：将一个widget传给`runApp`函数即可。使用Material的UI风格，可以继承主题数，widget需要位于MaterialApp内才能正常显示， 因此我们使用MaterialApp来运行该应用。Material也是widget组件树组成一套UI风格，就好像html也是由不同html标签组成的DOM树，**所以学习Flutter主要是学习Material中的组件使用方式**；MaterialApp中的组件基本结构如下图：

<img src='https://s4.ax1x.com/2022/01/08/7PHXo8.png' width='80%'/>

- Scallold是Material中提供的基础的页面脚手架，包含Flutter应用主要展示的页面；

## 2.5 组件状态

1. 状态概述：项目开发中，通常根据是否需要进行数据交互分为有状态组件（StatefulWidget）和无状态组件（StatelessWidget）。widget的主要工作是实现一个build函数，用以构建自身。

2. 无状态组件：StatelessWidget

   ```dart
   class 组件类名 extends StatelessWidget {
     const 组件类名({Key? key}) : super(key: key);
   
     @override
     Widget build(BuildContext context) {
       return Container();
     }
   }
   ```

3. 有状态组件：StatefulWidget：可以在_State对象中定义需要交互的数据信息

   ```dart
   class 组件类名 extends StatefulWidget {
     const 组件类名({Key? key}) : super(key: key);
   
     @override
     _State createState() => _State();
   }
   
   class _State extends State<> {
     @override
     Widget build(BuildContext context) {
       return Container();
     }
   }
   ```

## 2.6 包管理

1. pubspec.yaml

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>在软件开发中，将代码单独抽到一个独立模块，项目需要使用时再直接集成这个模块，便可大大提高开发效率。一个 App 在实际开发中往往会依赖很多包，手动来管理应用中的依赖包将会非常麻烦。 Flutter 使用配置文件`pubspec.yaml`（位于项目根目录）来管理第三方依赖包。

```yaml
name: flutter_in_action
description: First Flutter Application.

version: 1.0.0+1

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^0.1.2

dev_dependencies:
  flutter_test:
    sdk: flutter
    
flutter:
  uses-material-design: true
```

> - `name`：应用或包名称。
> - `description`: 应用或包的描述、简介。
> - `version`：应用或包的版本号。
> - `dependencies`：应用或包依赖的其它包或插件。
> - `dev_dependencies`：开发环境依赖的工具包（而不是flutter应用本身依赖的包）。
> - `flutter`：flutter相关的配置选项。

2. Pub仓库

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>Pub（https://pub.dev/ ）是 Google 官方的 Dart Packages 仓库，类似于 node 中的 npm仓库。我们可以在 Pub 上面查找我们需要的包和插件，也可以向 Pub 发布我们的包和插件。使用方式

- 搜索支持Flutter的包以及对应的版本

- 将包添加到Flutter项目的配置文件中

  ```yaml
  dependencies:
    flutter:
      sdk: flutter
    # 新添加的依赖
    english_words: ^4.0.0
  ```

- 执行pub get命令将第三方包拉取到当前项目中

- 在dart项目中import对应的包（dart基础：每个dart文件就属于一个包，引入后可以使用非私有对象）

3. 其它依赖方式

   - 依赖本地包

     ```dart
     dependencies:
     	pkg1:
             path: ../../code/pkg1
     ```

   - 依赖Git -> 软件包位于仓库的根目录中

     ```dart
     dependencies:
       pkg1:
         git:
           url: git://github.com/xxx/pkg1.git
     ```

   - 依赖Git -> 软件包不在仓库的根目录中可以使用path参数指定相对位置
   
     ```dart
     dependencies:
       package1:
         git:
           url: git://github.com/flutter/packages.git
           path: packages/package1    
     ```

# 第三章 Material基础



## 3.1 AppBar

## 3.2 

## 3.3 路由管理

### 1. 路由概述

- Flutter路由说明

  - 路由（Route）在移动开发中通常指页面（Page），这跟 Web 开发中单页应用的 Route 概念意义是相同的，Route 在 Android中 通常指一个 Activity，在 iOS 中指一个 ViewController。所谓路由管理，就是管理页面之间如何跳转，通常也可被称为导航管理。Flutter 中的路由管理和原生开发类似，无论是 Android 还是 iOS，导航管理都会维护一个路由栈，路由入栈（push）操作对应打开一个新页面，路由出栈（pop）操作对应页面关闭操作，而路由管理主要是指如何来管理路由栈。
  - 管理多个页面时有两个核心概念和类：Route和 Navigator。 一个route是一个屏幕或页面的抽象，Navigator是管理route的Widget。Navigator可以通过route入栈和出栈来实现页面之间的跳转。

- 核心对象

  - Route：一个页面要想被路由统一管理，必须包装为一个Route；

    ```dart
    // push参数是一个Route,在Route的builder中包装一个组件
    Navigator.of(context)
      .push(MaterialPageRoute(
      	builder: (context) {
          return const 组件对象();
        }
      );
    ```

    > Route是一个抽象类，不能直接new，Route在不同的平台有不同的实现对应着不同的表现；对于material的表现是打开一个页面会从屏幕底部滑动到屏幕的顶部，关闭页面时从顶部滑动到底部消失；对于cupertino的表现是打开一个页面会从屏幕右侧滑动到屏幕的左侧，关闭页面时从左侧滑动到右侧消失

  - MaterialPageRoute和CupertinoPageRoute：Route的构造参数如下

    ```dart
    MaterialPageRoute({
      WidgetBuilder builder,
      RouteSettings settings,
      bool maintainState = true,
      bool fullscreenDialog = false,
    })
    ```

    > - builder： 是一个WidgetBuilder类型的回调函数，它的作用是构建路由页面的具体内容，返回值是一个widget。我们通常要实现此回调，返回新路由的实例。
    > - settings： 包含路由的配置信息，如路由名称、是否初始路由（首页）。
    > - maintainState：默认情况下，当入栈一个新路由时，原来的路由仍然会被保存在内存中，即设置为true
    > - fullscreenDialog：表示新的路由页面是否是一个全屏的模态对话框，在iOS中，如果fullscreenDialog为true，新页面将会从屏幕底部滑入（而不是水平方向）。

  - Navigator：是一个路由管理的组件，它提供了打开和退出路由页方法。Navigator通过一个栈来管理活动路由集合。通常当前屏幕显示的页面就是栈顶的路由。Navigator提供了一系列方法来管理路由栈开发中使用的MaterialApp、CupertinoApp、WidgetsApp它们默认是有插入Navigator的。所以，我们在需要的时候，只需要直接使用即可

    ```dart
    // 创建Navigator对象
    Navigator.of(context);
    
    // Navigator类中第一个参数为context的静态方法都对应一个Navigator的实例方法,等价方法
    Navigator.push(BuildContext context, Route route);
    Navigator.of(context).push(Route route)
    
    // 路由跳转：传入一个路由对象（返回值是一个Future对象，用以接收新路由出栈（即关闭）时的返回的数据）
    Future<T> push<T extends Object>(Route<T> route);
    
    // 路由跳转：传入一个名称（命名路由）
    Future<T> pushNamed<T extends Object>(
      String routeName, {
        Object arguments,
      })
    
    // 路由返回：可以传入一个参数，result为页面关闭时返回给上一个页面的数据。
    bool pop<T extends Object>([ T result ])
    ```

### 2. 简单路由

```dart
// 点击按钮跳转到其他路由
TextButton(onPressed: (){
          Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context){
                  return const ProductPage();
                }
              )
          );
        }, child: const Text("product")),
```

### 3. 命名路由

## 3.4 资源管理



# 第四章 基础组件

### 4.1 Flutter组件原理

1. Flutter内置了两种风格的UI库：①通用的Material组件②以iOS设计风格的Cupertino组件
2. Flutter应用的入口：在main方法中调用runApp()方法，运行传入的Widget组件作为Flutter应用的跟组件

### 4.2 Flutter基础组件

1. MaterialApp：作为Material风格的根组件，用于获取Material主题数据（因为许多Material风格的Widget在MaterialApp应用中才能正常显示）

### 4.3 布局组件

1. Flutter中布局概念：Flutter中几乎所有东西都是Widget，可见的文字、图片、图标等等，不可见的布局、模型等等；

2. 布局组件在Flutter中的作用：用来限制、排列可见的Widget，使可见的Widget在特定的行、列或者网格中显示，通过组装简单的Widget构建复杂的界面；

3. 容器组件

   | 组件类    | 作用                                                     |
   | --------- | -------------------------------------------------------- |
   | Container | 绘制、定位、调整大小                                     |
   | Row       | 水平方向排列子Widget组件列表                             |
   | Column    | 垂直方向排列子Widget组件列表                             |
   | GridView  | 可滚动的网格                                             |
   | ListView  | 可滚动的列表                                             |
   | Stack     | Widget覆盖在另一个Widget                                 |
   | Card      | 将相关信息整理到一个有圆角的阴影盒子中                   |
   | ListTitle | 将最多三行的文本、可选的导语以及后面的图标组织在一行中。 |

4. 常用组件

   | 组件类       | 作用         |
   | ------------ | ------------ |
   | Text         | 带样式的文本 |
   | Image        | 图片组件     |
   | Icon         | 图标组件     |
   | RaisedButton | 按钮组件     |
   |              |              |

5. 结构组件

   | 组件类      | 作用       |
   | ----------- | ---------- |
   | AlertDialog | 弹窗对话框 |
   |             |            |

   

6. Material App组件

   | 组件类   | 作用                                                         |
   | -------- | ------------------------------------------------------------ |
   | Scaffold | APP基本布局：用于显示drawer、snackbar和底部sheet的API        |
   | Appbar   | APP应用程序栏，由工具栏和其他可能的widget（如TabBar和FlexibleSpaceBar）组成 |
   |          |                                                              |

7. 其他

   | 组件类        | 说明                                                         |
   | ------------- | ------------------------------------------------------------ |
   | AbsorbPointer | 禁止用户输入的控件，如：按钮、输入框、滚动等等<br /> - 特点：`AbsorbPointer` 本身可以接收点击事件，消耗掉事件 |
   | IgnorePointer | IgnorePointer的用法和AbsorbPointer一样，而且达到的效果一样<br /> - 特点：`IgnorePointer`无法接收点击事件，其下的控件可以接收到点击事件 |
   | AlertDialog   | 弹窗                                                         |

   

# 第五章 布局组件

# 第六章 容器组件

# 第七章 滚动组件

# 第八章 功能组件

# 第九章 事件与通知

# 第十章 动画

# 第十一章 自定义组件

# 第十二章 文件操作与网络请求

# 第十三章 国际化

# 第十四章 Flutter核心原理

# 第十五章 Flutter项目总结

