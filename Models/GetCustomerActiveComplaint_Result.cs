//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace PtclCustomerService.Models
{
    using System;
    
    public partial class GetCustomerActiveComplaint_Result
    {
        public int ComplaintID { get; set; }
        public int ComplaintTypeID { get; set; }
        public string ComplaintImage { get; set; }
        public string ComplaintTitle { get; set; }
        public string ComplaintDescription { get; set; }
        public Nullable<int> UserID { get; set; }
        public Nullable<bool> ComplaintStatus { get; set; }
        public Nullable<int> RegeneratedID { get; set; }
        public Nullable<System.DateTime> ComplaintCreationDate { get; set; }
    }
}
