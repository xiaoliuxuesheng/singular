# SQL优化

```sql
-- 优化前SQL
SELECT  各种字段
FROM `table_name`
WHERE 各种条件
LIMIT 0,10;
-- 优化后SQL
SELECT  各种字段
FROM `table_name` main_tale
RIGHT JOIN 
(
SELECT  子查询只查主键
FROM `table_name`
WHERE 各种条件
LIMIT 0,10;
) temp_table ON temp_table.主键 = main_table.主键
```

