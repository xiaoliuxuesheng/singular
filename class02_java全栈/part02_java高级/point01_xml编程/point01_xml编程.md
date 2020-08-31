# 第一章 Java与XMl

## 1.1 XML概述

- xml是可扩展标记语言：开发者在符合xml命名规则的基础上可以根据自己的需求定义自己的标签
- xml主要作用：用来存储数据
- xml标记最基本格式：标签必须成对出现，如果需要自定义标签需要指定约束文件

## 1.2 解析XML的方法

- DOM：一次将文件加载进内存后读取，
- DOM4J：是对DOM封装
- SAX：事件驱动型，解析方式是边读边解析

# 第二章 Dom4j解析XML

## 2.1 基本介绍

- 添加依赖

  ```java
  
  ```

- Dom4j中常用对象

  - SAXReader：读取XML文件封装为Document树结构的文件对象
  - Document：是一个xml文档对象数据
  - Element：元素节点，通过Document对象可以查找单个元素

- Dom4j解析步骤

  1. 创建解析器：SAXReader reader = new SAXReader();
  2. 通过解析器获取Document：Document doc = reader.read("");
  3. 获取xml的根节点：Element root = doc.getRootElement();

## 2.2 解析案例



# 第三章 JAXB

## 3.1 导读

-  JAXB 作为JDK的一部分，能便捷地将Java对象与XML进行相互转换，JAXB为XML节点和属性提供提供了各种面向对象的处理方式，可以基于注解或适配器将XML转换为Java对象。

- O/X Mapping：Object/XML Mapping 指XML文档与Java对象之间的映射关系

  - JAXB
  - XMLBeans
  - JiBX
  - Castor
  - XStream

- JAXB 转换：我们将Java对象转换为XML的过程称之为`Marshal`，将XML转换为Java对象的过程称之为UnMarshal

- JAXB相关的重要类与接口

  | 名称         | 作用v                                |
  | ------------ | ------------------------------------ |
  | JAXBContext  | 应用的入口，用于管理XML/Java绑定信息 |
  | Marshaller   | 将Java对象序列化为XML数据            |
  | Unmarshaller | 将XML数据反序列化为Java对象          |

## 3.2 简单的转换案例

1. Java 对象转 XML

   - 定义Java对象@XmlRootElement：JAXB 转换对象必须拥有无参数构造器

     ```java
     @XmlRootElement
     public class Student {
         private String id;
         private String name;
         private Integer age;
     }
     ```

   - 转换

     ```java
     public static void javaToxml(Student stu) throws Exception {
         // 获取JAXB的上下文环境，需要传入具体的 Java bean -> 这里使用Student
         JAXBContext context = JAXBContext.newInstance(Student.class);
         // 创建 Marshaller 实例
         Marshaller marshaller = context.createMarshaller();
         // 设置转换参数 -> 这里举例是告诉序列化器是否格式化输出
         marshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, Boolean.TRUE);
         // 构建输出环境 -> 这里使用标准输出，输出到控制台Console
         PrintStream out = System.out;
         // 将所需对象序列化 -> 该方法没有返回值
         marshaller.marshal(stu, out);
     }
     ```

2. XML 转 Java 对象

   - 定义xml字符串或文件

   - 转换

     ```java
     public static void xmlTojava() throws Exception {
         // 获取JAXB的上下文环境，需要传入具体的 Java bean -> 这里使用Student
         JAXBContext context = JAXBContext.newInstance(Student.class);
         // 创建 UnMarshaller 实例
         Unmarshaller unmarshaller = context.createUnmarshaller();
         // 加载需要转换的XML数据 -> 这里使用InputStream，还可以使用File，Reader等
         InputStream stream = 
             SimpleTest.class.getClassLoader().getResourceAsStream("lesson1.xml");
         // 将XML数据序列化 -> 该方法的返回值为Object基类，需要强转类型
         Student stu = (Student) unmarshaller.unmarshal(stream);
         // 将结果打印到控制台
         System.out.println(stu);
     }
     ```

## 3.3 JAXB注解说明

1. @XmlRootElement：类级别的注解。将类映射为xml全局元素，也就是根元素。如果要使用 JAXB ，则该注解必不可少
   - 参数 name属性用于指定生成元素的名字，若不指定，默认使用类名小写作为元素名
   - 参数 namespace属性用于指定生成的元素所属的命名空间。
2. @XmlType
   - 参数定义XML Schema中type的名称
   - 参数 namespace指定Schema中的命名空间
   - 参数 propOrder指定映射XML时的节点顺序
   - 参数 factoryClass指定UnMarshal时生成映射类实例所需的工厂类，默认为这个类本身
   - 参数 factoryMethod指定工厂类的工厂方法
3. @XmlAccessorType：类级别的注解。定义这个类中的何种类型需要映射到XML
    - 参数 value可以接受4个指定值：

      - XmlAccessType.FIELD：映射这个类中的所有字段到XML
      - XmlAccessType.PROPERTY：映射这个类中的属性（get/set方法）到XML
      - XmlAccessType.PUBLIC_MEMBER：将这个类中的所有public的field或property同时映射到XML（默认）
      - XmlAccessType.NONE：不映射
4. @XmlElement：字段，方法，参数级别的注解。该注解可以将被注解的（非静态）字段，或者被注解的get/set方法对应的字段映射为本地元素，也就是子元素。
   - 参数 name用于指定映射时的节点名称，若不指定，默认使用方法名小写作为元素名
   - 参数 namespace指定映射时的节点命名空间
   - 参数 required字段是否必须，默认为false
   - 参数 nillable是否处理空数据，默认为false
   - 参数 type定义该字段或属性的关联类型
5. @XmlAttribute
   - 参数 name用于指定映射时的节点属性名称，若不指定，默认使用方法名小写作为元素名。
   - 参数 namespace指定映射时的节点属性命名空间
   - 参数 required该属性是否必须，默认为false
6. @XmlTransient：定义某一字段或属性不需要被映射。
7. @XmlElementWrapper：为数组元素或集合元素定义一个父节点。List元素需要使用`@XmlElementWrapper`，否则外围解析可能不正常。
8. @XmlJavaTypeAdapter：自定义某一字段或属性映射到XML的适配器。

## 3.4 Trang的使用

- 获取到 schema 文件

## 3.5 xjc 将schema 文件转化为 Java bean

## 3.6 解读 JAXBContext

- JAXBContext 是整个 JAXB API 的入口。主要用来构建 JAXB 实例（newInstance()），并提供与XML/Java绑定信息相关的抽象，如编组（createMarshaller()）、解组（createUnmarshaller()）和验证（createValidator()）

1. newInstance()：

   ```java
   // 传入特定的class
   JAXBContext instance = JAXBContext.newInstance(Student.class);
   
   // 如果存在同名的Java对象，则可以指定完整路径
   JAXBContext instance = JAXBContext.newInstance(com.example.bean.Student.class);
   
   // 如果有多个对象需要注册
   JAXBContext instance = JAXBContext.newInstance(Student.class, Teacher.class);
   
   // 可以对某一个package包下所有的对象编组：我们需要在对应的包中创建一个jaxb.index文件，然后在其中指定创建JAXBContext时需要用到的Class，每个Class名称占一行。否则，会报错 
   JAXBContext instance = JAXBContext.newInstance("com.example.bean");
   
   // 甚至对多个package包下所有的对象编组：
   JAXBContext instance = JAXBContext.newInstance("com.example.bean:com.example.pojo");
   ```

2. createMarshaller()：创建一个Marshaller对象，用于将Java内容转换为XML数据。

3. createUnmarshaller()：创建一个可以用来将 XML 数据转换为 java 内容树的 Unmarshaller 对象。 

4. createBinder()：创建一个可用于关联/原地解组/编组操作的 Binder 对象。如果不传参数，默认使用W3C DOM创建一个Binder。