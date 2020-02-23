# 第三章 SpringBoot日志

## 3.1 日志框架的使用原理

1. 首先引用统一的日志接口层
2. 具体使用哪个日志框架 , 只需要导入这个接口层日志的实现类

## 3.2 常见日志

| 接口层                         | 实现层                                                       |
| ------------------------------ | ------------------------------------------------------------ |
| jboss-logging                  | 日志框架稍微高级,使用难度较高                                |
| JCL( jakarta commons logging ) | Apache开发的Commons logging日志                              |
| SLF4j                          | ① SLF4j日志接口层是log4j而开发<br />② JUL是java为了和log4j挣市场开发的<br />③ log4j 缺陷太多,升级版是logback<br />④ Log4j2 是Apache新开发的日志,功能先进但是没有广泛适配 |

- Spring 中默认是 : Commons-logging
- SpringBoot 中默认是 : SLF4j + logback组合

## 3.3 SLF4j的使用

- 系统开发时候,调用的是日持抽象层的方法 : 方法的实现是由抽象日志框架实现的

  ```java
  import org.slf4j.Logger;
  import org.slf4j.LoggerFactory;
  
  public class HelloWorld {
    public static void main(String[] args) {
      Logger logger = LoggerFactory.getLogger(HelloWorld.class);
      logger.info("Hello World");
    }
  }
  ```

  > 需要有Log4j的jar包和 logback的jar包

- 日志记录API : 日志级别由低到高

  ```java
  logger.trace("trace日志");
  logger.debug("debug日志");
  logger.info("info日志");
  logger.warn("warn日志");
  logger.error("error日志");
  ```

  > SpringBoot默认的日志级别是info

- 日志相关配置

  - 使用SpringBoot配置文件修改日志信息

    - 设置日志级别 : logging.level

      ```yaml
      logging:
        level:
          需要设置的日志级别的包: trace
      ```

      > 如果不设置 : 默认是info级别的在控制台输出

    - 设置日志文件 : logging.file  和  logging.path

      ```yaml
      logging:
        path:
        file:
      ```

      > - 如果都不指定这两个设置 : 默认在控制台输出
      > - 如果指定file : 日志则输出到指定文件
      > - 如果指定path : 日志输出到指定文件夹,日志文件名称为spring.log
      >
      > **file和path在设置时候指定一个就可以了**

    - 设置日志输出格式和位置 : logging.pattern.console 和  logging.pattern.file:

      ```yaml
      logging:
        pattern:
          console: 表示输出在控制台时候的日志格式
          file: 表示输出在日志文件时候的日志格式
      ```

## 3.4 SpringBoot中slf4j使用原理

### 1. 默认的日志配置

- SpringBoot中默认使用slf4j为日志抽象层
- SpringBoot中默认使用logback为日志抽象层的实现

### 2. 日志框架的适配问题

- 应用开发时候的日志配置方式

  ```txt
  ① 第一 |--> 应用中引入日志抽象层 : slf4j的依赖jar
  ② 第二 |--> 再引入抽象层是实现框架 : 如logback
  	   |--> 如果需要其他日志框架的实现 : 需要给这个日志框架添加一个适配包,从而可以适配抽象层 	
  ```

- 常用的日志适配包

  ```xml
  ① slf4j-log412.jar : 适配log4j日志框架
  ② slf4j-jdk14.jar : 适配JUL日志框架
  ③ slf4j-simple.jar : 也是slf4j的一个实现
  ④ slf4j-nop.jar : 没有实现的日志实现 
  ```

- **每个日志框架的实现层都有自己的日志配置文件,如果使用日志的实现,则需要使用该实现的自己的配置文件**

### 3. 日志的替换包

- Spring应用开发需要整合其他框架,而其他框架都会有自带的日志包,则在整合开发需要替换多余的日志框架

- 替换方式 : 添加日志框架的替换包

  - 其他框架调用的替换包的API真实记录日志的是slf4j的日志框架完成

- 常见日志框架的替换包

  ```txt
  ① jcl-over-slf4j.jar	: 替换Commons-logging日志框架
  ② log4j-over-slf4j.jar	: 替换log4就日志框架
  ③ jul-slf4j.jar			: 替换JUL日志框架
  ```

### 4. 统一slf4j日志包管理

- 第一 : 排除掉其他系统的日志框架
- 第二 : 添加其他框架的日志替换包
- 第三 : 添加日志框架的适配包
- 第四 : 添加slf4j的日志实现包

## 3.5 SpringBoot日志配置文件

### 1. SpringBoot默认的日志配置

- springboot默认日志配置 : spring-boot依赖中 : logging

### 2. 添加日志配置文件

| 日志框架 | 日志文件名称                                                 |
| -------- | ------------------------------------------------------------ |
| logback  | logback-spring.xml<br/>logback-spring.groovy<br/>logback.xml<br/>logback.groovy |
| Log4j2   | log4j2-spring.xml<br/>log4j2.xml                             |
| JUL      | logging.properties                                           |

- 需要在类路径下添加日志框架自己的日志文件

### 3. 日志文件的profile功能

- 标准日志配置文件默认会被日志框架识别

- 如果给日志配置文件添加spring扩展名 , 则会有SpringBoot加载日志配置,可以使用高级设置

  ```xml
  <springProfile name="dev">
      如果是dev环境,则这个配置会生效
  </springProfile>
  
  <springProfile name="test">
      如果是test环境,则这个配置会生效
  </springProfile>
  
  ```

  > 如果配置文件没有spring扩展名,则这个标签<springProfile>日志框架是不会识别

## 3.6 切换日志框架

### 1. 使用slf4j + log4j日志组合

- 第一 : 排除默认的logback日志框架
- 第二 : 添加日志替换包 , 替换其框架的日志包
- 第三 : 添加log4j的日志适配包

### 2. 使用slf4j + log4j2 日志组合

- 默认使用的日志启动器是 : logging : 底层是slf4j + logback组合

- 使用log4j2 的日志启动器 : 这个启动器和logging启动器只能二选一
  - 第一 : 排除掉logging的日志启动器
  - 第二 : 添加log4j2的日志启动器