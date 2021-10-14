# 第一部分 Hibernate基础

## 第一章 Hibernate 入门

### 1.1 持久化概述

1. 持久化框架：将应用中产生的数据保存到数据库的操作称为持久化；
2. Hibernate是一个ORM框架
   - ORM：Object Relation Mapping对象关系映射
   - ORM思想：将关系型数据库中一行数据映射为一个Java对象，程序员可以把对Java对象的操作映射为对数据库的操作
   - ORM元数据库：用来描述数据库和对象之间的映射关系。
3. 常用的持久化框架
   - Hibernate
   - SpringBootJPA
   - SpringBootJDBC
   - MyBatis

### 1.2 Hello World

1. 核心概念说明

   - hibernate.cfg.xml：默认位于项目跟目录，是Hibernate默认主配置文件名称；

     ```xml
     <?xml version='1.0' encoding='utf-8'?>
     <!DOCTYPE hibernate-configuration PUBLIC
         "-//Hibernate/Hibernate Configuration DTD//EN"
         "http://www.hibernate.org/dtd/hibernate-configuration-3.0.dtd">
     <hibernate-configuration>
       <session-factory>
         <property name=""></property>
         <mapping resource=""/>
       </session-factory>
     </hibernate-configuration>
     ```

   - Xxx.hbm.xml：xml格式的ORM映射关系配置表

     ```xml
     <?xml version="1.0" encoding="UTF-8"?>
     <!DOCTYPE hibernate-mapping PUBLIC
             "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
             "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">
     <hibernate-mapping>
         <class name="" table="">
             <id name="" type="">
                 <column name="" />
                 <generator class=""></generator>
             </id>
             <property name="" type="">
                 <column name="" length=""  />
             </property>
         </class>
     </hibernate-mapping>
     ```

2. 入门案例说明

   - 新建Maven项目，添加Hibernate基础依赖

     ```xml
     <dependency>
       <groupId>org.hibernate</groupId>
       <artifactId>hibernate-core</artifactId>
       <version>5.3.10.Final</version>
     </dependency>
     <dependency>
       <groupId>mysql</groupId>
       <artifactId>mysql-connector-java</artifactId>
       <version>8.0.16</version>
     </dependency>
     <dependency>
       <groupId>junit</groupId>
       <artifactId>junit</artifactId>
       <version>4.12</version>
       <scope>test</scope>
     </dependency>
     <dependency>
       <groupId>org.projectlombok</groupId>
       <artifactId>lombok</artifactId>
       <version>1.18.8</version>
     </dependency>
     ```

   - 新建持久化测试Java实体类HaUser：由Hibernate自动完成数据库生成

     ```java
     @Getter
     @Setter
     @ToString
     public class HaUser {
         private Integer id;
         private String loginName;
         private String loginPwd;
         private String name;
         private String address;
         private String phone;
         private String mail;
     }
     ```

   - 新建数据库实体类ORM关系映射配置文件

     ```xml
     <?xml version="1.0" encoding="UTF-8"?>
     <!DOCTYPE hibernate-mapping PUBLIC
             "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
             "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">
     <hibernate-mapping>
         <class name="com.hibernate.demo01.entity.HaUser" table="ha_user">
             <id name="id" type="java.lang.Integer">
                 <column name="id" />
                 <generator class="native"></generator>
             </id>
             <property name="loginName" type="java.lang.String">
                 <column name="login_name" length="50"  />
             </property>
             <property name="loginPwd" type="java.lang.String">
                 <column name="login_pwd" length="16"  />
             </property>
             <property name="name" type="java.lang.String">
                 <column name="name" length="16"  />
             </property>
             <property name="address" type="java.lang.String">
                 <column name="address" length="16"  />
             </property>
             <property name="phone" type="java.lang.String">
                 <column name="phone" length="16"  />
             </property>
             <property name="mail" type="java.lang.String">
                 <column name="mail" length="16"  />
             </property>
         </class>
     </hibernate-mapping>
     ```

   - 新建Hibernate主配置文件，并设置数据库相关属性

     ```xml
     <?xml version='1.0' encoding='utf-8'?>
     <!DOCTYPE hibernate-configuration PUBLIC
         "-//Hibernate/Hibernate Configuration DTD//EN"
         "http://www.hibernate.org/dtd/hibernate-configuration-3.0.dtd">
     <hibernate-configuration>
       <session-factory>
         <property name="hibernate.connection.driver_class">com.mysql.cj.jdbc.Driver</property>
         <property name="hibernate.connection.url">jdbc:mysql://127.0.0.1:3306/xlxs_hibernate</property>
         <property name="hibernate.connection.username">root</property>
         <property name="hibernate.connection.password">root</property>
     
         <property name="hibernate.dialect">org.hibernate.dialect.MySQL8Dialect</property>
         <property name="hibernate.hbm2ddl.auto">create</property>
         <property name="hibernate.show_sql">true</property>
         <property name="hibernate.format_sql">true</property>
         <mapping resource="com/hibernate/demo01/entity/HaUser.hbm.xml"/>
       </session-factory>
     </hibernate-configuration>
     ```

   - 新建测试类，测试Hibernate自动映射

     ```java
     @Test
     public void test() {
       ServiceRegistry sr = new StandardServiceRegistryBuilder().configure().build();
       SessionFactory fa = new MetadataSources(sr).buildMetadata().buildSessionFactory();
     
       HaUser user = new HaUser();
       user.setLoginName("zhangsan");
       user.setLoginPwd("123456");
       user.setName("张三");
       user.setAddress("江苏南京");
       user.setPhone("0123456789");
       user.setMail("123@qq.com");
       Session session = sessionFactory.openSession();
       session.save(user);
     }
     ```

### 1.2 配置说明

1. 主配置文件：hibernate.cfg.xml

   | 配置项                                     | 配置值                                            |
   | ------------------------------------------ | ------------------------------------------------- |
   | property.hibernate.connection.driver_class |                                                   |
   | property.hibernate.connection.url          |                                                   |
   | property.hibernate.connection.username     |                                                   |
   | property.hibernate.connection.password     |                                                   |
   | property.hibernate.dialect                 | create-drop<br />create<br />update<br />validate |
   | property.hibernate.hbm2ddl.auto            |                                                   |
   | property.hibernate.show_sql                |                                                   |
   | property.hibernate.format_sql              |                                                   |
   | mapping.resource                           |                                                   |

2. 对象关系映射文件：Xxx.hbm.xml

   | class配置项      | 配置说明                           |
   | ---------------- | ---------------------------------- |
   | name             | Java全类名                         |
   | table            | Java对象映射的表名，缺省为Java类名 |
   | **id配置**       | **配置说明**                       |
   | column           |                                    |
   | generator        |                                    |
   | **property配置** | **配置说明**                       |
   | column           |                                    |

3. 对象关系映射相关注解

   | Hibernate注解 | 注解说明 |
   | ------------- | -------- |
   |               |          |

## 第二章 Hibernate核心API

## 2.1 ServiceRegistry

- 

## 2.2 SessionFactory

## 2.3 Session

1. 概述：

   - Session是应用程序与数据库交互操作的一个单线程对象，Session中维护着一个一级换缓存；
   - Hibernate中持久化对象都维护在Session的一级缓存中；
   - Session封装着与数据库操作的相关API
   - Session操作的对象状态：持久态，临时态，游离态，删除态；

2. SessionAPI

   | API       | 描述 |
   | --------- | ---- |
   | flush()   |      |
   | reflesh() |      |
   | clear()   |      |

   

# 第二部分 Hibernate集成Spring



# 第三部分 spring-boot-jpa

