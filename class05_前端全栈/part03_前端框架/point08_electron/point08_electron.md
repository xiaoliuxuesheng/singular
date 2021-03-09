- 学习内容
  1. 基础
     1. electron介绍：① 基础介绍②桌面技术选型③技术架构与原理
     2. 快速开始：①开发前准备②简单实战
     3. 和WEB开发的不同：①主进程和渲染进程②进程间通信③Native能力及原生GUI④释放前端想象力
  2. 项目实战
     1. 项目思路：需求分析、技术选型、技术关键点
     2. 具体实现：控制待实现、傀儡端实现、信令服务实现
  3. 工程化
     1. 项目落地基建：打包、软件更新、质量监控
     2. 工程化：保证安全、提升体验、Electron bad pard

# 第一章

1. 基本介绍：是由Github开发的允许开发者使用WEB技术构建跨平台桌面应用

   - electron = Chromium + Node.js + Native API

2. 特点

   1. 高效：通过WEB技术写UI
   2. 能力：底层技术，node、npm包等
   3. 体验：跨平台&原生能力

3. electron：发展历史：①1995第一款浏览器、②2002年火狐，2008谷歌浏览器③2011桌面端的开发，2015年开发electron

4. electron架构原理：

   - Electron是基于Chromium的，

     ![image-20210309193223338](C:\Users\xiaoliuxuesheng\AppData\Roaming\Typora\typora-user-images\image-20210309193223338.png)

   - Electron架构

     ![image-20210309193322746](C:\Users\xiaoliuxuesheng\AppData\Roaming\Typora\typora-user-images\image-20210309193322746.png)