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
    public partial class AdminSetup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtPassword.Attributes["type"] = "password";
            txtConfirmPassword.Attributes["type"] = "password";

            using (PTCLEntities db = new PTCLEntities())
            {
                if (IsPostBack == true) return;
                if (Request.QueryString["AdminID"] != null)
                {
                    int AdminID = Convert.ToInt32(Request.QueryString["AdminID"]);
                    tblAdmin s = db.tblAdmins.FirstOrDefault(v => v.AdminID == AdminID);
                    txtUserName.Text = s.UserName;
                    txtPassword.Text = s.Password;
                    txtConfirmPassword.Text = s.Password;
                    txtFullName.Text = s.FullName;
                    txtEmailAddress.Text = s.EmailAddress;
                    txtPhone.Text = s.AdminPhone.ToString();
                    txtLocation.Text = s.Location;
                    lblUpload.Text = s.AdminDP;

                    //txtStatus.Text = s.Status;
                    //Response.Write(s.Status);

                    if (s.Status == true)
                    {
                        ddlStatus.SelectedValue = "true";
                    }
                    else
                    {
                        ddlStatus.SelectedValue = "false";
                    }
                }
                if ((Request.QueryString["profile"] == "me"))
                {
                    HypCancel.NavigateUrl = "~/ManageAccounts/Admin/AdminProfile.aspx";
                };
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

        protected void cmdCreate_Click(object sender, EventArgs e)
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                if (Request.QueryString["AdminID"] == null)
                {
                    tblAdmin s = new tblAdmin();
                    s.UserName = txtUserName.Text;
                    //s.Password = txtPassword.Text;
                    s.FullName = txtFullName.Text;
                    s.EmailAddress = txtEmailAddress.Text;
                    s.Location = txtLocation.Text;
                    s.AdminPhone = txtPhone.Text;

                    if (FileUpload.HasFile)
                    {
                        FileUpload.SaveAs(Server.MapPath("../../UploadFiles/AdminProfile/" + FileUpload.FileName));
                        s.AdminDP = FileUpload.FileName;
                    }
                    else
                    {
                        s.AdminDP = "";
                    }

                    var password = txtPassword.Text;
                    var salt = CreateSalt();
                    var hash = HashPassword(password, salt);
                    s.Password = Convert.ToBase64String(hash);

                    //s.Status = txtStatus.Text;
                    s.Status = bool.Parse(ddlStatus.SelectedValue.ToString());
                    // s.Status = Boolean.TryParse(ddlStatus.SelectedValue.ToString);
                    var check = db.uniqueEmail(txtEmailAddress.Text).ToList();
                    var check1 = db.uniqueUserName(txtUserName.Text).ToList();
                    if (check.Count == 0)
                    {
                        if (check1.Count == 0)
                        {
                            db.tblAdmins.Add(s);
                            db.SaveChanges();
                            lblMsg.Text = "Admin Inserted Successfully";
                        }
                        else
                        {
                            lblMsg.Text = "UserName Already Takken";
                        }
                    }
                    else
                        lblMsg.Text = "Email Already Takken";
                }
                else
                {
                    var password = txtPassword.Text;
                    var salt = CreateSalt();
                    var hash = HashPassword(password, salt);
                    int AdminID = Convert.ToInt32(Request.QueryString["AdminID"]);
                    tblAdmin s = db.tblAdmins.FirstOrDefault(v => v.AdminID == AdminID);
                    s.Password = Convert.ToBase64String(hash);
                    s.UserName = txtUserName.Text;
                    //s.Password = txtPassword.Text;
                    s.FullName = txtFullName.Text;
                    s.EmailAddress = txtEmailAddress.Text;
                    s.Location = txtLocation.Text;
                    s.AdminPhone = txtPhone.Text;

                    if (FileUpload.HasFile)
                    {
                        FileUpload.SaveAs(Server.MapPath("../../UploadFiles/AdminProfile/" + FileUpload.FileName));
                        s.AdminDP = FileUpload.FileName;
                    }
                    else
                    {
                        s.AdminDP = "";
                    }

                    //s.Status = txtStatus.Text;
                    s.Status = bool.Parse(ddlStatus.SelectedValue);
                    //s.Status = bool.Parse(ddlStatus.SelectedValue.ToString());
                    //s.Status = Convert.ToBoolean(ddlStatus.SelectedValue);
                    var check = db.uniqueEmail(txtEmailAddress.Text).ToList();
                    var check1 = db.uniqueUserName(txtUserName.Text).ToList();
                    if (check.Count == 1)
                    {
                        if (check1.Count == 1)
                        {
                            db.SaveChanges();
                            lblMsg.Text = "Admin Updated Successfully";
                        }
                        else
                        {
                            lblMsg.Text = "UserName Already Takken";
                        }
                    }
                    else
                        lblMsg.Text = "Email Already Takken";
                }
            }
        }
    }
}