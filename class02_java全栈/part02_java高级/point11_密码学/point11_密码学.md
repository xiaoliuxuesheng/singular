**密码学**

- 编制密码和破译密码的学科：主要作用是研究如何隐藏信息并把信息传递出去的

**密码学体系**

- 古典密码学
  - 加密
    - 替换法：单表替换、多表替换
    - 移位法：凯撒加密，按照字母表中位置位移
  - 破译
    - 频度分析法
- 近代密码学：**恩尼格玛机**：加密更复杂，被图灵破解
  - 替换法
  - 移位法：ASCII码表：美国信息交换标准代码，根据字符的码表中的值进行移位
- 现代密码学：
  - 散列函数：MD5、SHA1、SHA-256、SHA-512
  - 对称加密：加密方式和解密方式用的是同一把密钥
    - 对称加密核心原理：流加密、块加密
      - 流加密：对信息中的每个元素（一个字母或一个比特）作为基本单位进行处理
      - 块加密：是先对信息流分块，然后对每一块进行加密
    - 加密模式：DES加密解密、AES加密解密；
    - 
  - 非对称加密：特点是由两把密钥，一把公钥（pubkey）一把私钥（privateKey）；核心原理是如果信息是被公钥加密，则必须使用私钥解密
    - RSA算法、ECC算法
  - 数字签名
    - 数字摘要：BASE64模式、BAS64原理
    - 数字签名和数字证书
    - java keytool工具
  - 其他
    - 
    - toString()和new String()
    - 加密模式：ECB、CBC
    - 填充模式：noPadding、PKCS5Padding

  1. 字符编码表的发展

     - 最早只有127个字母被编码到计算机里，也就是大小写英文字母、数字和一些符号，这个编码表被称为ASCII编码；

       > ASCII 只有127个字符，表示英文字母的大小写、数字和一些符号，但由于其他语言用ASCII 编码表示字节不够

     - 但是要处理中文显然一个字节是不够的，至少需要两个字节，而且还不能和ASCII编码冲突，所以，中国制定了GB2312编码，用来把中文编进去，全世界有上百种语言，日本把日文编到Shift_JIS里，韩国把韩文编到Euc-kr里，各国有各国的标准，就会不可避免地出现冲突，结果就是，在多语言混合的文本中，显示出来会有乱码。因此，Unicode应运而生。Unicode把所有语言都统一到一套编码里，这样就不会再有乱码问题了。

       > 由于每个国家的语言都有属于自己的编码格式，在多语言编辑文本中会出现乱码，这样Unicode应运而生，Unicode就是将这些语言统一到一套编码格式中，通常两个字节表示一个字符，而ASCII是一个字节表示一个字符，这样如果你编译的文本是全英文的，用Unicode编码比ASCII编码需要多一倍的存储空间，在存储和传输上就十分不划算

     - Unicode标准也在不断发展，但最常用的是用两个字节表示一个字符（如果要用到非常偏僻的字符，就需要4个字节）。现代操作系统和大多数编程语言都直接支持Unicode。新的问题又出现了：如果统一成Unicode编码，乱码问题从此消失了。但是，如果你写的文本基本上全部是英文的话，用Unicode编码比ASCII编码需要多一倍的存储空间，在存储和传输上就十分不划算。所以，本着节约的精神，又出现了把Unicode编码转化为“可变长编码”的UTF-8编码。UTF-8编码把一个Unicode字符根据不同的数字大小编码成1-6个字节，常用的英文字母被编码成1个字节，汉字通常是3个字节，只有很生僻的字符才会被编码成4-6个字节。如果你要传输的文本包含大量英文字符，用UTF-8编码就能节省空间。UTF-8编码有一个额外的好处，就是ASCII编码实际上可以被看成是UTF-8编码的一部分，所以，大量只支持ASCII编码的历史遗留软件可以在UTF-8编码下继续工作。

       > 为了解决上述问题，又出现了把Unicode编码转化为“可变长编码”UTF-8编码，UTF-8编码将Unicode字符按数字大小编码为1-6个字节，英文字母被编码成一个字节，常用汉字被编码成三个字节，如果你编译的文本是纯英文的，那么用UTF-8就会非常节省空间，并且ASCII码也是UTF-8的一部分。s

     - 搞清楚了ASCII、Unicode和UTF-8的关系，我们就可以总结一下现在计算机系统通用的字符编码工作方式：(1) 在计算机内存中，统一使用Unicode编码，当需要保存到硬盘或者需要传输的时候，就转换为UTF-8编码。（2）用记事本编辑的时候，从文件读取的UTF-8字符被转换为Unicode字符到内存里，编辑完成后，保存的时候再把Unicode转换为UTF-8保存到文件。如下图（截取他人图片）

  2. UrlEncoding

  3. 对称加密

     - des
     - aes

  4. Base64原理

  5. 消息摘要、数字摘要、散列函数

     - md5
     - sha1
     - sha256
     - sha512

  6. 对称加密

     - rsa

  7. 数字签名

  8. jwt

     - 令牌组成【Header.Payload.Signature】

       -  Header:json字符串格式的标头,记录了jwt的加密方式，是base64编码后的字符串

         ```json
         {
             "typ":"JWT",	   // 表示这个令牌（token）的类型（type），JWT 令牌统一写为JWT。
             "alg":"签名方法"	// 表示签名的算法（algorithm），默认是 HMAC SHA256（写成 HS256）
         }
         ```

       -  Payload:json字符串的载荷，记录是jwt中保存的数据，是base64编码后的字符串

         ```json
         {
         	"自定义Key":"自定义Value",
             ... ...
         }
         ```

       - Signature:用Header对Payload的签名，是使用编码后的Header和Payload以及提供的秘钥，然后使用Header中提供的算法进行签名，签名的作用是保证jwt无法被篡改

     - 各种jwt库

       - Auth0实现 的 java-jwt:Auth0提供的JWT库简单实用, 依赖第三方(如JAVA运行环境)提供的证书信息(keypair)
       - Brian Campbell实现的 jose4j:完整的JWT实现, 可以不依赖第三方提供的证书信息(keypair, 库本身自带有RSA的实现),类定义与JWT协议规定匹配度高,易理解与上手,对称加密与非对称加密都有提供实现
       - connect2id实现的 nimbus-jose-jwt:定义清晰,简单易用,易理解 , 依赖第三方提供的证书信息(keypair), 对称算法 与非对称算法皆有实现.
       - Les Haziewood实现的 jjwt:jjwt小巧够用, 但对JWT的一些细节包装不够, 比如 Claims (只提供获取header,body)
       - Inversoft实现的prime-jwt:有些地方不符合JAVA语言规范, 支持对称算法(HMAC) 与非对称算法(RSA), 也算容易理解
       - Vertx实现的vertx-auth-jwt: 算是最不容易理解的一个库了.花了不少时间才弄通这一示例. 不容易上手. 并且生成与校验id_token 时都需要公钥与私钥,不足.

     - jjwt

       - 依赖

         ```xml
         <dependency>
             <groupId>io.jsonwebtoken</groupId>
             <artifactId>jjwt</artifactId>
             <version>0.9.1</version>
         </dependency>
         ```

       - Token及验签

         ```java
         @Test
         public void testJJwt() throws Exception {
             //这里其实就是new一个JwtBuilder，设置jwt的body
         	JwtBuilder builder = Jwts.builder() 
                 // 如果有私有声明，一定要先设置这个自己创建的私有的声明，这个是给builder的claim赋值，一旦写在标准的声明赋值之后，就是覆盖了那些标准的声明的
                 .setClaims(claims)
                 //设置jti(JWT ID)：是JWT的唯一标识，根据业务需要，这个可以设置为一个不重复的值，主要用来作为一次性token,从而回避重放攻击。
                 .setId(jwtId)
                 //iat: jwt的签发时间
                 .setIssuedAt(now)
                 //设置签名使用的签名算法和签名使用的秘钥
                 .signWith(signatureAlgorithm, secretKey);
             System.out.println(token);
         
             //得到DefaultJwtParser
             String user = Jwts.parser()
                 // 设置签名的秘钥
                 .setSigningKey("MyJwtSecret")
                 // 解析token
                 .parseClaimsJws(token.replace("Bearer ", ""))
                 // 获取载荷
                 .getBody()
                 .getSubject();
             System.out.println(user);
         }
         ```

     - java-jwt

       - 依赖

         ```xml
         <dependency>
             <groupId>com.auth0</groupId>
             <artifactId>java-jwt</artifactId>
             <version>3.8.3</version>
         </dependency>
         ```

       - Token及验签

         ```java
         // 使用 java-jwt 生成jwt
                 Map<String, Object> header = new HashMap<>();
                 Calendar calendar = Calendar.getInstance();
                 calendar.add(Calendar.SECOND, 20);
                 String sign = JWT.create()
                         .withHeader(header)
                         .withClaim("name", "张三")
                         .withClaim("age", 23)
                         .withExpiresAt(calendar.getTime())
                         .sign(Algorithm.HMAC256("@$!@%WER!FSEW"));
         // 使用 java-jwt 验签
             DecodedJWT verify = JWT.require(Algorithm.HMAC256("@$!@%WER!FSEW")).build()
                             .verify(sign);
         ```

     - 