# :one: FileUtils

> 封装了文件操作的常用方法

## :dash: 常量说明

| Modifier and Type | Field and Description                            |
| :---------------- | :----------------------------------------------- |
| static File[]     | EMPTY_FILE_ARRAY<br />一个空的File类型的数组集合 |
| static long       | ONE_EB<br />一个EB的long型的字节数量             |
| static BigInteger | ONE_EB_BI<br />一个EB的BigInteger类型的字节数量  |
| static long       | ONE_GB<br />一个GB的long型的字节数量             |
| static BigInteger | ONE_GB_BI<br />一个GB的BigInteger类型的字节数量  |
| static long       | ONE_KB<br />一个KB的long型的字节数量             |
| static BigInteger | ONE_KB_BI<br />一个EB的BigInteger类型的字节数量  |
| static long       | ONE_MB<br />一个MB的long型的字节数量             |
| static BigInteger | ONE_MB_BI<br />一个MB的BigInteger类型的字节数量  |
| static long       | ONE_PB<br />一个PB的long型的字节数量             |
| static BigInteger | ONE_PB_BI<br />一个PB的BigInteger类型的字节数量  |
| static long       | ONE_TB<br />一个TB的long型的字节数量             |
| static BigInteger | ONE_TB_BI<br />一个TB的BigInteger类型的字节数量  |
| static BigInteger | ONE_YB<br />一个YB的BigInteger类型的字节数量     |
| static BigInteger | ONE_ZB<br />一个ZB的BigInteger类型的字节数量     |

## :dash: 静态方法

| Modifier and Type       | Method and Description                                       |
| :---------------------- | :----------------------------------------------------------- |
| static String           | byteCountToDisplaySize(BigInteger size)<br />将输入的特定long型数字转义为一个可读性的表示文件大小的结果字符串 |
| static String           | byteCountToDisplaySize(long size)<br />将输入的特定BigInteger型数字转义为一个可读性的表示文件大小的结果字符串 |
| static Checksum         | checksum(File file, Checksum checksum)                       |
| static long             | checksumCRC32(File file)                                     |
| static void             | cleanDirectory(File directory)<br />清除一个目录但是不删除目录 |
| static boolean          | contentEquals(File file1, File file2)<br />比较两个文件的内容判断这两个文件是否相同 |
| static boolean          | contentEqualsIgnoreEOL(File file1, File file2, String charsetName)<br />比较两个文件的内容，忽略换行符，第三个参数编码集 |
| static File[]           | convertFileCollectionToFileArray(Collection<File> files)<br />把相应的文件集合转换成文件数组 |
| static void             | copyDirectory(File srcDir, File destDir)<br />拷贝整个目录到新的位置，并且保存最近修改时间 |
| static void             | copyDirectory(File srcDir, File destDir, boolean preserveFileDate)<br />拷贝整个目录到新的位置，并且设置是否保存最近修改时间 |
| static void             | copyDirectory(File srcDir, File destDir, FileFilter filter)<br />拷贝过滤后的目录到指定的位置，并且保存最近修改时间 |
| static void             | copyDirectory(File srcDir, File destDir, FileFilter filter, boolean preserveFileDate)   拷贝过滤后的目录到指定的位置，并且设置是否保存最近修改时间 |
| static void             | copyDirectoryToDirectory(File srcDir, File destDir)<br />将一个目录拷贝到另一目录中，并且保存最近更新时间 |
| static void             | copyFile(File srcFile, File destFile)<br />拷贝一个文件到指定的目录文件 |
| static void             | copyFile(File srcFile, File destFile, boolean preserveFileDate)<br />拷贝一个文件到指定的目录文件并且设置是否更新文件的最近修改时间 |
| static long             | copyFile(File input, OutputStream output)<br />拷贝一个文件到输出流中 |
| static void             | copyFileToDirectory(File srcFile, File destDir)<br />拷贝一个文件到指定的目录文件并且设置更新文件的最近修改时间 |
| static void             | copyFileToDirectory(File srcFile, File destDir, boolean preserveFileDate)<br />拷贝一个文件到指定的目录文件并且设置是否更新文件的最近修改时间 |
| static void             | copyInputStreamToFile(InputStream source, File destination)<br />拷贝输入流中的资源到一个文件中 |
| static void             | copyToDirectory(File src, File destDir)<br />拷贝一个文件到指定的目录文件 |
| static void             | copyToDirectory(Iterable<File> srcs, File destDir)<br />将文件复制到保存每个文件日期的目录。 |
| static void             | copyToFile(InputStream source, File destination)             |
| static void             | copyURLToFile(URL source, File destination)                  |
| static void             | copyURLToFile(URL source, File destination, int connectionTimeout, int readTimeout) |
| static void             | deleteDirectory(File directory)                              |
| static boolean          | deleteQuietly(File file)                                     |
| static boolean          | directoryContains(File directory, File child)                |
| static void             | forceDelete(File file)                                       |
| static void             | forceDeleteOnExit(File file)                                 |
| static void             | forceMkdir(File directory)                                   |
| static void             | forceMkdirParent(File file)                                  |
| static File             | getFile(File directory, String... names)                     |
| static File             | getFile(String... names)                                     |
| static File             | getTempDirectory()                                           |
| static String           | getTempDirectoryPath()                                       |
| static File             | getUserDirectory()                                           |
| static String           | getUserDirectoryPath()                                       |
| static boolean          | isFileNewer(File file, Date date)                            |
| static boolean          | isFileNewer(File file, File reference)                       |
| static boolean          | isFileNewer(File file, long timeMillis)                      |
| static boolean          | isFileOlder(File file, Date date)                            |
| static boolean          | isFileOlder(File file, File reference)                       |
| static boolean          | isFileOlder(File file, long timeMillis)                      |
| static boolean          | isSymlink(File file)                                         |
| static Iterator<File>   | iterateFiles(File directory, IOFileFilter fileFilter, IOFileFilter dirFilter) |
| static Iterator<File>   | iterateFiles(File directory, String[] extensions, boolean recursive) |
| static Iterator<File>   | iterateFilesAndDirs(File directory, IOFileFilter fileFilter, IOFileFilter dirFilter) |
| static LineIterator     | lineIterator(File file)                                      |
| static LineIterator     | lineIterator(File file, String encoding)                     |
| static Collection<File> | listFiles(File directory, IOFileFilter fileFilter, IOFileFilter dirFilter) |
| static Collection<File> | listFiles(File directory, String[] extensions, boolean recursive) |
| static Collection<File> | listFilesAndDirs(File directory, IOFileFilter fileFilter, IOFileFilter dirFilter) |
| static void             | moveDirectory(File srcDir, File destDir)Moves a directory.   |
| static void             | moveDirectoryToDirectory(File src, File destDir, boolean createDestDir) |
| static void             | moveFile(File srcFile, File destFile)Moves a file.           |
| static void             | moveFileToDirectory(File srcFile, File destDir, boolean createDestDir) |
| static void             | moveToDirectory(File src, File destDir, boolean createDestDir) |
| static FileInputStream  | openInputStream(File file)                                   |
| static FileOutputStream | openOutputStream(File file)                                  |
| static FileOutputStream | openOutputStream(File file, boolean append)                  |
| static byte[]           | readFileToByteArray(File file)                               |
| static String           | readFileToString(File file, Charset encoding)                |
| static String           | readFileToString(File file, String encoding)                 |
| static List<String>     | readLines(File file, Charset encoding)                       |
| static List<String>     | readLines(File file, String encoding)                        |
| static long             | sizeOf(File file)                                            |
| static BigInteger       | sizeOfAsBigInteger(File file)                                |
| static long             | sizeOfDirectory(File directory)                              |
| static BigInteger       | sizeOfDirectoryAsBigInteger(File directory)                  |
| static File             | toFile(URL url)                                              |
| static File[]           | toFiles(URL[] urls)                                          |
| static void             | touch(File file)                                             |
| static URL[]            | toURLs(File[] files)                                         |
| static boolean          | waitFor(File file, int seconds)                              |
| static void             | write(File file, CharSequence data, Charset encoding)        |
| static void             | write(File file, CharSequence data, Charset encoding, boolean append) |
| static void             | write(File file, CharSequence data, String encoding)         |
| static void             | write(File file, CharSequence data, String encoding, boolean append) |
| static void             | writeByteArrayToFile(File file, byte[] data)                 |
| static void             | writeByteArrayToFile(File file, byte[] data, boolean append) |
| static void             | writeByteArrayToFile(File file, byte[] data, int off, int len) |
| static void             | writeByteArrayToFile(File file, byte[] data, int off, int len, boolean append) |
| static void             | writeLines(File file, Collection<?> lines)                   |
| static void             | writeLines(File file, Collection<?> lines, boolean append)   |
| static void             | writeLines(File file, Collection<?> lines, String lineEnding) |
| static void             | writeLines(File file, Collection<?> lines, String lineEnding, boolean append) |
| static void             | writeLines(File file, String encoding, Collection<?> lines)  |
| static void             | writeLines(File file, String encoding, Collection<?> lines, boolean append) |
| static void             | writeLines(File file, String encoding, Collection<?> lines, String lineEnding) |
| static void             | writeLines(File file, String encoding, Collection<?> lines, String lineEnding, boolean append) |
| static void             | writeStringToFile(File file, String data, Charset encoding)  |
| static void             | writeStringToFile(File file, String data, Charset encoding, boolean append) |
| static void             | writeStringToFile(File file, String data, String encoding)   |
| static void             | writeStringToFile(File file, String data, String encoding, boolean append) |

# :two:IOUtils

> 封装了文件与流的操作方法

## :dash: 常量说明

| Modifier and Type | Field and Description                                   |
| :---------------- | :------------------------------------------------------ |
| static char       | DIR_SEPARATOR<br /> 当前系统目录分隔符                  |
| static char       | DIR_SEPARATOR_UNIX<br /> Unix系统的文件目录分隔符       |
| static char       | DIR_SEPARATOR_WINDOWS<br /> Windows系统的文件目录分隔符 |
| static int        | EOF<br />表示文件或流结束                               |
| static String     | LINE_SEPARATOR<br /> 当前系统行分隔字符串               |
| static String     | LINE_SEPARATOR_UNIX<br />Unix系统行分隔字符串           |
| static String     | LINE_SEPARATOR_WINDOWS<br />Windows系统行分隔字符串     |

## :dash: 静态方法

| Modifier and Type           | Method and Description                                       |
| :-------------------------- | :----------------------------------------------------------- |
| static BufferedInputStream  | buffer(InputStream inputStream)<br /> 将字节输入流转为一个缓存输入流 |
| static BufferedInputStream  | buffer(InputStream inputStream, int size)                    |
| static BufferedOutputStream | buffer(OutputStream outputStream)                            |
| static BufferedOutputStream | buffer(OutputStream outputStream, int size)                  |
| static BufferedReader       | buffer(Reader reader)                                        |
| static BufferedReader       | buffer(Reader reader, int size)                              |
| static BufferedWriter       | buffer(Writer writer)                                        |
| static BufferedWriter       | buffer(Writer writer, int size)                              |
| static void                 | close(URLConnection conn)                                    |
| static boolean              | contentEquals(InputStream input1, InputStream input2)        |
| static boolean              | contentEquals(Reader input1, Reader input2)                  |
| static boolean              | contentEqualsIgnoreEOL(Reader input1, Reader input2)         |
| static int                  | copy(InputStream input, OutputStream output)                 |
| static long                 | copy(InputStream input, OutputStream output, int bufferSize) |
| static void                 | copy(InputStream input, Writer output, Charset inputEncoding) |
| static void                 | copy(InputStream input, Writer output, String inputEncoding) |
| static void                 | copy(Reader input, OutputStream output, Charset outputEncoding) |
| static void                 | copy(Reader input, OutputStream output, String outputEncoding) |
| static int                  | copy(Reader input, Writer output)                            |
| static long                 | copyLarge(InputStream input, OutputStream output)            |
| static long                 | copyLarge(InputStream input, OutputStream output, byte[] buffer) |
| static long                 | copyLarge(InputStream input, OutputStream output, long inputOffset, long length) |
| static long                 | copyLarge(InputStream input, OutputStream output, long inputOffset, long length, byte[] buffer) |
| static long                 | copyLarge(Reader input, Writer output)                       |
| static long                 | copyLarge(Reader input, Writer output, char[] buffer)        |
| static long                 | copyLarge(Reader input, Writer output, long inputOffset, long length) |
| static long                 | copyLarge(Reader input, Writer output, long inputOffset, long length, char[] buffer) |
| static LineIterator         | lineIterator(InputStream input, Charset encoding)            |
| static LineIterator         | lineIterator(InputStream input, String encoding)             |
| static LineIterator         | lineIterator(Reader reader)                                  |
| static int                  | read(InputStream input, byte[] buffer)                       |
| static int                  | read(InputStream input, byte[] buffer, int offset, int length) |
| static int                  | read(ReadableByteChannel input, ByteBuffer buffer)           |
| static int                  | read(Reader input, char[] buffer)                            |
| static int                  | read(Reader input, char[] buffer, int offset, int length)    |
| static void                 | readFully(InputStream input, byte[] buffer)                  |
| static void                 | readFully(InputStream input, byte[] buffer, int offset, int length) |
| static byte[]               | readFully(InputStream input, int length)                     |
| static void                 | readFully(ReadableByteChannel input, ByteBuffer buffer)      |
| static void                 | readFully(Reader input, char[] buffer)R                      |
| static void                 | readFully(Reader input, char[] buffer, int offset, int length) |
| static List<String>         | readLines(InputStream input, Charset encoding)               |
| static List<String>         | readLines(InputStream input, String encoding)                |
| static List<String>         | readLines(Reader input)                                      |
| static byte[]               | resourceToByteArray(String name)                             |
| static byte[]               | resourceToByteArray(String name, ClassLoader classLoader)    |
| static String               | resourceToString(String name, Charset encoding)              |
| static String               | resourceToString(String name, Charset encoding, ClassLoader classLoader) |
| static URL                  | resourceToURL(String name)                                   |
| static URL                  | resourceToURL(String name, ClassLoader classLoader)          |
| static long                 | skip(InputStream input, long toSkip)                         |
| static long                 | skip(ReadableByteChannel input, long toSkip)                 |
| static long                 | skip(Reader input, long toSkip)                              |
| static void                 | skipFully(InputStream input, long toSkip)                    |
| static void                 | skipFully(ReadableByteChannel input, long toSkip)            |
| static void                 | skipFully(Reader input, long toSkip)                         |
| static InputStream          | toBufferedInputStream(InputStream input)                     |
| static InputStream          | toBufferedInputStream(InputStream input, int size)           |
| static BufferedReader       | toBufferedReader(Reader reader)                              |
| static BufferedReader       | toBufferedReader(Reader reader, int size)                    |
| static byte[]               | toByteArray(InputStream input)                               |
| static byte[]               | toByteArray(InputStream input, int size)                     |
| static byte[]               | toByteArray(InputStream input, long size)                    |
| static byte[]               | toByteArray(Reader input, Charset encoding)                  |
| static byte[]               | toByteArray(Reader input, String encoding)                   |
| static byte[]               | toByteArray(URI uri)                                         |
| static byte[]               | toByteArray(URL url)                                         |
| static byte[]               | toByteArray(URLConnection urlConn)                           |
| static char[]               | toCharArray(InputStream is, Charset encoding)                |
| static char[]               | toCharArray(InputStream is, String encoding)                 |
| static char[]               | toCharArray(Reader input)                                    |
| static InputStream          | toInputStream(CharSequence input, Charset encoding)          |
| static InputStream          | toInputStream(CharSequence input, String encoding)           |
| static InputStream          | toInputStream(String input, Charset encoding)                |
| static InputStream          | toInputStream(String input, String encoding)                 |
| static String               | toString(byte[] input, String encoding)                      |
| static String               | toString(InputStream input, Charset encoding)                |
| static String               | toString(InputStream input, String encoding)                 |
| static String               | toString(Reader input)                                       |
| static String               | toString(URI uri, Charset encoding)                          |
| static String               | toString(URI uri, String encoding)                           |
| static String               | toString(URL url, Charset encoding)                          |
| static String               | toString(URL url, String encoding)                           |
| static void                 | write(byte[] data, OutputStream output)                      |
| static void                 | write(byte[] data, Writer output, Charset encoding)          |
| static void                 | write(byte[] data, Writer output, String encoding)           |
| static void                 | write(char[] data, OutputStream output, Charset encoding)    |
| static void                 | write(char[] data, OutputStream output, String encoding)     |
| static void                 | write(char[] data, Writer output)                            |
| static void                 | write(CharSequence data, OutputStream output, Charset encoding) |
| static void                 | write(CharSequence data, OutputStream output, String encoding) |
| static void                 | write(CharSequence data, Writer output)                      |
| static void                 | write(String data, OutputStream output, Charset encoding)    |
| static void                 | write(String data, OutputStream output, String encoding)     |
| static void                 | write(String data, Writer output)<br />将字符串写入到字符输出流中 |
| static void                 | writeChunked(byte[] data, OutputStream output)               |
| static void                 | writeChunked(char[] data, Writer output)                     |
| static void                 | writeLines(Collection<?> lines, String lineEnding, OutputStream output, Charset encoding)<br />将集合中的每个元素转为指定编码的字符串并用默认的行分隔符写到字节输出流 |
| static void                 | writeLines(Collection<?> lines, String lineEnding, OutputStream output, String encoding)<br />将集合中的每个元素转为指定编码的字符串并用指定的行分隔符写到字节输出流 |
| static void                 | writeLines(Collection<?> lines, String lineEnding, Writer writer)<br />将集合中的每个元素转为字符串并用指定的行分隔符写到字符输出流中 |