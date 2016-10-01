CREATE TABLE [log].[etl_error_rows] (
	[Error_timestamp] DATETIME2(7) NOT NULL
		CONSTRAINT [DF_etl_error_rows_Timestamp] DEFAULT SYSDATETIME(),
	[Package_name] NVARCHAR(256) NULL,
	[Filename] NVARCHAR(2000) NULL,
	[Row_content] NVARCHAR(MAX) NULL
);