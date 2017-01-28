
/*Miko³aj Balcerek s416040 Przychodnia
Podawanie czasu trwania wizyty - showDurationVisitAfterID*/

--===========================================================================================================================================

/* CLEARUP */
IF EXISTS (
    SELECT * FROM sysobjects WHERE id = object_id(N'showDurationVisitAfterID') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
    DROP FUNCTION showDurationVisitAfterID
GO

/* PODAWANIE CZASU TRWANIA WIZYTY */ 
CREATE FUNCTION showDurationVisitAfterID
(@idWiz_zmienna int)
returns table
as
	return select DATEDIFF(minute,godzinaS,godzinaZ) AS 'dlugosc wizyty w minutach' from Wizyty where (idWiz = @idWiz_zmienna);






