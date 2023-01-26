/* In this project, l explore the top 400 best-selling video games created between 1977 and 2020. 
Compare a dataset on game sales with critic and user reviews to determine whether or not video games have improved as the gaming market has grown.
Our database contains two tables: game_sales and review */

/* Check first 10 rows */
SELECT * 
FROM game_sales
LIMIT 10;

-- The ten best-selling video games
SELECT *
FROM game_sales
ORDER BY games_sold DESC
LIMIT 10;

/* Find the top ten video games by average critic_score and count the number of games released in each year.
Count has to be more then 4. Save the result of query as top_critic_years */
CREATE VIEw top_critic_years  AS (
SELECT year, 
       ROUND(AVG(critic_score),2) AS avg_critic_score, 
       COUNT(*) AS num_games
FROM game_sales
INNER JOIN reviews
USING (game)
GROUP BY year
HAVING COUNT(*) > 4
ORDER BY avg_critic_score DESC
LIMIT 10);

/* Find the top ten video games by average user_score and count the number of games released in each year.
Count has to be more then 4. Save the result of query as top_user_years */
CREATE VIEw top_user_years  AS (
SELECT 
    year, 
    ROUND(AVG(user_score),2) as avg_user_score, 
    COUNT(*) AS num_games
FROM game_sales
INNER JOIN reviews
USING(game)
GROUP BY year
HAVING COUNT(*) > 4
ORDER BY avg_user_score DESC
LIMIT 10
);

-- Find the years that are shown up in both tables
SELECT year
FROM top_critic_years
INTERSECT
SELECT year
FROM top_user_years

/* As a result from previeus query, we know the best years for video games are '1998','2002','2008'.
Now we can generate the total number of games for those years to find the best year */ 
SELECT  year, 
	SUM(games_sold) AS total_games_sold
FROM game_sales 
WHERE year IN 
	(
	SELECT year
	FROM top_critic_years
	INTERSECT
	SELECT year
	FROM top_user_years
	)
GROUP BY year
ORDER BY total_games_sold DESC;

-- The best year for video games was 2008	
-- 175 games sold 
-- 9.03 Average user score
-- 8.63 Average critic score
