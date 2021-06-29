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
            HyperLink activeHyp = Master.FindControl("HypConplaints") as HyperLink;
            activeHyp.CssClass += " active";
            PendingGridView();
            ApprovedGridView();
            RegeneratedGridView();
            if (Request.QueryString["Active"] == "1")
            {
                lblTitle.Text = "Active Complaints";
                PanelPendingComplaint.CssClass = " ";
            }
            if (Request.QueryString["Closed"] == "1")
            {
                lblTitle.Text = "Closed Complaints";
                PanelApprovedComplaint.CssClass = " ";
            }
            if (Request.QueryString["Rcomp"] == "1")
            {
                lblTitle.Text = "Regenerated Complaints";
                PanelRegeneratedComplaint.CssClass = " ";
            }
        }

        protected void PendingGridView()
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                var PendingComplaintsData = db.ActiveC().ToList();
                GVPendingComplaint.DataSource = PendingComplaintsData;
                GVPendingComplaint.DataBind();
                GVPendingComplaint.UseAccessibleHeader = true;

                if (GVPendingComplaint.Rows.Count > 0)
                {
                    GVPendingComplaint.HeaderRow.TableSection = TableRowSection.TableHeader;
                }
                else
                {
                    lblTablePendingMsg.Text = "No Record to Show";
                }
            }
        }

        protected void ApprovedGridView()
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                var MyApprovedComplaintData = db.AdminApprovedComplaint().ToList();
                GVApprovedComplaint.DataSource = MyApprovedComplaintData;
                GVApprovedComplaint.DataBind();
                GVApprovedComplaint.UseAccessibleHeader = true;
                if (GVApprovedComplaint.Rows.Count > 0)
                {
                    GVApprovedComplaint.HeaderRow.TableSection = TableRowSection.TableHeader;
                }
                else
                {
                    lblTableClosedMsg.Text = "No Record to Show";
                }
            }
        }

        protected void RegeneratedGridView()
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                var MyRegeneratedComplaintData = db.spGetRegeneratedComplaints().ToList();
                GVRegeneratedComplaint.DataSource = MyRegeneratedComplaintData;
                GVRegeneratedComplaint.DataBind();
                if (GVRegeneratedComplaint.Rows.Count > 0)
                {
                    GVRegeneratedComplaint.HeaderRow.TableSection = TableRowSection.TableHeader;
                }
                else
                {
                    lblTableRegeneratedMsg.Text = "No Record to Show";
                }
            }
        }

        protected void cmdCancelMenu_Click(object sender, EventArgs e)
        {
            PanelPendingComplaint.CssClass = " d-none";
            PanelApprovedComplaint.CssClass = " d-none";
            PanelRegeneratedComplaint.CssClass = " d-none";
        }

        protected void PendingComplaint_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Complaints/Admin/AdminComplaint.aspx?Active=1");
            PanelPendingComplaint.CssClass = " active";
            PanelApprovedComplaint.CssClass = " d-none";
            PanelRegeneratedComplaint.CssClass = " d-none";
            PendingComplaint.CssClass += " active";
            ApprovedComplaint.CssClass = ApprovedComplaint.CssClass.Replace("active", "");
            RegeneratedComplaint.CssClass = ApprovedComplaint.CssClass.Replace("active", "");
        }

        protected void ApprovedComplaint_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Complaints/Admin/AdminComplaint.aspx?Closed=1");

            PanelApprovedComplaint.CssClass = " active";
            PanelPendingComplaint.CssClass = " d-none";
            PanelRegeneratedComplaint.CssClass = " d-none";

            ApprovedComplaint.CssClass += " active";
            PendingComplaint.CssClass = PendingComplaint.CssClass.Replace("active", "");
            RegeneratedComplaint.CssClass = ApprovedComplaint.CssClass.Replace("active", "");
        }

        protected void RegeneratedComplaint_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Complaints/Admin/AdminComplaint.aspx?Rcomp=1");
            PanelRegeneratedComplaint.CssClass = " active";
            PanelPendingComplaint.CssClass = " d-none";
            PanelApprovedComplaint.CssClass = " d-none";

            RegeneratedComplaint.CssClass += " active";
            PendingComplaint.CssClass = PendingComplaint.CssClass.Replace("active", "");
            ApprovedComplaint.CssClass = ApprovedComplaint.CssClass.Replace("active", "");
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