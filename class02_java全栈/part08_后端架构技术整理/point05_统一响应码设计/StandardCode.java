package com.panda.seckill.standard.common;

import lombok.AllArgsConstructor;
import lombok.Getter;

/**
 * 通用的响应状态吗
 *
 * @author 刘晓东
 * @date 2019-12-14
 */

@Getter
@AllArgsConstructor
public enum StandardCode implements IResponseCode {

    SUCCESS(2002001, "成功"),

    //==================== 4001 表示请求非法异常 ====================
    SERVER_RESOURCE_ERROR(4001001, "请求资源不存在"),

    //==================== 4002 表示用户输入导致的数据异常 ====================
    ACCOUNT_ERROR(4001001, "用户登录账户异常"),
    VALIDATE_CODE_ERROR(4001002, "认证验证码错误"),
    VALIDATE_CODE_EXPIRE(4001003, "认证验证码过期"),
    VALIDATE_CODE_NONENTITY(4001003, "认证验证码过期"),

    //==================== 5001 表示认证异常 ====================
    SERVER_ERROR(5001001, "服务器内部异常"),
    AUTHENTICATION_ERROR(5001002, "请求需要身份认证,请先登录");

    private Integer code;
    private String message;

    public StandardCode format(Object... args) {
        this.message = String.format(this.message, args);
        return this;
    }


    public static StandardCode valueOf(Integer code) {
        for (StandardCode responseCode : values()) {
            if (responseCode.getCode().equals(code)) {
                return responseCode;
            }
        }
        throw new IllegalArgumentException("No matching constant for [" + code + "]");
    }
}
