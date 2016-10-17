CREATE VIEW log.v_etl_executions
AS
SELECT *,
	CAST(CASE 
		WHEN duration_seconds > 3600 THEN CAST(duration_seconds AS DECIMAL(10,2))/3600
		WHEN duration_seconds > 60 THEN CAST(duration_seconds AS DECIMAL(10,2))/60
		ELSE duration_seconds
	END AS NVARCHAR(MAX)) +
	CASE 
		WHEN duration_seconds > 3600 THEN ' hours'
		WHEN duration_seconds > 60 THEN ' minutes'
		ELSE ' seconds'
	END AS duration_label
FROM (
	SELECT Audit_key,
		Task_name,
		File_name,
		Processing_start,
		Processing_end,
		Items_processed,
		Row_count_end,
		Success,
		DATEDIFF(SS,Processing_start,COALESCE(Processing_end,SYSDATETIME())) AS duration_seconds
	FROM log.etl_executions
) AS x