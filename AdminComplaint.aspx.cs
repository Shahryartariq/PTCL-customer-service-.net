using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class AdminComplaint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HyperLink activeHyp = Master.FindControl("HypAdminAccount") as HyperLink;
            activeHyp.CssClass += " active";
            PendingGridView();
            ApprovedGridView();
        }

        protected void PendingGridView()
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                var PendingComplaintsData = db.AdminPendingComplaint().ToList();
                GV1.DataSource = PendingComplaintsData;
                GV1.DataBind();
            }
        }

        protected void ApprovedGridView()
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                var MyApprovedComplaintData = db.AdminApprovedComplaint().ToList();
                GV2.DataSource = MyApprovedComplaintData;
                GV2.DataBind();
            }
        }

        protected void cmdCancelMenu_Click(object sender, EventArgs e)
        {
            PanelPendingComplaint.CssClass = " d-none";
            PanelApprovedComplaint.CssClass = " d-none";
        }

        protected void PendingComplaint_Click(object sender, EventArgs e)
        {
            PanelPendingComplaint.CssClass = " active";
            PanelApprovedComplaint.CssClass = " d-none";
            PendingComplaint.CssClass += " active";
            ApprovedComplaint.CssClass = ApprovedComplaint.CssClass.Replace("active", "");
        }

        protected void ApprovedComplaint_Click(object sender, EventArgs e)
        {
            PanelPendingComplaint.CssClass = " d-none";
            PanelApprovedComplaint.CssClass = " active";
            ApprovedComplaint.CssClass += " active";
            PendingComplaint.CssClass = PendingComplaint.CssClass.Replace("active", "");
        }

        protected void GV_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
        }

        protected void GV_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {
                int ComplaintID = Convert.ToInt32(e.CommandArgument);
                Response.Write(ComplaintID);
                using (PTCLEntities db = new PTCLEntities())
                {
                    db.DeleteComplaint(ComplaintID);
                }
                PendingGridView();
            }
        }
    }
}