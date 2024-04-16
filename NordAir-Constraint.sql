/* **********************************************************
	NordAir - Contraintes de validation
	Sch�ma MRD:	"NordAir"
	Auteur:		Arthur Tirado et Xavier Breton-L'italien	
********************************************************** */
USE NORDAIR
GO	

/* Question A.1

Ajouter la contrainte de validation � la table RESERVATION_ENVOLEE afin de s�assurer que le code
du si�ge r�serv� respecte le format suivant :
	- Deux premiers caract�res : un nombre
	- Troisi�me caract�re : une lettre A, B, C ou D
Dans une transaction (afin qu�un retour arri�re ou � rollback � soit possible), �crire les requ�tes
de manipulation (INSERT ou UPDATE) pour tester le comportement de la contrainte :
	- Un 1er cas valide;
	- Des cas invalides qui �chouent � cause de la contrainte.
Inclure le r�sultat affich� lors de l�ex�cution des requ�tes de tests (puis ex�cuter le � rollback �).
*/

ALTER TABLE RESERVATION_ENVOLEE
ADD CONSTRAINT CHK_CODE_SIEGE
CHECK (CODE_SIEGE LIKE '[0-9][0-9][A-D]')

--TESTS A.1
--L'insert doit fonctionner avec un code_siege valide:
BEGIN TRANSACTION
	INSERT INTO
	RESERVATION_ENVOLEE
		(ID_RESERVATION,
		 ID_ENVOLEE,
		 CODE_SIEGE)
	VALUES(
	1,
	2,
	'22A'
	)
ROLLBACK

--L'insert ne doit pas fonctionner avec un code_siege invalide (Letres dans les deux charcteres au debut):
BEGIN TRANSACTION
	INSERT INTO
	RESERVATION_ENVOLEE
		(ID_RESERVATION,
		 ID_ENVOLEE,
		 CODE_SIEGE)
	VALUES(
	1,
	2,
	'WFA'
	)
ROLLBACK
--L'insert ne doit pas fonctionner avec un code_siege invalide (Letres Au dehors de a,b,c,d):
BEGIN TRANSACTION
	INSERT INTO
	RESERVATION_ENVOLEE
		(ID_RESERVATION,
		 ID_ENVOLEE,
		 CODE_SIEGE)
	VALUES(
	1,
	2,
	'22T'
	)
ROLLBACK
--L'insert ne doit pas fonctionner avec un code_siege invalide (chiffre dans de le troisieme charactere):
BEGIN TRANSACTION
	INSERT INTO
	RESERVATION_ENVOLEE
		(ID_RESERVATION,
		 ID_ENVOLEE,
		 CODE_SIEGE)
	VALUES(
	1,
	2,
	'223'
	)
ROLLBACK
--L'insert ne doit pas fonctionner avec un code_siege invalide (code trop long):
BEGIN TRANSACTION
	INSERT INTO
	RESERVATION_ENVOLEE
		(ID_RESERVATION,
		 ID_ENVOLEE,
		 CODE_SIEGE)
	VALUES(
	1,
	2,
	'22AAA'
	)
ROLLBACK
--L'insert ne doit pas fonctionner avec un code_siege invalide (code trop court):
BEGIN TRANSACTION
	INSERT INTO
	RESERVATION_ENVOLEE
		(ID_RESERVATION,
		 ID_ENVOLEE,
		 CODE_SIEGE)
	VALUES(
	1,
	2,
	'22'
	)
ROLLBACK

/* Question A.2

Ajouter les contraintes de validation aux tables PASSAGER et PILOTE afin de s�assurer que le
num�ro de t�l�phone respecte le format suivant : (999)999-9999

Dans une transaction (afin qu�un retour arri�re ou � rollback � soit possible), �crire les requ�tes
de manipulation (INSERT ou UPDATE) pour tester le comportement de chaque contrainte :
	Un 1er cas valide;
	Des cas invalides qui �chouent � cause de la contrainte.
Inclure le r�sultat affich� lors de l�ex�cution des requ�tes de tests (puis ex�cuter le � rollback �).
*/
ALTER TABLE PASSAGER
ADD CONSTRAINT CHK_PHONE_NUMBER
CHECK (TELEPHONE LIKE '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')

ALTER TABLE PILOTE
ADD CONSTRAINT CHK_PHONE_NUMBER
CHECK (TELEPHONE LIKE '([0-9][0-9][0-9]) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]')

--TESTS A.2
--L'insert ne doit pas fonctionner avec un code_siege invalide (chiffre dans de le troisieme charactere):
BEGIN TRANSACTION
	INSERT INTO
	PASSAGER
		(
		 NOM,
		 PRENOM,
		 ADRESSE,
		 TELEPHONE,
		 COURRIEL)
	VALUES(
	'joe',
	'smith',
	'223',
	'(581)111-111',
	'aaaa'
	)
ROLLBACK