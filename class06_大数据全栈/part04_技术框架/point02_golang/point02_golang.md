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

## 1.2 基本环境

### <font size=4 color=blue>1. Windows系统</font>

- Windows 下可以使用 .msi 后缀的安装包来安装
- 将安装目录添加到环境变量中：GO+

### <font size=4 color=blue>2. Linux系统</font>

### <font size=4 color=blue>3. Mac系统</font>

## 1.3 开发软件配置

### <font size=4 color=blue>1. Visual Studio</font>

### <font size=4 color=blue>2. IntelliJ GoLand</font>

## 1.4 Go语言结构

### <font size=4 color=blue>1. GO语言语法特征</font>

- 没有对象，没有继承和多态，没有泛型，没有try-cache
- 有接口，有函数式编程，CSP并发模型（gorountine-channel）
- 有编程经验的来说，go语言是另一种标准（重新树立学习观）

## 1.5 Go命令

# 第二章 Go语言基础

## 2.1 关键字和保留字

### <font size=4 color=blue>1. Go语言中标识符</font>

- 只能由字母数字和`_`(下划线）组成，
- 只能以字母和`_`开头

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

| 运算符 | 描述 |
| :----- | :--: |
| +      | 相加 |
| -      | 相减 |
| *      | 相乘 |
| /      | 相除 |
| %      | 求余 |

### <font size=4 color=blue>2. 关系运算符</font>

| 运算符 |                             描述                             |
| :----: | :----------------------------------------------------------: |
|   ==   |    检查两个值是否相等，如果相等返回 True 否则返回 False。    |
|   !=   |  检查两个值是否不相等，如果不相等返回 True 否则返回 False。  |
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

### <font size=4 color=blue>1. 整型</font>

### <font size=4 color=blue>2. 浮点型</font>

### <font size=4 color=blue>3. 复数</font>

### <font size=4 color=blue>4. bool</font>

### <font size=4 color=blue>5. byte</font>

### <font size=4 color=blue>6. rune</font>

### <font size=4 color=blue>7. string</font>

### <font size=4 color=blue>8. 数组</font>

### <font size=4 color=blue>9. 切片</font>

### <font size=4 color=blue>10. map</font>

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
	case 掉价表达式:
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

- for range
- for循环可以通过break、goto、return、panic语句强制退出循环。

### <font size=4 color=blue>4. goto</font>



# 第三章 Go语言函数



# 第四章 内存模型



- 安装：

  - Windows系统

  - Linux系统安装

    - 下载go.xxx.tar.gz文件

    - 将下载好的文件解压到`/usr/local`目录下

    - 配置环境变量： Linux下有两个文件可以配置环境变量，其中`/etc/profile`是对所有用户生效的

      ```sh
      export GOROOT=/usr/local/go
      export PATH=$PATH:$GOROOT/bin
      ```

    - Mac系统

      - 下载可执行文件版，直接点击**下一步**安装即可，默认会将go安装到`/usr/local/go`目录下。
      - 打开终端窗口，输入`go version`命令，查看安装的Go版本

  - 环境变量GOROOT和GOPATH

    - GOROOT：是我们安装go开发包的路径
    - GOPATH：是go项目开发的一个根目录，其中的bin目录是
    - GOPROXY：Go1.14版本之后，都推荐使用`go mod`模式来管理依赖环境了，也不再强制我们把代码必须写在`GOPATH`下面的src目录了，你可以在你电脑的任意位置编写go代码

1. 第一个Go程序

   - 在GOPATH目录下初始化项目目录：① bin表示二进制可执行文件目录  ② pgk最终文件打包目录 ③ src源码目录

   - 在src下定义的是公司域名目录

   - 在公司域名目录下定义的模块目录

   - 早模块下定义go的入口文件：`main.go`文件

     ```go
     package main  // 声明 main 包，表明当前是一个可执行程序
     
     import "fmt"  // 导入内置 fmt 包
     
     func main(){  // main函数，是程序执行的入口
     	fmt.Println("Hello World!")  // 在终端打印 Hello World!
     }
     ```

2. `go build`表示将源代码编译成可执行文件，在模块目录中的命令行中执行

   ```sh
   go build
   ```

   - 或者在其他目录执行以下命令：o编译器会去 `GOPATH`的src目录下查找你要编译的`模块名称`的项目

     ```sh
     go build 模块名称
     ```

   - 编译得到的可执行文件会保存在执行编译命令的当前目录下

3. `go install`表示安装的意思，它先编译源代码得到可执行文件，然后将可执行文件移动到`GOPATH`的bin目录下

   - 跨平台编译：默认我们`go build`的可执行文件都是当前操作系统可执行的文件，只需要指定目标操作系统的平台和处理器架构即可

     > 使用了cgo的代码是不支持跨平台编译的
     >
     > 目标处理器架构是amd64

     - 只需要指定目标操作系统的平台和处理器架构即可

       ```sh
       CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build
       CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build
       ```

     - Linux 下编译 Mac 和 Windows 平台64位可执行程序：

       ```sh
       CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build
       CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build
       ```

     - Windows下编译Mac平台64位可执行程序：

       ```sh
       SET CGO_ENABLED=0 SET GOOS=darwin SET GOARCH=amd64 go build
       SET CGO_ENABLED=0 SET GOOS=linux SET GOARCH=amd64  go build
       ```

4. go的变量与常量

   - **标识符**：Go语言中标识符由字母数字和`_`(下划线）组成，并且只能以字母和`_`开头。

   - **关键字**：是指编程语言中预先定义好的具有特殊含义的标识符。 关键字和保留字都不建议用作变量名。

     | break        | default         | func       | interface   | select     |
     | ------------ | --------------- | ---------- | ----------- | ---------- |
     | **case**     | **defer**       | **go**     | **map**     | **struct** |
     | **chan**     | **else**        | **goto**   | **package** | **switch** |
     | **const**    | **fallthrough** | **if**     | **range**   | **type**   |
     | **continue** | **for**         | **import** | **return**  | **var**    |

   - **保留字**

     - **Constants**：true  false  iota  nil
     - **Types**：int  int8  int16  int32  int64  
                         uint  uint8  uint16  uint32  uint64  uintptr
                         float32  float64  complex128  complex64
                         bool  byte  rune  string  error
     - **Functions**：make  len  cap  new  append  copy  close  delete
                        complex  real  imag
                        panic  recover

   - **变量**：利用变量将这个数据的内存地址保存起来，以后直接通过这个变量就能找到内存上对应的数据了。同一个作用域的变量不能重复声明

     - 标准声明：以关键字`var`开头，变量类型放在变量的后面，行尾无需分号

       ```go
       var 变量名 变量类型
       
       // 案例
       var name string
       var age int
       var isOk bool
       ```

     - 批量声明：每声明一个变量就需要写`var`关键字会比较繁琐，go语言中还支持批量变量声明

       ```go
       var (
           a string
           b int
           c bool
           d float32
       )
       ```

     - 变量初始化：Go语言在声明变量的时候，会自动对变量对应的内存区域进行初始化操作。每个变量会被初始化成其类型的默认值

       ```go
       var 变量名 类型 = 表达式
       
       // 案例一 初始化单个变量
       var name string = "Q1mi"
       var age int = 18
       
       // 案例二 初始化多个变量
       var name, age = "Q1mi", 20
       
       // 案例三 类型推导.编译器会根据等号右边的值来推导变量的类型完成初始化
       var name = "Q1mi"
       var age = 18
       ```

     - 短变量声明：在函数内部，可以使用更简略的 `:=` 方式声明并初始化变量

       ```go
       package main
       
       import (
       	"fmt"
       )
       // 全局变量m
       var m = 100
       
       func main() {
       	n := 10
       	m := 200 // 此处声明局部变量m
       	fmt.Println(m, n)
       }
       ```

     - 匿名变量：在使用多重赋值时，如果想要忽略某个值，可以使用`匿名变量（anonymous variable）`，匿名变量不占用命名空间，不会分配内存，所以匿名变量之间不存在重复声明

       ```go
       func foo() (int, string) {
       	return 10, "Q1mi"
       }
       func main() {
       	x, _ := foo()
       	_, y := foo()
       	fmt.Println("x=", x)
       	fmt.Println("y=", y)
       }
       ```

   - **常量**：常量是恒定不变的值，多用于定义程序运行期间不会改变的那些值。 常量的声明关键字换成了`const`，常量在定义的时候必须赋值。

     - 标准声明

       ```go
       const pi = 3.1415
       ```

     - 批量声明：单独赋值

       ```go
       const (
           pi = 3.1415
           e = 2.7182
       )
       ```

     - 批量声明：批量赋相同的值,如果省略了值则表示和上面一行的值相同

       ```go
       const (
           n1 = 100
           n2
           n3
       )
       ```

     - 常量计数器**iota**：只能在常量的表达式中使用，`iota`在const关键字出现时将被重置为0。const中每新增一行常量声明将使`iota`计数一次(iota可理解为const语句块中的行索引)

       ```go
       // 案例一 产量计数器自增1
       const (
       		n1 = iota //0
       		n2        //1
       		n3        //2
       		n4        //3
       	)
       
       
       // 案例二 常量计数器遇到const重置为0
       const (
       		n1 = iota //0
       		n2 = 100  //100
       		n3 = iota //2
       		n4        //3
       	)
       	const n5 = iota //0
       ```

5. 数据类型

   - 整型

     - 根据长度分类：int8（byte）、int16（shot）、int32（int）、int64（long）
     - 对应的无符号：uint8、uint16、uint32、uint64

   - 浮点型

     - 浮点型类型有：float32、float64
     - 浮点数常量：math.MaxFolat64、math.MaxFloat32

   - 布尔型bool：go中不允许将true与false强制转为数值型，不参与数值运算

   - 字符串string：使用双引号包裹的字符，内部使用UTF8编码，常见转义字符和正则规则相同

     - 定义单行文本

       ```go
       var s = "单行文本"
       ```

     - 定义多行文本

       ```go
       var s = `
       	多行文本
       `
       ```

     - 字符串相关API

       - len(变量)   查看字符串长度
       - 字符变量A + 字符变量B    字符串拼接
         - fmt.Sprintf("%s%s",字符变量A,字符变量B)
       - 

   - 数组

   - 切片

   - 结构体

   - 函数

   - map

   - 通道
