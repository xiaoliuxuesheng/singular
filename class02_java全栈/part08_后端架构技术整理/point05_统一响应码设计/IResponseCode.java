package com.panda.seckill.standard.common;

/**
 * 通用的响应码信息 : 必须包含的两个字段 code 和 message
 *
 * @author 刘晓东
 * @date 2019-12-14
 */
public interface IResponseCode {

    /**
     * 获取响应码
     *
     * @return 响应码
     */
    Integer getCode();

    /**
     * 获取响应信息
     *
     * @return 详细信息字符串
     */
    String getMessage();

    IResponseCode format(Object... args);
}
