﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public partial class PackageDetails : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HyperLink activeHyp = Master.FindControl("HypPackage") as HyperLink;
            activeHyp.CssClass += " active";
        }
    }
}