CREATE PROCEDURE [dbo].[GetTimeIntervalTable] (@start DATETIME, @end DATETIME, @interval INT)
AS

DECLARE @dt DATETIME, @dtEnd DATETIME, @dtnext DATETIME
DECLARE @results TABLE(timeinterval DATETIME)

SET @dt = @start
SET @dtEnd = @end
SET @dtnext = @start

WHILE @dtnext <= @end
BEGIN
   INSERT INTO @results(timeinterval) VALUES(@dtnext)
   SET @dtnext = dateadd(minute, @interval, @dtnext)
END

SELECT * FROM @results