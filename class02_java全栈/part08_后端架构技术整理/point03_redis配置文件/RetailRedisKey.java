package com.singularity.retail.commons;

import com.singularity.retail.standard.common.RedisKeyGenerator;
import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum RetailRedisKey implements RedisKeyGenerator {
    HELLO_TOKEN("system:hello:token:", "登陆用户的token"),
    RETAIL_LOING_TOKEN("system:employee:token:", "登陆用户的token");

    private String prefix;
    private String name;

    @Override
    public String getKey(String suffix) {
        return this.getPrefix() + suffix;
    }
}
