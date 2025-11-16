CREATE TABLE [dbo].[DimAddress]
(
	[AddressSK] INT NOT NULL PRIMARY KEY,
	[address_id] [int] NOT NULL,
	[street_number] [varchar](10) NULL,
	[street_name] [varchar](200) NULL,
	[city] [varchar](100) NULL,
	[country_name] [varchar](200) NULL,
	[rowversion] [timestamp] NOT NULL
)
