# 第一章 SpringBoot入门

## 1.1 SpringBoot简介

- 官网 : 可以快捷的建立产品级功能的应用
- 嵌入式的Servlet容器,应用无需打成war包在部署
- SpringBoot是整合Spring技术栈,内置大量场景启动器,实现自动依赖和版本管理
- 内置大量的自动配置,简化开发
- 准生产环境的运行时应用监控
- 与云计算天然集成

## 1.2 SringBoot与微服务

## 1.3 学习环境约束

- JDK1.8
- Mavne 3.X
- IDEA
- SpringBoot 1.5.9 release

## 1.4 SpringBoot的helloworld

- 使用IDEA可以快速创建SpringBoot应用
  - 添加SpringBoot相关依赖与WEB启动器
  - 添加主程序,添加main方法
  - 创建Controller标志的类,并启动主程序
  - 访问测试

## 1.5 SpringBoor打包插件

```pom
spring-boot-maven-plugin
```

## 1.6 SpringBoot的场景启动器

- 场景启动器是整合了一个模块的所有的依赖的组合

## 1.7 SpringBoot配置细节

### 1. @SpringBootApplication

- 用于指定主配置类 : 用于启动SpringBoot应用
- 是一个组合注解

### 2. @SpringBootConfiguration

- 表示这个类是SpringBoot的配置类
- 底层是Spring的注解 : @Configuration (这个配置类用于替换传统的配置文件)
- 配置类也是Spring容器中的组件

### 3. @EnableAutoConfiguration

- 表示开启自动配置 : 扫描组件并自动配置
  - **@AutoConfigurationPackage** : 自动配置包
  - **@Import({Registrar.class})** : Spring底层注解 : 导入主启动类的包以及子包下的组件

### 4. @Import({EnableAutoConfigurationImportSelector.class})

- 导入组件选择器 : 将所有需要导入的组件以全类名的方式导入
- 最终会给容器中导入 自动配置类 : 将导入的场景并完成自动配置

- 导入的是 `META-INF`下的spring.factories 中获取的组件

- 自动配置都在 : org-springframework.spring.boot.aotoconfiguration包下

