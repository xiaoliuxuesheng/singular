# 前言

- ORM
  - ORM：Object Relation Mapping对象关系映射
  - ORM思想：将关系型数据库中一行数据映射为一个Java对象，程序员可以把对Java对象的操作映射为对数据库的操作
  - ORM元数据库：用来描述数据库和对象之间的映射关系。
- ORM框架
  - Hibernate
  - SpringBootJPA
  - SpringBootJDBC
  - MyBatis
- lombok
- Maven

# 第一部分 Xml配置Hibernate

## 第一章 HelloWorld

1. 新建Maven功能，添加Hibernate相关依赖

   ```xml
   <dependency>
     <groupId>org.hibernate</groupId>
     <artifactId>hibernate-core</artifactId>
     <version>5.6.5.Final</version>
   </dependency>
   <dependency>
     <groupId>mysql</groupId>
     <artifactId>mysql-connector-java</artifactId>
     <version>8.0.26</version>
   </dependency>
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
   ```

2. 新建Java实体类

   ```java
   @Getter
   @Setter
   @ToString
   public class Person {
     private String id;
     private Long cardId;
     private String name;
     private Date gmtCreate;
     private Date gmtModify;
   }
   ```

3. 在Maven的resources目录中新建Hibernate的配置文件：**hibernate.cfg.xml**

   ```xml
   <hibernate-configuration>
     <!-- 通常，一个session-factory节点代表一个数据库 -->
     <session-factory>
       <!-- 1. 数据库连接配置 -->
       <property name="hibernate.connection.driver_class">com.mysql.jdbc.Driver</property>
       <property name="hibernate.connection.url">jdbc:mysql://localhost:3306/xlxs_jap</property>
       <property name="hibernate.connection.username">root</property>
       <property name="hibernate.connection.password">root</property>
       <!--数据库方法配置，hibernate在运行时，会根据不同的方言生成符合当前数据库语法的sql-->
       <property name="hibernate.dialect">org.hibernate.dialect.MySQL5Dialect</property>
       <!-- 2. 其他相关配置 -->
       <!-- 2.1 显示hibernate在运行时候执行的sql语句 -->
       <property name="hibernate.show_sql">true</property>
       <!-- 2.2 格式化sql -->
       <property name="hibernate.format_sql">true</property>
       <!-- 2.3 自动建表  -->
       <property name="hibernate.hbm2ddl.auto">update</property>
       <!--3. 加载所有映射-->
       <mapping resource="hibernate/mapping/Person.hbm.xml"/>
     </session-factory>
   </hibernate-configuration>
   ```

4. 为Java对象添加和数据库的mapping映射：映射配置文件由hibernate.cfg.xml配置文件中的mapping中配置

   ```xml
   <?xml version="1.0"?>
   <!DOCTYPE hibernate-mapping PUBLIC
           "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
           "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">
   <hibernate-mapping package="com.jpa.hibernate.entity">
   
     <class name="Person" lazy="true" table="person">
       <id name="id">
         <generator class="uuid"/>
       </id>
       <property name="name" column="name"/>
       <property name="cardId" column="card_id"/>
       <property name="gmtCreate" column="gmt_create"/>
       <property name="gmtModify" column="gmt_modify"/>
     </class>
   </hibernate-mapping>
   ```

5. 编写测试类读取配置文件（默认读取根目录hibernate.cfg.xml文件），调用Hibernate的API创建数据表并存储对象

   ```java
   @Test
   public void testInit() throws Exception{
     //获取加载配置管理类
     Configuration configuration = new Configuration();
     //不给参数就默认加载hibernate.cfg.xml文件，
     configuration.configure();
     //创建Session工厂对象
     SessionFactory factory = configuration.buildSessionFactory();
     //得到Session对象
     Session session = factory.openSession();
     //使用Hibernate操作数据库，都要开启事务,得到事务对象
     Transaction transaction = session.getTransaction();
     //开启事务
     transaction.begin();
     //把对象添加到数据库中
     Person person = new Person();
     person.setName("张三");
     person.setCardId(1001L);
     session.save(person);
     //提交事务
     transaction.commit();
     //关闭Session
     session.close();
   }
   
   @Test
   public void test() {
     StandardServiceRegistry sr = new StandardServiceRegistryBuilder().configure().build();
     SessionFactory fa = new MetadataSources(sr).buildMetadata().buildSessionFactory();
     Session session = fa.openSession();
     //使用Hibernate操作数据库，都要开启事务,得到事务对象
     Transaction transaction = session.getTransaction();
     //开启事务
     transaction.begin();
     Person person = new Person();
     person.setName("张三");
     person.setCardId(1001L);
     session.save(person);
     //提交事务
     transaction.commit();
     //关闭Session
     session.close();
   }
   ```

# 第二章 Hibernate基础操作

### 2.1 新增

- Session接口提供的save()方法

  ```java
  @Test
  public void testSave() {
      //加载 Hibernate 核心配置文件
      Configuration configuration = new Configuration().configure();
      //创建一个 SessionFactory 用来获取 Session 连接对象
      SessionFactory sessionFactory = configuration.buildSessionFactory();
      //获取session 连接对象
      Session session = sessionFactory.openSession();
      //开始事务
      Transaction transaction = session.beginTransaction();
      //创建实体对象
      Person person = new Person();
      person.setName("新增数据");
      person.setCardId(1001L);
      person.setGmtCreate(new Date());
      person.setGmtModify(new Date());
      session.save(person);
      //提交事务
      transaction.commit();
      //释放资源
      session.close();
      sessionFactory.close();
  }
  ```

### 2.2 修改

- Session接口提供的update方法

  ```java
  @Test
  public void testUpdate() {
      //加载 Hibernate 核心配置文件
      Configuration configuration = new Configuration().configure();
      //创建一个 SessionFactory 用来获取 Session 连接对象
      SessionFactory sessionFactory = configuration.buildSessionFactory();
      //获取session 连接对象
      Session session = sessionFactory.openSession();
      //开始事务
      Transaction transaction = session.beginTransaction();
      //现将需要修改的记录查询出来
      Person user = session.get(Person.class, "ff8080817f808f1b017f808f1cd40000");
      //设置需要修改的字段
      user.setName("更新用户名");
      //直接调用 update() 方法进行修改
      session.update(user);
      //提交事务
      transaction.commit();
      //释放资源
      session.close();
      sessionFactory.close();
  }
  ```

### 2.3 删除

- Session接口提供的delete()方法

  ```java
  @Test
  public void testDelete() {
      //加载 Hibernate 核心配置文件
      Configuration configuration = new Configuration().configure();
      //创建一个 SessionFactory 用来获取 Session 连接对象
      SessionFactory sessionFactory = configuration.buildSessionFactory();
      //获取session 连接对象
      Session session = sessionFactory.openSession();
      //开始事务
      Transaction transaction = session.beginTransaction();
      Person person = new Person();
      person.setId("ff8080817f5e6512017f5e6514950000");
      //删除指定的记录
      session.delete(person);
      //提交事务
      transaction.commit();
      //释放资源
      session.close();
      sessionFactory.close();
  }
  ```

### 2.4 查询

- HQL 查询：Hibernate Query Language，它是一种面向对象的查询语言

  ```java
  @Test
  public void testQueryHql() throws Exception{
      //加载 Hibernate 核心配置文件
      Configuration configuration = new Configuration().configure();
      //创建一个 SessionFactory 用来获取 Session 连接对象
      SessionFactory sessionFactory = configuration.buildSessionFactory();
      //获取session 连接对象
      Session session = sessionFactory.openSession();
      //创建 HQL 语句，语法与 SQL 类似，但操作的是实体类及其属性
      Query query = session.createQuery("from Person where name like ?1");
      //查询所有使用 163 邮箱的用户
      query.setParameter(1, "%三%");
      //获取结果集
      List<Person> resultList = query.getResultList();
      //遍历结果集
      for (Person person : resultList) {
          System.out.println(person);
      }
      //释放资源
      session.close();
      sessionFactory.close();
  }
  ```

- QBC 查询：Query By Criteria，是一种完全面向对象（比 HQL 更加面向对象）的对数据库查询技术

  ```java
  @Test
  public void testQbcQuery() {
      //加载 Hibernate 核心配置文件
      Configuration configuration = new Configuration().configure();
      //创建一个 SessionFactory 用来获取 Session 连接对象
      SessionFactory sessionFactory = configuration.buildSessionFactory();
      //获取session 连接对象
      Session session = sessionFactory.openSession();
      //获得 CriteriaBuilder 对象
      CriteriaBuilder criteriaBuilder = session.getCriteriaBuilder();
      //构建 CriteriaQuery 查询对象
      CriteriaQuery<Person> criteria = criteriaBuilder.createQuery(Person.class);
      //添加查询条件
      Root<Person> from = criteria.from(Person.class);
      Predicate like = criteriaBuilder.like(from.get("name"), "%三%");
      criteria.where(criteriaBuilder.and(like));
      //获取结果集
      List<Person> list = session.createQuery(criteria).getResultList();
      //遍历结果集
      for (Person person : list) {
          System.out.println(person);
      }
      //释放资源
      session.close();
      sessionFactory.close();
  }
  ```

- SQL 查询：支持使用原生的 SQL 语句对数据库进行查询

  ```java
  @Test
  public void testSqlQuery() {
      //加载 Hibernate 核心配置文件
      Configuration configuration = new Configuration().configure();
      //创建一个 SessionFactory 用来获取 Session 连接对象
      SessionFactory sessionFactory = configuration.buildSessionFactory();
      //获取session 连接对象
      Session session = sessionFactory.openSession();
      //构建 sql 查询
      NativeQuery sqlQuery = session.createSQLQuery("select * from person where name like '%三%'");
      sqlQuery.addEntity(Person.class);
      //获得结果集
      List<Person> resultList = sqlQuery.getResultList();
      //遍历结果集
      for (Person person : resultList) {
          System.out.println(person);
      }
      //释放资源
      session.close();
      sessionFactory.close();
  }
  ```

  

## 第三章Hibernate配置说明

### 3.1 hibernate.cfg.xml

1. Hibernate配置文件说明：主要用于配置数据库连接、事务管理、Hibernate 本身的配置信息以及 Hibernate 映射文件信息；该配置文件默认放在项目的 src 目录下，当项目发布后，该文件会在项目的 WEB-INF/classes 路径下；默认名称是hibernate.cfg.xml

2. Hibernate 核心配置文件的根元素是 `<hibernate-configuration>`，该元素中包含一个` <session-factory>` 子元素。

   - **`<property> `元素**：用于配置 Hibernate 连接数据库的各种信息，例如，数据库的方言、驱动、URL、用户名、密码等。这些 property 属性中，有些是 Hibernate 的必需配置，有些则是可选配置

     | property 属性名                 | 描述                                                         | 必需 |
     | ------------------------------- | ------------------------------------------------------------ | ---- |
     | connection.url                  | 指定连接数据库 URL                                           | 是   |
     | hibernate.connection.username   | 指定数据库用户名                                             | 是   |
     | hibernate.connection.password   | 指定数据库密码                                               | 是   |
     | connection.driver_class         | 指定数据库驱动程序                                           | 是   |
     | hibernate.dialect               | 指定数据库使用的 SQL 方言，用于确定 Hibernate 自动生成的 SQL 语句的类型 | 是   |
     | hibernate.show_sql              | 用于设置是否在控制台输出 SQL 语句                            | 否   |
     | hibernate.format_sql            | 用于设置是否格式化控制台输出的 SQL 语句                      | 否   |
     | hibernate.hbm2ddl.auto          | 当创建 SessionFactory 时，是否根据映射文件自动验证表结构或自动创建、自动更新数据库表结构。 该参数的取值为 validate 、update、create 和 create-drop | 否   |
     | hibernate.connection.autocommit | 事务是否自动提交                                             | 否   |

   - **`<mapping>` 元素**：用来指定 Hibernate 映射文件的信息，加载映射文件。

     ```xml
     <mapping resource="net/biancheng/www/mapping/User.hbm.xml"/>
     ```

### 3.2 Xxx.hbm.xml

1. Hibernate 映射文件用于在实体类对象与数据表之间建立映射关系，每个映射文件的结构基本相同

2. `<hibernate-mapping>` 元素：是 Hibernate 映射文件的根元素，在该元素中定义的配置在整个映射文件中都有效。该元素中包含的常用属性如下表。

   | 属性名          | 描述                                                         | 必需 |
   | --------------- | ------------------------------------------------------------ | ---- |
   | schema          | 指定映射文件所对应的数据库名字空间                           | 否   |
   | package         | 为映射文件对应的实体类指定包名                               | 否   |
   | catalog         | 指定映射文件所对应的数据库目录                               | 否   |
   | default-access  | 指定 Hibernate 用于访问属性时所使用的策略，默认为 property。当 default-access="property" 时，使用 getter 和 setter 方法访问成员变量；当 default-access = "field"时，使用反射访问成员变量。 | 否   |
   | default-cascade | 指定默认的级联风格                                           | 否   |
   | default-lazy    | 指定 Hibernate 默认使用的延迟加载策略                        | 否   |

3. `<class> `元素：是 Hibernate 映射文件的根元素 `<hibernate-mapping>` 的子元素，它主要用来定义一个实体类与数据库表之间的映射关系，该元素中包含的常用属性如下表。

   | 属性名  | 描述                                                         | 必需 |
   | ------- | ------------------------------------------------------------ | ---- |
   | name    | 实体类的完全限定名（包名+类名），若根元素 <hibernate-mapping> 中已经指定了 package 属性，则该属性可以省略包名 | 否   |
   | table   | 对应的数据库表名。                                           | 否   |
   | catalog | 指定映射文件所对应的数据库 catalog 名称，若根元素 <hibernate-mapping> 中已经指定 catalog 属性，则该属性会覆盖根元素中的配置。 | 否   |
   | schema  | 指定映射文件所对应的数据库 schema 名称，若根元素 <hibernate-mapping> 中已经指定 schema 属性，则该属性会覆盖根元素中的配置。 | 否   |
   | lazy    | 指定是否使用延迟加载。                                       | 否   |

4. `<id>` 元素：通常情况下，Hibernate 推荐我们在持久化类（实体类）中定义一个标识属性，用于唯一地标识一个持久化实例（实体类对象），且标识属性需要映射到底层数据库的主键上。包含的常用属性如下表。

   | 属性名 | 描述                                                         | 必需 |
   | ------ | ------------------------------------------------------------ | ---- |
   | name   | 与数据库表主键向对应的实体类的属性                           | 否   |
   | column | 数据库表主键的字段名                                         | 否   |
   | type   | 用于指定数据表中的字段需要转化的类型，这个类型既可以是 Hibernate 类型，也可以是 Java 类型 | 否   |

   > Hibernate 提供了以下 7 主键生成策略，如下表。
   >
   > ```xml
   > <id name="id" column="id" type="integer">
   >     <!--主键生成策略-->
   >      <generator class="native" ></generator>
   > </id>
   > ```
   >
   > | 主键策略  | 说明                                                         |
   > | --------- | ------------------------------------------------------------ |
   > | increment | 自动增长策略之一，适合 short、int、long 等类型的字段。该策略不是使用数据库的自动增长机制，而是使用 Hibernate 框架提供的自动增长方式，即先从表中查询主键的最大值， 然后在最大值的基础上+1。该策略存在多线程问题，一般不建议使用。 |
   > | identity  | 自动增长策略之一，适合 short、int、long 等类型的字段。该策略采用数据库的自动增长机制，但该策略不适用于 Oracle 数据库。 |
   > | sequence  | 序列，适合 short、int、long 等类型的字段。该策略应用在支持序列的数据库，例如 Oracle 数据库，但不是适用于 MySQL 数据库。 |
   > | uuid      | 适用于字符串类型的主键，采用随机的字符串作为主键。           |
   > | native    | 本地策略，Hibernate 会根据底层数据库不同，自动选择适用 identity 还是 sequence 策略，该策略也是最常用的主键生成策略。 |
   > | assigned  | Hibernate 框架放弃对主键的维护，主键由程序自动生成。         |
   > | foreign   | 主键来自于其他数据库表（应用在多表一对一的关系）。           |

5. `<property> `元素：`<class>` 元素中可以包含一个或多个 `<property>` 子元素，它用于表示实体类的普通属性（除与数据表主键字段对应的属性之外的其他属性）和数据表中非主键字段的映射关系。该元素中包含的常用属性如下表。

   | 属性名   | 描述                                                         |
   | -------- | ------------------------------------------------------------ |
   | name     | 实体类属性的名称                                             |
   | column   | 数据表字段名                                                 |
   | type     | 用于指定数据表中的字段需要转化的类型，这个类型既可以是 Hibernate 类型，也可以是 Java 类型 |
   | length   | 数据表字段的长度                                             |
   | lazy     | 该属性使用延迟加载，默认值是 false                           |
   | unique   | 是否对该字段使用唯一性约束。                                 |
   | not-null | 是否允许该字段为空                                           |

## 第四章 Hibernate规范

### 4.1 Hibernate工作原理

1. Hibernate执行SQL涉及到了 Configuration、SessionFactory、Session、Transaction 和 Query 等多个接口，这些接口的工作原理如下图

   <img src="https://s1.ax1x.com/2022/03/13/bbZWrt.png" alt="bbZWrt.png" border="0" />

2. **Hibernate工作流程**

   - Hibernate 启动，Configruation 会读取并加载 Hibernate 核心配置文件和映射文件钟的信息到它实例对象中。
   - 通过 Configuration 对象读取到的配置文件信息，创建一个 SessionFactory 对象，该对象中保存了当前数据库的配置信息、映射关系等信息。
   - 通过 SessionFactory 对象创建一个 Session 实例，建立数据库连接。Session 主要负责执行持久化对象的增、删、改、查操作，创建一个 Session 就相当于创建一个新的数据库连接。
   - （**查询方法不需要开启事务**）通过 Session 对象创建 Transaction（事务）实例对象，并开启事务。Transaction 用于事务管理，一个 Transaction 对象对应的事务可以包含多个操作。需要注意的是，Hibernate 的事务默认是关闭的，需要手动开启和关闭。
   -  Session 接口提供了各种方法，可以对实体类对象进行持久化操作（即对数据库进行操作），例如 get()、load()、save()、update()、saveOrUpdate() 等等，除此之外，Session 对象还可以创建Query 对象 或 NativeQuery 对象，分别使用 HQL 语句或原生 SQL 语句对数据库进行操作。
   - 对实体对象持久化操作完成后，必须提交事务，若程序运行过程中遇到异常，则回滚事务。
   - 关闭 Session 与 SessionFactory，断开与数据库的连接，释放资源。

### 4.2 Hibernate核心接口

1. Configuration：主要用于管理 Hibernate 配置信息，并在启动 Hibernate 应用时，创建 SessionFactory 实例，默认会在项目的类路径（CLASSPATH）中，搜索核心配置文件 hibernate.cfg.xml 并将其加载到内存中，作为后续操作的基础配置 。

2. SessionFactory：用来读取和解析映射文件，并负责创建和管理 Session 对象；SessionFactory 对象中保存了当前的数据库配置信息、所有映射关系以及 Hibernate 自动生成的预定义 SQL 语句，同时它还维护了 Hibernate 的二级缓存。一个 SessionFactory 实例对应一个数据库存储源，Hibernate 应用可以从 SessionFactory 实例中获取 Session 实例。SessionFactory 具有以下特点：

   - SessionFactory 是线程安全的，它的同一个实例可以被应用多个不同的线程共享。
   - SessionFactory 是重量级的，不能随意创建和销毁它的实例。如果应用只访问一个数据库，那么在应用初始化时就只需创建一个 SessionFactory 实例；如果应用需要同时访问多个数据库，那么则需要为每一个数据库创建一个单独的 SesssionFactory 实例。

3. Session：是 Hibernate 应用程序与数据库进行交互时，使用最广泛的接口，它也被称为 Hibernate 的持久化管理器，所有持久化对象必须在 Session 的管理下才可以进行持久化操作。持久化类只有与 Session 关联起来后，才具有了持久化的能力，Session 对象维护了 Hibernate 的一级缓存，在显式执行 flush 之前，所有的持久化操作的数据都缓存在 Session 对象中。Session 具有以下特点：

   - 不是线程安全的，因此应该避免多个线程共享同一个 Session 实例；
   - Session 实例是轻量级的，它的创建和销毁不需要消耗太多的资源。通常我们会将每一个Session 实例和一个数据库事务绑定，每执行一个数据库事务，不论执行成功与否，最后都因该调用 Session 的 Close() 方法，关闭 Session 释放占用的资源。

   | 方法             | 描述                         |
   | ---------------- | ---------------------------- |
   | save()           | 执行插入操作                 |
   | update()         | 执行修改操作                 |
   | saveOrUpdate()   | 根据参数，执行插入或修改操作 |
   | delete()         | 执行删除操作                 |
   | get()            | 根据主键查询数据（立即加载） |
   | load()           | 根据主键查询数据（延迟加载） |
   | createQuery()    | 获取 Hibernate 查询对象      |
   | createSQLQuery() | 获取 SQL 查询对象            |

4. Transaction 是 Hibernate 提供的数据库事务管理接口，它对底层的事务接口进行了封装。所有的持久化操作（即使是只读操作）都应该在事务管理下进行，因此在进行 CRUD 持久化操作之前，必须获得 Trasaction 对象并开启事务。

   - 调用 Session 提供的 beginTransaction() 方法获取 Transaction 对象:根据 Session 获得一个 Transaction 对象，但是并没有开启事务。

     ```java
     Transaction transaction = session.beginTransaction();
     ```

   -  调用 Session 提供的 getTransaction() 方法获取 Transaction 对象是在根据 Session 获得一个 Transaction 对象后，又继续调用 Transaction 的 begin() 方法，开启了事务。

     ```java
     Transaction transaction1 = session.getTransaction();
     ```

   | 方法       | 描述               |
   | ---------- | ------------------ |
   | begin()    | 该方法用于开启事务 |
   | commit()   | 该方法用于提交事务 |
   | rollback() | 该方法用于回滚事务 |

5. Query是 Hibernate 提供的查询接口，主要用执行 Hinernate 的查询操作。Query 对象中通常包装了一个 HQL（Hibernate Query Language）语句，HQL 语句与 SQL 语句存在相似之处，但 HQL 语句是面向对象的，它使用的是类名和类的属性名，而不是表名和表中的字段名。HQL 能够提供更加丰富灵活、更为强大的查询能力，因此 Hibernate 官方推荐使用 HQL 进行查询。

   | 方法                               | 描述                                                         |
   | ---------------------------------- | ------------------------------------------------------------ |
   | setXxx()                           | Query 接口中提供了一系列 setXxx() 方法，用于设置查询语句中的参数。这些方法都需要两个参数，分别是：参数名或占位符位置、参数值。我们需要根据参数类型的不同，分别调用不同的 setXxx() 方法，例如 setString()、setInteger()、setLong()、setBoolean() 和 setDate() 等等。 |
   | Iterator<R> iterate();             | 该方法用于执行查询语句，并返回一个 Iterator 对象。我们可以通过返回的 Iterator 对象，遍历得到结果集。 |
   | Object uniqueResult();             | 该方法用户执行查询，并返回一个唯一的结果。使用该方法时，需要确保查询结果只有一条数据，否则就会报错。 |
   | int executeUpdate();               | 该方法用于执行 HQL 的更新和删除操作。                        |
   | Query<R> setFirstResult(int var1); | 该方法用户设置结果集第一条记录的位置，即设置从第几条记录开始查询，默认从 0 开始。 |
   | Query<R> setMaxResults(int var1);  | 该方法用于设置结果集的最大记录数，通常与 setFirstResult() 方法结合使用，用于限制结果集的范围，以实现分页功能。 |

### 4.3 Hibernate对象状态

1. **持久化类规范**：

   - 持久化类中需要提供一个使用 public 修饰的无参构造器；
   - 持久化类中需要提供一个标识属性 OID，与数据表主键字段向对应，例如实体类 User 中的 id 属性。为了保证 OID 的唯一性，OID 应该由 Hibernate 进行赋值，尽量避免人工手动赋值；
   - 持久化类中所有属性（包括 OID）都要与数据库表中的字段相对应，且都应该符合 JavaBean 规范，即属性使用 private 修饰，且提供相应的 setter 和 getter 方法；
   - 标识属性应尽量使用基本数据类型的包装类型，例如 Interger，目的是为了与数据库表的字段默认值 null 保持一致；
   - 不能用 final 修饰持久化类。

2. 持久化对象的状态

   | 状态                                              | 特点                                                         |
   | ------------------------------------------------- | ------------------------------------------------------------ |
   | 瞬时态（transient）<br /> - 临时态<br /> - 自由态 | 由 new 关键字开辟内存空间的对象（即使用 new 关键字创建的对象）<br /> - 没有唯一标识 OID；<br /> - 未与任何 Session 实例建立关联关系；<br /> - 数据库中也没有与之相关的记录； |
   | 持久态（persistent）                              | 当对象加入到 Session 的一级缓存中时，与 Session 实例建立关联关系时<br />- 存在唯一标识 OID，且不为 null；<br /> - 已经纳入到 Session 中管理；<br /> - 数据库中存在对应的记录；<br /> - 持久态对象的任何属性值的改动，会在事务结束时同步到数据库表中。 |
   | 脱管态（detached）<br /> - 离线态<br /> - 游离态  | 持久态对象与 Session 断开联系时<br /> - 存在唯一标识 OID；<br /> - 与 Session 断开关联关系，未纳入 Session 中管理；<br /> - 一旦有 Session 再次关联该脱管对象，那么该对象就可以立马变为持久状态；<br /> - 脱管态对象发生的任何改变，都不能被 Hibernate 检测到，更不能提交到数据库中。 |

### 4.4 Hibernate缓存

1. **缓存概述**：是位于应用程序和永久性数据存储源（例如硬盘上的文件或者数据库）之间，用于临时存放备份数据的内存区域，通过它可以降低应用程序读写永久性数据存储源的次数，提高应用程序的运行性能。缓存具有以下特点：

   - 缓存中的数据通常是数据库中数据的备份，两者中存放的数据完全一致，因此应用程序运行时，可以直接读写缓存中的数据，而不再对数据库进行访问，可以有效地降低应用程序对数据库的访问频率。
   - 缓存的物理介质通常是内存，永久性数据存储源的物理介质为硬盘或磁盘，而应用程序读取内存的速度要明显高于硬盘，因此使用缓存能够有效的提高数据读写的速度，提高应用程序的性能。
   - 由于应用程序可以修改（即“写”）缓存中的数据，为了保证缓存和数据库中的数据保持一致，应用程序通常会在在某些特定时刻，将缓存中的数据同步更新到数据库中。

2. **Hibernate一级缓存**：是 Session 级别的缓存，它是由 Hibernate 管理的，不可卸载。当使用 Hibernate 查询对象时，会首先从一级缓存中查找，若在一级缓存中找到了匹配的对象，则直接取出并使用；若没有在一级缓存中找到匹配的对象，则去数据库中查询对应的数据，并将查询到的数据添加到一级缓存中。Hibernate 一级缓存具有以下特点：

   - 一级缓存是 Hibernate 自带的，默认是开启状态，无法卸载。

   - Hibernate 一级缓存中只能保存持久态对象。

   - Hibernate 一级缓存的生命周期与 Session 保持一致，且一级缓存是 Session 独享的，每个 Session 不能访问其他的 Session 的缓存区，Session 一旦关闭或销毁，一级缓存中的所有对象将全部丢失。

   - 当通过 Session 接口提供的 save()、update()、saveOrUpdate() 和 lock() 等方法，对对象进行持久化操作时，该对象会被添加到一级缓存中。

   - 当通过 Session 接口提供的 get()、load() 方法，以及 Query 接口提供的 getResultList、list() 和 iterator() 方法，查询某个对象时，会首先判断缓存中是否存在该对象，如果存在，则直接取出来使用，而不再查询数据库；反之，则去数据库查询数据，并将查询结果添加到缓存中。

   - 当调用 Session 的 close() 方法时，Session 缓存会被清空。

   - 一级缓存中的持久化对象具有自动更新数据库能力。

   - 一级缓存是由 Hibernate 维护的，用户不能随意操作缓存内容，但用户可以通过 Hibernate 提供的方法，来管理一级缓存中的内容，

     | 返回值类型 | 方法                              | 描述                                                     |
     | ---------- | --------------------------------- | -------------------------------------------------------- |
     | void       | clear()                           | 该方法用于清空一级缓存中的所有对象。                     |
     | void       | evict(Object var1)                | 该方法用于清除一级缓存中某一个对象。                     |
     | void       | flush() throws HibernateException | 该方法用于刷出缓存，使数据库与一级缓存中的数据保持一致。 |

3. **Hibernate二级缓存**：

## 第五章 Hibernate关联映射

### 5.1 一对一

-  Student 的映射文件 Student.hbm.xml

  ```xml
  <?xml version='1.0' encoding='utf-8'?>
  <!DOCTYPE hibernate-mapping PUBLIC
          "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
          "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">
  <hibernate-mapping>
      <class name="net.biancheng.www.po.Student" table="student" schema="bianchengbang_jdbc" lazy="true">
          <!--主键映射-->
          <id name="id" column="id" type="java.lang.Integer">
              <!--主键生成策略-->
              <generator class="native"></generator>
          </id>
          <property name="name" column="name" length="100" type="java.lang.String"></property>
          <!--维护关联关系-->
          <many-to-one name="grade" class="net.biancheng.www.po.Grade" column="gid"/>
      </class>
  </hibernate-mapping>
  ```

- 创建 Grade 的映射文件 Grade.hbm.xml

  ```xml
  <?xml version='1.0' encoding='utf-8'?>
  <!DOCTYPE hibernate-mapping PUBLIC
          "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
          "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">
  <hibernate-mapping>
      <class name="net.biancheng.www.po.Grade" table="grade" schema="bianchengbang_jdbc">
          <id name="id" column="id" type="java.lang.Integer">
              <generator class="native"></generator>
          </id>
          <property name="name" column="name" length="100" type="java.lang.String"/>
          <!--使用 set 元素维护一对多关联关系-->
          <set name="students">
              <key column="gid"></key>
              <one-to-many class="net.biancheng.www.po.Student"></one-to-many>
          </set>
      </class>
  </hibernate-mapping>
  ```

### 5.2 一对多

- 创建 Course 的映射文件 Coures.hbm.xml

  ```xml
  <?xml version='1.0' encoding='utf-8'?>
  <!DOCTYPE hibernate-mapping PUBLIC
          "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
          "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">
  <hibernate-mapping>
      <class name="net.biancheng.www.po.Course" table="course" schema="bianchengbang_jdbc">
          <id name="id" column="id" >
              <generator class="native"></generator>
          </id>
          <property name="name" column="name" length="100"/>
         
          <set name="students" table="student_course" cascade="save-update">
              <key column="cid"></key>
              <many-to-many class="net.biancheng.www.po.Student" column="sid"></many-to-many>
          </set>
      </class>
  </hibernate-mapping>
  ```

- 改 Student.hbm.xml 的配置，在其中添加 <set> 标签映射关联关系

  ```xml
  <?xml version='1.0' encoding='utf-8'?>
  <!DOCTYPE hibernate-mapping PUBLIC
          "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
          "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">
  <hibernate-mapping>
      <class name="net.biancheng.www.po.Student" table="student" schema="bianchengbang_jdbc" lazy="true">
          <!--主键映射-->
          <id name="id" column="id" type="java.lang.Integer">
              <!--主键生成策略-->
              <generator class="native"></generator>
          </id>
          <property name="name" column="name" length="100" type="java.lang.String"></property>
          <!--维护关联关系-->
          <many-to-one name="grade" class="net.biancheng.www.po.Grade" column="gid"/>
          <set name="courses" table="student_course" lazy="false">
              <key column="sid"></key>
              <many-to-many class="net.biancheng.www.po.Course" column="cid"></many-to-many>
          </set>
      </class>
  </hibernate-mapping>
  ```

### 5.3 多对多

- 修改映射文件 Grade.hbm.xml 的配置

  ```xml
  <?xml version='1.0' encoding='utf-8'?>
  <!DOCTYPE hibernate-mapping PUBLIC
          "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
          "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">
  <hibernate-mapping>
      <class name="net.biancheng.www.po.Grade" table="grade" schema="bianchengbang_jdbc">
          <id name="id" column="id" type="java.lang.Integer">
              <generator class="native"></generator>
          </id>
          <property name="name" column="name" length="100" type="java.lang.String"/>
          <!--设置 inverse 属性为 true，使其丧失对关联关系的控制权，由 Student 来管理关联关系-->
          <set name="students" inverse="true">
              <key column="gid"></key>
              <one-to-many class="net.biancheng.www.po.Student"></one-to-many>
          </set>
      </class>
  </hibernate-mapping>
  ```

- 修改映射文件 Course.hbm.xml 的配置

  ```xml
  <?xml version='1.0' encoding='utf-8'?>
  <!DOCTYPE hibernate-mapping PUBLIC
          "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
          "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">
  <hibernate-mapping>
      <class name="net.biancheng.www.po.Course" table="course" schema="bianchengbang_jdbc">
          <id name="id" column="id">
              <generator class="native"></generator>
          </id>
          <property name="name" column="name" length="100"/>
          <!--设置 inverse 属性为 true，使其丧失对关联关系的控制权，由 Student 来管理关联关系-->
          <set name="students" table="student_course" inverse="true">
              <key column="cid"></key>
              <many-to-many class="net.biancheng.www.po.Student" column="sid"></many-to-many>
          </set>
      </class>
  </hibernate-mapping>
  ```

# 第二部分 Java注解Hibernate

# 第三部分 Hibernate集成SpringBoot

