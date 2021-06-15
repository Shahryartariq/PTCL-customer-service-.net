using PtclCustomerService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class UserComplaint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HyperLink activeHyp = Master.FindControl("HypComplaint") as HyperLink;
            activeHyp.CssClass += " active";
            PendingGridView();
            ApprovedGridView();
            if (Request.QueryString["register"] == "1")
            {
                PanelRegisterComplaint.CssClass = " ";
            }
            if (Request.QueryString["Active"] == "1")
            {
                PanelPendingComplaint.CssClass = " ";
            }
            if (Request.QueryString["closed"] == "1")
            {
                PanelApprovedComplaint.CssClass = " ";
            }
            using (PTCLEntities db = new PTCLEntities())
            {
                if (IsPostBack == true) return;
                ddlComplaint.SelectedValue = "7";
                var ComplaintTypes = db.GetComplaintType().ToList();
                ddlComplaint.DataSource = ComplaintTypes;
                ddlComplaint.DataTextField = "ComplaintTypeName";
                ddlComplaint.DataValueField = "ComplaintTypeID";
                ddlComplaint.DataBind();
            }
        }

        protected void PendingGridView()
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                var UserID = Convert.ToInt32(Session["UserID"]);
                //change bad ma
                var PendingComplaintsData = db.UserPendingComplaints(UserID).ToList();
                GVPendingComplaint.DataSource = PendingComplaintsData;
                GVPendingComplaint.DataBind();

                var totalCount = db.GetMyComplaints(UserID).ToList();
                int count = totalCount.Count;
                if (count > 10)
                {
                    Response.Write("Limit Exceed");
                    RegisterComplaintSection.CssClass = " d-none";
                    PanelOverLimit.CssClass = " ";
                }
            }
        }

        protected void ApprovedGridView()
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                var UserID = Convert.ToInt32(Session["UserID"]);

                var MyApprovedComplaintData = db.MyApprovedComplaint(UserID).ToList();
                GV2.DataSource = MyApprovedComplaintData;
                GV2.DataBind();
            }
        }

        protected void cmdCancelMenu_Click(object sender, EventArgs e)
        {
            PanelPendingComplaint.CssClass = " d-none";
            PanelRegisterComplaint.CssClass = " d-none";
            PanelApprovedComplaint.CssClass = " d-none";
        }

        protected void RegisterComplaint_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Complaints/User/UserComplaint.aspx?register=1");
            PanelRegisterComplaint.CssClass = " ";
            PanelPendingComplaint.CssClass = " d-none";
            PanelApprovedComplaint.CssClass = " d-none";

            RegisterComplaint.CssClass += " active";
            PendingComplaint.CssClass = ApprovedComplaint.CssClass.Replace("active", "");
            ApprovedComplaint.CssClass = ApprovedComplaint.CssClass.Replace("active", "");
        }

        protected void PendingComplaint_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Complaints/User/UserComplaint.aspx?active=1");
            PanelPendingComplaint.CssClass = " ";
            PanelRegisterComplaint.CssClass = " d-none";
            PanelApprovedComplaint.CssClass = " d-none";

            PendingComplaint.CssClass += " active";
            RegisterComplaint.CssClass = ApprovedComplaint.CssClass.Replace("active", "");
            ApprovedComplaint.CssClass = ApprovedComplaint.CssClass.Replace("active", "");
        }

        protected void ApprovedComplaint_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Complaints/User/UserComplaint.aspx?closed=1");
            PanelPendingComplaint.CssClass = " d-none";
            PanelRegisterComplaint.CssClass = " d-none";
            PanelApprovedComplaint.CssClass = " ";

            ApprovedComplaint.CssClass += " active";
            RegisterComplaint.CssClass = ApprovedComplaint.CssClass.Replace("active", "");
            PendingComplaint.CssClass = ApprovedComplaint.CssClass.Replace("active", "");
        }

        protected void cmdSubmit_Click(object sender, EventArgs e)
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                tblComplaint s = new tblComplaint();
                s.ComplaintTitle = txtComplaintTitle.Text;
                s.ComplaintTypeID = Convert.ToInt32(ddlComplaint.SelectedValue);
                s.ComplaintDescription = txtComplaintDescription.Text;
                s.ComplaintStatus = false;
                var UserID = Session["UserID"];
                s.UserID = Convert.ToInt32(UserID);

                s.ComplaintCreationDate = DateTime.Now;

                if (FileUpload.HasFile)
                {
                    FileUpload.SaveAs(Server.MapPath("../../UploadFiles/ComplaintData/" + FileUpload.FileName));
                    s.ComplaintImage = FileUpload.FileName;
                }
                else
                {
                    s.ComplaintImage = "";
                }
                txtComplaintDescription.Text = "";
                txtComplaintTitle.Text = "";
                db.tblComplaints.Add(s);
                db.SaveChanges();
                lblMsg.Text = "Complaint Submitted Successfully";
                ddlComplaint.SelectedValue = "7";

            }
        }

        protected void GV_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
        }

        protected void GV_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Regenerated")
            {
            }
            if (e.CommandName == "delete")
            {
                int ComplaintID = Convert.ToInt32(e.CommandArgument);
                //Response.Write(ComplaintID);
                using (PTCLEntities db = new PTCLEntities())
                {
                    db.DeleteComplaint(ComplaintID);
                }
                PendingGridView();
            }
        }
    }
}