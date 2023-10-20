

/****** Object:  UserDefinedFunction [dbo].[udf_StripHTML]    Script Date: 9/14/2023 6:43:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE FUNCTION [dbo].[udf_StripHTML_test] (@HTMLText VARCHAR(MAX))
RETURNS VARCHAR(MAX) AS
BEGIN
    DECLARE @Start INT
    DECLARE @End INT
    DECLARE @Length INT
	 ,@startPosition int
      ,@endPostition int
	  ,@encrypted varchar(max)
 SET @startPosition = (SELECT PATINDEX('%encrypted>%',@HTMLText)+10) 
 SET @endPostition =(SELECT PATINDEX('%</encrypted%',@HTMLText)) -@startPosition

 --sELECT @startPosition,@endPostition
 SET @encrypted =(SELECT SUBSTRING(@HTMLText,@startPosition,@endPostition))

    SET @Start = CHARINDEX('<',@HTMLText)
    SET @End = CHARINDEX('>',@HTMLText,CHARINDEX('<',@HTMLText))
    SET @Length = (@End - @Start) + 1
    WHILE @Start > 0 AND @End > 0 AND @Length > 0
    BEGIN
        SET @HTMLText = STUFF(@HTMLText,@Start,@Length,'')
        SET @Start = CHARINDEX('<',@HTMLText)
        SET @End = CHARINDEX('>',@HTMLText,CHARINDEX('<',@HTMLText))
        SET @Length = (@End - @Start) + 1
    END
    RETURN REPLACE(REPLACE(REPLACE(REPLACE(LTRIM(RTRIM(REPLACE(@HTMLText,'&nbsp;',''))),'Dear sir/madam',''),'Dear Sir or Madam,','') ,'hi,', ''),@encrypted,'')
END
GO



GO
/****** Object:  UserDefinedFunction [dbo].[udf_StripHTML]    Script Date: 9/19/2023 8:51:37 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  ALTER FUNCTION [dbo].[udf_StripHTML] (@HTMLText VARCHAR(MAX))
RETURNS VARCHAR(MAX) AS
BEGIN
    DECLARE @Start INT
    DECLARE @End INT
    DECLARE @Length INT

	
DECLARE @StartPos  int
DECLARE @EndPos    int
DECLARE @LengthPos int


SET @StartPos = CHARINDEX('<encrypted', @HTMLText)
SET @EndPos = CHARINDEX('</encrypted>', @HTMLText, CHARINDEX('<', @HTMLText)) + 12
SET @LengthPos = (@EndPos - @StartPos) + 1

WHILE (@StartPos > 0 AND @EndPos > 0 AND @LengthPos > 0) 
BEGIN
SET @HTMLText = STUFF(@HTMLText, @StartPos, @LengthPos, '')
SET @StartPos = CHARINDEX('<encrypted', @HTMLText)
SET @EndPos = CHARINDEX('</encrypted>', @HTMLText, CHARINDEX('</encrypted>', @HTMLText)) + 12
SET @LengthPos = (@EndPos - @StartPos) + 1
END



    SET @Start = CHARINDEX('<',@HTMLText)
    SET @End = CHARINDEX('>',@HTMLText,CHARINDEX('<',@HTMLText))
    SET @Length = (@End - @Start) + 1
    WHILE @Start > 0 AND @End > 0 AND @Length > 0
    BEGIN
        SET @HTMLText = STUFF(@HTMLText,@Start,@Length,'')
        SET @Start = CHARINDEX('<',@HTMLText)
        SET @End = CHARINDEX('>',@HTMLText,CHARINDEX('<',@HTMLText))
        SET @Length = (@End - @Start) + 1
    END
    RETURN replace(replace(REPLACE(LTRIM(RTRIM(replace(@HTMLText,'&nbsp;',''))),'Dear sir/madam',''),'Dear Sir or Madam,','') ,'hi,', '')
END

