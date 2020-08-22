# 第一章 Docker简介

## 1.1 Docker概述

Docker 是一个开源项目，诞生于 2013 年初，最初是 dotCloud 公司内部的一个业余项目。它基于 Google 公司推出的 Go 语言实现。 项目后来加入了 Linux 基金会，遵从了 Apache 2.0 协议，项目代码在 [GitHub](https://github.com/docker/docker) 上进行维护。

Docker是一个开发、发布和运行应用程序的开放平台。Docker使您能够将应用程序与基础架构分离，以便快速交付软件。有了Docker，可以像管理应用程序一样管理你的基础设施。通过利用Docker快速发布、测试和部署代码的方法，可以显著减少编写代码和在生产环境中运行代码之间的延迟。

## 1.2 Docker说明

1. **Docker架构**：Docker使用C-S架构。Docker客户端与Docker守护进程通信，Docker守护进程负责构建、运行和分发Docker容器。Docker客户端和守护进程可以在同一个系统上运行，也可以将Docker客户端连接到远程Docker守护进程。Docker客户端和守护进程使用REST API，通过UNIX Socket(套接字)或网络接口进行通信，

   <img src="https://s1.ax1x.com/2020/08/22/daHOIS.jpg" alt="daHOIS.jpg" border="0" />

2. **Docker守护进程**：Docker守护进程（dockerd）监听Docker API的请求并管理Docker对象，如镜像(images)、容器(containers)、网络(networks)和卷(volumes)。守护进程还可以与其他守护进程通信以管理Docker服务。

3. **Docker客户端（docker）**：是许多Docker用户与Docker进行交互的主要方式。当您使用docker run等命令时，客户端会将这些命令发送给dockerd，dockerd会执行这些命令。docker命令使用docker API。Docker客户端可以与多个docker守护进程通信。

4. **Docker registry**：用来存储Docker镜像。Docker Hub是任何人都可以使用的公共registry，Docker默认配置为在Docker Hub上查找镜像。您可以运行自己的私有registry。如果您使用Docker数据中心（DDC），它包括Docker Trusted Registry（DTR）。使用docker pull或docker run命令时，将从配置的registry中提取所需的镜像。使用docker push命令时，镜像将被推送到配置的registry中。

5. **Docker对象**：当使用Docker时，您可能正在创建和使用镜像、容器、网络、卷、插件和其他对象。

6. **镜像(image)**：是一个只读模板，包含了创建Docker容器的指导说明。通常，一个镜像基于另一个镜像，并带有一些额外的自定义项。例如，您可以构建一个镜像，它是基于ubuntu镜像，然后再安装Apache web服务器和您的应用程序，并做相关详细配置确保应用能运行。

   - 也可以创建自己的镜像，也可以只使用其他人创建并在docker hub registry中发布的镜像。要构建自己的镜像，需要创建一个Dockerfile，其中包含一些简单的语法，用于定义创建镜像并运行它所需的步骤。Dockerfile中的每条指令都会在镜像中创建一个层。更改Dockerfile并重新生成镜像时，仅重新生成已更改的层。与其他虚拟化技术相比，这是使镜像如此轻量级、小型和快速的原因之一。

7. **容器(container)**：是镜像的可运行实例。您可以使用Docker API或CLI创建、启动、停止、移动或删除容器。您可以将容器连接到一个或多个网络，将存储附加到该容器，甚至可以基于其当前状态创建新镜像。

   - 默认情况下，容器与其他容器及其主机隔离得相对较好。您可以控制容器的网络、存储或其他底层子系统与其他容器或主机的隔离程度。

   - 容器由其镜像以及创建或启动时提供给它的任何配置选项定义。当容器被删除时，对其状态的任何未存储在持久性存储中的更改都将丢失，即创建容器时我们要先规划好确保有用数据是放在持久化的存储上。

8. **联合文件系统(Union file systems)**：是通过创建层来操作的文件系统，这使得它们非常轻量和快速。Docker引擎使用UnionFS为容器提供构建块。Docker引擎可以使用多个UnionFS变体，包括AUFS、btrfs、vfs和DeviceMapper。

9. 

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
    systemctl start docker
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

| docker 指令                                          | 说明                                                         |
| ---------------------------------------------------- | ------------------------------------------------------------ |
| docker images                                        | 列出本地镜像列表<br />  - REPOSITORY：表示镜像的仓库源<br/>  - TAG：镜像的标签<br/>  - IMAGE ID：镜像ID<br/>  - CREATED：镜像创建时间<br/>  - SIZE：镜像大小 |
| docker search 镜像名称                               | 从[Docker Hub](https://hub.docker.com/) 网站来搜索镜像,根据NAME pull镜像<br />  - NAME: 镜像仓库源的名称<br/>  - DESCRIPTION: 镜像的描述<br/>  - OFFICIAL: 是否 docker 官方发布<br/>  - stars: 类似 Github 里面的 star，表示点赞、喜欢的意思。<br/>  - AUTOMATED: 自动构建。 |
| docker pull 镜像名称:镜像Tag                         | 获取一个新的镜像                                             |
| docker rmi 镜像名称 \| 镜像ID                        | 删除镜像                                                     |
| docker commit -m=" " -a=" " e218edb10161 名称:Tag    | -m: 提交的描述信息<br/><br/>-a: 指定镜像作者<br/><br/>e218edb10161：容器 ID<br/><br/>runoob/ubuntu:v2: 指定要创建的目标镜像名 |
| docker build -t 镜像名称:Tag Dockerfile 文件所在目录 | 创建一个新的镜像<br />  - -t ：指定要创建的目标镜像名<br/>  - . ：Dockerfile 文件所在目录 |
| docker tag 镜像ID 重命名:Tag                         | 为镜像添加一个新的标签或修改镜像名称                         |
| docker save -o 路径 标识                             |                                                              |
| docker load -i 镜像文件                              |                                                              |

## 3.2 容器操作

| docker 指令                      | 说明                                                         |
| -------------------------------- | ------------------------------------------------------------ |
| docker run 镜像名称 \| 镜像ID    | 运行镜像生成容器<br />-d 后台运行<br />-p 宿主机端口:容器端口  端口映射<br />--name 容器名称 |
| docker inspect 容器名称 \| ID    | 查看Docker容器详情                                           |
| docker top 容器名称 \| ID        | 看容器内部运行的进程                                         |
| docker ps                        | 查看容器列表<br />-a 查所有<br/>-q 只看ID                    |
| docker logs -f 容器ID            | 查看指定容器的日志后几行                                     |
| docker exec -it 容器ID /bin/bash | 进入容器                                                     |
| docker rm 删除容器               | 删除容器，正在运行的容器不可以删除                           |
| docker stop 容器ID               | 停止容器                                                     |
| docker restart 容器 ID           | 停止的容器可以通过 docker restart 重启                       |
| docker start 容器ID              | 开始运行一个停止的容器                                       |

# 第四章 Docker数据容器卷

## 4.1 数据卷概述

实现数据容器内数据的持久化，数据卷将宿主机的目录映射到容器内的目录中；默认创建的数据容器卷在宿主机的`/var/lib/docker/volumes/数据卷名称/_data`目录中，如果数据容器卷绑定容器目录后自动将容器内的文件复制出来；

## 4.2 数据容器卷的操作

| 容器卷指令                                                  | 说明                           |
| ----------------------------------------------------------- | ------------------------------ |
| docker volume create 数据卷名称                             | 创建数据卷                     |
| docker volume ls                                            | 查询数据卷列表                 |
| docker volume inspect 数据卷名称                            | 查看数据卷详细信息             |
| docker volume remove 数据卷名称                             | 删除数据卷                     |
| docker run -v 数据卷名称:容器内部路径(将容器自带文件带出来) | 使用数据卷不存在时候默认会创建 |
| docker run 宿主机路径:容器内路径(推荐)                      | 使用指定路径作为数据卷         |

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

