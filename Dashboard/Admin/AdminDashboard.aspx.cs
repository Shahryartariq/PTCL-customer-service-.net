using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService.Dashboard.Admin
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HyperLink activeHyp = Master.FindControl("HypDashBoard") as HyperLink;
            activeHyp.CssClass += " active";

            using (PTCLEntities db = new PTCLEntities())
            {
                if (Session["AdminID"] != null)
                {
                    var totalCustomerCount = db.GetPtclUsers().ToList();
                    int counCustomer = totalCustomerCount.Count;
                    lblTotalCustomers.Text = counCustomer.ToString();

                    var totalAdminCount = db.GetPtclAdmins().ToList();
                    int counAdmins = totalAdminCount.Count;
                    LblTotalAdmins.Text = counAdmins.ToString();

                    var totalComplaints = db.GetComplaints().ToList();
                    int mytotalComplaints = totalComplaints.Count;
                    lblTotalComplaints.Text = mytotalComplaints.ToString();
                }
            }
        }
    }
}