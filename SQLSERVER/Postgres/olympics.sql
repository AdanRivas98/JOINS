-- *1 Mostrar la lista de los ganadores de medalla de oro en eventos de Futbol, Baloncesto y Golf-- 
SELECT * FROM olympics.event e 
INNER JOIN olympics.competitor_event ce
ON e.id = ce.event_id
INNER JOIN olympics.medal m 
ON m.id = ce.medal_id
WHERE m.medal_name = 'Gold' AND e.event_name IN ('Futbol', 'Baloncesto', 'Golf'); 

-- *2 Cuales son los eventos que se jugaron en el año 2000-- 
SELECT e.event_name FROM olympics.games g
INNER JOIN olympics.games_competitor gc 
ON gc.games_id = g.id 
INNER JOIN olympics.competitor_event ce
ON ce.competitor_id = gc.id 
INNER JOIN olympics.event e 
ON e.id = ce.event_id
WHERE g.games_year = 2000; 

-- *3 Cuales son las 20 principales ciudades donde se han jugado mas Olimpiadas-- 
SELECT c.city_name, COUNT(gc.games_id) FROM olympics.games_city gc 
INNER JOIN olympics.city c 
ON c.id = gc.city_id 
GROUP BY c.city_name 
ORDER BY COUNT(gc.games_id) DESC LIMIT 20;

-- *4 Liste los paises no tienen ningun participante en las ultimas 10 olimpiadas-- 
SELECT nr.region_name FROM olympics.noc_region nr 
INNER JOIN olympics.person_region pr 
ON pr.region_id = nr.id 
INNER JOIN olympics.person p 
ON p.id = pr.person_id 
INNER JOIN olympics.games_competitor gc 
ON gc.person_id  = p.id
LEFT JOIN olympics.games g
ON g.id = gc.games_id
WHERE g.games_year IS NULL LIMIT 10; 

-- *5 liste los 5 paises que mas ganan medallas de oro, plata y bronce-- 
SELECT nr.region_name, COUNT(ce.event_id) FROM olympics.noc_region nr 
INNER JOIN olympics.person_region pr 
ON pr.region_id = nr.id 
INNER JOIN olympics.person p 
ON p.id = pr.person_id 
INNER JOIN olympics.games_competitor gc 
ON gc.person_id  = p.id
INNER JOIN olympics.competitor_event ce
ON ce.competitor_id = gc.id
INNER JOIN olympics.medal m 
ON ce.medal_id = m.id 
WHERE m.medal_name = 'Gold'
GROUP BY nr.region_name LIMIT 5;

SELECT nr.region_name, COUNT(ce.event_id) FROM olympics.noc_region nr 
INNER JOIN olympics.person_region pr 
ON pr.region_id = nr.id 
INNER JOIN olympics.person p 
ON p.id = pr.person_id 
INNER JOIN olympics.games_competitor gc 
ON gc.person_id  = p.id
INNER JOIN olympics.competitor_event ce
ON ce.competitor_id = gc.id
INNER JOIN olympics.medal m 
ON ce.medal_id = m.id 
WHERE m.medal_name = 'Silver'
GROUP BY nr.region_name LIMIT 5;

SELECT nr.region_name, COUNT(ce.event_id) FROM olympics.noc_region nr 
INNER JOIN olympics.person_region pr 
ON pr.region_id = nr.id 
INNER JOIN olympics.person p 
ON p.id = pr.person_id 
INNER JOIN olympics.games_competitor gc 
ON gc.person_id  = p.id
INNER JOIN olympics.competitor_event ce
ON ce.competitor_id = gc.id
INNER JOIN olympics.medal m 
ON ce.medal_id = m.id 
WHERE m.medal_name = 'Bronze'
GROUP BY nr.region_name LIMIT 5; 

-- *6 El evento con mayor cantidad de personas participando --
SELECT MAX(e.event_name) FROM olympics.event e 
INNER JOIN olympics.competitor_event ce 
ON ce.event_id = e.id ; 

-- *9 Cual es la altura y peso que mas es mas frecuente en los participantes del deporte de Boxeo-- 
SELECT MAX(p.height) AS altura, MAX(p.weight) AS peso FROM olympics.sport s 
INNER JOIN olympics.event e 
ON e.sport_id = s.id 
INNER JOIN olympics.competitor_event ce 
ON ce.event_id = e.id 
INNER JOIN olympics.games_competitor gc 
ON gc.id = ce.competitor_id
INNER JOIN olympics.person p 
ON gc.person_id = p.id 
WHERE s.sport_name = 'Boxeo'; 

-- *10 Muestre los participantes menores de edad que participan en las olimpiadas-- 
SELECT p.full_name, gc.age FROM olympics.games_competitor gc 
INNER JOIN olympics.person p 
ON p.id = gc.person_id 
WHERE gc.age < 18; 

