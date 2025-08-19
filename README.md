# Retail Analytics & Churn Prediction — End-to-End Project

**Stack:** SQL, Excel, Tableau, Python/Scikit-Learn (ML)

## Quick Start
1. Load `sql/schema.sql` in your DB, then bulk load the CSVs in `data/`.
2. Run `sql/kpis_and_extracts.sql` to compute KPIs.
3. Open `excel/Executive_Dashboard.xlsx` for a quick summary.
4. Open `notebooks/retail_churn_ml.ipynb`, run all to train models and create `data/customer_scored.csv`.
5. In Tableau, connect to `data/orders_daily.csv` and `data/customer_scored.csv` and build dashboards (spec in this README).

## Suggested Tableau Dashboards
- Executive Overview (GMV & Orders trend, YoY; filters by region/channel/segment)
- Customer Health (churn probability distribution; heatmap by segment × region; top high-risk customers)
- Category Drilldown (category → subcategory → SKU tree; units vs GMV)

Data is synthetic and safe for portfolio use.