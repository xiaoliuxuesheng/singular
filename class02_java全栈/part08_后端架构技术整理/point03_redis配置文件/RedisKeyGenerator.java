package com.singularity.retail.standard.common;

public interface RedisKeyGenerator {

    String getKey(String suffix);
}
