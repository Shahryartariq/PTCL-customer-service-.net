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

            using (PTCLEntities db = new PTCLEntities())
            {
                if (IsPostBack == true) return;
                if (Request.QueryString["UserID"] != null)
                {
                    int UserID = Convert.ToInt32(Request.QueryString["UserID"]);
                    tblPtclUser s = db.tblPtclUsers.FirstOrDefault(v => v.UserID == UserID);
                    txtFirstName.Text = s.FirstName;
                    txtLastName.Text = s.LastName;
                    txtEmail.Text = s.EmailAddress;
                    txtPhone.Text = s.Phone;
                    //txtStatus.Text = s.Status.ToString();
                    txtCnic.Text = s.Cnic;
                    txtPassword.Text = s.Password;
                    txtConfirmPassword.Text = s.Password;
                    lblCustomer.Text = "Manage " + s.FirstName;

                    //Response.Write(s.Status);
                    if (Convert.ToInt32(s.Status) == 1)
                    {
                        ddlStatus.SelectedValue = "1";
                    }
                    else
                    {
                        ddlStatus.SelectedValue = "0";
                    }
                    if (Request.QueryString["back"] == "1")
                    {
                        HypGoBack.NavigateUrl = "~/ManageAccounts/Admin/AdminCustomersProfile.aspx?UserID=" + UserID + "&ComplaintID=" + Request.QueryString["ComplaintID"];
                    }
                    else
                    {
                        HypGoBack.NavigateUrl = "~/ManageCustomers/Admin/AdminManageCustomers.aspx";
                    }
                }
            }
        }

        protected void cmdSubmit_Click(object sender, EventArgs e)
        {
            if (Request.QueryString["UserID"] != null)
            {
                using (PTCLEntities db = new PTCLEntities())
                {
                    int UserID = Convert.ToInt32(Request.QueryString["UserID"]);
                    tblPtclUser s = db.tblPtclUsers.FirstOrDefault(v => v.UserID == UserID);
                    s.FirstName = txtFirstName.Text;
                    s.LastName = txtLastName.Text;
                    s.EmailAddress = txtEmail.Text;
                    s.Phone = txtPhone.Text;
                    //s.Status = bool.Parse(txtStatus.Text);
                    s.Status = bool.Parse(ddlStatus.SelectedItem.Text);
                    //s.Status = ddlStatus.SelectedValue.ToString();

                    s.Cnic = txtCnic.Text;
                    s.Password = txtPassword.Text;
                    s.Password = txtConfirmPassword.Text;
                    db.SaveChanges();
                    lblMsg.Text = "Customer Updated Successfully";
                }
            }
        }
    }
}