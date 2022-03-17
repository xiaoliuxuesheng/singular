# 第一章 C语言概述

## 1.1 编程概述

## 1.2 C语言与发展历史

## 1.3 环境安装

1. Mac系统

   - 安装Homebrew：https://brew.sh/

   - 安装GCC

     ```sh
     brew install gcc
     ```

   - 查看GCC安装信息

     ```sh
     brew list gcc
     ```

   - 下载安装CLion

   - 配置CLion

     - C Complier：gcc
     - C++ Complier：g++

## 1.4 GCC概述

- gcc

  - gcc -v：查看版本
  - gcc -o 输出文件名 输入文件：编辑输入文本并输出结果，gcc根据输入文件的后缀名进行编译
  - gcc -v -o 输出文件 输入文件：打印GCC工作详细流程
  - gcc -I 查找头文件的目录：查找文件
  - gcc -D宏名：在gcc时候定义宏

- C语言编译过程

  - cc1：编译器
    - gcc -S：间接的调用了cc1
  - 汇编-as：将cc1编译结果交给as进行输出
    - gcc -C：间接的调用了as
  - 链接：生成可执行文件
    - gcc -o：完成编译》汇编》链接全部过程

- C语言预处理

  - #include：包含头文件

  - #define：宏(替换)，#define 宏名 宏体，替换过程不进行语法检查，会在编译的时候进行语法检查，给宏体加括号可以保证宏体的优先级

  - #define 宏函数：宏函数，所有宏名采用大写名称

  - #ifdef：`#ifdef 宏名`表示是否定义宏名，用`#endif`给`#ifdef`做结尾

    ```c
    #ifdef ABC
    	
    #endif
    ```

  - #else

  - #endif

  - 预定义宏：`__FUNCTION__`（函数名）、`__LINE__`（当前宏所在行号）、`__FILE__`（当前宏所在文件）：表示GCC中预定义好的

- 宏展开的#与##：主要的在定义宏体中的：不好理解，在后续再回头看

  - #X：表示将x字符串化
  - xx##yy：连接字符；表示将xx和yy连接

# 第二章 C语言基础

## 2.1 变量

## 2.2 数据类型

## 2.3 运算符

## 2.4 流程控制

# 第三章 函数

# 第四章 



