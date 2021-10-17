# 前言

[TOC]

# 第一章 Python MySql环境

## 1.1 下载pymysql

- 命令行

  ```python
  pip install pymysql
  ```

## 1.2 连接MySQL

1. 连接MySQL

   ```python
   # 打开数据库连接，并指定数据库
   conn = pymysql.connect('服务地址',user = "用户名",passwd = "密码",db = "数据库名称")
   
   # 打开数据库连接, 不指定数据库的连接
   conn = pymysql.connect('服务地址',user = "用户名",passwd = "密码")
   ```

2. 创建游标：要想操作数据库，光连接数据是不够的，必须拿到操作数据库的游标，才能进行后续的操作，比如读取数据、添加数据。通过获取到的数据库连接实例conn下的cursor()方法来创建游标。游标用来接收返回结果

   ```python
   conn = pymysql.connect('服务地址',user = "用户名",passwd = "密码",db = "数据库名称")
   conn.cursor()
   # 先关闭游标
   cursor.close()
   # 再关闭数据库连接
   conn.close()
   ```

# 第二章 pymysql API说明

1. execute(query,args=None)：执行单条的sql语句，执行成功后返回受影响的行数
   - **query**：要执行的sql语句，字符串类型
   - **args**：可选的序列或映射，用于query的参数值。如果args为序列，query中必须使用%s做占位符；如果args为映射，query中必须使用%(key)s做占位符
2. executemany(query,args=None)：批量执行sql语句，比如批量插入数据，执行成功后返回受影响的行数
   - **query**：要执行的sql语句，字符串类型
   - **args**：嵌套的序列或映射，用于query的参数值

# 第三章 操作实例代码

## 3.1 创建数据库

```python
'''创建数据库'''
import pymysql
#打开数据库连接，不需要指定数据库，因为需要创建数据库
conn = pymysql.connect('localhost',user = "root",passwd = "123456")
#获取游标
cursor=conn.cursor()
#创建pythonBD数据库
cursor.execute('CREATE DATABASE IF NOT EXISTS pythonDB DEFAULT CHARSET utf8 COLLATE utf8_general_ci;')
cursor.close()#先关闭游标
conn.close()#再关闭数据库连接
print('创建pythonBD数据库成功')
```

## 3.2 创建数据表

```python
import pymysql
#打开数据库连接
conn = pymysql.connect('localhost',user = "root",passwd = "123456",db = "testdb")
#获取游标
cursor=conn.cursor()
print(cursor)

#创建user表
cursor.execute('drop table if exists user')
sql="""CREATE TABLE IF NOT EXISTS `user` (
	  `id` int(11) NOT NULL AUTO_INCREMENT,
	  `name` varchar(255) NOT NULL,
	  `age` int(11) NOT NULL,
	  PRIMARY KEY (`id`)
	) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=0"""

cursor.execute(sql)
cursor.close()#先关闭游标
conn.close()#再关闭数据库连接
print('创建数据表成功')
```

## 3.3 新增数据

```python
# 方式一: 直接执行完整是SQL语句
insert=cursor.execute("insert into user(name,age) values('lili',18)")

# 方式二: 使用SQL语句占位符,动态为SQL参数赋值
sql="insert into user values(%s,%s,%s)"
cursor.execute(sql,(3,'kongsh',20))

# 方式三: 批量新增
sql="insert into user(id,name,age) values (%s,%s,%s)"
values = ((4,'wen',20),(5,'tom',10),(6,'test',30))
insert=cursor.executemany(sql,values)
```

## 3.4 修改数据

```python
#更新一条数据
update=cur.execute("update user set age=100 where name='kongsh'")
print ('修改后受影响的行数为：',update)

#更新2条数据
sql="update user set age=%s where name=%s"
update=cur.executemany(sql,[(15,'kongsh'),(18,'wen')])
```

## 3.5 删除数据

```python
#删除1条数据
cur.execute("delete from user where id=1")

#删除2条数据
sql="delete from user where id=%s"
cur.executemany(sql,[(3),(4)])
```

## 3.6 查询数据

> 查询数据使用execute()函数得到的只是受影响的行数，并不能真正拿到查询的内容。cursor对象还提供了3种提取数据的方法：fetchone、fetchmany、fetchall.。每个方法都会导致游标动，所以必须注意游标的位置。
>
> - cursor.fetchone():获取游标所在处的一行数据，返回元组，没有返回Nonef；etchone()函数必须跟exceute()函数结合使用，并且在exceute()函数之后使用
> - cursor.fetchmany(size):接受size行返回结果行。如果size大于返回的结果行的数量，则会返回cursor.arraysize条数据。
> - cursor. fetchall():接收全部的返回结果行。

1. fetchone

   ```python
   '''fetchone'''
   import pymysql
   #打开数据库连接
   conn=pymysql.connect('localhost','root','123456')
   conn.select_db('pythondb')
   #获取游标
   cur=conn.cursor()
   
   cur.execute("select * from user;")
   while 1:
       res=cur.fetchone()
       if res is None:
           #表示已经取完结果集
           break
       print (res)
   cur.close()
   conn.commit()
   conn.close()
   print('sql执行成功')
   ```

2. fetchmany：从exceute()函数结果中获取游标所在处的size条数据，并以元组的形式返回，元组的每一个元素都也是一个由一行数据组成的元组，如果size大于有效的结果行数，将会返回cursor.arraysize条数据，但如果游标所在处没有数据，将返回空元组。查询几条数据，游标将会向下移动几个位置。fetmany()函数必须跟exceute()函数结合使用，并且在exceute()函数之后使用

   ```python
   import pymysql
   #打开数据库连接
   conn=pymysql.connect(‘localhost’,‘root’,‘123456’)
   conn.select_db(‘pythondb’)
   #获取游标
   cur=conn.cursor()
   
   cur.execute(“select * from user”)
   #取3条数据
   resTuple=cur.fetchmany(3)
   print(type(resTuple))
   for res in resTuple:
   print (res)
   
   cur.close()
   conn.commit()
   conn.close()
   print(‘sql执行成功’)
   ```

3. fetchall：获取游标所在处开始及以下所有的数据，并以元组的形式返回，元组的每一个元素都也是一个由一行数据组成的元组，如果游标所在处没有数据，将返回空元组。执行完这个方法后，游标将移动到数据库表的最后

   ```python
   import pymysql
   #打开数据库连接
   conn=pymysql.connect(‘localhost’,‘root’,‘123456’)
   conn.select_db(‘pythondb’)
   #获取游标
   cur=conn.cursor()
   
   cur.execute(“select * from user”)
   #取所有数据
   resTuple=cur.fetchall()
   print(type(resTuple))
   print (‘共%d条数据’%len(resTuple))
   
   cur.close()
   conn.commit()
   conn.close()
   print(‘sql执行成功’)
   ```

## 3.7 事务

```python
try:
   # 执行sql语句
   cursor.execute(sql)
   # 提交事务
   conn.commit()
except:
   # 发生错误时回滚
   conn.rollback()
```

