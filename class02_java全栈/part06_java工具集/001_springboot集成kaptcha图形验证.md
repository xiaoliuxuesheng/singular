# 1. 引入依赖

```xml
<dependency>
    <groupId>com.github.penggle</groupId>
    <artifactId>kaptcha</artifactId>
    <version>2.3.2</version>
</dependency>
```

#2.配置DefaultKaptcha

## 方式一 : 基于XMl配置文件

- 在根目录添加xml文件 : kaptchaConfig.xml

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <beans xmlns="http://www.springframework.org/schema/beans"
           xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
           xsi:schemaLocation="http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd">
        <bean id="captchaProducer" class="com.google.code.kaptcha.impl.DefaultKaptcha">
            <property name="config">
                <bean class="com.google.code.kaptcha.util.Config">
                    <constructor-arg type="java.util.Properties">
                        <props>
                            <!--是否使用边框-->
                            <prop key="kaptcha.border ">yes</prop>
                            <!--边框颜色-->
                            <prop key="kaptcha.border.color">105,179,90</prop>
                            <!--验证码字体颜色-->
                            <prop key="kaptcha.textproducer.font.color">blue</prop>
                            <!--验证码图片的宽度-->
                            <prop key="kaptcha.image.width">100</prop>
                            <!--验证码图片的高度-->
                            <prop key="kaptcha.image.height">50</prop>
                            <!--验证码字体的大小-->
                            <prop key="kaptcha.textproducer.font.size">27</prop>
                            <!--验证码保存在session的key-->
                            <prop key="kaptcha.session.key">code</prop>
                            <!--验证码输出的字符长度-->
                            <prop key="kaptcha.textproducer.char.length">4</prop>
                            <!--验证码的字体设置-->
                            <prop key="kaptcha.textproducer.font.names">宋体,楷体,微软雅黑</prop>
                            <!--验证码的取值范围-->
                            <prop key="kaptcha.textproducer.char.string">0123456789ABCEFGHIJKLMNOPQRSTUVWXYZ</prop>
                            <!--图片的样式-->
                            <prop key="kaptcha.obscurificator.impl">com.google.code.kaptcha.impl.WaterRipple</prop>
                            <!--干扰颜色，合法值： r,g,b 或者 white,black,blue.-->
                            <prop key="kaptcha.noise.color">black</prop>
                            <!--干扰实现类-->
                            <prop key="kaptcha.noise.impl">com.google.code.kaptcha.impl.DefaultNoise</prop>
                            <!--背景颜色渐变，开始颜色-->
                            <prop key="kaptcha.background.clear.from">185,56,213</prop>
                            <!--背景颜色渐变，结束颜色-->
                            <prop key="kaptcha.background.clear.to">white</prop>
                            <!--文字间隔-->
                            <prop key="kaptcha.textproducer.char.space">3</prop>
                        </props>
                    </constructor-arg>
                </bean>
            </property>
        </bean>
    </beans>
    ```

- 在启动类引入配置文件

    ```java
    @ImportResource(locations={"classpath:kaptchaConfig.xml"})
    ```

## 方式二 : 使用Java配置类

```java
import com.google.code.kaptcha.impl.DefaultKaptcha;
import com.google.code.kaptcha.util.Config;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;
import java.util.Properties;
@Component
public class CodeUtil {
    @Bean
    public DefaultKaptcha getDefaultKaptcha() {
        com.google.code.kaptcha.impl.DefaultKaptcha defaultKaptcha = new com.google.code.kaptcha.impl.DefaultKaptcha();
        Properties properties = new Properties();
        properties.setProperty("kaptcha.border", "no");
        properties.setProperty("kaptcha.border.color", "105,179,90");
        properties.setProperty("kaptcha.textproducer.font.color", "red");
        properties.setProperty("kaptcha.image.width", "110");
        properties.setProperty("kaptcha.image.height", "40");
        properties.setProperty("kaptcha.textproducer.font.size", "40");
        properties.setProperty("kaptcha.session.key", "code");
        properties.setProperty("kaptcha.textproducer.char.length", "4");
        properties.setProperty("kaptcha.textproducer.font.names", "宋体,楷体,微软雅黑");
        Config config = new Config(properties);
        defaultKaptcha.setConfig(config);
        return defaultKaptcha;
    }
}
```

# 3.定义获取验证码接口与验证接口

```java
@Controller
@Slf4j
public class CodeController {

    @Autowired
    private DefaultKaptcha defaultKaptcha;

    //获取验证码
    @RequestMapping("/getCode")
    public void defaultKaptcha(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) throws Exception {
        byte[] captchaChallengeAsJpeg = null;
        ByteArrayOutputStream jpegOutputStream = new ByteArrayOutputStream();
        try {
            //生产验证码字符串并保存到session中
            String createText = defaultKaptcha.createText();
            httpServletRequest.getSession().setAttribute("vrifyCode", createText);
            //使用生产的验证码字符串返回一个BufferedImage对象并转为byte写入到byte数组中
            BufferedImage challenge = defaultKaptcha.createImage(createText);
            ImageIO.write(challenge, "jpg", jpegOutputStream);
        } catch (IllegalArgumentException e) {
            httpServletResponse.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        //定义response输出类型为image/jpeg类型，使用response输出流输出图片的byte数组
        captchaChallengeAsJpeg = jpegOutputStream.toByteArray();
        httpServletResponse.setHeader("Cache-Control", "no-store");
        httpServletResponse.setHeader("Pragma", "no-cache");
        httpServletResponse.setDateHeader("Expires", 0);
        httpServletResponse.setContentType("image/jpeg");
        ServletOutputStream responseOutputStream =
                httpServletResponse.getOutputStream();
        responseOutputStream.write(captchaChallengeAsJpeg);
        responseOutputStream.flush();
        responseOutputStream.close();
    }

    //验证码验证
    @RequestMapping("/checkCode")
    @ResponseBody
    public boolean imgvrifyControllerDefaultKaptcha(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse) {
        String captchaId = (String) httpServletRequest.getSession().getAttribute("vrifyCode");
        String parameter = httpServletRequest.getParameter("code");
        log.info("Session  vrifyCode ---->" + captchaId + "---- form code --->" + parameter);
        if (!captchaId.equals(parameter)) {
            log.info("错误的验证码");
            return false;
        } else {
            return true;
        }
    }
}
```



