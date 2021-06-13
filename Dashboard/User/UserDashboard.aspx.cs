using PtclCustomerService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class UserDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HyperLink activeHyp = Master.FindControl("HypDashBoard") as HyperLink;
            activeHyp.CssClass += " active";
            using (PTCLEntities db = new PTCLEntities())
            {
                if (IsPostBack == true) return;
                if (Session["UserID"] != null)
                {
                    int UserID = (int)Session["UserID"];
                    var totalCount = db.GetMyComplaints(UserID).ToList();

                    int count = totalCount.Count;
                    lblActiveComplaints.Text = count.ToString();
                }
            }
        }
    }
}