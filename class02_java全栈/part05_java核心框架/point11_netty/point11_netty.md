★ 基本介绍

- 学前基础:需要掌握Java编程;Java网络;JavaIO;Java多线程;常用设计模式;常用数据结构

★ Netty是什么

- JBOSS提供的Java框架，是一个异步的、基于事件驱动的网络应用框架，快速开发高性能、高可用网络程序
- 针对TCP协议下，使用原生Socket 被 NIO包装， Netty基于NIO的框架
- netty本质是一个NIO框架，适用于服务器通讯

★ Netty应用场景

- 服务器之间远程过程调用，高性能的请求方式

★ IO模型：指用什么样的通道进行数据的接受和发送

- java支持三种javaIO模型：BIO（传统IO）、NIO（同步非阻塞）、AIO（异步非阻塞）

★ BIO

- 介绍：就是传统的JavaIO，相关类在java.io包，编程简单流程是指每个请求都会创建线程指定一个socket链接对服务器进行通讯，等待响应，有响应后才会结束

- 代码演示：监听端口

  ```java
  ServerSocket serverSocket = new ServerSocket(6666);
  Socket socket = serverSocket.accept();
  ```

- 处理客户端请求数据

  ```java
  private static void handler(Socket socket) {
      try {
          InputStream inputStream = socket.getInputStream();
          int len = -1;
          byte[] buffer = new byte[1024];
          while ((len = inputStream.read(buffer)) != -1) {
              System.out.print(new String(buffer));
          }
      }catch (Exception e){
          e.printStackTrace();
      }finally {
          socket.close();
      }
  }
  ```


★ NIO

- NIO基本介绍:① 是对JDK原生IO的改进,在java.nio包中③NIO中有三大核心:Channel-通道完成读和写;Buffer-缓冲区;Selector-选择器,NIO是面试缓冲区或者面向块编程的,Java程序是和缓存区进行交互的

  1. 每个channel都会对应一个buffer
  2. Selector对应一个线程,一个线程对应多个channel(链接)
  3. Channel需要注册到Selector
  4. 程序切换到哪个channel是由事件决定的,Event是事件
  5. Selector会根据不同的事件在各个通道上切换
  6. Buffer本质就是给内存块,是由一个数组组成
  7. 数据的读取和写入都是通过Buffer,Buffer是可以读也可以写,但是读写需要切换
  8. Channel 是双向的:可以返回底层操作系统的情况

- NIO的非阻塞模式:一个线程从某个通道发送或读取数据,它仅能得到目前可用的数据,如果目前没有可用数据,就什么也得不到,而不是保存线程阻塞

- buffer案例

  ```java
  public static void main(String[] args) {
      IntBuffer buffer = IntBuffer.allocate(12);
  
      for (int i = 0; i < 12; i++) {
          buffer.put(i*3);
      }
  	// 读写切换
      buffer.flip();
  
      while (buffer.hasRemaining()){
          System.out.println("buffer = " + buffer.get());
      }
  }
  ```

  > BIO以流的方式处理,基于字节流和字符流,NIO是基于Channel和Buffer进行操作,数据总社从通道读取到缓存区中,从缓存区中写入到通道找那个,Selectot用于监听多个通道事件.

★ 缓存区Buffer

- buffer本质是一个可以读写数据的内存块(容器对象),该对象提供了一种方法,可以轻松的使用内容块,并且内置一下机制可跟踪和记录缓冲区的状态变化情况
- Buffer类及其子类:除Boolean的八大数据数据类型,用的最多的是ByteBuffer
  - mark = 标记
  - Capacity = 容量,可以容纳的最大数据量
  - Limit = 表示缓冲区的当前终点,
  - Position = 位置,表示下一个要被读或者写的元素索引

★Netty

1. NIO存在的问题

   - 类库和API繁杂
   - 对网络编程、多线程的基础技术要求比较包，需要熟练才能写出高质量的NIO
   - 原生的NIO会存在BUG

2. Netty介绍优点

   - 对JDK自带的NIO进行了封装，
   - 设计优雅：适用于各种传输类型，统一的API阻塞和非阻塞socket，灵活且可扩展的事件模型
   - 使用方便：没有其他依赖项，只有Java原生API即可
   - 安全：完整的SSl|TLS
   - 社区活跃，更新快

3. Netty结构设置

   - 线程模型基本介绍
     - ① 传功阻塞IO服务模型:采用阻塞IO模式获取和输入数据,每个连接都需要独立的线程完成数据处理
     - ② Reactor模式：反应器模式;对IO进行改进,使用IO复用模型,多个连接公用一个阻塞对象
       - 单Reactor单线程 :一个Reactor进行处理转发
       - 单Reactor多线程 :accept只处理连接请求,Handler只处理请求,分发给线程池,由线程池处理并返回结果到Handler,最后有Handler返回给客户端
       - 主从Reactor多线程 - 主Reactor值处理连接请求,处理请求交给子Reactor
     - ③ Netty模式:主要基于Reactor多线程模型的改进,其中主从Reactor对个多线程模型有多个Reactor

4. Netty模型 简单版

   - 客户端请求 -> BoseGroup(selector + accept) -> SocetChannel -> NIOSocketChannel -注册>WorkerGroup.selector -> Handler

5. Netty模进阶版

   - 抽象出两组线程池,BoseGroup接受客户端连接,WorkerGroup负责网络读写
   - BossGroup和WorerGroup类型都是NioEventLoopGroup
   - NioEventLoopGroup相当于一个事件循环组,这个组中含有多个事件循环,每个循环是NioEventLoop
   - NioEventLoop表示一个不断循环的处理任务的线程,每个NioEventLoop都有一个Selector用于监听绑定在其上的socket网络通信
   - NioEventLoopGroup可以有对个线程表示可以含有多个NioEventLoop
   - BossGroup执行步骤有三步
     - 轮询assept事件
     - 处理accept事件,与client建立连接,生成NioSocketChannel,并将其注册到worker NIOEventLoop上的selector上
     - 处理任务队列的任务:runAllTasks
   - worker NIOEventLoop执行步骤
     - 轮询read.write事件
     - 处理io事件,在对应的NioSocketChannel处理
     - 处理任务队列的任务,runAllTasks
   - 每个worker NIOEventLoop处理业务时,会使用pipline观点,pipeline包含的channel,维护了很多处理器

6. Netty实例项目:netty服务器监听6688端口,客户端给服务器发消息,服务器可以返回给客户端消息

   - 定义服务端

     ```java
     public class NettyServer {
     
         public static void main(String[] args) throws InterruptedException {
     
                 // 1. BoseGroup 只处理连接请求
                 NioEventLoopGroup bossgroup = new NioEventLoopGroup();
                 // 2. WorkerGroup 处理器
                 NioEventLoopGroup workerGroup = new NioEventLoopGroup();
     
             try {
                 // 创建服务端启动对象 配置参数
                 ServerBootstrap bootstrap = new ServerBootstrap();
                 // 配置
                 bootstrap.group(workerGroup, workerGroup)       //  设置两个线程组
                         .channel(NioServerSocketChannel.class)   // 通道的实现
                         .option(ChannelOption.SO_BACKLOG, 128) // 设置连接个数
                         .childOption(ChannelOption.SO_KEEPALIVE, true)    // 保持连接
                         .childHandler(new ChannelInitializer<SocketChannel>() {
                             // 给pipeline设置处理器
                             @Override
                             protected void initChannel(SocketChannel ch) throws Exception {
                                 ch.pipeline().addLast(new NettyServerHandler());
                             }
                         }); // 给我们的workergroup 的eventloop对应的观点设置处理器
     
                 System.out.println(" 服务器完成 ");
                 // 绑定并启动
                 ChannelFuture sync = bootstrap.bind(6688).sync();
     
                 // 对关闭通道进行箭筒
                 sync.channel().closeFuture().sync();
             }finally {
                 bossgroup.shutdownGracefully();
                 workerGroup.shutdownGracefully();
             }
         }
     }
     
     ```

   - 定义服务端处理器

     ```java
     public class NettyServerHandler extends ChannelInboundHandlerAdapter {
     
     
         /**
          * 读取数据
          *
          * @param ctx 上下文对象 包含观点pipeline 通道 channel 地址
          * @param msg 客户端发送的消息
          * @throws Exception
          */
         @Override
         public void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
             System.out.println("ctx = " + ctx);
             // 将msg转为ByteBuffer 是netty提供的ByteBuf
             ByteBuf buf = (ByteBuf) msg;
             System.out.println("buf.toString(CharsetUtil.UTF_8) = " + buf.toString(CharsetUtil.UTF_8));
             System.out.println("ctx = " + ctx.channel().remoteAddress());
         }
     
         /**
          * 数据读取完毕
          * @param ctx
          * @throws Exception
          */
         @Override
         public void channelReadComplete(ChannelHandlerContext ctx) throws Exception {
             // writeAndFlush = write + flush 数据写入并刷新
             ctx.writeAndFlush(Unpooled.copiedBuffer("hello 客户端", CharsetUtil.UTF_8));
         }
     
         /**
          * 处理异常
          * @param ctx
          * @param cause
          * @throws Exception
          */
         @Override
         public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
             ctx.close();
     
         }
     }
     ```

   - 定义客户端

     ```java
     public class NettyClient01 {
         public static void main(String[] args) throws InterruptedException {
             // 一个事件循环组
             NioEventLoopGroup eventExecutors = new NioEventLoopGroup();
     
             try {
                 // 创建客户端启动对象 客户端是BootStrap
                 Bootstrap bootstrap = new Bootstrap();
                 // 设置相关参数
                 bootstrap.group(eventExecutors) // 设置线程组
                         .channel(NioSocketChannel.class) // 设置客户端通道
                         .handler(new ChannelInitializer<SocketChannel>() {
                             @Override
                             protected void initChannel(SocketChannel socketChannel) throws Exception {
                                 socketChannel.pipeline().addLast(new NettyClient01Handler());
                             }
                         });
                 System.out.println(" 客户端完成 ");
     
                 ChannelFuture sync = bootstrap.connect("127.0.0.1", 6688).sync();
                 sync.channel().closeFuture().sync();
             } finally {
                 eventExecutors.shutdownGracefully();
             }
     
         }
     }
     ```

   - 定义客户端处理器

     ```java
     public class NettyClient01Handler extends ChannelInboundHandlerAdapter {
     
         /**
          * 通道就绪就会触发
          * @param ctx
          * @throws Exception
          */
         @Override
         public void channelActive(ChannelHandlerContext ctx) throws Exception {
             System.out.println("ctx = " + ctx);
             ctx.writeAndFlush(Unpooled.copiedBuffer("猫叫了一声", CharsetUtil.UTF_8));
         }
     
         /**
          * 通道读取会触发
          * @param ctx
          * @param msg
          * @throws Exception
          */
         @Override
         public void channelRead(ChannelHandlerContext ctx, Object msg) throws Exception {
             ByteBuf byteBuf = (ByteBuf) msg;
             System.out.println("byteBuf.toString(CharsetUtil.UTF_8) = " + byteBuf.toString(CharsetUtil.UTF_8));
             System.out.println("ctx = " + ctx.channel().remoteAddress());
         }
     
         @Override
         public void exceptionCaught(ChannelHandlerContext ctx, Throwable cause) throws Exception {
             ctx.close();
         }
     }
     ```

7. 源码分析:

   - bossGroup和workGroup的子线程数量模式是和主机CPU的核数的两倍,可以手动指定

★ Netty任务队列:NioEventGroup中的TaskQueue, 话费时间长久的操作

- 用户程序自定义定时普通任务
- 用户自定义定时任务
- 非当前Reactor线程调用Channel各种方法

★ 异步模型原理

- 一个异步过程调用后,调用者不能立刻得到结果,知己处理这个调用的组件完成后,通过状态,通知和回调通知调用者,netty中的Bind Write Connecthi返回一个ChannelFuture
- Netty的异步模型是建立在future和callback之上的,callback就是回调, Future核心:一个方法在执行时候回立即返回一个Future,后续可以去监控方法的处理过程,Future表示异步的执行结果,