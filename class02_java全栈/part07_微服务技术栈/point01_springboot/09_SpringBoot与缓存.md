# 第九章 SpringBoot与缓存

## 9.1 JSR107

### 1. 简介

- J2EE发布的缓存JSR107缓存规范
- 统一缓存的开发规范
- 提升系统的扩展性

### 2. JSR107核心概念

- **CachingProvider**
  - 定义了创建、配置、获取、管理和控制多个CacheManager。一个应用可以在运行期访问多个CachingProvider。
- **CacheManager**
  - 定义了创建、配置、获取、管理和控制多个唯一命名的Cache，这些Cache存在于CacheManager的上下文中。一个CacheManager仅被一个CachingProvider所拥有。
- **Cache**
  - 是一个类似Map的数据结构并临时存储以Key为索引的值。一个Cache仅被一个CacheManager所拥有。
- **Entry**
  - 是一个存储在Cache中的key-value对。
- **Expiry**
  - 每一个存储在Cache中的条目有一个定义的有效期。一旦超过这个时间，条目为过期的状态。一旦过期，条目将不可访问、更新和删除。缓存有效期可以通过ExpiryPolicy设置。

### 3. maven依赖

```xml
<dependency>
    <groupId>javax.cache</groupId>
    <artifactId>cache-api</artifactId>
</dependency>
```

### 4. 缺点

- JSR107定义的接口规范,缓存组件没有完全实现这些规范,有时需要自定义实现,开发繁琐
- Spring提供的缓存抽象,可以简化缓存开发

## 9.2 Spring缓存抽象

### 1. 概述

- Spring从3.1定义了缓存接口统一不同的缓存技术

  - org.framework.cache.Cache接口

    ```tex
    Cache接口包含缓存的各种操作集合
    Cache接口下提供了多种实现 : RedisCache;EhCacheCache,ConcurrentMapCache
    ```

  - org.framework.cache.CacheManager接口

- 支持JSR107注解简化开发

### 2. 核心概念

| 缓存关键字             | 使用说明                                              |
| ---------------------- | ----------------------------------------------------- |
| 接口 : Cache           | 缓存接口,定义了缓存操作,有不同的缓存实现              |
| 接口 : CacheManager    | 缓存管理器 ,管理各种缓存组件                          |
| 注解 : @Cacheable      | 针对方法配置 : 根据方法的请求参数对方法的结果进行缓存 |
| 注解 : @CacheEvict     | 清空缓存                                              |
| 注解 : @CachePut       | 保证方法被调用,而且会缓存方法的结果                   |
| 注解 : @EnableCacheing | 开启基于注解的缓存                                    |
| keyGenerator           | 缓存时key的生成策略                                   |
| serialize              | 缓存时value的序列化策略                               |

## 9.3 注解是使用细节

### 1. @Cacheable

- 属性详解

  | 属性                    | 使用说明                                                     |
  | ----------------------- | ------------------------------------------------------------ |
  | value[] 或 cacheNames[] | 指定缓存组件Cache的名称                                      |
  | key                     | 是缓存数据的key,默认是方法参数 : 可以使用SpEL表达式<br />    ->: 当前方法名  :  #root.methodName <br />    ->:当前被调用的方法 : #root.method.name<br />    ->:当前被调用的对象 : #root.target<br />    ->:当前被调用的对象类 : #root.targetClass<br />    ->:当前方法的参数列表 : #root.args[0]<br />    ->:方法参数的名字 : #参数名称<br />    ->: 方法返回值 : #result |
  | keyGenerator            | key的生成器,可以自己指定key的生成器的组件id keyGenerator和key只可以使用一个 |
  | cacheManager            | 指定缓存管理器 或者cacheResolver指定缓存解析器               |
  | cacheResolver           | 指定缓存解析器                                               |
  | condition               | 是否缓存 : 当condition为true时,开启缓存                      |
  | unless                  | 否定缓存,当unless为true是则不缓存                            |
  | sync                    | 是否异步模式                                                 |

- 工作原理

  - 自动配配置类 : org.springframework.boot.autoconfigure.cache.**CacheAutoConfiguration**

  - 导入缓存组件 

    ```java
    @Import({CacheAutoConfiguration.CacheConfigurationImportSelector.class}) 
    ```

  - 被导入的 : 缓存配置类

    | 名称                                                         |
    | ------------------------------------------------------------ |
    | org.springframework.boot.autoconfigure.cache.**Generic**CacheConfiguration |
    | org.springframework.boot.autoconfigure.cache.**JCache**CacheConfiguration |
    | org.springframework.boot.autoconfigure.cache.**EhCache**CacheConfiguration |
    | org.springframework.boot.autoconfigure.cache.**Hazelcast**CacheConfiguration |
    | org.springframework.boot.autoconfigure.cache.**Infinispan**CacheConfiguration |
    | org.springframework.boot.autoconfigure.cache.**Couchbase**CacheConfiguration |
    | org.springframework.boot.autoconfigure.cache.**Redis**CacheConfiguration |
    | org.springframework.boot.autoconfigure.cache.**Caffeine**CacheConfiguration |
    | org.springframework.boot.autoconfigure.cache.**Simple**CacheConfiguration |
    | org.springframework.boot.autoconfigure.cache.**NoOp**CacheConfiguration |

    > 默认生效的是 : SimpleCacheConfiguration

  - org.springframework.boot.autoconfigure.cache.SimpleCacheConfiguration

    ```java
    @Bean
    public ConcurrentMapCacheManager cacheManager() {
        ConcurrentMapCacheManager cacheManager = new ConcurrentMapCacheManager();
        List<String> cacheNames = this.cacheProperties.getCacheNames();
        if (!cacheNames.isEmpty()) {
            cacheManager.setCacheNames(cacheNames);
        }
    
        return (ConcurrentMapCacheManager)this.customizerInvoker.customize(cacheManager);
    }
    ```

    > 给容器中注册CacheManager

- 运行流程
  - 方法运行之前会查询缓存组件 : 根据cacheNames
  - 如果没有Cache组件会创建一个ConcurrentMap
  - 如果有则在缓存中组件中查询,并返回或者运行方法保存缓存

### 2. @CacheEvict

### 3. @CachePut

### 4. @Caching

### 5. CacheConfig

## 9.4 搭建Redis缓存

### 1. 引入Redis启动器

```xml
<dependency>
    <groupId>org.springframework.boot</groupId>
    <artifactId>spring-boot-starter-data-redis</artifactId>
</dependency>
```

### 2. 配置Redis

```yaml
spring:
  redis:
    host: redis主机地址
```

### 3. Redis自动配置

- 自动注入RedisTemplate<Object,Object> : 操作Redis,操作对象
- 自动注入StringRedisTemplate : 操作Redis,操作字符串

### 4. Redis对象序列化

- 编码方式 : 将对象转为json数据后再保存

- 配置方式 : 配置序列化规则 : 默认使用JDK的序列化器,可以修改为JSON序列化器

  ```java
  RedisTemplate<Object,Object>修改序列化器属性
  ```

## 9.5 自定义缓存管理器

- Redis缓存管理器生效原理 

  ```java
  @ConditionalOnMissingBean({CacheManager.class})
  ```

  > 当容器中没有缓存管理器时候就缓存的自动自动配置类就会生效
  >
  > 引入Redis启动器,缓存管理器称为 : RedisCacheManager

- 默认的CacheManager使用的RedisTemplate<Object,Object> ,默认是用序列化方式保存数据

- 配置自己的CacheManager使用自定义的RedisTemplate<Object,Object>,改变序列化方式

- 配置多个CacheManager,需要默认指定一个缓存管理器