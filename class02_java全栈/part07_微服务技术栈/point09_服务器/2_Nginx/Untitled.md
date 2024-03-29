# 1-1 介绍

1. 课程大纲
   - 第一部分 基础篇
     - 1.1 快速安装
     - 1.2 配置语法
     - 1.3 默认模块
     - 1.4 Nginx的log
     - 1.5 访问限制
       - HTTP请求和连接
       - 请求限制与连接限制
       - access模块配置语法
       - 请求限制局限性
       - 基本安全认证
       - auth模块配置语法
       - 安全认证局限性
   - 第二部分 场景实践篇
     - 2.1 静态资源WEB服务
       - 什么是静态资源
       - 静态资源服务场景
       - 静态资源服务配置
       - 客户端缓存
       - 静态资源压缩
       - 防盗链
       - 跨域访问
     - 2.2 代理服务
     - 2.3 负载均衡
     - 2.4 缓存服务
   - 第三部分 深度学习篇
     - 3.1 动静分离
     - 3.2 rewrite规则
     - 3.3 HTTPS服务
       - HTTPS协议
       - 配置语法
       - Nginx的HTTPS服务
       - 苹果要求的https服务
     - 3.4 Nginx与LUA开发
     - 3.5 进阶模块配置
   - 第四部分 架构篇
     - 4.1 常见问题
     - 4.2 Nginx中间件性能优化
       - 如何调试性能优化
       - 性能优化影响因素
       - 操作系统性能优化
       - Nginx性能优化
     - 4.3 Nginx与安全 
     - 4.4 新版本特性
     - 4.5 中间件架构设计

# 1-2 环境准备

1. 学习环境：Linux服务器64位

2. 环境调试：

   -  确认系统网络：需要下载资源包

     ```sh
     ping www.baidu.com
     ```

   - 确认yum可用：

     ```sh
     yum list | grep gcc
     ```

   - 确认关闭iptables：测试环境，方便测试

     ```sh
     iptables -L		# 查看iptables规则
     iptables -F		# 关闭防火墙
     
     iptables -t nat -L	
     iptables -t nat -F
     ```

   - 确认停用selinux：屏蔽服务安全规则屏蔽

     ```sh
     getenforce 		# 查看selinux是否开启
     setenforce 0	# 临时关闭selinux
     ```

3. 两项基本安装

   ```sh
   yum -y install gcc gcc-c++ autoconf pcre pcre-devel make automake
   yum -y install wget httpd-tools vim
   ```

4. 一次初始化

   ```sh
   cd opt
   mkdir app download logs work backup
   ```

   - app：代码目录
   - download：下载的源码包等资源
   - logs：自定义日志
   - work：存放shell脚本
   - backup：存放配置文件备份

# 2-1 基础篇-什么是nginx

1. 中间件： 将具体业务和底层逻辑解耦的组件；可以是应用与操作系统之间的组件，也可以是应用于其他系统应用之间的组件，重点的解耦，上层应用无需了解底层逻辑，是需要符合中间件的规范即可；
2. nginx简介：Nginx是一个开源且高性能、可靠的HTTP中间件、代理服务；

# 2-2 常见的中间件服务

1. HTTPD：Apache基金会
2. IIS：微软
3. GWS：Google
4. Nginx：

# 2-3 Nginx特性 2-4 2-5 2-6

1. IO多路复用epoll：多个描述符的I/O操作都能在一个线程内并发交替的顺序完成，这叫I/O多路复用，复用的是同一个线程
   - epoll：IO多路复用的实现方式（select、poll、epoll）， IO请求时候，内核会主动发送所需要处理文件的文件信息给引用端，引用端在内核FD就绪之前都是Block（阻塞）的，也会维护一个FD列表
     - select： 应用端会采用select模式不但遍历所维护的FD文件描述符列表，以等待对应的线程唤醒完成数据拷贝：①采用线程遍历的方式，效率低下②能够监视文件描述符的数量存在最大限制2024
     - poll：
     - epoll：2.6后采用FD模型，每当FD就绪，采用系统的回调函数将FD放入，效率更高；并且没有最大连接限制
2. 轻量级：
   - 功能模块少：核心模块只集成http模块相关的核心模块；
   - 代码模块化：可以采用插件式安装；
3. CUP的亲和：把CPU核心和Nginx工作进程绑定的方式，把每个worker进程固定在一个CUP上执行，减少CPU切换的消耗，获得更好的性能
4. sendfile：Nginx处理静态资源效率高，因为采用了sendfile的机制，传统的文件传输：①读取文件到内核空间②再从内核空间切换到用户空间，sendfile只通过内核空间完成传输

# 2-7 快速安装

1. Nginx版本说明

   - Mainline version：开发版
   - Stable version：稳定版
   - Legacy version：历史版本

2. Nginx安装

   - 下载Nginx地址：http://nginx.org/en/download.html

   - Linux系统采用yum安装：Pre-Built Packages：Linux packages for stable and mainline versions.

     ```sh
     # 安装工具包
     sudo yum install yum-utils
     # 新增nginx yum配置 查看官网
     vim /etc/yum.repos.d/nginx.repo
     
     [nginx-stable]
     name=nginx stable repo
     baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
     gpgcheck=1
     enabled=1
     gpgkey=https://nginx.org/keys/nginx_signing.key
     module_hotfixes=true
     
     # 安装nginx
     yum install nginx
     
     # 检查安装结果
     nginx -v
     nginx -V
     ```

# 2.8 Nginx安装目录

1. 安装目录：采用yum安装其实安装的也是rpm包，列出安装目录：rpm -ql nginx

   ```properties
   
   # 配置文件：Nginx日志轮转，用于logrotate服务的日志切割
   /etc/logrotate.d/nginx
   # 目录配置文件
   /etc/nginx
   /etc/nginx/nginx.conf						# nginx启动读取的配置文件
   /etc/nginx/conf.d
   /etc/nginx/conf.d/default.conf				# 默认是server加载的配置文件
   # 配置文件：cgi配置相关 fastcgi配置
   /etc/nginx/fastcgi_params
   /etc/nginx/scgi_params
   /etc/nginx/uwsgi_params
   # 配置文件：设置http协议的Content-Type与扩展名对应关系
   /etc/nginx/mime.types
   # 配置文件：配置系统守护进程管理器管理方式
   /usr/lib/systemd/system/nginx-debug.service
   /usr/lib/systemd/system/nginx.service
   # 目录：Nginx模块目录
   /etc/nginx/modules
   /usr/lib64/nginx
   /usr/lib64/nginx/modules
   # 命令：Nginx服务的启动管理终端命令
   /usr/sbin/nginx
   /usr/sbin/nginx-debug
   # 文件目录：Nginx手册和帮助呢就
   /usr/share/doc/nginx-1.20.0
   /usr/share/doc/nginx-1.20.0/COPYRIGHT
   /usr/share/man/man8/nginx.8.gz
   # Nginx缓存目录
   /var/cache/nginx
   # Nginx日志目录
   /var/log/nginx
   # Nginx默认首页
   /usr/share/nginx
   /usr/share/nginx/html
   /usr/share/nginx/html/50x.html
   /usr/share/nginx/html/index.html
   
   /usr/libexec/initscripts/legacy-actions/nginx
   /usr/libexec/initscripts/legacy-actions/nginx/check-reload
   /usr/libexec/initscripts/legacy-actions/nginx/upgrade
   ```

2. 编译参数：查看安装nginx编译参数：nginx -V

   ```properties
   # 安装目的目录或路径
   --prefix=/etc/nginx 
   --sbin-path=/usr/sbin/nginx 
   --modules-path=/usr/lib64/nginx/modules 
   --conf-path=/etc/nginx/nginx.conf 
   --error-log-path=/var/log/nginx/error.log 
   --http-log-path=/var/log/nginx/access.log 
   --pid-path=/var/run/nginx.pid 
   --lock-path=/var/run/nginx.lock 
   # 执行对应模块时,Nginx所保留的临时性文件
   --http-client-body-temp-path=/var/cache/nginx/client_temp 
   --http-proxy-temp-path=/var/cache/nginx/proxy_temp 
   --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp 
   --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp 
   --http-scgi-temp-path=/var/cache/nginx/scgi_temp
   # nginx进程启动的用户和组
   --user=nginx 
   --group=nginx 
   # nginx启动的模块
   --with-compat 
   --with-file-aio 
   --with-threads 
   --with-http_addition_module 
   --with-http_auth_request_module 
   --with-http_dav_module 
   --with-http_flv_module 
   --with-http_gunzip_module 
   --with-http_gzip_static_module 
   --with-http_mp4_module 
   --with-http_random_index_module 
   --with-http_realip_module 
   --with-http_secure_link_module 
   --with-http_slice_module 
   --with-http_ssl_module 
   --with-http_stub_status_module 
   --with-http_sub_module 
   --with-http_v2_module 
   --with-mail 
   --with-mail_ssl_module 
   --with-stream 
   --with-stream_realip_module 
   --with-stream_ssl_module 
   --with-stream_ssl_preread_module 
   # 设置额外的参数将被添加到CFLAGS变量
   --with-cc-opt='-O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 
   # 设置附加的参数,链接系统库
   --with-ld-opt='-Wl,-z,relro -Wl,-z,now -pie'
   
   -fexceptions -fstack-protector-strong 
   --param=ssp-buffer-size=4 
   -grecord-gcc-switches 
   -m64 
   -mtune=generic -fPIC' 
   ```

3. nginx基本配置语法

   - 默认主配置文件

     ```sh
     user  nginx;
     worker_processes  auto;
     
     error_log  /var/log/nginx/error.log notice;
     pid        /var/run/nginx.pid;
     
     
     events {
         worker_connections  1024;
     }
     
     
     http {
         include       /etc/nginx/mime.types;
         default_type  application/octet-stream;
     
         log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                           '$status $body_bytes_sent "$http_referer" '
                           '"$http_user_agent" "$http_x_forwarded_for"';
     
         access_log  /var/log/nginx/access.log  main;
     
         sendfile        on;
         #tcp_nopush     on;
     
         keepalive_timeout  65;
     
         #gzip  on;
     	# 包含了conf.d中所有conf
         include /etc/nginx/conf.d/*.conf;
     }
     ```

   - 配置文件根：主配置文件

     - 全局配置：nginx全局级别的配置
       - user：设置nginx服务的系统使用用户
       - worker_processes：工作进程数，和CPU相同
       - error_log：nginx错误日志
       - pid：nginx启动时进程文件
     - 事件配置
       - events：内核模型
         - worker_connections：每个进程运行的最大连接数，优化度量
         - use：工作进程数，内核模型

     - http服务配置：http://127.0.0.1:8080/api
       - http：包含多个server（一个server有独立的IP和端口）
         - include：包含配置文件ContentType
         -  include /etc/nginx/conf.d/*.conf; 只有一个下面的default.conf
         - default_type：ContentType
         - log_format：日志类型
         - access_log：
         - sendfile：内核模式
         - keepalive_timeout：服务端超时时间
         - server：包含多个location（一个server可以多个api）
           - server_name：当前server的主机/域名
           - listen：当前server的端口
           - location：控制上个server的配置的访问路径
             - root：
             - index：
             - proxy
           - error_page：当前server统一错误页面
           - location：控制上个error_page的访问路径
          - root：
   
- default.conf
   
     ```properties
     server {
      listen       80;
       server_name  localhost;
     
         #access_log  /var/log/nginx/host.access.log  main;
     
         location / {
             root   /usr/share/nginx/html;
             index  index.html index.htm;
         }
     
         #error_page  404              /404.html;
     
         # redirect server error pages to the static page /50x.html
         # 
         error_page   500 502 503 504  /50x.html;
         location = /50x.html {
             root   /usr/share/nginx/html;
         }
     
         # proxy the PHP scripts to Apache listening on 127.0.0.1:80
         #
         #location ~ \.php$ {
         #    proxy_pass   http://127.0.0.1;
         #}
     
         # pass the PHP scripts to FastCGI server listening on 127.0.0.1:9000
         #
         #location ~ \.php$ {
         #    root           html;
         #    fastcgi_pass   127.0.0.1:9000;
         #    fastcgi_index  index.php;
         #    fastcgi_param  SCRIPT_FILENAME  /scripts$fastcgi_script_name;
         #    include        fastcgi_params;
         #}
     
         # deny access to .htaccess files, if Apache's document root
         # concurs with nginx's one
         #
         #location ~ /\.ht {
         #    deny  all;
         #}
     }
     
     ```
     
     - server
       - listen：
       - server_name：
       - location：
       - error_page：表示这些状态码会返回 /50x.html这个地址 
       - location  ：下面的location指定这个 /50x.html所在的地址

# 2-12 http请求

1. http请求：基于tcp
   - request：请求头 + 请求行 + 请求数据
   - response：响应头 + 状态行 + 响应数据

# 2-13 Nginxlog 2-14

2. 日志类型

   - error.log： 包含nginx处理http请错误的日志和nginx自生服务的错误日志，

   - access.log：每次nginx请求记录的日志，分析每次访问的，依赖与log_format配置：nginx的log会记录很多信息，对应nginx的变量，通过log_format将变量以一定格式组织在一起并记录到日志文件中

     ```properties
     Syntax：配置语法（配置关键字 这个格式的名字 添加的所有的字符串变量 ）
     Default：默认配置（）
     Context：只能配置在http块中
     ```

   - 默认nginxlog配置：remote_addr（客户端地址）、remote_user（请求nginx的认证用户名，没有则不激烈）、time_local、request（请求行）、status（响应码）、body_bytes_sent（body大小）、http_referer（上个页面地址）、http_user_agent（客户端agent）、http_x_forwarded_for（）

     ```properties
     # log_format 是日志格式化标识
     # main 是日志的名称
     # 读取变量组织日志 $符号读取变量 
     log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                           '$status $body_bytes_sent "$http_referer" '
                           '"$http_user_agent" "$http_x_forwarded_for"';
     # 配置访问日志： 日志地址 采用的日志格式名称
     access_log  /var/log/nginx/access.lo  main;
     ```

3. nginx变量

   - http请求变量：`arg_参数名`、`http_请求头`（请求头）、`sent_http_响应头`（响应头）
   - 内置变量： 从nginx官网：
   - 自定义变量：

# 2-15 nginx模块

1. Nginx模块分类

   - nginx官方模块：源码包内置的模块
   - 第三方模块：第三方开发模块

2. 模块http_stub_status_module：Nginx客户端状态，配置语法

   ```properties
   Syntax：stub_status;	# 开启 配置语法
   Default：--		# 默认没有配置
   Context：server，location 在这两级可以配置
   ```

   - 配置案例：如下配置表示开启的nginx服务状态配置

     ```properties
     location /path {
     	stub_status;
     }
     ```

   - 查看nginx状态：ip：端口/path

3. 模块：http_random_index_module：目录中选择一个随机主页，配置语法

   ```properties
   Syntax：random_index on|off;	# 配置语法
   Default：off		# 默认没有配置
   Context：location 在这两级可以配置
   ```

   - 配置案例

     ```properties
     location /path {
     	root /opt/app/code；
     	random_index on;
     	# index 就不需要了
     }
     ```

   - 查看配置是否生效：`http://ip:端口/path`

4. 模块：http_sub_module：客户端给服务端响应内容的时候用于对http内容替换，配置语法

   ```properties
   Syntax：sub_filter 要替换的内容  替换以后的内容;	# 配置语法
   Default：		# 默认没有配置
   Context：http/server/location 在这两级可以配置
   
   Syntax：sub_filter_last_modified on|off;	# 配置语法  nginx服务完成和客户端每次请求时候 校验服务端的内容是否有变更,判断是否有更新
   Default：off		# 默认没有配置
   Context：http/server/location 在这两级可以配置
   
   Syntax：sub_filter_once on|off;	 # 匹配所有html里的第一个还是所有字符串 on匹配第一个
   Default：on		#  默认值
   Context：http/server/location 在这两级可以配置
   ```

# 2-20 nginx请求限制

1. 链接频率限制：-limit_conn_module：http的连接与请求,三次握手四次挥手连接是一个请求;还天天请求是建立在一次tcp请求基础上,一次tcp请求至少可以产生一次http请求,

   ```properties
   Syntax：limit_conn_zone key zone=name:size;	 # 
   Default： 		#  默认值
   Context：http;    在这两级可以配置
   
   Syntax：limit_conn zone number;	 #  
   Default： 		#  默认值
   Context：http/server/location 在这两级可以配置
   ```

2. 请求频率限制：-limit_req_module：

   ```properties
   Syntax：limit_req_zone key zone=name:size rate=速率;	 # 
   Default： 		#  默认值
   Context：http;    在这两级可以配置
   
   Syntax：limit_req zone=name;	 # 
   Default： 		#  默认值
   Context：http/server/location 在这两级可以配置
   ```

# 2-23 访问控制

1. 基于IP的访问控制 - http_access_module：客户端可以被代理，只能通过remote_addr，用x_forwarded_for是头信息规定携带的,包含了通过代理所有的IP，要求遵循协议，方式二：结合geo模块；方式三：通过http自定义变量传递；

   ```properties
   Syntax：alow ip值 | CIDR(网段)|unix(sockt)|all; 允许
   Default： 		#  默认值
   Context：http/server/location/limit_except;    在这两级可以配置
   
   
   Syntax：deny ip值 | CIDR(网段)|unix(sockt)|all; 不允许
   Default： 		#  默认值
   Context：http/server/location/limit_except;    在这两级可以配置
   ```

2. x_forwarded_for：可以配置一系列IP

3. 基于用户的信息登陆 - http_auth_basic_module 根据官方格式生成密码文件

   ```PRO
   Syntax：auth_basic string|off; # string 开启或显示登陆提示
   Default： off  #  默认值
   Context：http/server/location/limit_except;    在这两级可以配置
   
   Syntax：auth_basic_user_file file; #存储用户密码信息的文件
   Default： off  #  默认值
   Context：http/server/location/limit_except;    在这两级可以配置
   ```

   - 依赖文件方式
   - 操作管理机械 管理复杂
   - Nginx结合LUA
   - Nginx和LDAP打通

# 3-1 Nginx中间件架构









