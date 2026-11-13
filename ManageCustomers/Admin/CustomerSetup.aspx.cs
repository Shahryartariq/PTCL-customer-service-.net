using PtclCustomerService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class UserSetup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtPassword.Attributes["type"] = "password";
            txtConfirmPassword.Attributes["type"] = "password";
            // the customer's password is only changed when the admin types a new one
            txtPassword.Attributes["placeholder"] = "Leave empty to keep the current password";
            txtConfirmPassword.Attributes["placeholder"] = "Leave empty to keep the current password";
            RFV5.Enabled = false;
            RFV6.Enabled = false;

            if (Request.QueryString["UserID"] == null)
            {
                Response.Redirect("~/ManageCustomers/Admin/AdminManageCustomers.aspx");
            }
            int UserID = Convert.ToInt32(Request.QueryString["UserID"]);

            if (Request.QueryString["back"] == "1")
            {
                HypGoBack.NavigateUrl = "~/ManageAccounts/Admin/AdminCustomersProfile.aspx?UserID=" + UserID + "&ComplaintID=" + Convert.ToInt32(Request.QueryString["ComplaintID"]);
            }
            else
            {
                HypGoBack.NavigateUrl = "~/ManageCustomers/Admin/AdminManageCustomers.aspx";
            }

            if (IsPostBack == true) return;
            using (PTCLEntities db = new PTCLEntities())
            {
                tblPtclUser s = db.tblPtclUsers.FirstOrDefault(v => v.UserID == UserID);
                if (s == null)
                {
                    Response.Redirect("~/Errors/404NotFound.aspx");
                }
                txtFirstName.Text = s.FirstName;
                txtLastName.Text = s.LastName;
                txtEmail.Text = s.EmailAddress;
                txtPhone.Text = s.Phone;
                txtCnic.Text = s.Cnic;
                lblCustomer.Text = "Manage " + HttpUtility.HtmlEncode(s.FirstName);
                ddlStatus.SelectedValue = s.Status ? "1" : "0";
            }
        }

        protected void cmdSubmit_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            using (PTCLEntities db = new PTCLEntities())
            {
                int UserID = Convert.ToInt32(Request.QueryString["UserID"]);
                tblPtclUser s = db.tblPtclUsers.FirstOrDefault(v => v.UserID == UserID);
                if (s == null)
                {
                    Response.Redirect("~/Errors/404NotFound.aspx");
                }

                string email = txtEmail.Text.Trim();
                if (db.tblPtclUsers.Any(v => v.EmailAddress == email && v.UserID != UserID))
                {
                    lblMsg.Text = "Email Already Taken";
                    return;
                }

                s.FirstName = txtFirstName.Text.Trim();
                s.LastName = txtLastName.Text.Trim();
                s.EmailAddress = email;
                s.Phone = txtPhone.Text.Trim();
                s.Status = ddlStatus.SelectedValue == "1";
                s.Cnic = txtCnic.Text.Trim();
                if (txtPassword.Text != "")
                {
                    s.Password = PasswordHasher.Hash(txtPassword.Text);
                }
                db.SaveChanges();
                lblCustomer.Text = "Manage " + HttpUtility.HtmlEncode(s.FirstName);
                lblMsg.Text = "Customer Updated Successfully";
            }
        }
    }
}
