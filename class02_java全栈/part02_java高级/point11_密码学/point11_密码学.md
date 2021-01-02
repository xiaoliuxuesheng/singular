# 1、码表

- 概述：在计算机内部，所有的信息都表示为一个二进制字符串，每个二进制位称为比特位（bit）有0和1两中状态，每8个bit称为一个字节，由8个bit（0和1）组成的一个字节可以组合出256中状态（`2*2*2*2*2*2*2*2`），把其中的每一种状态都对应到一种字符就形成了码表，所以编程中可以把字符表示的代码翻译为计算机可以识别的二进制；

- 常见的国际码表

  - **ASCii（美国标准信息交换码）**：用一个字节的7位可以表示。所以ASCII码一共规定了128个字符的编码

  - **Unicode（国际标准码表）**：世界上存在着多种编码方式，同一个二进制数字可以被解释成不同的符号。因此，要想打开一个文本文件，就必须知道它的编码方式，否则用错误的编码方式解读，就会出现乱码。可以想象，如果有一种编码，将世界上所有的符号都纳入其中。每一个符号都给予一个独一无二的编码，那么乱码问题就会消失，这就是Unicode。*注意的是，Unicode只是一个符号集，它只规定了符号的二进制代码，却没有规定这个二进制代码应该如何存储*

  - **iso-8859-1（拉丁码表 latin）**：用了一个字节用的8位。把位于128-255之间的字符用于拉丁字母表中特殊语言字符的编码，也因此而得名。ASCII码是包含的仅仅是英文字母，并且没有完全占满256个编码位置，所以它以ASCII为基础，在空置的0xA0-0xFF的范围内，加入192个字母及符号，藉以供使用变音符号的拉丁字母语言使用。从而支持德文，法文等。因而它依然是一个单字节编码，只是比ASCII更全面。

  - **UTF-8**：事实证明，对可以用ASCII表示的字符使用UNICODE并不高效，因为UNICODE比ASCII占用大一倍的空间，而对ASCII来说高字节的0对他毫无用处。为了解决这个问题，就出现了一些中间格式的字符集，他们被称为通用转换格式，即UTF（Universal Transformation Format）。目前存在的UTF格式有：UTF-7, UTF-7.5, UTF-8, UTF-16, 以及 UTF-32

    > UTF-8基于unicode，UTF-8最大的一个特点，就是它是一种变长的编码方式。它可以使用1~4个字节表示一个符号，根据不同的符号而变化字节长度。
    >
    > - 对于单字节的符号，字节的第一位设为0，后面7位为这个符号的unicode码。因此对于英语字母，UTF-8编码和ASCII码是相同的。
    > - 对于n字节的符号（n>1），第一个字节的前n位都设为1，第n+1位设为0，后面字节的前两位一律设为10。剩下的没有提及的二进制位，全部为这个符号的unicode码。

  - **GBK（汉字内码扩展规范）**：由我国自主编写，（GBK即“国标”、“扩展”汉语拼音的第一个字母）目前最常用的中文码表，2万的中文和符号。用两个字节表示，其中的一部分文字，第一个字节开头是1，第二字节开头是0

# 2、URL编码与解码

# 3、Base64

- 概述：Base64不是加密算法，本质上是可读性算法，Base64的目的不是加密代码而是将代码具有可读性；

- Base64规则：Base64是由64个字符组成（大写A-Z、小写a-z、数字0-9、字符+、字符/），

- Base58规则：是在Base64几乎是行减少了几个字符：没有数字0，没有小写字母o，没有大写字母I，没有小写字母i，没有+，没有/；

- Base64原理：Base64首先将字符拆分为三个字节为一组，一个字节8位，总共24位，然后将24位拆分为4组，每一组有6位，因为一个字节是8位，拆分或6位缺两位的高位用0补齐，base64取后6位控制在0-63之间，对应base64规则将字节转换为64个可读性字符，当位数不够的时候用=号补齐；

- 案例演示：

  ```java
  // Java原始API
  
  // Hutool工具包
  ```

# 4、Java String

- toString与new String
  - toString：调用的Object的toString方法，返回的的hash值
  - new String：是根据参数，使用Java虚拟机的的模板编码格式，会把这个字节数组进行decode，找到对应的字符码表进行转换；

# 5、数字摘要

- 数字签名概述：

- 常见数据签名算法

  | 数字签名算法 | 概述 |
  | ------------ | ---- |
  | MD5          |      |
  | SHA-1        |      |
  | SHA-256      |      |
  | SHA-512      |      |

- 案例演示

  ```java
  
  ```

# 6、对称加密

- 对称加密概述：加密方式和解密方式用的是同一把密钥

- 常见的对称加密：

  | 加密方式 | 概述 |
  | -------- | ---- |
  | DES      |      |
  | AES      |      |

- 加密模式

  - ECB：Electron Codebook电子密码本，原理是将需要加密的消费按照块密码的大小分为数个块，并对每个块进行独立加密，特定是同时加密如果原文相同，加密出来的密文也是相同的

    > - 优点：可以并行处理数据
    > - 确定：同样的原文生成同样的密文，不能很好的保护数据

  - CBC：Cipher Block Chaining密码块链接，原理是每个明文块与密文块进行异或后，再进行加密，在这种加密模式中每个密文块都依赖与他前面的所有明文块

    > - 优点：安全系统好
    > - 确定：加密速度慢

- 填充模式

  - noPadding：
  - PKCS5Padding：

- 案例演示

  ```java
  // Java API
  
  // Hutool 工具类
  ```

# 7、非对称加密

- 非对称加密概述：特点是由两把密钥，一把公钥（pubkey）一把私钥（privateKey）；核心原理是如果信息是被公钥加密，则必须使用私钥解密

- 常见非对称加密：

  | 加密方式 | 概述 |
  | -------- | ---- |
  | RSA      |      |
  | ECC      |      |

- 案例演示

  ```java
  // Java API
  
  // Hutool 工具类
  ```

# 8、数字签名

java keytool工具

# 9、jwt

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