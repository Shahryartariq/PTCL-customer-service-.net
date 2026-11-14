using PtclCustomerService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int adminId;
            string userName;
            if (AuthCookie.TryRead(Request, "admin", out adminId, out userName))
            {
                Session["AdminID"] = adminId;
                Session["UserName"] = userName;
                Session.Timeout = 720;
                Response.Redirect("Home.aspx");
            }
        }

        protected void cmdLoginAdmin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            using (PTCLEntities db = new PTCLEntities())
            {
                string userName = txtUserName.Text.Trim();
                tblAdmin a = db.tblAdmins.FirstOrDefault(v => v.UserName == userName);

                if (a == null || !PasswordHasher.Verify(txtPassword.Text, a.Password))
                {
                    lblMsg.Text = "Invalid Username or Password";
                    return;
                }
                if (a.Status == false)
                {
                    lblMsg.Text = "This admin account is inactive";
                    return;
                }

                // passwords saved with the old fixed salt get a new salted hash
                if (PasswordHasher.IsOldHash(a.Password))
                {
                    a.Password = PasswordHasher.Hash(txtPassword.Text);
                    db.SaveChanges();
                }

                Session["AdminID"] = a.AdminID;
                Session["UserName"] = a.UserName;
                Session.Timeout = 720;

                AuthCookie.Save(Response, "admin", a.AdminID, a.UserName, 3);

                Response.Redirect("Home.aspx");
            }
        }

        protected void cmdSignup_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserSignup.aspx");
        }

        protected void cmdLoginUser_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserLogin.aspx");
        }
    }
}
