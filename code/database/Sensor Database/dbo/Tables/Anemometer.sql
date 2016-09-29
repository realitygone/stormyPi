CREATE TABLE [dbo].[Anemometer] (
	[System_timestamp] DATETIME NULL,
	[System_epoch_time] INT,
	[System_milliseconds] INT,
	[Wind_speed] DECIMAL(9,7) NULL,
	[Raw_ADC_value] INT NULL
);