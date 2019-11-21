# 主页 - wiremock使用文档

> Home - WireMock User Documentation

Wiremock是一个HTTP模拟服务器, 它的核心是web服务器，可以预先准备好为特定请求提供固定的响应(存根)，并捕获传入的请求，以便稍后检查它们(验证)。

> WireMock is an HTTP mock server. At its core it is web server that can be primed to serve canned responses to particular requests (stubbing) and that captures incoming requests so that they can be checked later (verification).
>
> - [ ] prime /praɪm/
>     - n. 初期；青年；精华；全盛时期
>     - adj. 主要的；最好的；基本的
>     - vt. 使准备好；填装
>     - vi. 作准备
> - [ ] canned /kænd/
>     - adj. 罐装的；录音的
>     - v. 装于罐头
> - [ ] stub /stʌb/
>     - n. 存根；烟蒂；树桩；断株
>     - vt. 踩熄；连根拔除
> - [ ] capture /'kæptʃɚ/
>     - n. 捕获；战利品，俘虏
>     - vt. 俘获；夺得；捕捉，拍摄，录制
> - [ ] verification /,vɛrɪfɪ'keʃən/
>     - n. 确认，查证；核实

它还有其他一些有用的特性，包括记录/回放与其他api的交互、注入故障和延迟、模拟有状态行为。

> It also has an assortment of other useful features including record/playback of interactions with other APIs, injection of faults and delays, simulation of stateful behaviour.
>
> - [ ] assortment   /ə'sɔrtmənt/
>     - n. 分类；混合物
> - [ ] feature  /ˈfitʃər/
>     - n. 特色，特征；容貌；特写或专题节目
>     - vt. 特写；以…为特色；由…主演
>     - vi. 起重要作用
> - [ ] interaction  /,ɪntə'rækʃən/
>     - n. 相互作用，相互影响；交流；[数] 交互作用；互动
> - [ ] injection /ɪn'dʒɛkʃən/
>     - n. 注射；注射剂；充血；射入轨道
> - [ ] fault /fɔlt/
>     - n. 故障；[地质] 断层；错误；缺点；毛病；（网球等）发球失误
>     - vt. （通常用于疑问句或否定句）挑剔
>     - vi. 弄错；产生断层
> - [ ] delay /dɪ'le/
>     - n. (Delay) （美）德莱（人名）
>     - n. 延迟的时间；延期；延时；延迟器
>     - v. 延期；（使）耽搁；推迟
> - [ ] simulation /'sɪmjə'leʃən/
>     - n. 仿真；模拟；模仿；假装
> - [ ] stateful /'steitful/
>     - adj. 状态性的；有状态的
> - [ ] behaviour/bɪ'hevjər/
>     - n. 行为；习性；运行状况（=behavior）

它可以被任何JVM应用程序用作库, 或者作为一个独立的进程运行在与测试系统或远程服务器相同的主机上

> It can be used as a library by any JVM application, or run as a standalone process either on the same host as the system under test or a remote server.
>
> - [ ] standalone /'stændə,lon/
>     - n. 脱机
>     - adj. （计算机）独立运行的；（公司）独立的
> - [ ] either  /'iðər/
>     - det. （两者之中的）任何一个；（两者之中的）各方；（用于否定句表示两者）都不
>     - adv. 也；而且
>     - conj. 或者，要么
>     - adj. （两者中） 任一的；两者择一的
>     - pron. （两者中的）任何一个；（两者中的）每个；（用于否定句表示两者）都不
> - [ ] remote /rɪ'mot/
>     - n. 远程
>     - adj. 遥远的；偏僻的；疏远的

所有的Wiremock的特定都是已接近通过REST(JSON格式)接口和他的javaAPI, 此外 存根也可以配置JSON文件

> All of WireMock’s features are accessible via its REST (JSON) interface and its Java API. Additionally, stubs can be configured via JSON files.
>
> - [ ] accessible  /ək'sɛsəbl/
>     - adj. 易接近的；可进入的；可理解的
> - [ ] via  /ˈvaɪə, ˈviə/
>     - prep. 经由，通过；凭借，借助于
> - [ ] additionally  /ə'dɪʃənli/
>     - adv. 此外；又，加之

如果你还有任何这里没有回答你的问题,请发送到发送文件清单

> If you have any questions that aren’t answered here please post them on the mailing list

准备好尝试它么?跳转到开始页面

> Ready to try it? Head to the Getting Started page.

# 下载和安装

> Download and Installation

Wiremock是由两种分布方式,一个是标准的JAR只包含Wiremock ,另一个是脱机丰富的JAR包含Wiremock和他所有的依赖

> WireMock is distributed in two flavours - a standard JAR containing just WireMock, and a standalone fat JAR containing WireMock plus all its dependencies.
>
> - [ ] distributed  /dɪ'strɪbjʊtɪd/
>     - adj. 分布式的，分散式的
> - [ ] flavour  /'fleivə/
>     - n. 香味；滋味
>     - vt. 给……调味；给……增添风趣

独立JAR的大部分依赖项都是阴影的，也就是说，它们隐藏在其他包中。这允许WireMock在其依赖项的版本冲突的项目中使用。独立JAR也是可运行的(参见作为独立进程运行)。

> Most of the standalone JAR’s dependencies are shaded i.e. they are hidden in alternative packages. This allows WireMock to be used in projects with conflicting versions of its dependencies. The standalone JAR is also runnable (see Running as a Standalone Process).
>
> - [ ] shade /ʃed/
>     - n. 树荫；阴影；阴凉处；遮阳物；（照片等的）明暗度；少量、些微；细微的差别
>     - vt. 使阴暗；使渐变；为…遮阳；使阴郁；掩盖
>     - vi. （颜色、色彩等）渐变
> - [ ] alternative /ɔl'tɝnətɪv/
>     - n. 二中择一；供替代的选择
>     - adj. 供选择的；选择性的；交替的
> - [ ] conflict /'kɑnflɪkt/
>     - n. 冲突，矛盾；斗争；争执
>     - vi. 冲突，抵触；争执；战斗

此外，这些jar的版本同时适用于Java 7和Java 8+。

> Additionally, versions of these JARs are distributed for both Java 7 and Java 8+.

Java 7发行版主要针对仍然使用JRE7的Android开发人员和企业Java团队。它的一些依赖项没有设置为最新版本，例如使用Jetty 9.2.x，因为这是最后一个保留Java 7兼容性的次要版本。

> The Java 7 distribution is aimed primarily at Android developers and enterprise Java teams still using JRE7. Some of its dependencies are not set to the latest versions e.g. Jetty 9.2.x is used, as this is the last minor version to retain Java 7 compatibility.
>
> - [ ] enterprise 
> - [ ] minor 
> - [ ] compatibility

Java 8+ build努力跟踪其所有主要依赖项的最新版本。默认情况下，这通常是您应该选择的版本。

> The Java 8+ build endeavours to track the latest version of all its major dependencies. This is usually the version you should choose by default.

## Maven 依赖

> Maven dependencies

- java7

    ```xml
    <dependency>
        <groupId>com.github.tomakehurst</groupId>
        <artifactId>wiremock</artifactId>
        <version>2.24.0</version>
        <scope>test</scope>
    </dependency>
    ```

- Java7 独立包

    ```xml
    <dependency>
        <groupId>com.github.tomakehurst</groupId>
        <artifactId>wiremock-standalone</artifactId>
        <version>2.24.0</version>
        <scope>test</scope>
    </dependency>
    ```

- Java8

    ```xml
    <dependency>
        <groupId>com.github.tomakehurst</groupId>
        <artifactId>wiremock-jre8</artifactId>
        <version>2.24.0</version>
        <scope>test</scope>
    </dependency>
    ```

- Java 8 独立包

    ```xml
    <dependency>
        <groupId>com.github.tomakehurst</groupId>
        <artifactId>wiremock-jre8-standalone</artifactId>
        <version>2.24.0</version>
        <scope>test</scope>
    </dependency>
    ```

## Gradle 依赖

- java 7

    ```java
    testCompile "com.github.tomakehurst:wiremock:2.24.0"
    ```

- Java 独立包

    ```java
    testCompile "com.github.tomakehurst:wiremock-standalone:2.24.0"
    ```

- Java 8

    ```java
    testCompile "com.github.tomakehurst:wiremock-jre8:2.24.0"
    ```

- Java 8 独立包

    ```java
    testCompile "com.github.tomakehurst:wiremock-jre8-standalone:2.24.0"
    ```

## 直接下载

> Direct download
>
> - [ ] direct  /dəˈrekt; daɪˈrekt/
>     adj. 直接的；直系的；亲身的；恰好的
>     vt. 管理；指挥；导演；指向
>     adv. 直接地；正好；按直系关系
>     vi. 指导；指挥

如果你想把Wiremock作为的包运行独立在进程中,你可以下载JAR在这里

> If you want to run WireMock as a standalone process you can [download the standalone JAR from here](http://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-standalone/2.24.0/wiremock-standalone-2.24.0.jar).

# 在JUnit4 规则中

> The JUnit 4.x Rule

JUnit规则为在测试用例中包含WireMock提供了一种方便的方法。它为您处理生命周期，在每个测试方法之前启动服务器，然后停止。

> The JUnit rule provides a convenient way to include WireMock in your test cases. It handles the lifecycle for you, starting the server before each test method and stopping afterwards.
>
> - [ ] afterwards  /'æftɚwɚdz/
>     - adv. 后来；然后

## 基本用法

创建Wiremock变量在你的测试类中他的默认端口是8080

```java
@Rule
public WireMockRule wireMockRule = new WireMockRule();
```



> The rule’s constructor can take an `Options` instance to override various settings. An `Options`implementation can be created via the `WireMockConfiguration.options()` builder:
>
> - [ ] various  

```java
@Rule
public WireMockRule wireMockRule = 
    new WireMockRule(WireMockConfiguration.options().port(8888).httpsPort(8889));
```

查看配置细节

> See [Configuration](http://wiremock.org/docs/configuration/) for details.



## 不匹配的请求

> Unmatched requests

JUnit规则将验证在测试用例过程中收到的所有请求都由配置的存根提供，而不是缺省的404。如果有非VerificationException抛出，则测试失败。这种行为可以通过传递一个额外的构造函数标志来禁用:

> The JUnit rule will verify that all requests received during the course of a test case are served by a configured stub, rather than the default 404. If any are not a `VerificationException` is thrown, failing the test. This behaviour can be disabled by passing an extra constructor flag: