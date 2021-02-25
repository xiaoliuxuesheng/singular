1. 云计算标准

   - Infrastructure as a Server：基础设施级服务（阿里云、aws）
   - Platform as a Server：平台级服务（新浪云）
   - Software as a Server：软件设施级服务（Office 356）

2. PAAS

   - Docker火热成为了新一代的容器标准，但是Docker容器端口需要与主机端口进行映射，服务关系变得复杂而且效率低下；
   - 资源管理器：管理容器中服务
     - MEsos：Apache开源的分布式资源管理器，软件级管理器，多一层风险
     - DockerSwarm：Docker母公司开发，轻量，功能少
     - k8s：Google公司开源。轻量并且功能丰富

3. k8s：

   - Google：早期便采用了容器架构，公司内部资源管理器是borg系统，
   - Docker火热，Google为了市场份额，用GO语言模仿borg系统开源的一个资源管理器

4. 知识图谱

   - **介绍说明**

     - 发展历史
       - 公有云类型说明
       - 资源管理器对比
       - k8s优势
     - k8s组件
       - Borg组件说明
       - k8s结构说明：网络结构+组件结构
     - k8s中的关键字解释

   - **基础概念**

     - Pod概念：k8s最小的封装集合，可以包含多个容器
       - 自主式Pod
       - 管理器的Pod
         - RS、PC
         - deployment
         - HPA
         - StatefullSet
         - DaemonSet
         - Job、Cronjob
       - 网络发现
       - Pod协同
     - 网络通信模式：pod与pod直接的通讯
       - 网络通信模式说明
       - 组件通讯模式说明

   - **k8s安装**

     - 系统初始化
     - Kubeadm部署安装
     - 常见问题分析

   - **资源清单：导演（k8s）和剧本（资源清单）**

     - k8s中资源的概念
       - 说明是资源
       - 名称空间级别的资源
       - 集群级别的资源
     - 资源清单：yaml语法
     - 通过资源清单编写Pod
     - Pod生命周期
       - InitC
       - Pod phase
       - 容器探针：livenessProbe+readinessProbe
       - Pod hook
       - 重启策略

   - **Pod控制器**

     - 什么是控制器
     - 控制器种类说明
       - ReplicationController和ReplicaSet
       - Deployment
       - DasmonSet
       - Job
       - CronJob
       - StatefulSet
       - Horizontal Pod Autoscaling

   - **服务发现**

     - Service原理
       - Service定义
       - Service常见分类
         - ClusterIP
         - NodePort
         - ExternalName
       - Service实现方式
         - userspace
         - iptables
         - ipvs
     - ingress
       - Nginx
         - HTTP代理范围
         - HTTPS代理访问
         - 使用cookie实现会话关联
         - BasicAuth
         - Nginx 进行重写

   - **存储**

     - configMap：存配置文件
       - 定义概念
       - 创建configMap：使用目录创建、使用文件创建、使用字面值创建
       - Pod中使用ConfigMap：ConfigMap来代替环境变量、ConfigMap设置命令行参数、通过数据卷插件使用ConfigMap
       - configMap热更新：实现演示、更新触发说明
     - Secret：
       - 定义概念：概念说明、分类
       - Service Account
       - Opaque Secret：特殊说明、创建、使用（挂载VOLUME、导出到环境变量）

     - Volume
       - 定义概念：劵的类型
       - emptyDir：说明、用途假设、实验演示
       - hostPath：说明、用途说明、实验演示

     - PV
       - 概念及解释：PV、PVC、类型说明
       - PV：后端类型、PV访问模式说明、回收策略、状态、实例演示
       - PVC：PVC实践演示

   - **调度器**

     - 调度器概念：
       - 概念
       - 调度过程
       - 自定义调度器
     - 调度亲和性
       - nodeAffinity
       - podAntiAffinity
       - 亲和性运算

   - **集群安全机制**

     - 机制说明
     - 认证：HTTP Base、HTTPS
     - 鉴权
       - AlwaysDeny
       - AlwaysAllow
       - ABAC
       - Webbook
       - RBAC
         - RBAC
         - Role and ClusterRole
         - RoleBinding and ClusterRoleBind
         - Resource
         - to Subject
         - 创建系统用户管理
     - 准入控制

   - **HELM**：yum包管理工具

     - HELM概念
       - HELM概念说明
       - 组件构成
       - HELM部署
       - HELM自定义
     - HELM部署实例
       - HELM部署dashboard
       - metrics-server：HPA演示、资源控制（Pod+名称空间）
       - Prometheus
       - EFK

   - **运维**

     - k8s源码修改
     - k8s高可用构建

5. 组件说明

   - 