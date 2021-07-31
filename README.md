> 
>
> git remote add github https://github.com/xiaoliuxuesheng/singular.git 

# [class00_办公软件](class00_办公软件/class00_办公软件.md)

- <font size=5>[part01_office](class00_办公软件/part01_office/part01_office.md)</font>
  - [part01_office](class00_办公软件/part01_office/part01_office.md)
  - [part02_ui](/class00_办公软件/part02_ui/part02_ui.md)
  - [part03_notebook](/class00_办公软件/part03_notebook/part03_notebook.md)
    - [point01_gitbook](class00_办公软件/part03_notebook/point01_Gitbook/point01_gitbook.md)
    - [point02_hexo](class00_办公软件/part03_notebook/point02_hexo/point02_hexo.md)
    - [point03_docsify](class00_办公软件/part03_notebook/point03_Docsify/point03_Docsify.md)
  - [part04_uml](/class00_办公软件/part04_uml/part04_uml.md)
- <font size=5>[part02_ui](/class00_办公软件/part02_ui/part02_ui.md)</font>
- <font size=5>[part03_notebook](/class00_办公软件/part03_notebook/part03_notebook.md)</font>
- <font size=5>[part04_uml](/class00_办公软件/part04_uml/part04_uml.md)</font>

# [class01_学前必备](class01_学前必备/class01_学前必备.md)

- <font size=5>[part01_计算机组成](/class01_学前必备/part01_计算机组成/part01_计算机组成.md)</font>
- <font size=5>[part02_计算机操作系统](/class01_学前必备/part02_计算机操作系统/part02_计算机操作系统.md)</font>
- <font size=5>[part03_计算机网络原理](/class01_学前必备/part03_计算机网络原理/part03_计算机网络原理.md)</font>

# [class02_java全栈](class02_java全栈/class02_java全栈.md)

- <font size=5>[part01_java基础](/class02_java全栈/part01_java基础/part01_java基础.md)</font>
- <font size=5>[part02_java高级](/class02_java全栈/part02_java高级/part02_java高级.md)</font>
- <font size=5>[part03_自动化构建](/class02_java全栈/part03_自动化构建/part03_自动化构建.md)</font>
- <font size=5>[part04_javaEE开发](/class02_java全栈/part04_javaEE开发/part04_javaEE开发.md)</font>
- <font size=5>[part05_java核心框架](/class02_java全栈/part05_java核心框架/part05_java核心框架.md)</font>
- <font size=5>[part06_java工具集](/class02_java全栈/part06_java工具集/part06_java工具集.md)</font>
- <font size=5>[part07_微服务技术栈](/class02_java全栈/part07_微服务技术栈/part07_微服务技术栈.md)</font>
- <font size=5>[part08_后端架构技术整理](/class02_java全栈/part08_后端架构技术整理/part08_后端架构技术整理.md)</font>

# [class03_数据库](class03_数据库/class03_数据库.md)

- <font size=5>[part01_oracle](/class03_数据库/part01_oracle/part01_oracle.md)</font>
- <font size=5>[part02_mysql](/class03_数据库/part02_mysql/part02_mysql.md)</font>
- <font size=5>[part03_redis](/class03_数据库/part03_redis/part03_redis.md)</font>
- <font size=5>[part04_mongodb](/class03_数据库/part04_mongodb/part04_mongodb.md)</font>

#  [class04_产品开发](class04_产品开发/class04_产品开发.md)

- <font size=5>[part01_产品基础](/class04_产品开发/part01_产品基础/part01_产品基础.md)</font>
  - [part01_产品基础](/class04_产品开发/part01_产品基础/part01_产品基础.md)
  - [part02_产品设计](/class04_产品开发/part02_产品设计/part02_产品设计.md)
- <font size=5>[part02_产品设计](/class04_产品开发/part02_产品设计/part02_产品设计.md)</font>

# [class05_前端全栈](class05_前端全栈/class05_前端全栈.md)

- <font size=5>[part01_前端基础](/class05_前端全栈/part01_前端基础/part01_前端基础.md)</font>
- <font size=5>[part02_前端进阶](/class05_前端全栈/part02_前端进阶/part02_前端进阶.md)</font>
- <font size=5>[part03_前端框架](/class05_前端全栈/part03_前端框架/part03_前端框架.md)</font>
- <font size=5>[part04_工具扩展](/class05_前端全栈/part04_工具扩展/part04_工具扩展.md)</font>

# [class06_大数据](class06_大数据全栈/class06_大数据全栈.md)

- <font size=5>[part01_linux](/class06_大数据全栈/part01_linux/part01_linux.md)</font>
- <font size=5>[part02_docker](/class06_大数据全栈/part02_docker/part02_docker.md)</font>
- <font size=5>[part03_技术栈](/class06_大数据全栈/part03_技术栈/part03_技术栈.md)</font>
- <font size=5>[part04_大数据](/class06_大数据全栈/part04_大数据/part04_大数据.md)</font>

# 面试整理

## 001_Redis面试题

1. Redis有哪些数据类型
   - String、List、Set、ZSet、Hash
2. 什么是Redis的持久化
   - RDB：是Redis默认的持久化方式，按照一定的时间把内存的数据用快照的方式保存到磁盘；
   - AOP：是把Redis执行的写命令记录到文件中，Redis会优先选择AOF恢复
3. Redis过期键的删除策略
   - 定时过期：每个设置过过期时间的key会创建对应的定时器，到期就清除；会占用CPU资源处理过期数据
   - 惰性过期：访问key的时候才会判断是否过期，过期则清除；过期的数据任然在内存中；
   - 定期清理：每隔一段时间，扫描数据库中的key；
4. 为什么Redis效率高
   - 纯内存操作
   - 核心是基于非阻塞的IO多路复用
   - 单线程避免线程之间切换的损耗

## 002_MySQL面试

## 003_Spring

1. Spring项目添加事物的方式
   - 使用在Spring Beand的方法上@Transactional注解：事物粒度比较大，只能控制整个方法；
   - TransactionTemplate：在execute方法方法中执行事物，事物粒度小，执行单条SQL，但是不能设置事物属性；
   - PlatformTransactionManager通过TransactionDefinition获取到TransactionStatus：执行完成后commit，执行失败后rollback，，事物粒度小，执行单条SQL，并且可以设置事物属性；
2. 事物嵌套
   - 

# 架构

1. 高并发相关理论
   - 瓶颈分析
   - CPA理论
2. 高并发技术
   - 流量网关：全局流量控制、日志统计、SQL注入、web攻击、黑名单控制、
   - 业务网关：安全、权限、路由、过滤、流控、缓存、服务路由、业务聚合
   -  