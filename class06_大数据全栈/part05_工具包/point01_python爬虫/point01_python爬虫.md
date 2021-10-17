1、爬虫概述

- 什么是爬虫：通过编写程序，模拟浏览器上网，然后去互联网上抓取数据的过程

2、爬虫合法性探究

- 在法律中是不背禁止的，但是操作具有违法风险的进行网络统计属于违法行为；恶意爬虫：干扰了被访问网站的正常运营，抓取了被法律保护的敏感信息；

3、爬虫初探

- 爬虫分类：
  - 通用爬虫：搜索引擎的抓取系统的重要组成部分，抓取的是一整张页面
  - 聚焦爬虫：建立在同用爬虫的基础上，抓取的页面的特点的局部内容
  - 增量爬虫：检测网站中最新更新的数据；
- 爬虫的矛与盾：
  - 互联网的流量50%是由爬虫造成的，有点网站愿意被爬区，但是不愿与被同行所爬取，并且同时又去爬取其他同行的信息。
  - 反爬机制：门户网站制定策略或者技术手段组织爬虫程序进行网站数据的爬取；
  - 反反扒测试：破解反扒机制，获取到网站的相关数据

- robots.txt协议：君子协议，规定网站的哪些内容可以被爬区，哪些不可以被爬区；

4、http和https：超文本传输协议，服务器和客户端进行数据交互的形式，

- 常用请求头信息：
  - User-Agent：表示请求载体的身份表示，
  - Connection：请求完毕后是端口连接还是保持链接；
- 常用响应头信息：
  - Content-Type：服务器响应会客户端的数据类型
- https协议：s表示security；表示是安全的超文本传输协议，https传输会使用到数据加密；加密方式：① 对称加密②非对称加密③证书加密

5、requests模块

- 网络请求模块
  - urllib模块：古老的爬虫模块，操作复杂
  - requests模块的功能：使用简洁，高效，是python中原生的基于网络请求的模块，作用是模拟浏览器发送请求

- 使用方式：模拟浏览器发送请求流程：①指定url②设置请求头③获取响应数据④存储数据

- 环境安装

  ```python
  # 安装requests
  pip install requests
  ```

- 编码案例：爬取一个网页

  ```python
  import requests
  if __name__ == "__main__":
      # 1. 指定url
      url = 'https://www.baidu.com/'
  
      # 2. 发送get请求:url=表示发送的地址,方法返回值是响应对象
      response = requests.get(url=url)
      response.encoding = 'utf-8'
  
      # 3. 获取响应数据
      html = response.text
  
      print(html)
  
      # 4. 持久化存储
      with open('./page/baidu.html','w',encoding='utf-8') as fp: 
          fp.write(html)
          print('爬区数据结束')
  ```

6、案例巩固：

- 需求1：爬区搜狗指定词条对应的搜索结果（简易网页采集器）

  ```python
  # https://www.baidu.com/s?wd=搜索关键字
  param ={
      'wd': 变量
  }
  # 反爬机制 UA 伪装
  header = {
      'User-Agent':'伪装浏览器'
  }
  # 发送get请求带params参数
  requests.get(url = url, params = param, headers = header)
  ```

- 需求2：破解百度翻译，获取到局部数据，获取ajax请

  ```python
  # https://fanyi.baidu.com/?aldtype=16047#en/zh/test
  import requests
  import json
  if __name__ == "__main__":
      # 1. POST请求
      post_url = 'https://fanyi.baidu.com/sug'
      headers = {
          'User-Agent':'Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.62 Safari/537.36'
      }
      # 2. 请求数据
      data = {
          'kw': 'dog'
      }
      # 3. 发送请求
      response = requests.post(url=post_url,data=data,headers=headers)
      json_obj = response.json()
      # 4. 持久化
      fp = open('./page/dog.json','w',encoding='utf-8')
      json.dump(json_obj,fp=fp,ensure_ascii=False)
  
      print('over!')
  ```

- 需求3：爬区豆瓣电影排行榜，判断是静态资源，还是ajax请求

  ```python
  # ajax:https://movie.douban.com/j/chart/top_list?type=13&interval_id=100%3A90&action=&start=0&limit=1
  # GET 请求 多个参数
  ```

- 需求4：爬区肯德基餐厅查询

  

- 需求5：爬区国家药品监督总局化妆品生成许可

2.1、数据解析

- 数据解析分类
  - 正则解析
  - bs4解析
  - xpath通用解析
- 数据解析原理：①加载出整个网页②定位数据存储标签③提取标签中的值

2.2、图片数据爬区

- 下载图片

  ```python
  # 请求图片获取图片内容
  import requests
  if __name__ == "__main__":
      url = 'http://pic.netbian.com/uploads/allimg/170406/164734-149146845438e2.jpg'
      img_data = requests.get(url=url).content
      with open('./page/img.jpg','wb') as fp:
          fp.write(img_data)
          print('over')
  ```

2.3、正则解析

- 

2.4、bs4解析

- bs4概述：实例化一个BeautifulSoup对象，并且将页面源码加载到该对象中，通过调用BeautifulSoup对象中的属性和方法进行标签定位和数据提取

- bs4环境安装

  ```sh
  pip install BeautifulSoup
  pip install lxml
  ```

- 实例化BeautifulSoup

  ```python
  # 实例化BeautifulSoup对象
  fp = open('本地html文档', 'r', encoding = 'utf-8')
  soup = BeautifulSoup(fp, 'lxml')
  
  response_text = requires.get().text
  soup = BeautifulSoup(response_text, 'lxml')
  ```

2.5、bf4相关属性和方法

- BeautifulSoup相关API

  ```python
  # 返回第一个遇到的标签(soup.div)
  soup.tagName
  
  # 根据参数查找:如果是标签名称,返回第一次遇到的标签;
  soup.find('tagName')
  
  # 查找指定属性的标签:_class 查找class属性;_id 查找id属性;attr查找其他属性
  spup.find('tagName',_class='')
  
  # 查找符合要求的所有的标签
  soup.findAll('tagName')
  
  # 定位选择器
  soup.select('选择器')
  
  # 定位层级选择器 大于号是一个层级
  soup.select('选择器 > 选择器 > 选择器')
  
  # 定义层级选择器 空格表示多个层级
  soup.select('选择器 选择器')
  
  # 获取标签的数据
  soup.string			# 获取直系标签内容
  soup.text			# 获取标签内所有内容
  soup.get_text()		# 获取标签内所有内容
  
  # 获取标签的属性
  soup.a['href']
  soup.find('a')['href']
  ```

2.8、xpath

- 最常用，通用，高效的解析器：

- xpath解析原理：①实例化etree对象②将被解析页面加载到额tree对象中③调用etree对象的API定位标签

- 环境的安装

  ```python
  pip install lxml
  from lxml import etree
  ```

- 实例化etree对象

  ```python
  # 加载本地html页面为etree对象
  tree = etree.path("本地html网页地址")
  
  # 加载互联网网页为etree对象
  tree = etree.HTML("response_text")
  ```

2.9、xpath常用API：

- xpath表达式:

  | 表达式                                    | 说明                                                |
  | ----------------------------------------- | --------------------------------------------------- |
  | ./                                        | 表示从当前元素的位置开始读取                        |
  | /                                         | 单个/表示从根节点开始读                             |
  | //                                        | 双//表示从任意节点开始读,如果在路径中间表示多层路径 |
  | //标签[@属性名称=属性值]                  | 属性定位                                            |
  | //父标签[@属性=属性值]/子标签[索引]       | 索引定位，父标签定位到多个子标签，索引从1开始       |
  | //标签[@属性名称=属性值]/text()           | 获取标签的直系内容                                  |
  | //标签[@属性名称=属性值]//text()          | //text()获取标签中后的标签的所有内容                |
  | //标签[@属性名称=属性值]/子标签/@属性名称 | 定位子标签并获取到原始                              |
  | \|                                        | 或表达式，匹配多个xpath表达式                       |

- 使用案例

  ```python
  
  ```

4.1、验证码识别

- 验证码：一般网站制定的反爬机制，部分网页需要登录后才需要可以浏览，人工识别和接口识别

4.2、三方平台验证码识别

- 云打码平台：注册与开发者用户注册

