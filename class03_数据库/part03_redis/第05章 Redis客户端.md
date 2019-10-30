# 第五章 Redis客户端

## 5.1 Java

### :dash: Java集成Redis

#### :anchor: **方式一:Jedis原生API**

1. 添加Jedis的Maven依赖

    ```xml
    <dependency>  
        <groupId>redis.clients</groupId>  
        <artifactId>jedis</artifactId>  
        <version>2.8.1</version>  
        <type>jar</type>  
    </dependency>  
    ```

2. 连接Redis服务器

    - 连接单实例服务器

        ```java
        Jedis jedis = new Jedis("localhost",port);
        ```

    - 连接Redis集群

        ```java
        Set<HostAndPort> jedisClusterNodes = new HashSet<HostAndPort>();
        jedisClusterNodes.add(new HostAndPort("127.0.0.1", 7001));
        jedisClusterNodes.add(new HostAndPort("127.0.0.1", 7002));
        
        JedisCluster jc = new JedisCluster(jedisClusterNodes);
        ```

    - 使用连接池JedisPool管理Redis连接

        ```java
        JedisPool jedisPool = new JedisPool("localhost", 7001);  
        Jedis jedis = null;  
        try {  
            
            jedis = jedisPool.getResource();
            
        } catch (Exception e) {  
            e.printStackTrace();  
        } finally {  
            if (jedis != null)  
                jedisPool.returnResource(redis); //将连接交回连接池  
        }  
        jedisPool.destroy(); //退出时销毁连接池 
        ```

    - 详细定制连接池的属性

        ```java
        JedisPoolConfig config = new JedisPoolConfig();  
        config.setMaxActive(500);		// 控制一个pool可分配多少个jedis实例
        config.setMaxIdle(5);  			// 最多有多少个状态为idle(空闲的)的jedis实例
        config.setMaxWait(1000 * 100);  // 最大的等待时间
        config.setTestOnBorrow(true);  	// 在borrow一个jedis实例时，是否提前进行validate操作
        pool = new JedisPool(config, "127.0.0.1", 7001);  
        ```

#### :anchor: **方式二:Spring集成Redis**

1. 添加SpringRedis相关Maven依赖

    ```xml
    <dependency>
        <groupId>org.springframework.data</groupId>
        <artifactId>spring-data-redis</artifactId>
        <version>1.8.6.RELEASE</version>
    </dependency>
    <dependency>
        <groupId>redis.clients</groupId>
        <artifactId>jedis</artifactId>
        <version>2.9.0</version>
    </dependency>
    ```

2. 配置Redis属性配置文件

    ```properties
    redis.host=127.0.0.1
    redis.port=6379
    
    redis.sentinel.port=26879
    
    redis.pwd=
    
    redis.database=0
    redis.timeout=1000
    redis.userPool=true
    redis.pool.maxIdle=100
    redis.pool.minIdle=10
    redis.pool.maxTotal=200
    redis.pool.maxWaitMillis=10000
    redis.pool.minEvictableIdleTimeMillis=300000
    redis.pool.numTestsPerEvictionRun=10
    redis.pool.timeBetweenEvictionRunsMillis=30000
    redis.pool.testOnBorrow=true
    redis.pool.testOnReturn=true
    
    redis.pool.testWhileIdle=true
    ```

3. 配置spring-redis.xml

    ~~~xml
    <?xml version="1.0" encoding="UTF-8"?>
    <beans xmlns="http://www.springframework.org/schema/beans"
        xmlns:context="http://www.springframework.org/schema/context"
        xmlns:redis="http://www.springframework.org/schema/redis" xmlns:cache="http://www.springframework.org/schema/cache"
        xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
        xsi:schemaLocation="
        http://www.springframework.org/schema/beans
        http://www.springframework.org/schema/beans/spring-beans.xsd
        http://www.springframework.org/schema/context
        http://www.springframework.org/schema/context/spring-context.xsd
            http://www.springframework.org/schema/aop
        http://www.springframework.org/schema/aop/spring-aop.xsd
        http://www.springframework.org/schema/redis
        http://www.springframework.org/schema/redis/spring-redis.xsd
        http://www.springframework.org/schema/cache
        http://www.springframework.org/schema/cache/spring-cache.xsd
        ">
        <context:property-placeholder order="1" location="classpath:redis.properties" ignore-unresolvable="true"/>
        <!-- Redis -->
        <!-- 连接池参数 -->
        <bean id="jedisPoolConfig" class="redis.clients.jedis.JedisPoolConfig">
            <property name="maxIdle" value="${redis.pool.maxIdle}" />
            <property name="minIdle" value="${redis.pool.minIdle}" />
            <property name="maxTotal" value="${redis.pool.maxTotal}" />
            <property name="maxWaitMillis" value="${redis.pool.maxWaitMillis}" />
            <property name="minEvictableIdleTimeMillis" value="${redis.pool.minEvictableIdleTimeMillis}"></property>
            <property name="numTestsPerEvictionRun" value="${redis.pool.numTestsPerEvictionRun}"></property>
            <property name="timeBetweenEvictionRunsMillis" value="${redis.pool.timeBetweenEvictionRunsMillis}"></property>
            <property name="testOnBorrow" value="${redis.pool.testOnBorrow}" />
            <property name="testOnReturn" value="${redis.pool.testOnReturn}" />
            <property name="testWhileIdle" value="${redis.pool.testWhileIdle}"></property>
        </bean>
     
        <bean id="jedisConnectionFactory" class="org.springframework.data.redis.connection.jedis.JedisConnectionFactory">
            <property name="poolConfig" ref="jedisPoolConfig" />
            <property name="hostName" value="${redis.host}" />
            <property name="port" value="${redis.port}" />
            <property name="password" value="${redis.pwd}" />
            <property name="usePool" value="${redis.userPool} " />
            <property name="database" value="${redis.database}" />
            <property name="timeout" value="${redis.timeout}" />
        </bean>
     
        <bean id="redisTemplate" class="org.springframework.data.redis.core.RedisTemplate">
            <property name="connectionFactory" ref="jedisConnectionFactory" />
            
            <!-- 序列化方式 建议key/hashKey采用StringRedisSerializer -->
            <property name="keySerializer">
                <bean class="org.springframework.data.redis.serializer.StringRedisSerializer" />
            </property>
            <property name="valueSerializer">
                <bean class="org.springframework.data.redis.serializer.JdkSerializationRedisSerializer" />
            </property>
            <property name="hashKeySerializer">
                <bean class="org.springframework.data.redis.serializer.StringRedisSerializer" />
            </property>
            <property name="hashValueSerializer">
                <bean class="org.springframework.data.redis.serializer.JdkSerializationRedisSerializer" />
            </property>
             <!-- 开启REIDS事务支持 -->
             <property name="enableTransactionSupport" value="false" />
        </bean>
     
        <!-- 对string操作的封装 -->
        <bean id="stringRedisTemplate" class="org.springframework.data.redis.core.StringRedisTemplate">
            <constructor-arg ref="jedisConnectionFactory" />
                <!-- 开启REIDS事务支持 -->  
             <property name="enableTransactionSupport" value="false" />
        </bean>
        
    </beans>
    
    ```
    ~~~

    >  <import resource="classpath:spring/spring-redis.xml" />

4. 封装redis操作工具类

    ```java
    package com.test.util;
     
    import java.util.Collections;
    import java.util.HashSet;
    import java.util.List;
    import java.util.Map;
    import java.util.Set;
    import java.util.concurrent.TimeUnit;
     
    import org.slf4j.Logger;
    import org.slf4j.LoggerFactory;
    import org.springframework.data.redis.core.RedisTemplate;
    import org.springframework.data.redis.core.StringRedisTemplate;
     
    /**
     * redis工具类
     *
     */
    @SuppressWarnings("unchecked")
    public class CacheUtil {
     
        private static final Logger LOG = LoggerFactory.getLogger(CacheUtil.class);
     
        private static RedisTemplate<String, Object> redisTemplate = CacheContextUtil.getBean("redisTemplate", RedisTemplate.class);
     
        private static StringRedisTemplate stringRedisTemplate = CacheContextUtil.getBean("stringRedisTemplate", StringRedisTemplate.class);
     
        private static String CACHE_PREFIX;
     
        private static boolean CACHE_CLOSED;
     
        private CacheUtil() {
     
        }
     
        @SuppressWarnings("rawtypes")
        private static boolean isEmpty(Object obj) {
    	if (obj == null) {
    	    return true;
    	}
    	if (obj instanceof String) {
    	    String str = obj.toString();
    	    if ("".equals(str.trim())) {
    		return true;
    	    }
    	    return false;
    	}
    	if (obj instanceof List) {
    	    List<Object> list = (List<Object>) obj;
    	    if (list.isEmpty()) {
    		return true;
    	    }
    	    return false;
    	}
    	if (obj instanceof Map) {
    	    Map map = (Map) obj;
    	    if (map.isEmpty()) {
    		return true;
    	    }
    	    return false;
    	}
    	if (obj instanceof Set) {
    	    Set set = (Set) obj;
    	    if (set.isEmpty()) {
    		return true;
    	    }
    	    return false;
    	}
    	if (obj instanceof Object[]) {
    	    Object[] objs = (Object[]) obj;
    	    if (objs.length <= 0) {
    		return true;
    	    }
    	    return false;
    	}
    	return false;
        }
        /**
         * 构建缓存key值
         * @param key	缓存key
         * @return
         */
        private static String buildKey(String key) {
    	if (CACHE_PREFIX == null || "".equals(CACHE_PREFIX)) {
    	    return key;
    	}
    	return CACHE_PREFIX + ":" + key;
        }
        /**
         * 返回缓存的前缀
         * @return CACHE_PREFIX_FLAG
         */
        public static String getCachePrefix() {
    	return CACHE_PREFIX;
        }
        /**
         * 设置缓存的前缀
         * @param cachePrefix
         */
        public static void setCachePrefix(String cachePrefix) {
    	if (cachePrefix != null && !"".equals(cachePrefix.trim())) {
    	    CACHE_PREFIX = cachePrefix.trim();
    	}
        }
        /**
         * 关闭缓存
         * @return	true:成功 
         * 		false:失败
         */
        public static boolean close() {
    	LOG.debug(" cache closed ! ");
    	CACHE_CLOSED = true;
    	return true;
        }
        /**
         * 打开缓存
         * @return	true:存在
         * 		false:不存在
         */
        public static boolean openCache() {
    	CACHE_CLOSED = false;
    	return true;
        }
        /**
         * 检查缓存是否开启
         * @return	true:已关闭 
         * 		false:已开启
         */
        public static boolean isClose() {
    	return CACHE_CLOSED;
        }
        /**
         * 判断key值是否存在
         * @param key	缓存的key
         * @return	true:存在
         * 		false:不存在
         */
        public static boolean hasKey(String key) {
    	LOG.debug(" hasKey key :{}", key);
    	try {
    	    if (isClose() || isEmpty(key)) {
    		return false;
    	    }
    	    key = buildKey(key);
    	    return redisTemplate.hasKey(key);
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
        /**
         * 匹配符合正则的key
         * @param patternKey
         * @return key的集合
         */
        public static Set<String> keys(String patternKey) {
    	LOG.debug(" keys key :{}", patternKey);
    	try {
    	    if (isClose() || isEmpty(patternKey)) {
    		return Collections.emptySet();
    	    }
    	    return redisTemplate.keys(patternKey);
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return Collections.emptySet();
        }
     
        /**
         * 根据key删除缓存
         * @param key
         * @return	true:成功 
         * 		false:失败
         */
        public static boolean del(String... key) {
    	LOG.debug(" delete key :{}", key.toString());
    	try {
    	    if (isClose() || isEmpty(key)) {
    		return false;
    	    }
    	    Set<String> keySet = new HashSet<>();
    	    for (String str : key) {
    		keySet.add(buildKey(str));
    	    }
    	    redisTemplate.delete(keySet);
    	    return true;
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
     
        /**
         * 根据key删除缓存
         * @param key
         * @return	true:成功 
         * 		false:失败
         */
        public static boolean delPattern(String key) {
    	LOG.debug(" delete Pattern keys :{}", key);
    	try {
    	    if (isClose() || isEmpty(key)) {
    		return false;
    	    }
    	    key = buildKey(key);
    	    redisTemplate.delete(redisTemplate.keys(key));
    	    return true;
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
     
        /**
         * 删除一组key值
         * @param keys
         * @return	true:成功 
         * 		false:失败
         */
        public static boolean del(Set<String> keys) {
    	LOG.debug(" delete keys :{}", keys.toString());
    	try {
    	    if (isClose() || isEmpty(keys)) {
    		return false;
    	    }
    	    Set<String> keySet = new HashSet<>();
    	    for (String str : keys) {
    		keySet.add(buildKey(str));
    	    }
    	    redisTemplate.delete(keySet);
    	    return true;
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
     
        /**
         * 设置过期时间
         * @param key	缓存key
         * @param seconds	过期秒数
         * @return	true:成功 
         * 		false:失败
         */
        public static boolean setExp(String key, long seconds) {
    	LOG.debug(" setExp key :{}, seconds: {}", key, seconds);
    	try {
    	    if (isClose() || isEmpty(key) || seconds > 0) {
    		return false;
    	    }
    	    key = buildKey(key);
    	    return redisTemplate.expire(key, seconds, TimeUnit.SECONDS);
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
     
        /**
         * 查询过期时间
         * @param key	缓存key
         * @return	秒数
         */
        public static Long getExpire(String key) {
    	LOG.debug(" getExpire key :{}", key);
    	try {
    	    if (isClose() || isEmpty(key)) {
    		return 0L;
    	    }
    	    key = buildKey(key);
    	    return redisTemplate.getExpire(key, TimeUnit.SECONDS);
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return 0L;
        }
     
        /**
         * 缓存存入key-value
         * @param key	缓存键
         * @param value	缓存值
         * @return	true:成功 
         * 		false:失败
         */
        public static boolean setString(String key, String value) {
    	LOG.debug(" setString key :{}, value: {}", key, value);
    	try {
    	    if (isClose() || isEmpty(key) || isEmpty(value)) {
    		return false;
    	    }
    	    key = buildKey(key);
    	    stringRedisTemplate.opsForValue().set(key, value);
    	    return true;
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
     
        /**
         * 缓存存入key-value
         * @param key	缓存键
         * @param value	缓存值
         * @param seconds	秒数
         * @return	true:成功 
         * 		false:失败
         */
        public static boolean setString(String key, String value, long seconds) {
    	LOG.debug(" setString key :{}, value: {}, timeout:{}", key, value, seconds);
    	try {
    	    if (isClose() || isEmpty(key) || isEmpty(value)) {
    		return false;
    	    }
    	    key = buildKey(key);
    	    stringRedisTemplate.opsForValue().set(key, value, seconds, TimeUnit.SECONDS);
    	    return true;
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
     
        /**
         * 根据key取出String value
         * @param key	缓存key值
         * @return	String	缓存的String
         */
        public static String getString(String key) {
    	LOG.debug(" getString key :{}", key);
    	try {
    	    if (isClose() || isEmpty(key)) {
    		return null;
    	    }
    	    key = buildKey(key);
    	    return stringRedisTemplate.opsForValue().get(key);
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return null;
        }
     
        /**
         * 去的缓存中的最大值并+1
         * @param key	缓存key值
         * @return	long	缓存中的最大值+1
         */
        public static long incr(String key) {
    	LOG.debug(" incr key :{}", key);
    	try {
    	    if (isClose() || isEmpty(key)) {
    		return 0;
    	    }
    	    key = buildKey(key);
    	    return redisTemplate.opsForValue().increment(key, 1);
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return 0;
        }
     
        /**
         * 缓存中存入序列化的Object对象
         * @param <T>
         * @param key	缓存key
         * @param obj	存入的序列化对象
         * @return	true:成功 
         * 		false:失败
         */
        public static boolean set(String key, Object obj) {
    	LOG.debug(" set key :{}, value:{}", key, obj);
    	try {
    	    if (isClose() || isEmpty(key) || isEmpty(obj)) {
    		return false;
    	    }
    	    key = buildKey(key);
    	    redisTemplate.opsForValue().set(key, obj);
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
     
        /**
         * 缓存中存入序列化的Object对象
         * @param <T>
         * @param key	缓存key
         * @param obj	存入的序列化对象
         * @return	true:成功 
         * 		false:失败
         */
        public static boolean setObj(String key, Object obj, long seconds) {
    	LOG.debug(" set key :{}, value:{}, seconds:{}", key, obj, seconds);
    	try {
    	    if (isClose() || isEmpty(key) || isEmpty(obj)) {
    		return false;
    	    }
    	    key = buildKey(key);
    	    redisTemplate.opsForValue().set(key, obj);
    	    if (seconds > 0) {
    		redisTemplate.expire(key, seconds, TimeUnit.SECONDS);
    	    }
    	    return true;
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
     
        /**
         * 取出缓存中存储的序列化对象
         * @param key	缓存key
         * @param clazz	对象类
         * @return <T>	序列化对象
         */
        public static <T> T getObj(String key, Class<T> clazz) {
    	LOG.debug(" get key :{}", key);
    	try {
    	    if (isClose() || isEmpty(key)) {
    		return null;
    	    }
    	    key = buildKey(key);
    	    return (T) redisTemplate.opsForValue().get(key);
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return null;
        }
     
        /**
         * 存入Map数组
         * @param <T>
         * @param key	缓存key
         * @param map	缓存map
         * @return	true:成功 
         * 		false:失败
         */
        public static <T> boolean setMap(String key, Map<String, T> map) {
    	try {
    	    if (isClose() || isEmpty(key) || isEmpty(map)) {
    		return false;
    	    }
    	    key = buildKey(key);
    	    redisTemplate.opsForHash().putAll(key, map);
    	    return true;
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
     
        /**
         * 取出缓存的map
         * @param key	缓存key
         * @return map	缓存的map
         */
        @SuppressWarnings("rawtypes")
        public static Map getMap(String key) {
    	LOG.debug(" getMap key :{}", key);
    	try {
    	    if (isClose() || isEmpty(key)) {
    		return null;
    	    }
    	    key = buildKey(key);
    	    return redisTemplate.opsForHash().entries(key);
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return null;
        }
     
        /**
         * 查询缓存的map的集合大小
         * @param key	缓存key
         * @return int	缓存map的集合大小
         */
        public static long getMapSize(String key) {
    	LOG.debug(" getMap key :{}", key);
    	try {
    	    if (isClose() || isEmpty(key)) {
    		return 0;
    	    }
    	    key = buildKey(key);
    	    return redisTemplate.opsForHash().size(key);
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return 0;
        }
     
        
        /**
         * 根据key以及hashKey取出对应的Object对象
         * @param key	缓存key
         * @param hashKey	对应map的key
         * @return object	map中的对象
         */
        public static Object getMapKey(String key, String hashKey) {
    	LOG.debug(" getMapkey :{}, hashKey:{}", key, hashKey);
    	try {
    	    if (isClose() || isEmpty(key) || isEmpty(hashKey)) {
    		return null;
    	    }
    	    key = buildKey(key);
    	    return redisTemplate.opsForHash().get(key, hashKey);
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return null;
        }
     
        /**
         * 取出缓存中map的所有key值
         * @param key	缓存key
         * @return Set<String> map的key值合集
         */
        public static Set<Object> getMapKeys(String key) {
    	LOG.debug(" getMapKeys key :{}", key);
    	try {
    	    if (isClose() || isEmpty(key)) {
    		return null;
    	    }
    	    key = buildKey(key);
    	    return redisTemplate.opsForHash().keys(key);
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return null;
        }
     
        /**
         * 删除map中指定的key值
         * @param key	缓存key
         * @param hashKey	map中指定的hashKey
         * @return	true:成功 
         * 		false:失败
         */
        public static boolean delMapKey(String key, String hashKey) {
    	LOG.debug(" delMapKey key :{}, hashKey:{}", key, hashKey);
    	try {
    	    if (isClose() || isEmpty(key) || isEmpty(hashKey)) {
    		return false;
    	    }
    	    key = buildKey(key);
    	    redisTemplate.opsForHash().delete(key, hashKey);
    	    return true;
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
     
        /**
         * 存入Map数组
         * @param <T>
         * @param key	缓存key
         * @param map	缓存map
         * @param seconds	秒数
         * @return	true:成功 
         * 		false:失败
         */
        public static <T> boolean setMapExp(String key, Map<String, T> map, long seconds) {
    	LOG.debug(" setMapExp key :{}, value: {}, seconds:{}", key, map, seconds);
    	try {
    	    if (isClose() || isEmpty(key) || isEmpty(map)) {
    		return false;
    	    }
    	    key = buildKey(key);
    	    redisTemplate.opsForHash().putAll(key, map);
    	    redisTemplate.expire(key, seconds, TimeUnit.SECONDS);
    	    return true;
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
     
        /**
         * map中加入新的key
         * @param <T>
         * @param key	缓存key
         * @param hashKey	map的Key值
         * @param value	map的value值
         * @return	true:成功 
         * 		false:失败
         */
        public static <T> boolean addMap(String key, String hashKey, T value) {
    	LOG.debug(" addMap key :{}, hashKey: {}, value:{}", key, hashKey, value);
    	try {
    	    if (isClose() || isEmpty(key) || isEmpty(hashKey) || isEmpty(value)) {
    		return false;
    	    }
    	    key = buildKey(key);
    	    redisTemplate.opsForHash().put(key, hashKey, value);
    	    return true;
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
     
        /**
         * 缓存存入List
         * @param <T>
         * @param key	缓存key
         * @param list	缓存List
         * @return	true:成功 
         * 		false:失败
         */
        public static <T> boolean setList(String key, List<T> list) {
    	LOG.debug(" setList key :{}, list: {}", key, list);
    	try {
    	    if (isClose() || isEmpty(key) || isEmpty(list)) {
    		return false;
    	    }
    	    key = buildKey(key);
    	    redisTemplate.opsForList().leftPushAll(key, list.toArray());
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
     
        /**
         * 根据key值取出对应的list合集
         * @param key	缓存key
         * @return List<Object> 缓存中对应的list合集
         */
        public static <V> List<V> getList(String key) {
    	LOG.debug(" getList key :{}", key);
    	try {
    	    if (isClose() || isEmpty(key)) {
    		return null;
    	    }
    	    key = buildKey(key);
    	    return (List<V>) redisTemplate.opsForList().range(key, 0, -1);
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return null;
        }
     
        /**
         * 根据key值截取对应的list合集
         * @param key	缓存key
         * @param start	开始位置
         * @param end	结束位置
         * @return
         */
        public static void trimList(String key, int start, int end) {
    	LOG.debug(" trimList key :{}", key);
    	try {
    	    if (isClose() || isEmpty(key)) {
    		return;
    	    }
    	    key = buildKey(key);
    	    redisTemplate.opsForList().trim(key, start, end);
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
        }
     
        /**
         * 取出list合集中指定位置的对象
         * @param key	缓存key
         * @param index	索引位置
         * @return Object	list指定索引位置的对象
         */
        public static Object getIndexList(String key, int index) {
    	LOG.debug(" getIndexList key :{}, index:{}", key, index);
    	try {
    	    if (isClose() || isEmpty(key) || index < 0) {
    		return null;
    	    }
    	    key = buildKey(key);
    	    return redisTemplate.opsForList().index(key, index);
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return null;
        }
        /**
         * Object存入List
         * @param <T>
         * @param key	缓存key
         * @param value	List中的值
         * @return	true:成功 
         * 		false:失败
         */
        public static boolean addList(String key, Object value) {
    	LOG.debug(" addList key :{}, value:{}", key, value);
    	try {
    	    if (isClose() || isEmpty(key) || isEmpty(value)) {
    		return false;
    	    }
    	    key = buildKey(key);
    	    redisTemplate.opsForList().leftPush(key, value);
    	    return true;
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
     
        /**
         * 缓存存入List
         * @param <T>
         * @param key	缓存key
         * @param list	缓存List
         * @param seconds	秒数
         * @return	true:成功 
         * 		false:失败
         */
        public static <T> boolean setList(String key, List<T> list, long seconds) {
    	LOG.debug(" setList key :{}, value:{}, seconds:{}", key, list, seconds);
    	try {
    	    if (isClose() || isEmpty(key) || isEmpty(list)) {
    		return false;
    	    }
    	    key = buildKey(key);
    	    redisTemplate.opsForList().leftPushAll(key, list.toArray());
    	    if (seconds > 0) {
    		redisTemplate.expire(key, seconds, TimeUnit.SECONDS);
    	    }
    	    return true;
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
     
        /**
         * set集合存入缓存
         * @param <T>
         * @param key	缓存key
         * @param set	缓存set集合
         * @return	true:成功 
         * 		false:失败
         */
        public static <T> boolean setSet(String key, Set<T> set) {
    	LOG.debug(" setSet key :{}, value:{}", key, set);
    	try {
    	    if (isClose() || isEmpty(key) || isEmpty(set)) {
    		return false;
    	    }
    	    key = buildKey(key);
    	    redisTemplate.opsForSet().add(key, set.toArray());
    	    return true;
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
     
        /**
         * set集合中增加value
         * @param <T>
         * @param key	缓存key
         * @param value	增加的value
         * @return	true:成功 
         * 		false:失败
         */
        public static boolean addSet(String key, Object value) {
    	LOG.debug(" addSet key :{}, value:{}", key, value);
    	try {
    	    if (isClose() || isEmpty(key) || isEmpty(value)) {
    		return false;
    	    }
    	    key = buildKey(key);
    	    redisTemplate.opsForSet().add(key, value);
    	    return true;
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
     
        /**
         * set集合存入缓存
         * @param <T>
         * @param key	缓存key
         * @param set	缓存set集合
         * @param seconds	秒数
         * @return	true:成功 
         * 		false:失败
         */
        public static <T> boolean setSet(String key, Set<T> set, long seconds) {
    	LOG.debug(" setSet key :{}, value:{}, seconds:{}", key, set, seconds);
    	try {
    	    if (isClose() || isEmpty(key) || isEmpty(set)) {
    		return false;
    	    }
    	    key = buildKey(key);
    	    redisTemplate.opsForSet().add(key, set.toArray());
    	    if (seconds > 0) {
    		redisTemplate.expire(key, seconds, TimeUnit.SECONDS);
    	    }
    	    return true;
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
     
        /**
         * 取出缓存中对应的set合集
         * @param <T>
         * @param key	缓存key
         * @return Set<Object> 缓存中的set合集
         */
        public static <T> Set<T> getSet(String key) {
    	LOG.debug(" getSet key :{}", key);
    	try {
    	    if (isClose() || isEmpty(key)) {
    		return null;
    	    }
    	    key = buildKey(key);
    	    return (Set<T>) redisTemplate.opsForSet().members(key);
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return null;
        }
     
        /**
         * 有序集合存入数值
         * @param key	缓存key
         * @param value	缓存value
         * @param score	评分
         * @return
         */
        public static boolean addZSet(String key, Object value, double score) {
    	LOG.debug(" addZSet key :{},value:{}, score:{}", key, value, score);
    	try {
    	    if (isClose() || isEmpty(key) || isEmpty(value)) {
    		return false;
    	    }
    	    key = buildKey(key);
    	    return redisTemplate.opsForZSet().add(key, value, score);
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
     
        /**
         * 从有序集合中删除指定值
         * @param key	缓存key
         * @param value	缓存value
         * @return
         */
        public static boolean removeZSet(String key, Object value) {
    	LOG.debug(" removeZSet key :{},value:{}", key, value);
    	try {
    	    if (isClose() || isEmpty(key) || isEmpty(value)) {
    		return false;
    	    }
    	    key = buildKey(key);
    	    redisTemplate.opsForZSet().remove(key, value);
    	    return true;
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
     
        /**
         * 从有序集合中删除指定位置的值
         * @param key	缓存key
         * @param start	起始位置
         * @param end	结束为止
         * @return
         */
        public static boolean removeZSet(String key, long start, long end) {
    	LOG.debug(" removeZSet key :{},start:{}, end:{}", key, start, end);
    	try {
    	    if (isClose() || isEmpty(key)) {
    		return false;
    	    }
    	    key = buildKey(key);
    	    redisTemplate.opsForZSet().removeRange(key, start, end);
    	    return true;
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return false;
        }
     
        /**
         * 从有序集合中获取指定位置的值
         * @param key	缓存key
         * @param start	起始位置
         * @param end	结束为止
         * @return
         */
        public static <T> Set<T> getZSet(String key, long start, long end) {
    	LOG.debug(" getZSet key :{},start:{}, end:{}", key, start, end);
    	try {
    	    if (isClose() || isEmpty(key)) {
    		return Collections.emptySet();
    	    }
    	    key = buildKey(key);
    	    return (Set<T>) redisTemplate.opsForZSet().range(key, start, end);
    	} catch (Exception e) {
    	    LOG.error(e.getMessage(), e);
    	}
    	return Collections.emptySet();
        }
    }
    
    ```

5. Context 工具类

    ```java
    import org.springframework.beans.BeansException;
    import org.springframework.context.ApplicationContext;
    import org.springframework.context.ApplicationContextAware;
    import org.springframework.stereotype.Component;
    
    
    /**
     * Context 工具类
     */
    @SuppressWarnings("static-access")
    @Component
    public class CacheContextUtil implements ApplicationContextAware {
        private static ApplicationContext commonApplicationContext;
    
    
        @Override
        public void setApplicationContext(ApplicationContext context) throws BeansException {
            this.commonApplicationContext = context;
        }
    
    
        /**
         * 根据提供的bean名称得到相应的服务类
         *
         * @param beanId bean的id
         * @return 返回bean的实例对象
         */
        public static Object getBean(String beanId) {
            return commonApplicationContext.getBean(beanId);
        }
    
    
        /**
         * 根据提供的bean名称得到对应于指定类型的服务类
         *
         * @param beanId bean的id
         * @param clazz  bean的类类型
         * @return 返回的bean类型, 若类型不匹配, 将抛出异常
         */
        public static <T> T getBean(String beanId, Class<T> clazz) {
            return commonApplicationContext.getBean(beanId, clazz);
        }
    }
    ```

#### :anchor: 方式三:SpringBoot集成Redis



### :dash: Java调用Redis

1. #### 普通同步方式

    ```java
    @Test
    public void testNormal() {
        Jedis jedis = new Jedis("localhost");
        
        String result = jedis.set("key", "value");
        
        jedis.disconnect();
    }
    ```

2. #### 事务方式(Transactions)

    > 目的是保障一个client发起的事务中的命令可以连续的执行，而中间不会插入其他client的命令

    ```java
    @Test
    public void test2Trans() {
        Jedis jedis = new Jedis("localhost");
        
        Transaction tx = jedis.multi();
        tx.set("key", "value");
        List<Object> results = tx.exec();
        
        jedis.disconnect();
    }
    ```

    - `jedis.watch(…)`方法来监控key，如果调用后key值发生变化，则整个事务会执行失败
    - 事务中某个操作失败，并不会回滚其他操作
    - 可以使用`discard()`方法来取消事务

3. #### 管道(Pipelining)

    > 需要采用异步方式，一次发送多个指令，不同步等待其返回结果

    ```java
    @Test
    public void test3Pipelined() {
        Jedis jedis = new Jedis("localhost");
        
        Pipeline pipeline = jedis.pipelined();
        pipeline.set("key", "value");
        List<Object> results = pipeline.syncAndReturnAll();
        
        jedis.disconnect();
    }
    ```

4. #### 管道中调用事务

    ```java
    @Test
    public void test4combPipelineTrans() {
        jedis = new Jedis("localhost"); 
        
        Pipeline pipeline = jedis.pipelined();
        pipeline.multi();
        pipeline.set("key", "value");
        pipeline.exec();
        List<Object> results = pipeline.syncAndReturnAll();
        
        jedis.disconnect();
    }
    ```

5. #### 分布式直连同步调用

    ```java
    @Test
    public void testshardNormal() {
        List<JedisShardInfo> shards = Arrays.asList(
                new JedisShardInfo("localhost",6379),
                new JedisShardInfo("localhost",6380));
    
        ShardedJedis sharding = new ShardedJedis(shards);
        String result = sharding.set("key", "value");
    
        sharding.disconnect();
    }
    ```

6. #### 分布式直连异步调用

    ```java
    @Test
    public void test6shardpipelined() {
        List<JedisShardInfo> shards = Arrays.asList(
                new JedisShardInfo("localhost",6379),
                new JedisShardInfo("localhost",6380));
    
        ShardedJedis sharding = new ShardedJedis(shards);
        ShardedJedisPipeline pipeline = sharding.pipelined();
        pipeline.set("key", "value");
        List<Object> results = pipeline.syncAndReturnAll();
        
        sharding.disconnect();
    }
    ```

7. #### 分布式连接池同步调用

    ```java
    @Test
    public void test7shardSimplePool() {
        List<JedisShardInfo> shards = Arrays.asList(
                new JedisShardInfo("localhost",6379),
                new JedisShardInfo("localhost",6380));
    
        ShardedJedisPool pool = new ShardedJedisPool(new JedisPoolConfig(), shards);
    
        ShardedJedis one = pool.getResource();
        String result = one.set("key", "value");
        pool.returnResource(one);
    
        pool.destroy();
    }
    ```

8. #### 分布式连接池异步调用

    ```java
    @Test
    public void test8shardPipelinedPool() {
        List<JedisShardInfo> shards = Arrays.asList(
                new JedisShardInfo("localhost",6379),
                new JedisShardInfo("localhost",6380));
    
        ShardedJedisPool pool = new ShardedJedisPool(new JedisPoolConfig(), shards);
        ShardedJedis one = pool.getResource();
        ShardedJedisPipeline pipeline = one.pipelined();
    	pipeline.set("key", "value");
        List<Object> results = pipeline.syncAndReturnAll();
        pool.returnResource(one);
        
        pool.destroy();
    }
    ```

## 5.2 Python - redis-py

## 5.3 Php

## 5.4 Go