/* =====================================================
   FACT TABLE DDLs
   Schema: fact
   Grain defined in README.md
   ===================================================== */
USE [IICS]
GO

/****** Object:  Table [fact].[fact_orders]    Script Date: 22-01-2026 20:36:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [fact].[fact_orders](
	[order_key] [bigint] IDENTITY(1,1) NOT NULL,
	[order_id] [varchar](50) NOT NULL,
	[order_date_key] [int] NOT NULL,
	[customer_key] [int] NOT NULL,
	[store_key] [int] NOT NULL,
	[total_amount] [decimal](12, 2) NOT NULL,
	[payment_method] [varchar](50) NULL,
	[insert_dt] [datetime2](3) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[order_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [fact].[fact_orders] ADD  DEFAULT (sysutcdatetime()) FOR [insert_dt]
GO




USE [IICS]
GO

/****** Object:  Table [fact].[fact_order_items]    Script Date: 22-01-2026 20:36:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [fact].[fact_order_items](
	[fact_id] [bigint] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NOT NULL,
	[order_item_id] [int] NULL,
	[order_date_key] [int] NULL,
	[customer_key] [int] NULL,
	[product_key] [int] NULL,
	[store_key] [int] NULL,
	[quantity] [int] NULL,
	[unit_price] [decimal](12, 2) NULL,
	[line_total] [decimal](14, 2) NULL,
	[insert_dt] [datetime2](3) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[fact_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [fact].[fact_order_items] ADD  DEFAULT (sysutcdatetime()) FOR [insert_dt]
GO



