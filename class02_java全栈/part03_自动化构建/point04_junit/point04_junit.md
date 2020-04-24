1-1 课程导学
	1. 概述:一整套自动化测试流程
	2. 前提技术:HttpClient + Mock + MyBatis + TestNG + SringBoot + Git
	3. 课程安排
		- 1-3章 课程基本概念介绍
		- 4-14章 全程实战开发
		- 15章 总结:整理技术栈
	4. 实战开发代码
		--> {展示层TestNG + extentReport --> 控制层:HttpClient+TestNG --> 持久层:MyBatis+MySQL} 
		--> Mock:虚拟化 + Jenkins <-- SpringBoot 

5. 安装项目开发流程依次技术学习  -->  最后整合技术  --> 实践是关键

1-2 什么是接口
	1. 服务提供外部访问的标准
	2. 额外课程 JMeter之HTTP协议接口测试

1-3 为什么要接口测试
	- 更容易实现持续集成
	- 自动化测试落地性价比更高,比UI更稳定
	- 大型系统更复杂,系统模块越来越多
	- GUG更容易定位,模块测试
	- 修复成本低,提高效率

1-4 接口自动化测试技能树
	- 开发语言Java
	- 测试框架TestNG + HttpClient:学习基本API
	- Mock技术:模拟接口+集成前后端分离
	- 数据持久层框架:MyBatis

1-5 接口自动化测试落地过程
	- 需求阶段 : 产品+测试 - 项目设计 + 需求
	- 研发接口 : 开发人员 - UI+前端+后端+测试设计+测试开发
	- 测试阶段 : 测试案例 - 坏境搭接+多项测试执行+BUG修复+测试报告(项目背景+执行+问题)
	- 项目上线 : 上线测试 - 

2-1 接口测试范围
	1. 范围也就是功能测试 - 自己查含义与执行方式
		- 等价类划分法 - 边界值分析法 - 错误推断法 - 因果图法
		- 判定表驱动法 - 正交实验法 - 功能图法 - 场景法
	2. 异常测试
		- 数据异常 : NULL 空字符串 数据类型
		- 坏境异常 : 负载均衡+冷热备份+压力测试
		- 性能测试 : 负载测试 + 压力测试 + 并发测试 + 稳定性或可靠性
2-2 接口测试用例设计
	1. 自动化接口测试范围
		- 功能测试 + 数据异常测试
	2. 接口测试用例设计:可以将用例设计映射为一张表
		- 表头设计
			> id : 标识
			> 目标URL : 测试的接口url
			> 入参:
			> 预期结果: 状态码 + 内容
			> 执行状态:0或1
			> 执行时间

-----------------

# CICD DevOps

- Junit
  - Junit4.x
  - Junit5.x
- TestNG
- Mock系列
  - powermock
  - easymock
  - mockito
  - jmock
- Behavior：功能测试
  - concordion
  - cacumber
- 集成工具
  - jenkins -》 git、github、gitflow
- 部署
  - pupet、ansible、soltstack、docker
- 运行监控
  - ElasticSearch、全链路
- 项目管理
  - jira、wiki、snoar、sonar scan

# Unit test

## 1、基本概述

- 是必不可少的，在开发总某个重逻辑的代码中，设计的接口众多，功能繁杂，如果需要启动项目才可以测试，开发代价很大

## 2、特征

- 需要可以实现自动化
- 执行效率需要高
- Unit Test不应该依赖其他的Unit Test，并且不应该依赖外部的资源
- Unit Test执行的时间和空间必须是透明的
- Unit Test需要有意义
- Unit Test需要做到精确、做到源码级别的要求

# Mockito

1. 添加依赖

   ```xml
   <dependency>
       <groupId>junit</groupId>
       <artifactId>junit</artifactId>
       <scope>test</scope>
       <version>4.12</version>
   </dependency>
   <dependency>
       <groupId>org.mockito</groupId>
       <artifactId>mockito-all</artifactId>
       <version>1.10.19</version>
       <scope>test</scope>
   </dependency>
   ```

2. mock外部资源的替身

   - 使用@Runner的方式：Mockito.mock()方法将需要Mock的类传入，框架会为该对象创建代理对象，并且代理其行为

     ```java
     @RunWith(MockitoJUnitRunner.class)
     public class Mock01WithRunner {
         @Test
         public void test01() throws Exception {
             EmployeeMapper mapper = Mockito.mock(EmployeeMapper.class);
             // ... ...
         }
     }
     ```

   - 使用注解Annotation的方式

     ```java
     public class Mock02WithAnno {
         @Before
         public void testInit() throws Exception{
             MockitoAnnotations.initMocks(this);
         }
         
         @Mock
         private EmployeeMapper employeeMapper;
         
         @Test
         public void testMock() throws Exception{
             EmployeeDO aaa = employeeMapper.queryEmpDB("aaa");
         }
         
     }
     ```

     