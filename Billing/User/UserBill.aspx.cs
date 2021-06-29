using PtclCustomerService.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService.Billing.User
{
    public partial class UserBill : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HyperLink activeHyp = Master.FindControl("HypUserBill") as HyperLink;
            activeHyp.CssClass += " active";

            if (Session["UserID"] != null)
            {
                using (PTCLEntities db = new PTCLEntities())
                {
                    if (IsPostBack == true) return;
                    ddMonthList.SelectedValue = "0";
                    int UserID = Convert.ToInt32(Session["UserID"]);
                    tblPtclUser s = db.tblPtclUsers.FirstOrDefault(v => v.UserID == UserID);
                    lblBillName.Text = s.FirstName + " " + s.LastName;
                    lbluserID.Text = s.UserID.ToString();

                    DateTime dateAndTime = DateTime.Now.AddDays(10);
                    lblDueDate.Text = "Due Date: " + dateAndTime.ToString("dd/MM/yyyy");

                    tblLandline.Text = s.landline;

                    //location
                    tblUserLocation l = db.tblUserLocations.FirstOrDefault(x => x.LocationID == s.LocationID);
                    if (l.LocationName.ToString() == "")
                    {
                        lblLocation.Text = "No location";
                    }
                    else
                    {
                        lblLocation.Text = l.LocationName;
                    }
                    FillList();
                }
            }
        }

        protected void FillList()
        {
            if (ddMonthList.SelectedValue == "0")
            {
                lblMonth.Text = "Select";
            }
            else if (ddMonthList.SelectedValue == "1")
            {
                lblMonth.Text = "January";
            }
            else if (ddMonthList.SelectedValue == "2")
            {
                lblMonth.Text = "February";
            }
            else if (ddMonthList.SelectedValue == "3")
            {
                lblMonth.Text = "March";
            }
            else if (ddMonthList.SelectedValue == "4")
            {
                lblMonth.Text = "April";
            }
            else if (ddMonthList.SelectedValue == "5")
            {
                lblMonth.Text = "May";
            }
            else if (ddMonthList.SelectedValue == "6")
            {
                lblMonth.Text = "June";
            }
            else if (ddMonthList.SelectedValue == "7")
            {
                lblMonth.Text = "July";
            }
            else if (ddMonthList.SelectedValue == "8")
            {
                lblMonth.Text = "August";
            }
            else if (ddMonthList.SelectedValue == "9")
            {
                lblMonth.Text = "September";
            }
            else if (ddMonthList.SelectedValue == "10")
            {
                lblMonth.Text = "October";
            }
            else if (ddMonthList.SelectedValue == "11")
            {
                lblMonth.Text = "November";
            }
            else if (ddMonthList.SelectedValue == "12")
            {
                lblMonth.Text = "December";
            }
            else
            {
                Response.Redirect("~/Errors.Something Went Wrong.aspx");
            }
        }

        protected void listChange(object sender, EventArgs e)
        {
            FillList();
            //Response.Write(ddMonthList.SelectedValue + " ------ " + ddMonthList.SelectedItem.Text + "<br/>");
            int val = Convert.ToInt32(ddMonthList.SelectedValue);
            //lblNoBill.Text = val.ToString();
            int monthnum = Convert.ToInt32(DateTime.Now.Month);
            if (val == 0)
            {
                panelBill.Visible = false;
                lblNoBill.Text = "";
                lblNoMonth.Text = "Please Select Billing Month";
            }
            else if (val <= monthnum)
            {
                panelBill.Visible = true;
                lblNoMonth.Text = "";
                lblNoBill.Text = "";
            }
            else
            {
                panelBill.Visible = false;
                lblNoMonth.Text = "";
                lblNoBill.Text = "Bill Will be Displayed Soon.Keep Patience Beloved Customer";
            }
        }
    }
}