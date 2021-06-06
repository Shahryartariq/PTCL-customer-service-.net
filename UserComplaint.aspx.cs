﻿using PtclCustomerService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class UserComplaint : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HyperLink activeHyp = Master.FindControl("HypComplaint") as HyperLink;
            activeHyp.CssClass += " active";
            PendingGridView();
            ApprovedGridView();

            using (PTCLEntities db = new PTCLEntities())
            {
                if (IsPostBack == true) return;
                var ComplaintTypes = db.GetComplaintType().ToList();
                ddlComplaint.DataSource = ComplaintTypes;
                ddlComplaint.DataTextField = "ComplaintTypeName";
                ddlComplaint.DataValueField = "ComplaintTypeID";
                ddlComplaint.DataBind();
            }
        }

        protected void PendingGridView()
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                var UserID = Convert.ToInt32(Session["UserID"]);

                var PendingComplaintsData = db.MyPendingComplaint(UserID).ToList();
                //var PendingComplaintsData = db.GetComplaints().ToList();
                GV1.DataSource = PendingComplaintsData;
                GV1.DataBind();
            }
        }

        protected void ApprovedGridView()
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                var UserID = Convert.ToInt32(Session["UserID"]);

                var MyApprovedComplaintData = db.MyApprovedComplaint(UserID).ToList();
                GV2.DataSource = MyApprovedComplaintData;
                GV2.DataBind();
            }
        }

        protected void cmdCancelMenu_Click(object sender, EventArgs e)
        {
            PanelPendingComplaint.CssClass = " d-none";
            PanelRegisterComplaint.CssClass = " d-none";
            PanelApprovedComplaint.CssClass = " d-none";
        }

        protected void RegisterComplaint_Click(object sender, EventArgs e)
        {
            PanelRegisterComplaint.CssClass = " ";
            PanelPendingComplaint.CssClass = " d-none";
            PanelApprovedComplaint.CssClass = " d-none";

            RegisterComplaint.CssClass += " active";
            PendingComplaint.CssClass = ApprovedComplaint.CssClass.Replace("active", "");
            ApprovedComplaint.CssClass = ApprovedComplaint.CssClass.Replace("active", "");
        }

        protected void PendingComplaint_Click(object sender, EventArgs e)
        {
            PanelPendingComplaint.CssClass = " ";
            PanelRegisterComplaint.CssClass = " d-none";
            PanelApprovedComplaint.CssClass = " d-none";

            PendingComplaint.CssClass += " active";
            RegisterComplaint.CssClass = ApprovedComplaint.CssClass.Replace("active", "");
            ApprovedComplaint.CssClass = ApprovedComplaint.CssClass.Replace("active", "");
        }

        protected void ApprovedComplaint_Click(object sender, EventArgs e)
        {
            PanelPendingComplaint.CssClass = " d-none";
            PanelRegisterComplaint.CssClass = " d-none";
            PanelApprovedComplaint.CssClass = " ";

            ApprovedComplaint.CssClass += " active";
            RegisterComplaint.CssClass = ApprovedComplaint.CssClass.Replace("active", "");
            PendingComplaint.CssClass = ApprovedComplaint.CssClass.Replace("active", "");
        }

        protected void cmdSubmit_Click(object sender, EventArgs e)
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                tblComplaint s = new tblComplaint();
                s.ComplaintTitle = txtComplaintTitle.Text;
                s.ComplaintTypeID = Convert.ToInt32(ddlComplaint.SelectedValue);
                s.ComplaintDescription = txtComplaintDescription.Text;
                s.ComplaintStatus = false;
                var UserID = Session["UserID"];
                s.UserID = Convert.ToInt32(UserID);

                db.tblComplaints.Add(s);
                db.SaveChanges();
                lblMsg.Text = "Complaint Submitted Successfully";
            }
        }

        protected void GV_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
        }

        protected void GV_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {
                int ComplaintID = Convert.ToInt32(e.CommandArgument);
                //Response.Write(ComplaintID);
                using (PTCLEntities db = new PTCLEntities())
                {
                    db.DeleteComplaint(ComplaintID);
                }
                PendingGridView();
            }
        }
    }
}