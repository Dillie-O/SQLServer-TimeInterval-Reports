CREATE PROCEDURE [dbo].[GenerateReportCounts] (@start DATETIME, @end DATETIME, @interval INT)
AS

DECLARE @TimeIntervals TABLE(timeinterval DATETIME)
DECLARE @UpdateCounts TABLE(rounded_time DATETIME, roundcount INT, column_name VARCHAR(200))

INSERT INTO @TimeIntervals EXEC dbo.TimeIntervalTable @start, @end, @interval

INSERT INTO @UpdateCounts EXEC dbo.GetApplicationsCreatedAtCounts @start, @end
INSERT INTO @UpdateCounts EXEC dbo.GetApplicationsUpdatedAtCounts @start, @end

SELECT t.timeinterval AS time_slot, 
       CASE WHEN u.roundcount IS NULL THEN 0 ELSE u.roundcount END AS update_count,
       CASE WHEN u.roundcount IS NULL THEN 'None' ELSE u.column_name END AS column_name
  FROM @TimeIntervals t
       LEFT OUTER JOIN @UpdateCounts u ON u.rounded_time = t.timeinterval
ORDER BY t.timeinterval ASC