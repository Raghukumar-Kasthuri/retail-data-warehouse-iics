/* =====================================================
   STAGING TABLE DDLs
   Schema: stg
   Source: CSV files via IICS
   ===================================================== */


USE [IICS]
GO

/****** Object:  Table [stg].[stg_customers]    Script Date: 22-01-2026 20:32:21 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[stg_customers](
	[customer_id] [int] NULL,
	[first_name] [varchar](100) NULL,
	[last_name] [varchar](100) NULL,
	[email] [varchar](255) NULL,
	[phone] [varchar](50) NULL,
	[city] [varchar](100) NULL,
	[state] [varchar](50) NULL,
	[postal_code] [varchar](20) NULL,
	[file_name] [varchar](255) NULL,
	[file_row_number] [int] NULL,
	[batch_id] [varchar](50) NULL,
	[insert_dt] [datetime2](3) NOT NULL,
	[update_dt] [datetime2](3) NULL,
	[load_user] [varchar](128) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [stg].[stg_customers] ADD  DEFAULT (sysutcdatetime()) FOR [insert_dt]
GO

ALTER TABLE [stg].[stg_customers] ADD  DEFAULT (suser_sname()) FOR [load_user]
GO


USE [IICS]
GO

/****** Object:  Table [stg].[stg_products]    Script Date: 22-01-2026 20:32:29 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[stg_products](
	[product_id] [varchar](50) NULL,
	[product_name] [varchar](255) NULL,
	[category] [varchar](100) NULL,
	[brand] [varchar](100) NULL,
	[unit_price] [decimal](12, 2) NULL,
	[file_name] [varchar](255) NULL,
	[file_row_number] [int] NULL,
	[batch_id] [varchar](50) NULL,
	[insert_dt] [datetime2](3) NOT NULL,
	[update_dt] [datetime2](3) NULL,
	[load_user] [varchar](128) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [stg].[stg_products] ADD  DEFAULT (sysutcdatetime()) FOR [insert_dt]
GO

ALTER TABLE [stg].[stg_products] ADD  DEFAULT (suser_sname()) FOR [load_user]
GO



USE [IICS]
GO

/****** Object:  Table [stg].[stg_stores]    Script Date: 22-01-2026 20:32:40 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[stg_stores](
	[store_id] [int] NULL,
	[store_name] [varchar](255) NULL,
	[city] [varchar](100) NULL,
	[state] [varchar](50) NULL,
	[file_name] [varchar](255) NULL,
	[file_row_number] [int] NULL,
	[batch_id] [varchar](50) NULL,
	[insert_dt] [datetime2](3) NOT NULL,
	[update_dt] [datetime2](3) NULL,
	[load_user] [varchar](128) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [stg].[stg_stores] ADD  DEFAULT (sysutcdatetime()) FOR [insert_dt]
GO

ALTER TABLE [stg].[stg_stores] ADD  DEFAULT (suser_sname()) FOR [load_user]
GO



USE [IICS]
GO

/****** Object:  Table [stg].[stg_orders]    Script Date: 22-01-2026 20:32:52 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[stg_orders](
	[order_id] [int] NULL,
	[order_date] [date] NULL,
	[customer_id] [int] NULL,
	[store_id] [int] NULL,
	[total_amount] [decimal](14, 2) NULL,
	[payment_method] [varchar](50) NULL,
	[file_name] [varchar](255) NULL,
	[file_row_number] [int] NULL,
	[batch_id] [varchar](50) NULL,
	[insert_dt] [datetime2](3) NOT NULL,
	[update_dt] [datetime2](3) NULL,
	[load_user] [varchar](128) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [stg].[stg_orders] ADD  DEFAULT (sysutcdatetime()) FOR [insert_dt]
GO

ALTER TABLE [stg].[stg_orders] ADD  DEFAULT (suser_sname()) FOR [load_user]
GO



USE [IICS]
GO

/****** Object:  Table [stg].[stg_order_items]    Script Date: 22-01-2026 20:34:13 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [stg].[stg_order_items](
	[order_item_id] [int] NULL,
	[order_id] [int] NULL,
	[product_id] [varchar](50) NULL,
	[quantity] [int] NULL,
	[line_total] [decimal](14, 2) NULL,
	[file_name] [varchar](255) NULL,
	[file_row_number] [int] NULL,
	[batch_id] [varchar](50) NULL,
	[insert_dt] [datetime2](3) NOT NULL,
	[update_dt] [datetime2](3) NULL,
	[load_user] [varchar](128) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [stg].[stg_order_items] ADD  DEFAULT (sysutcdatetime()) FOR [insert_dt]
GO

ALTER TABLE [stg].[stg_order_items] ADD  DEFAULT (suser_sname()) FOR [load_user]
GO




