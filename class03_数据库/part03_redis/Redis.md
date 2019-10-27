# 第一章 初始Redis

## 1.1 Redis简介

- 开源、免费的缓存服务器
- 高性能的Key-Value服务器
- 支持多种数据结构，功能丰富

## 1.2 Redis特性

- 速度快：支持10WOPS，C语言编写，单线程(同一时间只执行一条命令)，使用内存管理数据(非阻塞IO,单线程纯内存)
- 持久化：内存数据可以持久化，RDB 和 AOF
- 多种数据结构：String、Hash Table、Linked List、Set、Sorted Set、（Bit Map，HyperLogLog，GEO（位置定位计算），）
- 支持多种编程语言：Java、Python、Php、Node、Go
- 简单：真个服务器代码简单、少，不依赖外部库，单线程
- 主从复制：高可用基础
- 功能丰富：支持简单事物、消息发布订阅、Lua脚本、pipeline
- 高可用分布式：Redis Sentinel 、 Redis Cluster

## 1.3 Redis使用场景

- 缓存：保存临时数据
- 计数器：
- 消息队列系统：发布与订阅
- 排行榜功能：
- 社交网络：
- 实时系统：

## 1.4 Redis 安装与配置

1. Redis安装

   - LInux下安装Redis

     ```sh
     wget redis.tar.gz   		# 查询Redis官网
     tar -xzvf redis.tar.gz		# 解压
     ln -s redis.xx	redis		# 为安装包添加软链接
     cd redis					# 进入Redis才可以安装
     make && make install		# 便于安装包,安装好后再/usr/local/bin/目录中
     redis-server redis.conf		# 使用配置文件启动redis服务器
     ```

     > 可执行文件说明
     >
     > - redis-server:redis服务器
     > - redis-cli:Redis服务端窗口
     > - redis-benchmark:Redis性能测试
     > - redis-check-aop:修复aop文件
     > - redis-check-dump:修复rdb文件
     > - redis-sentinel:sentinel服务器
     >
     > Redis启动
     >
     > - 最简启动 : redis-server(使用默认配置)
     >
     > - 动态参数启动 : redis-server --port 6380
     >
     > - 配置文件启动:redis-server redis.conf
     >
     >   ```sh
     >   ps -ef | grep redis
     >   netstart -antpl | grep redis
     >   redis-cli -h IP号 -p 端口 ping
     >   ```

   - Redis在Windows下安装

2. Redis客户端连接

   ```sh
   redis-cli -h IP号 -p 端口
   
   ->:ping  
   pong
   ```

   ```sh
   telnet IP 端口		# 在windward中查看Redis是否端口开启
   
   # 查看已开放的端口
   firewall-cmd --list-ports
   
   开放端口（开放后需要要重启防火墙才生效）
   
   firewall-cmd --zone=public --add-port=3338/tcp --permanent
   
   重启防火墙
   
   firewall-cmd --reload
   
   关闭端口（关闭后需要要重启防火墙才生效）
   
   firewall-cmd --zone=public --remove-port=3338/tcp --permanent
   
   开机启动防火墙
   systemctl enable firewalld
   
   开启防火墙
   
   systemctl start firewalld
   
   禁止防火墙开机启动
   systemctl disable firewalld
   
   停止防火墙
   systemctl stop firewalld
   ```

   

1. Redis常用配置

   ```properties
   deamonize yes|no 		# 是否是守护进程,yes是会有进程文件以及日志
   port 6379				# 端口
   logfile					# 日志文件
   dir						# Redis工作目录
   ```

   

# 第二章 Redis数据类型与API

## 2.1 通用命令

- 通用命令

  | 命令           | 说明                                             |
  | -------------- | ------------------------------------------------ |
  | keys [pattern] | 遍历所有key                                      |
  | dbsize         | 查看本数据库有key的总数                          |
  | exists key     | 判断key是否存在                                  |
  | del key...     | 删除指定的key                                    |
  | expire key 秒  | 设置指定key的过期时间                            |
  | ttl key        | 查询指定key的过期时间                            |
  | persist key    | 去掉key的过期时间                                |
  | type key       | 查看key的数据类型:string-hash-list-set-zset-none |

- 数据结构和内部编码

  ```mermaid
  graph LR
  Root[key] --> A((String))
  A --> A1(raw)
  A --> A2(int)
  A --> A3(embstr)
  Root --> B((hash))
  B --> B1(hashtable)
  B --> B2(ziplist)
  Root --> C((list))
  C --> C1(linkedlist)
  C --> C2(ziplist)
  Root --> D((set))
  D --> D1(hashtable)
  D --> D2(intset)
  Root --> E((zset))
  E --> E1(skiplist)
  E --> E2(ziplist)
  ```

## 2.2 字符串

- 字符串结构
  
  - key是字符串类型,值可以是字符串、数字、二进制（最大不可大512M）
  
- 常用命令

    | 命令                         | 说明                                     |
    | ---------------------------- | ---------------------------------------- |
    | get key                      | 获取指定key的值                          |
    | set key value                | 设置指定key指定值(不管key存不存在都设置) |
    | setnx key value              | key不存在才设置                          |
    | set key value xx             | 可以存在才设置                           |
    | del key                      | 删除指定key                              |
    | incr key                     | 数值类型 自增1                           |
    | decr key                     | key自减1                                 |
    | incrby key 值                | key自增指定值                            |
    | decrby key 值                | key自减指定值                            |
    | mget key ...                 | 批量获取key                              |
    | mset key value key value ... | 批量设置key                              |
    | getset key value             | 设置新值并且返回原来的值                 |
    | append key value             | 给指定key追加值                          |
    | strlen key                   | 查看指定key的长度(字节),一个汉字2个字节  |
    | incrbyfloat key 数值         | 值浮点数增加指定值                       |
    | getrange key start end       | 获取字符串指定下标所有值                 |
    | setrange key index 值        | 设置指定下标所对应的值                   |

## 2.3 hash

- 特点

  - 哈希值结构:{key:{字段:值}} - 字段是不可以重复

- 命令

  | 命令                             | 说明                            |
  | -------------------------------- | ------------------------------- |
  | hget key 字段                    | 获取key中指定字段的值           |
  | hset key 字段 值                 | 给指定key添加字段和值           |
  | hdel key 字段                    | 删除指定key中的指定字段         |
  | hexists key 字段                 | 判断是否存在指定字段            |
  | hlen key                         | 获取指定key中字段的数量         |
  | hmget key 字段1 字段2 ...        | 获取指定key的多个字段           |
  | hmset key 字段1 值1 字段2 值2... | 设置指定key多个字段值           |
  | hgetall key                      | 返回hash中key对应的所有字段和值 |
  | hvals key                        | 返回hash中key对应的所有值       |
  | hkeys key                        | 返回hash key对应的所有的字段    |
  | hsetnx key 字段 值               | 已存在则不设置                  |
  | hincrby key 字段 值              | 指定key的指定字段自增指定值     |
  | 好incrbyfloat key 字段 值        | 指定key的指定字段自增指定值     |

## 2.4 lsit

- 特点

  - 列表数据结构 : key : 元素1 元素2 ...
  - 有序可以重复的

- 列表API

  | 命令                                | 说明                                                         |
  | ----------------------------------- | ------------------------------------------------------------ |
  | rpush key value1 ...                | 在列表右边追加多个元素                                       |
  | lpush key value1...                 | 在列表左边追加多个元素                                       |
  | linsert key before\|after value1... | 在指定值前后插入                                             |
  | lpop key                            | 从左边弹出一个元素                                           |
  | rpop key                            | 从右边弹出一个元素                                           |
  | lrem key count value                | 根据count值删除所有value相同的值<br />count>0 从左到右,最多删除count个<br />count<0 从右向左,最多删除count个<br />count=0 删除所有value |
  | ltrim key 开始 结束                 | 安装索引范围修剪列表                                         |
  | lrange key 开始 结束                | 获取列表指定范围内的所有item 包含end                         |
  | lindex key 索引                     | 获取指引索引的值                                             |
  | llen key                            | 获取列表中的元素个数                                         |
  | lset key index 新值                 | 设置指定索引指定值                                           |
  |                                     |                                                              |

## 2.5 set



# 第三章 Redis客户端

## 3.1 Java - Jedis

- 获取Jedis

  ```xml
  <dependency>
      <groupId>redis.clients</groupId>
      <artifactId>jedis</artifactId>
      <version>2.7.1</version><!--版本号可根据实际情况填写-->
  </dependency>
  <dependency>
      <groupId>org.apache.commons</groupId>
      <artifactId>commons-lang3</artifactId>
      <version>3.3.2</version>!--版本号可根据实际情况填写-->
  </dependency>
  ```

- Jedis工具集类

  ```java
  import com.aicai.qa.tools.statics.config.SysConfigUtil;
  import redis.clients.jedis.BinaryClient;
  import redis.clients.jedis.Jedis;
  import redis.clients.jedis.JedisPool;
  import redis.clients.jedis.JedisPoolConfig;
  
  import java.util.List;
  import java.util.Map;
  import java.util.Set;
  
  public class RedisUtil {
      private JedisPool pool = null;
  
      private RedisUtil() {
          if (pool == null) {
              String ip = SysConfigUtil.getSysConfigUtil("redis.properties").getString("redis.host");
              int port = SysConfigUtil.getSysConfigUtil("redis.properties").getInt("redis.port");
              String password = SysConfigUtil.getSysConfigUtil("redis.properties").getString("redis.password");
              JedisPoolConfig jedisPoolConfig = new JedisPoolConfig();
              jedisPoolConfig.setMaxTotal(SysConfigUtil.getSysConfigUtil("redis.properties").getInt("redis.maxTotal"));
              jedisPoolConfig.setMaxIdle(SysConfigUtil.getSysConfigUtil("redis.properties").getInt("redis.maxIdle"));
              jedisPoolConfig.setMaxWaitMillis(SysConfigUtil.getSysConfigUtil("redis.properties").getLong("redis.maxWaitMillis"));
              jedisPoolConfig.setTestOnBorrow(SysConfigUtil.getSysConfigUtil("redis.properties").getBoolean("redis.testOnBorrow"));
              if (password != null && !"".equals(password)) {
                  // redis 设置了密码
                  pool = new JedisPool(jedisPoolConfig, ip, port, 10000, password);
              } else {
                  // redis 未设置密码
                  pool = new JedisPool(jedisPoolConfig, ip, port, 10000);
              }
          }
      }
  
      /**
       * 获取指定key的值,如果key不存在返回null，如果该Key存储的不是字符串，会抛出一个错误
       *
       * @param key
       * @return
       */
      public String get(String key) {
          Jedis jedis = getJedis();
          String value = null;
          value = jedis.get(key);
          return value;
      }
  
      /**
       * 设置key的值为value
       *
       * @param key
       * @param value
       * @return
       */
      public String set(String key, String value) {
          Jedis jedis = getJedis();
          return jedis.set(key, value);
      }
  
      /**
       * 删除指定的key,也可以传入一个包含key的数组
       *
       * @param keys
       * @return
       */
      public Long del(String... keys) {
          Jedis jedis = getJedis();
          return jedis.del(keys);
      }
  
      /**
       * 通过key向指定的value值追加值
       *
       * @param key
       * @param str
       * @return
       */
      public Long append(String key, String str) {
          Jedis jedis = getJedis();
          return jedis.append(key, str);
      }
  
      /**
       * 判断key是否存在
       *
       * @param key
       * @return
       */
      public Boolean exists(String key) {
          Jedis jedis = getJedis();
          return jedis.exists(key);
      }
  
      /**
       * 设置key value,如果key已经存在则返回0
       *
       * @param key
       * @param value
       * @return
       */
      public Long setnx(String key, String value) {
          Jedis jedis = getJedis();
          return jedis.setnx(key, value);
      }
  
      /**
       * 设置key value并指定这个键值的有效期
       *
       * @param key
       * @param seconds
       * @param value
       * @return
       */
      public String setex(String key, int seconds, String value) {
          Jedis jedis = getJedis();
          return jedis.setex(key, seconds, value);
      }
  
      /**
       * 通过key 和offset 从指定的位置开始将原先value替换
       *
       * @param key
       * @param offset
       * @param str
       * @return
       */
      public Long setrange(String key, int offset, String str) {
          Jedis jedis = getJedis();
          return jedis.setrange(key, offset, str);
      }
  
      /**
       * 通过批量的key获取批量的value
       *
       * @param keys
       * @return
       */
      public List<String> mget(String... keys) {
          Jedis jedis = getJedis();
          return jedis.mget(keys);
      }
  
      /**
       * 批量的设置key:value,也可以一个
       *
       * @param keysValues
       * @return
       */
      public String mset(String... keysValues) {
          Jedis jedis = getJedis();
          return jedis.mset(keysValues);
      }
  
      /**
       * 批量的设置key:value,可以一个,如果key已经存在则会失败,操作会回滚
       *
       * @param keysValues
       * @return
       */
      public Long msetnx(String... keysValues) {
          Jedis jedis = getJedis();
          return jedis.msetnx(keysValues);
      }
  
      /**
       * 设置key的值,并返回一个旧值
       *
       * @param key
       * @param value
       * @return
       */
      public String getSet(String key, String value) {
          Jedis jedis = getJedis();
          return jedis.getSet(key, value);
      }
  
      /**
       * 通过下标 和key 获取指定下标位置的 value
       *
       * @param key
       * @param startOffset
       * @param endOffset
       * @return
       */
      public String getrange(String key, int startOffset, int endOffset) {
          Jedis jedis = getJedis();
          return jedis.getrange(key, startOffset, endOffset);
      }
  
      /**
       * 通过key 对value进行加值+1操作,当value不是int类型时会返回错误,当key不存在是则value为1
       *
       * @param key
       * @return
       */
      public Long incr(String key) {
          Jedis jedis = getJedis();
          return jedis.incr(key);
      }
  
      /**
       * 通过key给指定的value加值,如果key不存在,则这是value为该值
       *
       * @param key
       * @param integer
       * @return
       */
      public Long incrBy(String key, long integer) {
          Jedis jedis = getJedis();
          return jedis.incrBy(key, integer);
      }
  
      /**
       * 对key的值做减减操作,如果key不存在,则设置key为-1
       *
       * @param key
       * @return
       */
      public Long decr(String key) {
          Jedis jedis = getJedis();
          return jedis.decr(key);
      }
  
      /**
       * 减去指定的值
       *
       * @param key
       * @param integer
       * @return
       */
      public Long decrBy(String key, long integer) {
          Jedis jedis = getJedis();
          return jedis.decrBy(key, integer);
      }
  
      /**
       * 通过key获取value值的长度
       *
       * @param key
       * @return
       */
      public Long strLen(String key) {
          Jedis jedis = getJedis();
          return jedis.strlen(key);
      }
  
      /**
       * 通过key给field设置指定的值,如果key不存在则先创建,如果field已经存在,返回0
       *
       * @param key
       * @param field
       * @param value
       * @return
       */
      public Long hsetnx(String key, String field, String value) {
          Jedis jedis = getJedis();
          return jedis.hsetnx(key, field, value);
      }
  
      /**
       * 通过key给field设置指定的值,如果key不存在,则先创建
       *
       * @param key
       * @param field
       * @param value
       * @return
       */
      public Long hset(String key, String field, String value) {
          Jedis jedis = getJedis();
          return jedis.hset(key, field, value);
      }
  
      /**
       * 通过key同时设置 hash的多个field
       *
       * @param key
       * @param hash
       * @return
       */
      public String hmset(String key, Map<String, String> hash) {
          Jedis jedis = getJedis();
          return jedis.hmset(key, hash);
      }
  
      /**
       * 通过key 和 field 获取指定的 value
       *
       * @param key
       * @param failed
       * @return
       */
      public String hget(String key, String failed) {
          Jedis jedis = getJedis();
          return jedis.hget(key, failed);
      }
  
      /**
       * 设置key的超时时间为seconds
       *
       * @param key
       * @param seconds
       * @return
       */
      public Long expire(String key, int seconds) {
          Jedis jedis = getJedis();
          return jedis.expire(key, seconds);
      }
  
      /**
       * 通过key 和 fields 获取指定的value 如果没有对应的value则返回null
       *
       * @param key
       * @param fields 可以是 一个String 也可以是 String数组
       * @return
       */
      public List<String> hmget(String key, String... fields) {
          Jedis jedis = getJedis();
          return jedis.hmget(key, fields);
      }
  
      /**
       * 通过key给指定的field的value加上给定的值
       *
       * @param key
       * @param field
       * @param value
       * @return
       */
      public Long hincrby(String key, String field, Long value) {
          Jedis jedis = getJedis();
          return jedis.hincrBy(key, field, value);
      }
  
      /**
       * 通过key和field判断是否有指定的value存在
       *
       * @param key
       * @param field
       * @return
       */
      public Boolean hexists(String key, String field) {
          Jedis jedis = getJedis();
          return jedis.hexists(key, field);
      }
  
      /**
       * 通过key返回field的数量
       *
       * @param key
       * @return
       */
      public Long hlen(String key) {
          Jedis jedis = getJedis();
          return jedis.hlen(key);
      }
  
      /**
       * 通过key 删除指定的 field
       *
       * @param key
       * @param fields 可以是 一个 field 也可以是 一个数组
       * @return
       */
      public Long hdel(String key, String... fields) {
          Jedis jedis = getJedis();
          return jedis.hdel(key, fields);
      }
  
      /**
       * 通过key返回所有的field
       *
       * @param key
       * @return
       */
      public Set<String> hkeys(String key) {
          Jedis jedis = getJedis();
          return jedis.hkeys(key);
      }
  
      /**
       * 通过key返回所有和key有关的value
       *
       * @param key
       * @return
       */
      public List<String> hvals(String key) {
          Jedis jedis = getJedis();
          return jedis.hvals(key);
      }
  
      /**
       * 通过key获取所有的field和value
       *
       * @param key
       * @return
       */
      public Map<String, String> hgetall(String key) {
          Jedis jedis = getJedis();
          return jedis.hgetAll(key);
      }
  
      /**
       * 通过key向list头部添加字符串
       *
       * @param key
       * @param strs 可以是一个string 也可以是string数组
       * @return 返回list的value个数
       */
      public Long lpush(String key, String... strs) {
          Jedis jedis = getJedis();
          return jedis.lpush(key, strs);
      }
  
      /**
       * 通过key向list尾部添加字符串
       *
       * @param key
       * @param strs 可以是一个string 也可以是string数组
       * @return 返回list的value个数
       */
      public Long rpush(String key, String... strs) {
          Jedis jedis = getJedis();
          return jedis.rpush(key, strs);
      }
  
      /**
       * 通过key在list指定的位置之前或者之后 添加字符串元素
       *
       * @param key
       * @param where LIST_POSITION枚举类型
       * @param pivot list里面的value
       * @param value 添加的value
       * @return
       */
      public Long linsert(String key, BinaryClient.LIST_POSITION where,
                          String pivot, String value) {
          Jedis jedis = getJedis();
          return jedis.linsert(key, where, pivot, value);
      }
  
      /**
       * 通过key设置list指定下标位置的value
       * 如果下标超过list里面value的个数则报错
       *
       * @param key
       * @param index 从0开始
       * @param value
       * @return 成功返回OK
       */
      public String lset(String key, Long index, String value) {
          Jedis jedis = getJedis();
          return jedis.lset(key, index, value);
      }
  
      /**
       * 通过key从对应的list中删除指定的count个 和 value相同的元素
       *
       * @param key
       * @param count 当count为0时删除全部
       * @param value
       * @return 返回被删除的个数
       */
      public Long lrem(String key, long count, String value) {
          Jedis jedis = getJedis();
          return jedis.lrem(key, count, value);
      }
  
      /**
       * 通过key保留list中从strat下标开始到end下标结束的value值
       *
       * @param key
       * @param start
       * @param end
       * @return 成功返回OK
       */
      public String ltrim(String key, long start, long end) {
          Jedis jedis = getJedis();
          return jedis.ltrim(key, start, end);
      }
  
      /**
       * 通过key从list的头部删除一个value,并返回该value
       *
       * @param key
       * @return
       */
      public synchronized String lpop(String key) {
  
          Jedis jedis = getJedis();
          return jedis.lpop(key);
      }
  
      /**
       * 通过key从list尾部删除一个value,并返回该元素
       *
       * @param key
       * @return
       */
      synchronized public String rpop(String key) {
          Jedis jedis = getJedis();
          return jedis.rpop(key);
      }
  
      /**
       * 通过key从一个list的尾部删除一个value并添加到另一个list的头部,并返回该value
       * 如果第一个list为空或者不存在则返回null
       *
       * @param srckey
       * @param dstkey
       * @return
       */
      public String rpoplpush(String srckey, String dstkey) {
          Jedis jedis = getJedis();
          return jedis.rpoplpush(srckey, dstkey);
      }
  
      /**
       * 通过key获取list中指定下标位置的value
       *
       * @param key
       * @param index
       * @return 如果没有返回null
       */
      public String lindex(String key, long index) {
          Jedis jedis = getJedis();
          return jedis.lindex(key, index);
      }
  
      /**
       * 通过key返回list的长度
       *
       * @param key
       * @return
       */
      public Long llen(String key) {
          Jedis jedis = getJedis();
          return jedis.llen(key);
      }
  
      /**
       * 通过key获取list指定下标位置的value
       * 如果start 为 0 end 为 -1 则返回全部的list中的value
       *
       * @param key
       * @param start
       * @param end
       * @return
       */
      public List<String> lrange(String key, long start, long end) {
          Jedis jedis = getJedis();
          return jedis.lrange(key, start, end);
      }
  
      /**
       * 通过key向指定的set中添加value
       *
       * @param key
       * @param members 可以是一个String 也可以是一个String数组
       * @return 添加成功的个数
       */
      public Long sadd(String key, String... members) {
          Jedis jedis = getJedis();
          return jedis.sadd(key, members);
      }
  
      /**
       * 通过key删除set中对应的value值
       *
       * @param key
       * @param members 可以是一个String 也可以是一个String数组
       * @return 删除的个数
       */
      public Long srem(String key, String... members) {
          Jedis jedis = getJedis();
          return jedis.srem(key, members);
      }
  
      /**
       * 通过key随机删除一个set中的value并返回该值
       *
       * @param key
       * @return
       */
      public String spop(String key) {
          Jedis jedis = getJedis();
          return jedis.spop(key);
      }
  
      /**
       * 通过key获取set中的差集
       * 以第一个set为标准
       *
       * @param keys 可以 是一个string 则返回set中所有的value 也可以是string数组
       * @return
       */
      public Set<String> sdiff(String... keys) {
          Jedis jedis = getJedis();
          return jedis.sdiff(keys);
      }
  
      /**
       * 通过key获取set中的差集并存入到另一个key中
       * 以第一个set为标准
       *
       * @param dstkey 差集存入的key
       * @param keys   可以 是一个string 则返回set中所有的value 也可以是string数组
       * @return
       */
      public Long sdiffstore(String dstkey, String... keys) {
          Jedis jedis = getJedis();
          return jedis.sdiffstore(dstkey, keys);
      }
  
      /**
       * 通过key获取指定set中的交集
       *
       * @param keys 可以 是一个string 也可以是一个string数组
       * @return
       */
      public Set<String> sinter(String... keys) {
          Jedis jedis = getJedis();
          return jedis.sinter(keys);
      }
  
      /**
       * 通过key获取指定set中的交集 并将结果存入新的set中
       *
       * @param dstkey
       * @param keys   可以 是一个string 也可以是一个string数组
       * @return
       */
      public Long sinterstore(String dstkey, String... keys) {
          Jedis jedis = getJedis();
          return jedis.sinterstore(dstkey, keys);
      }
  
      /**
       * 通过key返回所有set的并集
       *
       * @param keys 可以 是一个string 也可以是一个string数组
       * @return
       */
      public Set<String> sunion(String... keys) {
          Jedis jedis = getJedis();
          return jedis.sunion(keys);
      }
  
      /**
       * 通过key返回所有set的并集,并存入到新的set中
       *
       * @param dstkey
       * @param keys   可以 是一个string 也可以是一个string数组
       * @return
       */
      public Long sunionstore(String dstkey, String... keys) {
          Jedis jedis = getJedis();
          return jedis.sunionstore(dstkey, keys);
      }
  
      /**
       * 通过key将set中的value移除并添加到第二个set中
       *
       * @param srckey 需要移除的
       * @param dstkey 添加的
       * @param member set中的value
       * @return
       */
      public Long smove(String srckey, String dstkey, String member) {
          Jedis jedis = getJedis();
          return jedis.smove(srckey, dstkey, member);
      }
  
      /**
       * 通过key获取set中value的个数
       *
       * @param key
       * @return
       */
      public Long scard(String key) {
          Jedis jedis = getJedis();
          return jedis.scard(key);
      }
  
      /**
       * 通过key判断value是否是set中的元素
       *
       * @param key
       * @param member
       * @return
       */
      public Boolean sismember(String key, String member) {
          Jedis jedis = getJedis();
          return jedis.sismember(key, member);
      }
  
      /**
       * 通过key获取set中随机的value,不删除元素
       *
       * @param key
       * @return
       */
      public String srandmember(String key) {
          Jedis jedis = getJedis();
          return jedis.srandmember(key);
      }
  
      /**
       * 通过key获取set中所有的value
       *
       * @param key
       * @return
       */
      public Set<String> smembers(String key) {
          Jedis jedis = getJedis();
          return jedis.smembers(key);
      }
  
  
      /**
       * 通过key向zset中添加value,score,其中score就是用来排序的
       * 如果该value已经存在则根据score更新元素
       *
       * @param key
       * @param score
       * @param member
       * @return
       */
      public Long zadd(String key, double score, String member) {
          Jedis jedis = getJedis();
          return jedis.zadd(key, score, member);
      }
  
      /**
       * 通过key删除在zset中指定的value
       *
       * @param key
       * @param members 可以 是一个string 也可以是一个string数组
       * @return
       */
      public Long zrem(String key, String... members) {
          Jedis jedis = getJedis();
          return jedis.zrem(key, members);
      }
  
      /**
       * 通过key增加该zset中value的score的值
       *
       * @param key
       * @param score
       * @param member
       * @return
       */
      public Double zincrby(String key, double score, String member) {
          Jedis jedis = getJedis();
          return jedis.zincrby(key, score, member);
      }
  
      /**
       * 通过key返回zset中value的排名
       * 下标从小到大排序
       *
       * @param key
       * @param member
       * @return
       */
      public Long zrank(String key, String member) {
          Jedis jedis = getJedis();
          return jedis.zrank(key, member);
      }
  
      /**
       * 通过key返回zset中value的排名
       * 下标从大到小排序
       *
       * @param key
       * @param member
       * @return
       */
      public Long zrevrank(String key, String member) {
          Jedis jedis = getJedis();
          return jedis.zrevrank(key, member);
      }
  
      /**
       * 通过key将获取score从start到end中zset的value
       * socre从大到小排序
       * 当start为0 end为-1时返回全部
       *
       * @param key
       * @param start
       * @param end
       * @return
       */
      public Set<String> zrevrange(String key, long start, long end) {
          Jedis jedis = getJedis();
          return jedis.zrevrange(key, start, end);
      }
  
      /**
       * 通过key返回指定score内zset中的value
       *
       * @param key
       * @param max
       * @param min
       * @return
       */
      public Set<String> zrangebyscore(String key, String max, String min) {
          Jedis jedis = getJedis();
          return jedis.zrevrangeByScore(key, max, min);
      }
  
      /**
       * 通过key返回指定score内zset中的value
       *
       * @param key
       * @param max
       * @param min
       * @return
       */
      public Set<String> zrangeByScore(String key, double max, double min) {
          Jedis jedis = getJedis();
          return jedis.zrevrangeByScore(key, max, min);
      }
  
      /**
       * 返回指定区间内zset中value的数量
       *
       * @param key
       * @param min
       * @param max
       * @return
       */
      public Long zcount(String key, String min, String max) {
          Jedis jedis = getJedis();
          return jedis.zcount(key, min, max);
      }
  
      /**
       * 通过key返回zset中的value个数
       *
       * @param key
       * @return
       */
      public Long zcard(String key) {
          Jedis jedis = getJedis();
          return jedis.zcard(key);
      }
  
      /**
       * 通过key获取zset中value的score值
       *
       * @param key
       * @param member
       * @return
       */
      public Double zscore(String key, String member) {
          Jedis jedis = getJedis();
          return jedis.zscore(key, member);
      }
  
      /**
       * 通过key删除给定区间内的元素
       *
       * @param key
       * @param start
       * @param end
       * @return
       */
      public Long zremrangeByRank(String key, long start, long end) {
          Jedis jedis = getJedis();
          return jedis.zremrangeByRank(key, start, end);
      }
  
      /**
       * 通过key删除指定score内的元素
       *
       * @param key
       * @param start
       * @param end
       * @return
       */
      public Long zremrangeByScore(String key, double start, double end) {
          Jedis jedis = getJedis();
          return jedis.zremrangeByScore(key, start, end);
      }
  
      /**
       * 返回满足pattern表达式的所有key
       * keys(*)
       * 返回所有的key
       *
       * @param pattern
       * @return
       */
      public Set<String> keys(String pattern) {
          Jedis jedis = getJedis();
          return jedis.keys(pattern);
      }
  
      /**
       * 通过key判断值得类型
       *
       * @param key
       * @return
       */
      public String type(String key) {
          Jedis jedis = getJedis();
          return jedis.type(key);
      }
  
  
      private void close(Jedis jedis) {
          if (jedis != null) {
              jedis.close();
          }
      }
  
      private Jedis getJedis() {
          return pool.getResource();
      }
  
      public static RedisUtil getRedisUtil() {
          return new RedisUtil();
      }
  
  }
  ```

- SpringBoot Redis配置

  ```java
  
  ```

  

## 3.2 Python - redis-py

## 3.3 Php

## 3.4 Go

# 第四章 瑞士军刀Redis

> Redis 还提供了注入慢查询分析, Redis Shell 、 Pipeline 、事务、与 Lua 脚本、 Bitmaps 、 HyperLogLog 、 PubSub 、 GEO 等附加功能

## 4.1 慢查询

> - Redis 声明周期 : 发送命令-命令排队-命令执行-返回结果
> - 许多存储系统(如: MySQL )提供慢查询日志帮助开发与运维人员定位系统存在的慢操作.所谓慢查询日志就是系统在命令执行前后计算每条命令的执行时间,当超过预设阈值,就将这条命令的相关信息(例如:发生时间,耗时,命令的详细信息)记录到慢查询日志中
>
> - 慢查询只统计步骤 3 的时间,所以没有慢查询并不代表客户端没有超时问题.



- 对于慢查询功能,需要明确两件事:

  　　预设阈值怎么设置? slowlog-log-slower-than (毫秒),

  　　慢查询记录存放在那? 如果需要将 Redis 将配置持久化到本地配置文件,要执行 config rewrite 命令

  ​		slowlog-max-len 只是说明了慢查询日志最多存储多少条,并没有说明存放在哪里?

  ​			实际上 Redis 使用了一个列表来存储慢查询日志, slowlog-max-len 就是列表的最大长度.一个新的命令满足慢查询条件时被插入到这个列表中,当慢查询日志列表已处于其最大长度时,最早插入的一个命令将从列表中移出

  ​		可以看到每个查询日志有4个属性组成,分别是慢查询日志的表示 id 、发生时间戳、命令耗时、执行命令和参数

  ​		由于慢查询日志是一个先进先出的队列,也就是说如果慢查询比较多的情况下,可能会丢失部分慢查询命令,为了防止这种情况发生,可以定期执行 slowlog get 命令将慢查询日志持久化到其他存储中(例如: MySQL 、 ElasticSearch 等),然后可以通过可视化工具进行查询

- 获取慢查询配置
  - config get slowlog-max-len：慢查询队列的长度，默认是128
  - config get slowlog-log-slower-than：慢查询阈值(微妙)，默认是10000
  - slowlog-log-slower-than=0，记录所有命令, 
  - slowlog-log-slower-than<0  对于任何命令都不会进行记录.

- 设置慢查询配置
  - 修改配置文件重启
  - 动态配置，如 config set slowlog-max-len 1000

- 慢查询命令
  - slowlog get [n]：获取慢查询队列中n个元素
  - slowlog len：获取慢查询队列的长度
  - slowlog rest：清空慢查询队列

- 优化方案
  - slowlog-log-slower-than不要设置过大，默认是10ms，通常设置1ms
  - slowlog-max-len不要设置过小，通常设置1000左右
  - 理解命令生命周期
  - 定期持久化慢查询

## 4.2 pipeline

## 4.3 发布订阅

## 4.4 Bitmap

## 4.5 HyperLogLog

## 4.6 GEO

# 第五章 Redis持久化选择

# 第六章 Redis复制原理和优化

# 第七章 Redis Sentinel

# 第八章 Redis Cluster

