SELECT 'athletes' AS tabelle, COUNT(*) FROM athletes
UNION ALL
SELECT 'countries', COUNT(*) FROM countries
UNION ALL
SELECT 'sports', COUNT(*) FROM sports
UNION ALL
SELECT 'events', COUNT(*) FROM events
UNION ALL
SELECT 'participations', COUNT(*) FROM participations;

SELECT COUNT(*)
FROM participations p
JOIN athletes a ON p.athlete_id = a.athlete_id
JOIN events e ON p.event_id = e.event_id
JOIN countries c ON p.noc = c.noc
JOIN sports s ON e.sport_id = s.sport_id;

SELECT a.name, e.event_name, s.sport_name, c.country_name, p.year, p.medal
FROM participations p
JOIN athletes a ON p.athlete_id = a.athlete_id
JOIN events e ON p.event_id = e.event_id
JOIN countries c ON p.noc = c.noc
JOIN sports s ON e.sport_id = s.sport_id
LIMIT 10;