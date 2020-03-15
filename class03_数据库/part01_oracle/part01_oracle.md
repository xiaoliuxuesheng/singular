# Docker 安装Oracle

1. 拉取阿里云

   ```sh
   docker pull registry.cn-hangzhou.aliyuncs.com/helowin/oracle_11g
   ```

2. 创建容器

   ```sh
    docker run -d -p 1521:1521 --name oracle11g 容器ID
   ```

3. 启动容器

   ```sh
   docker start oracle11g
   ```

4. 进入镜像进行配置

   - 进入镜像

     ```sh
     docker exec -it oracle11g /bin/bash
     ```

   - 切换到root用户

     ```sh
      su root
     
     密码：helowin
     ```

   - 修改环境变量

     ```sh
     vi /etc/profile
     ```

     ```sh
     export ORACLE_HOME=/home/oracle/app/oracle/product/11.2.0/dbhome_2
      
     export ORACLE_SID=helowin
      
     export PATH=$ORACLE_HOME/bin:$PATH
     ```

   - 创建软连接

     ```sh
     ln -s $ORACLE_HOME/bin/sqlplus /usr/bin
     ```

   - 切换到oracle 用户

     ```sh
     su - oracle
     ```

   - 登陆sqlplus

     ```sh
     sqlplus /nolog
     ```

   - 用管理员连接

     ```sh
      conn /as sysdba
     ```

   - 配置

     ```sql
     alter user system identified by system;
     
     alter user sys identified by sys;
     
     -- 也可以创建用户  
     create user panda identified by panda;
     
     -- 并给用户赋予权限  
     grant connect,resource,dba to panda;
     ```

   - 出问题解决方案

     ```sql
     alter database mount;
     alter database open;
     ```

   - 修改密码

     ```sql
     ALTER PROFILE DEFAULT LIMIT PASSWORD_LIFE_TIME UNLIMITED;
     ```

   - 连接

     ```sh
     # 看一下oracle 的 lsnrctl 服务
     lsnrctl status
     ```

     

# 第一篇 数据库安全篇

# 第二篇 数据库基础篇

## 第三章 熟悉数据库

### 3.1 数据库模型

### 3.2 数据库相关术语

### 3.3 数据库范式

## 第四章 SQL基础

### 4.1 Oracle数据类型

### 4.2 Oracle常用操作符

1. 单引号
   - 引用一个字符串常量，也就是界定一个字符串的开始和结束，**这个字符串常量是区分大小写的**
   - 转义符，对紧随其后出现的字符(单引号)进行转义 
2. 双引号
   - 关键字、对象名、字段名、别名加双引号，则示意 Oracle将严格区分大小写，否则Oracle都默认大写。

### 4.3 Oracle约束类型

> - Oracle中约束是保证数据库表中的数据完整性和一致性的一种手段
>
> - 同一个数据库中的约束名称不可以重名

<font size=4 color=blue>.★ 主键约束</font>：【**primary key**】- 主键在数据表中只有一个，但一个主键约束可以由多个列组成

<font size=4 color=blue>★ 外键约束</font>：【**foreign key**】- 用于保证使用外键约束的数据列与所引用的数据表的的主键数据一致

<font size=4 color=blue>★ 唯一约束</font>：【**unique**】用于设置输入时保证该列字段的值是唯一的

<font size=4 color=blue>★ 检查约束</font>：【**check**】用于规定一个列的输入值，以保证数据的正确性

<font size=4 color=blue>★ 非空约束</font>：【**not null**】添加非空约束保证该字段必须输入值

1. 在创建数据表时候添加主键约束

   ```sql
   CREATE TABLE 数据表名称(
     ID VARCHAR2(32),
     CONSTRAINT 主键名称 PRIMARY KEY (主键字段)
   );
   ```

2. 为已存在表新增主键约束

   ```sql
   ALTER TABLE 数据表名称
   ADD CONSTRAINT 主键名称 PRIMARY KEY (主键字段);
   ```

3. 删除主键约束

   ```sql
   ALTER TABLE 数据表名称
   DROP CONSTRAINT 约束(主键)名称;
   ```



1. 在创建数据表时候添加外键约束

   ```sql
   CREATE TABLE 数据表名称 (
     ID   VARCHAR2(32),
     NAME VARCHAR2(32),
     CONSTRAINT 外键约束名称 FOREIGN KEY (外键字段名称) 
       REFERENCES 引用的表名 (引用的字段) 
         ON DELETE CASCADE
   );
   ```

2. 为已存在表新增外键约束

   ```sql
   ALTER TABLE 数据表名称
   ADD CONSTRAINT 外键约束名称 FOREIGN KEY (外键字段名称)
   REFERENCES 引用的表名(引用的字段) 
     ON DELETE CASCADE ;
   ```

3. 删除外键约束

   ```sql
   ALTER TABLE 数据库名称
   DROP CONSTRAINT 约束(外键)名称;
   ```



1. 在创建数据表时候添加唯一约束

   ```sql
   CREATE TABLE ORC_TABLE03_NAME(
     NAME VARCHAR2(30),
     CONSTRAINT UK_ID UNIQUE (NAME)
   );
   ```

2. 为已存在表新增唯一约束

   ```sql
   ALTER TABLE 数据表名称
   ADD CONSTRAINT 外键约束名称 FOREIGN KEY (外键字段名称)
   REFERENCES 引用的表名(引用的字段) 
     ON DELETE CASCADE ;
   ```

3. 删除唯一约束

   ```sql
   ALTER TABLE 数据库名称
   DROP CONSTRAINT 约束(唯一)名称;
   ```



1. 在创建数据表时候添加检查约束

   ```sql
   CREATE TABLE ORC_TABLE03_NAME(
     NAME VARCHAR2(30),
     CONSTRAINT UK_ID UNIQUE (NAME)
   );
   ```

2. 为已存在表新增检查约束

   ```sql
   ALTER TABLE 数据表名称
   ADD CONSTRAINT 外键约束名称 FOREIGN KEY (外键字段名称)
   REFERENCES 引用的表名(引用的字段) 
     ON DELETE CASCADE ;
   ```

3. 删除检查约束

   ```sql
   ALTER TABLE 数据库名称
   DROP CONSTRAINT 约束(唯一)名称;
   ```



1. 在创建数据表时候添加非空约束

   ```sql
   CREATE TABLE ORC_TABLE03_NAME(
     NAME VARCHAR2(30),
     CONSTRAINT UK_ID UNIQUE (NAME)
   );
   ```

2. 为已存在表新增非空约束

   ```sql
   ALTER TABLE 数据表名称
   ADD CONSTRAINT 外键约束名称 FOREIGN KEY (外键字段名称)
   REFERENCES 引用的表名(引用的字段) 
     ON DELETE CASCADE ;
   ```

3. 删除非空约束

   ```sql
   ALTER TABLE 数据库名称
   DROP CONSTRAINT 约束(唯一)名称;
   ```

## 第五章 Oracle内置函数

### 5.1 数值型函数



| 函数         | 说明                | 示例                    |
| ------------ | ------------------- | ----------------------- |
| ABS(X)       | X的绝对值           | ABS(-3)=3               |
| ACOS(X)      | X的反余弦           | ACOS(1)=0               |
| COS(X)       | 余弦                | COS(1)=0.54030230586814 |
| CEIL(X)      | 大于或等于X的最小值 | CEIL(5.4)=6             |
| FLOOR(X)     | 小于或等于X的最大值 | FLOOR(5.8)=5            |
| LOG(X,Y)     | X为底Y的对数        | LOG(2，4)=2             |
| MOD(X,Y)     | X除以Y的余数        | MOD(8，3)=2             |
| POWER(X,Y)   | X的Y次幂            | POWER(2，3)=8           |
| ROUND(X[,Y]) | X在第Y位四舍五入    | ROUND(3.456，2)=3.46    |
| SQRT(X)      | X的平方根           | SQRT(4)=2               |
| TRUNC(X[,Y]) | X在第Y位截断        | TRUNC(3.456，2)=3.45    |

### 5.2 字符型函数

| 函数                     | 说明                                                         |
| ------------------------ | ------------------------------------------------------------ |
| ASCII(X)                 | 返回字符X的ASCII码                                           |
| CONCAT(X,Y)              | 连接字符串X和Y                                               |
| INSTR(X,STR[,START][,N)  | 从X中查找str，可以指定从start开始，也可以指定从n开始         |
| LENGTH(X)                | 返回X的长度                                                  |
| LOWER(X)                 | X转换成小写                                                  |
| UPPER(X)                 | X转换成大写                                                  |
| LTRIM(X[,TRIM_STR])      | 把X的左边截去trim_str字符串，缺省截去空格                    |
| RTRIM(X[,TRIM_STR])      | 把X的右边截去trim_str字符串，缺省截去空格                    |
| TRIM([TRIM_STR FROM]X)   | 把X的两边截去trim_str字符串，缺省截去空格                    |
| REPLACE(X,old,new)       | 在X中查找old，并替换成new                                    |
| SUBSTR(X,start[,length]) | 返回X的字串，从start处开始，截取length个字符，缺省length，默认到结尾 |

### 5.3 日期型函数

| 函数                | 说明                   |
| ------------------- | ---------------------- |
| SYSDATE             | 当前日期和时间         |
| LAST_DAY            | 本月最后一天           |
| ADD_MONTHS(d,n)     | 当前日期d后推n个月     |
| MONTHS_BETWEEN(d,n) | 日期d和n相差月数       |
| NEXT_DAY(d,day)     | d后第一周指定day的日期 |

### 5.4 转换函数

### 5.5 Null函数

### 5.6 集合函数

| 名称     | 作用           | 语法                     |
| -------- | -------------- | ------------------------ |
| AVG      | 平均值         | AVG（表达式）            |
| SUM      | 求和           | SUM(表达式)              |
| MIN、MAX | 最小值、最大值 | MIN(表达式)、MAX(表达式) |
| COUNT    | 数据统计       | COUNT（表达式）          |

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

