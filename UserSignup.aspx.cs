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
            using (PTCLEntities db = new PTCLEntities())
            {
                if (IsPostBack == true) return;
                var LocationData = db.spGetLocation().ToList();
                ddlLocationCode.DataSource = LocationData;
                ddlLocationCode.DataTextField = "LocationCode";
                ddlLocationCode.DataValueField = "LocationID";
                ddlLocationCode.DataBind();
            }
        }

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
            argon2.MemorySize = 1024;
            argon2.MemorySize = 8194;

            return argon2.GetBytes(16);
        }

        //Hashing End8 */

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
                u.Status = true;

                u.landline = txtLandLineNumber.Text;

                //Location Code
                u.LocationID = Convert.ToInt32(ddlLocationCode.SelectedValue);

                if (FileUpload.HasFile)
                {
                    FileUpload.SaveAs(Server.MapPath("UploadFiles/CustomerProfile/" + FileUpload.FileName));
                    u.CustomerDP = FileUpload.FileName;
                }
                else
                {
                    u.CustomerDP = "";
                }

                //u.Password = txtPassword.Text;

                //hashing password start
                var password = txtPassword.Text;
                var salt = CreateSalt();
                var hash = HashPassword(password, salt);
                //Response.Write(Convert.ToBase64String(hash));
                u.Password = (Convert.ToBase64String(hash));

                //hashing password end

                var check = db.uniqueEmail(txtEmail.Text).ToList();
                var check1 = db.spUniqueLandline(txtLandLineNumber.Text).ToList();
                //Response.Write(check.Count);

                if (check.Count == 0)
                {
                    if (check1.Count == 0)
                    {
                        db.tblPtclUsers.Add(u);
                        db.SaveChanges();
                        lblMsg.Text = "Registration Completed Succcessfully";
                    }
                    else
                    {
                        lblMsg.Text = "LandLine Already Takken";
                    }
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