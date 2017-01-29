
/*Miko³aj Balcerek s416040 Przychodnia
Podawanie czasu trwania wizyty - showDurationVisitAfterID
Podawanie wizyt danego pacjenta - showVisitAfterPESEL
Dodawanie badania - addBadanie
Dodawanie skierowania - addSkierowanie*/

--===========================================================================================================================================

/* CLEARUP */
IF EXISTS (
    SELECT * FROM sysobjects WHERE id = object_id(N'showDurationVisitAfterID') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
    DROP FUNCTION showDurationVisitAfterID
GO

IF EXISTS (
    SELECT * FROM sysobjects WHERE id = object_id(N'showVisitAfterPESEL') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
    DROP FUNCTION showVisitAfterPESEL
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'addBadanie')
DROP PROCEDURE addBadanie
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'addSkierowanie')
DROP PROCEDURE addSkierowanie
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

--=============================================================================================================
/* PODAWANIE WIZYT PO PESELU */ 
CREATE FUNCTION showVisitAfterPESEL
(@PESEL_zmienna bigint)
returns table
as
	return select *  from Wizyty where (PESEL = @PESEL_zmienna);
;
GO

/* Dodawanie skierowania, domyœlna wartoœæ iloœci skierowañ to 99 */
Create procedure addSkierowanie
        @pesel bigint,
		@idprac int,
		@idUs int,
		@data_wystawienia date,
		@data_wa¿noœci date,
		@iloœæ_wizyt int
as
begin try
		if (select idUs from Umiejêtnoœci where idPrac = @idprac) = @idUs
		begin
        insert into Skierowania
		values (@idprac, @pesel, @data_wystawienia, @data_wa¿noœci, @idUS, @iloœæ_wizyt)
		end
end try
begin catch
     print ERROR_MESSAGE() 
end catch;
GO

