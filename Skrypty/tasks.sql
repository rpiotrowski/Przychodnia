--Rejestracja nowego pacjenta, zmiana jego danych
Dodanie nowego pracownika, zmiana jego danych
Dopisanie pracownikowi nowej umiejêtnoœci (wykonania ustalonej us³ugi)
Dodawanie nowych us³ug
Umówienie wizyty pacjenta 
Anulowanie wizyty
Komentowanie wizyty przez pracownika z opisem przebiegu us³ugi


create procedure addPatient
        @pesel bigint,
		@name varchar(20),
		@surname varchar(20),
		@address varchar(100),
		@phone bigint,
		@mail varchar(50),
		@vip tinyint = 0
as
begin try
        insert into Pacjenci
		values (@pesel, @name,@surname,@address,@phone,@mail,@vip); 
end try
begin catch
     print ERROR_MESSAGE() 
end catch

exec addPatient 95071912345,Monika,Tyblewska,"Niebieska 19 64-320 Otusz",678678678,"monia@wp.pl",1


