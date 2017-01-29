exec addPatient 95071912345,Monika,Tyblewska,"Niebieska 19 64-320 Otusz",678678678,"monia@wp.pl",1
exec updatePatient 95071912345,Monika,Majewska,"Niebieska 19 64-320 Otusz",678678678,"monia@wp.pl",1
exec addDoctor "Rafal","Piotrowski","Slowackiego 16 64-320 Olsztyn",678678678,"rafcio@wp.pl",laryngolog
exec updateDoctor 5,"Rafal","Piotrowski","Slowackiego 16 64-320 Olsztyn",678678678,"rafcio@wp.pl",pediatra
exec addAbility 5,2
exec addService "masaz gleboki",30,"200",0
exec addComment 1,"Skierowany na operacjê"
--dope³nia koniec wizyty
exec addVisit 91071912531,4,1,"2017-06-10","10:00:00"
exec removeV 32

select * from dbo.showPatient(95071912345)

select * from Wizyty