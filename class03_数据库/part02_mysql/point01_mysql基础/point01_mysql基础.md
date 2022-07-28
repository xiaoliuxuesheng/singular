# 第一部分 MySQL基础篇

## 第一章 数据库基础

### 1.1 数据库概述

学习数据库首先要熟悉数据库支持的数据类型以及每种类型的特点，即数据类支持的运算；数据库内置了对数据操作的简单函数，掌握常用的函数会大大提高SQL能力；最重要的SQL操作是面对工作的基本要求；是DBA必经的过程；

### 1.2 MySQL发展历史

### 1.3 MySQL安装

1. Windows系统安装

   - 官网下载：https://dev.mysql.com/downloads/installer/
   - 安装msi版本：自定义选择service和workbatch

2. MacOS系统安装

3. Linux系统安装

4. Docker命令安装

   - 拉取MySQL镜像：https://hub.docker.com/_/mysql?tab=tags，如：拉取MySQL8的Docker镜像

     ```sh
     docker pull mysql:8.0.29
     ```

   - 执行Docker命令，运行MySQL容器

     ```sh
     docker run \
     --name mysql \
     -p 3306:3306 \
     -v D:/panda_docker_files/mysql/data:/var/lib/mysql \
     -v D:/panda_docker_files/mysql/config:/etc/mysql \
     -e MYSQL_ROOT_PASSWORD=root \
     -d <MySQL镜像ID>
     ```

   - 进入容器

     ```sh
     docker exec -it mysql /bin/sh
     ```

   - 登陆mysql

     ```sh
     mysql -uroot -p
     ```

   - 查询root用户登录权限

     ```sql
     select host,user,plugin,authentication_string from mysql.user;
     ```

   - 修改root权限

     ```sql
     ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'root';
     ```

5. DockerFile安装

   ```sh
   
   ```

6. DockeroCompose安装

   ```yaml
   
   ```

### 1.4 MySQL客户端

1. mysqld
2. Sqlyong
3. Navicat
4. DataGrip

## 第二章 MySQL基础

### 2.1 SQL语言概述

1. SQL（Structure Query Language）：结构化查询语言，是用于和数据库进行交互的一种语言；
2. SQL分类
   - DDL（Data Definition Language）：数据定义语言，作用是对数据库对象的定义：如数据库，数据表、列、索引等等；DDL包含的sql关键字包含：create、drop、alert；
   - DML（Data Manipulation Language）：数据库操作语言，作用是添加，删除，更新和查询数据库记录，并检查数据完整性；DML包含的SQL关键字包含：insert、update、delete、select；
   - DCL（Data Control Language）：数据库控制语言，作用是控制不同的数据段的许可级别和访问级别的语句：如定义数据库、表、字段不同用户的访问权限和安全级别；DCL包含的SQL关键字包含：grant、revoke。

### 2.2 数据类型

#### 1. 数值类型

| 类型             | 说明 |
| ---------------- | ---- |
| BIE              |      |
| TINYINT          |      |
| BOOL, BOOLEAN    |      |
| SMALLINT         |      |
| MEDIUMINT        |      |
| INT,INTEGER      |      |
| BIGINT           |      |
| DECIMAL          |      |
| DEC              |      |
| FLOAT            |      |
| DOUBLE           |      |
| DOUBLE PRECISION |      |



### 2.3 运算符

### 2.5 MySQL函数

## 第三章 MySql-Database

## 第四章 MySql-Table

## 第五章 MySql-查询

## 第六章 视图

## 第七章 存储过程

## 第八章 触发器

## 第九章 MySql 8 新特性

### 9.1 窗口函数

### 9.2 公用表达式





