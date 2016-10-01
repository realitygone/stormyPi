CREATE TABLE [log].[etl_errors] (
	[Master_audit_key] INT NOT NULL,
	[Error_timestamp] DATETIME2(7) NOT NULL
		CONSTRAINT [DF_etl_errors_Error_timestamp] DEFAULT SYSDATETIME(),
	[Source_name] NVARCHAR(MAX) NULL,
	[Error_code] INT NULL,
	[Error_message] NVARCHAR(MAX) NULL
);