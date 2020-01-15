# Flyway

## 简介



## 第一部分 SpringBoot单机版

1. 添加依赖

    - maven

        ```xml
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-data-jpa</artifactId>
        </dependency>
        <dependency>
            <groupId>mysql</groupId>
            <artifactId>mysql-connector-java</artifactId>
            <scope>runtime</scope>
        </dependency>
        <dependency>
            <groupId>org.flywaydb</groupId>
            <artifactId>flyway-core</artifactId>
        </dependency>
        ```

    - gradle

        ```groovy
        dependencies {
            compile group: 'org.springframework.boot', name: 'spring-boot-starter-web', version: '2.2.0.RELEASE'
            compile group: 'org.springframework.boot', name: 'spring-boot-starter-data-jpa', version: '2.2.0.RELEASE'
            compile group: 'mysql', name: 'mysql-connector-java', version: '5.1.47'
            compile group: 'org.flywaydb', name: 'flyway-core', version: '6.1.4'
        }
        ```

2. 在项目中初始化SQL脚本目录：<kbd>在`resources`中建立`db/migration`文件夹</kbd>

    - 新增测试文件:`V1__create_person_table.sql`

        ```sql
        create table PERSON
        (
          ID   int          not null,
          NAME varchar(100) not null
        );
        ```

3. 初始化数据，新建flyway数据脚本管理表<kbd>flyway_schema_history</kbd>

    ```sql
    CREATE TABLE `flyway_schema_history`
    (
      `installed_rank` int(11)       NOT NULL,
      `version`        varchar(50)            DEFAULT NULL,
      `description`    varchar(200)  NOT NULL,
      `type`           varchar(20)   NOT NULL,
      `script`         varchar(1000) NOT NULL,
      `checksum`       int(11)                DEFAULT NULL,
      `installed_by`   varchar(100)  NOT NULL,
      `installed_on`   timestamp     NOT NULL DEFAULT CURRENT_TIMESTAMP,
      `execution_time` int(11)       NOT NULL,
      `success`        tinyint(1)    NOT NULL,
      PRIMARY KEY (`installed_rank`),
      KEY `flyway_schema_history_s_idx` (`success`)
    ) ENGINE = InnoDB
      DEFAULT CHARSET = utf8;
    ```

4. 配置flyway

    - 方式一 : 在配置文件中指定

    ```yaml
    spring:
      flyway:
        locations: classpath:/db
        baseline-on-migrate: true
        enabled: true
        url: jdbc:mysql://localhost:3306/case-project?useUnicode=true&characterEncoding=utf-8
        user: root
        password: root
      datasource:
        driver-class-name: com.mysql.jdbc.Driver
        url: jdbc:mysql://localhost:3306/case-project?useUnicode=true&characterEncoding=utf-8
        username: root
        password: root
    ```

    - 方式二 : 使用gradle的Build script

        ```groovy
        flyway {
            url = 'jdbc:mysql://localhost:3306/case-project?useUnicode=true&characterEncoding=utf-8'
            user = 'root'
            password = 'root'
        }
        ```

    - 配置说明

        - baseline-on-migrate：解决新老版本兼容异常 下面是兼容报错警告

    ```java
    public boolean exists() {
        if(!this.tableFallback && this.table.getName().equals("flyway_schema_history")) {
            Table fallbackTable = this.table.getSchema().getTable("schema_version");
            if(fallbackTable.exists()) {
                LOG.warn("Could not find schema history table " + this.table + ", but found " + fallbackTable + " instead. You are seeing this message because Flyway changed its default for flyway.table in version 5.0.0 to flyway_schema_history and you are still relying on the old default (schema_version). Set flyway.table=schema_version in your configuration to fix this. This fallback mechanism will be removed in Flyway 6.0.0.");
                this.tableFallback = true;
                this.table = fallbackTable;
            }
        }
    }
    ```

5. 测试

    - 启动项目执行SQL脚本

    - Gradle的flyway插件

        ```groovy
        plugins {
            id "org.flywaydb.flyway" version "6.1.4"
        }
        ```

        > 使用gradle执行flyway命令
        >
        > ```sh
        > gradle flywayMigrate -i
        > ```

    - Maven的flyway插件

        ```xml
        <plugin>
            <groupId>org.flywaydb</groupId>
            <artifactId>flyway-maven-plugin</artifactId>
            <executions>
                <execution>
                    <phase>generate-sources</phase>
                    <goals>
                        <goal>migrate</goal>
                    </goals>
                </execution>
            </executions>
            <dependencies>
                <dependency>
                    <groupId>mysql</groupId>
                    <artifactId>mysql-connector-java</artifactId>
                    <version>5.1.46</version>
                </dependency>
            </dependencies>
        
            <configuration>
                <driver>com.mysql.jdbc.Driver</driver>
                <url>jdbc:mysql://localhost:3306/case-project</url>
                <user>root</user>
                <password>root</password>
            </configuration>
        </plugin>
        ```

        > 在`mvn install`时 插件会自动执行

## 第二部分  Gradle设置Task

```groovy
task migrateDatabase1(type: org.flywaydb.gradle.task.FlywayMigrateTask) {
    url = 'jdbc:mysql://localhost:3306/case-project?useUnicode=true&characterEncoding=utf-8'
    user = 'root'
    password = 'root'
}

task migrateDatabase2(type: org.flywaydb.gradle.task.FlywayMigrateTask) {
    url = 'jdbc:mysql://localhost:3306/case_project?useUnicode=true&characterEncoding=utf-8'
    user = 'root'
    password = 'root'
}
```

