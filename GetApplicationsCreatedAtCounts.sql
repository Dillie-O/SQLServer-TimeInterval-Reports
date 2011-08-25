CREATE PROCEDURE [dbo].[GetApplicationsCreatedAtCounts] (@start DATETIME, @end DATETIME)
AS

SELECT Z.rounded_time, COUNT(*) AS round_count, 'applications_created_at' AS column_name
  FROM (
        SELECT dbo.RoundTime(created_at, .5) AS rounded_time
          FROM applications
       ) AS Z
WHERE rounded_time BETWEEN @start AND @end
GROUP BY z.rounded_time
ORDER BY rounded_time DESC