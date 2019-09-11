# 前言

## 1. 主流行业介绍

- 第一步 应该干什么 ?   产品经理
- 第二 设计类方向   : 原型图   UI交互 视觉    美感   色感    
- 第三 开发方向 : 前端开发  后端开发   大数据开发
- 第四 运维方向 : Linux  云计算
  - 技术淘汰速度慢
- 第五 网络 方向   安全

## 2. 行业中的Linux

- 开源 免费
- 安全 稳定
- 最适合服务器

## 3. 市场技术需求

## 4. 运维行业发展

- ① Linux运维工程师
- ② Linux高级运维工程师
- ③ Linux开发工程师
- ④ 数据库运维工程师
- ⑤ 云计算运维架构师

# 001~004 : Unix简介

:anchor: Linux 和 Unix发展史

- Unix的起始 : 常见版本 AIX(IBM)   UX(HP)  Solaris(SUN)
- Linux的发展
    - Redhat : Redhat系列RHEL(Redhat Enterprise Linux也就是所谓的Redhat Advance Server，收费版本
    - CentOS : Redhat砍掉收费功能的版本  社区克隆版本，免费
    - Fedora : RedHat新功能试验版本  由原来的Redhat桌面版本发展而来，免费版本
    - Debian : Debian系列  是迄今为止最遵循GNU规范的Linux系统
    - Ubuntu :  基于Debian的unstable版本加强而来 , 太新 不适合服务器, 适合个人开发
    - Manjaro

:anchor: 开源软件简介

> 使用自由
>
> 研究自由
>
> 散布改良自由

- Apache
- Nginx
- MySQL  Oracle   SQLServer
- PHP
- Samba : Linux和Windows之间内网文件服务器
- MongoDB
- Redis
- Python : 脚本语言
- Ruby : 脚本语言 小日本
- Sphinx : 中文分词

:anchor: Linux应用领域

- 服务器领域
- 嵌入式

# 005~010 : Linux安装

:anchor:  VMware虚拟机安装

- VMware特点
    - 模型硬件坏境的虚拟机系统
    - 镜像的管理
    - 克隆虚拟机 : 创建链接克隆
- CentOS最小内存需求 : 628M(小于则会开启简易安装)
- 虚拟机网络设置
    - 桥接 : 用本地真实网卡和虚拟机通讯 【可以任意通信】  设置 》 虚拟网络编辑 》 桥接网卡
    - NET : 虚拟机时候虚拟网卡通讯虚拟网卡 8  【外部计算机不能喝虚拟机通讯， 通过主机连接公网】
    - 仅主机模式 : 使用虚拟网卡1 通讯 【只可以 和主机通讯】

:anchor: 系统分区

- 磁盘分区 : 将磁盘划分为多个逻辑部分, 不同类的目录和文件可以存储进不同的分区

- **分区表形式**

    - MBR分区表 : 主引导记录分区, 最大支持2.1TB  最多支持4个分区
    - GPT分区表 : 全局唯一标识分区表 , 支持 9.4ZB

- 分区类型

    - 主分区 : 最多只能有4个
    - 扩展分区 : ,最多只有一个, 主分区加扩展分区最多有四个, 只能包含逻辑分区
    - 逻辑分区 : 

- 格式化 : 逻辑格式化, 根据用户选定的文件系统, 在磁盘特定区域写入特定数据

    - Windows : NTFS

    - Linux : EXT4 和 XFS

        > 文件大小 - 文件读取速度

- EXT4 格式化原理

    - 将分区分为 **数据区**:保存数据 - 分为等大小的blog=4k,存取数据的最小单位, 文件大小和占用大小不一定相同,不一定是顺序存储的 **索引区** : Inode : 128字节, 文件id号 + 时间 + 权限 + 文件地址

- 设备文件和挂载点

    - 分区设备文件名

        - /dev/hda1   = IDE硬盘接口

        - /dev/sda1   = SCSI硬盘接口  +  **SATA硬盘接口**   

            ````sh
            格式 : sd:表示接口类型sd口    a:表示第几块硬盘   1:表示该硬盘的第几个主分区  或逻辑分区
            # 逻辑分区从5开始
            ````

    - 挂载点 : 盘符 使用已经存在的空目录作为挂载点(一个盘符对应一个分区)       挂载分区

- 挂载 : 

    - 必须分区 : 

        - / 根分区   :   15G
        - swap 分布区 交互分区 , 虚拟内存,真实机内存不够时临时做为内存,, nor大小是内存的一倍到两倍(大于2G)

        - /boot  : 启动分区  : 1G

    - 常用分区

        - /home  : 用于文件服务器
        - /www : 用于web服务器  自定义新建

    > 根目录/bin + /lib + /etc  和根目录在同级目录

:anchor: Linux系统安装

- 密码原则
    - 大于8位
    - 大写小写数字符号
    - 不允许使用身份信息相关
    - 不允许使用现有单词
    - 易记忆性
    - 时效性

:anchor: 远程登录管理工具

- XShell + Xftp
- Redhat6 的IP 设置 setup   +  onboot * 表示开启
    - service network restart
- install.log : 安装软件包日志
- install.log.syslog : 安装数据
- anaconda-ks.log : 安装步骤记录,用于批量安装模板

# 011~014 : 初学建议

:anchor: 学习的注意事项

- 严格区分大小写
- Linux系统一切皆文件 : 所有内容是通过文件的形式保存和管理的,设备也是设备文件
- Linux是不靠文件扩展名区分文件类型,靠权限为标识, 用于管理员规范
- Linux中所有的存储设备都必须在挂载之后才可以使用
- Windows程序不可以直接在Linux中使用

:anchor: Linux注意事项

- 目录结构
    - /bin : 存放系统命令目录, 普通用户 和管理员都可以执行, 是/usr/bin目录的软连接
    - /sbin : 存放系统命令目录, 只有超级用户可以执行, 是 /usr/sbin目录的软讲解
    - /usr/bin : 存放系统命令目录, 普通用户 和管理员都可以执行, 
    - /usr/sbin  : 存放系统命令目录, 只有超级用户可以执行, 
    - /boot : 系统启动目录, 保存与系统启动相关文件
    - /etc : 设备的配置,默认是设备配置
    - /opt : 第三方软件安装目录, 推荐使用/usr/local目录
    - /dev : 设备文件 
    - /home : 用于家目录, 默认的登陆目录
    - /lib + /lib64: 系统函数库
    - /lost=found : 错误关机的临时文件
    - /media + /misc  + /mnt : 空目录 用作挂载点
    -  /proc + /sys: 内存挂载点
    - /selinux : 限制root权限, 增强权限
    - /tem : 临时
    - /usr : UNIX software resource : 系统软件资源目录

- Linux 二级目录
    - /usr/lib : 应用程序调用的函数库保存位置
    - /usr/local : 手工安装软件保存位置
    - /usr/share : 应用程序的资源文件保存位置, 帮助文档
    - 