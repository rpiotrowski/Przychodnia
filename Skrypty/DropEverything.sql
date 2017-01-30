IF OBJECT_ID('Badania', 'U') IS NOT NULL
	drop table Badania
IF OBJECT_ID('Grafik', 'U') IS NOT NULL
    	drop table Grafik
IF OBJECT_ID('Skierowania', 'U') IS NOT NULL
    	drop table Skierowania
IF OBJECT_ID('Umiejêtnoœci', 'U') IS NOT NULL
    	drop table Umiejêtnoœci
IF OBJECT_ID('Wizyty', 'U') IS NOT NULL
    	drop table Wizyty
IF OBJECT_ID('Pacjenci', 'U') IS NOT NULL
    	drop table Pacjenci
IF OBJECT_ID('Pracownicy', 'U') IS NOT NULL
    	drop table Pracownicy
IF OBJECT_ID('Us³ugi', 'U') IS NOT NULL
    	drop table Us³ugi

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'addBadanie')
DROP PROCEDURE addBadanie
GO

IF EXISTS (
    SELECT * FROM sysobjects WHERE id = object_id(N'showDurationVisitAfterID') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
    DROP FUNCTION showDurationVisitAfterID
GO

IF EXISTS (
    SELECT * FROM sysobjects WHERE id = object_id(N'showVisitAfterPESEL') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
    DROP FUNCTION showVisitAfterPESEL
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'addSkierowanie')
DROP PROCEDURE addSkierowanie
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'addGrafikGodzinyDzienTygodnia')
DROP PROCEDURE addGrafikGodzinyDzienTygodnia
GO

IF EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'updateGrafikGodzinyDzienTygodnia')
DROP PROCEDURE updateGrafikGodzinyDzienTygodnia
GO

IF EXISTS (
    SELECT * FROM sysobjects WHERE id = object_id(N'showGrafikAfterDay') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
    DROP FUNCTION showGrafikAfterDay
GO

IF EXISTS (
    SELECT * FROM sysobjects WHERE id = object_id(N'showGrafikAfterWeek') 
    AND xtype IN (N'FN', N'IF', N'TF')
)
    DROP FUNCTION showGrafikAfterWeek
GO

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

GO
IF OBJECT_ID('TopVisitsPatients', 'V') IS NOT NULL
    DROP VIEW  TopVisitsPatients;
GO