-- Medaillen pro Land und Jahr

SELECT 
c.country_name, 
p.year, 
COUNT(*) AS medal_count
FROM participations p
JOIN countries c ON p.noc = c.noc
WHERE p.medal IS NOT NULL
GROUP BY c.country_name, p.year
ORDER BY c.country_name, p.year;



-- Veränderungen zum Vorjahr

SELECT 
country_name, 
year, 
medal_count,
       medal_count - LAG(medal_count) OVER (PARTITION BY country_name ORDER BY year) AS change_vs_prev
FROM (
    SELECT c.country_name, p.year, COUNT(*) AS medal_count
    FROM participations p
    JOIN countries c ON p.noc = c.noc
    WHERE p.medal IS NOT NULL
    GROUP BY c.country_name, p.year
) t
ORDER BY country_name, year;


--Größter Zuwachs/Rückgang

SELECT 
c.country_name,
       SUM(CASE WHEN p.year IN (2008, 2012, 2016) THEN 1 ELSE 0 END) AS medals_recent,
       SUM(CASE WHEN p.year IN (1996, 2000, 2004) THEN 1 ELSE 0 END) AS medals_earlier,
       SUM(CASE WHEN p.year IN (2008, 2012, 2016) THEN 1 ELSE 0 END) - SUM(CASE WHEN p.year IN (1996, 2000, 2004) THEN 1 ELSE 0 END) AS delta
FROM participations p
JOIN countries c ON p.noc = c.noc
WHERE p.medal IS NOT NULL
GROUP BY c.country_name
ORDER BY delta DESC
;


--Top 10 Länder (Anzahl Medaillen)

SELECT 
c.country_name, 
COUNT(*) AS total_medals
FROM participations p
JOIN countries c ON p.noc = c.noc
WHERE p.medal IS NOT NULL
GROUP BY c.country_name
ORDER BY total_medals DESC
LIMIT 10;


--Medaillentyp pro Land je Jahr

SELECT 
c.country_name, 
p.year, 
p.medal, 
COUNT(*) AS count
FROM participations p
JOIN countries c ON p.noc = c.noc
WHERE p.medal IS NOT NULL
GROUP BY c.country_name, p.year, p.medal
ORDER BY country_name;


-- Medaillentyp pro Land 2016 

SELECT 
c.country_name,
       SUM(CASE WHEN p.medal = 'Gold' THEN 1 ELSE 0 END) AS gold,
       SUM(CASE WHEN p.medal = 'Silver' THEN 1 ELSE 0 END) AS silver,
       SUM(CASE WHEN p.medal = 'Bronze' THEN 1 ELSE 0 END) AS bronze,
       COUNT(*) AS total_medals
FROM participations p
JOIN countries c ON p.noc = c.noc
WHERE p.medal IS NOT NULL AND p.year = 2016
GROUP BY c.country_name
ORDER BY total_medals DESC;


