- # 第一章 Hexo基础

  ## 1.1 Hexo介绍

  <img width='25px' style="margin-left:15px;bottom:5px;float:left" src="https://s1.ax1x.com/2020/11/06/Bh0IFf.png"/>**快速、简洁且高效的博客框架**

  > Hexo 使用 <a href="https://typora.io/" title="最好用的Markdown编辑工具：官网下载">Markdown </a>解析文章
  >
  > 使用用靓丽的<a href="https://hexo.bootcss.com/themes/" title="hexo 主题列表页">主题</a>生成静态网页

  ## 1.2 Hexo安装环境

  - 核心依赖
    1. Hexo的安装依赖npm环境，所以必须安装node：[下载地址](https://nodejs.org/en)
    2. Hexo的初始化需要借助Git下载相关初始化文件，必须安装Git：[下载地址](https://git-scm.com/download)
  - 辅助工具
    1. Hexo使用Markdow.文件作为文章载体，将文章内容显示为静态网页，推荐Markdow的编辑工具：Typora

  ## 1.3 Hexo的初始化

  1. 下载hexo包：使用npm命令行

     ```sh
     npm install -g hexo-cli		# 全局安装hexo-cli
     npm install hexo			# 对于熟悉 npm 的进阶用户，可以仅局部安装 hexo 包
     ```

  2. 执行hexo命令：下载hexo包后便有了hexo命令工具

     - 方式一：hexo命令在环境变量中，全局安装默认就在环境变量中

       ```sh
       hexo <命令参数>
       ```

     - 方式二：找到命令所在目录，在指定目录执行命令

       ```sh
       npx hexo <命令参数>
       ```

  3. 建立Hexo博客站点

     - 新建站点所在位置的目录；

     - 在站点目录内执行hexo建站指令

       ```sh
       hexo init <站点目录>
       ```

       > - 命令参数：`<站点目录>` 是可选项，如果定义了目录名称，会在当前目录中新建一个站点目录
       > - 建站完成的目录结构
       >   - scaffolds（模板文件夹）：当使用hexo命令新增文章时，根据布局（layout）生成对应模板的文章到对应的目录；①draft.md是指草稿的模板、②page.md、③post.md会被hexo博客解析为文章的的模板
       >     - draft布局：source/\_drafts（通过 `publish` 命令将草稿移动到 `source/_posts` 文件夹）
       >     - page布局：source/
       >     - post布局：source/\_posts（自定义的其他布局和 `post` 相同，都将储存到 `source/_posts` 文件夹）
       >   - source（资源文件夹）：存放文章；除 `_posts` 文件夹之外，开头命名为 `_` (下划线)的文件 / 文件夹和隐藏的文件将会被忽略
       >   - themes（主题）：Hexo 会根据主题来生成静态页面；
       >   - _config.yml：网站的配置信息
       >   - package.json：应用程序的信息

  4. 初体验：使用一个命令在本地浏览器查看初始化的hexo的博客站点

     ```sh
     hexo server
     # 简写为
     hexo s
     ```

  # 第二章 Hexo配置

  ## 2.1 Site网站的个性化描述

  | Site        | 描述                                                         |
  | ----------- | ------------------------------------------------------------ |
  | title       | 网站标题                                                     |
  | subtitle    | 网站副标题                                                   |
  | description | 网站描述，用于SEO，告诉搜索引擎一个关于您站点的简单描述      |
  | keywords    | 网站的关键词。支持多个关键词                                 |
  | author      | 网站作者                                                     |
  | language    | 网站使用的语言。请参考你的主题的文档自行设置，常见的有 `zh-Hans`和 `zh-CN`。 |
  | timezone    | 网站使用的时区，默认为 `计算机的预设置`，中国大陆地区可以使用 `Asia/Shanghai`。 |

  ## 2.2 URL

  | URL                        | 描述                                                         |
  | -------------------------- | ------------------------------------------------------------ |
  | url                        | 网站的网址：必须`http://` or `https://`开头                  |
  | root                       | 网站的根目录， 也是存放文章的目录                            |
  | permalink                  | 文章的链接格式 ，默认为 `:year/:month/:day/:title/`          |
  | permalink_defaults         | 永久链接中每个段的默认值                                     |
  | pretty_urls                | 改写 [`permalink`](https://hexo.bootcss.com/docs/variables.html) 的值来美化 URL |
  | pretty_urls.trailing_index | 是否在永久链接中保留尾部的 `index.html`（默认true）          |

  ## 2.3 Directory

  | 目录         | 描述                                             |
  | ------------ | ------------------------------------------------ |
  | source_dir   | 资源文件夹 ，存放用户的资源文件，默认为 `source` |
  | public_dir   | 公用文件夹 ，存放生成的静态文件，默认为 `public` |
  | tag_dir      | 标签目录 ，默认为 `tags`                         |
  | archive_dir  | 档案目录 ，默认为 `archives`                     |
  | category_dir | 分类目录 ，默认为 `categories`                   |
  | code_dir     | 代码目录 ，默认为 `downloads/code`               |
  | i18n_dir     | i18n目录 ，默认为 `:lang`                        |
  | skip_render  | 储存站长验证文件，跳过指定文件的渲染             |

  ## 2.4 Writing写作设置

  | Setting           | 描述                                            |
  | ----------------- | ----------------------------------------------- |
  | new_post_name     | 文章的文件名格式，默认为 `:title.md`            |
  | default_layout    | 预设的布局模板，默认为 `post`                   |
  | titlecase         | 标题是否使用首字母大写 ，默认为 `false`         |
  | external_link     | 链接是否在新标签页中打开，默认为 `true`         |
  | filename_case     | 将文件名转换为 `1` 小写 或 `2` 大写，默认为 `0` |
  | render_drafts     | 是否显示渲染草稿，默认为 `false`                |
  | post_asset_folder | 是否启用 Asset 文件夹，默认为 `false`           |
  | relative_link     | 是否建立相对于根文件夹的链接，默认为 `false`    |
  | future            | 是否显示未来文章，默认为 `true`                 |
  | highlight         | 代码块设置                                      |
  | enable            | 是否使用代码高亮 ，默认为 `true`                |
  | line_number       | 是否显示行号 ，默认为 `true`                    |
  | auto_detect       | 是否自动检测语言 ，默认为 `false`               |
  | tab_replace       | tab 替代设置                                    |

  ## 2.5 Home page setting首页设置

  | Setting         | 描述                            |
  | --------------- | ------------------------------- |
  | index_generator | 主页设置                        |
  | path            | 首页的根目录                    |
  | per_page        | 每页显示文章的数量，默认为 `10` |
  | order_by        | 显示文章的顺序，默认为 `-date`  |

  ## 2.6 Category & Tag

  | Setting          | 描述                             |
  | ---------------- | -------------------------------- |
  | default_category | 预设分类，默认为 `uncategorized` |
  | category_map     | 分类别名                         |
  | tag_map          | 标签别名                         |

  ## 2.7 Date / Time format

  | Setting     | 描述                          |
  | ----------- | ----------------------------- |
  | date_format | 日期格式，默认为 `YYYY-MM-DD` |
  | time_format | 时间格式，默认为 `HH:mm:ss`   |

  ## 2.8 Pagination分页设置

  | Setting        | 描述                                                        |
  | -------------- | ----------------------------------------------------------- |
  | per_page       | 单个页面上显示的文章数量，默认为 `10` ，用 `0` 表示禁用分页 |
  | pagination_dir | 分页目录，默认为 `page`                                     |

  ## 2.9 Extensions

  | Setting | 描述                               |
  | ------- | ---------------------------------- |
  | theme   | 博客使用的主题，默认为 `landscape` |

  ## 2.10 Deployment部署的配置

  | Setting | 描述         |
  | ------- | ------------ |
  | deploy  | 网站部署配置 |
  | type    | 网站部署类型 |
  | repo    | 网站部署地址 |

  # 第三章 Hexo常用命令

  ## 3.1 hexo init

  ```sh
  hexo init [folder]
  ```

  > - 命令用于初始化本地文件夹为网站的根目录
  > - folder 可选参数，用以指定初始化目录的路径，若无指定则默认为当前目录

  ## 3.2 hexo new

  ```sh
  hexo new [layout] <title>
  ```

  > - `layout` 可选参数，用以指定文章类型，若无指定则默认由配置文件中的 default_layout 选项决定
  > - `title` 必填参数，用以指定文章标题，如果参数值中含有空格，则需要使用双引号包围

  ## 3.3 hexo generate

  ```sh
  hexo generate
  ```

  > - 命令用于生成静态文件，一般可以简写为 `hexo g`
  > - `-d` 选项，指定生成后部署，与 `hexo d -g` 等价

  ## 3.4 hexo server

  ```sh
  hexo server [选项]
  
  # 运行服务器前需要安装 hexo-server 插件
  npm install hexo-server --save
  ```

  > - 用于启动本地服务器，一般可以简写为 `hexo s`,
  > - `-p` 选项，指定服务器端口，默认为 4000
  > - `-i` 选项，指定服务器 IP 地址，默认为 0.0.0.0
  > - `-s` 选项，静态模式 ，仅提供 public 文件夹中的文件并禁用文件监视

  ## 3.5 hexo deploy

  ```sh
  hexo deploy
  ```

  > - 用于部署网站，一般可以简写为 `hexo d`
  > - 部署前需要修改 _config.yml 配置文件，下面以 git 为例进行说明
  >
  > ```yaml
  > deploy:
  > 	type: git
  > 	repo: <repository url>
  > 	branch:	master
  > 	message: 自定义提交消息，默认为Site updated: {{ now('YYYY-MM-DD HH:mm:ss') }}
  > ```

  ## 3.6 hexo clean

  ```sh
  hexo clean
  
  ```

  > - 用于清理缓存文件，是一个比较常用的命令

  # 第四章 主题配置

  ## 4.1 站长统计

  1. 在友盟主页注册账号，并新增应用：网站统计

  2. 输入网站相关数据，获取JavaScript脚本的内容

  3. 在主题的配置文件中开启站点统计

     ```yaml
     # 友盟cnzz统计(url填js代码src链接)
     cnzz:
       enable: true
       url: https://s4.cnzz.com/z_stat.php?id=1279413779&web_id=1279413779
     
     ```

     

  # 第五章 我的文章说明

  ## 5.1 分类

  ## 5.2 标签

  ## 5.3 分类标签规则

  
