CREATE TABLE [log].[etl_errors] (
	[Audit_key] INT NOT NULL,
	[Error_timestamp] DATETIME2(7) NOT NULL
		CONSTRAINT [DF_etl_errors_Error_timestamp] DEFAULT SYSDATETIME(),
	[Error_message] NVARCHAR(MAX) NULL
);