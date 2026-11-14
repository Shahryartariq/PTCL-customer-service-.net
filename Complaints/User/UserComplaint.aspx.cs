using PtclCustomerService.Models;
using System;
using System.Linq;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class UserComplaint : System.Web.UI.Page
    {
        // a customer can have this many complaints that are not solved yet
        private const int MaxOpenComplaints = 10;

        protected void Page_Load(object sender, EventArgs e)
        {
            HyperLink activeHyp = Master.FindControl("HypComplaint") as HyperLink;
            activeHyp.CssClass += " active";
            PendingGridView();
            ApprovedGridView();
            if (Request.QueryString["register"] == "1")
            {
                if (Request.QueryString["ComplaintID"] != null)
                {
                    RegeneratedArea.CssClass = " my-3";
                    txtParentID.Text = ParentComplaintID().ToString();
                }

                lblTitle.Text = "Register Your Complaint";
                PanelRegisterComplaint.CssClass = " ";
            }
            if (Request.QueryString["Active"] == "1")
            {
                lblTitle.Text = "Active Complaints";
                PanelPendingComplaint.CssClass = " ";
            }
            if (Request.QueryString["closed"] == "1")
            {
                lblTitle.Text = "Closed Complaints";
                PanelApprovedComplaint.CssClass = " ";
            }
            using (PTCLEntities db = new PTCLEntities())
            {
                if (IsPostBack == true) return;
                var ComplaintTypes = db.GetComplaintType().ToList();
                ddlComplaint.DataSource = ComplaintTypes;
                ddlComplaint.DataTextField = "ComplaintTypeName";
                ddlComplaint.DataValueField = "ComplaintTypeID";
                ddlComplaint.DataBind();
                SelectDefaultType();
            }
        }

        // "Other" is selected by default when it exists
        private void SelectDefaultType()
        {
            if (ddlComplaint.Items.FindByValue("7") != null)
            {
                ddlComplaint.SelectedValue = "7";
            }
        }

        private int ParentComplaintID()
        {
            int id;
            int.TryParse(Request.QueryString["ComplaintID"], out id);
            return id;
        }

        private int OpenComplaintCount(PTCLEntities db, int UserID)
        {
            return db.tblComplaints.Count(c => c.UserID == UserID && c.ComplaintStatus != true);
        }

        protected void PendingGridView()
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                var UserID = Convert.ToInt32(Session["UserID"]);
                var PendingComplaintsData = db.UserPendingComplaints(UserID).ToList();
                GVPendingComplaint.DataSource = PendingComplaintsData;
                GVPendingComplaint.DataBind();

                if (PendingComplaintsData.Count >= MaxOpenComplaints)
                {
                    RegisterComplaintSection.CssClass = " d-none";
                    PanelOverLimit.CssClass = " ";
                }
                else
                {
                    RegisterComplaintSection.CssClass = "";
                    PanelOverLimit.CssClass = "d-none";
                }
            }
        }

        protected void ApprovedGridView()
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                var UserID = Convert.ToInt32(Session["UserID"]);

                var MyApprovedComplaintData = db.MyApprovedComplaint(UserID).ToList();
                GVApprovedComplaint.DataSource = MyApprovedComplaintData;
                GVApprovedComplaint.DataBind();
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
        }

        protected void PendingComplaint_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Complaints/User/UserComplaint.aspx?active=1");
        }

        protected void ApprovedComplaint_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Complaints/User/UserComplaint.aspx?closed=1");
        }

        protected void cmdSubmit_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            using (PTCLEntities db = new PTCLEntities())
            {
                int UserID = Convert.ToInt32(Session["UserID"]);

                // checked here too, not only by hiding the form
                if (OpenComplaintCount(db, UserID) >= MaxOpenComplaints)
                {
                    lblMsg.Text = "You already have " + MaxOpenComplaints + " open complaints";
                    return;
                }

                int? parentID = null;
                if (Request.QueryString["ComplaintID"] != null)
                {
                    // only one of this customer's own closed complaints can be raised again
                    int id = ParentComplaintID();
                    if (!db.tblComplaints.Any(c => c.ComplaintID == id && c.UserID == UserID && c.ComplaintStatus == true))
                    {
                        lblMsg.Text = "Only your own closed complaints can be registered again";
                        return;
                    }
                    parentID = id;
                }

                string uploadError;
                string attachment = Uploads.Save(FileUpload, "ComplaintData", Uploads.ImagesAndPdf, out uploadError);
                if (uploadError != null)
                {
                    lblMsg.Text = uploadError;
                    return;
                }

                tblComplaint s = new tblComplaint();
                s.ComplaintTitle = txtComplaintTitle.Text.Trim();
                s.ComplaintTypeID = Convert.ToInt32(ddlComplaint.SelectedValue);
                s.ComplaintDescription = txtComplaintDescription.Text.Trim();
                s.ComplaintStatus = false;
                s.UserID = UserID;
                s.ComplaintCreationDate = DateTime.Now;
                s.ComplaintImage = attachment ?? "";
                s.RegeneratedID = parentID;

                db.tblComplaints.Add(s);
                db.SaveChanges();

                txtComplaintDescription.Text = "";
                txtComplaintTitle.Text = "";
                SelectDefaultType();
                if (parentID != null)
                {
                    // back to a normal form, so the same complaint isn't raised again twice
                    Response.Redirect("~/Complaints/User/UserComplaint.aspx?register=1");
                }
                lblMsg.Text = "Complaint Registered Successfully";
                PendingGridView();
            }
        }

        protected void GV_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
        }

        protected void GV_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {
                int ComplaintID = Convert.ToInt32(e.CommandArgument);
                using (PTCLEntities db = new PTCLEntities())
                {
                    int UserID = Convert.ToInt32(Session["UserID"]);
                    // customers can only delete their own complaints
                    if (db.tblComplaints.Any(c => c.ComplaintID == ComplaintID && c.UserID == UserID))
                    {
                        db.DeleteComplaint(ComplaintID);
                    }
                }
                PendingGridView();
                ApprovedGridView();
            }
        }
    }
}
