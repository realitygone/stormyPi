CREATE VIEW [log].[v_etl_executions]
AS
SELECT [Audit_key],
	[Task_name],
	[File_name],
	[Processing_Start],
	[Processing_end],
	DATEDIFF(mi,[Processing_Start],COALESCE([Processing_end],GETDATE())) as Duration_minutes,
	--DATEDIFF(hh,[Processing_Start],COALESCE([Processing_end],GETDATE())) as dur_hour,
	[Items_processed],
	[Items_successful],
	[Items_error],
	[Success],
	[Row_count_start],
	[Row_count_end],
	[Execution_GUID]
FROM [log].[etl_executions];