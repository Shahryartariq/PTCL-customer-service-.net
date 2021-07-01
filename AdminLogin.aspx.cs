using Konscious.Security.Cryptography;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.Cookies["PCS"] != null)
            {
                Session["AdminID"] = Request.Cookies["PCS"]["AdminID"];
                Session["UserName"] = Request.Cookies["PCS"]["UserName"];
                Session.Timeout = 720;
                Response.Redirect("Home.aspx");
            }
        }

        private byte[] CreateSalt()
        {
            var buffer = new byte[16];
            string x = "SherryBSSE40";
            buffer = System.Text.Encoding.UTF8.GetBytes(x);
            return buffer;
        }

        private byte[] HashPassword(string password, byte[] salt)
        {
            var argon2 = new Argon2id(Encoding.UTF8.GetBytes(password));

            argon2.Salt = salt;
            argon2.DegreeOfParallelism = 8; // four cores
            argon2.Iterations = 4;
            argon2.MemorySize = 1024;
            argon2.MemorySize = 8194;

            return argon2.GetBytes(16);
        }

        protected void cmdLoginAdmin_Click(object sender, EventArgs e)
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                var password = txtPassword.Text;
                var salt = CreateSalt();
                var hash = HashPassword(password, salt);

                var query = db.PtclAdminLogin(txtUserName.Text, Convert.ToBase64String(hash)).ToList();
                //var query = db.PtclAdminLogin(txtUserName.Text, txtPassword.Text).ToList();
                if (query.Count > 0)
                {
                    Session["AdminID"] = query[0].AdminID;
                    Session["UserName"] = query[0].UserName;
                    Session.Timeout = 720;

                    Response.Cookies["PCS"]["AdminID"] = query[0].AdminID.ToString();
                    Response.Cookies["PCS"]["UserName"] = query[0].UserName.ToString();
                    Response.Cookies["PCS"].Expires = DateTime.Now.AddDays(3);
                    ;

                    Response.Redirect("Home.aspx");
                }
                else
                {
                    lblMsg.Text = "Invalid Username or Password";
                }
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