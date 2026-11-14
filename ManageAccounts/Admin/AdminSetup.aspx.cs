using PtclCustomerService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class AdminSetup : System.Web.UI.Page
    {
        private bool Editing
        {
            get { return Request.QueryString["AdminID"] != null; }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            txtPassword.Attributes["type"] = "password";
            txtConfirmPassword.Attributes["type"] = "password";
            if (Editing)
            {
                // when editing, the password is only changed if a new one is typed
                txtPassword.Attributes["placeholder"] = "Leave empty to keep the current password";
                txtConfirmPassword.Attributes["placeholder"] = "Leave empty to keep the current password";
                RFV5.Enabled = false;
                RFV6.Enabled = false;
            }

            if ((Request.QueryString["profile"] == "me"))
            {
                HypCancel.NavigateUrl = "~/ManageAccounts/Admin/AdminProfile.aspx";
            }

            if (IsPostBack == true) return;
            if (Editing)
            {
                using (PTCLEntities db = new PTCLEntities())
                {
                    int AdminID = Convert.ToInt32(Request.QueryString["AdminID"]);
                    tblAdmin s = db.tblAdmins.FirstOrDefault(v => v.AdminID == AdminID);
                    if (s == null)
                    {
                        Response.Redirect("~/Errors/404NotFound.aspx");
                    }
                    txtUserName.Text = s.UserName;
                    txtFullName.Text = s.FullName;
                    txtEmailAddress.Text = s.EmailAddress;
                    txtPhone.Text = s.AdminPhone;
                    txtLocation.Text = s.Location;
                    lblUpload.Text = HttpUtility.HtmlEncode(s.AdminDP);
                    ddlStatus.SelectedValue = s.Status ? "true" : "false";
                }
            }
        }

        protected void cmdCreate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            using (PTCLEntities db = new PTCLEntities())
            {
                int AdminID = Editing ? Convert.ToInt32(Request.QueryString["AdminID"]) : 0;
                string userName = txtUserName.Text.Trim();
                string email = txtEmailAddress.Text.Trim();

                // taken by another admin (when editing, the admin's own values are fine)
                if (db.tblAdmins.Any(v => v.UserName == userName && v.AdminID != AdminID))
                {
                    lblMsg.Text = "UserName Already Taken";
                    return;
                }
                if (db.tblAdmins.Any(v => v.EmailAddress == email && v.AdminID != AdminID))
                {
                    lblMsg.Text = "Email Already Taken";
                    return;
                }

                bool status = bool.Parse(ddlStatus.SelectedValue);
                if (Editing && AdminID == Convert.ToInt32(Session["AdminID"]) && status == false)
                {
                    lblMsg.Text = "You can't set your own account to inactive";
                    return;
                }

                string uploadError;
                string picture = Uploads.Save(FileUpload, "AdminProfile", Uploads.Images, out uploadError);
                if (uploadError != null)
                {
                    lblMsg.Text = uploadError;
                    return;
                }

                tblAdmin s;
                if (Editing)
                {
                    s = db.tblAdmins.FirstOrDefault(v => v.AdminID == AdminID);
                    if (s == null)
                    {
                        Response.Redirect("~/Errors/404NotFound.aspx");
                    }
                }
                else
                {
                    s = new tblAdmin();
                    s.AdminDP = "";
                    s.ComplaintsResolved = 0;
                }

                s.UserName = userName;
                s.FullName = txtFullName.Text.Trim();
                s.EmailAddress = email;
                s.Location = txtLocation.Text.Trim();
                s.AdminPhone = txtPhone.Text.Trim();
                s.Status = status;
                if (txtPassword.Text != "")
                {
                    s.Password = PasswordHasher.Hash(txtPassword.Text);
                }
                if (picture != null)
                {
                    s.AdminDP = picture;
                    lblUpload.Text = HttpUtility.HtmlEncode(picture);
                }

                if (Editing)
                {
                    db.SaveChanges();
                    lblMsg.Text = "Admin Updated Successfully";
                }
                else
                {
                    db.tblAdmins.Add(s);
                    db.SaveChanges();
                    lblMsg.Text = "Admin Inserted Successfully";
                    txtUserName.Text = "";
                    txtFullName.Text = "";
                    txtEmailAddress.Text = "";
                    txtLocation.Text = "";
                    txtPhone.Text = "";
                }
            }
        }
    }
}
