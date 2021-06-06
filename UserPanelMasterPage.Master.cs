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
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null)
            {
                Response.Redirect("UserLogin.aspx");
            }
            using (PTCLEntities db = new PTCLEntities())
            {
                int UserID = Convert.ToInt32(Session["UserID"]);
                tblPtclUser s = db.tblPtclUsers.FirstOrDefault(v => v.UserID == UserID);
                //lblName.Text = s.UserName;
                lblName.Text = "Login as: " + s.FirstName;
            }
        }
    }
}