# 第一章 MongoDB再入门

## 1.1 MongoDB特性

1. MongoDB是基于JSON模型的，可以显著提升开发效率，使用文档嵌套模型，实现最快速的开发效率，用空间换时间
2. MongoDB有卓越的横向扩展能力：字段灵活，可以快速响应业务变化
3. MongoDB是非关系型数据库的一种，与传统关系型数据库的范式设计理念不相符，MongoDB根推荐时间文档嵌套来代替关系型数据库中的多表关联
4. MongoDB依赖于JSON和JavaScript语法
5. MongoDB是使用分片进行横向扩展实现高可用，但是分片的扩展和调优是MongoDB的难点，需要花时间研究
6. 分片数据可以支持海量数据，并且可以做到无缝扩容；

## 1.2 MongoDB安装与说明

### <font size=4 color=blue>**1. MongoDB版本与下载**</font>

- 偶数版本号为稳定版本；
- MongoBD官网：[下载地址](https://www.mongodb.com/download-center/community)

### <font size=4 color=blue>**2. MongoDB的安装**</font>

- **Windows系统的安装**
  - 下载MongoDB的mis安装包；
  - 注意点：安装时候**"install mongoDB compass"** 不勾选，需要单独安装；
  - 在Windows系统中安装MongoDB后会自动将mongoDB服务添加到Windows服务中；
  
- **Linux系统**

  - 解压tgz安装包

  - 进入安装包中/bin目录中执行mongod命令启动mongo服务

  - 将/bin目录配置到环境变量：修改配置文件`/etc/profile`，并重新加载配置文件`. /etc/profile`

    ```sh
    export PATH=xxx/bin:$PATH
    ```

- **Docker镜像**

- **MongoDB云**
  - MongoDB云服务器地址：https://www.mongodb.com/cloud
  - 注册账号：945036446@qq.com & Mongo03lxd
  - mongo "mongodb+srv://xiaoliuxuesheng-l4sjf.mongodb.net/<dbname>" --username root

### <font size=4 color=blue>**3. MongoDB命令行程序**</font>

- **mongo：客户端程序，连接MongoDB**

- **mongod： 服务端程序，启动MongoDB**

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
  | --config    | 指定启动的配置文件：*<span title='① 配置文件可以在任意目录中，扩展名为.conf ② 配置文件用key=value结构 ③ 启动mongo服务使用--config指定配置文件 ④ 特殊配置IP绑定属性是bind_id'>配置文件格式说明</span>* |
  | --journal   | 启用日志选项：将mongo数据操作记录将会写在journal目录的文件夹中 |

- **mongos：数据分片程序，支持数据的横向扩展**

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



### <font size=4 color=blue>**4. 关闭MongoDB**</font>

- 使用Ctrl  + C关闭：关闭前置启动的Mongo服务，会等待正在执行的任务完成后才关闭，是一种安全的关闭方式

- 使用kill命令关闭：强制关闭，下次启动需要删除/data/db目录中的mongod.lock文件，否则下次无法启动

- 使用Mongo中提供的函数关闭：此命令需要在admin库中执行

  - db.shutdownServer()
  - db.runCommand("shutdown")

- 使用mongod命令关闭服务

  ```sh
  mongod --shutdown --dbpath <数据库目录>
  ```

### <font size=4 color=blue>**5. MongoDB内置数据库**</font>

| 数据库 | 说明                                                         |
| ------ | ------------------------------------------------------------ |
| admin  | root数据库，保存新增的用户信息，这个用户自动继承所有数据库的权限 |
| local  | 这个数据库永远不会被复制，用于存储限于本地单台服务器相关集合 |
| config | 当mongo用作分片设置时，用于保存分片相关信息                  |

### <font size=4 color=blue>**6. MongoDB权限和用户**</font>

- MongoDB也提供了安全认证功能，通过创建用户的方式降低数据风险

- MongoDB用户权限列表

  | 权限                 | 说明                                                         |
  | -------------------- | ------------------------------------------------------------ |
  | Read                 | 允许用户读取指定数据库                                       |
  | readWrite            | 允许用户读写指定数据库                                       |
  | dbAdmin              | 允许用户在指定数据库执行管理函数：如索引创建、删除或访问system.profile |
  | userAdmin            | 允许用户向system.users集合写入：在指定数据库里创建删除和管理用户 |
  | clusterAdmin         | 只在Admin数据库中可用，赋予用户所有分片和复制集相关函数权限  |
  | readAnyDatabase      | 只在Admin数据库中可用，赋予用户所有数据库的读权限            |
  | readWriteAnyDatabase | 只在Admin数据库中可用，赋予用户所有数据库的读写权限          |
  | userAdminAnyDatabase | 只在Admin数据库中可用，赋予用户所有数据库的userAdmin权限     |
  | dbAdminAnyDatabase   | 只在Admin数据库中可用，赋予用户所有数据库的dbAdmin权限       |
  | root                 | 只在Admin数据库中可用，超级账户,超级权限                     |

- MongoDB的用户使用

  - 创建DB管理用户：MongoDB的用户管理机制：有一个管理用户组，这个组是专门为管理普通用户而设定的，这个组可以称为管理员；管理员通常没有数据库的读写权限，只有操作用户的权限，因此创建管理员时候需要为管理员赋予userAdminAnyDatabase角色即可；管理员账户必须在admin数据库下才可以操作；

  - 在mongo命令行执行：切换到admin数据库

    ```sh
    use admin
    ```

  - 在mongo命令行执行：查看当前数据库中的用户

    ```sql
    db.system.user.find()
    ```

  - 在mongo命令行执行：创建用户，创建用户后需要重启mongo服务

    ```js
    db.createUser({
        user:"panda",
        pwd:"root",
        customData:{
            description:"创建第一个管理员:{panda:root}"
        },
        roles:[
            {role:"userAdminAnyDatabase",db:"admin"}
        ]
    });
    ```

  - 默认MongoDB启动是不开启权限认证方式：启动添加选项auth=true，设计权限后可以登录但是不可以查询，通过认证才可以查询，认证成功返回1，失败返回0

    ```sh
    db.auth("panda","root")
    ```

  - 使用管理登录并创建普通用户

     1. 创建数据库

        ```sql
        use mg_db01
        ```

      	2. 在该数据库下创建用户

        ```sql
        db.createUser({
            user:"lxd01",
            pwd:"root",
            customData:{
                description:"创建第一个用户:{lxd01:root}"
            },
            roles:[
                {role:"readWrite",db:"mg_db01"}
            ]
        });
        ```

  - 更新用户角色：执行命令db.updateUser()，执行该命令的角色需要有userAdminAnyDatabase角色才可以，当前更新的角色会覆盖之前用户拥有的角色，不是追加角色

    ```js
    db.updateUser("用户名",{
        "roles":[
            {"role":"角色",db:"mg_db01"}
        ]
    })
    ```

  - 根据用户密码

    ```js
    // 方式一:db.updateUser
    db.updateUser("用户名",{
        "pwd":"新密码"
    })
    
    // 方式二:db.changeUserPassword()
    db.changeUserPassword("用户名","新密码")
    ```

  - 删除用户：必须切换到用户所在的数据库

    ```js
    db.dropUser("用户名")
    ```

## 1.3 MongoDB客户端工具

1. **MongoShell**：bin目录中mongod命令程序

2. **MongoDB Compass** ：Mongo官方可视化桌面程序
3. **Studio 3T**：[下载地址](https://www.mongodb.com/download-center/compass)
4. **DataGrip**：

## 1.4 MongoDB相关概念

> MongoDB是一个以JSON为数据模型的文档型（Java Document）数据库，文档的本质是一个Object。

|          | MongoDB      | 关系型数据库 |
| -------- | ------------ | ------------ |
| 数据库   | database     | database     |
| 数据表   | collection   | table        |
| 行       | document     | row          |
| 列       | field        | column       |
| 索引     | index        | index        |
| 数据模型 | json         | 关系模型     |
| 高可用   | 复制集       | 集群模式     |
| 横向扩展 | 原生分片支持 | 数据分区     |

## 1.5 MongoDB数据类型

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

## 1.6 MongoDB运算符

### <font size=4 color=blue>**1. 查询运算符**</font>

#### 比较查询运算符

| 运算符 | 功能说明                   |
| ------ | -------------------------- |
| $eq    | 匹配等于指定值的值。       |
| $ne    | 匹配所有不等于指定值的值。 |
| $gt    | 匹配大于指定值的值。       |
| $gte   | 匹配大于或等于指定值的值。 |
| $lt    | 匹配小于指定值的值。       |
| $lte   | 匹配小于或等于指定值的值。 |
| $in    | 匹配数组中指定的任何值。   |
| $nin   | 不匹配数组中指定的任何值。 |

#### 逻辑查询运算符

| 运算符 | 功能说明                                                  |
| ------ | --------------------------------------------------------- |
| $and   | 用逻辑联接查询子句`AND`将返回两个子句都匹配的所有文档     |
| $not   | 反转查询表达式的效果，并返回与查询表达式*不*匹配的文档。  |
| $nor   | 用逻辑联接查询子句`NOR`将返回两个子句均不匹配的所有文档。 |
| $or    | 用逻辑联接查询子句`OR`将返回符合任一子句条件的所有文档。  |

#### 元素查询运算符

| 运算符  | 功能说明                       |
| ------- | ------------------------------ |
| $exists | 匹配具有指定字段的文档。       |
| $type   | 如果字段是指定类型，则选择文档 |

#### 评估查询运算符

| 运算符      | 功能说明                                       |
| :---------- | :--------------------------------------------- |
| $exp        | 允许在查询语言中使用聚合表达式。               |
| $jsonSchema | 根据给定的JSON Schema验证文档。                |
| $mod        | 对字段的值执行模运算并选择具有指定结果的文档。 |
| $regex      | 选择值与指定的正则表达式匹配的文档。           |
| $text       | 执行文本搜索。                                 |
| $where      | 匹配满足JavaScript表达式的文档                 |

#### 地理空间查询运算符

| 名称           | 描述                                                         |
| :------------- | :----------------------------------------------------------- |
| $geoIntersects | 选择与`GeoJSON`几何形状相交的几何形状。该`2dsphere`索引支持 `$geoIntersects`。 |
| $geoWithin     | 选择边界`GeoJSON`几何内的`几何`。该`2dsphere`和`2D`指标支持 `$geoWithin`。 |
| $near          | 返回点附近的地理空间对象。需要地理空间索引。该`2dsphere`和`2D`指标支持 `$near`。 |
| $nearSphere    | 返回球体上某个点附近的地理空间对象。需要地理空间索引。该[2dsphere](https://mongodb.net.cn/manual/core/2dsphere/)和[2D](https://mongodb.net.cn/manual/core/2d/)指标支持[`$nearSphere`](https://mongodb.net.cn/manual/reference/operator/query/nearSphere/#op._S_nearSphere)。 |
| $box           | 使用传统坐标对指定一个用于[`$geoWithin`](https://mongodb.net.cn/manual/reference/operator/query/geoWithin/#op._S_geoWithin)查询的矩形框 。所述[2D](https://mongodb.net.cn/manual/core/2d/)指数支撑 [`$box`](https://mongodb.net.cn/manual/reference/operator/query/box/#op._S_box)。 |
| $center        | [`$geoWithin`](https://mongodb.net.cn/manual/reference/operator/query/geoWithin/#op._S_geoWithin)使用平面几何时，使用旧坐标对指定圆以进行 查询。所述[2D](https://mongodb.net.cn/manual/core/2d/)指数支撑[`$center`](https://mongodb.net.cn/manual/reference/operator/query/center/#op._S_center)。 |
| $centerSphere  | 在使用球形几何图形时，使用传统坐标对或[GeoJSON](https://mongodb.net.cn/manual/reference/glossary/#term-geojson)格式指定一个圆来 进行[`$geoWithin`](https://mongodb.net.cn/manual/reference/operator/query/geoWithin/#op._S_geoWithin)查询。该[2dsphere](https://mongodb.net.cn/manual/core/2dsphere/)和 [2D](https://mongodb.net.cn/manual/core/2d/)指标支持[`$centerSphere`](https://mongodb.net.cn/manual/reference/operator/query/centerSphere/#op._S_centerSphere)。 |
| $geometry      | 为地理空间查询运算符指定[GeoJSON](https://mongodb.net.cn/manual/reference/glossary/#term-geojson)格式的几何。 |
| $maxDistance   | 指定最大距离以限制[`$near`](https://mongodb.net.cn/manual/reference/operator/query/near/#op._S_near) 和[`$nearSphere`](https://mongodb.net.cn/manual/reference/operator/query/nearSphere/#op._S_nearSphere)查询的结果。该[2dsphere](https://mongodb.net.cn/manual/core/2dsphere/)和[2D](https://mongodb.net.cn/manual/core/2d/)指标支持[`$maxDistance`](https://mongodb.net.cn/manual/reference/operator/query/maxDistance/#op._S_maxDistance)。 |
| $minDistance   | 指定最小距离以限制[`$near`](https://mongodb.net.cn/manual/reference/operator/query/near/#op._S_near) 和[`$nearSphere`](https://mongodb.net.cn/manual/reference/operator/query/nearSphere/#op._S_nearSphere)查询的结果。`2dsphere`仅与索引一起使用。 |
| $polygon       | 指定要使用旧式坐标对进行 [`$geoWithin`](https://mongodb.net.cn/manual/reference/operator/query/geoWithin/#op._S_geoWithin)查询的面。所述[2D](https://mongodb.net.cn/manual/core/2d/)指数支撑 [`$center`](https://mongodb.net.cn/manual/reference/operator/query/center/#op._S_center)。 |
| $uniqueDocs    | 不推荐使用。修改[`$geoWithin`](https://mongodb.net.cn/manual/reference/operator/query/geoWithin/#op._S_geoWithin)和[`$near`](https://mongodb.net.cn/manual/reference/operator/query/near/#op._S_near)查询以确保即使文档多次匹配查询，查询也会返回一次文档。 |

#### 数组查询运算符

| 名称       | 描述                                                         |
| :--------- | :----------------------------------------------------------- |
| $all       | 匹配包含查询中指定的所有元素的数组。                         |
| $elemMatch | 如果array字段中的元素符合所有指定[`$elemMatch`](https://mongodb.net.cn/manual/reference/operator/query/elemMatch/#op._S_elemMatch)条件，则选择文档。 |
| $size      | 如果数组字段为指定大小，则选择文档。                         |

#### 按位查询运算符

| 名称          | 描述                                                      |
| :------------ | :-------------------------------------------------------- |
| $bitsAllClear | 匹配其中一组位位置的数值或二进制值*都*具有值`0`。         |
| $bitsAllSet   | 匹配其中一组位位置的数值或二进制值*都*具有值`1`。         |
| $bitsAnyClear | 匹配数字或二进制值，其中一组位位置中的*任何*位的值为`0`。 |
| $bitsAnySet   | 匹配数字或二进制值，其中一组位位置中的*任何*位的值为`1`。 |

#### 注释查询

| 名称     | 描述                                   |
| -------- | -------------------------------------- |
| $comment | 查询操作关联采取查询谓词的任何表达意见 |

#### 投影算子

| 名称       | 描述                                                         |
| :--------- | :----------------------------------------------------------- |
| $          | 在与查询条件匹配的数组中投影第一个元素。                     |
| $elemMatch | 投影与指定[`$elemMatch`](https://mongodb.net.cn/manual/reference/operator/projection/elemMatch/#proj._S_elemMatch)条件匹配的数组中的第一个元素。 |
| $meta      | 投影[`$text`](https://mongodb.net.cn/manual/reference/operator/query/text/#op._S_text)操作期间分配的文档分数。 |
| $slice     | 限制从数组投影的元素数量。支持跳过和限制切片。               |

### <font size=4 color=blue>**2. 更新运算符**</font>

#### 字段

| 名称         | 描述                                                         |
| :----------- | :----------------------------------------------------------- |
| $currentDate | 将字段的值设置为当前日期（日期或时间戳）。                   |
| $inc         | 将字段的值增加指定的数量。                                   |
| $min         | 仅当指定值小于现有字段值时才更新该字段。                     |
| $max         | 仅当指定值大于现有字段值时才更新该字段。                     |
| $mul         | 将字段的值乘以指定的数量。                                   |
| $rename      | 重命名字段。                                                 |
| $set         | 设置文档中字段的值。                                         |
| $setOnInsert | 如果更新导致插入文档，则设置字段的值。对修改现有文档的更新操作没有影响。 |
| $unset       | 从文档中删除指定的字段。                                     |

#### 数组运算符

| 名称      | 描述                                                         |
| --------- | ------------------------------------------------------------ |
| $         | 充当占位符，以更新与查询条件匹配的第一个元素。               |
| $[\\]     | 充当占位符，以更新匹配查询条件的文档的数组中的所有元素。     |
| $[\\]     | 充当占位符，以更新`arrayFilters`与查询条件匹配的文档中所有与条件匹配的元素。 |
| $addToSet | 仅当元素不存在于集合中时才将它们添加到数组中。               |
| $pop      | 删除数组的第一项或最后一项。                                 |
| $pull     | 删除所有与指定查询匹配的数组元素。                           |
| $push     | 将项目添加到数组。                                           |
| $pullAll  | 从数组中删除所有匹配的值。                                   |

#### 修饰符

| 名称      | 描述                                                       |
| :-------- | :--------------------------------------------------------- |
| $each     | 修改`$push`和`$addToSet`运算符以附加多个项以进行数组更新。 |
| $position | 修改`$push`运算符以指定要添加元素的数组中的位置。          |
| $slice    | 修改`$push`运算符以限制更新数组的大小。                    |
| $sort     | 修改`$push`运算符以对存储在数组中的文档重新排序。          |

#### 按位

| 名称 | 描述                                     |
| :--- | :--------------------------------------- |
| $bit | 执行按位`AND`，`OR`和`XOR`整数值的更新。 |

### <font size=4 color=blue>**3. 聚合管道运算符**</font>

| 阶段            | 描述                                                         |
| :-------------- | :----------------------------------------------------------- |
| $addFields      | 将新字段添加到文档。与相似 [`$project`](https://mongodb.net.cn/manual/reference/operator/aggregation/project/#pipe._S_project)，[`$addFields`](https://mongodb.net.cn/manual/reference/operator/aggregation/addFields/#pipe._S_addFields)重塑流中的每个文档；具体而言，通过向输出文档添加新字段，该文档既包含输入文档中的现有字段，又包含新添加的字段。[`$set`](https://mongodb.net.cn/manual/reference/operator/aggregation/set/#pipe._S_set)是的别名[`$addFields`](https://mongodb.net.cn/manual/reference/operator/aggregation/addFields/#pipe._S_addFields)。 |
| $bucket         | 根据指定的表达式和存储区边界将传入文档分类为多个组，称为存储区。 |
| $bucketAuto     | 根据指定的表达式将传入文档分类为特定数量的组，称为存储桶。自动确定存储区边界，以尝试将文档平均分配到指定数量的存储区中。 |
| $collStats      | 返回有关集合或视图的统计信息。                               |
| $count          | 返回聚合管道此阶段的文档数计数。                             |
| $facet          | 在同一阶段的同一组输入文档上处理多个[聚合管道](https://mongodb.net.cn/manual/core/aggregation-pipeline/#id1)。支持在一个阶段中创建能够表征多维或多面数据的多面聚合。 |
| $geoNear        | 根据与地理空间点的接近程度返回有序的文档流。包含 [`$match`](https://mongodb.net.cn/manual/reference/operator/aggregation/match/#pipe._S_match)，[`$sort`](https://mongodb.net.cn/manual/reference/operator/aggregation/sort/#pipe._S_sort)和[`$limit`](https://mongodb.net.cn/manual/reference/operator/aggregation/limit/#pipe._S_limit)用于地理空间数据的功能。输出文档包括附加距离字段，并且可以包括位置标识符字段。 |
| $graphLookup    | 对集合执行递归搜索。向每个输出文档添加一个新的数组字段，其中包含对该文档的递归搜索的遍历结果。 |
| $group          | 按指定的标识符表达式对输入文档进行分组，并将累加器表达式（如果指定）应用于每个组。消耗所有输入文档，并在每个不同的组中输出一个文档。输出文档仅包含标识符字段，如果指定，还包含累积字段。 |
| $indexStats     | 返回有关集合每个索引使用情况的统计信息。                     |
| $limit          | 将未修改的前*n个*文档传递到管道，其中*n*是指定的限制。对于每个输入文档，输出一个文档（对于前*n个*文档）或零文档（在前*n个*文档之后）。 |
| $listSessions   | 列出所有活动时间已经足够长以传播到`system.sessions`集合的会话。 |
| $lookup         | 对*同一*数据库中的另一个集合执行左外部 联接，以过滤“联接”集合中的文档以进行处理。 |
| $match          | 筛选文档流，以仅允许匹配的文档未经修改地传递到下一个管道阶段。`$match`使用标准的MongoDB查询。对于每个输入文档，输出一个文档（匹配）或零文档（不匹配）。 |
| $merge          | 将聚合管道的结果文档写入集合。该阶段可以将结果合并（插入新文档，合并文档，替换文档，保留现有文档，使操作失败，使用自定义更新管道处理文档）将结果合并到输出集合中。要使用该`$merge`阶段，它必须是管道中的最后一个阶段。4.2版中的新功能。 |
| $out            | 将聚合管道的结果文档写入集合。要使用该`$out`阶段，它必须是管道中的最后一个阶段。 |
| $planCacheStats | 返回集合的计划缓存信息。                                     |
| $project        | 重塑流中的每个文档，例如通过添加新字段或删除现有字段。对于每个输入文档，输出一个文档。另请参阅`$unset`删除现有字段。 |
| $redact         | 通过基于文档本身中存储的信息限制每个文档的内容，来重塑流中的每个文档。包含`$project`和的功能 `$match`。可用于实施字段级修订。对于每个输入文档，输出一个或零个文档。 |
| $replaceRoot    | 用指定的嵌入式文档替换文档。该操作将替换输入文档中的所有现有字段，包括该`_id`字段。指定嵌入在输入文档中的文档以将嵌入的文档提升到顶层。`$replaceWith`是`$replaceRoot`舞台的别名 。 |
| $replaceWith    | 用指定的嵌入式文档替换文档。该操作将替换输入文档中的所有现有字段，包括该`_id`字段。指定嵌入在输入文档中的文档以将嵌入的文档提升到顶层。`$replaceWith`是`$replaceRoot`舞台的别名 。 |
| $sample         | 从其输入中随机选择指定数量的文档。                           |
| $set            | 将新字段添加到文档。与相似`$project`，`$set`重塑流中的每个文档；具体而言，通过向输出文档添加新字段，该文档既包含输入文档中的现有字段，又包含新添加的字段。`$set`是`$addFields`舞台的别名。 |
| $skip           | 跳过前*n个*文档，其中*n*是指定的跳过编号，并将其余未修改的文档传递到管道。对于每个输入文档，输出零个文档（对于前*n个*文档）或一个文档（如果在前*n个*文档之后）。 |
| $sort           | 通过指定的排序键对文档流重新排序。只有顺序改变；这些文档保持不变。对于每个输入文档，输出一个文档。 |
| $sortByCount    | 根据指定表达式的值对传入文档进行分组，然后计算每个不同组中的文档数。 |
| $unset          | 从文档中删除/排除字段。`$unset`是`$project`删除字段的阶段的别名。 |
| $unwind         | 从输入文档中解构一个数组字段，以输出*每个*元素的文档。每个输出文档用元素值替换数组。对于每个输入文档，输出*n个*文档，其中*n*是数组元素的数量，对于空数组可以为零。 |

### <font size=4 color=blue>**4. 表达式运算符**</font>

#### 算术表达式运算符

算术表达式对数字执行数学运算。一些算术表达式也可以支持日期算术。

| 名称                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [`$abs`](https://mongodb.net.cn/manual/reference/operator/aggregation/abs/#exp._S_abs) | 返回数字的绝对值。                                           |
| [`$add`](https://mongodb.net.cn/manual/reference/operator/aggregation/add/#exp._S_add) | 添加数字以返回总和，或者添加数字和日期以返回新日期。如果添加数字和日期，则将数字视为毫秒。接受任意数量的参数表达式，但最多只能一个表达式解析为日期。 |
| [`$ceil`](https://mongodb.net.cn/manual/reference/operator/aggregation/ceil/#exp._S_ceil) | 返回大于或等于指定数字的最小整数。                           |
| [`$divide`](https://mongodb.net.cn/manual/reference/operator/aggregation/divide/#exp._S_divide) | 返回第一个数字除以第二个数字的结果。接受两个参数表达式。     |
| [`$exp`](https://mongodb.net.cn/manual/reference/operator/aggregation/exp/#exp._S_exp) | 将*e*提高到指定的指数。                                      |
| [`$floor`](https://mongodb.net.cn/manual/reference/operator/aggregation/floor/#exp._S_floor) | 返回小于或等于指定数字的最大整数。                           |
| [`$ln`](https://mongodb.net.cn/manual/reference/operator/aggregation/ln/#exp._S_ln) | 计算数字的自然对数。                                         |
| [`$log`](https://mongodb.net.cn/manual/reference/operator/aggregation/log/#exp._S_log) | 以指定的底数计算数字的对数。                                 |
| [`$log10`](https://mongodb.net.cn/manual/reference/operator/aggregation/log10/#exp._S_log10) | 计算数字的以10为底的对数。                                   |
| [`$mod`](https://mongodb.net.cn/manual/reference/operator/aggregation/mod/#exp._S_mod) | 返回第一个数字的余数除以第二个数字。接受两个参数表达式。     |
| [`$multiply`](https://mongodb.net.cn/manual/reference/operator/aggregation/multiply/#exp._S_multiply) | 乘以数字可返回乘积。接受任意数量的参数表达式。               |
| [`$pow`](https://mongodb.net.cn/manual/reference/operator/aggregation/pow/#exp._S_pow) | 将数字提高到指定的指数。                                     |
| [`$round`](https://mongodb.net.cn/manual/reference/operator/aggregation/round/#exp._S_round) | 将数字四舍五入为整数*或*指定的小数位。                       |
| [`$sqrt`](https://mongodb.net.cn/manual/reference/operator/aggregation/sqrt/#exp._S_sqrt) | 计算平方根。                                                 |
| [`$subtract`](https://mongodb.net.cn/manual/reference/operator/aggregation/subtract/#exp._S_subtract) | 返回从第一个值减去第二个值的结果。如果两个值是数字，则返回差值。如果两个值是日期，则返回以毫秒为单位的差。如果两个值是日期和毫秒数，则返回结果日期。接受两个参数表达式。如果两个值是日期和数字，请首先指定date参数，因为从数字中减去日期没有意义。 |
| [`$trunc`](https://mongodb.net.cn/manual/reference/operator/aggregation/trunc/#exp._S_trunc) | 将数字截断为整数*或*指定的小数位。                           |

#### 数组表达式运算符

| [`$arrayElemAt`](https://mongodb.net.cn/manual/reference/operator/aggregation/arrayElemAt/#exp._S_arrayElemAt) | 返回指定数组索引处的元素。                                   |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [`$arrayToObject`](https://mongodb.net.cn/manual/reference/operator/aggregation/arrayToObject/#exp._S_arrayToObject) | 将键值对数组转换为文档。                                     |
| [`$concatArrays`](https://mongodb.net.cn/manual/reference/operator/aggregation/concatArrays/#exp._S_concatArrays) | 连接数组以返回连接的数组。                                   |
| [`$filter`](https://mongodb.net.cn/manual/reference/operator/aggregation/filter/#exp._S_filter) | 选择数组的子集以返回仅包含与过滤条件匹配的元素的数组。       |
| [`$in`](https://mongodb.net.cn/manual/reference/operator/aggregation/in/#exp._S_in) | 返回一个布尔值，指示指定的值是否在数组中。                   |
| [`$indexOfArray`](https://mongodb.net.cn/manual/reference/operator/aggregation/indexOfArray/#exp._S_indexOfArray) | 在数组中搜索指定值的出现，并返回第一次出现的数组索引。如果未找到子字符串，则返回`-1`。 |
| [`$isArray`](https://mongodb.net.cn/manual/reference/operator/aggregation/isArray/#exp._S_isArray) | 确定操作数是否为数组。返回一个布尔值。                       |
| [`$map`](https://mongodb.net.cn/manual/reference/operator/aggregation/map/#exp._S_map) | 对数组的每个元素应用子表达式，并按顺序返回结果值的数组。接受命名参数。 |
| [`$objectToArray`](https://mongodb.net.cn/manual/reference/operator/aggregation/objectToArray/#exp._S_objectToArray) | 将文档转换为代表键值对的文档数组。                           |
| [`$range`](https://mongodb.net.cn/manual/reference/operator/aggregation/range/#exp._S_range) | 根据用户定义的输入输出包含整数序列的数组。                   |
| [`$reduce`](https://mongodb.net.cn/manual/reference/operator/aggregation/reduce/#exp._S_reduce) | 将表达式应用于数组中的每个元素，并将它们组合为单个值。       |
| [`$reverseArray`](https://mongodb.net.cn/manual/reference/operator/aggregation/reverseArray/#exp._S_reverseArray) | 返回具有相反顺序元素的数组。                                 |
| [`$size`](https://mongodb.net.cn/manual/reference/operator/aggregation/size/#exp._S_size) | 返回数组中元素的数量。接受单个表达式作为参数。               |
| [`$slice`](https://mongodb.net.cn/manual/reference/operator/aggregation/slice/#exp._S_slice) | 返回数组的子集。                                             |
| [`$zip`](https://mongodb.net.cn/manual/reference/operator/aggregation/zip/#exp._S_zip) | 将两个数组合并在一起。                                       |

#### 布尔表达式运算符

布尔表达式将其参数表达式评估为布尔值，并返回布尔值作为结果。

除了`false`布尔值，布尔表达式为`false`如下：`null`，`0`，和`undefined` 的值。布尔表达式将所有其他值评估为`true`，包括非零数字值和数组。

| 名称                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [`$and`](https://mongodb.net.cn/manual/reference/operator/aggregation/and/#exp._S_and) | `true`仅当其*所有*表达式的计算结果 *均为*时才返回`true`。接受任意数量的参数表达式。 |
| [`$not`](https://mongodb.net.cn/manual/reference/operator/aggregation/not/#exp._S_not) | 返回与其参数表达式相反的布尔值。接受单个参数表达式。         |
| [`$or`](https://mongodb.net.cn/manual/reference/operator/aggregation/or/#exp._S_or) | `true`当其*任何*表达式的计算结果为时， 返回`true`。接受任意数量的参数表达式。 |

#### 比较表达式运算符

比较表达式返回一个布尔值，但[`$cmp`](https://mongodb.net.cn/manual/reference/operator/aggregation/cmp/#exp._S_cmp) 返回一个数字。

比较表达式采用两个参数表达式，并且对不同类型的值使用[指定的BSON比较顺序](https://mongodb.net.cn/manual/reference/bson-type-comparison-order/#bson-types-comparison-order)来[比较](https://mongodb.net.cn/manual/reference/bson-type-comparison-order/#bson-types-comparison-order)值和类型。

| [`$cmp`](https://mongodb.net.cn/manual/reference/operator/aggregation/cmp/#exp._S_cmp) | 返回`0`如果这两个值是相等的，`1`如果第一个值大于所述第二值，并且`-1`如果所述第一值大于所述第二以下。 |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [`$eq`](https://mongodb.net.cn/manual/reference/operator/aggregation/eq/#exp._S_eq) | `true`如果值相等则返回。                                     |
| [`$gt`](https://mongodb.net.cn/manual/reference/operator/aggregation/gt/#exp._S_gt) | `true`如果第一个值大于第二个值，则返回。                     |
| [`$gte`](https://mongodb.net.cn/manual/reference/operator/aggregation/gte/#exp._S_gte) | `true`如果第一个值大于或等于第二个值，则返回。               |
| [`$lt`](https://mongodb.net.cn/manual/reference/operator/aggregation/lt/#exp._S_lt) | `true`如果第一个值小于第二个值，则返回。                     |
| [`$lte`](https://mongodb.net.cn/manual/reference/operator/aggregation/lte/#exp._S_lte) | 返回`true`如果第一个值小于或等于第二。                       |
| [`$ne`](https://mongodb.net.cn/manual/reference/operator/aggregation/ne/#exp._S_ne) | `true`如果值*不*相等，则返回。                               |

#### 条件表达式运算符

| 名称                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [`$cond`](https://mongodb.net.cn/manual/reference/operator/aggregation/cond/#exp._S_cond) | 一个三元运算符，它对一个表达式求值，并根据结果返回其他两个表达式之一的值。接受有序列表中的三个表达式或三个命名参数。 |
| [`$ifNull`](https://mongodb.net.cn/manual/reference/operator/aggregation/ifNull/#exp._S_ifNull) | 如果第一个表达式的结果为空，则返回第一个表达式的非空结果或第二个表达式的结果。空结果包含未定义值或缺少字段的实例。接受两个表达式作为参数。第二个表达式的结果可以为空。 |
| [`$switch`](https://mongodb.net.cn/manual/reference/operator/aggregation/switch/#exp._S_switch) | 计算一系列案例表达式。当它找到一个计算结果为的表达式时`true`，`$switch`执行一个指定的表达式并退出控制流程。 |

#### 日期表达式运算符

以下运算符返回日期对象或日期对象的组成部分：

| 名称                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [`$dateFromParts`](https://mongodb.net.cn/manual/reference/operator/aggregation/dateFromParts/#exp._S_dateFromParts) | 给定日期的组成部分，构造一个BSON Date对象。                  |
| [`$dateFromString`](https://mongodb.net.cn/manual/reference/operator/aggregation/dateFromString/#exp._S_dateFromString) | 将日期/时间字符串转换为日期对象。                            |
| [`$dateToParts`](https://mongodb.net.cn/manual/reference/operator/aggregation/dateToParts/#exp._S_dateToParts) | 返回包含日期组成部分的文档。                                 |
| [`$dateToString`](https://mongodb.net.cn/manual/reference/operator/aggregation/dateToString/#exp._S_dateToString) | 以格式字符串返回日期。                                       |
| [`$dayOfMonth`](https://mongodb.net.cn/manual/reference/operator/aggregation/dayOfMonth/#exp._S_dayOfMonth) | 以1到31之间的数字返回日期的月份。                            |
| [`$dayOfWeek`](https://mongodb.net.cn/manual/reference/operator/aggregation/dayOfWeek/#exp._S_dayOfWeek) | 以1（星期日）至7（星期六）之间的数字返回日期的星期几。       |
| [`$dayOfYear`](https://mongodb.net.cn/manual/reference/operator/aggregation/dayOfYear/#exp._S_dayOfYear) | 以1到366（le年）之间的数字返回日期中的日期。                 |
| [`$hour`](https://mongodb.net.cn/manual/reference/operator/aggregation/hour/#exp._S_hour) | 以0到23之间的数字返回日期的小时数。                          |
| [`$isoDayOfWeek`](https://mongodb.net.cn/manual/reference/operator/aggregation/isoDayOfWeek/#exp._S_isoDayOfWeek) | 以ISO 8601格式返回工作日编号，范围从 `1`（星期一）到`7`（星期日）。 |
| [`$isoWeek`](https://mongodb.net.cn/manual/reference/operator/aggregation/isoWeek/#exp._S_isoWeek) | 以ISO 8601格式返回星期数，范围从 `1`到`53`。星期数字从`1`包含一年中第一个星期四的星期（星期一至星期日）开始。 |
| [`$isoWeekYear`](https://mongodb.net.cn/manual/reference/operator/aggregation/isoWeekYear/#exp._S_isoWeekYear) | 以ISO 8601格式返回年份。年份从第1周的星期一（ISO 8601）开始，到最后一周的星期日（ISO 8601）结束。 |
| [`$millisecond`](https://mongodb.net.cn/manual/reference/operator/aggregation/millisecond/#exp._S_millisecond) | 以0到999之间的数字返回日期的毫秒数。                         |
| [`$minute`](https://mongodb.net.cn/manual/reference/operator/aggregation/minute/#exp._S_minute) | 以0到59之间的数字返回日期的分钟。                            |
| [`$month`](https://mongodb.net.cn/manual/reference/operator/aggregation/month/#exp._S_month) | 以1（一月）至12（十二月）之间的数字返回日期的月份。          |
| [`$second`](https://mongodb.net.cn/manual/reference/operator/aggregation/second/#exp._S_second) | 以0到60之间的数字返回日期的秒数（（秒）。                    |
| [`$toDate`](https://mongodb.net.cn/manual/reference/operator/aggregation/toDate/#exp._S_toDate) | 将值转换为日期。版本4.0中的新功能。                          |
| [`$week`](https://mongodb.net.cn/manual/reference/operator/aggregation/week/#exp._S_week) | 返回日期的星期数，其范围是0（该年的第一个星期日之前的局部星期）和53（le年）之间的数字。 |
| [`$year`](https://mongodb.net.cn/manual/reference/operator/aggregation/year/#exp._S_year) | 以数字形式返回日期的年份（例如2014）。                       |

以下算术运算符可以采用日期操作数：

| 名称                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [`$add`](https://mongodb.net.cn/manual/reference/operator/aggregation/add/#exp._S_add) | 添加数字和日期以返回新日期。如果添加数字和日期，则将数字视为毫秒。接受任意数量的参数表达式，但最多只能一个表达式解析为日期。 |
| [`$subtract`](https://mongodb.net.cn/manual/reference/operator/aggregation/subtract/#exp._S_subtract) | 返回从第一个值减去第二个值的结果。如果两个值是日期，则返回以毫秒为单位的差。如果两个值是日期和毫秒数，则返回结果日期。接受两个参数表达式。如果两个值是日期和数字，请首先指定date参数，因为从数字中减去日期没有意义。 |

#### 文字表达式运算符

| 名称                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [`$literal`](https://mongodb.net.cn/manual/reference/operator/aggregation/literal/#exp._S_literal) | 返回一个没有解析的值。用于聚合管道可以解释为表达式的值。例如，[`$literal`](https://mongodb.net.cn/manual/reference/operator/aggregation/literal/#exp._S_literal)对以a开头的字符串使用表达式，`$`以避免将其解析为字段路径。 |

#### 对象表达式运算符

| 名称                                                         | 描述                                              |
| :----------------------------------------------------------- | :------------------------------------------------ |
| [`$mergeObjects`](https://mongodb.net.cn/manual/reference/operator/aggregation/mergeObjects/#exp._S_mergeObjects) | 将多个文档合并为一个文档。3.6版的新功能。         |
| [`$objectToArray`](https://mongodb.net.cn/manual/reference/operator/aggregation/objectToArray/#exp._S_objectToArray) | 将文档转换为代表键值对的文档数组。3.6版的新功能。 |

#### 表达式运算符

集表达式对数组执行集运算，将数组视为集。集合表达式将忽略每个输入数组中的重复条目以及元素的顺序。

如果set操作返回一个set，则该操作会滤除结果中的重复项，以输出仅包含唯一条目的数组。输出数组中元素的顺序未指定。

如果一组包含嵌套数组元素，该组表达并*没有*下降到嵌套阵列，但在评估顶层阵列。

| 名称                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [`$allElementsTrue`](https://mongodb.net.cn/manual/reference/operator/aggregation/allElementsTrue/#exp._S_allElementsTrue) | 返回`true`如果*没有*一套评价了元素 `false`，否则，返回`false`。接受单个参数表达式。 |
| [`$anyElementTrue`](https://mongodb.net.cn/manual/reference/operator/aggregation/anyElementTrue/#exp._S_anyElementTrue) | `true`如果集合中的*任何*元素 求和，则返回`true`；否则，返回`false`。接受单个参数表达式。 |
| [`$setDifference`](https://mongodb.net.cn/manual/reference/operator/aggregation/setDifference/#exp._S_setDifference) | 返回具有出现在第一个集合中但不出现在第二个集合中的元素的集合；即执行 第二组相对于第一组的[相对补码](http://en.wikipedia.org/wiki/Complement_(set_theory))。正好接受两个参数表达式。 |
| [`$setEquals`](https://mongodb.net.cn/manual/reference/operator/aggregation/setEquals/#exp._S_setEquals) | 返回`true`如果输入组具有相同的不同元素。接受两个或多个参数表达式。 |
| [`$setIntersection`](https://mongodb.net.cn/manual/reference/operator/aggregation/setIntersection/#exp._S_setIntersection) | 返回具有出现在*所有*输入集中的元素的集合。接受任意数量的参数表达式。 |
| [`$setIsSubset`](https://mongodb.net.cn/manual/reference/operator/aggregation/setIsSubset/#exp._S_setIsSubset) | 返回`true`第一个集合的所有元素是否出现在第二个集合中，包括第一个集合等于第二个集合时；即不是[严格的子集](http://en.wikipedia.org/wiki/Subset)。正好接受两个参数表达式。 |
| [`$setUnion`](https://mongodb.net.cn/manual/reference/operator/aggregation/setUnion/#exp._S_setUnion) | 返回带有出现在*任何*输入集中的元素的集合。                   |

#### 字符串表达式运算符

字符串表达式（除外 [`$concat`](https://mongodb.net.cn/manual/reference/operator/aggregation/concat/#exp._S_concat)）仅对ASCII字符字符串具有明确定义的行为。

[`$concat`](https://mongodb.net.cn/manual/reference/operator/aggregation/concat/#exp._S_concat) 行为是明确定义的，与所使用的字符无关。

| 名称                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [`$concat`](https://mongodb.net.cn/manual/reference/operator/aggregation/concat/#exp._S_concat) | 连接任意数量的字符串。                                       |
| [`$dateFromString`](https://mongodb.net.cn/manual/reference/operator/aggregation/dateFromString/#exp._S_dateFromString) | 将日期/时间字符串转换为日期对象。                            |
| [`$dateToString`](https://mongodb.net.cn/manual/reference/operator/aggregation/dateToString/#exp._S_dateToString) | 以格式字符串返回日期。                                       |
| [`$indexOfBytes`](https://mongodb.net.cn/manual/reference/operator/aggregation/indexOfBytes/#exp._S_indexOfBytes) | 在字符串中搜索子字符串的出现，并返回第一次出现的UTF-8字节索引。如果未找到子字符串，则返回`-1`。 |
| [`$indexOfCP`](https://mongodb.net.cn/manual/reference/operator/aggregation/indexOfCP/#exp._S_indexOfCP) | 在字符串中搜索子字符串的出现，并返回第一次出现的UTF-8代码点索引。如果未找到子字符串，则返回`-1` |
| [`$ltrim`](https://mongodb.net.cn/manual/reference/operator/aggregation/ltrim/#exp._S_ltrim) | 从字符串开头删除空格或指定的字符。版本4.0中的新功能。        |
| [`$regexFind`](https://mongodb.net.cn/manual/reference/operator/aggregation/regexFind/#exp._S_regexFind) | 将正则表达式（regex）应用于字符串，并返回*第一个*匹配的子字符串的信息。4.2版中的新功能。 |
| [`$regexFindAll`](https://mongodb.net.cn/manual/reference/operator/aggregation/regexFindAll/#exp._S_regexFindAll) | 将正则表达式（regex）应用于字符串，并返回所有匹配的子字符串的信息。4.2版中的新功能。 |
| [`$regexMatch`](https://mongodb.net.cn/manual/reference/operator/aggregation/regexMatch/#exp._S_regexMatch) | 将正则表达式（regex）应用于字符串，并返回一个布尔值，该布尔值指示是否找到匹配项。4.2版中的新功能。 |
| [`$rtrim`](https://mongodb.net.cn/manual/reference/operator/aggregation/rtrim/#exp._S_rtrim) | 从字符串末尾删除空格或指定的字符。版本4.0中的新功能。        |
| [`$split`](https://mongodb.net.cn/manual/reference/operator/aggregation/split/#exp._S_split) | 根据定界符将字符串拆分为子字符串。返回子字符串数组。如果在字符串中未找到分隔符，则返回包含原始字符串的数组。 |
| [`$strLenBytes`](https://mongodb.net.cn/manual/reference/operator/aggregation/strLenBytes/#exp._S_strLenBytes) | 返回字符串中UTF-8编码的字节数。                              |
| [`$strLenCP`](https://mongodb.net.cn/manual/reference/operator/aggregation/strLenCP/#exp._S_strLenCP) | 返回字符串中UTF-8 [代码点](http://www.unicode.org/glossary/#code_point)的数量。 |
| [`$strcasecmp`](https://mongodb.net.cn/manual/reference/operator/aggregation/strcasecmp/#exp._S_strcasecmp) | 执行不区分大小写的字符串比较并返回： `0`如果两个字符串相等，`1`则第一个字符串大于第二个`-1`字符串，并且第一个字符串小于第二个字符串。 |
| [`$substr`](https://mongodb.net.cn/manual/reference/operator/aggregation/substr/#exp._S_substr) | 不推荐使用。使用[`$substrBytes`](https://mongodb.net.cn/manual/reference/operator/aggregation/substrBytes/#exp._S_substrBytes)或 [`$substrCP`](https://mongodb.net.cn/manual/reference/operator/aggregation/substrCP/#exp._S_substrCP)。 |
| [`$substrBytes`](https://mongodb.net.cn/manual/reference/operator/aggregation/substrBytes/#exp._S_substrBytes) | 返回字符串的子字符串。从字符串中指定的UTF-8字节索引（从零开始）处的字符开始，并继续指定的字节数。 |
| [`$substrCP`](https://mongodb.net.cn/manual/reference/operator/aggregation/substrCP/#exp._S_substrCP) | 返回字符串的子字符串。从字符串中指定的UTF-8 [代码点（CP）](http://www.unicode.org/glossary/#code_point)索引（从零开始）处的字符开始，并继续指定的代码点数。 |
| [`$toLower`](https://mongodb.net.cn/manual/reference/operator/aggregation/toLower/#exp._S_toLower) | 将字符串转换为小写。接受单个参数表达式。                     |
| [`$toString`](https://mongodb.net.cn/manual/reference/operator/aggregation/toString/#exp._S_toString) | 将值转换为字符串。版本4.0中的新功能。                        |
| [`$trim`](https://mongodb.net.cn/manual/reference/operator/aggregation/trim/#exp._S_trim) | 从字符串的开头和结尾删除空格或指定的字符。版本4.0中的新功能。 |
| [`$toUpper`](https://mongodb.net.cn/manual/reference/operator/aggregation/toUpper/#exp._S_toUpper) | 将字符串转换为大写。接受单个参数表达式。                     |

#### 文本表达式运算符

| 名称                                                         | 描述                 |
| :----------------------------------------------------------- | :------------------- |
| [`$meta`](https://mongodb.net.cn/manual/reference/operator/aggregation/meta/#exp._S_meta) | 访问文本搜索元数据。 |

#### 三角表达式运算符

三角表达式对数字执行三角运算。表示角度的值始终以弧度为单位输入或输出。使用 [`$degreesToRadians`](https://mongodb.net.cn/manual/reference/operator/aggregation/degreesToRadians/#exp._S_degreesToRadians)和[`$radiansToDegrees`](https://mongodb.net.cn/manual/reference/operator/aggregation/radiansToDegrees/#exp._S_radiansToDegrees)在度和弧度测量之间转换。

| 名称                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [`$sin`](https://mongodb.net.cn/manual/reference/operator/aggregation/sin/#exp._S_sin) | 返回以弧度为单位的值的正弦值。                               |
| [`$cos`](https://mongodb.net.cn/manual/reference/operator/aggregation/cos/#exp._S_cos) | 返回以弧度为单位的值的余弦值。                               |
| [`$tan`](https://mongodb.net.cn/manual/reference/operator/aggregation/tan/#exp._S_tan) | 返回以弧度为单位的值的切线。                                 |
| [`$asin`](https://mongodb.net.cn/manual/reference/operator/aggregation/asin/#exp._S_asin) | 返回弧度值的反正弦（弧正弦）。                               |
| [`$acos`](https://mongodb.net.cn/manual/reference/operator/aggregation/acos/#exp._S_acos) | 返回以弧度为单位的值的反余弦（弧余弦）。                     |
| [`$atan`](https://mongodb.net.cn/manual/reference/operator/aggregation/atan/#exp._S_atan) | 返回弧度值的反正切（弧切线）。                               |
| [`$atan2`](https://mongodb.net.cn/manual/reference/operator/aggregation/atan2/#exp._S_atan2) | 返回弧度的反正切（弧切线），其中和是分别传递给表达式的第一个和第二个值。`y / x``y``x` |
| [`$asinh`](https://mongodb.net.cn/manual/reference/operator/aggregation/asinh/#exp._S_asinh) | 返回弧度值的反双曲正弦（双曲反正弦）。                       |
| [`$acosh`](https://mongodb.net.cn/manual/reference/operator/aggregation/acosh/#exp._S_acosh) | 返回弧度值的反双曲余弦（双曲反余弦）。                       |
| [`$atanh`](https://mongodb.net.cn/manual/reference/operator/aggregation/atanh/#exp._S_atanh) | 返回弧度值的反双曲正切（双曲反正切）。                       |
| [`$degreesToRadians`](https://mongodb.net.cn/manual/reference/operator/aggregation/degreesToRadians/#exp._S_degreesToRadians) | 将值从度转换为弧度。                                         |
| [`$radiansToDegrees`](https://mongodb.net.cn/manual/reference/operator/aggregation/radiansToDegrees/#exp._S_radiansToDegrees) | 将值从弧度转换为度。                                         |

#### 类型表达式运算符

| 名称                                                         | 描述                                      |
| :----------------------------------------------------------- | :---------------------------------------- |
| [`$convert`](https://mongodb.net.cn/manual/reference/operator/aggregation/convert/#exp._S_convert) | 将值转换为指定的类型。版本4.0中的新功能。 |
| [`$toBool`](https://mongodb.net.cn/manual/reference/operator/aggregation/toBool/#exp._S_toBool) | 将值转换为布尔值。版本4.0中的新功能。     |
| [`$toDate`](https://mongodb.net.cn/manual/reference/operator/aggregation/toDate/#exp._S_toDate) | 将值转换为日期。版本4.0中的新功能。       |
| [`$toDecimal`](https://mongodb.net.cn/manual/reference/operator/aggregation/toDecimal/#exp._S_toDecimal) | 将值转换为Decimal128。版本4.0中的新功能。 |
| [`$toDouble`](https://mongodb.net.cn/manual/reference/operator/aggregation/toDouble/#exp._S_toDouble) | 将值转换为双精度。版本4.0中的新功能。     |
| [`$toInt`](https://mongodb.net.cn/manual/reference/operator/aggregation/toInt/#exp._S_toInt) | 将值转换为整数。版本4.0中的新功能。       |
| [`$toLong`](https://mongodb.net.cn/manual/reference/operator/aggregation/toLong/#exp._S_toLong) | 将值转换为long。版本4.0中的新功能。       |
| [`$toObjectId`](https://mongodb.net.cn/manual/reference/operator/aggregation/toObjectId/#exp._S_toObjectId) | 将值转换为ObjectId。版本4.0中的新功能。   |
| [`$toString`](https://mongodb.net.cn/manual/reference/operator/aggregation/toString/#exp._S_toString) | 将值转换为字符串。版本4.0中的新功能。     |
| [`$type`](https://mongodb.net.cn/manual/reference/operator/aggregation/type/#exp._S_type) | 返回该字段的BSON数据类型。                |

#### 累加器（`$group`）

[`$group`](https://mongodb.net.cn/manual/reference/operator/aggregation/group/#pipe._S_group)累加器是可以在该阶段中使用的运算符，它们在文档通过管道进行时保持其状态（例如，总计，最大值，最小值和相关数据）。

当在[`$group`](https://mongodb.net.cn/manual/reference/operator/aggregation/group/#pipe._S_group)阶段中用作累加器时，这些运算符将单个表达式作为输入，对每个输入文档评估一次该表达式，并为共享相同组键的文档组维护其阶段。

| 名称                                                         | 描述                                                         |
| :----------------------------------------------------------- | :----------------------------------------------------------- |
| [`$addToSet`](https://mongodb.net.cn/manual/reference/operator/aggregation/addToSet/#grp._S_addToSet) | 返回每个组的*唯一*表达式值的数组。数组元素的顺序未定义。     |
| [`$avg`](https://mongodb.net.cn/manual/reference/operator/aggregation/avg/#grp._S_avg) | 返回数值的平均值。忽略非数字值。                             |
| [`$first`](https://mongodb.net.cn/manual/reference/operator/aggregation/first/#grp._S_first) | 从每个组的第一个文档返回一个值。仅当文档按定义的顺序定义顺序。 |
| [`$last`](https://mongodb.net.cn/manual/reference/operator/aggregation/last/#grp._S_last) | 从每个组的最后一个文档返回一个值。仅当文档按定义的顺序定义顺序。 |
| [`$max`](https://mongodb.net.cn/manual/reference/operator/aggregation/max/#grp._S_max) | 返回每个组的最高表达式值。                                   |
| [`$mergeObjects`](https://mongodb.net.cn/manual/reference/operator/aggregation/mergeObjects/#exp._S_mergeObjects) | 返回通过组合每个组的输入文档而创建的文档。                   |
| [`$min`](https://mongodb.net.cn/manual/reference/operator/aggregation/min/#grp._S_min) | 返回每个组的最低表达式值。                                   |
| [`$push`](https://mongodb.net.cn/manual/reference/operator/aggregation/push/#grp._S_push) | 返回每个组的表达式值数组。                                   |
| [`$stdDevPop`](https://mongodb.net.cn/manual/reference/operator/aggregation/stdDevPop/#grp._S_stdDevPop) | 返回输入值的总体标准偏差。                                   |
| [`$stdDevSamp`](https://mongodb.net.cn/manual/reference/operator/aggregation/stdDevSamp/#grp._S_stdDevSamp) | 返回输入值的样本标准偏差。                                   |
| [`$sum`](https://mongodb.net.cn/manual/reference/operator/aggregation/sum/#grp._S_sum) | 返回数值的总和。忽略非数字值。                               |

#### 累加器（处于其他阶段）

某些可用作[`$group`](https://mongodb.net.cn/manual/reference/operator/aggregation/group/#pipe._S_group)阶段的累加器的运算符 也可用于其他阶段，但不能用作累加器。在其他阶段使用这些运算符时，它们不会保持其状态，并且可以将单个参数或多个参数用作输入。有关详细信息，请参阅特定的操作员页面。

在版本3.2中更改。

下面的蓄电池运营商也可在 [`$project`](https://mongodb.net.cn/manual/reference/operator/aggregation/project/#pipe._S_project)，[`$addFields`](https://mongodb.net.cn/manual/reference/operator/aggregation/addFields/#pipe._S_addFields)和[`$set`](https://mongodb.net.cn/manual/reference/operator/aggregation/set/#pipe._S_set)阶段。

| 名称 | 描述 |
| :--- | :--- |
| $avg |      |

### <font size=4 color=blue>**5. 查询修饰符**</font>

#### 查询修饰符

| 名称         | 描述                                                         |
| :----------- | :----------------------------------------------------------- |
| $comment     | 向查询添加注释，以标识[数据库探查器](https://mongodb.net.cn/manual/reference/glossary/#term-database-profiler)输出中的查询。 |
| $explain     | 强制MongoDB报告查询执行计划。请参阅[`explain()`](https://mongodb.net.cn/manual/reference/method/cursor.explain/#cursor.explain)。 |
| $hint        | 强制MongoDB使用特定索引。看到[`hint()`](https://mongodb.net.cn/manual/reference/method/cursor.hint/#cursor.hint) |
| $max         | 指定要在查询中使用的索引的*排他*上限。请参阅[`max()`](https://mongodb.net.cn/manual/reference/method/cursor.max/#cursor.max)。 |
| $maxTimeMS   | 指定用于游标的处理操作的累积时间限制（以毫秒为单位）。请参阅[`maxTimeMS()`](https://mongodb.net.cn/manual/reference/method/cursor.maxTimeMS/#cursor.maxTimeMS)。 |
| $min         | 指定一个*包容性的*下限为索引在查询中使用。请参阅[`min()`](https://mongodb.net.cn/manual/reference/method/cursor.min/#cursor.min)。 |
| $orderby     | 返回带有根据排序规范排序的文档的游标。请参阅[`sort()`](https://mongodb.net.cn/manual/reference/method/cursor.sort/#cursor.sort)。 |
| $query       | 包装查询文档。                                               |
| $returnKey   | 强制光标仅返回索引中包含的字段。                             |
| $showDiskLoc | 修改返回的文档以包括对每个文档在磁盘上位置的引用。           |

#### 排序顺序

| 名称                                                         | 描述                                                     |
| :----------------------------------------------------------- | :------------------------------------------------------- |
| $natural | 一种特殊的排序顺序，使用磁盘上的文档顺序对文档进行排序。 |

## 1.7 MongoDB的相关操作

### <font size=4 color=blue>**1. 数据库**</font>

- 创建数据库：作用一：切换到指定数据库；作用二：如果数据库不存在，则会在内存中创建一个数据库并激活改数据库，当数据库中有文档数据则会持久化到磁盘上；

  ```sql
  use 数据库名称;
  ```

- 删除数据库：需要执行命令的用户具有dbAdminAnyDatabase角色登陆；删除当前已激活的数据库，需要在命令行可以执行，在部分图形化界面工具中无法使用该命令删除数据库

  ```sql
  db.dropDatabase();
  ```

- 查看当前正在使用的数据库

  ```sql
  db;
  ```

- 查看所有数据库：如果开启认证后未认证则不会显示结果，如果是数据库用户认证，则只可以看到当前用户所在的数据库；并且不会显示任何未含有数据信息的数据库

  ```sql
  show dbs;
  show databases;
  ```

### <font size=4 color=blue>**2. 集合 - 创建**</font>

- 集合的显式创建：使用该命令不可以重复创建同名的集合

  ```sql
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
  db.集合名称.insert(文档);
  ```

### <font size=4 color=blue>**3. 集合 - 删除**</font>

- 开启认证后，删除集合的用户必须具备dbAdminAnyDatabase角色

  ```sql
  db.集合名称.drop()
  ```

### <font size=4 color=blue>**4. 集合 - 查看**</font>

```sql
show collections
show tables
```

### <font size=4 color=blue>**5. 文档 - 新增**</font>

- **说明**：新增文档不需要指定集合名称，如果插入时集合不存在，插入操作会创建该集合。

- **新增文档API**

  | API              | 说明                                                         |
  | ---------------- | ------------------------------------------------------------ |
  | **insert()**     | 新增一条或多条文档，单条插入时返回 写入结果 对象。批量插入时返回 批量插入结果 对象。 |
  | **save()**       | 新增一条或多个文档                                           |
  | **insertOne()**  | 新增一条文档，并返回新增文档的id（3.2新增）                  |
  | **insertMany()** | 新增多条文档，并返回新增文档的id集合（3.2新增）              |
  | 定义变量         | var 变量名称 = (文档字符串)                                  |

- **基本语法**

  ```sql
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

### <font size=4 color=blue>**5. 文档 - 更新**</font>

- update函数

  - 语法格式：db.集合名称.update({查询条件},{更新内容},{可选更新参数})

    - 可选属性
      - multi:Boolean值  true表示更新多条,默认是false,只更新1条
    - 如果不使用更新操作符,默认是将更新内容替换掉原文档
    - 默认只更新匹配到的第一条

  - 更新操作符

    - $set:用于指定键值进行更新,如果键值不存在则新增,如果键值存在则更新掉键值对应的值

      ```json
      db.集合名称.update({},{
          $set:{}
      })
      ```

    - $inc:用户数值类型的属性自增,并且自增的值只能有1个

      ```json
      db.集合名称.update({},{
          $inc:{key:12}
      })
      ```

    - $unset:删除键

    - $push:向文档的数据类型

      ```json
      db.集合名称.update({},{
          $push:{tab:12}
      })
      ```

    - $pop:从数组中删除元素:1表示从后向前, -1 表示从头部开始删

      ```json
      db.集合名称.update({},{
          $push:{tab:1或者-1}
      })
      ```

    - $pull:重数组中删除满足条件的元素

    - 

  

- save函数更新文档

  

# 第二章：从熟练到精通的开发之路

13 | 模型设计基础

14 | JSON文档模型设计特点

15 | 文档模型设计之一：基础设计

16 | 文档模型设计之二：工况细化

17 | 文档模型设计之三：模式套用

18 | 设计模式集锦

19 | 事务开发：写操作事务

20 | 事务开发：读操作事务之一

21 | 事务开发：读操作事务之二

22 | 事务开发：多文档事务

23 | Change Stream

24 | MongoDB开发最佳实践

# 第三章：分片集群与高级运维之道

25 | 分片集群机制及原理

26 | 分片集群设计

27 | 实验：分片集群搭建及扩容

28 | MongoDB监控最佳实践

29 | MongoDB备份与恢复

30 | 备份与恢复操作

31 | MongoDB安全架构

32 | MongoDB安全加固实践

33 | MongoDB索引机制（一）

34 | MongoDB索引机制（二）

35 | MongoDB读写性能机制

36 | 性能诊断工具

37 | 高级集群设计：两地三中心

38 | 实验：搭建两地三中心集群

39 | 高级集群设计：全球多写

40 | MongoDB上线及升级

# 第四章：企业架构师进阶之法

41 | MongoDB应用场景及选型

42 | MongoDB典型案例（一）

43 | MongoDB典型案例（二）

44 | 关系型数据库迁移

45 | 数据库迁移方式及工具

46 | Oracle迁移实战

47 | MongoDB + Spark实时大数据

48 | MongoDB + Spark连接实战

49 | MongoDB SQL套接件

50 | MongoDB与微服务

51 | MongoDB与数据中台

52 | MongoDB数据中台案例

53 | 结果测试&结束语