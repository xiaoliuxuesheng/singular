package com.panda.seckill.standard.common;

import lombok.*;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class ResponseResult<T> {
    private Integer code;
    private String message;
    private T body;

    public ResponseResult(Integer code, String message) {
        this.code = code;
        this.message = message;
    }

    public static <T> ResponseResult<T> success() {
        return new Result().success();
    }

    public static <T> ResponseResult<T> success(T body) {
        return new Result().success(body);
    }

    public static <T> ResponseResult<T> failure(IResponseCode code) {
        return new Result().failure(code);
    }

    public static <T> ResponseResult<T> failure(IResponseCode code, T body) {
        return new Result().failure(code, body);
    }

    private static class Result {
        public <T> ResponseResult<T> success() {
            return new ResponseResult<>(StandardCode.SUCCESS.getCode(), StandardCode.SUCCESS.getMessage());
        }

        public <T> ResponseResult<T> success(T body) {
            return new ResponseResult<>(StandardCode.SUCCESS.getCode(), StandardCode.SUCCESS.getMessage(), body);
        }

        public <T> ResponseResult<T> failure(IResponseCode code) {
            return new ResponseResult<>(code.getCode(), code.getMessage());
        }

        public <T> ResponseResult<T> failure(IResponseCode code, T body) {
            return new ResponseResult<>(code.getCode(), code.getMessage(), body);
        }
    }
}
