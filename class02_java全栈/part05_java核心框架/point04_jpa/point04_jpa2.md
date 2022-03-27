# 第一章 JPA 入门

## 1.1 JPA概述

JPA（Java Persistence API，Java持久层API），是一个基于ORM（对象关系映射）的标准规范，用来处理程序与数据库之间的关系。JPA最早由EJB3.0专家组开发，是JSR220实现的一部分，它只定义标准规则，不提供具体实现，JPA实现通常被称为：持久化提供者（persistence provider），目前主要的JPA实现有：Hibernate、EclipseLink、OpenJPA等。PA包括以下3方面的内容：

1. **一套API标准**：在javax.persistence的包下面，用来操作实体对象，执行CRUD操作，框架在后台替代我们完成所有的事情，开发者从烦琐的JDBC和SQL代码中解脱出来。
2. **面向对象的查询语言**：Java Persistence Query Language（JPQL）。这是持久化操作中很重要的一个方面，通过面向*****对象而非面向数据库的查询语言查询数据，避免程序的SQL语句紧密耦合
3. **ORM（object/relational metadata）元数据的映射**：JPA支持XML和JDK5.0注解两种元数据的形式，元数据描述对象和表之间的映射关系，框架据此将实体对象持久化到数据库表中。

## 1.2 SpringDataJPA

Spring  Data项目是从2010年发展起来的，从创立之初SpringData就想提供一个大家熟悉的、一致的、基于Spring的数据访问编程模型，同时仍然保留底层数据存储的特殊特性。它可以轻松地让开发者使用数据访问技术，包括关系数据库、非关系数据库（NoSQL）和基于云的数据服务。

Spring Data Common是Spring Data所有模块的公用部分，该项目提供跨Spring数据项目的共享基础设施。它包含了技术中立的库接口以及一个坚持java类的元数据模型。Spring Data不仅对传统的数据库访问技术JDBC、Hibernate、JDO、TopLick、JPA、Mybitas做了很好的支持、扩展、抽象、提供方便的API，还对NoSQL等非关系数据做了很好的支持，包括MongoDB、Redis、Apache Solr等；Spring Data的子项目：

1. **Main Modules**

   | Commons   | MongoDB       | KeyValue    |
   | --------- | ------------- | ----------- |
   | **JPA**   | **Solr**      | **Gemfire** |
   | **Redis** | **Cassandra** | **LDAP**    |

2. **Community Modules**

   | Aerospike    | ElasticSearch | Hazelcast |
   | ------------ | ------------- | --------- |
   | **Couhbase** | **DynamoDB**  | **Neo4j** |

3. **Related Modules**

   | JDBC Extension | Apache Hadoop | Spring Content |
   | -------------- | ------------- | -------------- |

Spring  Data JPA可以理解为JPA规范的再次封装抽象，底层还是使用了Hibernate的JPA技术实现，引用JPQL（Java Persistence Query Language）查询语言，属于Spring整个生态体系的一部分。

## 1.3 HelloWorld

1. 创建SringBoot项目集成SpringDataJpa

   ```xml
   <dependencyManagement>
       <dependencies>
           <dependency>
               <groupId>org.springframework.boot</groupId>
               <artifactId>spring-boot-dependencies</artifactId>
               <version>2.6.4</version>
               <scope>import</scope>
               <type>pom</type>
           </dependency>
       </dependencies>
   </dependencyManagement>
   
   <dependencies>
       <!--SpringBootWEB-->
       <dependency>
           <groupId>org.springframework.boot</groupId>
           <artifactId>spring-boot-starter-web</artifactId>
       </dependency>
       <!--SpringBootJPA&MySQL-->
       <dependency>
           <groupId>org.springframework.boot</groupId>
           <artifactId>spring-boot-starter-data-jpa</artifactId>
       </dependency>
       <dependency>
           <groupId>mysql</groupId>
           <artifactId>mysql-connector-java</artifactId>
       </dependency>
       <!--SpringBootTest-->
       <dependency>
           <groupId>org.springframework.boot</groupId>
           <artifactId>spring-boot-starter-test</artifactId>
       </dependency>
       <!--通用工具包-->
       <dependency>
           <groupId>junit</groupId>
           <artifactId>junit</artifactId>
           <version>4.13.2</version>
       </dependency>
       <dependency>
           <groupId>org.projectlombok</groupId>
           <artifactId>lombok</artifactId>
           <version>1.18.22</version>
       </dependency>
       <dependency>
           <groupId>cn.hutool</groupId>
           <artifactId>hutool-all</artifactId>
           <version>5.6.2</version>
       </dependency>
   </dependencies>
   ```

2. 配置文件添加数据库连接和JPA配置

   ```yaml
   spring:
     datasource:
       driver-class-name: com.mysql.cj.jdbc.Driver
       url: jdbc:mysql://localhost:3306/xlxs_jap
       username: root
       password: root
     jpa:
       hibernate:
         ddl-auto: update
       show-sql: true
       database-platform: org.hibernate.dialect.MySQL8Dialect
       generate-ddl: true
   ```

3. 添加SpringBoot主启动类

   ```java
   @SpringBootApplication
   public class JpaBoot01App {
       public static void main(String[] args) {
           SpringApplication.run(JpaBoot01App.class, args);
       }
   }
   ```

4. 创建Java实体类，添加ORM映射配置

   ```java
   @Getter
   @Setter
   @ToString
   @Builder
   @NoArgsConstructor
   @AllArgsConstructor
   @Entity
   @Table(name = "jpa_person01")
   public class Person01 {
       @Id
       @Column(name = "id")
       @GeneratedValue(generator = "jpa-uuid")
       @GenericGenerator(name = "jpa-uuid", strategy = "uuid")
       private String id;
   
       @Column(name = "card_id")
       private Long cardId;
   
       @Column(name = "name")
       private String name;
   
       @Column(name = "gmt_create")
       private Date gmtCreate;
   
       @Column(name = "gmt_modify")
       private Date gmtModify;
   }
   ```

5. 为实体类添加Repository

   ```java
   @Repository
   public interface Person01Repository extends JpaRepository<Person01,String> {
       
   }
   ```

6. 创建SpringBoot测试类，自动生成数据表，执行save操作

   ```java
   @SpringBootTest
   @RunWith(SpringRunner.class)
   public class Person01Test {
       @Autowired
       private Person01Repository person01Repository;
       
       @Test
       public void testSave() throws Exception {
           Person01 person = Person01.builder()
                   .name("JapAdd2")
                   .gmtCreate(new Date())
                   .gmtModify(new Date())
                   .cardId(100001L)
                   .build();
           Person01 save = person01Service.save(person);
           System.out.println("save = " + save);
       }
   }
   ```

   > ```tex
   > Hibernate: create table jpa_person01 (id varchar(255) not null, card_id bigint, gmt_create datetime(6), gmt_modify datetime(6), name varchar(255), primary key (id)) engine=InnoDB
   > 
   > Hibernate: insert into jpa_person01 (card_id, gmt_create, gmt_modify, name, id) values (?, ?, ?, ?, ?)
   > 
   > save = Person01(id=ff8080817fc8f976017fc8f97d910000, cardId=100001, name=JapAdd2, gmtCreate=Sun Mar 27 09:24:28 CST 2022, gmtModify=Sun Mar 27 09:24:28 CST 2022)
   > ```

# 第二章 JPA原理解析

## 2.1 Repository体系

1. Spring Data Common定义了很多公共接口和一些相对数据操作的公共实现（分页、排序、结果映射、事务等等），SpringDataJPA依赖关系：依赖了Spring Data Common

   <a href="https://imgtu.com/i/qwcz8K"><img src="https://s1.ax1x.com/2022/03/27/qwcz8K.png" alt="qwcz8K.png" border="0" /></a>

2. Repository是SpringDataCommon里的顶级接口，是操作DB的入口类；Repository的继承体系

   <a href="https://imgtu.com/i/qwcz8K"><img src="https://s1.ax1x.com/2022/03/27/qwcz8K.png" alt="qwcz8K.png" border="0" /></a>

   > - ReactiveCrudRepository：是为了支持响应式编程，当前支持NoSql相关操作
   > - RxJava2CrudRepository：为了支持RxJava2做的标准响应式接口
   > - CoroutineCrudRepository：是为了支持Coroutine语法
   > - CrudRepository：是Java操作关系型数据库的的操作接口

## 2.2 JpaRepository体系

### 1.  JpaRepository继承体系

<a href="https://imgtu.com/i/qwgnxS"><img src="https://s1.ax1x.com/2022/03/27/qwgnxS.png" alt="qwgnxS.png" border="0" /></a>

- 七大接口
  - Repository：顶级接口，没规定任何方法
  - CrudRepository：单表操作的基本CRUD方法
  - PagingAndSortingRepository：定义了带分页和排序的方法
  - QueryByExampleExecutor：件的Example查询
  - JpaRepository：JPA的扩展方法
  - JpaSpecificationExecutor：Jpa Specification扩展查询
  - QueryByExampleExecutor：QueryDSL的封装
- 两个实现类
  - SimpleJpaRepository：JPA所有接口的默认实现类
  - QuerydslJpaRepository：QueryDsl的实现类

### 2. Repository使用示例

SimpleJpaRepository是Repository七大接口的默认实现类，自定义Repository接口都是SimpleJpaRepository的代理实现的；

- 自定义Repository的DAO，继承Repository，Repository是空接口，所有DAO的操作方式只能定义在自定义的Repository中
- 自定义Repository的DAO，继承CrudRepository：当前DAO可以做单表简单的CRUD操作
- 自定义Repository的DAO，继承JpaRepository：DAO具有的JPA常用的方法->分页、排序、CRUD

## 2.3 JPA注解

### 1. ORM映射注解

1. **@Entity**：标记当前类是ORM规则中的实体类，可以映射为一个数据表，默认的表名是将驼峰Java类名转为小写加下划线的表名，可以使用name属性自定义映射的表名；通过配合@Table注解设置数据表的信息；

   ```java
   @Entity
   public class PersonCard{}	// 映射表名：person_card
   
   @Entity(name="personCard")
   public class PersonCard{}	// 映射表名：personCard
   ```

2. **@Table**：用来定义entity主表的name，catalog，schema等属性。

   - name：表名

   - catalog：用于指定数据库实例名，一般情况下配置文件中的是必须指定数据库的实例名称的

   - schema：作用与catalog属性作用一致

   - uniqueConstraints：用于设定约束条件

     ```java
     @Table(name="customer",uniqueConstraints={@UniqueConstraint(columnNames={"name","email"}),@UniqueConstraint(columnNames={"name","age"})} )
     @Entity
     public class Customer {
         private Integer id;
         private String name;
         private String email;
         private int age;
     }
     ```

     > ```sql
     > CREATE TABLE `customers` (
     >   `ID` int(11) NOT NULL AUTO_INCREMENT,
     >   `Age` int(11) DEFAULT NULL,
     >   `Email` varchar(255) DEFAULT NULL,
     >   `Name` varchar(255) DEFAULT NULL,
     >   PRIMARY KEY (`ID`),
     >   UNIQUE KEY `UK_a4gmx9uvdyb7q19sf3seob2l8` (`Name`,`Email`),
     >   UNIQUE KEY `UK_ag4xexpudoihe3uvpsl9yvhsg` (`Name`,`Age`)
     > ) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
     > ```

3. **@Id**：用于声明一个实体类的属性映射为数据库的主键列。也可置于属性的getter方法之上；

4. **@GeneratedValue**：用于标注主键的生成策略，通过strategy 属性指定。默认情况下，JPA 自动选择一个最适合底层数据库的主键生成策略：SqlServer对应identity，MySQL 对应 auto increment。GenerationType中

   - strategy：指主键生成策略，是GenerationType类型，其中定义了以下几种可供选择的策略

     - AUTO： JPA自动选择合适的策略，**是默认选项**；

     - IDENTITY：采用数据库ID自增长的方式来自增主键字段，Oracle 不支持这种方式；

     - SEQUENCE：通过序列产生主键，通过@SequenceGenerator 注解指定序列名，MySql不支持这种方式 

     - TABLE：通过表产生主键，框架借由表模拟序列产生主键，使用该策略可以使应用更易于数据库移植。

   - generator：用于引用@GenericGenerator注解定义的自定义生成策略

5. **@GenericGenerator**：主键策略生成器

   - name属性：表示该表主键生成策略的名称，它被引用在@GeneratedValue中设置的“generator”值中；
   - strategy属性：可以使用hibernate特有的生成策略：uuid
   - table属性：表示表生成策略所持久化的表名，例如，这里表使用的是数据库中的“tb_generator”；
   - catalog属性和 schema属性：具体指定表所在的目录名或是数据库模式名；
   - pkColumnName 属性：表示在持久化表中，该主键生成策略所对应键值的名称。例如在“tb_generator”中将“gen_name”作为主键的键值；
   - valueColumnName 属性：表示在持久化表中，该主键当前所生成的值，它的值将会随着每次创建累加。例如，在“tb_generator”中将“gen_value”作为主键的值；
   - pkColumnValue 属性：表示在持久化表中，该生成策略所对应的主键。例如在“tb_generator”表中，将“gen_name”的值为“CUSTOMER_PK”；
   - initialValue ：主键初始值，默认为0；
   - allocationSize ：表示每次主键值增加的大小。例如设置成1，则表示每次创建新记录后自动加1，默认为50；
   - uniqueConstraint ：与@Table标记中的用法类似；

6. **@Column**：用于定义实体类中普通列的映射关系

   - name：列名
   - length：字段长度，默认255
   - unique：是否唯一
   - nullable：是否可以为空
   - inserttable：是否可以插入
   - updateable：是否可以更新

7. **@Transient**：放弃该属性变成数据库表的字段

8. **@EnableJpaAuditing**：

9. **@EntityListeners**：

10. **@CreatedDate|@CreationTimestamp**：

11. **@LastModifiedDate|@UpdateTimestamp**：

### 2. ORM关联注解

1. @OneToOne：实体类的一对一映射，通常会使用@ManyToOne来完成@OneToOne的映射，关联关系定义在@JoinColumn注解中；
   - cascade：CascadeType.ALL、CascadeType.PERSIST（持久化）、CascadeType.MERGE（更新）、CascadeType.REMOVE（删除）、CascadeType.REFRESH（刷新）、CascadeType.DETACH
   - mappedBy：表示放弃一对一的关系维护，关系维护被交由指另一方属性维护，mappedBy的值也就是另一方的属性的属性名，即修改当前对象不会影响关联的对象，
2. @OneToMany：
   - cascade：CascadeType.ALL、CascadeType.PERSIST（持久化）、CascadeType.MERGE（更新）、CascadeType.REMOVE（删除）、CascadeType.REFRESH（刷新）、CascadeType.DETACH
   - mappedBy：表示放弃一对一的关系维护，关系维护被交由指另一方属性维护，mappedBy的值也就是另一方的属性的属性名，即修改当前对象不会影响关联的对象，
3. @ManyToOne：
   - cascade：CascadeType.ALL、CascadeType.PERSIST（持久化）、CascadeType.MERGE（更新）、CascadeType.REMOVE（删除）、CascadeType.REFRESH（刷新）、CascadeType.DETACH
   - mappedBy：表示放弃一对一的关系维护，关系维护被交由指另一方属性维护，mappedBy的值也就是另一方的属性的属性名，即修改当前对象不会影响关联的对象，
4. @ManyToMany：
   - cascade：CascadeType.ALL、CascadeType.PERSIST（持久化）、CascadeType.MERGE（更新）、CascadeType.REMOVE（删除）、CascadeType.REFRESH（刷新）、CascadeType.DETACH
   - mappedBy：表示放弃一对一的关系维护，关系维护被交由指另一方属性维护，mappedBy的值也就是另一方的属性的属性名，即修改当前对象不会影响关联的对象，
5. @JoinColumn：用于指定关联注解的关联关系
   - 注解字段：也是一个数据表的映射实体
   - name属性：用于说明当前的实体类对应的表中哪个字段对应这个属性，默认是注解属性对象中的ID字段
   - referencedColumnName：用于说明当前实体类的字段关联到属性对象中的哪个字段

### 3. Repository注解

1. @Repository
2. @Query
3. @Modifying
4. @Transactional

# 第三章 JPA基础操作

## 3.1 JpaRepository

1. CrudRepository
2. PagingAndSortingRepository
3. QueryByExampleExecutor

## 3.2 JpaSpecificationExecutor

## 3.3 @Query

## 3.4 DQM语法

# 第四章 JPA级联操作

## 4.1 @OneToOne

### 1. 单向OneToOne

- 实体类创建

  ```java
  @Getter
  @Setter
  @ToString
  @Builder
  @NoArgsConstructor
  @AllArgsConstructor
  @Entity
  @Table(name = "jpa_person04")
  public class Person04 {
      @Id
      @GenericGenerator(name = "jpa-uuid",strategy = "uuid")
      @GeneratedValue(generator = "jpa-uuid")
      private String id;
      @Column(name = "mame")
      private String name;
      @Column(name = "gmt_create")
      private Date gmtCreate;
      @Column(name = "gmt_modify")
      private Date gmtModify;
      @OneToOne(cascade = CascadeType.ALL)
      @JoinColumn(name = "card_id",referencedColumnName = "id")
      private Person04Card card;
  }
  @Getter
  @Setter
  @ToString
  @Builder
  @NoArgsConstructor
  @AllArgsConstructor
  @Entity
  @Table(name = "jpa_person04_card")
  public class Person04Card {
      @Id
      @GeneratedValue
      private Long id;
      @Column(name = "code")
      private String code;
  }
  ```

- 启动测试新增关联关系对象

  ```java
  @Test
  public void testSave() throws Exception{
      Person04Card card = new Person04Card();
      card.setCode("1001");
  
      Person04 person = Person04.builder()
          .name("person04")
          .card(card)
          .gmtCreate(new Date())
          .gmtModify(new Date())
          .build();
      Person04 save = person04Repository.save(person);
      System.out.println("save = " + save);
      System.out.println("card = " + card);
      System.out.println("person = " + person);
  
  }
  ```

  > ```sql
  > Hibernate: create table jpa_person04 (id varchar(255) not null, gmt_create datetime(6), gmt_modify datetime(6), mame varchar(255), card_id bigint, primary key (id)) engine=InnoDB
  > Hibernate: create table jpa_person04_card (id bigint not null, code varchar(255), primary key (id)) engine=InnoDB
  > Hibernate: alter table jpa_person04 add constraint FKhcwmloe3uqq85lqwj6iunusxp foreign key (card_id) references jpa_person04_card (id)
  > 
  > Hibernate: select next_val as id_val from hibernate_sequence for update
  > Hibernate: update hibernate_sequence set next_val= ? where next_val=?
  > Hibernate: insert into jpa_person04_card (code, id) values (?, ?)
  > Hibernate: insert into jpa_person04 (card_id, gmt_create, gmt_modify, mame, id) values (?, ?, ?, ?, ?)
  > ```

### 2. 双向@OneToOne



## 4.2 @OneToMany

## 4.3 @ManyToOne

## 4.4 @ManyToMany