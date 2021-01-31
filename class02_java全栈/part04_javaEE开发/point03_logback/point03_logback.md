# 第一章 日志框架介绍

## 1.1 日志框架

| 接口层                         | 实现层                                                       |
| ------------------------------ | ------------------------------------------------------------ |
| jboss-logging                  | 日志框架稍微高级,使用难度较高                                |
| JCL( jakarta commons logging ) | Apache开发的Commons logging日志                              |
| SLF4j                          | ① SLF4j日志接口层是log4j而开发 <br />② JUL是java为了和log4j挣市场开发的 <br />③ log4j 缺陷太多,升级版是logback <br />④ Log4j2 是Apache新开发的日志,功能先进但是没有广泛适配 |

# 第二章 Logback术语

### 1. 日志级别

- 日志级别定义在定义于ch.qos.logback.classic.Level类中：包括：TRACE、DEBUG、INFO、WARN 和 ERROR如果 logger没有被分配级别，那么它将从有被分配级别的最近的祖先那里继承级别。root logger 默认级别是 DEBUG。

### 2. 日志格式

- **格式转换符**：在日志配置中格式转换符需要添加前缀百分号%

  | 日志格式转换符                            | 说明                                                         |
  | ----------------------------------------- | ------------------------------------------------------------ |
  | d{pattern} date{pattern}                  | **输出**日志的打印日志，模式语法与`java.text.SimpleDateFormat` 兼容 |
  | p<br />le<br />level                      | **输出**日志级别。                                           |
  | t thread                                  | **输出**产生日志的线程名。                                   |
  | c{length} <br />lo{length} logger{length} | **输出**日志的logger名，可有一个整形参数，功能是缩短<br />logger名 %logger    == mainPackage.sub.sample.Bar == mainPackage.sub.sample.Bar <br />%logger{0}== mainPackage.sub.sample.Bar == Bar <br />%logger{5}== mainPackage.sub.sample.Bar == m.s.s.Bar |
  | cn contextName                            | **输出**上下文名称。                                         |
  | m<br />msg message                        | **输出**应用程序提供的信息。                                 |
  | n                                         | **输出**平台先关的分行符                                     |

- **格式修饰符**：可选的格式修饰符位于“%”和转换符之间。

  | 格式修饰符            | 说明                                                         |
  | --------------------- | ------------------------------------------------------------ |
  | 减号“-”               | **左对齐**                                                   |
  | 十进制数              | **最小宽度修饰符<br />**如果字符小于最小宽度，则左填充或右填充，默认是左填充（即右对齐）<br />如果字符大于最小宽度，字符永远不会被截断 |
  | 点号"."后面加十进制数 | **最大宽度修饰符<br />**如果字符大于最大宽度，则从前面截断<br />点符号“.”后面加减号“-”在加数字，表示从尾部截断。 |

# 第三章 Logback配置详解

## 3.1 configuration

1. 根节点`<configuration>`，包含下面三个属性

   | 属性       | 说明                                                 |
   | ---------- | ---------------------------------------------------- |
   | scan       | 默认值为true：修改文件后是否被扫描并重新加载         |
   | scanPeriod | 设置监测配置文件是否有修改的时间间隔，默认单位是毫秒 |
   | debug      | 默认值为false：是否打印出logback内部日志信息         |

2. 配置案例

   ```xml
   <configuration scan="true" scanPeriod="60 seconds" debug="false"> 
   　　  <!--其他配置省略--> 
   </configuration>　
   ```

## 3.2 contextName

1. 子节点`<contextName>`：用来设置上下文名称，每个logger都关联到logger上下文用于区分不同应用程序的记录。一旦设置，不能修改。

2. 配置案例

   ```XML
   <configuration scan="true" scanPeriod="60 seconds" debug="false"> 
        <contextName>myAppName</contextName> 
   </configuration>    
   ```

## 3.3 property

1. 子节点`<property>` ：用来定义变量值，它有两个属性name和value，通过<property>定义的值会被插入到logger上下文中，可以使“${}”来使用变量。

   | 属性  | 说明            |
   | ----- | --------------- |
   | name  | 变量的名称<br/> |
   | value | 变量定义的值    |

2. 配置案例

   ```xml
   <configuration scan="true" scanPeriod="60 seconds" debug="false"> 
   　　　<property name="APP_Name" value="myAppName" /> 
   　　　<contextName>${APP_Name}</contextName> 
   </configuration>
   ```

## 3.4 timestamp

1. 子节点`<timestamp>`：将解析配置文件的时间格式化为指定格式，解析完成之后这个时间值才会改变；他有两个属性key和datePattern

   | 属性        | 说明                                        |
   | ----------- | ------------------------------------------- |
   | key         | 标识此<timestamp> 的名字，可用${}获取到该值 |
   | datePattern | 解析配置文件时间的字符模式                  |

2. 配置案例

   ```xml
   <configuration scan="true" scanPeriod="60 seconds" debug="false"> 
       <timestamp key="bySecond" datePattern="yyyyMMdd'T'HHmmss"/> 
       <contextName>${bySecond}</contextName> 
       <!-- 其他配置省略--> 
   </configuration>
   ```

## 3.5 appender

### 1. ConsoleAppender 

- 把日志输出到控制台，有以下子节点

  | 子节点            | 说明                                 |
  | ----------------- | ------------------------------------ |
  | encoder > pattern | 对日志进行格式化                     |
  | target            | 字符串System.out(默认)或者System.err |

- 配置案例

  ```xml
  <configuration> 
      <appender name="记录器名称" class="ch.qos.logback.core.ConsoleAppender"> 
          <encoder> 
              <pattern>%-4relative [%thread] %-5level %logger{35} - %msg %n</pattern> 
          </encoder> 
      </appender> 
  
      <root level="日志记录级别"> 
          <appender-ref ref="记录器名称" /> 
      </root> 
  </configuration>
  ```

### 2. FileAppender

- 把日志添加到文件

  | 子节点            | 说明                                                      |
  | ----------------- | --------------------------------------------------------- |
  | file              | 被写入的文件名，可以是相对目录，也可以是绝对目录          |
  | append            | 默认是true，追加到文件结尾；如果是false是指清空后新增     |
  | encoder > pattern | 对记录事件进行格式化                                      |
  | prudent           | 默认是 false，日志会被安全的写入文件；如果是 true则效率低 |

- 配置案例

  ```xml
  <configuration> 
      <appender name="记录器名称" class="ch.qos.logback.core.FileAppender"> 
          <file>testFile.log</file> 
          <append>true</append> 
          <encoder> 
              <pattern>%-4relative [%thread] %-5level %logger{35} - %msg%n</pattern> 
          </encoder> 
      </appender> 
  
      <root level="DEBUG"> 
          <appender-ref ref="记录器名称" /> 
      </root> 
  </configuration>
  ```

### 3. RollingFileAppender

- **滚动记录文件**，先将日志记录到指定文件，当符合某个条件时（比如按时间滚动、按文件大小滚动），将日志记录到其他文件。有以下子节点：

  | 子节点        | 说明                                                         |
  | ------------- | ------------------------------------------------------------ |
  | file          | 被写入的文件名，可以是相对目录，也可以是绝对目录             |
  | append        | 默认是true，追加到文件结尾；如果是false是指清空后新增        |
  | rollingPolicy | 当发生滚动时，决定RollingFileAppender的行为，涉及文件移动和重命名 |

- **rollingPolicy滚动策略说明** 

  1. TimeBasedRollingPolicy：根据时间来制定滚动策略，既负责滚动也负责出发滚动。有以下子节点：

     | 子节点          | 说明                                                         |
     | --------------- | ------------------------------------------------------------ |
     | fileNamePattern | 滚动后归档的文件命名格式：%d的时间格式，默认格式是 yyyy-MM-dd |
     | maxHistory      | 控制保留的归档文件的最大数量，超出数量就删除旧文件。         |

  2. SizeBasedTriggeringPolicy：查看当前活动文件的大小，如果超过指定大小会告知RollingFileAppender 触发当前活动文件滚动。

     | 子节点      | 说明                           |
     | ----------- | ------------------------------ |
     | maxFileSize | 活动文件的大小，默认值是10MB。 |

  3. SizeAndTimeBasedRollingPolicy：根据日期和大小生成日志

     | 子节点              | 说明                             |
     | ------------------- | -------------------------------- |
     | fileNamePattern     | 必须包含“%i”，表示滚动后文件序号 |
     | maxFileSize         | 活动文件的大小，默认值是10MB。   |
     | maxHistory          | 最大保存时间                     |
     | totalSizeCap        | 最大文件容量                     |
     | cleanHistoryOnStart | 清除历史记录                     |

- 配置案例

  ```xml
  <configuration>    
      <appender name="FILE" class="ch.qos.logback.core.rolling.RollingFileAppender">
          <rollingPolicy class="ch.qos.logback.core.rolling.SizeAndTimeBasedRollingPolicy">
              <FileNamePattern>${LOG_FILE_PATH}/${APP_NAME}.%d{yyyy-MM-dd}.%i.log</FileNamePattern>
              <maxFileSize>5KB</maxFileSize>
              <maxHistory>1</maxHistory>
              <totalSizeCap>2GB</totalSizeCap>
              <cleanHistoryOnStart>true</cleanHistoryOnStart>
          </rollingPolicy>
          <encoder class="ch.qos.logback.classic.encoder.PatternLayoutEncoder">
              <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} [%15thread] %-5level %logger{50} - %msg%n</pattern>
          </encoder>
      </appender>
  </configuration> 
  ```

## 3.6 appender > filter



## 3.7 loger

1. 用来设置某一个包或具体的某一个类的日志打印级别、以及指定`<appender>`。

   | 属性             | 说明                                                |
   | ---------------- | --------------------------------------------------- |
   | name             | 用来指定受此loger约束的某一个包或者具体的某一个类。 |
   | level            | 可选：用来设置打印级别，大小写无关                  |
   | addtivity        | 可选：是否向上级loger传递打印信息。默认是true       |
   | **子标签**       | **说明**                                            |
   | `<appender-ref>` | 标识这个appender将会添加到这个loger。               |

2. 配置案例：根据日志记录器配一个自己的日志，比如可以单独定义个mybatis的日志记录器

   ```xml
   <configuration>    
       <logger name="com.panda.module.mybatis.mapper" level="DEBUG">
           <appender-ref ref="MYBATIS"/>
       </logger>
   </configuration>
   ```

## 3.8 root

1. 它也是`<loger>`元素，但是它是根loger,是所有`<loger>`的上级。只有一个level属性，因为name已经被命名为"root",且已经是最上级了。

   | 属性             | 说明                                            |
   | ---------------- | ----------------------------------------------- |
   | level            | 可选：默认是DEBUG，用来设置打印级别，大小写无关 |
   | **子标签**       | **说明**                                        |
   | `<appender-ref>` | 标识这个appender将会添加到这个loger。           |

2. 配置案例：比如在根logger中添加多个记录器

   ```xml
   <configuration>       
       <root level="INFO">
           <appender-ref ref="STDOUT"/>
           <appender-ref ref="FILE"/>
       </root>
   </configuration>
   ```

# 第四章 SpringBoot Logback

# 第五章 Logback MDC

## 5.1 MDC概述

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>Logback是在logback-classic模块中实现了SLF4J的MDC功能。

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>MDC中管理的数据（简称MDC数据）是以单个线程为单位进行访问的，即对MDC数据的操作（如put, get）只对当前线程有效，所以也永远是线程安全的。在服务端，为每个请求分配一个线程进行处理，所以每个服务端线程处理的请求，都具有唯一的MDC上下文数据。

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>子线程不会自动继承父线程的MDC数据。所以在创建子线程时，可以先调用MDC的getCopyOfContextMap()方法以返回一个Map<String, String>对象，从而获取父线程的MDC数据，然后再在子线程的开始处，最先调用MDC的setContextMap()方法为子线程设置父线程的MDC数据。从而能够在子线程中访问父线程的MDC数据。

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>在使用java.util.concurrent.Executors管理线程时，使用同样的方法让子线程继承主线程的MDC数据。

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>但是，在Web应用中，一个请求可能在不同的阶段被多个线程处理。这时，只是在服务端的处理线程中设置MDC数据，并不能保证请求的某些信息（如用户的认证信息等）总是能够被处理线程访问到。为了在处理一个请求时能够保证某些信息总是可访问，建议使用Servlet Filter，在请求到来时就将信息装入到MDC中，在完成所有的后续处理后，再次通过过滤器时将MDC数据移除。

```java
public class MyFilter implements Filter {
    public void doFilter(ServletRequest request, 
                         ServletResponse response,
                         FilterChain chain) throws IOException, ServletException {
        // ...
            MDC.put(KEY, VALUE);
        // ...
            try {
                chain.doFilter(request, response);
            } finally {
                if (MDC.contains(KEY)) {
                    MDC.remove(KEY);
                }
            }
    }
}
```

## 5.2 MDCInsertingServletFilter

- Logback自带的ch.qos.logback.classic.helpers.MDCInsertingServletFilter能够将HTTP请求的hostname, request URI, user-agent等信息装入MDC，只需要将MDCInsertingServletFilter添加到WEB容器，后续处理过程就可以直接访问如下请求参数的值：

  - req.remoteHost
  - req.xForwardedFor
  - req.method
  - req.requestURI
  - req.requestURL
  - req.queryString
  - req.userAgent

- pattern案例

  ```xml
  <configuration>
      <!-- 彩色日志 -->
      <!-- 彩色日志依赖的渲染类 -->
      <conversionRule conversionWord="clr" converterClass="org.springframework.boot.logging.logback.ColorConverter"/>
      <conversionRule conversionWord="wex"
                      converterClass="org.springframework.boot.logging.logback.WhitespaceThrowableProxyConverter"/>
      <conversionRule conversionWord="wEx"
                      converterClass="org.springframework.boot.logging.logback.ExtendedWhitespaceThrowableProxyConverter"/>
      <!-- 彩色日志格式 -->
      <property name="CONSOLE_LOG_PATTERN"
                value="${CONSOLE_LOG_PATTERN:-%clr(%d{yyyy-MM-dd HH:mm:ss.SSS}){faint} %clr(${LOG_LEVEL_PATTERN:-%5p}) %clr(${PID:- }){magenta} %clr(--){faint} %clr([%15.15t]){faint} %clr(%-40.40logger{39}){cyan} %clr(:){faint} %m%n${LOG_EXCEPTION_CONVERSION_WORD:-%wEx}}"/>/>
  
  
  
      <property 
                name="MDC_LOG_PATTERN" 
                value="IP:%X{req.remoteHost} -url:%X{req.requestURI} -Method:%X{req.method} - QueryString:%X{req.queryString} - device:%X{req.userAgent}  -ips:%X{req.xForwardedFor}  - %m%n "></property>
  
      <appender name="Console" class="ch.qos.logback.core.ConsoleAppender">
          <layout>
              <pattern>${MDC_LOG_PATTERN}</pattern>
          </layout>
      </appender>
  
  
      <root level="INFO">
          <appender-ref ref="Console"/>
      </root>
  </configuration>
  
  ```

## 5.3 自定义MDC Filter实现日志链路

