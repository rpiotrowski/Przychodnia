/* MIKOŁAJ BALCEREK CZW 10.00
	RAFAŁ PIOTROWSKI PTK 11:45
	PROJEKT SKRYPT 1 */


IF OBJECT_ID('Badania', 'U') IS NOT NULL
	drop table Badania
IF OBJECT_ID('Grafik', 'U') IS NOT NULL
    	drop table Grafik
IF OBJECT_ID('Skierowania', 'U') IS NOT NULL
    	drop table Skierowania
IF OBJECT_ID('Umiejętności', 'U') IS NOT NULL
    	drop table Umiejętności
IF OBJECT_ID('Wizyty', 'U') IS NOT NULL
    	drop table Wizyty
IF OBJECT_ID('Pacjenci', 'U') IS NOT NULL
    	drop table Pacjenci
IF OBJECT_ID('Pracownicy', 'U') IS NOT NULL
    	drop table Pracownicy
IF OBJECT_ID('Usługi', 'U') IS NOT NULL
    	drop table Usługi


create table Pacjenci
(PESEL bigint not null primary key,
imię varchar(30) not null,
nazwisko varchar(30),
adres varchar(100),
telefon bigint,  
mail varchar(50),
vip tinyint default 0,
check (len(PESEL) = 11),
check(len(telefon)>6),
check(mail like '%@%.%'),
);


create table Pracownicy
(idPrac int identity(1,1) primary key,
imię varchar(30),
nazwisko varchar(30),
adres varchar(100),
telefon bigint,  
mail varchar(50),
specjalizacja varchar(20),
check(len(telefon)>6),
check(mail like '%@%.%'),
);


create table Usługi
(idUs int identity(1,1) not null primary key,
nazwa varchar(50) not null unique,
czas_trwania int not null /*tu musi byc int zeby funkcja DATEADD daialala */,
cena money not null,
wymaga_skierowania tinyint DEFAULT 0);


create table Umiejętności
(idPrac int references Pracownicy(idPrac),
idUs int references Usługi(idUs),
CONSTRAINT uc_PersonID UNIQUE (idPrac,idUs)
);


create table Grafik
(idG int identity(1,1) primary key,
idPrac int references Pracownicy(idPrac),
godzinaOd TIME(0),
godzinaDo TIME(0),
dzień_tyg varchar(20)
check(dzień_tyg = 'poniedziałek' or dzień_tyg = 'wtorek' or dzień_tyg = 'środa' or
dzień_tyg = 'czwartek' or dzień_tyg = 'piątek' or dzień_tyg = 'sobota'))


create table Badania
(idB int identity(1,1) primary key,
PESEL bigint references Pacjenci(PESEL),
data_badania date,
wynik varchar(50),
);

create table Wizyty
(idWiz int identity(1,1) primary key,
PESEL bigint references Pacjenci(PESEL),
idPrac int references Pracownicy(idPrac),
idUs int references Usługi(idUs),
data_wizyty date not null,/*'YYYY-MM-DD'*/
godzinaS time(0) not null,
godzinaZ time(0) not null,
komentarz varchar(500),
check (godzinaS <= godzinaZ),
check (GETDATE() <= data_wizyty),
CONSTRAINT uc_pacjent UNIQUE (PESEL,data_wizyty,godzinaS),
CONSTRAINT uc_lekarz UNIQUE (idPrac,data_wizyty,godzinaS)
);

create table Skierowania
(idS int identity(1,1) primary key,
IdPrac int references Pracownicy(idPrac),
PESEL bigint references Pacjenci(PESEL),
data_wystawienia date not null, /*'YYYY-MM-DD'*/
data_ważności date,
idUs int references Usługi(idUs),
ilość_wizyt int default 0 not null, /*999 to nieskonczonosc wizyt */
check (data_wystawienia <= data_ważności),
);

--===========================================================================================

insert into Pacjenci
values (95071912531, 'Mikołaj', 'Nowak','Słowiańska 90 60-321 Poznań',66776678,'mikolaj@gmail.com', default );
insert into Pacjenci
values (94071912531, 'Rafał', 'Słowik','Polna 90 60-321 Poznań',76776678,'rafal@gmail.com', 1 );
insert into Pacjenci
values (93071912531, 'Ewa', 'Wanat','Garbary 90 60-321 Poznań',86776678,'ewa@gmail.com', default );
insert into Pacjenci
values (92071912531, 'Ignacy', 'Nowka','Lechicka 90 60-321 Poznań',55776678,'ignacy@gmail.com', default );
insert into Pacjenci
values (91071912531, 'Eliza', 'Nowka','Szylinga 10 60-321 Poznań',31776678,'eliza@gmail.com', default );
insert into Pacjenci
values (96100907776, 'Kamil', 'Piotrowski','Szamarzewskiego 30 60-122 Poznań',31776785,'kampiotr@gmail.com', default );


insert into Pracownicy
values('Łukasz','Bartkowiak','Marcinkowskiego 90 60-321 Poznań',66776678,'łukasz@gmail.com','laryngolog')
insert into Pracownicy
values('Anna','Bąk','Bułgarska 90 60-321 Poznań',86756678,'anna@gmail.com','foniatra')
insert into Pracownicy
values('Michał','Anioł','Zbawiciela 44 60-321 Poznań',86376678,'michał@gmail.com','laryngolog')
insert into Pracownicy
values('Gregory','House','Nowy Świat 32 68-012 Poznań',86376139,'greg@princeton.com','internista')



insert into Usługi
values('konsultacja laryngologiczna', 30, 150, 0);
insert into Usługi
values('konsultacja foniatryczna',30, 150, 0);
insert into Usługi
values('Konsultacja z badaniem endoskopowym',30, 30, 1);
insert into Usługi
values('Płukanie uszu',30, 30, 1);
insert into Usługi
values('Konsultacja u internisty',20, 20, 0);




insert into Umiejętności
values (1,1)
insert into Umiejętności
values (1,3)
insert into Umiejętności
values (1,4)
insert into Umiejętności
values (3,1)
insert into Umiejętności
values (2,2)
insert into Umiejętności
values (3,3)
insert into Umiejętności
values (4,5)




insert into Grafik
values (1,'08:00:00','16:00:00','poniedziałek')
insert into Grafik
values (2,'08:00:00','14:00:00','poniedziałek')
insert into Grafik
values (2,'10:00:00','13:00:00','wtorek')
insert into Grafik
values (3,'10:00:00','20:00:00','środa')
insert into Grafik
values (1,'10:00:00','13:00:00','piątek')
insert into Grafik
values (2,'10:00:00','16:00:00','sobota')
insert into Grafik
values (4,'10:00:00','16:00:00','piątek')
insert into Grafik
values (4,'12:00:00','19:00:00','czwartek')





insert into Badania
values(95071912531,'1999-12-03','.badania/roentgen_531.pdf')
insert into Badania
values(95071912531,'2014-12-03','.badania/słuch_5312.pdf')
insert into Badania
values(95071912531,'1999-12-03','Niedobór słuchu lewego ucha')
insert into Badania
values(95071912531,'1999-12-03','Nieudany skan ROENTGEN')
insert into Badania
values(96100907776,'2016-12-03','Stwierdzono krwawienie pod językiem')


INSERT into Skierowania
values(1,95071912531,'2017-10-10', '2017-11-20', 4, default)
INSERT into Skierowania
values(2,96100907776,'2017-10-10', '2017-11-20', 4, default)


INSERT into Wizyty
values(95071912531,1,1,'2018-12-10','10:00:00','16:30:00',NULL);
INSERT into Wizyty
values(96100907776,2,2,'2018-12-22','12:00:00','19:30:00',NULL);


select * from Pacjenci
select * from Pracownicy
select * from Usługi
select * from Umiejętności
select * from Wizyty
select * from Grafik
select * from Badania
select * from Skierowania
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
		set @l = 4
	
	if (select count(*) 
	    from (select * from Wizyty where data_wizyty >= getdate()) as tab
		where PESEL = (select PESEL from inserted)) > @l
	begin
			print 'Pacjent nie moze umowic juz wiecej wizyt'
			rollback;
	end
end
go

create trigger expirience
on Wizyty
after insert
as
begin
	if not exists (select * from Umiejętności 
				  where idPrac =  (select idPrac from inserted)
				  and idUs = (select idUs from inserted))
	begin
			print 'Lekarz niewykwalifikowany do wykonywania tej usugi'
			rollback;
	end
end;


