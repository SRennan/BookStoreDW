CREATE TABLE [dbo].[order_history](
	[history_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[status_id] [int] NULL,
	[status_date] [datetime] NULL,
	[rowversion] [timestamp] NOT NULL,
 CONSTRAINT [pk_orderhist] PRIMARY KEY CLUSTERED 
(
	[history_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
