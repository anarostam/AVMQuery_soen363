--1) inner join// equivalent WHERE clause

SELECT a.accident_id, loc.state, loc.county, loc.city
FROM Accident a
INNER JOIN location loc ON a.lat = loc.lat AND a.lon = loc.lon

SELECT a.accident_id, loc.state, loc.county, loc.city
FROM Accident a, location loc
WHERE a.lat = loc.lat AND a.lon = loc.lon

-- outer join // equivalent WHERE clause

SELECT loc.city, w.weather_description, w.temperature
FROM location loc
RIGHT JOIN weather w ON loc.lat = w.lat AND loc.lon = w.lon


SELECT loc.city, w.weather_description, w.temperature
FROM location loc, weather w
WHERE loc.lat = w.lat AND loc.lon = w.lon

--full join // equivalent WHERE clause

SELECT d.detail_information, a.evenement_name, d.light_condition
FROM details d
FULL JOIN Accident a ON d.detail_id = a.accident_id

(SELECT d.detail_information, a.evenement_name, d.light_condition
FROM details d, Accident a
WHERE d.detail_id = a.accident_id)
UNION
(SELECT d.detail_information, NULL AS evenement_name, d.light_condition
FROM details d
WHERE NOT EXISTS (
  SELECT 1 FROM Accident a WHERE d.detail_id = a.accident_id
))
UNION
(SELECT NULL AS detail_information, a.evenement_name, NULL AS light_condition
FROM Accident a
WHERE NOT EXISTS (
  SELECT 1 FROM details d WHERE d.detail_id = a.accident_id));


--3) simple group by (with and without where, with or with our having clause)
--1.with WHERE and HAVING clause
SELECT loc.county, COUNT(*) AS accident_count
FROM Accident a
JOIN location loc ON a.lat = loc.lat AND a.lon = loc.lon
WHERE lower(loc.city) = 'birmingham'
GROUP BY loc.county
HAVING COUNT(*) >= 2

--2.without WHERE and HAVING clause
SELECT er.type, COUNT(*) AS total_er 
FROM emergency_respondent er
GROUP BY type

--3.with WHERE and without HAVING clause
SELECT w.snowfall, COUNT(*) AS total_snow
FROM weather w
WHERE w.temperature >= 5
GROUP BY w.snowfall

--4.without WHERE and with HAVING clause
SELECT date_of_birth, COUNT(*) AS victim_count
FROM Victim 
GROUP BY date_of_birth
HAVING COUNT(*) > 1;

--4)A join with nested sub-query
SELECT loc.city, loc.county, w.rain
FROM location loc
JOIN weather w ON loc.lat = w.lat AND loc.lon = w.lon
WHERE w.rain IN (
SELECT MAX(rain)
FROM weather
)

--5)A couple of correlated queries
--1.
SELECT v1.first_name, v1.last_name
FROM Victim v1
WHERE v1.date_of_birth = (
SELECT MAX(v2.date_of_birth)
FROM Victim v2
WHERE v2.sex = v1.sex
);

--2.
SELECT w1.weather_id, w1.lat, w1.lon, w1.time, w1.temperature
FROM weather w1
WHERE w1.temperature IN (
    SELECT MAX(w2.temperature)
    FROM weather w2
    WHERE w2.lat = w1.lat AND w2.lon = w1.lon
);

--3.
SELECT d1.detail_id, d1.road_function, d1.drunk_driving
FROM details d1
WHERE d1.road_function = (
    SELECT d2.road_function
    FROM details d2
    WHERE d2.drunk_driving = TRUE
    GROUP BY d2.road_function
    ORDER BY COUNT(*) DESC
    LIMIT 1
);

--9) implementation of the division operator
--a) A regular nested query with NOT IN
SELECT v.first_name, v.last_name
FROM Victim v
WHERE v.victim_id NOT IN(
SELECT i.victim_id
FROM intervention i
)

--b) A regular nested query with NOT EXISTS and EXCEPT
SELECT loc.lat, loc.lon, loc.city, loc.county
FROM location loc
WHERE NOT EXISTS (
    SELECT a.lat, a.lon
    FROM accident a
    WHERE a.lat = loc.lat AND a.lon = loc.lon
    EXCEPT
    SELECT loc.lat, loc.lon
);

