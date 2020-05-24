# 前言



# 第一章 数据持久化

## 1.1 基本环境准备

<font size=4 color=blue>**1. 准备数据库测试表** </font>

```sql
create database if not exists case_mybatisplus;
use case_mybatisplus;

create table if not exists mybatis_employee
(
  id         char(50) primary key comment 'ID',
  dept_id    bigint unsigned comment '部门ID',
  name       varchar(30)    default '' comment '用户名',
  age        int unsigned   default 0 comment '年龄',
  gender     tinyint        default 1 comment '性别',
  salary     decimal(15, 3) default -1 comment '工资'
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'mybatis练习:员工表';

insert into mybatis_employee values ('1',1,'令狐冲',23,'1','2300');
insert into mybatis_employee values ('2',2,'任盈盈',23,'1','3422');
insert into mybatis_employee values ('3',1,'岳不群',55,'1','8888');

create table if not exists mybatis_department
(
  id         bigint unsigned primary key auto_increment comment 'ID',
  dept_name  varchar(30)     default '' comment '部门名称'
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8 comment 'mybatis练习:部门表';

insert into mybatis_department values (1,'华山派');
insert into mybatis_department values (2,'日月派');
```

<font size=4 color=blue>**2. 新建Maven工程添加基本依赖** </font>

```xml
<!-- 1. 添加mysql驱动 -->
<dependency>
    <groupId>mysql</groupId>
    <artifactId>mysql-connector-java</artifactId>
    <version>8.0.18</version>
</dependency>

<!-- 2. 测试相关工具 -->
<dependency>
    <groupId>junit</groupId>
    <artifactId>junit</artifactId>
    <version>4.12</version>
    <scope>test</scope>
</dependency>
<dependency>
    <groupId>org.projectlombok</groupId>
    <artifactId>lombok</artifactId>
    <version>1.16.18</version>
    <scope>provided</scope>
</dependency>
```

<font size=4 color=blue>**3. 新建数据表对应的实体类** </font>：在之后的学习中一直用这两张表

```java
@Setter
@Getter
@ToString
public class EmployeeDO implements Serializable {
    private static final long serialVersionUID = 749824536257824974L;
    /**
    * ID
    */
    private String id;
    /**
    * 部门ID
    */
    private Long deptId;
    /**
    * 用户名
    */
    private String name;
    /**
    * 年龄
    */
    private Integer age;
    /**
    * 性别
    */
    private Boolean gender;
    /**
    * 工资
    */
    private BigDecimal salary;

}

@Setter
@Getter
@ToString
public class DepartmentDO {
    /**
     * id
     */
    private Integer id;
    /**
     * 部门名称
     */
    private String deptName;
}
```

## 1.2 使用JDBC操作数据库

<font size=4 color=blue>**1. 使用JDBC操作数据库的基本流程** </font>

- **【加】**加载数据库驱动：Class.forName(DRIVER)

- **【连】**创建数据库连接对象：DriverManager.getConnection(URL, USERNAME, PASSWORD);

- **【预】**创建SQL预编译Statement 对象：Connection.reateStatement()

- **【执】**执行 SQL处理结果集：Statement .executeQuery(sql)

- **【释】**释放对象：close()

  ```java
  public class JDBCTest {
  
      private static final String URL = "jdbc:mysql://127.0.0.1:3306/case_mybatisplus";
      private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
      private static final String USERNAME = "root";
      private static final String PASSWORD = "root";
  
      @Test
      public void testJdbc() {
          String sql = "SELECT * FROM mybatis_employee WHERE dept_id = 1";
          Connection conn = null;
          try {
              Class.forName(DRIVER);
              conn = DriverManager.getConnection(URL, USERNAME, PASSWORD);
              Statement stmt = conn.createStatement();
              ResultSet rs = stmt.executeQuery(sql);
              List<EmployeeDTO> employees = new ArrayList<>(rs.getRow());
              while (rs.next()) {
                  EmployeeDTO employee = new EmployeeDTO();
                  employee.setId(rs.getString("id"));
                  employee.setName(rs.getString("name"));
                  employee.setDeptId(rs.getLong("dept_id"));
                  employee.setAge(rs.getInt("age"));
                  employee.setSalary(rs.getDouble("salary"));
                  employee.setGender(rs.getBoolean("gender"));
                  employees.add(employee);
              }
              System.out.println("Query SQL ==> " + sql);
              System.out.println("Query Result: ");
              employees.forEach(System.out::println);
          } catch (Exception e) {
              e.printStackTrace();
          } finally {
              try {
                  if (conn != null) {
                      conn.close();
                  }
              } catch (SQLException e) {
                  e.printStackTrace();
              }
          }
      }
  }
  ```

<font size=4 color=blue>**2. 使用总结** 	</font>

​		JDBC最核心的步骤其实只有两步：**SQL的编写**（正确的SQL自然能执行成功）和**结果集的处理**，其余的步骤虽然必不可少，但是可以模块化的东西；JDBC的优点不必多说，**最快的**，总结一下主要的缺点

- 每次请求需要创建数据库连接，浪费资源：可以采用连接池解决
- SQL和Java代码耦合严重，对优化不友好：解决方案将SQL和Java代码分离，SQL独立配置
- 对结果集的处理会浪费大量的代码处理简单的字段和实体属性的映射，冗余严重：完善数据库和实体映射

## 1.3 使用SpringJDBC操作数据库

<font size=4 color=blue>**1. 在Maven项目中添加SpringJDBC依赖** </font>

```xml
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-context</artifactId>
    <version>5.0.6.RELEASE</version>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-jdbc</artifactId>
    <version>5.1.2.RELEASE</version>
</dependency>
<dependency>
    <groupId>org.springframework</groupId>
    <artifactId>spring-tx</artifactId>
    <version>5.1.2.RELEASE</version>
</dependency>
<dependency>
    <groupId>commons-logging</groupId>
    <artifactId>commons-logging</artifactId>
    <version>1.2</version>
</dependency>
```

<font size=4 color=blue>**2. 使用JdbcTemplate操作数据库** </font>

```java
public class StringJDBCTest {
    private static final String URL = "jdbc:mysql://127.0.0.1:3306/case_mybatisplus";
    private static final String DRIVER = "com.mysql.cj.jdbc.Driver";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "root";
    
    JdbcTemplate jdbcTemplate;

    @Before
    public void initJdbcTemplate() throws Exception {
        DataSource d = new SimpleDriverDataSource(new Driver(), URL, USERNAME, PASSWORD);
        jdbcTemplate = new JdbcTemplate();
        jdbcTemplate.setDataSource(d);
    }

    @Test
    public void selectEmp() throws Exception {
        String sql = "SELECT * FROM mybatis_employee WHERE dept_id = 1";
        List<EmployeeDTO> employees = new ArrayList<>();
        jdbcTemplate.query(sql, new ResultSetExtractor<List<EmployeeDTO>>() {
            @Override
            public List<EmployeeDTO> extractData(ResultSet rs) throws Exception{
                while (rs.next()) {
                    EmployeeDTO employee = new EmployeeDTO();
                    employee.setId(rs.getString("id"));
                    employee.setName(rs.getString("name"));
                    employee.setDeptId(rs.getLong("dept_id"));
                    employee.setAge(rs.getInt("age"));
                    employee.setSalary(rs.getDouble("salary"));
                    employee.setGender(rs.getBoolean("gender"));
                    employees.add(employee);
                }
                return employees;
            }
        });
        System.out.println("Query SQL ==> " + sql);
        System.out.println("Query Result: ");
        employees.forEach(System.out::println);
    }
}

```

<font size=4 color=blue>**3. 使用总结** </font>

​	从代码中可以看出来，使用SpringJDBC操作数据库的核心步骤也只有两步：**SQL的编写**（正确的SQL自然能执行成功）和**结果集的处理**，但是对比JDBC而言，其他的步骤比如数据库的连接对象，SQL语句的执行对象不再在编码中完成；缺点还是很明显的：从JDBC的缺点中拷贝来两条

- SQL和Java代码耦合严重，对优化不友好：解决方案将SQL和Java代码分离，SQL独立配置
- 对结果集的处理会浪费大量的代码处理简单的字段和实体属性的映射，冗余严重：完善数据库和实体映射

## 1.4 使用Hibernate操作数据库

<font size=4 color=blue>**1. 添加Hibernate的依赖** </font>

```xml
<dependency>
    <groupId>org.hibernate</groupId>
    <artifactId>hibernate-core</artifactId>
    <version>5.2.6.Final</version>
</dependency>
```

<font size=4 color=blue>**2. 添加日志依赖以及相关的配置文件：在这里使用 `log4j.properties`** </font>

```xml
<dependency>
    <groupId>log4j</groupId>
    <artifactId>log4j</artifactId>
    <version>1.2.16</version>
</dependency>
```

```properties
log4j.rootLogger=DEBUG,CONSOLE
log4j.logger.cn.siliang.dao=debug
log4j.logger.com.ibatis=debug
log4j.logger.com.ibatis.common.jdbc.SimpleDataSource=debug
log4j.logger.com.ibatis.common.jdbc.ScriptRunner=debug
log4j.logger.com.ibatis.sqlmap.engine.impl.SqlMapClientDelegate=debug
log4j.logger.java.sql.Connection=debug
log4j.logger.java.sql.Statement=debug
log4j.logger.java.sql.PreparedStatement=debug
log4j.logger.java.sql.ResultSet=debug
log4j.logger.org.tuckey.web.filters.urlrewrite.UrlRewriteFilter=debug
######################################################################################
log4j.appender.CONSOLE=org.apache.log4j.ConsoleAppender
log4j.appender.Threshold=error
log4j.appender.CONSOLE.Target=System.out
log4j.appender.CONSOLE.layout=org.apache.log4j.PatternLayout
log4j.appender.CONSOLE.layout.ConversionPattern=%d{yyyy-M-d HH:mm:ss}%x[%5p][%F:%L]%m%n
######################################################################################
log4j.appender.file=org.apache.log4j.DailyRollingFileAppender
log4j.appender.file.DatePattern=yyyy-MM-dd
log4j.appender.file.File=log.log
log4j.appender.file.Append=true
log4j.appender.file.Threshold=error
log4j.appender.file.layout=org.apache.log4j.PatternLayout
log4j.appender.file.layout.ConversionPattern=%d{yyyy-M-d HH:mm:ss}%x[%5p](%F:%L)%m%n
log4j.logger.com.opensymphony.xwork2=error
```

<font size=4 color=blue>**3. Hibernate数据配置文件：hibernate.cfg.xml（根目录）** </font>

```xml
<?xml version='1.0' encoding='utf-8'?>
<!DOCTYPE hibernate-configuration PUBLIC
        "-//Hibernate/Hibernate Configuration DTD//EN"
        "http://www.hibernate.org/dtd/hibernate-configuration-3.0.dtd">
<hibernate-configuration>
    <session-factory>
        <property name="current_session_context_class">thread</property>
        <property name="hibernate.connection.driver_class">
            com.mysql.jdbc.Driver
        </property>
        <property name="hibernate.connection.url">
            jdbc:mysql://localhost/case_mybatisplus
        </property>
        <property name="hibernate.connection.username">root</property>
        <property name="hibernate.connection.password">root</property>

        <!-- 可以将向数据库发送的SQL语句显示出来 -->
        <property name="hibernate.show_sql">true</property>
        <!-- 格式化SQL语句 -->
        <property name="hibernate.format_sql">true</property>

        <!-- hibernate的方言 -->
        <property name="hibernate.dialect">org.hibernate.dialect.MySQLDialect</property>

        <!-- 配置hibernate的映射文件所在的位置 -->
        <mapping resource="Employee.hbm.xml" />
    </session-factory>
</hibernate-configuration>
```

<font size=4 color=blue>**4. 实体类映射文件：Employee.hbm.xml（根目录）** </font>

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE hibernate-mapping PUBLIC
        "-//Hibernate/Hibernate Mapping DTD 3.0//EN"
        "http://www.hibernate.org/dtd/hibernate-mapping-3.0.dtd">
<hibernate-mapping package="com.panda.mybatis">
    <!--
        name：即实体类的全名
        table：映射到数据库里面的那个表的名称
        catalog：数据库的名称
     -->
    <class name="com.panda.mybatis.model.domain.EmployeeDO" table="mybatis_employee">
        <!-- class下必须要有一个id的子元素 -->
        <!-- id是用于描述主键的 -->
        <id name="id" column="id">
            <!-- 主键生成策略 -->
            <generator class="native"/>
        </id>
        <!--
            使用property来描述属性与字段的对应关系
            如果length忽略不写，且你的表是自动创建这种方案，那么length的默认长度是255
        -->
        <property name="deptId" column="dept_id"/>
        <property name="name" column="name"/>
        <property name="age" column="age"/>
        <property name="gender" column="gender"/>
        <property name="salary" column="salary"/>
    </class>
</hibernate-mapping>
```

<font size=4 color=blue>**5. 使用Hibernate做查询** </font>

```java
@Test
public void demo1() {
    //1. 加载Hibernate的核心配置文件
    Configuration configuration = new Configuration().configure();

    //2. 创建SessionFactory对象，类似于JDBC中的连接池
    SessionFactory sessionFactory = configuration.buildSessionFactory();

    //3. 通过SessionFactory获取到Session对象，类似于JDBC中的Connection
    Session session = sessionFactory.openSession();
    EmployeeDO employeeDO = session.get(EmployeeDO.class, "1");
    System.out.println(employeeDO);
    //7. 释放资源
    session.close();
    sessionFactory.close();
}
```

<font size=4 color=blue>**6. 使用总结** </font>

​		在Hibernate的使用中，需要在配置文件中添加大量的配置，在对数据操作的过程中除了需要关注数据本来的业务逻辑，还需要对Hibernate框架的配置做到熟练应用，学习成本稍高；

​		Hibernate的使用还是比较简单的，在上述的查询操作中没有看见一句SQL，其核心逻辑就是一句话：`session.get(EmployeeDO.class, "1")`；

# 第二章 Mybatis入门案例

## 2.1 MyBatis简介

​		前身是iBatis，原来是Apache的一个开源项目，在2010年6月份这个项目迁移到了Google Code，随着该项目的不断升级，iBatis3.x也正式推出，并同时改名为MyBatis。随后MyBatis项目迁移到了Github。

- MyBatis 是支持定制化 SQL、存储过程以及高级映射的优秀的持久层框架。
- MyBatis 避免了几乎所有的 JDBC 代码和手动设置参数以及获取结果集。
- MyBatis可以使用简单的XML或注解用于配置和原始映射，将接口和Java的实体映射成数据库中的记录。

## 2.2 MyBatis入门案例

<font size=4 color=blue>**1. 准备MyBatis基本依赖** </font>

```xml
<!-- 1. MyBatis -->
<dependency>
    <groupId>org.mybatis</groupId>
    <artifactId>mybatis</artifactId>
    <version>3.2.6</version>
</dependency>
<dependency>
    <groupId>cglib</groupId>
    <artifactId>cglib</artifactId>
    <version>3.2.5</version>
</dependency>
```

<font size=4 color=blue>**2. log4j日志依赖以及配置文件 ** </font>

<font size=4 color=blue>**3. 初始化数据库和数据表** </font>

<font size=4 color=blue>**4. JavaBean** </font>

<font size=4 color=blue>**5. MyBatis全局配置文件 mybatis-configuration.xml** </font>

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE configuration
        PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-config.dtd">
<configuration>
    <settings>
        <setting name="mapUnderscoreToCamelCase" value="true"/>
    </settings>
    <!-- 全局环境配置-->
    <environments default="development">
        <environment id="development">
            <!-- 事物 -->
            <transactionManager type="JDBC"/>
            <!-- 配置数据源 -->
            <dataSource type="POOLED">
                <!-- 数据库驱动  -->
                <property name="driver" value="com.mysql.jdbc.Driver"/>
                <property name="url"
                          value="jdbc:mysql://localhost:3306/case_mybatisplus"/>
                <property name="username" value="root"/>
                <property name="password" value="root"/>
            </dataSource>
        </environment>
    </environments>

    <!-- 引入自定义mapper.xml -->
    <mappers>
        <mapper resource="mybatis/mapper/EmployeeMapper.xml"/>
    </mappers>
</configuration>
```

<font size=4 color=blue>**4. SQL配置文件** </font>

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper
        PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
        "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
<mapper namespace="com.panda.mybatis.mapper.EmployeeMapper">

    <select id="selectList" resultType="com.panda.mybatis.model.domain.EmployeeDO">
        select * from mybatis_employee;
    </select>
</mapper>
```

<font size=4 color=blue>**5. 定义Mapper接口** </font>

```java
public interface EmployeeMapper {
    List<EmployeeDO> selectList();
}
```

<font size=4 color=blue>**6. 测试Helloworld** </font>

```java
public class MyBatisTest {

    SqlSession sqlSession;
    @Before
    public void before() throws Exception{
        String resource = "mybatis/mybatis-configuration.xml";
        // 配置mybatis获得输入流
        InputStream inputStream = Resources.getResourceAsStream(resource);
        // 创建 SqlSessionFactory
        SqlSessionFactory sqlSessionFactory =
                new SqlSessionFactoryBuilder().build(inputStream);
        //从 SqlSessionFactory 中获取 SqlSession
        sqlSession = sqlSessionFactory.openSession();
    }
    @After
    public void after() throws Exception{
        // 关闭 SqlSession
        sqlSession.close();
    }
    @Test
    public void getEmployees() throws Exception{
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        List<EmployeeDO> employees = mapper.selectList();
        employees.forEach(System.out::println);
    }
}
```

# 第二章 MyBatis相关API

## 2.1 配置文件相关

<font size=4 color=blue>**1. 配置文件方式** </font>

- **xml格式的配置文件**
- **Java代码格式的配置类**

<font size=4 color=blue>**2. 常用配置属性说明** </font>

## 2.2 SqlSessionFactory

<font size=4 color=blue>**1. 说明** </font>

<font size=4 color=blue>**2. API** </font>

## 2.3 SqlSession

# 第二章 MyBatis的基本操作

## 1. 初始化SqlSessionFactory对象

- 根据Mybatis全局配置文件 : mybatis-cfg.xml

  ```java
  Resources.getResourceAsStream(配置文件的路径);
  ```

- 根据文件流解析XML文件并完成SqlSessionFactory的初始化

  ```java
  new SqlSessionFactoryBuilder().build(resourceAsStream);
  ```


# 第三章 Mybatis全局配置文件

## 3.1 配置文件属性

### configuration

- 全局配置的根节点
- 子标签配置要按照顺序定义

#### properties

- **作用 : ** 引入外部配置文件,读取配置文件中的数据  , 使用`${}`语法

- **格式** : 配置格式

  ```xml
  <properties resource="" url=""/>
  ```

  > 属性 : resource : 读取本地磁盘的资源文件
  >
  > 属性 : url : 读取网络环境或磁盘资源文件

#### settings

- **作用 : ** Mybatis的全局设置 : 通过对设置项的修改可以改变Mybatis运行时行为

- **格式**

  ```xml
  <settings>
      <setting name="" value=""/>
  </settings>
  ```

  > 属性 : name 表示设置项的名称
  >
  > 属性 : value 表示设置项的值

- **常用设置项说明**

  | 设置项名称                       | 作用说明                                    | 取值范围                      |
  | -------------------------------- | ------------------------------------------- | ----------------------------- |
  | cacheEnabled = true              |                                             |                               |
  | lazyLoadingEnabled = false       | 级联查询时的懒加载                          | true <br />false              |
  | aggressiveLazyLoading = false    | 侵入加载 : 按需加载<br />    或    加载全部 | true <br />false              |
  | multipleResultSetsEnabled = true |                                             |                               |
  | useColumnLabel = true            |                                             |                               |
  | useGeneratedKeys = false         | 开启获取自增主键                            |                               |
  | autoMappingBehavior = PARTIAL    | 自动映射行为                                | NONE<br />PARTIAL<br />FULL   |
  | autoMappingUnknownColum = NONE   |                                             | NONE<br />WARNING<br/>FAILING |
  | defaultExecutorType = SIMPLE     |                                             | SIMPLE<br />REUSE<br />BATCH  |
  | defaultStatementTimeout          |                                             |                               |
  | defaultFetchSize                 |                                             |                               |
  | safeRowBoundsEnabled = false     |                                             |                               |
  | safeResultHandlerEnabled = true  |                                             |                               |
  | mapUnderscoreToCamelCase = false | 驼峰命名规则                                | true <br />false              |
  | localCacheScope = SESSION        |                                             | SESSION<br />STATEMENT        |
  | jdbcTypeForNull = OTHER          | 数据库对NULL值处理规则                      | NULL<br />VARCHAR<br />OTHER  |
  | lazyLoadTriggerMethods           |                                             |                               |
  | defaultScriptingLanguage         |                                             |                               |
  | defaultEnumTypeHandler           |                                             |                               |
  | callSettersOnNulls               |                                             |                               |
  | returnInstanceForEmptyRow        |                                             |                               |
  | logPrefix                        |                                             |                               |
  | logImpl                          |                                             |                               |
  | proxyFactory                     |                                             |                               |
  | vfsImpl                          |                                             |                               |
  | useActualParamName               |                                             |                               |
  | configurationFactory             |                                             |                               |

#### typeAliases

- **作用 : ** 设置全局的别名,在引用类全限定名称时 用于给类设置别名,简化配置文件

- **格式** : 别名不区分大小写

  ```xml
  <typeAliases>
      <typeAlias type="" alias=""/>
      <package name=""/>
  </typeAliases>
  ```

  > 子标签 : typeAlias 用于给单个类起别名
  >
  > 子标签 : package 用于批量起别名 , 默认别名为类的简单名称

- 使用别名注解

  ```java
  @Alias("别名")
  public class 类名{
      
  }
  ```

- **MyBatis内置别名**

  | 别名       | 映射类型   |
  | ---------- | ---------- |
  | _byte      | byte       |
  | _long      | long       |
  | _short     | short      |
  | _int       | int        |
  | _integer   | int        |
  | _double    | double     |
  | _float     | float      |
  | _boolean   | boolean    |
  | string     | String     |
  | byte       | Byte       |
  | long       | Long       |
  | short      | Short      |
  | int        | Integer    |
  | integer    | Integer    |
  | double     | Double     |
  | float      | Float      |
  | boolean    | Boolean    |
  | date       | Date       |
  | decimal    | BigDecimal |
  | bigdecimal | BigDecimal |
  | object     | Object     |
  | map        | Map        |
  | hashmap    | HashMap    |
  | list       | List       |
  | arraylist  | ArrayList  |
  | collection | Collection |
  | iterator   | Iterator   |

#### typeHandlers

- **作用** : 自定义类型处理器 ,java类型和数据类型的映射规则
- **格式**
- **自定义类型处理器**

#### plugins

- **作用** : 插件原理,通过拦截SQL执行的关键步骤,完成插件功能

- **插件的配置**

  ```xml
  <plugins>
      <plugin interceptor=""></plugin>
  </plugins>
  ```

- **自定义插件**

  1. 插件拦截的关键对象

     • **Executor** (update, query, flushStatements, commit, rollback, getTransaction, close, isClosed)
     • **ParameterHandler** (getParameterObject, setParameters)
     • **ResultSetHandler** (handleResultSets, handleOutputParameters)
     • **StatementHandler** (prepare, parameterize, batch, update, query) 

#### environments

- **作用 : ** 配置mybatis开发坏境 , 可以配置多种坏境,一个子标签`environment`代表一种数据库环境

  > 属性 default 表示当前默认的坏境名称

- **坏境配置**

  ```xml
  <environment id="唯一标识">
      <transactionManager type="JDBC"/>
      <dataSource type="POOLED">
          <property name="driver" value="${jdbc.driver}"/>
          <property name="url" value="${jdbc.url}"/>
          <property name="username" value="${jdbc.username}"/>
          <property name="password" value="${jdbc.password}"/>
      </dataSource>
  </environment>
  ```

  > environment > id : 表示当前坏境的唯一标识
  >
  > transactionManager > type : 配置事务管理器类型 : JDBC | MANAGED
  >
  > dataSource > type: 配置数据源类型 : POOLED-UNPOOLED-JNDI	

#### databaseIdProvider

- **作用 : ** 可以根据不同的数据库厂商执行不同的SQL语句(对一致性的支持)

- **配置数据库标识**

  ```xml
  <databaseIdProvider type="DB_VENDOR">
      <property name="MySQL" value="mysql"/>
      <property name="Oracle" value="oracle"/>
  </databaseIdProvider>
  ```

  > ① databaseIdProvider type="DB_VENDOR" : 自动获取数据库厂商标识
  >
  > ② property > name : 为数据库厂商配置别名
  >
  > ③ 在SQL配置文件的SQL标签中指定`databaseId`属性标识当前SQL的数据库厂商

#### mappers

- **作用 : ** 将SQL映射文件注册的全局环境中

- **格式 : **

  ```xml
  <mappers>
      <mapper resource="" class=""/>
      <package name=""/>
  </mappers>
  ```

  > 子标签mapper的属性 : resource注册基于SQL配置文件的形式注册配置文件
  >
  > 子标签mapper的属性 : class : 基于注解的SQL映射方式注册接口
  >
  > 子标签package : 批量注册SQL配置文件 : 配置文件与接口同名且在同一个包中



# 第四章 MyBatis的SQL配置文件

## 4.1 mapper与参数处理

### 1. namespace 

- 表示配置文件的标识

### 2. 参数处理

- 一个参数 : mybatis对参数不做处理,mybatis只要识别到SQL占位符便会参数的值编译到SQL占位符语句中

- 多个参数 : 会做特殊处理,将多个参数封装为map

  - 封装规则一

    ```properties
    map.key:param1,param2, ... ... paramn
    map.vakue:传入的值
    ```

  - 封装规则二

    ```properties
    map.key:0,1, ... ... n		# 参数索引
    map.vakue:传入的值
    ```

  - 封装规则三 : 命名封装参数规则

    - 指定key : `@Param("指定参数key")`
    - 根据key获取value : `#{key}`

  - 封装规则四 : POJO

    - 将多个参数封装为一个POJO,参数使用POJO作为参数

  - 封装规则五 : 直接使用map

    - {map.key} 获取map中的value

- 特殊参数 : 集合类型参数 也会封装在map中

  - Collection集合 : key=collection
  - List集合  : key = list
  - 数组 : key = array

### 3. 取值方式

- {} : 预编译的方式生成SQL

- 可以指定取值规则JdbcType : 作用数据库可以不能识别null的处理 JdbcType = NULL改变null的处理
- 全局配置的 `jdbcTypeForNull = OTHER`对null的处理为`OTHER`

- ${} : 字符串替换的方式生成SQL

## 4.2 SQL映射标签

> SQL的增删改操作结果是对数据库影响的行数;
>
> SQL的增删改操作的返回值 : Integer | Long | Boolean

### 1. insert

- **自增主键** : 由java.sql.Statement.getGeneratedKeys() 实现

  ```xml
  <insert useGeneratedKeys="true" keyProperty="">
      <!-- SQL -->
  </insert>
  ```

  > useGeneratedKeys : 表示开启获取自增主键的值
  >
  > keyProperty : 表示获取的自增主键的值设置给实体对象的哪个属性

- **UUID主键** : 在执行SQL之前执行selectKey生成UUID并设置给实体对象,Oracle 获取自增序列原理相同

### 2. update

### 3. selectKey

- **作用 : ** 是`inset` 和 `update` 标签的子标签,可以在执行**新增和修改**SQL时额外执行的一条SQL语句

- **属性说明**

  ```xml
  <selectKey order="BEFORE" keyProperty="id" resultType="string">
  	select UUID()
  </selectKey>
  ```

  > 属性order : 表示该SQL对于父标签的SQL的执行时机 : BEFORE表示之前 , AFTER 表示之后
  >
  > 属性 keyProperty : 表示将查询结果封装给实体对象的哪个属性
  >
  > 属性 resultType : 表示查询结果的数据类型

### 4. delete

### 5. select

- 查询一条并且将结果封装为实体 : 设置属性`resultType="实体全限定名"`
  - **resultType : ** 自动封装结果集
    - 需要开启全局设置 : autoMappingBehavior = PARTIAL
    - (辅助)驼峰命名规则 : mapUnderscoreToCamelCase = true
- 查询多条并封装 : 设置属性`resultType="集合中单个元素的数据类型"`
- 查询并且将结果封装为map : 设置属性`resultType="map"`
  - 指定map的key`@Mapkey(结果中的哪个属性作为key)   `
  - 指定返回值类型`Map<注解类型,单条记录实体类型>` 
- 自定义查询结果集 : resultMap

### 6. sql与include

- sql 标签 定义通用SQL语句块
- include标签 引用通用的SQL语句块

## 4.3 自定义查询结果集resultMap

### 1. resultMap

### 2. collections

### 3. 

## 4.4 动态标签

### 1. where

### 2. if

### 3. case-when

## 4.3 缓存标签

# 1. mybatis参数封装原理

## ParamNameResolver.getNamedParams

```java
public Object getNamedParams(Object[] args) {
    // 参数个数
    int paramCount = this.names.size();
    if (args != null && paramCount != 0) {
        // 如果是一个参数 : 直接将参数的值返回
        if (!this.hasParamAnnotation && paramCount == 1) {
            return args[(Integer)this.names.firstKey()];
        } else {
            
            // 新建map用于封装参数
            Map<String, Object> param = new ParamMap();
            int i = 0;
			// 遍历参数
            for(Iterator var5 = this.names.entrySet().iterator(); var5.hasNext(); ++i) {
                Entry<Integer, String> entry = (Entry)var5.next();
                // put 规则一
                param.put(entry.getValue(), args[(Integer)entry.getKey()]);
                String genericParamName = "param" + String.valueOf(i + 1);
                
                // 如果没有命名封装参数 使用封装规则二
                if (!this.names.containsValue(genericParamName)) {
                    // put 规则二
                    param.put(genericParamName, args[(Integer)entry.getKey()]);
                }
            }
            return param;
        }
    } else {
        return null;
    }
}
```

-----

-----

----

- 一、MyBatis简介
- 二、MyBatis-HelloWorld
- 三、MyBatis-全局配置文件
- 四、MyBatis-映射文件
- 五、MyBatis-动态SQL
- 六、MyBatis-缓存机制
- 七、MyBatis-Spring整合
- 八、MyBatis-逆向工程
- 九、MyBatis-工作原理
- 十、MyBatis-插件开发

001_简介

1. 持久层框架介绍
    - jdbc
    - DbUtils
    - JdbcTemplate
    - Hibernate
    - MyBatis
2. 与Hibernate比较

002_mybatis下载

1. [MyBatis Github托管地址](https://github.com/mybatis/mybatis-3)
2. [MyBatis官网文档](https://mybatis.org/mybatis-3/zh/index.html)

003_开发坏境准备

1. 数据表mybatis_employee与mybatis_department

    ```sql
    create table if not exists mybatis_employee
    (
      id         char(50) primary key comment 'ID',
      dept_id    bigint unsigned comment '部门ID',
      name       varchar(30)    default '' comment '用户名',
      age        int unsigned   default 0 comment '年龄',
      gender     tinyint        default 1 comment '性别',
      salary     decimal(15, 3) default -1 comment '工资',
      birthday   date           default '0000-00-00' comment '生日',
      login_date datetime       default '0000-00-00 00-00-00' comment '上次登录时间戳',
      gmt_create datetime       default '0000-00-00 00-00-00' comment '创建日期时间戳',
      gmt_modify datetime       default '0000-00-00 00-00-00' comment '修改日期时间戳'
    ) comment 'mybatis练习:员工表';
    
    create table if not exists mybatis_department
    (
      id         bigint unsigned primary key auto_increment comment 'ID',
      parent_id  bigint unsigned default 0 comment '上级部门',
      dept_name  varchar(30)     default '' comment '部门名称',
      gmt_create datetime        default '0000-00-00 00-00-00' comment '创建日期时间戳',
      gmt_modify datetime        default '0000-00-00 00-00-00' comment '修改日期时间戳'
    ) comment 'mybatis练习:部门表';
    ```

2. 数据表对应的JavaBean

    ```java
    @Setter
    @Getter
    public class EmployeePO {
        private String id;
        private String name;
        private Integer age;
        private Boolean gender;
        private BigDecimal salary;
        private LocalDate birthday;
        private LocalDateTime loginDate;
        private LocalDateTime gmtCreate;
        private LocalDateTime gmtModify;
    }
    
    @Setter
    @Getter
    public class DepartmentPO {
        private Integer id;
        private Integer parentId;
        private String deptName;
        private LocalDateTime gmtCreate;
        private LocalDateTime gmtModify;
    }
    ```

3. 准备数据驱动包

    ```xml
    <dependency>
        <groupId>org.mybatis</groupId>
        <artifactId>mybatis</artifactId>
        <version>3.5.1</version>
    </dependency>
    <dependency>
        <groupId>org.slf4j</groupId>
        <artifactId>slf4j-api</artifactId>
        <version>1.7.5</version>
    </dependency>
    <dependency>
        <groupId>org.slf4j</groupId>
        <artifactId>slf4j-log4j12</artifactId>
        <version>1.7.12</version>
    </dependency>
    <dependency>
        <groupId>log4j</groupId>
        <artifactId>log4j</artifactId>
        <version>1.2.17</version>
    </dependency>
    ```

4. 准备log4j包的log4j.properties配置文件

    ```properties
    log4j.rootLogger=DEBUG,CONSOLE
    log4j.logger.cn.siliang.dao=debug
    log4j.logger.com.ibatis=debug
    log4j.logger.com.ibatis.common.jdbc.SimpleDataSource=debug
    log4j.logger.com.ibatis.common.jdbc.ScriptRunner=debug
    log4j.logger.com.ibatis.sqlmap.engine.impl.SqlMapClientDelegate=debug
    log4j.logger.java.sql.Connection=debug
    log4j.logger.java.sql.Statement=debug
    log4j.logger.java.sql.PreparedStatement=debug
    log4j.logger.java.sql.ResultSet=debug
    log4j.logger.org.tuckey.web.filters.urlrewrite.UrlRewriteFilter=debug
    ######################################################################################
    log4j.appender.CONSOLE=org.apache.log4j.ConsoleAppender
    log4j.appender.Threshold=error
    log4j.appender.CONSOLE.Target=System.out
    log4j.appender.CONSOLE.layout=org.apache.log4j.PatternLayout
    log4j.appender.CONSOLE.layout.ConversionPattern=%d{yyyy-M-d HH:mm:ss}%x[%5p][%F:%L]%m%n
    ######################################################################################
    log4j.appender.file=org.apache.log4j.DailyRollingFileAppender
    log4j.appender.file.DatePattern=yyyy-MM-dd
    log4j.appender.file.File=log.log
    log4j.appender.file.Append=true
    log4j.appender.file.Threshold=error
    log4j.appender.file.layout=org.apache.log4j.PatternLayout
    log4j.appender.file.layout.ConversionPattern=%d{yyyy-M-d HH:mm:ss}%x[%5p](%F:%L)%m%n
    log4j.logger.com.opensymphony.xwork2=error
    
    ```

5. 准备mybatis配置文件:mybatis.config.xml

    ```xml
    <?xml version="1.0" encoding="UTF-8" ?>
    <!DOCTYPE configuration
            PUBLIC "-//mybatis.org//DTD Config 3.0//EN"
            "http://mybatis.org/dtd/mybatis-3-config.dtd">
    <configuration>
        <environments default="development">
            <environment id="development">
                <transactionManager type="JDBC"/>
                <dataSource type="POOLED">
                    <property name="driver" value="com.mysql.jdbc.Driver"/>
                    <property name="url" value="jdbc:mysql://localhost:3306/case-project?useSSL=false"/>
                    <property name="username" value="root"/>
                    <property name="password" value="root"/>
                </dataSource>
            </environment>
        </environments>
        <mappers>
            <mapper resource="com/panda/mybatis/mapper/EmployeeMapper.xml"/>
        </mappers>
    </configuration>
    ```

6. 准备JavaBean的SQL映射mapper文件

    ```xml
    <?xml version="1.0" encoding="UTF-8" ?>
    <!DOCTYPE mapper
            PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN"
            "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
    <mapper namespace="com.panda.mybatis.mapper.EmployeeMapper">
        <select id="selectEmp" resultType="com.panda.mybatis.entity.EmployeePO">
          select * from mybatis_employee where id = #{id}
      </select>
    </mapper>
    ```

7. 测试mybatis

    ```java
    private SqlSessionFactory sqlSessionFactory;
    
    @Before
    public void testInit() throws Exception {
        String resource = "mybatis.config.xml";
        InputStream inputStream = Resources.getResourceAsStream(resource);
        sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
    }
    ```

005_接口式编程

1. 通过SQLSession构建Mapper对象

    ```java
    SqlSession sqlSession = sqlSessionFactory.openSession();
    EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
    ```

006_mybatis小结

1. 推荐使用接口式编程
    - mapper接口没有实现类,是有框架生成一个代理对象
2. SqlSession表示与数据库的一次回话(连接)
    - 用完必须关闭
    - SqlSession是非现场安全的,不可以定义为成员变量
3. mybatis.config.xml:全局配置文件 数据库相关与全局设置
4. xxxMapper.xml:sql映射文件.封装SQL语句

007_全局配置文件

1. 配置文件的详细信息

    ```txt
    properties（属性）
    settings（设置）
    typeAliases（类型别名）
    typeHandlers（类型处理器）
    objectFactory（对象工厂）
    plugins（插件）
    environments（环境配置）
    environment（环境变量）
    	transactionManager（事务管理器）
    		dataSource（数据源）
    		databaseIdProvider（数据库厂商标识）
    mappers（映射器）
    ```

2. 配置文件的dtd约束文件

008_全局配置:settings

1. settings:这是 MyBatis 中极为重要的调整设置，它们会改变 MyBatis 的运行时行为

    ```xml
    <settings>
        <setting name="key" value="value"/>
        ... ...
    </settings>
    ```

009_typeAliases

1. typeAliases:别名处理器:为Java类型起别名,

    ```xml
    <typeAliases>
        <typeAlias alias="别名" type="类型全类名"/>
        <package name="com.panda.mybatis.entity"/>
    </typeAliases>
    ```

    - 定义type后默认别名是类名小写,别名不区分大小写
    - package可以批量定义别名
    - 使用注解定义别名:@Alias("别名")

2. 内置默认内置别名

010_typeHandlers

1. Java类型与数据库类型映射桥梁

    ```xml
    <typeHandlers>
        <typeHandler handler=""/>
    </typeHandlers>
    ```

    - 日期类型处理器在3.4后新日期类型自动注册

011_plugins

1. 插件:允许拦截mybatis的SQL语句的执行步骤
    - Executor:执行器
    - ParameterHandler:参数处理器
    - ResultSetHandler:结果集处理器
    - StatementHandler:SQL语句处理器

012_environments

1. environments 环境配置
    - 可以配置多种坏境:id代表坏境的唯一标识
    - transactionManager:事务管理器type=JDBC|MANAGED|自定义
        - JDBC是别名:
        - MANAGED是别名:
        - 自定义:实现TransactionFactory接口
    - dataSource:设置数据源 默认3个别名
        - UNPOOLED:不使用连接池
        - POOLED:使用连接池
        - JNDI:
        - 自定义:实现接口DataSourceFactory

013_databaseIdProvider:mybatis一致性,多数据库厂商

1. 根据不同的数据库厂商执行不同的SQL语句,需要在写SQL时候指定数据库厂商,就是发送不同是SQL语句

    ```xml
    <databaseIdProvider type="DB_VENDOR">
        <property name="MySQL" value="mysql"/>
    </databaseIdProvider>
    ```

    - DB_VENDOR:得到数据库厂商的标识
    - property为数据库厂商起别名
    - 在SQL配置文件中指定SQL的数据库厂商

014_mapper

1. 将SQL映射注册到全局配置中

    ```xml
    <mappers>
        <mapper resource="com/panda/mybatis/mapper/EmployeeMapper.xml"/>
        <mapper class=""/>
        <package name=""/>
    </mappers>
    ```

    - resource:单个注册
    - class:注册注解类型的SQL语句
    - package:批量注册:同包名下的同名称

015_全局配置小结

- 配置属性有顺序要求

016_SQL映射文件

1. 映射文件核心内容

    ```txt
    cache – 对给定命名空间的缓存配置。
    cache-ref – 对其他命名空间缓存配置的引用。
    resultMap – 是最复杂也是最强大的元素，用来描述如何从数据库结果集中来加载对象。
    parameterMap – 已被废弃！老式风格的参数映射。更好的办法是使用内联参数，此元素可能在将来被移除。文档中不会介绍此元素。
    sql – 可被其他语句引用的可重用语句块。
    insert – 映射插入语句
    update – 映射更新语句
    delete – 映射删除语句
    select – 映射查询语句
    ```

2. select

    ```xml
    <select id="" 
            resultMap="" 
            lang="" 
            resultType="" 
            parameterType="" 
            databaseId="" 
            fetchSize="" 
            flushCache="" 
            parameterMap="" 
            resultOrdered="" 
            resultSets=""
            statementType="" 
            resultSetType="" 
            timeout="" 
            useCache="">
    </select>
    ```

3. update

    ```xml
    <update id="" 
            timeout="" 
            statementType="" 
            parameterMap="" 
            flushCache="" 
            databaseId="" 
            parameterType="" 
            lang="" 
            keyProperty="" 
            keyColumn="" 
            useGeneratedKeys="">
    </update>
    ```

4. insert

    ```xml
    <insert id="" 
            useGeneratedKeys="" 
            keyColumn="" 
            keyProperty="" 
            lang="" 
            parameterType="" 
            databaseId="" 
            flushCache="" 
            parameterMap="" 
            statementType="" 
            timeout="">
    </insert>
    ```

5. delete

    ```xml
    <delete id="" 
            timeout="" 
            statementType="" 
            parameterMap="" 
            flushCache="" 
            databaseId="" 
            parameterType="" 
            lang="">
    </delete>
    ```

017_自增主键

1. insert自增主键属性

018_Oracle获取主键

1. Oracle获取自增主键的测试

019_非自增序列

1. selectKey:只能用于修改和插入

    ```xml
    <selectKey databaseId="" 
               statementType="" 
               keyProperty="把查询的值封装给Java的哪个属性" 
               keyColumn="" 
               resultType="查询语句返回的数据类型" 
               order="当前的SQL是运行时机">
    </selectKey>
    ```

020_021_mybatis参数处理

1. 参数处理

022_参数扩展

1. 对象参数

023_源码阅读

1. 源码

    ```java
    
    ```

024_#与$

1. 区别

025_#取值规则

1. \#{ javatype jdbctype}

051_mybatis缓存

1. 缓存的作用极大的提高查询效率
2. mybatis的缓存,配置方便
    - mybatis默认定义了两级缓存:一级缓存session和二级缓存mapper级别的
    - 默认情况下只有一级缓存:SqlSession级别的缓存 本地缓存
    - 二级缓存需要手动开启和配置L基于namespace级别的缓存
    - mybatis定义了缓存接口Cache,可以通过实现Cache接口自定义二级缓存

052_一级缓存

1. 一级缓存:与数据库同一次回话期间查询到的数据会放在本地缓存中,以后要获取相同的数据直接从缓存中获取,不用再次从数据库查

    - 一级缓存SqlSession本质是一个map

    - 不同是SqlSession是不同的一级缓存
    - 执行了增删改则一级缓存会失效
    - 手动清空缓存,缓存也会失效

053_二级缓存介绍

2. 二级缓存全局缓存

    - 基于namespace的缓存,一个namespace对应一个二级缓存,保存在namespace对应的缓存map中

    - 工作原理

        > 一个会话查询数据,这个数据会被保存早一级缓存中,会话关闭则缓存失效
        >
        > 如果把一级缓存中数据保存在二级缓存中,新的会话查询就会从缓存中查询

054_二级缓存使用

1. 开启二级缓存:默认是开启的  但是缓存哪个namepace需要手动声明

    ```xml
    <settings>
        <setting name="cacheEnabled" value="true"/>
    </settings>
    ```

2. 声明需要缓存的namepace

    ```xml
     <cache type="指定自定义缓存的全类名" 
            blocking="" 
            eviction="缓存回收策略" 
            flushInterval="缓存刷新间隔多少时间清空一次默认清空  单位 毫秒" 
            readOnly="是否只读:true-认为获取数据是只读操作速度快|false-认为获取的数据会被修改-会反序列化克隆一份新数据" 
            size="最大缓存数元素数"/>
    ```

3. pojo需要实现序列化接口

# 第一章 MyBatis简介

# 第二章 MyBatis入门案例

## 2.1 整合SpringBoot

# 第三章 Mybatis全局配置

#第四章 MyBatis SQL配置文件

## 4.1 cache 

## 4.2 cache-ref  

## 4.3 resultMap  

1. 级联属性封装结果集
2. 

## 4.4 sql  

## 4.5 insert  

## 4.6 update 

## 4.7 delete 

## 4.8 select 

1. 返回单个对象
2. 返回单个值
3. 返回list
4. 返回Map
5. 返回记录的map

