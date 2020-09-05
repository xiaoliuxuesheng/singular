## 前言

[TOC]

# 第一章 Docsify入门

## 1.1 Docsify是什么

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Docsify是文档站点生成器，可以即时生成文档网站，无需编写html页面，可以智能的加载并解析Markdow文档并显示为网站。通过 Github 进行项目管理，随时随地都可以对文档查阅于修改更新，并维护在Github站点生成开放的博客站点。

## 1.2 Docsify初始化

1. **环境准备**

   - [Git](https://git-scm.com/)：项目版本管理工具；
   - [nodejs](http://nodejs.cn/)：Docsify是一个npm包，需要安装Node环境；
   - [Typora](https://typora.io/)：Markdow文档编辑工具。

2. **下载Docsify**：全局安装

   ```sh
   npm i docsify-cli -g
   ```

3. **初始化**：如果不指定站点路径会在当前目录中初始化，否则会根据站点路径将改目录初始化为Docsify站点

   ```sh
   docsify init [站点路径]
   ```

4. **初始化目录结构说明**

   - `index.html` 作为入口文件

     ```html
     <!DOCTYPE html>
     <html lang="en">
     <head>
         <meta charset="UTF-8">
         <title>Document</title>
         <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
         <meta name="description" content="Description">
         <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
         <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify/lib/themes/vue.css">
     </head>
     <body>
         <div id="app"></div>
         <script>
             window.$docsify = {
                 name: '',
                 repo: '',
             }
         </script>
         <script src="//cdn.jsdelivr.net/npm/docsify/lib/docsify.min.js"></script>
     </body>
     </html>
     ```

   - `README.md` 作为主页

   - `.nojekyll` 防止GitHub Pages忽略以下划线开头的文件

5. **预览网站**

   ```sh
   docsify serve <path> [--open false] [--port 3000]
   ```

   > - --open（-o）：在默认浏览器中打开文档，默认为false
   > - --port（-p）：指定打开端口，默认为3000

6. **新增页面**：

   - 在markdow中引入其他markdow文档，必须以站点的根目录为绝对路径添加文档，格式如下：默认的/可以不加
   
     ```markdown
     [显示名称](/目录/../文档.md)
     ```
   
   - 如果要使用`a`标签链接页面，href属性必须是`#/`开头，从根目录开始加载文件
   
     ```html
     <a href='#/目录/../文档.md'>home</a>
     ```

# 第二章 Docsify配置

## 2.1 指定文档版本

- 发布新的主要版本的docsify（例如`v4.x.x`=> `v5.x.x`）时，都需要手动更新docsify URL 。定期检查docsify网站，以查看是否已发布新的主要版本。在URL（`@4`）中指定主要版本将使您的网站自动获得不间断的增强功能（即“次要”更新）和错误修复（即“补丁”更新）。这是加载文档资源的推荐方法。

  ```html
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify@4/themes/vue.css" />
  <script src="//cdn.jsdelivr.net/npm/docsify@4"></script>
  ```

- 如果您希望将docsify锁定为特定版本，请`@`在URL中的符号后指定完整版本。这是确保您的网站外观和行为相同的最安全的方法，而不管对docsify的未来版本进行任何更改。

  ```html
  <link rel="stylesheet" href="//cdn.jsdelivr.net/npm/docsify@4.11.4/themes/vue.css">
  <script src="//cdn.jsdelivr.net/npm/docsify@4.11.4"></script>
  ```

## 2.2 侧边栏名称

- 定义侧边栏名称

  ```html
  <script>
      window.$docsify = {
          name: '侧边栏标题'
      }
  </script>
  ```

- name-link定义点击侧边栏后跳转的链接

  ```html
  <script>
      window.$docsify = {
        nameLink: '/',
        // 按照路由切换
        nameLink: {
          '/zh-cn/': '/zh-cn/',
          '/': '/'
        }
      }
  </script>
  ```

- 侧边栏logo

  ```html
  <script>
      window.$docsify = {
         logo: '/_media/icon.svg',
      }
  </script>
  ```

  

## 2.2 侧边栏标题配置

- 默认侧边栏的内容为当前打开文档的标题结构，如果需要自定义侧边栏内容，需要添加侧边栏文档`_sidebar.md`以及开启侧边栏配置，侧边栏的内容以列表的markdow语法指定需要显示的内容

  ```html
  <script>
      window.$docsify = {
          loadSidebar: true
      }
  </script>
  ```

- 嵌套侧边栏：可以设置边栏仅通过导航来更新以反映当前目录。可以通过将`_sidebar.md`文件添加到每个文件夹来完成。

  `_sidebar.md`从每个级别目录加载。如果当前目录不存在`_sidebar.md`，它将退回到父目录。例如，如果当前路径为`/guide/quick-start`，`_sidebar.md`则将从中加载`/guide/_sidebar.md`。

## 2.3 侧边栏文档目录

- 创建完成后`_sidebar.md`，边栏内容将根据markdown文件中的标题自动生成。自定义侧边栏后默认不会再生成目录，可以通过设置生成目录的最大层级开启这个功能。

  ```html
  <script>
    window.$docsify = {
      loadSidebar: true,
      subMaxLevel: 2
    }
  </script>
  ```

- maxLevel与subMaxLevel
  - 默认情况下会抓取文档中所有标题渲染成目录，可配置最大支持渲染的标题层级。
  - 配置了侧边栏后渲染的目录被侧边栏自定义，自定义侧边栏后默认不会再生成目录，你也可以通过设置生成目录的最大层级开启这个功能。

  ```html
  <script>
    window.$docsify = {
      maxLevel: 3
    }
  </script>
  ```

## 2.4 导航栏

1. 创建基于HTML的导航栏，文档链接以开头`#/`。

   ```html
   <body>
     <nav>
       <a href="#/">EN</a>
       <a href="#/zh-cn/">中文</a>
     </nav>
     <div id="app"></div>
   </body>
   ```

2. 设置`loadNavbar`为**true**并创建`_navbar.md`文档自定义导航栏，导航栏格式和侧边栏一样，最多可以设置两级结构的列表

   ```html
   <script>
     window.$docsify = {
       loadNavbar: true
     }
   </script>
   ```

## 2.5 封面

1. 配置封面：设置`coverpage`为**true**，并创建一个`_coverpage.md`：

   ```html
   <script>
     window.$docsify = {
       coverpage: true
     }
   </script>
   ```

2. 配置背景：默认情况下，背景颜色是随机生成的。您可以自定义背景色

   ```markdown
   ![color](#f0f0f0)
   ```

## 2.6 GitHub Corner小部件

```html
<script>
    window.$docsify = {
      repo: 'docsifyjs/docsify',
      // or
      repo: 'https://github.com/docsifyjs/docsify/',
    };
</script>
```

## 2.7 切换跳转

- 切换页面后是否自动跳转到页面顶部。

  ```html
  <script>
      window.$docsify = {
        auto2top: true
      }
  </script>
  ```

## 2.8 首页文件

- 设置首页文件加载路径。适合不想将 `README.md` 作为入口文件渲染，或者是文档存放在其他位置的情况使用。

  ```html
  <script>
     window.$docsify = {
        // 入口文件改为 /home.md
        homepage: 'home.md',
        // 文档和仓库根目录下的 README.md 内容一致
        homepage: 'https://raw.githubusercontent.com/QingWei-Li/docsify/master/README.md'
      }
  </script>
  ```

## 2.9 主题颜色

```html
<script>
   window.$docsify = {
       themeColor: '#3F51B5',
   };
</script>
```

## 2.10 屏幕适配

- 在较小的屏幕上，导航栏将与边栏合并。首次加载时候就生效，改变屏幕大小不会自动刷新

  ```html
  <script>
      window.$docsify = {
        mergeNavbar: true,
      };
  </script>
  ```

## 2.11 notFoundPage

- 加载`_404.md`文件

  ```html
  <script>
      window.$docsify = {
        	notFoundPage: true,
          // or
          notFoundPage: 'my404.md',
      };
  </script>
  ```

## 2.12 topMargin

- 滚动内容页面以到达所选部分时，在顶部添加一个空格。如果您使用的是*粘性标头*布局，并且想要将锚点与标头的末尾对齐，这很有用。

  ```html
  <script>
      window.$docsify = {
        	topMargin: 90, // default: 0
      };
  </script>
  ```

# 第三章 插件

## 3.1 emoji插件结合

1. 在index.html中引入插件

   ```html
   <script src="//cdn.jsdelivr.net/npm/docsify/lib/plugins/emoji.min.js"></script>
   ```

2. 在markdow中使用emoji符号

   ```markdown
   * [:us:, :uk:](/)
   * [:cn:](/zh-cn/)
   ```

## 3.2 代码高亮

- 内置的代码高亮工具是 [Prism](https://github.com/PrismJS/prism)，默认支持 CSS、JavaScript 和 HTML。如果需要高亮其语言——例如 PHP——可以手动引入代码高亮插件。

  ```html
  <script src="https://unpkg.com/prismjs/components/prism-bash.js"></script>
  <script src="https://unpkg.com/prismjs/components/prism-java.js"></script>
  <script src="https://unpkg.com/prismjs/components/prism-sql.js"></script>
  ```

## 3.3 搜索

1. 添加搜索插件

   ```html
   <script src="//cdn.jsdelivr.net/npm/docsify/lib/plugins/search.min.js"></script>
   ```

2. 设置搜索属性

   ```html
   <script>
       window.$docsify = {
         	search: {
               placeholder: '搜索',
               noData: '找不到结果',
           }
       };
   </script>
   ```

   - placeholder：搜索框占位符
   - noData：查找没有结果时候的提示语句

## 3.4 快捷复制代码

```html
<script src="//cdn.jsdelivr.net/npm/docsify-copy-code"></script>
```

## 3.5 图片预览模式

```html
<script src="//cdn.jsdelivr.net/npm/docsify/lib/plugins/zoom-image.min.js"></script>
```

## 3.6 文档分页提示

```html
<script src="//cdn.jsdelivr.net/npm/docsify-pagination/dist/docsify-pagination.min.js"></script>
```



# 第四章 部署

## 4.1 部署到Github

- 可以直接把文档网站部署到 GitHub Pages 或者 VPS 上。

