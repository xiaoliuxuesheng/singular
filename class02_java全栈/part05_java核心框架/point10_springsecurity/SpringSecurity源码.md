1. 默认启动，内置user用户，控制台输出随机密码

2. application.yml配置修改默认user用户和密码

3. 编码的方式在内存添加多个用户

4. SpringSecurity配置文件

   ```java
       @Bean
       SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
           
       }
   ```

   > 1. 用户名密码登陆，修改默认的登陆页地址	loginPage("/pandaLogin")
   > 2. 
   > 3. 用户名密码登陆，添加认证成功处理器
   > 4. 用户名密码登陆，认证失败处理器
   > 5. 用户名密码登陆，
