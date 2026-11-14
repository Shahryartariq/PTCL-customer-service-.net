/*
    PTCL Customer Service (PCS) - optional demo data
    A second admin, three customers and a few complaints, so every screen has something to show.
    Run after 01-schema.sql and 02-seed.sql. Skip it for a clean database.

        sqlcmd -S .\SQLEXPRESS -E -i Database\03-demo-data.sql

    Logins:
        admin    / Admin@123      (from 02-seed.sql)
        support  / Support@123
        ali.raza@example.com / Customer@123   (same password for all three customers)
*/

USE PTCL;
GO

IF EXISTS (SELECT 1 FROM dbo.tblPtclUser WHERE EmailAddress = N'ali.raza@example.com')
BEGIN
    PRINT 'Demo data is already there.';
    RETURN;
END

DECLARE @admin INT = (SELECT AdminID FROM dbo.tblAdmin WHERE UserName = N'admin');

INSERT INTO dbo.tblAdmin (UserName, Password, Status, FullName, EmailAddress, Location, AdminDP, AdminPhone, ComplaintsResolved)
VALUES (N'support', N'v2$Q1hyI4CHGH5xCx4F9xBsgg==$TwiLiGBW9G50xK6oZSGLOg==', 1,
        N'Sana Malik', N'sana.malik@example.com', N'Lahore', N'', N'03211234567', 0);
DECLARE @support INT = SCOPE_IDENTITY();

DECLARE @customerPassword NVARCHAR(100) = N'v2$8iS/SdnSC74qPY0VPC95CA==$WrCjLm+6gYj6byjBqffA6A==';

INSERT INTO dbo.tblPtclUser (FirstName, LastName, EmailAddress, Phone, Status, Cnic, Password, CustomerDP, LocationID, landline)
VALUES (N'Ali', N'Raza', N'ali.raza@example.com', N'03001112233', 1, N'3740512345671', @customerPassword, N'',
        (SELECT LocationID FROM dbo.tblUserLocation WHERE LocationName = N'Islamabad'), N'2345678');
DECLARE @ali INT = SCOPE_IDENTITY();

INSERT INTO dbo.tblPtclUser (FirstName, LastName, EmailAddress, Phone, Status, Cnic, Password, CustomerDP, LocationID, landline)
VALUES (N'Ayesha', N'Khan', N'ayesha.khan@example.com', N'03214445566', 1, N'3520298765432', @customerPassword, N'',
        (SELECT LocationID FROM dbo.tblUserLocation WHERE LocationName = N'Lahore'), N'5876543');
DECLARE @ayesha INT = SCOPE_IDENTITY();

INSERT INTO dbo.tblPtclUser (FirstName, LastName, EmailAddress, Phone, Status, Cnic, Password, CustomerDP, LocationID, landline)
VALUES (N'Bilal', N'Ahmed', N'bilal.ahmed@example.com', N'03337778899', 1, N'3810311223344', @customerPassword, N'',
        (SELECT LocationID FROM dbo.tblUserLocation WHERE LocationName = N'Sargodha'), N'3712345');
DECLARE @bilal INT = SCOPE_IDENTITY();

/* solved complaints */
INSERT INTO dbo.tblComplaint (ComplaintTypeID, ComplaintImage, ComplaintTitle, ComplaintDescription, UserID, ComplaintStatus, RegeneratedID, ComplaintCreationDate, AdminID)
VALUES (1, N'', N'No internet since morning', N'The DSL light on my router keeps blinking and nothing loads.', @ali, 1, NULL, DATEADD(DAY, -12, GETDATE()), @admin);
DECLARE @aliFirst INT = SCOPE_IDENTITY();

INSERT INTO dbo.tblComplaint (ComplaintTypeID, ComplaintImage, ComplaintTitle, ComplaintDescription, UserID, ComplaintStatus, RegeneratedID, ComplaintCreationDate, AdminID)
VALUES (5, N'', N'Charged twice this month', N'My bill shows the broadband package two times.', @ayesha, 1, NULL, DATEADD(DAY, -9, GETDATE()), @support),
       (4, N'', N'Crackling noise on calls', N'There is a loud noise on the landline whenever it rains.', @bilal, 1, NULL, DATEADD(DAY, -7, GETDATE()), @admin);

/* open complaints - one of them raised again because the first fix didn't last */
INSERT INTO dbo.tblComplaint (ComplaintTypeID, ComplaintImage, ComplaintTitle, ComplaintDescription, UserID, ComplaintStatus, RegeneratedID, ComplaintCreationDate, AdminID)
VALUES (1, N'', N'Internet down again', N'Same problem as last week, the connection drops every evening.', @ali, 0, @aliFirst, DATEADD(DAY, -2, GETDATE()), NULL),
       (2, N'', N'Speed is 2 Mbps on a 20 Mbps plan', N'Speed tests in the evening never go above 2 Mbps.', @ayesha, 0, NULL, DATEADD(DAY, -1, GETDATE()), NULL),
       (3, N'', N'Landline has no dial tone', N'The phone has been dead for two days.', @bilal, 0, NULL, DATEADD(HOUR, -5, GETDATE()), NULL);

UPDATE dbo.tblAdmin SET ComplaintsResolved = (SELECT COUNT(*) FROM dbo.tblComplaint c WHERE c.AdminID = tblAdmin.AdminID);
GO
