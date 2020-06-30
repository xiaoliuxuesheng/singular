# 第一章 EasyExcel入门

## 1.1 EasyExcel概述

​        EasyExcel是一个基于Java的简单、省内存的读写Excel的开源项目。在尽可能节约内存的情况下支持读写百M的Excel。

​        Java解析、生成Excel比较有名的框架有Apache poi、jxl。但他们都存在一个严重的问题就是非常的耗内存，poi有一套SAX模式的API可以一定程度的解决一些内存溢出的问题，但POI还是有一些缺陷，比如07版Excel解压缩以及解压后存储都是在内存中完成的，内存消耗依然很大。

​        easyexcel重写了poi对07版Excel的解析，能够原本一个3M的excel用POI sax依然需要100M左右内存降低到几M，并且再大的excel不会出现内存溢出，03版依赖POI的sax模式。在上层做了模型转换的封装，让使用者更加简单方便。

## 1.2 EasyExcel的基本使用

1. 添加EasyExcel依赖

   ```xml
   <dependency>
       <groupId>com.alibaba</groupId>
       <artifactId>easyexcel</artifactId>
       <version>2.1.6</version>
   </dependency>
     
    <dependency>
   	  <groupId>org.projectlombok</groupId>
   	  <artifactId>lombok</artifactId>
   	  <version>1.18.2</version>
    </dependency>
   ```

   > - Lombok是在学校坏境中的必备神器，简化代码，降低学习成本
   
2. EasyExcel的基本用法

   - EasyExcel的使用需要为准备读取的数据添加一个配置信息注释类，在这个注释类中包含了Excel文件中的数据属性，并且在这个注释类中可以会用内置的标签作为读取或写入的Excel的配置信息；

     - 准备一个测试用的Excel文件，并且为这个文件准备配置类

   - EasyExcel读取Excel文件除了要准备配置信息类还必须为这个类定义一个读写监听器，这个监听器需要继承`AnalysisEventListener<T>`这个类，EasyExcel对Excel文件的执行结果会调用监听器中的方法，通过覆写父类方法可以得到对Excel的执行结果；
   
     ```java
     /**
      * 接收所解析的每个数据块的返回
      */
     public abstract class AnalysisEventListener<T> implements ReadListener<T> {
     
         /**
          * 当分析一个头行时触发调用函数
          *
          * @param headMap
          * @param context
          */
         @Override
         public void invokeHead(Map<Integer, CellData> headMap, 
                                AnalysisContext context) {
             invokeHeadMap(ConverterUtils.convertToStringMap(headMap,   context.currentReadHolder()), context);
         }
     
         /**
          * 覆盖当前方法以接收标头数据。
          *
          * @param headMap
          * @param context
          */
         public void invokeHeadMap(Map<Integer, String> headMap, 
                                   AnalysisContext context) {}
     
         /**
          * 当任何一个侦听器执行错误报告时，所有侦听器都将接收此方法。
          * 如果这里抛出异常，则整个读操作将终止。
          *
          * @param exception
          * @param context
          */
         @Override
         public void onException(Exception e, AnalysisContext c) throws Exception {
             throw e;
         }
     
         /**
           * 验证是否存在另一段数据。您可以通过返回false来停止读取
           */
         @Override
         public boolean hasNext(AnalysisContext context) {
             return true;
         }
     }
     
     ```


## 1.3 快速感受

- **Excel内容**

  | 字符串标题 | 日期标题 | 数值标题 |
  | ---------- | -------- | -------- |
  | 字符串10   | 2019/1/1 | 10       |
  | 字符串20   | 2019/2/1 | 21       |
  | 字符串30   | 2019/3/1 | 32       |
  | 字符串40   | 2019/4/1 | 43       |
  | 字符串50   | 2019/5/1 | 54       |

- **读Excel**

  ```java
  @Test
  public void read() {
      String fileName = "demo.xlsx";
      // 这里 需要指定读用哪个class去读，然后读取第一个sheet 文件流会自动关闭
      // 参数一：读取的excel文件路径
      // 参数二：读取sheet的一行，将参数封装在DemoData实体类中
      // 参数三：读取每一行的时候会执行DemoDataListener监听器
      EasyExcel.read(fileName, DemoData.class, new DemoDataListener()).sheet().doRead();
  }
  ```

- **写Excel**

  ```java
  @Test
  public void simpleWrite() {
      String fileName = "demo.xlsx";
      // 这里 需要指定写用哪个class去读，然后写到第一个sheet，名字为模板 然后文件流会自动关闭
      // 如果这里想使用03 则 传入excelType参数即可
      // 参数一：写入excel文件路径
      // 参数二：写入的数据类型是DemoData
      // data()方法是写入的数据，结果是List<DemoData>集合
      EasyExcel.write(fileName, DemoData.class).sheet("模板").doWrite(data());
  }
  
  // 准备测试数据
  public Listt<DemoData> data() {
      List<DemoData> list = new ArrayList<>();
      for (int i = 0; i < 10; i++) {
          list.add(DemoData.builder()
                   .date(new Date())
                   .doubleData(23.34 + i)
                   string("test" + i).build()
                  );
      }
      return list;
  }
  ```

- **Web上传与下载**

  ```java
  /**
  	excel文件的下载
  */
  @GetMapping("download")
  public void download(HttpServletResponse response) throws IOException {
      response.setContentType("application/vnd.ms-excel");
      response.setCharacterEncoding("utf-8");
      response.setHeader("Content-disposition", "attachment;filename=demo.xlsx");
      EasyExcel.write(response.getOutputStream(), DownloadData.class).sheet("模板").doWrite(data());
  }
  
  /**
  	excel文件的上传
  */
  @PostMapping("upload")
  @ResponseBody
  public String upload(MultipartFile file) throws IOException {
      EasyExcel.read(file.getInputStream(), DemoData.class, new DemoDataListener()).sheet().doRead();
      return "success";
  }
  ```

## 1.4 读写详解的配置准备

- 配置信息类：如果没有特殊说明，下面的案例将默认使用这个实体类

  ```java
  public class DemoData {
      private String string;
      private Date date;
      private Double doubleData;
      // getting setting
  }
  ```

- Excel读写监听器：如果没有特殊说明，下面的案例将默认使用这个监听器

  ```java
  public class DemoDataListener extends AnalysisEventListener<DemoData> {
  
      List<DemoData> list = new ArrayList<DemoData>();
      
      /**
       * 如果使用了spring,请使用这个构造方法。每次创建Listener的时候需要把spring管理的类传进来
       */
      public DemoDataListener() {}
  
      /**
       * 这个每一条数据解析都会来调用
       *
       * @param data
       * @param context
       */
      @Override
      public void invoke(DemoData data, AnalysisContext context) {
          System.out.println("解析到一条数据:{}", JSON.toJSONString(data));
          list.add(data);
      }
  
      /**
       * 所有数据解析完成了 都会来调用
       *
       * @param context
       */
      @Override
      public void doAfterAllAnalysed(AnalysisContext context) {
          System.out.println(JSON.toJSONString(list));
      }
  }
  
  ```

# 四、详解读取Excel

## 4.1 简单读取

- 格式一：使用EasyExcelFactory读取，文件流会自动关闭

  ```java
  @Test
  public void simpleRead1() {
      String fileName = "demo.xlsx";
      EasyExcel.read(fileName, DemoData.class, new DemoDataListener()).sheet().doRead();
  }
  ```

- 格式二：使用ExcelReader读取Excel，一定要记得关闭ExcelReader，读会创建临时文件，到时磁盘会崩的

  ```java
  @Test
  public void simpleRead2() {
      String fileName = "demo.xlsx";
       ExcelReader excelReader = EasyExcel.read(fileName, DemoData.class, 
                                                new DemoDataListener()).build();
      ReadSheet readSheet = EasyExcel.readSheet(0).build();
      excelReader.read(readSheet);
      excelReader.finish();
  }
  ```

## 4.2指定列的下标或名称

- > - 用名字去匹配，这里需要注意，如果名字重复，会导致只有一个字段读取到数据

- 读取Excel

  ```java
  @Test
  public void indexOrNameRead() {
      String fileName = "demo.xlsx";
      // 这里默认读取第一个sheet
      EasyExcel.read(fileName, DemoData.class, new DemoDataListener()).sheet().doRead();
  }
  ```

## 4.3 读取多个sheet

- **读取全部sheet**

  ```java
  @Test
  public void repeatedRead() {
      String fileName = "demo.xlsx";
      EasyExcel.read(fileName, DemoData.class, new DemoDataListener()).doReadAll();
  }
  ```

  > - DemoDataListener的doAfterAllAnalysed 会在每个sheet读取完毕后调用一次。
  > - 然后所有sheet都会往同一个DemoDataListener里面写

- **读取部分sheet**

  ```java
  @Test
  public void repeatedRead() {
      String fileName = "demo.xlsx";
      ExcelReader excelReader = EasyExcel.read(fileName).build();
      
      // readSheet参数设置读取sheet的序号
      ReadSheet sheet1 =
          EasyExcel.readSheet(0).head(DemoData.class).registerReadListener(new DemoDataListener()).build();
      
      
      ReadSheet sheet2 =
          EasyExcel.readSheet(1).head(DemoData.class).registerReadListener(new DemoDataListener()).build();
      
      // 这里注意 一定要把sheet1 sheet2一起传进去,不然有个问题就是03版的excel 会读取多次,浪费性能
      excelReader.read(sheet1, sheet2);
      
      // 这里千万别忘记关闭，读的时候会创建临时文件，到时磁盘会崩的
      excelReader.finish();
  }
  ```

## 4.4 自定义格式转换

- 在属性配置类中使用格式转换器：**@ExcelProperty.**converter

  ```java
  @Data
  public class ConverterData {
      /**
       * converter属性定义自己的字符串转换器
       */
      @ExcelProperty(converter = CustomStringConverter.class)
      private String string;
      /**
       * 这里用string 去接日期才能格式化
       */
      @DateTimeFormat("yyyy年MM月dd日 HH时mm分ss秒")
      private String date;
      /**
       * 我想接收百分比的数字
       */
      @NumberFormat("#.##%")
      private String doubleData;
  }
  ```

- EasyExcel内置了部分转换器，可以自定义转换器

  ```java
  public class CustomStringStringConverter implements Converter<String> {
      @Override
      public Class supportJavaTypeKey() {
          return String.class;
      }
  
      @Override
      public CellDataTypeEnum supportExcelTypeKey() {
          return CellDataTypeEnum.STRING;
      }
  
      /**
       * 这里读的时候会调用
       *
       * @param cellData
       *            NotNull
       * @param contentProperty
       *            Nullable
       * @param globalConfiguration
       *            NotNull
       * @return
       */
      @Override
      public String convertToJavaData(CellData cellData, 
                                      ExcelContentProperty contentProperty,
          GlobalConfiguration globalConfiguration) {
          return "自定义：" + cellData.getStringValue();
      }
  
      /**
       * 这里是写的时候会调用 不用管
       *
       * @param value
       *            NotNull
       * @param contentProperty
       *            Nullable
       * @param globalConfiguration
       *            NotNull
       * @return
       */
      @Override
      public CellData convertToExcelData(String value, 
                                         ExcelContentProperty contentProperty,
          GlobalConfiguration globalConfiguration) {
          return new CellData(value);
      }
  
  }
  ```

- **测试代码**

  ```java
  @Test
  public void converterRead() {
      String fileName = "demo.xlsx";
      EasyExcel.read(fileName, ConverterData.class, new ConverterDataListener())
          // 这里注意 我们也可以registerConverter来指定自定义转换器， 
          // 但是这个转换变成全局了， 所有java为string,excel为string的都会用这个转换器。
          // 如果就想单个字段使用请使用@ExcelProperty 指定converter
          // .registerConverter(new CustomStringStringConverter())
          // 读取sheet
          .sheet().doRead();
  }
  
  ```

## 4.5 多行头

```java
@Test
public void complexHeaderRead() {
    String fileName = "demo.xlsx";
    EasyExcel.read(fileName, DemoData.class, new DemoDataListener()).sheet()
        // 这里可以设置1，因为头就是一行。如果多行头，可以设置其他值。不传入默认1行
        .headRowNumber(1).doRead();
}
```

## 4.5 读取表头数据

- **监听器**

  ```java
  /**
   * 这里会一行行的返回头
   * 监听器只需要重写这个方法就可以读取到头信息
   * @param headMap
   * @param context
   */
  @Override
  public void invokeHeadMap(Map<Integer, String> headMap, AnalysisContext context) {
      LOGGER.info("解析到一条头数据:{}", JSON.toJSONString(headMap));
  }
  ```

- 测试代码

  ```java
  @Test
  public void headerRead() {
      String fileName = "demo.xlsx";
      // 这里 需要指定读用哪个class去读，然后读取第一个sheet
      EasyExcel.read(fileName, DemoData.class, new ReadDataListener()).sheet().doRead();
  }
  ```

## 4.6 异常处理

- **监听器**

  ```java
  /**
  * 监听器实现这个方法就可以在读取数据的时候获取到异常信息
  */
  @Override
  public void onException(Exception exception, AnalysisContext context) {
      LOGGER.error("解析失败，但是继续解析下一行:{}", exception.getMessage());
      // 如果是某一个单元格的转换异常 能获取到具体行号
      // 如果要获取头的信息 配合invokeHeadMap使用
      if (exception instanceof ExcelDataConvertException) {
          ExcelDataConvertException excelDataConvertException = (ExcelDataConvertException)exception;
          LOGGER.error("第{}行，第{}列解析异常", excelDataConvertException.getRowIndex(),
              excelDataConvertException.getColumnIndex());
      }
  }
  ```

## 4.7 web读取

```java
@PostMapping("upload")
@ResponseBody
public String upload(MultipartFile file) throws IOException {
    EasyExcel.read(file.getInputStream(), 
                   UploadData.class, 
                   new UploadDataListener(uploadDAO)).sheet().doRead();
    return "SUCCESS";
}
```

# 五、详解写入Excel

**数据写入公用方法**

```java
private List<DemoData> data() {
    List<DemoData> list = new ArrayList<DemoData>();
    for (int i = 0; i < 10; i++) {
        DemoData data = new DemoData();
        data.setString("字符串" + i);
        data.setDate(new Date());
        data.setDoubleData(0.56);
        list.add(data);
    }
    return list;
}
```

## 5.1 简单写入

- **对象**

  ```java
  public class DemoData {
      @ExcelProperty("字符串标题")
      private String string;
      @ExcelProperty("日期标题")
      private Date date;
      @ExcelProperty("数字标题")
      private Double doubleData;
      // getting setting
  }
  ```

- 测试写入格式一：使用EasyExcelFactory读写，文件流会自动关闭

  ```java
  @Test
  public void simpleWrite() {
      String fileName = System.currentTimeMillis() + ".xlsx";
      EasyExcel.write(fileName, DemoData.class).sheet("写入方法一").doWrite(data());
  }
  ```

  > - 如果想使用03 则 传入excelType参数即可

- 测试写入格式一：使用ExcelWriter读写，文件流需要手动关闭

  ```java
  @Test
  public void simpleWrite() {
  	String fileName = System.currentTimeMillis() + ".xlsx";
   	ExcelWriter excelWriter = EasyExcel.write(fileName, DemoData.class).build();
      WriteSheet writeSheet = EasyExcel.writerSheet("写入方法二").build();
      excelWriter.write(data(), writeSheet);
      /// 千万别忘记finish 会帮忙关闭流
      excelWriter.finish();
  }
  ```

## 5.2 导出指定的列

```java
@Test
public void excludeOrIncludeWrite() {
    String fileName = "excludeOrIncludeWrite" + System.currentTimeMillis() + ".xlsx";

    // 忽略 date 不导出
    Set<String> excludeColumnFiledNames = new HashSet<String>();
    excludeColumnFiledNames.add("date");
    
    // 这里 需要指定写用哪个class去写，然后写到第一个sheet，名字为模板 然后文件流会自动关闭
    EasyExcel.write(fileName,DemoData.class)
        .excludeColumnFiledNames(excludeColumnFiledNames)
        .sheet("忽略date")
        .doWrite(data());

    fileName = "excludeOrIncludeWrite" + System.currentTimeMillis() + ".xlsx";
    // 根据用户传入字段 假设我们只要导出 date
    Set<String> includeColumnFiledNames = new HashSet<String>();
    includeColumnFiledNames.add("date");
    // 这里 需要指定写用哪个class去写，然后写到第一个sheet，名字为模板 然后文件流会自动关闭
    EasyExcel.write(fileName, DemoData.class)
        .includeColumnFiledNames(includeColumnFiledNames)
        .sheet("导出date")
        .doWrite(data());
}

```

## 5.3指定写入的列

- **对象**

```java
public class IndexData {
    /**
    * 导出的excel第二列和第四列将空置
    */
    @ExcelProperty(value = "字符串标题", index = 0)
    private String string;
    @ExcelProperty(value = "日期标题", index = 2)
    private Date date;
    @ExcelProperty(value = "数字标题", index = 4)
    private Double doubleData;
}

```

**代码**

```java
@Test
public void indexWrite() {
    String fileName = "indexWrite" + System.currentTimeMillis() + ".xlsx";
    // 这里 需要指定写用哪个class去写，然后写到第一个sheet，名字为模板 然后文件流会自动关闭
    EasyExcel.write(fileName, IndexData.class).sheet("模板").doWrite(data());
}
```

### 复杂头写入

**对象**

```java
public class ComplexHeadData {
    /**
    * 主标题 将整合为一个单元格效果如下：
    * —————————————————————————
    * |          主标题        |
    * —————————————————————————
    * |字符串标题|日期标题|数字标题|
    * —————————————————————————
    */
    @ExcelProperty({"主标题", "字符串标题"})
    private String string;
    @ExcelProperty({"主标题", "日期标题"})
    private Date date;
    @ExcelProperty({"主标题", "数字标题"})
    private Double doubleData;
}

```

**代码**

```java
@Test
public void complexHeadWrite() {
    String fileName = "complexHeadWrite" + System.currentTimeMillis() + ".xlsx";
    // 这里 需要指定写用哪个class去写，然后写到第一个sheet，名字为模板 然后文件流会自动关闭
    EasyExcel.write(fileName, ComplexHeadData.class).sheet("模板").doWrite(data());
}

```

### 自定义格式转换

```java
public class ConverterData {
    /**
     * 自定义的转换
     */
    @ExcelProperty(value = "字符串标题", converter = CustomStringConverter.class)
    private String string;
    /**
     * 我想写到excel 用年月日的格式
     */
    @DateTimeFormat("yyyy年MM月dd日 HH时mm分ss秒")
    @ExcelProperty("日期标题")
    private Date date;
    /**
     * 我想写到excel 用百分比表示
     */
    @NumberFormat("#.##%")
    @ExcelProperty(value = "数字标题")
    private Double doubleData;
    // getting setting
}

```

**代码**

```java
@Test
public void converterWrite() {
    String "converterWrite" + System.currentTimeMillis() + ".xlsx";
    // 这里 需要指定写用哪个class去写，然后写到第一个sheet，名字为模板 然后文件流会自动关闭
    EasyExcel.write(fileName, ConverterData.class).sheet("模板").doWrite(data());
}

```

### 图片导出

**对象**

```java
@Data
@ContentRowHeight(200)
@ColumnWidth(200 / 8)
public class ImageData {
    // 图片导出方式有5种
    private File file;
    private InputStream inputStream;
    /**
     * 如果string类型 必须指定转换器，string默认转换成string，该转换器是官方支持的
     */
    @ExcelProperty(converter = StringImageConverter.class)
    private String string;
    private byte[] byteArray;
    /**
     * 根据url导出 版本2.1.1才支持该种模式
     */
    private URL url;
}

```

**代码**

```java
@Test
public void imageWrite() throws Exception {
    String fileName = "imageWrite" + System.currentTimeMillis() + ".xlsx";
    // 如果使用流 记得关闭
    InputStream inputStream = null;
    try {
        List<ImageData> list = new ArrayList<ImageData>();
        ImageData imageData = new ImageData();
        list.add(imageData);
        String imagePath = "converter" + File.separator + "img.jpg";
        // 放入五种类型的图片 根据实际使用只要选一种即可
        imageData.setByteArray(FileUtils.readFileToByteArray(new File(imagePath)));
        imageData.setFile(new File(imagePath));
        imageData.setString(imagePath);
        inputStream = FileUtils.openInputStream(new File(imagePath));
        imageData.setInputStream(inputStream);
        imageData.setUrl(new URL(
            "https://raw.githubusercontent.com/alibaba/easyexcel/master/src/test/resources/converter/img.jpg"));
        EasyExcel.write(fileName, ImageData.class).sheet().doWrite(list);
    } finally {
        if (inputStream != null) {
            inputStream.close();
        }
    }
}

```

### 列宽、行高

**对象**

```java
@Data
@ContentRowHeight(10)
@HeadRowHeight(20)
@ColumnWidth(25)
public class WidthAndHeightData {
    @ExcelProperty("字符串标题")
    private String string;
    @ExcelProperty("日期标题")
    private Date date;
    /**
     * 宽度为50,覆盖上面的宽度25
     */
    @ColumnWidth(50)
    @ExcelProperty("数字标题")
    private Double doubleData;
}

```

**代码**

```java
@Test
public void widthAndHeightWrite() {
    String fileName = "widthAndHeightWrite" + System.currentTimeMillis() + ".xlsx";
    // 这里 需要指定写用哪个class去写，然后写到第一个sheet，名字为模板 然后文件流会自动关闭
    EasyExcel.write(fileName, WidthAndHeightData.class).sheet("模板").doWrite(data());
}

```

### 合并单元格

**代码**

```java
 @Test
 public void mergeWrite() {
     String fileName = "mergeWrite" + System.currentTimeMillis() + ".xlsx";
     // 每隔2行会合并 把eachColumn 设置成 3 也就是我们数据的长度，所以就第一列会合并。当然其他合并策略也可以自己写
     LoopMergeStrategy loopMergeStrategy = new LoopMergeStrategy(2, 0);
     // 这里 需要指定写用哪个class去写，然后写到第一个sheet，名字为模板 然后文件流会自动关闭
     EasyExcel.write(fileName, DemoData.class).registerWriteHandler(loopMergeStrategy).sheet("合并单元格")
         .doWrite(data());
 }

```



### 动态表头

**代码**

```java
@Test
public void dynamicHeadWrite() {
    String fileName = "dynamicHeadWrite" + System.currentTimeMillis() + ".xlsx";
    EasyExcel.write(fileName)
        // 这里放入动态头
        .head(head()).sheet("模板")
        // 当然这里数据也可以用 List<List<String>> 去传入
        .doWrite(data());
}

// 动态表头的数据格式List<List<String>>
private List<List<String>> head() {
    List<List<String>> list = new ArrayList<List<String>>();
    List<String> head0 = new ArrayList<String>();
    head0.add("字符串" + System.currentTimeMillis());
    List<String> head1 = new ArrayList<String>();
    head1.add("数字" + System.currentTimeMillis());
    List<String> head2 = new ArrayList<String>();
    head2.add("日期" + System.currentTimeMillis());
    list.add(head0);
    list.add(head1);
    list.add(head2);
    return list;
}

```



### web数据写出

**代码**

```java
@GetMapping("download")
public void download(HttpServletResponse response) throws IOException {
    response.setContentType("application/vnd.ms-excel");
    response.setCharacterEncoding("utf-8");
    // 这里URLEncoder.encode可以防止中文乱码 当然和easyexcel没有关系
    String fileName = URLEncoder.encode("数据写出", "UTF-8");
    response.setHeader("Content-disposition", "attachment;filename=" + fileName + ".xlsx");
    EasyExcel.write(response.getOutputStream(), DownloadData.class).sheet("模板").doWrite(data());
}

```

# 六、详解填充样板写入

这里的案例填充都是模板向下，如果需要横向填充只需要模板设置好就可以。

### 简单的填充

**Excel模板**

| A            | B                | C                                  |
| ------------ | ---------------- | ---------------------------------- |
| 姓名         | 数字             | 复杂                               |
| ｛ｎａｍｅ｝ | ｛ｎｕｍｂｅｒ｝ | ｛ｎａｍｅ｝今年｛ｎｕｍｂｅｒ｝岁 |

**Excel最终效果**

| A      | B    | C              |
| ------ | ---- | -------------- |
| 姓名   | 数字 | 复杂           |
| 知春秋 | 25   | 知春秋今年25岁 |

**对象**

```java
public class FillData {
    private String name;
    private double number;
    // getting setting
}

```



**代码**

```java
@Test
public void simpleFill() {
    // 模板注意 用{} 来表示你要用的变量 如果本来就有"{","}" 特殊字符 用"\{","\}"代替
    String templateFileName = "simple.xlsx";

    // 方案1 根据对象填充
    String fileName = System.currentTimeMillis() + ".xlsx";
    // 这里 会填充到第一个sheet， 然后文件流会自动关闭
    FillData fillData = new FillData();
    fillData.setName("知春秋");
    fillData.setNumber(25);
    EasyExcel.write(fileName).withTemplate(templateFileName).sheet().doFill(fillData);

    // 方案2 根据Map填充
    fileName = System.currentTimeMillis() + ".xlsx";
    // 这里 会填充到第一个sheet， 然后文件流会自动关闭
    Map<String, Object> map = new HashMap<String, Object>();
    map.put("name", "知春秋");
    map.put("number", 25);
    EasyExcel.write(fileName).withTemplate(templateFileName).sheet().doFill(map);
}

```



### 复杂的填充

使用List集合的方法批量写入数据，点表示该参数是集合



**Excel模板**

| A             | B                 | C                                    |
| ------------- | ----------------- | ------------------------------------ |
| 姓名          | 数字              | 复杂                                 |
| ｛.ｎａｍｅ｝ | ｛.ｎｕｍｂｅｒ｝ | ｛.ｎａｍｅ｝今年｛.ｎｕｍｂｅｒ｝岁 |

**Excel最终效果**

| A      | B    | C              |
| ------ | ---- | -------------- |
| 姓名   | 数字 | 复杂           |
| 知春秋 | 25   | 知春秋今年25岁 |
| 知春秋 | 25   | 知春秋今年25岁 |
| 知春秋 | 25   | 知春秋今年25岁 |
| 知春秋 | 25   | 知春秋今年25岁 |
| 知春秋 | 25   | 知春秋今年25岁 |
| 知春秋 | 25   | 知春秋今年25岁 |

**代码**

```java
@Test
public void complexFill() {
    // 模板注意 用{} 来表示你要用的变量 如果本来就有"{","}" 特殊字符 用"\{","\}"代替
    // {} 代表普通变量 {.} 代表是list的变量
    String templateFileName = "complex.xlsx";

    String fileName = System.currentTimeMillis() + ".xlsx";
    ExcelWriter excelWriter = EasyExcel.write(fileName).withTemplate(templateFileName).build();
    WriteSheet writeSheet = EasyExcel.writerSheet().build();
    // 这里注意 入参用了forceNewRow 代表在写入list的时候不管list下面有没有空行 都会创建一行，然后下面的数据往后移动。默认 是false，会直接使用下一行，如果没有则创建。
    // forceNewRow 如果设置了true,有个缺点 就是他会把所有的数据都放到内存了，所以慎用
    // 简单的说 如果你的模板有list,且list不是最后一行，下面还有数据需要填充 就必须设置 forceNewRow=true 但是这个就会把所有数据放到内存 会很耗内存
    // 如果数据量大 list不是最后一行 参照下一个
    FillConfig fillConfig = FillConfig.builder().forceNewRow(Boolean.TRUE).build();
    excelWriter.fill(data(), fillConfig, writeSheet);
    excelWriter.fill(data(), fillConfig, writeSheet);
    // 其他参数可以使用Map封装
    Map<String, Object> map = new HashMap<String, Object>();
    excelWriter.fill(map, writeSheet);
    excelWriter.finish();
}

```



# 七、API

## 7.1 关于常见类解析

- EasyExcel 入口类，用于构建开始各种操作
- ExcelReaderBuilder ExcelWriterBuilder 构建出一个 ReadWorkbook WriteWorkbook，可以理解成一个excel对象，一个excel只要构建一个
- ExcelReaderSheetBuilder ExcelWriterSheetBuilder 构建出一个 ReadSheet WriteSheet对象，可以理解成excel里面的一页,每一页都要构建一个
- ReadListener 在每一行读取完毕后都会调用ReadListener来处理数据
- WriteHandler 在每一个操作包括创建单元格、创建表格等都会调用WriteHandler来处理数据
- 所有配置都是继承的，Workbook的配置会被Sheet继承，所以在用EasyExcel设置参数的时候，在EasyExcel...sheet()方法之前作用域是整个sheet,之后针对单个sheet

## 7.2 读

### 1. 注解

- `ExcelProperty` 指定当前字段对应excel中的那一列。可以根据名字或者Index去匹配。当然也可以不写，默认第一个字段就是index=0，以此类推。千万注意，要么全部不写，要么全部用index，要么全部用名字去匹配。千万别三个混着用，除非你非常了解源代码中三个混着用怎么去排序的。
- `ExcelIgnore` 默认所有字段都会和excel去匹配，加了这个注解会忽略该字段
- `DateTimeFormat` 日期转换，用`String`去接收excel日期格式的数据会调用这个注解。里面的`value`参照`java.text.SimpleDateFormat`
- `NumberFormat` 数字转换，用`String`去接收excel数字格式的数据会调用这个注解。里面的`value`参照`java.text.DecimalFormat`
- `ExcelIgnoreUnannotated` 默认不加`ExcelProperty` 的注解的都会参与读写，加了不会参与

### 2. 参数

#### 通用参数

`ReadWorkbook`,`ReadSheet` 都会有的参数，如果为空，默认使用上级。

- `converter` 转换器，默认加载了很多转换器。也可以自定义。
- `readListener` 监听器，在读取数据的过程中会不断的调用监听器。
- `headRowNumber` 需要读的表格有几行头数据。默认有一行头，也就是认为第二行开始起为数据。
- `head`  与`clazz`二选一。读取文件头对应的列表，会根据列表匹配数据，建议使用class。
- `clazz` 与`head`二选一。读取文件的头对应的class，也可以使用注解。如果两个都不指定，则会读取全部数据。
- `autoTrim` 字符串、表头等数据自动trim
- `password` 读的时候是否需要使用密码

#### ReadWorkbook（理解成excel对象）参数

- `excelType` 当前excel的类型 默认会自动判断
- `inputStream` 与`file`二选一。读取文件的流，如果接收到的是流就只用，不用流建议使用`file`参数。因为使用了`inputStream` easyexcel会帮忙创建临时文件，最终还是`file`
- `file` 与`inputStream`二选一。读取文件的文件。
- `autoCloseStream` 自动关闭流。
- `readCache` 默认小于5M用 内存，超过5M会使用 `EhCache`,这里不建议使用这个参数。
- `useDefaultListener` `@since 2.1.4` 默认会加入`ModelBuildEventListener` 来帮忙转换成传入`class`的对象，设置成`false`后将不会协助转换对象，自定义的监听器会接收到`Map<Integer,CellData>`对象，如果还想继续接听到`class`对象，请调用`readListener`方法，加入自定义的`beforeListener`、 `ModelBuildEventListener`、 自定义的`afterListener`即可。

#### ReadSheet（就是excel的一个Sheet）参数

- `sheetNo` 需要读取Sheet的编码，建议使用这个来指定读取哪个Sheet
- `sheetName` 根据名字去匹配Sheet,excel 2003不支持根据名字去匹配

## 7.3 写

### 1. 注解

- `ExcelProperty` index 指定写到第几列，默认根据成员变量排序。`value`指定写入的名称，默认成员变量的名字，多个`value`可以参照快速开始中的复杂头
- `ExcelIgnore` 默认所有字段都会写入excel，这个注解会忽略这个字段
- `DateTimeFormat` 日期转换，将`Date`写到excel会调用这个注解。里面的`value`参照`java.text.SimpleDateFormat`
- `NumberFormat` 数字转换，用`Number`写excel会调用这个注解。里面的`value`参照`java.text.DecimalFormat`
- `ExcelIgnoreUnannotated` 默认不加`ExcelProperty` 的注解的都会参与读写，加了不会参与

### 2. 参数

#### 通用参数

`WriteWorkbook`,`WriteSheet` ,`WriteTable`都会有的参数，如果为空，默认使用上级。

- `converter` 转换器，默认加载了很多转换器。也可以自定义。
- `writeHandler` 写的处理器。可以实现`WorkbookWriteHandler`,`SheetWriteHandler`,`RowWriteHandler`,`CellWriteHandler`，在写入excel的不同阶段会调用
- `relativeHeadRowIndex` 距离多少行后开始。也就是开头空几行
- `needHead` 是否导出头
- `head`  与`clazz`二选一。写入文件的头列表，建议使用class。
- `clazz` 与`head`二选一。写入文件的头对应的class，也可以使用注解。
- `autoTrim` 字符串、表头等数据自动trim

#### WriteWorkbook（理解成excel对象）参数

- `excelType` 当前excel的类型 默认`xlsx`
- `outputStream` 与`file`二选一。写入文件的流
- `file` 与`outputStream`二选一。写入的文件
- `templateInputStream` 模板的文件流
- `templateFile` 模板文件
- `autoCloseStream` 自动关闭流。
- `password` 写的时候是否需要使用密码
- `useDefaultStyle` 写的时候是否是使用默认头

#### WriteSheet（就是excel的一个Sheet）参数

- `sheetNo` 需要写入的编码。默认0
- `sheetName` 需要些的Sheet名称，默认同`sheetNo`

#### WriteTable（就把excel的一个Sheet,一块区域看一个table）参数

- `tableNo` 需要写入的编码。默认0



详细参数介绍
关于常见类解析
Ø EasyExcel 入口类，用于构建开始各种操作

Ø ExcelReaderBuilder ExcelWriterBuilder 构建出一个 ReadWorkbook WriteWorkbook，可以理解成一个excel对象，一个excel只要构建一个

Ø ExcelReaderSheetBuilder ExcelWriterSheetBuilder 构建出一个 ReadSheet WriteSheet对象，可以理解成excel里面的一页,每一页都要构建一个

Ø ReadListener 在每一行读取完毕后都会调用ReadListener来处理数据

Ø WriteHandler 在每一个操作包括创建单元格、创建表格等都会调用WriteHandler来处理数据

Ø 所有配置都是继承的，Workbook的配置会被Sheet继承，所以在用EasyExcel设置参数的时候，在EasyExcel…sheet()方法之前作用域是整个sheet,之后针对单个sheet

读
注解
Ø ExcelProperty 指定当前字段对应excel中的那一列。可以根据名字或者Index去匹配。当然也可以不写，默认第一个字段就是index=0，以此类推。千万注意，要么全部不写，要么全部用index，要么全部用名字去匹配。千万别三个混着用，除非你非常了解源代码中三个混着用怎么去排序的。

Ø ExcelIgnore 默认所有字段都会和excel去匹配，加了这个注解会忽略该字段

Ø DateTimeFormat 日期转换，用String去接收excel日期格式的数据会调用这个注解。里面的value参照java.text.SimpleDateFormat

Ø NumberFormat 数字转换，用String去接收excel数字格式的数据会调用这个注解。里面的value参照java.text.DecimalFormat

Ø ExcelIgnoreUnannotated 默认不加ExcelProperty 的注解的都会参与读写，加了不会参与

参数
通用参数
Ø ReadWorkbook,ReadSheet 都会有的参数，如果为空，默认使用上级。

Ø converter 转换器，默认加载了很多转换器。也可以自定义。

Ø readListener 监听器，在读取数据的过程中会不断的调用监听器。

Ø headRowNumber 需要读的表格有几行头数据。默认有一行头，也就是认为第二行开始起为数据。

Ø head 与clazz二选一。读取文件头对应的列表，会根据列表匹配数据，建议使用class。

Ø clazz 与head二选一。读取文件的头对应的class，也可以使用注解。如果两个都不指定，则会读取全部数据。

Ø autoTrim 字符串、表头等数据自动trim

Ø password 读的时候是否需要使用密码

ReadWorkbook（理解成excel对象）参数
Ø excelType 当前excel的类型 默认会自动判断

Ø inputStream 与file二选一。读取文件的流，如果接收到的是流就只用，不用流建议使用file参数。因为使用了inputStream easyexcel会帮忙创建临时文件，最终还是file

Ø file 与inputStream二选一。读取文件的文件。

Ø autoCloseStream 自动关闭流。

Ø readCache 默认小于5M用 内存，超过5M会使用 EhCache,这里不建议使用这个参数。

ReadSheet（就是excel的一个Sheet）参数
Ø sheetNo 需要读取Sheet的编码，建议使用这个来指定读取哪个Sheet

Ø sheetName 根据名字去匹配Sheet,excel 2003不支持根据名字去匹配

写
注解
Ø ExcelProperty index 指定写到第几列，默认根据成员变量排序。value指定写入的名称，默认成员变量的名字，多个value可以参照快速开始中的复杂头

Ø ExcelIgnore 默认所有字段都会写入excel，这个注解会忽略这个字段

Ø DateTimeFormat 日期转换，将Date写到excel会调用这个注解。里面的value参照java.text.SimpleDateFormat

Ø NumberFormat 数字转换，用Number写excel会调用这个注解。里面的value参照java.text.DecimalFormat

Ø ExcelIgnoreUnannotated 默认不加ExcelProperty 的注解的都会参与读写，加了不会参与

参数
通用参数
Ø WriteWorkbook,WriteSheet ,WriteTable都会有的参数，如果为空，默认使用上级。

Ø converter 转换器，默认加载了很多转换器。也可以自定义。

Ø writeHandler 写的处理器。可以实现WorkbookWriteHandler,SheetWriteHandler,RowWriteHandler,CellWriteHandler，在写入excel的不同阶段会调用

Ø relativeHeadRowIndex 距离多少行后开始。也就是开头空几行

Ø needHead 是否导出头

Ø head 与clazz二选一。写入文件的头列表，建议使用class。

Ø clazz 与head二选一。写入文件的头对应的class，也可以使用注解。

Ø autoTrim 字符串、表头等数据自动trim

WriteWorkbook（理解成excel对象）参数
Ø excelType 当前excel的类型 默认xlsx

Ø outputStream 与file二选一。写入文件的流

Ø file 与outputStream二选一。写入的文件

Ø templateInputStream 模板的文件流

Ø templateFile 模板文件

Ø autoCloseStream 自动关闭流。

Ø password 写的时候是否需要使用密码

Ø useDefaultStyle 写的时候是否是使用默认头

WriteSheet（就是excel的一个Sheet）参数
Ø sheetNo 需要写入的编码。默认0

Ø sheetName 需要些的Sheet名称，默认同sheetNo

WriteTable（就把excel的一个Sheet,一块区域看一个table）参数
Ø tableNo 需要写入的编码。默认0

https://blog.csdn.net/sinat_32366329/article/details/103109058