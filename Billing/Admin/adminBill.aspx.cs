using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService.Billing.Admin
{
    public partial class adminBill : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HyperLink activeHyp = Master.FindControl("HypAdminBill") as HyperLink;
            activeHyp.CssClass += " active";
            GridFill();
        }

        protected void GridFill()
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                var Users = db.spUserWithLocation().ToList();
                grdViewDetail.DataSource = Users;
                grdViewDetail.DataBind();
                grdViewDetail.UseAccessibleHeader = true;
                if (grdViewDetail.Rows.Count > 0)
                {
                    grdViewDetail.HeaderRow.TableSection = TableRowSection.TableHeader;
                }
                else
                {
                    lblCustomersMsg.Text = "No Record to Show";
                }
            }
        }
    }
}