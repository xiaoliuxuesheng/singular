# 第一章 File类

## 1.1 File类

### 1. 概述

- File是对系统中的文件的**抽象**

### 2.系统中的路径

- 相对路径 : 查看路径是参照当前文件的路径为参照
- 绝对路径 : 查看路径是参照当系统根路径为参照

### 3. 系统路径分隔符常量

- **路径分隔符** 
  - String `pathSeparator `
    - 与系统有关的**字符串**的路径分隔符 
  - char `pathSeparatorChar `
    - 与系统有关的**字符**的路径分隔符
- **分隔符**
  - String `separator `
    - 与系统有关的默认**字符串**的名称分隔符
  - char` separatorChar `
    - 与系统有关的默认**字符**的名称分隔符

## 1.2 File类的构造方法

- File(File parent, String child) 
- File(String pathname) 
- File(String parent, String child) 

## 1.3 File类API

### 1.文件判断

| 方法                  | 描述                                       |
| --------------------- | ------------------------------------------ |
| boolean canExecute()  | 测试应用程序是否可以执行此路径表示的文件   |
| boolean canRead()     | 测试是否可以读取此路径表示的文件           |
| boolean canWrite()    | 测试是否可以修改此路径表示的文件。         |
| boolean exists()      | 测试此路径表示的文件或目录是否存在。       |
| boolean isAbsolute()  | 测试此路径是否为绝对路径名                 |
| boolean isDirectory() | 测试此路径表示的文件是否是一个目录         |
| boolean isFile()      | 测试此路径表示的文件是否是一个标准文件     |
| boolean isHidden()    | 测试此路径名指定的文件是否是一个隐藏文件。 |

### 2.文件查询

- static File[] listRoots()
  - 列出可用的文件系统根

| 方法                                    | 描述                                             |
| --------------------------------------- | ------------------------------------------------ |
| File getAbsoluteFile()                  | 返回此路径名的绝对路径名形式                     |
| String getAbsolutePath()                | 返回此路径名的绝对路径名字符串                   |
| File getCanonicalFile()                 | 返回此路径名的规范形式                           |
| String getCanonicalPath()               | 返回此路径名的规范路径名字符串                   |
| String getName()                        | 返回由此路径名表示的文件或目录的名称             |
| String getParent()                      | 返回此路径名父目录的路径名字符串或null。         |
| File getParentFile()                    | 返回此路径名父目录的路径名或null                 |
| String getPath()                        | 将此路径名转换为一个路径名字符串                 |
| long lastModified()                     | 返回此路径名表示的文件最后一次被修改的时间       |
| long length()                           | 返回由此路径名表示的文件的长度                   |
| String[] list()                         | 返回此路径名表示的目录中的文件和目录的字符串数组 |
| File[] listFiles()                      | 返回此路径名表示的目录中的文件和目录的文件数组   |
| String[] list(FilenameFilter filter)    | 满足指定过滤器的文件和目录的字符串数组           |
| File[] listFiles(FileFilter filter)     | 满足指定过滤器的文件和目录的文件数组             |
| File[] listFiles(FilenameFilter filter) | 满足指定过滤器的文件和目录的文件数组             |
| long getTotalSpace()                    | 返回此抽象路径名指定的分区大小                   |
| ong getFreeSpace()                      | 返回此路径指定的分区中未分配的字节数             |

### 3.文件的创建

- static File `createTempFile(String prefix, String suffix)`
  - 创建一个空文件，使用给定前缀和后缀生成其名称
- static File `createTempFile(String prefix, String suffix, File directory)`
  - 创建一个新的空文件，使用给定的前缀和后缀字符串生成其名称

| 方法                    | 描述                                                         |
| ----------------------- | ------------------------------------------------------------ |
| boolean createNewFile() | 当且仅当不存在具有此路径名指定名称的文件时创建一个新的空文件 |
| boolean mkdir()         | 创建此路径名指定的目录                                       |
| boolean mkdirs()        | 创建此抽象路径名指定的目录，包括所有必需但不存在的父目录     |

### 4. 文件的修改

| 方法                                        | 描述                                             |
| ------------------------------------------- | ------------------------------------------------ |
| boolean delete()                            | 删除此路径名表示的文件或目录                     |
| void deleteOnExit()                         | 在虚拟机终止时，请求删除此路径名表示的文件或目录 |
| boolean renameTo(File dest)                 | 重新命名此路径名表示的文件                       |
| boolean setExecutable(boolean executable)   | 设置此路径名所有者执行权限                       |
| boolean setExecutable(boolean e, boolean o) | 设置此路径的所有者或所有用户的执行权限           |
| boolean setLastModified(long time)          | 设置此路径名指定的文件或目录的最后一次修改时间   |
| boolean setReadable(boolean readable)       | 设置此路径名所有者读权限                         |
| boolean setReadable(boolean r, boolean o)   | 设置此路径名的所有者或所有用户的读权限           |
| boolean setReadOnly()                       | 标记此路径指定的文件或目录只能对其进行读操作     |
| boolean setWritable(boolean writable)       | 设置此路径名所有者写权限                         |
| boolean setWritable(boolean w, boolean o)   | 设置此路径名的所有者或所有用户的写权限           |

### 5.其他

| 方法                         | 描述                                               |
| ---------------------------- | -------------------------------------------------- |
| int compareTo(File pathname) | 按字母顺序比较两个抽象路径名                       |
| boolean equals(Object obj)   | 测试此抽象路径名与给定对象是否相等                 |
| long getUsableSpace()        | 返回此抽象路径名指定的分区上可用于此虚拟机的字节数 |
| int hashCode()               | 计算此抽象路径名的哈希码                           |
| String toString()            | 返回此抽象路径名的路径名字符串                     |
| URI toURI()                  | 构造一个表示此抽象路径名的 file: URI               |



一.什么是I/O？
　　Java的核心库java.io提供了全面的IO接口。包括：文件读写、标准设备输出等。Java中IO是以流为基础进行输入输出的，所有数据被串行化写入输出流，或者从输入流读入。

二.什么是流
　　流是一个很形象的概念，当程序需要读取数据的时候，就会开启一个通向数据源的流，这个数据源可以是文件，内存，或是网络连接。类似的，当程序需要写入数据的时候，就会开启一个通向目的地的流。这时候你就可以想象数据好像在这其中“流”动一样。

三.Java流的分类
　　按流向分:
　　输入流: 程序可以从中读取数据的流。
　　输出流: 程序能向其中写入数据的流。
　　按数据传输单位分:
　　字节流: 以字节为单位传输数据的流
　　字符流: 以字符为单位传输数据的流
　　按功能分:
　　节点流: 用于直接操作目标设备的流
　　过滤流: 是对一个已存在的流的链接和封装，通过对数据进行处理为程序提供功能强大、灵活的读写功能。