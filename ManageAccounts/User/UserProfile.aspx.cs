﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace PtclCustomerService.ManageAccounts.User
{
    public partial class UserProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            HyperLink activeHyp = Master.FindControl("HypProfile") as HyperLink;
            activeHyp.CssClass += " active";
        }
    }
}