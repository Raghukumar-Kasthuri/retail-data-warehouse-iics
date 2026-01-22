/* =====================================================
   DIMENSION TABLE DDLs
   Schema: dw
   Includes SCD Type 1 & Type 2 dimensions
   ===================================================== */


USE [IICS]
GO

/****** Object:  Table [dw].[DIM_DATE]    Script Date: 22-01-2026 20:34:53 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dw].[DIM_DATE](
	[date_key] [int] NOT NULL,
	[full_date] [date] NOT NULL,
	[yr] [int] NULL,
	[mon] [int] NULL,
	[day] [int] NULL,
	[day_of_week] [varchar](10) NULL,
	[is_weekend] [char](1) NULL,
	[insert_dt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[date_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dw].[DIM_DATE] ADD  DEFAULT (getdate()) FOR [insert_dt]
GO



USE [IICS]
GO

/****** Object:  Table [dw].[dim_customer]    Script Date: 22-01-2026 20:35:04 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dw].[dim_customer](
	[customer_key] [int] IDENTITY(1,1) NOT NULL,
	[customer_id] [int] NOT NULL,
	[first_name] [varchar](100) NULL,
	[last_name] [varchar](100) NULL,
	[email] [varchar](255) NULL,
	[phone] [varchar](50) NULL,
	[city] [varchar](100) NULL,
	[state] [varchar](50) NULL,
	[postal_code] [varchar](20) NULL,
	[start_dt] [datetime2](0) NOT NULL,
	[end_dt] [datetime2](0) NOT NULL,
	[current_flag] [bit] NOT NULL,
	[insert_dt] [datetime2](0) NOT NULL,
	[update_dt] [datetime2](0) NULL,
PRIMARY KEY CLUSTERED 
(
	[customer_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



USE [IICS]
GO

/****** Object:  Table [dw].[dim_product]    Script Date: 22-01-2026 20:35:14 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dw].[dim_product](
	[product_key] [int] IDENTITY(1,1) NOT NULL,
	[product_id] [varchar](50) NOT NULL,
	[product_name] [varchar](255) NOT NULL,
	[category] [varchar](100) NULL,
	[brand] [varchar](100) NULL,
	[unit_price] [decimal](10, 2) NULL,
	[insert_dt] [datetime2](3) NOT NULL,
	[update_dt] [datetime2](3) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[product_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO



USE [IICS]
GO

/****** Object:  Table [dw].[dim_store]    Script Date: 22-01-2026 20:35:22 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dw].[dim_store](
	[store_key] [int] IDENTITY(1,1) NOT NULL,
	[store_id] [int] NULL,
	[store_name] [varchar](255) NULL,
	[city] [varchar](100) NULL,
	[state] [varchar](50) NULL,
	[insert_dt] [datetime2](3) NOT NULL,
	[update_dt] [datetime2](7) NULL,
PRIMARY KEY CLUSTERED 
(
	[store_key] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dw].[dim_store] ADD  DEFAULT (sysutcdatetime()) FOR [insert_dt]
GO



