using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class MainMaster : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                if (Session["AdminID"] == null)
                {
                    Response.Redirect("UserLogin.aspx");
                }
                HypLogin.Text = null;
                HypLogout.Text = "Logout";
                HypUserPanel.Text = "";
                HypAdminPanel.Text = "Admin Panel";
            }
            else
            {
                HypLogin.Text = null;
                HypLogout.Text = "Logout";
                HypUserPanel.Text = "User Panel";
            }
        }
    }
}