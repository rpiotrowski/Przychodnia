/* Podaje czas wizyty o podanym ID w minutach */
select * from dbo.showDurationVisitAfterID(1)

/* Podaje wizyty pacjenta o  podanym PESEL*/
select * from dbo.showVisitAfterPESEL(96100907776)

/* Dodaje badanie o rezultacie z�amany nos Kamilowi Piotrowskiemu */
exec addBadanie 96100907776,"2017-10-10","z�amany nos"