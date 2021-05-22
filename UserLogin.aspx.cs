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
        }

        protected void cmdLoginUser_Click(object sender, EventArgs e)
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                var query = db.PtclUserLogin(txtEmail.Text, txtPassword.Text).ToList();
                if (query.Count > 0)
                {
                    Session["UserID"] = query[0].UserID;
                    Session["FirstName"] = query[0].FirstName;
                    Session.Timeout = 720;

                    Response.Redirect("Home.aspx");
                }
                else
                {
                    lblMsg.Text = "Invalid Email or Password";
                }
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