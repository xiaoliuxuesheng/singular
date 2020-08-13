https://www.bilibili.com/video/BV14C4y147y8?p=1

# 第一章 Go语言

## 1.1 基本介绍

- **GO语言应用领域**

  <img src="https://s1.ax1x.com/2020/05/18/YWVumF.png" alt="YWVumF.png" border="0" />

- **GO语言特点**

  - **Go语言为并发而生**：硬件制造商正在为处理器添加越来越多的内核以提高性能，但是，大多数现代编程语言（如Java，Python等）都来自90年代的单线程环境。虽然一些编程语言的框架在不断地提高多核资源使用效率，例如 Java 的 Netty 等，但仍然需要开发人员花费大量的时间和精力搞懂这些框架的运行原理后才能熟练掌握。Go语言在多核并发上拥有原生的设计优势，Go语言从底层原生支持并发，无须第三方库、开发者的编程技巧和开发经验。
  - **Go性能强悍**：Go语言也是编译型的语言，它直接将人类可读的代码编译成了处理器可以直接运行的二进制文件，执行效率更高，性能更好。
  - **Go语言简单易学**：语法简洁Go 语言的风格类似于C语言。其语法在C语言的基础上进行了大幅的简化，去掉了不需要的表达式括号，循环也只有 for 一种表示方法，就可以实现数值、键值等各种遍历。
  - **代码风格统一**：Go 语言提供了一套格式化工具——`go fmt`。一些 Go 语言的开发环境或者编辑器在保存时，都会使用格式化工具进行修改代码的格式化
  - **开发效率高**：Go语言实现了开发效率与执行效率的完美结合，让你像写Python代码（效率）一样编写C代码（性能）

- **下载地址**

  - **官网**：https://golang.org/dl/
  - **镜像**：https://golang.google.cn/dl/
  
- 文档

  - https://studygolang.com/pkgdoc

## 1.2 基本环境

### <font size=4 color=blue>1. Windows系统</font>

- Windows 下可以使用 .msi 后缀的安装包来安装
- 将安装目录添加到环境变量中
  - GOLANNG_HOME=安装包根目录
  - Path=%GOLANNG_HOME%\bin
  - GOPATH=是 Go语言中使用的一个环境变量，它使用绝对路径提供项目的工作目录
  - Path=%GOPATH%\bin

### <font size=4 color=blue>2. Linux系统</font>

### <font size=4 color=blue>3. Mac系统</font>

## 1.3 开发软件配置

### <font size=4 color=blue>1. Visual Studio</font>

- **插件安装**

  - go

- **公共代理镜像**

  ```sh
  go env -w GO111MODULE=on
  go env -w GOPROXY=https://goproxy.io,direct		# 学习初期执行这一条就可以
  
  # 设置不走 proxy 的私有仓库，多个用逗号相隔（可选）
  go env -w GOPRIVATE=*.corp.example.com
  
  # 设置不走 proxy 的私有组织（可选）
  go env -w GOPRIVATE=example.com/org_name
  ```

- **go代码片段设置**

  1. Ctrl + P 或者 Command+Shift+P：弹出命令输入框
  2. 输入：>snippets
  3. 选择：首选项：配置用户代码片段：弹出模块选择窗口
  4. 输入：g，选择go模板
  5. 弹出go.json文件，根据注释中模板添加自动以模板

  ```json
  {
  	"println":{
  		"prefix": "pln",
  		"body":"fmt.Println($0)",
  		"description": "println"
  	},
  	"printf":{
  		"prefix": "plf",
  		"body": "fmt.Printf(\"$0\")",
  		"description": "printf"
  	}
  }
  ```

### <font size=4 color=blue>2. IntelliJ GoLand</font>

## 1.4 Go依赖管理

## 1.5 Go Module

## 1.6 Go命令

1. go build：表示将源代码编译成可执行文件，可以使用`-o`参数来指定编译后得到的可执行文件的名字，后缀必须是exe
2. go run go脚本：直接执行脚本中的main函数中的代码
3. go install：示安装的意思，它先编译源代码得到可执行文件，然后将可执行文件移动到`GOPATH`的bin目录下

> - go文件执行流程分析
>   - 源文件 -> go build（编译）-> 生成可执行文件ext -> 运行 -> 获取结果
>   - 源文件 -> go run（编译运行） -> 获取结果
> - 区别
>   - 编译生成的可执行文件exe可以在非go环境中执行
>   - 编译运行只可以在具有go运行环境的机器才可以执行
>   - 在编译时，编译器会将程序运行的库文件包含在可执行文件中，所以可执行文件提交较大

## 1.7 跨平台编译

- 只需要指定目标操作系统的平台和处理器架构即可

  ```sh
  SET CGO_ENABLED=0  // 禁用CGO
  SET GOOS=linux  // 目标平台是linux
  SET GOARCH=amd64  // 目标处理器架构是amd64
  ```

- Mac 下编译 Linux 和 Windows平台 64位 可执行程序

  ```sh
  CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build
  CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build
  ```

- Linux 下编译 Mac 和 Windows 平台64位可执行程序：

  ```bash
  CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build
  CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build
  ```

- Windows下编译Mac平台64位可执行程序：

  ```bash
  SET CGO_ENABLED=0
  SET GOOS=darwin
  SET GOARCH=amd64
  go build
  ```

## 1.8 Hello World

1. **程序示例**

   ```go
   package main
   // 单行注释
   import "fmt"
   
   /**
    * 多行注释
    * main()方法是程序执行的入口
    */
   func main() {
   	fmt.Println("Hello World!")
   }
   ```

   > 1. package main：main包会编译为执行二进制文件，非main包是用于封装功能
   >
   > 2. main()：是执行的入口函数，
   >
   > 3. 在函数外只能作为标识符的声明，只能使用var关键字声明标识符

2. **单行注释和多行注释**

3. **开发注意事项**

   - go源文件必须是`.go`作为文件扩展标识符
   - go语言严格区分大小写
   - go方法由一条条语句构成，每个语句后不需要添加分号，提现go语言的简洁性
   - 在go语言中定义变量或引入的包必须使用，否则编译不通过

4. go语言代码风格

   - 缩进有严格要求
   - 运算符的两边严格规定有空格

5. 包和函数：import表示引入一个包，包中可以定义多个go文件，import这个包后就可以使用这个包中的文件中的函数了

6. doc操作指令

   - cd：切换目录
   - md：创建文件夹
   - dir：查看列表
   - rd：删除空目录
   - echo：输出内容
   - `>`：添加内容
   - `>>`：追加
   - copy：拷贝文件
   - del：删除文件
   - cls：清屏
   - exit：退出

# 第二章 Go语言基础

## 2.1 关键字和保留字

### <font size=4 color=blue>1. Go语言中标识符</font>

- 只能由字母数字和`_`(下划线）组成；
- 只能以字母和`_`开头；
- go推荐使用驼峰命名的方式定义标识符。

### <font size=4 color=blue>2. 内置关键字</font>

| break        | default         | func       | interface   | select     |
| ------------ | --------------- | ---------- | ----------- | ---------- |
| **case**     | **defer**       | **go**     | **map**     | **struct** |
| **chan**     | **else**        | **goto**   | **package** | **switch** |
| **const**    | **fallthrough** | **if**     | **range**   | **type**   |
| **continue** | **for**         | **import** | **return**  | **var**    |

### <font size=4 color=blue>3. 保留字</font>

- **Constants**：true、false、iota、nil

- **Types**

  | int         | int8        | int16         | int32          | int64       |
  | ----------- | ----------- | ------------- | -------------- | ----------- |
  | **uint**    | **uint8**   | **uint16**    | **uint32**     | **uint64**  |
  | **float32** | **float64** | **complex64** | **complex128** | **uintptr** |
  | **bool**    | **byte**    | **rune**      | **string**     | **error**   |

- **Functions**

  | make     | len       | cap         | new         | append   |
  | -------- | --------- | ----------- | ----------- | -------- |
  | **copy** | **close** | **delete**  | **complex** | **real** |
  | **imag** | **panic** | **recover** |             |          |

## 2.2 操作符

### <font size=4 color=blue>1. 算术运算符</font>

| 运算符 |     描述     |
| :----- | :----------: |
| +      |     相加     |
| -      |     相减     |
| *      |     相乘     |
| /      | 相除返回整数 |
| %      | 求余返回余数 |

### <font size=4 color=blue>2. 关系运算符</font>

| 运算符 |                             描述                             |
| :----: | :----------------------------------------------------------: |
|   ==   |    检查两个值是否相等，如果相等返回 True 否则返回 False。    |
|   !=   | 检查两 个值是否不相等，如果不相等返回 True 否则返回 False。  |
|   >    |  检查左边值是否大于右边值，如果是返回 True 否则返回 False。  |
|   >=   | 检查左边值是否大于等于右边值，如果是返回 True 否则返回 False。 |
|   <    |  检查左边值是否小于右边值，如果是返回 True 否则返回 False。  |
|   <=   | 检查左边值是否小于等于右边值，如果是返回 True 否则返回 False。 |

### <font size=4 color=blue>3. 逻辑运算符</font>

| 运算符 |                             描述                             |
| :----: | :----------------------------------------------------------: |
|   &&   | 逻辑 AND 运算符。 如果两边的操作数都是 True，则为 True，否则为 False。 |
|  \|\|  | 逻辑 OR 运算符。 如果两边的操作数有一个 True，则为 True，否则为 False。 |
|   !    | 逻辑 NOT 运算符。 如果条件为 True，则为 False，否则为 True。 |

### <font size=4 color=blue>4. 位运算符</font>

| 运算符 |                             描述                             |
| :----: | :----------------------------------------------------------: |
|   &    |    参与运算的两数各对应的二进位相与。 （两位均为1才为1）     |
|   \|   |  参与运算的两数各对应的二进位相或。 （两位有一个为1就为1）   |
|   ^    | 参与运算的两数各对应的二进位相异或，当两对应的二进位相异时，结果为1。 （两位不一样则为1） |
|   <<   | 左移n位就是乘以2的n次方。 “a<<b”是把a的各二进位全部左移b位，高位丢弃，低位补0。 |
|   >>   | 右移n位就是除以2的n次方。 “a>>b”是把a的各二进位全部右移b位。 |

###  <font size=4 color=blue>5. 赋值运算符</font>

| 运算符 |                      描述                      |
| :----: | :--------------------------------------------: |
|   =    | 简单的赋值运算符，将一个表达式的值赋给一个左值 |
|   +=   |                  相加后再赋值                  |
|   -=   |                  相减后再赋值                  |
|   *=   |                  相乘后再赋值                  |
|   /=   |                  相除后再赋值                  |
|   %=   |                  求余后再赋值                  |
|  <<=   |                   左移后赋值                   |
|  >>=   |                   右移后赋值                   |
|   &=   |                  按位与后赋值                  |
|  \|=   |                  按位或后赋值                  |
|   ^=   |                 按位异或后赋值                 |

## 2.3 数据类型

### <font size=4 color=blue>1.1 整型</font>

- 整型分为以下两个大类： 
  - 按长度分为：int8、int16、int32、int64 
  - 对应的无符号整型：uint8、uint16、uint32、uint64

- 其中，`uint8`就是我们熟知的`byte`型，`int16`对应C语言中的`short`型，`int64`对应C语言中的`long`型。

|  类型  | 描述                                                         |
| :----: | :----------------------------------------------------------- |
| uint8  | 无符号 8位整型 (0 到 255)                                    |
| uint16 | 无符号 16位整型 (0 到 65535)                                 |
| uint32 | 无符号 32位整型 (0 到 4294967295)                            |
| uint64 | 无符号 64位整型 (0 到 18446744073709551615)                  |
|  int8  | 有符号 8位整型 (-128 到 127)                                 |
| int16  | 有符号 16位整型 (-32768 到 32767)                            |
| int32  | 有符号 32位整型 (-2147483648 到 2147483647)                  |
| int64  | 有符号 64位整型 (-9223372036854775808 到 9223372036854775807) |

### <font size=4 color=blue>1.2 特殊整型</font>

> 在使用`int`和 `uint`类型时，不能假定它是32位或64位的整型，而是考虑`int`和`uint`可能在不同平台上的差异。

|  类型   | 描述                                                   |
| :-----: | :----------------------------------------------------- |
|  uint   | 32位操作系统上就是`uint32`，64位操作系统上就是`uint64` |
|   int   | 32位操作系统上就是`int32`，64位操作系统上就是`int64`   |
| uintptr | 无符号整型，用于存放一个指针                           |

### <font size=4 color=blue>2. 浮点型</font>

| 类型    | 描述                                                         |
| ------- | ------------------------------------------------------------ |
| float32 | 最大范围约为 `3.4e38`，可以使用常量定义：`math.MaxFloat32`   |
| float64 | 最大范围约为 `1.8e308`，可以使用一个常量定义：`math.MaxFloat64` |

### <font size=4 color=blue>3. 复数</font>

| 类型       | 描述               |
| ---------- | ------------------ |
| complex64  | 实部和虚部为32位   |
| complex128 | 实部和虚部为64位。 |

### <font size=4 color=blue>4. bool</font>

- `bool`类型进行声明布尔型数据，布尔型数据只有`true（真）`和`false（假）`两个值。
  - 布尔类型变量的默认值为`false`。
  - Go 语言中不允许将整型强制转换为布尔型.
  - 布尔型无法参与数值运算，也无法与其他类型进行转换。

### <font size=4 color=blue>5. string</font>

- Go语言中的字符串以原生数据类型出现，字符串的内部实现使用`UTF-8`编码。 字符串的值为`双引号(")`中的内容，可以在Go语言的源码中直接添加非ASCII码字符

- **字符串转义符**

  | 转义符 | 含义                               |
  | :----: | :--------------------------------- |
  |  `\r`  | 回车符（返回行首）,不换行          |
  |  `\n`  | 换行符（直接跳到下一行的同列位置） |
  |  `\t`  | 制表符                             |
  |  `\'`  | 单引号                             |
  |  `\"`  | 双引号                             |
  |  `\\`  | 反斜杠                             |

- **多行字符串**：要定义一个多行字符串时，就必须使用`反引号`字符

  ```go
  s1 := `第一行
  第二行
  第三行
  `
  ```

- **字符串的常用操作**

  | 方法                                | 介绍           |
  | :---------------------------------- | :------------- |
  | len(str)                            | 求长度         |
  | +或fmt.Sprintf                      | 拼接字符串     |
  | strings.Split                       | 分割           |
  | strings.contains                    | 判断是否包含   |
  | strings.HasPrefix                   | 前缀判断       |
  | strings.HasSuffix                   | 后缀判断       |
  | strings.Index()                     | 子串出现的位置 |
  | strings.LastIndex()                 | 子串出现的位置 |
  | strings.Join(a[]string, sep string) | join操作       |

### <font size=4 color=blue>6. byte rune</font>

- 组成每个字符串的元素叫做“字符”，可以通过遍历或者单个获取字符串元素获得字符。 字符用单引号（’）包裹起来
- Go 语言的字符有以下两种
  - `uint8`类型，或者叫 byte 型，代表了`ASCII码`的一个字符。
  - `rune`类型，代表一个 `UTF-8字符`，实际是一个`int32`。

```go
// 遍历字符串
func traversalString() {
	s := "hello沙河"
	for i := 0; i < len(s); i++ { //byte
		fmt.Printf("%v(%c) ", s[i], s[i])
	}
	fmt.Println()
	for _, r := range s { //rune
		fmt.Printf("%v(%c) ", r, r)
	}
	fmt.Println()
}
```

### <font size=4 color=blue>7. 数组</font>

- 数组的特点：是同一种数据类型元素的集合，数组是值类型

- 数组的定义：数组长度是数据类型的一部分，定义数组时候必须指定初始化数组的长度

  ```go
  var 变量名 [长度]原型类型;
  ```

- 数组初始化：如果不初始化，数组中元素默认为该类型的零值；

  ```go
  arr = [数组长度]数据类型{元素};		// 格式一：常规初始化
  arr = [...]数据类型{元素};	   	   // 格式二：根据元素推断出数组长度
  arr = [数组长度]数据类型{索引:元素}	   // 格式三：根据指定索引初始化数组
  ```

- 数据遍历

  - for
  - for-range

- 二维数组

  ```go
  var 数组变量 [数组长度][单个元素数组中元素个数]数据类型
  ```

### <font size=4 color=blue>8. 切片slice</font>

- 切边概述：因为数组长度固定并且是数据类型的一部分，所以数组的局限性很大；切片（slice）是一个拥有相同类型元素的可变长度的序列；他是基于数组的一层封装，一般用于快速的操作一块数据集合；特点是：①切片灵活、支持自动扩容②切片是引用类型，内部包含`地址`、`长度`、`容量`；切片的本质就是一个指针，指向了一块连续的内存，是引用类型，真实数据在底层数组中；

- 切片的定义：切片定义和数组定义类似，但是特点是片的长度不需要声明

  ```go
  var 变量名 []数据类型
  ```

- 切片初始化：初始化切片时候切片的长度属性不需要指定，切片定义不添加元素默认值是nil，nil值的切片没有底层数组；一个nil值的切片的长度和容量都是0，但是反之不成立；

  ```go
  arr := []数据类型{元素};
  ```

- 切片容量和长度

  - 长度：len()是指切片中元素的数量
  - 容量：cap()切片第一个元素对应的底层数组到数组最后的元素数量

- 从数组中切割得到切片：

  ```go
  arr := [6]int{1,2,3,4,5,6}
  sli := arr[0:3]
  ```

  > - 根据索引切割数组：左包含右不包含
  > - 如果左索引不指定默认是0；如果右索引不指定默认值是数组长度；

- 切片再切片

  ```go
  
  ```

- 使用make函数构造切片

  ```go
  make([]切片类型,长度,容量)
  ```

- 切片的常用操作

  | API                                        | 说明                                       |
  | ------------------------------------------ | ------------------------------------------ |
  | 切片变量 = append(切片变量,"新增元素",...) | 想切片追加变量必须用原变量接收追加后的结果 |
  | copy(target,source)                        | 将source的切片元素拷贝到target是切片中     |

  

### <font size=4 color=blue>9. map</font>

- map的特点
  - 是go语言提供的映射关系的容器，其内部是使用散列函表（hash）实现
  - map是一种无序基于`key-value`的数据结构，map是引用类型，必须初始化才能用

- map的定义

  - 先定义后初始化

    ```go
    // map定义格式
    var 变量名 = map[key类型]值类型
    
    // map初始化
    m = make(map[string]int, 3)
    
    // 赋值
    变量名[key] = value
    ```

  - 直接初始化

    ```go
    mm := make(map[string]bool, 5)
    mm["bool"] = true
    fmt.Println(mm)
    ```

- map遍历：range

- map中删除key

  ```go
  delete(map变量,key)
  ```

### <font size=4 color=blue>10. 指针</font>

- 指针概述：go语言中不需要操作指针，指针的作用一：&获取变量地址；作用二：*根据地址获取值

  ```go
  n := 23
  m := &n
  fmt.Println(m)
  fmt.Printf("%T", m)
  
  p := *m
  fmt.Println(p)
  ```

- 指针特点

  - *int：表示int类型的指针
  - 对变量进行取址（&）操作，可获得这个变量的指针变量
  - 指针变量的值是指针地址
  - 对指针变量进行取址操作（*），可以获得指针变量的原始变量值

## 2.4 基本语法

### <font size=4 color=blue>1. if条件语句</font>

```go
if 表达式1 {
    分支1
} else if 表达式2 {
    分支2
} else{
    分支3
}
```

- go语言格式说明：规定与`if`匹配的左括号`{`必须与`if和表达式`放在同一行，`{`放在其他位置会触发编译错误

### <font size=4 color=blue>2. switch条件语句</font>

```go
switch {
	case 条件表达式:
		fallthrough
	default:
		// 
}
```

- go中默认每个case默认break
- fallthrough语法可以执行满足条件的case的下一个case

### <font size=4 color=blue>3. for遍历语句</font>

```go
for 初始语句;条件表达式;结束语句{
    循环体语句
}

// for循环的初始语句可以被忽略，但是初始语句后的分号必须要写
i := 0
for ; i < 10; i++ {
    fmt.Println(i)
}

// for循环的初始语句和结束语句都可以省略
i := 0
for i < 10 {
    fmt.Println(i)
    i++
}
```

> for循环可以通过break、goto、return、panic语句强制退出循环。

### <font size=4 color=blue>5. for range</font>

```go
ss := "仅仅字符串"
for i, v := range ss {
    fmt.Printf("%d %c", i, v)
    fmt.Println("")
}
```

### <font size=4 color=blue>4. goto</font>

### <font size=4 color=blue>5. make</font>

- make&new：make也是用来分配内存的，区别于new，它只用于slice、map、chan的内存创建，而且他的返回值类型就是这三个基本类型本身，而不是他们的指针地址，因为这三个类型本身就是引用类型，所以没有必要返回他们的指针了

  ```go
  func make(T type,size...IntegerType) Type
  ```

- 使用示例

  ```go
  
  ```

## 2.6 变量与常量

### <font size=4 color=blue>1. 标准变量声明</font>

```go
var 变量名 变量类型 = 值
```

> - 在函数外部声明标识符必须是：var、const、func关键字开头
> - 如果声明全局变量（定义在函数外部的变量），声明变量后可以不使用，定义在函数内部的变量必须使用；
> - 如果声明变量（全局或局部变量）后立即赋值，变量类型可以根据变量的值进行类型推导，变量的类型**必须**省略不写；
> - 如果声明变量（全局或局部变量）后没有立即赋值，变量类型必须声明；
> - 同一个作用域的变量不能重复声明；

### <font size=4 color=blue>2. 局部变量（短变量）</font>

```go
func main() {
	n := 10
	m := 200 
	fmt.Println(m, n)
}
```

> - 只能在函数内部声明局部变量
> - 在函数内部，使用更简略的 `:=` 方式，声明后必须初始化变量

### <font size=4 color=blue>3. 变量批量声明</font>

- **批量声明后批量赋值**：必须使用var关键字，在函数内或函数外声明方式相同

  ```go
  var x,
  	y,
  	z = 1,
  	2,
  	3
  ```

- **批量声明不立即赋值**：声明变量后不赋值必须指定变量的类型

  ```go
  var (
      a string
      b int
      c bool
      d float32
  )
  ```

- **批量声明变量并赋值**：可以指定变量类型或可以由根据变量的值推导出变量类型

  ```go
  var (
  	aa string = "aa"
  	bb        = 23
  	cc        = true
  	dd        = 23.23
  )
  ```

- **在函数内部批量声明**：函数内部可以使用短变量声明格式，省略var关键字和数据类型

  ```go
  func main() {
  	a, b := 23, 23
  	fmt.Println(a, b)
  }
  ```

### <font size=4 color=blue>4. 变量的初始值</font>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Go语言在声明变量的时候，会自动对变量对应的内存区域进行初始化操作。每个变量会被初始化成其类型的默认值，例如： 整型和浮点型变量的默认值为`0`。 字符串变量的默认值为`空字符串`。 布尔型变量默认为`false`。 切片、函数、指针变量的默认为`nil`。

### <font size=4 color=blue>5. 匿名变量</font>

- 在使用多重赋值时，如果想要忽略某个值，可以使用`匿名变量（anonymous variable）`。 匿名变量用一个下划线`_`表示

  ```js
  func main() {
  	x, _ := 1,2
  	_, y := 4,7
  	fmt.Println("x=", x)
  	fmt.Println("y=", y)
  }
  ```

### <font size=4 color=blue>6. 常量</font>

- **常量定义**：常量的声明和变量声明非常类似，只是把`var`换成了`const`，常量在定义的时候必须赋值。

  ```go
  const pi = 3.1415
  const e = 2.7182
  onst (
      pi = 3.1415
      e = 2.7182
  )
  ```

- **常量赋值说明**：const同时声明多个常量时，如果省略了值则表示和上面一行的值相同

  ```go
  // 常量n1、n2、n3的值都是100
  const (
      n1 = 100
      n2
      n3
  )
  ```

### <font size=4 color=blue>5. iota</font>

- `iota`是go语言的常量计数器，只能在常量的表达式中使用。使用iota能简化定义，在定义枚举时很有用。

  - `iota`在const关键字出现时将被重置为0。
  - const中每新增一行常量声明将使`iota`计数一次(iota可理解为const语句块中的行索引)。 

  ```go
  const (
      a1 = 12				// 12 被赋值的
      a2 = 12				// 12 被赋值的
      a3 = iota			// 2 -- const关键字出现时将被重置为0m,所以第一个位置的a1的iota=0
      a4					// 3
      a5					// 4
  )
  // a = iota + 1 所以c = iota + 1;e = iota + 1;
  const (
      a, b = iota + 1, iota + 2 //1,2	-- iota第一行a=0,b计数一次=1
      c, d                      //2,3 -- iota第二行c=1 , d= 1+2
      e, f                      //3,4
  )
  ```

## 2.7函数

1. 函数：go语言中支持函数、匿名函数、闭包，并且函数在go语言中属于一等公民

2. 函数定义：使用func关键字

   ```go
   func 函数名称(形参名称 形参类型,...)(返回值 返回值类型,...){
   	// 函数体
   }
   ```

   > 命名返回值：作用是在函数中声明了一个变量，这个变量可以在函数中使用；使用后return关键字后的变量可以省略
   >
   > 不命名返回值：直接指定返回值类型
   >
   > 没有返回值，返回值括号可以省略
   >
   > 如果有多个返回值，返回值括号不能省略，接受返回值也要多个变量
   >
   > 没有参数，参数的括号不拿个能省略
   >
   > 多个参数类型相同，参数类型可以简写为1个，用逗号分隔
   >
   > 可变长参数：变量...类型，定义在最后，可以接受多个参数，切片类型

# 第三章 Go常用标准库

## 3.1 fmt

## 3.2 strings

> 

| API                                                          | 说明                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| <span title='fmt.Println(strings.EqualFold("Go", "go")) // true'>func EqualFold(s, t string) bool</span> | 判断两个utf-8编码字符串是否相同<br /> - 将unicode大写、小写、标题三种格式字符视为相同 |
| <span title='fmt.Println(strings.HasPrefix("aaa", "aa")) // true'>func HasPrefix(s, prefix string) bool</span> | 判断s是否有前缀字符串prefix。                                |
| func HasSuffix(s, suffix string) bool                        | 判断s是否有后缀字符串suffix。                                |
| <span title='fmt.Println(strings.Contains("seafood", "foo")) // true'>func Contains(s, substr string) bool</span> | 判断字符串s是否包含子串substr。                              |
| func ContainsRune(s string, r rune) bool                     | 判断字符串s是否包含utf-8码值r。                              |
| <span title='fmt.Println(strings.ContainsAny("failure", "u & i")) // true'>func ContainsAny(s, chars string) bool</span> | 判断字符串s是否包含字符串chars中的任一字符。                 |
| func Count(s, sep string) int                                | 返回字符串s中有几个不重复的sep子串。                         |
| func Index(s, sep string) int                                |                                                              |



# 第四章 数据库相关

# 第五章 Web开发相关

# 第六章 常用组件和技巧

# 第七章 GORM教程