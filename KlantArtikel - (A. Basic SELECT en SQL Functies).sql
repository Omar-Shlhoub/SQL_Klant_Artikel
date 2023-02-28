----- Basics SQL Querry----- 
----- Omar shlhoub -----
--Basket ball database E. Subqueries)
----------------------------------------------------------------------------------

--(Vraag 1.) 

--Geef de leden die in dezelfde plaats wonen als het lid met nummer 83.

--MYSQL

SELECT achternaam, woonplaats
FROM lid
WHERE woonplaats = (    SELECT woonplaats
                        FROM lid
                        WHERE nr = 83
                        )


------------------------------

--(Vraag 2.) 

--Geef een overzicht van de boetes van de leden die in Amsterdam wonen. Tip: gebruik WHERE ... IN...

--MYSQL

SELECT  betalingnr, 
        lid_nr, 
        TYPE, 
        datumovertreding, 
        bedrag
FROM boete AS b
JOIN lid AS l 
ON b.lid_nr = l.nr
WHERE woonplaats IN (   SELECT woonplaats
                        FROM lid
                        WHERE woonplaats = 'Amsterdam'
                        )

------------------------------

--(Vraag 3.) 

--Geef de thuiswedstrijden en de uitslag van de thuiswedstrijden van de teams met als thuishal de'Apollohal'.

--MYSQL

SELECT  datum, 
        tijd, 
        team_code_thuis, 
        team_code_uit, 
        concat(scorethuis, ' - ',scoreuit) AS uitslag
FROM wedstrijd AS w
JOIN team AS t 
ON t.code = w.team_code_thuis
JOIN sporthal AS s 
ON t.sporthal_naam = s.naam
WHERE s.naam = 'Apollohal'

------------------------------

--(Vraag 4.)

--Geef een overzicht van de boetes van de leden die voor team 'LEAMD1' hebben gespeeld.

--MYSQL

SELECT  betalingnr, 
        lid_nr, 
        TYPE, 
        datumovertreding, 
        bedrag
FROM lid AS l
JOIN boete AS b 
ON l.nr = b.lid_nr
WHERE team_code_speelt_in = 'LEAMD1'

------------------------------

--(Vraag 5.)

--Geef de namen van de leden die de hoogste boete hebben betaald.

--MYSQL

SELECT achternaam
FROM lid
WHERE nr IN (
                SELECT b.lid_nr
                FROM boete AS b
                WHERE bedrag = (
                SELECT MAX(bedrag)
                FROM boete
                )
)

------------------------------

--(Vraag 6.)

--Geef een lijst van leden en het aantal boetes dat ze hebben betaald, laat de naam van het lid en het
--aantal boetes zien.

--MYSQL

SELECT  achternaam, 
        COUNT(bedrag) AS aantalBoetes
FROM lid AS l
JOIN boete AS b ON l.nr = b.lid_nr
GROUP BY achternaam

------------------------------

--(Vraag 7.)

--Geef de namen van de leden die meer dan 2 boetes hebben betaald.

--MYSQL 

SELECT achternaam, 
        COUNT(bedrag) AS aantalboetes
FROM lid AS l
JOIN boete AS b 
ON l.nr = b.lid_nr
GROUP BY achternaam
HAVING COUNT(bedrag)> 2

------------------------------

--(Vraag 8.)

--Geef de naam van het lid dat meer boetes heeft betaald dan het lid met lidnummer 201.

--MYSQL

SELECT achternaam
FROM lid AS l
JOIN boete AS b 
ON l.nr = b.lid_nr
GROUP BY achternaam
HAVING COUNT(bedrag)> (
                        SELECT COUNT(bedrag)
                        FROM boete AS b
                        JOIN lid AS l ON l.nr = b.lid_nr
                        WHERE lid_nr = 201)