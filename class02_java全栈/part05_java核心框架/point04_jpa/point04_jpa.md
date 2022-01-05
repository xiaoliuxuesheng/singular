# SpringBoot 配置H2

1. 选择SpringBoot版本2.6.2

   ```xml
   <parent>
     <groupId>org.springframework.boot</groupId>
     <artifactId>spring-boot-starter-parent</artifactId>
     <version>2.6.2</version>
     <relativePath/>
   </parent>
   ```

2. 添加H2依赖：SpringBoot会自动配置版本

   ```xml
   <dependency>
     <groupId>org.springframework.boot</groupId>
     <artifactId>spring-boot-starter-data-jpa</artifactId>
   </dependency>
   <dependency>
     <groupId>com.h2database</groupId>
     <artifactId>h2</artifactId>
   </dependency>
   ```

3. 添加配置

   ```yaml
   spring:
     h2:
       console:
         # 启用H2 WEB端控制页面
         enabled: true
         # WEB端控制页面访问链接
         path: /h2
     # SpringBoot 2.5.0 重置了初始化跳转,主要用来指定数据源初始化之后要用什么用户、去执行哪些脚本、遇到错误是否继续等功能。
     sql:
       init:
         # 设置文件编码
         encoding: UTF-8
         # 数据库文件
         schema-locations: classpath:databases/schema/init.sql
         # 数据文件
         data-locations: classpath:databases/data/init.sql
         # 执行初始化脚本的用户名称
         username: root
         # 执行初始化脚本的用户密码
         password: root
         # 多个文件的分隔符
         separator: ;
         # 执行脚本过程中碰到错误是否继续
         continue-on-error: false
     datasource:
       driver-class-name: org.h2.Driver
       url: jdbc:h2:mem:test;MODE=MYSQL;DB_CLOSE_DELAY=-1;DATABASE_TO_UPPER=false
       username: root
       password: root
   ```

4. 添加SQL脚本，启动项目测试H2控制台

   - 添加数据库脚本文件和数据库数据文件

   - 启动项目浏览器访问：http://localhost:8080/h2
   - JDBC URL：jdbc:h2:mem:test
   - 用户名：root
   - 密码：root

# JPA

## 第一部分 数据初始化

- 数据库准备：一对一、一对多、多对多、层级表

  ```sql
  drop table if exists orm_dept;
  create table if not exists orm_dept
  (
      id   varchar(100) primary key comment 'UUID的主键',
      parent_id    varchar(100) comment '上级部门ID',
      code    varchar(50) comment '部门编号',
      name     varchar(100) comment '部门名称',
      level   smallint comment '部门层级',
      gmt_create     varchar(14) comment '字符串格式创建时间',
      gmt_create_time datetime comment '日期格式创建时间',
      gmt_modify     varchar(14) comment '字符串格式创建时间',
      gmt_modify_time datetime comment '日期格式创建时间'
  );
  
  create table orm_emp
  (
      id   bigint auto_increment primary key comment '自增主键',
      dept_no     varchar(100) comment '所在部门',
      username    varchar(100) comment '用户名',
      gmt_create     varchar(14) comment '字符串格式创建时间',
      gmt_create_time datetime comment '日期格式创建时间',
      gmt_modify     varchar(14) comment '字符串格式创建时间',
      gmt_modify_time datetime comment '日期格式创建时间'
  );
  
  create table orm_emp_info
  (
      emp_id bigint primary key comment '员工ID',
      username   varchar(100) comment '用户名',
      phone    varchar(11) comment '手机号',
      password    varchar(100) comment '密码'
  );
  
  create table orm_role
  (
      id   bigint primary key comment '雪花ID',
      code   varchar(20) comment '角色编号',
      name   varchar(20) comment '角色名称'
  );
  create table orm_emp_role
  (
      emp_id  bigint comment '员工ID',
      role_id bigint comment '角色ID'
  );
  
  insert into orm_dept(id, parent_id, code, name, level, gmt_create, gmt_create_time, gmt_modify, gmt_modify_time)
  values ( 'e262fef8e057424b81b6805db4b4ac20','','WEB_SOFT','软件开发部',1,'20211223120000',now(),'20211223120000',now() );
  insert into orm_dept(id, parent_id, code, name, level, gmt_create, gmt_create_time, gmt_modify, gmt_modify_time)
  values ( 'e262fef8e057424b81b6805db4b4ac22','e262fef8e057424b81b6805db4b4ac20','d_java','Java开发部',2,'20211223120000',now(),'20211223120000',now() );
  
  ```
  
- 实体类创建：基本结构

  1. Dept
  
     ```java
     import lombok.Getter;
     import lombok.Setter;
     
     import javax.persistence.*;
     import java.time.LocalDateTime;
     
     public class Dept {
     
         private String id;
         private String parentId;
         private String code;
         private String name;
         private Short level;
         private String gmtCreate;
         private LocalDateTime gmtCreateTime;
         private String gmtModify;
         private LocalDateTime gmtModifyTime;
     
         @Override
         public String toString() {
             return "Dept{" +
                     "id='" + id + '\'' +
                     ", parentId='" + parentId + '\'' +
                     ", code='" + code + '\'' +
                     ", name='" + name + '\'' +
                     ", level=" + level +
                     ", gmtCreate=" + gmtCreate +
                     ", gmtCreateTime=" + gmtCreateTime +
                     ", gmtModify=" + gmtModify +
                     ", gmtModifyTime=" + gmtModifyTime +
                     '}';
         }
     }
     ```

  2. Emp
  
     ```java
     
     ```
  
  3. EmpInfo
  
     ```java
     
     ```
  
  4. Role
  
     ```java
     
     ```
  
  5. EmpRole
  
     ```java
     
     ```

## 第二部分 JPA

### 2.1 依赖

1. 添加JPA相关依赖

   ```xml
   <dependency>
     <groupId>org.springframework.boot</groupId>
     <artifactId>spring-boot-starter-data-jpa</artifactId>
   </dependency>
   <dependency>
     <groupId>com.zaxxer</groupId>
     <artifactId>HikariCP</artifactId>
   </dependency>
   <dependency>
     <groupId>mysql</groupId>
     <artifactId>mysql-connector-java</artifactId>
   </dependency>
   ```

2. 添加工具包

   ```xml
   <!--UTIL-->
   <dependency>
     <groupId>org.projectlombok</groupId>
     <artifactId>lombok</artifactId>
   </dependency>
   <dependency>
     <groupId>cn.hutool</groupId>
     <artifactId>hutool-all</artifactId>
     <version>5.6.2</version>
   </dependency>
   <!--TEST-->
   <dependency>
     <groupId>junit</groupId>
     <artifactId>junit</artifactId>
     <scope>test</scope>
   </dependency>
   <dependency>
     <groupId>org.springframework.boot</groupId>
     <artifactId>spring-boot-starter-test</artifactId>
     <scope>test</scope>
   </dependency>
   ```

### 2.2 JPA入门

1. Dept

   ```java
   @Getter
   @Setter
   @Builder
   @NoArgsConstructor
   @AllArgsConstructor
   @Entity
   @Table(name = "orm_dept")
   public class Dept {
       @Id
       @GenericGenerator(name = "system-uuid", strategy = "uuid")
       @GeneratedValue(generator = "system-uuid")
       @Column(name = "id")
       private String id;
   
       @Column(name = "parent_id",length = 100)
       private String parentId;
   
       @Column(name = "code")
       private String code;
   
       @Column(name = "name")
       private String name;
   
       @Column(name = "level")
       private Short level;
   
       @Column(name = "gmt_create")
       private String gmtCreate;
       @Column(name = "gmt_create_time")
       private LocalDateTime gmtCreateTime;
   
       @Column(name = "gmt_modify")
       private String gmtModify;
       @Column(name = "gmt_modify_time")
       private LocalDateTime gmtModifyTime;
   
       @Override
       public String toString() {
           return "Dept{" +
                   "id='" + id + '\'' +
                   ", parentId='" + parentId + '\'' +
                   ", code='" + code + '\'' +
                   ", name='" + name + '\'' +
                   ", level=" + level +
                   ", gmtCreate=" + gmtCreate +
                   ", gmtCreateTime=" + gmtCreateTime +
                   ", gmtModify=" + gmtModify +
                   ", gmtModifyTime=" + gmtModifyTime +
                   '}';
       }
   }	
   ```

2. DeptRepository

   ```java
   @Repository
   public interface DeptRepository extends JpaRepository<Dept,String> {
   
   }
   ```

3. 测试类

   ```java
   @SpringBootTest
   @RunWith(SpringRunner.class)
   public class SpringbootJap01ApplicationTests {
   
       @Autowired
       private DeptRepository deptRepository;
       @Test
       public void testFindAll() throws Exception {
           List<Dept> all = deptRepository.findAll();
           System.out.println("all = " + all);
       }
   }
   ```

### 2.3 JPA API

1. 新增

   ```java
   // save(S entity)
   // saveAndFlush(S entity);
   // saveAll(Iterable<S> entities);
   // saveAllAndFlush(Iterable<S> entities);
   ```

2. 修改

   ```java
   // 执行save方法, 如果存在主键值则是更新操作
   ```

3. 查找

   ```java
   // 1. 基础查询
   
   ```

4. 删除 

   ```java
   ```

### 2.4 JPA级联

1. 一对一

   ```java
   ```

2. 一对多

   ```java
   ```

3. 多对多

   ```java
   ```

   