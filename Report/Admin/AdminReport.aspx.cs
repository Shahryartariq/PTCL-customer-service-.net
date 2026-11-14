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
                ddlLocation.Items.Insert(0, new ListItem("--Select--", "0"));
            }
        }

        protected void GridFill()
        {
            using (PTCLEntities db = new PTCLEntities())
            {
                ShowReport(db.spReportData().ToList());
            }
        }

        // binds first, then marks the header row (DataTables needs a <thead>)
        private void ShowReport(object reportData)
        {
            GVAdmin.DataSource = reportData;
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            int adminValue = Convert.ToInt32(ddlAdmins.SelectedValue);
            int LocationValue = Convert.ToInt32(ddlLocation.SelectedValue);

            using (PTCLEntities db = new PTCLEntities())
            {
                // 0 means "--Select--", so any of the two filters can be left empty
                if (adminValue > 0 && LocationValue > 0)
                {
                    ShowReport(db.spFilterAdminWithLocation(adminValue, LocationValue).ToList());
                }
                else if (adminValue > 0)
                {
                    ShowReport(db.spFilterAdminOnly(adminValue).ToList());
                }
                else if (LocationValue > 0)
                {
                    ShowReport(db.spFilterLocationOnly(LocationValue).ToList());
                }
                else
                {
                    ShowReport(db.spReportData().ToList());
                }
            }
        }
    }
}