exec addPatient 95071912345,Monika,Tyblewska,"Niebieska 19 64-320 Otusz",678678678,"monia@wp.pl",0
exec addPatient 95071923456,Andrzej,Duda,"Niebieska 19 64-320 Otusz",678678678,"monia@wp.pl",1

exec updatePatient 95071912345,Monika,Majewska,"Niebieska 19 64-320 Otusz",678678678,"monia@wp.pl",0

exec addDoctor "Rafal","Piotrowski","Slowackiego 16 64-320 Olsztyn",678678678,"rafcio@wp.pl",laryngolog
exec updateDoctor 5,"Rafal","Piotrowski","Slowackiego 16 64-320 Olsztyn",678678678,"rafcio@wp.pl",pediatra

exec addAbility 5,3
exec addAbility 5,1
exec addAbility 5,6


exec addService "badanie suchu",30,"200",0

exec addVisit 95071912345,5,1,"2017-11-13","10:00:00"
exec addComment 1,"Skierowany na tomograf zatok"

exec removeV 5

--ustalona godzina
--nie w tym samym czasie
--3 wizyty zwyky, 5 wyzyt vip
exec addVisit 95071912345,5,1,"2017-12-14","10:00:00"
exec addVisit 95071912345,5,1,"2017-12-15","10:00:00"
exec addVisit 95071912345,5,1,"2017-12-16","10:00:00"
exec addVisit 95071912345,5,1,"2017-12-14","10:00:00"

exec addVisit 95071923456,5,6,"2017-12-30","10:00:00"
exec addVisit 95071923456,5,1,"2017-12-16","10:00:00"
exec addVisit 95071923456,5,1,"2017-12-17","10:00:00"
exec addVisit 95071923456,5,1,"2017-12-18","10:00:00"
exec addVisit 95071923456,5,6,"2017-12-19","10:00:00"
exec addVisit 95071923456,5,6,"2017-12-22","10:00:00"

--kwalifikacja pracownika
exec addVisit 96100907776,5,2,"2017-12-22","10:00:00"

select * from dbo.showPatient(95071912345)

select * from dbo.listDAbility(6)
select * from dbo.allPatientVisits(95071912345)
select * from dbo.popularServices

select * from Pacjenci