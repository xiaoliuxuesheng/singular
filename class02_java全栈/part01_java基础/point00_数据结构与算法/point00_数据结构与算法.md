# 前言

1. 面试题：字符串匹配：又一个字符串A与一个子串B，判断A中是否包含B，并且返回第一次出现B的位置
   - 方式一：暴力匹配
   - 方式二：KMP算法，部分匹配表
2. 汉诺塔游戏：采用分治算法
3. 八皇后算法：回溯算法，八颗旗子在8*8的棋盘任意两个不能在同一个行、列、交叉线；问：有多少种摆法
4. 马踏棋盘：骑士周游：一个旗子随机放在8*8的棋盘，走日字，要求每个棋盘格子走一次，要走完所有格子要多少步
   - 采用图的深度优化遍历算法DFS+贪心算法优化

# 课程内容

- 程序=算法+数据结构
- 课程内容
  1. 数据结构：线性与非线性
  2. 数组：数组和稀疏数组
  3. 链表：单向链表、双向链表、环形链表，约瑟夫问题
  4. 栈：前缀、后缀、中缀、逆序
  5. 递归
  6. 排序：八大排序算法：①冒泡②插入③归并④选择⑤快速⑥堆排序⑦基数排序⑧
  7. 时间复杂度
  8. 查找算法
  9. 哈希表：hashMap
  10. 树：结构与算法
  11. 图
  12. 程序员十大算法

# 学习笔记

- 数据结构与算法的重要性：有些问题要选择合适的数据结构，有些问题除了需要合适的数据结构外还需要针对这个结构选择合理的算法才能解决

- 数据结构分类：线性和非线性

  1. 线性：特点是数据元素之间存在一对一的线性关系，有两种不同的储存结构：顺序存储和链表存储，链表储存的元素会保存一份相邻元素的引用；常见的线性结构：数组、队列、栈、链表
  2. 非线性：二维数组、多维数组、广义表、树、图

- 稀疏数组

  - 使用场景：有些数据是保存在二维数组中，存在的问题：如果二维数组很大，保存的数据很少，二维数组中会有大量的初始值，浪费空间，可以采用稀疏数组解决

  - 什么是稀疏数组：也是一个二维数组，这个二维数组每一行保存四列：①序号②元素在二维数组中所在的行③元素在二维数组中所在的列④元素的值；原来二维数组中有多少个元素就保存多少行，从而减少二维数组的规模

  - 编程实现：二维数组和稀疏数组相互转换

    ```java
    ```

- 队列：

  - 特点：遵循先进先出原则：是一个有序列表，可以用数组或链表实现，

  - 功能分析：

    1. 是有序表：用maxSize属性表示链表中最大元素个数
    2. 队列的输入是有序表的后端：输入位置用rear表示
    3. 队列的输出是有序表的前端：输出位置用front表示
    4. 队列的常用操作：①打印队列信息②元素入队③元素出队

  - （数组）编码实现：①属性定义②方法定义与实现

    ```java
    ```

  - （链表）编码实现

    ```java
    ```

- 