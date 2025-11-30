CREATE TABLE [dbo].[DimBook](
	[BookSK] [int] IDENTITY(1,1) NOT NULL,
	[book_id] [int] NOT NULL,
	[title] [varchar](400) NULL,
	[isbn13] [varchar](13) NULL,
	[language_code] [varchar](8) NULL,
	[language_name] [varchar](50) NULL,
	[num_pages] [int] NULL,
	[publication_date] [date] NULL,
	[publisher_name] [varchar](400) NULL

)

