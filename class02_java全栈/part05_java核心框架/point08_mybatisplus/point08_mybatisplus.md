## 2.2 通用CRUD API

| 描述                   | API                                                          |
| ---------------------- | ------------------------------------------------------------ |
| 插入一条记录           | Integer **insert**(T entity);                                |
| 插入一条记录           | Integer **insertAllColumn**(T entity);                       |
| 根据 ID 删除           | Integer **deleteById**(Serializable id);                     |
| 根据 columnMap删除记录 | Integer **deleteByMap**(Map<String, Object> columnMap);      |
| 根据 entity删除记录    | Integer **delete**(Wrapper<T> wrapper);                      |
| 根据ID 批量删除        | Integer **deleteBatchIds**(Collection<? extends Serializable> idList); |
| 根据 ID 修改           | Integer **updateById**(T entity);                            |
| 根据 ID 修改           | Integer **updateAllColumnById**( T entity);                  |
| 根据条件，更新记录     | Integer **update**(T entity,Wrapper<T> wrapper);             |
| 根据 ID 查询           | T **selectById**(Serializable id);                           |
| 根据ID 批量查询        | List<T> **selectBatchIds**(Collection<? extends Serializable> idList); |
| 根据 columnMap 条件    | List<T> **selectByMap**(Map<String, Object> columnMap);      |
| 根据 entity 条件       | T **selectOne**( T entity);                                  |
| 查询根据 Wrapper 条件  | Integer **selectCount**(Wrapper<T> wrapper);                 |
| 查询根据 entity 条件   | List<T> **selectList**(Wrapper<T> wrapper);                  |
| 根据 Wrapper 条件      | List<Map<String, Object>> **selectMaps**(Wrapper<T> wrapper); |
| 查询全部记录并翻页     | List<T> **selectPage**(RowBounds rowBounds, Wrapper<T> wrapper); |
| 查询全部记录并翻页     | List<Map<String, Object>> **selectMapsPage**(RowBounds rowBounds, Wrapper<T> wrapper); |

# 第一章 MP简介

## 1.1 MP介绍

1. 基本作用：是Mybatis的增强包 : 只做增强, 不做改变, 为了简化工作, 提高生产效率
2. MP的优点
   - **无侵入** : 不会影响到MyBatis的运行
   - **依赖少**
   - **损耗小** : 启动注入基本CRUD
   - **多种主键策略** 
   - **内置多种插件**

## 1.2 官方学习文档

1. MybatisPlus官方文档：https://mp.baomidou.com/
2. Mybatis源码开源地址
   - 码云：https://gitee.com/baomidou/mybatis-plus
   - Github：https://github.com/baomidou/mybatis-plus

# 第二章 集成MP

## 2.1 基本坏境准备

1. 数据表

   ```sql
   create database if not exists case_mybatisplus;
   
   use case_mybatisplus;
   
   create table if not exists employee
   (
     `id`             char(50)    not null comment '主键',
     `dept_id`        char(50)    not null comment '部门ID',
     `emp_name`       varchar(50) not null comment '员工名称',
     `password`       varchar(50) not null comment '登录密码',
     `locked`         tinyint  default 0 comment '是否锁定',
     `enabled`        tinyint  default 1 comment '是否可用',
     `login_time`     datetime    null comment '上次登录时间',
     `pwd_reset_time` datetime default current_timestamp comment '最后密码修改时间',
     `gmt_create`     datetime default current_timestamp comment '创建时间',
     `gmt_update`     datetime default current_timestamp on update current_timestamp comment '修改时间',
     primary key (`id`),
     index `idx_emp_name` (emp_name),
     index `idx_pwd_rest` (pwd_reset_time)
   ) comment '员工表';
   
   create table if not exists department
   (
     `id`         char(50)    not null comment '主键',
     `dept_name`  varchar(50) not null comment '部门名称',
     `parent_id`  char(50) comment '上级部门id',
     `level`      int comment '部门等级',
     `enabled`    tinyint  default 1 comment '是否可用',
     `gmt_create` datetime default current_timestamp comment '创建时间',
     `gmt_update` datetime default current_timestamp on update current_timestamp comment '修改时间',
     primary key (id),
     index `idx_parent_id` (parent_id)
   ) comment '部门表';
   ```

2. 添加基本依赖

   ```xml
   <dependency>
       <groupId>org.springframework.boot</groupId>
       <artifactId>spring-boot-starter-web</artifactId>
       <version>2.2.2.RELEASE</version>
   </dependency>
   <dependency>
       <groupId>com.baomidou</groupId>
       <artifactId>mybatis-plus-boot-starter</artifactId>
       <version>3.2.0</version>
   </dependency>
   <dependency>
       <groupId>mysql</groupId>
       <artifactId>mysql-connector-java</artifactId>
       <version>8.0.18</version>
   </dependency>
   <dependency>
       <groupId>com.zaxxer</groupId>
       <artifactId>HikariCP</artifactId>
       <version>3.4.1</version>
   </dependency>
   <dependency>
       <groupId>org.projectlombok</groupId>
       <artifactId>lombok</artifactId>
       <version>1.18.10</version>
   </dependency>
   ```

3. 添加数据源配置文件

   ```yaml
   spring:
     datasource:
       type: com.zaxxer.hikari.HikariDataSource
       driver-class-name: com.mysql.jdbc.Driver
       url: jdbc:mysql://localhost:3306/case_mybatisplus?useUnicode=true&characterEncoding=utf8&serverTimezone=GMT%2B8&useSSL=false
       username: root
       password: root
   
   logging:
     level:
       com.panda.hello.mapper: debug
   ```


## 2.2 集成MP

1. 自定义Mapper接口继承BaseMapper<T> extends Mapper<T> 接口

   ```java
   @Mapper
   @Component
   public interface EmployeeMapper extends BaseMapper<EmployeeDO>{
       
   }
   ```

   

# 第三章 通用CRUD

## 3.1 MP全局配置

## 3.2 MP持久化映射注解

1. @TableName

   |       属性       | 描述                                                         |
   | :--------------: | ------------------------------------------------------------ |
   |      value       | 表名                                                         |
   |      schema      | schema                                                       |
   | keepGlobalPrefix | 是否保持使用全局的 tablePrefix 的值                          |
   |    resultMap     | xml 中 resultMap 的 id                                       |
   |  autoResultMap   | 是否自动构建 resultMap 并使用(如果设置 resultMap 则不会进行 resultMap 的自动构建并注入) |

   > - mp会自动构建一个`ResultMap`并注入到mybatis里
   > - mp只是帮你注入了常用crud到mybatis里 注入之前可以说是动态的(根据你entity的字段以及注解变化而变化),但是注入之后是静态的(等于你写在xml的东西) ，
   > - 对于直接指定`typeHandler`,mybatis只支持你写在2个地方
   >   - 定义在resultMap里,只作用于select查询的返回结果封装
   >   - 定义在`#{property}`里的`property`后面(例:`#{property,typehandler=xxx.xxx.xxx}`)
   
2. @TableId

   | 属性  |  类型  | 必须指定 |   默认值    |    描述    |
   | :---: | :----: | :------: | :---------: | :--------: |
   | value | String |    否    |     ""      | 主键字段名 |
   | type  |  Enum  |    否    | IdType.NONE |  主键类型  |

   - IdType.NONE

     |     值      | 描述                                                         |
     | :---------: | :----------------------------------------------------------- |
     |    AUTO     | 数据库ID自增                                                 |
     |    NONE     | 无状态,该类型为未设置主键类型(注解里等于跟随全局,全局里约等于 INPUT) |
     |    INPUT    | insert前自行set主键值                                        |
     |  ASSIGN_ID  | 分配ID(主键类型为Number(Long和Integer)或String)(since 3.3.0),使用接口`IdentifierGenerator`的方法`nextId`(默认实现类为`DefaultIdentifierGenerator`雪花算法) |
     | ASSIGN_UUID | 分配UUID,主键类型为String(since 3.3.0),使用接口`IdentifierGenerator`的方法`nextUUID`(默认default方法) |

3. @TableField

   |       属性       | 描述                                                         |
   | :--------------: | :----------------------------------------------------------- |
   |      value       | 字段名                                                       |
   |        el        | 映射为原生 `#{ ... }` 逻辑,相当于写在 xml 里的 `#{ ... }`部分 |
   |      exist       | 是否为数据库表字段                                           |
   |    condition     | 字段 `where` 实体查询比较条件,有值设置则按设置的值为准,没有则为默认全局的 `%s=#{%s}`,[参考](https://github.com/baomidou/mybatis-plus/blob/3.0/mybatis-plus-annotation/src/main/java/com/baomidou/mybatisplus/annotation/SqlCondition.java) |
   |      update      | 字段 `update set` 部分注入, 例如：update="%s+1"：表示更新时会set version=version+1(该属性优先级高于 `el` 属性) |
   |  insertStrategy  | 举例：NOT_NULL: `insert into table_a(<if test="columnProperty != null">column</if>) values (<if test="columnProperty != null">#{columnProperty}</if>)` |
   |  updateStrategy  | 举例：IGNORED: `update table_a set column=#{columnProperty}` |
   |  whereStrategy   | 举例：NOT_EMPTY: `where <if test="columnProperty != null and columnProperty!=''">column=#{columnProperty}</if>` |
   |       fill       | 字段自动填充策略                                             |
   |      select      | 是否进行 select 查询                                         |
   | keepGlobalFormat | 是否保持使用全局的 format 进行处理                           |
   |     jdbcType     | JDBC类型 (该默认值不代表会按照该值生效)                      |
   |   typeHandler    | 类型处理器 (该默认值不代表会按照该值生效)                    |
   |   numericScale   | 指定小数点后保留的位数                                       |

4. @Version：乐观锁注解、标记 `@Verison` 在字段上

5. @EnumValue：通枚举类注解(注解在枚举字段上)

6. @TableLogic：表字段逻辑处理注解（逻辑删除）

   |  属性  |  类型  | 必须指定 | 默认值 |     描述     |
   | :----: | :----: | :------: | :----: | :----------: |
   | value  | String |    否    |   ""   | 逻辑未删除值 |
   | delval | String |    否    |   ""   |  逻辑删除值  |

7. @SqlParser：租户注解,支持method上以及mapper接口上

   - true: 表示过滤SQL解析，即不会进入ISqlParser解析链，否则会进解析链并追加例如tenant_id等条件

8. @KeySequence：序列主键策略 `oracle`

   | 属性  |   默认值   |                             描述                             |
   | :---: | :--------: | :----------------------------------------------------------: |
   | value |     ""     |                            序列名                            |
   | clazz | Long.class | id的类型, 可以指定String.class，这样返回的Sequence值是字符串"1" |

## 3.3 MP通用CRUD

### <font size=4 color=blue>ServiceImpl implements IService</font>

1. save

   ```java
   // 插入一条记录（选择字段，策略插入）
   boolean save(T entity);
   // 插入（批量）
   boolean saveBatch(Collection<T> entityList);
   // 插入（批量）
   boolean saveBatch(Collection<T> entityList, int batchSize);
   ```

2. SaveOrUpdate

   ```java
   // TableId 注解存在更新记录，否插入一条记录
   boolean saveOrUpdate(T entity);
   // 根据updateWrapper尝试更新，否继续执行saveOrUpdate(T)方法
   boolean saveOrUpdate(T entity, Wrapper<T> updateWrapper);
   // 批量修改插入
   boolean saveOrUpdateBatch(Collection<T> entityList);
   // 批量修改插入
   boolean saveOrUpdateBatch(Collection<T> entityList, int batchSize);
   ```

3. Remove

   ```java
   // 根据 entity 条件，删除记录
   boolean remove(Wrapper<T> queryWrapper);
   // 根据 ID 删除
   boolean removeById(Serializable id);
   // 根据 columnMap 条件，删除记录
   boolean removeByMap(Map<String, Object> columnMap);
   // 删除（根据ID 批量删除）
   boolean removeByIds(Collection<? extends Serializable> idList);
   ```

4. Update

   ```java
   // 根据 UpdateWrapper 条件，更新记录 需要设置sqlset
   boolean update(Wrapper<T> updateWrapper);
   // 根据 whereEntity 条件，更新记录
   boolean update(T entity, Wrapper<T> updateWrapper);
   // 根据 ID 选择修改
   boolean updateById(T entity);
   // 根据ID 批量更新
   boolean updateBatchById(Collection<T> entityList);
   // 根据ID 批量更新
   boolean updateBatchById(Collection<T> entityList, int batchSize);
   ```

5. Get

   ```java
   // 根据 ID 查询
   T getById(Serializable id);
   // 根据 Wrapper，查询一条记录。结果集，如果是多个会抛出异常，随机取一条加上限制条件 wrapper.last("LIMIT 1")
   T getOne(Wrapper<T> queryWrapper);
   // 根据 Wrapper，查询一条记录
   T getOne(Wrapper<T> queryWrapper, boolean throwEx);
   // 根据 Wrapper，查询一条记录
   Map<String, Object> getMap(Wrapper<T> queryWrapper);
   // 根据 Wrapper，查询一条记录
   <V> V getObj(Wrapper<T> queryWrapper, Function<? super Object, V> mapper);
   ```

6. List

   ```java
   // 查询所有
   List<T> list();
   // 查询列表
   List<T> list(Wrapper<T> queryWrapper);
   // 查询（根据ID 批量查询）
   Collection<T> listByIds(Collection<? extends Serializable> idList);
   // 查询（根据 columnMap 条件）
   Collection<T> listByMap(Map<String, Object> columnMap);
   // 查询所有列表
   List<Map<String, Object>> listMaps();
   // 查询列表
   List<Map<String, Object>> listMaps(Wrapper<T> queryWrapper);
   // 查询全部记录
   List<Object> listObjs();
   // 查询全部记录
   <V> List<V> listObjs(Function<? super Object, V> mapper);
   // 根据 Wrapper 条件，查询全部记录
   List<Object> listObjs(Wrapper<T> queryWrapper);
   // 根据 Wrapper 条件，查询全部记录
   <V> List<V> listObjs(Wrapper<T> queryWrapper, Function<? super Object, V> mapper);
   # 参数说明
   ```

7. Page

   ```java
   // 无条件翻页查询
   IPage<T> page(IPage<T> page);
   // 翻页查询
   IPage<T> page(IPage<T> page, Wrapper<T> queryWrapper);
   // 无条件翻页查询
   IPage<Map<String, Object>> pageMaps(IPage<T> page);
   // 翻页查询
   IPage<Map<String, Object>> pageMaps(IPage<T> page, Wrapper<T> queryWrapper);
   ```

8. Count

   ```java
   // 查询总记录数
   int count();
   // 根据 Wrapper 条件，查询总记录数
   int count(Wrapper<T> queryWrapper);
   ```

9. Chain

   ```java
   // 链式查询 普通
   QueryChainWrapper<T> query();
   // 链式查询 lambda 式。注意：不支持 Kotlin
   LambdaQueryChainWrapper<T> lambdaQuery(); 
   
   // 链式更改 普通
   UpdateChainWrapper<T> update();
   // 链式更改 lambda 式。注意：不支持 Kotlin 
   LambdaUpdateChainWrapper<T> lambdaUpdate();
   ```

### <font size=4 color=blue>BaseMapper</font>

1. Insert

   ```java
   // 插入一条记录
   int insert(T entity);
   ```

2. Delete

   ```java
   // 根据 entity 条件，删除记录
   int delete(@Param(Constants.WRAPPER) Wrapper<T> wrapper);
   // 删除（根据ID 批量删除）
   int deleteBatchIds(@Param(Constants.COLLECTION) Collection<? extends Serializable> idList);
   // 根据 ID 删除
   int deleteById(Serializable id);
   // 根据 columnMap 条件，删除记录
   int deleteByMap(@Param(Constants.COLUMN_MAP) Map<String, Object> columnMap);
   ```

3. Update

   ```java
   // 根据 whereEntity 条件，更新记录
   int update(@Param(Constants.ENTITY) T entity, @Param(Constants.WRAPPER) Wrapper<T> updateWrapper);
   // 根据 ID 修改
   int updateById(@Param(Constants.ENTITY) T entity);
   ```

4. Select

   ```java
   // 根据 ID 查询
   T selectById(Serializable id);
   // 根据 entity 条件，查询一条记录
   T selectOne(@Param(Constants.WRAPPER) Wrapper<T> queryWrapper);
   
   // 查询（根据ID 批量查询）
   List<T> selectBatchIds(@Param(Constants.COLLECTION) Collection<? extends Serializable> idList);
   // 根据 entity 条件，查询全部记录
   List<T> selectList(@Param(Constants.WRAPPER) Wrapper<T> queryWrapper);
   // 查询（根据 columnMap 条件）
   List<T> selectByMap(@Param(Constants.COLUMN_MAP) Map<String, Object> columnMap);
   // 根据 Wrapper 条件，查询全部记录
   List<Map<String, Object>> selectMaps(@Param(Constants.WRAPPER) Wrapper<T> queryWrapper);
   // 根据 Wrapper 条件，查询全部记录。注意： 只返回第一个字段的值
   List<Object> selectObjs(@Param(Constants.WRAPPER) Wrapper<T> queryWrapper);
   
   // 根据 entity 条件，查询全部记录（并翻页）
   IPage<T> selectPage(IPage<T> page, @Param(Constants.WRAPPER) Wrapper<T> queryWrapper);
   // 根据 Wrapper 条件，查询全部记录（并翻页）
   IPage<Map<String, Object>> selectMapsPage(IPage<T> page, @Param(Constants.WRAPPER) Wrapper<T> queryWrapper);
   // 根据 Wrapper 条件，查询总记录数
   Integer selectCount(@Param(Constants.WRAPPER) Wrapper<T> queryWrapper);
   ```

# 第四章 条件构造器

## 4.1 使用建议

- **不支持以及不赞成在 RPC 调用中把 Wrapper 进行传输**
  1. wrapper 很重
  2. 传输 wrapper 可以类比为你的 controller 用 map 接收值(开发一时爽,维护火葬场)
  3. 正确的 RPC 调用姿势是写一个 DTO 进行传输,被调用方再根据 DTO 执行相应的操作
  4. 我们拒绝接受任何关于 RPC 传输 Wrapper 报错相关的 issue 甚至 pr

## 4.2 AbstractWrapper

| 条件        | 说明 |
| ----------- | ---- |
| allEq       |      |
| eq          |      |
| ne          |      |
| gt          |      |
| ge          |      |
| lt          |      |
| le          |      |
| between     |      |
| notBetween  |      |
| like        |      |
| notLike     |      |
| likeLeft    |      |
| likeRight   |      |
| isNull      |      |
| isNotNull   |      |
| in          |      |
| notIn       |      |
| inSql       |      |
| notInSql    |      |
| groupBy     |      |
| orderByAsc  |      |
| orderByDesc |      |
| orderBy     |      |
| having      |      |
| or          |      |
| and         |      |
| nested      |      |
| apply       |      |
| last        |      |
| exists      |      |
| notExists   |      |

## 4.3 QueryWrapper

| 条件   | 说明 |
| ------ | ---- |
| select |      |

## 4.4 UpdateWrapper

| 条件   | 说明 |
| ------ | ---- |
| set    |      |
| setSql |      |
| lambda |      |



# 第五章 ActiveRecord

# 第六章 代码生成器

## 6.1 代码生成器简介

​		MP的代码生成插件中定义了大量的自定义设置，生成的代码功能比较全面。

​		表及字段命名策略：在MP中建议是数据中的表名和字段名也采用驼峰命名方式，如果采用下划线命名，需要开启全局下划线开关。数据库采用驼峰是因为在对应实体类和属性时就可以直接映射，稍微减少性能损耗；

​		MP的代码生成是基于Java代码，而且功能远远大于MBG,可以生成实体类、mapper接口、service层、controller层；MBG是需要一个XML配置文件才可以生成；

## 6.2 代码生成器环境准备

1. 添加代码生成JAR依赖

   ```xml
   <dependency>
       <groupId>com.baomidou</groupId>
       <artifactId>mybatis-plus-generator</artifactId>
       <version>3.1.1</version>
   </dependency>
   ```

2. Java代码

   ```java
   import com.baomidou.mybatisplus.annotation.IdType;
   import com.baomidou.mybatisplus.generator.AutoGenerator;
   import com.baomidou.mybatisplus.generator.config.DataSourceConfig;
   import com.baomidou.mybatisplus.generator.config.GlobalConfig;
   import com.baomidou.mybatisplus.generator.config.PackageConfig;
   import com.baomidou.mybatisplus.generator.config.StrategyConfig;
   import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
   
   public class MybatisPlusGeneratorConfig2 {
       public static void main(String[] args) {
           // 1. 全局配置
           GlobalConfig config = new GlobalConfig();
           config.setAuthor("刘晓东")
                   .setOpen(false)
                   .setActiveRecord(true)
                   .setFileOverride(true)
                   .setIdType(IdType.ID_WORKER)
                   .setBaseResultMap(true)
                   .setBaseColumnList(true)
                   .setServiceName("%sService")
                   .setXmlName("%sMapper")
                   .setOutputDir("E:/panda-study-framework/commons-template/src/main/java");
   
           // 2. 数据源配置
           DataSourceConfig dataSourceConfig = new DataSourceConfig();
           dataSourceConfig.setUrl("jdbc:mysql://localhost:3306/case_mybatisplus?useUnicode=true&useSSL=false&characterEncoding=utf8&serverTimezone=UTC")
                   .setDriverName("com.mysql.jdbc.Driver")
                   .setUsername("root")
                   .setPassword("root");
   
           // 3. 策略配置
           StrategyConfig strategyConfig = new StrategyConfig();
           strategyConfig.setCapitalMode(true)
                   .setEntityLombokModel(true)
                   .setSkipView(true)
                   .setNaming(NamingStrategy.underline_to_camel)
                   .setColumnNaming(NamingStrategy.underline_to_camel)
                   .setInclude("employee", "department");
   
           // 2. 包配置
           PackageConfig packageConfig = new PackageConfig();
           packageConfig.setParent("com.panda.mp")
                   .setModuleName("generator")
                   .setEntity("model.domain")
                   .setMapper("mapper")
                   .setService("service")
                   .setServiceImpl("service.impl")
                   .setController("web.controller")
                   .setXml("mapper");
   
           AutoGenerator generator = new AutoGenerator();
           generator.setGlobalConfig(config)
                   .setDataSource(dataSourceConfig)
                   .setPackageInfo(packageConfig)
                   .setStrategy(strategyConfig);
           generator.execute();
       }
   }
   ```

   

# 第七章 插件扩展

# 第八章 自定义全局操作

# 第九章 公共字段填充

# 第十章 Oracle

