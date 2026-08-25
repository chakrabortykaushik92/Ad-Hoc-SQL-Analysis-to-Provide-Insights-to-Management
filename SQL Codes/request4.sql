/*4. Follow-up: Which segment had the most increase in unique products in
2021 vs 2020? The final output contains these fields,
segment
product_count_2020
product_count_2021
difference*/

WITH cte AS (SELECT 
        fiscal_year,
        segment,
        COUNT(DISTINCT p.product_code) AS product_count
    FROM fact_sales_monthly s
    JOIN dim_product p
        ON s.product_code = p.product_code
    WHERE fiscal_year IN (2020, 2021)
    GROUP BY fiscal_year, segment)
SELECT
    segment,
    MAX(CASE WHEN fiscal_year = 2020 THEN product_count END) AS product_count_2020,
    MAX(CASE WHEN fiscal_year = 2021 THEN product_count END) AS product_count_2021,
    MAX(CASE WHEN fiscal_year = 2021 THEN product_count END)
      - MAX(CASE WHEN fiscal_year = 2020 THEN product_count END) AS difference
FROM cte
GROUP BY segment
ORDER BY difference DESC
