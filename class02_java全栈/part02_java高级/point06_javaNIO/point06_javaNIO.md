# 第一章 JavaNIO介绍

## 1.1 基本概念

- NIO是对JDK原生IO的改进，在java.nio包中，NIO是面试缓冲区或者面向块编程的,Java程序是和缓存区进行交互的
- NIO中有三大核心：①Channel-通道完成读和写 ②Buffer-缓冲区 ③Selector-选择器
  1. 每个channel都会对应一个buffer
  2. Selector对应一个线程,一个线程对应多个channel(链接)
  3. Channel需要注册到Selector
  4. 程序切换到哪个channel是由事件决定的,Event是事件
  5. Selector会根据不同的事件在各个通道上切换
  6. Buffer本质就是给内存块,是由一个数组组成
  7. 数据的读取和写入都是通过Buffer,Buffer是可以读也可以写,但是读写需要切换
  8. Channel 是双向的:可以返回底层操作系统的情况

- NIO的非阻塞模式:一个线程从某个通道发送或读取数据,它仅能得到目前可用的数据,如果目前没有可用数据,就什么也得不到,而不是保存线程阻塞

## 1.2 Buffer

1. Buffer基本介绍

   ​		缓冲区本质上是一个可以读写数据的内存块（数组容器），并且提供了操作内存块的相关API，Channel提供从文件或网络读取数据的渠道

2. Buffer的简单案例：Buffer包含了除了Boolean的七大数据类型的Buffer

   ```java
   public static void main(String[] args) {
       IntBuffer buffer = IntBuffer.allocate(12);
   
       for (int i = 0; i < 12; i++) {
           buffer.put(i*3);
       }
   	// 读写切换，重置Buffer中元素指针位置
       buffer.flip();
   
       while (buffer.hasRemaining()){
           System.out.println("buffer = " + buffer.get());
       }
   }
   ```

   > BIO以流的方式处理,基于字节流和字符流,NIO是基于Channel和Buffer进行操作,数据总社从通道读取到缓存区中,从缓存区中写入到通道找那个,Selectot用于监听多个通道事件.

3. Buffer对象相关属性说明

   | 属性名   | 作用                                               |
   | -------- | -------------------------------------------------- |
   | capacity | 容量：表示可以容纳的最大数据量                     |
   | limit    | 表示缓冲区的当前终点：不能对超过极限的位置进行读写 |
   | position | 位置：标记了下一个被度或者写的元素的索引           |
   | mark     | 标记                                               |

4. Buffer相关API

   - Buffer实例化

     | 方法 | 说明 |
     | ---- | ---- |
     |      |      |

   - Buffer相关API

     | 方法名称 | 说明 |
     | -------- | ---- |
     |          |      |

5. ByteBuffer：字节缓存区，使用最多的缓冲区

   | 方法名称 | 说明 |
   | -------- | ---- |
   |          |      |

## 1.3 Channel

1. 基本介绍

   ​		通道可以同时读写；通道可以实现异步读写数据从Buffer；Channel是NIO中的一个接口，常用的Channel类有**①FileChannel**-操作文件的**②DatagramChannel**用于UDP数据的处理

   **③ServerSocketChannel** - 相当于ServerChannel服务端的Channel,会对应一个客户端的SocketChannel**④SocketChannel** - 类似Socket,用在客户端的

2. FileChannel相关API

   | 方法                                | 说明                           |
   | ----------------------------------- | ------------------------------ |
   | read(ByteBuffer b)                  | 从通道读取数据并放到缓存区     |
   | write(ByteBuffer b)                 | 把缓冲区数据写到通道中         |
   | transferFrom(src, position, count)  | 从目标通道中赋值数据到当前通道 |
   | transferTo(position, count, target) | 把数据从当前通道赋值给目标通道 |

3. FileChannel的相关操作步骤

   - 首先用Channel包装基本的IO流

     ```java
     FileOutputStream stream = new FileOutputStream("FileChannel.txt");
     FileChannel channel = stream.getChannel();
     ```

   - 将数据保存进Buffer

     ```java
     ByteBuffer byteBuffer = ByteBuffer.allocate(1024);
     
     // 写入
     byteBuffer.put(sstring.getBytes());
     ```

   - channel要读取Buffer中的数据需要将Buffer反转

     ```java
     byteBuffer.flip();
     ```

   - FileChannel从Buffer中获取写的数据并完成写出

     ```java
     channel.write(byteBuffer);
     ```

4. Buffer和Channel注意事项

   - ByteBuffer支持类型化的put和get：需要保证写入和读取的类型一致

   - 可以将普通Buffer转为只读Buffer

     ```java
     ByteBuffer asReadOnlyBuffer = buffer.asReadOnlyBuffer();
     ```

   - NIO提供了MappingedByteBuffer,可以让文件直接在内存中进行修改

     ```java
     FileChannel inChannel = in.getChannel();
     MappedByteBuffer map = inChannel.map(FileChannel.MapMode.READ_WRITE, 0, 5);
     map.put(0, (byte) 'H');
     ```

   - NIO支持通过多个Buffer完成读写操作

