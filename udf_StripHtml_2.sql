CREATE FUNCTION dbo.udf_StripHtml_2 (@html NVARCHAR(MAX))
RETURNS NVARCHAR(MAX)
as
BEGIN
declare @start int, @end int, @length int

--Replace the HTML entity & with the '&' character (this needs to be done first, as
--'&' might be double encoded as '&amp;')
set @start = charindex('&', @html)
set @end = @start + 4
set @length = (@end - @start) + 1

while (@start > 0 and @end > 0 and @length > 0) begin
set @html = stuff(@html, @start, @length, '&')
set @start = charindex('&', @html)
set @end = @start + 4
set @length = (@end - @start) + 1
end

--Replace the HTML entity < with the '<' character
set @start = charindex('<', @html)
set @end = @start + 3
set @length = (@end - @start) + 1

while (@start > 0 and @end > 0 and @length > 0) begin
set @html = stuff(@html, @start, @length, '<')
set @start = charindex('<', @html)
set @end = @start + 3
set @length = (@end - @start) + 1
end

--Replace the HTML entity > with the '>' character
set @start = charindex('>', @html)
set @end = @start + 3
set @length = (@end - @start) + 1

while (@start > 0 and @end > 0 and @length > 0) begin
set @html = stuff(@html, @start, @length, '>')
set @start = charindex('>', @html)
set @end = @start + 3
set @length = (@end - @start) + 1
end

--Replace the HTML entity & with the '&' character
set @start = charindex('&amp;', @html)
set @end = @start + 4
set @length = (@end - @start) + 1

while (@start > 0 and @end > 0 and @length > 0) begin
set @html = stuff(@html, @start, @length, '&')
set @start = charindex('&amp;', @html)
set @end = @start + 4
set @length = (@end - @start) + 1
end

--Replace the HTML entity   with the ' ' character
set @start = charindex(' ', @html)
set @end = @start + 5
set @length = (@end - @start) + 1

while (@start > 0 and @end > 0 and @length > 0) begin
set @html = stuff(@html, @start, @length, ' ')
set @start = charindex(' ', @html)
set @end = @start + 5
set @length = (@end - @start) + 1
end

--Replace any
--tags with a newline
set @start = charindex('
', @html)
set @end = @start + 3
set @length = (@end - @start) + 1

while (@start > 0 and @end > 0 and @length > 0) begin
set @html = stuff(@html, @start, @length, CHAR(13) + CHAR(10))
set @start = charindex('
', @html)
set @end = @start + 3
set @length = (@end - @start) + 1
end

--Replace any
--tags with a newline
set @start = charindex('
', @html)
set @end = @start + 4
set @length = (@end - @start) + 1

while (@start > 0 and @end > 0 and @length > 0) begin
set @html = stuff(@html, @start, @length, 'CHAR(13) + CHAR(10)')
set @start = charindex('
', @html)
set @end = @start + 4
set @length = (@end - @start) + 1
end

--Replace any
--tags with a newline
set @start = charindex('
', @html)
set @end = @start + 5
set @length = (@end - @start) + 1

while (@start > 0 and @end > 0 and @length > 0) begin
set @html = stuff(@html, @start, @length, 'CHAR(13) + CHAR(10)')
set @start = charindex('
', @html)
set @end = @start + 5
set @length = (@end - @start) + 1
end

--Remove anything between tags
set @start = charindex('<', @html)
set @end = charindex('>', @html, charindex('<', @html))
set @length = (@end - @start) + 1

while (@start > 0 and @end > 0 and @length > 0) begin
set @html = stuff(@html, @start, @length, '')
set @start = charindex('<', @html)
set @end = charindex('>', @html, charindex('<', @html))
set @length = (@end - @start) + 1
end
return ltrim(rtrim(@html))
END