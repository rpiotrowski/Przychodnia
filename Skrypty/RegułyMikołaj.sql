IF EXISTS (SELECT * FROM sys.objects WHERE [name] = N'VIP_count' AND [type] = 'TR')
BEGIN
      DROP TRIGGER [dbo].[VIP_count];
END;
go

IF EXISTS (SELECT * FROM sys.objects WHERE [name] = N'Skierowania_used' AND [type] = 'TR')
BEGIN
      DROP TRIGGER [dbo].[Skierowania_used];
END;
go

IF EXISTS (SELECT * FROM sys.objects WHERE [name] = N'regular_increments' AND [type] = 'TR')
BEGIN
      DROP TRIGGER [dbo].[regular_increments];
END;
go

IF EXISTS (SELECT * FROM sys.objects WHERE [name] = N'visit_time_limit' AND [type] = 'TR')
BEGIN
      DROP TRIGGER [dbo].[visit_time_limit];
END;
go

/*Nadanie pacjentowi statusu VIP je�eli ma >= 5 wizyt */
create trigger VIP_count
on Wizyty
for insert
as
declare @help bigint;
if (select PESEL from Wizyty group by PESEL having COUNT(*) >=5) is not null
begin
SET @help = (select MAX(PESEL) from Wizyty group by PESEL having COUNT(*) >=5);
update Pacjenci
	set vip = 1
	where PESEL = @help
	select * from Pacjenci;
end
go

/* Liczba skierowa� zmniejsza si� je�eli nie jest si� vipem */
create trigger Skierowania_used
on Wizyty
for insert
as
declare @help bigint;
set @help = (select PESEL from inserted);
if (select vip from Pacjenci where PESEL = @help) = 0
begin
if (select ilo��_wizyt from Skierowania where PESEL = @help) !=0
begin
print 'Pacjent nie jest VIP-em, liczba skierowa� pomniejsza si�'
update Skierowania
	set ilo��_wizyt = ilo��_wizyt - 1
	where PESEL = @help
	select * from Pacjenci;
end
else
begin
print 'Sko�czy�y si� skierowania, p�jd� do lekarza po nowe!'
end
end
go
/*Wizyty mog� by� tylko umawiani na inkrementy 15 minutowe */
create trigger regular_increments
on Wizyty
for insert
as
declare @help bigint;
if (select datepart(minute, godzinaS) from inserted) = 0 or (select datepart(minute, godzinaS) from inserted) = 15 or (select datepart(minute, godzinaS) from inserted) = 30 or (select datepart(minute, godzinaS) from inserted) = 45
begin
print 'Wybrana godzina Startowa jest sukcesywnie inkrementem 15-minutowym'
end
else
begin
print 'Nie mozna umawiac na nieinkrementy 15-minutowe'
rollback
end
go

/* Wizyty mo�na umawia� maksymalnie godzin� przed, do 4/6 (depends on vip status) lat do przodu (zmienione dla �atwiejszego testowania) */
create trigger visit_time_limit
on Wizyty
for insert
as
declare @help bigint;
set @help = (select PESEL from inserted)
if (select vip from Pacjenci where PESEL= @help) = 0
begin
if (SELECT DATEDIFF(YEAR, GETDATE(), data_wizyty) from inserted) > 4 or (SELECT DATEDIFF(HOUR, GETDATE(), data_wizyty) from inserted) < 2
begin
print 'Nie mo�na doda� wizyty, poniewa� rozpoczyna si� za daleko/blisko w przysz�o�ci!'
rollback
end
end
else
begin
if (SELECT DATEDIFF(YEAR, GETDATE(), data_wizyty) from inserted) > 6 or (SELECT DATEDIFF(HOUR, GETDATE(), data_wizyty) from inserted) < 2
begin
print 'Nie mo�na doda� wizyty, poniewa� rozpoczyna si� za daleko/blisko w przysz�o�ci! (VIP limit)'
rollback
end
end
go


