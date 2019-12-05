# 说明



# :one: 添加依赖

```xml
<dependency>
    <groupId>com.github.macdao</groupId>
    <artifactId>moscow</artifactId>
    <version>0.3.0</version>
</dependency>
<dependency>
    <groupId>com.squareup.okhttp3</groupId>
    <artifactId>okhttp</artifactId>
</dependency>
```

# :two: 在项目目录中定义json文件

> 文件路径: `spring-base-contracts/sub-project-01/employee/employee-controller.json`

```json
[
  {
    "description": "should_delete_product_by_id",
    "request": {
      "method": "DELETE",
      "uri": "/product/product_id-6"
    },
    "response": {
      "status": 200,
      "json": {
        "msg": "这是个消息",
        "code": "HTTP_VERSION_NOT_SUPPORTED"
      }
    }
  }
]
```

3. 定义Springboot测试类

    ```java
    @RunWith(SpringRunner.class)
    @SpringBootTest(classes = SpringbootBaseApplication.class, webEnvironment = SpringBootTest.WebEnvironment.RANDOM_PORT)
    public class EmployeeControllerTest {
    }
    ```

4. 定义契约容器

    ```java
    private static final ContractContainer contractContainer = new ContractContainer(Paths.get("spring-base-contracts/sub-project-01"));
    ```

5. 常用常量

    ```java
    @Rule
    public TestName name = new TestName();
    
    
    @LocalServerPort
    private int port;
    ```

6. 测试方法

    ```java
        @Test
        public void should_delete_product_by_id() throws Exception {
            System.out.println("name = " + name.getMethodName());
            new ContractAssertion(contractContainer.findContracts(name.getMethodName()))
                    .setPort(port)
                    .assertContract();
        }
    ```

7. 需要测试 接口

    ```java
    @DeleteMapping(value = "/product/{id}")
    public ResponseEntity deleteProduct(@PathVariable("id") String id) {
        System.out.println("id = " + id);
        Map<String, Object> map = new HashMap<>();
        map.put("code", HttpStatus.HTTP_VERSION_NOT_SUPPORTED);
        map.put("msg", "这是个消息");
        return ResponseEntity.ok(map);
    }
    ```

    