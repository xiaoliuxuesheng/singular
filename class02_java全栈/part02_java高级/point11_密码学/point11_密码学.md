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

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>从密码体制上划分，现代密码学工分为两种密码体制：对称密码体制和非对称密码体制。对称与非对称的差别源于加密密钥和解密密钥是否对称，即加密密钥与解密密钥是否相同（对称）。

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>在对称密码体制中，加密与解密操作使用相同的密钥，我们把这个密钥称为秘密密钥。DES、AES算法都是常用的对称密码算法。流密码实现简单，对环境要求低，适用于手机平台的加密，广泛应用于军事、外交领域。RC4算法就是典型的流密码算法。流密码的理论、算法受限于国家安全因素未能公布。分组密码在这一点上与流密码恰恰相反，其理论，算法公开，分类众多。DES、AES算法主要的对称密码算法均属于分组密码。分组密码共有5中工作模式：电子密码本模式（ECB）、密文链接模式（CBC）、密文反馈模式（CFB）、输出反馈模式（OFB）、计数器模式（CTR）。分组密码会产生短块，关于短块的处理方法有填充法、流密码加密法、密文挪用技术。

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>在非对称密码体制中，加密与解密操作使用不同的密钥。对外公开的密钥，称为公钥；对外保密的密钥，称为私钥。用公钥加密的数据，只能用私钥解密；反之，用私钥加密的数据，只能用公钥解密。RSA算法是常用的非对称密码算法。非对称密码体制同时支持数字签名技术，如RSA、DSA都是常用的数字签名算法。

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>散列函数可以有效地确保数据完整性，其是一项消息认证技术。常用的散列函数算法有MD5、SHA、Mac。散列函数也是数字签名技术中最重要的技术环节。数字签名离不开非对称密码体制，其私钥用于签名，公钥用于验证。基于数字签名的不可伪造性，数字签名技术成为5种安全服务中数据完整性服务、认证性服务和抗否认性服务的核心技术。通信双方只有一方提供数字签名的认证方式称为单向认证，通信双方都提供数字签名的认证方式称为双向认证。一般网银系统多采用单向认证方式，而要求较高的网银交易则都采用双向认证方式。

<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>PKI和PGP是现代网络安全技术领域的两把锁。目前电子商务、电子政务使用PKI技术来确保平台安全性。PGP则多用于电子邮件、文件等的数据签名与加密。

## 1.4 ASCII码与字符编码表

1. **ASCii（美国标准信息交换码）**：

## 1.5 Base64与Base58

1. **Base64**

   - 概述：Base64不是加密算法，本质上是可读性算法，Base64的目的不是加密代码而是将二进制数据具有可读性；

   - 原理：Base64是由64个字符组成（大写A-Z、小写a-z、数字0-9、字符+、字符/），Base64首先将字符拆分为三个字节为一组，一个字节8位，总共24位，然后将24位拆分为4组，每一组有6位，因为一个字节是8位，拆分或6位缺两位的高位用0补齐，base64取后6位控制在0-63之间，对应base64规则将字节转换为64个可读性字符，当位数不够的时候用=号补齐；

   - Java案例

     ```java
     
     ```

2. **Base58**：由于Base64字符中的部分字母和数字相似度太高，在外观上对可读性仍较低，所以Base58在Base64的基础上减少了6个字符：①数字0、②大写字母O，③大写字母I，④小写的字母l、⑤加号+，⑥斜杠/，Base58是采用我们数学上经常使用的进制转换方法——辗转相除法；

## 1.6 new String原理

- 是根据参数，使用Java虚拟机的的模板编码格式，会把这个字节数组进行decode，找到对应的字符码表进行转换；

# 第二章 现代加密算法

## 2.1 数字摘要

1. 介绍
2. MD家族
3. SHA家族
4. MAC家族
5. 其他摘要算法

## 2.2 对称加密算法

1. 介绍
2. 数据加密标准——DES
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

### 2. 密钥交换算法——DH&ECDH



1. 介绍
2. RSA
3. ECC

## 2.3 数字签名

# 第三章 JWT

## 3.1 介绍

## 3.2 基于Java的JWT

1. nimbus-jose-jwt



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

- 概述：

- Base64规则：

- Base58规则：是在Base64几乎是行

- Base64原理：

- 案例演示：

  

# 4、Java String

- toString与new String
  - toString：调用的Object的toString方法，返回的的hash值
  - new String：

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