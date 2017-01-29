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
print N'Pacjent nie jest VIP-em, liczba skierowa� pomniejsza si�'
update Skierowania
	set ilo��_wizyt = ilo��_wizyt - 1
	where PESEL = @help
	select * from Pacjenci;
end
else
begin
print N'Sko�czy�y si� skierowania, p�jd� do lekarza po nowe!'
end
end
go



