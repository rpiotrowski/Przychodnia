exec addPatient 95071912345,Monika,Tyblewska,"Niebieska 19 64-320 Otusz",678678678,"monia@wp.pl",1
exec updatePatient 95071912345,Monika,Majewska,"Niebieska 19 64-320 Otusz",678678678,"monia@wp.pl",1
exec addDoctor "Rafal","Piotrowski","Slowackiego 16 64-320 Olsztyn",678678678,"rafcio@wp.pl",laryngolog
exec updateDoctor 5,"Rafal","Piotrowski","Slowackiego 16 64-320 Olsztyn",678678678,"rafcio@wp.pl",pediatra
exec addAbility 5,2
exec addService "masaz gleboki","00:30:00","200",0
exec addComment 1,"Rozpoznanie zapalenie ucha srodkowego. Skierowanie pacjenta na masaz gleboki"
exec addVisit 95071912345,5,1,"2017-03-10","10:00:00","10:30:00"
removeV 2

select * from dbo.showPatient(95071912345)