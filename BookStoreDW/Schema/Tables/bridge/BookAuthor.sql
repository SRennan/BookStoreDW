CREATE TABLE [bridge].[BookAuthor]
(
	[bookSK] [int] NOT NULL,
	[authorSK] [int] NOT NULL,
);
GO
ALTER TABLE [bridge].[BookAuthor]  WITH CHECK ADD  CONSTRAINT [FK_BookAuthor] FOREIGN KEY([bookSK])
REFERENCES [dbo].DimBook ([BookSK])

GO
ALTER TABLE [bridge].[BookAuthor]  WITH CHECK ADD  CONSTRAINT [FK_AuthorBook] FOREIGN KEY([authorSK])
REFERENCES [dbo].DimAuthor ([AuthorSK])
GO


