# 第一章 MyBatis基础

## 1.1 原生JDBC使用总结

- 数据库连接 使用时就创建 不使用立即释放 对数据库进行频繁的开启和关闭 造成数据库资源的浪费
  影响数据库的性能 

  > **方案：使用数据库连接池管理数据库连接**

- 将sql语句硬编码到Java代码中，向prepareStatement中设置参数 ，对占位符号的位置和设置的参数值，硬编码在java代码中，不利于系统维护

  > **方案：sql语句及占位符和参数与Java代码分离，单独定义在配置文件中**

- 从resultSet中遍历结果数据时 存在硬编码问题 将要获取表的字段进行硬编码 不利于维护 

  > **方案：将查询结果 自动映射成java对象**  

## 1.2 Hibernate使用总结



## 1.3 MyBatis特点

## 1.4 MyBatis入门案例

# 第二章 MyBatis的两种持久化

## 2.1 原生DAO开发方式

## 2.2 Mapper接口代理模式开发

# 第三章 全局配置文件

## 3.1 配置方式

1. xml
2. Java

## 3.2 常用配置说明

# 第四章 MyBatis的API

## 4.1 Configuration

##4.2 SqlSessionFactory

## 4.3 SqlSession

# 第五章 SQL配置文件

## 5.1 insert

## 5.2 delete

## 5.3 update

## 5.4 select

## 5.5 include & sql

## 5.6 resultMap

# 第六章 MyBatis缓存设计

## 6.1 一级缓存

##6.2 二级缓存

## 6.3 缓存原理

#第七章 动态SQL

## 7.1 `<where>`

# 第八章 整合SpringBoot

# 第九章 逆向工程

