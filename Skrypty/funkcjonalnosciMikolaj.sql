
/*Miko�aj Balcerek s416040 Przychodnia
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


IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'addGrafikGodzinyDzienTygodnia')
DROP PROCEDURE addGrafikGodzinyDzienTygodnia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'updateGrafikGodzinyDzienTygodnia')
DROP PROCEDURE updateGrafikGodzinyDzienTygodnia
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

/* Dodawanie skierowania, domy�lna warto�� ilo�ci skierowa� to 99 */
Create procedure addSkierowanie
        @pesel bigint,
		@idprac int,
		@idUs int,
		@data_wystawienia date,
		@data_wa�no�ci date,
		@ilo��_wizyt int
as
begin try
/* Error numeric */
		if (select idUs from Umiej�tno�ci where idPrac=@idprac) = @idUs
		begin
        insert into Skierowania
		values (@idprac, @pesel, @data_wystawienia, @data_wa�no�ci, @idUS, @ilo��_wizyt)
		end
end try
begin catch
     print ERROR_MESSAGE() 
end catch;
GO


/* Edycja grafiku */
Create procedure addGrafikGodzinyDzienTygodnia
        @idPrac int,
		@godzinaOd TIME(0),
		@godzinaDo TIME(0),
		@dzie�_tyg varchar(20)
as
begin try

        insert into Grafik
		values (@idPrac, @godzinaOd, @godzinaDo, @dzie�_tyg)
end try
begin catch
     print ERROR_MESSAGE() 
end catch;
GO

Create procedure updateGrafikGodzinyDzienTygodnia
	    @idPrac int,
		@godzinaOd TIME(0),
		@godzinaDo TIME(0),
		@dzie�_tyg varchar(20)
as
begin try
	update Grafik
	set godzinaOd = @godzinaOd,
	godzinaDo = @godzinaDo
	where idPrac = @idPrac and  dzie�_tyg = @dzie�_tyg
	select * from Grafik
end try
begin catch
	 print ERROR_MESSAGE()
end catch
GO


