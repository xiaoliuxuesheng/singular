# 第一部分 Nginx基础

## 第一章 快速安装

### 1.1 中间件与Nginx

​		**中间件**：中间件是介于应用系统和系统软件之间的一类软件，它使用系统软件所提供的基础服务（功能），衔接网络上应用系统的各个部分或不同的应用，能够达到资源共享、功能共享的目的。

​		**HTTP 中间件**：为过滤进入应用的HTTP请求提供一套便利的机制。

​		**Nginx**：同 Apache 一样都是一种 Web 服务器。基于 REST 架构风格，以统一资源描述符（Uniform Resources Identifier）URI 或者统一资源定位符（Uniform Resources Locator）URL 作为沟通依据，通过 HTTP 协议提供各种网络服务。

- Nginx 是一款自由的、开源的、高性能的 HTTP 服务器和反向代理服务器；同时也是一个 IMAP、POP3、SMTP 代理服务器。
- Nginx 可以作为一个 HTTP 服务器进行网站的发布处理，另外 Nginx 可以作为反向代理进行负载均衡的实现。

### 1.2 Nginx优点

1. 更快：单次请求会得到更快的响应；并发请求也会更快地响应请求。
2. 高扩展性：完全由多个不同功能、不同层次、不同类型且耦合度极低的模块组成，当对某一模块修复bug或者升级时，可以专注于模块自身。Nginx的模块都是嵌入到二级制文件中执行的，这使得第三方模块一样具备极其优秀的性能。
3. 高可靠性：核心框架代码的优秀设计、模块设计的简单性，官方提供的常用模块都非常稳定，每个worker进程相对独立，master进程在1个worker进程出错时可以快速“拉起”新的worker子进程提供服务。
4. 低内存消耗：一般情况下，10000个非活跃的HTTP Keep-Alive连接在Nginx中仅消耗2.5MB的内存，这是Nginx支持高并发连接的基础。
5. 单机支持10万以上的并发连接。
6. 热部署：master管理进程与worker工作进程的分离设计，使得Nginx能够提供热部署功能，可以在7*24小时不间断服务的前提下，升级Nginx的可执行文件，也支持不停止服务就更新配置项、更换日志文件等功能。
7. 最自由的BSD许可协议：BSD许可协议不只是允许用户免费使用Nginx，它还允许用户在自己的项目中直接使用或修改Nginx源码，然后发布。

### 1.3 场景的Http服务

<font size=4 color=blue>**1. HttpD**</font>：

<font size=4 color=blue>**2. IIS**</font>：

<font size=4 color=blue>**3. GWS**</font>：

### 1.4 Nginx安装

<font size=4 color=blue>**1. Windows系统**</font>

<font size=4 color=blue>**2. Linux系统yum安装**</font>

<font size=4 color=blue>**3. Docker安装**</font>

### 1.5 Nginx安装目录说明

<font size=4 color=blue>**1. nginx日志轮转，用于logrotate（轮替）服务的日志切割**</font>

```path
/etc/logrotate.d/nginx 
```

<font size=4 color=blue>**2. nginx主配置文件**</font>

```
/etc/nginx
/etc/nginx/nginx.conf
/etc/nginx/conf.d
/etc/nginx/conf.d/default.conf
```

<font size=4 color=blue>**3. cgi配置相关，fastcgi配置**</font>

```
/etc/nginx/fastcgi_params
/etc/nginx/scgi_params
/etc/nginx/uwsgi_params
```

<font size=4 color=blue>**4. 编码转换映射化文件**</font>

```
/etc/nginx/koi-utf
/etc/nginx/koi-win
/etc/nginx/win-utf
```

<font size=4 color=blue>**5. 设置http协议Content-Type与扩展名对应关系**</font>

```
/etc/nginx/mime.types
```

<font size=4 color=blue>**6. 用于配置出系统守护进程管理器的管理方式**</font>

```
/usr/lib/systemd/system/nginx-debug.service
/usr/lib/systemd/system/nginx.service
/etc/sysconfig/nginx
/etc/sysconfig/nginx-debug
```

<font size=4 color=blue>**7. nginx模块目录**</font>

```
/etc/nginx/modules
/usr/lib64/nginx/modules
```

<font size=4 color=blue>**8. nginx服务的启动管理的终端命令**</font>

```
/usr/sbin/nginx
/usr/sbin/nginx-debug
```

<font size=4 color=blue>**9. nginx的手册和帮助文件**</font>

```
/usr/share/doc/nginx-1.16.0
/usr/share/doc/nginx-1.16.0/COPYRIGHT
/usr/share/man/man8/nginx.8.gz
```

<font size=4 color=blue>**10. nginx的缓存目录**</font>

```
/usr/share/nginx
```

<font size=4 color=blue>**11. nginx的日志目录**</font>

```
/var/log/nginx
```

```
/usr/lib64/nginx
/usr/libexec/initscripts/legacy-actions/nginx
/usr/libexec/initscripts/legacy-actions/nginx/check-reload
/usr/libexec/initscripts/legacy-actions/nginx/upgrade
/usr/share/nginx/html
/usr/share/nginx/html/50x.html
/usr/share/nginx/html/index.html
/var/cache/nginx
```

### 1.6 Nginx安装编译参数

```properties
--prefix= 指向安装目录。
--sbin-path= 指定执行程序文件存放位置。
--modules-path= 指定第三方模块的存放路径。
--conf-path= 指定配置文件存放位置。
--error-log-path= 指定错误日志存放位置。
--pid-path= 指定pid文件存放位置。
--lock-path= 指定lock文件存放位置。

--user= 指定程序运行时的非特权用户。
--group= 指定程序运行时的非特权用户组。
--builddir= 指向编译目录。
--with-rtsig_module=启用rtsig模块支持。
--with-select_module=启用select模块支持，一种轮询处理方式，不推荐在高并发环境中使用，禁用：--without-select_module。
--with-poll_module=启用poll模块支持,功能与select相同，不推荐在高并发环境中使用。
--with-threads=启用thread pool支持。
--with-file-aio=启用file aio支持。
--with-http_ssl_module=启用https支持。
--with-http_v2_module=启用ngx_http_v2_module支持。
--with-ipv6=启用ipv6支持。
--with-http_realip_module=允许从请求报文头中更改客户端的ip地址，默认为关。
--with-http_addition_module=启用ngix_http_additon_mdoule支持（作为一个输出过滤器，分部分响应请求)。
--with -http_xslt_module=启用ngx_http_xslt_module支持，过滤转换XML请求 。
--with-http_image_filter_mdoule=启用ngx_http_image_filter_module支持，传输JPEG\GIF\PNG图片的一个过滤器，默认不启用，需要安装gd库。
--with-http_geoip_module=启用ngx_http_geoip_module支持，用于创建基于MaxMind GeoIP二进制文件相配的客户端IP地址的ngx_http_geoip_module变量。
--with-http_sub_module=启用ngx_http_sub_module支持，允许用一些其他文本替换nginx响应中的一些文本。
--with-http_dav_module=启用ngx_http_dav_module支持，增加PUT、DELETE、MKCOL创建集合，COPY和MOVE方法，默认为关闭，需要编译开启。
--with-http_flv_module=启用ngx_http_flv_module支持，提供寻求内存使用基于时间的偏移量文件。
--with-http_mp4_module=启用ngx_http_mp4_module支持，启用对mp4类视频文件的支持。
--with-http_gzip_static_module=启用ngx_http_gzip_static_module支持，支持在线实时压缩输出数据流。
--with-http_random_index_module=启用ngx_http_random_index_module支持，从目录中随机挑选一个目录索引。
--with-http_secure_link_module=启用ngx_http_secure_link_module支持，计算和检查要求所需的安全链接网址。
--with-http_degradation_module=启用ngx_http_degradation_module 支持允许在内存不足的情况下返回204或444代码。
--with-http_stub_status_module=启用ngx_http_stub_status_module 支持查看nginx的状态页。
--without-http_charset_module=禁用ngx_http_charset_module这一模块，可以进行字符集间的转换，从其它字符转换成UTF-8或者从UTF8转换成其它字符。它只能从服务器到客户端方向，只有一个字节的字符可以转换。
--without-http_gzip_module=禁用ngx_http_gzip_module支持，同--with-http_gzip_static_module功能一样。
--without-http_ssi_module=禁用ngx_http_ssi_module支持，提供了一个在输入端处理服务器包含文件（SSI）的过滤器。
--without-http_userid_module=禁用ngx_http_userid_module支持，该模块用来确定客户端后续请求的cookies。
--without-http_access_module=禁用ngx_http_access_module支持，提供了基于主机ip地址的访问控制功能。
--without-http_auth_basic_module=禁用ngx_http_auth_basic_module支持，可以使用用户名和密码认证的方式来对站点或部分内容进行认证。
--without-http_autoindex_module=禁用ngx_http_authindex_module，该模块用于在ngx_http_index_module模块没有找到索引文件时发出请求，用于自动生成目录列表。
--without-http_geo_module=禁用ngx_http_geo_module支持，这个模块用于创建依赖于客户端ip的变量。
--without-http_map_module=禁用ngx_http_map_module支持，使用任意的键、值 对设置配置变量。
--without-http_split_clients_module=禁用ngx_http_split_clients_module支持，该模块用于基于用户ip地址、报头、cookies划分用户。
--without-http_referer_module=禁用ngx_http_referer_modlue支持，该模块用来过滤请求，报头中Referer值不正确的请求。
--without-http_rewrite_module=禁用ngx_http_rewrite_module支持。该模块允许使用正则表达式改变URI，并且根据变量来转向以及选择配置。如果在server级别设置该选项，那么将在location之前生效，但如果location中还有更进一步的重写规则，location部分的规则依然会被执行。如果这个URI重写是因为location部分的规则造成的，那么location部分会再次被执行作为新的URI，这个循环会被执行10次，最后返回一个500错误。
--without-http_proxy_module=禁用ngx_http_proxy_module支持，http代理功能。
--without-http_fastcgi_module=禁用ngx_http_fastcgi_module支持，该模块允许nginx与fastcgi进程交互，并通过传递参数来控制fastcgi进程工作。
--without-http_uwsgi_module=禁用ngx_http_uwsgi_module支持，该模块用来使用uwsgi协议，uwsgi服务器相关。
--without-http_scgi_module=禁用ngx_http_scgi_module支持，类似于fastcgi，也是应用程序与http服务的接口标准。
--without-http_memcached_module=禁用ngx_http_memcached支持，用来提供简单的缓存，提高系统效率。
--without-http_limit_conn_module=禁用ngx_http_limit_conn_module支持，该模块可以根据条件进行会话的并发连接数进行限制。
--without-http_limit_req_module=禁用ngx_limit_req_module支持，该模块可以实现对于一个地址进行请求数量的限制。
--without-http_empty_gif_module=禁用ngx_http_empty_gif_module支持，该模块在内存中常驻了一个1*1的透明gif图像，可以被非常快速的调用。
--without-http_browser_module=禁用ngx_http_browser_mdoule支持，创建依赖于请求报头的值 。如果浏览器为modern，则$modern_browser等于modern_browser_value的值；如果浏览器为old，则$ancient_browser等于$ancient_browser_value指令分配的值；如果浏览器为MSIE，则$msie等于1。
--without-http_upstream_ip_hash_module=禁用ngx_http_upstream_ip_hash_module支持，该模块用于简单的负载均衡。
--with-http_perl_module=启用ngx_http_perl_module支持，它使nginx可以直接使用perl或通过ssi调用perl。
--with-perl_modules_path= 设定perl模块路径
--with-perl= 设定perl库文件路径
--http-log-path= 设定access log路径
--http-client-body-temp-path= 设定http客户端请求临时文件路径
--http-proxy-temp-path= 设定http代理临时文件路径
--http-fastcgi-temp-path= 设定http fastcgi临时文件路径
--http-uwsgi-temp-path= 设定http scgi临时文件路径
--http-scgi-temp-path= 设定http scgi临时文件路径
--without-http=禁用http server功能
--without-http-cache=禁用http cache功能
--with-mail=启用POP3、IMAP4、SMTP代理模块
--with-mail_ssl_module=启用ngx_mail_ssl_module支持
--without-mail_pop3_module=禁用pop3协议。
--without-mail_iamp_module=禁用iamp协议。
--without-mail_smtp_module=禁用smtp协议。
--with-google_perftools_module=启用ngx_google_perftools_mdoule支持，调试用，可以用来分析程序性能瓶颈。
--with-cpp_test_module=启用ngx_cpp_test_module支持。
--add-module= 指定外部模块路径，启用对外部模块的支持。
--with-cc= 指向C编译器路径。
--with-cpp= 指向C预处理路径。
--with-cc-opt= 设置C编译器参数，指定--with-cc-opt="-I /usr/lcal/include",如果使用select()函数，还需要同时指定文件描述符数量--with-cc-opt="-D FD_SETSIZE=2048"。 (PCRE库）
--with-ld-opt= 设置连接文件参数，需要指定--with-ld-opt="-L /usr/local/lib"。（PCRE库）
--with-cpu-opt= 指定编译的CPU类型，如pentium,pentiumpro,...amd64,ppc64...
--without-pcre=禁用pcre库。
--with-pcre=启用pcre库。
--with-pcre= 指向pcre库文件目录。
--with-pcre-opt= 在编译时为pcre库设置附加参数 。
--with-md5= 指向md5库文件目录。
--with-md5-opt= 编译时为md5库设置附加参数。
--with-md5-asm=使用md5汇编源。
--with-sha1= 指向sha1库文件目录。
--with-sha1-opt= 编译时为sha1库设置附加参数。
--with-sha1-asm=使用sha1汇编源。
--with-zlib= 指向zlib库文件目录。
--with-zlib-opt= 在编译时为zlib设置附加参数。
--with-zlib-asm= 为指定的CPU使用汇编源进行优化。
--with-libatomic=为原子内存的更新操作的实现提供一个架构。
--with-libatomic= 指向libatomic_ops的安装目录。
--with-openssl= 指向openssl安装目录。
--with-openssl-opt= 在编译时为openssl设置附加参数。
--with-debug=启用debug日志。
```

## 第二章 配置语法

## 第三章 默认模块

## 第四章 Nginx的Log

## 第五章 访问控制

### 5.1 Http请求和连接

### 5.2 请求限制与连接限制

###5.3 assess模块配置语法

###5.4 请求限制局限性 

###5.5 基本安全认证 

###5.6 auth模块语法配置 

###5.7 安全认证局限性

# 第二部分 场景实践篇

## 第六章 静态资源WEB服务 

### 6.1 什么是静态资源 

### 6.2 静态资源服务场景 

### 6.3 静态资源服务配置 

### 6.4 客户端缓存 

### 6.5 静态资源压缩 

### 6.6 防盗链 

### 6.7 跨域访问

## 第七章 代理服务 

## 第八章 负载均衡 

## 第九章 缓存服务

# 第三部分 深度学习篇

## 第十章 动静分离 

## 第十一章 rewrite规则 

## 第十二章 Https服务 

### 12.1 HTTPS协议 

### 12.2 配置语法 

### 12.3 Nginx与Https服务 

### 12.4 苹果要求的Https服务

## 第十三章 Nginx与LUA开发 

## 第十四章 进阶模块配置

# 第四部分 架构篇

## 第十五章 场景问题

## 第十六章 Nginx中间件性能优化

### 16.1 如何调试性能优化 

### 16.2 性能优化影响因素 

### 16.3 操作系统性能优化 

### 16.4 Nginx性能优化

## 第十七章 Nginx与安全 

## 第十八章 新版本特性 

## 第十九章 中间件架构设计

01_课程综述

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
        >     1. 带有“=“的精确匹配优先
        >     2. 没有修饰符的精确匹配
        >     3. 正则表达式按照他们在配置文件中定义的顺序
        >     4. 带有“^\~”修饰符的，开头匹配
        >     5. 带有“~” 或“~\*” 修饰符的，如果正则表达式与URI匹配
        >     6. 没有修饰符的，如果指定字符串与URI开头匹配

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

Nginx模块

ngx_http_autoindex_module

- 处理以斜杠字符(' / ')结尾的请求，并生成一个目录列表。

    ```java
    location / {
        autoindex on | off; 			// 启用或禁用列表输出
        autoindex_exact_size on | off;	// 输出文件大小是否是字节
        autoindex_format html | xml | json | jsonp;	// 设置目录列表格式
        autoindex_localtime on | off;	// 列表文件的日期格式
        
    }
    ```

    

