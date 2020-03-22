# Docker基础

01_前提知识

1. Linux基础
2. 内容大纲
    - 简介与安装
    - 常用命令
    - 镜像
    - 容器卷
    - DockerFile
    - 常用软件安装
    - Docker发布

02_简介

1. 作用说明

03_理念

04_是sm

05_能干什么

06_Docker三要素

1. Linux内核版本必须是64位,内核版本是3.10以上

    ```sh
    uname -r
    cat /exc/redhat-release
    ```

2. Docker架构图

    - Client : 表示
    - Docker 主机
        - 在主机中安装了Docker终端,拉取远程的Docker镜像到本地镜像
        - 本地镜像run之后创建镜像的实例称为容器,一个镜像可以产生多个实例
    - Docker远程容器

3. Docker三大要素

    - 镜像 
    - 容器 : 运行镜像产生的实例称为容器
    - 仓库 : 集中存放镜像的地址,是仓库远程服务器, 仓库中每个镜像都有着不同的标签,仓库分为公开仓库和私有仓库,最大的公开的仓库是 : https://hub.docker.com

07_Docker安装

1. 查看是否已经安装过docker

    ```sh
    yum list installed | grep docker
    ```

2. 如果已经安装过，若需要删除docker

    ```sh
    yum remove -y 需要删除的名称
    ```

3. 安装Docker

    ```sh
    yum install -y docker
    ```

    > -y 表示静默安装

    - 镜像加速配置
        1. 从阿里云获取镜像地址 
        2. 修改docker镜像地址 : /etc/docker/daemon.json
        
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
        
        

4. 启动Docker

    ```sh
    # 启动docker
    systemctl start docker
    # 重启docker
    systemctl restart docker
    ```

5. 停止Docker

    ```sh
    systemctl stop docker
    ```

6. 查看Docker状态

    ```sh
    systemctl status docker
    ```

7. 设置Docker开机启动

    ```sh
    # 设置开机启动
    systemctl enable docker
    # 将指定用户添加到用户组
    usermod -aG docker root
    ```

    