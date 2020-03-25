# MongoDB的

1. MongoDB是使用文档模型的设计范式，推荐使用文档嵌套的模式代替多表关联的模型（这种设计反范式）
2. MongoDB基于JSON和JavaScript语法，需要系统深入的学习
3. MongoDB通过分片进行横向扩展，这块技术是学习难点

# 第一章 MongoDB再入门



# 第二章 从熟练到精通



# 第三章 分片集群与运维



# 第四章 架构师进阶





# MongoDB CRUD操作

## Create 新增文档

- 创建或插入操作是向一个集合总新增一个文档, 如果当前集合不存在, 插入操作会创建出这个集合

- MongoDB提供以下方法向集合中插入文档

    ```js
    db.<collection>.insert()
    db.<collection>.insertOne()
    db.<collection>.insertMany()
    ```

    > 在MongoDB中，insert操作针对单个集合。, MongoDB中的所有写操作都是单个文档级别上的原子操作

- [create](./create.md) 学习笔记

## Read 查询文档

- 读取操作是从一个集合中检索文档, 即在集合中查询文档, MongoDB提供了以下方法在集合中查询

    ```sh
    db.<collection>.find()
    ```

- [read](./read.md) 学习笔记

## Update 修改文档

- 修改操作

    ```js
    db.<collection>.update()
    db.<collection>.updateOne()
    db.<collection>.updateMany()
    db.<collection>.replaceOne()
    ```

- [update](./update.md) 学习笔记

## Delete

- 删除操作

    ```sj
    db.<collection>.deleteOne()
    db.<collection>.deleteMany()
    ```

- [delete](./delete.md) 学习笔记

