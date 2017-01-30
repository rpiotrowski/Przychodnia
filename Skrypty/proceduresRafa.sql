alter procedure addPatient
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

--==========================================================================================

create function showPatient 
(@i bigint)
returns table
as
return select * from Pacjenci where PESEL=@i

select * from dbo.showPatient(95071912345)

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

--==========================================================================================

create procedure removeV
	@idWiz int
as
begin
	delete from Wizyty
	where idWiz = @idWiz
	select * from Wizyty
end

--==============================================================================================
create function listDAbility
(@i int)
returns table
as
return select * 
	   from Pracownicy 
	   where idPrac in (select idPrac from Umiejêtnoœci where @i = idUS)

--==============================================================================================

create function allPatientVisits 
(@pesel bigint)
returns table
as
return select * from Wizyty where PESEL=@pesel


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
