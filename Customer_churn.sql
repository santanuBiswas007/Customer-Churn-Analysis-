CREATE DATABASE customer_churn;
USE customer_churn;
SELECT * FROM customer; 


-- Step 1 — Business Understanding

-- Q1 How many total customers are there?
  SELECT COUNT(*) AS Total_Customer FROM customer;


-- Q2 How many customers churned?
  SELECT 
     COUNT(Exited) AS customer_churn_count
     From customer WHERE Exited = 1;
     
         


-- Q3 How many customers are still active?
     SELECT 
     COUNT(Exited) AS customer_churn_count
     From customer WHERE Exited = 0;


-- Q4 What is the overall churn rate (%)? Formula:
-- Churn Rate =
-- (Number of Churned Customers / Total Customers) * 100

SELECT
COUNT(*) AS total_customers,
SUM(Exited) AS churned_customers,
ROUND(SUM(Exited) * 100.0 / COUNT(*),2) AS churn_rate_percentage
FROM customer;


-- Q5 What is the average credit score of customers?
  SELECT ROUND(AVG(CreditScore),2) AS Avg_Credit_Score
  FROM customer;


-- Q6 What is the average balance?

SELECT ROUND(AVG(Balance),2) AS Avg_Balance
  FROM customer;
  
  
 --  Step 2 — Data Understanding

-- Q7 What are the distinct countries (Geography)?
       SELECT DISTINCT Geography FROM customer;


-- Q8 How many customers are in each country?
      SELECT
      Geography,
      COUNT(*) Customer_count_by_geography FROM customer 
      GROUP BY Geography
      ORDER BY Customer_count_by_geography;


-- Q9 How many male vs female customers?
     SELECT gender,COUNT(*) AS gender_count
     FROM customer
     GROUP BY gender
     ORDER BY gender_count;
     
 

-- Q10 What is the age distribution?

SELECT 
MIN(age) Minimum_age,
MAX(age) Maximum_age,
ROUND(AVG(age),1)Average_age
FROM customer;




-- Q11 How many customers have a credit card?

SELECT COUNT(*) customers_with_creditcard FROM 
customer WHERE HasCrCard = 1;

-- Q12 How many customers are active members? 

SELECT COUNT(*) active_members FROM 
customer WHERE IsActiveMember = 1;


-- Step 3 — Churn Analysis

-- Q13 — Churn by Gender

-- Calculate the total number of customers, total churned customers, and churn rate (%) for each Gender.
    SELECT 
    Gender,
    COUNT(*) AS total_customer_number,
    SUM(Exited) as total_churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*),2) AS churn_rate_percentage  
    FROM customer 
    GROUP BY Gender;
    
-- Q14 — Churn by Geography Find the total customers, churned customers, and churn rate (%) for each Geography (Country).

    SELECT 
    Geography,
    COUNT(*) AS total_customer_number,
    SUM(Exited) as total_churned_customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*),2) AS churn_rate_percentage  
    FROM customer 
    GROUP BY Geography;
-- Q15 — Average Age of Churned Customers Calculate the average age of customers who have churned, considering only records where Exited = 1.

    SELECT 
    ROUND(AVG(age),2 )avg_age
    FROM customer 
    WHERE Exited = 1;
    
-- Q16 — Credit Score Comparison Customer Status (Churned / Active) , Average Credit Score
 

    
SELECT 
    CASE 
        WHEN Exited = 1 THEN 'Churned'
        ELSE 'Active'
    END AS Customer_Status,
    ROUND(AVG(CreditScore),2) AS Avg_Credit_Score
FROM customer
GROUP BY Exited;


-- Q17 — Balance Comparison Compare the average account balance between churned customers and active customers.


   SELECT 
    CASE 
        WHEN Exited = 1 THEN 'Churned'
        ELSE 'Active'
    END AS Customer_Status,
    ROUND(AVG(Balance),2) AS Avg_Balance
FROM customer
GROUP BY Exited;

-- Q18 — Churn by Active Membership Analyze churn based on Active Membership status.


 SELECT 
    IsActiveMember,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND((SUM(Exited) * 100.0) / COUNT(*), 2) AS Churn_Rate_Percentage
FROM customer
GROUP BY IsActiveMember;


-- Q19 — Churn by Number of Products Analyze how churn varies based on the number of products customers use (NumOfProducts).


SELECT 
    NumOfProducts,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND((SUM(Exited) * 100.0) / COUNT(*), 2) AS Churn_Rate_Percentage
FROM customer
GROUP BY NumOfProducts
ORDER BY NumOfProducts;


-- Q20 — Churn by Credit Card Ownership Check if customers without credit cards churn more.


SELECT 
    HasCrCard,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND((SUM(Exited) * 100.0) / COUNT(*), 2) AS Churn_Rate_Percentage
FROM customer
GROUP BY HasCrCard
ORDER BY HasCrCard;


-- Q21 — Age Segmentation and Churn
-- Create age groups:
-- 18–30 → Young
-- 31–50 → Middle Age
-- 50+ → Senior

 SELECT 
  CASE WHEN age BETWEEN 18 AND 30 THEN 'Young'
       WHEN age BETWEEN 31 AND 50 THEN 'Middle Age'
	  ELSE "Senior" END AS Age_Segment,
      COUNT(*) AS total_customers,
      SUM(Exited) as Churned_Customers,
	  ROUND((SUM(Exited) * 100.0) / COUNT(*), 2) AS Churn_Rate_Percentage
      FROM customer 
      GROUP BY Age_Segment;


-- Q22 — Balance Segmentation and Churn
-- Create balance segments:
-- 0 → Zero Balance
-- 1–50,000 → Low Balance
-- 50,001–100,000 → Medium Balance
-- Above 100,000 → High Balance
 SELECT 
  CASE WHEN balance = 0  THEN 'Zero Balance'
       WHEN balance BETWEEN 1 AND 50000 THEN 'Low Balance'
       WHEN balance BETWEEN 50001 AND 100000  THEN 'Medium Balance'
	  ELSE "High Balance" END AS Balance_Segment,
      COUNT(*) AS total_customers,
      SUM(Exited) as Churned_Customers,
	  ROUND((SUM(Exited) * 100.0) / COUNT(*), 2) AS Churn_Rate_Percentage
      FROM customer 
      GROUP BY Balance_Segment;



-- Q23 — Top Customers by Balance
-- Find the top 10 customers with the highest account balance.
-- Display:
-- CustomerId
-- Geography
-- Balance
SELECT 
CustomerId,
Geography,
Balance
FROM customer
ORDER BY Balance DESC
LIMIT 10;

-- Q24 — Top 10 Customers by Salary Find the top 10 highest salary customers.

SELECT 
CustomerId,
Geography,
EstimatedSalary
FROM customer
ORDER BY EstimatedSalary DESC
LIMIT 10;

-- Q25 — Tenure vs Churn
-- Analyze churn by tenure.
-- For each Tenure, calculate:
-- Total Customers
-- Churned Customers
-- Churn Rate %
  SELECT 
  tenure,
  COUNT(*) AS total_customers,
      SUM(Exited) as Churned_Customers,
	  ROUND((SUM(Exited) * 100.0) / COUNT(*), 2) AS Churn_Rate_Percentage
      FROM customer 
      GROUP BY tenure
      ORDER BY tenure;

-- Q26 — High Value Customers at Risk
-- Find customers who:
-- • Balance > 100000
-- • IsActiveMember = 0
-- These are high-value churn risks.
SELECT 
CustomerId,
Geography,
Age,
Balance,
EstimatedSalary
FROM customer
WHERE Balance > 100000 
AND IsActiveMember = 0
ORDER BY Balance DESC;

-- Q27 — Rank Customers by Balance
-- Rank customers based on their Balance using a window function. Return CustomerId, Balance, and Rank.
SELECT 
CustomerId,
Balance,
RANK() OVER( ORDER BY Balance DESC ) AS Balance_Rank
FROM customer  	;

-- Q28 — Top 5% Richest Customers Identify customers who fall in the top 5% based on Balance.

SELECT *
FROM (
        SELECT 
        CustomerId,
        Geography,
        Balance,
        PERCENT_RANK() OVER(ORDER BY Balance DESC) AS balance_rank
        FROM customer
     ) ranked_customers
WHERE balance_rank <= 0.05;

-- Q29 — Customers with High Salary but Low Balance Find customers whose EstimatedSalary > 150000 and Balance < 10000.
-- These customers may earn a lot but keep little money in the bank.
  SELECT * FROM customer
  WHERE  EstimatedSalary > 150000 and Balance < 10000;
  
  
-- Q30 — Customer Risk Segmentation
-- Create risk categories using CASE based on Balance and activity.
-- Return CustomerId, Balance, and Risk_Category (High, Medium, Low).
SELECT 
    CASE 
        WHEN Balance > 100000 AND IsActiveMember = 0 THEN 'High Risk'
        WHEN Balance BETWEEN 50000 AND 100000 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS Risk_Category,
    COUNT(*) AS Total_Customers
FROM customer
GROUP BY Risk_Category
ORDER BY Total_Customers DESC;


-- Q31 — Running Churn Trend
-- Churn by tenure using window functions
SELECT 
    Tenure,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    SUM(SUM(Exited)) OVER (ORDER BY Tenure) AS Running_Churn_Total
FROM customer
GROUP BY Tenure
ORDER BY Tenure;
-- Q32 — Country with Highest Churn Rate
SELECT 
    Geography,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*),2) AS Churn_Rate_Percentage
FROM customer
GROUP BY Geography
ORDER BY Churn_Rate_Percentage DESC;
-- Q33 — Most Loyal Customers
-- Tenure > 8 and Exited = 0
SELECT 
    CustomerId,
    Geography,
    Age,
    Balance,
    Tenure
FROM customer
WHERE Tenure > 8 
AND Exited = 0
ORDER BY Tenure DESC;

-- Q34 — Product Usage vs Churn
SELECT 
    NumOfProducts,
    COUNT(*) AS Total_Customers,
    SUM(Exited) AS Churned_Customers,
    ROUND(SUM(Exited) * 100.0 / COUNT(*),2) AS Churn_Rate_Percentage
FROM customer
GROUP BY NumOfProducts
ORDER BY NumOfProducts;

-- Q35 — Churn Prediction Indicators
-- Customers with:
-- Low tenure
-- High balance
-- Inactive
-- Age > 50
SELECT 
    CustomerId,
    Age,
    Tenure,
    Balance,
    IsActiveMember,
    Geography
FROM customer
WHERE Tenure < 3
AND Balance > 100000
AND IsActiveMember = 0
AND Age > 50;





