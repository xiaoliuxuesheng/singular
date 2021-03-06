# 前言

**PRD主要面向团队开发人员，设计、程序、运营等，我们需要更加详细的去阐述所有功能**

# 第一章 MRD概述

​        PRD（Product Requirement Document）主要面向团队开发人员，设计、程序、运营等，我们需要更加详细的去阐述所有功能

# 第二章 BRD设计

<img src="https://s1.ax1x.com/2020/06/28/Nchljg.png" alt="Nchljg.png" border="0" />

1. <font color=red size=4>**环境**</font>：

2. <font color=red size=4>**引言**</font>：是PRD正文部分的开始部分，其作用是**提供辅助读者深入理解整个文档所需的其它相关信息**

   -  **背景**：描述所说明的软件的应用，尽可能精确地描述所有相关的利益干系人。如：xx产品，是由xxx与xxx合作项目，由xxx提出，由xxx承担开发人物，目前用户为xx项目的车主。
   -  **参与资料**：列出有关资料的名称、文件编号、发表日期、出版单位、作者等，并说明参考文件的来源。包含但不仅限于：
      - 经过核准的任务计划书
      - 上级机关批文
      - 项目相关的合同
      - 本项目其它已发表的文件，如：MRD、原型
      - 文中引用的其它文件、研发规范

   -  **术语**：列出本文件中用到的专业术语的定义和缩略语对照，便于理解，适用于接触新业务领域的团队。

3. <font color=red size=4>**概述**</font>：是**帮助读者理解项目和产品**本身。

   - 项目／产品描述：叙述该项软件／产品应用目标、作用范围以及其他应向读者说明的有关该软件开发的背景材料。

     - 应用目标：可以理解为产品要解决什么问题，如：针对xx状态下，无法进行xxx的情况，使xx产品可以通过xxx完成对xxx的工作开展。
     - 范围：明确产品边界，说明产品将干什么，不干什么。
     - 开发背景：为何要开发这个产品，一般情况下根据团队理解程度，节选BRD、MRD相关调研背景资料。

   - 系统模型：用于帮助读者理解系统整体结构，常用于向上汇报，**帮助理解系统整体运作**。

     - 系统总体结构图：产品涉及的系统整体所处环境分解关系、各层次作用以及数据传递关系，便于理解各系统之间如何配合工作，各自边界是什么。
     - 网络拓扑结构图：系统所处的网络环境，用于理解各系统部署情况。帮助读者理解集群，负载，网络安全等相关信息，便于产品设计和相关决策。

   - 假设和约束：指的是产品在实现过程中，必须满足的假设条件和所受的限制。

4. <font color=red size=4>**基本结构**</font>

   - **封面**：封面显示公司形象，是需求的门面，主要包含以下内容：

     - 公司信息：包含但不仅限于logo，名称，传真等，一方面提升公司形象，一方面便于联系；
     - 保密级别：公开，普通，机密，绝密等。**这同时也是一种免责声明**；
     - 文档名称：xx项目/产品 PRD；
     - 文档编号：如果公司有要求则按公司要求，无要求则根据产品体系自行填写，文件名最好带上文档编号；
     - 文档编写人：编写人信息，包含部门， 姓名等，代表的是一种责任；
     - 编写时间：一般为重要文档版本对外发布时间。

   - **版本信息**：又叫修改控制纪录，这部分就像软件的更新说明一样，表明文档与上个版本有什么区别。

     <img src="https://s1.ax1x.com/2020/06/28/NchDu4.png" width='70%'/>

   - **编制说明**：一般情况下PRD文档都省略或合并了这个部分，在背景或概要描述时顺便提一句。

     - 编制来源：描述因何进行编写文档。如：因什么政策，有xx公司牵头和参与，以什么为目标，展开本次工作。
     - 编制过程：描述文档编制的过程。如：x日成立工作组，x日组织了研讨，x日组织专家分析，x日正式启动编写。
     - 文档体系结构：用于描述本项目或产品涉及所有文档，如：xx综述分册，xx业务模型分册，xx需求规格分册，xx数据模型分册等。
     - 编制说明：用于描述当前文档的定位和边界，如：本文档负责是承接并叙述xx相关成果内容，起草单位：xxx。

   - **目录与正文**:是帮助读者理解项目和产品本身。

     - 项目／产品描述：叙述该项软件／产品应用目标、作用范围以及其他应向读者说明的有关该软件开发的背景材料。应用目标：可以理解为产品要解决什么问题，如：针对xx状态下，无法进行xxx的情况，使xx产品可以通过xxx完成对xxx的工作开展。范围：明确产品边界，说明产品将干什么，不干什么。开发背景：为何要开发这个产品，一般情况下根据团队理解程度，节选BRD、MRD相关调研背景资料。
     - 系统模型：用于帮助读者理解系统整体结构，常用于向上汇报，**帮助理解系统整体运作**。系统总体结构图：产品涉及的系统整体所处环境分解关系、各层次作用以及数据传递关系，便于理解各系统之间如何配合工作，各自边界是什么。网络拓扑结构图：系统所处的网络环境，用于理解各系统部署情况。帮助读者理解集群，负载，网络安全等相关信息，便于产品设计和相关决策。
     - 假设和约束：指的是产品在实现过程中，必须满足的假设条件和所受的限制。

5. <font color=red size=4>**功能需求**</font>

   - 业务：求帮助理解产品的业务需求和内容，重点是优先级的设定：**可用性的、用户体验性、扩展性、生态需求**等等
     - 产品描述：总整体上解释和描述产品定位，产品目标。

     - 概要功能列表：列出文档涉及的功能列表清单，包含如：序号，需求序号，功能名称，需求描述，需求类型，需求分析，优先级
   - 产品结构图：帮助了解产品功能和总体形态的概貌。全局功能结构：表达这个产品整体的功能层次和逻辑关系，通常用脑图来表达。页面结构图：以页面为基准，描述产品各页面的层次结构，常用于移动端产品，可用结构图表达。
   - 业务流程：帮助理解产品的业务关系和流程。产品用例图：以不同的用户或角色为基点，通过用例，表达用户会使用的功能边界，常见于后台系统。整体流程图：用于描述某个整体任务时，各模块之间的配合关系，常见于后台系统。全局数据流：用于描述纪录或表单等信息的流转关系或层次结构，常用于后台系统。
   - 详细功能需求：是PRD核心中的核心，用于描述功能的量化指标，是研发部门关注的重点。业务功能：核心功能报表功能：提供数据分析，互联网公司的专属资产；
   - 数据字典：列出有关功能的数据元素，或信息结构。

6. <font color=red size=4>**非功能需求**</font>

   - 接口需求：包含面对不同主体，产品对外提供的接口要求，以供各主体使用。前后端交互格式；文件格式、大小；报表格式。
   - 数据需求：此部分包含对数据库、数据库文件、数据集等进行规定。可能包括数据使用频率、存取能力、数据备份、数据档案、数据保存等要求。
   - 操作：用于说明和业务相关的用户要求的一些操作
   - 性能需求：描述产品交互过程中的数值需求，这部分的要求是可以度量的具体指标。精度；时间特性；灵活性。
   - 属性：描述产品的相关属性要求，可以从安全性、可维护性、可用性进行描述。
   - 其他需求：最后作为项目的补充说明其他的特殊性。

# ---

<img src="F:/视频收藏_IT开发/class04_产品开发/part01_产品基础/resources/part02_06_三大文档_PRD"/>

#### :dash: <font color=red size=4>**基本结构**</font>

**:one: 封面**：封面显示公司形象，是需求的门面，主要包含以下内容：

- 公司信息：包含但不仅限于logo，名称，传真等，一方面提升公司形象，一方面便于联系；
- 保密级别：公开，普通，机密，绝密等。**这同时也是一种免责声明**；
- 文档名称：xx项目/产品 PRD；
- 文档编号：如果公司有要求则按公司要求，无要求则根据产品体系自行填写，文件名最好带上文档编号；
- 文档编写人：编写人信息，包含部门， 姓名等，代表的是一种责任；
- 编写时间：一般为重要文档版本对外发布时间。

**:two: 版本信息**：又叫修改控制纪录，这部分就像软件的更新说明一样，表明文档与上个版本有什么区别。

<img src="F:/视频收藏_IT开发/class04_产品开发/part01_产品基础/resources/part02_06_PRD_版本表格"/>

:three: **编制说明**：一般情况下PRD文档都省略或合并了这个部分，在背景或概要描述时顺便提一句。

- 编制来源：描述因何进行编写文档。如：因什么政策，有xx公司牵头和参与，以什么为目标，展开本次工作。
- 编制过程：描述文档编制的过程。如：x日成立工作组，x日组织了研讨，x日组织专家分析，x日正式启动编写。
- 文档体系结构：用于描述本项目或产品涉及所有文档，如：xx综述分册，xx业务模型分册，xx需求规格分册，xx数据模型分册等。
- 编制说明：用于描述当前文档的定位和边界，如：本文档负责是承接并叙述xx相关成果内容，起草单位：xxx。

:four: **目录与正文**

#### :dash: 概述

>  是**帮助读者理解项目和产品**本身。

:one: 项目／产品描述：叙述该项软件／产品应用目标、作用范围以及其他应向读者说明的有关该软件开发的背景材料。

- 应用目标：可以理解为产品要解决什么问题，如：针对xx状态下，无法进行xxx的情况，使xx产品可以通过xxx完成对xxx的工作开展。
- 范围：明确产品边界，说明产品将干什么，不干什么。
- 开发背景：为何要开发这个产品，一般情况下根据团队理解程度，节选BRD、MRD相关调研背景资料。

:two: 系统模型：用于帮助读者理解系统整体结构，常用于向上汇报，**帮助理解系统整体运作**。

- 系统总体结构图：产品涉及的系统整体所处环境分解关系、各层次作用以及数据传递关系，便于理解各系统之间如何配合工作，各自边界是什么。
- 网络拓扑结构图：系统所处的网络环境，用于理解各系统部署情况。帮助读者理解集群，负载，网络安全等相关信息，便于产品设计和相关决策。

:three: 假设和约束：指的是产品在实现过程中，必须满足的假设条件和所受的限制。

#### :dash: 引言

> 是PRD正文部分的开始部分，其作用是**提供辅助读者深入理解整个文档所需的其它相关信息**

:one: **背景**：描述所说明的软件的应用，尽可能精确地描述所有相关的利益干系人

> 如：xx产品，是由xxx与xxx合作项目，由xxx提出，由xxx承担开发人物，目前用户为xx项目的车主。

:two: **参与资料**：列出有关资料的名称、文件编号、发表日期、出版单位、作者等，并说明参考文件的来源。包含但不仅限于：

- 经过核准的任务计划书
- 上级机关批文
- 项目相关的合同
- 本项目其它已发表的文件，如：MRD、原型
- 文中引用的其它文件、研发规范

:three: 术语：列出本文件中用到的专业术语的定义和缩略语对照，便于理解，适用于接触新业务领域的团队。

<img src="F:/视频收藏_IT开发/class04_产品开发/part01_产品基础/resources/part02_07_术语表"/>

#### :dash: 功能需求

:one: 业务：求帮助理解产品的业务需求和内容

- 产品描述：总整体上解释和描述产品定位，产品目标。

- 概要功能列表：列出文档涉及的功能列表清单

  <img src="F:/视频收藏_IT开发/class04_产品开发/part01_产品基础/resources/part02_08_功能概要列表" width=600>

  > 重点是优先级的设定：**可用性的、用户体验性、扩展性、生态需求**等等

:two: 产品结构图：帮助了解产品功能和总体形态的概貌。

- 全局功能结构：表达这个产品整体的功能层次和逻辑关系，通常用脑图来表达。
- 页面结构图：以页面为基准，描述产品各页面的层次结构，常用于移动端产品，可用结构图表达。

:three: 业务流程：帮助理解产品的业务关系和流程。

- 产品用例图：以不同的用户或角色为基点，通过用例，表达用户会使用的功能边界，常见于后台系统。
- 整体流程图：用于描述某个整体任务时，各模块之间的配合关系，常见于后台系统。
- 全局数据流：用于描述纪录或表单等信息的流转关系或层次结构，常用于后台系统。

:four: 详细功能需求：是PRD核心中的核心，用于描述功能的量化指标，是研发部门关注的重点。

- 业务功能：核心功能
- 报表功能：提供数据分析，互联网公司的专属资产；

:five: 数据字典：列出有关功能的数据元素，或信息结构。

#### :dash: 非功能需求

:one: 接口需求：包含面对不同主体，产品对外提供的接口要求，以供各主体使用。

- 前后端交互格式
- 文件格式、大小
- 报表格式

:two: 数据需求：此部分包含对数据库、数据库文件、数据集等进行规定。可能包括数据使用频率、存取能力、数据备份、数据档案、数据保存等要求。

:three: 操作：用于说明和业务相关的用户要求的一些操作

:four: 性能需求：描述产品交互过程中的数值需求，这部分的要求是可以度量的具体指标。

- 精度
- 时间特性
- 灵活性

:five: 属性：描述产品的相关属性要求，可以从安全性、可维护性、可用性进行描述。

:six: 其他需求：最后作为项目的补充说明其他的特殊性。