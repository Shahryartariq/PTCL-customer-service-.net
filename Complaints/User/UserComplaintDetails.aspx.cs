using PtclCustomerService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class UserComplaintDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["Last"] == "1")
            {
                HypCancel.NavigateUrl = "~/Complaints/User/UserComplaint.aspx?closed=1";
            }
            if (Request.QueryString["start"] == "1")
            {
                PanelRegenerate.CssClass = " d-none";
                HypCancel.NavigateUrl = "~/Complaints/User/UserComplaint.aspx?Active=1";
            }

            tblComplaint s = OwnComplaint();

            // only closed complaints can be registered again
            if (s.ComplaintStatus != true)
            {
                PanelRegenerate.CssClass = " d-none";
            }

            if (IsPostBack == true) return;

            txtComplaintID.Text = s.ComplaintID.ToString();
            txtComplaintTitle.Text = s.ComplaintTitle;
            txtComplaintDescription.Text = s.ComplaintDescription;
            txtComplaintUserID.Text = s.UserID.ToString();
            txtDateTime.Text = s.ComplaintCreationDate.ToString();

            if (s.RegeneratedID.HasValue && s.RegeneratedID.Value > 0)
            {
                txtComplaintRegenerated.Text = "Yes Regenerated (" + s.RegeneratedID.ToString() + ")";
                HypRegeneratedComplaint.Text = "Goto Parent Complaint";
                HypRegeneratedComplaint.NavigateUrl = "~/Complaints/User/UserComplaintDetails.aspx?ComplaintID=" + s.RegeneratedID.ToString();
            }
            else
            {
                txtComplaintRegenerated.Text = "No Regenerated";
            }

            ddlComplaintStatus.SelectedValue = s.ComplaintStatus == true ? "1" : "0";

            if (!string.IsNullOrEmpty(s.ComplaintImage))
            {
                HypDownloadUpload.NavigateUrl = "~/UploadFiles/ComplaintData/" + s.ComplaintImage;
            }
            else
            {
                HypDownloadUpload.NavigateUrl = "";
                HypDownloadUpload.Text = "NO FILE TO DOWNLOAD";
            }
        }

        // the complaint from the address, but only if it belongs to the logged in customer
        private tblComplaint OwnComplaint()
        {
            int ComplaintID;
            int.TryParse(Request.QueryString["ComplaintID"], out ComplaintID);
            int UserID = Convert.ToInt32(Session["UserID"]);

            using (PTCLEntities db = new PTCLEntities())
            {
                tblComplaint s = db.tblComplaints.FirstOrDefault(v => v.ComplaintID == ComplaintID && v.UserID == UserID);
                if (s == null)
                {
                    Response.Redirect("~/Errors/404NotFound.aspx");
                }
                return s;
            }
        }

        protected void btnRegenerate_Click(object sender, EventArgs e)
        {
            tblComplaint s = OwnComplaint();
            Response.Redirect("~/Complaints/User/UserComplaint.aspx?register=1&ComplaintID=" + s.ComplaintID);
        }
    }
}
