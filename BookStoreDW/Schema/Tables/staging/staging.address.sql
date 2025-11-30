CREATE TABLE [staging].[address](
	[AddressSK] [int] NOT NULL,
	[street_name] [varchar](200) NULL,
	[street_number] [varchar](10) NULL,
	[city] [varchar](100) NULL,
	[country_name] [varchar](200) NULL
) ON [PRIMARY]
GO