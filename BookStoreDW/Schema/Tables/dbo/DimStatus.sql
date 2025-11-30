CREATE TABLE [dbo].[DimStatus](
	[StatusSK] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NOT NULL,
	[status_value] [varchar](20) NULL,
	[Status_dateKey] [int] NOT NULL,
	[status_date] [datetime] NULL
)