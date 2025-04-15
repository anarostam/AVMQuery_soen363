-- View: accidents with sever weather conditions
CREATE VIEW severe_weather_accidents AS
SELECT a.accident_id, a.time,
       l.city, l.state, l.county,
       w.weather_description
FROM accident a
JOIN location l ON a.lat = l.lat AND a.lon = l.lon
JOIN weather w ON a.lat = w.lat AND a.lon = w.lon
WHERE w.weather_description IN (
    'Heavy rain', 'Heavy snow', 'T-storm with hail', 'Freezing rain'
);
