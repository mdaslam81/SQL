

SELECT
	    --virtual file latency
	    [ReadLatency] =
	        CASE WHEN [num_of_reads] = 0
	            THEN 0 ELSE ([io_stall_read_ms] / [num_of_reads]) END,
	    [WriteLatency] =
	        CASE WHEN [num_of_writes] = 0
	            THEN 0 ELSE ([io_stall_write_ms] / [num_of_writes]) END,
	    [Latency] =
	        CASE WHEN ([num_of_reads] = 0 AND [num_of_writes] = 0)
	            THEN 0 ELSE ([io_stall] / ([num_of_reads] + [num_of_writes])) END,
	    --avg bytes per IOP
	    [AvgBPerRead] =
	        CASE WHEN [num_of_reads] = 0
	            THEN 0 ELSE ([num_of_bytes_read] / [num_of_reads]) END,
	    [AvgBPerWrite] =
	        CASE WHEN [io_stall_write_ms] = 0
	            THEN 0 ELSE ([num_of_bytes_written] / [num_of_writes]) END,
	    [AvgBPerTransfer] =
	        CASE WHEN ([num_of_reads] = 0 AND [num_of_writes] = 0)
	            THEN 0 ELSE
	                (([num_of_bytes_read] + [num_of_bytes_written]) /
	                ([num_of_reads] + [num_of_writes])) END,
	    LEFT ([mf].[physical_name], 2) AS [Drive],
	    DB_NAME ([vfs].[database_id]) AS [DB],
	    --[vfs].*,
	    [mf].[physical_name]
	FROM
	    sys.dm_io_virtual_file_stats (NULL,NULL) AS [vfs]
	JOIN sys.master_files AS [mf]
	    ON [vfs].[database_id] = [mf].[database_id]
	    AND [vfs].[file_id] = [mf].[file_id]
	-- WHERE [vfs].[file_id] = 2 -- log files
	-- ORDER BY [Latency] DESC
	-- ORDER BY [ReadLatency] DESC
ORDER BY [WriteLatency] DESC;
	GO


SELECT
db_name(database_id)
,file_id As File_ID
,case file_id when 1 then 'Data'
	when 2 then 'Log'
	when 3 then 'Log2'
	when 4 then 'Log3' End As LogicalFileName
, num_of_reads
, num_of_writes
, (num_of_reads + num_of_writes) AS 'Writes + Reads'
, num_of_bytes_read
, num_of_bytes_written
, CAST(100. * num_of_reads/(num_of_reads + num_of_writes)
AS DECIMAL(10,4)) AS '# Reads Pct'
, CAST(100. * num_of_writes/(num_of_reads + num_of_writes)
AS DECIMAL(10,4)) AS '# Write Pct'
, CAST(100. * num_of_bytes_read
/(num_of_bytes_read + num_of_bytes_written)
AS DECIMAL(10,4)) AS 'Read Bytes Pct'
, CAST(100. * num_of_bytes_written
/(num_of_bytes_read + num_of_bytes_written)
AS DECIMAL(10,4)) AS [Written Bytes Pct]
FROM sys.dm_io_virtual_file_stats(DB_ID(N'yourdatabasename'), NULL)
ORDER BY File_ID,[Written Bytes Pct] desc
----------------------------------------------------------------------------------------------------------------

SELECT
db_name(database_id) As Database_Name
,file_id As File_ID
,case file_id when 1 then 'Data'
	when 2 then 'Log'
	when 3 then 'Log2'
	when 4 then 'Log3' End As LogicalFileName
, num_of_reads
, num_of_writes
, (num_of_reads + num_of_writes) AS 'Writes + Reads'
, num_of_bytes_read
, num_of_bytes_written
, CAST(100. * num_of_reads/(num_of_reads + num_of_writes)
AS DECIMAL(10,4)) AS '# Reads Pct'
, CAST(100. * num_of_writes/(num_of_reads + num_of_writes)
AS DECIMAL(10,4)) AS '# Write Pct'
, CAST(100. * num_of_bytes_read
/(num_of_bytes_read + num_of_bytes_written)
AS DECIMAL(10,4)) AS 'Read Bytes Pct'
, CAST(100. * num_of_bytes_written
/(num_of_bytes_read + num_of_bytes_written)
AS DECIMAL(10,4)) AS [Written Bytes Pct]
FROM sys.dm_io_virtual_file_stats(NULL, NULL)
ORDER BY database_name desc
