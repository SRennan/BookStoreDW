CREATE TABLE [dbo].[DimShippingMethod](
	[MethodSK] [int] IDENTITY(1,1) NOT NULL,
	[method_id] [int] NOT NULL,
	[method_name] [varchar](100) NULL,
	[cost] [decimal](6, 2) NULL
)

