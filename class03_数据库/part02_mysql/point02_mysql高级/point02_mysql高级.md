# Linux安装

1. 下载MySQL安装包：https://dev.mysql.com/downloads/mysql/

2. 卸载旧版MySQL

   ```sh
    rpm -qa | grep -i mysql
    
    rpm -e 包
   ```

3. MySQL内置的文件

   ```sh
    whereis mysql
    rm -rf xxx
   ```

4. 上传并解压到mysql目录中

   ```sh
   tar -xvf xxx.tar -C mysql/
   ```

5. 安装MySQL第三方包

   ```sh
   yum -y install libaio.so.1 libgcc_s.so.1 libstdc++.so.6 libncurses.so.5 --setopt=protected_multilib=false
   yum update libstdc
   ```

6. 安装mysql

   ```sh
   rpm -ivh client
   rpm -ivh server
   ```

7. 启动

   ```sh
   systemctl start mysqld.service    启动mysql
   systemctl status mysqld.service  查看mysql状态
   systemctl stop mysqld.service   关闭mysql
   ```

   

   

# 第七章 表类型的选择

> MySQL中有存储引擎的概念：可以针对不同的存储需求而选择最优的存储引擎

## 7.1 存储引擎概述



# 第八章 选择合适的数据类

# 第九章 字符集

# 第十章 索引

# 第十一章 视图

# 第十二章 存储过程

# 第十三章 触发器

# 第十四章 事务控制

# 第十五章 SQL安全

# 第十六章 SQL Mode相关问题

# 第十七章 SQL分区

# Mysql 用户权限管理

## 1.1 MySQL 权限介绍

### :anchor: MySQL控制权限的表

- user：存放用户账户信息以及全局级别（所有数据库）权限，决定了来自哪些主机的哪些用户可以访问数据库实例，如果`有全局权限则意味着对所有数据库都有此权限` 

- db：存放`数据库级别`的权限，决定了来自哪些主机的哪些用户可以访问此数据库 

  | 表名           | `user`                   | `db`                    |
  | -------------- | ------------------------ | ----------------------- |
  | **范围列**     | `Host`                   | `Host`                  |
  |                | `User`                   | `Db`                    |
  |                |                          | `User`                  |
  | **权限列**     | `Select_priv`            | `Select_priv`           |
  |                | `Insert_priv`            | `Insert_priv`           |
  |                | `Update_priv`            | `Update_priv`           |
  |                | `Delete_priv`            | `Delete_priv`           |
  |                | `Index_priv`             | `Index_priv`            |
  |                | `Alter_priv`             | `Alter_priv`            |
  |                | `Create_priv`            | `Create_priv`           |
  |                | `Drop_priv`              | `Drop_priv`             |
  |                | `Grant_priv`             | `Grant_priv`            |
  |                | `Create_view_priv`       | `Create_view_priv`      |
  |                | `Show_view_priv`         | `Show_view_priv`        |
  |                | `Create_routine_priv`    | `Create_routine_priv`   |
  |                | `Alter_routine_priv`     | `Alter_routine_priv`    |
  |                | `Execute_priv`           | `Execute_priv`          |
  |                | `Trigger_priv`           | `Trigger_priv`          |
  |                | `Event_priv`             | `Event_priv`            |
  |                | `Create_tmp_table_priv`  | `Create_tmp_table_priv` |
  |                | `Lock_tables_priv`       | `Lock_tables_priv`      |
  |                | `References_priv`        | `References_priv`       |
  |                | `Reload_priv`            |                         |
  |                | `Shutdown_priv`          |                         |
  |                | `Process_priv`           |                         |
  |                | `File_priv`              |                         |
  |                | `Show_db_priv`           |                         |
  |                | `Super_priv`             |                         |
  |                | `Repl_slave_priv`        |                         |
  |                | `Repl_client_priv`       |                         |
  |                | `Create_user_priv`       |                         |
  |                | `Create_tablespace_priv` |                         |
  | **安全专栏**   | `ssl_type`               |                         |
  |                | `ssl_cipher`             |                         |
  |                | `x509_issuer`            |                         |
  |                | `x509_subject`           |                         |
  |                | `plugin`                 |                         |
  |                | `authentication_string`  |                         |
  |                | `password_expired`       |                         |
  |                | `password_last_changed`  |                         |
  |                | `password_lifetime`      |                         |
  |                | `account_locked`         |                         |
  | **资源控制列** | `max_questions`          |                         |
  |                | `max_updates`            |                         |
  |                | `max_connections`        |                         |
  |                | `max_user_connections`   |                         |

- tables_priv `存放表级别的权限`，决定了来自哪些主机的哪些用户可以访问数据库的这个表 

- Columns_priv表：`存放列级别的权限`，决定了来自哪些主机的哪些用户可以访问数据库表的这个字段 

    | 表名       | `tables_priv` | `columns_priv` |
    | ---------- | ------------- | -------------- |
    | **范围列** | `Host`        | `Host`         |
    |            | `Db`          | `Db`           |
    |            | `User`        | `User`         |
    |            | `Table_name`  | `Table_name`   |
    |            |               | `Column_name`  |
    | **权限列** | `Table_priv`  | `Column_priv`  |
    |            | `Column_priv` |                |
    | **其他列** | `Timestamp`   | `Timestamp`    |
    |            | `Grantor`     |                |

- Procs_priv表：`存放存储过程和函数`级别的权限

  | Table Name            | `procs_priv`   |
  | --------------------- | -------------- |
  | **Scope columns**     | `Host`         |
  |                       | `Db`           |
  |                       | `User`         |
  |                       | `Routine_name` |
  |                       | `Routine_type` |
  | **Privilege columns** | `Proc_priv`    |
  | **Other columns**     | `Timestamp`    |
  |                       | `Grantor`      |

### :anchor: mysql权限表的验证过程

1. 先从user表中的Host,User,Password这3个字段中判断连接的ip、用户名、密码是否存在，存在则通过验证
2. 通过身份认证后，进行权限分配，按照user，db，tables_priv，columns_priv的顺序进行验证。即先检查全局权限表user，如果user中对应的权限为Y，则此用户对所有数据库的权限都为Y，将不再检查db, tables_priv,columns_priv；如果为N，则到db表中检查此用户对应的具体数据库，并得到db中为Y的权限；如果db中为N，则检查tables_priv中此数据库对应的具体表，取得表中的权限Y，以此类推。

## 1.2 MySQL 权限级别

### :anchor: MySQL权限级别

1. 全局性的管理权限： 作用于整个MySQL实例级别 
2. 数据库级别的权限： 作用于某个指定的数据库上或者所有的数据库上 
3. 数据库对象级别的权限：作用于指定的数据库对象上（表、视图等）或者所有的数据库对象上

### :anchor: 权限类型详解

| 权限                        | 权限级别               | 权限说明                                                     |
| --------------------------- | ---------------------- | ------------------------------------------------------------ |
| **create**                  | 数据库、表或索引       | 创建数据库、表或索引权限                                     |
| **drop**                    | 数据库或表             | 删除数据库或表权限                                           |
| grant option                | 数据库、表或保存的程序 | 赋予权限选项                                                 |
| references                  | 数据库或表             | 外键权限                                                     |
| **alter**                   | 表                     | 更改表，比如添加字段、索引、修改字段等                       |
| **delete**                  | 表                     | 删除数据权限                                                 |
| **index**                   | 表                     | 索引权限                                                     |
| **insert**                  | 表                     | 插入权限                                                     |
| **select**                  | 表                     | 查询权限                                                     |
| **update**                  | 表                     | 更新权限                                                     |
| create view                 | 视图                   | 创建视图权限                                                 |
| show view                   | 视图                   | 查看视图权限                                                 |
| alter routine               | 存储过程               | 更改存储过程权限                                             |
| create routine              | 存储过程               | 创建存储过程权限                                             |
| execute                     | 存储过程               | 执行存储过程权限                                             |
| file                        | 服务器主机上的文件访问 | 文件访问权限                                                 |
| **create temporary tables** | 服务器管理             | 创建临时表权限                                               |
| lock tables                 | 服务器管理             | 锁表权限                                                     |
| create user                 | 服务器管理             | 创建用户权限                                                 |
| proccess                    | 服务器管理             | 查看进程权限                                                 |
| reload                      | 服务器管理             | 执行以下命令的权限<br />flush-hosts,<br /> flush-logs, <br />flush-privileges,<br /> flush-status, <br />flush-tables, <br />flush-threads, <br />refresh, <br />reload |
| replication client          | 服务器管理             | 复制权限                                                     |
| replication slave           | 服务器管理             | 复制权限                                                     |
| show databases              | 服务器管理             | 查看数据库权限                                               |
| shutdown                    | 服务器管理             | 关闭数据库权限                                               |
| super                       | 服务器管理             | 执行kill线程权限                                             |

## 1.3 权限相关常用操作

### :anchor: 操作用户

1. 用户相关知识

   - 授权用户由两部分组成：`用户名和登录主机名`

     ```sql
     # 表达用户的语法:单引号不是必须，但如果其中包含特殊字符则是必须的
     'user_name'@'host_name'
     ```

   - Host_name可以使主机名或者ipv4/ipv6的地址。 Localhost代表本机， 127.0.0.1代表ipv4本机地址， ::1代表ipv6的本机地址

   - Host_name字段允许使用`%和_`两个匹配字符，比如<kbd>%</kbd>代表所有主机

   - user_name为空表示允许匿名用户登录

2. 创建用户

   ```sql
   # 这只是创建用户并没有权限
   create user '用户名'@'主机' identified by '密码';
   
   # 创建用户并赋予RELOAD,PROCESS权限 ，在所有的库和表上
   grant RELOAD,PROCESS ON *.* to '用户名'@'主机' identified by '密码';
   
   # 创建keme用户，在test库，temp表， 上的id列只有select 权限
   grant select(id) on 数据库.数据表 to '用户名'@'主机' identified by '密码';
   ```

3. 账户重命名

   ```sql
   rename user '旧用户名'@'旧主机' to '新用户名'@'新主机';
   ```

4. 删除用户

   ```sql
   DROP USER 'username'@'host';
   ```

5. 锁定与解锁用户

   ```sql
   # 创建的时候给用户锁定
   create user '用户名'@'主机' identified by 'mysql' account lock;
   
   # 修改用户为unlock
   alter user '用户名'@'主机' account unlock;
   ```

6. 设置与更改用户密码

   ```sql
   # 设置其他人用户密码
   SET PASSWORD FOR 'username'@'host' = PASSWORD('newpassword');
   
   # 如果是当前登陆用户,设置当前用户密码
   SET PASSWORD = PASSWORD("newpassword");
   ```

7. 设置密码过期策略

   - 系统参数default_password_lifetime作用于所有的用户账户,0 表示设置密码不过期 

   - 如果为每个用户设置了密码过期策略，则会覆盖上述系统参数

     ```sql
     # 设置过期天数
     ALTER USER 'jeffrey'@'localhost' PASSWORD EXPIRE INTERVAL 90 DAY;
     
     # 密码不过期
     ALTER USER 'jeffrey'@'localhost' PASSWORD EXPIRE NEVER;
     
     # 默认过期策略
     ALTER USER 'jeffrey'@'localhost' PASSWORD EXPIRE DEFAULT;
     
     # 强制过期
     ALTER USER 'jeffrey'@'localhost' PASSWORD EXPIRE;
     ```

### :anchor: 操作用户权限

1. 修改权限介绍

   - 执行Grant,revoke,set password,rename user命令修改权限之后， MySQL会自动将修改后的权限信息同步加载到系统内存中
   - 如果执行insert/update/delete操作上述的系统权限表之后，则必须再执行刷新权限命令才能同步到系统内存中，刷新权限命令包括： `flush privileges`/mysqladmin flush-privileges / mysqladmin reload
   - 如果是修改tables和columns级别的权限，则客户端的下次操作新权限就会生效
   - 如果是修改database级别的权限，则新权限在客户端执行use database命令后生效
   - 如果是修改global级别的权限，则需要重新创建连接新权限才能生效
   - 如果是修改global级别的权限，则需要重新创建连接新权限才能生效 (例如修改密码)

2. 查看用户权限

   ```sql
   # 查看已授权信息
   show grants for 用户名@'Host值';
   
   # 查看用户其他非授权信息
   show create user 用户名@'Host值';
   ```

3. 设置权限

   ```sql
   grant 权限列表 on 数据库.数据表 to '用户名'@'主机' identified by '密码' with grant option;
   ```

4. 回收权限

   ```sql
   revoke 权限列表 on 数据库名.数据表名 from '用户名'@'主机';
   ```

## 1.4 MySQL全局属性

1. MySQL重要的全局属性

   - MAX_QUERIES_PER_HOUR：一个用户在一个小时内可以执行查询的次数（基本包含所有语句）
   - MAX_UPDATES_PER_HOUR：一个用户在一个小时内可以执行修改的次数（仅包含修改数据库或表的语句）
   - MAX_CONNECTIONS_PER_HOUR：一个用户在一个小时内可以连接MySQL的时间
   - MAX_USER_CONNECTIONS：一个用户可以在`同一时间连接MySQL实例的数量`

2. 查询全局属性

   ```sql
   # 查询所有的全局变量,可以不使用global关键字
   SHOW VARIABLES;  
   SHOW GLOBAL VARIABLES;
   
   # 查询单个全局变量
   SHOW GLOBAL VARIABLES LIKE '变量名'
   SELECT @@变量名
   ```

3. 修改权限属性的值

   ```sql
   SET @@GLOBAL.wait_timeout = 值
   SET GLOBAL  wait_timeout = 值;
   ```

​    

