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


/*Dodaje skierowanie na wizytê do lekarza, równie¿ sprawdza czy odpowiedni lekarz do odpowiendiej us³ug */
select * from Skierowania
select * from Skierowania
/* ERROR NUMERIC exec addSkierowanie 1,96100907776,"2017-11-11","2017-12-12",4,2 */
GO


