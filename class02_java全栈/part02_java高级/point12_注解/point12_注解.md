# 第一章 注解介绍

## 1.1 注解概述

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Java注解是JDK1.5新增特性，注解的主要作用是为Java代码提供元数据；注解作为元数据不会直接影响原代码的执行，但是Java注解的类可以通过反射获取所标注的注解，所有注解需要提供第三方代码用于获取Java类上的注解信息；

## 1.2 JDK内置常用注解

1. **作用在代码的注解**

   | 注解                 | 作用                                                         |
   | -------------------- | ------------------------------------------------------------ |
   | @Override            | 检查该方法是否是重写方法。如果发现其父类，或者是引用的接口中并没有该方法时，会报编译错误。 |
   | @Deprecated          | 标记过时方法。如果使用该方法，会报编译警告                   |
   | @SuppressWarnings    | 指示编译器去忽略注解中声明的警告                             |
   | @FunctionalInterface | Java 8 开始支持，标识一个匿名函数或函数式接口                |
   | @SafeVarargs         | Java 7 开始支持，忽略任何使用参数为泛型变量的方法或构造函数调用产生的警告。 |

2. 元注解：为注解提供元数据

   | 注解        | 作用                                                         |
   | ----------- | ------------------------------------------------------------ |
   | @Documented | 标记这些注解是否包含在用户文档中                             |
   | @Retention  | 标识这个注解怎么保存，是只在代码中，还是编入class文件中，或者是在运行时可以通过反射访问 |
   | @Target     | 标记这个注解应该是哪种 Java 成员                             |
   | @Inherited  | 标记这个注解是继承于哪个注解类(默认 注解并没有继承于任何子类) |
   | @Repeatable | Java 8 开始支持，标识某注解可以在同一个声明上使用多次。      |

# 第二章 注解的组成

## 2.1 @Retention.RetentionPolicy

| 枚举对象                                                     | 作用                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| RetentionPolicy.SOURCE                                       | 注解仅存在于源码中，在class字节码文件中不包含                |
| RetentionPolicy.CLASS                                        | 默认的保留策略，注解会在class字节码文件中存在，但运行时无法获得 |
| <span title='自定义注解如果只存着源码中或者字节码文件中就无法发挥作用，而在运行期间能获取到注解才能实现我们目的'>RetentionPolicy.RUNTIME</span> | 注解会在class字节码文件中存在，在运行时可以通过反射获取到    |

## 2.2 @Target.ElementType 

| 枚举对象                    | 作用                                         |
| --------------------------- | -------------------------------------------- |
| ElementType.TYPE            | 作用接口、类、枚举、注解                     |
| ElementType.FIELD           | 作用属性字段、枚举的常量                     |
| ElementType.METHOD          | 作用方法                                     |
| ElementType.PARAMETER       | 作用方法参数                                 |
| ElementType.CONSTRUCTOR     | 作用构造函数                                 |
| ElementType.LOCAL_VARIABLE  | 作用局部变量                                 |
| ElementType.ANNOTATION_TYPE | 作用于注解（@Retention注解中就使用该属性）   |
| ElementType.PACKAGE         | 作用于包                                     |
| ElementType.TYPE_PARAMETER  | 作用于类型泛型，即泛型方法、泛型类、泛型接口 |
| ElementType.TYPE_USE        | 类型使用.可以用于标注任意类型除了 class      |

## 2.3 注解属性

### 1. **属性格式**

```java
public @interface 注解名称{
	属性类型 属性名() default 默认值;
}
```

### 2. 属性类型

- 基本数据类型
- String
- 枚举类型
- 注解类型
- Class类型：可以指定泛型用于规定类型
- 以上类型的一维数组类型

### 3. 注解属性名

- 注解的属性其实和类中定义的变量有异曲同工之处，只是注解中的变量都是成员变量（属性），并且注解中是没有方法的，只有成员变量，变量名就是使用注解括号前对应的参数名，变量类型是注解变量的类型；

- 注解本身就是Annotation接口的子接口，**也就是说注解中其实是可以有属性和方法，但是接口中的属性都是static final的，对于注解来说没什么意义，而我们定义接口的方法就相当于注解的属性，也就对应了前面说的为什么注解只有属性成员变量，其实他就是接口的方法，这就是为什么成员变量会有括号**，不同于接口我们可以在注解的括号中给成员变量赋值。

  ```java
  /**Annotation接口源码*/
  public interface Annotation {
      boolean equals(Object obj);
      int hashCode();
      Class<? extends Annotation> annotationType();
  }
  ```

# 第二章 自定义注解

1. 定义注解类

   ```java
   public @interface 注解类名{
       
   }
   ```

2. 为注解添加元注解：必须的

   ```java
   @Retention(RetentionPolicy.RUNTIME)
   @Target(ElementType.ANNOTATION_TYPE)
   public @interface 注解类名{
       
   }
   ```

3. 为注解添加属性：自定义

   ```java
   @Retention(RetentionPolicy.RUNTIME)
   @Target(ElementType.TYPE)
   public @interface 注解类名{
       String name() default "mao";
       int age() default 18;
   }
   ```

4. 将注解添加到所需要标注的类

   ```java
   @注解类名(name = "father",age = 50)
   public class Father {
   }
   ```

5. 使用反射获取注解信息

   ```java
   public class test {
      public static void main(String[] args) throws NoSuchMethodException {
   
           /**
            * 获取类注解属性
            */
           Class<Father> fatherClass = Father.class;
           boolean annotationPresent = fatherClass.isAnnotationPresent(MyTestAnnotation.class);
           if(annotationPresent){
               MyTestAnnotation annotation = fatherClass.getAnnotation(MyTestAnnotation.class);
               System.out.println(annotation.name());
               System.out.println(annotation.age());
           }
   
           /**
            * 获取方法注解属性
            */
           try {
               Field age = fatherClass.getDeclaredField("age");
               boolean annotationPresent1 = age.isAnnotationPresent(Age.class);
               if(annotationPresent1){
                   Age annotation = age.getAnnotation(Age.class);
                   System.out.println(annotation.value());
               }
   
               Method play = PlayGame.class.getDeclaredMethod("play");
               if (play!=null){
                   People annotation2 = play.getAnnotation(People.class);
                   Game[] value = annotation2.value();
                   for (Game game : value) {
                       System.out.println(game.value());
                   }
               }
           } catch (NoSuchFieldException e) {
               e.printStackTrace();
           }
       }
   }
   ```

   