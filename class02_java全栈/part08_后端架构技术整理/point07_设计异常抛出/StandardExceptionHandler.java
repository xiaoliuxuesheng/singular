package com.panda.seckill.standard.exception;

import com.panda.seckill.standard.common.IResponseCode;
import com.panda.seckill.standard.common.ResponseResult;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 通用的异常处理类: 用于捕获Controller中抛出的异常
 *
 * @author 刘晓东
 * @date
 */
@ControllerAdvice
public class StandardExceptionHandler {

    /**
     * 表示如果Controller中抛出CoreException的异常则响应结果是封装好的标准响应
     *
     * @param e 被捕获的异常信息
     * @return ResponseResult表示标注的响应结果
     */
    @ExceptionHandler(StandardException.class)
    @ResponseBody
    public ResponseResult<IResponseCode> handlerMyDemoException(Exception e) {
        StandardException ex = (StandardException) e;
        return ResponseResult.failure(ex.getCode());
    }
}
