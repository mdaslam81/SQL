DECLARE @tbl TABLE (
         Id INT
        ,[Name] VARCHAR(20)
        ,ParentId INT
        )

    INSERT INTO @tbl( Id, Name, ParentId )
    VALUES
     (1, 'Europe', NULL)
    ,(2, 'Asia',   NULL)
    ,(3, 'Germany', 1)
    ,(4, 'UK',      1)
    ,(5, 'China',   2)
    ,(6, 'India',   2)
    ,(7, 'Scotland', 4)
    ,(8, 'Edinburgh', 7)
    ,(9, 'Leith', 8)

    ;
WITH  abcd
        AS (
              -- anchor
            SELECT  id, [Name], ParentID,
                    CAST(([Name]) AS VARCHAR(1000)) AS "Path"
            FROM    @tbl
            WHERE   ParentId IS NULL
            UNION ALL
              --recursive member
            SELECT  t.id, t.[Name], t.ParentID,
                    CAST((a.path + '/' + t.Name) AS VARCHAR(1000)) AS "Path"
            FROM    @tbl AS t
                    JOIN abcd AS a
                      ON t.ParentId = a.id
           )
SELECT * FROM abcd