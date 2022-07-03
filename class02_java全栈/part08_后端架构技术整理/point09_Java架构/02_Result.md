1. 封装统一响应码接口

   ```java
   public interface ResultCode {
       Integer SUCCESS_CODE = 2002000;
       String SUCCESS_MSG = "SUCCESS";
   
       /**
        * 2002000*: 成功
        * 400*: 请求错误
        * 500*: 服务内部错误
        *
        * @return 响应编码
        */
       Integer getCode();
   
       /**
        * 用于前端的错误提示
        *
        * @return 响应描述
        */
       String getMsg();
   
       /**
        * 记录日志的字符串模板
        *
        * @return 用于记录日志使用的模板
        */
       String getLogFmt();
   }
   ```

2. 定义统一响应实体类

   ```java
   @Getter
   @Setter
   @ToString
   @ApiModel(value = "统一响应实体")
   public class Result<T> {
   
       @ApiModelProperty(value = "响应编码", required = true)
       private Integer code;
       @ApiModelProperty(value = "响应消息", required = true)
       private String msg;
       @ApiModelProperty(value = "响应数据")
       private T data;
   
       // ============= 私有化构造方法 =============
       private Result() {
           this.code = ResultCode.SUCCESS_CODE;
           this.msg = ResultCode.SUCCESS_MSG;
       }
   
       private Result(T data) {
           this.code = ResultCode.SUCCESS_CODE;
           this.msg = ResultCode.SUCCESS_MSG;
           this.data = data;
       }
   
       private Result(Integer code, String msg) {
           this.code = code;
           this.msg = msg;
       }
   
       private Result(Integer code, String msg, T data) {
           this.code = code;
           this.msg = msg;
           this.data = data;
       }
       // ============= 静态方法 =============
   
       public static Result<Void> of() {
           return new Result<>();
       }
   
       public static <T> Result<T> of(T data) {
           return new Result<T>(data);
       }
   
       public static Result<Void> of(ResultCode code) {
           return new Result<>(code.getCode(), code.getMsg());
       }
   
       public static <T> Result<T> of(ResultCode code, T data) {
           return new Result<T>(code.getCode(), code.getMsg(), data);
       }
   }
   ```

3. 各模块封装自己的错误码

   ```java
   @Getter
   @AllArgsConstructor
   public enum ResultCodeOrder implements ResultCode {
   
       PARAM_ERROR(4004001,"请求参数错误","param:{} error")
       ;
       private final Integer code;
       private final String msg;
       private final String logFmt;
   }
   ```

4. 在接口中使用自定义的错误码

   ```java
   @ApiImplicitParam(name = "name",value = "名称",required = true)
   @ApiOperation(value = "新增订单")
   @PostMapping("/order/add")
   public Result<String> orderAdd(@RequestParam(value = "name")String name){
     log.error(ResultCodeOrder.PARAM_ERROR.getLogFmt(), name);
     return Result.of(ResultCodeOrder.PARAM_ERROR, name);
   }
   ```

   