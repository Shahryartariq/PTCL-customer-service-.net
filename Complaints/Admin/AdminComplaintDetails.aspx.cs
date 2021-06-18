using PtclCustomerService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class AdminComplaintDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                if (Request.QueryString["ComplaintID"] != null)
                {
                    int ComplaintID = Convert.ToInt32(Request.QueryString["ComplaintID"]);
                    tblComplaint s = db.tblComplaints.FirstOrDefault(v => v.ComplaintID == ComplaintID);

                    Label lblCID = new Label();
                    lblCID.Text = "Complaint ID: " + s.ComplaintID.ToString();
                    PanelCID.Controls.Add(lblCID);

                    // Download File
                    if (s.ComplaintImage != "" && s.ComplaintImage != null)
                    {
                        HypDownloadUpload.NavigateUrl = "../../UploadFiles/ComplaintData/" + s.ComplaintImage;
                    }
                    else
                    {
                        HypDownloadUpload.NavigateUrl = "";
                        HypDownloadUpload.Text = "NO FILE TO DOWNLOAD";
                    }

                    Label lbltitle = new Label();
                    lbltitle.Text = s.ComplaintTitle;
                    PanelComplaintTitle.Controls.Add(lbltitle);

                    //User Data
                    var userid = s.UserID;
                    tblPtclUser a = db.tblPtclUsers.FirstOrDefault(b => b.UserID == userid);

                    Label lblFirstName = new Label();
                    lblFirstName.Text = a.FirstName;
                    PanelFirstName.Controls.Add(lblFirstName);

                    if (a.CustomerDP != "" && a.CustomerDP != null)
                    {
                        CustomerPic.ImageUrl = "../../UploadFiles/CustomerProfile/" + a.CustomerDP;
                    }
                    else
                    {
                    }

                    HypEmailIcon.NavigateUrl = "mailto:" + a.EmailAddress;
                    HypCustomerProfile.NavigateUrl = "~/ManageAccounts/Admin/AdminCustomersProfile.aspx?UserID=" + userid + "&ComplaintID=" + ComplaintID;
                }
            }
        }
    }
}