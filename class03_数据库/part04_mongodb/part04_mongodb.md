# 第一章 MongoDB再入门

## 1.1 MongoDB特性

1. MongoDB是基于JSON模型的，可以显著提升开发效率，使用文档嵌套模型，实现最快速的开发效率，用空间换时间
2. MongoDB有卓越的横向扩展能力：字段灵活，可以快速响应业务变化
3. MongoDB是非关系型数据库的一种，与传统关系型数据库的范式设计理念不相符，MongoDB根推荐时间文档嵌套来代替关系型数据库中的多表关联
4. MongoDB依赖于JSON和JavaScript语法
5. MongoDB是使用分片进行横向扩展实现高可用，但是分片的扩展和调优是MongoDB的难点，需要花时间研究
6. 分片数据可以支持海量数据，并且可以做到无缝扩容

## 1.2 MongoDB安装

<font size=4 color=blue>**1. Windows系统**</font>

- 偶数版本号为稳定版本，下载合适的Windows版本：[下载地址](https://www.mongodb.com/download-center/community)

- 安装时候**"install mongoDB compass"** 不勾选，下载慢而且不好用

- 可以将MongoDB服务加入Windows服务，这样就不用每次手动启动MongoDB服务了，不建议这样做

  - 使用mongod.exe的--install选项来安装服务，使用--config选项来指定之前创建的配置文件

    ```sh
    ~\mongod.exe --config "C:\mongodb\mongod.cfg" --install
    ```

  - 启动MongoDB服务

    ```sh
    net start MongoDB
    ```

  - 关闭MongoDB服务

    ```sh
    net stop MongoDB
    ```

  - 使用mongod.exe移除 MongoDB 服务

    ```sh
    ~\mongod.exe --remove
    ```

- 启动MongoDB服务

  ```sh
  
  ```

- 使用MongoShell测试Mongo服务：在bin目录中打开doc窗口

  ```sh
  mongo  		# 显示连接成功
  show dbs; 	# 查看所有的数据库
  exit;		# 退出mongo命令窗口
  ```

<font size=4 color=blue>**2. Linux系统**</font>

- 偶数版本号为稳定版本，下载合适的Windows版本：[下载地址](https://www.mongodb.com/download-center/community)

- 解压MongoDB.tar安装包到/data包中

  ```sh
  export PATH=$PATH:/data/database_mongo/bin
  ```

- 配置日志和数据文件夹：将mongo的加入到环境变量

  ```sh
  mongod --dbpath /data/db --port 27017 --logpath /data/db/mongld.log --fork
  ```

- 新建MongoDB数据文件夹

  ```sh
  mkidr -p /data /data/db
  ```

<font size=4 color=blue>**3. Docker镜像**</font>

<font size=4 color=blue>**4. MongoDB云**</font>

- MongoDB云服务器地址：https://www.mongodb.com/cloud
- 注册账号：

## 1.3 MongoDB客户端工具

<font size=4 color=blue>**1. MongoShell**</font>

<font size=4 color=blue>**2. MongoDB Compass**</font>

- 是MongoDB安装包官方的一个图形界面管理工具，[下载地址](https://www.mongodb.com/download-center/compass)

<font size=4 color=blue>**2. Studio 3T**</font>

<font size=4 color=blue>**3. DataGrip**</font>

## 1.4 MongoDB其他命令工具

<font size=4 color=blue>**1. mongodump：数据备份**</font>

```sh
mongodump  [选项] [参数]
```

- 默认备份所有数据到 bin/dump/ 目录中
- **--host 主机 --port 端口号**：备份指定主机的MongoDB数据
- **--dbpath 数据文件路径**：备份指定路径文件中的MongoDB数据
- **-out 备份目录**： 备份指定数据库到指定目录
- **--collection 集合 --db 数据库**： 备份指定数据库的集合

<font size=4 color=blue>**2. mongorestore：数据恢复**</font>

- 使用mongodump命令来备份MongoDB数据。该命令可以导出所有数据到指定目录中。mongodump命令可以通过参数指定导出的数据量级转存的服务器。

- 基本语法

  ```sh
  mongorestore -h <hostname><:port> -d dbname <path>
  ```

  - **-host <:port>, -h <:port>：**MongoDB所在服务器地址
  - **--db , -d ：**需要恢复的数据库实例
  - **--drop：**恢复的时候，先删除当前数据，然后恢复备份的数据
  - **<path>：**mongorestore 最后的一个参数，设置备份数据所在位置
  - **--dir：**指定备份的目录，不能同时指定 <path> 和 --dir 选项

# 第二章 从熟练到精通

## 2.1 命令行操作MongoDB

### <font size=4 color=blue>**1. Database相关操作**</font>

- 查看所有数据库

  ```sh
  show dbs;
  ```

- 激活使用数据库

  ```sh
  use <数据库名称>;
  ```

- 查看数据库下所有集合（数据表）

  ```sh
  show collections;
  ```

### <font size=4 color=blue>**2. 新增文档**</font>

- 新增文档不需要指定集合名称，如果插入时集合不存在，插入操作会创建该集合。

- **insert()**：新增一条或多条文档，单条插入时返回 写入结果 对象。批量插入时返回 批量插入结果 对象。

  ```sh
  db.collection.insert(
     <文档或文档集合>,
     {
       writeConcern: <document>,
       ordered: <boolean>
     }
  )
  ```

  > - **writeConcern**：
  > - **ordered**：默认为true表示有序插入，如果其中一条执行错误则停止新增；false表示无需插入，如果其中有文档执行错误则会继续处理其他文档

- **insertOne()**：新增一条文档
  
  ```sh
  db.collection.insertOne(
     <document>,
     {
        writeConcern: <document>
     }
  )
  ```
  
- **insertMany()**：新增多条文档

  ```sh
  db.collection.insertMany(
     { [ <document 1> , <document 2>, ... ] },
     {
        writeConcern: <document>,
        ordered: <boolean>
     }
  )
  ```

### <font size=4 color=blue>**3. 删除文档**</font>



# 第三章 分片集群与运维



# 第四章 架构师进阶





# MongoDB CRUD操作

## Create 新增文档

- 创建或插入操作是向一个集合总新增一个文档, 如果当前集合不存在, 插入操作会创建出这个集合

- MongoDB提供以下方法向集合中插入文档

    ```js
    db.<collection>.insert()
    db.<collection>.insertOne()
    db.<collection>.insertMany()
    ```

    > 在MongoDB中，insert操作针对单个集合。, MongoDB中的所有写操作都是单个文档级别上的原子操作

- [create](./create.md) 学习笔记

## Read 查询文档

- 读取操作是从一个集合中检索文档, 即在集合中查询文档, MongoDB提供了以下方法在集合中查询

    ```sh
    db.<collection>.find()
    ```

- [read](./read.md) 学习笔记

## Update 修改文档

- 修改操作

    ```js
    db.<collection>.update()
    db.<collection>.updateOne()
    db.<collection>.updateMany()
    db.<collection>.replaceOne()
    ```

- [update](./update.md) 学习笔记

## Delete

- 删除操作

    ```sj
    db.<collection>.deleteOne()
    db.<collection>.deleteMany()
    ```

- [delete](./delete.md) 学习笔记

