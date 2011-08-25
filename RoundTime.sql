CREATE FUNCTION [dbo].[RoundTime] (@Time DATETIME, @RoundTo FLOAT)
RETURNS DATETIME
AS

BEGIN
   DECLARE @RoundedTime smalldatetime
   DECLARE @Multiplier float

   SET @Multiplier = 24.0 / @RoundTo

   SET @RoundedTime= ROUND(CAST(CAST(CONVERT(VARCHAR, @Time, 121) AS DATETIME) AS FLOAT) * @Multiplier, 0) / @Multiplier
   RETURN @RoundedTime
END