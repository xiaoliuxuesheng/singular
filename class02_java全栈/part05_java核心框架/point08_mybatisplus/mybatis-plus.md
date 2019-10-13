# 第一章 MP基础

## 1.1 MP概述

- 是Mybatis的增强包 : 只做增强, 不做改变, 为了简化工作, 提高生产效率

## 1.2 MP特点

- **无侵入** : 不会影响到MyBatis的运行
- **依赖少**
- **损耗小** : 启动注入基本CRUD
- **多种主键策略** 
- **内置多种插件**

## 1.3 搭建MP学习坏境

1. **pom.xml** : 引入依赖

   ```xml
   <!-- 引入Mybatis plus 依赖 -->
           <dependency>
               <groupId>com.baomidou</groupId>
               <artifactId>mybatis-plus</artifactId>
               <version>2.1.9</version>
           </dependency>
   
   <!-- 添加数据源 -->
       <dependency>
           <groupId>com.alibaba</groupId>
           <artifactId>druid</artifactId>
           <version>1.1.13</version>
       </dependency>
       <dependency>
           <groupId>mysql</groupId>
           <artifactId>mysql-connector-java</artifactId>
           <version>5.1.47</version>
       </dependency>
   
   <!-- 添加Spring IOC核心 -->
           <dependency>
               <groupId>org.springframework</groupId>
               <artifactId>spring-context</artifactId>
               <version>5.1.8.RELEASE</version>
           </dependency>
           <dependency>
               <groupId>org.springframework</groupId>
               <artifactId>spring-orm</artifactId>
               <version>5.1.8.RELEASE</version>
           </dependency>
   
   <!-- 添加测试工具包 -->
           <dependency>
               <groupId>org.slf4j</groupId>
               <artifactId>slf4j-nop</artifactId>
               <version>1.7.2</version>
           </dependency>
           <dependency>
               <groupId>org.projectlombok</groupId>
               <artifactId>lombok</artifactId>
               <version>1.18.8</version>
           </dependency>
           <dependency>
               <groupId>junit</groupId>
               <artifactId>junit</artifactId>
               <version>4.12</version>
           </dependency>
           <dependency>
               <groupId>org.springframework</groupId>
               <artifactId>spring-test</artifactId>
               <version>5.1.8.RELEASE</version>
           </dependency>
   ```

2. Mybatis配置文件 : **mybatis.cfg.xml**

   ```xml
   <?xml version="1.0" encoding="UTF-8" ?>
   <!DOCTYPE configuration
           PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
           "http://mybatis.org/dtd/mybatis-3-config.dtd">
   <configuration>
   
   </configuration>
   ```

3. 数据源外部属性配置文件 : **db.properties**

   ```properties
   jdbc.driver=com.mysql.jdbc.Driver
   jdbc.url=jdbc:mysql://localhost:3306/case_project?useUnicode=true&characterEncoding=utf8&serverTimezone=GMT%2B8&useSSL=false
   jdbc.username=root
   jdbc.password=root
   ```

4. 配置Spring核心配置 : **application.xml**

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <beans xmlns="http://www.springframework.org/schema/beans"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xmlns:context="http://www.springframework.org/schema/context" xmlns:tx="http://www.springframework.org/schema/tx"
          xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://www.springframework.org/schema/context https://www.springframework.org/schema/context/spring-context.xsd http://www.springframework.org/schema/tx http://www.springframework.org/schema/tx/spring-tx.xsd">
   
       <!--1. 配置数据源-->
       <context:property-placeholder location="classpath:db.properties"/>
   
       <bean class="com.alibaba.druid.pool.DruidDataSource" id="dataSource">
           <property name="driverClassName" value="${jdbc.driver}"/>
           <property name="url" value="${jdbc.url}"/>
           <property name="username" value="${jdbc.username}"/>
           <property name="password" value="${jdbc.password}"/>
       </bean>
   
       <!--2. 集成mybatis : SqlSessionFactoryBean-->
       <bean class="com.baomidou.mybatisplus.spring.MybatisSqlSessionFactoryBean" id="sqlSessionFactory">
           <property name="dataSource" ref="dataSource"/>
   
           <property name="configLocation" value="classpath:mybatis.cfg.xml"/>
   
           <property name="globalConfig" ref="configuration"/>
       </bean>
       <bean class="com.baomidou.mybatisplus.entity.GlobalConfiguration" id="configuration">
           <property name="dbColumnUnderline" value="true"/>
       </bean>
   
       <bean class="org.mybatis.spring.mapper.MapperScannerConfigurer">
           <property name="basePackage" value="com.panda.plus"/>
       </bean>
   
       <!-- 3. 添加事物管理器-->
       <bean class="org.springframework.jdbc.datasource.DataSourceTransactionManager" id="transactionManager">
           <property name="dataSource" ref="dataSource"/>
       </bean>
       <tx:annotation-driven transaction-manager="transactionManager"></tx:annotation-driven>
   </beans>
   ```

5. 准备数据库支持 

   ```sql
   create database if not exists case_project;
   
   use case_project;
   
   create table if not exists plus_employee(
       `id` char(50) not null comment '主键',
       `dept_id` char(50) not null comment '部门ID',
       `emp_name` varchar(50) not null comment '员工名称',
       `password` varchar(50) not null comment '登录密码',
       `locked` tinyint default 0 comment '是否锁定',
       `enabled` tinyint default 1 comment '是否可用',
       `login_time` datetime null comment '上次登录时间',
       `pwd_reset_time` datetime default current_timestamp comment '最后密码修改时间',
       `create_time` datetime default current_timestamp comment '创建时间',
       `modify_time` datetime default current_timestamp on update current_timestamp comment '修改时间',
       primary key (`id`),
       index `idx_emp_name` (emp_name),
       index `idx_pwd_rest` (pwd_reset_time)
   ) comment '员工表';
   
   create table if not exists plus_department(
       `id` char(50) not null comment '主键',
       `dept_name` varchar(50) not null comment '部门名称',
       `parent_id` char(50) comment '上级部门id',
       `level` int comment '部门等级',
       `enabled` tinyint default 1 comment '是否可用',
       `create_time` datetime default current_timestamp comment '创建时间',
       `modify_time` datetime default current_timestamp on update current_timestamp comment '修改时间',
       primary key (id),
       index `idx_parent_id` (parent_id)
   ) comment '部门表';
   ```

# 第二章 MP基本的CRUD

## 2.1 常用配置

### 1. @TableName

- 用于指定Mapper接口中泛型类型对应的数据库表的名称

### 2. @TableId

- 用于指定主键策略, javaBean的哪个属性是数据库的注解,以及主键的特性

- 主键策略类型

  ```java
  public enum IdType {
      AUTO(0, "数据库ID自增"),
      INPUT(1, "用户输入ID"),
      ID_WORKER(2, "全局唯一ID"),
      UUID(3, "全局唯一ID"),
      NONE(4, "该类型为未设置主键类型"),
      ID_WORKER_STR(5, "字符串全局唯一ID");
  }
  ```

### 3. @TableField

- 属性策略 : 用于指定非主键类型的字段的规则

### 4. 全局配置

- JavaBean : **GlobalConfiguration** 是MybatisPlus的全局配置
- 基本属性含义
  - **dbColumnUnderline = true|false** : 开启数据库下划线规则
  - **idType=int值** : 每个枚举对应一个索引值, 指定全局主键类型
  - ...  ....
- 需要将全局配置注入到 : **MybatisSqlSessionFactoryBean.globalConfig**属性中

## 2.2 通用CRUD API

| 描述                   | API                                                          |
| ---------------------- | ------------------------------------------------------------ |
| 插入一条记录           | Integer **insert**(T entity);                                |
| 插入一条记录           | Integer **insertAllColumn**(T entity);                       |
| 根据 ID 删除           | Integer **deleteById**(Serializable id);                     |
| 根据 columnMap删除记录 | Integer **deleteByMap**(Map<String, Object> columnMap);      |
| 根据 entity删除记录    | Integer **delete**(Wrapper<T> wrapper);                      |
| 根据ID 批量删除        | Integer **deleteBatchIds**(Collection<? extends Serializable> idList); |
| 根据 ID 修改           | Integer **updateById**(T entity);                            |
| 根据 ID 修改           | Integer **updateAllColumnById**( T entity);                  |
| 根据条件，更新记录     | Integer **update**(T entity,Wrapper<T> wrapper);             |
| 根据 ID 查询           | T **selectById**(Serializable id);                           |
| 根据ID 批量查询        | List<T> **selectBatchIds**(Collection<? extends Serializable> idList); |
| 根据 columnMap 条件    | List<T> **selectByMap**(Map<String, Object> columnMap);      |
| 根据 entity 条件       | T **selectOne**( T entity);                                  |
| 查询根据 Wrapper 条件  | Integer **selectCount**(Wrapper<T> wrapper);                 |
| 查询根据 entity 条件   | List<T> **selectList**(Wrapper<T> wrapper);                  |
| 根据 Wrapper 条件      | List<Map<String, Object>> **selectMaps**(Wrapper<T> wrapper); |
| 查询全部记录并翻页     | List<T> **selectPage**(RowBounds rowBounds, Wrapper<T> wrapper); |
| 查询全部记录并翻页     | List<Map<String, Object>> **selectMapsPage**(RowBounds rowBounds, Wrapper<T> wrapper); |

