# 说明

​		CommandLineRunner还是ApplicationRunner，它们的目的都是在服务启动之后执行一些操作。如果需要获取命令行参数时则建议使用ApplicationRunner。

# 方式一 : CommandLineRunner

## 1. 定制启动类

- 新建启动类实现CommandLineRunner接口

    ```java
    @Component
    @Order(value=1)
    public class Task implements CommandLineRunner{
        @Override
        public void run(String... args) throws Exception {
            logger.info("服务已启动，执行command line runner。");
        }
    }
    ```

    - <kbd>@Component</kbd> : 需要将启动类加入Spring容器，可以被启动类扫描到
    - <kbd>@Order(value=1)</kbd> : 可以定义多个启动类，需要指定启动类的执行顺序

## 2. 参数处理

- SpringBoot项目打包为Jar包时启动运行时候需要使用命令行命令，run()方法有个可变参数args，这个参数是用来接收命令行参数的

    ```sh
    java -jar xxx.jar --param=xxx
    ```

    > run()方法有个可变参数args可以接收到参数 `args[0] = --param=xxx`

# ApplicationRunner

## 1. 定义启动类

```java
@Component
public class TaskApp implements ApplicationRunner {
    @Override
    public void run(ApplicationArguments args) throws Exception {
        logger.info("获取到参数: " + );
    }
}
```

- <kbd>@Component</kbd> : 需要将启动类加入Spring容器，可以被启动类扫描到

## 2. 参数处理

- ApplicationRunner会封装命令行参数，可以很方便地获取到命令行参数和参数值。

    ```sh
    java -jar xxx.jar --param=xxx
    ```

    > run()方法有个可变参数args可以接收到参数 `args.getOptionValues("param")` 得到`xxx`





