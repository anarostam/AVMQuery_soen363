//import of csv
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/anarostam/AVMQuery_soen363/main/phase2/csv/accident.csv' AS row
CALL {
  WITH row
  CREATE (:Accident {
    accident_id: row.accident_id, 
    weather_id: row.weather_id, 
    state_case: row.state_case, 
    time: row.time, 
    event_name: row.evenement_name, 
    lat: row.lat, 
    lon: row.lon, 
    detail_information: '',
    light_condition: '',
    road_function: '',
    intersection_type: '',
    drunk_driving: false
  })
} IN TRANSACTIONS OF 500 ROWS;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/anarostam/AVMQuery_soen363/main/phase2/csv/details.csv' AS row
MATCH (a:Accident {accident_id: toInteger(row.detail_id)})
SET a.detail_information = row.detail_information,
    a.light_condition = row.light_condition,
    a.road_function = row.road_function,
    a.intersection_type = row.intersection_type,
    a.drunk_driving = toBoolean(row.drunk_driving);


LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/anarostam/AVMQuery_soen363/main/phase2/csv/emergency_respondent.csv' AS row
             CALL {
               WITH row
               CREATE (:EmergencyRespondent {
                 respondent_id: toInteger(row.respondent_id),
                 type: row.type,
                 contact_info: row.contact_info,
                 ssn: row.ssn,
                 first_name: row.first_name,
                 last_name: row.last_name,
                 date_of_birth: date(row.date_of_birth),
                 sex: row.sex,
                 counties: [x IN split(replace(replace(row.counties, '{', ''), '}', ''), ',') | toInteger(x)]
               })
             } IN TRANSACTIONS OF 50 ROWS;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/anarostam/AVMQuery_soen363/refs/heads/main/phase2/csv/victim.csv' AS row
CALL {
  WITH row
  CREATE (:Victim {
    victim_id: toInteger(row.victim_id),
    contact_info: row.contact_info,
    ssn: row.ssn,
    first_name: row.first_name,
    last_name: row.last_name,
    date_of_birth: date(row.date_of_birth),
    sex: row.sex,
    health_insurance: CASE row.health_insurance WHEN 't' THEN true ELSE false END
  })
} IN TRANSACTIONS OF 50 ROWS;


LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/anarostam/AVMQuery_soen363/refs/heads/main/phase2/csv/vehicle.csv' AS row
CALL {
  WITH row
  CREATE (:Vehicle {
    vin: row.vin,
    maker: row.maker,
    model: row.model
  })
} IN TRANSACTIONS OF 50 ROWS;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/anarostam/AVMQuery_soen363/refs/heads/main/phase2/csv/location.csv' AS row
             CALL {
               WITH row
               CREATE (:Location {
                 lat: toFloat(row.lat),
                 lon: toFloat(row.lon),
                 state: row.state,
                 city: row.city,
                 route: toInteger(row.route),
                 route_name: row.route_name,
                 county: row.county,
                 county_num: toInteger(row.county_num)
               })
             } IN TRANSACTIONS OF 50 ROWS;
    
LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/anarostam/AVMQuery_soen363/refs/heads/main/phase2/csv/weatherchunked/chunked_weather_chunk_aj.csv' AS row
CALL {
  WITH row
  CREATE (w:Weather {
    weather_id: toInteger(row.weather_id),
    lat: toFloat(row.lat),
    lon: toFloat(row.lon),
    time: date(row.time),
    unix_timestamp: toInteger(row.unix_timestamp),
    weather_description: row.weather_description,
    temperature: toFloat(row.temperature),
    apparent_temperature: toFloat(row.apparent_temperature),
    precipitation: toFloat(row.precipitation),
    rain: toFloat(row.rain),
    snowfall: toFloat(row.snowfall),
    snow_depth: toFloat(row.snow_depth),
    cloud_cover: toInteger(row.cloud_cover),
    cloud_cover_low: toInteger(row.cloud_cover_low),
    cloud_cover_mid: toInteger(row.cloud_cover_mid),
    cloud_cover_high: toInteger(row.cloud_cover_high),
    wind_speed_10m: toFloat(row.wind_speed_10m),
    wind_speed_100m: toFloat(row.wind_speed_100m),
    wind_direction_10m: toFloat(row.wind_direction_10m),
    wind_direction_100m: toFloat(row.wind_direction_100m),
    wind_gusts_10m: toFloat(row.wind_gusts_10m)
  })
} IN TRANSACTIONS OF 5 ROWS;

CREATE INDEX accident_id_index IF NOT EXISTS
FOR (a:Accident)
ON (a.accident_id);


LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/anarostam/AVMQuery_soen363/main/phase2/csv/detailschunked/chunked_details_chunk_ac.csv' AS row
CALL {
  WITH row
  MATCH (a:Accident {accident_id: row.detail_id})  // <-- no toInteger
  SET a.detail_information = row.detail_information,
      a.light_condition = row.light_condition,
      a.road_function = row.road_function,
      a.intersection_type = row.intersection_type,
      a.drunk_driving = CASE row.drunk_driving
                          WHEN 't' THEN true
                          WHEN 'f' THEN false
                          ELSE null
                        END
} IN TRANSACTIONS OF 5 ROWS;


CREATE INDEX vehicle_vin_index IF NOT EXISTS FOR (v:Vehicle) ON (v.vin);

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/anarostam/AVMQuery_soen363/main/phase2/csv/accident_vehicle.csv' AS row
CALL {
  WITH row
  MATCH (a:Accident {accident_id: row.accident_id})
  MATCH (v:Vehicle {vin: row.vin})
  MERGE (a)-[:INVOLVED]->(v)
} IN TRANSACTIONS OF 5 ROWS;

CREATE INDEX victim_id_index IF NOT EXISTS FOR (v:Victim) ON (v.victim_id);

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/anarostam/AVMQuery_soen363/refs/heads/main/phase2/csv/accident_victim.csv' AS row
CALL {
  WITH row
  MATCH (a:Accident {accident_id: row.accident_id})
  MATCH (v:Victim {victim_id: toInteger(row.victim_id)})
  MERGE (a)-[r:HAS_VICTIM]->(v)
  SET r.injured = CASE row.injured
                    WHEN 't' THEN true
                    WHEN 'f' THEN false
                    ELSE null
                  END,
      r.injury_desc = row.injury_desc
} IN TRANSACTIONS OF 5 ROWS;

CREATE INDEX respondent_id_index IF NOT EXISTS FOR (r:EmergencyRespondent) ON (r.respondent_id);





LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/anarostam/AVMQuery_soen363/refs/heads/main/phase2/csv/vehicle_victim.csv' AS row
CALL {
  WITH row
  MATCH (v:Victim {victim_id: toInteger(row.victim_id)})
  MATCH (veh:Vehicle {vin: row.vin})
  MERGE (v)-[r:WAS_IN]->(veh)
  SET r.driving = CASE row.driving
                    WHEN 't' THEN true
                    WHEN 'f' THEN false
                    ELSE null
                  END
} IN TRANSACTIONS OF 5 ROWS;

LOAD CSV WITH HEADERS FROM 'https://raw.githubusercontent.com/anarostam/AVMQuery_soen363/refs/heads/main/phase2/csv/interventionchunked/chunked_intervention_chunk_ao.csv' AS row
CALL {
  WITH row
  MATCH (v:Victim {victim_id: toInteger(row.victim_id)})
  MATCH (a:Accident {accident_id: row.accident_id})  // No toInteger()
  MATCH (r:EmergencyRespondent {respondent_id: toInteger(row.respondent_id)})
  MERGE (i:Intervention {intervention_id: toInteger(row.intervention_id)})
  SET i.victim_id = toInteger(row.victim_id),
      i.accident_id = row.accident_id,
      i.respondent_id = toInteger(row.respondent_id)
  MERGE (i)-[:INVOLVES_VICTIM]->(v)
  MERGE (i)-[:RELATED_TO_ACCIDENT]->(a)
  MERGE (i)-[:HANDLED_BY]->(r)
} IN TRANSACTIONS OF 5 ROWS;