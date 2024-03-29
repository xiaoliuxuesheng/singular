- File | Settings | Other Settings | Easy Code | Type Mapper

  | 列类型                    | 属性类型                |
  | ------------------------- | ----------------------- |
  | char(\(\d+\))?            | java.lang.String        |
  | varchar(\(\d+\))?         | java.lang.String        |
  | text                      | java.lang.String        |
  | decimal(\(\d+\))?         | java.lang.Long          |
  | decimal(\(\d+,\d+\))?     | java.math.BigDecimal    |
  | integer                   | java.lang.Integer       |
  | int(\(\d+\))?             | java.lang.Integer       |
  | bigint(\(\d+\))?          | java.lang.Long          |
  | bigint(\(\d+\))? unsigned | java.lang.Long          |
  | date                      | java.time.LocalDate     |
  | datetime                  | java.time.LocalDateTime |
  | timestamp                 | java.time.LocalDateTime |
  | boolean                   | java.lang.Boolean       |
  | tinyint(\(\d+\))?         | java.lang.Integer       |

- File | Settings | Other Settings | Easy Code | Template Setting

  - entity.java

    ```java
    ##引入宏定义
    $!define
    
    ##使用宏定义设置回调（保存位置与文件后缀）
    #save("/model/po", "PO.java")
    
    ##使用宏定义设置包后缀
    #setPackageSuffix("model.po")
    
    ##使用全局变量实现默认包导入
    $!autoImport
    import java.io.Serializable;
    import lombok.Getter;
    import lombok.Setter;
    
    ##使用宏定义实现类注释信息
    #tableComment("实体类")
    
    
    @Setter
    @Getter
    public class $!{tableInfo.name}PO implements Serializable {
        private static final long serialVersionUID = $!tool.serial();
    #foreach($column in $tableInfo.fullColumn)
        #if(${column.comment})/**
        * ${column.comment}
        */#end
    
        private $!{tool.getClsNameByFullName($column.type)} $!{column.name};
    #end
    }
    ```

  - dao.java

    ```java
    ##定义初始变量
    #set($tableName = $tool.append($tableInfo.name, "Mapper"))
    ##设置回调
    $!callback.setFileName($tool.append($tableName, ".java"))
    $!callback.setSavePath($tool.append($tableInfo.savePath, "/mapper"))
    
    ##拿到主键
    #if(!$tableInfo.pkColumn.isEmpty())
        #set($pk = $tableInfo.pkColumn.get(0))
    #end
    
    #if($tableInfo.savePackageName)package $!{tableInfo.savePackageName}.#{end}mapper;
    
    import $!{tableInfo.savePackageName}.model.po.$!{tableInfo.name}PO;
    
    import org.apache.ibatis.annotations.Mapper;
    import org.springframework.stereotype.Component;
    import org.apache.ibatis.annotations.Param;
    import java.util.List;
    
    /**
     * $!{tableInfo.comment}($!{tableInfo.name}PO)表数据库访问层
     *
     * @author $!author
     * @since $!time.currTime()
     */
    @Mapper
    @Component
    public interface $!{tableName} {
    
        /**
         * 通过ID查询单条数据
         *
         * @param $!pk.name 主键
         * @return 实例对象
         */
        $!{tableInfo.name}PO queryById($!pk.shortType $!pk.name);
    
        /**
         * 查询指定行数据
         *
         * @param offset 查询起始位置
         * @param limit 查询条数
         * @return 对象列表
         */
        List<$!{tableInfo.name}PO> queryAllByLimit(@Param("offset") int offset, @Param("limit") int limit);
    
    
        /**
         * 通过实体作为筛选条件查询
         *
         * @param $!tool.firstLowerCase($!{tableInfo.name}) 实例对象
         * @return 对象列表
         */
        List<$!{tableInfo.name}PO> queryAll($!{tableInfo.name}PO $!tool.firstLowerCase($!{tableInfo.name}));
    
        /**
         * 新增数据
         *
         * @param $!tool.firstLowerCase($!{tableInfo.name}) 实例对象
         * @return 影响行数
         */
        int insert($!{tableInfo.name}PO $!tool.firstLowerCase($!{tableInfo.name}));
    
        /**
         * 修改数据
         *
         * @param $!tool.firstLowerCase($!{tableInfo.name}) 实例对象
         * @return 影响行数
         */
        int update($!{tableInfo.name}PO $!tool.firstLowerCase($!{tableInfo.name}));
  }
    ```

  - service.java

    ```java
    ##定义初始变量
    #set($tableName = $tool.append($tableInfo.name, "Service"))
    ##设置回调
    $!callback.setFileName($tool.append($tableName, ".java"))
    $!callback.setSavePath($tool.append($tableInfo.savePath, "/service"))
    
    ##拿到主键
    #if(!$tableInfo.pkColumn.isEmpty())
        #set($pk = $tableInfo.pkColumn.get(0))
    #end
    
    #if($tableInfo.savePackageName)package $!{tableInfo.savePackageName}.#{end}service;
    
    import $!{tableInfo.savePackageName}.model.po.$!{tableInfo.name}PO;
    import java.util.List;
    
    /**
     * $!{tableInfo.comment}($!{tableInfo.name}PO)表服务接口
     *
     * @author $!author
     * @since $!time.currTime()
     */
    public interface $!{tableName} {
    
        /**
         * 通过ID查询单条数据
         *
         * @param $!pk.name 主键
         * @return 实例对象
         */
        $!{tableInfo.name}PO queryById($!pk.shortType $!pk.name);
    
        /**
         * 查询多条数据
         *
         * @param offset 查询起始位置
         * @param limit 查询条数
         * @return 对象列表
         */
        List<$!{tableInfo.name}PO> queryAllByLimit(int offset, int limit);
    
        /**
         * 新增数据
         *
         * @param $!tool.firstLowerCase($!{tableInfo.name}) 实例对象
         * @return 实例对象
         */
        $!{tableInfo.name}PO insert($!{tableInfo.name}PO $!tool.firstLowerCase($!{tableInfo.name}));
    
        /**
         * 修改数据
         *
         * @param $!tool.firstLowerCase($!{tableInfo.name}) 实例对象
         * @return 实例对象
         */
        $!{tableInfo.name}PO update($!{tableInfo.name}PO $!tool.firstLowerCase($!{tableInfo.name}));
  }
    ```

  - serviceImpl.java

    ```java
    ##定义初始变量
    #set($tableName = $tool.append($tableInfo.name, "ServiceImpl"))
    ##设置回调
    $!callback.setFileName($tool.append($tableName, ".java"))
    $!callback.setSavePath($tool.append($tableInfo.savePath, "/service/impl"))
    
    ##拿到主键
    #if(!$tableInfo.pkColumn.isEmpty())
        #set($pk = $tableInfo.pkColumn.get(0))
    #end
    
    #if($tableInfo.savePackageName)package $!{tableInfo.savePackageName}.#{end}service.impl;
    
    import $!{tableInfo.savePackageName}.model.po.$!{tableInfo.name}PO;
    import $!{tableInfo.savePackageName}.mapper.$!{tableInfo.name}Mapper;
    import $!{tableInfo.savePackageName}.service.$!{tableInfo.name}Service;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.stereotype.Service;
    import java.util.List;
    
    /**
     * $!{tableInfo.comment}($!{tableInfo.name})表服务实现类
     *
     * @author $!author
     * @since $!time.currTime()
     */
    @Service
    public class $!{tableName} implements $!{tableInfo.name}Service {
        @Autowired
        private $!{tableInfo.name}Mapper $!tool.firstLowerCase($!{tableInfo.name})Mapper;
    
        /**
         * 通过ID查询单条数据
         *
         * @param $!pk.name 主键
         * @return 实例对象
         */
        @Override
        public $!{tableInfo.name}PO queryById($!pk.shortType $!pk.name) {
            return this.$!{tool.firstLowerCase($!{tableInfo.name})}Mapper.queryById($!pk.name);
        }
    
        /**
         * 查询多条数据
         *
         * @param offset 查询起始位置
         * @param limit 查询条数
         * @return 对象列表
         */
        @Override
        public List<$!{tableInfo.name}PO> queryAllByLimit(int offset, int limit) {
            return this.$!{tool.firstLowerCase($!{tableInfo.name})}Mapper.queryAllByLimit(offset, limit);
        }
    
        /**
         * 新增数据
         *
         * @param $!tool.firstLowerCase($!{tableInfo.name}) 实例对象
         * @return 实例对象
         */
        @Override
        public $!{tableInfo.name}PO insert($!{tableInfo.name}PO $!tool.firstLowerCase($!{tableInfo.name})) {
            this.$!{tool.firstLowerCase($!{tableInfo.name})}Mapper.insert($!tool.firstLowerCase($!{tableInfo.name}));
            return $!tool.firstLowerCase($!{tableInfo.name});
        }
    
        /**
         * 修改数据
         *
         * @param $!tool.firstLowerCase($!{tableInfo.name}) 实例对象
         * @return 实例对象
         */
        @Override
        public $!{tableInfo.name}PO update($!{tableInfo.name}PO $!tool.firstLowerCase($!{tableInfo.name})) {
            this.$!{tool.firstLowerCase($!{tableInfo.name})}Mapper.update($!tool.firstLowerCase($!{tableInfo.name}));
            return this.queryById($!{tool.firstLowerCase($!{tableInfo.name})}.get$!tool.firstUpperCase($pk.name)());
        }
  }
    ```

  - controller.java

    ```java
    ##定义初始变量
    #set($tableName = $tool.append($tableInfo.name, "ServiceImpl"))
    ##设置回调
    $!callback.setFileName($tool.append($tableName, ".java"))
    $!callback.setSavePath($tool.append($tableInfo.savePath, "/service/impl"))
    
    ##拿到主键
    #if(!$tableInfo.pkColumn.isEmpty())
        #set($pk = $tableInfo.pkColumn.get(0))
    #end
    
    #if($tableInfo.savePackageName)package $!{tableInfo.savePackageName}.#{end}service.impl;
    
    import $!{tableInfo.savePackageName}.model.po.$!{tableInfo.name}PO;
    import $!{tableInfo.savePackageName}.mapper.$!{tableInfo.name}Mapper;
    import $!{tableInfo.savePackageName}.service.$!{tableInfo.name}Service;
    import org.springframework.beans.factory.annotation.Autowired;
    import org.springframework.stereotype.Service;
    import java.util.List;
    
    /**
     * $!{tableInfo.comment}($!{tableInfo.name})表服务实现类
     *
     * @author $!author
     * @since $!time.currTime()
     */
    @Service
    public class $!{tableName} implements $!{tableInfo.name}Service {
        @Autowired
        private $!{tableInfo.name}Mapper $!tool.firstLowerCase($!{tableInfo.name})Mapper;
    
        /**
         * 通过ID查询单条数据
         *
         * @param $!pk.name 主键
         * @return 实例对象
         */
        @Override
        public $!{tableInfo.name}PO queryById($!pk.shortType $!pk.name) {
            return this.$!{tool.firstLowerCase($!{tableInfo.name})}Mapper.queryById($!pk.name);
        }
    
      /**
         * 查询多条数据
         *
       * @param offset 查询起始位置
         * @param limit 查询条数
         * @return 对象列表
         */
        @Override
        public List<$!{tableInfo.name}PO> queryAllByLimit(int offset, int limit) {
            return this.$!{tool.firstLowerCase($!{tableInfo.name})}Mapper.queryAllByLimit(offset, limit);
        }
    
        /**
         * 新增数据
         *
         * @param $!tool.firstLowerCase($!{tableInfo.name}) 实例对象
         * @return 实例对象
         */
        @Override
        public $!{tableInfo.name}PO insert($!{tableInfo.name}PO $!tool.firstLowerCase($!{tableInfo.name})) {
            this.$!{tool.firstLowerCase($!{tableInfo.name})}Mapper.insert($!tool.firstLowerCase($!{tableInfo.name}));
            return $!tool.firstLowerCase($!{tableInfo.name});
        }
    
        /**
         * 修改数据
         *
         * @param $!tool.firstLowerCase($!{tableInfo.name}) 实例对象
         * @return 实例对象
         */
        @Override
        public $!{tableInfo.name}PO update($!{tableInfo.name}PO $!tool.firstLowerCase($!{tableInfo.name})) {
            this.$!{tool.firstLowerCase($!{tableInfo.name})}Mapper.update($!tool.firstLowerCase($!{tableInfo.name}));
            return this.queryById($!{tool.firstLowerCase($!{tableInfo.name})}.get$!tool.firstUpperCase($pk.name)());
        }
    }
    ```
    
  - mapper.xml

    ```xml
    ##引入mybatis支持
    $!mybatisSupport
    
    ##设置保存名称与保存位置
    $!callback.setFileName($tool.append($!{tableInfo.name}, "Mapper.xml"))
    $!callback.setSavePath($tool.append($modulePath, "/src/main/resources/mapper"))
    
    ##拿到主键
    #if(!$tableInfo.pkColumn.isEmpty())
    #set($pk = $tableInfo.pkColumn.get(0))
    #end
    
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd">
    <mapper namespace="$!{tableInfo.savePackageName}.mapper.$!{tableInfo.name}Mapper">
    
        <resultMap id="$!{tableInfo.name}Map" type="$!{tableInfo.savePackageName}.model.po.$!{tableInfo.name}PO">
            #foreach($column in $tableInfo.fullColumn)
            <result property="$!column.name" column="$!column.obj.name" jdbcType="$!column.ext.jdbcType"/>
            #end
        </resultMap>
    
        <!--查询单个-->
        <select id="queryById" resultMap="$!{tableInfo.name}Map">
            select
            #allSqlColumn()
    
            from $!{tableInfo.obj.parent.name}.$!tableInfo.obj.name
            where $!pk.obj.name = #{$!pk.name}
        </select>
    
        <!--查询指定行数据-->
        <select id="queryAllByLimit" resultMap="$!{tableInfo.name}Map">
            select
            #allSqlColumn()
    
            from $!{tableInfo.obj.parent.name}.$!tableInfo.obj.name
            limit #{offset}, #{limit}
        </select>
    
        <!--通过实体作为筛选条件查询-->
        <select id="queryAll" resultMap="$!{tableInfo.name}Map">
            select
            #allSqlColumn()
    
            from $!{tableInfo.obj.parent.name}.$!tableInfo.obj.name
            <where>
                #foreach($column in $tableInfo.fullColumn)
                <if test="$!column.name != null#if($column.type.equals("java.lang.String")) and $!column.name != ''#end">
                    and $!column.obj.name = #{$!column.name}
                </if>
                #end
            </where>
        </select>
    
        <!--新增所有列-->
        <insert id="insert" keyProperty="$!pk.name" useGeneratedKeys="true">
            insert into $!{tableInfo.obj.parent.name}.$!{tableInfo.obj.name}(#foreach($column in $tableInfo.otherColumn)$!column.obj.name#if($velocityHasNext), #end#end)
            values (#foreach($column in $tableInfo.otherColumn)#{$!{column.name}}#if($velocityHasNext), #end#end)
        </insert>
    
        <!--通过主键修改数据-->
        <update id="update">
            update $!{tableInfo.obj.parent.name}.$!{tableInfo.obj.name}
            <set>
                #foreach($column in $tableInfo.otherColumn)
                <if test="$!column.name != null#if($column.type.equals("java.lang.String")) and $!column.name != ''#end">
                    $!column.obj.name = #{$!column.name},
                </if>
                #end
            </set>
            where $!pk.obj.name = #{$!pk.name}
        </update>
    
    </mapper>
    ```

    地品
    		1、Background Image Plus 换壁纸

    ​		2、Chinese(Simplified)... 中文语言包

    ​		3、Translation	代码翻译

    ​		4、Key Promoter X 快捷键提示插件

    ​		5、Rainbow bracket 彩虹括号插件

    ​		6、Code Glance 代码小地图

    ​		7、Walk Time / Statistic 代码统计插件
    天品
    ​		1、String Manipulation 字符串处理插件

    ​		2、Tabnine AI Code Completion... 代码补全

    ​		3、GsonFormatPlus json代码生成

    ​		3、JUnitGenerator V2.0  代码生成

    ​		4、Sequence Giagram 生成代码时序图

    ​		5、RestfulTool Restful服务开发工具集

    ​		6、代码检查

    ​			CheckStyle-IDEA、Alibaba JAVA CodingGuidelines、SonarLint

    ​		7、MyBatis X

    # Mac

    1. 开启触控板所有功能
       - 打开偏好设置中的所有选项
       - 辅助功能-指针控制-触控板选项-启用拖移-三指拖移
    2. 仿达编号设置
       - 仿达偏好设置

    