# PTCL Customer Service (PCS)

A complaint and billing portal for PTCL customers, with an admin panel for the support team. Customers sign up with their landline, register complaints and check their monthly bill. Admins work through the complaints, mark them solved (the customer gets an email), and manage customers, admins and reports.

I built this in 2021 as my Enterprise Application Development (EAD) semester project at university. It is a student project and is not connected to PTCL.

## Features

**Customers**
- Sign up with name, CNIC, phone, email, city and landline number, plus an optional profile picture
- Register a complaint with a type, title, description and an image or PDF attachment
- See active and closed complaints, and open the details of each one
- Raise a closed complaint again if the problem comes back. The new complaint links to the old one
- Up to 10 open complaints at a time
- Monthly bill for the current and past months, which can be downloaded as a PDF
- View and edit the profile

**Admins**
- Dashboard with the number of customers, admins and complaints
- Active, closed and regenerated complaint lists
- Complaint details with the customer's info. **Resolve** marks the complaint solved and emails the customer
- Manage admins and customers (add, edit, set inactive, delete)
- Bills for every customer
- Report of solved complaints, filtered by admin and/or city

## Tech stack

- **ASP.NET Web Forms** on .NET Framework 4.7.2, written in C#
- **Entity Framework 6** (database first) with **SQL Server Express** and stored procedures
- **Argon2id** password hashing ([Konscious.Security.Cryptography](https://github.com/kmaragon/Konscious.Security.Cryptography)), with a random salt per password
- Bootstrap 5 with the [SB Admin](https://startbootstrap.com/template/sb-admin) template, Font Awesome, DataTables and Simple DataTables
- pdfmake and html2canvas for the bill PDF
- Gmail SMTP for the "complaint resolved" email

## Run it on your PC

You need Windows with:
- **Visual Studio 2019 or 2022**, with the *ASP.NET and web development* workload
- **SQL Server Express** (the default instance `.\SQLEXPRESS`) and SQL Server Management Studio or `sqlcmd`

1. **Create the database.** Run the scripts in `Database/`, in order:
   ```
   sqlcmd -S .\SQLEXPRESS -E -i Database\01-schema.sql
   sqlcmd -S .\SQLEXPRESS -E -i Database\02-seed.sql
   sqlcmd -S .\SQLEXPRESS -E -i Database\03-demo-data.sql
   ```
   `01` creates the `PTCL` database, its tables and stored procedures. `02` adds cities, complaint types and the first admin. `03` is optional demo data.
   If your SQL Server instance has a different name, change `data source=.\SQLEXPRESS` in `Web.config`.

2. **Open `PtclCustomerService.sln`** in Visual Studio. NuGet restores the packages on the first build.

3. **Optional: emails.** Copy `Secrets.config.example` to `Secrets.config` and fill in a Gmail address and a Gmail [App Password](https://support.google.com/accounts/answer/185833). Git ignores `Secrets.config`. Without it everything works, but resolving a complaint shows that the email couldn't be sent.

4. **Press F5.** The site opens in IIS Express.

### Logins

| Who | Login | Password |
|---|---|---|
| Admin | `admin` | `Admin@123` |
| Admin (demo data) | `support` | `Support@123` |
| Customer (demo data) | `ali.raza@example.com` | `Customer@123` |

Change the admin password after the first login (Admin Profile → Edit Profile). New customers can sign up from the login page.

## Project structure

```
Complaints/        register, list and resolve complaints (User/ and Admin/)
Billing/           monthly bill for the customer, bills list and download for admins
Dashboard/         customer and admin dashboards
ManageAccounts/    profiles, admin accounts
ManageCustomers/   customer management for admins
Report/            report of solved complaints
Models/            Entity Framework model (PtclModel1.edmx) and generated classes
Database/          SQL scripts to create and fill the database
*.Master           page layouts: main site, customer panel, admin panel
AuthCookie.cs      encrypted "remember me" cookie
PasswordHasher.cs  Argon2id password hashing
Uploads.cs         checks and saves uploaded pictures and attachments
Email.cs           sends the "complaint resolved" email
```

## 2026 update

In 2026 I went back over the project without changing its design. I added the database scripts, which were never committed, so the project now runs from the repo. I also fixed bugs and security issues:

- Removed a committed email password from the code and the git history
- Pages check the login before running any of their own code, and customers can only see their own complaints
- The "remember me" cookie is encrypted, so it can't be edited to log in as someone else
- Each password has its own salt, and editing a profile no longer breaks the password or creates a duplicate account
- Uploads get unique names, a size limit and a file type check, and text from the database is HTML-encoded
- Fixed the report filters, the complaint limit and pages that crashed on missing data
