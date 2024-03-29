# 前言

1. MySQL功能迭代
   
   | 时间       | 特点                      |
   | -------- | ----------------------- |
   | 20世纪90年代 | MySQL的由来；数据库引擎的创建       |
   | 2000年    | 采用GLP协议：成为开源软件          |
   | 2001年    | 引入InnoDB存储引擎            |
   | 2002年    | MySQL全面支持事务：ACID；外键     |
   | 2003年    | 支持UNION                 |
   | 2004年    | 支持视图、存储过程、触发器、游标、等分布式特性 |

# 第一章 MySQL的安装与配置

## 1.1 MySQL版本说明

1. Standard：推荐大部分用户下载使用
2. Max：除Standard的所有内容外，还有一些附加新特性，未通过正式的测试发布
3. Debug：和Standard类似，但是会包含一些调试信息，会影响性能

## 1.2 MySQL安装与配置

1. Wiindows系统安装
   
   - 官网下载：https://dev.mysql.com/downloads/installer/
   - 安装msi版本：自定义选择service和workbatch

2. Linux系统安装
   
   - **使用PRM包安装**
     
     - 下载清华镜像源：https://mirror.tuna.tsinghua.edu.cn
     
     - 新建MySQL目录：存放MySQL下载文件及解压文件
     
     - 解压下载的MySQL的RPM包：common、libs、client、server主要安装这四个包
       
       ```sh
       [root@localhost mysql]# tar xvf mysql-5.7.28-1.el6.x86_64.rpm-bundle.tar 
       
       mysql-community-server-5.7.28-1.el6.x86_64.rpm
       mysql-community-client-5.7.28-1.el6.x86_64.rpm
       mysql-community-embedded-devel-5.7.28-1.el6.x86_64.rpm
       mysql-community-common-5.7.28-1.el6.x86_64.rpm
       mysql-community-test-5.7.28-1.el6.x86_64.rpm
       mysql-community-libs-5.7.28-1.el6.x86_64.rpm
       mysql-community-devel-5.7.28-1.el6.x86_64.rpm
       mysql-community-embedded-5.7.28-1.el6.x86_64.rpm
       mysql-community-libs-compat-5.7.28-1.el6.x86_64.rpm 
       ```
     
     - CentOS安装会报错，需要安装numactl
       
       ```sh
       yum -y install numactl
       ```
     
     - rpm安装：
       
       ```sh
       rpm -ivh mysql-community-common-5.7.28-1.el6.x86_64.rpm
       rpm -ivh mysql-community-libs-5.7.28-1.el6.x86_64.rpm
       rpm -ivh mysql-community-client-5.7.28-1.el6.x86_64.rpm
       rpm -ivh mysql-community-server-5.7.28-1.el6.x86_64.rpm
       ```
     
     - 配置MySQL
       
       ```sh
       
       ```
       
       # 启动数据库
       
       service mysql start
       
       # 查看数据库状态
       
       service mysql status
       
       # 登录数据库
       
       mysql -u root -p
       
       # 赋值权限
       
       GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;
       flush privileges;
       
       exit
       
       ```
       
       ```
   
   - 使用yum安装MySQL
     
     - 下载yum包：https://dev.mysql.com/downloads/repo/yum/
     
     - 使用wget下载安装包
       
       ```sh
       
       ```
     
     wget https://repo.mysql.com//mysql80-community-release-el7-3.noarch.rpm
     
     ```
     - 本地配置yum
     
     ```sh
     yum localinstall Xxx.rpm
     ```
     
     - 检查mysql源是否安装成功
       
       ```sh
       [root@localhost Downloads]# yum repolist enabled | grep mysql
       mysql-connectors-community/x86_64       MySQL Connectors Community           153
       mysql-tools-community/x86_64            MySQL Tools Community                110
       mysql80-community/x86_64                MySQL 8.0 Community Server           177
       ```
     
     - 安装MySQL
       
       ```sh
       yum install mysql-community-server
       ```
     
     - 启动MySQL
       
       ```sh
       systemctl start mysqld
       ```
     
     - 查看MySQL状态
       
       ```sh
       systemctl status mysqld
       ```
     
     - 开机启动
       
       ```sh
       systemctl enable mysqld
       systemctl daemon-reload
       ```
     
     - 修改root本地登录密码，mysql安装完成之后，在/var/log/mysqld.log文件中给root生成了一个默认密码
       
       ```sh
       grep 'temporary password' /var/log/mysqld.log
       
       mysql -u root -p
       ALTER USER 'root'@'localhost' IDENTIFIED BY '@Panda03lxd'; 
       ```
     
     - 开启3306端口
       
       ```sh
       firewall-cmd --zone=public --add-port=3306/tcp --permanent 
       ```

​       

3. Mac系统安装

4. Docker安装

# 第二章 SQL基础

# 第三章 MySQL数据类型

## 3.1 整数类型

| 整数类型                       | 字节     | 最小值                               | 最大值                                             |
| -------------------------- | ------ | --------------------------------- | ----------------------------------------------- |
| tinyint                    | 1      | 有符号：-128<br />无符号：0               | 有符号：127<br />无符号：255                            |
| smallint                   | 2      | 有符号：-32768<br />无符号：0             | 有符号：-32767<br />无符号：65535                       |
| mediumint                  | 3      | 有符号：-8388608<br />无符号：0           | 有符号：-8388607<br />无符号：1677215                   |
| int、integer                | 4      | 有符号：-2<sup>31</sup>-1 <br />无符号：0 | 有符号：2<sup>31</sup>-1 <br />无符号：2<sup>32</sup>-1 |
| bigint                     | 8      | 有符号：-2<sup>63</sup>-1 <br />无符号：0 | 有符号：2<sup>63</sup>-1 <br />无符号：2<sup>64</sup>-1 |
| **浮点数类型**                  | **字节** | **最小值**                           | **最大值**                                         |
| float                      | 4      |                                   |                                                 |
| double                     | 8      |                                   |                                                 |
| **定点数类型**                  | **字节** | **最小值**                           | **最大值**                                         |
| dec(M,D)<br />decimal(M,D) | M+2    |                                   | 和Double相同                                       |
| **位类型**                    | **字节** | **最小值**                           | **最大值**                                         |
| bit(M)                     | 1~8    | bit(1)                            | bit(8)                                          |

:one: **整数类型(n)** :  不代表占用空间容量。而代表最小显示位数 

- 整数型的数值类型已经限制了取值范围，有符号整型和无符号整型都有，而M值并不代表可以存储的数值字符长度，它代表的是数据在显示时显示的最小长度；
- 默认是int(11)：当存储的字符长度超过M值时，没有任何的影响，只要不超过数值类型限制的范围；
- 当存储的字符长度小于M值时，只有在设置了zerofill用0来填充，才能够看到效果，换句话就是说，没有zerofill，M值就是无用的。

:two: **整数类型(m,d)**  : float与double在插入值发生截取时候不会有四舍五入警告,decimal会产生截断警告，不会四舍五入。

## 3.2 日期时间类型

:anchor: **特点**

- MySQL
- 有多重日期的数据类型
- 每一个类型都有合法的取值范围

:anchor: **日期时间类型**

| 类型        | 日期格式                | 日期范围                                    | 存储大小 |
| --------- | ------------------- | --------------------------------------- | ---- |
| year      | YYYY                | 1901~2155                               | 1字节  |
| time      | HH:MM:SS            | -838:59:59~838:59:59                    | 3字节  |
| date      | YYYY-MM-DD          | 1000-01-01~9999-12-03                   | 3字节  |
| datetime  | YYYY-MM-DD HH:MM:SS | 1000-01-01 00:00:00~9999-12-03 23:59:59 | 8字节  |
| timestamp | YYYY-MM-DD HH:MM:SS | 1970-01-01 00:00:01~2038-01-19 03:14:07 | 4字节  |

## 3.3 文本字符串类型

:anchor: 特征

- 字符串类型用来存储字符串数据，还可以存储其他数据：比如图片和声音等二进制数据
- 文本字符可以进行区分或者不区分大小写的字符比较
- 文本字符串可以进行模式匹配查找

:anchor: MySQL中的文本字符串类型

| 字符类型       | 说明                 | 存储                          |
| ---------- | ------------------ | --------------------------- |
| char(M)    | 固定长度非二进制字符串        | M字节 : M<=255                |
| varchar(M) | 变长非二进制字符串          | L+1字节 : L <= M              |
| tinytext   | **非常小**的非二进制字符串    | L+1字节 : L <= 2<sup>8</sup>  |
| text       | **小** 非二进制字符串      | L+2字节 : L <= 2<sup>16</sup> |
| mediutext  | **中** 非二进制字符串      | L+3字节 : L <= 2<sup>24</sup> |
| longtext   | **大** 非二进制字符串      | L+4字节 : L <= 2<sup>32</sup> |
| enum       | 枚举:只能由一个枚举字符串      | 取决于枚举值的数量:最大65535           |
| set        | 字符串对象可以有0个或多个set成员 | 最多64个成员                     |

## 3.4 二进制字符串类型

:anchor: 特征

- 在数据库中存储的是二进制数据的数据类型。
- **实际编码中，使用二进制类型并不多，就当了解一下好了**

:anchor: MySQL中的二进制字符串类型

| 类型名称          | 说明          |
| ------------- | ----------- |
| bit(M)        | 位字段类型       |
| binary(M)     | 固定长度的二进制字符串 |
| varbinary(M)  | 可变长度的二进制字符串 |
| tinyblob(M)   | 非常小的blob    |
| blob(M)       | 小的blob      |
| mediumblob(M) | 中等大小的blob   |
| longblob(M)   | 非常大的blob    |

> blob类型是一种特殊的二进制类型。
> 
> blob可以用来保存数据量很大的二进制数据
> 
> blob类型与text类型很类似，不同点在于blob类型用于存储二进制数据，blob类型数据是根据其二进制编码进行比较和排序的，而text类型是文本模式进行比较和排序

# 第四章 MySQL运算符

## 4.1 算符运算符

| 运算符 | 作用        |
| --- | --------- |
| +   | 加法运算      |
| -   | 减法运算      |
| *   | 乘法运算      |
| /   | 除法运算:返回商  |
| %   | 求余运算:返回余数 |

## 4.2 比较运算符

| 运算符          | 作用                         |
| ------------ | -------------------------- |
| =            | 等于                         |
| <=>          | 安全的等于                      |
| <>   或者   != | 不等于                        |
| <=           | 小于等于                       |
| <            | 小于                         |
| \>=          | 大于等于                       |
| >            | 大于                         |
| is null      | 判断一个值是否为NULL               |
| is not null  | 判断一个值是否不为NULL              |
| least        | 在有两个或多个参数时候返回最小值           |
| between and  | 判断一个值是否在两个值中间              |
| isnull       | 判断一个值是否为NULL:与is null 效果一样 |
| in           | 判断一个值是否在in列表中的任意一个值        |
| not in       | 判断一个值是否不在in列表中的任意一个值       |
| like         | 通配符匹配                      |
| regexp       | 正则表达式匹配                    |

## 4.3 逻辑运算符

| 运算符         | 作用   |
| ----------- | ---- |
| not  或者  !  | 逻辑非  |
| and  或者 &&  | 逻辑与  |
| or  或者 \|\| | 逻辑或  |
| xor         | 逻辑异或 |

## 4.4 位操作运算符

| 运算符 | 作用  |
| --- | --- |
| \|  | 位或  |
| &   | 位与  |
| ^   | 为异或 |
| <<  | 位左移 |
| \>> | 位右移 |
| ~   | 位取反 |

## 4.5 运算符优先级

| 运算符优先级 - 从低到高                                  |
| ---------------------------------------------- |
| = (赋值运算)                                       |
| \|\|，or                                        |
| xor                                            |
| && ，and                                        |
| not                                            |
| between，case，when，then，else                    |
| =(比较运算)，<==>，>=，>，<=，<，<>，!=，is，like，regexp，in |
| \|                                             |
| &                                              |
| <<，>>                                          |
| -，+                                            |
| *，/，%                                          |
| ^                                              |
| -(符号)，~(位反转)                                   |
| ！                                              |

# 第五章 常用函数

## 5.1 字符串函数

| 函数                    | 功能                         |
| --------------------- | -------------------------- |
| concat(s1,s2...)      | 连接s1,s2为一个字符串              |
| insert(str,x,y,inStr) | 将字符串从x位置,y个字符长的字符串替换为inStr |
| lower(str)            | 将字符串str中的字符变为小写字母          |
| upper(str)            | 将字符串str中的字符变为大写字母          |
| left(str,x)           | 返回字符str最左边的x个字符            |
| right(str,x)          | 返回字符str最右边的x个字符            |
| lpad(str,n,pad)       | 用字符串pad对str最左边进行填充,直到长度为n  |
| rpad(str,npad)        | 用字符串pad对str最右边进行填充,直到长度为n  |
| trim(str)             | 去掉字符串str行头和行尾的空格           |
| ltrim(str)            | 去掉字符串str行头的空格              |
| rtrim(str)            | 去掉字符串str行尾的空格              |
| repeate(str,x)        | 返回str重复x次的结果               |
| replace(str,a,b)      | 用字符串b替换字符串str中所有出现的字符串a    |
| strcmp(s1,s2)         | 比较字符串s1和s2                 |
| substring(str,x,y)    | 返回字符串str的x位置起y个字符长的字符串     |

## 5.2 数值函数

| 函数            | 功能                     |
| ------------- | ---------------------- |
| abs(x)        | 返回x的绝对值                |
| ceil(x)       | 返回大于x的最小整数  1.4  →  2  |
| floor(x)      | 返回小于x的最大整数   1.9  →  1 |
| mod(x,y)      | 返回x/y的模(余数)            |
| rand()        | 返回0~1内的随机数             |
| round(x,y)    | 返回参数x的四舍五入后有y为小数的值     |
| truncate(x,y) | 返回数值x截断为y位小数的结果        |

## 5.3 日期函数

| 函数                                | 功能                    |
| --------------------------------- | --------------------- |
| curdate()                         | 返回当前日期                |
| curtime()                         | 返回当前时间                |
| now()                             | 返回当前日期时间              |
| unix_timestamp(date)              | 返回日期date的UNIX时间戳      |
| from_unixtime()                   | 返回UNIX时间戳的日期值         |
| year(date)                        | 返回日期date的年份           |
| monthname(date)                   | 返回日期date的月份名称         |
| week(date)                        | 返回日期date为一年中的第几周      |
| hour(time)                        | 返回时间time的小时值          |
| minute(time)                      | 返回时间time的分钟值          |
| date_format(date,fmt)             | 返回按字符串fmt格式化日期date值   |
| date_add(date,interval expr type) | 返回一个日期或时间加上一个事件间隔的时间值 |
| datediff(e1,e2)                   | 返回起始时间e1和结束时间e2之间的天数  |

- date_fmt是常用格式符
  
  | 格式符     | 说明                       |
  | ------- | ------------------------ |
  | %S 或 %s | 两位数字的秒(00,01,..,59)      |
  | %i      | 两位数字的分(00,01,..,59)      |
  | %H      | 24小时制的两位小时数(00,01,..,24) |
  | %h      | 12小时制的两位小时数(00,01,..,12) |
  | %d      | 两位数字的天数(01,02,..,31)     |
  | %m      | 两位数字的月数(01,02,..,12)     |
  | %Y      | 四位数字的年份                  |
  | %y      | 两位数字的年份                  |

- date_add的type说明
  
  | 表达式类型         | 描述   | 格式          |
  | ------------- | ---- | ----------- |
  | hour          | 小时   | hh          |
  | minute        | 分钟   | mm          |
  | second        | 秒    | ss          |
  | year          | 年    | YY          |
  | month         | 月    | MM          |
  | day           | 天    | DD          |
  | year_month    | 年和月  | YY-MM       |
  | day_hour      | 日和小时 | DD hh       |
  | day_minute    | 日和分钟 | DD hh:mm    |
  | day_second    | 日和秒  | DD hh:mm:ss |
  | hour_minute   | 小时和分 | hh:mm       |
  | hour_second   | 小时和秒 | hh:ss       |
  | minute_second | 分钟和秒 | mm:ss       |

## 5.4 流程函数

| 函数                                               | 功能                    |
| ------------------------------------------------ | --------------------- |
| if(value,t,f)                                    | 如果value为真返回t，否则返回f    |
| ifnull(v1,v2)                                    | 如果v1不为空返回v1，否则返回v2    |
| case when [v1] then [r1] ... else [def] end      | 如果v1为真返回r1，否则返回def    |
| case [ex] when [v1] then [r1] ... else [def] end | 如果ex等于v1则返回r1，否则返回def |

## 5.5 其他常用函数

| 函数              | 功能                             |
| --------------- | ------------------------------ |
| database()      | 返回当前数据库名称                      |
| version()       | 返回当前数据库版本                      |
| user()          | 返回当前登陆用户名                      |
| inet_aton(IP)   | 将IP字符串转为数字表示                   |
| inet_ntoa(数值)   | 将数字转为IP格式表示                    |
| password(明文字符串) | 返回明文字符串的加密后的结果，<br />数据库系统加密方式 |
| md5()           | 返回字符串的md5值                     |

## 5.6 学习小结

1. 在上述总结的函数中并不是所有函数，但涵盖了日常开发中常用的函数；
2. 需要在平时开发、学习中积累并熟练掌握；
3. 学习查阅文档，学习其他函数

# 第六章 图形化工具介绍

## 6.1 Workbench

## 6.2 Navicat

## 6.3 Datagrip

# -----



# 前言

# 第一章 MySQL安装

# 第二章 SQL基础

## 2.1 SQL简介

        SQL（Structure Query Language）：结构化查询语言，是用于和数据库进行交互的一种语言；

## 2.2 SQL语言

1. DDL（Data Definition Language）：数据定义语言，作用是对数据库对象的定义：如数据库，数据表、列、索引等等；DDL包含的sql关键字包含：create、drop、alert；
2. DML（Data Manipulation Language）：数据库操作语言，作用是添加，删除，更新和查询数据库记录，并检查数据完整性；DML包含的SQL关键字包含：insert、update、delete、select；
3. DCL（Data Control Language）：数据库控制语言，作用是控制不同的数据段的许可级别和访问级别的语句：如定义数据库、表、字段不同用户的访问权限和安全级别；DCL包含的SQL关键字包含：grant、revoke。

## 2.3 小结

# 前言

1. MySQL功能迭代
   
   | 时间       | 特点                      |
   | -------- | ----------------------- |
   | 20世纪90年代 | MySQL的由来；数据库引擎的创建       |
   | 2000年    | 采用GLP协议：成为开源软件          |
   | 2001年    | 引入InnoDB存储引擎            |
   | 2002年    | MySQL全面支持事务：ACID；外键     |
   | 2003年    | 支持UNION                 |
   | 2004年    | 支持视图、存储过程、触发器、游标、等分布式特性 |

# 第一章 MySQL的安装与配置

## 1.1 MySQL版本说明

1. Standard：推荐大部分用户下载使用
2. Max：除Standard的所有内容外，还有一些附加新特性，未通过正式的测试发布
3. Debug：和Standard类似，但是会包含一些调试信息，会影响性能

## 1.2 MySQL安装与配置

1. Wiindows系统安装
   
   - 官网下载：[MySQL :: Download MySQL Installer](https://dev.mysql.com/downloads/installer/)
   - 安装msi版本：自定义选择service和workbatch

2. Linux系统安装
   
   - **使用PRM包安装**
     
     - 下载清华镜像源：[https://mirror.tuna.tsinghua.edu.cn](https://mirror.tuna.tsinghua.edu.cn)
     
     - 新建MySQL目录：存放MySQL下载文件及解压文件
     
     - 解压下载的MySQL的RPM包：common、libs、client、server主要安装这四个包
       
       ```sh
       [root@localhost mysql]# tar xvf mysql-5.7.28-1.el6.x86_64.rpm-bundle.tar 
       
       mysql-community-server-5.7.28-1.el6.x86_64.rpm
       mysql-community-client-5.7.28-1.el6.x86_64.rpm
       mysql-community-embedded-devel-5.7.28-1.el6.x86_64.rpm
       mysql-community-common-5.7.28-1.el6.x86_64.rpm
       mysql-community-test-5.7.28-1.el6.x86_64.rpm
       mysql-community-libs-5.7.28-1.el6.x86_64.rpm
       mysql-community-devel-5.7.28-1.el6.x86_64.rpm
       mysql-community-embedded-5.7.28-1.el6.x86_64.rpm
       mysql-community-libs-compat-5.7.28-1.el6.x86_64.rpm 
       ```
     
     - CentOS安装会报错，需要安装numactl
       
       ```sh
       yum -y install numactl
       ```
     
     - rpm安装：
       
       ```sh
       rpm -ivh mysql-community-common-5.7.28-1.el6.x86_64.rpm
       rpm -ivh mysql-community-libs-5.7.28-1.el6.x86_64.rpm
       rpm -ivh mysql-community-client-5.7.28-1.el6.x86_64.rpm
       rpm -ivh mysql-community-server-5.7.28-1.el6.x86_64.rpm
       ```
     
     - 配置MySQL
       
       # 启动数据库
       
       service mysql start
       
       # 查看数据库状态
       
       service mysql status
       
       # 登录数据库
       
       mysql -u root -p
       
       # 赋值权限
       
       GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;
       flush privileges;
       
       exit
   
   - 使用yum安装MySQL
     
     - 下载yum包：[MySQL :: Download MySQL Yum Repository](https://dev.mysql.com/downloads/repo/yum/)
     
     - 使用wget下载安装包

```
wget https://repo.mysql.com//mysql80-community-release-el7-3.noarch.rpm

````
- 本地配置yum

```sh
yum localinstall Xxx.rpm
````

- 检查mysql源是否安装成功

  ```sh
  [root@localhost Downloads]# yum repolist enabled | grep mysql
  mysql-connectors-community/x86_64       MySQL Connectors Community           153
  mysql-tools-community/x86_64            MySQL Tools Community                110
  mysql80-community/x86_64                MySQL 8.0 Community Server           177
  ```

- 安装MySQL

  ```sh
  yum install mysql-community-server
  ```

- 启动MySQL

  ```sh
  systemctl start mysqld
  ```

- 查看MySQL状态

  ```sh
  systemctl status mysqld
  ```

- 开机启动

  ```sh
  systemctl enable mysqld
  systemctl daemon-reload
  ```

- 修改root本地登录密码，mysql安装完成之后，在/var/log/mysqld.log文件中给root生成了一个默认密码

  ```sh
  grep 'temporary password' /var/log/mysqld.log

  mysql -u root -p
  ALTER USER 'root'@'localhost' IDENTIFIED BY '@Panda03lxd'; 
  ```

- 开启3306端口

  ```sh
  firewall-cmd --zone=public --add-port=3306/tcp --permanent 
  ```
```

​

3. Mac系统安装

4. Docker安装

# 第二章 SQL基础

# 第三章 MySQL数据类型

## 3.1 整数类型

| 整数类型                     | 字节     | 最小值                   | 最大值                         |
| ------------------------ | ------ | --------------------- | --------------------------- |
| tinyint                  | 1      | 有符号：-128<br>无符号：0     | 有符号：127<br>无符号：255          |
| smallint                 | 2      | 有符号：-32768<br>无符号：0   | 有符号：-32767<br>无符号：65535     |
| mediumint                | 3      | 有符号：-8388608<br>无符号：0 | 有符号：-8388607<br>无符号：1677215 |
| int、integer              | 4      | 有符号：-231-1 <br>无符号：0  | 有符号：231-1 <br>无符号：232-1     |
| bigint                   | 8      | 有符号：-263-1 <br>无符号：0  | 有符号：263-1 <br>无符号：264-1     |
| **浮点数类型**                | **字节** | **最小值**               | **最大值**                     |
| float                    | 4      |                       |                             |
| double                   | 8      |                       |                             |
| **定点数类型**                | **字节** | **最小值**               | **最大值**                     |
| dec(M,D)<br>decimal(M,D) | M+2    |                       | 和Double相同                   |
| **位类型**                  | **字节** | **最小值**               | **最大值**                     |
| bit(M)                   | 1~8    | bit(1)                | bit(8)                      |

:one: **整数类型(n)** : 不代表占用空间容量。而代表最小显示位数

- 整数型的数值类型已经限制了取值范围，有符号整型和无符号整型都有，而M值并不代表可以存储的数值字符长度，它代表的是数据在显示时显示的最小长度；
- 默认是int(11)：当存储的字符长度超过M值时，没有任何的影响，只要不超过数值类型限制的范围；
- 当存储的字符长度小于M值时，只有在设置了zerofill用0来填充，才能够看到效果，换句话就是说，没有zerofill，M值就是无用的。

:two: **整数类型(m,d)** : float与double在插入值发生截取时候不会有四舍五入警告,decimal会产生截断警告，不会四舍五入。

## 3.2 日期时间类型

:anchor: **特点**

- MySQL
- 有多重日期的数据类型
- 每一个类型都有合法的取值范围

:anchor: **日期时间类型**

| 类型        | 日期格式                | 日期范围                                    | 存储大小 |
| --------- | ------------------- | --------------------------------------- | ---- |
| year      | YYYY                | 1901~2155                               | 1字节  |
| time      | HH:MM:SS            | -838:59:59~838:59:59                    | 3字节  |
| date      | YYYY-MM-DD          | 1000-01-01~9999-12-03                   | 3字节  |
| datetime  | YYYY-MM-DD HH:MM:SS | 1000-01-01 00:00:00~9999-12-03 23:59:59 | 8字节  |
| timestamp | YYYY-MM-DD HH:MM:SS | 1970-01-01 00:00:01~2038-01-19 03:14:07 | 4字节  |

## 3.3 文本字符串类型

:anchor: 特征

- 字符串类型用来存储字符串数据，还可以存储其他数据：比如图片和声音等二进制数据
- 文本字符可以进行区分或者不区分大小写的字符比较
- 文本字符串可以进行模式匹配查找

:anchor: MySQL中的文本字符串类型

| 字符类型       | 说明                 | 存储                |
| ---------- | ------------------ | ----------------- |
| char(M)    | 固定长度非二进制字符串        | M字节 : M<=255      |
| varchar(M) | 变长非二进制字符串          | L+1字节 : L <= M    |
| tinytext   | **非常小**的非二进制字符串    | L+1字节 : L <= 28   |
| text       | **小** 非二进制字符串      | L+2字节 : L <= 216  |
| mediutext  | **中** 非二进制字符串      | L+3字节 : L <= 224  |
| longtext   | **大** 非二进制字符串      | L+4字节 : L <= 232  |
| enum       | 枚举:只能由一个枚举字符串      | 取决于枚举值的数量:最大65535 |
| set        | 字符串对象可以有0个或多个set成员 | 最多64个成员           |

## 3.4 二进制字符串类型

:anchor: 特征

- 在数据库中存储的是二进制数据的数据类型。
- **实际编码中，使用二进制类型并不多，就当了解一下好了**

:anchor: MySQL中的二进制字符串类型

| 类型名称          | 说明          |
| ------------- | ----------- |
| bit(M)        | 位字段类型       |
| binary(M)     | 固定长度的二进制字符串 |
| varbinary(M)  | 可变长度的二进制字符串 |
| tinyblob(M)   | 非常小的blob    |
| blob(M)       | 小的blob      |
| mediumblob(M) | 中等大小的blob   |
| longblob(M)   | 非常大的blob    |

> blob类型是一种特殊的二进制类型。
> 
> blob可以用来保存数据量很大的二进制数据
> 
> blob类型与text类型很类似，不同点在于blob类型用于存储二进制数据，blob类型数据是根据其二进制编码进行比较和排序的，而text类型是文本模式进行比较和排序

# 第四章 MySQL运算符

## 4.1 算符运算符

| 运算符 | 作用        |
| --- | --------- |
| +   | 加法运算      |
| -   | 减法运算      |
| *   | 乘法运算      |
| /   | 除法运算:返回商  |
| %   | 求余运算:返回余数 |

## 4.2 比较运算符

| 运算符         | 作用                         |
| ----------- | -------------------------- |
| =           | 等于                         |
| <=>         | 安全的等于                      |
| <> 或者 !=    | 不等于                        |
| <=          | 小于等于                       |
| <           | 小于                         |
| >=          | 大于等于                       |
| >           | 大于                         |
| is null     | 判断一个值是否为NULL               |
| is not null | 判断一个值是否不为NULL              |
| least       | 在有两个或多个参数时候返回最小值           |
| between and | 判断一个值是否在两个值中间              |
| isnull      | 判断一个值是否为NULL:与is null 效果一样 |
| in          | 判断一个值是否在in列表中的任意一个值        |
| not in      | 判断一个值是否不在in列表中的任意一个值       |
| like        | 通配符匹配                      |
| regexp      | 正则表达式匹配                    |

## 4.3 逻辑运算符

| 运算符       | 作用   |
| --------- | ---- |
| not 或者 !  | 逻辑非  |
| and 或者 && | 逻辑与  |
| or 或者 \   | \    |
| xor       | 逻辑异或 |

## 4.4 位操作运算符

| 运算符 | 作用  |
| --- | --- |
| \   |     |
| &   | 位与  |
| ^   | 为异或 |
| <<  | 位左移 |
| >>  | 位右移 |
| ~   | 位取反 |

## 4.5 运算符优先级

| 运算符优先级 - 从低到高                                  |
| ---------------------------------------------- |
| = (赋值运算)                                       |
| \                                              |
| xor                                            |
| && ，and                                        |
| not                                            |
| between，case，when，then，else                    |
| =(比较运算)，<==>，>=，>，<=，<，<>，!=，is，like，regexp，in |
| \                                              |
| &                                              |
| <<，>>                                          |
| -，+                                            |
| *，/，%                                          |
| ^                                              |
| -(符号)，~(位反转)                                   |
| ！                                              |

# 第五章 常用函数

## 5.1 字符串函数

| 函数                    | 功能                         |
| --------------------- | -------------------------- |
| concat(s1,s2...)      | 连接s1,s2为一个字符串              |
| insert(str,x,y,inStr) | 将字符串从x位置,y个字符长的字符串替换为inStr |
| lower(str)            | 将字符串str中的字符变为小写字母          |
| upper(str)            | 将字符串str中的字符变为大写字母          |
| left(str,x)           | 返回字符str最左边的x个字符            |
| right(str,x)          | 返回字符str最右边的x个字符            |
| lpad(str,n,pad)       | 用字符串pad对str最左边进行填充,直到长度为n  |
| rpad(str,npad)        | 用字符串pad对str最右边进行填充,直到长度为n  |
| trim(str)             | 去掉字符串str行头和行尾的空格           |
| ltrim(str)            | 去掉字符串str行头的空格              |
| rtrim(str)            | 去掉字符串str行尾的空格              |
| repeate(str,x)        | 返回str重复x次的结果               |
| replace(str,a,b)      | 用字符串b替换字符串str中所有出现的字符串a    |
| strcmp(s1,s2)         | 比较字符串s1和s2                 |
| substring(str,x,y)    | 返回字符串str的x位置起y个字符长的字符串     |

## 5.2 数值函数

| 函数            | 功能                 |
| ------------- | ------------------ |
| abs(x)        | 返回x的绝对值            |
| ceil(x)       | 返回大于x的最小整数 1.4 → 2 |
| floor(x)      | 返回小于x的最大整数 1.9 → 1 |
| mod(x,y)      | 返回x/y的模(余数)        |
| rand()        | 返回0~1内的随机数         |
| round(x,y)    | 返回参数x的四舍五入后有y为小数的值 |
| truncate(x,y) | 返回数值x截断为y位小数的结果    |

## 5.3 日期函数

| 函数                                | 功能                    |
| --------------------------------- | --------------------- |
| curdate()                         | 返回当前日期                |
| curtime()                         | 返回当前时间                |
| now()                             | 返回当前日期时间              |
| unix_timestamp(date)              | 返回日期date的UNIX时间戳      |
| from_unixtime()                   | 返回UNIX时间戳的日期值         |
| year(date)                        | 返回日期date的年份           |
| monthname(date)                   | 返回日期date的月份名称         |
| week(date)                        | 返回日期date为一年中的第几周      |
| hour(time)                        | 返回时间time的小时值          |
| minute(time)                      | 返回时间time的分钟值          |
| date_format(date,fmt)             | 返回按字符串fmt格式化日期date值   |
| date_add(date,interval expr type) | 返回一个日期或时间加上一个事件间隔的时间值 |
| datediff(e1,e2)                   | 返回起始时间e1和结束时间e2之间的天数  |

- date_fmt是常用格式符
  
  | 格式符     | 说明                       |
  | ------- | ------------------------ |
  | %S 或 %s | 两位数字的秒(00,01,..,59)      |
  | %i      | 两位数字的分(00,01,..,59)      |
  | %H      | 24小时制的两位小时数(00,01,..,24) |
  | %h      | 12小时制的两位小时数(00,01,..,12) |
  | %d      | 两位数字的天数(01,02,..,31)     |
  | %m      | 两位数字的月数(01,02,..,12)     |
  | %Y      | 四位数字的年份                  |
  | %y      | 两位数字的年份                  |

- date_add的type说明
  
  | 表达式类型         | 描述   | 格式          |
  | ------------- | ---- | ----------- |
  | hour          | 小时   | hh          |
  | minute        | 分钟   | mm          |
  | second        | 秒    | ss          |
  | year          | 年    | YY          |
  | month         | 月    | MM          |
  | day           | 天    | DD          |
  | year_month    | 年和月  | YY-MM       |
  | day_hour      | 日和小时 | DD hh       |
  | day_minute    | 日和分钟 | DD hh:mm    |
  | day_second    | 日和秒  | DD hh:mm:ss |
  | hour_minute   | 小时和分 | hh:mm       |
  | hour_second   | 小时和秒 | hh:ss       |
  | minute_second | 分钟和秒 | mm:ss       |

## 5.4 流程函数

| 函数                                               | 功能                    |
| ------------------------------------------------ | --------------------- |
| if(value,t,f)                                    | 如果value为真返回t，否则返回f    |
| ifnull(v1,v2)                                    | 如果v1不为空返回v1，否则返回v2    |
| case when [v1] then [r1] ... else [def] end      | 如果v1为真返回r1，否则返回def    |
| case [ex] when [v1] then [r1] ... else [def] end | 如果ex等于v1则返回r1，否则返回def |

## 5.5 其他常用函数

| 函数              | 功能                           |
| --------------- | ---------------------------- |
| database()      | 返回当前数据库名称                    |
| version()       | 返回当前数据库版本                    |
| user()          | 返回当前登陆用户名                    |
| inet_aton(IP)   | 将IP字符串转为数字表示                 |
| inet_ntoa(数值)   | 将数字转为IP格式表示                  |
| password(明文字符串) | 返回明文字符串的加密后的结果，<br>数据库系统加密方式 |
| md5()           | 返回字符串的md5值                   |

## 5.6 学习小结

1. 在上述总结的函数中并不是所有函数，但涵盖了日常开发中常用的函数；
2. 需要在平时开发、学习中积累并熟练掌握；
3. 学习查阅文档，学习其他函数

# 第六章 图形化工具介绍

## 6.1 Workbench

## 6.2 Navicat

## 6.3 Datagrip

# 存储过程

1. 使用说明：存储过程是数据库的一个重要对象，可以封装SQL语句集，可以用来完成一些较复杂的业务逻辑，并且可以指定参数，传教时会先预编译，用户后续调用都不需要再次编译；

2. 存储过程特点
   
   - 优点
     - 在生产环境下，可以通过直接修改存储过程的方式修改业务逻辑，不需要重启服务器
     - 执行速度快，存储过程经过编译后比单独执行要快
     - 角色网络传输力量
     - 方便优化
   - 缺点
     - 过程化编译，复杂业务处理维护成本高
     - 调试不方便
     - 可移植性差，不同数据库的存储过程语法不一样

3. 环境准备

4. 声明结束符：mysql使用‘;’作为结束符，而在存储过程中，使用‘;’作为一段sql语句的结束，会导致存储过程冲突
   
   ```sql
   delimiter $$
   ```

5. 语法结构
   
   ```sql
   CREATE
     [DEFINER = user]
     PROCEDURE 存储过程名称(参数[,参数])
     [特性定义]
     BEGIN
         执行体
     END$$
   ```

6. 基本语法
   
   - 局部变量：只能定义在begin-end语句中有效
     
     ```sql
     -- 声明变量
     declare 变量名称 varchar(10) default '';
     -- 变量赋值
     set 变量名称 = '变量值';
     -- into 关键字赋值
     select 字段 into 变量名 from 表名 where...
     ```
   
   - 用户变量：在一个客户端链接中的sql执行都有效
     
     ```sql
     -- 使用@作为变量前缀作为用户变量，不需要变量定义
     ```
   
   - 会话变量
   
   - 全局变量：直接使用，不需要变量声明
     
     ```sql
     @全局变量名称
     ```

7. 参数
   
   - 基本语法：参数使用逗号分隔
     
     ```sql
     -- 入参
     create procedure 存储过程名称(in 参数名 参数类型,...)
     -- 出参
     create procedure 存储过程名称(out 参数名 参数类型,...)
     -- 入参并且出参
     create procedure 存储过程名称(inout 参数名 参数类型,...)
     ```

8. 流程控制 - 判断
   
   - If语法
     
     ```sql
     IF 条件判断 THEN 执行语句
     ELSEIF 条件判断 THEN 执行语句
     ELSE 执行语句
     END IF
     ```
   
   - case语法
     
     ```sql
     CASE '值'
     WHEN '' THEN 执行语句
     WHEN '' THEN 执行语句
     END CASE
     ```
   
   - case语法二
     
     ```sql
     CASE
       WHEN 条件 THEN 执行语句
     END CASE
     ```

9. 流程控制
   
   - loop语法：是死循环，需要手动退出，leave=breale；iteratior=continue
     
     ```sql
     别名:loop
       -- leave = breake
       leave 别名
       -- iterate = continue
       iterate 别名
     end loop 别名
     ```
   
   - repeat语法：类似于do-while
     
     ```sql
     循环别名:repeat
       执行语句
     until 条件语句
     end repeat 循环别名
     ```
   
   - while语法
     
     ```sql
     while 条件语句 do
       执行语句
     end while
     ```

10. 游标：使用游标得到某个结果集，逐行处理结果
