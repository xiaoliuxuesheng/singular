# 第一章 密码学基础

## 1.1 密码学的发展历史简介

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>密码学的发展史共经历了三个阶段：①手工加密阶段、②机械加密阶段、③计算机加密阶段。手工加密阶段最为漫长，期间孕育了古典密码，这为后期密码学的发展奠定了基础。机械工业革命发展的同时促进着各种科学技术的进步，密码学也不例外。加之两次世界大战，更加促进了密码学的飞速发展，密码学由此进入现代密码学阶段。尽管如此，在这一阶段的密码学仍旧未能摆脱古典密码学的影子，加密与解密操作均依赖于语言学的支持，转轮密码机Enigma的发明与破解更是将这一特点发挥到了极致。随着数据理论逐步介入，密码学逐渐成为一门学科，而非一门艺术。进入计算机加密阶段后，密码学应用不再局限于军事、政治和外交领域，逐步扩大到商务、金融和社会的其他领域。密码学的研究和应用已大规模扩展到了民用方面。

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>密码学主要包含两个分支：密码编码学和密码分析学。密码编码学针对于信息如何隐藏；密码分析学针对于信息如何破译。编码学与分析学相互影响，共同促进密码学的发展。

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>古典密码是现代密码的基础，移位和替代是古典密码最常用、最核心的两种加密技巧。由此，古典密码主要分为移位密码和替代密码。例如，凯撒密码就是替代密码的典范。替代密码其分支众多，包含单表替代密码、同音替代密码、多表替代密码和多字母替代密码。移位和替代技巧仍是现代密码学最常用的两种加密手段。

## 1.2 现代密码学的柯克霍夫原则

1. 即使非数学上不可破解，系统也应在实质（应用）程度上无法破解。
2. 系统内不应含任何机密物，即使落入敌人手中也不会造成困扰。
3. 密钥必须易于沟通和记忆，而无需写下，且双方可以很容易地改变密钥。
4. 系统应可以用于电讯。
5. 系统应可以携带，不应需要两个人或两个人以上才能使用（应只要一个人就能使用）。
6. 系统应容易使用，不致让使用者的脑力过分操劳，也无须记得长串的规则。

## 1.3 密码体制划分

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>从密码体制上划分，现代密码学工分为两种密码体制：*对称密码体制和非对称密码体制*。对称与非对称的差别源于加密密钥和解密密钥是否对称，即加密密钥与解密密钥是否相同（对称）。

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>在对称密码体制中，加密与解密操作使用相同的密钥，我们把这个密钥称为秘密密钥。DES、AES算法都是常用的对称密码算法。流密码实现简单，对环境要求低，适用于手机平台的加密，广泛应用于军事、外交领域。RC4算法就是典型的流密码算法。流密码的理论、算法受限于国家安全因素未能公布。分组密码在这一点上与流密码恰恰相反，其理论，算法公开，分类众多。DES、AES算法主要的对称密码算法均属于分组密码。分组密码共有5中工作模式：电子密码本模式（ECB）、密文链接模式（CBC）、密文反馈模式（CFB）、输出反馈模式（OFB）、计数器模式（CTR）。分组密码会产生短块，关于短块的处理方法有填充法、流密码加密法、密文挪用技术。

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>在非对称密码体制中，加密与解密操作使用不同的密钥。对外公开的密钥，称为公钥；对外保密的密钥，称为私钥。用公钥加密的数据，只能用私钥解密；反之，用私钥加密的数据，只能用公钥解密。RSA算法是常用的非对称密码算法。非对称密码体制同时支持数字签名技术，如RSA、DSA都是常用的数字签名算法。

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>散列函数可以有效地确保数据完整性，其是一项消息认证技术。常用的散列函数算法有MD5、SHA、Mac。散列函数也是数字签名技术中最重要的技术环节。数字签名离不开非对称密码体制，其私钥用于签名，公钥用于验证。基于数字签名的不可伪造性，数字签名技术成为5种安全服务中数据完整性服务、认证性服务和抗否认性服务的核心技术。通信双方只有一方提供数字签名的认证方式称为单向认证，通信双方都提供数字签名的认证方式称为双向认证。一般网银系统多采用单向认证方式，而要求较高的网银交易则都采用双向认证方式。

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>PKI和PGP是现代网络安全技术领域的两把锁。目前电子商务、电子政务使用PKI技术来确保平台安全性。PGP则多用于电子邮件、文件等的数据签名与加密。

## 1.4 ASCII码与字符编码表

1. **字符编码表概述**：在计算机内部，所有的信息都表示为一个二进制字符串，每个二进制位称为比特位（bit）有0和1两中状态，每8个bit称为一个字节，由8个bit（0和1）组成的一个字节可以组合出256中状态（`2*2*2*2*2*2*2*2`），把其中的每一种状态都对应到一种字符就形成了字符编码映射表，所以编程中可以把字符表示的代码翻译为计算机可以识别的二进制；

2. **常见的国际码表**

   - **ASCii（美国标准信息交换码）**：用一个字节的7位可以表示。所以ASCII码一共规定了128个字符的编码

   - **Unicode（国际标准码表）**：世界上存在着多种编码方式，同一个二进制数字可以被解释成不同的符号。因此，要想打开一个文本文件，就必须知道它的编码方式，否则用错误的编码方式解读，就会出现乱码。可以想象，如果有一种编码，将世界上所有的符号都纳入其中。每一个符号都给予一个独一无二的编码，那么乱码问题就会消失，这就是Unicode。*注意的是，Unicode只是一个符号集，它只规定了符号的二进制代码，却没有规定这个二进制代码应该如何存储*

   - **iso-8859-1（拉丁码表 latin）**：用了一个字节用的8位。把位于128-255之间的字符用于拉丁字母表中特殊语言字符的编码，也因此而得名。ASCII码是包含的仅仅是英文字母，并且没有完全占满256个编码位置，所以它以ASCII为基础，在空置的0xA0-0xFF的范围内，加入192个字母及符号，藉以供使用变音符号的拉丁字母语言使用。从而支持德文，法文等。因而它依然是一个单字节编码，只是比ASCII更全面。

   - **UTF-8**：事实证明，对可以用ASCII表示的字符使用UNICODE并不高效，因为UNICODE比ASCII占用大一倍的空间，而对ASCII来说高字节的0对他毫无用处。为了解决这个问题，就出现了一些中间格式的字符集，他们被称为通用转换格式，即UTF（Universal Transformation Format）。目前存在的UTF格式有：UTF-7, UTF-7.5, UTF-8, UTF-16, 以及 UTF-32

     > UTF-8基于unicode，UTF-8最大的一个特点，就是它是一种变长的编码方式。它可以使用1~4个字节表示一个符号，根据不同的符号而变化字节长度。
     >
     > - 对于单字节的符号，字节的第一位设为0，后面7位为这个符号的unicode码。因此对于英语字母，UTF-8编码和ASCII码是相同的。
     > - 对于n字节的符号（n>1），第一个字节的前n位都设为1，第n+1位设为0，后面字节的前两位一律设为10。剩下的没有提及的二进制位，全部为这个符号的unicode码。

   - **GBK（汉字内码扩展规范）**：由我国自主编写，（GBK即“国标”、“扩展”汉语拼音的第一个字母）目前最常用的中文码表，2万的中文和符号。用两个字节表示，其中的一部分文字，第一个字节开头是1，第二字节开头是0

## 1.5 Base64与Base58

1. **Base64**

   - 概述：Base64不是加密算法，本质上是可读性算法，Base64的目的不是加密代码而是将二进制数据具有可读性；

   - 原理：Base64是由64个字符组成（大写A-Z、小写a-z、数字0-9、字符+、字符/），Base64首先将字符拆分为三个字节为一组，一个字节8位，总共24位，然后将24位拆分为4组，每一组有6位，因为一个字节是8位，拆分或6位缺两位的高位用0补齐，base64取后6位控制在0-63之间，对应base64规则将字节转换为64个可读性字符，当位数不够的时候用=号补齐；

   - Java案例

     ```java
     // Java 8的java.util套件中，新增了Base64的类别
     Base64.Decoder decoder = Base64.getDecoder();
     Base64.Encoder encoder = Base64.getEncoder();
     
     String encodedText = encoder.encodeToString(textByte);
     byte[] decodeByte = decoder.decode(encodedText);
     
     // Hutool工具包
     String encode = Base64Encoder.encode("encodeText");
     String decodeStr = Base64Decoder.decodeStr(encode);
     ```

2. **Base58**：由于Base64字符中的部分字母和数字相似度太高，在外观上对可读性仍较低，所以Base58在Base64的基础上减少了6个字符：①数字0、②大写字母O，③大写字母I，④小写的字母l、⑤加号+，⑥斜杠/，Base58是采用我们数学上经常使用的进制转换方法——辗转相除法；

## 1.6 new String原理

- 是根据参数，使用Java虚拟机的的模板编码格式，会把这个字节数组进行decode，找到对应的字符码表进行转换；

# 第二章 现代加密算法

## 2.1 数字摘要

### 1. 介绍

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>消息摘要算法包含MD、SHA和MAC共3大系列，它们是三大消息摘要算法的主要代表。常用于验证数据的完整性，是数字签名算法的核心算法。核心原理是比较两个对象hashCode ()方法的值是否相同，顾名思义，hashCode就是散列值。任何消息经过散列函数处理后，都会获得唯一的散列值，这一过程称为“消息摘要”，其散列值称为“数字指纹”，其算法自然就是“消息摘要算法”了。为了方便人们识别和阅读，数字指纹常以十六进制字符串的形式出现。

- **MD（Message Digest，消息摘要算法）**：MD系列算法包括MD2、MD4和MD5共3种算法；

- **SHA（Secure Hash Algorithm，安全散列算法）**：SHA算法主要包括其代表算法SHA-1和SHA-1算法的变种SHA-2系列算法（包含SHA-224、SHA-256、SHA-384和SHA-512）；

- **MAC（Message Authentication Code，消息认证码算法）**：MAC算法综合了上述两种算法，主要包括HmacMD5、HmacSHA1、HmacSHA256、HmacSHA384和HmacSHA512算法。

### 2. MD家族

- **简述**：MD5算法是典型的消息摘要算法，它由MD4、MD3、MD2算法改进而来。不论是哪一种MD算法，它们都需要获得一个随机长度的信息并产生一个128位的信息摘要。如果将这个128位的二进制摘要信息换算成十六进制，可以得到一个32位（每4位二进制数转换为1位十六进制数）的字符串；

- **MD5算法**

  ```java
  // Java 工具类
  public static String digest(String text, String algorithm) {
      MessageDigest instance = null;
      try {
          instance = MessageDigest.getInstance(algorithm);
      } catch (NoSuchAlgorithmException e) {
          throw new RuntimeException("没有"+algorithm+"算法！");
      }
      byte[] digest = instance.digest(text.getBytes(StandardCharsets.UTF_8));
      StringBuilder sb = new StringBuilder();
      for (byte b : digest) {
          String s = Integer.toHexString(b & 0Xff);
          if (s.length() == 1) {
              s = "0" + s;
          }
          sb.append(s);
      }
      return sb.toString();
  }
  String digest = digest("text", "md5");
  // Hutool 工具包
  Digester md5 = new Digester(DigestAlgorithm.MD5);
  String digestHex = md5.digestHex(testStr);
  ```

### 3. SHA家族

- **简述**：SHA算法家族目前共有SHA-1、SHA-224、SHA-256、SHA-384和SHA-512五种算法，通常将后四种算法并称为SHA-2算法。除上述五种算法外，还有发布不久就夭折的SHA-0算法。SHA算法是在MD4算法的基础上演进而来的，通过SHA算法同样能够获得一个固定长度的摘要信息。与MD系列算法不同的是：若输入的消息不同，则与其相对应的摘要信息的差异概率很高。SHA算法是FIPS所认证的五种安全杂凑算法。

- **SHA算法**

  ```java
  // Java SHA算法
  String digest = digest("text", "SHA-1");
  String digest = digest("text", "SHA-256");
  String digest = digest("text", "SHA-512");
  ```

### 4. MAC家族

- **简述**：MAC（Message Authentication Code，消息认证码算法）是含有密钥散列函数算法，兼容了MD和SHA算法的特性，并在此基础上加入了密钥。因为MAC算法融合了密钥散列函数（keyed-Hash），通常我们也把MAC称为HMAC（keyed-Hash Message Authentication Code）。MAC算法主要集合了MD和SHA两大系列消息摘要算法。MD系列算法有HmacMD2、HmacMD4和HmacMD5三种算法；SHA系列算法有HmacSHA1、HmacSHA224、HmacSHA256、HmacSHA384和HmacSHA512五种算法。

- **Hmac算法**：

  ```java
  
  ```

### 5. 其他摘要算法

- 除了MD、SHA和MAC这三大主流消息摘要算法外，还有许多我们不了解的消息摘要算法，包括RipeMD系列（包含RipeMD128、RipeMD160、RipeMD256和RipeMD320）、Tiger、Whirlpool和GOST3411算法。RipeMD系列算法与MAC系列算法相结合，又产生了HmacRipeMD128和HmacRipeMD160两种算法。

## 2.2 对称加密算法

1. 介绍
2. 数据加密标准——DES
   - ECB：Electron Codebook电子密码本，原理是将需要加密的消费按照块密码的大小分为数个块，并对每个块进行独立加密，特定是同时加密如果原文相同，加密出来的密文也是相同的
   - 优点：可以并行处理数据
   - 确定：同样的原文生成同样的密文，不能很好的保护数据
   - CBC：Cipher Block Chaining密码块链接，原理是每个明文块与密文块进行异或后，再进行加密，在这种加密模式中每个密文块都依赖与他前面的所有明文块
   - 优点：安全系统好
   - 确定：加密速度慢
3. 三重DES——DESede
4. 高级数据加密标准——AES
5. 国际数据加密标准——IDEA
6. 基于口令加密——PBE

## 2.3 非对称加密

### 1. 非对称加密概述

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>非对称加密算法与对称加密算法的主要差异在于非对称加密用于加密和解密的密钥不相同，一个公开，称为公钥；一个保密，称为私钥。因此，非对称加密也称为双钥或公钥加密算法。非对称加密的缺点是加解密速度要远远慢于对称加密。

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>非对称加密算法源于DH算法（Diffie-Hellman，密钥交换算法），DH算法提出后，国际上相继出现了各种实用性更强的非对称加密算法，其构成主要是基于数学问题的求解，主要分为两类：

1. 基于因子分解难题：RSA算法是最为典型的非对称加密算法，RSA算法是当今应用范围最为广泛的非对称加密算法，也是第一个既能用于数据加密也能用于数字签名的算法。
2. 基于离散对数难题：ElGamal算法由Taher ElGamal提出，以自己的名字命名。该算法既可用于加密/解密，也可用于数字签名，并为数字签名算法形成标准提供参考。美国的DSS（Digital Signature Standard，数据签名标准）的DSA（Digital Signature Algorithm，数字签名算法）经ElGamal算法演变而来。
3. 椭圆曲线理论： ECC（Elliptical Curve Cryptography，椭圆曲线加密）算法以椭圆曲线理论为基础，在创建密钥时可做到更快、更小，并且更有效。ECC 算法通过椭圆曲线方程式的性质产生密钥，而不是采用传统的方法利用大质数的积来产生。

：特点是由两把密钥，一把公钥（pubkey）一把私钥（privateKey）；核心原理是如果信息是被公钥加密，则必须使用私钥解密

### 2. 密钥交换算法——DH&ECDH

1. 介绍
2. RSA
3. ECC

## 2.3 数字签名

1. 签名概述：数字签名（又称[公钥](https://baike.baidu.com/item/公钥)数字签名）是只有信息的发送者才能产生的别人无法伪造的一段数字串，这段数字串同时也是对信息的发送者发送信息真实性的一个有效证明。
2. 签名原理：

# 第三章 JWT

## 3.1 介绍

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>Json web token (JWT), 是为了在网络应用环境间传递声明而执行的一种基于JSON的开放标准（RFC 7519).该token被设计为紧凑且安全的，特别适用于分布式站点的单点登录（SSO）场景。JWT的声明一般被用来在身份提供者和服务提供者间传递被认证的用户身份信息，以便于从资源服务器获取资源，也可以增加一些额外的其它业务逻辑所必须的声明信息，该token也可直接被用于认证，也可被加密。

## 3.2 Jwt原理

### 1. 第一部分：header

- 将头部进行base64编码，构成了第一部分。

  ```json
  {
    'typ': 'JWT',
    'alg': 'HS256'
  }
  ```

- 头部一般承载两部分信息：①声明类型typ，这里是jwt②加密的算法alg，如 HMAC SHA256

### 2. 第二部分：payload

- 将荷载进行base64加密，得到Jwt的第二部分

  ```json
  {
    "sub": "1234567890",
    "name": "John Doe",
    "admin": true
  }
  ```

- 载荷就是存放有效信息的地方。这个名字像是特指飞机上承载的货品，这些有效信息包含三个部分：①标准中注册的声明、②公共的声明、③私有的声明

  - 标准中注册的声明 (建议但不强制使用) ：
    - **jti（jwt id）**: jwt的唯一身份标识，主要用来作为一次性token,从而回避重放攻击。
    - **iss（issuer）**: jwt签发者
    - **iat（issued at）**: jwt的签发时间
    - **sub（subject）**: jwt所面向的用户
    - **aud（audience）**: 接收jwt的一方
    - **exp（expires）**: jwt的过期时间，这个过期时间必须要大于签发时间
    - **nbf（not before）**: 定义在什么时间之前，该jwt都是不可用的.
  - 公共的声明 ：公共的声明可以添加任何的信息，一般添加用户的相关信息或其他业务需要的必要信息.但不建议添加敏感信息，因为该部分在客户端可base64
  - 私有的声明：私有声明是提供者和消费者所共同定义的声明，一般不建议存放敏感信息，因为base64是对称解密的，意味着该部分信息可以归类为明文信息。

### 3. 第三部分：signature

- 第三部分是一个签证信息，这个部分需要base64加密后的header和base64加密后的payload使用`.`连接组成的字符串，然后通过header中声明的加密方式进行加盐`secret`组合加密，然后就构成了jwt的第三部分。

  ```java
  // 伪代码
  var encodedString = base64UrlEncode(header) + '.' + base64UrlEncode(payload);
  var signature = HMACSHA256(encodedString, 'secret'); 
  ```

- secret是保存在服务器端的，jwt的签发生成也是在服务器端的，secret就是用来进行jwt的签发和jwt的验证，所以，它就是你服务端的私钥，在任何场景都不应该流露出去。一旦客户端得知这个secret, 那就意味着客户端是可以自我签发jwt了。

## 3.2 JWT库

### 1. java-jwt

- 依赖

  ```xml
  <dependency>
      <groupId>com.auth0</groupId>
      <artifactId>java-jwt</artifactId>
      <version>3.11.0</version>
  </dependency>
  ```

- 案例：Auth0提供的JWT库简单实用, 依赖第三方（JavaAPI提供的PublicKey和PrivateKey）提供的证书信息（keypair）；有一问题是在 生成token与校验token时都需要公钥(public key)与密钥(private key)，这是一不足（实际上在校验时只需要public key即可）

  ```java
  /**
  1. Algorithm：Jwt签名算法,用于sign()方法生成完整TOKEN
  2. JWT : 封装JWT操作相关对象
  	2.1 JWTParser
  3. JWTVerifier：JWT.require()方法封装验签算法，用于验证TOKEN
  */
  // 使用秘钥签名获取TOKEN
  @Test
  public void testJwt() throws Exception{
      String token = JWT.create()
          .withJWTId("id")
          .withIssuer("发行人")
          .withIssuedAt(new Date())//发行时间
          .withAudience("接收人")
          .withExpiresAt(new Date(System.currentTimeMillis() + 1000 * 60)) 
          .withSubject("用户")
          .withAudience("接收方")
          .withNotBefore(new Date(System.currentTimeMillis() + 1000 * 10))
          .withClaim("TEST","自定义")
          .sign(Algorithm.HMAC256("秘钥"));
  
      JWTVerifier verifier = JWT.require(Algorithm.HMAC256("秘钥")).build();
      verifier.verify(token);
  }
  // 使用秘钥对签名获取TOKEN
  @Test
  public void testJwt() throws Exception{
      // hutool工具包将秘钥字符串转为秘钥对象
      PublicKey publicKey = SecureUtil.generatePublicKey("RSA", "pubKey字节数组");
      PrivateKey privateKey = SecureUtil.generatePrivateKey("RSA","priKey字节数组");
      // 封装签名算法：加签与验签都需要封装公钥与私钥
      Algorithm algorithm = Algorithm.RSA512((RSAPublicKey) publicKey, (RSAPrivateKey) privateKey);
      // 获取TOKEN
      String token = JWT.create()
          .withJWTId("id")
          .withIssuer("发行人")
          .withIssuedAt(new Date())//发行时间
          .withAudience("接收人")
          .withExpiresAt(new Date(System.currentTimeMillis() + 1000 * 60)) // 过期时间
          .withSubject("用户")
          .withAudience("接收方")
          .withNotBefore(new Date(System.currentTimeMillis()))
          .withClaim("TEST","自定义")
          .sign(algorithm);
      // 验证TOKEN的算法都需要公钥与私钥
      JWTVerifier verifier = JWT.require(algorithm).build();
      DecodedJWT verify = verifier.verify(token);
  }
  ```


### 2. jose4j

- Maven依赖

  ```xml
  <dependency>
      <groupId>org.bitbucket.b_c</groupId>
      <artifactId>jose4j</artifactId>
      <version>3.6.3</version>
  </dependency>
  ```

- 使用案例：jose4j提供了完整的JWT实现，可以不依赖第三方提供的证书信息(keypair，库本身自带有RSA的实现)，类定义与JWT协议规定匹配度高,易理解与上手；对称加密与非对称加密都有提供实现

  ```java
  
  ```


### 3. nimbus-jose-jwt

- Maven依赖

  ```xml
  <dependency>
      <groupId>com.nimbusds</groupId>
      <artifactId>nimbus-jose-jwt</artifactId>
      <version>8.19</version>
  </dependency>
  ```

- 使用案例：类定义清晰,简单易用,易理解 , 依赖Java第三方提供的证书信息(keypair), 对称算法 与非对称算法皆有实现。

  ```java
  /*
  1. SignedJWT是JWSObject的子类，构造方法需要JWSHeader 和 JWTClaimsSet
      1.1 sign(final JWSSigner signer):设置签名算法相关参数
      1.2 JWSSigner的实现:①ECDSASigner、②Ed25519Signer、③MACSigner、④RSASSASigner
  2. JWSHeader的构造方法中需要指定签名算法JWSHeader(final JWSAlgorithm alg) 
  3. JWTClaimsSet封装JwtPayload标准信息
  3. JWSAlgorithm 签名算法
  */        
  @Test
  public void testHS256() throws Exception{
      String secret = IdUtil.fastSimpleUUID();
      // 1. 指定签名算法
      JWSHeader header = new JWSHeader(JWSAlgorithm.HS256);
      // 2. 为签名算法配置参数
      JWSSigner sign = new MACSigner(secret);
      // 3. 配置payload
      JWTClaimsSet claimsSet = new JWTClaimsSet.Builder()
          .jwtID("id")
          .subject("sub")
          .expirationTime(new Date(System.currentTimeMillis() + 1000))
          .issuer("issuer")
          .issueTime(new Date())
          .notBeforeTime(new Date(System.currentTimeMillis() + 100))
          .audience("audience")
          .claim("CLAIM","CLAIM")
          .build();
      // 4. 构建Token对象
      SignedJWT jwt = new SignedJWT(header, claimsSet);
      jwt.sign(sign);
      // 5. 生成token
      String token = jwt.serialize();
      System.out.println("token = " + token);
  
      // 验签
      SignedJWT parse = SignedJWT.parse(token);
      JWSVerifier verify = new MACVerifier(secret);
      boolean result = parse.verify(verify);
      
      JWTClaimsSet jwtClaimsSet = parse.getJWTClaimsSet();
  }
  @Test
  public void testRsa() throws Exception {
      // Java 实现密钥对
      final KeyPairGenerator keyPairGenerator = KeyPairGenerator.getInstance("RSA");
      // 长度 至少 1024, 建议 2048
      final int keySize = 2048;
      keyPairGenerator.initialize(keySize);
      final KeyPair keyPair = keyPairGenerator.genKeyPair();
      //公钥
      final RSAPublicKey publicKey = (RSAPublicKey) keyPair.getPublic();
      //私钥
      final PrivateKey privateKey = keyPair.getPrivate();
      // 1. 指定签名算法
      final JWSHeader header = new JWSHeader(JWSAlgorithm.RS512);
      // 2. 为签名算法配置参数，加签是私钥
      JWSSigner signer = new RSASSASigner(privateKey);
      // 3. 配置payload
      JWTClaimsSet claimsSet = new JWTClaimsSet.Builder()
          .jwtID("id")
          .subject("sub")
          .expirationTime(new Date(System.currentTimeMillis() + 1000))
          .issuer("issuer")
          .issueTime(new Date())
          .notBeforeTime(new Date(System.currentTimeMillis() + 100))
          .audience("audience")
          .claim("CLAIM", "CLAIM")
          .build();
      // 4. 构建Token对象
      SignedJWT jwt = new SignedJWT(header, claimsSet);
      jwt.sign(signer);
      String token = jwt.serialize();
      System.out.println("token = " + token);
      // 验签
      final SignedJWT parseJWT = SignedJWT.parse(token);
  	// 验签是公钥
      JWSVerifier verifier = new RSASSAVerifier(publicKey);
      final boolean verify = parseJWT.verify(verifier);
  
      final JWTClaimsSet jwtClaimsSet = parseJWT.getJWTClaimsSet();
      System.out.println("jwtClaimsSet = " + jwtClaimsSet);
  }
  ```


### 4. jjwt

- Maven依赖

  ```xml
  <dependency>
      <groupId>io.jsonwebtoken</groupId>
      <artifactId>jjwt</artifactId>
      <version>0.9.1</version>
  </dependency>
  
  <!-- 或者 jjwt-api 基于jjwt 旨在最简单的时候jwt-->
  <dependency>
      <groupId>io.jsonwebtoken</groupId>
      <artifactId>jjwt-api</artifactId>
      <version>0.10.5</version>
  </dependency>
  <dependency>
      <groupId>io.jsonwebtoken</groupId>
      <artifactId>jjwt-impl</artifactId>
      <version>0.10.5</version>
      <scope>runtime</scope>
  </dependency>
  <dependency>
      <groupId>io.jsonwebtoken</groupId>
      <artifactId>jjwt-jackson</artifactId>
      <version>0.10.5</version>
      <scope>runtime</scope>
  </dependency>
  <!-- 如果希望使用算法: RSASSA-PSS (PS256, PS384, PS512) algorithms: 添加该依赖
  <dependency>
      <groupId>org.bouncycastle</groupId>
      <artifactId>bcprov-jdk15on</artifactId>
      <version>1.60</version>
      <scope>runtime</scope>
  </dependency>
  -->
  ```

- 使用案例：jjwt小巧够用，API注意点较多：①JwtBuilder的payload属性与其他JwtBuilder属性不可以同时设置②加签的秘钥需要封装一次Keys.hmacShaKeyFor()②JwtParser的getBody()只能获取到payload属性或claims属性中的值

  ```java
  private static String secretKey = "ICAgIHByaXZhdGUgc3RhdGljIFN0cmluZyBzZWNyZXRLZXkgPSAiZEdocGN5QnBjeUIyWlhKNUlHeHZibWNnYzJWamNtVjAiOwo=";
  
  @Test
  public void testCreate()throws Exception{
      Map<String, Object> claims = new HashMap<>();
      claims.put("payload","Payload");
      Key key = Keys.hmacShaKeyFor(Base64Decoder.decode(secretKey));
      String token = Jwts.builder()
          //.setPayload("PayLoadPayLoadPayLoadPayLoad")
          .setId("id")
          .setIssuer("提交人")
          .setIssuedAt(new Date())
          .setExpiration(new Date(System.currentTimeMillis() + 60 * 1000))
          .setNotBefore(new Date())
          .setAudience("接收人")
          .setSubject("主题")
          .setClaims(claims)
          .signWith(key,SignatureAlgorithm.HS512)
          .compact();
      System.out.println("token = " + token);
      Jwt jws = Jwts.parser()
          .setSigningKey(Base64Decoder.decode(secretKey))
          .parse(token);
  }
  
  // 秘钥必须符合2048长度规则, 签约TOKEN需要使用私钥,API没做规范
  @Test
  public void testBefore() throws Exception{
      String pub = "Base64公钥2048 字符串";
      String pri = "Base64私钥2048 字符串";
  
      PublicKey ab  = SecureUtil.generatePublicKey("RSA", Base64Decoder.decode(pub));
      PrivateKey ai = SecureUtil.generatePrivateKey("RSA",Base64Decoder.decode(pri));
  
      String rsa = Jwts.builder()
          .setPayload("Publisc")
          .signWith(ai)
          .compact();
      System.out.println("rsa = " + rsa);
  
      Jwt parse = Jwts.parser()
          .setSigningKey(ab)
          .parse(rsa);
  }
  
  ```
  
- 异常详情

  | 异常                  | 说明                     |
  | --------------------- | ------------------------ |
  | SignatureException    | 密钥错误                 |
  | MalformedJwtException | 密钥算法或者密钥转换错误 |
  | MissingClaimException | 密钥缺少校验数据         |
  | ExpiredJwtException   | 密钥已过期               |
  | JwtException          | 密钥解析错误             |


### 5. fusionauth-jwt 

- Maven依赖

  ```xml
  <dependency>
      <groupId>io.fusionauth</groupId>
      <artifactId>fusionauth-jwt</artifactId>
      <version>4.0.0</version>
  </dependency>
  ```

- 有些地方不符合JAVA语言规范，支持对称算法(HMAC) 与非对称算法(RSA)，也算容易理解


### 6. vertx-auth-jwt

- Maven依赖

  ```xml
  <dependency>
      <groupId>io.vertx</groupId>
      <artifactId>vertx-auth-jwt</artifactId>
      <version>3.5.1</version>
  </dependency>
  ```

- 算是最不容易理解的一个库了， 不容易上手，生成与校验token时都需要公钥与私钥；
