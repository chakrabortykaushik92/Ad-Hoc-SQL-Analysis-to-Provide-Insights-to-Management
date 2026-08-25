/*8. In which quarter of 2020, got the maximum total_sold_quantity? The final
output contains these fields sorted by the total_sold_quantity,
Quarter
total_sold_quantity*/

SELECT 
CASE 
    WHEN MONTHNAME(date) in ("September","October","November") THEN "Q1"
    WHEN MONTHNAME(date) in ("December","January","February") THEN "Q2"
    WHEN MONTHNAME(date) in ("March","April","May") THEN "Q3"
    WHEN MONTHNAME(date) in ("June","July","August") THEN "Q4"
END AS quarter, SUM(sold_quantity) AS total_sold_quantity
FROM fact_sales_monthly
WHERE fiscal_year=2020
GROUP BY quarter
ORDER BY total_sold_quantity DESC;
