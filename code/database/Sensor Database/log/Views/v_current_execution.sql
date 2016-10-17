CREATE VIEW log.v_current_execution
AS
WITH all_tasks AS (
	SELECT Audit_key
	FROM log.etl_executions
	WHERE Task_name='Master ETL'
		AND (
			Processing_end IS NULL
			OR
			Processing_end = (SELECT MAX(Processing_end) FROM log.etl_executions WHERE Task_name='Master ETL')
		)

	UNION ALL

	SELECT l.Audit_key
	FROM all_tasks AS a
	INNER JOIN log.etl_executions AS l ON l.Parent_audit_key=a.Audit_key
)
SELECT l.*
FROM all_tasks AS a
INNER JOIN log.v_etl_executions AS l ON l.Audit_key=a.Audit_key;