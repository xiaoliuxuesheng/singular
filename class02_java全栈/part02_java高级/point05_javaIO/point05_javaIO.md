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

# 第二章 IO流概述

## 2.1 什么是IO

​		Java程序中的数据是从内存中读取而来，而内存中数据是来自网络或者电脑磁盘中，程序从磁盘中获取数据到内存是输入（Input）（数据从外部存储设置进入到内存）；程序将数据从内存中写入到存储设备是输出**Output**

## 2.2 IO 流分类

- 以程序为中心：按流的方向分为输入流和输出流

- 程序操作的流的内容将流划分为字节流和字符流

  |                         | 输入流：Input              | 输出流：Output              |
  | ----------------------- | -------------------------- | --------------------------- |
  | **字节流：Stream**      | 字节输入流 **InputStream** | 字节输出流 **OutPutStream** |
  | **字符流：read和write** | 字符输入流 **Reader**      | 字符输出流 **Writer**       |

- 按流的功能：直接操作数据源的成为节点流，对节点流的包装成为处理流

  - File或ByteArray相关的成为节点流，其他的流是对节点流的包装

## 2.3 流操作的通用步骤

1. 确定操作源
2. 选择处理源的流
3. 具体的流的操作方式：读和写
4. 释放资源

## 2.4 装饰器模式

- IO流的装饰作用是为了提高IO流的操作性能

- 装饰器模式相关对象

  - 抽象组件：定义需要装饰的**抽象类**
  - 具体组件：是抽象组件的具体实现，是需要被装饰的**类**
  - 抽象装饰类：包含了具体组件，是对抽象类的实现是由被装饰组件实现，并对原有实现进行的增强
  - 具体装饰类：被装饰的对象

- 核心代码

  ```java
  public class 装饰器类 implements 抽象组件{
      private 被装饰器类 decorator;
      public 装饰器类(被装饰器类 decorator){
      	this.decorator = decorator
      }
      
      @OverRide
      public void 增强方法(){
          decorator.增强方法() + 方法的增强;
      }
  }
  ```

## 2.5 try - with -resource

```java
// 流无需手动关闭
try(流的声明){
    
}cache(){
    
}
```

# 第三章 InputStream

## 3.1 通用API

| 方法名                 | 说明                                                         |
| ---------------------- | ------------------------------------------------------------ |
| close()                | 通知操作系统：关闭此输入流并释放与此流相关联的系统资源       |
| read()                 | 从输入流中读取数据中的下一个字节                             |
| read(byte[] b)         | 从输入流中读取一定数量的字节,并保存在缓存数据中(参数),返回读取到的字节长度 |
| read(byte[] b,off len) | 从输入流中读取一定数量的字节,并保存在缓存数据中(参数)        |
| mark(int limit)        | 在此输入流的标记当前位置                                     |
| reset()                | 将此流重新定位到最后一次对此输入流mark()方法时的设置         |
| skip(long l)           | 跳过和丢弃此输入流中的那个字节                               |

## 3.2 FileInputStream

> 通过字节方式读取文件,适合读取所有类型文件

- 构建FileInputStream

## 3.3 ByteArrayInputStream

> 在内存中创建了一个字节数组,将输入流中读取的数据保存到字节数组的缓存区中

- 扩展API

  | 方法名            | 说明                                         |
  | ----------------- | -------------------------------------------- |
  | available()       | 表示剩余可读字节数量.                        |
  | markSupported()   | 这个值总是返回true - 是否支持mark()/reset(). |
  | mark(int limit) : | limit在此处没有意义 - 标记当前的位置,        |

## 3.4 BufferedInputStream

> 内部维护了一个缓冲区（默认8K），包装了节点流，增加了操作性能
>
> 流的释放标准是从里到外释放，可以只释放外层流，会自动释放内部对应的节点流

## 3.5 DataInputStream

## 3.6 ObjectOutputStream

> 反序列化：不是所有对象都可以序列化，需要实现Serializable



# 第四章 OutputStream

## 4.1 通用API

| 方法名称                 | 说明                                                 |
| ------------------------ | ---------------------------------------------------- |
| close()                  | 通知操作系统：关闭出输出流并释放与此流关联的系统资源 |
| flush()                  | 刷新此输出流并强制任何缓冲的输出字节被写出           |
| write()                  |                                                      |
| write(byte[] b)          | 将字节数组全部数据写入到此输出流                     |
| write(byte[] b,off, len) | 将字节数组制定的数据写入到此输出流                   |

## 4.2 FileOutputStream

> 把内存中的数据写入到磁盘文件中，通过字节方式写入或追加到文件,适合写入任何类型文件

- 构建FileOutputStream对象

  ```java
  // 写入
  public FileOutputStream(String name);
  public FileOutputStream(File file);
  
  // 追加
  public FileOutputStream(String name, boolean append);
  public FileOutputStream(File file, boolean append);
  ```

- 常用操作：Java程序 -》 JVM -》 操作系统 -》 写入到文件

### 1. PrintStream

> 打印流，可以自动刷新，可以重定向输出端

## 4.3 ByteArrayOutputStream

> 对byte类型数据进行写入的类 相当于一个中间缓冲层，将类写入到文件等其他outputStream。它是对字节进行操作，属于内存操作流

- 扩展API

  | 方法          | 说明                   |
  | ------------- | ---------------------- |
  | toByteArray() | 获取当前内存流中的数据 |

## 4.4 BufferedOutputStream

> 内部维护了一个缓冲区（默认8K），包装了节点流，增加了操作性能
>
> 流的释放标准是从里到外释放，可以只释放外层流，会自动释放内部对应的节点流

## 4.5 DataOutputStream

> 数据输出流允许应用程序以与机器无关方式将Java基本数据类型写到底层输出流。

## 4.6 ObjectInputStream

> 序列化：不是所有对象都可以序列化，需要实现Serializable

# 第五章 Reader

## 5.1 通用API

| 方法名                 | 说明                                                         |
| ---------------------- | ------------------------------------------------------------ |
| close()                | 通知操作系统：关闭此输入流并释放与此流相关联的系统资源       |
| read()                 | 从输入流中读取数据中的下一个字节                             |
| read(byte[] b)         | 从输入流中读取一定数量的字节,并保存在缓存数据中(参数),返回读取到的字节长度 |
| read(byte[] b,off len) | 从输入流中读取一定数量的字节,并保存在缓存数据中(参数)        |
| mark(int limit)        | 在此输入流的标记当前位置                                     |
| reset()                | 将此流重新定位到最后一次对此输入流mark()方法时的设置         |
| skip(long l)           | 跳过和丢弃此输入流中的那个字节                               |

## 5.2 FileReader

## 5.3 BufferedReader

- 扩展API

  | 方法名     | 说明     |
  | ---------- | -------- |
  | readLine() | 读取一行 |

## 5.4 InputStreamReader

> 是字节流转化成字符流的桥梁.通过给定字符编码方式或者传入指定编码方式,平台默认编码方式等将字节转化成字符读取到流中.

# 第六章 Write

## 6.1 通用API

| 方法名称                 | 说明                                                 |
| ------------------------ | ---------------------------------------------------- |
| close()                  | 通知操作系统：关闭出输出流并释放与此流关联的系统资源 |
| flush()                  | 刷新此输出流并强制任何缓冲的输出字节被写出           |
| write()                  |                                                      |
| write(byte[] b)          | 将字节数组全部数据写入到此输出流                     |
| write(byte[] b,off, len) | 将字节数组制定的数据写入到此输出流                   |

## 6.2 FileWriter

##6.3 BufferedWriter

- 扩展API：不要使用多态

  | 方法名    | 说明   |
  | --------- | ------ |
  | newLine() | 换行符 |

## 6.4 InputStreamWriter

> 是字符流转化成字节流的桥梁,通过给定字符编码方式或者传入指定编码方式,平台默认编码方式等将字符转化成字节写到流中

## 6.5 PrintWriter



# 第七章 工具包

## 7.1 Commons-io工具包

1. 引入依赖

   ```xml
   
   ```

2. 常用方法说明

   | 方法名 | 说明 |
   | ------ | ---- |
   |        |      |

## 7.2 HuTool工具包

1. 引入依赖

   ```xml
   
   ```

2. 常用方法说明

   | 方法名 | 说明 |
   | ------ | ---- |
   |        |      |

   

   