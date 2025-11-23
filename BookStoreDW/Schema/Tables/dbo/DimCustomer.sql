CREATE TABLE [dbo].[DimCustomer]
(
	[CustomerSK] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[customer_id] [int] NOT NULL,
	[first_name] [varchar](200) NULL,
	[last_name] [varchar](200) NULL,
	[email] [varchar](350) NULL,
	[street_name] [varchar](200) NULL,	
	[street_number] [varchar](10) NULL,
	[city] [varchar](100) NULL,
	[address_status] [varchar](30) NULL,
)

