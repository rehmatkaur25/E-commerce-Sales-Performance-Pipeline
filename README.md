# E-commerce Sales Performance Pipeline

An end-to-end business analyst project that takes raw e-commerce transaction data through cleaning, database modeling, and analysis, then into stakeholder-facing dashboards — built to mirror a real BA workflow from messy source data to decision-ready reporting.

## Project Overview

This project simulates a business analyst engagement for an e-commerce company. Starting from raw customer, order, and product data, the pipeline delivers:

- Cleaned, analysis-ready datasets
- A relational database with documented schema and analytical queries
- A stakeholder-facing Excel dashboard
- A Power BI dashboard with KPI cards and interactive visuals

The goal was to practice the full BA toolkit — Python, SQL, Excel, and Power BI — on a single connected dataset rather than in isolation.

## Pipeline

```
Raw CSVs → Python (cleaning, EDA, RFM, cohort analysis) → MySQL (schema + queries) → Excel Dashboard → Power BI Dashboard
```

## Tech Stack

| Stage | Tools |
|---|---|
| Data cleaning & analysis | Python (pandas), Jupyter Notebook |
| Database | MySQL |
| Reporting | Microsoft Excel (PivotTables & PivotCharts) |
| Business Intelligence | Power BI |
| Documentation | BRD (Business Requirements Document) |

## Repository Structure

```
├── data/
│   ├── raw/                        # Original, unprocessed source files
│   │   ├── customers_raw.csv
│   │   ├── orders_raw.csv
│   │   ├── order_items_raw.csv
│   │   └── products_raw.csv
│   └── clean/                      # Cleaned, analysis-ready files
│       ├── customers_clean.csv
│       ├── orders_clean.csv
│       ├── order_items_clean.csv
│       ├── products_clean.csv
│       └── rfm_segments.csv
├── notebooks/
│   └── project2_ecommerce_cleaning_eda.ipynb   # Data cleaning, EDA, RFM, cohort analysis
├── sql/
│   └── schema.sql                  # Database schema + analysis queries
├── excel/
│   └── E-Commerce_Excel_Dashboard.xlsx
├── powerbi/
│   └── E-Commerce_PowerBI_Dashboard.pbix
├── docs/
│   └── BRD_E-commerce_Sales_Pipeline.pdf
└── README.md
```

## 1. Data Cleaning & Exploratory Analysis (Python)

Performed in Jupyter Notebook on the raw customer, order, order-item, and product data:

- Missing value handling, type correction, and deduplication
- Exploratory data analysis on sales trends, order status, and category performance
- **RFM segmentation** (Recency, Frequency, Monetary) to group customers by value
- **Cohort analysis** to examine customer retention over time

## 2. Database (MySQL)

Cleaned data was loaded into a MySQL database (`ecommerce_project`) with a defined schema (`schema.sql`) covering customers, orders, order items, and products, plus five analysis queries supporting the reporting layer.

## 3. Excel Dashboard

A stakeholder-facing summary dashboard built with PivotTables and PivotCharts:

- 3 KPI stat cards
- 4 charts: Revenue by Category, Customer Segments (RFM), Top 10 Customers by Spend, Monthly Revenue Trend
- Clean 2x2 layout with stakeholder-readable titles and no pivot-editing clutter

## 4. Power BI Dashboard

*(In progress)*

- 4 color-coded KPI cards: Total Revenue, Total Orders, Delivered Rate, Total Customers
- 4 chart tiles matching the Excel dashboard, with soft-tint backgrounds
- Connected live to the MySQL database

## Key Insights

*(Add 2-4 bullet points here once the dashboards are finalized — e.g. top-performing category, highest-value customer segment, month-over-month revenue trend, delivery rate.)*

## Business Requirements

See [`docs/BRD_E-commerce_Sales_Pipeline.pdf`](docs/BRD_E-commerce_Sales_Pipeline.pdf) for the full business requirements document driving this project's scope.

## Project Management

Task tracking and sprint planning for this project were managed in Jira, following the BRD's scope through each pipeline stage (data cleaning → SQL → Excel → Power BI).

- [`docs/jira_1.jpeg`](docs/jira_1.jpeg)
- [`docs/jira_2.jpeg`](docs/jira_2.jpeg)
- [`docs/jira_3.jpeg`](docs/jira_3.jpeg)

## Author

*(Your name / LinkedIn / portfolio link here)*
