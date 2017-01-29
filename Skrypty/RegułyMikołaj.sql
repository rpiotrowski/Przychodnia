create trigger VIP_count
on Wizyty
for insert
as
if (select PESEL, count(*) from Wizyty group by PESEL having COUNT(*) >=5) is not null
begin
declare help bigint
set help = (select MAX(PESEL) from Wizyty group by PESEL having COUNT(*) >=5)
print 'uzytkownik ' + help +  'otrzymuje status VIP!'
update Pacjenci
	set vip = 1
	where PESEL = help
	select * from Pacjenci
end
go




