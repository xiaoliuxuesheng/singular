001-课程大纲

2. 课程大纲
   - 初级
     - 入门：
     - 安装
     - 数据类型
     - 表引擎
     - SQL操作
     - 副本
     - 分片集群
   - 高级
     - 查看执行计划
     - 建表优化
     - 语法优化规则
     - 查询优化
     - 数据一致性
     - 物化视图
     - SQL引擎
     - 常见问题排查
   - 监控及备份
     - Clickhouse监控概述
     - Prometheus和Grafana的安装
     - ClickHouse配置
     - Grafana集成Prometheus
     - 备份及恢复
2. 学习基础：sql+zookeeper+Linux基础

002-课程介绍

1. 课程大纲的整体介绍
   - 第一章 ClickHouse入门
   - 第二章 ClickHouse安装
   - 第三章 数据类型
   - 第四章 表引擎
   - 第五章 sql操作
   - 第六章  副本
   - 第七章 分片集群

003-click house特点

1. 背景：是俄罗斯Yandex开源的都列式存储数据库
2. 特点
   - 列式存储的数据库由CSS开发的数据库：存储到磁盘中先存第一列，然后再存第二列。。：存储紧凑
   - 主要用户分析处理；
   - 能够使用SQL查询实时生成分析数据报告；
   - 几乎覆盖了标准SQL大部分语法；
   - 多样化引擎：表引擎和库引擎等等
   - 高吞吐写入能力
   - 数据分区与线程并行

004-准备工作

1. 关闭防火墙

2. Centos取消文件限制：/etc/security/limits.conf

   ```sh
   * soft nofile 65536
   * hard nofile 65536
   * soft nproc 131072
   * hard nproc 131072
   ```

   > - `*` - 表示限制的用户和用户组（用户名@用户组）
   > - soft - 表示软限制
   > - hard - 表示硬限制，大于软限制
   > - nofile - 表示打开的文件数
   > - nproc - 可以打开的进程数

3. 上面的配置回被：/etc/security/limits.d/20-nproc.conf覆盖，所以上面的配置需要再配置一份

   ```sh
   * soft nofile 65536
   * hard nofile 65536
   * soft nproc 131072
   * hard nproc 131072
   ```

4. 重新登陆就生效了 

5. 安装依赖

   ```sh
   sudo yum install -y libtool
   sudo yum install -y *unixODBC*
   ```

6. CentOS取消SELINUX

   ```sh
   sudo vim /etc/selinux/config
   
   SELINUX=disabled
   
   getenforce
   setenforce 0 # 临时关闭，下次重启就会生效
   ```

7. 重启三台服务器

005-单机安装

1. 下载：https://clickhouse.com/

2. 使用RPM安装：https://clickhouse.com/docs/en/getting-started/install/

   ```sh
   sudo yum install yum-utils
   sudo rpm --import https://repo.clickhouse.com/CLICKHOUSE-KEY.GPG
   sudo yum-config-manager --add-repo https://repo.clickhouse.com/rpm/stable/x86_64
   ```

3. 手动安装离线安装：https://repo.yandex.ru/clickhouse/rpm/stable/x86_64/

   - client + common- static + common-static-dbg + server

   - 版本说明：20.5（支持多线程）、20.6.3（支持explain）、20.8（支持mysql同步）

   - 安装：四个安装包保存到一个目录

     ```sh
     sudo rpm -ivh *.rpm
     ```

     > - bin/ - /usr/bin/
     > - conf/ - /etc/clickhose-server
     >   - config.xml：服务端配置
     >   - user.xml：使用参数配置
     > - lib/ - /var/lib/clickhouse
     > - logs/ - var/logs/clickhouse-server

4. 修改配置config.xml：本机以外的可以访问

   ```xml
    <listen-host>::</listen-host>
   ```

5. 启动：

   ```sh
   sudo clickhouse status
   sudo clickhouse start
   sudo clickhouse restart
   ```

6. 客户端连接click house服务器

   ```sh
   clickhouse-client -m
   clickhouse-client -h -p 
   clickhouse-client --qyery “”
   ```

   > - -m：命令行可以换行
   > - -h -p：可以连接远程服务
   > - --query：直接查询返回结果

7. 关闭开机自启动

   ```sh
   sudo systemctl disable clickhouse-se
   ```

006-数据类型

1. 数据类型：常用数据类型https://clickhouse.com/docs/en/sql-reference/data-types/
   - 整形
     - 整型范围：Int8、Int16、Int32、Int64
     - 无符号整型范围：UInt8、UInt16、UInt32、Uint64
   - 浮点型
     - Float32：float
     - Float64：double
   - 布尔型
     - 没有单独的类型表示布尔，可以采用Uint8类型，取值范围只有0和1
   - Decimal型：声明方式中s表示小数位
     - Decimal32(s)：相当于Decimal(9-s,s)，有效位数位1-9；
     - Decimal64(s)：相当于Decimal(18-s,s)，有效位数位1-18；
     - Decimal128(s)：相当于Decimal(38-s,s)，有效位数位1-38；
   - 字符串
     - String：表示任意长度
     - FixedString(N)：固定长度N的字符串，使用不方便
   - 枚举类型：保存string=integer的对应关系
     - Enum8：int8的数字
     - Enum16：int16的数字
   - 时间类型：
     - Date：表示年-月-日
     - DateTime：表示年-月-日 时:分:秒
     - DateTime64：表示年-月-日 时:分:秒:毫秒
   - 数组：
     - Array(T)：由T类型组成的数组，T可以说任意类型，不推荐使用多维数组
   - Nullable：空值

007-表引擎

1. 表引擎的使用：决定了如何存储表中的数据，必须在创建表的时候定义该表使用的引擎；
   - 数据存储的方式和位置，写到哪里以及从哪里读取
   - 支持查询的方式
   - 并发数据访问
   - 索引的使用
   - 是否可以执行多线程请求
   - 数据复制参数
2. 库引擎
   - MergeTree系列
   - Log系列
   - 集成引擎：连接外部数据源
3. 表引擎说明：严格区分大小写
   - TinyLog：以列文件的形式保存到磁盘，不支持索引，并且没有并发控制，一般保存少量数据的小表
   - Memory：内存引擎，数据保存在内存中，服务器重启数据消失，不支持索引，性能高
   - MergeTree：合并树，ClickHouse中最强大引擎，支持索引和分区
   - ReplacingMergeTree：
   - SummingMergeTree：

008-MergeTree

1. 简答使用：建表语句，主键可以重复的

   ```sql
   create table t_order (
       id UInt32 ,
       sku_id String,
       total_amt Decimal(16,2),
       create_time DateTime
   )engine = MergeTree
   partition by toYYYYMMDD(create_time)
   primary key (id)
   order by (id,sku_id);
   
   insert into t_order values (1,'sku_1','234.32','2021-10-17 15:50:56');
   insert into t_order values (1,'sku_2','114.32','2020-10-17 15:50:56');
   insert into t_order values (1,'sku_3','255.32','2020-10-17 12:50:56');
   ```

009-partition by 分区

1. 分区介绍
   - 作用：分区的目的主要是降低扫描的范围，优化查询速度
   - 特点：缺省只会使用过一个分区
   - 分区目录：MergeTree以列文件+所以文件+表定义文件组成，如果设定了分区，这些文件就会保存到不同的分区目录
   - 并行：分区后面对涉及分区查询统计，ClickHouse会以分区为单位并行处理
2. 数据文件
   - bin：数据文件
   - mark：标记文件，作用是索引文件和bin数据文件之间起到桥梁作用，
   - primary.idx文件：主机索引文件
   - maimax_create_time.idx文件：分区键的最大值和最小值
3. 数据写入分区合并
   - 数据写入会保存到分区文件中，根据配置文件中指定的配置会自动给讲分区文件进行合并

010-主键

1. clickhouse：主键指提供一级索引，但是不是唯一约束，
   - 主键的设定主要依据是查询语句中的where条件
   - 根据条件通过对主键进行某种形式的二分查询，可以快速定位
   - index granularity：索引粒度，指在稀疏索引中两个相邻索引对应数据的间隔，默认是8192

011-order by

1. order-by：设定了分区内的数据按照哪些字段顺序进行有序保存
   - 是MergeTree中唯一一个必填项，比主键还重要，因为当用户不设定主键时候，会根据order by的字段进行处理
   - 要求：主键必须是order by字段的前缀字段

012-二级索引

1.  添加二级索引

   ```sql
   create table t_order (
       id UInt32 ,
       sku_id String,
       total_amt Decimal(16,2),
       create_time DateTime,
     	INDEX a total_amt type minmax granularity 5
   )engine = MergeTree
   partition by toYYYYMMDD(create_time)
   primary key (id)
   order by (id,sku_id);
   
   alter table 表名 modify colume 列名 列类型 ttl 字段+interval 时间 单位
   ```

   > - INDEX 索引名称
   > - TYPE 索引类型
   > - granularity 索引粒度：是设定二级索引对于一级索引对粒度（把几个一级索引设定为一个二级索引）

013-数据TTL

1. TTL：Tome to live，MargeTree提供了可以挂历数据表或列的生命周期的功能

2. 列级别的TTL

   ```sql
   create table t_order (
       id UInt32 ,
       sku_id String,
       total_amt Decimal(16,2) TTL create_time+interval 10 SECOND,
       create_time DateTime,
     	INDEX a total_amt type minmax granularity 5
   )engine = MergeTree
   partition by toYYYYMMDD(create_time)
   primary key (id)
   order by (id,sku_id);
   ```

   > - TTL语法：TTL 日期类型字段+interval 时间 单位：TTL字段不能是主键

3. 表级别TTL：推荐使用分区字段作为表TTL

   ```sql
   alter table 表名 modify ttl 字段+interval 时间 单位
   ```

4. TTL数据转移

014-ReplacingMergeTree

1. ReplacingMergeTree是MergeTree的一个变种，存储特性完全继承MergeTree，并且多了去重功能，

   - 去重时机：数据的去重只会在合并的时候执行，而合并会在未知的时间在后台执行，是根据order by的字段去重
   - 去重范围：如果表经过了分区，去重只会在分区内部进行去重，不能执行跨分区的去重；

   ```sql
   create table t_order (
       id UInt32 ,
       sku_id String,
       total_amt Decimal(16,2),
       create_time DateTime
   )engine = ReplacingMergeTree(create_time)
   partition by toYYYYMMDD(create_time)
   primary key (id)
   order by (id,sku_id);
   ```

   > - 实际上是用order by字段作为唯一键
   > - 去重不能跨分区
   > - 只有同一批拆入获取合并分区时候才会去重
   > - 认定重复的数据保留，版本字段值最大的
   > - 如果版本字段相同则按照插入顺序保留最后一条

015-SummingMergeTree

1. SummingMergeTree适用于不查询明细，指关系以维度进行汇总聚合结果的场景，预聚合，在分片合并的时候才会聚合
   - 以SummingMergeTree指定的列作为汇总的数据列
   - 可以填写多列必须是数字列，如果不填，以所有非唯独列为数字列的字段为汇总数据列
   - 以order by的列为准，作为维度列
   - 其他的列按照插入顺序保留第一行
   - 不在一个分区的数据不会被聚合

016-开发中引擎的选择

1. 开发引擎的选择

017-sql操作

1. insert

2. update：Alter操作：Mutation语句分两步执行，同步执行的部分其实知识进行新增数据新增分区并把就数据打上逻辑失效标记，触发分区合并时候才会删除旧数据，释放空间；

   ```sql
   altel 表 update 字段=值 where 字段=条件值；
   ```

3. delete

   ```sql
   alter 表 delete where 字段=条件指；
   ```

018-sql操作-查询

1. 支持自查询
2. 支持CTE（with语句）
3. 支持各种JOIN，但是JOIN无法缓存
4. 不支持自定义函数
5. 窗口函数测试阶段中

019-sql操作-多维分析

1. 多维分析描述：使用group by的时候，根据分组字段进行多维分析

   ```sql
   group by 字段,字段
   with 分析维度;
   ```

   - rollup：上卷
   - cube：多维分析
   - total：总计

020-sql操作-alert+导出

1.  新增字段

   ```sql
   ```

2. 修改字段类型

   ```sql
   ```

3. 删除字段

   ```sql
   alter table 表 drop column
   ```

4. 导出字段

   ```sql
   ```

021-副本引擎

1. 副本：是分布式集群的数据高可用方案，没有主从副本

   ![image-20211017155816583](/Volumes/Storage/panda_code_note/note_blogs_docsify/class06_大数据全栈/part04_大数据/point05_clickhouse/imgs/image-20211017155816583.png)

2. 配置操作：加载外部文件的方式添加副本，添加文件/etc/clickhouse-server/config.d/metrika.xml

   ```xml
   <?xml version="1.0"?>
   <yandex>
   	<zookeeper-servers>
   		<node index="1">
   			<host></host>
   			<port></port>
   		</node>
        <node index="1">
   			<host></host>
   			<port></port>
   		</node>
       <node index="1">
   			<host></host>
   			<port></port>
   		</node>
   	</zookeeper-servers>
   </yandex>
   ```

3. 在/etc/clickhouse-server/config.xml中添加配置引入外部文件

   ```xml
   
   <include_form>
   	/etc/clickhouse-server/config.d/metrika.xml
   </include_form>
   ```

4. 启动zookeeper

5. 表引擎需要添加前缀：ReplacingXxx

022-分片集群

1. 分片集群：增加集群水平扩展能力

023-分片集群操作

