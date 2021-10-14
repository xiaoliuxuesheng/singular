001-课程介绍

1. 课程大纲
   - 第一章 入门
     - 1.1 基本概念
     - 1.2 运行环境配置
     - 1.3 Hadoop运行模式
     - 1.4 
   - 第二章 HDFS
   - 第三章 MapReduce
   - 第四章 Yarn
   - 第五章 生产调优
   - 第六章 源码解析

002-大数据概念

1. 大数据概念：百科定义概念解释；指TB/PB/EB级别的数据；大数据技术指的是存储/管理/分析的数据；

003-大数据特点

1. 大数据特点：
   - Volume（大量）
   - Velocity（高速）：海量数据实时分析/计算
   - Variety（多样）：结构化数据（数据库）和非结构化数据（日志等等）
   - Value（低价值密度）：

004-大数据应用场景

1. 应用场景
   - 如：抖音推荐
   - 如：电商商品推荐
   - 如：零售运营分析
   -  如：仓储物流成本分析
   -  如：保险/金融/房产
   -  人工智能发展。物联网技术落地

005-大数据发展前景

1. 发展前景
   - 国家发展方向：互联网。大数据。人工智能与实体经济融合；新基建投资
   - 5G技术发展：为6G做铺垫
   - 大数据在2017开设大数据课程，落地技术成熟，人才紧缺

006-未来工作内容

1. 大数据部门业务流程
   - 产品人员需要对生产数据进行分析
   - 运营人员对市场分析
2. 大数据部门内部组织
   - 平台组：负责整个集群的搭建，监控，性能控制
     - Hadoop、Flume、Kafka、HBase、Spark等框架平台搭建
     - 集群性能监控
     - 集群性能调优
   - 数据仓库组：
     - ETL工程师：数据清洗
     - 数据分析、数据仓库建设
   - 实施组：
     - 实时指标分析：性能调优
   - 数据挖掘组：
     - 算法工程师
     - 推荐系统工程师
     - 用户画像工程师
   - 报表开发组：
     - JavaEE工程师
     - 前端工程师

007-Hadoop入门-概述

1. Hadoop入口
   - 概念
     - 是什么
     - 发展历史
     - 三大发行版本
     - 优势
     - 组成
     - 大数据生态
     - 大数据系统架构
   - 环境准备
     - 模版虚拟机准备、机器克隆
     - 安装JDK
   - Hadoop生产集群
     - 本地模式
     - 生产集群
   - 常见错误

008-Hadoop是什么

1. Hadoop是什么
   - Apache基金会分布式基础架构：Hadoop主要解决海量数据的存储和海量数据的分析计算
   - Hadoop通常是指Hadoop生态圈：ZooKeeper、Hive、Habase等等

009-Hadoop发展历史

1. 发展历史
   - 为了实现与谷歌类似的全文检索功能，在Luence基础上优化升级
   - 2001年低Lucene成为Apache子项目：对于海量数据，面对和Google同样的困难：海量数据存储和检索；
   - 学习和模仿Google解决办法：微型版 Nutch（Google大数据论文：GFS-》HDFS、MapReduce-》MR、BigTable-》HBase）
   - 2003-2004 Google公开了GFS和MapReduce细节：Doug以此为基础实现了DFS和MapReduce机制，Nutch性能飙升
   - 2005年Hadoop作为Lucene的子项目引入Apache基金会
   - 2006年3月：MapReduce和Nutch Distributed File System分别被纳入到Hadoop项目中，Hadoop项目诞生，标志着大数据时代来临

010-Hadoop发布版本

1. 发布版本
   - Apache：最原始，最基础的版本，适用于入门学习
     - 2021年以后所有版本都需要收费
   - Cloudera：内部集成了很对大数据框架，对应产品是CDH
     - 2008年这个公司在Apache基础上对Hadoop进行封装，整合管理界面，做到配置可视化，并集成大数据框架
   - Hortonworks：文档好，对应产品HDP，现已被Cloudera公司收购推出新的品牌CDP
     - 2011年这个公司也开始做同样的产品，后来强强合作

011-Hadoop优势

1. 优势
   - 高可靠性：Hadoop底层维护多个数据副本，数据不回丢失
   - 高扩展性：在集群分配任务数据，可方便扩展节点
   - 高效性：Hadoop并行工作，加快任务处理
   - 高容错性：可以将失败的任务重写分配

012-Hadoop1，2，3区别

1. 区别
   - 1.x：Common（辅助工具）、HDFS（数据存储）、MapReduce（计算+资源调度）
   - 2.x：Common（辅助工具）、HDFS（数据存储）、MapReduce（计算）、Yarn（资源调度）
   - 3.x：在组成方面和2.x没有区别，在2.0基础上做优化

013-HDFS概述

1. Hadoop Distributed File System：HDFS是一个分布式文件系统

   - NameNode（nn）：存储文件的元数据，如文件名，文件目录，文件属性，以及每个文件的块列表和块所在的DataNode

   - DataNode（dn）：在本地文件系统存储文件的块数据。以及块数据的校验和

   - Secondary NameNode（2nn）：每隔一段时间对NameNode元数据备份

     ![image-20211014224325144](/Volumes/Storage/panda_code_note/note_blogs_docsify/class06_大数据全栈/part04_大数据/part02_hadoop/imgs/part02_hadoop/image-20211014224325144.png)



