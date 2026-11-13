using PtclCustomerService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class AdminPanelMasterPage : System.Web.UI.MasterPage
    {
        // Init runs before the content page's Page_Load, so no admin page code runs for someone who isn't logged in
        protected void Page_Init(object sender, EventArgs e)
        {
            if (Session["AdminID"] == null)
            {
                Response.Redirect("~/AdminLogin.aspx");
            }
            using (PTCLEntities db = new PTCLEntities())
            {
                int AdminID = Convert.ToInt32(Session["AdminID"]);
                tblAdmin s = db.tblAdmins.FirstOrDefault(v => v.AdminID == AdminID);
                if (s == null || s.Status == false)
                {
                    // account deleted or set to inactive while logged in
                    Response.Redirect("~/Logout.aspx");
                }
                lblName.Text = "Login as: " + HttpUtility.HtmlEncode(s.UserName);
            }
        }
    }
}
