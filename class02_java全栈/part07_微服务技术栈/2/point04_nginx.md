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

    

