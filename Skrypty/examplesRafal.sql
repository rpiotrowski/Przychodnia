exec addPatient 95071912345,Monika,Tyblewska,"Niebieska 19 64-320 Otusz",678678678,"monia@wp.pl",1
exec updatePatient 95071912345,Monika,Majewska,"Niebieska 19 64-320 Otusz",678678678,"monia@wp.pl",1
exec addDoctor "Rafal","Piotrowski","Slowackiego 16 64-320 Olsztyn",678678678,"rafcio@wp.pl",laryngolog
exec updateDoctor 5,"Rafal","Piotrowski","Slowackiego 16 64-320 Olsztyn",678678678,"rafcio@wp.pl",pediatra
exec addAbility 5,2
exec addService "masaz gleboki",30,"200",0
exec addComment 1,"Skierowany na operacjê"
exec addVisit 95071912345,5,2,"2017-11-13","10:00:00"
exec removeV 18

select * from dbo.showPatient(95071912345)

select * from dbo.listDAbility(2)
select * from dbo.allPatientVisits(95071912345)
select * from dbo.popularServices