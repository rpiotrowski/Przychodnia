Bazy danych 2016 - projekt zaliczeniowy
Tytuł projektu: Przychodnia laryngologiczno-foniatryczna
Autorzy: Mikołaj Balcerek, Rafał Piotrowski


Celem bazy danych jest wspomaganie pracy przychodni laryngologicznej-foniatrycznej (lekarskiej) poprzez rejestrację pacjentów i umawianie ich wizyt ze specjalistami.

Diagram ER
Model relacyjny - (podkreślenie -  klucz podstawowy, kursywa - klucz obcy) 

Pacjenci (PESEL, imię, nazwisko, adres, telefon, mail, vip)
Pracownicy (idPrac, imię, nazwisko, adres, telefon, mail, specjalizacja)
Umiejętności (idPrac, idUs)
Usługi (idUs, nazwa, czas_trwania, cena, wymaga_skierowania)
Wizyty (idWiz, PESEL, idPrac, idUs, data_wizyty, godzinaS, godzinaZ, komentarz)
Grafik (idG, idPrac, godzinaOd, godzinaDo, dzień_tyg )
Skierowania (idS,idPrac,PESEL, data_wystawienia, data_ważności, idUs, ilość_wizyt)
Badania (idB, PESEL, data, wynik)
Opis funkcjonalności
Rejestracja nowego pacjenta, zmiana jego danych
Dodanie nowego pracownika, zmiana jego danych
Dopisanie pracownikowi nowej umiejętności (wykonania ustalonej usługi)
Dodawanie nowych usług
Umówienie wizyty pacjenta 
Anulowanie wizyty
Komentowanie wizyty przez pracownika z opisem przebiegu usługi
Tworzenie i edycja indywidualnego grafiku
Sprawdzenie umówionych wizyt określonego pacjenta
Plan dnia/tygodnia pracownika
Podawanie czasu trwania wizyty
Wystawianie skierowań
Dodawanie wyników badań
Opis reguł działania przychodni (opis logiki bazy)
Długość wizyty jest zgodna z podanym czasem trwania usług
Pracownik/Pacjent nie może mieć umówionych dwóch wizyt w tym samym czasie
Pacjent może mieć umówione maksymalnie tylko 10 wizyt
Wizyty można umawiać tylko cztery tygodnie do przodu, z co najmniej godzinnym wyprzedzeniem
Wizyta może być umówiona tylko na ustalone godziny (np. 13:00, 13:15, 13:30. 13:45)
Konkretne usługi mogą wykonywać tylko wykwalifikowani do tego pracownicy
Pacjenci z zrealizowanymi 30 wizytami otrzymują status VIP
VIP-owie mogą umawiać wizyty sześć tygodni do przodu
VIP-owie mogą mieć umówione maksymalnie 15 wizyt
VIP-owskie skierowania nie mają limitu zużyć
Generowane raporty
Lista pracowników z daną umiejętnością
Lista wszystkich wizyt pacjenta z komentarzami
Lista najczęściej wykonywanych usług
Pacjenci z największą liczbą wizyt
Miesięczny obrót przychodni
Wszystkie wystawione skierowania przez pracownika
