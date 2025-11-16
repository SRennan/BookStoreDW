CREATE TABLE [dbo].[DimCustomer]
(
	[CustomerSK] INT NOT NULL PRIMARY KEY,
	[customer_id] [int] NOT NULL,
	[first_name] [varchar](200) NULL,
	[last_name] [varchar](200) NULL,
	[email] [varchar](350) NULL,
	[rowversion] [timestamp] NOT NULL
)
