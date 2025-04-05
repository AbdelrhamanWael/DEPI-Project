DECLARE @dbName NVARCHAR(255)
DECLARE @tableName NVARCHAR(255)
DECLARE @sql NVARCHAR(MAX)

-- Declare cursor to loop through all user databases
DECLARE db_cursor CURSOR FOR
SELECT name
FROM sys.databases
WHERE state_desc = 'ONLINE' AND name NOT IN ('master', 'model', 'msdb', 'tempdb')

OPEN db_cursor
FETCH NEXT FROM db_cursor INTO @dbName
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Build SQL for truncating all tables in the database
    SET @sql = 'USE ' + QUOTENAME(@dbName) + ';'

    -- Declare another cursor to loop through all tables in the current database
    DECLARE table_cursor CURSOR FOR
