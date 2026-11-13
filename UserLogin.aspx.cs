using PtclCustomerService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class UserLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            int userId;
            string firstName;
            if (AuthCookie.TryRead(Request, "user", out userId, out firstName))
            {
                Session["UserID"] = userId;
                Session["FirstName"] = firstName;
                Session.Timeout = 720;
                Response.Redirect("Home.aspx");
            }
        }

        protected void cmdLoginUser_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid) return;

            using (PTCLEntities db = new PTCLEntities())
            {
                string email = txtEmail.Text.Trim();
                tblPtclUser u = db.tblPtclUsers.FirstOrDefault(v => v.EmailAddress == email);

                if (u == null || !PasswordHasher.Verify(txtPassword.Text, u.Password))
                {
                    lblMsg.Text = "Invalid Email or Password";
                    return;
                }
                if (u.Status == false)
                {
                    lblMsg.Text = "Your account is inactive. Please contact PTCL customer service";
                    return;
                }

                // passwords saved with the old fixed salt get a new salted hash
                if (PasswordHasher.IsOldHash(u.Password))
                {
                    u.Password = PasswordHasher.Hash(txtPassword.Text);
                    db.SaveChanges();
                }

                Session["UserID"] = u.UserID;
                Session["FirstName"] = u.FirstName;
                Session.Timeout = 720;

                AuthCookie.Save(Response, "user", u.UserID, u.FirstName, 1);

                Response.Redirect("Home.aspx");
            }
        }

        protected void cmdSignup_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserSignup.aspx");
        }

        protected void cmdLoginAdmin_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminLogin.aspx");
        }
    }
}
