using PtclCustomerService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
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
            txtPassword.Attributes["placeholder"] = "Leave empty to keep your current password";
            txtConfirmPassword.Attributes["placeholder"] = "Leave empty to keep your current password";
            // the password is only changed when a new one is typed
            RFV5.Enabled = false;
            RFV6.Enabled = false;

            if (IsPostBack == true) return;
            using (PTCLEntities db = new PTCLEntities())
            {
                Locations.Fill(ddlLocationCode, db.spGetLocation().ToList());

                int UserID = Convert.ToInt32(Session["UserID"]);
                tblPtclUser s = db.tblPtclUsers.FirstOrDefault(v => v.UserID == UserID);
                txtMyName.Text = s.FirstName;
                txtLastName.Text = s.LastName;
                txtEmail.Text = s.EmailAddress;
                txtPhone.Text = s.Phone;
                txtCnic.Text = s.Cnic;
                txtStatus.Text = s.Status ? "Active" : "Inactive";
                lblUpload.Text = HttpUtility.HtmlEncode(s.CustomerDP);
                txtLandLineNumber.Text = s.landline;
                if (s.LocationID.HasValue && ddlLocationCode.Items.FindByValue(s.LocationID.ToString()) != null)
                {
                    ddlLocationCode.SelectedValue = s.LocationID.ToString();
                }
            }
        }

        protected void cmdUpdate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            using (PTCLEntities db = new PTCLEntities())
            {
                int UserID = Convert.ToInt32(Session["UserID"]);
                tblPtclUser u = db.tblPtclUsers.FirstOrDefault(v => v.UserID == UserID);

                string email = txtEmail.Text.Trim();
                string landline = txtLandLineNumber.Text.Trim();

                // taken by another customer, not by this one
                if (db.tblPtclUsers.Any(v => v.EmailAddress == email && v.UserID != UserID))
                {
                    lblMsg.Text = "Email Already Taken";
                    return;
                }
                if (db.tblPtclUsers.Any(v => v.landline == landline && v.UserID != UserID))
                {
                    lblMsg.Text = "LandLine Already Taken";
                    return;
                }

                string uploadError;
                string picture = Uploads.Save(FileUpload, "CustomerProfile", Uploads.Images, out uploadError);
                if (uploadError != null)
                {
                    lblMsg.Text = uploadError;
                    return;
                }

                u.FirstName = txtMyName.Text.Trim();
                u.LastName = txtLastName.Text.Trim();
                u.EmailAddress = email;
                u.Phone = txtPhone.Text.Trim();
                u.Cnic = txtCnic.Text.Trim();
                u.landline = landline;
                u.LocationID = Convert.ToInt32(ddlLocationCode.SelectedValue);
                if (txtPassword.Text != "")
                {
                    u.Password = PasswordHasher.Hash(txtPassword.Text);
                }
                if (picture != null)
                {
                    u.CustomerDP = picture;
                    lblUpload.Text = HttpUtility.HtmlEncode(picture);
                }

                db.SaveChanges();
                Session["FirstName"] = u.FirstName;
                lblMsg.Text = "Profile Updated Successfully";
            }
        }
    }
}
