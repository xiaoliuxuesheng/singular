# 第一章 xml文件

## 1.1 什么是xml

xml是可扩展标记语言：开发者在符合xml命名规则的基础上，可以根据自己的需求定义自己的标签；xml的作用主要是用来储存数据的；解析xml的方法主要有：①DOM（原始DOM解析）、②DOM4J（DOM解析的优化）、③SAX（边读边解析）

# 第二章 Dom4j

1. DOM4J解析需要独立的jar包

   ```xml
   <dependency>
       <groupId>org.dom4j</groupId>
       <artifactId>dom4j</artifactId>
       <version>2.1.1</version>
   </dependency>
   ```

2. DOM4J中相关对象说明

   | 对象      | 作用                                       |
   | --------- | ------------------------------------------ |
   | SAXReader | 读取xml文件到Document树结构文件对象        |
   | Document  | 一个xml文档对象树，类比html的树结构        |
   | Element   | 元素节点，通过Document对象可以插在单个元素 |

3. DOM4J解析步骤

   - 创建解析器

     ```java
     SAXReader reader = new SAXReader();
     ```

   - 解析器读取xml文件，生成Document对象

     ```java
     Document doc = reader.read("xxx.xml");
     ```

     ```xml
     <?xml version="1.0" encoding="UTF-8"?>
     <students>
     	<student>
         	<name>张三</name>
             <collage>Java学院</collage>
             <phone>18700134456</phone>
         </student>
     	<student>
         	<name>吴飞</name>
             <collage>Go学院</collage>
             <phone>18700134423</phone>
         </student>
     	<student>
         	<name>李四</name>
             <collage>Python学院</collage>
             <phone>18700134444</phone>
         </student>
     </students>
     ```

   - 使用Document对象读取元素节点

     ```java
     
     ```

     

# 第三章 Sax

1. SAX属于javax扩展包中的提供

2. SAX解析过程

   - 创建SAX解析工厂

     ```java
     SAXParserFactory factory = SAXParserFactory.newInstance();
     ```

   - 使用工厂创建SAX解析器

     ```java
     SAXParser saxParser = factory.newSAXParser();
     ```

   - 

# 第四章 XPath

1. xpath语法：使用路径表达式来选取xml文档中的节点或节点集，节点是通过路径path或步（steps）来选取的

2. 常用的路径表达式

   | 表达式                    | 描述                                               |
   | ------------------------- | -------------------------------------------------- |
   | nodename                  | 选取此节点的所有子节点                             |
   | /<br />/root<br />el/boot | 从根节点选取                                       |
   | //<br />//el<br />el//el  | 从匹配当前节点的选择的文档中的节点，不考虑他的位置 |
   | .                         | 选取当前节点                                       |
   | ..                        | 选取当前节点的父节点                               |
   | @                         | 选取属性                                           |

3. 谓语：用来查找某个特定的节点或者包含某个指定的值的节点。谓语被定义在方括号中

   | 路径表达式           | 说明                                 |
   | -------------------- | ------------------------------------ |
   | path[n]              | 选择符合路径的第n个节点元素          |
   | path[last()]         | 选择符合路径的最后一个节点元素       |
   | path[last()-1]       | 倒数第二个节点元素                   |
   | path[@属性]          | 拥有属性的节点元素                   |
   | path[@属性='属性值'] | 拥有指定属性并且等于指定值的节点元素 |
   | path[@属性>值]       | 跟着属性值的范围查找节点元素         |

4. xpath路径通配符

   | 通配符 | 说明               |
   | ------ | ------------------ |
   | *      | 匹配一个或多个单词 |
   | \|     | and 与并且的意思   |

5. 添加小path依赖

   ```xml
   <dependency>
       <groupId>jaxen</groupId>
       <artifactId>jaxen</artifactId>
       <version>1.1.1</version>
   </dependency>
   ```

   