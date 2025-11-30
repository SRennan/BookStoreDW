CREATE TABLE [dbo].[DimAddress](
	[AddressSK] [int] IDENTITY(1,1) NOT NULL,
	[address_id] [int] NOT NULL,
	[street_name] [varchar](200) NULL,
	[street_number] [varchar](10) NULL,
	[city] [varchar](100) NULL,
	[country_name] [varchar](200) NULL,
)
