/* Podaje czas wizyty o podanym ID w minutach */
select * from dbo.showDurationVisitAfterID(1)

/* Podaje wizyty pacjenta o  podanym PESEL*/
select * from dbo.showVisitAfterPESEL(96100907776)

/* Dodaje badanie o rezultacie z³amany nos Kamilowi Piotrowskiemu */
exec addBadanie 96100907776,"2017-10-10","z³amany nos"
GO

/*Dodaje godziny grafiku w dany dzieñ tygodnia */
/* BAJER: Nie dzia³a dla nieisteniej¹cego dnia tygodnia */
exec addGrafikGodzinyDzienTygodnia 1,"10:00:00","15:00:00","wtrk"
select * from Grafik;
/* dziala dla poprawnego */
exec addGrafikGodzinyDzienTygodnia 1,"10:00:00","15:00:00","wtorek"

/*Edycja grafik na dany dzieñ tygodnia */
exec updateGrafikGodzinyDzienTygodnia 1,"10:00:00","18:00:00","wtorek"

/*Pokaz grafiku dla pracownika na dzieñ/tyg */
select * from dbo.showGrafikAfterWeek(1)

/*BAJER!!: Nadanie pacjentowi statusu VIP je¿eli ma >= 5 wizyt */
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

/* Vip-y nie trac¹ iloœci dostêpnych skierowañ' */
update Skierowania set iloœæ_wizyt = 3 where pesel = 96100907776
select vip, Pesel from Pacjenci where pesel = 96100907776 /*jest vipem */
select iloœæ_wizyt from Skierowania where pesel = 96100907776
exec addVisit 96100907776,1,1,"2017-04-19","15:00:00" /* dodaje wizyte */
select iloœæ_wizyt from Skierowania where pesel = 96100907776 /*nie zmienia siê iloœæ skierowañ */

/* Umówienie wizyty u lekarza zmniejsza iloœæ wizyt, na które wa¿ne jest skierowanie */
update Skierowania set iloœæ_wizyt = 3 where pesel = 95071912531;
update Pacjenci set vip = 0  where PESEL = 95071912531
select iloœæ_wizyt from Skierowania where PESEL = 95071912531;
exec addVisit 95071912531,1,4,"2017-04-19","19:00:00"
select iloœæ_wizyt from Skierowania where PESEL = 95071912531; /* Iloœæ wizyt zmniejszy³a siê */











/*Dodaje skierowanie na wizytê do lekarza, równie¿ sprawdza czy odpowiedni lekarz do odpowiendiej us³ug */
select * from Skierowania
select * from Skierowania
/* ERROR NUMERIC exec addSkierowanie 1,96100907776,"2017-11-11","2017-12-12",4,2 */
GO




