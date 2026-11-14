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
            if (Request.QueryString["Email"] == "1")
            {
                lblEmailMessage.Text = "Email Sent to the Customer Successfully";
            }
            if (Request.QueryString["Email"] == "0")
            {
                lblEmailMessage.Text = "Complaint Resolved, but the Email to the Customer could not be Sent";
            }

            hypCacnel.NavigateUrl = "~/Complaints/Admin/AdminComplaint.aspx?Active=1";
            using (PTCLEntities db = new PTCLEntities())
            {
                int ComplaintID;
                int.TryParse(Request.QueryString["ComplaintID"], out ComplaintID);
                tblComplaint s = db.tblComplaints.FirstOrDefault(v => v.ComplaintID == ComplaintID);
                if (s == null)
                {
                    Response.Redirect("~/Errors/404NotFound.aspx");
                }

                AddText(PanelCID, "Complaint ID: " + s.ComplaintID.ToString());

                // Download File
                if (!string.IsNullOrEmpty(s.ComplaintImage))
                {
                    HypDownloadUpload.NavigateUrl = "~/UploadFiles/ComplaintData/" + s.ComplaintImage;
                }
                else
                {
                    HypDownloadUpload.NavigateUrl = "";
                    HypDownloadUpload.Text = "NO FILE TO DOWNLOAD";
                }

                AddText(PanelComplaintTitle, s.ComplaintTitle);

                if (s.ComplaintStatus == true)
                {
                    AddText(PanelStatusComplaint, "Solved");
                    PanelResolveComplaint.CssClass = " d-none";
                    hypCacnel.NavigateUrl = "~/Complaints/Admin/AdminComplaint.aspx?Closed=1";
                }
                else
                {
                    AddText(PanelStatusComplaint, "Not Solved");
                }

                AddText(PanelComplaintDescription, s.ComplaintDescription);
                AddText(PanelCreation, s.ComplaintCreationDate.ToString());

                // Regenerated
                if (s.RegeneratedID.HasValue && s.RegeneratedID.Value > 0)
                {
                    AddText(PanelRegenerate, "Yes");
                    HypParentComplaint.Visible = true;
                    HypParentComplaint.Text = "Goto Parent";
                    HypParentComplaint.NavigateUrl = "~/Complaints/Admin/AdminComplaintDetails.aspx?ComplaintID=" + s.RegeneratedID;
                }
                else
                {
                    AddText(PanelRegenerate, "No");
                }

                // User Data
                var userid = s.UserID;
                tblPtclUser a = db.tblPtclUsers.FirstOrDefault(b => b.UserID == userid);
                if (a != null)
                {
                    AddText(PanelFullName, a.FirstName + " " + a.LastName);
                    AddText(PanelFirstName, a.FirstName);
                    AddText(PanelEmail, a.EmailAddress);
                    AddText(PanelPhone, a.Phone);
                    if (!string.IsNullOrEmpty(a.CustomerDP))
                    {
                        CustomerPic.ImageUrl = "~/UploadFiles/CustomerProfile/" + a.CustomerDP;
                    }
                    HypEmailIcon.NavigateUrl = "mailto:" + a.EmailAddress;
                    HypCustomerProfile.NavigateUrl = "~/ManageAccounts/Admin/AdminCustomersProfile.aspx?UserID=" + userid + "&ComplaintID=" + ComplaintID;
                }

                var complaintTypeID = s.ComplaintTypeID;
                tblComplaintType c = db.tblComplaintTypes.FirstOrDefault(d => d.ComplaintTypeID == complaintTypeID);
                AddText(PanelComplaintType, c != null ? c.ComplaintTypeName : "");
            }
        }

        // text from the database is encoded, so a title like "<script>" shows as text
        private static void AddText(Panel panel, string text)
        {
            Label label = new Label();
            label.Text = HttpUtility.HtmlEncode(text);
            panel.Controls.Add(label);
        }

        protected void btnResolve_Click(object sender, EventArgs e)
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                int ComplaintID = Convert.ToInt32(Request.QueryString["ComplaintID"]);
                tblComplaint a = db.tblComplaints.FirstOrDefault(b => b.ComplaintID == ComplaintID);
                if (a == null || a.ComplaintStatus == true)
                {
                    // already solved (e.g. by another admin a moment ago)
                    Response.Redirect("~/Complaints/Admin/AdminComplaintDetails.aspx?ComplaintID=" + ComplaintID);
                }

                var userid = a.UserID;
                tblPtclUser u = db.tblPtclUsers.FirstOrDefault(c => c.UserID == userid);

                int AdminID = Convert.ToInt32(Session["AdminID"]);
                tblAdmin z = db.tblAdmins.FirstOrDefault(y => y.AdminID == AdminID);
                if (z != null)
                {
                    z.ComplaintsResolved = (z.ComplaintsResolved ?? 0) + 1;
                }

                a.AdminID = AdminID;
                a.ComplaintStatus = true;
                db.SaveChanges();

                var message = "Dear Customer, your PTCL complaint (" + HttpUtility.HtmlEncode(a.ComplaintTitle)
                    + ") has been resolved by our team. Please check and let us know. Say hello to the future.";

                bool sent = u != null && Email.SendEmail(u.EmailAddress, "Dear Customer, your issue has been resolved", message);
                Response.Redirect("~/Complaints/Admin/AdminComplaintDetails.aspx?ComplaintID=" + ComplaintID + "&Email=" + (sent ? "1" : "0"));
            }
        }
    }
}
