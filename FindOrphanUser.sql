DECLARE cur CURSOR FAST_FORWARD FOR 
SELECT name FROM sys.databases 
WHERE database_id > 4 

OPEN cur  

DECLARE @SQL NVARCHAR(MAX), @DBName SYSNAME 
DECLARE @Results TABLE (DBName SYSNAME, UserName SYSNAME, UserSID VARBINARY(MAX))  

FETCH NEXT FROM cur into @DBName  

WHILE @@FETCH_STATUS = 0 
BEGIN 
	SET @SQL = 'USE ' + @DBName + ';SELECT ''' + @DBName + ''' AS DBName, 
			UserName = name, UserSID = sid from sysusers 
			WHERE issqluser = 1 AND 
				(sid IS NOT NULL AND sid <> 0x0) AND 
				(LEN(sid) <= 16) AND SUSER_SNAME(sid) IS NULL'     

	INSERT INTO @Results 
	EXEC(@SQL)  

	FETCH NEXT FROM cur into @DBName  
END  

CLOSE cur 
DEALLOCATE cur  

SELECT * FROM @Results
