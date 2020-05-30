# [point01_struts2](/class02_java全栈/part05_java核心框架/point01_struts2/point01_struts2.md)

# [point02_spring](/class02_java全栈/part05_java核心框架/point02_spring/point02_spring.md)

# [point03_hibernate](/class02_java全栈/part05_java核心框架/point03_hibernate/point03_hibernate.md)

# [point04_jpa](/class02_java全栈/part05_java核心框架/point04_jpa/point04_jpa.md)

# [point05_sringmvc](/class02_java全栈/part05_java核心框架/point05_sringmvc/point05_sringmvc.md)

# [point06_springdata](/class02_java全栈/part05_java核心框架/point06_springdata/point06_springdata.md)

# [point07_mybatis](/class02_java全栈/part05_java核心框架/point07_mybatis/point07_mybatis.md)

# [point08_mybatisplus](/class02_java全栈/part05_java核心框架/point08_mybatisplus/point08_mybatisplus.md)

# [point09_shiro](/class02_java全栈/part05_java核心框架/point09_shiro/point09_shiro.md)

# [point10_springsecurity](/class02_java全栈/part05_java核心框架/point10_springsecurity/point10_springsecurity.md)

开发底层规范

01_HTTP响应状态码

1xx:信息

| code | message             | 说明                                                         |
| ---- | ------------------- | ------------------------------------------------------------ |
| 100  | Continue            | 服务器仅接收到部分请求，但是一旦服务器并没有拒绝该请求，客户端应该继续发送其余的请求。 |
| 101  | Switching Protocols | 服务器转换协议：服务器将遵从客户的请求转换到另外一种协议。   |

2xx:成功

| code | message                       | 说明                                                         |
| ---- | ----------------------------- | ------------------------------------------------------------ |
| 200  | OK                            | 请求成功                                                     |
| 201  | Created                       | 请求被创建完成，同时新的资源被创建。                         |
| 202  | Accepted                      | 供处理的请求已被接受，但是处理未完成。                       |
| 203  | Non-authoritative Information | 文档已经正常地返回，但一些应答头可能不正确，因为使用的是文档的拷贝。 |
| 204  | No Content                    | 没有新文档。浏览器应该继续显示原来的文档。如果用户定期地刷新页面，而Servlet可以确定用户文档足够新，这个状态代码是很有用的。 |
| 205  | Reset Content                 | 没有新文档。但浏览器应该重置它所显示的内容。用来强制浏览器清除表单输入内容。 |
| 206  | Partial Content               | 客户发送了一个带有Range头的GET请求，服务器完成了它。         |

3xx:重定向

| code | message            | 说明                                                         |
| ---- | ------------------ | ------------------------------------------------------------ |
| 300  | Continue           | 多重选择。链接列表。用户可以选择某链接到达目的地。最多允许五个地址。 |
| 301  | Moved Permanently  | 所请求的页面已经转移至新的url。                              |
| 302  | Moved Temporarily  | 所请求的页面已经临时转移至新的url。                          |
| 303  | See Other          | 所请求的页面可在别的url下被找到。                            |
| 304  | Not Modified       | 未按预期修改文档。客户端有缓冲的文档并发出了一个条件性的请求（一般是提供If-Modified-Since头表示客户只想比指定日期更新的文档）。服务器告诉客户，原来缓冲的文档还可以继续使用。 |
| 305  | Use Proxy          | 客户请求的文档应该通过Location头所指明的代理服务器提取。     |
| 306  | Unused             | 此代码被用于前一版本。目前已不再使用，但是代码依然被保留。   |
| 307  | Temporary Redirect | 被请求的页面已经临时移至新的url。                            |

4xx:客户端错误

| code | message                         | 说明                                                         |
| ---- | ------------------------------- | ------------------------------------------------------------ |
| 400  | Bad Request                     | 服务器未能理解请求。                                         |
| 401  | Unauthorized                    | 被请求的页面需要用户名和密码。                               |
| 402  | Payment Required                | 此代码尚无法使用。                                           |
| 403  | Forbidden                       | 对被请求页面的访问被禁止。                                   |
| 404  | Not Found                       | 服务器无法找到被请求的页面                                   |
| 405  | Method Not Allowed              | 请求中指定的方法不被允许                                     |
| 406  | Not Acceptable                  | 服务器生成的响应无法被客户端所接受                           |
| 407  | Proxy Authentication Required   | 用户必须首先使用代理服务器进行验证，这样请求才会被处理       |
| 408  | Request Timeout                 | 请求超出了服务器的等待时间                                   |
| 409  | Conflict                        | 由于冲突，请求无法被完成。                                   |
| 410  | Gone                            | 被请求的页面不可用                                           |
| 411  | Length Required                 | "Content-Length" 未被定义。如果无此内容，服务器不会接受请求  |
| 412  | Precondition Failed             | 请求中的前提条件被服务器评估为失败                           |
| 413  | Request Entity Too Large        | 由于所请求的实体的太大，服务器不会接受请求。                 |
| 414  | Request-url Too Long            | 由于url太长，服务器不会接受请求。当post请求被转换为带有很长的查询信息的get请求时，就会发生这种情况 |
| 415  | Unsupported Media Type          | 由于媒介类型不被支持，服务器不会接受请求                     |
| 416  | Requested Range Not Satisfiable | 服务器不能满足客户在请求中指定的Range头                      |
| 417  | Expectation Failed              | 执行失败                                                     |
| 423  |                                 | 锁定的错误                                                   |

5xx:服务器错误

| code | message                    | 说明                                               |
| ---- | -------------------------- | -------------------------------------------------- |
| 500  | Internal Server Error      | 请求未完成。服务器遇到不可预知的情况。             |
| 501  | Not Implemented            | 请求未完成。服务器不支持所请求的功能。             |
| 502  | Bad Gateway                | 请求未完成。服务器从上游服务器收到一个无效的响应。 |
| 503  | Service Unavailable        | 请求未完成。服务器临时过载或当机。                 |
| 504  | Gateway Timeout            | 网关超时。                                         |
| 505  | HTTP Version Not Supported | 服务器不支持请求中指明的HTTP协议版本               |

第一部分 统一的交互风格

1.1 响应码规范

**:anchor: 说明** 

​		HTTP响应状态码是http协议下设计的具有特殊含义的状态码，其主要是用于规定服务端和客户端之间的调用关系，是开发人员才会关注的调用信息，不适合向用户直接展示；需要自定义既可以用于程序开发者使用的响应码，也可以向用户展示请求信息的响应设计；

**:anchor: 设计说明**

1. 制定响应码规范

   ```java
   public interface ResponseCode {
   
       Integer getCode();
   
       String getMessage();
       
       IResponseCode format(Object... args);
   }
   ```

   - 一个响应码只包含两个属性：响应的状态码 + 状态码的描述信息;
   - `format()`方法是对message的扩展，方便对message定制化输出；
   - 定义一个接口用于规定了获取状态码的方法和获取状态码信息；
   - 不同的模块如果需要设计响应码，则自定义实现类实现该接口即可；

2. 对响应码规范的实现案例

   ```java
   @Getter
   @AllArgsConstructor
   public enum DemoCode implements IResponseCode {
   
       SUCCESS(2002000, "成功");
   
       private Integer code;
       private String message;
   
       public DemoCode format(Object... args) {
           this.message = String.format(this.message, args);
           return this;
       }
       
       public static DemoCode valueOf(Integer code) {
           for (DemoCode responseCode : values()) {
               if (DemoCode.getCode().equals(code)) {
                   return responseCode;
               }
           }
           throw new IllegalArgumentException("No matching constant for [" + code + "]");
       }
   }
   ```

   - 采用枚举的方式实现对状态码的规范：代码简介，逻辑清晰；
   - 设计静态方法：`valueOf(Integer code)`根据状态码获取所对应的状态对象；

1.2 响应格式

**:anchor: 说明**

​		架构设计前后端交互的方式统一用json实现，json信息中必须包含三个属性：code表示本次交互的状态吗，message表示状态码的描述信息，body表示具体的传输对象。

**:anchor: 设计说明**

```java
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ResponseResult<T> {
    private Integer code;
    private String message;
    private T body;

    // 没有响应体的成功响应
    public static ResponseResult success() {
        return ResponseResult.builder()
                .code(ResponseCode.SUCCESS.getCode())
                .message(ResponseCode.SUCCESS.getMessage())
                .build();
    }

    // 有响应体的成功响应
    public static <T> ResponseResult success(T body) {
        return ResponseResult.builder()
                .code(ResponseCode.SUCCESS.getCode())
                .message(ResponseCode.SUCCESS.getMessage())
                .body(body).build();
    }

    // 没有响应体的失败响应,但是必须指定失败状态码
    public static ResponseResult failure(ResponseCode code) {
        return ResponseResult.builder()
                .code(code.getCode())
                .message(code.getMessage())
                .build();
    }
	
    // 有响应体,也需要额外指定响应状态码
    public static <T> ResponseResult failure(ResponseCode code, T body) {
        return ResponseResult.builder()
                .code(code.getCode())
                .message(code.getMessage())
                .body(body)
                .build();
    }
}
```

1.3 异常处理

**:anchor: 说明**

​		SpringBoot的默认的异常处理方式：如果访问的请求头有`text/html`出现异常，将返回HTML页面默认；如果是非浏览器访问出现异常 ，返回是JOSN错误信息。

:anchor: 自定义异常处理：处理浏览器访问异常

- 在根目录中定义/resource/error文件夹
- 在文件夹中定义状态码对应名称相同的html页面

:anchor: 自定义异常处理：非浏览器访问异常，并相应为标准的json格式

1. 自定义一个异常类为应用的顶层异常，继承RuntimeException，并添加属性标准响应码，为了规范异常的json格式

   ```java
   @Getter
   public class TopException extends RuntimeException {
   
       private IResponseCode code;
   
       public CoreException(IResponseCode code) {
           super();
           this.code = code;
       }
   }
   ```

2. 应用模块中的如果需要自定义异常，则根据标准需要继承这个顶层异常类

   ```java
   public class DemoException extends CoreException {
   
       public DemoException(IResponseCode code) {
           super(code);
       }
   }
   ```

3. 在应用代码中抛出异常

   ```java
   throw new DemoException(IResponseCode code);
   ```

4. 处理异常：需要在顶级模块中设计异常处理器类，用户捕获这个顶级的异常类并相应到前端为标准json格式

   ```java
   @ControllerAdvice
   public class CoreExceptionHandler {
   
       /**
        * 表示如果Controller中抛出CoreException的异常则响应结果是封装好的标准响应
        *
        * @param e 被捕获的异常信息
        * @return ResponseResult表示标注的响应结果
        */
       @ExceptionHandler(CoreException.class)
       @ResponseBody
       public ResponseResult handlerMyDemoException(Exception e) {
           CoreException ex = (CoreException) e;
           return ResponseResult.failure(ResponseCode.SERVER_ERROR, ex.getCode());
       }
   }
   ```

   - @ControllerAdvice：异常处理器类
   - @ExceptionHandler：表示当前方法是处理哪一种异常
   - @ResponseBody：将相应对象转换为json格式响应到客户端