using PtclCustomerService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class UserPanelMasterPage : System.Web.UI.MasterPage
    {
        // Init runs before the content page's Page_Load, so no page code runs for someone who isn't logged in
        protected void Page_Init(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("~/UserLogin.aspx");
            }
            using (PTCLEntities db = new PTCLEntities())
            {
                int UserID = Convert.ToInt32(Session["UserID"]);
                tblPtclUser s = db.tblPtclUsers.FirstOrDefault(v => v.UserID == UserID);
                if (s == null || s.Status == false)
                {
                    // account deleted or blocked while logged in
                    Response.Redirect("~/Logout.aspx?userSide=1");
                }
                lblName.Text = "Login as: " + HttpUtility.HtmlEncode(s.FirstName);
            }
        }
    }
}
