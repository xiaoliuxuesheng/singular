# 第一章 Dart概述

## 1.1 Dart介绍

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>Dart是google于2011发布的计算机语言，其初衷是志向改变web开发的现状，主要是fix javascript的问题。随着时间的发展，Dart自身也经历了无数次的颠覆性迭代，几乎现代语言该有的特征Dart都有，比如async/await异步模式编程、完全内存隔离的isolate多线程编程范式、函数编程范式、面向对象编程范式、静态数据类型、JIT+AOT的编译优化等等。而Dart的生态，已经逐渐成型。虽然还不敢说超越Javascript，但是后起之势非常迅猛。而Flutter就是基于Dart语言的UI框架，可以快速在iOS和Android上构建高质量原生应用，最大特点是跨平台和高性能，Flutte涉及到各个主流平台的开发：

- 首先就是，flutter框架横扫APP，Android和iOS平台日臻完善。
- Flutter for web也已经合并到稳定版本，
- 桌面版Flutter的应用最早从MacOS开始，
- Linux平台的桌面版Fluuter应用也已官宣，
- windows版的桌面应用也正在加紧开发。
- Dart从没放弃server端的开发，Dart-Native是一个制霸后端的一个神器， Aqueduct已经在发力。

## 1.2 Dart特点

- Dart的金主，背靠Google，用于Dart统一前端，GO统一后端的野心。
- Dart的编程范式：是目前编程范式和语言覆盖面最广的语言，比Java更面向对象的一种编程语言。
- Dart的生态：目前，能够和FLutter比生态的，几乎没有。假以时日，Aqueduct的生态蓬勃而起，Dart的全栈时代就真的到来了。

## 1.3 Dart安装

- 基础环境准备
  - 操作系统是Windows或Mac，网络正常
  - 安装Git
  - 安装JDK
  - 安装编程工具：VSCode和Android Studio并安装Flutter插件；Mac系统需要安装Xcode
    - Android SDK：platform 29
    - Android 模拟器
  - 从Flutter1.21开始，FlutterSDK会完整的包含DartSDK
    - dart：执行dart代码文件
    - dart2js：dart转js
    - dartfmt：格式化dart代码
    - pub：dart包管理工具

1. Windows系统

   - 下载新版Flutter：https://docs.flutter.dev/get-started/install

   - 安装Flutter并配置Flutter环境变量和Dart环境变量

     ```sh
     
     ```

   - 配置Flutter国内镜像

     ```sh
     # 上海交大
     export PUB_HOSTED_URL=https://mirrors.sjtug.sjtu.edu.cn/dart-pub
     export FLUTTER_STORAGE_BASE_URL=https://mirrors.sjtug.sjtu.edu.cn
     # 清华大学
     export PUB_HOSTED_URL=https://mirrors.tuna.tsinghua.edu.cn/dart-pub
     export FLUTTER_STORAGE_BASE_URL=https://mirrors.tuna.tsinghua.edu.cn/flutter
     # OpenTUNA
     export PUB_HOSTED_URL=https://opentuna.cn/dart-pub
     export FLUTTER_STORAGE_BASE_URL=https://opentuna.cn/flutter
     # CNNIC
     export PUB_HOSTED_URL=http://mirrors.cnnic.cn/dart-pub
     export FLUTTER_STORAGE_BASE_URL=http://mirrors.cnnic.cn/flutter
     # 腾讯云
     export PUB_HOSTED_URL=https://mirrors.cloud.tencent.com/dart-pub
     export FLUTTER_STORAGE_BASE_URL=https://mirrors.cloud.tencent.com/flutter
     ```

   - Flutter命令查看可用模拟器

     ```sh
     flutter emulators
     ```

   - 启动模拟器

     ```sh
     flutter emulator --launch 查询到的模拟器名称
     ```

2. Mac系统

   - 安装Xcode

   - 下载新版Flutter：https://docs.flutter.dev/get-started/install

   - 安装Flutter并配置Flutter环境变量和Dart环境变量

     ```sh
     export DATR_HOME=/Users/panda/DevApps/source_app/env_flutter3.5/bin/cache/dart-sdk
     export PATH=$PATH:$DATR_HOME/bin
     export FLUTTER_HOME=/Users/panda/DevApps/source_app/env_flutter3.5
     export PATH=$PATH:$FLUTTER_HOME/bin
     ```

   - 配置Flutter国内镜像

     ```sh
     # 上海交大
     export PUB_HOSTED_URL=https://mirrors.sjtug.sjtu.edu.cn/dart-pub
     export FLUTTER_STORAGE_BASE_URL=https://mirrors.sjtug.sjtu.edu.cn
     # 清华大学
     export PUB_HOSTED_URL=https://mirrors.tuna.tsinghua.edu.cn/dart-pub
     export FLUTTER_STORAGE_BASE_URL=https://mirrors.tuna.tsinghua.edu.cn/flutter
     # OpenTUNA
     export PUB_HOSTED_URL=https://opentuna.cn/dart-pub
     export FLUTTER_STORAGE_BASE_URL=https://opentuna.cn/flutter
     # CNNIC
     export PUB_HOSTED_URL=http://mirrors.cnnic.cn/dart-pub
     export FLUTTER_STORAGE_BASE_URL=http://mirrors.cnnic.cn/flutter
     # 腾讯云
     export PUB_HOSTED_URL=https://mirrors.cloud.tencent.com/dart-pub
     export FLUTTER_STORAGE_BASE_URL=https://mirrors.cloud.tencent.com/flutter
     ```

   - 配置Android仓库地址：build.gradle

     ```groovy
     allprojects {
         repositories {
             google()
             jcenter()
             maven { url 'https://mirrors.tuna.tsinghua.edu.cn/flutter/download.flutter.io' }
         }
     }
     ```

   - 创建Flutter项目

     ```sh
     flutter create <项目名称>
     ```

   - 打开模拟器

     ```sh
     # 查看所有模拟器
     flutter emulators
     # 打开模拟器
     flutter emulator --launch 查询到的模拟器名称
     ```

## 1.4 Dart运行

1. Dart资源网站

   - 官网英文：https://dart.dev/
   - 官网中文：https://dart.cn/
   - 在线运行：https://dartpad.cn/
   - dart生态：https://pub.dev

2. 运行方式

   - 原生虚拟机：运行环境安装在Windows、Mac、Linux等操作系统
   - JavaScript引擎：Dart代码可以转为js代码并运行在浏览器上

3. Dart与JavaScript语言对比

   | 对比项     | Dart            | JavaScript        |
   | ---------- | --------------- | ----------------- |
   | 框架       | Flutter         | React、Vue。。。  |
   | 生态       | https://pub.dev | https://npmjs.con |
   | 包管理工具 | pub             | npm               |

## 1.5 Dart入门

1. Dart Hello World

   ```dart
   void main() {
     print('hello dart');
   }
   ```

2. Hello World说明

   - dart代码的入口是main函数

   - 使用dart命令运行dart代码

     ```sh
     dart xxx.dart
     ```

   - dart中每行代码结束符号是分号（;）

# 第二章 Dart基础

## 2.1 Dart规范

1. 注释

   - 单行注释

     ```dart
     // 单行注释
     ```

   - 多行注释

     ```dart
     /*
     	多行注释
     */
     ```

   - 文档注释：通过dartdoc将文档输出，并且支持markdown语法

     ```dart
     /// 文档
     /// 注释
     ```

2. Dart语法规范

   - dart中命名规范：字母、数字、下划线、$符号，并且可以使用数字开头；

## 2.2 Dart变量

1. Dart变量声明说明

   - 变量是一个引用：Dart是完全面向对象的，变量存储的也是变量的引用；
   - Dart中变量大小写敏感；
   - Dart中变量不会隐式类型转换：如null不会转为false，0也不会转为false（要和JS做区分）
   - 声明变量：
     - 明确指定类型：`变量类型 变量名称 = 变量值;`
     - 不明确指定类型：`var 变量名称 = 变量值;` 或者 `dynamic 变量名称 = 变量值;`

2. Dart声明变量语法

   - 使用`var`关键字来标识一个变量：是通过在变量名前加上数据类型前缀来支持类型检查

     ```dart
     var name = 'smith';
     ```

   - 使用数据类型加变量名：支持类型检查

     ```dart
     String name = 'Maxsu'; 
     int number = 99;
     ```

   - 变量初始值：未初始化的变量的初始值为`null`

     ```dart
     int num; 
     print(num);
     // 输出结果：Null
     ```

   - dynamic：声明没有未指定静态类型的变量则会隐式声明为 `dynamic` 

     ```dart
     void main() { 
        dynamic x = "tom"; 
        print(x);  
     }
     ```

   - final和const：`final`和`const`关键字用于声明常量

     ```dart
     const pi = 3.14; 
     final f = fun();
     ```

     > - `const`关键字用于表示编译时常量
     > - `final`关键字用于表示运行时常量

## 2.3 Dart数据类型

1. Number

   - 数据类型

     - num：数值类型，可以是小数也可以是整数
     - int：是num的亚类型，整数值不大于64位
     - double：是num的亚类型，值是64位（双精度）浮点数

   - 变量定义

     ```dart
     void main(List<String> args) {
       // 先定义 后赋值
       num price;
       price = 43.65;
       print(price);
     
       int age = 81;
       print(age);
     
       double money = 23.32;
       print(money);
     }
     ```

   - API

     | num API                       | 说明                                                        |
     | ----------------------------- | ----------------------------------------------------------- |
     | compareTo(比较值)             | 数值比较：相同返回0；大于返回1；小于返回-1                  |
     | abs()                         | 获取绝对值                                                  |
     | remainder(被除数)             | 当前值除以被除数后的余数                                    |
     | clamp(最小值,最大值)          | 当数值大于最大值或小于最小值,会取设定的边界值，否则取当前值 |
     | ceil()                        | 向上取整：获取不小于当前值的最小整数                        |
     | eilToDouble()                 | 向上取整：获取不小于当前值的最小整数，返回浮点数            |
     | floor()                       | 向下取整：获取不大于当前值的最大整数                        |
     | floorToDouble()               | 向下取整：获取不大于当前值的最大整数，返回浮点数            |
     | round()                       | 四舍五入：获取最接近当前值的整数                            |
     | roundToDouble()               | 四舍五入：获取最接近当前值的整数，返回浮点数                |
     | truncate()                    | 截断小数：保留整数                                          |
     | truncateToDouble()            | 截断小数：保留整数再返回浮点数                              |
     | toInt()                       | 转换为整数：去掉小数保留整数                                |
     | toDouble()                    | 转换为浮点数                                                |
     | toString()                    | 转为字符串                                                  |
     | toStringAsFixed(小数位数)     | 保留当前值的指定小数位并返回为字符串                        |
     | toStringAsPrecision(数值位数) | 保留当前值的指定位数，四舍五入后返回字符串                  |
     | **int API**                   | **说明**                                                    |
     | gcd(数值)                     | 获取和当前值和参数值的最大公约数                            |
     | modInverse(3)                 | 求模逆运算                                                  |
     | modPow(3,5)                   | 先进行逆运算再求模运算：3次方后除以5取余数                  |
     | toSigned(2)                   |                                                             |
     | toUnsigned(3)                 |                                                             |
     | toRadixString(2)              |                                                             |
     | **double API**                | **说明**                                                    |
     |                               |                                                             |

2. String

   - 数据类型：String是一组 UTF-16 单元序列。 字符串通过单引号或者双引号创建。使用连续三个单引号或者三个双引号实现多行字符串对象的创建。字符串可以通过 ${expression} 的方式内嵌表达式

     > == 运算符用来测试两个对象是否相等
     >
     > 用 + 运算符来把多个字符串连接为一个

   - 变量定义: ①特殊符号有效②可以通过${}引用变量

     ```dart
     void main(List<String> args) {
       // 单引号
       var obj = "----变量";
       String str1 = '单引号声明字\t符串${obj}';
       print(str1);
     
       // 双引号
       String str2 = "双引号声明的字\t符串${obj}";
       print(str2);
     
       // 三个单引号
       String str3 = '''
         可以定义
         格式\t化
           的字符串 ${obj}
       ''';
       print(str3);
     }
     ```

   - API

     | 常用API                         | 说明                   |
     | ------------------------------- | ---------------------- |
     | +                               | 字符拼接               |
     | split(分隔符)                   | 根据分隔符分隔字符串   |
     | trim()                          | 截取字符串前后空格     |
     |                                 |                        |
     |                                 |                        |
     | isEmpty()                       | 判断字符串是否为空     |
     | replaceAll(源字符串,替换字符串) | 字符串替换             |
     | contains(字符串)                | 判断是否包含字符串     |
     | indexOf(字符)                   | 查询字符串中字符的位置 |

3. Boolean

   - 数据类型：bool 类型。只有字面量 true and false 是布尔类型

   - 变量定义

     ```dart
     void main(List<String> args) {
       bool flag1 = true;
       print(flag1);
     }	
     ```

   - API

     | 常用API | 说明 |
     | ------- | ---- |
     |         |      |

4. List (也被称为 Array)

   - 数据类型：Array就是list对象

   - 变量定义

     ```dart
     void main(List<String> args) {
       // list 字面量: 不限制集合中元素类型
       List l1 = ["aa", 11];
       print(l1);
       // list 字面量: 限制集合总元素类型
       List l2 = <int>[1, 2, 3];
       print(l2);
       // 构造函数: 创建不限制长度的空集合
       List l3 = new List.empty(growable: true);
       print(l3);
       // 构造函数: 声明指定函数 并填充列表
       List l4 = List.filled(5, "填充值");
       print(l4);
       // List扩展操作符
       List l5 = [1, ...l2];
       print(l5);
       // ?... 可选扩展运算符
       var l6;
       List l7 = [1, ...?l6];
       print(l7);
     }
     ```

   - 常用API 

     | 常用API         | 说明                                                 |
     | --------------- | ---------------------------------------------------- |
     | length          | 属性: 长度                                           |
     | reversed()      | 反转                                                 |
     | insert(下标,值) | 在指定下标添加指定值                                 |
     | allAll()        | 添加其他集合到当前集合                               |
     | clear()         | 清空列表                                             |
     | remove(元素)    | 删除元素                                             |
     | removeAt(下标)  | 删除指定索引的元素                                   |
     | isEmpty()       | 判断列表是否为空                                     |
     | join(连接符)    | 将列表根据分隔符连接为字符串                         |
     | map()           | 迭代映射，java stream的map                           |
     | where()         | 将集合中符合条件的返回组成新集合，java stream的flter |
     | any()           | 迭代判断集合中是否有指定条件约束的，java stream的any |
     | every()         | 判断集合中是否全部是指定条件，java stream的every     |
     | extend()        | 扩展集合, java的flitMap                              |
     | fold()          | 折叠，java stream的reduce 规约                       |

5. Map

   - 数据类型：Map是一个无序的键值对映射的集合

   - 变量定义

     ```dart
     void main(List<String> args) {
       // 字面量创建Map
       Map m1 = {"key1": 1, "key2": "value2"};
       print(m1);
       // Map构造函数
       Map m2 = new Map();
       m2["key1"] = 2;
       m2["key2"] = "value2";
       print(m2);
     }
     ```

   - API

     | 常用API              | 说明                |
     | -------------------- | ------------------- |
     | keys                 | 属性: 获取所有key   |
     | values               | 属性: 获取所有value |
     | remove(key)          | 删除指定Key         |
     | removeWhere()        | 根据条件删除        |
     | containsKey(key)     | 判断key是否存在     |
     | containsValue(value) | 判断值是否存在      |
     | putIfAbsent()        | 如果值不存在则添加  |

6. Set

   - 数据类型：Set是一个无序的，元素唯一的集合，Set无法通过下标取值

   - 变量定义

     ```dart
     void main(List<String> args) {
       // 字面量
       Set s1 = <int>{1, 1, 2, 3};
       print(s1);
       // 构造函数
       Set s2 = new Set();
       s2.add(3);
       print(s2);
       // 根据List转Set并去掉重复
       List list = [1, 2, 3];
       Set s3 = list.toSet();
       print(s3);
     }
     ```

   - API

     | 常用API               | 说明           |
     | --------------------- | -------------- |
     | first                 | 属性: 第一个   |
     | last                  | 属性: 最后一个 |
     | intersection(Set集合) | 求交集         |
     | union(Set集合)        | 求并集         |
     | difference(Set集合)   | 求差集         |

7. Rune (用于在字符串中表示 Unicode 字符)

   - 数据类型：符号类型对象，是一个32位字符对象，可以把文字转换为符号表情或特定的文字

   - 变量定义：https://copychar.cc

     ```dart
     print("\u{1f44d}");
     ```

   - API

     | 常用API | 说明 |
     | ------- | ---- |
     |         |      |

8. Symbol

   - 数据类型：是Dart中用#开头表示的标识符

   - API

     | 常用API | 说明 |
     | ------- | ---- |
     |         |      |

## 2.4 Dart运算符

1. Dart运算符优先级

   | 描述           | 运算符                                                       |
   | -------------- | ------------------------------------------------------------ |
   | 一元后缀       | expr++ 、 expr– 、 () 、 [] 、 .                             |
   | 一元前缀       | -expr 、 !expr 、 ~expr 、 ++expr 、 –expr                   |
   | 乘法           | * 、 / 、 % 、 ~/                                            |
   | 加法           | \+ 、 -                                                      |
   | 移位           | << 、 >>                                                     |
   | 按位与         | &                                                            |
   | 按位或         | \|                                                           |
   | 关系和类型判断 | >= 、 > 、 <= 、 < 、 as 、 is 、 is!                        |
   | 相等           | == 、 !=                                                     |
   | 逻辑与         | &&                                                           |
   | 逻辑或         | \|\|                                                         |
   | 条件式         | expr1 ? expr2 : expr3                                        |
   | 级联           | ..                                                           |
   | 赋值           | = 、 = 、 /= 、 ~/= 、 %= 、 += 、 -= 、 <<= 、 >>= 、 &= 、 ^= 、 |

2. 算术运算符

   | 运算符 | 意义                         |
   | ------ | ---------------------------- |
   | +      | 加法                         |
   | -      | 减法                         |
   | -expr  | 取反，或称否定（反向表达式） |
   | *      | 乘法                         |
   | /      | 除法                         |
   | ~/     | 整除                         |
   | %      | 模运算，取整除后的余         |

3. 赋值运算符

   | 运算符 | 意义                       |
   | ------ | -------------------------- |
   | ++var  | var = var + 1（执行前加1） |
   | var++  | var = var + 1（执行后加1） |
   | –var   | var = var - 1（执行前减1） |
   | var–   | var = var - 1（执行后减1） |
   | =      |                            |
   | -=     |                            |
   | /=     |                            |
   | %=     |                            |
   | >>=    |                            |
   | ^=     |                            |
   | +=     |                            |
   | *=     |                            |
   | ~/=    |                            |
   | <<=    |                            |
   | &=     |                            |
   | \|=    |                            |

4. 关系运算符

   | 运算符 | 意义     |
   | ------ | -------- |
   | ==     | 等于     |
   | !=     | 不等于   |
   | >      | 大于     |
   | <      | 小于     |
   | >=     | 大于等于 |
   | <=     | 小于等于 |

5. 类型运算符

   ```dart
    //用 obj is T 这个语法可以判断obj是否实现了T
   if (emp is Person) {
     emp.firstName = 'Bob';
   }
   //使用as运算符检查
   (emp as Person).firstName = 'Bob';
   ```

6. 逻辑运算符

   | 运算符 | 意义                         |
   | ------ | ---------------------------- |
   | !expr  | 反转表达式，假为真，反之亦然 |
   | \|\|   | 逻辑或                       |
   | &&     | 逻辑与                       |

7. 按位和位移运算符

   | 运算符 | 意义                       |
   | ------ | -------------------------- |
   | &      | 与                         |
   | \|     | 或                         |
   | ^      | 异或                       |
   | ~expr  | 按位补码（0成为1；1变成0） |
   | <<     | 左移位                     |
   | >>     | 右移位                     |

8. 其它运算符

   | 运算符                | 名称             | 意义                                    |
   | --------------------- | ---------------- | --------------------------------------- |
   | ()                    | 函数应用         | 表示一个函数调用                        |
   | []                    | 访问列表         | 在列表中索引指定值                      |
   | expr1 ? expr2 : expr3 | 条件式           | 如果expr1为真，执行expr2，否则执行expr3 |
   | ?? \| ??=             | 避空运算符       | 属性不存在就不访问                      |
   | ?.                    | 成员属性条件访问 | 获取对象成员                            |
   | .                     | 成员访问         | 选择对象的成员，例如foo.bar             |
   | ..                    | 级联             | 对对象的成员执行多个操作                |

## 2.5 流程控制

1. 分支控制语句
2. 循环语句
   - for：
   - for-in：
   - forEach：
   - 
3. 循环控制语句

# 第三章 Dart函数

## 3.1 函数声明

- 函数声明：直接声明，声明方式同Java

  ```dart
  // 函数声明格式
  返回值类型 函数名称([形参列表]){
    函数体;
    [return 返回值;]
  }
  // 函数调用
  函数名称(实参列表);
  ```

- 箭头函数：函数的简写形式，Dart红箭头函数体只能有一行

  ```dart
  var list = [1, 3];
  list.forEach((element) => {print(element)});
  ```

- 自调用函数：类似JavaScript函数的自调用函数

  ```dart
  // 立即执行函数需要定义在main函数内部
  ((int param) {
      print(param); 
  })(34);
  ```

- 匿名函数

  ```dart
  // 匿名函数声明
  var 函数名称 = ([形参列表]){
  	函数体;
    [return 返回值;]
  };
  ```

## 3.2 函数参数

- 必填参数：

  ```dart
  // 定义函数 添加基本类型参数
  函数返回值 函数名(参数类型 参数名称,...){
  	[return 返回值;]
  }
  // 函数调用
  函数名(形参);
  ```

- 可选参数：可选参数定义在中括号中，可选参数要赋初始值或者将可选参数类型设置为dynamic；

  ```dart
  // 定义函数 添加基本类型参数
  函数返回值 函数名(参数类型 参数名称,..., [参数类型 参数名 = 默认值]){
  	[return 返回值;]
  }
  // 函数调用 - 可以不给可选参数传值
  函数名称(必填参数,...);
  函数名称(必填参数,...,可选参数);
  ```

- 命名参数：命名参数定义在大括号中

  ```dart
  // 定义函数
  函数返回值 函数名(参数类型 参数名称,..., {参数类型 参数名称 = 默认值}){
  	[return 返回值;]
  }
  // 命名参数调用
  函数名称(必填参数,...,命名参数名称:参数值);
  ```

- 函数参数

  ```dart
  void myPrint(String str) {
    print("自定义输出函数" + str);
  }
  // 定义函数时候, 函数参数是一个函数
  void test(String test, var fun) {
    fun(test);
  }
  void main(List<String> args) {
    // 调用函数时候, 将函数作为参数传递
    test("aaa", myPrint);
  }
  ```

## 3.3 作用域

1. 作用域

   - 指的是一对大括号中定义的变量，只用于当前大括号中

   - 作用域有作用域链：①内层可以访问外层②内层优先级高于外层

2. 闭包：

   - Dart中闭包的实现方式和JavaScript相同：①全局变量容易被污染② 局部变量作用范围小

   - 闭包的作用：既能重用变量，并且需要这个变量不被污染；

   - 闭包原理：外层函数被调用后，外层函数的作用域对象被内层函数引用者，导致外层函数的作用域对象无法被释放，从而形成闭包；

     ```dart
     void main(List<String> args) {
       var p = parent();
       // 多次调用闭包函数 函数中的变量可以全局调用
       p();
       p();
     }
     
     parent() {
       var money = 1000;
       return () {
         money -= 100;
         print(money);
       };
     }
     ```

     

## 3.4 异步函数

 1. 异步函数概述

    - 在JavaScript中异步函数是通过Promise实现的：async函数返回一个Promise，await用于等待Promise
    - 在Dart中的异步函数通过Future实现的：async函数返回一个Future，await用于等待Future

 2. 异步函数实现方式：测试案例-https://httpbin.org/ip

    - then

      ```dart
      // import 引入http包
      import 'package:http/http.dart' as http;
      Future getIp() {
        var url = Uri.parse('https://httpbin.org/ip');
        return http.get(url).then((resp) {
          return resp.body;
        });
      }
      void main(List<String> args) {
        // then方式
        // https://httpbin.org/ip
        getIp().then((value) => {print(value)}).catchError((er) {
          print(er);
        });
      }
      ```

    - await：函数声明后需要使用async关键字修饰函数

      ```dart
      // import 引入http包
      import 'package:http/http.dart' as http;
      Future getIpAsync() async {
        var url = Uri.parse('https://httpbin.org/ip');
        final response = await http.get(url);
        return response.body;
      }
      void main(List<String> args) {
        getIpAsync().then((value) => print(value)).catchError((e) {
          print(e);
        });
      }
      ```

# 第四章 类

## 4.1 Dart类概述

1. 类和对象：类是对象的抽象，对象是类的实例，是new关键字实现对象的创建；

2. 类的声明：使用class关键字声明的，包含了属性和方法

   - 属性：用来描述类的变量
   - 方法：类中定义的函数称为方法

3. 类的定义

   ```dart
   class Persion {
     // 类的属性
     String name;
   
     // 构造函数1:默认构造函数 与类同名的函数
     Persion() {
       print("========被new出了一个对象");
     }
   
     // 构造函数2: 命名构造函数
     Persion.name(String name) {
       this.name = name;
     }
   	// 构造函数3: 命名构造函数
     Persion.simple(this.name);
   
     // 类的方法
     void pringName() {
       print(this.name);
     }
   }
   
   void main(List<String> args) {
     var p1 = new Persion();
     p1.name = "test";
     print(p1.name);
     p1.pringName();
   
     var p2 = new Persion.name("name");
     print(p2.name);
   
     var p3 = new Persion.simple("simple");
     print(p3.name);
   }
   
   ```

## 4.2 构造函数

1. 默认构造函：与类名同名的函数，和Java的构造函数相同，实例化对象的时候会调用构造函数

   ```dart
   class Persion {
     // 类的属性
     String name;
   
     // 构造函数:默认构造函数 与类同名的函数
     Persion() {
       print("========被new出了一个对象");
     }
   }
   ```

2. 默认构造函数简写：构造函数中定义参数可以简写

   ```dart
   class Persion {
     // 类的属性
     String name;
   
     // 构造函数:默认构造函数 与类同名的函数
     Persion(this.name);
   }
   ```

3. 命名构造函数：在dart中构造函数不能重载，但是dart提供了命名构造函数，不同命名的函数可以定义不同的参数

   ```dart
   class Persion {
     // 类的属性
     String name;
   
     // 构造函数2: 命名构造函数
     Persion.name(String name) {
       this.name = name;
     }
   }
   void main(List<String> args) {
     var p2 = new Persion.name("name");
     print(p2.name);
   }
   ```

4. 命名构造函数：简写

   ```dart
   class Persion {
     // 类的属性
     String name;
   	// 构造函数3: 命名构造函数
     Persion.simple(this.name);
   }
   void main(List<String> args) {
     var p3 = new Persion.simple("simple");
     print(p3.name);
   }
   ```

5. 常量构造函数：如果类创建的对象不会改变的话，会使用到常量类（java中的单例概念）

   > - 常量类中的属性必须是final
   > - 常量构造函数的标识是使用const修饰
   >   - 声明不可变对象：必须声明的new一个const对象

   ```dart
   class Point {
     // 常量类中属性必须是final
     // 常量类中不允许有
     final num x;
     final num y;
     const Point(this.x, this.y);
   }
   void main(List<String> args) {
     var p1 = new Persion("aa");
     var p2 = new Persion("aa");
     print(p1 == p2); // false：new对象没有使用const
   
     var po1 = new Point(1, 2);
     var po2 = new Point(2, 3);
     var po3 = new Point(2, 3);
     print(po1 == po2); // false
     print(po2 == po3); // false
     
     // 声明不可变对象必须是const
     var po4 = const Point(3, 4);
     var po5 = const Point(3, 4);
     print(po4 == po5); // true
   
     var p6 = Persion("aa");
     var p7 = Persion("aa");
     print(p6 == p7); // false：省略new关键字，不使用const关键，常量构造函数可以当做普通构造函数
   }
   ```

6. 工厂构造函数：通过factory声明，工厂函数不会自动创建实例，而是通过代码来决定返回的实例

   > - 对象的构建是在工厂构造函数中完成，工厂构造函数返回的是已经new出来的对象

   ```dart
   class Person {
     String name;
   
     static Person instance;
     factory Person([String name = '']) {
       if (Person.instance == null) {
         instance = new Person.self(name);
       }
       return instance;
     }
   
     Person.self(this.name);
   }
   ```

7. 重定向构造函数

   - 调用当前构造函数时候调用其他构造函数，Java中的构造函数的用法；

## 4.3 访问修饰符

1. Dart访问修饰符概述

   - 在dart中默认的访问修饰符是公开的：即public
   - 如果属性或方法是以下划线开头（_）表示是私有属性：和Python语法相同

2. static修饰符

   - 通过static修饰的属性是实例属性：直接使用类名调用（同Java）
   - 通过static修饰的方法是实例方法：直接使用类名调用（同Java）

3. 访问修饰符

   ```dart
   class Person {
     // 缺省表示 public
     // _开头表示私有
     String _name;
   
     // get set
     int _age;
   
     Person(this._name);
   
     String getName() {
       _wife();
       return this._name;
     }
   
     void _wife() {
       print("没有媳妇");
     }
   }
   ```

## 4.4 get/set

1. get/set概述：私有属性外部不能访问，需要提供get/set方法让外部修改私有属性

   - get：通过get关键字修饰发方法，函数没有小括号，访问get方法时候也不需要小括号
   - set：通过set关键字修饰的方法，访问时候向设置属性赋值一样给set函数传参

2. get/set定义

   ```dart
   class Person {
     // get set
     int _age;
     
     // get 方法不能用小括号
     int get age {
       return this._age;
     }
   
     // set 方法
     set age(num age) {
       this._age = age;
     }
   }
   void main(List<String> args) {
     Person person = new Person();
     // 访问get方法
     int a = person.age
     // 设置set方法
     person.age = 23;
   }
   ```

## 4.5 初始化列表 

1. 初始列表概述

   - 作用：在构造函数中设置属性的默认值
   - 时机：在构造函数体执行前执行
   - 语法：使用逗号分隔初始化表达式
   - 功能：常用于设置final常量的值

2. 初始化列表：重定向构造函数

   ```dart
   class Person {
     num weight;
     num height;
     // 初始化列表 给类中的属性赋值
     Person() : height = 3,weight = 10 {
       print("height = $height,weight=$weight");
     }
     // 重定向构造函数
     Person.we(int weight) {
       this.weight = weight;
       this.height = 100;
     }
   
     Person.toWe(int hei) : this.we(hei);
   }
   
   void main(List<String> args) {
     var p1 = new Person();
     print(p1);
   
     var p2 = new Person.toWe(23);
     print(p2.weight);
     print(p2.height);
   }
   
   ```

## 4.6 元数据

1. 元数据概述

   - 元数据是@开头的（Java中的注解），可以给代码标记一些额外的信息
   - 元数据可以用来标记：类、对象、方法、属性、参数或变量

2. Dart内置的元数据

   | 元数据     | 功能                                 |
   | ---------- | ------------------------------------ |
   | @override  | 给方法添加，表示重新了父类中同名方法 |
   | @require   | 用来标记命名参数：表示是必填参数     |
   | @deprecate | 弃用                                 |

3. 自定义元数据


## 4.7 继承

1. 继承概述

   - 子类通过extends关键字继承父类
   - 子类可以使用父类中可见的内容
   - 子类中可以通过@override元数据标记覆写的方法
   - 在子类中可以通过super关键字引入父类中的可见内容

2. 继承案例

   ```dart
   // 定义父类
   class Animal {
     String name;
   
     Animal(this.name);
   
     void eat() {
       print("${this.name}正在吃东西");
     }
   }
   // 子类 extends 父类
   class Dog extends Animal {
     // 继承父类构造函数: 构造函数重定向
     Dog(String name) : super(name);
   
     @override
     void eat() {
       print("Dog的名字是${this.name}, 正在吃东西");
     }
   }
   
   void main(List<String> args) {
     Animal dog = new Dog("泰迪");
     dog.eat();
   }
   ```

## 4.8 抽象类

1. 抽象类概述

   - 抽象类是用abstract修饰的类
   - 抽象类的作用：充当普通类的模板，在抽象类中可以定义子类必要的属性或方法
     - 抽象类中可以定义抽象方法或普通方法
     - 抽象类不能被实例化，需要通过子类继承抽象类，new子类的实例对戏
     - 抽象类可以充当接口被实现：被实现后普通方法的方法体无效；
   - 抽象方法：必须定义在抽象类中，抽象方法没有方法体，子类必须重写抽象方法

2. 抽象类案例

   ```dart
   // 抽象类
   abstract class Phone {
     void camera();
     
     void info() {
       print("定义在抽象类总的普通方法");
     }
   }
   
   class XiaoMi extends Phone {
     @override
     void camera() {
       print("20万像素");
     }
   }
   
   void main(List<String> args) {
     Phone phone = new XiaoMi();
     phone.camera();
   }
   ```

## 4.9 接口

1. 接口概述

   - Dart中普通类可以当做一个接口，一般使用抽象类作为接口；
   - 一个类可以实现多个接口，多个接口用逗号分隔，implements关键字表示是实现接口
   - 普通类实现接口必须实现接口类中所有的属性和方法

2. 接口案例

   ```dart
   abstract class Phone {
     String brand;
     String name;
   
     void camera() {
       print("手机的像素");
     }
   }
   
   class XiaoMi implements Phone {
     // 实现所有属性
     @override
     String brand;
     @override
     String name;
   
     // 实现所有方法
     @override
     void camera() {
       print("小米手机像素20万");
     }
   }
   
   void main(List<String> args) {
     Phone phone = new XiaoMi();
     phone.camera();
   }
   ```

## 4.10 混入

1. 混入概述： 混入是一段公共代码

   - 将类当做混入：
     - 作为Mixin的类只能继承自Object，不能继承其他类
     - 作为Mixin的类不能有构造函数
   - 通过minxin关键字声明一个混入
   - 后引入的混入会覆盖前引入的混入的相同代码

2. 混入的作用：提搞代码复用率，普通类可以通过with来使用混入，并且可以使用多个混入，弥补了单继承的缺陷

3. 混入案例

   ```dart
   mixin MixA {
     String name;
   }
   
   mixin MixB {
     String name;
     int age;
   }
   
   class Person with MixA, MixB {}
   
   void main(List<String> args) {
     Person person = new Person();
     print(person);
   }
   ```

## 4.11 泛型

1. 泛型概述：类型参数化，泛型定义是在尖括号中定义泛型标识作为类型使用；

2. 泛型函数

   ```dart
   返回类型 函数名<泛型>(参数类型 参数){
     函数体
   }
   // 案例
   T getData<T>(T val){
     return val;
   }
   ```

3. 泛型类

   ```dart
   class Type<T> {
     T name;
   
     Type(this.name);
     T getName() {
       return this.name;
     }
   }
   
   void main(List<String> args) {
     Type<String> type = new Type("222");
     print(type.name);
   
     Type<int> typeInt = new Type(222);
     print(typeInt.name);
   }
   ```

4. 泛型接口

   ```dart
   abstract class Cache<T> {
     T getvalue(String key);
     void putValue(String key, T value);
   }
   ```
   
4. 泛型限制：用于限制泛型类型，类型java泛型的extends和supper

   ```dart
   abstract class Cache<T extends 其他类型> {
     T getvalue(String key);
     void putValue(String key, T value);
   }
   ```

## 4.12 枚举

1. 枚举概述：

   - 是数量固定的常量值
   - 通过enum关键字声明

2. 枚举定义

   ```dart
   enum Color { BLACK, BLUE }
   
   void main(List<String> args) {
     // 获取枚举常量列表
     List<Color> values = Color.values;
     print(values);
     // 通过下标访问枚举常量
     Color c1 = Color.values[1];
     print(c1);
     // 枚举常量的index值
     print(Color.BLACK.index);
   }
   ```

# 第五章 包

## 5.1 简介

1. 库：dart中库就是具有特定功能的模块：可能包含单个文件，也可能包含多个文件

2. 库的分类

   - 自定义库：是指开发者在项目中自定义开发的
   - 系统库：Dart JDK中自带的库
   - 第三方库：是指维护在Dart生态中的库（https://pub.dev）

3. pub命令：包信息维护在pubspec.yaml中

   | pub命令  | 描述             |
   | -------- | ---------------- |
   | get 包名 | 下载指定名称的库 |

## 5.2 自定义库

1. 通过library声明库：

   - 在开发中每个dart文件都默认是一个库，只是没有使用library显示声明

     ```dart
     library main;
     
     void main(List<String> args) {
       print("Hello Dart");
     }
     ```

   - Dart中使用下划线（_）开头的标识符，表示库内访问可见

   - 使用librar关键字声明库规范：建议使用小写字母加下划线

2. 通过import引入库：import("库的位置/库的名称")

   - 先定义一个库（dart文件）：Person.dart，

     ```dart
     // 定义库名称 可以省略
     library Person;
     
     class Person {
       String name;
       int age;
     
       Person(this.name, this.age);
     }
     ```

   - 再另外定义一个库并import自定义的库：Main.dart

     ```dart
     import './Person.dart';
     
     void main(List<String> args) {
       Person person = new Person("name", 23);
       print(person.name);
     }
     ```

3. 引入部分库：表示按需加载

   - show：包含引入
   - hide：排除引入

   ```dart
   // 定义库文件lib/Common.dart
   void f1() {
     print("f1");
   }
   
   void f2() {
     print("f2");
   }
   
   void f3() {
     print("f3");
   }
   // 按需加载:
   import './lib/Common.dart' show f1, f2;
   
   void main(List<String> args) {
     f1();
     f2();
   }
   ```

4. 引入冲突：引入多个库但是存在相同命名，通过as关键字声明一个库的前缀

   ```dart
   import './lib/Common.dart' as Commn;
   import './lib/Person.dart' as Person;
   
   void main(List<String> args) {
     Commn.f1();
     Person.f1();
   }
   ```

5. 延迟引入：懒加载通过deferred as关键字来表示需要延迟加载的库，只是建立了文件直接的关系，实际引入的时候需要调用loadLibrary函数 

   ```dart
   import './lib/Common.dart' deferred as Commons;
   
   void main(List<String> args) {
     lazy();
   }
   
   // loadLibrary返回Future
   Future lazy() async {
     await Commons.loadLibrary();
     Commons.f1();
   }
   ```

6. part与part of

   - 在Dart中单个文件可以作为一个库，如果一个库的内容过于多，需要将库拆分为多个文件，需将这这些文件声明为库的一部分

     ```dart
     // 主库：util
     library util;
     part "sub1.dart";
     part "sub2.dart";
     
     // 分库1：sub1.dart
     part of util
     
     // 分库2：sub2.dart
     part of util;
     
     // 引入主库即可使用主库中的分库信息
     import "./util.dart";
     ```

## 5.3 系统库

1. 系统库的引入：dart内置的，import前缀是dart，默认引入的是dart:core

   ```dart
   import 'dart:math';
   
   void main(List<String> args) {
     print(pi);
   }
   ```

## 5.4 第三方库

1. 第三方库的来源：https://pub.dev

2. 第三方库使用

   - 在项目中创建库管理文件：pubspec.yaml
   - 命令行进入到管理文件所在目录，使用pub get命令进行安装

3. import第三方库：import 是package开头

   ```dart
   import 'package:http/http.dart' as http;
   ```
