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

            using (PTCLEntities db = new PTCLEntities())
            {
                if (IsPostBack == true) return;
                if (Request.QueryString["ComplaintID"] != null)
                {
                    int ComplaintID = Convert.ToInt32(Request.QueryString["ComplaintID"]);
                    //HypRegenerate.NavigateUrl = "~/Complaints/User/UserComplaintDetails.aspx?ComplaintID=" + ComplaintID;

                    tblComplaint s = db.tblComplaints.FirstOrDefault(v => v.ComplaintID == ComplaintID);
                    //Response.Write(ComplaintID);
                    txtComplaintID.Text = s.ComplaintID.ToString();
                    txtComplaintTitle.Text = s.ComplaintTitle;
                    txtComplaintDescription.Text = s.ComplaintDescription;
                    txtComplaintUserID.Text = s.UserID.ToString();
                    txtDateTime.Text = s.ComplaintCreationDate.ToString();

                    if (s.RegeneratedID.ToString() == "0")
                    {
                        txtComplaintRegenerated.Text = "No Regenerated";
                    }
                    else if (s.RegeneratedID.ToString() != "")
                    {
                        txtComplaintRegenerated.Text = "Yes Regenerated (" + s.RegeneratedID.ToString() + ")";

                        HypRegeneratedComplaint.Text = "Goto Parent Complaint";
                        HypRegeneratedComplaint.NavigateUrl = "~/Complaints/User/UserComplaintDetails.aspx?ComplaintID=" + s.RegeneratedID.ToString();
                    }
                    else
                    {
                        txtComplaintRegenerated.Text = "No Regenerated";
                    }
                    //Response.Write(s.Status);
                    if (Convert.ToInt32(s.ComplaintStatus) == 1)
                    {
                        ddlComplaintStatus.SelectedValue = "1";
                    }
                    else
                    {
                        ddlComplaintStatus.SelectedValue = "0";
                    }
                    if (s.ComplaintImage != "")
                    {
                        HypDownloadUpload.NavigateUrl = "../../UploadFiles/ComplaintData/" + s.ComplaintImage;
                    }
                    else
                    {
                        HypDownloadUpload.NavigateUrl = "";
                        HypDownloadUpload.Text = "NO FILE TO DOWNLOAD";
                    }

                    if (s.ComplaintStatus.ToString() == "0")
                    {
                    }
                }
            }
        }

        protected void btnRegenerate_Click(object sender, EventArgs e)
        {
            int ComplaintID = Convert.ToInt32(Request.QueryString["ComplaintID"]);

            Response.Redirect("~/Complaints/User/UserComplaint.aspx?register=1&ComplaintID=" + ComplaintID);
        }
    }
}