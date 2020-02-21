# 第三章 gitbook基本应用

## 3.1 初始化书籍

1. 新建文件夹 : 保存书籍内容文件

2. 在书籍文件夹中使用命令构建书籍基本结构

   ```sh
   gitbook init
   ```

   - 执行完后会生成两个文件 : `README.md` 和 `SUMMARY.md`
   - README.md : 表示说明文件 ;
   - SUMMARY.md ： 摘要, 书籍的目录结构在这里配置

3. 配置摘要基本格式

   ```sh
   # 目录
   
   * [结构内容](存放结构的文件路径)
   ```

   > 列表 + 超链接的格式配置摘要
   >
   > 超链接的链接是摘要的对应的文件位置

4. 根据摘要构建书籍

   ```sh
   gitbook init
   ```

## 3.2 gitbook预览

1. 使用浏览器服务预览书籍

   ```sh
   gitbook serve --port 端口号
   ```

   - --port 端口号` : 可以省略(默认端口号4000)
   - 浏览器访问路径 : `http://localhost:4000`

2. 生成PDF文档

   ```sh
   gitbook pdf 书籍目录 文档存放目/文档名称.pdf
   ```

3. 生成 epub 格式的电子书

   ```sh
   gitbook epub 书籍目录 文档存放目/文档名称.epub
   ```

4. 生成 mobi 格式的电子书

   ```sh
   gitbook mobi 书籍目录 文档存放目/文档名称.mobi
   ```

5. 生成的静态网站输出到 _book 目录

   ```sh
   gitbook build [书籍路径] [输出路径]
   ```

# 