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
    using System.Collections.Generic;
    
    public partial class tblAdmin
    {
        public int AdminID { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public bool Status { get; set; }
        public string FullName { get; set; }
        public string EmailAddress { get; set; }
        public string Location { get; set; }
        public string AdminDP { get; set; }
        public string AdminPhone { get; set; }
    
        public virtual tblAdmin tblAdmin1 { get; set; }
        public virtual tblAdmin tblAdmin2 { get; set; }
    }
}
