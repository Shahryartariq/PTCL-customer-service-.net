﻿using PtclCustomerService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class UserPanel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HyperLink activeHyp = Master.FindControl("HypProfile") as HyperLink;
            activeHyp.CssClass += " active";

            txtPassword.Attributes["type"] = "password";
            txtConfirmPassword.Attributes["type"] = "password";

            using (PTCLEntities db = new PTCLEntities())
            {
                if (IsPostBack == true) return;
                if (Session["UserID"] != null)
                {
                    int UserID = (int)Session["UserID"];
                    tblPtclUser s = db.tblPtclUsers.FirstOrDefault(v => v.UserID == UserID);
                    txtMyName.Text = s.FirstName;
                    txtLastName.Text = s.LastName;
                    txtEmail.Text = s.EmailAddress;
                    txtPhone.Text = s.Phone;
                    txtCnic.Text = s.Cnic;
                    txtPassword.Text = s.Password;
                    txtConfirmPassword.Text = s.Password;
                    txtStatus.Text = s.Status.ToString();
                    txtLocation.Text = s.CustomerLocation;
                    lblUpload.Text = s.CustomerDP;
                }
            }
        }

        protected void cmdUpdate_Click(object sender, EventArgs e)
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                if (Session["UserID"] != null)
                {
                    int UserID = (int)Session["UserID"];
                    tblPtclUser u = db.tblPtclUsers.FirstOrDefault(v => v.UserID == UserID);
                    u.FirstName = txtMyName.Text;
                    u.LastName = txtLastName.Text;
                    u.EmailAddress = txtEmail.Text;
                    u.Phone = txtPhone.Text;
                    u.Cnic = txtCnic.Text;
                    u.Password = txtPassword.Text;
                    u.CustomerLocation = txtLocation.Text;

                    if (FileUpload.HasFile)
                    {
                        FileUpload.SaveAs(Server.MapPath("../../UploadFiles/CustomerProfile/" + FileUpload.FileName));
                        u.CustomerDP = FileUpload.FileName;
                    }
                    else
                    {
                        u.CustomerDP = "";
                    }

                    db.SaveChanges();

                    lblMsg.Text = "User Updated Successfully";
                }
            }
        }
    }
}