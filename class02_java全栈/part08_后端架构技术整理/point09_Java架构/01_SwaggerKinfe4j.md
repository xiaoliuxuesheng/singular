1. 创建SpringBoot项目

   ```xml
   <parent>
     <groupId>org.springframework.boot</groupId>
     <artifactId>spring-boot-starter-parent</artifactId>
     <version>2.7.1</version>
     <relativePath/> <!-- lookup parent from repository -->
   </parent>
   ```

2. 添加knife4j场景启动器

   ```xml
   <dependency>
     <groupId>com.github.xiaoymin</groupId>
     <artifactId>knife4j-spring-boot-starter</artifactId>
     <version>2.0.7</version>
   </dependency>
   ```

3. 添加kinfe4j与SpringBoot2.6+兼容配置

   ```yaml
   spring:
     mvc:
       pathmatch:
         matching-strategy: ant_path_matcher
   ```

4. 定义knife4j配置文件：Java项目可以分多个模块，并且为每个模块指定UI入口

   ```java
   @Configuration
   @EnableSwagger2WebMvc
   public class Knife4jConfiguration {
       @Bean(value = "OrderApi")
       public Docket orderApi() {
           return new Docket(DocumentationType.SWAGGER_2)
                   .apiInfo(new ApiInfoBuilder()
                           //.title("swagger-bootstrap-ui-demo RESTful APIs")
                           .description("Xxx项目订单模块")
                           .termsOfServiceUrl("http://www.xx.com/")
                           .contact("xx@qq.com")
                           .version("1.0")
                           .build())
                   //分组名称
                   .groupName("订单模块")
                   .select()
                   //这里指定Controller扫描包路径
                   .apis(RequestHandlerSelectors.basePackage("com.panda.module.order.controller"))
                   .paths(PathSelectors.any())
                   .build();
       }
   
       @Bean(value = "ManagerApi")
       public Docket managerApi() {
           return new Docket(DocumentationType.SWAGGER_2)
                   .apiInfo(new ApiInfoBuilder()
                           //.title("swagger-bootstrap-ui-demo RESTful APIs")
                           .description("Xxx项目管理员模块")
                           .termsOfServiceUrl("http://www.xx.com/")
                           .contact("xx@qq.com")
                           .version("1.0")
                           .build())
                   //分组名称
                   .groupName("监管模块")
                   .select()
                   //这里指定Controller扫描包路径
                   .apis(RequestHandlerSelectors.basePackage("com.panda.module.manager.controller"))
                   .paths(PathSelectors.any())
                   .build();
       }
   }
   ```

5. 接口文档维护

   ```java
   @Api(tags = "v2.0")
   @RestController
   public class ManagerController {
   
       @ApiOperation(value = "根据姓名查询管理员")
       @ApiImplicitParam(name = "name",value = "姓名",required = true)
       @GetMapping("/manager")
       public ResponseEntity<String> manager(@RequestParam(value = "name")String name){
           return ResponseEntity.ok("Hi:"+name);
       }
   }
   ```

   > 1. @Api：tags名称根据需求的版本号定义，方便区分每个版本新增的功能
   > 2. @ApiOperation：描述当前API的标题
   > 3. @ApiImplicitParam：参数说明

6. 访问Kinfe4j管理页面

   ```http
   http://localhost:8080/doc.html
   ```

7. 整合APIFOX工具

   - 导入URL，每个Docket的Bean都代表一个模块