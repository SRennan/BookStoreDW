/*
Script de implementación para BookStore_DW

Una herramienta generó este código.
Los cambios realizados en este archivo podrían generar un comportamiento incorrecto y se perderán si
se vuelve a generar el código.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BookStore_DW"
:setvar DefaultFilePrefix "BookStore_DW"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detectar el modo SQLCMD y deshabilitar la ejecución del script si no se admite el modo SQLCMD.
Para volver a habilitar el script después de habilitar el modo SQLCMD, ejecute lo siguiente:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'El modo SQLCMD debe estar habilitado para ejecutar correctamente este script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'Creando Esquema [staging]...';


GO
CREATE SCHEMA [staging]
    AUTHORIZATION [dbo];


GO
PRINT N'Creando Tabla [staging].[customer]...';


GO
CREATE TABLE [staging].[customer] (
    [CustomerSK]     INT           NOT NULL,
    [first_name]     VARCHAR (200) NULL,
    [last_name]      VARCHAR (200) NULL,
    [email]          VARCHAR (350) NULL,
    [street_name]    VARCHAR (200) NULL,
    [street_number]  VARCHAR (10)  NULL,
    [city]           VARCHAR (100) NULL,
    [address_status] VARCHAR (30)  NULL,
    [country_id]     INT           NULL
) ON [PRIMARY];


GO
PRINT N'Creando Tabla [staging].[address]...';


GO
CREATE TABLE [staging].[address] (
    [AddressSK]     INT           NOT NULL,
    [street_name]   VARCHAR (200) NULL,
    [street_number] VARCHAR (10)  NULL,
    [city]          VARCHAR (100) NULL,
    [country_name]  VARCHAR (200) NULL
) ON [PRIMARY];


GO
PRINT N'Creando Tabla [staging].[book]...';


GO
CREATE TABLE [staging].[book] (
    [BookSK]           INT           NOT NULL,
    [title]            VARCHAR (400) NULL,
    [isbn13]           VARCHAR (13)  NULL,
    [language_code]    VARCHAR (8)   NULL,
    [language_name]    VARCHAR (50)  NULL,
    [num_pages]        INT           NULL,
    [publication_date] DATE          NULL,
    [publisher_name]   VARCHAR (400) NULL,
    [author_name]      VARCHAR (400) NULL
);


GO
PRINT N'Creando Tabla [staging].[shippingMethod]...';


GO
CREATE TABLE [staging].[shippingMethod] (
    [MethodSK]    INT            NOT NULL,
    [method_name] VARCHAR (100)  NULL,
    [cost]        DECIMAL (6, 2) NULL
);


GO
PRINT N'Creando Tabla [staging].[orders]...';


GO
CREATE TABLE [staging].[orders] (
    [order_id]       INT            NOT NULL,
    [AddressSK]      INT            NULL,
    [BookSK]         INT            NULL,
    [CustomerSK]     INT            NULL,
    [MethodSK]       INT            NULL,
    [Order_dateKey]  INT            NOT NULL,
    [Status_dateKey] INT            NOT NULL,
    [order_date]     DATETIME       NULL,
    [status_date]    DATETIME       NULL,
    [status_value]   VARCHAR (20)   NULL,
    [quantity]       INT            NOT NULL,
    [price]          DECIMAL (5, 2) NOT NULL
);


GO
PRINT N'Creando Tabla [dbo].[DimAddress]...';


GO
CREATE TABLE [dbo].[DimAddress] (
    [AddressSK]     INT           IDENTITY (1, 1) NOT NULL,
    [address_id]    INT           NOT NULL,
    [street_name]   VARCHAR (200) NULL,
    [street_number] VARCHAR (10)  NULL,
    [city]          VARCHAR (100) NULL,
    [country_name]  VARCHAR (200) NULL,
    PRIMARY KEY CLUSTERED ([AddressSK] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[DimBook]...';


GO
CREATE TABLE [dbo].[DimBook] (
    [BookSK]           INT           IDENTITY (1, 1) NOT NULL,
    [book_id]          INT           NOT NULL,
    [title]            VARCHAR (400) NULL,
    [isbn13]           VARCHAR (13)  NULL,
    [language_code]    VARCHAR (8)   NULL,
    [language_name]    VARCHAR (50)  NULL,
    [num_pages]        INT           NULL,
    [publication_date] DATE          NULL,
    [publisher_name]   VARCHAR (400) NULL,
    [author_name]      VARCHAR (400) NULL,
    PRIMARY KEY CLUSTERED ([BookSK] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[DimCustomer]...';


GO
CREATE TABLE [dbo].[DimCustomer] (
    [CustomerSK]     INT           IDENTITY (1, 1) NOT NULL,
    [customer_id]    INT           NOT NULL,
    [first_name]     VARCHAR (200) NULL,
    [last_name]      VARCHAR (200) NULL,
    [email]          VARCHAR (350) NULL,
    [street_name]    VARCHAR (200) NULL,
    [street_number]  VARCHAR (10)  NULL,
    [city]           VARCHAR (100) NULL,
    [address_status] VARCHAR (30)  NULL,
    [country_id]     INT           NULL,
    PRIMARY KEY CLUSTERED ([CustomerSK] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[DimDate]...';


GO
CREATE TABLE [dbo].[DimDate] (
    [DateSK]            INT           IDENTITY (1, 1) NOT NULL,
    [FullDate]          DATE          NOT NULL,
    [DayNumberOfWeek]   TINYINT       NOT NULL,
    [DayNameOfWeek]     NVARCHAR (10) NOT NULL,
    [DayNumberOfMonth]  TINYINT       NOT NULL,
    [DayNumberOfYear]   SMALLINT      NOT NULL,
    [WeekNumberOfYear]  TINYINT       NOT NULL,
    [MonthName]         NVARCHAR (10) NOT NULL,
    [MonthNumberOfYear] TINYINT       NOT NULL,
    [CalendarQuarter]   TINYINT       NOT NULL,
    [CalendarYear]      SMALLINT      NOT NULL,
    [CalendarSemester]  TINYINT       NOT NULL,
    PRIMARY KEY CLUSTERED ([DateSK] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[DimShippingMethod]...';


GO
CREATE TABLE [dbo].[DimShippingMethod] (
    [MethodSK]    INT            IDENTITY (1, 1) NOT NULL,
    [method_id]   INT            NOT NULL,
    [method_name] VARCHAR (100)  NULL,
    [cost]        DECIMAL (6, 2) NULL,
    PRIMARY KEY CLUSTERED ([MethodSK] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[FactOrders]...';


GO
CREATE TABLE [dbo].[FactOrders] (
    [order_id]       INT            NOT NULL,
    [AddressSK]      INT            NOT NULL,
    [BookSK]         INT            NOT NULL,
    [CustomerSK]     INT            NOT NULL,
    [MethodSK]       INT            NOT NULL,
    [Order_dateKey]  INT            NOT NULL,
    [Status_dateKey] INT            NOT NULL,
    [order_date]     DATETIME       NULL,
    [status_date]    DATETIME       NULL,
    [status_value]   VARCHAR (20)   NULL,
    [quantity]       INT            NOT NULL,
    [price]          DECIMAL (5, 2) NOT NULL,
    CONSTRAINT [PK_FactOrders] PRIMARY KEY CLUSTERED ([order_id] ASC)
);


GO
PRINT N'Creando Tabla [dbo].[PackageConfig]...';


GO
CREATE TABLE [dbo].[PackageConfig] (
    [PackageID]      INT          IDENTITY (1, 1) NOT NULL,
    [TableName]      VARCHAR (50) NOT NULL,
    [LastRowVersion] BIGINT       NULL,
    CONSTRAINT [PK_PackageConfig] PRIMARY KEY CLUSTERED ([PackageID] ASC)
);


GO
PRINT N'Creando Restricción DEFAULT restricción sin nombre en [staging].[orders]...';


GO
ALTER TABLE [staging].[orders]
    ADD DEFAULT (1) FOR [quantity];


GO
PRINT N'Creando Restricción DEFAULT restricción sin nombre en [dbo].[FactOrders]...';


GO
ALTER TABLE [dbo].[FactOrders]
    ADD DEFAULT (1) FOR [quantity];


GO
PRINT N'Creando Clave externa [dbo].[FK_DimDate_OrderDate]...';


GO
ALTER TABLE [dbo].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_DimDate_OrderDate] FOREIGN KEY ([Order_dateKey]) REFERENCES [dbo].[DimDate] ([DateSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_DimDate_StatusDate]...';


GO
ALTER TABLE [dbo].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_DimDate_StatusDate] FOREIGN KEY ([Status_dateKey]) REFERENCES [dbo].[DimDate] ([DateSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_DimCustomer]...';


GO
ALTER TABLE [dbo].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_DimCustomer] FOREIGN KEY ([CustomerSK]) REFERENCES [dbo].[DimCustomer] ([CustomerSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_DimBook]...';


GO
ALTER TABLE [dbo].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_DimBook] FOREIGN KEY ([BookSK]) REFERENCES [dbo].[DimBook] ([BookSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_DimAddress]...';


GO
ALTER TABLE [dbo].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_DimAddress] FOREIGN KEY ([AddressSK]) REFERENCES [dbo].[DimAddress] ([AddressSK]);


GO
PRINT N'Creando Clave externa [dbo].[FK_DimMethod]...';


GO
ALTER TABLE [dbo].[FactOrders] WITH NOCHECK
    ADD CONSTRAINT [FK_DimMethod] FOREIGN KEY ([MethodSK]) REFERENCES [dbo].[DimShippingMethod] ([MethodSK]);


GO
PRINT N'Creando Procedimiento [dbo].[DW_MergeDimAddress]...';


GO
CREATE PROCEDURE [dbo].[DW_MergeDimAddress]
AS
BEGIN

	UPDATE dc
	SET [street_name]	= sc.[street_name]
	   ,[street_number]	= sc.[street_number]
	   ,[city]			= sc.[city]
	   ,[country_name]	= sc.[country_name]
	   
	FROM [dbo].[DimAddress]        dc
	INNER JOIN [staging].[address] sc ON (dc.[AddressSK]=sc.[AddressSK])
END
GO
PRINT N'Creando Procedimiento [dbo].[DW_MergeDimBook]...';


GO
CREATE PROCEDURE [dbo].[DW_MergeDimBook]
AS
BEGIN

	UPDATE dc
	SET [title]				= sc.[title]
	   ,[isbn13]			= sc.[isbn13]
	   ,[language_code]		= sc.[language_code]
	   ,[language_name]		= sc.[language_name]
	   ,[num_pages]			= sc.[num_pages]
	   ,[publication_date]	= sc.[publication_date]
	   ,[publisher_name]	= sc.[publisher_name]
	   ,[author_name]		= sc.[author_name]
	FROM [dbo].[DimBook]        dc
	INNER JOIN [staging].[book] sc ON (dc.[BookSK]=sc.[BookSK])
END
GO
PRINT N'Creando Procedimiento [dbo].[DW_MergeDimCustomer]...';


GO
CREATE PROCEDURE [dbo].[DW_MergeDimCustomer]
AS
BEGIN

	UPDATE dc
	SET [first_name]	= sc.[first_name]
	   ,[last_name]		= sc.[last_name]
	   ,[email]			= sc.[email]
	   ,[street_name]	= sc.[street_name]
	   ,[street_number]	= sc.[street_number]
	   ,[city]			= sc.[city]
	   ,[address_status]= sc.[address_status]
	   ,[country_id]	= sc.[country_id]
	FROM [dbo].[DimCustomer]        dc
	INNER JOIN [staging].[customer] sc ON (dc.[CustomerSK]=sc.[CustomerSK])
END
GO
PRINT N'Creando Procedimiento [dbo].[DW_MergeDimShippingMethod]...';


GO
CREATE PROCEDURE [dbo].[DW_MergeDimShippingMethod]
AS
BEGIN

	UPDATE dc
	SET [method_name]	= sc.[method_name]
	   ,[cost]			= sc.[cost]

	FROM [dbo].[DimShippingMethod]        dc
	INNER JOIN [staging].[shippingMethod] sc ON (dc.[MethodSK]=sc.[MethodSK])
END
GO
PRINT N'Creando Procedimiento [dbo].[GetLastPackageRowVersion]...';


GO
CREATE PROCEDURE [dbo].[GetLastPackageRowVersion]
(
	@tableName VARCHAR(50)
)
  AS
  BEGIN
	SELECT LastRowVersion
	FROM [dbo].[PackageConfig]
	WHERE TableName = @tableName;
  END
GO
PRINT N'Creando Procedimiento [dbo].[UpdateLastPackageRowVersion]...';


GO
CREATE PROCEDURE [dbo].[UpdateLastPackageRowVersion]
  (
	@tableName VARCHAR(50)
	,@lastRowVersion BIGINT
  )
  AS
  BEGIN
	UPDATE [dbo].[PackageConfig]
	SET LastRowVersion = @lastRowVersion
	WHERE TableName = @tableName;
  END
GO
/*
Plantilla de script posterior a la implementación							
--------------------------------------------------------------------------------------
 Este archivo contiene instrucciones de SQL que se anexarán al script de compilación.		
 Use la sintaxis de SQLCMD para incluir un archivo en el script posterior a la implementación.			
 Ejemplo:      :r .\miArchivo.sql								
 Use la sintaxis de SQLCMD para hacer referencia a una variable en el script posterior a la implementación.		
 Ejemplo:      :setvar TableName miTabla							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/
IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
			  WHERE [TableName] = 'Address')
 BEGIN
	INSERT [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES ('Address', 0)
 END
GO
IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
			  WHERE [TableName] = 'Book')
 BEGIN
	INSERT [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES ('Book', 0)
 END
GO
IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
			  WHERE [TableName] = 'Customer')
 BEGIN
  INSERT [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES ('Customer', 0)
 END
GO
IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
			  WHERE [TableName] = 'ShippingMethod')
 BEGIN
	INSERT [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES ('ShippingMethod', 0)
 END
GO
IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[PackageConfig]
			  WHERE [TableName] = 'Orders')
 BEGIN
	INSERT [dbo].[PackageConfig] ([TableName], [LastRowVersion]) VALUES ('Orders', 0)
 END
GO

IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[DimDate])
 BEGIN
	BEGIN TRAN 
		DECLARE @startdate DATE = '2020-01-01',
				@enddate   DATE = '2024-01-01';
		DECLARE @datelist TABLE(FullDate DATE);

	IF @startdate IS NULL
		BEGIN
			SELECT TOP 1 
				   @startdate = FullDate
			FROM dbo.DimDate 
			ORDER By DateKey ASC;
		END

	WHILE (@startdate <= @enddate)
	BEGIN 
		INSERT INTO @datelist(FullDate)
		SELECT @startdate

		SET @startdate = DATEADD(dd,1,@startdate);
	END

	 INSERT INTO dbo.DimDate(DateKey
							,FullDate 
							,DayNumberOfWeek 
							,DayNameOfWeek 
							,DayNumberOfMonth 
							,DayNumberOfYear 
							,WeekNumberOfYear 
							,[MonthName] 
							,MonthNumberOfYear 
							,CalendarQuarter 
							,CalendarYear 
							,CalendarSemester)

	SELECT DateKey           = CONVERT(INT,CONVERT(VARCHAR,dl.FullDate,112))
		  ,FullDate          = dl.FullDate
		  ,DayNumberOfWeek   = DATEPART(dw,dl.FullDate)
		  ,DayNameOfWeek     = DATENAME(WEEKDAY,dl.FullDate) 
		  ,DayNumberOfMonth  = DATEPART(d,dl.FullDate)
		  ,DayNumberOfYear   = DATEPART(dy,dl.FullDate)
		  ,WeekNumberOfYear  = DATEPART(wk, dl.FUllDate)
		  ,[MonthName]       = DATENAME(MONTH,dl.FullDate) 
		  ,MonthNumberOfYear = MONTH(dl.FullDate)
		  ,CalendarQuarter   = DATEPART(qq, dl.FullDate)
		  ,CalendarYear      = YEAR(dl.FullDate)
		  ,CalendarSemester  = CASE DATEPART(qq, dl.FullDate)
										WHEN 1 THEN 1
										WHEN 2 THEN 1
										WHEN 3 THEN 2
										WHEN 4 THEN 2
								  END
		FROM @datelist              dl 
		LEFT OUTER JOIN dbo.DimDate dd ON (dl.FullDate = dd.FullDate)
		WHERE dd.FullDate IS NULL;
	COMMIT TRAN
END
GO
IF NOT EXISTS(SELECT TOP(1) 1
              FROM [dbo].[DimDate]
			  WHERE [DateKey] = 0)
BEGIN

    INSERT INTO [dbo].[DimDate]
               ([DateKey]
               ,[FullDate]
               ,[DayNumberOfWeek]
               ,[DayNameOfWeek]
               ,[DayNumberOfMonth]
               ,[DayNumberOfYear]
               ,[WeekNumberOfYear]
               ,[MonthName]
               ,[MonthNumberOfYear]
               ,[CalendarQuarter]
               ,[CalendarYear]
               ,[CalendarSemester])
         VALUES
               (0
               ,GETDATE()
               ,0
               ,''
               ,0
               ,0
               ,1
               ,''
               ,0
               ,0
               ,0
               ,0);
END
GO

GO
PRINT N'Comprobando los datos existentes con las restricciones recién creadas';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [dbo].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_DimDate_OrderDate];

ALTER TABLE [dbo].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_DimDate_StatusDate];

ALTER TABLE [dbo].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_DimCustomer];

ALTER TABLE [dbo].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_DimBook];

ALTER TABLE [dbo].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_DimAddress];

ALTER TABLE [dbo].[FactOrders] WITH CHECK CHECK CONSTRAINT [FK_DimMethod];


GO
PRINT N'Actualización completada.';


GO
