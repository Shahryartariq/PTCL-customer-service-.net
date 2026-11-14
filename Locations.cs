using PtclCustomerService.Models;
using System.Collections.Generic;
using System.Web.UI.WebControls;

namespace PtclCustomerService
{
    public static class Locations
    {
        /// <summary>
        /// Fills a city dropdown as "Islamabad (051)". Islamabad and Rawalpindi share 051,
        /// so the code alone isn't enough to pick the right city.
        /// </summary>
        public static void Fill(DropDownList list, List<spGetLocation_Result> locations)
        {
            list.Items.Clear();
            foreach (spGetLocation_Result l in locations)
            {
                string code = l.LocationCode.HasValue ? " (0" + l.LocationCode.Value + ")" : "";
                list.Items.Add(new ListItem(l.LocationName + code, l.LocationID.ToString()));
            }
        }
    }
}
