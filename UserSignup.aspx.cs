using PtclCustomerService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class UserSignup : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void cmdRegister_Click(object sender, EventArgs e)
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                tblPtclUser u = new tblPtclUser();
                u.FirstName = txtFirstName.Text;
                u.LastName = txtLastName.Text;
                u.EmailAddress = txtEmail.Text;
                u.Cnic = txtCnic.Text;
                u.Password = txtPassword.Text;
                u.Phone = txtPhone.Text;
                db.tblPtclUsers.Add(u);
                db.SaveChanges();
                lblMsg.Text = "Registration Completed Succcessfully";
            }
        }

        protected void cmdLoginUser_Click(object sender, EventArgs e)
        {
            Response.Redirect("UserLogin.aspx");
        }

        protected void cmdLoginAdmin_Click(object sender, EventArgs e)
        {
            Response.Redirect("AdminLogin.aspx");
        }
    }
}