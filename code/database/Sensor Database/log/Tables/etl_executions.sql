CREATE TABLE [log].[etl_executions] (
	[Audit_key] INT IDENTITY(1,1) NOT NULL,
	[Parent_audit_key] INT NULL,
	[Task_name] NVARCHAR(128) NULL,
	[Processing_start] DATETIME2(7) NOT NULL
		CONSTRAINT [DF_etl_executions_Processing_start] DEFAULT SYSDATETIME(),
	[Processing_end] DATETIME2(7) NULL,
);