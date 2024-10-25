SELECT * FROM world_bank_debt_data.international_debt;

use world_bank_debt_data;

select * from international_debt;

select count(*) from international_debt;


-- Q1.overveiw of the data 
SELECT  * FROM international_debt limit 10;



-- Q2.number of distinct countries in the dataset

select count(distinct(country_name)) as 'count' from international_debt;




-- Q3. Distinct Debt Indicators

SELECT DISTINCT indicator_code AS debt_indicators
FROM international_debt
ORDER BY debt_indicators;



-- Q4.Totaling the Amount of Debt Owed by the Countries

SELECT SUM(debt) as total_debt_USD
FROM international_debt;




-- Q5.Country with the Highest Debt
select country_name,round(SUM(debt/1000000000),2) as 'total_debt_billion_USD' from international_debt group by country_name order by sum(debt) desc limit 1 ;






-- Q6. Average Amount of Debt Across Indicators

SELECT 
    indicator_code, 
    indicator_name, 
    ROUND(AVG(debt) / 1000000000, 2) AS avg_debt_Billion_USD
FROM 
    international_debt
GROUP BY 
    indicator_code, 
    indicator_name
ORDER BY 
    avg_debt_Billion_USD DESC;
    
    
-- Q7.Highest Amount of Principal Repayments

SELECT country_name, ROUND(debt / 1000000000, 2) AS principal_repayment_debt_Billion_USD
FROM international_debt
WHERE indicator_code = 'DT.AMT.DLXF.CD'
ORDER BY debt DESC
LIMIT 5;


-- Q8.Most Common Debt Indicator
SELECT indicator_code, COUNT(*) AS country_count
FROM international_debt
GROUP BY indicator_code
HAVING COUNT(*) = (
    SELECT COUNT(*)
    FROM international_debt
    GROUP BY indicator_code
    ORDER BY COUNT(*) DESC
    LIMIT 1
)
ORDER BY country_count DESC;


-- Q9.Other Viable Debt Issues
SELECT i.country_name, 
       i.indicator_code, 
       ROUND(i.debt / 1000000000, 2) AS debt_Billion_USD
FROM international_debt i
INNER JOIN (
    SELECT country_name, MAX(debt) AS max_debt
    FROM international_debt
    GROUP BY country_name
) AS max_debt_country
ON i.country_name = max_debt_country.country_name
AND max_debt_country.max_debt = i.debt
ORDER BY debt_Billion_USD DESC;





-- CONCLUSIONS FROM ABOVE DATA ANALYSIS

-- 1.An interesting observation in the above finding is that there is a huge difference in the amounts of the indicators after the second one. This indicates that the first two indicators might be the most severe categories in which the countries owe their debts
-- 2.China has the highest amount of debt in the long-term debt (DT.AMT.DLXF.CD) category. This is verified by The World Bank.
-- 3.We can see that the indicator DT.AMT.DLXF.CD tops the chart of average debt. This category includes repayment of long term debts. Countries take on long-term debt to acquire immediate capital

    



