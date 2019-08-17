# 第一章 数据类型

## 1.1 Typescript的数据类型

### 1. boolean

> 布尔值

### 2. number

> 所有数字都是浮点数:支持十进制和十六进制字面量,以及ECMAScript 2015中引入的二进制和八进制字面量。

### 3. string

> 字符串 
>
> - 可以使用双引号（ `"`）或单引号（`'`）表示字符串
> - 模版字符串 : 可以定义多行文本和内嵌表达式

### 4. 数组类型[]

> - 第一种，可以在元素类型后面接上`[]`
> - 第二种方式是使用数组泛型，`Array<元素类型>`

### 5. *元祖*

> 元组类型允许表示一个已知元素数量和类型的数组，各元素的类型不必相同

```js
let 变量:[类型1,类型2] = [类型1的值,类型2的值];
```

### 6. enum

> 枚举 : 默认从`0`开始为元素编号。 你也可以手动的指定成员的数值

```js
enum Color {Red = 1, Green, Blue}
```

### 7. any

> 不希望类型检查器对这些值进行检查而是直接让它们通过编译阶段的检查。 那么我们可以使用 `any`类型来标记这些变量

### 8. void

> 表示没有任何类型

### 9. `undefined`和`null`

> `undefined`和`null`两者各自有自己的类型分别叫做`undefined`和`null`

### 10. never

> 表示的是那些永不存在的值的类型

### 11. object

> 表示非原始类型，也就是除`number`，`string`，`boolean`，`symbol`，`null`或`undefined`之外的类型

### ▲ 类型断言

- 通过*类型断言*这种方式可以告诉编译器一个实体具有比它现有类型更确切的类型。
- 类型断言类似类型转换，但是不进行特殊的数据检查和解构。 它没有运行时的影响，只是在编译阶段起作用

- 类型断言有两种形式。 其一是“尖括号”语法：

    ```ts
    let someValue: any = "this is a string";
    
    let strLength: number = (<string>someValue).length;
    ```

    另一个为`as`语法：

    ```ts
    let someValue: any = "this is a string";
    
    let strLength: number = (someValue as string).length;
    ```

## 1.2 变量声明

### 1. 声明关键字

- var : 不建议
- let : 词法作用域或块作用域
- const : 拥有与 `let`相同的作用域规则，但是不能对它们重新赋值。

### 2. 变量定义格式

```js
let 变量名: 变量类型 = 变量值;
```

> 使用变量时候需要指明变量的类型

