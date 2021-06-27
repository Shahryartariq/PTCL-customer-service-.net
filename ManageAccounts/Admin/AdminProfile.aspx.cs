using PtclCustomerService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class AdminProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HyperLink activeHyp = Master.FindControl("HypProfile") as HyperLink;
            activeHyp.CssClass += " active";

            using (PTCLEntities db = new PTCLEntities())
            {
                int? AdminID = null;
                if (Request.QueryString["AdminID"] != null)
                {
                    AdminID = Convert.ToInt32(Request.QueryString["AdminID"]);
                }
                else if (Session["AdminID"] != null)
                {
                    AdminID = Convert.ToInt32(Session["AdminID"]);
                }
                else
                {
                    Response.Redirect("~/Errors/Something Went Wrong.aspx");
                }

                HypProfile.NavigateUrl = "~/ManageAccounts/Admin/AdminSetup.aspx?profile=me&AdminID=" + AdminID;
                tblAdmin s = db.tblAdmins.FirstOrDefault(v => v.AdminID == AdminID);

                Label lblUserName = new Label();
                lblUserName.Text = s.UserName;
                PanelUserName.Controls.Add(lblUserName);

                Label lbllocation = new Label();
                lbllocation.Text = s.Location;
                PanelLocation.Controls.Add(lbllocation);

                Label lblFullName = new Label();
                lblFullName.Text = s.FullName;
                PanelFullName.Controls.Add(lblFullName);

                Label lblEmail = new Label();
                lblEmail.Text = s.EmailAddress;
                PanelEmail.Controls.Add(lblEmail);

                Label lblPhone = new Label();
                lblPhone.Text = s.AdminPhone;
                PanelPhone.Controls.Add(lblPhone);

                Label lblStatus = new Label();
                if (s.Status.ToString() == "True")
                {
                    lblStatus.Text = "Active";
                }
                else
                {
                    lblStatus.Text = "Inactive";
                }
                PanelStatus.Controls.Add(lblStatus);

                if (s.AdminDP != "" && s.AdminDP != null)
                {
                    AdminPic.ImageUrl = "../../UploadFiles/AdminProfile/" + s.AdminDP;
                }
                else
                {
                    AdminPic.ImageUrl = "../../assets/img/avatar.png";
                }
            }
        }
    }
}