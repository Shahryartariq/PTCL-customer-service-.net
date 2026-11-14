/*
    PTCL Customer Service (PCS) - database schema
    Creates the PTCL database, its tables and the stored procedures the app calls
    through Entity Framework (Models/PtclModel1.edmx).

    Run on SQL Server Express (2012 or newer), e.g. in SQL Server Management Studio,
    or from a terminal:
        sqlcmd -S .\SQLEXPRESS -E -i Database\01-schema.sql
*/

IF DB_ID('PTCL') IS NULL
    CREATE DATABASE PTCL;
GO

USE PTCL;
GO

/* ---------------------------------------------------------------- tables */

IF OBJECT_ID('dbo.tblUserLocation', 'U') IS NULL
CREATE TABLE dbo.tblUserLocation
(
    LocationID       INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_tblUserLocation PRIMARY KEY,
    LocationCode     INT NULL,
    LocationName     NVARCHAR(50) NULL,
    Locationprovince NVARCHAR(50) NULL
);
GO

IF OBJECT_ID('dbo.tblComplaintType', 'U') IS NULL
CREATE TABLE dbo.tblComplaintType
(
    ComplaintTypeID   INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_tblComplaintType PRIMARY KEY,
    ComplaintTypeName NVARCHAR(50) NULL
);
GO

IF OBJECT_ID('dbo.tblAdmin', 'U') IS NULL
CREATE TABLE dbo.tblAdmin
(
    AdminID            INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_tblAdmin PRIMARY KEY,
    UserName           NVARCHAR(100) NOT NULL CONSTRAINT UQ_tblAdmin_UserName UNIQUE,
    Password           NVARCHAR(100) NOT NULL,
    Status             BIT NOT NULL CONSTRAINT DF_tblAdmin_Status DEFAULT (1),
    FullName           NVARCHAR(50) NULL,
    EmailAddress       NVARCHAR(50) NULL,
    Location           NVARCHAR(50) NULL,
    AdminDP            NVARCHAR(100) NULL,
    AdminPhone         NVARCHAR(50) NULL,
    ComplaintsResolved INT NULL CONSTRAINT DF_tblAdmin_ComplaintsResolved DEFAULT (0)
);
GO

IF OBJECT_ID('dbo.tblPtclUser', 'U') IS NULL
CREATE TABLE dbo.tblPtclUser
(
    UserID       INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_tblPtclUser PRIMARY KEY,
    FirstName    NVARCHAR(100) NOT NULL,
    LastName     NVARCHAR(100) NOT NULL,
    EmailAddress NVARCHAR(100) NOT NULL CONSTRAINT UQ_tblPtclUser_EmailAddress UNIQUE,
    Phone        NVARCHAR(100) NOT NULL,
    Status       BIT NOT NULL CONSTRAINT DF_tblPtclUser_Status DEFAULT (1),
    Cnic         NVARCHAR(100) NOT NULL,
    Password     NVARCHAR(100) NOT NULL,
    CustomerDP   NVARCHAR(100) NULL,
    LocationID   INT NULL CONSTRAINT FK_tblPtclUser_tblUserLocation
                     REFERENCES dbo.tblUserLocation (LocationID),
    landline     NVARCHAR(50) NULL
);
GO

IF OBJECT_ID('dbo.tblComplaint', 'U') IS NULL
CREATE TABLE dbo.tblComplaint
(
    ComplaintID           INT IDENTITY(1,1) NOT NULL CONSTRAINT PK_tblComplaint PRIMARY KEY,
    ComplaintTypeID       INT NOT NULL CONSTRAINT FK_tblComplaint_tblComplaintType
                              REFERENCES dbo.tblComplaintType (ComplaintTypeID),
    ComplaintImage        NVARCHAR(200) NULL,
    ComplaintTitle        NVARCHAR(200) NULL,
    ComplaintDescription  NVARCHAR(1000) NULL,
    UserID                INT NULL CONSTRAINT FK_tblComplaint_tblPtclUser
                              REFERENCES dbo.tblPtclUser (UserID),
    ComplaintStatus       BIT NULL CONSTRAINT DF_tblComplaint_ComplaintStatus DEFAULT (0),
    RegeneratedID         INT NULL,   -- the closed complaint this one was raised again from
    ComplaintCreationDate DATETIME NULL CONSTRAINT DF_tblComplaint_ComplaintCreationDate DEFAULT (GETDATE()),
    AdminID               INT NULL CONSTRAINT FK_tblComplaint_tblAdmin
                              REFERENCES dbo.tblAdmin (AdminID)
);
GO

IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_tblComplaint_UserID')
    CREATE INDEX IX_tblComplaint_UserID ON dbo.tblComplaint (UserID);
IF NOT EXISTS (SELECT 1 FROM sys.indexes WHERE name = 'IX_tblPtclUser_landline')
    CREATE INDEX IX_tblPtclUser_landline ON dbo.tblPtclUser (landline);
GO

/* ------------------------------------------------- customers and admins */

IF OBJECT_ID('dbo.PtclUserLogin', 'P') IS NOT NULL DROP PROCEDURE dbo.PtclUserLogin;
GO
CREATE PROCEDURE dbo.PtclUserLogin
    @Email VARCHAR(100),
    @Password VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT UserID, FirstName, LastName, EmailAddress, Phone, Status, Cnic, Password,
           CustomerDP, LocationID, landline
    FROM dbo.tblPtclUser
    WHERE EmailAddress = @Email AND Password = @Password AND Status = 1;
END
GO

IF OBJECT_ID('dbo.PtclAdminLogin', 'P') IS NOT NULL DROP PROCEDURE dbo.PtclAdminLogin;
GO
CREATE PROCEDURE dbo.PtclAdminLogin
    @UserName NVARCHAR(100),
    @Password NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT AdminID, UserName, Password, Status, FullName, EmailAddress, Location, AdminDP, AdminPhone
    FROM dbo.tblAdmin
    WHERE UserName = @UserName AND Password = @Password AND Status = 1;
END
GO

IF OBJECT_ID('dbo.GetPtclUsers', 'P') IS NOT NULL DROP PROCEDURE dbo.GetPtclUsers;
GO
CREATE PROCEDURE dbo.GetPtclUsers
AS
BEGIN
    SET NOCOUNT ON;
    SELECT UserID, FirstName, LastName, EmailAddress, Phone, Status, Cnic, Password,
           CustomerDP, LocationID, landline
    FROM dbo.tblPtclUser
    ORDER BY UserID DESC;
END
GO

IF OBJECT_ID('dbo.GetPtclAdmins', 'P') IS NOT NULL DROP PROCEDURE dbo.GetPtclAdmins;
GO
CREATE PROCEDURE dbo.GetPtclAdmins
AS
BEGIN
    SET NOCOUNT ON;
    SELECT AdminID, UserName, Password, Status, FullName, EmailAddress, Location, AdminDP, AdminPhone
    FROM dbo.tblAdmin
    ORDER BY AdminID;
END
GO

IF OBJECT_ID('dbo.uniqueEmail', 'P') IS NOT NULL DROP PROCEDURE dbo.uniqueEmail;
GO
CREATE PROCEDURE dbo.uniqueEmail
    @Email VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT UserID, FirstName, LastName, EmailAddress, Phone, Status, Cnic, Password,
           CustomerDP, LocationID, landline
    FROM dbo.tblPtclUser
    WHERE EmailAddress = @Email;
END
GO

IF OBJECT_ID('dbo.spUniqueLandline', 'P') IS NOT NULL DROP PROCEDURE dbo.spUniqueLandline;
GO
CREATE PROCEDURE dbo.spUniqueLandline
    @landline VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT UserID, FirstName, LastName, EmailAddress, Phone, Status, Cnic, Password,
           CustomerDP, LocationID, landline
    FROM dbo.tblPtclUser
    WHERE landline = @landline;
END
GO

IF OBJECT_ID('dbo.uniqueUserName', 'P') IS NOT NULL DROP PROCEDURE dbo.uniqueUserName;
GO
CREATE PROCEDURE dbo.uniqueUserName
    @userName NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;
    SELECT AdminID, UserName, Password, Status, FullName, EmailAddress, Location, AdminDP, AdminPhone
    FROM dbo.tblAdmin
    WHERE UserName = @userName;
END
GO

IF OBJECT_ID('dbo.DeletePtlcUser', 'P') IS NOT NULL DROP PROCEDURE dbo.DeletePtlcUser;
GO
CREATE PROCEDURE dbo.DeletePtlcUser
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
        DELETE FROM dbo.tblComplaint WHERE UserID = @UserID;
        DELETE FROM dbo.tblPtclUser WHERE UserID = @UserID;
    COMMIT TRANSACTION;
END
GO

IF OBJECT_ID('dbo.DeletePtclAdmin', 'P') IS NOT NULL DROP PROCEDURE dbo.DeletePtclAdmin;
GO
CREATE PROCEDURE dbo.DeletePtclAdmin
    @AdminID INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
        -- keep the complaints this admin resolved, just without the admin
        UPDATE dbo.tblComplaint SET AdminID = NULL WHERE AdminID = @AdminID;
        DELETE FROM dbo.tblAdmin WHERE AdminID = @AdminID;
    COMMIT TRANSACTION;
END
GO

/* -------------------------------------------------- locations and types */

IF OBJECT_ID('dbo.spGetLocation', 'P') IS NOT NULL DROP PROCEDURE dbo.spGetLocation;
GO
CREATE PROCEDURE dbo.spGetLocation
AS
BEGIN
    SET NOCOUNT ON;
    SELECT LocationID, LocationCode, LocationName
    FROM dbo.tblUserLocation
    ORDER BY LocationName;
END
GO

IF OBJECT_ID('dbo.spUserWithLocation', 'P') IS NOT NULL DROP PROCEDURE dbo.spUserWithLocation;
GO
CREATE PROCEDURE dbo.spUserWithLocation
AS
BEGIN
    SET NOCOUNT ON;
    SELECT u.UserID, u.FirstName, u.LastName, u.LocationID, u.landline,
           l.LocationName, u.EmailAddress, l.LocationCode
    FROM dbo.tblPtclUser u
    LEFT JOIN dbo.tblUserLocation l ON l.LocationID = u.LocationID
    ORDER BY u.UserID DESC;
END
GO

IF OBJECT_ID('dbo.GetComplaintType', 'P') IS NOT NULL DROP PROCEDURE dbo.GetComplaintType;
GO
CREATE PROCEDURE dbo.GetComplaintType
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ComplaintTypeID, ComplaintTypeName
    FROM dbo.tblComplaintType
    ORDER BY ComplaintTypeID;
END
GO

/* ------------------------------------------------------------ complaints */

-- every complaint (admin dashboard total)
IF OBJECT_ID('dbo.GetComplaints', 'P') IS NOT NULL DROP PROCEDURE dbo.GetComplaints;
GO
CREATE PROCEDURE dbo.GetComplaints
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ComplaintID, ComplaintTypeID, ComplaintImage, ComplaintTitle, ComplaintDescription,
           UserID, ComplaintStatus, RegeneratedID, ComplaintCreationDate
    FROM dbo.tblComplaint
    ORDER BY ComplaintCreationDate DESC;
END
GO

IF OBJECT_ID('dbo.GetComplaintbyCID', 'P') IS NOT NULL DROP PROCEDURE dbo.GetComplaintbyCID;
GO
CREATE PROCEDURE dbo.GetComplaintbyCID
    @ComplaintID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ComplaintID, ComplaintTypeID, ComplaintImage, ComplaintTitle, ComplaintDescription,
           UserID, ComplaintStatus, RegeneratedID, ComplaintCreationDate
    FROM dbo.tblComplaint
    WHERE ComplaintID = @ComplaintID;
END
GO

IF OBJECT_ID('dbo.ComplaintDetailsByCID', 'P') IS NOT NULL DROP PROCEDURE dbo.ComplaintDetailsByCID;
GO
CREATE PROCEDURE dbo.ComplaintDetailsByCID
    @ComplaintID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT c.ComplaintTitle, c.RegeneratedID, c.ComplaintCreationDate, c.ComplaintID, c.ComplaintStatus,
           c.UserID, t.ComplaintTypeName, u.FirstName, u.EmailAddress, u.CustomerDP
    FROM dbo.tblComplaint c
    INNER JOIN dbo.tblComplaintType t ON t.ComplaintTypeID = c.ComplaintTypeID
    LEFT JOIN dbo.tblPtclUser u ON u.UserID = c.UserID
    WHERE c.ComplaintID = @ComplaintID;
END
GO

-- all of one customer's complaints
IF OBJECT_ID('dbo.GetMyComplaints', 'P') IS NOT NULL DROP PROCEDURE dbo.GetMyComplaints;
GO
CREATE PROCEDURE dbo.GetMyComplaints
    @userID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ComplaintID, ComplaintTypeID, ComplaintImage, ComplaintTitle, ComplaintDescription,
           UserID, ComplaintStatus, RegeneratedID, ComplaintCreationDate
    FROM dbo.tblComplaint
    WHERE UserID = @userID
    ORDER BY ComplaintCreationDate DESC;
END
GO

-- one customer's complaints that are not solved yet
IF OBJECT_ID('dbo.GetCustomerActiveComplaint', 'P') IS NOT NULL DROP PROCEDURE dbo.GetCustomerActiveComplaint;
GO
CREATE PROCEDURE dbo.GetCustomerActiveComplaint
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ComplaintID, ComplaintTypeID, ComplaintImage, ComplaintTitle, ComplaintDescription,
           UserID, ComplaintStatus, RegeneratedID, ComplaintCreationDate
    FROM dbo.tblComplaint
    WHERE UserID = @UserID AND ISNULL(ComplaintStatus, 0) = 0
    ORDER BY ComplaintCreationDate DESC;
END
GO

IF OBJECT_ID('dbo.UserPendingComplaints', 'P') IS NOT NULL DROP PROCEDURE dbo.UserPendingComplaints;
GO
CREATE PROCEDURE dbo.UserPendingComplaints
    @userID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT c.ComplaintTitle, c.RegeneratedID, c.ComplaintCreationDate, c.ComplaintID, c.ComplaintStatus,
           c.ComplaintImage, c.UserID, t.ComplaintTypeName, u.FirstName
    FROM dbo.tblComplaint c
    INNER JOIN dbo.tblComplaintType t ON t.ComplaintTypeID = c.ComplaintTypeID
    INNER JOIN dbo.tblPtclUser u ON u.UserID = c.UserID
    WHERE c.UserID = @userID AND ISNULL(c.ComplaintStatus, 0) = 0
    ORDER BY c.ComplaintCreationDate DESC;
END
GO

IF OBJECT_ID('dbo.MyApprovedComplaint', 'P') IS NOT NULL DROP PROCEDURE dbo.MyApprovedComplaint;
GO
CREATE PROCEDURE dbo.MyApprovedComplaint
    @UserID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT c.ComplaintTitle, c.RegeneratedID, c.ComplaintCreationDate, c.ComplaintID, c.ComplaintStatus,
           c.ComplaintImage, c.UserID, t.ComplaintTypeName, u.FirstName
    FROM dbo.tblComplaint c
    INNER JOIN dbo.tblComplaintType t ON t.ComplaintTypeID = c.ComplaintTypeID
    INNER JOIN dbo.tblPtclUser u ON u.UserID = c.UserID
    WHERE c.UserID = @UserID AND c.ComplaintStatus = 1
    ORDER BY c.ComplaintCreationDate DESC;
END
GO

-- admin: complaints still open
IF OBJECT_ID('dbo.ActiveC', 'P') IS NOT NULL DROP PROCEDURE dbo.ActiveC;
GO
CREATE PROCEDURE dbo.ActiveC
AS
BEGIN
    SET NOCOUNT ON;
    SELECT c.ComplaintTitle, c.RegeneratedID, c.ComplaintCreationDate, c.ComplaintID, c.ComplaintStatus,
           c.UserID, t.ComplaintTypeName, u.FirstName
    FROM dbo.tblComplaint c
    INNER JOIN dbo.tblComplaintType t ON t.ComplaintTypeID = c.ComplaintTypeID
    LEFT JOIN dbo.tblPtclUser u ON u.UserID = c.UserID
    WHERE ISNULL(c.ComplaintStatus, 0) = 0
    ORDER BY c.ComplaintCreationDate DESC;
END
GO

-- admin: solved complaints
IF OBJECT_ID('dbo.AdminApprovedComplaint', 'P') IS NOT NULL DROP PROCEDURE dbo.AdminApprovedComplaint;
GO
CREATE PROCEDURE dbo.AdminApprovedComplaint
AS
BEGIN
    SET NOCOUNT ON;
    SELECT c.ComplaintTitle, c.RegeneratedID, c.ComplaintCreationDate, c.ComplaintID, c.ComplaintStatus,
           c.UserID, t.ComplaintTypeName, u.FirstName
    FROM dbo.tblComplaint c
    INNER JOIN dbo.tblComplaintType t ON t.ComplaintTypeID = c.ComplaintTypeID
    LEFT JOIN dbo.tblPtclUser u ON u.UserID = c.UserID
    WHERE c.ComplaintStatus = 1
    ORDER BY c.ComplaintCreationDate DESC;
END
GO

-- admin: complaints raised again from a closed one
IF OBJECT_ID('dbo.spGetRegeneratedComplaints', 'P') IS NOT NULL DROP PROCEDURE dbo.spGetRegeneratedComplaints;
GO
CREATE PROCEDURE dbo.spGetRegeneratedComplaints
AS
BEGIN
    SET NOCOUNT ON;
    SELECT c.ComplaintTitle, c.RegeneratedID, c.ComplaintCreationDate, c.ComplaintID, c.ComplaintStatus,
           c.UserID, t.ComplaintTypeName, u.FirstName
    FROM dbo.tblComplaint c
    INNER JOIN dbo.tblComplaintType t ON t.ComplaintTypeID = c.ComplaintTypeID
    LEFT JOIN dbo.tblPtclUser u ON u.UserID = c.UserID
    WHERE ISNULL(c.RegeneratedID, 0) > 0
    ORDER BY c.ComplaintCreationDate DESC;
END
GO

IF OBJECT_ID('dbo.RegeneratedComplaints', 'P') IS NOT NULL DROP PROCEDURE dbo.RegeneratedComplaints;
GO
CREATE PROCEDURE dbo.RegeneratedComplaints
AS
BEGIN
    SET NOCOUNT ON;
    SELECT ComplaintID, ComplaintTypeID, ComplaintImage, ComplaintTitle, ComplaintDescription,
           UserID, ComplaintStatus, RegeneratedID, ComplaintCreationDate
    FROM dbo.tblComplaint
    WHERE ISNULL(RegeneratedID, 0) > 0
    ORDER BY ComplaintCreationDate DESC;
END
GO

IF OBJECT_ID('dbo.DeleteComplaint', 'P') IS NOT NULL DROP PROCEDURE dbo.DeleteComplaint;
GO
CREATE PROCEDURE dbo.DeleteComplaint
    @ComplaintID INT
AS
BEGIN
    SET NOCOUNT ON;
    DELETE FROM dbo.tblComplaint WHERE ComplaintID = @ComplaintID;
END
GO

IF OBJECT_ID('dbo.temp', 'P') IS NOT NULL DROP PROCEDURE dbo.temp;
GO
CREATE PROCEDURE dbo.temp
AS
BEGIN
    SET NOCOUNT ON;
    SELECT c.ComplaintTitle, c.ComplaintID, c.ComplaintStatus, c.UserID, t.ComplaintTypeName, u.FirstName
    FROM dbo.tblComplaint c
    INNER JOIN dbo.tblComplaintType t ON t.ComplaintTypeID = c.ComplaintTypeID
    LEFT JOIN dbo.tblPtclUser u ON u.UserID = c.UserID;
END
GO

/* --------------------------------------------------------------- reports */
/* Solved complaints with who solved them, filtered by admin and/or the customer's city. */

IF OBJECT_ID('dbo.spReportData', 'P') IS NOT NULL DROP PROCEDURE dbo.spReportData;
GO
CREATE PROCEDURE dbo.spReportData
AS
BEGIN
    SET NOCOUNT ON;
    SELECT c.ComplaintTitle, c.ComplaintCreationDate, c.ComplaintID, c.ComplaintStatus, c.UserID, c.AdminID,
           t.ComplaintTypeName, u.FirstName, a.FullName, u.LocationID
    FROM dbo.tblComplaint c
    INNER JOIN dbo.tblComplaintType t ON t.ComplaintTypeID = c.ComplaintTypeID
    LEFT JOIN dbo.tblPtclUser u ON u.UserID = c.UserID
    LEFT JOIN dbo.tblAdmin a ON a.AdminID = c.AdminID
    WHERE c.ComplaintStatus = 1
    ORDER BY c.ComplaintCreationDate DESC;
END
GO

IF OBJECT_ID('dbo.spFilterAdminOnly', 'P') IS NOT NULL DROP PROCEDURE dbo.spFilterAdminOnly;
GO
CREATE PROCEDURE dbo.spFilterAdminOnly
    @adminID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT c.ComplaintTitle, c.ComplaintCreationDate, c.ComplaintID, c.ComplaintStatus, c.UserID, c.AdminID,
           t.ComplaintTypeName, u.FirstName, a.FullName, u.LocationID
    FROM dbo.tblComplaint c
    INNER JOIN dbo.tblComplaintType t ON t.ComplaintTypeID = c.ComplaintTypeID
    LEFT JOIN dbo.tblPtclUser u ON u.UserID = c.UserID
    LEFT JOIN dbo.tblAdmin a ON a.AdminID = c.AdminID
    WHERE c.ComplaintStatus = 1 AND c.AdminID = @adminID
    ORDER BY c.ComplaintCreationDate DESC;
END
GO

IF OBJECT_ID('dbo.spFilterLocationOnly', 'P') IS NOT NULL DROP PROCEDURE dbo.spFilterLocationOnly;
GO
CREATE PROCEDURE dbo.spFilterLocationOnly
    @locationID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT c.ComplaintTitle, c.ComplaintCreationDate, c.ComplaintID, c.ComplaintStatus, c.UserID, c.AdminID,
           t.ComplaintTypeName, u.FirstName, a.FullName, u.LocationID
    FROM dbo.tblComplaint c
    INNER JOIN dbo.tblComplaintType t ON t.ComplaintTypeID = c.ComplaintTypeID
    LEFT JOIN dbo.tblPtclUser u ON u.UserID = c.UserID
    LEFT JOIN dbo.tblAdmin a ON a.AdminID = c.AdminID
    WHERE c.ComplaintStatus = 1 AND u.LocationID = @locationID
    ORDER BY c.ComplaintCreationDate DESC;
END
GO

IF OBJECT_ID('dbo.spFilterAdminWithLocation', 'P') IS NOT NULL DROP PROCEDURE dbo.spFilterAdminWithLocation;
GO
CREATE PROCEDURE dbo.spFilterAdminWithLocation
    @adminID INT,
    @locationID INT
AS
BEGIN
    SET NOCOUNT ON;
    SELECT c.ComplaintTitle, c.ComplaintCreationDate, c.ComplaintID, c.ComplaintStatus, c.UserID, c.AdminID,
           t.ComplaintTypeName, u.FirstName, a.FullName, u.LocationID
    FROM dbo.tblComplaint c
    INNER JOIN dbo.tblComplaintType t ON t.ComplaintTypeID = c.ComplaintTypeID
    LEFT JOIN dbo.tblPtclUser u ON u.UserID = c.UserID
    LEFT JOIN dbo.tblAdmin a ON a.AdminID = c.AdminID
    WHERE c.ComplaintStatus = 1 AND c.AdminID = @adminID AND u.LocationID = @locationID
    ORDER BY c.ComplaintCreationDate DESC;
END
GO
