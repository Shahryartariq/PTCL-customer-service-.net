using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace PtclCustomerService
{
    public partial class AdminPanel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HyperLink activeHyp = Master.FindControl("HypAdminPanel") as HyperLink;
            activeHyp.CssClass += " active";
            FillUsers();
        }

        protected void FillUsers()
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                var Users = db.GetPtclUsers().ToList();
                GVCustomers.DataSource = Users;
                GVCustomers.DataBind();
                GVCustomers.UseAccessibleHeader = true;
                if (GVCustomers.Rows.Count > 0)
                {
                    GVCustomers.HeaderRow.TableSection = TableRowSection.TableHeader;
                }
                else
                {
                    lblCustomersMsg.Text = "No Record to Show";
                }
            }
        }

        protected void GV_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "edit")
            {
                Response.Redirect("CustomerSetup.aspx?UserID=" + e.CommandArgument);
            }
            else if (e.CommandName == "delete")
            {
                int UserID = Convert.ToInt32(e.CommandArgument);
                using (PTCLEntities db = new PTCLEntities())
                {
                    db.DeletePtlcUser(UserID);
                }
                FillUsers();
            }
        }

        protected void GV_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
        }

        protected void GV_RowEditing(object sender, GridViewEditEventArgs e)
        {
        }
    }
}