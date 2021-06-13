using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class ManageAdmins : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HyperLink activeHyp = Master.FindControl("HypManangeAdmin") as HyperLink;
            activeHyp.CssClass += " active";
            FillAdmin();
        }

        protected void FillAdmin()
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                var Admins = db.GetPtclAdmins().ToList();
                GVAdmin.DataSource = Admins;
                GVAdmin.DataBind();
            }
        }

        protected void GVAdmin_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "edit")
            {
                Response.Redirect("AdminSetup.aspx?AdminID=" + e.CommandArgument);
            }
            else if (e.CommandName == "delete")
            {
                int AdminID = Convert.ToInt32(e.CommandArgument);
                using (PTCLEntities db = new PTCLEntities())
                {
                    db.DeletePtclAdmin(AdminID);
                }
                FillAdmin();
            }
        }

        protected void GVAdmin_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
        }

        protected void GVAdmin_RowEditing(object sender, GridViewEditEventArgs e)
        {
        }
    }
}