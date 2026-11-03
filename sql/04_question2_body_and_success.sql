--Durchschnitt Größe/Gewicht/Alter im Bezug auf Medaille vs. keine Medaille je Sportart

SELECT
s.sport_name,
CASE WHEN p.medal IS NOT NULL THEN 'Medaille' ELSE 'Keine Medaille' END AS status,
ROUND(AVG(a.height) / 10.0, 2) AS avg_height_cm,
ROUND(AVG(a.weight) / 10.0, 2) AS avg_weight_kg,
ROUND(AVG(p.age), 0) AS avg_age,
COUNT(*) AS participant_count
FROM participations p
JOIN athletes a ON p.athlete_id = a.athlete_id
JOIN events e ON p.event_id = e.event_id
JOIN sports s ON e.sport_id = s.sport_id
GROUP BY s.sport_name, status
ORDER BY s.sport_name, status;


--Sportarten sortiert nach durchschnittliche Größe der Medaillengewinner
SELECT
s.sport_name,
ROUND(AVG(a.height) / 10.0, 2) AS avg_height_medalists_cm,
COUNT(*) AS medal_count
FROM participations p
JOIN athletes a ON p.athlete_id = a.athlete_id
JOIN events e ON p.event_id = e.event_id
JOIN sports s ON e.sport_id = s.sport_id
WHERE p.medal IS NOT NULL AND a.height IS NOT NULL
GROUP BY s.sport_name
HAVING COUNT(*) >= 30
ORDER BY avg_height_medalists_cm DESC;


--Medaillenquote nach Größenklasse je Sportart
SELECT
s.sport_name,
CASE WHEN a.height < 1650 THEN '<165cm'
     WHEN a.height BETWEEN 1650 AND 1800 THEN '165-180cm'
     WHEN a.height BETWEEN 1801 AND 1950 THEN '181-195cm'
     ELSE '>195cm' END AS height_group,
COUNT(*) AS total_participations,
SUM(CASE WHEN p.medal IS NOT NULL THEN 1 ELSE 0 END) AS medal_count,
ROUND(100.0 * SUM(CASE WHEN p.medal IS NOT NULL THEN 1 ELSE 0 END) / COUNT(*), 2) AS medal_rate_pct
FROM participations p
JOIN athletes a ON p.athlete_id = a.athlete_id
JOIN events e ON p.event_id = e.event_id
JOIN sports s ON e.sport_id = s.sport_id
WHERE a.height IS NOT NULL
GROUP BY s.sport_name, height_group
ORDER BY s.sport_name, height_group;


--Alter der Medaillengewinner je Sportart im Zeitverlauf
SELECT
s.sport_name,
p.year,
ROUND(AVG(p.age), 0) AS avg_age_medalists
FROM participations p
JOIN events e ON p.event_id = e.event_id
JOIN sports s ON e.sport_id = s.sport_id
WHERE p.medal IS NOT NULL
GROUP BY s.sport_name, p.year
ORDER BY s.sport_name, p.year;


--Scatterplot
SELECT
s.sport_name,
ROUND(a.height / 10.0, 2) AS height_cm,
ROUND(a.weight / 10.0, 2) AS weight_kg,
p.age,
a.sex,
p.medal
FROM participations p
JOIN athletes a ON p.athlete_id = a.athlete_id
JOIN events e ON p.event_id = e.event_id
JOIN sports s ON e.sport_id = s.sport_id
WHERE p.medal IS NOT NULL AND a.height IS NOT NULL AND a.weight IS NOT NULL;