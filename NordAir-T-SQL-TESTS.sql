USE NORDAIR
GO

/* Copiez et insérez sous procédures/fonctions/triggers
   les requêtes de tests dans les scripts correspondants de T-SQL */

/* ********************************************************************************
	SCRIPT NordAir T-SQL E1 - Les fonctions
   ******************************************************************************** */
/* Exécutez les requêtes de tests et inclure le résultat affiché lors des SELECT */

/*  Question E1-A */
/* ============== */
SELECT dbo.MINUTES_EN_HEURES(0)   AS DUREE0,
	   dbo.MINUTES_EN_HEURES(30)  AS DUREE1,
	   dbo.MINUTES_EN_HEURES(90)  AS DUREE2
/* Résultat ici */

/*
DUREE0                                  DUREE1                                  DUREE2
--------------------------------------- --------------------------------------- ---------------------------------------
0.000                                   0.500                                   1.500

(1 row affected)
*/

SELECT dbo.MINUTES_EN_HEURES(95)   AS DUREE3,
	   dbo.MINUTES_EN_HEURES(710)  AS DUREE4,
	   dbo.MINUTES_EN_HEURES(1420) AS DUREE5
/* Résultat ici */
/*
DUREE3                                  DUREE4                                  DUREE5
--------------------------------------- --------------------------------------- ---------------------------------------
1.583                                   11.833                                  23.667

(1 row affected)
*/

SELECT dbo.MINUTES_EN_HEURES(119)  AS DUREE6,
	   dbo.MINUTES_EN_HEURES(180)  AS DUREE7,
	   dbo.MINUTES_EN_HEURES(181)  AS DUREE8  
/* Résultat ici */
/*
DUREE6                                  DUREE7                                  DUREE8
--------------------------------------- --------------------------------------- ---------------------------------------
1.983                                   3.000                                   3.017

(1 row affected)
*/

SELECT	dbo.MINUTES_EN_HEURES(2160)  AS DUREE9,
		dbo.MINUTES_EN_HEURES(5899)  AS DUREE10, 
		dbo.MINUTES_EN_HEURES(12350) AS DUREE11   
/* Résultat ici */
/*
DUREE9                                  DUREE10                                 DUREE11
--------------------------------------- --------------------------------------- ---------------------------------------
36.000                                  98.317                                  205.833

(1 row affected)
*/

/*  Question E1-B */
/* ============== */
-- Test 1
SELECT dbo.MINUTES_VOL_PILOTE(34, '2024-05-13', '2024-05-20') AS NB_MINUTES_VOL
/* Résultat ici */
/*
NB_MINUTES_VOL
--------------
1420

(1 row affected)
*/

-- Test 2
SELECT dbo.MINUTES_VOL_PILOTE(99, '2024-05-13', '2024-05-20') AS NB_MINUTES_VOL
/* Résultat ici */
/*
NB_MINUTES_VOL
--------------
NULL

(1 row affected)
*/
-- Test 3
SELECT dbo.MINUTES_VOL_PILOTE(34, '2024-03-01', '2024-03-05') AS NB_MINUTES_VOL
/* Résultat ici */
/*
NB_MINUTES_VOL
--------------
0

(1 row affected)
*/

-- Test 4
SELECT
	NO_PILOTE,
	NOM,
	PRENOM,
	LEFT(dbo.MINUTES_VOL_PILOTE(NO_PILOTE, '2024-05-15', '2024-05-17'), 5) AS NB_MINUTES_VOL
FROM
	PILOTE
/* Résultat ici */
/*
NO_PILOTE                               NOM             PRENOM          NB_MINUTES_VOL
--------------------------------------- --------------- --------------- --------------
22                                      LAVIGNE         ROGER           710
34                                      LATRIMOUILLE    ANDRE           355
55                                      LAVERTU         MARIE           710
61                                      GENEST          CLAUDINE        355

(4 rows affected)
*/

/*  Question E1-C */
/* ============== */
-- Test 1
SELECT dbo.HEURES_VOL_PILOTE(34, '2024-05-13', '2024-05-20') AS NB_HEURES_VOL
/* Résultat ici */
/*
NB_HEURES_VOL
---------------------------------------
23.667

(1 row affected)
*/
-- Test 2
SELECT dbo.HEURES_VOL_PILOTE(99, '2024-05-13', '2024-05-20') AS NB_HEURES_VOL
/* Résultat ici */
/*
NB_HEURES_VOL
---------------------------------------
NULL

(1 row affected)
*/

-- Test 3
SELECT dbo.HEURES_VOL_PILOTE(34, '2024-03-01', '2024-03-05') AS NB_HEURES_VOL
/* Résultat ici */
/*
NB_HEURES_VOL
---------------------------------------
0.000

(1 row affected)
*/

-- Test 4
SELECT
	NO_PILOTE,
	NOM,
	PRENOM,
	LEFT(dbo.HEURES_VOL_PILOTE(NO_PILOTE, '2024-05-15', '2024-05-17'), 5) AS NB_HEURES_VOL
FROM
	PILOTE
/* Résultat ici */
/*
NO_PILOTE                               NOM             PRENOM          NB_HEURES_VOL
--------------------------------------- --------------- --------------- -------------
22                                      LAVIGNE         ROGER           11.83
34                                      LATRIMOUILLE    ANDRE           5.917
55                                      LAVERTU         MARIE           11.83
61                                      GENEST          CLAUDINE        5.917

(4 rows affected)
*/

/* ********************************************************************************
	SCRIPT NordAir T-SQL E2 - Le trigger
   ******************************************************************************** */
/* Pour chaque cas de test, inclure seulement le résultat des 3 derniers SELECT après l'ordre UPDATE
   Les 2 premiers SELECT de chaque test sont présents pour vous aider à faire votre assurance qualité */

BEGIN TRANSACTION

-- Test 1
SELECT * FROM RESERVATION WHERE ID_RESERVATION IN (1,2,5)
SELECT * FROM RESERVATION_ENVOLEE WHERE ID_RESERVATION IN (1,2,5)

UPDATE	RESERVATION
SET		ANNULEE = 'true'
WHERE	ID_RESERVATION = 5

SELECT * FROM RESERVATION WHERE ID_RESERVATION IN (1,2,5)
SELECT * FROM RESERVATION_ENVOLEE WHERE ID_RESERVATION IN (1,2,5)
SELECT
	LEFT(ID_RESERVATION, 4)			AS ID_RESERVATION,
	CONVERT(DATE, DATE_RESERVATION) AS DATE_RESERVATION,
	CONVERT(DATE, DATE_ANNULATION)  AS  DATE_ANNULATION,
	ANNULEE_PAR_USER,
	LEFT(ID_PASSAGER, 5)			AS ID_PASSAGER,
	LEFT(LISTE_ENVOLEES, 30)		AS LISTE_ENVOLEES
FROM AUDIT_ANNULATION_RESERVATION
/* Résultat des 3 derniers SELECT ici */

/*
RESERVATION

ID_RESERVATION                          DATE_RESERVATION        ID_PASSAGER                             ANNULEE
--------------------------------------- ----------------------- --------------------------------------- -------
1                                       2024-04-13 00:00:00.000 1                                       0
2                                       2024-04-18 00:00:00.000 2                                       0
5                                       2024-04-20 00:00:00.000 5                                       1

(3 rows affected)
*/

/*
RESERVATION_ENVOLEE

ID_RESERV_ENVOLEE                       ID_RESERVATION                          ID_ENVOLEE                              CODE_SIEGE
--------------------------------------- --------------------------------------- --------------------------------------- ----------
1                                       1                                       1                                       01A
2                                       2                                       1                                       02B
3                                       2                                       8                                       03C
7                                       5                                       1                                       07A
8                                       5                                       2                                       07A
9                                       5                                       3                                       07A
10                                      5                                       4                                       07A
11                                      5                                       61                                      04C
12                                      5                                       62                                      04C
13                                      5                                       63                                      04C
14                                      5                                       80                                      04D

(11 rows affected)
*/

/*
AUDIT_ANNULATION_RESERVATION

ID_RESERVATION DATE_RESERVATION DATE_ANNULATION ANNULEE_PAR_USER               ID_PASSAGER LISTE_ENVOLEES
-------------- ---------------- --------------- ------------------------------ ----------- ------------------------------
5              2024-04-20       2024-05-03      DESKTOP-RSKQ5V3\xavto          5           1-2-3-4-61-62-63-80

(1 row affected)
*/

-- Test 2
SELECT * FROM RESERVATION WHERE ID_RESERVATION IN (1,2,5)
SELECT * FROM RESERVATION_ENVOLEE WHERE ID_RESERVATION IN (1,2,5)

UPDATE	RESERVATION
SET		ANNULEE = 'true'
WHERE	ID_RESERVATION = 5

SELECT * FROM RESERVATION WHERE ID_RESERVATION IN (1,2,5)
SELECT * FROM RESERVATION_ENVOLEE WHERE ID_RESERVATION IN (1,2,5)
SELECT
	LEFT(ID_RESERVATION, 4)			AS ID_RESERVATION,
	CONVERT(DATE, DATE_RESERVATION) AS DATE_RESERVATION,
	CONVERT(DATE, DATE_ANNULATION)  AS  DATE_ANNULATION,
	ANNULEE_PAR_USER,
	LEFT(ID_PASSAGER, 5)			AS ID_PASSAGER,
	LEFT(LISTE_ENVOLEES, 30)		AS LISTE_ENVOLEES
FROM AUDIT_ANNULATION_RESERVATION
/* Résultat des 3 derniers SELECT ici */

/*
RESERVATION

ID_RESERVATION                          DATE_RESERVATION        ID_PASSAGER                             ANNULEE
--------------------------------------- ----------------------- --------------------------------------- -------
1                                       2024-04-13 00:00:00.000 1                                       0
2                                       2024-04-18 00:00:00.000 2                                       0
5                                       2024-04-20 00:00:00.000 5                                       1

(3 rows affected)
*/

/*
RESERVATION_ENVOLEE

ID_RESERV_ENVOLEE                       ID_RESERVATION                          ID_ENVOLEE                              CODE_SIEGE
--------------------------------------- --------------------------------------- --------------------------------------- ----------
1                                       1                                       1                                       01A
2                                       2                                       1                                       02B
3                                       2                                       8                                       03C
7                                       5                                       1                                       07A
8                                       5                                       2                                       07A
9                                       5                                       3                                       07A
10                                      5                                       4                                       07A
11                                      5                                       61                                      04C
12                                      5                                       62                                      04C
13                                      5                                       63                                      04C
14                                      5                                       80                                      04D

(11 rows affected)
*/

/*
AUDIT_ANNULATION_RESERVATION

ID_RESERVATION DATE_RESERVATION DATE_ANNULATION ANNULEE_PAR_USER               ID_PASSAGER LISTE_ENVOLEES
-------------- ---------------- --------------- ------------------------------ ----------- ------------------------------
5              2024-04-20       2024-05-03      DESKTOP-RSKQ5V3\xavto          5           1-2-3-4-61-62-63-80
5              2024-04-20       2024-05-03      DESKTOP-RSKQ5V3\xavto          5           1-2-3-4-61-62-63-80

(2 rows affected)
*/

-- Test 3
SELECT * FROM RESERVATION WHERE ID_RESERVATION IN (1,2,5,7)
SELECT * FROM RESERVATION_ENVOLEE WHERE ID_RESERVATION IN (1,2,5,7)

UPDATE	RESERVATION
SET		ANNULEE = 'true'
WHERE	ID_RESERVATION = 7

SELECT * FROM RESERVATION WHERE ID_RESERVATION IN (1,2,5,7)
SELECT * FROM RESERVATION_ENVOLEE WHERE ID_RESERVATION IN (1,2,5,7)
SELECT
	LEFT(ID_RESERVATION, 4)			AS ID_RESERVATION,
	CONVERT(DATE, DATE_RESERVATION) AS DATE_RESERVATION,
	CONVERT(DATE, DATE_ANNULATION)  AS  DATE_ANNULATION,
	ANNULEE_PAR_USER,
	LEFT(ID_PASSAGER, 5)			AS ID_PASSAGER,
	LEFT(LISTE_ENVOLEES, 30)		AS LISTE_ENVOLEES
FROM AUDIT_ANNULATION_RESERVATION
/* Résultat des 3 derniers SELECT ici */
/*
RESERVATION

ID_RESERVATION                          DATE_RESERVATION        ID_PASSAGER                             ANNULEE
--------------------------------------- ----------------------- --------------------------------------- -------
1                                       2024-04-13 00:00:00.000 1                                       0
2                                       2024-04-18 00:00:00.000 2                                       0
5                                       2024-04-20 00:00:00.000 5                                       1
7                                       2024-05-01 00:00:00.000 7                                       1

(4 rows affected)
*/

/*
RESERVATION_ENVOLEE

ID_RESERV_ENVOLEE                       ID_RESERVATION                          ID_ENVOLEE                              CODE_SIEGE
--------------------------------------- --------------------------------------- --------------------------------------- ----------
1                                       1                                       1                                       01A
2                                       2                                       1                                       02B
3                                       2                                       8                                       03C
7                                       5                                       1                                       07A
8                                       5                                       2                                       07A
9                                       5                                       3                                       07A
10                                      5                                       4                                       07A
11                                      5                                       61                                      04C
12                                      5                                       62                                      04C
13                                      5                                       63                                      04C
14                                      5                                       80                                      04D
16                                      7                                       61                                      08A
17                                      7                                       52                                      03A

(13 rows affected)
*/

/*
AUDIT_ANNULATION_RESERVATION

ID_RESERVATION DATE_RESERVATION DATE_ANNULATION ANNULEE_PAR_USER               ID_PASSAGER LISTE_ENVOLEES
-------------- ---------------- --------------- ------------------------------ ----------- ------------------------------
5              2024-04-20       2024-05-03      DESKTOP-RSKQ5V3\xavto          5           1-2-3-4-61-62-63-80
5              2024-04-20       2024-05-03      DESKTOP-RSKQ5V3\xavto          5           1-2-3-4-61-62-63-80
7              2024-05-01       2024-05-03      DESKTOP-RSKQ5V3\xavto          7           52-61
7              2024-05-01       2024-05-03      DESKTOP-RSKQ5V3\xavto          7           52-61

(4 rows affected)
*/

-- Test 4
SELECT * FROM RESERVATION WHERE ID_RESERVATION IN (1,2,5,7)
SELECT * FROM RESERVATION_ENVOLEE WHERE ID_RESERVATION IN (1,2,5,7)

UPDATE	RESERVATION
SET		DATE_RESERVATION = GETDATE()
WHERE	ID_RESERVATION = 1

SELECT * FROM RESERVATION WHERE ID_RESERVATION IN (1,2,5,7)
SELECT * FROM RESERVATION_ENVOLEE WHERE ID_RESERVATION IN (1,2,5,7)
SELECT
	LEFT(ID_RESERVATION, 4)			AS ID_RESERVATION,
	CONVERT(DATE, DATE_RESERVATION) AS DATE_RESERVATION,
	CONVERT(DATE, DATE_ANNULATION)  AS  DATE_ANNULATION,
	ANNULEE_PAR_USER,
	LEFT(ID_PASSAGER, 5)			AS ID_PASSAGER,
	LEFT(LISTE_ENVOLEES, 30)		AS LISTE_ENVOLEES
FROM AUDIT_ANNULATION_RESERVATION
/* Résultat des 3 derniers SELECT ici */

/*
RESERVATION

ID_RESERVATION                          DATE_RESERVATION        ID_PASSAGER                             ANNULEE
--------------------------------------- ----------------------- --------------------------------------- -------
1                                       2024-05-03 22:55:44.767 1                                       0
2                                       2024-04-18 00:00:00.000 2                                       0
5                                       2024-04-20 00:00:00.000 5                                       1
7                                       2024-05-01 00:00:00.000 7                                       1

(4 rows affected)
*/

/*
RESERVATION_ENVOLEE

ID_RESERV_ENVOLEE                       ID_RESERVATION                          ID_ENVOLEE                              CODE_SIEGE
--------------------------------------- --------------------------------------- --------------------------------------- ----------
1                                       1                                       1                                       01A
2                                       2                                       1                                       02B
3                                       2                                       8                                       03C
7                                       5                                       1                                       07A
8                                       5                                       2                                       07A
9                                       5                                       3                                       07A
10                                      5                                       4                                       07A
11                                      5                                       61                                      04C
12                                      5                                       62                                      04C
13                                      5                                       63                                      04C
14                                      5                                       80                                      04D
16                                      7                                       61                                      08A
17                                      7                                       52                                      03A

(13 rows affected)
*/

/*
AUDIT_ANNULATION_RESERVATION

ID_RESERVATION DATE_RESERVATION DATE_ANNULATION ANNULEE_PAR_USER               ID_PASSAGER LISTE_ENVOLEES
-------------- ---------------- --------------- ------------------------------ ----------- ------------------------------
5              2024-04-20       2024-05-03      DESKTOP-RSKQ5V3\xavto          5           1-2-3-4-61-62-63-80
5              2024-04-20       2024-05-03      DESKTOP-RSKQ5V3\xavto          5           1-2-3-4-61-62-63-80
7              2024-05-01       2024-05-03      DESKTOP-RSKQ5V3\xavto          7           52-61
7              2024-05-01       2024-05-03      DESKTOP-RSKQ5V3\xavto          7           52-61

(4 rows affected)
*/

-- Test 5
SELECT * FROM RESERVATION WHERE ID_RESERVATION IN (1,2,5,7)
SELECT * FROM RESERVATION_ENVOLEE WHERE ID_RESERVATION IN (1,2,5,7)

UPDATE	RESERVATION
SET		ANNULEE = 'true'
WHERE	ID_RESERVATION = 1

SELECT * FROM RESERVATION WHERE ID_RESERVATION IN (1,2,5,7)
SELECT * FROM RESERVATION_ENVOLEE WHERE ID_RESERVATION IN (1,2,5,7)
SELECT
	LEFT(ID_RESERVATION, 4)			AS ID_RESERVATION,
	CONVERT(DATE, DATE_RESERVATION) AS DATE_RESERVATION,
	CONVERT(DATE, DATE_ANNULATION)  AS  DATE_ANNULATION,
	ANNULEE_PAR_USER,
	LEFT(ID_PASSAGER, 5)			AS ID_PASSAGER,
	LEFT(LISTE_ENVOLEES, 30)		AS LISTE_ENVOLEES
FROM AUDIT_ANNULATION_RESERVATION
/* Résultat des 3 derniers SELECT ici */

/*
RESERVATION

ID_RESERVATION                          DATE_RESERVATION        ID_PASSAGER                             ANNULEE
--------------------------------------- ----------------------- --------------------------------------- -------
1                                       2024-05-03 22:55:44.767 1                                       1
2                                       2024-04-18 00:00:00.000 2                                       0
5                                       2024-04-20 00:00:00.000 5                                       1
7                                       2024-05-01 00:00:00.000 7                                       1

(4 rows affected)
*/

/*
RESERVATION_ENVOLEE

ID_RESERV_ENVOLEE                       ID_RESERVATION                          ID_ENVOLEE                              CODE_SIEGE
--------------------------------------- --------------------------------------- --------------------------------------- ----------
1                                       1                                       1                                       01A
2                                       2                                       1                                       02B
3                                       2                                       8                                       03C
7                                       5                                       1                                       07A
8                                       5                                       2                                       07A
9                                       5                                       3                                       07A
10                                      5                                       4                                       07A
11                                      5                                       61                                      04C
12                                      5                                       62                                      04C
13                                      5                                       63                                      04C
14                                      5                                       80                                      04D
16                                      7                                       61                                      08A
17                                      7                                       52                                      03A

(13 rows affected)
*/

/*
AUDIT_ANNULATION_RESERVATION

ID_RESERVATION DATE_RESERVATION DATE_ANNULATION ANNULEE_PAR_USER               ID_PASSAGER LISTE_ENVOLEES
-------------- ---------------- --------------- ------------------------------ ----------- ------------------------------
5              2024-04-20       2024-05-03      DESKTOP-RSKQ5V3\xavto          5           1-2-3-4-61-62-63-80
5              2024-04-20       2024-05-03      DESKTOP-RSKQ5V3\xavto          5           1-2-3-4-61-62-63-80
7              2024-05-01       2024-05-03      DESKTOP-RSKQ5V3\xavto          7           52-61
7              2024-05-01       2024-05-03      DESKTOP-RSKQ5V3\xavto          7           52-61
1              2024-05-03       2024-05-03      DESKTOP-RSKQ5V3\xavto          1           1

(5 rows affected)
*/

-- Test 6
SELECT * FROM RESERVATION WHERE ID_RESERVATION IN (1,2,5,7)
SELECT * FROM RESERVATION_ENVOLEE WHERE ID_RESERVATION IN (1,2,5,7)

UPDATE	RESERVATION
SET		ANNULEE = 'false'
WHERE	ID_RESERVATION = 2

SELECT * FROM RESERVATION WHERE ID_RESERVATION IN (1,2,5,7)
SELECT * FROM RESERVATION_ENVOLEE WHERE ID_RESERVATION IN (1,2,5,7)
SELECT
	LEFT(ID_RESERVATION, 4)			AS ID_RESERVATION,
	CONVERT(DATE, DATE_RESERVATION) AS DATE_RESERVATION,
	CONVERT(DATE, DATE_ANNULATION)  AS  DATE_ANNULATION,
	ANNULEE_PAR_USER,
	LEFT(ID_PASSAGER, 5)			AS ID_PASSAGER,
	LEFT(LISTE_ENVOLEES, 30)		AS LISTE_ENVOLEES
FROM AUDIT_ANNULATION_RESERVATION
/* Résultat des 3 derniers SELECT ici */
/*
RESERVATION

ID_RESERVATION                          DATE_RESERVATION        ID_PASSAGER                             ANNULEE
--------------------------------------- ----------------------- --------------------------------------- -------
1                                       2024-05-03 22:55:44.767 1                                       1
2                                       2024-04-18 00:00:00.000 2                                       0
5                                       2024-04-20 00:00:00.000 5                                       1
7                                       2024-05-01 00:00:00.000 7                                       1

(4 rows affected)
*/

/*
RESERVATION_ENVOLEE

ID_RESERV_ENVOLEE                       ID_RESERVATION                          ID_ENVOLEE                              CODE_SIEGE
--------------------------------------- --------------------------------------- --------------------------------------- ----------
1                                       1                                       1                                       01A
2                                       2                                       1                                       02B
3                                       2                                       8                                       03C
7                                       5                                       1                                       07A
8                                       5                                       2                                       07A
9                                       5                                       3                                       07A
10                                      5                                       4                                       07A
11                                      5                                       61                                      04C
12                                      5                                       62                                      04C
13                                      5                                       63                                      04C
14                                      5                                       80                                      04D
16                                      7                                       61                                      08A
17                                      7                                       52                                      03A

(13 rows affected)
*/

/*
AUDIT_ANNULATION_RESERVATION

ID_RESERVATION DATE_RESERVATION DATE_ANNULATION ANNULEE_PAR_USER               ID_PASSAGER LISTE_ENVOLEES
-------------- ---------------- --------------- ------------------------------ ----------- ------------------------------
5              2024-04-20       2024-05-03      DESKTOP-RSKQ5V3\xavto          5           1-2-3-4-61-62-63-80
5              2024-04-20       2024-05-03      DESKTOP-RSKQ5V3\xavto          5           1-2-3-4-61-62-63-80
7              2024-05-01       2024-05-03      DESKTOP-RSKQ5V3\xavto          7           52-61
7              2024-05-01       2024-05-03      DESKTOP-RSKQ5V3\xavto          7           52-61
1              2024-05-03       2024-05-03      DESKTOP-RSKQ5V3\xavto          1           1
2              2024-04-18       2024-05-03      DESKTOP-RSKQ5V3\xavto          2           1-8

(6 rows affected)
*/

ROLLBACK

/* ********************************************************************************
	SCRIPT NordAir T-SQL E3 - La procédure
   ******************************************************************************** */
/* Pour chaque test:
   - Après un SELECT: inclure le résultat obtenu seulement si des lignes sont ramenées par le SELECT
   - Après un EX	ECUTE: inclure le message obtenu seulement si c'est un message d'erreur
   Par exemple:
	SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-06-16' AND '2024-06-17'
	/* Inclure résultat si des lignes affichées */
	EXECUTE PLANIFIER_VOLS 1823, 55, 'CADM', '2024-06-16', '2024-06-17'
	/* Inclure message si message d'erreur */
	SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-06-16' AND '2024-06-17'
	/* Inclure résultat si des lignes affichées */
*/
BEGIN TRANSACTION

-- Test 1

SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-06-16' AND '2024-06-17'
EXECUTE PLANIFIER_VOLS 1823, 55, 'CADM', '2024-06-16', '2024-06-17'
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-06-16' AND '2024-06-17'
/*
ID_ENVOLEE                              DATE_ENVOLEE            ID_SEGMENT                              ID_AVION                                ID_PILOTE
--------------------------------------- ----------------------- --------------------------------------- --------------------------------------- ---------------------------------------
359                                     2024-06-16 00:00:00.000 5                                       1                                       3
360                                     2024-06-16 00:00:00.000 6                                       1                                       3
361                                     2024-06-16 00:00:00.000 7                                       1                                       3
362                                     2024-06-16 00:00:00.000 8                                       1                                       3
363                                     2024-06-17 00:00:00.000 5                                       1                                       3
364                                     2024-06-17 00:00:00.000 6                                       1                                       3
365                                     2024-06-17 00:00:00.000 7                                       1                                       3
366                                     2024-06-17 00:00:00.000 8                                       1                                       3

(8 rows affected)
*/

-- Test 2
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-09-01' AND '2024-09-05'
EXECUTE PLANIFIER_VOLS 1733, 22, 'COPA', '2024-09-01', '2024-09-05'
/*
Msg 50000, Level 11, State 1, Procedure PLANIFIER_VOLS, Line 25 [Batch Start Line 339]
Numéro de vol non trouvé
*/
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-09-01' AND '2024-09-05'

-- Test 3
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-09-01' AND '2024-09-05'
EXECUTE PLANIFIER_VOLS 1923, 55, 'TOTO', '2024-09-01', '2024-09-05'
/*
Msg 50000, Level 11, State 1, Procedure PLANIFIER_VOLS, Line 33 [Batch Start Line 346]
Code de l`avion non trouvé
*/
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-09-01' AND '2024-09-05'

-- Test 4
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-07-01' AND '2024-07-01'
EXECUTE PLANIFIER_VOLS 1822, 55, 'CADM', '2024-07-01', '2024-07-01'
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-07-01' AND '2024-07-01'
/*
ID_ENVOLEE                              DATE_ENVOLEE            ID_SEGMENT                              ID_AVION                                ID_PILOTE
--------------------------------------- ----------------------- --------------------------------------- --------------------------------------- ---------------------------------------
367                                     2024-07-01 00:00:00.000 1                                       1                                       3
368                                     2024-07-01 00:00:00.000 2                                       1                                       3
369                                     2024-07-01 00:00:00.000 3                                       1                                       3
370                                     2024-07-01 00:00:00.000 4                                       1                                       3

(4 rows affected)
*/

-- Test 5
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-09-01' AND '2024-09-05'
EXECUTE PLANIFIER_VOLS 1923, 99, 'COPA', '2024-09-01', '2024-09-05'
/*
Msg 50000, Level 11, State 1, Procedure PLANIFIER_VOLS, Line 29 [Batch Start Line 368]
Numéro de pilote non trouvé
*/
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-09-01' AND '2024-09-05'

-- Test 6
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-06-01' AND '2024-06-05'
EXECUTE PLANIFIER_VOLS 1923, 22, 'COPA', '2024-06-01', '2024-06-05'
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-06-01' AND '2024-06-05'
/*
ID_ENVOLEE                              DATE_ENVOLEE            ID_SEGMENT                              ID_AVION                                ID_PILOTE
--------------------------------------- ----------------------- --------------------------------------- --------------------------------------- ---------------------------------------
374                                     2024-06-01 00:00:00.000 13                                      2                                       1
375                                     2024-06-01 00:00:00.000 14                                      2                                       1
376                                     2024-06-01 00:00:00.000 15                                      2                                       1
377                                     2024-06-01 00:00:00.000 16                                      2                                       1
378                                     2024-06-05 00:00:00.000 13                                      2                                       1
379                                     2024-06-05 00:00:00.000 14                                      2                                       1
380                                     2024-06-05 00:00:00.000 15                                      2                                       1
381                                     2024-06-05 00:00:00.000 16                                      2                                       1

(8 rows affected)
*/

-- Test 7
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-09-05' AND '2024-09-01'
EXECUTE PLANIFIER_VOLS 1923, 61, 'CADM', '2024-06-05', '2024-06-01'
/*
Msg 50000, Level 11, State 1, Procedure PLANIFIER_VOLS, Line 37 [Batch Start Line 397]
Date de fin avant celle de début
*/
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-09-05' AND '2024-09-01'

ROLLBACK