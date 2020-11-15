01、MongoDB简介

- NoSql数据库：基于分布式文件存储的数据库，由C++语言编写
- MongoDB是一种介于关系型数据库和非关系型数据库之间的产品：类似json的bson的数据结构
- NoSql数据库的分类
  - 基于key-value的存储结构
  - 列存储数据库：Hbase
  - 文档型数据库
  - 图型数据库

02、MongoDB与关系型数据库对比

| 术语        | MongoDB                  | 关系型   |
| ----------- | ------------------------ | -------- |
| database    | database                 | 数据库   |
| table       | collection               | 表       |
| row         | document                 | 行       |
| column      | field                    | 列       |
| index       | index                    | 索引     |
| table join  |                          | 多表联查 |
| primary key | primary key（字段：_id） | 主键     |

- mongodb数据存储：bson格式的数据

03、MongoDB数据类型

| 数据类型          | 描述                                                 |
| ----------------- | ---------------------------------------------------- |
| String            | 字符串，在MongoDB中必须为UTF8                        |
| integer           | 数值型                                               |
| Boolean           | 布尔值                                               |
| Double            | 双精度浮点                                           |
| Min/Max keys      | 将一个值以bson(二进制的json)元素的最低值和最高值对比 |
| Array             | 将数组或列表多个值存储为一个键                       |
| Timestamp         | 时间戳                                               |
| Object            | 嵌入文档                                             |
| Null              | 空值                                                 |
| object id         | 对象ID，用于创建文档ID                               |
| Binary Data       | 二进制数据                                           |
| Code              | 代码类型：存储JavaScript代码                         |
| Regular exception | 存储正则表达式                                       |

04、MongoDB的下载与安装

- windows
- linxu

05、MongoDB的启动-前置启动

1. 配置文件

   ```properties
   dppath=数据存储目录(是存储数据的目录)
   logpath=日志文件路径(需要知道将日志写到哪个文件中)
   ```

06、MongoDB的启动-后置启动

1. 前置启动：~/bin/mongod（默认前置启动）
2. 后置启动：~/bin/mongod --fork（后置启动需要指定启动日志的输出文件）--logpath 或 -syslog

- 其他启动参数

  | 参数        | 描述                                                         |
  | ----------- | ------------------------------------------------------------ |
  | --dbpath    | 数据目录                                                     |
  | --logpath   | 日志文件                                                     |
  | --quiet     | 安静退出                                                     |
  | --port      | 启动端口号                                                   |
  | --bind      | 绑定服务IP可以访问本机                                       |
  | --logpath   | 指定mongo日志文件                                            |
  | --logappend | 是否使用日志追加的方式                                       |
  | --fork      | 以守护进程的方式启动                                         |
  | --auth      | 启用验证                                                     |
  | --config    | 指定启动配置文件                                             |
  | --journal   | 启用日志选项,mongodb的数据操作会写入到journal文件夹的文件里面 |
  | --shutdown  | 关闭服务                                                     |

07、通过配置文件加载启动

- 配置文件格式：以conf为后缀，key=value的格式

  ```properties
  port=27017
  bind_id=0.0.0.0
  dbpath=数据目录
  fork=true
  logpath=日志目录
  logappend=true
  journal=true
  ```

08、配置环境变量

- 添加到环境变量中

  ```sh
  export PATH=~/bin:$PATH
  . /etc/profile
  ```

09、MongoDB关闭方式

1. Ctrl + C：关闭前置启动的MongoDB服务，是一个安全关闭

2. kill：结束MongoDB进程，需要删除data/db下的mongod.lock文件。否则下次无法启动，会造成数据丢失

3. 使用mongo函数关闭：都需要在admin库中执行

   ```js
   db.shutdownServer()
   db.runCommand("shutdown")
   ```

4. 使用mongod命令关闭:

   ```sh
   mongod --shutdown --dbpath 数据库路径
   ```

10、MongoDB的权限管理

- MongoDB通过创建用户的方式管理关系

- MongoDB用户权限表

  | 权限关键字           | 说明                                                         |
  | -------------------- | ------------------------------------------------------------ |
  | read                 | 允许用户读指定数据库                                         |
  | readWrite            | 允许用户读写指定数据库                                       |
  | dbAdmin              | 允许用户在指定数据库中执行管理函数：如创建索引、删除、查看、统计或访问system.profile |
  | userAdmin            | 允许用户向system.user集合写入：可以在指定数据库里创建、删除、和管理用户 |
  | clusterAdmin         | 只在Admin数据库中使用，赋予用户所有分片和复制集相关函数的管理权限 |
  | readAnyDatabase      | 只在Admin数据库中使用，赋予用户所有用户的读权限              |
  | readWriteAnyDatabase | 只在Admin数据库中使用，赋予用户所有数据库的读写权限          |
  | userAdminAnyDatabase | 只在Admin数据库中使用，赋予用户所有数据库的userAdmin权限     |
  | dbAdminAnyDatabase   | 只在Admin数据库中使用，赋予用户所有数据库的dbAdmin权限       |
  | root                 | 只在Admin数据库中使用，超级账号：所有权限                    |

11、用户的使用

- MongoDB中推荐使用用户管理机制：有一个管理用户组（专门为管理普通用户而设定的，暂且称为管理员）：管理员一般不会设定数据库的读写权限，而是会赋予管理员的用户创建权限，即userAdminAnyDatabase权限；（必须在useradmin库下执行）

  - 切换到admin库中：操作

    ```js
    use admin;
    db.syste.users.find({});
    ```

  - 创建用户

    ```js
    db.createUser({
        user:"<用户名>",
        pwd:"<密码>",
       	customData:{<用户自定义数据,json格式的>},
        roles:[
            {role:"<权限关键字>",db:"<数据库>"} | "role"
        ]
    })
    ```

  - 创建用户后需要重启服务

12、mongodb的用户认证

- 默认mongodb是不开启用户认证的，如果添加用户，需要开启用户认证auth=true

- 使用用户认证

  ```js
  db.auth("用户名","密码)
  ```

13、创建普通用户

- 普通用户需要由管理员登陆：首先是管理员登陆并认证

- 首先创建由普通用户管理的数据库：如果存在则不需要创建了

  ```sh
  use 数据库名称;   # 如果存在数据库则会切换数据库,如果没有则会创建新的数据库
  ```

- 创建普通用户：普通用户的权限是readWrite

  ```js
  db.createUser({
      user:"<用户名>",
      pwd:"<密码>",
     	customData:{<用户自定义数据,json格式的>},
      roles:[
          {role:"readWrite",db:"<新数据库>"} | "role"
      ]
  })
  ```

- 普通用户不登录时候新增会报错，认证后可以新增数据

14、更新用户角色

- 更新用户角色：执行改函数的用户需要具备useAdminAnyDatabase权限，更新原理是覆盖更新

  ```js
  db.updateUser({
      user:"<用户名>",
      roles:[
          {role:"角色"}
      ]
  })
  ```

15、更新用户名和密码

- db.updateUser()函数：可以更新用户所有信息

  ```js
  db.updateUser("用户名",{pwd:"新密码"})
  ```

- db.changeUserPassword()函数：只能更新用户密码

  ```js
  db.changeUserPassword("用户名","密码	")
  ```

16、删除用户

- 删除用户（必须在用户所在的数据库）：db.dropUser()

17、数据库操作

1. 创建数据库

   ```js
   use case_mongo;
   ```

2. 查看所有数据库：之会显示有数据的数据库

   ```js
   show dbs;
   ```

3. 删除数据库：必须具备dbAdminAnyDatabase权限

   ```js
   db.dropDatabase()
   ```

18、集合操作

- 创建集合

  ```js
  db.createCollection(name,options)
  ```

  > - name要创建的集合名称
  >
  > - options可选参数,指定当前集合内存等相关属性,是个json对象
  >
  >   | 属性        | 类型    | 描述                                                         |
  >   | ----------- | ------- | ------------------------------------------------------------ |
  >   | capped      | Boolean | 如果为true,表示创建固定集合,当到达最大值时候自动覆盖最早的文档<br />指定capped必须指定size |
  >   | autoindexid | Boolean | 默认为false,表示是否自动在_id字段创建索引                    |
  >   | size        | 数值    | 固定集合的一个最大值                                         |
  >   | max         | 数值    | 表示固定集合中包含文档的最大数量,先检查size大小后检查max大小 |

- 使用默认集合:在mongo中也可以创建集合,当插入数据时候如果集合不存在会自动创建集合

  ```js
  db.<collection名称>.insert({文档})
  ```

- 查看所有集合

  ```js
  show collections;
  ```

19、查看和删除集合

- 查看集合

  ```js
  show tables;
  ```

- 删除集合:需要切换到集合所在的数据库

  ```js
  db.<coollection名称>.drop()
  ```

20、文档操作-插入文档

> bson是json的二进制存储方式,Binary JSON

- insert插入单个文档: 返回执行结果成功数量,如果执行报错信息

  ```js
  db.<coollection名称>.insert(document文档)
  ```

- save插入多个文档:返回执行结果输

  ```js
  db.<coollection名称>.save([documentA,documentB])
  ```

- insertOne():返回插入文档的iD

- insertMany():插入多个文档,并返回文档的ID集合

21、插入多个文档

- insert()
- save()
- insertMany()

22、mongo shell工具可以定义变量，使用js语法

- 定义变量:var 关键字可以省略

  ```js
  var 变量 = {文档}
  
  db.<collection名称>.insert(变量)
  ```

23、更新文档

- update函数更新文档：db.<collections>.update(查询参数文档,需要更新的文档[,更新参数])

  ```js
  db.<collection名称>.update({id:"xxx"},{$set:{name:"需要更新的字段"}},{更新选项})
  ```

  > 更新选项
  >
  > - multi:表示是否更新多个,否则只会更新一个

- 更新操作符:$set

  ```js
  db.<collection名称>.update({id:"xxx"},{name:"需要更新的字段"},{更新选项})
  ```

24、更新操作符

- $inc:对数值进行递增或递减

  ```js
  db.<collection名称>.update({},{$inc:{num:递增或递减数值}})
  ```

- $unset:删除键值

  ```js
  db.<collection名称>.update({},{$unset:{num:json的占位值}})
  ```

25、push操作符

