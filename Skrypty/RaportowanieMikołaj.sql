GO
IF OBJECT_ID('TopVisitsPatients', 'V') IS NOT NULL
    DROP VIEW  TopVisitsPatients;
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'oblicz_dochod')
DROP PROCEDURE oblicz_dochod
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'oblicz_dochod')
DROP PROCEDURE skierowania_pracownik
GO

IF OBJECT_ID('TopSkierowania', 'V') IS NOT NULL
    DROP VIEW  TopSkierowania;
GO

/* Widok (raport) na pacjentów z iloœci¹ wizyt >=2 */
create view TopVisitsPatients
as
	select u.PESEL from Wizyty u
	left outer join
	(select PESEL, imiê, nazwisko
	from Pacjenci
	) w
	on u.PESEL = w.PESEL
	group by u.PESEL having COUNT(*) + 1 >= (SELECT AVG(a.rcount) FROM 
  (select count(*) as rcount 
   FROM Wizyty r
   GROUP BY r.Pesel) a)
go


/* Tabela tymczasowa do dochodów miesiêcznych przychodni */
/* Procedura licz¹ca dochód miesiêczny przychodni */
create procedure oblicz_dochod
as
begin try
		/*tabela tymczasowa */
		create table temp_dochod
		(
			miesiac int,
			dochód int,
		)

        insert into temp_dochod
		values ((select MONTH(getdate())), (select SUM(cena) from Us³ugi u join (select idUS from Wizyty where MONTH(data_wizyty) = MONTH(getdate())) k on u.idUs = k.idUs))

		select * from temp_dochod
		drop table temp_dochod
end try
begin catch
     print ERROR_MESSAGE() 
end catch;
GO


/*Lekarze wystawiaj¹cy najwiêksze iloœci Skierowañ (wiêcej ni¿ œrednia) */
create view TopSkierowania
as
	select u.idPrac from Skierowania u
	left outer join
	(select idPrac, nazwisko
	from Pracownicy
	) w
	on u.idPrac = w.idPrac
	group by u.IdPrac having COUNT(*)  >= (SELECT AVG(a.rcount) FROM 
  (select count(*) as rcount 
   FROM Skierowania r
   GROUP BY r.IdPrac) a)
go


