** Exploratory Data Analysis (EDA)**

-- Check the number of unique apps in both tables
SELECT COUNT(DISTINCT id)
FROM AppleStore

SELECT COUNT(DISTINCT id)
FROM AppleStore_description_combined

-- Check missing values in key fields
SELECT COUNT(*) AS Missing_Values
FROM AppleStore
WHERE track_name IS NULL OR user_rating IS NULL OR prime_genre IS NULL

SELECT COUNT(*) AS Missing_Values
FROM AppleStore_description_combined
WHERE track_name IS NULL OR app_desc IS NULL 
  
-- Number of apps per genre
SELECT prime_genre, COUNT(*) AS NumApps
FROM AppleStore
GROUP BY prime_genre
ORDER BY NumApps DESC

-- Tracks according to their prices
SELECT track_name, price
FROM AppleStore
GROUP BY track_name, price
ORDER BY price DESC

-- Overview of apps' ratings
SELECT MIN(user_rating) AS MinRating,
	   MAX(user_rating) AS MaxRating,
       AVG(user_rating) AS AvgRating
FROM AppleStore  