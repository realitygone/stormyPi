CREATE VIEW [log].[v_current_execution]
AS
SELECT [Audit_key],
	[Task_name],
	[File_name],
	[Processing_Start],
	[Processing_end],
	DATEDIFF(mi,[Processing_Start],COALESCE([Processing_end],GETDATE())) as Dur_minute
	--DATEDIFF(hh,[Processing_Start],COALESCE([Processing_end],GETDATE())) as dur_hour
FROM [log].[etl_executions]
WHERE [File_name] IS NULL OR [Processing_end] IS NULL;