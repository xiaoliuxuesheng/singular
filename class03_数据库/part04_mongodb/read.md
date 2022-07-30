# 1. 简介 

- 官方文档地址：https://www.mongodb.com/atlas/database
- 简介：
  - MongoDB是基于JSON模型的，可以显著提升开发效率，使用文档嵌套模型，实现最快速的开发效率，用空间换时间
  - MongoDB是非关系型数据库的一种，与传统关系型数据库的范式设计理念不相符，MongoDB根推荐时间文档嵌套来代替关系型数据库中的多表关联
  - MongoDB有卓越的横向扩展能力：字段灵活，可以快速响应业务变化
  - MongoDB依赖于JSON和JavaScript语法
  - MongoDB是使用分片进行横向扩展实现高可用，但是分片的扩展和调优是MongoDB的难点，需要花时间研究
  - 分片数据可以支持海量数据，并且可以做到无缝扩容；
- 发展历史
  - 2009年：
  - 2021年8月：分片
  - 2014年12月：写入新能提高
  - 2015年12月：可以关联，查询多个文档
  - 2017年10月：上市的数据库公司
  - 2018年6月：支持事务

# 2. 特点 

- 特点
  - 面向集合存储，易存储对象类型数据
  - 支持查询以及动态查询
  - 支持Ruby，Python、Java、C++等多种语言
  - 文档存储格式是BSON，一种JSON的扩展
  - 支持复制和故障恢复和分片
- 应用场景
  - 游戏应用：存储用户信息，积分等
  - 物流应用：存储订单信息，一次查询可以关联订单所有信息
  - 社交应用：存储聊天记录
  - 视频直播：用户信息，礼物信息
  - 大数据应用：

# 3. 安装 

- Windows系统安装

  - 下载MongoDB的mis安装包；
  - 注意点：安装时候**"install mongoDB compass"** 不勾选，需要单独安装；
  - 在Windows系统中安装MongoDB后会自动将mongoDB服务添加到Windows服务中；

- Linux系统安装

  - 解压tgz安装包

  - 进入安装包中/bin目录中执行mongod命令启动mongo服务

  - 将/bin目录配置到环境变量：修改配置文件`/etc/profile`，并重新加载配置文件`. /etc/profile`

    ```sh
    export PATH=xxx/bin:$PATH
    ```

- Mac系统安装

- Mongo云

  - MongoDB云服务器地址：https://www.mongodb.com/cloud
  - 注册账号：945036446@qq.com & Mongo03lxd
  - mongo "mongodb+srv://xiaoliuxuesheng-l4sjf.mongodb.net/<dbname>" --username root

- Docker安装

- DockerFile安装

- DockerCompose安装

  ```yaml
  version: '3.0'
  services:
    mongo:
      image: mongo:5.0.8
      restart: always
      container_name: mongodb
      environment:
        TZ: 'Asia/Shanghai'
        #用户名密码
        MONGO_INITDB_ROOT_USERNAME: 'root'
        MONGO_INITDB_ROOT_PASSWORD: 'root'
      ports:
        - 27017:27017
      volumes:
        - ./mongodb/data:/data/db
        - ./mongodb/log:/data/log
        - ./mongodb/keyFile:/data/mongodb/keyFile
      networks:
        - mongo-test
   
  networks:
    mongo-test:
      driver: bridge
  ```

# 4. 核心概念

- Mongo命令行工具

  - mongo：客戶端程序，连接MongoDB服务

  - mongod：服务端程序，启动MongoDB

    | 选项        | 说明                                                         |
    | ----------- | ------------------------------------------------------------ |
    | --quite     | 安静输出                                                     |
    | --port      | 指定启动服务端口：默认27017                                  |
    | --bind      | 绑定指定IP访问                                               |
    | --dbpath    | 指定mongo数据储存目录：模板是mongo根目录下：/data/db目录中   |
    | --fork      | 后台守护进程启动，改命令必须指定--logpath选项                |
    | --logpath   | 指定mongo日志文件位置                                        |
    | --syslog    | 指定服务日志                                                 |
    | --logappend | 指定日志追加方式                                             |
    | --auth      | 用于认证                                                     |
    | --config    | 指定启动的配置文件：*配置文件格式说明*                       |
    | --journal   | 启用日志选项：将mongo数据操作记录将会写在journal目录的文件夹中 |

  - mongos：数据分片程序，支持数据横向扩展

  - **mongodump： mongodump命令可以通过参数指定导出的数据量级转存的服务器**

    ```sh
    mongodump  [选项] [参数]
    ```

    - 缺省参数执行`mongodump`命令，默认是备份文件是在该命令所在目录的`dump` 目录中
    - `--host 主机 --port 端口号`，`-h 主机:端口号`：备份指定主机的MongoDB数据
    - `--dbpath 数据文件路径`：备份指定路径文件中的MongoDB数据
    - `-out 备份目录`： 备份指定数据库到指定目录
    - `--collection 集合 --db 数据库`： 备份指定数据库的集合

  - **mongoexport：使用mongoexport命令来备份MongoDB数据。该命令可以导出所有数据到指定目录中**

    ```sh
    mongorestore -h <hostname><:port> -d dbname <path>
    ```

    - `-host <:port>, -h <:port>`：MongoDB所在服务器地址
    - `--db , -d `：需要恢复的数据库实例
    - `--drop`：恢复的时候，先删除当前数据，然后恢复备份的数据
    - `<path>`：mongorestore 最后的一个参数，设置备份数据所在位置
    - `--dir`：指定备份的目录，不能同时指定 <path> 和 --dir 选项

  - **mongofiles：GridFS工具，内建的分布式文件系统**

  - **mongoimport：数据导入程序**

  - **mongorestore： 数据恢复程序**

  - **mongostat： 监视程序**

  - **mongotop：进程监控**

- 关闭MongoDB

  - 使用Ctrl  + C关闭：关闭前置启动的Mongo服务，会等待正在执行的任务完成后才关闭，是一种安全的关闭方式

  - 使用kill命令关闭：强制关闭，下次启动需要删除/data/db目录中的mongod.lock文件，否则下次无法启动

  - 使用Mongo中提供的函数关闭：此命令需要在admin库中执行

    - db.shutdownServer()
    - db.runCommand("shutdown")

  - 使用mongod命令关闭服务

    ```shell
    mongod --shutdown --dbpath <数据库目录>
    ```

- MongoDB内置数据库

  | 数据库 | 说明                                                         |
  | ------ | ------------------------------------------------------------ |
  | admin  | root数据库，保存新增的用户信息，这个用户自动继承所有数据库的权限 |
  | local  | 这个数据库永远不会被复制，用于存储限于本地单台服务器相关集合 |
  | config | 当mongo用作分片设置时，用于保存分片相关信息                  |

- MongoDB相关概念

  |               | MongoDB      | 关系型数据库 |
  | ------------- | ------------ | ------------ |
  | 库 > 数据库   | database     | database     |
  | 集合 > 数据表 | collection   | table        |
  | 文档 > 行     | document     | row          |
  | 属性 > 列     | field        | column       |
  | 索引          | index        | index        |
  | 数据模型      | json         | 关系模型     |
  | 高可用        | 复制集       | 集群模式     |
  | 横向扩展      | 原生分片支持 | 数据分区     |

- MongoDB数据类型

  | 数据类型           | 描述                                                         |
  | ------------------ | ------------------------------------------------------------ |
  | String             | 字符串：最常用的数据类型，在Mongo中只有UTF-8编码的字符是合法的 |
  | Integer            | 整数类型                                                     |
  | Boolean            | 布尔类型                                                     |
  | Double             | 双精度浮点值                                                 |
  | Min/Max keys       | 将一个值与BSON元素的最低值和最高值做对比                     |
  | Array              | 用于将数组或列表或多个值存储为一个键                         |
  | Timestamp          | 时间戳                                                       |
  | Object             | 内嵌文档                                                     |
  | Null               | 创建空值                                                     |
  | Sysbol             | 符号：基本上等同于字符串类型，一般是采用特殊符号的字符串     |
  | Date               | 日期类型：用UNIX时间格式存储当前时间                         |
  | Object ID          | 对象ID，用于创建文档的ID                                     |
  | Binary Data        | 二进制数据：用户存储二进制                                   |
  | Regular Expression | 正则表达式类型：用户存储正则表达式                           |

- MongoDB运算符

# 5.基本操作 

- 数据库

  1. 查看所有库

     ```sql
     show dbs;
     show databases;
     ```

  2. 创建数据库：use命令作用①切换数据库②创建一个空的数据库（在mongo中空集合的库默认不展示）

     ```sql
     use 数据库名称;
     ```

  3. 查看当前所在的库：新安装的mongo默认登陆后的库的名称是test，因为是空集合所以默认没有展示

     ```sql
     db;
     ```

  4. 删除数据库：需要执行命令的用户具有dbAdminAnyDatabase角色登陆；删除当前已激活的数据库，需要在命令行可以执行，在部分图形化界面工具中无法使用该命令删除数据库

     ```sql
     db.dropDatabase();
     ```

- 集合

  1. 查看库中所有集合

     ```sql
     show collections;
     show tables;
     ```

  2. 创建集合

     - 显式创建：使用该命令不可以重复创建同名的集合

       ```SQL
       db.createCollection(name, options)
       ```

       > - name：是要创建的集合名称
       >
       > - option：可用选项列表，指定有关内存大小及索引的选项
       >
       >   | 字段        | 类型    | 描述                                                         |
       >   | ----------- | ------- | ------------------------------------------------------------ |
       >   | capped      | Boolean | （可选）如果为true，则启用有上限的集合。封顶集合是一个固定大小的集合，当它达到最大大小时自动覆盖其最老的条目。 **如果指定为真，还需要指定size参数。** |
       >   | size        | number  | （可选）为有上限的集合指定最大字节大小                       |
       >   | max         | number  | （可选）指定上限集合中允许的最大文档数量                     |
       >   | autoindexid | Boolean | （可选）可选：如果为true，自动创建_id自动创建索引，默认为false |

     - 集合的隐式创建：当插入文档时，MongoDB自动创建集合，并会使用数据库名称作为集合名称

       ```sql
       -- db.t_demo02.insertOne({'name':'张三'})
       db.集合名称.insert(文档);
       ```

  3. 删除文档：开启认证后，删除集合的用户必须具备dbAdminAnyDatabase角色

     ```sql
     -- db.t_demo01.drop();
     db.集合名称.drop()
     ```

- 文档：https://www.mongodb.com/docs/manual/

  1. 插入单条文档，如果不指定`_id`会自动添加这个字段作为唯一值；

     ```sql
     db.collection.insertOne(
        <document>,
        {
           writeConcern: <document>
        }
     )
     ```

  2. 插入多条

     ```sql
     db.t_demo02.insertMany([
     {'name':'李思','age':23},
     {'name':'王五','age':23},
     {'name':'赵六','age':23}
     ]);
     
     for(let i = 0;i<5;i++){
     	db.t_demo02.insertOne({'name':'张三'+i})
     }
     ```

  3. 删除文档

     ```sql
     ```

     

# 6. 文档查询



# 7. $type 

# 8. 索引 

# 9. 聚合 

# 10. 集成SpringBoot 

# 11. 副本集群 

# 12. 分片集群

