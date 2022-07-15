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

# [class04_产品开发](class04_产品开发/class04_产品开发.md)

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

### ▲ 事务的四大特性

1. A（Atomic）：原子性，事务中的操作要不全部成功，要不全部失败；
2. C（Consistency）：一致性，在事务执行前后，数据保持一致
3. I（Isolation）：事务并发访问数据库，事务直接不会相互干扰；
4. D（Durability）：持久性，事务提交后，对数据库中数据的改变是永久的；

### ▲ MySQL事务隔离级别

1. 未提交读：其他事务可以看到本事务没有提交的修改，如果本事务回滚会造成脏读；
2. 已提交图：其他事务只能读到本事务已提交的部分，有不可重复读的问题：因为同一个事务内两次读取拿到的结果可能不一样；
3. 可重复读：是MySQL默认的隔离级别，指同一个事务中多次读的数据是一致的，
4. 串行读：串行执行事物；

### ▲ MySQL的SQL执行步骤

1. 连接器：管理连接，权限验证；
2. 查询缓存：默认是关闭的，命中缓存返回结果；
3. 分析器：解析SQL语法
4. 优化器：生成执行计划，选择索引
5. 执行器：执行优化后的SQL，调用存储引擎获取数据，返回结果

## 003_Spring

### ▲ 事务传播机制

- 事务传播机制是指：多个事务方法间调用时，事务在这些方法中的作用方式
  1. required（默认）：如果上下文中有事务了，就加入到事务中执行，如果当时上下文中不存在事务，则新建事务；
  2. supports（支持事务）：是指运行环境中有事务就运行在事务中，否则以非事务运行；
  3. mandatory（强制）：是指只能运行在已有的事务环境中，如果当前事务不存在会抛异常；
  4. requires_new（新事务）：事务方法运行需要新建一个事务，并且将上下文中事务挂起，当前事务执行完成后，上下文事务再恢复执行；
  5. not_supported（不支持事务）：当方法运行在事务环境时，会暂停已开启的事务，并且当前方法以非事务方式运行完毕后，再继续执行上下文中的事务
  6. never（永远不）：不能运行在事务中，如果运行在事务中抛出异常；
  7. nested（嵌套事务）：如果上下文中存在事务，则运行在事务中，如果不存在事务，则新建事务；

### ▲ Spring事务失效

- Spring事务在使用@Transactional注解事务失效的原因是AOP不起作用
  1. 方法不是public的
  2. 方法属于当前类自调用
  3. 数据库不支持事务
  4. 当前方法所在类不是Spring的Bean
  5. 默认回滚RuntimeException，如果异常被catch或者不属于RuntimeException就会失效

### ▲ SpringMVC工作流程

1. 客户端发送请求到前端控制器：DispatcherServlet
2. 前端控制器（DispatcherServlet）将请求发送给处理器映射器：HandlerMapping，处理器映射器（HandlerMapping）会根据请求，找到对应的处理器，封装为执行器链（HandlerExecutionChain）并返回给前端控制器；
3. 前端控制器根据执行器链中的处理器，找到可以执行改处理器的适配器，调用具体的处理器（Controllers），并返回ModelAndView；
4. 前端控制器根据ModelAndView交给视图解析器（ViewREslover），返回具体View；
5. 前端控制器根据View进行渲染视图，封装数据交给前端控制器并相应给客户端；

### ▲Spring启动流程

1. 首先是读取配置文件，解析出来需要加载到Spring中的Bean的信息封装成BeanDefinition（有不同的实现，解析xml、Java主键，yaml等等）
2. Spring中BeanFactory的作用就是通过 解析BeanDefinition，通过反射创建出Bean的实例对象，添加到IOC容器中，但是BeanDefinition交给BeanFactory之前，Spring还可以通过BeanFactoryPostProcessor对BeanDefinition进行修改；
3. BeanFactory拿到修改后的BeanDefinition后，就开始实例化Bean了，实例化过程：
   - 第一步：反射创建未初始化的对象；
   - 第二步：初始化对象，给属性赋值：三级缓存解决循环依赖，为属性赋值；
   - 第三步：通过Aware接口，对对象进行功能扩展；
   - 第四步：通过BeanPostProcessor，在执行init方法前后执行接口中的两个方法；
   - 第五步：创建完整对象完成，销毁对象之前执行销毁方法；

### Spring三级缓存

1. Spring项目添加事物的方式
   - 使用在Spring Beand的方法上@Transactional注解：事物粒度比较大，只能控制整个方法；
   - TransactionTemplate：在execute方法方法中执行事物，事物粒度小，执行单条SQL，但是不能设置事物属性；
   - PlatformTransactionManager通过TransactionDefinition获取到TransactionStatus：执行完成后commit，执行失败后rollback，，事物粒度小，执行单条SQL，并且可以设置事物属性；

## 004_SpringCloud

### 005_JVM

# 架构

1. 高并发相关理论
   - 瓶颈分析
   - CPA理论
2. 高并发技术
   - 流量网关：全局流量控制、日志统计、SQL注入、web攻击、黑名单控制、
   - 业务网关：安全、权限、路由、过滤、流控、缓存、服务路由、业务聚合