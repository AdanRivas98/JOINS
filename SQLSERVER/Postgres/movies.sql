-- *1 Mostrar la lista de todas las peliculas indicando si esta en Idioma español o no-- 
SELECT m.title, CASE WHEN l.language_code = 'es' THEN 'si' ELSE 'no' END AS español FROM movies.movie m 
INNER JOIN movies.movie_languages ml 
ON ml.movie_id = m.movie_id 
INNER JOIN movies.`language` l 
ON l.language_id = ml.language_id ; 

--*2 Mostrar el genero(drama, accion, terror, etc) de cada pelicula -- 
SELECT m.title, g.genre_name FROM movies.movie m 
INNER JOIN movies.movie_genres mg 
ON mg.movie_id = m.movie_id 
INNER JOIN movies.genre g 
ON g.genre_id = mg.genre_id ; 

-- *3 Cuales son las 5 compañias productoras de peliculas que tiene mayor aceptacion (votos)-- 
SELECT SUM(m.vote_count), pc.company_name FROM movies.movie m 
INNER JOIN movies.movie_company mc 
ON mc.movie_id = m.movie_id 
INNER JOIN movies.production_company pc 
ON pc.company_id = mc.company_id 
GROUP BY pc.company_name 
ORDER BY SUM(m.vote_count) DESC LIMIT 5; 

-- *4 Mostrar una lista de las personas que participan en cada pelicula-- 
SELECT m.title, p.person_name  FROM movies.movie m 
INNER JOIN movies.movie_cast mc 
ON mc.movie_id = m.movie_id 
INNER JOIN movies.person p 
ON p.person_id = mc.person_id ; 

-- *5 Mostrar una lista con la cantidad de personas por departamento que cuenta cada compañia productora-- 
SELECT d.department_name, COUNT(mc.movie_id) FROM movies.department d 
INNER JOIN movies.movie_crew mc 
ON d.department_id = mc.department_id 
GROUP BY d.department_name ; 

-- *6 Mostrar las peliculas en las que ha participado las personas como parte del movie_cast-- 
SELECT m.title FROM movies.movie m 
INNER JOIN movies.movie_cast mc 
ON mc.movie_id = m.movie_id
GROUP BY m.title ; 

-- *7 Listar los paises donde estan ubicas las compañias productoras-- 
SELECT pc2.company_name, c.country_name  FROM movies.movie m 
INNER JOIN movies.production_country pc 
ON pc.movie_id = m.movie_id 
INNER JOIN movies.country c 
ON pc.country_id = c.country_id 
INNER JOIN movies.movie_company mc 
ON m.movie_id = mc.movie_id 
INNER JOIN movies.production_company pc2 
ON mc.company_id = pc2.company_id ; 

