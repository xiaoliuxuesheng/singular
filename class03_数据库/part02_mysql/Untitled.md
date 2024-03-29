# 第一部分 基础篇

## 第一章 MySQL安装

## 1.1 数据库概述

## 1.2 Win平台下安装与配置

## 1.3 Linux平台下安装与配置

## 1.4 Mac平台下安装与配置

## 1.5 Docker容器安装与配置

## 1.6 MySQL图形化工具

# 第二章 SQL基础

## 2.1 MySQL发展历史

## 2.2 MySQL关键字与保留字

## 2.3 SQL简介

## 2.4 SQL分类



# 第三章 MySQL数据类型

## 3.1 数值类型

## 3.2 字符串类型

## 3.3 日期时间类型

## 3.4 Decimal类型

# 第四章 MySQL运算符

## 4.1 算术运算符

## 4.2 比较运算符

## 4.3 逻辑运算符

## 4.4 位运算符

## 4.5 优先级

# 第五章 常用函数

## 5.1 数值函数

## 5.2 字符串函数

## 5.3 日期时间函数

## 5.4 流程函数

## 5.5 统计函数

## 5.6 窗口函数

## 5.7 其他函数



# 第二部分 开发篇

## 第六章 表类型与存储引擎

## 第七章 字符串

## 第八章 索引

## 第九章 视图

## 9.1 视图介绍

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>MySQL从5.0.1版本开始提供视图功能；视图（view）是基于 DQL 语句的结果集而可视化的表，即视图是一个虚拟存在的表，是一个逻辑表，本身并不包含数据，作为一个select语句保存在数据字典中的；使用视图的大部分情况是为了保障数据安全性，提高查询效率，视图的优点如下：

- **简单**：使用视图的用户完全不需要关心后面对应的表的结构、关联条件和筛选条件，对用户来说已经是过滤好的复合条件的结果集。
- **安全**：使用视图的用户只能访问他们被允许查询的结果集，对表的权限管理并不能限制到某个行某个列，但是通过视图就可以简单的实现。
- **数据独立**：一旦视图的结构确定了，可以屏蔽表结构变化对用户的影响，源表增加列对视图没有影响；源表修改列名，则可以通过修改视图来解决，不会造成对访问者的影响。

## 9.2 视图的操作

> 创建视图需要有`CREATE VIEW`的权限，并且对于查询涉及的列有SELECT权限。如果使用`CREATE OR REPLACE` 或者`ALTERT`修改视图，那么还需要该视图的DROP 权限。

1. 创建视图：

   ```sql
   -- 标准语法
   CREATE [OR REPLACE] [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
   VIEW view_name [(column_list)]
   AS select_statement
   [WITH [CASCADED | LOCAL] CHECK OPTION]
   
   -- 案例
   ```

   > - 可选[OR REPLACE]：表示如果视图存在则替换为当前语句执行结果；
   > - 可选[ALGORITHM]：是对标准SQL的MySQL扩展，默认值是UNDEFINED，选项如下：
   >   - UNDEFINED：由MySQL选择所要使用的算法；
   >   - MERGE：会将引用视图的语句的文本与视图定义合并起来，使得视图定义的某一部分取代语句的对应部分；
   >   - TEMPTABLE：视图的结果将被置于临时表中，然后使用它执行语句；
   > - 可选WITH {} CHECK OPTION：是否允许更新数据使记录不再满足视图的条件，默认是CASCADED
   >   - LOCAL：是只要满足本视图的条件就可以更新；
   >   - CASCADED：则是必须满足所有针对该视图的所有视图的条件才可以更新。

2. 修改视图：

   ```sql
   -- 标准语法
   ALTER [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}]
   VIEW view_name [(column_list)]
   AS select_statement
   [WITH [CASCADED | LOCAL] CHECK OPTION]
   ```

   > - 可选参数说明同上

3. 删除视图：必须有每个表的DROP权限

   ```sql
   -- 标准语法
   DROP VIEW [IF EXISTS] view_name [, view_name] ...[RESTRICT | CASCADE]
   
   -- 案例
   ```

   > - 可选[IF EXISTS]：表示如果存在则删除；
   > - 默认RESTRICT：表示删除是有限制条件的，该视图不能被其他表的约束所引用（如CHECK，FOREIGN KEY等约束），不能有触发器，不能有视图，不能有函数和存储过程等。如果该表存在这些依赖的对象，此表不能删除。
   > - CASCADE：表示该表的删除没有限制条件，在删除视图的同时，相关的依赖对象将会被一起删除。

4. 查看视图：

   ```sql
   -- 标准语法
   SHOW CREATE VIEW view_name
   ```

## 9.3 视图实践

在web+mysql设计中，由于追求高伸缩性，不依赖于数据库本身实现，一般不使用视图来做数据查询，也就是web程序拼好sql字符串，让数据库执行。这样业务逻辑在程序中，方便调试，测试，修改，分布式运行。在web+mysql设计中，如果支持多种数据库，这个是ORM或类似mybatis配置来实现的，不用每个数据库写一个视图查询，做到了低耦合。低耦合，也就是不和具体数据库绑死。mysql视图可以镜像表，如a数据库镜像一个b数据库中表，可以在这个视图个和表一样操作增加删除修改，这个功能在一些系统设计中是有用的，如我在b数据库中做开发，可以镜像a数据库中的表过来，不用每次手工同步，上线时直接指向a数据库。如果你做一些数据分析或数据仓库查询，可以使用视图，这样不用写程序和写sql来实现。有的管理工具有视图创建工具，可以做可视化设计，提高工作效率。

视图方法可以“简化”查询逻辑并使查询看起来简单。然而，如果多表查询的性能较差，则很难找到view方法的性能瓶颈。所以优化的本质不会改变。它是建立在资源平衡的基础上的。简化并不能解决性能问题。

## 第十章 存储过程与函数

## 第十一章 触发器

## 第十章 事物与锁





# 第三部分 优化篇

# 第四部分 管理篇





