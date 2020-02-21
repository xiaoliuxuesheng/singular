# 03_CommonsIO

## 3.1_环境搭建

```pom
<!-- https://mvnrepository.com/artifact/commons-io/commons-io -->
<dependency>
    <groupId>commons-io</groupId>
    <artifactId>commons-io</artifactId>
    <version>2.4</version>
</dependency>
```

## 3.2 常用核心操作

### 1. FileUtils

| 方法名称                                                     | 方法说明           |
| ------------------------------------------------------------ | ------------------ |
| sizeOf(File file)                                            | 查看文件的大小     |
| listFiles( File directory, IOFileFilter fileFilter, IOFileFilter dirFilter) | 列出文件夹子孙集   |
| readFileToString(File f,String charset)                      | 读取文件内容       |
| readFileToByteArray(File file)                               | 读取文件为字节     |
| readLines(File file, String encoding)                        | 逐行读取           |
| lineIterator(File file)                                      | 返回迭代器         |
| write(File file, CharSequence data, boolean append)          | 写数据到文件       |
| writeLines(File file, String encoding, Collection<?> lines)  | 批量写出           |
| copyFile(File srcFile, File destFile)                        | 文件拷贝           |
| copyFileToDirectory(File srcFile, File destDir)              | 复制文件到目录     |
| copyDirectoryToDirectory()                                   | 拷贝目录           |
| copyURLToFile(URL source, File destination)                  | 拷贝网络资源到路径 |

### 2. IOUtils

| 方法名称                         | 方法说明 |
| -------------------------------- | -------- |
| toString(Url url,String charset) | 拷贝网络 |

