using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService.Complaints.Admin
{
    public partial class AdminComplaintHistory : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HyperLink activeHyp = Master.FindControl("HypComplaintsHistory") as HyperLink;
            activeHyp.CssClass += " active";
        }
    }
}