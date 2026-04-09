-- BUSINESS QUESTION 1: Does a higher price tag guarantee a better user rating?
-- Goal: Analyze if expensive books have better satisfaction scores.
SELECT 
    CASE 
        WHEN Price = 0 THEN 'Free'
        WHEN Price <= 10 THEN '$1 - $10'
        WHEN Price <= 20 THEN '$11 - $20'
        ELSE 'Over $20'
    END AS Price_Range,
    COUNT(*) AS Total_Books,
    ROUND(AVG(`User Rating`), 2) AS Avg_Rating,
    SUM(Reviews) AS Total_Reviews
FROM amazon_bestsellers
GROUP BY Price_Range
ORDER BY Avg_Rating DESC;

-- BUSINESS QUESTION 2: How do pricing strategies differ between Fiction and Non-Fiction genres?
-- Goal: Compare pricing metrics and volatility across different book genres.
SELECT 
    Genre,
    COUNT(*) AS Total_Books,
    MAX(Price) AS Max_Price,
    MIN(Price) AS Min_Price,
    ROUND(AVG(Price), 2) AS Average_Price,
    ROUND(STDDEV(Price), 2) AS Price_Volatility
FROM amazon_bestsellers
GROUP BY Genre;

-- BUSINESS QUESTION 3: Which authors have consistently dominated the bestseller list over a decade?
-- Goal: Identify top-performing authors based on frequency and consistency in the bestseller list.
SELECT 
    Author, 
    COUNT(*) AS Appearances, 
    ROUND(AVG(`User Rating`), 2) AS Avg_Rating,
    GROUP_CONCAT(DISTINCT Year ORDER BY Year ASC SEPARATOR ', ') AS Years_Active
FROM amazon_bestsellers
GROUP BY Author
HAVING Appearances >= 5
ORDER BY Appearances DESC;