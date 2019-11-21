# 第三章 Redis 配置说明

## 3.1 Redis基本配置

### 1. 内存单位

```txt
1k => 1000 bytes
1kb => 1024 bytes
1m => 1000000 bytes
1mb => 1024*1024 bytes
1g => 1000000000 bytes
1gb => 1024*1024*1024 bytes
```

- 不区分大小写

## 3.2 配置说明

### 1. Includes:包含外文件

```properties
include /path/to/other.conf
```

>  可以包含一个或多个配置通用的配置文件
>
> 可以将通用的配置抽取为配置模板

### 2. Modules:组件

```properties
loadmodule /path/to/my_module.so
```

>  服务器启动会加载模块,如果无法加载会启动失败

### 3. Network

```properties
bind 192.168.1.100 10.0.0.1		# 监听端口
```

> 如果没有配置`bind` Redis 默认会监听所有网络请求
>
> 可以配置监听一个或多个IP地址

```properties
protected-mode yes				# 是否被保护
```

```properties
port 6379						# 服务器启动端口
```

```properties
tcp-backlog 511
```

```properties
timeout 0						# 在客户端空闲N秒后关闭连接(0表示禁用)
```

```properties
tcp-keepalive 300				# 
```

### 4.General

```properties
daemonize no					# 是否后台启动
```

```properties
supervised no
```

```properties
pidfile /var/run/redis_6379.pid
```

```properties
loglevel notice
```
```properties
logfile ""
```
```properties
databases 16
```
```properties
always-show-logo yes
```
### 5. Snapshotting

```properties
save 900 1
save 300 10
save 60 10000
```
```properties
stop-writes-on-bgsave-error yes
```
```properties
rdbcompression yes
```
```properties
rdbchecksum yes
```
```properties
dbfilename dump.rdb
```
```properties
dir ./
```
### 6. Replication

```properties
replicaof <masterip> <masterport>
```

```properties
masterauth <master-password>
```
```properties
replica-serve-stale-data yes
```
```properties
replica-read-only yes
```
```properties
repl-diskless-sync no
```
```properties
repl-diskless-sync-delay 5
```
```properties
repl-ping-replica-period 10
```
```properties
repl-timeout 60
```
```properties
repl-disable-tcp-nodelay no
```
```properties
repl-backlog-size 1mb
```
```properties
repl-backlog-ttl 3600
```
```properties
replica-priority 100
```
```properties
min-replicas-to-write 3
min-replicas-max-lag 10
```
```properties
replica-announce-ip 5.5.5.5
replica-announce-port 1234
```
### 7.Security

```properties
requirepass foobared
```
```properties
rename-command CONFIG ""
```
### 8. Clients

```properties
maxclients 10000
```
### 9.memory management

```properties
maxmemory <bytes>
```
```properties
LRU means Least Recently Used
LFU means Least Frequently Used
```
```properties
maxmemory-policy noeviction
```
```properties
maxmemory-samples 5
```
```properties
replica-ignore-maxmemory yes
```
### 10. Lazy Freeing

```properties
lazyfree-lazy-eviction no
lazyfree-lazy-expire no
lazyfree-lazy-server-del no
replica-lazy-flush no
```
### 11. Append Only Mode

```properties
appendonly no
```
```properties
appendfilename "appendonly.aof"
```
```properties
appendfsync always
appendfsync everysec
appendfsync no
```
```properties
no-appendfsync-on-rewrite no
```
```properties
auto-aof-rewrite-percentage 100
auto-aof-rewrite-min-size 64mb
```
```properties
aof-load-truncated yes
```
```properties
aof-use-rdb-preamble yes
```
### 12.LUA scripting

```properties
lua-time-limit 5000
```
### 13. Redis Cluster

```properties
cluster-enabled yes
```
```properties
cluster-config-file nodes-6379.conf
```
```properties
cluster-node-timeout 15000
```
```properties
cluster-replica-validity-factor 10
```
```properties
cluster-migration-barrier 1
```
```properties
cluster-require-full-coverage yes
```
```properties
cluster-replica-no-failover no
```
### 14. cluster Docker/NAT support

```properties
cluster-announce-ip 10.1.1.5
cluster-announce-port 6379
cluster-announce-bus-port 6380
```
### 15.SLOW LOG

```properties
slowlog-log-slower-than 10000
```
```properties
slowlog-max-len 128
```
### 16. latency monitor

```properties
latency-monitor-threshold 0
```
### 17. event notification

```properties
notify-keyspace-events ""
```
```properties

```
### 18. advanced config

```properties
hash-max-ziplist-entries 512
hash-max-ziplist-value 64
```
```properties
list-max-ziplist-size -2
```
```properties
list-compress-depth 0
```
```properties
set-max-intset-entries 512
```
```properties
zset-max-ziplist-entries 128
zset-max-ziplist-value 64
```
```properties
hll-sparse-max-bytes 3000
```
```properties
stream-node-max-bytes 4096
stream-node-max-entries 100
```
```properties
activerehashing yes
```
```properties
client-output-buffer-limit normal 0 0 0
client-output-buffer-limit replica 256mb 64mb 60
client-output-buffer-limit pubsub 32mb 8mb 60
```
```properties
client-query-buffer-limit 1gb
```
```properties
proto-max-bulk-len 512mb
```
```properties
dynamic-hz yes
```
```properties
aof-rewrite-incremental-fsync yes
```
```properties
rdb-save-incremental-fsync yes
```
```properties
lfu-log-factor 10
lfu-decay-time 1
```
### 19. active defragmentation

```properties
activedefrag yes
```
```properties
 active-defrag-ignore-bytes 100mb
```
```properties
active-defrag-threshold-lower 10
```
```properties
active-defrag-threshold-upper 100
```
```properties
active-defrag-cycle-min 5
```
```properties
active-defrag-cycle-max 75
```
```properties
active-defrag-max-scan-fields 1000
```

