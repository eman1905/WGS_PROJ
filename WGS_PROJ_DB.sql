/*    ==Scripting Parameters==

    Source Server Version : SQL Server 2012 (11.0.2100)
    Source Database Engine Edition : Microsoft SQL Server Express Edition
    Source Database Engine Type : Standalone SQL Server

    Target Server Version : SQL Server 2017
    Target Database Engine Edition : Microsoft SQL Server Standard Edition
    Target Database Engine Type : Standalone SQL Server
*/
USE [master]
GO
/****** Object:  Database [WGS_PROJ]    Script Date: 2/3/2021 4:25:00 PM ******/
CREATE DATABASE [WGS_PROJ]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'WGS_PROJ', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\WGS_PROJ.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'WGS_PROJ_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.SQLEXPRESS\MSSQL\DATA\WGS_PROJ_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [WGS_PROJ] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [WGS_PROJ].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [WGS_PROJ] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [WGS_PROJ] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [WGS_PROJ] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [WGS_PROJ] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [WGS_PROJ] SET ARITHABORT OFF 
GO
ALTER DATABASE [WGS_PROJ] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [WGS_PROJ] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [WGS_PROJ] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [WGS_PROJ] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [WGS_PROJ] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [WGS_PROJ] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [WGS_PROJ] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [WGS_PROJ] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [WGS_PROJ] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [WGS_PROJ] SET  DISABLE_BROKER 
GO
ALTER DATABASE [WGS_PROJ] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [WGS_PROJ] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [WGS_PROJ] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [WGS_PROJ] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [WGS_PROJ] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [WGS_PROJ] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [WGS_PROJ] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [WGS_PROJ] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [WGS_PROJ] SET  MULTI_USER 
GO
ALTER DATABASE [WGS_PROJ] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [WGS_PROJ] SET DB_CHAINING OFF 
GO
ALTER DATABASE [WGS_PROJ] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [WGS_PROJ] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [WGS_PROJ]
GO
/****** Object:  Table [dbo].[msCourier]    Script Date: 2/3/2021 4:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msCourier](
	[courier_id] [int] IDENTITY(1,1) NOT NULL,
	[courier_name] [nvarchar](100) NULL,
	[courier_fee] [decimal](18, 2) NULL,
 CONSTRAINT [PK_msCourier] PRIMARY KEY CLUSTERED 
(
	[courier_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[msProduct]    Script Date: 2/3/2021 4:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msProduct](
	[product_id] [int] IDENTITY(1,1) NOT NULL,
	[product_desc] [nvarchar](1000) NULL,
	[product_price] [decimal](18, 2) NULL,
	[product_weight] [decimal](18, 2) NULL,
 CONSTRAINT [PK_msProduct] PRIMARY KEY CLUSTERED 
(
	[product_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[msSales]    Script Date: 2/3/2021 4:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[msSales](
	[sales_id] [int] IDENTITY(1,1) NOT NULL,
	[sales_name] [nvarchar](100) NULL,
 CONSTRAINT [PK_msSales] PRIMARY KEY CLUSTERED 
(
	[sales_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[trInvoice]    Script Date: 2/3/2021 4:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[trInvoice](
	[invoice_id] [int] IDENTITY(1,1) NOT NULL,
	[sales_id] [int] NULL,
	[courier_id] [int] NULL,
	[invoice_date] [date] NULL,
	[invoice_to] [nvarchar](50) NULL,
	[invoice_ship_to] [nvarchar](max) NULL,
	[payment_type] [nvarchar](50) NULL,
 CONSTRAINT [PK_trInvoice] PRIMARY KEY CLUSTERED 
(
	[invoice_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[trInvoiceDetail]    Script Date: 2/3/2021 4:25:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[trInvoiceDetail](
	[invoice_detail_id] [int] IDENTITY(1,1) NOT NULL,
	[invoice_id] [int] NULL,
	[product_id] [int] NULL,
	[qty] [int] NULL,
	[total_price] [decimal](18, 2) NULL,
	[total_weight] [decimal](18, 2) NULL,
 CONSTRAINT [PK_trInvoiceDetail] PRIMARY KEY CLUSTERED 
(
	[invoice_detail_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[msCourier] ON 

INSERT [dbo].[msCourier] ([courier_id], [courier_name], [courier_fee]) VALUES (1, N'JNT', CAST(9000.00 AS Decimal(18, 2)))
INSERT [dbo].[msCourier] ([courier_id], [courier_name], [courier_fee]) VALUES (2, N'JNE', CAST(10000.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[msCourier] OFF
SET IDENTITY_INSERT [dbo].[msProduct] ON 

INSERT [dbo].[msProduct] ([product_id], [product_desc], [product_price], [product_weight]) VALUES (1, N'Selotip', CAST(5000.00 AS Decimal(18, 2)), CAST(1.00 AS Decimal(18, 2)))
INSERT [dbo].[msProduct] ([product_id], [product_desc], [product_price], [product_weight]) VALUES (2, N'Buku', CAST(25000.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[msProduct] OFF
SET IDENTITY_INSERT [dbo].[msSales] ON 

INSERT [dbo].[msSales] ([sales_id], [sales_name]) VALUES (1, N'Satria')
SET IDENTITY_INSERT [dbo].[msSales] OFF
SET IDENTITY_INSERT [dbo].[trInvoice] ON 

INSERT [dbo].[trInvoice] ([invoice_id], [sales_id], [courier_id], [invoice_date], [invoice_to], [invoice_ship_to], [payment_type]) VALUES (1, 1, 1, CAST(N'2021-02-01' AS Date), N'To edit lagi', N'Ship To edit', N'COD')
SET IDENTITY_INSERT [dbo].[trInvoice] OFF
SET IDENTITY_INSERT [dbo].[trInvoiceDetail] ON 

INSERT [dbo].[trInvoiceDetail] ([invoice_detail_id], [invoice_id], [product_id], [qty], [total_price], [total_weight]) VALUES (5, 1, 1, 2, CAST(10000.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)))
INSERT [dbo].[trInvoiceDetail] ([invoice_detail_id], [invoice_id], [product_id], [qty], [total_price], [total_weight]) VALUES (6, 1, 2, 4, CAST(100000.00 AS Decimal(18, 2)), CAST(8.00 AS Decimal(18, 2)))
INSERT [dbo].[trInvoiceDetail] ([invoice_detail_id], [invoice_id], [product_id], [qty], [total_price], [total_weight]) VALUES (7, 1, 1, 3, CAST(15000.00 AS Decimal(18, 2)), CAST(3.00 AS Decimal(18, 2)))
INSERT [dbo].[trInvoiceDetail] ([invoice_detail_id], [invoice_id], [product_id], [qty], [total_price], [total_weight]) VALUES (8, 1, 2, 1, CAST(25000.00 AS Decimal(18, 2)), CAST(2.00 AS Decimal(18, 2)))
SET IDENTITY_INSERT [dbo].[trInvoiceDetail] OFF
ALTER TABLE [dbo].[trInvoice]  WITH CHECK ADD  CONSTRAINT [FK_trInvoice_msCourier] FOREIGN KEY([courier_id])
REFERENCES [dbo].[msCourier] ([courier_id])
GO
ALTER TABLE [dbo].[trInvoice] CHECK CONSTRAINT [FK_trInvoice_msCourier]
GO
ALTER TABLE [dbo].[trInvoice]  WITH CHECK ADD  CONSTRAINT [FK_trInvoice_msSales] FOREIGN KEY([sales_id])
REFERENCES [dbo].[msSales] ([sales_id])
GO
ALTER TABLE [dbo].[trInvoice] CHECK CONSTRAINT [FK_trInvoice_msSales]
GO
ALTER TABLE [dbo].[trInvoice]  WITH CHECK ADD  CONSTRAINT [FK_trInvoice_trInvoice] FOREIGN KEY([invoice_id])
REFERENCES [dbo].[trInvoice] ([invoice_id])
GO
ALTER TABLE [dbo].[trInvoice] CHECK CONSTRAINT [FK_trInvoice_trInvoice]
GO
ALTER TABLE [dbo].[trInvoiceDetail]  WITH CHECK ADD  CONSTRAINT [FK_trInvoiceDetail_msProduct] FOREIGN KEY([product_id])
REFERENCES [dbo].[msProduct] ([product_id])
GO
ALTER TABLE [dbo].[trInvoiceDetail] CHECK CONSTRAINT [FK_trInvoiceDetail_msProduct]
GO
ALTER TABLE [dbo].[trInvoiceDetail]  WITH CHECK ADD  CONSTRAINT [FK_trInvoiceDetail_trInvoice] FOREIGN KEY([invoice_id])
REFERENCES [dbo].[trInvoice] ([invoice_id])
GO
ALTER TABLE [dbo].[trInvoiceDetail] CHECK CONSTRAINT [FK_trInvoiceDetail_trInvoice]
GO
USE [master]
GO
ALTER DATABASE [WGS_PROJ] SET  READ_WRITE 
GO
