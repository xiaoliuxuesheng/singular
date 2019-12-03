# FileUtils

```java
// 根据文件名称构建File对象:如果是多个名称则会构建最后一个文件
public static File getFile(final String... names);
public static File getFile(final File directory, final String... names);

// 获取当前系统运行的临时目录
public static String getTempDirectoryPath();
public static File getTempDirectory();

// 获取当前系统用的家目录
public static String getUserDirectoryPath();
public static File getUserDirectory();

// 为指定文件打开文件输入流/输出流
public static FileInputStream openInputStream(final File file);
public static FileOutputStream openOutputStream(final File file);
public static FileOutputStream openOutputStream(final File file, final boolean append);

// 将制定数值转换为人类可读的文件大小
public static String byteCountToDisplaySize(final BigInteger size);
public static String byteCountToDisplaySize(final long size);

// 创建一个空文件,如果文件已存在则修改最后修改时间
public static void touch(final File file);

// 
public static File[] convertFileCollectionToFileArray(final Collection<File> files);

//
private static void innerListFiles(final Collection<File> files, 
                                   final File directory,
                                   final IOFileFilter filter, 
                                   final boolean includeSubDirectories);

//
public static Collection<File> listFiles(final File directory, 
                                         final IOFileFilter fileFilter, 
                                         final IOFileFilter dirFilter);

//
public static Collection<File> listFilesAndDirs(final File directory, 
                                                final IOFileFilter fileFilter, 
                                                final IOFileFilter dirFilter);

// 
public static Iterator<File> iterateFiles(final File directory, 
                                          final IOFileFilter fileFilter, 
                                          final IOFileFilter dirFilter);

//
public static Iterator<File> iterateFilesAndDirs(final File directory, 
                                                 final IOFileFilter fileFilter,
                                                 final IOFileFilter dirFilter);

// 
public static Collection<File> listFiles(final File directory, 
                                         final String[] extensions, 
                                         final boolean recursive);

//
public static Iterator<File> iterateFiles(final File directory, 
                                          final String[] extensions, 
                                          final boolean recursive);

//
public static boolean contentEquals(final File file1, final File file2);
public static boolean contentEqualsIgnoreEOL(final File file1, 
                                             final File file2, 
                                             final String charsetName);
public static File toFile(final URL url);
public static File[] toFiles(final URL[] urls);
public static URL[] toURLs(final File[] files);
public static void copyFileToDirectory(final File srcFile, final File destDir);
public static void copyFileToDirectory(final File srcFile, 
                                       final File destDir, 
                                       final boolean preserveFileDate);
public static void copyFile(final File srcFile, final File destFile);
public static void copyFile(final File srcFile, 
                            final File destFile,
                            final boolean preserveFileDate);
public static long copyFile(final File input, final OutputStream output);
public static void copyDirectoryToDirectory(final File srcDir, final File destDir);
public static void copyDirectory(final File srcDir, final File destDir);
public static void copyDirectory(final File srcDir, 
                                 final File destDir,
                                 final boolean preserveFileDate);
public static void copyDirectory(final File srcDir, 
                                 final File destDir,
                                 final FileFilter filter);
public static void copyDirectory(final File srcDir, 
                                 final File destDir,
                                 final FileFilter filter, 
                                 final boolean preserveFileDate);
public static void copyURLToFile(final URL source, final File destination);
public static void copyURLToFile(final URL source, 
                                 final File destination,
                                 final int connectionTimeout, 
                                 final int readTimeout);
public static void copyInputStreamToFile(final InputStream source, 
                                         final File destination);
public static void copyToFile(final InputStream source, final File destination);
public static void copyToDirectory(final File src, final File destDir) ;
public static void copyToDirectory(final Iterable<File> srcs, final File destDir);
public static void deleteDirectory(final File directory);
public static boolean deleteQuietly(final File file);
public static boolean directoryContains(final File directory, final File child);
public static void cleanDirectory(final File directory);
public static boolean waitFor(final File file, final int seconds);
public static String readFileToString(final File file, final Charset encoding);
public static String readFileToString(final File file, final String encoding);
public static byte[] readFileToByteArray(final File file);
public static List<String> readLines(final File file, final Charset encoding);
public static List<String> readLines(final File file, final String encoding);
public static LineIterator lineIterator(final File file, final String encoding);
public static LineIterator lineIterator(final File file);
public static void writeStringToFile(final File file, 
                                     final String data, 
                                     final Charset encoding);
public static void writeStringToFile(final File file, 
                                     final String data, 
                                     final String encoding);
public static void writeStringToFile(final File file, 
                                     final String data, 
                                     final Charset encoding,
                                     final boolean append);
public static void writeStringToFile(final File file, 
                                     final String data, 
                                     final String encoding,
                                     final boolean append);
public static void write(final File file, 
                         final CharSequence data, 
                         final Charset encoding);
public static void write(final File file, 
                         final CharSequence data, 
                         final String encoding);
public static void write(final File file, 
                         final CharSequence data, 
                         final Charset encoding, 
                         final boolean append);
public static void write(final File file, 
                         final CharSequence data, 
                         final String encoding, 
                         final boolean append);
public static void writeByteArrayToFile(final File file, final byte[] data);
public static void writeByteArrayToFile(final File file, 
                                        final byte[] data, 
                                        final boolean append);
public static void writeByteArrayToFile(final File file, 
                                        final byte[] data, 
                                        final int off, 
                                        final int len);
public static void writeByteArrayToFile(final File file, 
                                        final byte[] data, 
                                        final int off, 
                                        final int len,
                                        final boolean append);
public static void writeLines(final File file, 
                              final String encoding, 
                              final Collection<?> lines);
public static void writeLines(final File file, 
                              final String encoding, 
                              final Collection<?> lines,
                              final boolean append);
public static void writeLines(final File file, final Collection<?> lines);
public static void writeLines(final File file, 
                              final Collection<?> lines, 
                              final boolean append);
public static void writeLines(final File file, 
                              final String encoding, 
                              final Collection<?> lines,
                              final String lineEnding);
public static void writeLines(final File file, 
                              final String encoding, 
                              final Collection<?> lines,
                              final String lineEnding, 
                              final boolean append);
public static void writeLines(final File file, 
                              final Collection<?> lines, 
                              final String lineEnding);
public static void writeLines(final File file, 
                              final Collection<?> lines, 
                              final String lineEnding,
                              final boolean append);
public static void forceDelete(final File file);
public static void forceDeleteOnExit(final File file);
public static void forceMkdir(final File directory);
public static void forceMkdirParent(final File file);
public static long sizeOf(final File file);
public static BigInteger sizeOfAsBigInteger(final File file);
public static long sizeOfDirectory(final File directory);
public static BigInteger sizeOfDirectoryAsBigInteger(final File directory);
public static boolean isFileNewer(final File file, final File reference);
public static boolean isFileNewer(final File file, final Date date);
public static boolean isFileNewer(final File file, final long timeMillis);
public static boolean isFileOlder(final File file, final File reference);
public static boolean isFileOlder(final File file, final Date date);
public static boolean isFileOlder(final File file, final long timeMillis);
public static long checksumCRC32(final File file),
public static Checksum checksum(final File file, final Checksum checksum);
public static void moveDirectory(final File srcDir, final File destDir);
public static void moveDirectoryToDirectory(final File src, final File destDir, 
                                            final boolean createDestDir);
public static void moveFile(final File srcFile, final File destFile);
public static void moveFileToDirectory(final File srcFile, 
                                       final File destDir, 
                                       final boolean createDestDir);
public static void moveToDirectory(final File src, 
                                   final File destDir, 
                                   final boolean createDestDir);
public static boolean isSymlink(final File file);
```

## Field Summary

| 修饰符和类型        | 字段名称和描述                                |
| :------------------ | :-------------------------------------------- |
| `static File[]`     | `EMPTY_FILE_ARRAY`<br />一个空File类型的数组  |
| `static long`       | `ONE_EB`<br />一EB的字节数                    |
| `static BigInteger` | `ONE_EB_BI`<br />一EB的字节数                 |
| `static long`       | `ONE_GB`<br />一GB的字节数                    |
| `static BigInteger` | `ONE_GB_BI`<br />一GB的字节数                 |
| `static long`       | `ONE_KB`The number of bytes in a kilobyte.    |
| `static BigInteger` | `ONE_KB_BI`The number of bytes in a kilobyte. |
| `static long`       | `ONE_MB`The number of bytes in a megabyte.    |
| `static BigInteger` | `ONE_MB_BI`The number of bytes in a megabyte. |
| `static long`       | `ONE_PB`The number of bytes in a petabyte.    |
| `static BigInteger` | `ONE_PB_BI`The number of bytes in a petabyte. |
| `static long`       | `ONE_TB`The number of bytes in a terabyte.    |
| `static BigInteger` | `ONE_TB_BI`The number of bytes in a terabyte. |
| `static BigInteger` | `ONE_YB`The number of bytes in a yottabyte.   |
| `static BigInteger` | `ONE_ZB`The number of bytes in a zettabyte.   |