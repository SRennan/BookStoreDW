CREATE TABLE [dbo].[DimBook]
(
	[BookSK] INT NOT NULL PRIMARY KEY IDENTITY(1,1),
	[book_id] [int] NOT NULL,
	[title] [varchar](400) NULL,
	[isbn13] [varchar](13) NULL,
	[language_code] [varchar](8) NULL,
	[language_name] [varchar](50) NULL,
	[num_pages] [int] NULL,
	[publication_date] [date] NULL,
	[publisher_name] [varchar](400) NULL,
	[author_name] [varchar](400) NULL

)

