# [SQL Query Execution Order](https://www.linkedin.com/pulse/understanding-sql-query-execution-order-optimizing-akshay-lakade/)

# Steps

1. Identify data source tables
2. Merged using `FROM` and `JOIN`
   1. may apply different join algorithm.
3. Filter by `WHERE`
   1. narrow donw the dataset
4. Grouped - `GROUP BY`
   1. shffule the data by given grouping (key) - NetworkIO
5. Filter by `HAVING`
   1. filter after aggregation
6. Select - `SELECT`
   1. select the data you need.
7. Ordered - `ORDER BY`
8. Linited - `LIMIT`

# Optimization Techs

1. Indexing - PK 可以找得更快， WHERE 一樣找整個欄位，但是後面是 B-Tree ， 可以找得更快
2. Partitioning - 資料分區放好， WHERE 不用整個欄位掃描
3. Caching - 複雜的 ETL, 分段做，把中間結果存起來，這樣不用每一次查詢都重頭跑
4. Minimize Data Retrieval - 只拿要的，不要全拿，全拿使得 NetworkIO 變長很多

# Indexing vs Partitioning

## Pattitioning

[[System Design] 淺談Database Partition. Centralized and Distributed.](https://homuchen.com/posts/what-is-database-partition-sharding/)

* Pattition - 把資料切成很多包，每一包有一個號碼，例如日期
* 沒有一定要分散式，單機也可以
* 有 Horizontal partition 也有 vertical partition - 按照日期切，通常是 Horizontal partition
* BQ 支援 partition 的都是支援數字、 Range, Hour, Date,  Year - 猜測背後是用樹實做，因為數字可以排序好， metadata 只放在一台機器， query 時， 先找到要哪一塊資料
  * 背後用什麼資料結構都可以， Tree, Hashtable, xxx

## vs Indexing

INDEX（索引）：
* 介紹：索引是用於加速查詢的機制，它建立了一個額外的數據結構，用於快速定位和檢索數據行。當你在 BigQuery 中創建索引時，它會對特定列中的數據進行排序和分區，以便在查詢中更有效地定位數據。

* 適用場景：對於需要快速查詢特定列的數據，並且該列中的數據量巨大的情況下，索引是非常有用的。例如，**如果你經常需要按照用戶ID來查詢數據，那麼在用戶ID列上建立索引可以提高查詢效率。**

* ~~底層資料結構：BigQuery的索引實現是基於分區和排序，它使用了類似於B樹（B-tree）或B+樹（B+ tree）的數據結構來實現快速查詢。~~
* 事實上 BQ 2023 才支援 search index，但一般來說， 根據 ID 等條件給出一個 row， 在 OLTP 比較常見， OLAP ， 通常要選個是特定範圍，仍然是一大坨資料，所以更常使用 Partitioning

Partition（分區）：
* 介紹：分區是將表格中的數據按照某種特定的標準分割成多個獨立的區塊。分區可以根據時間、地理位置、用戶ID等特徵來進行。BigQuery 支持在表格中使用日期、時間和整數列進行分區。
* 適用場景：當你需要對表中的數據進行特定條件的篩選或者是進行時間序列分析時，分區是非常有用的。例如，如果你有一個包含大量時間序列數據的表格，你可以根據日期對其進行分區，這樣就可以只查詢特定日期範圍內的數據，從而提高查詢效率。
* 底層資料結構：分區通常使用類似於B樹的數據結構來實現，使得可以快速定位到指定區域的數據。
總的來說，索引和分區是用於提高查詢效率的兩種不同機制。索引適用於對特定列的查詢進行優化，而分區則適用於對表格中的數據進行更精細的管理和查詢範圍的限制。在使用時，需要根據具體的場景和需求來選擇使用哪一種機制或者是結合兩者來提高查詢效率。

------------------------------------------------------------

相同處：

1. 提高查詢效率：索引和分區都旨在提高數據查詢的效率，使得能夠更快速地定位和檢索數據。
2. 用於大型數據集：無論是索引還是分區，都特別適用於大型數據集，因為當數據量很大時，查詢效率往往會受到影響，這時候就需要這些優化機制來提高效率。

不同處：

1. 應用場景：
索引主要用於加速特定列的查詢，它可以在任何列上建立，並且可以針對特定的查詢需求進行優化。
分區則更多地用於管理數據的組織結構和篩選查詢範圍。例如，按照日期對數據進行分區，可以使得在特定日期範圍內的查詢更快速。
2. 資料結構：
索引通常使用類似於B樹（B-tree）或B+樹（B+ tree）等資料結構來實現，它們可以快速定位和檢索特定值。
分區的底層資料結構通常也是類似於B樹的結構，但它更多地用於將數據分割成獨立的區域，並對這些區域進行管理。
3. 功能：
索引主要提供快速查詢的功能，它可以加速查詢過程，但對於數據的組織結構並無干預。
分區不僅提供了查詢優化，還可以對數據進行更細緻的管理，例如定期對過期數據進行清理，或者對特定區域的數據進行更頻繁的操作。
總的來說，索引和分區都是用於提高查詢效率的重要機制，但它們的應用場景、底層資料結構和功能各有不同，需要根據具體的需求來選擇合適的機制或者結合兩者來達到更好的效果。


# Search Index

[BQ 的新功能 - 2023](https://medium.com/@saivineel.t/run-your-queries-in-bigquery-faster-with-search-indexes-fb8ad633cbff)

* 主要是作為搜尋，但主力還是 Partitioning

# TODO:
read this - https://www.cda.cn/discuss/post/details/5f03e1c6ee78f1071d5939b9