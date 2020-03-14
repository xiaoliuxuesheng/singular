<img src='data:image/png;base64,'/>

# 第一篇 数据库安全篇

# 第二篇 数据库基础篇

## 第三章 熟悉数据库

### 3.1 数据库模型

### 3.2 数据库相关术语

### 3.3 数据库范式

## 第四章 SQL基础

### 4.1 Oracle数据类型

### 4.2 Oracle常用操作符

## 第五章 Oracle内置函数

### 5.1 数值型函数

### 5.2 字符型函数

### 5.3 日期型函数

### 5.4 转换函数

### 5.5 Null函数

### 5.6 集合函数

### 5.6 其他函数

## 第六章 SQL语法

### 6.1 DDL-数据定义语言

> DDL主要包括数据库对象的创建（create）、删除（drop）、修改（alert）

#### <font size=4 color=blue>★ 表对象的DDL</font>

- **CREATE**

  ```sql
  -- 基本格式
  create table 表名(
  	字段名称 数据类型 [null|not null],
      ...
      [constraints]
  );
      -- 表名：在同一库中的表名是不可以重复的
      -- 字段名：在同一表中的字段名称是不可以重复的
      -- 数据类型：有的数据类型需要指定所占的字节长度
      -- [null|not null]：可选条件，约定字段是否允许为空
      -- [constraints]：设置约束，需要为每个约束命名
      
  -- 案例
  
  ```

- **DROP**

  ```sql
  
  ```

- **ALERT**

  ```sql
  
  ```

#### <font size=4 color=blue>★ 字段对象的DDL</font>

- **CREATE**

  ```sql
  
  ```

- **DROP**

  ```sql
  
  ```

- **ALERT**

  ```sql
  
  ```

#### <font size=4 color=blue>★ 约束对象的DDL</font>

- **CREATE**

  ```sql
  
  ```

- **DROP**

  ```sql
  
  ```

- **ALERT**

  ```sql
  
  ```

#### <font size=4 color=blue>★ 索引对象的DDL</font>

- **CREATE**

  ```sql
  
  ```

- **DROP**

  ```sql
  
  ```

- **ALERT**

  ```sql
  
  ```

### 6.2 DML-数据操作语言

### 6.3 DQL-数据查询语言

### 6.4 DCL-数据控制语言

## 第七章 pl/sql基础

## 第八章 游标

## 第九章 视图

## 第十章 存储过程

## 第十一章 触发器

## 第十二章 事务和锁

# 第三篇 数据库管理篇

# 第四篇 数据库应用篇

