using Konscious.Security.Cryptography;
using PtclCustomerService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class UserPanel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HyperLink activeHyp = Master.FindControl("HypProfile") as HyperLink;
            activeHyp.CssClass += " active";

            txtPassword.Attributes["type"] = "password";
            txtConfirmPassword.Attributes["type"] = "password";

            using (PTCLEntities db = new PTCLEntities())
            {
                if (IsPostBack == true) return;
                var DataLocation = db.spGetLocation().ToList();
                ddlLocationCode.DataSource = DataLocation;
                ddlLocationCode.DataTextField = "LocationCode";
                ddlLocationCode.DataValueField = "LocationID";
                ddlLocationCode.DataBind();

                if (Session["UserID"] != null)
                {
                    int UserID = Convert.ToInt32(Session["UserID"]);
                    tblPtclUser s = db.tblPtclUsers.FirstOrDefault(v => v.UserID == UserID);
                    txtMyName.Text = s.FirstName;
                    txtLastName.Text = s.LastName;
                    txtEmail.Text = s.EmailAddress;
                    txtPhone.Text = s.Phone;
                    txtCnic.Text = s.Cnic;
                    txtPassword.Text = s.Password;
                    txtConfirmPassword.Text = s.Password;
                    txtStatus.Text = s.Status.ToString();
                    //txtLocation.Text = s.CustomerLocation;
                    lblUpload.Text = s.CustomerDP;
                    txtLandLineNumber.Text = s.landline;
                    ddlLocationCode.SelectedValue = s.LocationID.ToString();
                }
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

        protected void cmdUpdate_Click(object sender, EventArgs e)
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                if (Session["UserID"] != null)
                {
                    int UserID = Convert.ToInt32(Session["UserID"]);
                    tblPtclUser u = db.tblPtclUsers.FirstOrDefault(v => v.UserID == UserID);
                    u.FirstName = txtMyName.Text;
                    u.LastName = txtLastName.Text;
                    u.EmailAddress = txtEmail.Text;
                    u.Phone = txtPhone.Text;
                    u.Cnic = txtCnic.Text;
                    //u.Password = txtPassword.Text;
                    u.landline = txtLandLineNumber.Text;

                    var password = txtPassword.Text;
                    var salt = CreateSalt();
                    var hash = HashPassword(password, salt);

                    u.LocationID = Convert.ToInt32(ddlLocationCode.SelectedValue);
                    u.Password = (Convert.ToBase64String(hash));

                    if (FileUpload.HasFile)
                    {
                        FileUpload.SaveAs(Server.MapPath("../../UploadFiles/CustomerProfile/" + FileUpload.FileName));
                        u.CustomerDP = FileUpload.FileName;
                    }
                    else
                    {
                        u.CustomerDP = "";
                    }

                    var check = db.uniqueEmail(txtEmail.Text).ToList();
                    var check1 = db.spUniqueLandline(txtLandLineNumber.Text).ToList();
                    if (check.Count == 1)
                    {
                        if (check1.Count == 1)
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

                /*var check = db.uniqueEmail(txtEmail.Text).ToList();
                var check1 = db.spUniqueLandline(txtLandLineNumber.Text).ToList();

                if (u.landline == txtLandLineNumber.Text || u.EmailAddress == txtEmail.Text)
                {
                    db.SaveChanges();
                    lblMsg.Text = "Registration Completed Succcessfully";
                }
                else if (check.Count == 0)
                {
                    if (check1.Count == 0)
                    {
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
            }*/
                
        }
    }
}
}