using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class Logout : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session.Abandon();
            Response.Cookies["PCS"].Expires = DateTime.Now.AddMinutes(-1);
            if (Request.QueryString["userSide"] != null)
            {
                Response.Redirect("~/UserLogin.aspx");
            }
            Response.Redirect("~/AdminLogin.aspx");
        }
    }
}