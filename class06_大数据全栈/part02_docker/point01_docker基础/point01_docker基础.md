# 第一章 Docker简介

## 1.1 Docker概述

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>Docker 是一个开源项目，诞生于 2013 年初，最初是 dotCloud 公司内部的一个业余项目。它基于 Google 公司推出的 Go 语言实现。 项目后来加入了 Linux 基金会，遵从了 Apache 2.0 协议，项目代码在 [GitHub](https://github.com/docker/docker) 上进行维护。

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>Docker是一个开发、发布和运行应用程序的开放平台。Docker使您能够将应用程序与基础架构分离，以便快速交付软件。有了Docker，可以像管理应用程序一样管理你的基础设施（Docker是容器，容器里安装的是应用软件）。通过利用Docker快速发布、测试和部署代码的方法，可以显著减少编写代码和在生产环境中运行代码之间的延迟。

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>Docker容器可以将开发的应用程序和开发依赖的应用软件以及软件所在的系统环境直接打包在一起，并且将Docker容器打包的镜像可以在任何服务器中运行而且可以保障应用程序运行环境一致；  

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

## 5.1 Dockfile介绍

- 镜像的描述文件，可以用来帮助我们自己构建一个自定义镜像
- 可以将自己的应用打包为镜像，将应用使用容器的方式运行
- Dockerfile构建镜像的原理：在操作系统中定义一个目录，在目录中定义名称为Dockerfile的文件，执行docker build命令，Docker服务（Server）会将Dockerfile所在目录作为这次镜像的上下文目录，并且将上下文目录中的所有文件进行打包，Docker服务（Server）收到打包文件后会解析Dockerfile，根据Dockerfile中的指令构建镜像，每执行一条指令构建一个镜像（用户缓存正确的指令结果），执行完成后构成成最终镜像；使用--no-cache参数不使用缓存；

## 5.2 Dockerfile命令

| 指令       | 作用                                                         |
| ---------- | ------------------------------------------------------------ |
| FROM       | 当前镜像是基于哪个镜像的，**第一个指令必须指定**             |
| RUN        | 构建镜像时需要运行的指令                                     |
| EXPOST     | 当前容器对外暴露的端口号                                     |
| WORKDIR    | 构建后的镜像运行为容器时候的登陆的工作目录                   |
| ENV        | 用来构建镜像过程中设置环境变量                               |
| ADD        | 将宿主机加的文件拷贝进镜像且会自动处理URL和解压包            |
| COPY       | 类似add，从构建上下文目录中的文件复制到新的一层镜像的目录位置 |
| VOLUME     | 容器数据卷，用户数据保存和持久化                             |
| CMD        | 指定一个容器启动时需要运行的名<br />Dockerfile中可以定义多个CMD指令，但是只要最后一个会生效 |
| ENTRYPOINT | 记得一个容器启动时要运行的命令                               |

1. FROM：构建自己的镜像是基于哪个镜像的，在构建时候回自动从docker hub拉取这个镜像作为base镜像，所以必须是Dockerfile的第一行指令

   ```dockerfile
   FROM Centos			# 默认会拉取最信版本的镜像
   FROM Centos:7		# 拉取指定版本的镜像
   FROM Centos@degst	# 使用镜像摘要
   ```

2. RUN：构建镜像时候需要执行的命令

   ```dockerfile
   RUN yum install -y vim				# 运行安装vim编辑器
   RUN ["yum","install","-y","vim"]	# 命令的属性格式
   ```

3. EXPOST：镜像运行时需要暴露的端口

   ```dockerfile
   EXPOST 3306
   EXPOST 
   ```

4. WORKDIR：用来为Dockerfile值的任何RUN、CMD、ENDPOINT、COPY、ADD指令设置工作目录，如果WORKDIR不存在，即时它没有任何后续Dockerfile指令中使用，它也会被创建

   ```dockerfile
   WORKDIR /root/workdir	# 如果不存在会自定创建
   WORKDIR workdir			# 如果是相对路径,则改路径与先前WORKDIR指令的路径相对
   ```

5. ADD：从上下文赋值新文件、目录或远程文件url，并将它们添加到指令路径的镜像文件系统中

   ```dockerfile
   ADD home/*	/workdir		# 通配符添加多个文件
   ADD home-?.txt /workdir		# 通配符添加文件
   ADD home.txt workdir		# 拷贝文件到相对目录
   ADD home.tar workdir		# 拷贝文件到相对目录,并减压
   ADD url /workdir			# 远程下载文件到指定目录 
   ```

6. COPY：用来将上下文中目录中指定文件复制到镜像的指定目录中

   ```dockerfile
   COPY home/*	/workdir		# 通配符添加多个文件
   COPY home-?.txt /workdir		# 通配符添加文件
   COPY home.txt workdir		# 拷贝文件到相对目录
   ```

7. VOLUME：定义容器运行时可以挂在到宿主机的目录

   ```dockerfile
   VOLUME ["/data"]
   VOLUME /data/tomcat/webapps
   ```

8. ENV：用来设置构建的环境变量，这个值将在构建阶段中所有后续指令的环境中

   ```dockerfile
   ENV key value		# 定义变量
   WORKDIR $KEY		# 使用变量
   ```

9. ENTRYPOINT：运行容器后会执行的指令，如果docker指令需要覆盖ENTRYPOINT配置的命令，需要指定参数--entrypoint参数

   ```dockerfile
   ENTRYPOINT ls $key/webapps
   docker --entrypoint ls /data		# 覆盖Dockerfile中的ls 并执行ls /data
   ```

10. CMD：在docker指令后执行的cmd指令会覆盖Dockerfile中的cmd指令，主要作用是配合ENTRYPOINT,必须使用过json格式的参数

    ```dockerfile
    CMD ls $key/webapp		# 执行指令
    docker ls /data			# docker命令后的ls会覆盖Dockerfile内的ls
    
    # 配合ENTRYPOINT使用，必须使用过json格式的参数
    ENTRYPOINT ["ls"]			# ENTRYPOINT 只需要指令命令或为命令指定默认参数，
    CMD  ["/data/bb"]			# cmd指令覆盖ENTRYPOINT参数，然后docker指令后覆盖CMD的命令，如果不覆盖会执行CMD命令
    ```

- 构建镜像

  ```sh
  docker build -t 自定义镜像名称:镜像版本 .(表示当前目录)
  ```

- 案例：①开发SpringBoot应用②定义Dockerfile和jar在同一目录

  ```dockerfile
  FROM openjdk:8-jdk
  WORKDIR /app
  COPY x.jar app.jar
  EXPOSE 8081
  ENTRYPOINT ["java","-jar"]
  CMD ["app.jar"]
  ```

- idea中的Docker插件：

# 第六章 Docker Network

## 6.1 简介

## 6.2 



# 第七章 Docker Compose

## 7.1 简介

- Compose项目上Docker官方的开源项目：负责实现对Docker集群的快速编排；（解释一下为什么需要容器编排：使用dokerfile可以额方便的定义一饿单独的应用容器，但是在日常工作中，经常是多个容器相互配合，并且有时候还需要容器间按顺序启动，使用docker compose就可以满足这样的需求）
- Compose定位：定义和运行多个Docker容器的应用，允许用户通过单独的docker-compose.yml模版文件来定义一组相关联的容器作为一个项目。但是Compose做不到特别复杂的工作：如容器的资源调度，由k8s解决；
- Compose中有两个重要概念
  1. 服务（Service）：一个应用的容器，服务可以存在多个；
  2. 项目（Project）：由一组关联应用容器组成的一个完整的业务单元，在docker-copose.yml中定义（可以理解为一个配置文件代表一个项目）

## 7.2 Compose安装

### 1. Windows系统

- DockerDesktop自带docker-compose

### 2. Mac系统

- DockerDesktop自带docker-compose

### 3. Linux系统

- **安装compose方式一**

  1. 下载

     ```sh
     # Github官网
     sudo curl -L https://github.com/docker/compose/releases/download/。。。 /docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
     
     # 国内下载地址
     https://get.daocloud.io/#install-compose
     ```

  2. 安装：是个shell脚本，需要修改下载的文件的执行权限s

     ```sh
     chmod +x /usr/local/bin/docker-compose
     ```

- **安装compose方式二**

  1. 安装pip

     ```sh
     yum -y install epel-release
     yum -y install python-pip
     
     pip --version
     ```

  2. 更新pip

     ```sh
     pip install --upgrade pip
     ```

  3. 安装docker-compose

     ```sh
     pip install docker-compose 
     ```

## 7.3 Compose指令

1. docker-compose使用方式：由于一个docker-compose.yml是一个项目，约定文件名称固定，便于区分，需要将配置文件定义在单独的目录中，将这个文件作为项目；

2. 基本语法

   - version：必须指定，说明项目的版本
   - services：一个配置文件中可以定义多个服务（service），是在这个services的配置项之下；
   - services.<服务名>：服务名称不能重复
   - services.<服务名>.container_name：相当于`run --name`；容器之间通信可以使用这个名称进行通信
   - services.<服务名>.image：当前服务所要使用的镜像，如果镜像不存在会从docker hub拉取，说明镜像和版本
   - services.<服务名>.ports：数组，用于映射端口，host与容器的端口映射，建议使用字符串
   - services.<服务名>.volumes：数组，宿主机和容器数据卷映射，或者容器卷名和容器路径 ；
   - services.<服务名>. networks：指定当前服务使用的网络桥，同一个网络桥的服务可以相互通信
   - services.<服务名>.environment：设置环境变量，可以使用数组可字典两种形式
   - services.<服务名>.env_file：用于替换environment，可以是相对路径或绝对路径；环境变量可以定义再指定配置文件中，配置文件必须是`.env`文件，配置文件中配置格式：key=value；
   - services.<服务名>：
     - build：启动服务时，先将build命令中指定的docker-file打包为镜像然后运行该镜像
       - context：指定上下文目录，是指docker-file所在的目录，相对于yaml文件的目录或绝对路径；
       - dockerfile：指定dockerfile文件名称；
   - services.<服务名>.command：覆盖容器启动后默认执行的命令
   - services.<服务名>.depends_on：解决容器依赖的顺序，代表这个容器的启动必须依赖其他容器，在其他容器启动到一定程度后就会启动，是个数组，可以指定多个服务名；
   - services.<服务名>.healthcheck：检测容器是否允许健康
     - test：[“CMD”， “curl”， “-f”， “检查的URL”]
     - interval：检查间隔时间
     - timeout：超时时间
     - retries：重试次数
   - services.<服务名>.sysctls：修改容器内核参数
   - services.<服务名>.ulimts：指定容器的ulimits限制值，修改容器系统内部进程最大限制
     - nproc：进程数 
     - nofile：
       - soft：
       - hard：
   - volumes：用于声明容器卷，`run -v`
   - volumes.<容器卷名称>：定义服务中使用到的容器卷名称
   - volumes.<容器卷名称>.external.true|false：否使用指定的容器卷，如果没有需要提前创建好
   - network：定义服务中用到的网桥，默认创建的是bridge，同一个网桥的服务可以相互通信  
   - network.<网桥名称>：同一个网桥名称服务可以相互通信
   - network.<网桥名称>.external.true|false：否使用外部指定的网桥，如果没有需要提前创建好

3. 案例：

   ```yaml
   version: "3.8"
   services: 
   	<服务名：如tomcat>: 
   		image: tomcat:8.0-jre8
   		ports: 
   			- "8080:8080"
   		volumes:
   		  - 宿主机路径:容器路径
   		  - 容器卷名称（必须在容器中声明容器卷名称）:容器路径
   		environment:
   			ENV: dev
   		environment:
   			- ENV=DEV
   		command: "redis-server --appendonly yes"
   		
   volumes:
     容器卷名称: <宿主机路径>声明指定的卷名，compose自动创建容器卷但是会新增项目名称
       external:
       	false: 是否使用指定的容器卷，如果没有需要提前创建好
   ```

   > 1. version：
   > 2. services：表示可以定义多个服务
   > 3. services.服务名称：表示定义再服务下的一个服务，服务名唯一
   > 4. services.服务名称.image：表示这个服务所需要的镜像
   > 5. services.服务名称.ports：端口映射数组，服务内可能有多个端口，可以配置多个端口映射，每个映射项使用双引号，防止数字可冒号解析异常
   > 6. services.服务名称.volumes：容器数据卷配置
   > 7. volumes：容器卷数组，每个配置项的key是容器卷名称，value是宿主机路径

4. 使用docker-compose命令执行配置文件：要求执行命令的目录必须要有一个docker-compose.yml文件

   | docker-compose选项     | 说明                                                         |
   | ---------------------- | ------------------------------------------------------------ |
   | -f、--file             | 默认启动文件名称docker-compose.yaml<br />-f <文件名>：指定启动文件 |
   | -p                     | 指定项目的名称，默认用目录名当作项目名称                     |
   | -v                     | 显示版本信息                                                 |
   | **docker-compose参数** | **说明**                                                     |
   | images                 | 列出镜像列表                                                 |
   | top                    | 查看项目中进程信息                                           |
   | logs                   | 查看项目中日志信息                                           |
   | ps                     | 列出项目中目前所有容器                                       |
   | up [serviceId]         | 创建并启动所有容器或指定容器<br />-d：容器后台运行           |
   | exec [serviceId] bash  | 进入到项目中指定容器，并使用bash命令                         |
   | down                   | 停止up命令所启动的容器，并移除网络                           |
   | stop [serviceId]       | 停止项目中的服务，不会移除网络                               |
   | start [serviceId]      | 启动项目中的服务                                             |
   | restart [serviceId]    | 重启项目中的服务                                             |
   | rm [serviceId]         | 删除项目中的某个服务<br /> -f：强制删除<br /> -v：删除服务并删除数据卷 |
   | pause [serviceId]      | 暂停项目中的服务                                             |
   | unpause [serviceId]    | 恢复项目中暂停的服务                                         |

## 7.4 compose示例



# 第八章 Docker常用安装

## 8.1 MySql

## 8.2 Oracle

## 8.3 Redis

##  8.4 MongoDB

## 8.5 Tomcat

## 8.6 Nginx

## 8.7 Jenkins

## 8.8 ElasticSearch

## CI&CD

# 第九章  本地镜像发布

## 9.1 手动

1. 创建DockerFile文件:自定义镜像信息. File文件没有后缀
   - from:当前镜像依赖的文件
   - copy:将相对路径下的内容复制到自定义镜像中
   - workdir:声明镜像的默认工目录,进入容器后的默认位置
   - cmd:需要执行的命令(在workdir下执行的  以最后一个为准)
   - docker build -t 镜像名称:[tag] dockerFile路径 

## 9.2 Docker-Compose

- Compose项目上Docker官方的开源项目，负责实现对Docker容器集群的快速编排。

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

## 9.3 compose&file

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

