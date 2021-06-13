using PtclCustomerService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService.ManageAccounts.User
{
    public partial class UserProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HyperLink activeHyp = Master.FindControl("HypProfile") as HyperLink;
            activeHyp.CssClass += " active";

            using (PTCLEntities db = new PTCLEntities())
            {
                if (IsPostBack == true) return;
                if (Session["UserID"] != null)
                {
                    int UserID = (int)Session["UserID"];
                    tblPtclUser s = db.tblPtclUsers.FirstOrDefault(v => v.UserID == UserID);

                    Label lblFirstName = new Label();
                    lblFirstName.Text = s.FirstName;
                    PanelFirstName.Controls.Add(lblFirstName);

                    Label lblLocation = new Label();
                    lblLocation.Text = s.CustomerLocation;
                    PanelLocation.Controls.Add(lblLocation);

                    Label LblFullName = new Label();
                    LblFullName.Text = s.FirstName + " " + s.LastName;
                    PanelFullName.Controls.Add(LblFullName);

                    Label lblEmail = new Label();
                    lblEmail.Text = s.EmailAddress;
                    PanelEmail.Controls.Add(lblEmail);

                    Label lblCnic = new Label();
                    lblCnic.Text = s.Cnic;
                    PanelCnic.Controls.Add(lblCnic);

                    Label lblPhone = new Label();
                    lblPhone.Text = s.Phone;
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

                    if (s.CustomerDP != "" && s.CustomerDP != null)
                    {
                        userPic.ImageUrl = "../../UploadFiles/CustomerProfile/" + s.CustomerDP;
                    }
                    else
                    {
                        userPic.ImageUrl = "../../assets/img/avatar.png";
                    }
                }
            }
        }
    }
}