** Data Analysis (Finding the insights)**

-- Determine Whether paid apps have higher ratings than free apps
SELECT CASE
			WHEN price > 0 THEN 'Paid'
            ELSE 'Free'
       END AS AppType,
       AVG(user_rating) AS Avg_rating
FROM AppleStore
GROUP BY AppType
ORDER BY Avg_rating DESC

 -- Determine Whether apps with more supported languages have higher ratings
 SELECT CASE
 			WHEN lang_num < 10 THEN '<10 languages'
            WHEN lang_num BETWEEN 10 AND 30 THEN '10-30 languages'
            ELSE '>30 languages'
            
        END AS language_bucket,
        AVG(user_rating) AS Avg_rating
FROM AppleStore        
GROUP BY language_bucket
ORDER BY Avg_rating DESC

-- Check genres with low ratings
SELECT prime_genre, AVG(user_rating) AS Avg_rating
FROM AppleStore
GROUP BY prime_genre
ORDER BY Avg_rating
LIMIT 10

-- Check correlation between length of app description and uaer rating 
SELECT CASE
		   WHEN length(B.app_desc) < 500 THEN 'short'
           WHEN length(B.app_desc) BETWEEN 500 AND 1000 THEN 'medium'
           ELSE 'long'
       END AS desc_len_bucket,
       AVG(A.user_rating) AS Avg_rating    
       
FROM AppleStore AS A
JOIN AppleStore_description_combined AS B
On A.id = B.id
GROUP BY desc_len_bucket
ORDER BY Avg_rating DESC

-- Check the top rated apps for each genre
SELECT prime_genre,
	   track_name ,
       user_rating
FROM (
  	  SELECT 
      prime_genre,
      track_name,
      user_rating,
      RANK() OVER(PARTITION BY prime_genre ORDER BY user_rating DESC, rating_count_tot DESC) AS rank
      FROm 
  	  AppleStore
      ) AS A 
WHERE A.rank = 1    

**Final Recommendations**
	--> Paid apps have better rating
    --> Apps supporting around 10 to 30 languages have better ratings
    --> Finance and Book apps have low ratings
    --> Apps with longer description have better ratings
    --> A new app should aim for an average rating above 3.5 


