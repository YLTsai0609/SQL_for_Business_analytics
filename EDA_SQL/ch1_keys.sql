主鍵（Primary Key）：
主鍵是一個唯一且非空的欄位或一組欄位的集合，用於唯一標識資料表中的每一行。
主鍵確保資料表中的每一行都具有唯一的識別標識，並且不允許其中的任何值為 NULL。
主鍵通常用於建立資料表之間的關聯（例如，作為外部鍵的參考鍵），或者用於提高查詢效能（例如，作為索引的依據）。

外部鍵（Foreign Key）：
外部鍵是資料表中的一個欄位或一組欄位，它建立了與另一個資料表的關聯。
外部鍵用於維護資料表之間的關係，它指向另一個資料表的主鍵或唯一鍵。
外部鍵通常用於實現資料表之間的參照完整性（Referential Integrity），確保相關聯的資料表之間的一致性和有效性。例如，當在一個資料表中插入、更新或刪除資料時，外部鍵可以用來確保相關聯的資料表不會出現無效的引用或不一致的數據。