# 第一章 Docker简介

## 1.1 Docker概述

## 1.2 Docker说明



# 第二章 Docker安装

## 2.1 CentOS系统的安装

- 官网安装文档：https://docs.docker.com/install/linux/docker-ce/centos/

---

1. 安装前准备一：检查CentOS 系统的内核版本（Docker 要求 CentOS 系统的内核版本高于 3.10 ）

   ```sh
   uname -r
   ```

2. 使用 root 权限登录 Centos。确保 yum 包更新到最新

   ```sh
   yum update
   ```

3. 查看系统的Docker旧版信息，如果有旧版Docker，需要先卸载掉Docker

   ```sh
   # 查看系统中已安装的Docker相关的yum包
   yum list installed | grep docker
   
   # 假设系统已安装Docker旧版,需要卸载掉旧版的安装新
   sudo yum remove docker \
                     docker-client \
                     docker-client-latest \
                     docker-common \
                     docker-latest \
                     docker-latest-logrotate \
                     docker-logrotate \
                     docker-engine
   ```

4. 下载Docker安装的依赖环境：yum-util 提供yum-config-manager功能，另外两个是devicemapper驱动依赖的

   ```sh
   sudo yum install -y yum-utils device-mapper-persistent-data lvm2
   ```

5. 配置Docker的yum原为阿里云：默认镜像源网速慢

   ```sh
   sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
   ```

6. 我们在更新yum源或者出现配置yum源之后，通常都会使用yum makecache 生成缓存

   ```sh
   yum makecache fast
   ```

7. 可以查看所有仓库中所有docker版本，并选择特定版本安装

   ```sh
   yum list docker-ce --showduplicates | sort -r
   yum list docker-ce.x86_64 --showduplicates | sort -r
   ```

8. 安装Docker：若要安装指定版本，需要安装列表中版本信息中有centos标志的相关包，版本格式如下：中横线分开版本信息

   ```sh
   yum install -y docker-ce-3
   yum install -y docker-ce-17.03.2.ce-1.el7.centos 
   ```

9. 配置Docker容器镜像

   ```sh
   sudo mkdir -p /etc/docker
   sudo tee /etc/docker/daemon.json <<-'EOF'
   {
     "registry-mirrors": ["https://84u6b78t.mirror.aliyuncs.com"]
   }
   EOF
   sudo systemctl daemon-reload
   sudo systemctl restart docker
   ```

10. 启动Docker并设置为开机启动

    ```sh
    systemctl starter docker
    systemctl enable docker
    ```

## 2.2 Mac系统中的安装

- 官网安装文档：https://docs.docker.com/docker-for-mac/install/

## 2.3 Windows系统下的安装

- 官网安装文档：https://docs.docker.com/docker-for-windows/install/

## 2.4 Ubuntu系统中安装

- 官网安装文档：https://docs.docker.com/install/linux/docker-ce/ubuntu/

## 2.5 其他LInux系统

> Debian：https://docs.docker.com/install/linux/docker-ce/debian/
>
> Fedora：https://docs.docker.com/install/linux/docker-ce/fedora/
>
> 其他Linux 发行版：https://docs.docker.com/install/linux/docker-ce/binaries/

# 第三章 Docker常用命令

## 3.1 镜像操作

- docker pull dao.cloud
- docker images
- docker remove xxx
- docker save -o 路径 标识
- docker load -i 镜像文件
- docket tag 标识 名称:版本

## 3.2 容器操作

- docker run 标识|ID|名称

  > - -d 后台运行
  > - -p 宿主机端口:容器端口  端口映射
  > - --name 容器名称

- docker ps 

  > -a 查所有
  >
  > -q 只看ID

- docker logs -f 容器ID : 查看日志后几行

- docker exec -it 容器ID /bin/bash

- docker remove 容器ID

  > $(命令)

- docker stop 容器ID

- docker rm 删除容器

- docker start 容器ID

# 第四章 Docker数据容器卷

- docker cp 文件名称 容器ID:容器内部路径
- 数据卷将宿主机的目录映射到容器内的目录中
  1. 创建数据卷:docker volume create 数据卷名称(创建数据卷后默认会放在一个目录之下/var/lib/docker/volumes/数据卷名称/_data)
  2. 查看数据卷详细信息:docker volume inspect 数据卷名称
     - docker volume ls
  3. 删除数据卷: docker volume remove 数据卷名称
  4. 使用数据卷不存在时候默认会创建:docker run 数据卷名称:容器内部路径(将容器自带文件带出来)
  5. 使用指定路径作为数据卷:docker run 宿主机路径:容器内路径(推荐)
  6. 

# 第五章 DockerFile解析

# 第六章 Docker常用安装

## 6.1 MySql

## 6.2 Oracle

## 6.3 Redis

##  6.4 MongoDB

## 6.5 Tomcat

## 6.6 Nginx

## 6.7 Jenkins

## 6.8 ElasticSearch

## CI&CD

# 第七章  本地镜像发布

## 7.1 手动

1. 创建DockerFile文件:自定义镜像信息. File文件没有后缀
   - from:当前镜像依赖的文件
   - copy:将相对路径下的内容复制到自定义镜像中
   - workdir:声明镜像的默认工目录,进入容器后的默认位置
   - cmd:需要执行的命令(在workdir下执行的  以最后一个为准)
   - docker build -t 镜像名称:[tag] dockerFile路径 

## 7.2 Docker-Compose

- 运行一个Docker镜像,需要大量的参数,可以通过Docker-Compose编写这些参数,可以批量管理容器,只需要通过docker-compose.yml文件维护

  1. 下载docker-compose:github - docker/compose

     ```sh
     https://github.com/docker/compose/releases
     ```

  2. 文件名称和权限修改为可执行文件

     ```sh
     chmod 777 xxx
     ```

  3. docker-compose.yml文件说明

     ```yml
     version: '3.1'
     services: 
     	mysql: 					# 自定义的名称,要管理的服务
     		restart: aways 		# Docker启动,容器随着启动
             image: 				# 镜像位置
             container_name: 	# docker ps看到的容器名称
             ports:
             	- 3306:3306
             environment:		# 指定环境变量
             	属性名: 属性值
             	属性名: 属性值
             volumes:
             	- 宿主机路径:容器路径
     ```

  4. 命令说明:在当前目录中寻找docker-compose.yml文件

     - 基于docker-compose.yml启动管理的容器:docker-compose up -d
     - 关闭并删除容器:docker-compose down
     - docker-compose start | stop | restart
     - docker-compose ps
     - docker-compose logs -f

## 7.3 compose&file

- 使用docker-compose.yml文件以及dockerFile文件在生成自定义镜像的同时启动当前镜像并由docker-compose管理容器

  ```yaml
  version: '3.1'
  services: 
  	mysql: 					# 自定义的名称,要管理的服务
  		restart: aways 		# Docker启动,容器随着启动
          build: 				# 构建自定义镜像
          	context: 		# dockerFile文件路径
          	dockerfile: 	# 指定DockerFile名称
          container_name: 	# docker ps看到的容器名称
          image: 镜像名:[tag]  # build的镜像的名称
          ports:
          	- 3306:3306
          environment:		# 指定环境变量
          	属性名: 属性值
          	属性名: 属性值
          volumes:
          	- 宿主机路径:容器路径
  ```

- 使用docker-copose 执行yml:如果镜像不存在会构建镜像, docker-compose build 构建镜像

- 运行钱重新构建:docker-compose up -d build

