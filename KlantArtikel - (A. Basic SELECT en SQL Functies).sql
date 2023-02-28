----- Basics SQL Querry----- 
----- Omar shlhoub -----
--KlantArtikel database (A. Basic SELECT en SQL Functies)
----------------------------------------------------------------------------------

--(Vraag 1.)

--Welke bestellingen zijn in februari 2013 geleverd?

--MSSQL

SELECT bestelnr
FROM bestelling
WHERE leverdatum BETWEEN '2013-02-01' AND '2013-02-28';

--------------------------------

--(Vraag 2.)

--Hoeveel bestellingen uit 2015 zijn binnen 10 dagen betaald

--MSSQL

WITH cte AS (   SELECT     bestelnr, 
                        besteldatum, 
                        datediff(d, leverdatum, betaaldatum) ASaantal
                FROM bestelling
                WHERE datediff(d, leverdatum, betaaldatum)<= 10
                AND YEAR(besteldatum)= 2015
                )
SELECT COUNT(bestelnr)
FROM cte;

--------------------------------

--(Vraag 3.) 

--Wat is de maximaal gebruikte betalingstermijn?

--MSSQL

SELECT MAX(datediff(d, leverdatum, betaaldatum)) AS maxtermijn
FROM bestelling;

--------------------------------

--(Vraag 4.)

--Op welke dag is de laatste bestelling gedaan? Zorg er voor dat het antwoord het volgende format
--heeft: “zaterdag 26 december 2015”

--MSSQL

SELECT top 1 format (besteldatum, 'dddd dd MMMM yyyy','nl-nl') AS laatstebesteldag
FROM bestelling
ORDER BY besteldatum DESC;

--------------------------------

--(Vraag 5.)

--Wat zijn de postcodes (zonder huisnummer) van de klanten uit Eindhoven?

--MSSQL

SELECT DISTINCT (SUBSTRING(postcodehuisnr, 1, 6)) AS postcode
FROM klant
WHERE woonplaats = 'Eindhoven';

--------------------------------

--(Vraag 6.)

--Hoeveel bestellingen zijn in 2015 in het weekend geleverd?

--MSSQL

SELECT COUNT(bestelnr) AS aantal
FROM bestelling
WHERE YEAR(leverdatum)= 2015
AND DATENAME (dw, leverdatum) IN ('Saturday', 'Sunday');

--------------------------------