using PtclCustomerService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Konscious.Security.Cryptography;
using System.Text;

namespace PtclCustomerService
{
    public partial class UserSignup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            /*if (IsCallback == false)
            {
                txtFirstName.Text = "";
                txtLastName.Text = "";
                txtPhone.Text = "";
                txtCnic.Text = "";
                txtEmail.Text = "";
                txtPassword.Text = "";
                txtLocation.Text = "";
            }*/
        }

        //Hashing Start

        private byte[] CreateSalt()
        {
            var buffer = new byte[16];
            string x = "SherryBSSE40";
            buffer = System.Text.Encoding.UTF8.GetBytes(x);
            return buffer;
        }

        private byte[] HashPassword(string password, byte[] salt)
        {
            var argon2 = new Argon2id(Encoding.UTF8.GetBytes(password));

            argon2.Salt = salt;
            argon2.DegreeOfParallelism = 8; // four cores
            argon2.Iterations = 4;
            argon2.MemorySize = 1024 * 1024; // 1 GB
            argon2.MemorySize = 8194;

            return argon2.GetBytes(16);
        }

        //Hashing End

        protected void cmdRegister_Click(object sender, EventArgs e)
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                tblPtclUser u = new tblPtclUser();
                u.FirstName = txtFirstName.Text;
                u.LastName = txtLastName.Text;
                u.EmailAddress = txtEmail.Text;
                u.Cnic = txtCnic.Text;
                u.Phone = txtPhone.Text;
                u.CustomerLocation = txtLocation.Text;

                if (FileUpload.HasFile)
                {
                    FileUpload.SaveAs(Server.MapPath("UploadFiles/CustomerProfile/" + FileUpload.FileName));
                    u.CustomerDP = FileUpload.FileName;
                }
                else
                {
                    u.CustomerDP = "No File Uploaded";
                }

                u.Password = txtPassword.Text;

                //hashing password start
                //var password = txtPassword.Text;
                //var salt = CreateSalt();
                //var hash = HashPassword(password, salt);
                //Response.Write(Convert.ToBase64String(hash));
                //u.Password = (Convert.ToBase64String(hash));

                //hashing password end

                var check = db.uniqueEmail(txtEmail.Text).ToList();
                //Response.Write(check.Count);

                if (check.Count == 0)
                {
                    db.tblPtclUsers.Add(u);
                    db.SaveChanges();

                    lblMsg.Text = "Registration Completed Succcessfully";
                }
                else
                    lblMsg.Text = "Email Already Takken";
            }
        }

        protected void cmdLoginUser_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserLogin.aspx");
        }

        protected void cmdLoginAdmin_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminLogin.aspx");
        }
    }
}