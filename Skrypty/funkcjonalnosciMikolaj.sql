
/*Miko³aj Balcerek s416040 Przychodnia
Podawanie czasu trwania wizyty - showDurationVisitAfterID
Dodawanie badania - addBadanie*/

--===========================================================================================================================================

/* CLEARUP */
IF EXISTS (
    SELECT * FROM sysobjects WHERE id = object_id(N'showDurationVisitAfterID') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
    DROP FUNCTION showDurationVisitAfterID
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'addBadanie')
DROP PROCEDURE addBadanie
GO


/* Dodawanie badania */
Create procedure addBadanie
        @pesel bigint,
		@data datetime,
		@wyniki varchar(500)
as
begin try
        insert into Badania
		values (@pesel, @data, @wyniki)
end try
begin catch
     print ERROR_MESSAGE() 
end catch;
GO

--=============================================================================================================
/* PODAWANIE CZASU TRWANIA WIZYTY */ 
CREATE FUNCTION showDurationVisitAfterID
(@idWiz_zmienna int)
returns table
as
	return select DATEDIFF(minute,godzinaS,godzinaZ) AS 'dlugosc wizyty w minutach' from Wizyty where (idWiz = @idWiz_zmienna);
;
GO



