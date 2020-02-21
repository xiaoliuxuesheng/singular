package com.panda.seckill.standard.exception;

import com.panda.seckill.standard.common.IResponseCode;
import lombok.Getter;

/**
 * 封装了通用的异常处理: 前后端交互的标注格式是json(包括异常的响应)
 * - 其他模块引用了通用配置, 如果需要扩展异常处理的类型,需要继承通用异常类
 *
 * @author panda
 * @date 2019-12-14
 */
@Getter
public class StandardException extends RuntimeException {

    private static final long serialVersionUID = -2036919730566366859L;

    private IResponseCode code;

    public StandardException(IResponseCode code) {
        super();
        this.code = code;
    }
}
