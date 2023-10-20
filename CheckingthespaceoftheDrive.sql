DECLARE	@Drive TINYINT,
	@SQL VARCHAR(100)

SET	@Drive = 97

-- Setup Staging Area
DECLARE	@Drives TABLE
	(
		Drive CHAR(1),
		Info VARCHAR(80)
	)

WHILE @Drive <= 122
	BEGIN
		SET	@SQL = 'EXEC XP_CMDSHELL ''fsutil volume diskfree ' + CHAR(@Drive) + ':'''
		
		INSERT	@Drives
			(
				Info
			)
		EXEC	(@SQL)

		UPDATE	@Drives
		SET	Drive = CHAR(@Drive)
		WHERE	Drive IS NULL

		SET	@Drive = @Drive + 1
	END

-- Show the expected output
SELECT		Drive,
		SUM(CASE WHEN Info LIKE 'Total # of bytes             : %' THEN CAST(REPLACE(SUBSTRING(Info, 32, 48), CHAR(13), '') AS BIGINT) ELSE CAST(0 AS BIGINT) END) AS TotalBytes,
		SUM(CASE WHEN Info LIKE 'Total # of free bytes        : %' THEN CAST(REPLACE(SUBSTRING(Info, 32, 48), CHAR(13), '') AS BIGINT) ELSE CAST(0 AS BIGINT) END) AS FreeBytes,
		SUM(CASE WHEN Info LIKE 'Total # of avail free bytes  : %' THEN CAST(REPLACE(SUBSTRING(Info, 32, 48), CHAR(13), '') AS BIGINT) ELSE CAST(0 AS BIGINT) END) AS AvailFreeBytes
FROM		(
			SELECT	Drive,
				Info
			FROM	@Drives
			WHERE	Info LIKE 'Total # of %'
		) AS d
GROUP BY	Drive
ORDER BY	Drive

select (22298570752/1073741824) --20GB u drive
select (11025694720/1073741824) --10GB u drive
Select (344591151104/1073741824) --320GB v drive
Select (274394120192/1073741824)-- 255GB
Select * from sysfiles

U:\MSSQL10.SECURATISINSTC\MSSQL\DATA\replprod.mdf

V:\MSSQL10.SECURATISINSTC\MSSQL\Data\replprod_1.ldf


U:\MSSQL10.SECURATISINSTC\MSSQL\DATA\replqa.mdf
V:\MSSQL10.SECURATISINSTC\MSSQL\Data\replqa.ldf