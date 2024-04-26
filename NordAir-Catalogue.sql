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