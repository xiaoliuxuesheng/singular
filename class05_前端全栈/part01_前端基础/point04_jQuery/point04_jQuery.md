1. $.extend(object);为扩展jQuery类本身.为类添加新的方法。 并不会把方法扩展到对象的实例上，引用它的方法也需要通过jQuery类来实现

   ```js
   // 为jQuery类添加类方法，可以理解为添加静态方法
   jQuery.extend({
       min: function(a, b) {
           return a < b ? a : b;
       },
       max: function(a, b) {
           return a > b ? a : b;
       }
   });
   
   // 用于将一个或多个对象的内容合并到目标对象
   let defaults = {name:"张三",age:18,sex:"true",scores:{chinese:70,science:100}};
   let options = {name:"李四",age:20,scores:{chinese:98,math:99,english:100}};
   let settings = $.extend(defaults,options);
   ```

2. $.fn.extend(object);给jQuery对象添加方法。$.fn = $.prototype，把方法扩展到了对象的prototype上，所以实例化一个jQuery对象的时候，它就具有了这些方法

   ```js
   let defaults = {name:"张三",age:18,sex:"true",scores:{chinese:70,science:100}};
   let options = {name:"李四",age:20,scores:{chinese:98,math:99,english:100}};
   let settings = $.extend(defaults,options);
   ```

   

第1部分：jQuery是什么？
选择合适的jQuery开发工具；配置jQuery环境；jQuery和javascript的语法方面的相同与不同之处，jQuery对象和DOM对象的相互转换，jQuery和其他库的冲突两个常见问题进行了详细的讲解。这一部分是全书的基础。

第2部分的重点是选择器。
首先介绍了CSS选择器和CSS3标准的选择器，jQuery选择器和选择器的优势。然后分门别类的详细讲解选择器，比如基本选择器、层次选择器、过滤选择器和表单选择器等等，其中还介绍了选择器中的注意事项。通过详尽的实便力图使学员更快的掌握jQuery的选择器使用。最后通过案例研究来巩固选择器。这一部分是学习jQuery的核心基础。

第3部分的重点是DOM操作。
DOM操作的分类；通过例子详细讲解jQuery中的DOM操作以及利用jQuery是如何简化DOM操作的。最后通过案例练习来巩固DOM操作。这一部分是学习jQuery的DOM操作的基础。

第4部分是jQuery中的事件和动画。
在事件中，详细jQuery中的事件方法，比如事件绑定、合成事件、事件冒泡、事件对象的属性、移除事件、模拟事件等。在动画部分中，详细的通过事例讲解jQuery中的动画方法，比如普通动画，渐显动画，自定义动画等。在讲解动画的过程中，还特意介绍了在制作动画过程中常见的一些问题。最后通过终合案例研究来加强对事件和动画的理解。

第5章的重点是插件使用和开发。jQuery有着非常丰富而强大的插件。这部分首先学习插件的用法，比如表单验证插件（Validation Plugin）, 表单插件（Form Plugin）, 动态绑定事件插件（livequery Plugin）,Cookie Plugin,排序(UI sortable)等插件的用法。最后详细介绍了如何编写jQuery插件和插件的注意事项。

第6部分：jQuery中的AJAX.