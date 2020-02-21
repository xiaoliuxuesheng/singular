# 第一章 Typescript入门

## 1.1 Typescript概述

- 是由微软开发的一个开源的**编程语言**
- 是JavaScript的超集, 对JavaScript的扩展, 包含的ES5 和 ES6
- 前端框架可以集成Typescript进行开发工作

## 1.2 安装Typescript

1. 安装Node.js

2. 安装Typescript

    ```sh
    npm install -g typescript
    ```

3. 安装yarn

    ```sh
    npm install -g yarn
    ```

## 1.3 配置并使用Typescript

1. 安装npm 和 yarn后IEDA会自动完成配置

2. 设置自动编译

    ```text
    setting > Typescript > Recomplile on Change
    ```

3. 初始化Typescript配置文件 : tsconfig.json

    ```sh
    tsc --init
    ```

4. 修改配置文件的编译文件路径

    ```text
    outDir 属性的值
    ```

5. 编译ts文件

    ```sh
    tsc ts文件名称
    ```

    > 编译完成会在编译文件路径输出一个js文件,可以用浏览器执行