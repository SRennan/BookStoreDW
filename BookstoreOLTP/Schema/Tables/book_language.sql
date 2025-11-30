CREATE TABLE [dbo].[book_language](
	[language_id] [int] NOT NULL,
	[language_code] [varchar](8) NULL,
	[language_name] [varchar](50) NULL,
	[rowversion] [timestamp] NOT NULL,
 CONSTRAINT [pk_language] PRIMARY KEY CLUSTERED 
(
	[language_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]