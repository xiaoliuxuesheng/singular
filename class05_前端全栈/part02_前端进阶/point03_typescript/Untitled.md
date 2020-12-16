01、TS简介

- JavaScript存在的问题
  - 变量弱类型语言；
  - 函数参数类型不明确；
- 微软公司开发Typescript，
  - 解决JavaScript存在的问题，是基于JavaScript对JavaScript的增强
  - 兼容JavaScript所支持的平台
  - Typescript不能被js解析器直接执行，需要使用ts编译器将ts文件编译为js脚本，从而在浏览器中执行；
  - 丰富的配置选项：可以编译为任意版本js；
  - 强大的开发工具

02、TS环境搭建

1. 下载、安装Node.js

2. 全局安装Typescript

   ```sh
   npm install -g typescript
   ```

3. 创建ts文件

4. 编译ts文件为js文件

   ```sh
   tsc xxx.ts
   ```

03，04、TS类型声明

- 类型声明：通过类型声明可以在TS中指定变量、形参的类型；类型指定后会检查赋值的类型

  ```js
  let 变量: 类型;
  
  // 声明变量时候赋值时候可以是省略变量类型
  let 变量: 类型 = 值;
  
  // 声明联合类型
  let 变量: 类型A | 类型B;
  
  // 类型断言
  变量A = 变量B as string
  变量A = <string>变量B
  
  function fn(参数: 类型, 参数: 类型): 返回类型A| 返回值类型B{
  }
  
  // 类型别名
  type 名称 = 具体的类型;
  let 变量: 别名
  ```

- TS所支持的类型：建议使用小写

  | 类型        | 说明                               | 举例                                           |
  | ----------- | ---------------------------------- | ---------------------------------------------- |
  | **number**  | 任意数字                           |                                                |
  | **string**  | 任意字符串，单引号、双引号、反引号 |                                                |
  | **boolean** | 布尔值                             |                                                |
  | **void**    | 表示空，undefined                  | 设置函数没有返回值                             |
  | never       | 没有值，不是任何值                 | js中的抛出的异常没有返回值                     |
  | **array**   | 任意js数组                         |                                                |
  | tuple       | 固定长度数组                       | TS新类型：[3,2]                                |
  | **object**  | 任意js对象                         |                                                |
  | **enum**    | 枚举                               | TS新类型：enum{A,B}                            |
  | any         | 任意类型                           | 表示关闭类型检查，<br />可以赋值给任意类型变量 |
  | unknown     | 类型安全的any                      | unknown类型变量不能赋值给其他类型变量          |

  > - object：可以是一个JS中的自定义类型，一般是约束对象中的属性，
  >
  >   ```js
  >   let obj:{属性: 类型};	// 用来指定对象中可以包含哪些属性
  >   
  >   let obj:{属性?: 类型};	// 属性后的问号表示是可选属性
  >   
  >   let obj:{属性: 类型,[属性: 类型]: any};	// []中表示任意类型的属性 
  >            
  >   let fun: (参数:类型) => 返回值类型;	// 箭头函数约束函数对象
  >   ```
  >
  > - array：声明类型是数组，可以约束数组中的值
  >
  >   ```js
  >   let a:string[] 			// 表达方式一 表示是一个字符串数组
  >   
  >   let arr:Array<String>	// 表达方式二 表示是一个字符串数组
  >   ```
  >
  > - tuple：名称是元祖，表示固定长度的数组
  >
  >   ```js
  >   let 元祖: [类型1,类型2]		// 只能保存两个元素,并指定定类型
  >   ```
  >
  > - enum：枚举
  >
  >   ```js
  >   // 定义枚举
  >   enum 枚举名称{
  >       枚举A,枚举B
  >   }
  >   ```

05，06，07，08、编译选项

- 自动编译：检视指定文件并且当文件发生改变时候回触发文件的自动编译

  ```sh
  tsc xxx.ts -w	
  ```

- 添加tsc配置文件：

  - tsconfig.json

    ```json
    {
        "include":['包含的文件路径'],		// ** 表示任意目录,*表示任意文件
        "exclude":["需要排除的文件路径"],
        "extends":["定义被继承的文件"],
        "files":["指定被编译文件列表,只有需要编译的文件少的时候才会用到这个配置"],
        "compilerOptions":{		// 编译器的选项完成对编译的配置,错误的值会有代码提示
            "target":"设置ts代码编译的目标版本,默认ES3/ES5/ES6(ES2016)/ES2017... .../ESNext",
            "module":"模块化的方案:es6es2016/commonjs",
            "lib":["指定代码运行时候包含的库,可选值ES3/ES5/ES6(ES2016)/ES2017... .../ESNext/DOM"],
            "outDir":"编译后js文件的存储位置",
            "outFile":"编译后将代码合并为一个文件,指定文件名称,多个模块不能合并",
            "allowjs":true|false,	// 是否包含js文件
            "checkjs":true|false,	// 检查js代码是否符合js代码
            "removeComments":true|false,	// 编译是否移除注释
            "noEmit":true|false,	//是否生成编译后的文件
            "noEmitOnError":true|false,	//当产生错误时候不会编译产生文件
            "alwaysStrict":true|false,	//用来设置编译后的文件是否是严格模式,默认是false,有模块自动就是严格模式
            "noImplicitAny":true|false,	// 不指定类型时是否运行使用隐式any
            "noImplicitThis":true|false,	//是否运行不明确类型的this
            "strictNullCheck":true|false,	//是否严格检查空值
            "strict":true|false,	//所有严格检查的总开关,一般开发中设置为true
        }
    }
    ```

  - 执行tsc命令

    ```sh
    tsc -w
    ```

09、webpack打包ts文件

- 

12、面向对象

1. 类

   ```js
   // 定义对象
   class 类名{
       属性名:类型;
   
   	// 构造方法
   	constructor(参数: 类型){
       	this.属性 = 参数;
       }
   	
   	方法名(形参:类型):返回值{
           return ;
       }
   }
   ```

2. 