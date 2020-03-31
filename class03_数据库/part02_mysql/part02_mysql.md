# 第一部分 数据库概述

## 第一章 数据库介绍

## 第二章 数据库类型

## 第三章 SQL介绍

1. DML：insert、delete、update
2. DQL：select
3. DDL：create、alter、drop
4. DCL：grant、revoke、commit、rollback

## 第四章 数据库范式

# 第二部分 MySql基础

## 第一章 MySql安装

1. docker

   - 拉取

     ```sh
     docker pull mysql:5.7.19
     ```

   - 运行

     ```sh
     docker run --name mysql -p 3306:3306 -v D:/panda_docker_files/mysql/data:/var/lib/mysql -v D:/panda_docker_files/mysql/config:/etc/mysql -e MYSQL_ROOT_PASSWORD=root -d mysql:5.7.19
     ```

     > - --name：容器名
     > - --p：映射宿主主机端口
     > - -v：挂载宿主目录到容器目录
     > - -e：设置环境变量，此处指定root密码
     > - -d：后台运行容器

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

     

## 第二章 MySql数据类型

## 第三章 MySql操作符

## 第四章 MySQL内置函数

# 第三部分 MySql的SQL规范

## 第一章 DDL 数据库定义语言

### 1.1 create语句

1. create创建表

### 1.2 alter语句

1. alter修改表名
2. alter为表新增字段
3. alter为表更新字段
4. alter为表删除字段

### 1.3 drop语句

1. drop删除表

## 第二章 DML 数据库操作语言

### 2.1 insert语句

1. 为所有字段插入值
2. 为指定字段插入值
3. 将查询结果插入到指定字段

### 2.2 update语句

1. 为指定字段更新值
2. 把指定字段的值更新为其他字段的值

### 2.3 delete语句

1. 删除所有
2. 删除指定条件的数据

## 第三章 DQL 数据库检索语言

### 3.1 select基本规范

```sql
select
	<查询结果集字段列表[聚合函数]>
form 表名 [连接查询]
[where 子句]
[group by 子句 [having 子句]]
[order by 子句]
[limit 子句]
```

### 3.2 查询结果集字段列表

1. 使用通配符代替查询字段：`*`表示查询结果或遍历当前查询表中的所有字段

   ```sql
   select * from 表名 ... ...;
   ```

2. 查询指定字段：查询多个字段，字段直接用逗号分隔，最后一个字段不需要逗号

   ```sql
   select 字段A, 字段B from 表名 ... ...;
   ```

3. 为查询字段定义别名：使用`AS`关键字（也可以是省略），也可以为表起别名

   ```sql
   select 字段A AS 别名A, 字段B AS 别名B from 表名 ... ...;
   ```

4. 使用函数对查询结果集字段进行二次处理

   ```sql
   select concat(字段A, 字段B) as 函数别名 from 表名 ... ...;
   ```

5. `distinct`将查询的自定设置为 不重复

   ```sql
   select distinct 字段 from 表名 ... ...;
   ```

### 3.3 where子句

1. 使用`in`关键字的查询
2. 使用`between ... and`关键字的查询
3. 使用`like`关键字的匹配查询
4. `null`值的查询
5. 多条件使用`and`关键字
6. 对条件使用`or`关键字

### 3.4 group by + having 子句

1. 将查询的结果按照某一个字段进行分组
2. 多字段分组查询
3. `having 条件表达式`：指满足分组条件表达式限定的结果被显示

### 3.5 order by 子句

1. 默认是升序排序（ASC）：例如从A~Z、0-9等

2. 设置查询结果为某个字段是降序（DESC）

3. 设置多个字段为排序字段

   ```sql
   select distinct 字段 from 表名
   order by 字段A DESC,字段B ASC;
   ```

### 3.6 limit 子句

1. 只查询指定的前n条数据：limit参数需要定义一个
2. 只显示中间指定数量是数据：limit 参数1表示起始偏移量，参数2表示需要显示的数量

### 3.7 使用聚合函数统计查询结果

1. count(*)
2. sum(字段)
3. avg(字段)
4. max(字段)
5. min(字段)

### 3.8 连接查询

1. inner join 内连接查询

   ```sql
   selec *
   from tableA,tableB
   where 连接条件;
   ```

   ```sql
   select * 
   from tableA inner join table B
   on 连接条件
   ... ...;
   ```

2. left join 左连接查询

   ```sql
   select * 
   from tableA left join table B
   on 连接条件
   ... ...;
   ```

3. right join 右连接查询

   ```sql
   select * 
   from tableA right join table B
   on 连接条件
   ... ...;
   ```

### 3.9 子查询

1. 带any关键字的子查询
2. 带some关键字的子查询
3. 带all关键字的子查询
4. 带exists | not exists关键字的子查询
5. 带in | not in关键字的子查询
6. 带比较运算符的子查询

### 3.10 合并查询

1. union all合并不去重
2. union 合并并去重

### 3.11 使用正则表达式查询



## 第四章 DCL 数据库控制语言

# 第四部分 MySql高级

## 第一章 索引

## 第二章 视图

## 第三章 触发器

## 第四章 存储过程和函数

## 第五章 MySQL用户与权限

### 5.1 权限相关表

#### <font size=4>1. mysql.user</font>

>  记录允许连接到服务器的账号信息，里面的权限是全局的，对用户而言是所有数据库的所有表

- 用户列：联合主键 = host+user

  | 字段名                | 备注                 |
  | --------------------- | -------------------- |
  | host                  | 主机名               |
  | user                  | 用户名               |
  | authentication_string | plugin加密后的字符串 |

- 权限列：描述了全局范围内允许对数据和数据库的操作，权限字段取值是枚举值（Y | N），使用grant或update语句更改user表中的这些字段修改用户对应的权限

  | 字段名 | 备注 |
  | ------ | ---- |
  |**select_priv** | 查询 |
  |**insert_priv** | 新增 |
  |**update_priv** | 修改 |
  |**delete_priv** | 删除 |
  |**create_priv** | 创建 |
  |**drop_priv** | 删除 |
  |reload_priv |      |
  |shutdown_priv |      |
  |process_priv |      |
  |file_priv |      |
  |grant_priv |      |
  |references_priv |      |
  |index_priv |      |
  |**alter_priv** | 更新 |
  |show_db_priv |      |
  |super_priv |      |
  |create_tmp_table_priv |      |
  |lock_tables_priv |      |
  |execute_priv |      |
  |repl_slave_priv |      |
  |repl_client_priv |      |
  |create_view_priv |      |
  |show_view_priv |      |
  |create_routine_priv |      |
  |alter_routine_priv |      |
  |create_user_priv |      |
  |event_priv |      |
  |trigger_priv |      |
  |create_tablespace_priv |      |
  |create_role_priv |      |
  |drop_role_pri |      |

- 安全列：共13个字段，

  | 字段名                   | 备注                                 |
  | ------------------------ | ------------------------------------ |
  | ssl_type                 | 用于加密                             |
  | ssl_cipher               |                                      |
  | x509_issuer              | 可用于标识用户身份                   |
  | x509_subject             |                                      |
  | account_locked           | 用户是否被锁定                       |
  | plugin                   | 可以验证用户身份的插件，密码加密方式 |
  | password_expired         | 密码过期时间，0表示不过期            |
  | password_lifetime        |                                      |
  | password_last_changed    |                                      |
  | password_reuse_history   |                                      |
  | password_reuse_time      |                                      |
  | password_require_current |                                      |
  | user_attributes          |                                      |

- 资源控制列：用于限制用户使用的资源

  | 字段名               | 备注                             |
  | -------------------- | -------------------------------- |
  | max_questions        | 用户没小时运行执行查询的次数     |
  | max_updates          | 用户每小时允许执行的更新操作次数 |
  | max_connections      | 用户每小时允许执行的连接操作次数 |
  | max_user_connections | 允许用户同时建立连接的次数       |

#### <font size=4>2. mysql.db</font>

> 存储了用户对某个数据库的操作权限，决定用户能从哪个主机读取那个数据库，这个表中的权限不受grant和revoke语句影响

- 用户相关列

  | 字段 | 备注             |
  | ---- | ---------------- |
  | host | 登陆主机         |
  | user | 登陆用户         |
  | db   | 可以操作的数据库 |

- 权限列

  | 字段 | 备注 |
  | ---- | ---- |
  | select_priv|      |
  | insert_priv|      |
  | update_priv|      |
  | delete_priv|      |
  | create_priv|      |
  | drop_priv|      |
  | grant_priv|      |
  | references_priv|      |
  | index_priv|      |
  | alter_priv|      |
  | create_tmp_table_priv|      |
  | lock_tables_priv|      |
  | create_view_priv|      |
  | show_view_priv|      |
  |  create_routine_priv|      |
  | alter_routine_priv|      |
  | execute_priv|      |
  | event_priv|      |
  | trigger_pri|      |


#### <font size=4>3. mysql.tables_priv</font>

> 用来设置表的操作权限

| 字段        | 备注 |
| ----------- | ---- |
| host        |      |
| db          |      |
| user        |      |
| table_name  |      |
| grantor     |      |
| timestamp   |      |
| table_priv  |      |
| column_priv |      |

#### <font size=4>4. mysql.columns_priv</font>

> 用来设置表中列相关的操作权限

| 字段        | 备注 |
| ----------- | ---- |
| host        |      |
| db          |      |
| user        |      |
| table_name  |      |
| column_name |      |
| timestamp   |      |
| column_priv |      |

### 5.2 账户管理

#### <font size=4>1. 使用mysql命令登陆和退出</font>

- 登陆

  ```sh
  mysql [选项] [参数]
  ```

  > - -h 主机名：使用该参数指定要登陆的主机名，如果不指定默认是localhost
  > - -u 用户名：登陆用户名
  > - -p密码：用户名密码（密码和p之间不能有空格）
  > - -P 端口号：默认是3306
  > - -e SQL语句：表示登陆后并执行SQL语句，执行完成后并退出

- 退出

  ```sh
  exit;
  ```

#### <font size=4>2. 用root权限新建用户</font>

- create user

  ```sh
  create user
  ```

  



## 第五部分 MySQL运维

## 第一章 数据备份与恢复

## 第二章 MySQL日志

## 第三章 MySQL性能优化

## 第四章 MySql主从

## 第五章 MySql集群

