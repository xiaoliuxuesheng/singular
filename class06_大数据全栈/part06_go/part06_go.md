# 环境安装

1. 环境变量:

2. goenv

   - $env:GO111MODULE="on"

   - $env:GOPROXY = "https://proxy.golang.com.cn,direct"

     还可以设置不走 proxy 的私有仓库或组，多个用逗号相隔（可选） 

   - $env:GOPRIVATE = "git.mycompany.com,github.com/my/private"

3. goroot:go的安装目录

4. gopath:go项目所在的路径,现在使用模块化,用go mod管理项目

# 工具配置

1. vocode

   - go
   - code runner

2. 代码组织

   - go使用包和模块组织代码:包对应就是文件夹,模块就是go源文件
   - go项目管理工具:早期使用gopath管理,高版本用过gomod管理项目

3. 项目创建

   - 创建文件夹

   - 初始化项目: go mode init demo01_go

   - 定义包名称: demo01_hello

   - 定义模块名称:case01.go

     ```go
     package demo01_hello
     
     func Hello() string{
     	return "hello GO"
     }
     ```

   - 调用包中的模块:main.go

     ```go
     package main
      
     import "demo01_go/demo01_hello"
     import "fmt"
     func main() {
     	s := demo01_hello.Hello();
     	fmt.Println(s);
     }
     ```

4. go命名规则

   1. 标识符命名规则
      1. 字母、数字、下划线
      2. 不能用数字开头
      3. 区分大小写
   2. 包名称：小写单词，用目录层级分隔，不要用混合大小写命名
   3. 文件名称：小写单词，下划线分隔
   4. 结构体名称：大驼峰命令规则
   5. 接口名称：规定用er作为后缀
   6. 变量命令：小驼峰
   7. 常量：全大小，下划线分隔
   8. 单元测试：Test开头

5. go关键字

6. go变量

   ```go
   // 声明单个
   var name string
   
   // 批量声明
   var (
   	a,
     b,
     c
   )
   
   // 变量初始化
   var name1 = "初始值" // 类型推断
   var name2 string = "初始值"
   
   // 批量初始化
   var name,age = "姓名", 23
   
   // 局部变量声明,必须声明在函数内部
   变量名称 := 变量值
   ```

7. go常量

   ```go
   const 常量名称 [常量类型] = 常量值
   ```

   https://www.bilibili.com/video/BV1zR4y1t7Wj?p=11

8. go变量类型

9. go运算符

10. go流程控制

11. go数组

12. go切片

13. go map

14. go函数

15. go闭包

16. go指针

17. go结构体

18. go继承