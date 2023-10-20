USE master;
    GO
    ALTER DATABASE tempdb
    MODIFY FILE (NAME = tempdev, SIZE=6000Mb);

	go

	  GO
    ALTER DATABASE tempdb
    MODIFY FILE (NAME = temp8, SIZE=6000Mb);



SELECT 
                name, file_id, type_desc, size * 8 / 1024 [TempdbSizeInMB]
                FROM sys.master_files
                WHERE DB_NAME(database_id) = 'tempdb'
                ORDER BY type_desc DESC, file_id 
go
SELECT name, 
    file_id, 
    type_desc, 
    size * 8 / 1024 [TempdbSizeInMB]
FROM tempdb.sys.database_files
ORDER BY type_desc DESC, 
      file_id;
go

SELECT name ,size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)/128.0 AS AvailableSpaceInMB
FROM sys.database_files;

	  go
sp_spaceused 
DBCC SHRINKFILE(temp3,10)


select * from  tempdb.sys.database_files





CHECKPOINT;
            GO
            DBCC DROPCLEANBUFFERS;
            GO



DBCC FREEPROCCACHE;
            GO