# 第一章 Docker简介



# 第二章 Docker安装

## 2.1 CentOS系统中安装

> https://docs.docker.com/install/linux/docker-ce/centos/

1. 安装的前提条件：需要一个CentOS 7的维护版本。不支持或测试存档版本，必须启用centos-extras存储库。默认情况下启用此存储库

2. 需要卸载掉旧版的Docker：如果yum报告说这些包都没有安装，也没有关系

   ```sh
   sudo yum remove docker \
                     docker-client \
                     docker-client-latest \
                     docker-common \
                     docker-latest \
                     docker-latest-logrotate \
                     docker-logrotate \
                     docker-engine
   ```

3. 安装Docker社区版：大多数用户设置Docker的存储库并从中进行安装，以简化安装和升级任务。这是推荐的方法。一些用户下载RPM包并手动安装它，并完全手动管理升级。这在某些情况下非常有用，比如在没有互联网接入的气隙系统上安装Docker。在测试和开发环境中，一些用户选择使用自动化的方便脚本来安装Docker。

   - 设置存储库

     ```sh
     sudo yum install -y yum-utils \
       device-mapper-persistent-data \
       lvm2
     ```

   - 配置存储库

     ```sh
     sudo yum-config-manager \
         --add-repo \
         https://download.docker.com/linux/centos/docker-ce.repo
     ```

   - 安装

     ```sh
     sudo yum install docker-ce docker-ce-cli containerd.io
     ```

4. 启动docker

   ```sh
   sudo systemctl start docker
   ```

5. 配置docker镜像远程地址

   ```sh
   
   ```

## 2.2 Mac系统中的安装

> https://docs.docker.com/docker-for-mac/install/

## 2.3 Windows系统下的安装

> https://docs.docker.com/docker-for-windows/install/

## 2.4 Ubuntu系统中安装

> https://docs.docker.com/install/linux/docker-ce/ubuntu/

## 2.5 其他LInux系统

> `Debian`：https://docs.docker.com/install/linux/docker-ce/debian/
>
> `Fedora`：https://docs.docker.com/install/linux/docker-ce/fedora/
>
> 其他 `Linux` 发行版：https://docs.docker.com/install/linux/docker-ce/binaries/

# 第三章 Docker常用命令

## 3.1 基本命令

### <font size=4 color=blue>▲ docker version：版本信息</font>

### <font size=4 color=blue>▲ docker info：详细信息</font>

### <font size=4 color=blue>▲ docker --help：帮助命令</font>

- Docker命令格式

  ```sh
  docker [OPTIONS] COMMAND
  ```

- Docker命令选项说明

  ```sh
  --config string				Location of client config files
  -D, --debug					Enable debug mode
  -H, --host list				Daemon socket(s) to connect to
  -l, --log-level string   	Set the logging level
                             		("debug"|"info"|"warn"|"error"|"fatal")
                             		(default "info")
  --tls                		Use TLS; implied by --tlsverify                 --tlscacert string   		Trust certs signed only by this CA 	
  --tlscert string     		Path to TLS certificate file
  --tlskey string      		Path to TLS key file
  --tlsverify          		Use TLS and verify the remote
  -v, --version            	Print version information and quit
  ```

- Docker参数说明

  ```sh
  attach		Attach local standard input, output, and error streams to a 
  				running container
  build       Build an image from a Dockerfile
  commit      Create a new image from a container's changes
  cp          Copy files/folders between a container and the local filesystem
  create      Create a new container
  diff        Inspect changes to files or directories on a container's filesystem
  events      Get real time events from the server
  exec        Run a command in a running container
  export      Export a container's filesystem as a tar archive
  history     Show the history of an image
  images      List images
  import      Import the contents from a tarball to create a filesystem image
  info        Display system-wide information
  inspect     Return low-level information on Docker objects
  kill        Kill one or more running containers
  load        Load an image from a tar archive or STDIN
  login       Log in to a Docker registry
  logout      Log out from a Docker registry
  logs        Fetch the logs of a container
  pause       Pause all processes within one or more containers
  port        List port mappings or a specific mapping for the container
  ps          List containers
  pull        Pull an image or a repository from a registry
  push        Push an image or a repository to a registry
  rename      Rename a container
  restart     Restart one or more containers
  rm          Remove one or more containers
  rmi         Remove one or more images
  run         Run a command in a new container
  save        Save one or more images to a tar archive (streamed to STDOUT by default)
  search      Search the Docker Hub for images
  start       Start one or more stopped containers
  stats       Display a live stream of container(s) resource usage statistics
  stop        Stop one or more running containers
  tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
  top         Display the running processes of a container
  unpause     Unpause all processes within one or more containers
  update      Update configuration of one or more containers
  version     Show the Docker version information
  wait        Block until one or more containers stop then print their exit codes
  ```

- Docker管理命令

  ```sh
  builder     Manage builds
  config      Manage Docker configs
  container   Manage containers
  context     Manage contexts
  image       Manage images
  network     Manage networks
  node        Manage Swarm nodes
  plugin      Manage plugins
  secret      Manage Docker secrets
  service     Manage services
  stack       Manage Docker stacks
  swarm       Manage Swarm
  system      Manage Docker
  trust       Manage trust on Docker images
  volume      Manage volumes
  ```

## 3.2 镜像命令

### <font size=4 color=blue>▲ docker images：本地镜像列表</font>

- 命令格式

  ```sh
  docker images [选项] [容器名称]
  ```

- 常用选项说明

  | 选项       | 作用                    |
  | ---------- | ----------------------- |
  | -a         | ALL，表示查询出所有镜像 |
  | -q         | 值查询镜像ID            |
  | --digests  | 查询镜像摘要信息        |
  | --no-trunc | 显示镜像的完整摘要信息  |

### <font size=4 color=blue>▲ docker search：查询镜像远程仓库</font>

- 命令格式

  ```sh
  docker search [选项] 镜像名称
  ```

- 选项说明

  | 选项        | 作用                        |
  | ----------- | --------------------------- |
  |             |                             |
  | --limit int | 规定每次查询结果数,默认25条 |
  | --no-trunc  | 显示镜像的完整摘要信息      |

### <font size=4 color=blue>▲ docker pull：从远程仓库拉取镜像</font>

- 命令格式

  ```sh
  docker pull 镜像名称[:版本号]
  ```

  > - 如果不选择版本号,默认拉取的版本号是latest

### <font size=4 color=blue>▲ docker rmi：删除本地镜像</font>

- 命令格式

  ```sh
  docker rmi [选项] 镜像名称|镜像ID
  ```

- 常用选项

  | 选项          | 作用                            |
  | ------------- | ------------------------------- |
  | -f, --force   | 强制删除                        |
  | $(docker命令) | 执行docker命令,返回命令执行结果 |

### <font size=4 color=blue>▲ docker inspect：查看镜像详细信息</font>

## 3.3 容器命令

### <font size=4 color=blue>▲ docker run：运行镜像创建容器</font>

- 命令格式

  ```sh
  docker run [选项] 镜像名称[:版本] [命令] [参数...]
  ```

  > 如果不写版本默认版本是latest

- 常用选项说明

  | 选项         | 作用                                                         |
  | ------------ | ------------------------------------------------------------ |
  | -t           | 后台运行容器，并返回容器ID                                   |
  | -i           | 交互模式运行容器，通常与 -t 同时使用                         |
  | -t           | 为容器重新分配一个伪输入终端，通常与 -i 同时使用             |
  | --name 名称  | 为容器指定一个名称                                           |
  | -volume , -v | 绑定一个卷                                                   |
  | -d           | 守护进程的方式启动容器，docker容器后台运行必须有一个前台进程<br />    容器运行的命令不是一直挂起的命令，就会自动退出<br />    最佳解决方案是：将需要启动的容器用前台进程启动 |

### <font size=4 color=blue>▲ docker ps：查询容器</font>

- 命令格式

  ```sh
  docker ps [选项]
  ```

- 常用选项

  | 选项    | 作用                           |
  | ------- | ------------------------------ |
  | -a      | 列出正在运行的和停止运行的容器 |
  | -l      | 列出上一个运行的容器           |
  | -n 数字 | 列出上n次运行的容器            |
  | -q      | 查询容器只返回容器ID           |

### <font size=4 color=blue>▲ docker start：启动容器</font>

- 命令格式

  ```sh
  docker start 容器名称|容器ID
  ```

### <font size=4 color=blue>▲ docker restart：重启容器</font>

### <font size=4 color=blue>▲ docker dtop：优雅关闭容器</font>

### <font size=4 color=blue>▲ docker kill：立即关闭容器</font>

### <font size=4 color=blue>▲ docker rm：删除容器</font>

- 选项说明

  | 选项                             | 说明         |
  | -------------------------------- | ------------ |
  | -f                               | 强制删除     |
  | docker rm -f $(docker ps -qa)    | 删除多个容器 |
  | docker ps -qa \| xargs docker rm | 删除多个容器 |

### <font size=4 color=blue>▲ docker logs：查看容器日志</font>

- 命令格式

  ```sh
  docker logs [选项] 容器名|容器ID
  ```

- 常用选项说明

  | 选项        | 说明                |
  | ----------- | ------------------- |
  | -t          | 加入时间戳          |
  | -f          | 跟随最新日志的 打印 |
  | --tail 数值 | 显示最后多少条      |

### <font size=4 color=blue>▲ docker cp：从容器复制文件</font>

- 命令格式

  ```sh
  docker cp 容器ID:文件路径 宿主机目录路径
  ```

### <font size=4 color=blue>▲ 容器的进入与退出</font>

- 退出容器

  ```sh
  exit		# 退出容器,如果没有守护进程会容器会停止
  ctrl+p+q 	# 退出不停止容器
  ```

- 重新进入容器

  ```sh
  docker exec -it 容器ID 容器内命令		 # 在容器外执行容器内部的命令,将执行结果返回宿主机
  docker attach 容器ID					# 在容器中打开新的终端,并且可以启动新的进程
  ```

### <font size=4 color=blue>▲ docker commit：提交容器副本称为新镜像</font>

- 命令格式

  ```sh
  docker commit -m '描述' -a '作者' 容器ID(自定义过的) 创建的镜像名称[:版本标签] 
  ```

  

# 第四章 Docker镜像

- 联合文件系统
- 可执行的软件包：用来打包软件的运行坏境和基于运行环境的开发软件

# 第五章 Docker数据容器卷

## 5.1 数据卷介绍

- 实现宿主机系统与容器直接的文件共享：使宿主机系统和容器共享同一个目录；
- 数据卷：必须在启动容器之前指定数据卷

## 5.2 容器数据卷的使用

1. 启动容器时候指定创建容器卷 自定义目录

   ```SH
   docker run -v 宿主机目录:容器目录
   ```

2. 容器自动数据卷：运行容器时候使用指定容器卷名称，容器会根据名称映射到容器内，docker会根据容器目录自动创建目录到宿主机，并且将容器内目录中的内容复制到宿主机；

   ```sh
   docker run -v 数据卷别名:容器目录
   ```

   

<font size=4 color=blue>▲ docker run -v：添加容器卷</font>

- 命令格式

  ```sh
  docker run -v 宿主机绝对路径:容器没目录 [其他选项] 镜像标识
  ```

<font size=4 color=blue>▲ 使用docker file添加容器卷</font>

# 第六章 DockerFile解析

## 6.1 DockerFile介绍

## 6.2 DockerFile关键字说明



# 第七章 Docker常用安装



# 第八章  本地镜像发布