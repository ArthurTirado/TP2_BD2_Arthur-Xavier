/* **********************************************************
	NordAir - Transact SQL E2
	Sch�ma MRD:	"NordAir"
	Auteur:		Arthur Tirado et Xavier Breton-L'italien	
********************************************************** */
USE NORDAIR
GO
-- Question E.2
/*
Cr�er une table AUDIT_ANNULATION_RESERVATION qui va contenir de l�information sur chaque
r�servation annul�e :
	- L�identifiant de la r�servation,
	- La date de la r�servation,
	- La date de l�annulation,
	- L�utilisateur qui a effectu� l�annulation,
	- L�identifiant du passager,
	- La liste des envol�es associ�es � la r�servation.
*/
DROP TABLE IF EXISTS AUDIT_ANNULATION_RESERVATION

CREATE TABLE AUDIT_ANNULATION_RESERVATION(
	ID_RESERVATION				SMALLINT			NOT NULL,
	DATE_RESERVATION			DATETIME			NOT NULL,
	DATE_ANNULATION				DATETIME			NOT NULL,
	ANNULEE_PAR_USER			VARCHAR(30)			NOT NULL,
	ID_PASSAGER					SMALLINT			NOT NULL,
	LISTE_ENVOLEES				VARCHAR(100)		NULL
)
/*
�crire le trigger T-SQL � RESERVATION_ANNULEE � qui, lorsqu�une r�servation est annul�e (voir la
colonne ANNULEE de la table RESERVATION), effectue les traitements suivants :
	- Supprime toutes les r�servations des envol�es associ�es � la r�servation afin de
	  rendre disponibles les si�ges r�serv�s. � noter que la r�servation elle-m�me n�est pas
	  supprim�e de la base de donn�es.

	- Enregistre dans la table AUDIT_ANNULATION_RESERVATION les information sur la
	  r�servation annul�e. Voir ci-dessous pour le format texte de la liste des envol�es
	  concern�es par l�annulation.
*/
DROP TRIGGER IF EXISTS TRIGGER_RESERVATION_ANNULEE
GO
CREATE TRIGGER TRIGGER_RESERVATION_ANNULEE
ON RESERVATION

AFTER UPDATE
AS
	IF UPDATE(ANNULEE)
	BEGIN
        INSERT INTO AUDIT_ANNULATION_RESERVATION
            (ID_RESERVATION,
             DATE_RESERVATION,
             DATE_ANNULATION,
             ANNULEE_PAR_USER,
             ID_PASSAGER,
             LISTE_ENVOLEES)
        SELECT
            ID_RESERVATION,
            DATE_RESERVATION,
            GETDATE(),
            SUSER_SNAME(),
            ID_PASSAGER,
            (SELECT STRING_AGG(ID_ENVOLEE, '-')
             FROM RESERVATION_ENVOLEE
             WHERE ID_RESERVATION = inserted.ID_RESERVATION)
        FROM inserted;
	END

BEGIN TRANSACTION
	UPDATE RESERVATION
		SET ANNULEE = 4000
		WHERE ID_RESERVATION IN(5,6,8,9,10)
	SELECT * FROM AUDIT_ANNULATION_RESERVATION
ROLLBACK
/*
(5 rows affected)

(5 rows affected)
ID_RESERVATION DATE_RESERVATION DATE_ANNULATION UTILISATEUR                                        ID_PASSAGER LIST_ENVOLEES
-------------- ---------------- --------------- -------------------------------------------------- ----------- --------------------------------------------------
10             2024-05-03       2024-04-30      TECNISTICO\Tecnistico                              10          54
9              2024-05-02       2024-04-30      TECNISTICO\Tecnistico                              9           13-14-43-44-61
8              2024-05-01       2024-04-30      TECNISTICO\Tecnistico                              8           20
6              2024-05-01       2024-04-30      TECNISTICO\Tecnistico                              6           44
5              2024-04-20       2024-04-30      TECNISTICO\Tecnistico                              5           1-2-3-4-61-62-63-80

(5 rows affected)


Completion time: 2024-04-30T11:47:17.9897620-04:00
*/