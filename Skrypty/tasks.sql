--Rejestracja nowego pacjenta, zmiana jego danych
--Dodanie nowego pracownika, zmiana jego danych
--Dopisanie pracownikowi nowej umiejêtnoœci (wykonania ustalonej us³ugi)
--Dodawanie nowych us³ug
Umówienie wizyty pacjenta 
Anulowanie wizyty
--Komentowanie wizyty przez pracownika z opisem przebiegu us³ugi

--===========================================================================================================================================
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
		values (@pesel, @name,@surname,@address,@phone,@mail,@vip); 
		select * from Pacjenci
end try
begin catch
     print ERROR_MESSAGE() 
end catch

exec addPatient 95071912345,Monika,Tyblewska,"Niebieska 19 64-320 Otusz",678678678,"monia@wp.pl",1


--==========================================================================================================================================
alter procedure updatePatient
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

exec updatePatient 95071912345,Monika,Majewska,"Niebieska 19 64-320 Otusz",678678678,"monia@wp.pl",1

--============================================================================================================
create function showPatient 
(@i bigint)
returns table
as
return select * from Pacjenci where PESEL=@i

select * from dbo.showPatient(95071912345)
--=============================================================================================================
alter procedure addDoctor
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

exec addDoctor "Rafal","Piotrowski","Slowackiego 16 64-320 Olsztyn",678678678,"rafcio@wp.pl",laryngolog
--=============================================================================================================
alter procedure updateDoctor
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

exec updateDoctor 5,"Rafal","Piotrowski","Slowackiego 16 64-320 Olsztyn",678678678,"rafcio@wp.pl",pediatra

--=======================================================================================================================

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

exec addAbility 5,2

--=================================================================================================================
alter procedure addService
	@nazwa varchar(50),
	@czas_trwania TIME(0), /* HHH:MM:SS */
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

exec addService "masaz gleboki","00:30:00","200",0

--================================================================================================================

alter procedure addComment
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

exec addComment 1,"Rozpoznanie zapalenie ucha srodkowego. Skierowanie pacjenta na masaz gleboki"

--=============================================================================================================