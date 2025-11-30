CREATE TABLE [dbo].[book_author](
	[book_id] [int] NOT NULL,
	[author_id] [int] NOT NULL,
	[rowversion] [timestamp] NOT NULL,
 CONSTRAINT [pk_bookauthor] PRIMARY KEY CLUSTERED 
(
	[book_id] ASC,
	[author_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]