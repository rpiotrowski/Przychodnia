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

exec addService "masaz gleboki",30,"200",0

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

alter procedure addVisit
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

exec addVisit 95071912345,4,1,"2017-03-10","10:00:00"

--==========================================================================================

create procedure removeV
	@idWiz int
as
begin
	delete from Wizyty
	where idWiz = @idWiz
	select * from Wizyty
end

removeV 2

--===========================================================================================

alter trigger checkVisitTime
on Wizyty
after insert
as
begin
	select * from inserted
	if exists 
	(select * from Wizyty d inner join (SELECT * FROM inserted WHERE idWiz=( SELECT max(idWiz) FROM inserted)) i
	on d.PESEL = i.PESEL where d.data_wizyty = i.data_wizyty and d.godzinaS = i.godzinaS)
		begin
			print 'Pacjent ma ju¿ umówion¹ wizytê o tej godzinie'
			rollback
	end

end

alter table Wizyty
enable trigger checkVisitTime

select so1.name
from sysobjects so1 join sysobjects so2
on so1.parent_obj = so2.id
where so1.type = 'TR'
and so2.name = 'Wizyty'

alter trigger ten_visits_only
on Wizyty
after insert
as
begin
	if (select count(*) 
	    from (select * from Wizyty where data_wizyty >= getdate()) as tab
		where PESEL = (select PESEL from inserted) ) > 3 
	begin
			print 'Pacjent nie moze umowic juz wiecej wizyt'
			rollback
	end
end