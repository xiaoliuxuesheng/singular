# 第1章 Nginx开门见山
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;结合《2019年Q3季度的互联网吸引力人才报告》与招聘网站岗位需求，从不同视角，不同维度分析Nginx“江湖”地位，让小伙伴清楚无论是大中小企业还是互联网公司，抑或是初中高级前端、后端、运维甚至是实习生岗位都是在招聘中有明确要求的。...

## 1-1 形神兼具：体系化修炼Nginx

1. **Nginx重要性**：项目部署，一个程序员的学习广度的基础要求；Nginx的优化；Nginx是前端、后端、运维必须掌握的技术；
2. **谁适适合学Nginx**：凡是IT开发人员必须要学会的一个技术：前端、后端、运维。
3. 学习内容：
   - 基础用法
   - 核心模块
   - 生产场景
   - 性能优化
4. 技术储备

# 第2章 Nginx初体验
​		本章介绍了Nginx诞生的历史背景，重点列出其在企业级环境中的应用场景，Nginx高并发的根源所在，最后利用rpm简单部署一个Nginx。

## 2-1 总诀式：课程结构概述

1. 概述：历史背景、主要应用、特点、部署
2. 基础使用：进程结构、热部署、模块划分、基础语法
3. 进阶使用：core、log、rewrite、ssl
4. 场景实践：反向代理、负载均衡、https、限速、动静分离
5. 软件架构：同步异步、阻塞非阻塞、多路复用、连接池
6. 性能优化：TCP协议栈、磁盘IO、模块优化、内存分配优化

## 2-2 破剑式：Nginx概述

1. Nginx简要概述：Nginx是一个高性能的**反向代理**WEB**服务器**，其特点是占用内存小、并发能力强；
2. 静态资源和动态资源
   - 静态资源：通过请求后相应的结果不会改变的资源，如网页嵌入的图片、css、js等
   - 动态资源：通过请后响应的结果会根据请求的不同而结果不同，如接口返回的数据资源。
   
3. 反向代理和正向代理

   - 反向代理：反向代理服务器会帮我们把请求转发到真实的服务器那里去。Nginx就是性能非常好的反向代理服务器，用来做负载均衡。

     > 举例：拨打10086客服电话，可能一个地区的10086客服有几个或者几十个，你永远都不需要关心在电话那头的是哪一个，叫什么，男的，还是女的，漂亮的还是帅气的，你都不关心，你关心的是你的问题能不能得到专业的解答，你只需要拨通了10086的总机号码，电话那头总会有人会回答你，只是有时慢有时快而已。那么这里的10086总机号码就是我们说的反向代理。**客户不知道真正提供服务人的是谁**。

   - 正向代理：也就是我们生活中常说的代理，正向代理的过程，它隐藏了真实的请求客户端，服务端不知道真实的客户端是谁，客户端请求的服务都被代理服务器代替来请求

     > 举例：某同学要创业，但是没有启动资金，于是他决定去找马云爸爸借钱，结果可想而知，然后通过打听得到某同学的大学老师王老师是马云的同学，于是某同学找到王老师，托王老师帮忙去马云那借500万过来，当然最后事成了。不过马云并不知道这钱是A同学借的，马云是借给王老师的，最后由王老师转交给A同学。这里的王老师在这个过程中扮演了一个非常关键的角色，就是**代理**，也可以说是正向代理，王老师代替A同学办这件事，这个过程中，**真正借钱的人是谁，马云是不知道的**，这点非常关键。

##  2-3 破刀式：Nginx缘起历史

1. Apache服务器：互联网的爆发式增长，然而Apache服务器为单核CUP而设计，一个进程处理一个请求，在高并发的网络环境中已经得不到满足
2. Nginx服务器：非阻塞式的服务器，一个进程可以处理多个请求，为高并发而设计；

## 2-4 破枪式：Nginx主流企业场景

- 用户请求 ---> Nginx
  - ---> 静态资源
  - ---> API服务 ---> 数据库服务、外部资源
  - ---> 反向代理（反向代理、负载均衡） ---> 应用服务 ---> 数据库服务

## 2-5 破箭式：Nginx优势

- 高并发、高性能：一个进程处理多请求，非阻塞、IO多路复用
- 扩展性好：模块化设计，功能解耦
- 异步非阻塞的事件驱动模型：
- 高可靠性、热部署：部署在边缘节点中，体用高可用性提供服务的保障性
- BSD许可：可以二次开发，开源分享

## 2-6 破气式：安装第一个rpm包Nginx

1. Linux中使用RPM包安装：一般开发中很少用，已提供了yum源的方式安装

   - 安装Nginx需要安装epel-release源：在这个源中有Nginx

     ```sh
     yum install epel-release
     ```

   - 插件当前的yum源中是否包含Nginx

     ```sh
     yun list all | grep nginx
     ```

   - 安装Nginx

     ```sh
     yum install nginx -y
     ```

   - 列出nginx包中所安装的软件

     ```sh
     [root@localhost ~]# rpm -ql nginx
     
     /etc/logrotate.d/nginx
     /etc/nginx/fastcgi.conf
     /etc/nginx/fastcgi.conf.default
     /etc/nginx/fastcgi_params
     /etc/nginx/fastcgi_params.default
     /etc/nginx/koi-utf
     /etc/nginx/koi-win
     /etc/nginx/mime.types
     /etc/nginx/mime.types.default
     /etc/nginx/nginx.conf				# 主配置文件
     /etc/nginx/nginx.conf.default
     /etc/nginx/scgi_params
     /etc/nginx/scgi_params.default
     /etc/nginx/uwsgi_params
     /etc/nginx/uwsgi_params.default
     /etc/nginx/win-utf
     
     /usr/bin/nginx-upgrade
     /usr/lib/systemd/system/nginx.service
     /usr/lib64/nginx/modules
     /usr/sbin/nginx							# Nginx程序文件
     
     /usr/share/doc/nginx-1.16.1
     /usr/share/doc/nginx-1.16.1/CHANGES
     /usr/share/doc/nginx-1.16.1/README
     /usr/share/doc/nginx-1.16.1/README.dynamic
     /usr/share/doc/nginx-1.16.1/UPGRADE-NOTES-1.6-to-1.10
     /usr/share/licenses/nginx-1.16.1
     /usr/share/licenses/nginx-1.16.1/LICENSE
     /usr/share/man/man3/nginx.3pm.gz
     /usr/share/man/man8/nginx-upgrade.8.gz
     /usr/share/man/man8/nginx.8.gz
     /usr/share/nginx/html/404.html
     /usr/share/nginx/html/50x.html
     /usr/share/nginx/html/en-US
     /usr/share/nginx/html/icons
     /usr/share/nginx/html/icons/poweredby.png
     /usr/share/nginx/html/img
     /usr/share/nginx/html/index.html
     /usr/share/nginx/html/nginx-logo.png
     /usr/share/nginx/html/poweredby.png
     /usr/share/vim/vimfiles/ftdetect/nginx.vim
     /usr/share/vim/vimfiles/ftplugin/nginx.vim
     /usr/share/vim/vimfiles/indent/nginx.vim
     /usr/share/vim/vimfiles/syntax/nginx.vim
     
     /var/lib/nginx			# 
     /var/lib/nginx/tmp		
     /var/log/nginx			# 日志目录:assess.log、error.log
     ```

2. Linux中使用yum源安装Nginx

3. Windows系统安装Nginx

4. Mac系统安装Nginx

5. Docker中安装Nginx

# 第3章 Nginx进程结构与热部署
​		从Nginx进程结构说起，引入信号量机制，并利用信号量对Nginx进程管理；讲解热部署完整步骤、模块化机制等，通过本章学习，小伙伴们可动手编译安装定制化Nginx，可对线上WEB业务进行热升级，可以配置三种形式(多网卡、端口、域名、)虚拟主机。 ...

## 3-1 Nginx的进程结构

1. 查看Nginx启动帮助：`/usr/sinb/nginx`

   ```sh
   [root@localhost /]# nginx -h
   nginx version: nginx/1.16.1
   Usage: nginx [-?hvVtTq] [-s signal] [-c filename] [-p prefix] [-g directives]
   
   选项:
     -?,-h         : 帮助
     -v            : 显示版本并退出
     -V            : 显示版本和配置选项，然后退出
     -t            : 测试配置和退出
     -T            : 测试配置，转储配置并退出
     -q            : 在配置测试期间抑制非错误消息
     -s signal     : 主进程的结束信号: stop, quit, reopen, reload
     -p prefix     : set prefix path (default: /usr/share/nginx/)
     -c filename   : 设置前缀路径 (default: /etc/nginx/nginx.conf)
     -g directives : 从配置文件中设置全局指令
   ```

2. Nginx进程结构

   <img src="https://s1.ax1x.com/2020/05/31/tlMK4H.png" alt="tlMK4H.png" border="0" />

   ​		多进程和多线程的区别：nginx为高可用性而设计，采用多进程（work process）的方式设计；而多线程的特点是采用共享一块地址空间，一个线程不可用可能会导致其他线程不可用；

   ​		Maste Process并不会真正处理用户请求，而是用于管理子进程（重启子进程、加载配置文件），真正处理用户请求的是Worker Process（数量可配置）；在模块化开发时候不会在Master Process中进行修改，而是在自己的模块总开发，不会影响到其他模块；Cache Manager和Cache Loader管理缓存的进程，而缓存的内容是由Worker Process进行加载；

   ​		一个Worker Process建议绑定一个CPU，减少因为CUP切换的消耗。

## 3-2 Linux的信号量管理机制

1. Linux的信号量：Linux的管理是通过信号量进行管理的，通过`kill -l`查看系统信号量，通过kill发送信号量的方式：`kill -s 信号量名称 PID`

   ```sh
   [root@localhost ~]# kill -l
    1) SIGHUP       	# kill -1 PID	: 进程重新加载配置文件
    2) SIGINT       
    3) SIGQUIT      	# kill-3 PID 	: 类似Ctrl + \清除输出
    4) SIGILL       
    5) SIGTRAP
    6) SIGABRT      
    7) SIGBUS       
    8) SIGFPE       
    9) SIGKILL     	# kill -9 PID	: 无条件终止
   10) SIGUSR1			# kill -10 PID	: 用户自定义开发
   11) SIGSEGV    
   12) SIGUSR2    		# kill -12 PID	: 用户自定义开发
   13) SIGPIPE    
   14) SIGALRM    
   15) SIGTERM			# kill PID		: 结束工作,运行处理完数据后结束
   16) SIGSTKFLT  
   17) SIGCHLD    		# kill -17 PID	: 给父进程发送
   18) SIGCONT    
   19) SIGSTOP    
   20) SIGTSTP
   21) SIGTTIN    
   22) SIGTTOU    
   23) SIGURG     
   24) SIGXCPU    
   25) SIGXFSZ
   26) SIGVTALRM  
   27) SIGPROF    
   28) SIGWINCH   		# kill -28 PID	: 用户自定义开发
   29) SIGIO      
   30) SIGPWR
   31) SIGSYS     
   34) SIGRTMIN   
   35) SIGRTMIN+1 
   36) SIGRTMIN+2 
   37) SIGRTMIN+3
   38) SIGRTMIN+4 
   39) SIGRTMIN+5 
   40) SIGRTMIN+6 
   41) SIGRTMIN+7 
   42) SIGRTMIN+8
   43) SIGRTMIN+9 
   44) SIGRTMIN+10
   45) SIGRTMIN+11
   46) SIGRTMIN+12
   47) SIGRTMIN+13
   48) SIGRTMIN+14
   49) SIGRTMIN+15
   50) SIGRTMAX-14
   51) SIGRTMAX-13
   52) SIGRTMAX-12
   53) SIGRTMAX-11
   54) SIGRTMAX-10
   55) SIGRTMAX-9 
   56) SIGRTMAX-8 
   57) SIGRTMAX-7
   58) SIGRTMAX-6 
   59) SIGRTMAX-5 
   60) SIGRTMAX-4 
   61) SIGRTMAX-3 
   62) SIGRTMAX-2
   63) SIGRTMAX-1 
   64) SIGRTMAX
   ```

## 3-3 利用信号量管理Nginx

1. 使用信号量管理master和worker

   - master进程：可以接收信号量，管理子进程

     | 可接受信号 | 说明                                           |
     | ---------- | ---------------------------------------------- |
     | CHLD       | 监控worker进程                                 |
     | TERM       | 终止                                           |
     | INT        | 终止                                           |
     | QUIT       | 不会立即终止，等待请求处理完成                 |
     | HUP        | 重新加载配置文件，重读配置文件后会重启一个进程 |
     | USR1       | 重新打开日志文件                               |
     | USR2       | 平滑升级                                       |
     | WINCH      |                                                |

   - worker进程：不推荐直接给worker进程发送信号量，worker是由master进行管理

     | 可接受信号 | 说明       |
     | ---------- | ---------- |
     | TERM       | 关闭       |
     | INT        | 关闭：强制 |
     | QUIT       | 关闭：优雅 |
     | USR1       |            |
     | WINCH      |            |

   - 命令行管理：

     | 命令行参数      | 说明 |
     | --------------- | ---- |
     | nginx -s reload | HUP  |
     | nginx -s reopen | USR1 |
     | nginx -s stop   | TERM |
     | nginx -s quit   | QUIT |

## 3-4 配置文件重载的原理真相

1. 向master进程发送HUP信号（reload）
2. master进程检查配置语法是否正确
3. master进程（可能会，如果配置文件中修改了端口）打开监听端口
4. master进程使用新的配置文件启动新的worker子进程
5. master进程向老的worker子进程发送QUIT信号
6. 旧的worker进程关键监听句柄，处理网当前连接或关闭进程

##  3-5 Nginx的热部署试看



##  3-6 Nginx热部署完整步骤演示
 3-7 设计理念：Nginx模块化设计机制
 3-8 Nginx编译安装的配置参数
 3-9 定制编译安装第一个Nginx-上
 3-10 定制编译安装第一个Nginx-下
 3-11 Nginx配置文件结构-上
 3-12 Nginx配置文件结构-下
 3-13 虚拟主机的分类
 3-14 基于多网卡的虚拟主机实现
 3-15 基于端口的虚拟主机实现-上
 3-16 基于端口的虚拟主机实现-下
 3-17 基于域名的虚拟主机实现
第4章 核心指令-Nginx基础应用【积跬步以至千里】
对配置文件main段核心参数进行讲解；对server_name、location指令进行了重点讲解；重点针对易混淆知识点做了特别说明，例如root和alias的区别、location中URL后面的/；通过本章的学习，小伙伴们将收获：熟练使用location指令来部署WEB业务。 ...

 4-1 配置文件main段核心参数用法-上
 4-2 配置文件main段核心参数用法-下
 4-3 配置文件events段核心参数用法
 4-4 server_name指令用法
 4-5 server_name指令用法优先级
 4-6 root和alias的区别
 4-7 location的基础用法
 4-8 location指令中匹配规则的优先级
 4-9 深入理解location中URL结尾的反斜线
 4-10 stub_status模块用法
第5章 HTTP核心模块-Nginx应用进阶【不拓心路，难开视野】
案例实践驱动式学习，如:限制连接数的limit_conn模块、限制请求速率的limit_req模块、限制IP访问access模块、限制特定用户访问auth_basic模块、URL重写的rewrite模块；本章收获：对业务特定URL进行重写，对业务中模块进行限速，限制用户访问等。 ...

 5-1 再谈connection和request
 5-2 对connection做限制的limig_conn模块
 5-3 对request处理速率做限制的limit_req模块
 5-4 限制特定IP或网段访问的access模块
 5-5 限制特定用户访问的auth_basic模块
 5-6 基于HTTP响应状态码做权限控制的auth_request模块
 5-7 rewrite模块中的return指令
 5-8 rewrite模块中的rewrite指令
 5-9 return和rewrite指令执行顺序
 5-10 rewrite模块中if指令
 5-11 autoindex模块用法
 5-12 Nginx变量的分类
 5-13 TCP连接相关变量
 5-14 发送HTTP请求变量-上
 5-15 发送HTTP请求变量-下
 5-16 处理HTTP请求变量
第6章 场景实践-反向代理【企业案例|焦点效应】
从动静分离说起，引入反向代理，介绍反向代理协议；重点：反向代理模块upstream用法、配置Nginx实现应用服务的反向代理；通关本章将收获：如何利用Nginx对应用服务进行负载均衡，更重要深入细节，帮助小伙伴们技术实力的提升。 ...

 6-1 反向代理基础原理
 6-2 动静分离
 6-3 使用Nginx作为反向代理时支持的协议
 6-4 用于定义上游服务的upstream模块
 6-5 upstream模块指令用法详解
 6-6 配置一个可用的上游应用服务器
 6-7 配置nginx反向代理实例
 6-8 proxy_poass指令用法常见误区
 6-9 代理场景下Nginx接收用户请求包体的处理方式
 6-10 代理场景下Nginx如何更改发往上游的用户请求-上
 6-11 代理场景下Nginx如何更改发往上游的用户请求-下
 6-12 代理场景下Nginx与上游服务建立连接细节
第7章 场景实践-负载均衡【企业案例|沃尔森法则】
本章对轮询算法、hash算法、ip_hash、最少连接数等负载均衡算法做了阐述，动手配置实现对多台应用服务的负载均衡，对上游服务出现故障时如何容错进行讲解。本章收获：对WEB业务扩容实现多台服务器负载均衡，打造一个高可用高可靠性的WEB系统。 ...

 7-1 负载均衡基础
 7-2 配置实现Nginx对上游服务负载均衡
 7-3 负载均衡算法-哈希算法
 7-4 负载均衡算法-ip_hash算法
 7-5 负载均衡算法-最少连接数算法
 7-6 负载均衡场景下Nginx针对上游服务器返回异常时的容错机制-上
 7-7 负载均衡场景下Nginx针对上游服务器返回异常时的容错机制-中
 7-8 负载均衡场景下Nginx针对上游服务器返回异常时的容错机制-下
第8章 场景实践-缓存及HTTPS【企业案例|黑洞效应】
讲解缓存指令用法，实现对上游应用服务响应内容进行缓存;缓存失效时降低上游应用服务压力方法;引入缓存清除的第三方模块;讲解在Nginx上配置https服务。本章收获:掌握Nginx缓存功能；定制对WEB业的缓存；将线上业务配置成加密的https服务。 ...

 8-1 缓存基础
 8-2 缓存相关指令用法
 8-3 缓存用法配置示例
 8-4 配置Nginx不缓存上游服务特定内容
 8-5 缓存失效降低上游压力机制一-合并源请求
 8-6 缓存失效降低上游压力机制二-启用陈旧缓存
 8-7 第三方清除模块ngx_cache_purge介绍
 8-8 ngx_cache_purge用法配置示例
 8-9 https原理基础
 8-10 https如何解决信息被窃听的问题
 8-11 https如何解决报文被篡改以及身份伪装问题
 8-12 配置私有CA服务器
 8-13 组织机构向CA申请证书及CA签发证书
第9章 深入Nginx架构【Nginx灵魂：重塑思维】
本章挺进Nginx架构，探究Nginx灵魂内核，目的是帮助小伙伴重塑思维。将探讨Nginx的架构，包括Nginx的事件处理模型，多路IO服用的优势，连接池等内容，助力小伙伴们更好的使用Nginx服务于工作中的方方面面。

 9-1 Nginx高可用基础
 9-2 虚拟路由冗余协议VRRP原理
 9-3 KeepAlived软件架构
 9-4 使用KeepAlived配置实现虚IP在多服务器节点漂移-上
 9-5 使用KeepAlived配置实现虚IP在多服务器节点漂移-中
 9-6 使用KeepAlived配置实现虚IP在多服务器节点漂移-下
 9-7 KeepAlived+Nginx高可用原理
 9-8 KeepAlived+Nginx高可用配置示例
第10章 Nginx性能优化【适用于装逼，凭实力致胜】
本章探讨深入优化Nginx组件性能的各种企业场景，设计系统底层的TCP协议优化、磁盘IO优化等，同时也会介绍nginx自身模块的优化问题，帮助小伙伴们更好的掌握优化方法论，凭实力制胜，立于不败之地。

 10-1 性能优化基础
 10-2 提升Nginx利用CPU的效率
 10-3 TCP三次握手和四次挥手
 10-4 TCP建立连接优化

10-5 启用TCP的Fast Open功能





# 第1章 课程前言

总览课程，介绍课程学习须知，环境准备，了解课程意义。

-  1-1 课程介绍试看

  1. 学习收获：高级的开发水平
  2. Nginx的目录大纲

-  1-2 学习环境准备

  - 四项确认

    1. 网络可用：ping www.baidu.com
    2. yum可用：yum list | grep gcc
    3. 关闭iptables规则关闭防火墙：iptables -l：查看；iptables -F：关闭；iptables -t nat -L：nat的规则(-F 是关闭)
    4. 确认停止selinux：getenforce-查看是否启用;setenforce 0 - 关闭selinux

  - 两项安装

    1. 基本库

       ```sh
       yum -y install gcc gcc-c++ autoconf pcre pcre-devel make automake
       ```

    2. 安装基本工具

       ```sh
       yum -y install wget httpd-tools vim
       ```

  - 一次初始化

    ```sh
    cd /opt
    mkdir app download logs work backup
    ```

    - /opt/app：代码
    - /opt/download/：下载资源
    - /opt/logs：日志文件
    - /opt/work：shell脚本
    - /opt/backup：配置文件备份

# 第2章 基础篇

讲解Nginx的快速部署安装、模块、基础配置语法。Nginx的日志输出、Nginx默认配置模块。Nginx对于请求的处理，访问控制模块使用，并区别介绍连接限制与请求限制。

-  2-1 什么是Nginx
  1. Nginx中间件：在WEB系统架构中，应用是部署在操作系统之上的，在传统的运行模式中，应用除了负责业务逻辑之外，还需要接受外部请求或者来自其他服务的请求，造成了应用直接的耦合；所以在WEB应用中提供中间件，负责接受并转发外部请求或者其他服务的请求，网站直接的链接主要是中间件的串联，负责接受分发请求，应用直接可以做到解耦，只专注业务逻辑；N**ginx是一个开源的、高性能的、可靠的HTTP代理服务器中间件；**
-  2-2 常见的中间件服务
   1. Httpd：Apache开源的
   2. IIS：微软开发
   3. CWS：Google公司开发，独立使用的
-  2-3 Nginx优势多路IO复用
-  2-4 Nginx使用Epoll模型的优势介绍
-  2-5 Nginx-CPU亲和
-  2-6 Nginx-sendfile
-  2-7 Nginx快速安装
-  2-8 Nginx的目录和配置语法_Nginx安装目录
-  2-9 Nginx的目录和配置语法_Nginx编译配置参数
-  2-10 Nginx的目录和配置语法_默认配置语法
-  2-11 Nginx的目录和配置语法_默认配置与默认站点启动
-  2-12 HTTP请求
-  2-13 Nginx虚拟主机及实现方式
-  2-14 Nginx虚拟主机单网卡多IP配置演示
-  2-15 Nginx虚拟主机基于多端口的配置演示
-  2-16 Nginx虚拟主机基于host域名的配置演示
-  2-17 Nginx日志_log_format1
-  2-18 Nginx日志_log_format2
-  2-19 Nginx模块讲解_模块介绍
-  2-20 Nginx模块讲解_sub_status
-  2-21 Nginx模块讲解_random_index
-  2-22 Nginx模块讲解_sub_module
-  2-23 Nginx模块讲解_sub_module配置演示
-  2-24 Nginx的请求限制_连接频率限制配置语法与原理
-  2-25 Nginx的请求限制_请求限制配置原理
-  2-26 Nginx的请求限制_请求限制配置语法
-  2-27 Nginx的访问控制_介绍实现访问控制的基本方式
-  2-28 Nginx的访问控制—access_module配置语法介绍
-  2-29 Nginx的访问控制—access_module配置
-  2-30 Nginx的访问控制—access_module局限性
-  2-31 Nginx的访问控制—auth_basic_module配置
-  2-32 Nginx的访问控制—auth_basic_module局限性

第3章 场景实践篇

Nginx作为静态资源web服务的场景应用，Nginx做为http代理服务,介绍代理服务的类型，正向反向代理配置，重点讲解nginx作为的应用层负载均衡服务的各种应用，hash负载均衡策略,Nginx缓存等

-  3-1 场景实践篇内容介绍试看
-  3-2 Nginx作为静态资源web服务_静态资源类型
-  3-3 Nginx作为静态资源web服务_CDN场景
-  3-4 Nginx作为静态资源web服务_配置语法
-  3-5 Nginx作为静态资源web服务_场景演示
-  3-6 Nginx作为静态资源web服务_浏览器缓存原理
-  3-7 Nginx作为静态资源web服务_浏览器缓存场景演示
-  3-8 Nginx作为静态资源web服务_跨站访问
-  3-9 Nginx作为静态资源web服务_跨域访问场景配置
-  3-10 Nginx作为静态资源web服务_防盗链目的
-  3-11 Nginx作为静态资源web服务_防盗链配置
-  3-12 Nginx作为代理服务_代理服务
-  3-13 Nginx作为代理的模式和使用模块介绍
-  3-14 Nginx作为代理服务_配置语法及反向代理场景
-  3-15 Nginx作为代理服务_正向代理配置场景(1)
-  3-16 Nginx作为代理服务_正向代理配置场景(2)
-  3-17 Nginx作为代理服务_代理配置语法补充
-  3-18 Nginx作为代理服务_代理补充配置和规范
-  3-19 Nginx作为缓存服务_Nginx作为缓存服务
-  3-20 Nginx作为缓存服务_缓存服务配置语法
-  3-21 Nginx作为缓存服务_场景配置演示
-  3-22 Nginx作为缓存服务_场景配置补充说明
-  3-23 Nginx缓存命中分析
-  3-24 Nginx统计日志进行缓存命率中分析
-  3-25 Nginx作为缓存服务_分片请求
-  3-26 什么是Websocket以及Nginx实现ws代理
-  3-27 基于nodejs实现websocket代理场景配置演示
-  3-28 什么是fastcgi代理及配置语法
-  3-29 LNMP基础环境安装
-  3-30 Fastcgi代理配置演示及测试
-  3-31 LNMP配置演示1-搭建wordpress博客系统
-  3-32 LNMP配置演示2-搭建wordpress博客系统
-  3-33 Fastcgi缓存配置演示
-  3-34 场景演示：后端服务添加no-cache头对于Nginx代理缓存的影响
-  3-35 场景演示：设置缓存维度fastcgi_cache_key设置的影响
-  3-36 Uwsgi反向代理模式
-  3-37 基于Django框架Uwsgi反向代理配置演示
-  3-38 Nginx作为负载均衡服务_负载均衡与Nginx试看
-  3-39 Nginx作为负载均衡服务_配置场景
-  3-40 Nginx作为负载均衡服务_backup状态演示
-  3-41 Nginx作为负载均衡服务_轮询策略与加权轮询
-  3-42 Nginx作为负载均衡服务_负载均衡策略ip_hash方式
-  3-43 Nginx作为负载均衡服务_负载均衡策略url_hash策略

第4章 深度学习篇

Nginx常用配置模块,rewirte的配置语法和规则，配置基于指定地域的规则访问,geoip模块、https的实现原理，配置nginx的https服务,secure_link_module的防盗链实现，讲解，讲解Lua的开发语法、配合Nginx实现高效的认证系统和其他场景。

-  4-1 Nginx动静分离_动静分离场景演示(1)
-  4-2 Nginx动静分离_动静分离场景演示
-  4-3 Nginx动静分离_动静分离场景演示(2)
-  4-4 Rewrite规则_rewrite规则作用
-  4-5 Rewrite规则_rewrite配置语法
-  4-6 Rewrite规则_rewrite正则表达式
-  4-7 Rewrite规则_rewrite规则中的flag
-  4-8 Rewrite规则_redirect和permanent区别
-  4-9 Rewrite规则_rewrite规则场景(1)
-  4-10 Rewrite规则_rewrite规则场景(2)
-  4-11 Rewrite规则_rewrite规则书写
-  4-12 Nginx进阶高级模块_secure_link模块作用原理
-  4-13 Nginx进阶高级模块_secure_link模块实现请求资源验证
-  4-14 Nginx进阶高级模块_Geoip读取地域信息模块介绍
-  4-15 Nginx进阶高级模块_Geoip读取地域信息场景展示
-  4-16 基于Nginx的HTTPS服务_HTTPS原理和作用1
-  4-17 基于Nginx的HTTPS服务_HTTPS原理和作用2
-  4-18 基于Nginx的HTTPS服务_证书签名生成CA证书
-  4-19 基于Nginx的HTTPS服务_证书签名生成和Nginx的HTTPS服务场景演示1
-  4-20 基于Nginx的HTTPS服务_证书签名生成和Nginx的HTTPS服务场景演示2
-  4-21 基于Nginx的HTTPS服务_实战场景配置苹果要求的openssl后台HTTPS服务1
-  4-22 基于Nginx的HTTPS服务_实战场景配置苹果要求的openssl后台HTTPS服务2
-  4-23 基于Nginx的HTTPS服务_实战场景配置苹果要求的openssl后台HTTPS服务3
-  4-24 基于Nginx的HTTPS服务_HTTPS服务优化
-  4-25 Nginx与Lua的开发_Nginx与Lua特性与优势
-  4-26 Nginx与Lua的开发_Lua基础开发语法1
-  4-27 Nginx与Lua的开发_Lua基础开发语法2
-  4-28 Nginx与Lua的开发_Nginx与Lua的开发环境
-  4-29 Nginx与Lua的开发_Nginx调用Lua的指令及Nginx的Luaapi接口
-  4-30 Nginx与Lua的开发_实战场景灰度发布
-  4-31 Nginx与Lua的开发_实战场景灰度发布场景演示1
-  4-32 Nginx与Lua的开发_实战场景灰度发布场景演示2
-  4-33 Nginx与Lua的开发_实战场景灰度发布场景演示3
-  4-34 Nginx与Lua的开发_实战场景灰度发布场景演示4

第5章 Nginx架构篇

Nginx常见问题和排错经验，实践应用场景中的方法处理Nginx安全，常见的应用层安全隐患，复杂访问控制，Nignx的sql防注入安全策略,Nginx的整体配置，搭建合理Nginx中间件架构配置步骤、策略Nginx性能优化:架构优化，操作系统优化、Nginx优化等...

-  5-1 Nginx常见问题_架构篇介绍
-  5-2 Nginx常见问题__多个server_name中虚拟主机读取的优先级
-  5-3 Nginx常见问题_多个location匹配的优先级1
-  5-4 Nginx常见问题_多个location匹配的优先级2
-  5-5 Nginx常见问题_try_files使用
-  5-6 Nginx常见问题_alias和root的使用区别
-  5-7 Nginx常见问题_如何获取用户真实的ip信息
-  5-8 Nginx常见问题_Nginx中常见错误码
-  5-9 Nginx的性能优化_内容介绍及性能优化考虑
-  5-10 Nginx的性能优化_ab压测工具
-  5-11 Nginx的性能优化_ab压测工具1
-  5-12 Nginx的性能优化_ab压测工具2
-  5-13 Nginx的性能优化_ab压测工具3
-  5-14 Nginx的性能优化_系统与Nginx性能优化
-  5-15 Nginx的性能优化_文件句柄设置
-  5-16 Nginx的性能优化_CPU亲和配置1
-  5-17 Nginx的性能优化_CPU亲和配置2
-  5-18 Nginx的性能优化_Nginx通用配置优化
-  5-19 Nginx安全_基于Nginx的安全章节内容介绍
-  5-20 Nginx安全_恶意行为控制手段
-  5-21 Nginx安全_攻击手段之暴力破解
-  5-22 Nginx安全_文件上传漏洞
-  5-23 Nginx安全_SQL注入
-  5-24 Nginx安全_SQL注入场景说明
-  5-25 Nginx安全_场景准备mariadb和lnmp环境
-  5-26 Nginx安全_模拟SQL注入场景
-  5-27 Nginx安全_Nginx+LUA防火墙功能
-  5-28 Nginx安全_Nginx+LUA防火墙防sql注入场景演示
-  5-29 Nginx安全_复杂的访问攻击中CC攻击方式
-  5-30 Nginx安全_Nginx版本更新和本身漏洞
-  5-31 Nginx架构总结_静态资源服务的功能设计
-  5-32 Nginx架构总结_Nginx作为代理服务的需求
-  5-33 Nginx架构总结_需求设计评估

第6章 新特性篇

本章节结合当前主流最新应用场景，或者基于Nginx版本更新带来的最新重要特性，讲解:Nginx版本平滑升级、HTTP2.0协议、gRPC应用网关场景等等，作为新特性篇后续本章的内容将持续更新…

-  6-1 Nginx平滑升级实现和原理
-  6-2 Nginx进行版本平滑升级演示
-  6-3 HTTP协议版本及HTTP2.0协议特性gRPC
-  6-4 GO及gRPC测试用例环境安装准备
-  6-5 Nginx作为gRPC应用网关配置案例演示
-  6-6 完结散花

- 01_课程综述

  1. 课程大纲
     - 初始Nginx
     - Nginx架构基础
     - 详解HTTP模块
     - 反向代理与负载均衡
     - Nginx的系统层性能优化
     - 从源码视角使用Nginx和OpenResty

  02_Nginx使用场景

  1. 场景一：静态资源服务
     - 通过本地文件系统提供服务：静态资源无需通过应用服务访问，直接提供文件服务器访问即可
  2. 场景二：反向代理服务
     - Nginx的强大性能：
     - 缓存：加速访问
     - 负载均衡
  3. 场景三：API服务
     - OpenResty

  03_Nginx出现背景

  1. 出现的原因
     - 互联网的数据量快速增长：互联网的普及，全球化
     - 摩尔定律：性能提升
     - 抵消的Apache：一个连接对应一个进程，无谓的进程切换

  04_Nginx的优点

  1. Nginx优点
     - 高性能、高性能：对硬件和操作系统的深度挖掘
     - 可扩展性好：优秀的模块设计，活跃的社区和第三方模块
     - 高可靠性
     - 热部署

  05_Nginx的主要组成部分

  1. 主要的组成
     - Nginx二进制可执行文件：由各模块源码编译出的一个文件
     - Nginx.config：控制Nginx的行为，控制Nginx的功能
     - assess.log：记录每一条Http请求
     - error.log：定位问题

  06_Nginx的版本发布历史

  1. 发布特性
     - feature：发布新增的功能
     - bugfix：修改的那些bug
     - change：做了哪些重构
  2. 版本的区别
     - mainline：主干版本，单数版本，新增功能但是不稳定
     - stable：稳定版本，双数版本

  07_版本选择

  1. 开源免费版：Nginx.org
  2. 商业收费版：Nginx.plus
  3. Tengine：阿里巴巴
  4. OpenResty.org：OpenResty基金会
  5. OpenResty.com：开源

  08_编译自己的Nginx

  1. 编译Nginx

     - 下载Nginx：nginx.org

     - 目录介绍

       ```yaml
       auto目录：存放大量的脚本文件，和configure脚本程序相关
       	cc:用于编译
       	lib:库
       	os:操作系统判断
       conf目录：存放Nginx服务器的配置文件
       configure:脚本,生成中间文件,执行编译前的必备动作
       contrib目录：存放其他机构或组织贡献的代码,如有nginx的配置文件编辑器vim
       html:两个标准HTML文件,一个欢迎页,一个错误500页面
       man:Linux对Nignx的帮助
       src:Nginx的源代码
       CHANGES、CHANGES.ru、LICENSE和README都是Nginx服务器的相关文档资料。
       ```

       > ```sh
       > cp -r contrib/vim/* ~/.vim/
       > ```

     - Nginx编译安装

       - Nginx安装依赖：需要先安装 PCRE 库

         ```sh
         # 方式一 : yum安装
         yum -y install pcre-devel zlib-devel openssl-devel
         	
         # 方式二 : 二进制文件安装
         wget pcre2
         	tar zxvf pcre2
         ./configure
         	make
         	make install
         ```

       - 配置编译选项

         ```sh
         # 进入Nginx目录
         ./configure --prefix=日志等文件的生成目录
         ```

         - --prefix设置Nginx的安装目录
         - Nginx中还有许多其他模块，后面如果先添加某些模块，再重现编译Nginx并使用--with-选项添加模块即可
         - 编译完成Nginx的一些特性会在结尾展示，编译完成形成中间文件：objs目录中

       - 中间文件

         ```sh
         ngx-modules.c  # 表示接下来哪些模块被编译进Nginx
         ```

       - 编译 & 安装

         ```sh
         make && make install
         ```

       09_通用配置语法

       1. 通用语法规则 ： Nginx包含各种模块，每个模块都有自己独特的配置语法，这些所有的语法都遵循通用的语法规则

          - 配置文件由指令和指令块组成：大括号是指令块，指令块中包含多条指令；
          - 每条指令以分号结尾，指令与参数之间以空格间隔
          - 指令块以大括号将多条指令组织在一起
          - Include语句允许组合多个配置文件以提升可维护性
          - 使用#符号添加注释，提高可读性
          - 使用$符号使用变量
          - 部分指令的参数支持正则表达式

       2. 配置参数时间单位

          | 单位 | 名称         | 说明       |
          | ---- | ------------ | ---------- |
          | ms   | milliseconds | 毫秒       |
          | s    | seconds      | 秒         |
          | m    | minutes      | 分钟       |
          | h    | hours        | 小时       |
          | d    | days         | 天         |
          | w    | weeks        | 周         |
          | M    | months       | 月 = 30天  |
          | y    | years        | 年 = 365天 |

       3. 内存单位

          | 单位      | 名称      | 说明          |
          | --------- | --------- | ------------- |
          | 缺省      | bytes     | 字节          |
          | k  /  K   | kilobytes | 1k = 1024字节 |
          | m  /  M   | megabytes | 1m = 1024k    |
          | g   /   G | gigabytes | 1g = 1024m    |

       4. http配置的指令块

          - http块 : 表示里面所有的指令都由http模块解析并执行
          - server块 : 对应的域名
          - location块 : 是url表达式
          - upstream块 : 表示上游服务

       10_Nginx启动 , 重载 , 热部署

       1. Nginx命令说明

          ```sh
          nginx [选项] 参数
          ```

          - 选项说明

            - -h : 帮助
            - -c : 使用指定的配置文件,默认是安装nginx指定目录中confi中的配置文件
            - -g : 指定配置指令,在命令行中覆盖配置文件中的指令
            - -p : 指定运行目录
            - -s : 发送信号
            - -t  /  -T  : 测试配置文件是否有语法错误
            - -v  /  -V  : 打印nginx的版本信息,编译信息

          - 参数说明

            - stop : 立刻停止服务

            - quit : 优雅的停止服务,不再接受请求,处理完当前请求后停止

            - reload : 重载配置文件

              ```sh
              nginx -s reload  # 不停止服务重新加载被修改的配置文件
              ```

            - reopen : 重新开始记录日志文件

       2. 热部署 : 在最后迁移的时候不使用make install，而使用源码自带的升级命令make upgrade来自动完成。

          - 下载最新的nginx最新版本

          - 更换现有的的nginx二进制文件

          - 备份旧的nginx二进制文 : 如`./configure --prefix=/usr/local/nginx`

            ```sh
            mv /usr/local/nginx/sbin/nginx.old　　#备份
            ```

          - 复制新编译好的二进制文件到原来安装目录

            ```sh
            cp objs/nginx /usr/local/nginx/sbin/
            ```

          - 升级

            ```sh
            kill -USR2 老进程ID  # 服务请求会从老服务慢慢切换倒新服务
            kill -WINCH 老进程ID # 优雅的
            ```

            ```sh
            make upgrade
            ```

       3. 日志切割 : nginx -s reopen

          - 一般是采用bash脚本完成日志的备份与切割

  11_搭建静态资源

  1. nginx配置详解:Nginx的HTTP配置主要包括三个区块，结构如下：

     ```scala
     http { //这个是协议级别
     　　include mime.types;
     　　default_type application/octet-stream;
     　　keepalive_timeout 65;
     　　gzip on;
     　　　　server { //这个是服务器级别
     　　　　　　listen 80;
     　　　　　　server_name localhost;
     　　　　　　　　location / { //这个是请求级别
     　　　　　　　　　　root html;
     　　　　　　　　　　index index.html index.htm;
     　　　　　　　　}
     　　　　　　}
     }
     ```

     - location区段 : 通过指定模式来与客户端请求的URI相匹配，基本语法如下：

       ```sh
       location [=|~|~*|^~|@] pattern{……}
       ```

       > - **查找顺序和优先级**
       >   1. 带有“=“的精确匹配优先
       >   2. 没有修饰符的精确匹配
       >   3. 正则表达式按照他们在配置文件中定义的顺序
       >   4. 带有“^\~”修饰符的，开头匹配
       >   5. 带有“~” 或“~\*” 修饰符的，如果正则表达式与URI匹配
       >   6. 没有修饰符的，如果指定字符串与URI开头匹配

       ```java
       location /abc {
          // 没有修饰符 表示：必须以指定模式开始
       }
       ```

       ```java
       location = /abc {
          	// =表示：必须与指定的模式精确匹配
       }
       ```

       ```java
       location ~ ^/abc$ {
           // ~ 表示：指定的正则表达式要区分大小写
       }
       ```

       ```java
       location ~* ^/abc$ {
          // ~* 表示：指定的正则表达式不区分大小写
       }
       ```

       ```java
       location ^~ /abc {
          // 类似于无修饰符的行为，也是以指定模式开始，
          // 如果模式匹配，那么就停止搜索其他模式了。
       }
       ```

     - root 、alias指令区别

       - alias是一个目录别名的定义,后面必须要用“/”结束，否则会找不到文件的
       - root则是最上层目录的定义,而root后的/则可有可无

  012_反向代理具有缓存的服务器

  

  # Nginx模块

  ## ngx_http_autoindex_module

  - 处理以斜杠字符(' / ')结尾的请求，并生成一个目录列表。

    ```java
    location / {
        autoindex on | off; 			// 启用或禁用列表输出
        autoindex_exact_size on | off;	// 输出文件大小是否是字节
        autoindex_format html | xml | json | jsonp;	// 设置目录列表格式
        autoindex_localtime on | off;	// 列表文件的日期格式
        
    }
    ```

    

  