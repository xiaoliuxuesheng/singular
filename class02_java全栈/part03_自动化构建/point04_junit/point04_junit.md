# 第一部分 Junit

## 1.1 单元测试相关规则

1. 每一个测试方法上使用@Test进行修饰
2. 每一个测试方法必须使用public void 进行修饰
3. 每一个测试方法不能携带参数
4. 测试代码和源代码在两个不同的项目路径下
5. 测试类的包应该和被测试类保持一致
6. 测试单元中的每个方法必须可以独立测试

## 1.2 Junit注解

### <font size=4 color=blue>1. 常用注解</font>

> 注解的执行顺序：@BeforeClass -> @Before -> @Test -> @After -> @AfterClass

- **@BeforeClass**：在测试类启动后立即执行，只会执行一次，如果有多个根据方法的先后位置的顺序执行

- **@Before**：在测试用例的方法执行前执行，如果有多个根据方法名称的顺序执行

- **@Test**：需要运行的测试用例方法，如果有多个根据方法名称的顺序执行

-  **@After** ：在测试用例方法执行完成后执行，如果有多个根据方法名称的顺序执行

- **@AfterClass**：在测试类中所有测试用例执行完成后执行，只会执行一次，如果有多个根据方法的先后位置的顺序执行

- **@RunWith**：更改测试运行器

- **@Ignore**：意思是所修饰的测试方法会被测试运行器忽略

  这个注解其实基本上不用，他的意思是所修饰的测试方法会被测试运行器忽略

### <font size=4 color=blue>2. 注解属性说明</font>

- @Test(expected=XX.class)：这个参数表示我们期望会出现什么异常，出现异常则正常通过
- @Test(timeout=毫秒 )：表示如果测试方法在指定的timeout内没有完成，就会强制停止

## 1.3 参数化测试

- Parameterized：自定义运行器参数实现参数化测试，根据配置参数创建测试用例并根据配置参数运行测试用例，如下代码：

  ```java
  @RunWith(Parameterized.class)
  public class TestClass {
      @Parameters
      public static Collection<Object[]> data() {
          Object[][] objects = {{0, 0}, {1, 1}, {2, 1}, {3, 2}, {4, 3}, {5, 5}, {6, 8}};
          return Arrays.asList(objects);
      }
      
      private int 字段1;
      private int 字段2;
  }
  ```

  - 需要进行参数化测试，需要在类上面指定如下的运行器`@RunWith(Parameterized.class)`

  - 运行参数配置：@Parameters，方法必须是`public static`，返回值必须是`Collection`；返回的集合中的元素数量表示测试用例的执行数量，集合中每个元素中的参数个数和测试列中的字段数量必须相同，将配置参数中的参数设置到测试类的属性中有两种方法：

    - ①通过构造函数设置：构造函数中参数的位置对应着配置参数的几个中单个元素中的子元素索引

      ```java
      public TestClass(int input, int expected,int oth) {
          字段1 = input;
          字段2 = expected;
          字段3 = oth;
      }
      ```

    - ②使用@Parameter标签指定参数：此时测试类中的字段不可以用`private`修饰，@Parameter的属性值value属性默认值是0

      ```java
      @Parameter
      public int 字段1;
       
      @Parameter(value = 1)
      public  int 字段2;
      ```

- 参数化的运行的执行配置：`{索引}`表示索引对应的值

  | 默认                                                         | 配置运行说明                                                 |
  | ------------------------------------------------------------ | ------------------------------------------------------------ |
  | @Parameters(name = "{index}）                                | @Parameters(name = "{index} 自定义执行注释 {0}={1}")         |
  | <img src="https://s1.ax1x.com/2020/04/25/Jsn8fI.png" alt="junit 001" border="0"> | <img src="https://s1.ax1x.com/2020/04/25/Jsn3tA.png" alt="junit 002" border="0"> |

## 1.4 Junit断言Assert

1. **assertTrue/False([String message,]boolean condition)**：判断一个条件是true还是false。

2. **fail([String message])**：失败，可以有消息，也可以没有消息

3. **assertEquals([String message,]Object expected,Object actual)**：判断是否相等，可以输出错误信息
   - 第一个参数是期望值
   - 第二个参数是实际的值
   
4. **assertNotEquals([String message,]Object expected,Object actual)**：判断是否不相等。
   - 第一个参数是期望值
   - 第二个参数是实际的值
   
5. **assertArrayEquals([String message,] Object[] expecteds, Object[] actuals) **：判断集合是否相等

6. **assertNotNull/Null([String message,]Object obj)**：判读一个对象是否非空(非空)

7. **assertSame/NotSame([String message,]Object expected,Object actual)**：判断两个对象是否指向同一个对象。看内存地址

8. **failNotSame/failNotEquals(String message, Object expected, Object actual)**：当不指向同一个内存地址或者不相等的时候，输出错误信息。 注意信息是必须的，而且这个输出是格式化过的

9. **assertThat(String reason, Object actual, Matcher matcher)**：断言匹配器

   - reason为断言失败时的输出信息

   - actual为断言的值或对象

   - matcher为断言的匹配器，里面的逻辑决定了给定的actual对象满不满足断言

     | 一般匹配符                   | 使用说明                                       |
     | ---------------------------- | ---------------------------------------------- |
     | is                           | 测试变量值等于指定值                           |
     | not                          | 试变量不等于指定值                             |
     | allOf(Matcher... matchers)   | 测试所有条件必须成立                           |
     | anyOf(Matcher... matchers)   | 测试只要有一个条件成立                         |
     | anything                     | 无论什么条件都成立                             |
     | **字符串相关匹配符**         | **使用说明**                                   |
     | containsString               | 测试变量是否包含指定字符                       |
     | startsWith                   | 测试变量是否已指定字符串开头                   |
     | endsWith                     | 测试变量是否以指定字符串结尾                   |
     | equalTo                      | 测试变量是否等于指定字符串                     |
     | equalToIgnoringCase          | 测试变量再忽略大小写的情况下是否等于指定字符串 |
     | equalToCompressingWhiteSpace | 匹配符表明如果测试的字符串忽略头尾空格         |
     | **数值相关匹配符**           | **使用说明**                                   |
     | closeTo                      | 测试的浮点型数是否在范围之内                   |
     | greaterThan                  | 否大于指定值                                   |
     | lessThan                     | 是否小于指定值                                 |
     | greaterThanOrEqualTo         | 是否大于等于指定值                             |
     | lessThanOrEqualTo            | 是否小于等于指定值                             |
     | **collection相关匹配符**     | **使用说明**                                   |
     | hasItem                      | 测试集合中是否还有指定元素                     |
     | hasEntry                     | 测试map中是否还有指定键值对                    |
     | hasKey                       | 测试map中是否还有指定键                        |
     | hasValue                     | 测试map中是否还有指定值                        |

# 第二部分 powermock

## 2.1 mockUnit test介绍

- 什么是mock：解决单元测试中的外部资源导致代码逻辑的验证不完整

- 需要可以实现自动化
- 执行效率需要高
- Unit Test不应该依赖其他的Unit Test，并且不应该依赖外部的资源
- Unit Test执行的时间和空间必须是透明的
- Unit Test需要有意义
- Unit Test需要做到精确、做到源码级别的要求

## 2.2 powermock快速入门

1. 添加依赖

   ```xml
   <dependency>
       <groupId>org.powermock</groupId>
       <artifactId>powermock-module-junit4</artifactId>
       <version>2.0.0</version>
       <scope>test</scope>
   </dependency>
   <dependency>
       <groupId>org.powermock</groupId>
       <artifactId>powermock-api-mockito2</artifactId>
       <version>2.0.0</version>
       <scope>test</scope>
   </dependency>
   <dependency>
       <groupId>junit</groupId>
       <artifactId>junit</artifactId>
       <version>4.12</version>
       <scope>test</scope>
   </dependency>
   ```

2. 快速入门：为某个类mock一个对象并为其录制行为和结果

    ```java
    @Test
    public void select() {
      UserDao userDao = PowerMockito.mock(UserDao.class);
      PowerMockito.when(userDao.select()).thenReturn(10);
      UserService userService = new UserService(userDao);
      int select = userDao.select();
      Assert.assertEquals(10, select);
    }
    ```

## 2.3 mock局部变量

1. mock局部变量核心API

   ```java
   // 首先一定是需要将对象mock
   UserDao userDao = PowerMockito.mock(UserDao.class);
   
   // mock局部变量的说明:当局部变量new的时候使用无参构造器返回的对象是mock出来的对象
   PowerMockito.whenNew(UserDao.class).withNoArguments().thenReturn(userDao);
   ```

2. 案例演示

   ```java
   @Setter
   @Getter
   public class User {
   	
   }
   /**
    *	表示无法正常访问的外部资源
    */
   public class UserDao {
   
       public void save(User user){
           throw new UnsupportedOperationException();
       }
   
       public int select(){
           throw  new UnsupportedOperationException();
       }
   }
   /**
    *	方法内的局部变量
    */
   public class UserService2 {
       public void save(User user) {
           UserDao userDao = new UserDao();
           userDao.save(user);
       }
   
       public int select(){
           UserDao userDao = new UserDao();
           return userDao.select();
       }
   }
   ```

   

   ```java
   @RunWith(PowerMockRunner.class)
   @PrepareForTest({UserService2.class})
   public class UserService2Test {
   
       @Test
       public void save() throws Exception{
           User user = new User();
           UserDao userDao = PowerMockito.mock(UserDao.class);
           PowerMockito.whenNew(UserDao.class).withNoArguments().thenReturn(userDao);
   
           PowerMockito.doNothing().when(userDao).save(user);
   
           UserService2 userService2 = new UserService2();
           userService2.save(user);
           Mockito.verify(userDao).save(user);
       }
   }
   ```

3. 注解说明

   - @RunWith(PowerMockRunner.class)：虽然API中说明的在new局部变量时候返回mock对象，但是是在什么时候开始now，测试框架是不知道的，所以需要将测试用例在PowerMockRunner容器中运行
   - @PrepareForTest：mock局部变量是需要改变对应类的字节码，所以需要在测试用例执行之前准备局部变量对应的类的字节码对象

## 2.4 mock静态变量

1. mock静态变量核心API

   ```java
   PowerMockito.mockStatic(UserDao4.class);
   ```

2. 案例代码

   ```java
   @Setter
   @Getter
   public class User {
   	
   }
   /**
    *	表示无法正常访问的外部资源
    */
   public class UserDao4 {
   
       public static void save(User user){
           throw new UnsupportedOperationException();
       }
   
       public static int select(){
           throw  new UnsupportedOperationException();
       }
   }
   /**
    *	外部资源的静态方法
    */
   public class UserService4 {
       public void save(User user) {
           UserDao4.save(user);
       }
       public int select(){
           return UserDao4.select();
       }
   }
   ```

   ```java
   @RunWith(PowerMockRunner.class)
   @PrepareForTest({UserService4.class,UserDao4.class})
   public class UserService4Test {
   
       @Test
       public void save() {
           User user = new User();
           PowerMockito.mockStatic(UserDao4.class);
           PowerMockito.doNothing().when(UserDao4.class);
           UserService4 userService4 = new UserService4();
           userService4.save(user);
       }
   }
   ```

## 2.5 mock final修饰的方法

1. 核心API：通过改变字节码mock对象

   ```java
   @PrepareForTest({UserService5.class,UserDao5.class})
   ```

2. 案例说明

   ```java
   @Setter
   @Getter
   public class User {
   	
   }
   /**
    *	表示无法正常访问的外部资源并且是final
    */
   final public class UserDao5 {
   
       public void save(User user){
           throw new UnsupportedOperationException();
       }
   
       public int select(){
           throw  new UnsupportedOperationException();
       }
   }
   /**
    *	final的外部资源
    */
   public class UserService5 {
   
       private UserDao5 userDao5;
   
       public UserService5(UserDao5 userDao5) {
           this.userDao5 = userDao5;
       }
   
       public void save(User user) {
           userDao5.save(user);
       }
   
       public int select(){
           return userDao5.select();
       }
   }
   ```

## 2.6 mock私有方法

1. 核心API

   ```java
   MockPrivateClass mockPrivateClass = PowerMockito.spy(new MockPrivateClass());
   
   PowerMockito.when(mockPrivateClass, "privateFunc").thenReturn("test");
   ```

2. 案例代码

   ```java
   public class MockPrivateClass {
       public String mockPrivateFunc() {
           return  privateFunc();
       }
   
       private String privateFunc() {
           return "private func";
       }
   }
   ```

   ```java
   @RunWith(PowerMockRunner.class)
   @PrepareForTest({MockPrivateClass.class})
   public class MockPrivateClassTest {
   
       @Test
       public void testMockPrivateFunc() throws Exception {
           MockPrivateClass mockPrivateClass = PowerMockito.spy(new MockPrivateClass());
   
           PowerMockito.when(mockPrivateClass, "privateFunc").thenReturn("test");
   
           String realResult = mockPrivateClass.mockPrivateFunc();
   
           Assert.assertEquals("test", realResult);
       }
   }
   ```

## 2.7 verify的使用

1. verify的作用：验证被mock对象的方法是被执行到
2. verify的API说明
   - <T> T  **Mockito.verify**(T mock);
   - void **Mockito.verifyNoInteractions**(Object... mocks);
   - ConstructorArgumentsVerification **PowerMockito.verifyNew**(Class<T> mock);
     - ConstructorArgumentsVerification.withArguments(Object var1, Object... var2);
     - ConstructorArgumentsVerification.withNoArguments();
   - PrivateMethodVerification **PowerMockito.verifyPrivate**(Object object);
     - PrivateMethodVerification.invoke(String var1, Object... var2);
     - PrivateMethodVerification.invoke(Method var1);
   - void **PowerMockito.verifyStatic**(Class<T> mockedClass);
   - void **PowerMockito.verifyZeroInteractions**(Object... mocks);
   - void **PowerMockito.verifyNoMoreInteractions**(Object... mocks);  

## 2.8 mock不同的构造函数

1. 创建对象的API：PowerMockito.whenNew(UserDao.class)会使用到构造函数
   - withNoArguments()：调用无参构造器
   - withArguments(Object var1, Object... var2)：有参构造器并且传入参数
   - withAnyArguments()：没有任何构造参数
   - withParameterTypes(Class<?> var1, Class... var2)：

## 2.9 Parameters Matcher接口的使用

1. 使用说明：当断言过程中会存在多中参数验证的方式，使用matches接口的扩展验证

2. 代码案例

   ```java
   @RunWith(PowerMockRunner.class)
   @PrepareForTest({UserService5.class,UserDao5.class})
   public class UserService5Test {
   
       @Test
       public void save() {
           UserDao5 userDao5 = PowerMockito.mock(UserDao5.class);
           PowerMockito.when(userDao5.select(ArgumentMatchers.argThat(new ArgumentMatcher<String>() {
               @Override
               public boolean matches(String argument) {
                   switch (argument){
                       case "a":
                       case "b":
                       case "c":
                       case "str":
                           return true;
                       default:return false;
                   }
               }
           }))).thenReturn(10);
           UserService5 userService5 = new UserService5(userDao5);
           int a = userService5.select("a");
           int b = userService5.select("b");
           int c = userService5.select("c");
           int select = userService5.select("str");
           assertEquals(10, a);
           assertEquals(10, b);
           assertEquals(10, c);
           assertEquals(10, select);
       }
   }
   ```

## 2.10 Answer接口的使用

1. 使用说明：断言测试时候用不同的参数有不同的返回值，是matchers的增强

2. 代码案例

   ```java
   @RunWith(PowerMockRunner.class)
   @PrepareForTest({UserService5.class,UserDao5.class})
   public class UserService5Test {	
   	@Test
       public void saveAnswer() {
           UserDao5 userDao5 = PowerMockito.mock(UserDao5.class);
           PowerMockito.when(userDao5.select(Mockito.anyString())).then(new Answer<Integer>() {
               @Override
               public Integer answer(InvocationOnMock invocation) throws Throwable {
                   String argument = invocation.getArgument(0);
                   switch (argument){
                       case "a":
                           return 10;
                       case "b":
                           return 20;
                       case "c":
                           return 30;
                   }
                   return null;
               }
           });
           UserService5 userService5 = new UserService5(userDao5);
           int a = userService5.select("a");
           int b = userService5.select("b");
           int c = userService5.select("c");
           assertEquals(10, a);
           assertEquals(20, b);
           assertEquals(30, c);
       }
   }
   ```

## 2.11 Spy接口的使用

1. Spy的作用：通过spy而mock的对象，在断言执行时候，当符合断言规则就不会执行mock对象的方法，否则会执行mock对象的真实的方法，并且spy执行的对象会执行私有方法。

2. 代码案例

   ```java
   MockPrivateClass mockPrivateClass = PowerMockito.spy(new MockPrivateClass());
   
   PowerMockito.when(mockPrivateClass, "privateFunc").thenReturn("test");
   ```

# 第三部分 Mockito

## 3.2 Mockito快速入门

1. 添加依赖

   ```xml
   <dependency>
       <groupId>junit</groupId>
       <artifactId>junit</artifactId>
       <scope>test</scope>
       <version>4.12</version>
   </dependency>
   <dependency>
       <groupId>org.mockito</groupId>
       <artifactId>mockito-all</artifactId>
       <version>1.10.19</version>
       <scope>test</scope>
   </dependency>
   ```

2. mock外部资源的替身

   - 使用@Runner的方式：Mockito.mock()方法将需要Mock的类传入，框架会为该对象创建代理对象，并且代理其行为

     ```java
     @RunWith(MockitoJUnitRunner.class)
     public class Mock01WithRunner {
         @Test
         public void test01() throws Exception {
             EmployeeMapper mapper = Mockito.mock(EmployeeMapper.class);
             // ... ...
         }
     }
     ```

   - 使用initMocks()并注解Annotation的方式

     ```java
     public class Mock02WithAnno {
         @Before
         public void testInit() throws Exception{
             MockitoAnnotations.initMocks(this);
         }
         
         @Mock
         private EmployeeMapper employeeMapper;
         
         @Test
         public void testMock() throws Exception{
             EmployeeDO aaa = employeeMapper.queryEmpDB("aaa");
         }
     }
     ```

