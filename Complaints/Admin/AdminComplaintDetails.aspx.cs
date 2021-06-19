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
            hypCacnel.NavigateUrl = "~/Complaints/Admin/AdminComplaint.aspx?Active=1";
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

                    Label lblStatusComplaint = new Label();
                    if (s.ComplaintStatus.ToString() == "False")
                    {
                        lblStatusComplaint.Text = "Not Solved";
                    }
                    else
                    {
                        lblStatusComplaint.Text = "Solved";
                    }

                    PanelStatusComplaint.Controls.Add(lblStatusComplaint);

                    //Complaint Description
                    Label lblComplaintDesription = new Label();
                    lblComplaintDesription.Text = s.ComplaintDescription;
                    PanelComplaintDescription.Controls.Add(lblComplaintDesription);

                    //Date
                    Label lblCreation = new Label();
                    lblCreation.Text = s.ComplaintCreationDate.ToString();
                    PanelCreation.Controls.Add(lblCreation);

                    //User Data
                    var userid = s.UserID;
                    tblPtclUser a = db.tblPtclUsers.FirstOrDefault(b => b.UserID == userid);

                    //Regerate
                    Label lblRegenerate = new Label();
                    if (s.RegeneratedID.ToString() == "0" || s.RegeneratedID == null)
                    {
                        lblRegenerate.Text = "No"; lblRegenerate.Text = "No";
                    }
                    else
                    {
                        lblRegenerate.Text = "Yes";
                    }
                    PanelRegenerate.Controls.Add(lblRegenerate);

                    //FullName
                    Label lblFullName = new Label();
                    lblFullName.Text = a.FirstName + " " + a.LastName;
                    PanelFullName.Controls.Add(lblFullName);

                    Label lblFirstName = new Label();
                    lblFirstName.Text = a.FirstName;
                    PanelFirstName.Controls.Add(lblFirstName);

                    Label lblEmail = new Label();
                    lblEmail.Text = a.EmailAddress;
                    PanelEmail.Controls.Add(lblEmail);

                    Label LblPhone = new Label();
                    LblPhone.Text = a.Phone;
                    PanelPhone.Controls.Add(LblPhone);

                    if (a.CustomerDP != "" && a.CustomerDP != null)
                    {
                        CustomerPic.ImageUrl = "../../UploadFiles/CustomerProfile/" + a.CustomerDP;
                    }
                    else
                    {
                    }

                    HypEmailIcon.NavigateUrl = "mailto:" + a.EmailAddress;
                    HypCustomerProfile.NavigateUrl = "~/ManageAccounts/Admin/AdminCustomersProfile.aspx?UserID=" + userid + "&ComplaintID=" + ComplaintID;

                    var complaintTypeID = s.ComplaintTypeID;
                    tblComplaintType c = db.tblComplaintTypes.FirstOrDefault(d => d.ComplaintTypeID == complaintTypeID);
                    Label lblcomplaintTypeID = new Label();
                    lblcomplaintTypeID.Text = c.ComplaintTypeName;
                    PanelComplaintType.Controls.Add(lblcomplaintTypeID);
                }
            }
        }

        protected void btnResolve_Click(object sender, EventArgs e)
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                int ComplaintID = Convert.ToInt32(Request.QueryString["ComplaintID"]);
                tblComplaint a = db.tblComplaints.FirstOrDefault(b => b.ComplaintID == ComplaintID);

                a.ComplaintStatus = bool.Parse("true");
                db.SaveChanges();

                var linkUrl = "~/Complaints/Admin/AdminComplaintDetails.aspx?ComplaintID=" + ComplaintID;
                Response.Redirect(linkUrl);
            }
        }
    }
}