/* **********************************************************
	NordAir - Rêquetes
	Schéma MRD:	"NordAir"
	Auteur:		Arthur Tirado et Xavier Breton-L'italien	
********************************************************** */
USE NORDAIR
GO	

/*
Question C.1 10 points
• Produire la liste de tous les segments de vols de la compagnie NordAir au départ de la Côte-Nord
(municipalités de Baie-Comeau, Havre Saint-Pierre et Sept-Îles) comprenant dans l'ordre:
- Le no de vol (VOL),
- Le nom de la ville de l'aéroport de départ (DEPART),
- L'heure de départ, sous le format hh:mi (A)
- Le nom de la ville de l'aéroport de destination (ARRIVEE),
- La durée estimée d’une envolée, sous le format hh:mi (DUREE)
• Cette liste est triée par ville de départ, heure de départ puis ville de destination.
*/

SELECT
	LEFT(VOL.NO_VOL, 10) AS VOL,
	AEROPORT_DEPART.NOM_VILLE AS DEPART,
	CONVERT(VARCHAR(5), SEGMENT.HEURE_DEPART, 108) AS A,
	AEROPORT_DESTINATION.NOM_VILLE AS ARRIVEE,
	LEFT(FORMAT(DATEADD(MINUTE, SEGMENT.DUREE_VOL, 0), 'HH:mm'), 10) AS DUREE
FROM
	SEGMENT
	INNER JOIN VOL
		ON SEGMENT.ID_VOL = VOL.ID_VOL
	INNER JOIN AEROPORT AEROPORT_DEPART
		ON AEROPORT_DEPART.ID_AEROPORT = SEGMENT.AEROPORT_DEPART
	INNER JOIN AEROPORT AEROPORT_DESTINATION
		ON AEROPORT_DESTINATION.ID_AEROPORT = SEGMENT.AEROPORT_DESTINATION
WHERE
	AEROPORT_DEPART.NOM_VILLE IN ('BAIE-COMEAU', 'HAVRE SAINT-PIERRE', 'SEPT-ILES')
ORDER BY
	AEROPORT_DEPART.NOM_VILLE,
	SEGMENT.HEURE_DEPART,
	AEROPORT_DESTINATION.NOM_VILLE

/*
VOL        DEPART               A     ARRIVEE              DUREE
---------- -------------------- ----- -------------------- ----------
1822       BAIE-COMEAU          07:00 SEPT-ILES            01:00
1923       BAIE-COMEAU          08:30 MONT-JOLI            00:45
1922       BAIE-COMEAU          18:30 SEPT-ILES            01:00
1823       BAIE-COMEAU          20:00 MONT-JOLI            00:45
1923       HAVRE SAINT-PIERRE   05:30 GASPE                00:40
1823       HAVRE SAINT-PIERRE   17:00 GASPE                00:40
1923       SEPT-ILES            07:30 BAIE-COMEAU          00:55
1822       SEPT-ILES            08:00 GASPE                00:30
1823       SEPT-ILES            19:00 BAIE-COMEAU          00:55
1922       SEPT-ILES            19:30 GASPE                00:30

(10 rows affected)
*/

/*
Question C.2 10 points
• Produire la liste des vols prévus pour la période du 13 au 19 mai 2024. Pour chacun, indiquer
dans l'ordre:
- La date du vol, sous le format YYYY-MM-DD (DATE),
- Le numéro du vol (VOL),
- Le nombre de sièges encore disponibles (non réservés) pour l'ensemble du vol (sur
tous les segments, du départ initial à la destination finale du vol) (DISPONIBLES).
• Cette liste est triée par date puis par vol.
*/

SELECT
	CAST(ENVOLEE.DATE_ENVOLEE AS DATE) AS DATE,
	LEFT(VOL.NO_VOL, 10) AS VOL,
	LEFT(MIN(V_ENVOLEES_SIEGES.NOMBRE_PLACES - V_ENVOLEES_SIEGES.NB_RESERVE), 20) AS DISPONIBLES
FROM
	SEGMENT
	INNER JOIN ENVOLEE
		ON ENVOLEE.ID_SEGMENT = SEGMENT.ID_SEGMENT
	INNER JOIN VOL
		ON VOL.ID_VOL = SEGMENT.ID_VOL
	INNER JOIN V_ENVOLEES_SIEGES
		ON V_ENVOLEES_SIEGES.ID_ENVOLEE = ENVOLEE.ID_ENVOLEE
WHERE
	ENVOLEE.DATE_ENVOLEE BETWEEN '2024-05-13' AND '2024-05-19'
GROUP BY
	ENVOLEE.DATE_ENVOLEE,
	VOL.NO_VOL
ORDER BY
	ENVOLEE.DATE_ENVOLEE, 
	VOL.NO_VOL

/*
DATE       VOL        DISPONIBLES
---------- ---------- --------------------
2024-05-13 1822       44
2024-05-13 1823       47
2024-05-13 1922       31
2024-05-13 1923       25
2024-05-14 1822       47
2024-05-14 1823       48
2024-05-14 1922       32
2024-05-14 1923       31
2024-05-15 1822       47
2024-05-15 1823       48
2024-05-15 1922       30
2024-05-15 1923       32
2024-05-16 1822       44
2024-05-16 1823       46
2024-05-16 1922       31
2024-05-16 1923       29
2024-05-17 1822       31
2024-05-17 1823       48
2024-05-17 1922       48
2024-05-17 1923       31
2024-05-18 1822       29
2024-05-18 1823       47
2024-05-18 1922       46
2024-05-18 1923       32
2024-05-19 1822       31
2024-05-19 1823       47
2024-05-19 1922       48
2024-05-19 1923       28

(28 rows affected)
*/

/*
Question C.3 10 points
• Produire la liste des passagers pour les vols de la période du 13 au 19 mai 2024. Cette liste
comporte les informations suivantes dans l'ordre:
- La date du vol, sous le format YYYY-MM-DD (DEPART),
- L’heure de départ, sous sous le format hh:mi (A),
- Le numéro du vol (VOL),
- Le nom, le prénom et l’identifiant du passager (PASSAGER),
- Le nom de la ville de l'aéroport initial de départ du passager (DE)
- Le nom de la ville de l'aéroport d’arrivée pour la destination finale du passager (A).
• Cette liste est triée par date des envolées, puis par vol, par segment initial (ordre du segment) et
par segment d’arrivée (ordre du segment), et finalement par nom, prénom et id des passagers.
*/

SELECT
	CAST(V_PASSAGERS_VOLS.DATE_ENVOLEE AS DATE) AS DEPART,
	CONVERT(VARCHAR(5), SEGMENT_DEPART.HEURE_DEPART, 108) AS A,
	VOL.NO_VOL AS VOL,
	CONCAT(V_PASSAGERS_VOLS.NOM, ', ', V_PASSAGERS_VOLS.PRENOM, ' (', V_PASSAGERS_VOLS.ID_PASSAGER, ')') AS PASSAGER,
	AEROPORT_DEPART.NOM_VILLE AS DE,
	AEROPORT_ARIVEE.NOM_VILLE AS A
FROM 
	V_PASSAGERS_VOLS
	INNER JOIN VOL
		ON V_PASSAGERS_VOLS.ID_VOL = VOL.ID_VOL
	INNER JOIN SEGMENT SEGMENT_DEPART
		ON SEGMENT_DEPART.ORDRE_SEGMENT = V_PASSAGERS_VOLS.ORDRE_SEG_DEPART 
			AND SEGMENT_DEPART.ID_VOL = V_PASSAGERS_VOLS.ID_VOL
	INNER JOIN SEGMENT SEGMENT_ARRIVEE
		ON SEGMENT_ARRIVEE.ORDRE_SEGMENT = V_PASSAGERS_VOLS.ORDRE_SEG_ARRIVEE 
			AND SEGMENT_ARRIVEE.ID_VOL = V_PASSAGERS_VOLS.ID_VOL
	INNER JOIN AEROPORT AEROPORT_DEPART
		ON AEROPORT_DEPART.ID_AEROPORT = SEGMENT_DEPART.AEROPORT_DEPART
	INNER JOIN AEROPORT AEROPORT_ARIVEE
		ON AEROPORT_ARIVEE.ID_AEROPORT = SEGMENT_ARRIVEE.AEROPORT_DESTINATION
WHERE
	V_PASSAGERS_VOLS.DATE_ENVOLEE BETWEEN '2024-05-13' AND '2024-05-19'
ORDER BY
	V_PASSAGERS_VOLS.DATE_ENVOLEE,
	VOL.NO_VOL,
	V_PASSAGERS_VOLS.ORDRE_SEG_DEPART,
	V_PASSAGERS_VOLS.ORDRE_SEG_ARRIVEE,
	V_PASSAGERS_VOLS.NOM,
	V_PASSAGERS_VOLS.PRENOM,
	V_PASSAGERS_VOLS.ID_PASSAGER
	