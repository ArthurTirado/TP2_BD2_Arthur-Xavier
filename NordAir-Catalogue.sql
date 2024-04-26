/* **********************************************************
	NordAir - Catalogue
	Sch�ma MRD:	"NordAir"
	Auteur:		Arthur Tirado et Xavier Breton-L'italien	
********************************************************** */

USE NORDAIR
GO

/*
Question D.1 7 points
� Produire la liste des tables (type �BASE TABLE�) qui ne sont pas des tables enfants.
� Indiquer dans l�ordre :
	- Le nom de la base de donn�es (BD),
	- Le nom de la table (NOM_TABLE).
� Trier par le nom des tables.
� Utiliser au besoin des fonctions SQL pour am�liorer l�affichage du r�sultat (ex : SUBSTR ou LEFT).
*/

SELECT
	LEFT(DB_NAME(), 20) AS BD,
	LEFT(INFORMATION_SCHEMA.TABLES.TABLE_NAME, 20) AS NOM_TABLE
FROM
	INFORMATION_SCHEMA.TABLES
WHERE
	NOT EXISTS
		(SELECT
			*
		FROM
			INFORMATION_SCHEMA.TABLE_CONSTRAINTS
		WHERE
			INFORMATION_SCHEMA.TABLE_CONSTRAINTS.CONSTRAINT_TYPE = 'FOREIGN KEY'
			AND INFORMATION_SCHEMA.TABLE_CONSTRAINTS.TABLE_NAME = INFORMATION_SCHEMA.TABLES.TABLE_NAME)
ORDER BY
	INFORMATION_SCHEMA.TABLES.TABLE_NAME

/*
BD                   NOM_TABLE
-------------------- --------------------
NORDAIR              AEROPORT
NORDAIR              AVION
NORDAIR              PASSAGER
NORDAIR              PILOTE
NORDAIR              V_ENVOLEES_SIEGES
NORDAIR              V_PASSAGERS_VOLS
NORDAIR              VOL

(7 rows affected)
*/

/*
Question D.2 9 points
� Produire la liste de toutes les colonnes des cl�s �trang�res (contraintes d�int�grit� r�f�rentielle).
� Pour chaque colonne d�une cl� �trang�re, indiquer dans l�ordre :
	- Le nom de la table enfant (TABLE_ENFANT),
	- Le nom de la colonne (COLONNE_FK),
	- Le nom de la cl� �trang�re (CLE_ETRANGERE),
	- Le nom de la table parent r�f�r�e (TABLE PARENT),
	- Le nom de la colonne r�f�r�e (COLONNE_PK),
	- Le nom de la contrainte unique r�f�r�e (CLE_PRIMAIRE)
� Trier par table enfant puis par cl� �trang�re et enfin par nom de la colonne de cl� �trang�re.
� La requ�te doit fonctionner dans le cas o� des cl�s �trang�res sont compos�es (comme dans la
base de donn�es PROJET).
� Utiliser au besoin des fonctions SQL pour am�liorer l�affichage du r�sultat (ex : SUBSTR ou LEFT).
*/

SELECT DISTINCT
	INFORMATION_SCHEMA.TABLE_CONSTRAINTS.TABLE_NAME AS TABLE_ENFANT,
	INFORMATION_SCHEMA.COLUMNS.COLUMN_NAME AS COLONNE_FK,
	INFORMATION_SCHEMA.TABLE_CONSTRAINTS.CONSTRAINT_TYPE AS CLE_ETRANGERE
FROM
	INFORMATION_SCHEMA.TABLE_CONSTRAINTS
	INNER JOIN INFORMATION_SCHEMA.COLUMNS
		ON INFORMATION_SCHEMA.TABLE_CONSTRAINTS.TABLE_NAME = INFORMATION_SCHEMA.COLUMNS.TABLE_NAME
WHERE
	INFORMATION_SCHEMA.TABLE_CONSTRAINTS.CONSTRAINT_TYPE = 'FOREIGN KEY'
ORDER BY
	TABLE_ENFANT,
	CLE_ETRANGERE,
	COLONNE_FK