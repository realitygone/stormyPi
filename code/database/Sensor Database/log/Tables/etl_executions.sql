CREATE TABLE [log].[etl_executions] (
	[Audit_key] INT IDENTITY(1,1) NOT NULL,
	[Parent_audit_key] INT NULL,
	[Task_name] NVARCHAR(128) NULL,
	[File_name] NVARCHAR(2000) NULL,
	[Processing_start] DATETIME2(7) NOT NULL
		CONSTRAINT [DF_etl_executions_Processing_start] DEFAULT SYSDATETIME(),
	[Processing_end] DATETIME2(7) NULL,
	[Items_processed] INT NULL,
	[Items_successful] INT NULL,
	[Items_error] INT NULL,
	[Row_count_start] INT NULL,
	[Row_count_end] INT NULL,
	[Success] BIT NULL,
	[Execution_GUID] NVARCHAR(256) NULL
);