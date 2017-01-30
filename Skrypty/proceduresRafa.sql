IF EXISTS (
    SELECT * FROM sysobjects WHERE id = object_id(N'showPatient') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
    DROP FUNCTION showPatient
GO
IF EXISTS (
    SELECT * FROM sysobjects WHERE id = object_id(N'listDAbility') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
    DROP FUNCTION listDAbility
GO
IF EXISTS (
    SELECT * FROM sysobjects WHERE id = object_id(N'allPatientVisits') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
    DROP FUNCTION allPatientVisits
GO
IF EXISTS (SELECT * FROM sys.views WHERE name = 'popularServices' AND type = 'v') 
DROP VIEW popularServices
go
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'addPatient')
DROP PROCEDURE addPatient
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'updatePatient')
DROP PROCEDURE updatePatient
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'addDoctor')
DROP PROCEDURE addDoctor
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'updateDoctor')
DROP PROCEDURE updateDoctor
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'addAbility')
DROP PROCEDURE addAbility
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'addService')
DROP PROCEDURE addService
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'addComment')
DROP PROCEDURE addComment
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'addVisit')
DROP PROCEDURE addVisit
GO
IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'removeV')
DROP PROCEDURE removeV
GO


create procedure addPatient
        @pesel bigint,
		@name varchar(30),
		@surname varchar(30),
		@address varchar(100),
		@phone bigint,
		@mail varchar(50),
		@vip tinyint = 0
as
begin try
        insert into Pacjenci
		values (@pesel, @name,@surname,@address,@phone,@mail,@vip)
		select * from Pacjenci
end try
begin catch
     print ERROR_MESSAGE() 
end catch
go
--==========================================================================================

create procedure updatePatient
		@pesel bigint,
		@name varchar(30),
		@surname varchar(30),
		@address varchar(100),
		@phone bigint,
		@mail varchar(50),
		@vip tinyint
as
begin try
	update Pacjenci
	set imiê = @name,nazwisko = @surname,adres = @address,telefon = @phone,mail = @mail,vip = @vip
	where PESEL = @pesel
	select * from Pacjenci
end try
begin catch
     print ERROR_MESSAGE() 
end catch
go
--==========================================================================================

create function showPatient 
(@i bigint)
returns table
as
return select * from Pacjenci where PESEL=@i
go
--==========================================================================================


create procedure addDoctor
	@imiê varchar(30),
	@nazwisko varchar(30),
	@adres varchar(100),
	@telefon bigint,  
	@mail varchar(50),
	@specjalizacja varchar(10)
as
begin try
        insert into Pracownicy
		values (@imiê,@nazwisko,@adres,@telefon,@mail,@specjalizacja);
		select * from Pracownicy 
end try
begin catch
     print ERROR_MESSAGE() 
end catch
go
--==========================================================================================


create procedure updateDoctor
	@id int,
	@imiê varchar(30),
	@nazwisko varchar(30),
	@adres varchar(100),
	@telefon bigint,  
	@mail varchar(50),
	@specjalizacja varchar(10)
as
begin try
	update Pracownicy
	set imiê = @imiê,nazwisko = @nazwisko,adres = @adres,telefon = @telefon,mail = @mail,specjalizacja = @specjalizacja
	where idPrac = @id
	select * from Pracownicy
end try
begin catch
     print ERROR_MESSAGE() 
end catch
go
--==========================================================================================

create procedure addAbility
	@idPrac int,
	@idUs int
as
begin try
	insert into Umiejêtnoœci
	values(@idPrac,@idUs)
	select * from Umiejêtnoœci
end try
begin catch
     print ERROR_MESSAGE() 
end catch
go
--==========================================================================================

create procedure addService
	@nazwa varchar(50),
	@czas_trwania int,
	@cena money,
	@wymaga_skierowania tinyint = 0 
as
begin try
	insert into Us³ugi
	values(@nazwa,@czas_trwania,@cena,@wymaga_skierowania)
	select * from Us³ugi
end try
begin catch
	 print ERROR_MESSAGE()
end catch
go
--==========================================================================================

create procedure addComment
	@id int,
	@str varchar(500)
as
begin try
	update Wizyty
	set komentarz = @str
	where idWiz = @id
	select * from Wizyty
end try
begin catch
	 print ERROR_MESSAGE()
end catch
go
--==========================================================================================

create procedure addVisit
	@pesel bigint,
	@idPrac int,
	@idUs int,
	@data_wizyty date,/*'YYYY-MM-DD'*/
	@godzinaS time(0)	
as
begin
	declare @godzinaZ time(0)
	set @godzinaZ = DATEADD(MINUTE, (select czas_trwania from Us³ugi where idUs = @idUs), @godzinaS)
	insert into Wizyty
	values(@pesel,@idPrac,@idUs,@data_wizyty,@godzinaS,@godzinaZ,NULL)
	select * from Wizyty
end
go
--==========================================================================================

create procedure removeV
	@idWiz int
as
begin
	delete from Wizyty
	where idWiz = @idWiz
	select * from Wizyty
end
go
--==============================================================================================
create function listDAbility
(@i int)
returns table
as
return select * 
	   from Pracownicy 
	   where idPrac in (select idPrac from Umiejêtnoœci where @i = idUS)
go

--==============================================================================================

create function allPatientVisits 
(@pesel bigint)
returns table
as
return select * from Wizyty where PESEL=@pesel
go

--============================================================================================
create view popularServices
as
	select u.nazwa,w.liczba_wykonanych from Us³ugi u left outer join
	(select idUs, count(*) as liczba_wykonanych
	from Wizyty
	group by idUs 
	) w
	on u.idUs = w.idUs
	where w.liczba_wykonanych is not null 
go


create trigger ten_visits_only
on Wizyty
after insert
as
begin
	declare @vip tinyint
	set @vip = (select vip from Pacjenci where PESEL = (select PESEL from inserted ) )

	declare @l int
	if @vip = 0
		set @l = 3
	else
		set @l = 5
	
	if (select count(*) 
	    from (select * from Wizyty where data_wizyty >= getdate()) as tab
		where PESEL = (select PESEL from inserted)) > @l
	begin
			print 'Pacjent nie moze umowic juz wiecej wizyt'
			rollback
	end
end
go


create trigger expirience
on Wizyty
after insert
as
begin
	if not exists (select * from Umiejêtnoœci 
				  where idPrac =  (select idPrac from inserted)
				  and idUs = (select idUs from inserted))
	begin
			print 'Lekarz niewykwalifikowany do wykonywania tej usugi'
			rollback
	end
end
go