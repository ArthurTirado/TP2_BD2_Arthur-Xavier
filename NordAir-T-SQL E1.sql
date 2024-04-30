/* **********************************************************
	NordAir - Transact SQL E1
	Schéma MRD:	"NordAir"
	Auteur:		Arthur Tirado et Xavier Breton-L'italien	
********************************************************** */

USE NORDAIR
GO

CREATE OR ALTER FUNCTION MINUTES_EN_HEURES(@minutes SMALLINT) RETURNS DECIMAL(9,3)
AS
BEGIN
	DECLARE @heures DECIMAL(9,3)
	DECLARE @minutesRestantes DECIMAL(9,3)
	SET @heures = @minutes / 60
	SET @minutesRestantes = (@minutes - (@heures * 60)) / 60
	SET @heures += @minutesRestantes
	RETURN @heures
END
GO

CREATE OR ALTER FUNCTION MINUTES_VOL_PILOTE(@no_pilote SMALLINT, @date1 DATE, @date2 DATE) RETURNS SMALLINT
AS
BEGIN
	DECLARE @minutesVol SMALLINT
	DECLARE @piloteExiste SMALLINT

	SET @piloteExiste =
	(SELECT
		ID_PILOTE
	FROM
		PILOTE
	WHERE 
		NO_PILOTE = @no_pilote)

	IF(@piloteExiste IS NULL)
	BEGIN
		RETURN NULL
	END

	SET @minutesVol =
	(SELECT
		ISNULL(SUM(SEGMENT.DUREE_VOL),0)
	FROM
		PILOTE
		INNER JOIN ENVOLEE
			ON ENVOLEE.ID_PILOTE = PILOTE.ID_PILOTE
		INNER JOIN SEGMENT
			ON SEGMENT.ID_SEGMENT = ENVOLEE.ID_SEGMENT
	WHERE
		PILOTE.NO_PILOTE = @no_pilote AND ENVOLEE.DATE_ENVOLEE BETWEEN @date1 AND @date2)

	RETURN @minutesVol
END

CREATE OR ALTER FUNCTION HEURES_VOL_PILOTE(@no_pilote SMALLINT, @date1 DATE, @date2 DATE)RETURNS DECIMAL(9,3)
AS
BEGIN
	DECLARE @minutes SMALLINT
	DECLARE @heures DECIMAL(9,3)
	SET @minutes = dbo.MINUTES_VOL_PILOTE(@no_pilote, @date1, @date2)
	SET @heures = dbo.MINUTES_EN_HEURES(@minutes)
	RETURN @heures
END