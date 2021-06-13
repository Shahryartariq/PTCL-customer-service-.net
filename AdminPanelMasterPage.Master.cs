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
        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["AdminID"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
            }

            using (PTCLEntities db = new PTCLEntities())
            {
                int AdminID = Convert.ToInt32(Session["AdminID"]);
                tblAdmin s = db.tblAdmins.FirstOrDefault(v => v.AdminID == AdminID);
                //lblName.Text = s.UserName;
                lblName.Text = "Login as: " + s.UserName;
            }
        }
    }
}