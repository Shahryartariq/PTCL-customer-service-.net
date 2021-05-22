using PtclCustomerService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class AdminSetup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                if (IsPostBack == true) return;
                if (Request.QueryString["AdminID"] != null)
                {
                    int AdminID = Convert.ToInt32(Request.QueryString["AdminID"]);
                    tblAdmin s = db.tblAdmins.FirstOrDefault(v => v.AdminID == AdminID);
                    txtUserName.Text = s.UserName;
                    txtPassword.Text = s.Password;
                    txtConfirmPassword.Text = s.Password;
                    txtStatus.Text = s.Status;
                }
            }
        }

        protected void cmdCreate_Click(object sender, EventArgs e)
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                if (Request.QueryString["AdminID"] == null)
                {
                    tblAdmin s = new tblAdmin();
                    s.UserName = txtUserName.Text;
                    s.Password = txtPassword.Text;
                    s.Status = txtStatus.Text;
                    db.tblAdmins.Add(s);
                    db.SaveChanges();
                    lblMsg.Text = "Admin Inserted Successfully";
                }
                else
                {
                    int AdminID = Convert.ToInt32(Request.QueryString["AdminID"]);
                    tblAdmin s = db.tblAdmins.FirstOrDefault(v => v.AdminID == AdminID);
                    s.UserName = txtUserName.Text;
                    s.Password = txtPassword.Text;
                    s.Status = txtStatus.Text;
                    db.SaveChanges();
                    lblMsg.Text = "Admin Updated Successfully";
                }
            }
        }
    }
}