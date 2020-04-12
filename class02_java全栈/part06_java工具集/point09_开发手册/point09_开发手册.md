# 名称解释



# 〇、Git标准

<font color=red>**【强制】**</font>Git用户名规范：姓名工号

```sh
git confit user.name '姓名工号'
git config user.email '工作邮箱'
```

<font color=red>**【强制】**</font>Git中的开发分支名称：项目编号；开发代码只能在提交在开发分支，开发完成后合并到ST、UAT、然后发布

<font color=red>**【强制】**</font>Git代码提交的注释内容格式：分支名称（项目编号） #comment 提交说明

```sh
git commit -m 'T1955532 #comment 代码说明'
```

<font color=green>**【推荐】**</font>在代码提交前先使用git stash命令将本地未提交代码暂存在堆栈，保证本地代码与远程代码同步后再从堆栈中获取出修改的代码并提交（避免因为代码提交后与远程代码发生冲突导致提交历史中额外的合并节点）

```sh
git stash
git stash pop

git stath list
git stash clean
```

# 一、Java开发规范

## 1.1 命名规范

### <font size=4>1、命名要求</font>

- <font color=red>**【强制】**</font>代码开发中命名只可以使用字母、数字、下划线
- <font color=red>**【强制】**</font>禁止使用数字和下划线开头
- <font color=red>**【强制】**</font>禁止使用下划线结尾
- <font color=red>**【强制】**</font>禁止下划线和下划线中间只出现数字
- <font color=green>**【推荐】**</font>命名中不推荐使用美元符号($)
- <font color=red>**【强制】**</font>禁止使用中文命名，禁止英文和拼音混合命名
  - 英文除了国际通用简写，英文命令避免简写方式命名；
  - 拼音除了国际通用的拼音，避免使用拼音和汉语首字母的组合；
- <font color=red>**【强制】**</font>驼峰风格的命名要求
  - 类名使用 UpperCamelCase 风格，但以下情形例外： DO / BO / DTO / VO / AO
    / PO / UID 等 
  - 方法名、参数名、成员变量、局部变量都统一使用 lowerCamelCase 风格，必须遵
    从驼峰形式
- <font color=red>**【强制】**</font>常量统一使用大写字母，单词之间用下划线分隔
- <font color=red>**【强制】**</font>数组的表示格式规定类型与中括号紧挨相连，例如：String[] strs;
- <font color=green>**【推荐】**</font>命名要做到望文知义，尽量使用完整的单词组合来表达其含义
- <font color=green>**【推荐】**</font>接口中的方法和常量不要使用任何修饰符，保持代码的简洁性，并在需要在抽象方法上标注javaDoc注释
- <font color=green>**【推荐】**</font>尽量不要在接口中定义常量：如果一定要定义变量，必须是与接口相关并且是整个应用的基础常量
- <font color=green>**【推荐】**</font>接口和实现类的命名规范有两套
  - 接口命名：如果是形容能力的接口名称，取对应的名称作为接口名（通常是-able的形容词）
  - 接口实现类命名：对于Service和DAO类，基于SOA理念，暴露出的服务一定是接口，内部的实现类用Impl作为后缀

### <font size=4>2、业务类命名规范</font>

- <font color=red>**【强制】**</font>包名必须使用小写字母，是一个自然语义的单数英文单词
- <font color=red>**【强制】**</font>抽象类用Abstract或Base开头；Abstract主要用于方法的延迟实现，Base是对公共属性的抽取
- <font color=red>**【强制】**</font>异常类统一使用Exception结尾
- <font color=red>**【强制】**</font>配置类统一使用Config结尾
- <font color=red>**【强制】**</font>测试类统一使用Test结尾
- <font color=red>**【强制】**</font>系统相关处理器对象使用Handler结尾
- <font color=red>**【强制】**</font>业务相关处理器对象使用Controller结尾
- <font color=red>**【强制】**</font>业务逻辑处理对象使用Service结尾
- <font color=red>**【强制】**</font>数据访问对象使用Dao结尾
- <font color=red>**【强制】**</font>工具类统一使用Util结尾
- <font color=red>**【强制】**</font>过滤器类统一使用Filter结尾
- <font color=red>**【强制】**</font>拦截器统一使用Interceptor结尾
- <font color=red>**【强制】**</font>AOP切面列统一使用Aspect结尾
- <font color=green>**【推荐】**</font>如果模块、接口、类、方法上使用了设计模式，则用设计模式结尾

### <font size=4>3、领域模型对象</font>

- <font color=red>**【强制】**</font>数据对象：XxxDO
- <font color=red>**【强制】**</font>数据传输对象：XxxDTO
- <font color=red>**【强制】**</font>展示对象：XxxVO
- <font color=red>**【强制】**</font>枚举对象：XxxEnum

### <font size=4>4、领域模型属性规范</font>

- <font color=red>**【强制】**</font>POJO布尔值类型都不要加is前缀，否则部分框架解析会引起序列化错误
- <font color=red>**【强制】**</font>禁止在子父类的成员变量之间、或这不同代码块的局部变量之间采用完全相同的命名，降低了可读性

### <font size=4>5、约定方法名称</font>

- <font color=green>**【推荐】**</font>获取单个对象的方法用get前缀
- <font color=green>**【推荐】**</font>获取多个对象的方法用list做前缀，并且用复数形式结尾
- <font color=green>**【推荐】**</font>获取统计值的方法用count做前缀
- <font color=green>**【推荐】**</font>新增对象的方法用save | insert做前缀
- <font color=green>**【推荐】**</font>删除的方法用remove | delete做前缀
- <font color=green>**【推荐】**</font>修改的方法用update做前缀

## 1.2 常量定义

<font color=red>**【强制】**</font>不允许任何魔法值出现在代码中

<font color=red>**【强制】**</font>对long或Long型赋值时，数值后必须使用大写的L，小写容易和数字1混合

<font color=red>**【强制】**</font> 不要使用一个类维护常量，要按常量的功能进行分类，分开维护

- 跨应用共享常量：放在二方库中的constant目录中
- 应用内共享常量：放在一方库中的模块的constant目录中
- 子工程共享常量：在当前子工程的constant目录中
- 包内共享常量：在当前包的constant目录中
- 类内共享常量：在类内部使用private static final 定义

## 3. 代码格式

<font color=red>**【强制】**</font> IDEA统一编码格式为UTF8，IDE 中文件的换行符使用 Unix 格式，不要使用 Windows 格式 

<font color=red>**【强制】**</font> 采用4个空格作为缩进，禁止使用Tab建缩进，IDEA编辑器将Tab建改为4个空格的设置：Editor | Code Style | Java | Tabs and Indents

- IDEA请勿勾选Use tab character
- 设置Tab size = 4

<font color=red>**【强制】**</font> 在运算符的左右两边都需要增加一个控空格

<font color=red>**【强制】**</font> 单行字符数限制不超过 120 个，超出需要换行，换行时遵循如下原则：

- 第二行相对第一行缩进 4 个空格，从第三行开始，不再继续缩进
- 运算符与下文一起换行。
- 方法调用的点符号与下文一起换行。
- 方法调用中的多个参数需要换行时， 在逗号后进行。
- 在括号前不要换行

<font color=red>**【强制】**</font> 方法参数在定义和传入时，多个参数逗号后边必须加空格 

<font color=green>**【推荐】**</font> 单个方法的总行数不要多余80行：除注释之外的方法签名、左右大括号、方法内代码、空行。回车以及不可见字符的总行数不超过80行

<font color=green>**【推荐】**</font> 不同逻辑、不同语义、不同业务的代码直接插入一个空行分隔开来以提升代码可读性

## 4. OOP规约

<font color=red>**【强制】**</font>所有的覆写方法，必须加@Override 注解。 

<font color=red>**【强制】**</font>外部正在调用或者二方库依赖的接口，不允许修改方法签名，避免对接口调用方产
生影响。接口过时必须加@Deprecated 注解，并清晰地说明采用的新接口或者新服务是什
么 

<font color=red>**【强制】**</font>不能使用过时的类或方法。 

<font color=red>**【强制】**</font>所有整型包装类对象之间值的比较， 全部使用 equals 方法比较。 

<font color=red>**【强制】**</font> 为了防止精度损失， 禁止使用构造方法 BigDecimal(double)的方式把 double 值转化为 BigDecimal 对象 

## 5. 集合处理

## 6. 并发处理

<font color=red>**【强制】**</font> 获取单例对象要保证线程安全，其中的方法也是线程安全；

<font color=red>**【强制】**</font> 创建线程或线程池时候请指定有意义的线程名称，方便出错时候回溯

```java
public class TimeTaskThread() extends Thread {
    public TimeTaskThread() {
    	super.setName("TimeTaskThread");
    }
}
```

<font color=red>**【强制】**</font> 线程资源必须通过线程值提供，不允许在应用中自行显示创建线程；

<font color=red>**【强制】**</font> 线程池不允许使用Executors去创建，而是要用ThreadPoolExecutor的方式，这样的处理方式让写的同学更加明确线程池的运行规则，避免资源耗尽的风险；

- 说明：Executors返回线程池对象的弊端

  - FixedThreadPool 和 SingleThreadExecutor ： 允许请求的队列长度为 Integer.MAX_VALUE,可能堆积大量的请求，从而导致OOM。
  - CachedThreadPool 和 ScheduledThreadPool ： 允许创建的线程数量为 Integer.MAX_VALUE ，可能会创建大量线程，从而导致OOM。

- 说明：ThreadPoolExecutor的构造方法

  ```java
  public class ThreadPoolExecutor extends AbstractExecutorService {
  
  	// 其中一个构造方法：newFixedThreadPool时调用的
      public ThreadPoolExecutor(int corePoolSize,
                                int maximumPoolSize,
                                long keepAliveTime,
                                TimeUnit unit,
                                BlockingQueue<Runnable> workQueue) {
          this(corePoolSize, maximumPoolSize, keepAliveTime, unit, workQueue,
               Executors.defaultThreadFactory(), defaultHandler);
      }
  }
  ```

  > - corePoolSize：在线程池中保持的线程的数量，即使是这些线程没有被使用，除非设置了线程超时时间
  > - maximumPoolSize：最大线程数量，当workQueue队列已满，放不下新的任务，再通过execute添加新的任务则线程池会再创建新的线程，线程数量大于corePoolSize但不会超过maximumPoolSize，如果超过maximumPoolSize，那么会抛出异常，如RejectedExecutionException。
  > - keepAliveTime和unit：当线程池中线程数量大于workQueue，如果一个线程的空闲时间大于keepAliveTime，则该线程会被销毁。unit则是keepAliveTime的时间单位。
  > - workQueue：阻塞队列，当线程池正在运行的线程数量已经达到corePoolSize，那么再通过execute添加新的任务则会被加到workQueue队列中，在队列中排队等待执行，而不会立即执行。

<font color=red>**【强制】**</font> SimpleDateFormat是线程不安全的类，一般不要定义为static变量

## 7. 控制语句

## 8. 注释规约

<font color=red>**【强制】**</font> 类、类属性、类方法的注释必须使用Javadoc规范，使用多行注释的方式，不可以使用单号注释的方式

- 所有抽象方法除了使用Javadoc规范外，需要完善返回值、参数、异常等说明，还需要说明实现的功能
- 如果代码中返回值、参数、异常等做了修改，必须同步修改注释内容

<font color=red>**【强制】**</font> 单行注释在注释语句上方另起一行，不建议在代码后面添加注释，注释内容与双斜线有且只有一个空格

<font color=green>**【推荐】**</font> 在Javadoc注释中可以不用指定作者和日期，在Idea编辑器中，可以使用Git中的功能查看的提交人员和提交日期

<font color=green>**【推荐】**</font> 注释内容建议使用中文注释，如果没有国外开发人员参与

<font color=green>**【推荐】**</font> 注释力求精简准确、表达到位，避免过多的无用注释

- 好的命名规范在一定程度也可以替代部分简单注释内容

<font color=green>**【推荐】**</font> 注释中的特殊标记，请注明标记人和标记时间，并及时处理这些标记

- 代办事宜（TODO）：（标记人 标记时间 预处理时间）表示需要实现但未实现的功能
- 错误（FIXME）：（标记人 标记时间 预处理时间）表示标记代码是错误的，需要纠正的

## 9. 其他

# 二、异常日志

# 三、单元测试

# 四、安全规约

# 五、数据库

## 1. 建表规约

<font color=red>**【强制】**</font>  命名规范：表名和字段名只能用小写字母、下划线或数值

- 禁止数字和下划线开头
- 禁止两个下划线中间只出现数字

> - MySql在Windows系统中是不区分大小写的，但是在Linux系统中是区分大小写的，为避免系统兼容问题
> - Oracle是严格区分大小写的，未使用双引号时默认全部大写。？

<font color=red>**【强制】**</font>  表名不使用复数名词

> 表名应该仅仅表示表中的实体内容，而不是表中是数量

<font color=red>**【强制】**</font>  SQL中约束的命名规范

- 主键索引命名：pk_约束名称
- 唯一索引命名：uk_约束名称
- 普通索引命名：idx_约束名称

## 2. 索引规约

<font color=red>**【强制】**</font>  业务上具有唯一特性的字段，即时是多个字段的组合，也必须建成唯一索引。

> 唯一索引会影响insert的速度，这个影响是可以忽略的，而且唯一索引可以提高查找效率；即时在代码层面对数据唯一性做了校验，根据墨菲定律，必然会有脏数据的产生。

## 3. SQL规约

## 4. 数据规范

<font color=red>**【强制】**</font> 

# 六、工程结构



# 七、设计规约

<font color=red>**【强制】**</font> 存储方案和底层数据结构的设计必须评审，评审通过后将相关资料沉淀为文档。

- 存储方案表示的是架构设计的复杂度，对项目后期的数据安全性和稳定性负责；数据结构是程序开发的基石，数据结构的缺陷会直接导致系统的风险上升：可扩展性和可维护性的成本增加；
- 评审内容包括不限于：①存储介质、表结构是否满足技术需求；②技术方案、存取性能、和存储空间是否满足业务需求；③表、字段名称、字段类型、索引等表的关键属性之间的关系是否满足扩展性

<font color=red>**【强制】**</font> 在需求分析阶段，如果与系统交互的User超过一类并且相关的User Case超过5个，使用用例图来表达更清晰的结构化需求。

<img src="https://s1.ax1x.com/2020/04/12/GOaG9S.png" alt="GOaG9S.png" border="0" />

<font color=red>**【强制】**</font> 如果某个业务对象的状态超过3个，需要使用对应的**状态图**表达并且明确说明状态变化的各种触发条件

- **说明**：状态图的核心是对象状态，首先明确对象由多少中状态，然后明确两两状态直接是否存在直接的转换关系，再明确触发状态转换的条件是什么

<font color=red>**【强制】**</font> 如果系统中某个功能的调用链路上涉及的对象超过3个，需要使用**时序图**来表达并且明确各个调用环节的输入与输出

<font color=red>**【强制】**</font> 如果系统中模型类超过 5 个，并且存在复杂的依赖关系，使用**类图**来表达并且明确类之间的关系 

<font color=red>**【强制】**</font> 如果系统中超过 2 个对象之间存在协作关系，并且需要表示复杂的处理流程，使用**活动图**来表示 

<font color=green>**【推荐】**</font> 需求分析与系统设计在考虑主干功能的同时，需要充分评估异常流程与业务边界。 

<font color=green>**【推荐】**</font> 类在设计与实现时要符合单一原则。

- 单一原则最易理解却是最难实现的一条规则，随着系统演进，很多时候，忘记了类设计的初衷  

<font color=green>**【推荐】**</font> 谨慎使用继承的方式来进行扩展，优先使用聚合/组合的方式来实现。

- 不得已使用继承的话，必须符合里氏代换原则，此原则说父类能够出现的地方子类一定能够出现 