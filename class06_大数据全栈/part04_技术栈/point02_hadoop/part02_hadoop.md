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

     ![image-20211014224325144](/Volumes/Storage/panda_code_note/note_blogs_docsify/class06_大数据全栈/part04_大数据/part02_hadoop/imgs/image-20211014224325144.png)

014-yarn概述

1. Yarn：Yet Another Resource Negotiator是一种资源协调者
   - Resources Manager（RM）：所有集群的服务器中资源的管理者
   - Node Manager（NM）：单节点的资源管理者
   - Application Master（AM）：单个任务的老大，可以向RM申请资源，
   - Container：容器，相当于一台独立的服务器，任务运行在容器中；容器中任务可以夸节点执行； 每个NM上可以有多个Container，并且Container资源之和不能大于NodeManager所拥有的资源 
   - Client：作业提交任务，运行在Container容器中，每个容器中的任务都由该容器中的Application Manager管理，

![image-20211016081546534](/Volumes/Storage/panda_code_note/note_blogs_docsify/class06_大数据全栈/part04_大数据/part02_hadoop/imgs/image-20211016081546534.png)

015-MapReduce

1. MapReduce架构概述：将计算过程分为两个阶段：Map和Reduce
   - Map阶段：并行处理输入数据
   - Reduce阶段：对Map结果进行汇总
2. 任务案例：100T的资源存储在分布式的文件服务器中，资源管理器告诉每个服务器要找的资源，每个服务器把检索结果返回给资源管理器，完成资源的检索；

016-HDFS-YARN-MapReduce三者关系

1. 基本运行流程

   - Client发出请求：要求在集群服务器中查询服务器中的指定资源
   - ResourcesManager：收到请求，RM找一台节点，该节点Container中的APPMaster开启一个任务
   - APPMaster向RM进行资源申请，RM把有资源的节点进行分配，节点中的Container开启MapTask
   - 查询出结果汇总写入到HDFS，

   

   ![image-20211016082700338](/Volumes/Storage/panda_code_note/note_blogs_docsify/class06_大数据全栈/part04_大数据/part02_hadoop/imgs/image-20211016082700338.png)

017-大数据技术生态体系

1. 大数据技术生态体系

   - 数据来源层：三种数据来源
   - 数据传输层：大数据框架处理数据的框架
   - 数据存储层：数据接受完成后进行数据的存储
   - 资源管理层：资源调度
   - 数据计算层：实时计算和离线计算，并且可以数据查询
   - 任务调度层：定时执行
   - Zookeeper：整个数据平台的配置和调度
   - 业务模型层：业务模型的课可视化

   ![image-20211016083337923](/Volumes/Storage/panda_code_note/note_blogs_docsify/class06_大数据全栈/part04_大数据/part02_hadoop/imgs/image-20211016083337923.png)

2. 框架概述

3. 推荐系统架构图

   ![image-20211016083744197](/Volumes/Storage/panda_code_note/note_blogs_docsify/class06_大数据全栈/part04_大数据/part02_hadoop/imgs/image-20211016083744197.png)

018-Vmware安装

1. 基本搭建逻辑
   - 安装虚拟机软件，搭建一台模版虚拟机，然后根据模版虚拟机克隆出集群机器
   - 虚拟机基本环境：硬盘=50G、内存4G、IP=静态、主机名称
   - 安装环境：VMware+CentOS+SSH工具

019-安装CentOS

1. 安装注意事项
   - 安装硬件：处理器不能大于宿主机（处理器=2、内核数分配）、内存=2G、NAT网络模式、硬盘=50G
   - 安装软件：中文、日期和时间、软件选择（桌面安装可以切换到窗口版）、安装位置分配分区、不启用kdump、开启网络、主机名称修改、root密码=root、
     - /boot=1G + est4
     - swap=4G
     - /=45G

020-配置IP

1. 配置IP

   - VM  IP配置：子网IP=192.168.10.0、子网掩码=255.255.255.0、网关=192.168.10.2

   - 宿主机IP配置VmNet8：子网IP=192.168.10.1、子网掩码=255.255.255.0、网关=192.168.10.2、DNS=192.168.10.2、备用DNS=8.8.8.8

   - 虚拟机静态IP：su root

     - vim /etc/sysconfig/network-scripts/ifcfg-ens33
       - BOOTRPROTO=“static”
       - 文件尾部
         - IPADDR=192.168.10.100
         - GATEWAY=192.168.10.2
         - DNS1=192.168.10.2
     - 主机名称：vim /etc/hostname
       - hadoop100

   - 主机名称映射：宿主机和虚拟机修改host：linux=/etc/hosts

     ```txt
     10.211.55.100 hadoop100
     10.211.55.201 hadoop201
     10.211.55.202 hadoop202
     10.211.55.203 hadoop203
     10.211.55.204 hadoop204
     10.211.55.205 hadoop205
     10.211.55.206 hadoop206
     10.211.55.207 hadoop207
     10.211.55.208 hadoop208
     ```

021-远程访问工具

022-模版虚拟机环境配置

1. 红帽系列软件包

   ```sh
   yum install -y epel-release
   ```

2. Linux工具包

   ```sh
   yum install -y net-tools
   yum install -y vim
   ```

3. 关闭防火墙

   ```sh
   systemctl stop firewalld
   systemctl disable firewalld.service
   ```

4. 切换root免密

   ```sh
     vim /etc/sudoers
   
   
   %wheel  ALL=(ALL)       ALL
   # 在这行后面添加一行
   panda   ALL=(ALL)       NOPASSWD: ALL
   ```

5. 目录初始化：

   ```sh
   # 切换用户到panda
   su panda
   
   # 新建目录
   sudo mkdir module
   sudo mkdir software
   # 更改目录所属用户
   sudo chown panda:panda module/ software/
   ```

6. 卸载内置的JDK

   ```sh
   rpm -qa | grep i java | xargs -n1 rpm -e --nodeps
   ```

7. 重启虚拟机：

023-克隆虚拟机

1. 虚拟机克隆：hadoop201，hadoop202，hadoop203（修改主机名称和IP）

024-安装JDK

1. 目录说明：modules上软件安装目录、software上软件包保存目录

2. 解压并移动到module中

3. 配置环境变量：一切配置环境变量是/etc/profile文件中，该目录中可以读取/etc/profile.d/*.sh文件，所以自定义变量都保存到这里

   ```sh
   sudo vim /etc/profile.d/panda_env.sh
   
   export JAVA_HOME=/opt/module/jdk8
   export PATH=$PATH:$JAVA_HOME/bin
   export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
   ```

025-hadoop安装

1. 安装目录解压

2. 环境变量配置

   ```sh
   export HADOOP_HOME=/opt/module/hadoop3
   export PATH=$PATH:$HADOOP_HOME/bin
   export PATH=$PATH:$HADOOP_HOME/sbin
   ```

3. Hadoop软件目录

   - bin
     - hdfs
     - yarn
     - mapped
   - etc
     - hdfs-site.xml
     - mapped-site.xml
     - yarn-site.xml
     - workers
   - sbin
     - start-dfs
     - start-yarn
     - mr-jobhistory-daemond
   - share：官方提供案例

   026-Hadoop运行模式

   1. 运行模式：
      - 本地模式：指单台服务器上搭建的单机版Hadoop，但是数据存储在Linux本地
      - 伪分布式模式：是在单单服务器，数据存储在H DFS上
      - 完全分布式模式：多台主机组成的服务器集群 
   2. 单机模式演示

   027-完全分布式搭建

   1. 环境搭建步骤

      - 3台虚拟机
      - 安装JDK，配置环境变量
      - 安装Hadoop，配置环境变量
      - 配置集群
      - 单点启动
      - 配置ssh
      - 群起并测试集群

   2. 编写集群分发脚本

      - scp：实现服务器与服务器之间的数据拷贝

        ```sh
        scp -r $parent_dir/$file_name $user@$host:$parent_dir/$file
        
        # 案例
        scp -r /opt/module/jdk8 panda@hadoop202:/opt/module/jdk8
        scp -r panda@hadoop201:/opt/module/jdk8 /opt/module/jdk8
        ```

        > - -r：递归
        > - 源文件
        > - 目标服务器文件目录

      - rsync：远程同步工具，用户备份和镜像。特点是速度快，避免复制相同内容和支持符号链接的 特点，与scp比较同步只对有差异的文件做更性，cp是全量拷贝；

        ```sh
        rsync -av $parent_dir/$file_name $user@$host:$parent_dir/$file
        ```

        > -a：归档拷贝
        >
        > -v：显示复制过程

   028-自定义分发脚本

   1. 自定义分发脚本：同步文件定义在目录中：/home/panda/bin/

      ```sh
      #/bin/bash
      # 1. 判断参数个数
      if [ $# -lt 1 ]
      then 
      	echo '参数错误！'
      	exit；
      fi
      
      # 2. 遍历集群所有机器
      for host in hadoop201 hadoop202 hadoop203
      do
      	echo ======同步主机名=$host
      	# 3.遍历所有目录，挨个发送
      	for file in $@
      	do
      		# 4. 判断文件是否存在
      		if [ -e $file ]
      			then
      				# 5. 父目录 
      				pdir=$(cd -P $(dirname $file); pwd)
      				
      				# 6. 文件名称
      				fname=$(basename $file)
      				ssh $host "mkdir -p $pdir"
      				rsync -av $pdir/$fname $host:$pidr
      			else
      				echo ======$file 不存在！
      		fi
      	done
      done
      ```

   2. sudo执行需要使用命令文件的绝对路径

029-ssh免密登陆

1. 现在A服务器生成公钥和私钥，然后将公钥保存到B服务器中授权的目录中，然后通过ssh访问B服务器用私钥加密，B服务器用公钥进行解密

2. 服务器A生成公钥对

   ```sh
   ssh-keygen -t rsa
   ```

3. 将公钥拷贝到B服务器

   ```sh
   ssh-copy-id 主机名
   ```

4. 每个用户都需要配置免密登陆

030-集群配置

1. 集群配置基本规划：NameNode和ResourcesManager和SecondaryManager不要放到一个服务器中

   |      | hadoop201                  | hadoop202                            | hadoop203                          |
   | :--: | -------------------------- | ------------------------------------ | ---------------------------------- |
   | HDFS | **NodeName**<br />DataNode | DataNode                             | **SecondaryManager**<br />DataNode |
   | YARN | NodeManager                | **ResourceManager**<br />NodeManager | NodeManager                        |

2. 配置文件说明：Hadoop配置文件分两类：默认配置文件和自定义配置文件，只有用户想修改某一默认配置值时，才需要修改自定义配置文件，更改相应属性

   | 默认配置文件       | 目录                  |
   | ------------------ | --------------------- |
   | core-default.xml   |                       |
   | hdfs-default-xml   |                       |
   | yarn-default.xml   |                       |
   | mapred-default.xml |                       |
   | **自定义配置文件** | **目录：/etc/hadoop** |
   | core-site.xml      |                       |
   | Hfs-site.xml       |                       |
   | yarn-site.xml      |                       |
   | mapred-site.xml    |                       |

3. 配置集群：根据集群规划配置对应的各种节点和管理器

   - core-site.xml：NameNode

     ```xml
     <?xml version="1.0" encoding="UTF-8"?>
     <?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
     <configuration>
       <!-- hadoop201: NameNode -->
       <property>
         <name>fs.defaultFS</name>
         <value>hdfs://hadoop201:8020</value>
       </property>
     
       <!-- hadoop201: 数据存储目录 -->
       <property>
         <name>hadoop.tem.dir</name>
         <value>/opt/module/hadoop3/data</value>
       </property>
     
       <!-- 配置HDFS网页登陆使用的静态用户为panda -->
       <property>
         <name>hadoop.http.staticuser.user</name>
         <value>panda</value>
       </property>
     </configuration>
     
     ```

   - hdfs配置文件：hfs-site.xml

     ```xml
     <?xml version="1.0" encoding="UTF-8"?>
     <?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
     <configuration>
       <!-- NameNode web访问地址 -->
       <property>
         <name>dfs.namenode.http-address</name>
         <value>hadoop201:9870</value>
       </property>
     
       <!-- 2nn web端口访问 -->
       <property>
         <name>dfs.namenode.secondary.http-address</name>
         <value>hadoop203:9868</value>
       </property>
     </configuration>
     
     ```

   - yarn-site.xml

     ```xml
     <?xml version="1.0"?>
     <configuration>
     
       <!-- 指定MR 走shuffle -->
       <property>
         <name>yarn.nodemanager.aux-services</name>
         <value>mapreduce_shuffle</value>
       </property>
     
       <!-- 指定resourcesManger地址 -->
       <property>
         <name>yarn.resourcemanager.hostname</name>
         <value>hadoop202</value>
       </property>
     
       <!-- 环境变量继承 -->
         <property>
           <name>yarn.nodemanager.evn-whitelist</name>
           <value>JAVA_HOME,HADOOP_COMMON_HOME,HADOOP_HDFS_HOME,HADOOP_CONF_DIR,CLASSPATH_PREPEND_DISTCACHE,HADOOP_YARN_HOME,HADOOP_MAPRED_HOME</value>
         </property>
       -->
     </configuration>
     ```

   - mapred-site.xml

     ```xml
     <?xml version="1.0"?>
     <?xml-stylesheet type="text/xsl" href="configuration.xsl"?>
     <configuration>
       <!-- 指定MapRed运行在Yarn上 -->
       <property>
         <name>mapreduce.framework.name</name>
         <value>yarn</value>
       </property>
     </configuration>
     
     ```

   031-集群启动

   1. 配置workers：文件中不允许有空格和空行

   2. 并同步到其他服务器

   3. 启动集群：需要在Hadoop第一个节点格式化Name Node，格式化NameNode回产生新的集群ID，导致NameNode和DataNode集群ID不一致，集群找不到自己的数据，如果集群在运行过程中报错，需要重新格式化Name的话，一定要先停止namenode和datanode的进程，冰山删除机器所有的data和logs目录，再进行格式化

      ```sh
      # 格式化
      hdfs namenode -format
      
      # 启动hefs
      /sbin/start-dfs.sh
      
      # 配置RM节点的启动yarn
      /sbin/start-yarn.sh
      ```

   4. WEB查看HSFS：http://hadoop201:9870

   5. WEB查看YARN：http://hadoop202:8088







