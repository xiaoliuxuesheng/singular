1. **Jenkins安装**

   - **安装前的环境配置**
     - JDK的安装配置
     - Maven的安装配置
     - Gradle的安装配置
     - Git安装

   - **Windows安装**

     - 下载地址

       | 下载说明      | 下载地址                                                     |
       | ------------- | ------------------------------------------------------------ |
       | 官网          | https://jenkins.io/download/                                 |
       | 清华镜像源    | https://mirror.tuna.tsinghua.edu.cn/jenkins/windows-stable/  |
       | War包下载地址 | http://mirrors.jenkins-ci.org/war/latest/jenkins.war         |
       | msi安装包     | http://ftp.yz.yamagata-u.ac.jp/pub/misc/jenkins/windows-stable/ |

     - 启动

       - **第一种方式**：将jenkins.war放到Tomcat\webapps目录下，当启动tomcat的时候

       - **第二种方式**：通过cmd命令窗口，使用Java命令启动jenkins.war

         ```sh
         java -jar jenkins.war
         ```

       - **第三种方式**：通过msi安装，定义启动脚本`run.bat`

         ```sh
         echo "Jenkins CI automation testting"
         java -jar "D:\work\Program Files\Jenkins\jenkins.war"
         pause
         ```

2. **Jenkins配置**

   - 跳过插件安装，新增管理员登陆

   - 插件配置：配置国内镜像（Jenkins > Manage Plugins > Available）

     ```html
     
     ```


   - 下载中文汉化插件

3. 全局环境配置

   - JDK
   - Maven
   - Git

4. **Jenkins用户权限惯例**

   - 下载插件：Role-based Authorization Strategy
   - 开启全局安全配置：Config Global Security | 授权策略 | Role Based Strategy
   - 创建角色赋予权限：Manage and Assign Roles | Manage Roles
     - Global roles：全局角色（为管理员分配的角色）
     - Project roles：项目角色（不用的用户访问的项目限制）
     - Slave role：节点角色（Jenkins主从配置）
   - 创建用户：Manage Users | 新建用户
   - 授予角色：Manage and Assign Roles | Assign Roles
     - Global roles：全局角色
     - Project roles：项目角色
     - Slave role：节点角色

5. Jenkins凭证管理：凭据可以用来存储需要密文保护的数据库密码、Git密码、Docker私有库密码等方Jenkins与第三方应用交互

   - 安装Gredentials Bindings插件：会多一个凭证菜单
   - 凭据类型
     - Username with Passowrd：用户名密码方式的凭据
     - SSH Username with private key：SSH免密登陆
     - Securet file：加密文件
     - Security text：秘钥文本
     - Certificate：证书认证
   - Git凭证
     - 安装Git插件：Git

   

