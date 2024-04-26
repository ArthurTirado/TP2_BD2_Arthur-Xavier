/* **********************************************************
	NordAir - Catalogue
	Schéma MRD:	"NordAir"
	Auteur:		Arthur Tirado et Xavier Breton-L'italien	
********************************************************** */

USE NORDAIR
GO

/*
Question D.1 7 points
• Produire la liste des tables (type ‘BASE TABLE’) qui ne sont pas des tables enfants.
• Indiquer dans l’ordre :
	- Le nom de la base de données (BD),
	- Le nom de la table (NOM_TABLE).
• Trier par le nom des tables.
• Utiliser au besoin des fonctions SQL pour améliorer l’affichage du résultat (ex : SUBSTR ou LEFT).
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
• Produire la liste de toutes les colonnes des clés étrangères (contraintes d’intégrité référentielle).
• Pour chaque colonne d’une clé étrangère, indiquer dans l’ordre :
	- Le nom de la table enfant (TABLE_ENFANT),
	- Le nom de la colonne (COLONNE_FK),
	- Le nom de la clé étrangère (CLE_ETRANGERE),
	- Le nom de la table parent référée (TABLE PARENT),
	- Le nom de la colonne référée (COLONNE_PK),
	- Le nom de la contrainte unique référée (CLE_PRIMAIRE)
• Trier par table enfant puis par clé étrangère et enfin par nom de la colonne de clé étrangère.
• La requête doit fonctionner dans le cas où des clés étrangères sont composées (comme dans la
base de données PROJET).
• Utiliser au besoin des fonctions SQL pour améliorer l’affichage du résultat (ex : SUBSTR ou LEFT).
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

SELECT
    LEFT(TABLE_CONSTRAINTS.TABLE_NAME, 25) AS TABLE_ENFANT,
    LEFT(COLUMNS.COLUMN_NAME, 25) AS COLONNE_FK,
    LEFT(TABLE_CONSTRAINTS.CONSTRAINT_NAME, 30) AS CLE_ETRANGERE,
    LEFT(PARENT.TABLE_NAME, 20) AS TABLE_PARENT,
    LEFT(PARENT.COLUMN_NAME, 20) AS COLONNE_PK,
    LEFT(REFERENTIAL_CONSTRAINTS.UNIQUE_CONSTRAINT_NAME, 20) AS CLE_PRIMAIRE
FROM 
    INFORMATION_SCHEMA.TABLE_CONSTRAINTS
	INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE
		ON KEY_COLUMN_USAGE.CONSTRAINT_NAME = TABLE_CONSTRAINTS.CONSTRAINT_NAME
	INNER JOIN INFORMATION_SCHEMA.COLUMNS 
		ON COLUMNS.COLUMN_NAME = KEY_COLUMN_USAGE.COLUMN_NAME
		AND COLUMNS.TABLE_NAME = KEY_COLUMN_USAGE.TABLE_NAME
	INNER JOIN INFORMATION_SCHEMA.REFERENTIAL_CONSTRAINTS 
		ON TABLE_CONSTRAINTS.CONSTRAINT_NAME = REFERENTIAL_CONSTRAINTS.CONSTRAINT_NAME
	INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE AS PARENT
		ON REFERENTIAL_CONSTRAINTS.UNIQUE_CONSTRAINT_NAME = PARENT.CONSTRAINT_NAME
WHERE 
    TABLE_CONSTRAINTS.CONSTRAINT_TYPE = 'FOREIGN KEY'
ORDER BY 
    TABLE_ENFANT,
    CLE_ETRANGERE,
    COLONNE_FK;

/*
TABLE_ENFANT              COLONNE_FK                CLE_ETRANGERE                  TABLE_PARENT         COLONNE_PK           CLE_PRIMAIRE
------------------------- ------------------------- ------------------------------ -------------------- -------------------- --------------------
ENVOLEE                   ID_AVION                  FK_ENVOL_AVION                 AVION                ID_AVION             PK_AVION
ENVOLEE                   ID_PILOTE                 FK_ENVOL_PILOTE                PILOTE               ID_PILOTE            PK_PILOTE
ENVOLEE                   ID_SEGMENT                FK_ENVOL_SEGMENT               SEGMENT              ID_SEGMENT           PK_SEGMENT
RESERVATION               ID_PASSAGER               FK_RES_PASSAGER                PASSAGER             ID_PASSAGER          PK_PASSAGER
RESERVATION_ENVOLEE       ID_ENVOLEE                FK_RES_ENV_ENVOLEE             ENVOLEE              ID_ENVOLEE           PK_ENVOLEE
RESERVATION_ENVOLEE       ID_RESERVATION            FK_RES_ENV_RESERVATION         RESERVATION          ID_RESERVATION       PK_RESERVATION
SEGMENT                   AEROPORT_DEPART           FK_SEG_AEROPORT_DEPART         AEROPORT             ID_AEROPORT          PK_AEROPORT
SEGMENT                   AEROPORT_DESTINATION      FK_SEG_AEROPORT_DESTI          AEROPORT             ID_AEROPORT          PK_AEROPORT
SEGMENT                   ID_VOL                    FK_SEG_VOL                     VOL                  ID_VOL               PK_VOL

(9 rows affected)
*/

SELECT CONSTRAINT_TYPE, TABLE_CONSTRAINTS.TABLE_NAME, COLUMNS.COLUMN_NAME
	FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS 
	INNER JOIN INFORMATION_SCHEMA.KEY_COLUMN_USAGE
		ON KEY_COLUMN_USAGE.CONSTRAINT_NAME = TABLE_CONSTRAINTS.CONSTRAINT_NAME
	INNER JOIN INFORMATION_SCHEMA.COLUMNS 
		ON COLUMNS.COLUMN_NAME = KEY_COLUMN_USAGE.COLUMN_NAME
		AND COLUMNS.TABLE_NAME = KEY_COLUMN_USAGE.TABLE_NAME
	ORDER BY COLUMNS.COLUMN_NAME