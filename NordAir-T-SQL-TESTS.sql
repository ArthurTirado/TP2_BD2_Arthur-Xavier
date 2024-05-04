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

-- Test 2
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-09-01' AND '2024-09-05'
EXECUTE PLANIFIER_VOLS 1733, 22, 'COPA', '2024-09-01', '2024-09-05'
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-09-01' AND '2024-09-05'

-- Test 3
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-09-01' AND '2024-09-05'
EXECUTE PLANIFIER_VOLS 1923, 55, 'TOTO', '2024-09-01', '2024-09-05'
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-09-01' AND '2024-09-05'

-- Test 4
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-07-01' AND '2024-07-01'
EXECUTE PLANIFIER_VOLS 1822, 55, 'CADM', '2024-07-01', '2024-07-01'
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-07-01' AND '2024-07-01'

-- Test 5
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-09-01' AND '2024-09-05'
EXECUTE PLANIFIER_VOLS 1923, 99, 'COPA', '2024-09-01', '2024-09-05'
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-09-01' AND '2024-09-05'

-- Test 6
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-06-01' AND '2024-06-05'
EXECUTE PLANIFIER_VOLS 1923, 22, 'COPA', '2024-06-01', '2024-06-05'
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-06-01' AND '2024-06-05'

-- Test 7
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-09-05' AND '2024-09-01'
EXECUTE PLANIFIER_VOLS 1923, 61, 'CADM', '2024-06-05', '2024-06-01'
SELECT * FROM ENVOLEE WHERE DATE_ENVOLEE BETWEEN '2024-09-05' AND '2024-09-01'

ROLLBACK