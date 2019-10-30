# 第二章 Redis安装

## 1.1 Linux系统安装Redis

1. 配置编译环境

    ```sh
    # 查看gcc版本,检查系统gcc是否存在
    gcc -v     
    
    # yum 安装gcc
    yum install gcc
    ```

2. 下载Redis : [Redis官网](https://redis.io)

    ```sh
    wget http://download.redis.io/releases/redis-xxx.tar.gz
    ```

3. 解压并准备安装包

    ```sh
    # wget 默认下载在当前目录,软件安装推荐在/usr/local目录中
    tar -xzvf redis-xxx.tar.gz
    
    # 解压在/usr/local目录中给解压目录创建软连接或者更改安装包名称
    ln -s redis-xxx redos
    或者
    mv redis-xxx redis
    ```

4. 安装与软件说明

    ```sh
    # 进入Redis源码包
    cd redis
    
    # 安装Redis,安装的redis软件会在/usr/local/bin目录中
    make && make install
    
    # 软件说明
    redis-server		# Redis服务器
    redis-cli			# Redis服务端窗口
    redis-check-rdb		# RedisRDB文件修复
    redis-check-aof		# RedisAOF文件修复
    redis-benchmark		# Redis性能测试
    redis-sentinel		# Redis哨兵服务
    ```

5. 启动Redis三种方式

    ```sh
    # 方式一 : 默认启动
    redis-server
    
    # 方式二 : 参数命令启动
    redis-server --port 6380		# Redis服务器
    
    # 方式三 : 配置文件说明 默认配置文件在Redis安装包中:redis.conf
    redis-server redis.conf	
    ```

6. Redis工具链接redis服务器

    ```sh
    # 查看Redis是否启动
    ps -ef | grep redis
    netstart -antpl | grep redis
    redis-cli -h IP号 -p 端口 ping
    
    # CentOS7查看Redis主机的端口是否开放
    firewall-cmd --list-ports
    
    # 外部主机查看Redis主机端口是否开放
    telnet IP 端口		# 在windward中查看Redis是否端口开启
    ```

    ```sh
    # Linux防火墙扩展
    # 1.查看已开放的端口
    firewall-cmd --list-ports
    
    # 2.开放端口
    firewall-cmd --zone=public --add-port=6379/tcp --permanent
    
    # 3.开放后需要要重启防火墙才生效
    firewall-cmd --reload
    
    # 3.关闭端口（关闭后需要要重启防火墙才生效）
    firewall-cmd --zone=public --remove-port=6379/tcp --permanent
    
    # 4.开机启动防火墙
    systemctl enable firewalld
    
    # 5.禁止防火墙开机启动
    systemctl disable firewalld
    
    # 6.开启防火墙
    systemctl start firewalld
    
    # 7.停止防火墙
    systemctl stop firewalld
    ```

## 1.2 Windows系统安装Redis

1. 下载Windows版本的Redis安装包 : [Github官网下载msi版本](https://github.com/microsoftarchive/redis/releases)

2. 安装Redis-xxx.mis并检查服务

    ```sh
    # 将redis-server配置为Windows服务
    redis-server.exe --service-install redis.windows.conf
    
    # 其他Redis的Windows命令
    redis-server --service-uninstall			# 卸载服务
    
    redis-server --service-start				# 开启服务
    
    redis-server --service-stop					# 停止服务
    
    redis-server --service-name name			# 重命名服务
    ```

3. **建议在使用Redis时候手动启动Redis服务器**

## 1.3 Mac安装Redis

## 1.4 Docker安装Redis