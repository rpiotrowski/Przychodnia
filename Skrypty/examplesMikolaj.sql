/* Podaje czas wizyty o podanym ID w minutach */
select * from dbo.showDurationVisitAfterID(1)

/* Podaje wizyty pacjenta o  podanym PESEL*/
select * from dbo.showVisitAfterPESEL(96100907776)

/* Dodaje badanie o rezultacie z�amany nos Kamilowi Piotrowskiemu */
exec addBadanie 96100907776,"2017-10-10","z�amany nos"
GO

/*Dodaje godziny grafiku w dany dzie� tygodnia */
/* BAJER: Nie dzia�a dla nieisteniej�cego dnia tygodnia */
exec addGrafikGodzinyDzienTygodnia 1,"10:00:00","15:00:00","wtrk"
select * from Grafik;
/* dziala dla poprawnego */
exec addGrafikGodzinyDzienTygodnia 1,"10:00:00","15:00:00","wtorek"

/*Edycja grafik na dany dzie� tygodnia */
exec updateGrafikGodzinyDzienTygodnia 1,"10:00:00","18:00:00","wtorek"

/*Pokaz grafiku dla pracownika na dzie�/tyg */
select * from dbo.showGrafikAfterWeek(1)

/*BAJER!!: Nadanie pacjentowi statusu VIP je�eli ma >= 5 wizyt */
insert into Wizyty values(96100907776,1,1,"2017-10-10","16:30:00","17:30:00","asdasd")
select * from Wizyty
select vip, Pesel from Pacjenci where pesel = 96100907776 /* STATUS VIP 0 */
exec addVisit 96100907776,1,1,"2017-03-10","15:00:00"
exec addVisit 96100907776,1,1,"2017-03-10","17:00:00"
exec addVisit 96100907776,1,1,"2017-03-10","20:00:00"
exec addVisit 96100907776,1,1,"2017-08-10","20:00:00"
exec addVisit 96100907776,1,1,"2017-04-10","20:00:00"
exec addVisit 96100907776,1,1,"2017-04-10","10:00:00"
select vip, Pesel from Pacjenci where pesel = 96100907776 /* STATUS VIP 1 PO ZMIANIE!!! */

/* Vip-y nie trac� ilo�ci dost�pnych skierowa�' */
update Skierowania set ilo��_wizyt = 3 where pesel = 96100907776
select vip, Pesel from Pacjenci where pesel = 96100907776 /*jest vipem */
select ilo��_wizyt from Skierowania where pesel = 96100907776
exec addVisit 96100907776,1,1,"2017-04-19","15:00:00" /* dodaje wizyte */
select ilo��_wizyt from Skierowania where pesel = 96100907776 /*nie zmienia si� ilo�� skierowa� */

/* Um�wienie wizyty u lekarza zmniejsza ilo�� wizyt, na kt�re wa�ne jest skierowanie */
update Skierowania set ilo��_wizyt = 3 where pesel = 95071912531;
update Pacjenci set vip = 0  where PESEL = 95071912531
select ilo��_wizyt from Skierowania where PESEL = 95071912531;
exec addVisit 95071912531,1,4,"2017-04-19","19:00:00"
select ilo��_wizyt from Skierowania where PESEL = 95071912531; /* Ilo�� wizyt zmniejszy�a si� */











/*Dodaje skierowanie na wizyt� do lekarza, r�wnie� sprawdza czy odpowiedni lekarz do odpowiendiej us�ug */
select * from Skierowania
select * from Skierowania
/* ERROR NUMERIC exec addSkierowanie 1,96100907776,"2017-11-11","2017-12-12",4,2 */
GO




