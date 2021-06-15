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
            using (PTCLEntities db = new PTCLEntities())
            {
                if (IsPostBack == true) return;
                if (Request.QueryString["ComplaintID"] != null)
                {
                    int ComplaintID = Convert.ToInt32(Request.QueryString["ComplaintID"]);
                    tblComplaint s = db.tblComplaints.FirstOrDefault(v => v.ComplaintID == ComplaintID);
                    Response.Write(ComplaintID);
                    txtComplaintID.Text = s.ComplaintID.ToString();
                    txtComplaintTitle.Text = s.ComplaintTitle;
                    txtComplaintDescription.Text = s.ComplaintDescription;
                    txtComplaintUserID.Text = s.UserID.ToString();
                    txtDateTime.Text = s.ComplaintCreationDate.ToString();

                    if (s.RegeneratedID.ToString() != "")
                    {
                        txtComplaintRegenerated.Text = s.RegeneratedID.ToString();
                        HypRegeneratedComplaint.Text = "Goto Parent Complaint";
                        HypRegeneratedComplaint.NavigateUrl = "/UserComplaintDetails.aspx?ComplaintID=" + s.RegeneratedID.ToString();
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

                    HypDownloadUpload.NavigateUrl = "../../UploadFiles/ComplaintData/" + s.ComplaintImage;
                }
            }
        }
    }
}