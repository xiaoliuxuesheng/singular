# 第四章 Map接口

## 4.1 Map特点

- 特点

  - 存储数据是key:value的格式

- Java中的Map实现类

  ```mermaid
  graph TD
  A[Map接口]
  	A --> B(HashMap实现类)
  		B --> B1(LinkedHashMap实现类)
  	A --> C(TreeMap实现类)
  	A --> D(Hashtable实现类)
  	A --> E(ConcurrentHashMap实现类)
  ```

- 常用API

  | 方法签名                                      |
  | --------------------------------------------- |
  | void clear();                                 |
  | int size();                                   |
  | boolean isEmpty();                            |
  | boolean containsKey(Object key);              |
  | boolean containsValue(Object value);          |
  | Set<Map.Entry<K, V>> entrySet();              |
  | Set<K> keySet();                              |
  | get(Object key);                              |
  | put(K key, V value);                          |
  | void putAll(Map<? extends K, ? extends V> m); |
  | remove(Object key);                           |

## 4.2 HashMap

### 1. 概述 

- 根据键的HashCode 值存储数据,根据键可以直接获取它的值，具有很快的访问速度。
- HashMap最多只允许一条记录的键为Null(多条会覆盖);允许多条记录的值为 Null。
- 非同步的。

### 2. 底层数据结构

- 是线程不安全的,适合单线程环境

- 底层是采用哈希表的数据结构 : 数组 + 链表

  - 数组 : 空间连续,查询块,增删慢
  - 链表 : 空间不连续,查询慢,增删快

- 数组 : JKD8是Node类型的一个数组,默认长度是16位

- Node节点 : 也是链表中的数据节点

  > hash : 哈希值
  >
  > key : 保存的key值
  >
  > V  : 节点保存的真实对象
  >
  > Node next : 下一个节点的引用

- 链表中的节点数量超过8个后链表会变为红黑树

- 扩容 : 当数组容量为属性的0.75倍是,会扩展为原来的两倍

### 3. 源码解读

- put方法

  ```java
  public V put(K key, V value) {
          return putVal(hash(key), key, value, false, true);
  }
  final V putVal(int hash, K key, V value, boolean onlyIfAbsent,boolean evict) {
      Node<K,V>[] tab; 
      Node<K,V> p; 
      int n, i;
      //如果是一个空Map则重新定义个Map
      if ((tab = table) == null || (n = tab.length) == 0){
          n = (tab = resize()).length;
      }
      //如果数组中没有Node节点,则新建一个Node节点
      if ((p = tab[i = (n - 1) & hash]) == null){
          tab[i] = newNode(hash, key, value, null);
      }else {//如果有节点,则将新值添加到已存在节点的后面
          Node<K,V> e; 
          K k;
          //如果key的hash重复,则覆盖节点
          if (p.hash == hash && ((k = p.key)==key||(key != null && key.equals(k))))
              e = p;
          //红黑树
          else if (p instanceof TreeNode)
              e = ((TreeNode<K,V>)p).putTreeVal(this, tab, hash, key, value);
          //
          else {
              for (int binCount = 0; ; ++binCount) {
                  if ((e = p.next) == null) {
                      p.next = newNode(hash, key, value, null);
                      if (binCount >= TREEIFY_THRESHOLD - 1) // -1 for 1st
                          treeifyBin(tab, hash);
                      break;
                  }
                  if (e.hash == hash &&
                      ((k = e.key) == key || (key != null && key.equals(k))))
                      break;
                  p = e;
              }
          }
          if (e != null) { // existing mapping for key
              V oldValue = e.value;
              if (!onlyIfAbsent || oldValue == null)
                  e.value = value;
              afterNodeAccess(e);
              return oldValue;
          }
      }
      ++modCount;
      if (++size > threshold)
          resize();
      afterNodeInsertion(evict);
      return null;
  }
  ```

## 4.3 HashTable

### 1. 概述

- 与 HashMap类似,不同的是:key和value的值均不允许为null;
- 它支持线程的同步，即任一时刻只有一个线程能写Hashtable,因此也导致了Hashtale在写入时会比较慢。

### 2. 底层结构

- 和HashMap结构类型
- 不同的操作的HashTable的方法大部被非synchronized修饰

## 4.4  TreeMap

### 1. 底层结构

- TreeMap 是一个**有序的key-value集合**，它是通过红黑树实现的。
- 能够把它保存的记录根据键(key)排序,默认是按升序排序，也可以指定排序的比较器，
- 当用Iterator 遍历TreeMap时，得到的记录是排过序的。
- TreeMap不允许key的值为null。
- 非同步的

## 4.5 ConcurrentHashMap

### 1.概述

- ConcurrentHashMap是由一个Segment数组组成,默认是16个,不可以改变
- Segment是通过ReentrantLock进行加锁,所以每次操作ConcurrentHashMap加锁的单个Segment,保证了全局线程安全
- 每个Segment数据结构类型HashMap,也是由数组和链表组成

### 2. 源码解读

#### ▲ 初始化

```java
/**
 *   initialCapacity：初始容量，这个值指的是整个 ConcurrentHashMap 的初始容量，
 *
 *   loadFactor：负载因子，Segment 数组不可以扩容，所以这个负载因子是给每个 Segment 内部使用的。
**/
public ConcurrentHashMap(int initialCapacity,
                         float loadFactor, int concurrencyLevel) {
    if (!(loadFactor > 0.0f) || initialCapacity < 0 || concurrencyLevel <= 0)
        throw new IllegalArgumentException();
    if (initialCapacity < concurrencyLevel)
        initialCapacity = concurrencyLevel;
    long size = (long)(1.0 + (long)initialCapacity / loadFactor);
    int cap = (size >= (long)MAXIMUM_CAPACITY) ?
        MAXIMUM_CAPACITY : tableSizeFor((int)size);
    this.sizeCtl = cap;
}
```

> 初始化完成，我们得到了一个 Segment 数组

▲ put过程

```java
public V put(K key, V value) {
    return putVal(key, value, false);
}

final V putVal(K key, V value, boolean onlyIfAbsent) {
    //key和value不可以为null
    if (key == null || value == null) throw new NullPointerException();
    
    // spread() == (h ^ (h >>> 16)) & HASH_BITS = 0x7fffffff;
    int hash = spread(key.hashCode());
    
    
    int binCount = 0;
    for (Node<K,V>[] tab = table;;) {
        Node<K,V> f; 
        int n, i, fh;
        if (tab == null || (n = tab.length) == 0)
            tab = initTable();
        else if ((f = tabAt(tab, i = (n - 1) & hash)) == null) {
            if (casTabAt(tab, i, null,
                         new Node<K,V>(hash, key, value, null)))
                break;
        }
        else if ((fh = f.hash) == MOVED)
            tab = helpTransfer(tab, f);
        else {
            V oldVal = null;
            synchronized (f) {
                if (tabAt(tab, i) == f) {
                    if (fh >= 0) {
                        binCount = 1;
                        for (Node<K,V> e = f;; ++binCount) {
                            K ek;
                            if (e.hash == hash &&
                                ((ek = e.key) == key ||
                                 (ek != null && key.equals(ek)))) {
                                oldVal = e.val;
                                if (!onlyIfAbsent)
                                    e.val = value;
                                break;
                            }
                            Node<K,V> pred = e;
                            if ((e = e.next) == null) {
                                pred.next = new Node<K,V>(hash, key,
                                                          value, null);
                                break;
                            }
                        }
                    }
                    else if (f instanceof TreeBin) {
                        Node<K,V> p;
                        binCount = 2;
                        if ((p = ((TreeBin<K,V>)f).putTreeVal(hash, key,
                                                              value)) != null) {
                            oldVal = p.val;
                            if (!onlyIfAbsent)
                                p.val = value;
                        }
                    }
                }
            }
            if (binCount != 0) {
                if (binCount >= TREEIFY_THRESHOLD)
                    treeifyBin(tab, i);
                if (oldVal != null)
                    return oldVal;
                break;
            }
        }
    }
    addCount(1L, binCount);
    return null;
}
```

