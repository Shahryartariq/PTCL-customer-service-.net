/*
    PTCL Customer Service (PCS) - starting data
    Cities with their dialling codes, complaint types and the first admin account.
    Safe to run more than once.

        sqlcmd -S .\SQLEXPRESS -E -i Database\02-seed.sql

    First admin login:  admin / Admin@123   (change it from Admin Profile after signing in)
*/

USE PTCL;
GO

/* cities (LocationCode is the landline dialling code without the 0) */
IF NOT EXISTS (SELECT 1 FROM dbo.tblUserLocation)
BEGIN
    INSERT INTO dbo.tblUserLocation (LocationCode, LocationName, Locationprovince) VALUES
        (51, N'Islamabad',   N'Islamabad Capital Territory'),
        (51, N'Rawalpindi',  N'Punjab'),
        (42, N'Lahore',      N'Punjab'),
        (21, N'Karachi',     N'Sindh'),
        (41, N'Faisalabad',  N'Punjab'),
        (61, N'Multan',      N'Punjab'),
        (48, N'Sargodha',    N'Punjab'),
        (55, N'Gujranwala',  N'Punjab'),
        (52, N'Sialkot',     N'Punjab'),
        (62, N'Bahawalpur',  N'Punjab'),
        (22, N'Hyderabad',   N'Sindh'),
        (91, N'Peshawar',    N'Khyber Pakhtunkhwa'),
        (81, N'Quetta',      N'Balochistan');
END
GO

/* complaint types - the register form selects number 7 ("Other") by default */
IF NOT EXISTS (SELECT 1 FROM dbo.tblComplaintType)
BEGIN
    SET IDENTITY_INSERT dbo.tblComplaintType ON;
    INSERT INTO dbo.tblComplaintType (ComplaintTypeID, ComplaintTypeName) VALUES
        (1, N'Internet not working'),
        (2, N'Slow internet speed'),
        (3, N'Landline dead / no dial tone'),
        (4, N'Noise on the line'),
        (5, N'Billing issue'),
        (6, N'Smart TV / IPTV'),
        (7, N'Other');
    SET IDENTITY_INSERT dbo.tblComplaintType OFF;
END
GO

/* first admin: admin / Admin@123 */
IF NOT EXISTS (SELECT 1 FROM dbo.tblAdmin WHERE UserName = N'admin')
BEGIN
    INSERT INTO dbo.tblAdmin (UserName, Password, Status, FullName, EmailAddress, Location, AdminDP, AdminPhone, ComplaintsResolved)
    VALUES (N'admin', N'v2$6OzLe6EsDCIf13vChKepaw==$G1P0riuEWS9y04QEGYHGmg==', 1,
            N'PCS Admin', N'admin@example.com', N'Islamabad', N'', N'03001234567', 0);
END
GO
