mysql权限

1. 授权的概述

2. MySQL权限系统:mysql数据库系统表

    - user

        ```sql
        CREATE TABLE `user`
        (
          `Host`                     char(255)       DEFAULT '' COMMENT '主机源',
          `User`                     char(32)        DEFAULT '' COMMENT '用户名',
          `Select_priv`              enum ('N','Y')  DEFAULT 'N',
          `Insert_priv`              enum ('N','Y')  DEFAULT 'N',
          `Update_priv`              enum ('N','Y')  DEFAULT 'N',
          `Delete_priv`              enum ('N','Y')  DEFAULT 'N',
          `Create_priv`              enum ('N','Y')  DEFAULT 'N',
          `Drop_priv`                enum ('N','Y')  DEFAULT 'N',
          `Reload_priv`              enum ('N','Y')  DEFAULT 'N',
          `Shutdown_priv`            enum ('N','Y')  DEFAULT 'N',
          `Process_priv`             enum ('N','Y')  DEFAULT 'N',
          `File_priv`                enum ('N','Y')  DEFAULT 'N',
          `Grant_priv`               enum ('N','Y')  DEFAULT 'N',
          `References_priv`          enum ('N','Y')  DEFAULT 'N',
          `Index_priv`               enum ('N','Y')  DEFAULT 'N',
          `Alter_priv`               enum ('N','Y')  DEFAULT 'N',
          `Show_db_priv`             enum ('N','Y')  DEFAULT 'N',
          `Super_priv`               enum ('N','Y')  DEFAULT 'N',
          `Create_tmp_table_priv`    enum ('N','Y')  DEFAULT 'N',
          `Lock_tables_priv`         enum ('N','Y')  DEFAULT 'N',
          `Execute_priv`             enum ('N','Y')  DEFAULT 'N',
          `Repl_slave_priv`          enum ('N','Y')  DEFAULT 'N',
          `Repl_client_priv`         enum ('N','Y')  DEFAULT 'N',
          `Create_view_priv`         enum ('N','Y')  DEFAULT 'N',
          `Show_view_priv`           enum ('N','Y')  DEFAULT 'N',
          `Create_routine_priv`      enum ('N','Y')  DEFAULT 'N',
          `Alter_routine_priv`       enum ('N','Y')  DEFAULT 'N',
          `Create_user_priv`         enum ('N','Y')  DEFAULT 'N',
          `Event_priv`               enum ('N','Y')  DEFAULT 'N',
          `Trigger_priv`             enum ('N','Y')  DEFAULT 'N',
          `Create_tablespace_priv`   enum ('N','Y')  DEFAULT 'N',
          `ssl_type`                 enum ('','ANY','X509','SPECIFIED') DEFAULT '',
          `ssl_cipher`               blob,
          `x509_issuer`              blob,
          `x509_subject`             blob,
          `max_questions`            int(11) unsigned DEFAULT '0',
          `max_updates`              int(11) unsigned DEFAULT '0',
          `max_connections`          int(11) unsigned DEFAULT '0',
          `max_user_connections`     int(11) unsigned DEFAULT '0',
          `plugin`                   char(64) DEFAULT 'caching_sha2_password',
          `authentication_string`    text COLLATE utf8_bin,
          `password_expired`         enum ('N','Y')       DEFAULT 'N',
          `password_last_changed`    timestamp NULL       DEFAULT NULL,
          `password_lifetime`        smallint(5) unsigned DEFAULT NULL,
          `account_locked`           enum ('N','Y')       DEFAULT 'N',
          `Create_role_priv`         enum ('N','Y')       DEFAULT 'N',
          `Drop_role_priv`           enum ('N','Y')       DEFAULT 'N',
          `Password_reuse_history`   smallint(5) unsigned DEFAULT NULL,
          `Password_reuse_time`      smallint(5) unsigned DEFAULT NULL,
          `Password_require_current` enum ('N','Y')       DEFAULT NULL,
          `User_attributes`          json                 DEFAULT NULL,
          PRIMARY KEY (`Host`, `User`)
        ) ENGINE = InnoDB
        DEFAULT CHARSET = utf8
        COLLATE = utf8_bin
        STATS_PERSISTENT = 0
        ROW_FORMAT = DYNAMIC 
        COMMENT ='Users and global privileges';
        ```

    - db

        ```sql
        CREATE TABLE `db`
        (
          `Host`                  char(255)      DEFAULT '',
          `Db`                    char(64)       DEFAULT '',
          `User`                  char(32)       DEFAULT '',
          `Select_priv`           enum ('N','Y') DEFAULT 'N',
          `Insert_priv`           enum ('N','Y') DEFAULT 'N',
          `Update_priv`           enum ('N','Y') DEFAULT 'N',
          `Delete_priv`           enum ('N','Y') DEFAULT 'N',
          `Create_priv`           enum ('N','Y') DEFAULT 'N',
          `Drop_priv`             enum ('N','Y') DEFAULT 'N',
          `Grant_priv`            enum ('N','Y') DEFAULT 'N',
          `References_priv`       enum ('N','Y') DEFAULT 'N',
          `Index_priv`            enum ('N','Y') DEFAULT 'N',
          `Alter_priv`            enum ('N','Y') DEFAULT 'N',
          `Create_tmp_table_priv` enum ('N','Y') DEFAULT 'N',
          `Lock_tables_priv`      enum ('N','Y') DEFAULT 'N',
          `Create_view_priv`      enum ('N','Y') DEFAULT 'N',
          `Show_view_priv`        enum ('N','Y') DEFAULT 'N',
          `Create_routine_priv`   enum ('N','Y') DEFAULT 'N',
          `Alter_routine_priv`    enum ('N','Y') DEFAULT 'N',
          `Execute_priv`          enum ('N','Y') DEFAULT 'N',
          `Event_priv`            enum ('N','Y') DEFAULT 'N',
          `Trigger_priv`          enum ('N','Y') DEFAULT 'N',
          PRIMARY KEY (`Host`, `Db`, `User`),
          KEY `User` (`User`)
        ) ENGINE = InnoDB
          DEFAULT CHARSET = utf8
          COLLATE = utf8_bin
          STATS_PERSISTENT = 0
          ROW_FORMAT = DYNAMIC COMMENT ='Database privileges';
        ```

    - tables_priv

        ```sql
        CREATE TABLE `tables_priv`
        (
          `Host`        char(255)    DEFAULT '',
          `Db`          char(64)     DEFAULT '',
          `User`        char(32)     DEFAULT '',
          `Table_name`  char(64)     DEFAULT '',
          `Grantor`     varchar(288) DEFAULT '',
          `Timestamp`   timestamp,
          `Table_priv`  set ('Select',
            'Insert','Update','Delete',
            'Create','Drop','Grant',
            'References','Index',
            'Alter','Create View',
            'Show view','Trigger')   DEFAULT '',
          `Column_priv` set ('Select',
            'Insert','Update',
            'References')            DEFAULT '',
          PRIMARY KEY (`Host`, `Db`, `User`, `Table_name`),
          KEY `Grantor` (`Grantor`)
        ) ENGINE = InnoDB
          DEFAULT CHARSET = utf8
          COLLATE = utf8_bin
          STATS_PERSISTENT = 0
          ROW_FORMAT = DYNAMIC COMMENT ='Table privileges';
        ```

        

3. MySQL权限级别

    - 全局权限:

4. 权限的基本操作

    - 全局变量 包括系统的一些基本信息，以及mysql的一些基本配置

        ```sql
        # 查询所有的全局变量,可以不使用global关键字
        SHOW VARIABLES;  
        SHOW GLOBAL VARIABLES;
        
        # 查询单个全局变量
        SHOW GLOBAL VARIABLES LIKE '变量名'
        SELECT @@变量名
        
        # 修改全局变量的值,修改后需要刷新到mysql内存
        SET @@GLOBAL.wait_timeout = 值
        SET GLOBAL  wait_timeout = 值;
        
        FLUSH PRIVILEGES;
        ```

    - 创建用户:新创建用户只有usage权限表示可以连接

        ```sql
        create user 用户名@主机 identified by '密码';
        ```

    - 权限操作

        ```sql
        # 查看用户权限
        show grants for 用户名@'Host值';
        # 授权全局
        grant 权限名称 privilege on 库名.表名 to 用户名@Host源;
        
        # 回收全局权限
        revoke 权限名称 privilege on 库名.表名 to 用户名@Host源;
        ```

        

    