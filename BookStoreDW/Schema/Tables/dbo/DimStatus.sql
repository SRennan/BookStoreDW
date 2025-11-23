CREATE TABLE [dbo].[DimStatus]
(
	[StatusSK] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[status_id] [int] NOT NULL,
	[status_value] [varchar](20) NULL,

)