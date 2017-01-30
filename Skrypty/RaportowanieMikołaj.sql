GO
IF OBJECT_ID('TopVisitsPatients', 'V') IS NOT NULL
    DROP VIEW  TopVisitsPatients;
GO

/* Widok (raport) na pacjent�w z ilo�ci� wizyt >=2 */
create view TopVisitsPatients
as
	select u.PESEL from Wizyty u
	left outer join
	(select PESEL, imi�, nazwisko
	from Pacjenci
	) w
	on u.PESEL = w.PESEL
	group by u.PESEL having COUNT(*) + 1 >= (SELECT AVG(a.rcount) FROM 
  (select count(*) as rcount 
   FROM Wizyty r
   GROUP BY r.Pesel) a)
go

