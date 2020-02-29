# 第一章 持续继承与Jenkins

## 1.1 软件开发周期

- 需求分析 ---> 设计 --->  实现编码  --->   测试  ---> 升级

## 1.2 软件开发模型

1. 瀑布模型
2. 敏捷模型与持续继承

## 1.3 Jenkins介绍

1. 特点

# 第二章 Jenkins安装与持续继承配置

## 2.1 Gitlib的安装

## 2.2 Jenkins的安装

1. 启动

   ```sh
   docker run -d --name jenkins_01 -p 8080:8080 -p 50000:50000 -p 45000:45000 -v /home/jenkins/jenkins_home:/var/jenkins_home e54fbc2a5085
   ```
   
   ```sh
   docker run -d --name jenkins_03 -p 8080:8080 -p 50000:50000 -p 45000:45000 -v /home/jenkins/jenkins_home:/var/jenkins_home -v /usr/lib/jvm/java-1.8.0-openjdk:/var/jenkins_home/java8 -v /opt/apache-maven-3.6.3:/var/jenkins_home/maven3.6.3 e54fbc2a5085
   ```
   
   
   
2. 访问

   ```sh
   http://120.27.22.124:8080/
   ```

3. 输入密码

   ```sh
   cat /jenkins_home/secrets/initialAdminPassword
   ```

4. 选择插件安装，因为默认是Jenkins官网下载插件，一般是安装不成功的，需要首先跳过插件的安装，在安装成功后手动配置国内镜像地址安装插件，选择无

5. 配置用户名和密码

   ```sh
   用户名:liuxiaodong
   密码:jenkins03lxd
   ```

6. 插件管理

   - 修改插件地址配置

     <img src="./imgs/image-20200229212235550.png" alt="image-20200229212235550" style="zoom: 50%;" />

     - 首先点击Available等待插件加载完成,加载完成后再/jenkins_home/updates目录中会生成default.json文件,在这个文件中记录的是这些插件在国外的地址

![image-20200229212450168](./imgs/image-20200229212450168.png)



- 修改default文件

  ```sh
  $ sed -i 's/http:\/\/updates.jenkins-ci.org\/download/https:\/\/mirrors.tuna.tsinghua.edu.cn\/jenkins/g' /home/jenkins/jenkins_home/updates/default.json
  
  
  $ sed -i 's/http:\/\/www.google.com/https:\/\/www.baidu.com/g' /home/jenkins/jenkins_home/updates/default.json
  ```

- 修改ad

  ```sh
  https://mirrors.tuna.tsinghua.edu.cn/jenkins/updates/update-center.json
  ```

- 重启Jenkins

  ```sh
  http://120.27.22.124:8080/restart
  ```

## 2.3 插件安装

1. Localization: Chinese (Simplified)：中文汉化Jenkins



## 2.4 用户权限管理

1. 安装Role-based Authorization Strategy插件

2. 在全局安全策略中启用插件

   ![image-20200229214822783](./imgs\image-20200229214822783.png)

3. 在管理菜单中指定角色

   ​	![image-20200229215130828](./imgs/image-20200229215130828.png)

   - 管理角色

![image-20200229215226716](./imgs/image-20200229215226716.png)

- 角色管理,, 添加角色

  - **Global roles**:管理员
  - Item roles:项目分配:匹配项目时候前缀后的 点. 必须要  * 表示任意字符串
  - Node roles:Jenkins主从角色

- 添加用户分配角色

  ![image-20200229220110374](./imgs/image-20200229220110374.png)

  - 添加用户

    ```sh
    jenkins_panda/root
    
    jenkins_com/root
    ```

  - 为角色分配角色

  ## 2.5 Jenkins凭证管理

  1. 安装插件:Credentials Binding, 左侧会多一个凭证管理菜单

     ![image-20200229223604515](./imgs/image-20200229223604515.png)

     - 了解凭证类型

  2. 安装Git插件 并且在服务器中安装Git工具

  3. 添加Git的用户密码凭证

  4. 在项目中配置Git

     ![image-20200229224749842](./imgs/image-20200229224749842.png)

     ![image-20200229225011066](./imgs/image-20200229225011066.png)

​	

![image-20200229225121024](./imgs/image-20200229225121024.png)



- SSH凭证管理
  - Git服务器存放公钥
  - Jenkins存放私钥

## 2.5 jenkins 全局配置JKD与Maven

1. 配置JDK

   ![image-20200229230945798](./imgs/image-20200229230945798.png)

   - 新增JDK

     