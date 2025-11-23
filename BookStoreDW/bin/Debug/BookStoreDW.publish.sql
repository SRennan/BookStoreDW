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
PRINT N'Creando Tabla [dbo].[DimAddress]...';


GO
CREATE TABLE [dbo].[DimAddress] (
    [AddressSK]     INT           IDENTITY (1, 1) NOT NULL,
    [address_id]    INT           NOT NULL,
    [street_number] VARCHAR (10)  NULL,
    [street_name]   VARCHAR (200) NULL,
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
    [CustomerSK]  INT           IDENTITY (1, 1) NOT NULL,
    [customer_id] INT           NOT NULL,
    [first_name]  VARCHAR (200) NULL,
    [last_name]   VARCHAR (200) NULL,
    [email]       VARCHAR (350) NULL,
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
    [line_id]          INT            NOT NULL,
    [order_id]         INT            NOT NULL,
    [Order_dateKey]    INT            NOT NULL,
    [Status_dateKey]   INT            NOT NULL,
    [CustomerSK]       INT            NOT NULL,
    [BookSK]           INT            NOT NULL,
    [AddressSK]        INT            NOT NULL,
    [MethodSK]         INT            NOT NULL,
    [order_status_key] INT            NOT NULL,
    [status_value]     VARCHAR (20)   NULL,
    [order_date]       DATETIME       NULL,
    [status_date]      DATETIME       NULL,
    [price]            DECIMAL (5, 2) NULL,
    CONSTRAINT [PK_FactOrders] PRIMARY KEY CLUSTERED ([line_id] ASC, [order_id] ASC)
);


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
