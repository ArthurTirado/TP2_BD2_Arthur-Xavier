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
	SEGMENT.HEURE_DEPART AS A,
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
VOL        DEPART               A                ARRIVEE              DUREE
---------- -------------------- ---------------- -------------------- ----------
1822       BAIE-COMEAU          07:00:00.0000000 SEPT-ILES            01:00
1923       BAIE-COMEAU          08:30:00.0000000 MONT-JOLI            00:45
1922       BAIE-COMEAU          18:30:00.0000000 SEPT-ILES            01:00
1823       BAIE-COMEAU          20:00:00.0000000 MONT-JOLI            00:45
1923       HAVRE SAINT-PIERRE   05:30:00.0000000 GASPE                00:40
1823       HAVRE SAINT-PIERRE   17:00:00.0000000 GASPE                00:40
1923       SEPT-ILES            07:30:00.0000000 BAIE-COMEAU          00:55
1822       SEPT-ILES            08:00:00.0000000 GASPE                00:30
1823       SEPT-ILES            19:00:00.0000000 BAIE-COMEAU          00:55
1922       SEPT-ILES            19:30:00.0000000 GASPE                00:30

(10 rows affected)
*/

/*
Question C.2 10 points
• Produire la liste des vols prévus pour la période du 13 au 19 mai 2023. Pour chacun, indiquer
dans l'ordre:
- La date du vol, sous le format YYYY-MM-DD (DATE),
- Le numéro du vol (VOL),
- Le nombre de sièges encore disponibles (non réservés) pour l'ensemble du vol (sur
tous les segments, du départ initial à la destination finale du vol) (DISPONIBLES).
• Cette liste est triée par date puis par vol.
*/

SELECT
	ENVOLEE.DATE_ENVOLEE AS DATE,
	VOL.NO_VOL AS VOL,
	(V_ENVOLEE_SIEGES.NB_SIEGES - V_ENVOLEE_SIEGES.NB_RESERVES) AS DISPONIBLES
FROM
	SEGMENT
	INNER JOIN VOL
		ON VOL.ID_VOL = SEGMENT.ID_VOL
	INNER JOIN ENVOLEE
		ON ENVOLEE.ID_SEGMENT = SEGMENT.ID_SEGMENT
	INNER JOIN V_ENVOLEE_SIEGES
		ON V_ENVOLEE_SIEGES.ID_ENVOLEE = ENVOLEE.ID_ENVOLEE
WHERE
	ENVOLEE.DATE_ENVOLEE BETWEEN '2024-05-13' AND '2024-05-19'
ORDER BY
	ENVOLEE.DATE_ENVOLEE, 
	VOL.NO_VOL