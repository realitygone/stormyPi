CREATE TABLE [staging].[BME280] (
	[System_timestamp] DATETIME2(7) NULL,
	[Sensor_timestamp] INT NULL,
	[Temperature_celcius] DECIMAL(6,3) NULL,
	[Barometric_pressure] DECIMAL(10,2) NULL,
	[Humidity] DECIMAL(5,2),
	[Insert_audit_key] INT NULL
);