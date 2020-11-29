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

## 3.7 logback.xml

### 1. 根节点configuration 

- scan: 当此属性设置为true时，配置文件如果发生改变，将会被重新加载，默认值为true。
- scanPeriod: 设置监测配置文件是否有修改的时间间隔，如果没有给出时间单位，默认单位是毫秒。当scan为true时，此属性生效。默认的时间间隔为1分钟。
- debug: 当此属性设置为true时，将打印出logback内部日志信息，实时查看logback运行状态。默认值为false

### 2. 子节点contextName

- 用来设置上下文名称，每个logger都关联到logger上下文，默认上下文名称为default。但可以使用<contextName>设置成其他名字，用于区分不同应用程序的记录。一旦设置，不能修改。

  ```xml
  <contextName>myAppName</contextName> 
  ```

### 3.子节点property

- 用来定义变量值，它有两个属性name和value，通过<property>定义的值会被插入到logger上下文中，可以使“${}”来使用变量

  ```xml
  <property name="APP_Name" value="myAppName" /> 
  <contextName>${APP_Name}</contextName> 　
  ```

  > - name: 变量的名称
  > - value: 变量定义的值

### 4.子节点timestamp

- 获取时间戳字符串，他有两个属性key和datePattern

  ```xml
  <timestamp key="bySecond" datePattern="yyyyMMdd'T'HHmmss"/> 
  <contextName>${bySecond}</contextName> 
  ```

  > - key: 标识此<timestamp> 的名字
  > - datePattern: 设置解析配置文件的时间转换为字符串的模式，遵循SimpleDateFormat

### 5.子节点appender

> 负责写日志的组件，它有两个必要属性name和class。name指定appender名称，class指定appender的全限定名。

- **ConsoleAppender 把日志输出到控制台，有以下子节点：**

  ```xml
  <appender name="STDOUT" class="ch.qos.logback.core.ConsoleAppender"> 
      <encoder> 
          <pattern>%-4relative [%thread] %-5level %logger{35} - %msg %n</pattern> 
      </encoder> 
  </appender> 
  ```

  > `<encoder>`：对日志进行格式化。
  >
  > `<target>`：字符串System.out(默认)或者System.err

- **FileAppender：把日志添加到文件**

  ```xml
  <appender name="FILE" class="ch.qos.logback.core.FileAppender"> 
      <file>testFile.log</file> 
      <append>true</append> 
      <encoder> 
          <pattern>%-4relative [%thread] %-5level %logger{35} - %msg%n</pattern> 
      </encoder> 
  </appender> 
  ```

  > - `<file>`：被写入的文件名，可以是相对目录，也可以是绝对目录，如果上级目录不存在会自动创建，没有默认值。
  >
  > - `<append>`：默认是true，日志被追加到文件结尾，如果是 false，清空现存文件，。
  >
  > - `<encoder>`：对记录事件进行格式化。
  > - `<prudent>`：默认是 false。如果是 true，日志会被安全的写入文件，即使其他的FileAppender也在向此文件做写入操作，效率低

- **RollingFileAppender：滚动记录文件，先将日志记录到指定文件，当符合某个条件时，将日志记录到其他文件**

  - **class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy**：最常用的滚动策略，它根据时间来制定滚动策略，既负责滚动也负责出发滚动。

    > fileNamePattern：必要节点，包含文件名及“%d”转换符，如：%d{yyyy-MM}。直接使用 %d，默认格式是 yyyy-MM-dd
    >
    > file：子节点可有可无，通过设置file，可以为活动文件和归档文件指定不同位置，
    >
    > maxHistory：可选节点，控制保留的归档文件的最大数量，超出数量就删除旧文件

  - **class="ch.qos.logback.core.rolling.SizeBasedTriggeringPolicy"： **查看当前活动文件的大小，如果超过指定大小会告知RollingFileAppender 触发当前活动文件滚动。只有一个节点

    > maxFileSize：这是活动文件的大小，默认值是10MB。
    >
    > prudent：
    >
    > triggeringPolicy：告知 RollingFileAppender何时激活滚动

  -  **class="ch.qos.logback.core.rolling.FixedWindowRollingPolicy"**：根据固定窗口算法重命名文件的滚动策略

    ```xml
    <appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender"> 
        <rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy"> 
            <fileNamePattern>logFile.%d{yyyy-MM-dd}.log</fileNamePattern> 
            <maxHistory>30</maxHistory> 
        </rollingPolicy> 
        <encoder> 
            <pattern>%-4relative [%thread] %-5level %logger{35} - %msg%n</pattern> 
        </encoder> 
    </appender> 
    ```

    > minIndex：窗口索引最小值
    >
    > maxIndex：窗口索引最大值，当用户指定的窗口过大时，会自动将窗口设置为12。
    >
    > fileNamePattern：必须包含“%i”例如，假设最小值和最大值分别为1和2，命名模式为 mylog%i.log,会产生归档文件mylog1.log和mylog2.log

### 6. 子节点logger

- 用来设置某一个包或具体的某一个类的日志打印级别、以及指定<appender>。<logger>仅有一个name属性，一个可选的level和一个可选的addtivity属性。包含零个或多个<appender-ref>元素，标识这个appender将会添加到这个logger。
  - name: 用来指定受此loger约束的某一个包或者具体的某一个类。
  - level: 用来设置打印级别，大小写无关：TRACE, DEBUG, INFO, WARN, ERROR, ALL和OFF，还有一个特殊值INHERITED或者同义词NULL，代表强制执行上级的级别。 如果未设置此属性，那么当前loger将会继承上级的级别。
  - addtivity: 是否向上级logger传递打印信息。默认是true。可以包含零个或多个<appender-ref>元素，标识这个appender将会添加到这个logger。

- 常用logger实例

  ```xml
  <!-- show parameters for hibernate sql 专为 Hibernate 定制 -->
  <logger name="org.hibernate.type.descriptor.sql.BasicBinder" level="TRACE" />
  <logger name="org.hibernate.type.descriptor.sql.BasicExtractor" level="DEBUG" />
  <logger name="org.hibernate.SQL" level="DEBUG" />
  <logger name="org.hibernate.engine.QueryParameters" level="DEBUG" />
  <logger name="org.hibernate.engine.query.HQLQueryPlan" level="DEBUG" />
  
  <!--myibatis log configure-->
  <logger name="com.apache.ibatis" level="TRACE"/>
  <logger name="java.sql.Connection" level="DEBUG"/>
  <logger name="java.sql.Statement" level="DEBUG"/>
  <logger name="java.sql.PreparedStatement" level="DEBUG"/>
  ```

  

### 7. 子节点root

- 它也是<logger>元素，但是它是根loger,是所有<loger>的上级。只有一个level属性，因为name已经被命名为"root",且已经是最上级了。可以包含零个或多个<appender-ref>元素，标识这个appender将会添加到这个logger。
  - level: 用来设置打印级别，大小写无关：TRACE, DEBUG, INFO, WARN, ERROR, ALL和OFF，不能设置为INHERITED或者同义词NULL。 默认是DEBUG。