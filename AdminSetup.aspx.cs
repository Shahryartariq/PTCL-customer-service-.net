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
                    //txtStatus.Text = s.Status;
                    //Response.Write(s.Status);

                    if (Convert.ToInt32(s.Status) == 1)
                    {
                        ddlStatus.SelectedValue = "1";
                    }
                    else
                    {
                        ddlStatus.SelectedValue = "0";
                    }
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
                    //s.Status = txtStatus.Text;
                    s.Status = ddlStatus.SelectedValue.ToString();
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
                    //s.Status = txtStatus.Text;
                    s.Status = ddlStatus.SelectedValue.ToString();

                    db.SaveChanges();
                    lblMsg.Text = "Admin Updated Successfully";
                }
            }
        }

        /*protected void CVStatus_ServerValidate(object source, ServerValidateEventArgs args)
        {
            var temp = args.Value;
            if (temp == "1" || temp == "0")
            {
                args.IsValid = true;
            }
            else
            {
                args.IsValid = false;
            }
        }*/
    }
}