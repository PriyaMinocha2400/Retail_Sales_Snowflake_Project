# Retail Sales Analytics — Snowflake, SQL, Tableau

**Goal:** Build a portfolio-grade retail analytics stack: ingest Superstore into **Snowflake**, model a **star schema** with **surrogate keys**, validate row counts (10,331 ➜ **9,994**), and deliver a live **Tableau** dashboard (KPIs, MoM trend, Top-10 products, category margins, regional performance, shipping timeliness).

## Architecture
Raw (CSV) ➜ **STAGING.SUPERSTORE_RAW** ➜ **STAGING.SUPERSTORE_CLEAN** ➜
**DIM_CUSTOMER / DIM_PRODUCT / DIM_REGION / DIM_DATE** + **FACT_SALES** ➜ **V_SALES** (semantic view) ➜ Tableau

## What’s inside
- `sql/01_ingest_clean.sql` — load & normalize (trim/case/ZIP fix)
- `sql/02_dims_fact.sql` — build dims (surrogate keys) + load fact
- `sql/03_view_v_sales.sql` — convenience view for BI
- `sql/04_analysis.sql` — KPIs, MoM%, Top-10, heatmap, regions, shipping
- `tableau/` — packaged workbook **or** screenshots in `assets/`

## Key techniques
- **Data modeling:** star schema, surrogate keys, conformed dimensions, date spine  
- **Quality:** dedup & join audits to fix many-to-many (10,331 ➜ **9,994**)  
- **Analytics:** MoM% (`LOOKUP(…, -1)`), Top-N, margin%, shipping ≤3 days  
- **Security:** read-only role/user (least privilege) for BI

## Reproduce (Snowflake)
1. Create DB/Schema and set context (see `sql/00_setup.sql`).
2. Run `sql/01_ingest_clean.sql` ➜ creates `SUPERSTORE_CLEAN`.
3. Run `sql/02_dims_fact.sql` ➜ creates `DIM_*` + loads `FACT_SALES`.
4. Run `sql/03_view_v_sales.sql` ➜ creates `V_SALES`.
5. (Optional) Run `sql/04_analysis.sql` to verify metrics.

## Connect Tableau
- Connect to Snowflake ➜ select `RETAIL_SALES.STAGING.V_SALES` (Live).
- Calculated fields: **Margin%**, **MoM%**, **Discount Band**, **Delivered ≤3d**.
- Filters (apply to all): **Year**, **Region**, **Segment**, **Category**.

## Insights (examples)
- Discount bands >20% correlate with margin erosion.
- Top profit comes from [subcategories]; [states/regions] lead in revenue.
- Avg delivery **days** and **% ≤3 days** highlight shipping performance.

## Dataset
Superstore sample dataset (public). Not included here; use your own copy.

---
*Tech: Snowflake, SQL, Tableau, ELT, window functions, RBAC, data modeling.*
