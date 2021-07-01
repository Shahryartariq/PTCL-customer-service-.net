using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService.Report.Admin
{
    public partial class AdminReport : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HyperLink activeHyp = Master.FindControl("HypReport") as HyperLink;
            activeHyp.CssClass += " active";
            GVAdmin.UseAccessibleHeader = true;

            if (!IsPostBack)
            {
                GridFill();
            }

            using (PTCLEntities db = new PTCLEntities())
            {
                //object create
                if (IsPostBack == true) return;

                var MainCategory = db.GetPtclAdmins().ToList();
                ddlAdmins.DataSource = MainCategory;
                ddlAdmins.DataTextField = "UserName";
                ddlAdmins.DataValueField = "AdminID";
                ddlAdmins.DataBind();
                ddlAdmins.Items.Insert(0, new ListItem("--Select--", "0"));

                var SubCategory = db.spGetLocation().ToList();
                ddlLocation.DataSource = SubCategory;
                ddlLocation.DataTextField = "LocationName";
                ddlLocation.DataValueField = "LocationID";
                ddlLocation.DataBind();
                ddlLocation.Items.Insert(0, new ListItem("--Select--", "1"));
            }
        }

        protected void GridFill()
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                var reportData = db.spReportData().ToList();
                GVAdmin.DataSource = reportData;
                GVAdmin.UseAccessibleHeader = true;
                if (GVAdmin.Rows.Count > 0)
                {
                    GVAdmin.HeaderRow.TableSection = TableRowSection.TableHeader;
                    lblAdminmsg.Text = "";
                }
                else
                {
                    ;
                }
                GVAdmin.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            if (ddlAdmins.SelectedValue == "0")
            {
                lblAdminmsg.Text = "Please Select Admins";
            }

            if (ddlLocation.SelectedValue == "1")
            {
                lblAdminmsg.Text = "Please Select Location";
            }
            using (PTCLEntities db = new PTCLEntities())
            {
                if (ddlAdmins.SelectedItem.Text == null && ddlLocation.SelectedItem.Text == null)
                {
                    lblAdminmsg.Text = "Please Select both CheckBoxes";
                }
                else
                {
                    int adminValue = Convert.ToInt32(ddlAdmins.SelectedValue);
                    int LocationValue = Convert.ToInt32(ddlLocation.SelectedValue);

                    var reportData = db.spFilterAdminWithLocation(adminValue, LocationValue).ToList();
                    GVAdmin.DataSource = reportData;
                }

                GVAdmin.DataBind();
                GVAdmin.UseAccessibleHeader = true;
                if (GVAdmin.Rows.Count > 0)
                {
                    GVAdmin.HeaderRow.TableSection = TableRowSection.TableHeader;
                    lblAdminmsg.Text = "";
                }
                else
                {
                    lblAdminmsg.Text = "No Record to Show";
                }
            }
        }
    }
}