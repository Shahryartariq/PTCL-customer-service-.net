using PtclCustomerService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService.ManageAccounts.Admin
{
    public partial class AdminCustomersProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["UserID"] != null)
            {
                using (PTCLEntities db = new PTCLEntities())
                {
                    int UserID = Convert.ToInt32(Request.QueryString["UserID"]);
                    tblPtclUser a = db.tblPtclUsers.FirstOrDefault(b => b.UserID == UserID);

                    //Total Comapints
                    var GetMyComplaints = db.GetMyComplaints(UserID).ToList();
                    int countTotalCom = GetMyComplaints.Count;
                    //Response.Write(countTotalCom);
                    Label lblTotalC = new Label();
                    lblTotalC.Text = countTotalCom.ToString();
                    PanelTotalC.Controls.Add(lblTotalC);

                    //Active Comapints
                    var ActiveComplaints = db.GetCustomerActiveComplaint(UserID).ToList();
                    int countActiveCom = ActiveComplaints.Count;
                    //Response.Write(countTotalCom);
                    Label lblActiveC = new Label();
                    lblActiveC.Text = countActiveCom.ToString();
                    PanelActiveC.Controls.Add(lblActiveC);

                    Label lblFirstName = new Label();
                    lblFirstName.Text = a.FirstName;
                    PanelFirstName.Controls.Add(lblFirstName);

                    Label lblLocation = new Label();
                    lblLocation.Text = a.CustomerLocation;
                    PanelLocation.Controls.Add(lblLocation);

                    Label LblFullName = new Label();
                    LblFullName.Text = a.FirstName + " " + a.LastName;
                    PanelFullName.Controls.Add(LblFullName);

                    Label lblEmail = new Label();
                    lblEmail.Text = a.EmailAddress;
                    PanelEmail.Controls.Add(lblEmail);

                    Label lblCnic = new Label();
                    lblCnic.Text = a.Cnic;
                    PanelCnic.Controls.Add(lblCnic);

                    Label lblPhone = new Label();
                    lblPhone.Text = a.Phone;
                    PanelPhone.Controls.Add(lblPhone);

                    Label lblStatus = new Label();
                    if (a.Status.ToString() == "True")
                    {
                        lblStatus.Text = "Status (Active)";
                    }
                    else
                    {
                        lblStatus.Text = "Status (Inactive)";
                    }
                    PanelStatus.Controls.Add(lblStatus);

                    if (a.CustomerDP != "" && a.CustomerDP != null)
                    {
                        userPic.ImageUrl = "../../UploadFiles/CustomerProfile/" + a.CustomerDP;
                    }
                    else
                    {
                        userPic.ImageUrl = "../../assets/img/avatar.png";
                    }

                    if (Request.QueryString["ComplaintID"] != null)
                    {
                        int ComplaintID = Convert.ToInt32(Request.QueryString["ComplaintID"]);
                        HypEditProfile.NavigateUrl = "~/ManageCustomers/Admin/CustomerSetup.aspx?UserID=" + UserID + "&back=1" + "&ComplaintID=" + ComplaintID;
                        HypBack.NavigateUrl = "~/Complaints/Admin/AdminComplaintDetails.aspx?ComplaintID=" + ComplaintID;
                    }
                }
            }
        }
    }
}