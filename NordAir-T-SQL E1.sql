/* **********************************************************
	NordAir - Transact SQL E1
	Sch�ma MRD:	"NordAir"
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

	SET @minutesVol =
	(SELECT
		SUM(SEGMENT.DUREE_VOL)
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