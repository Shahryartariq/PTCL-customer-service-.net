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
                if (IsPostBack == true) return;
                if (Session["AdminID"] != null)
                {
                    int AdminID = (int)Session["AdminID"];
                    tblAdmin s = db.tblAdmins.FirstOrDefault(v => v.AdminID == AdminID);

                    Label lblUserName = new Label();
                    lblUserName.Text = s.UserName;
                    PanelUserName.Controls.Add(lblUserName);

                    Label lblFullName = new Label();
                    lblFullName.Text = s.FullName;
                    PanelFullName.Controls.Add(lblFullName);

                    Label lblEmail = new Label();
                    lblEmail.Text = s.EmailAddress;
                    PanelEmail.Controls.Add(lblEmail);

                    Label lblPhone = new Label();
                    lblPhone.Text = s.AdminPhone;

                    if (s.AdminDP != "")
                    {
                        AdminPic.ImageUrl = "UploadFiles/AdminProfile/" + s.AdminDP;
                    }
                    else
                    {
                        AdminPic.ImageUrl = "assets/img/avatar.png";
                    }
                }
            }
        }
    }
}