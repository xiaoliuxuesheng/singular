# 第一章 网络编程

1. 基本概念
   - 网络中的IP：定位计算机、端口：定义软件、URL：统一资源定位符，用于软件管理的资源
   - 协议：指的是计算机直接交流的规范
     - TCP协议：传输层协议，有去有回，安全面向连接
     - UDP协议：传输层协议，又去不一定有回
     - HTTP协议：网络层协议
   - BS | CS：浏览器交互或客户端交互
2. 网络与通信协议
   - 网络：将不同区域的电脑连接在一起
   - 通讯协议：计算机网络中实现通讯必须有一些约定用于控制通讯规则
   - 通讯接口：为了是两个节点之间能进行对话，使彼此之间能进行信息交换
   - 网络分层：OSI参考模型 -》 TCP/IP参考模型
     1. 网络接口 = 物理层 + 数据链路层
     2. 网络层 + 网络层：IP
     3. 传输层 = 传输层：TCP + UDP
     4. 应用层 = 会话层 + 表示层 + 应用层：TFP、HTTP、DNS、Telnet
   - 数据封装：将协议数据单元封装在一组协议头和协议尾中的过程
     - 应用层：准备数据
     - 传输层：接收应用层数据，并添加上TCP控制信息成为段，然后交给网络层
     - 网络层：阶段段后再添加上IP头部，称为包，然后交给数据链路层
     - 数据链路层：将包再添加上MAC头部和尾部，称为帧，然后将帧交给物理层
     - 物理层：将收到的数据转换为比特流，然后在网络线中传输

# 第二章 常用API

1. IP地址：用来标识网络中的一个通信实体的地址
2. IP地址分类
   - IPV4：32位地址，以点分十进制标识
   - IPV6：128位，写成8个16位无符号整数，每个整数用四个十六进制为表示
   - 本机地址：127.0.0.1
   - 非注册的私有地址：192.168.0.0 ~ 192.168.255.255
3. Java中对IP的封装
   - InetAddress-定位IP
   - InetSocketAddress - IP端口套接字
   - URI：统一资源标识符，用来标识物理资源的字符串
     - URL：统一资源定位符，一种定位资源的主要访问机制的字符串，一个标准的URL = protocol + host + port + path + parameter + anchor
     - URN：统一资源名，通过特定命名空间的唯一名称或ID标识资源
4. 端口：1~ 65535（同一个协议下端口不可冲突）
   - 22：
   - 80：
   - 8080：
   - 1521：
   - 3306：
   - 6379：
5. Java爬虫:

# 第三章 传输协议

## 3.1 UDP

1. UDP：一种无连接的传输层协议，不可靠的信息传输协议，效率高

## 3.2 TCP

1. TCP：

## 3.3 Socket

​		开发的网络应用位于应用层，TCP和UDP属于传输层协议，在应用层是使用套接字Socket进行使用传输层服务，Socket类似是传输层为应用层开启的一个接口，应用程序通过这个接口向远程发送数据或接收数据

★ 基于TCP的socket编程

> 通讯双方需要建立连接，连接建立时双方存在主次之分（必须先建立服务器后客户端才可以连接）

- TCP基本流程
  - 使用基于TCP协议的Socket网络编程实现
  - TCP基于请求-响应模式：在网络通信中，第一次主动发起通讯的程序称为客户端程序Socket，第一次通讯中等待连接的程序称为服务端程序ServerSocket
  - 利用IO流实现数据的传输：客户端的输出流被服务端的输入流接收；客户端的输入流用来接收服务端的输出流
- 

★ 基于UDP的Socket编程

> 通讯双方不需要建立连接，通信双方完全平等

- UDP的特点：传输数据不能太大

- UDP基本概念

  - DatagramSocket：用于发送或接收数据包的套接字
  - DatagramPacket：数据包

- UDP案例

  - 定义消息服务器

    ```java
    public class DatagramServer {
        public static void main(String[] args) throws Exception {
            // 1. 创建接收端
            DatagramSocket socket = new DatagramSocket(6699);
            // 2. 准备容器:封装包
            byte[] bytes = new byte[1024];
            DatagramPacket packet = new DatagramPacket(bytes, bytes.length);
            // 3. 阻塞是接受包
            socket.receive(packet);
            // 4. 分析数据
            byte[] data = packet.getData();
            System.out.println("new String(data) = " + new String(data));
            // 5. 释放资源
            socket.close();
        }
    }
    ```

  - 定义消息客户端

    ```java
    public class DatagramClient {
        public static void main(String[] args) throws Exception {
            // 1. 创建接收端
            DatagramSocket socket = new DatagramSocket(6688);
            // 2. 准备容器:封装包 发送的包需要指定地址
            byte[] bytes = "你好 panda".getBytes();
            DatagramPacket packet = new DatagramPacket(bytes, bytes.length,
                    new InetSocketAddress("localhost",6699));
            // 4. 发送
            socket.send(packet);
            // 5. 释放资源
            socket.close();
        }
    }
    ```

## 3.4 同步与异步

​		同步和异步是针对应用程序和内核的交互而言：同步指的是用户进程触发IO操作并等待或轮询的去查看IO操作是否就绪；异步指的是用户进程触发IO操作后便不在关注IO的执行结果，而当IO操作完成时候回得到完成通知

## 3.5 阻塞非阻塞

​		阻塞和非阻塞是针对于进程在访问数据时候，根据IO操作的就绪状态来采取的不同方式（是一种读取或者写入操作函数的实现方式），阻塞方式下读取或者写入函数将一直等待；非阻塞方式下，读取或写入函数会立即返回一个状态值

# 第四章 BIO编程模型

​		BIO表示Blocking IO：同步阻塞的编程方式

​		编程实现过程：首先在服务端启动一个ServerSocket来监听网络请求，客户端启动Socket发起网络请求，默认情况下ServerSocket会建立一个线程来处理此请求，如果服务端没有线程可用，客户端则会阻塞等待或被拒绝。

- 服务器监听：Socket 和客户端平等的Socket = ServerSocket.acceptor()
- 客户端的请求：new Socket("localhost", 6688);
- 客户端的OutputStream ---> 被服务端的InputStream接收
- 服务端发送的数据OutputStream  --> 由客户端的InputStream接收

★ BIO基本案例

- 服务端

  ```java
  public class TcpServer {
      public static void main(String[] args) throws Exception {
          System.out.println(" Server........ ");
          // 1. 创建ServerSocket
          ServerSocket serverSocket = new ServerSocket(6688);
          // 2. 在Socket上监听客户端的连接请求
          // 3. 阻塞:等待连接点建立
          Socket client = serverSocket.accept();
          System.out.println(LocalDateTime.now() + " 一个客户端建立了连接 ");
          // 4. 接收并处理请求消息
          InputStream stream = client.getInputStream();
          DataInputStream inputStream = new DataInputStream(stream);
          String msg = inputStream.readUTF();
          System.out.println("客户端连接后写入到OutputStream的消息 = " + msg);
          // 5. 将处理结果返回给客户端
  //        OutputStream outputStream = client.getOutputStream();
  //        outputStream.write("我是服务端,消息已收到".getBytes());
          // 6. 关闭流和Socket对象
          client.close();
      }
  }
  ```

- 客户端

  ```java
  public class TcpClient01 {
      public static void main(String[] args) throws Exception {
          System.out.println(" Client.... ");
          // 1. 创建Socket对象
          // 2. 想服务器发送连接请求
          Socket socket = new Socket("localhost", 6688);
          // 3. 向服务器发送服务请求
          OutputStream outputStream = socket.getOutputStream();
          DataOutputStream data = new DataOutputStream(outputStream);
          data.writeUTF("从客户端写入到输出流的数据");
          // 4. 接收服务结果
          // 5. 关闭流和Socket对象
          socket.close();
      }
  }
  ```

# 第五章 NIO编程模型

​		NIO表示UnBLocking IO：同步非阻塞的编程方式

​		NIO是采用基于事件驱动的思想完成的，主要是解决了BIO的大并发问题，NIO是基于Reactor，当Socket有流可读或写入socket时候，操作系统会通知应用程序进行处理，应用再将流读取或写入到缓冲区或操作系统，NIO模型下不再是一个连接处理一个请求了，而是一个有效的请求对应一个线程，当没有数据时候是没有工作线程处理

★ Buffer的固定逻辑

- 写操作
  1. clear()：情况
  2. put()：写操作
  3. flip()：重置游标
  4. SocketChannel.write(buffer)：将缓存数据发送到网络的另一端
  5. clear()
- 读操作
  1. clear()
  2. SocketChannel.read()：从网络中读取数据，返回是否有数据
  3. flip()：重置游标，有数据表示position有值
  4. get()：读取数据，重置position后开始读取
  5. clear()：读取完后再将缓存数据重置

# 第六章 AIO编程模型

# 第七章 Netty

