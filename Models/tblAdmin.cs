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
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2214:DoNotCallOverridableMethodsInConstructors")]
        public tblAdmin()
        {
            this.tblComplaints = new HashSet<tblComplaint>();
        }
    
        public int AdminID { get; set; }
        public string UserName { get; set; }
        public string Password { get; set; }
        public bool Status { get; set; }
        public string FullName { get; set; }
        public string EmailAddress { get; set; }
        public string Location { get; set; }
        public string AdminDP { get; set; }
        public string AdminPhone { get; set; }
        public Nullable<int> ComplaintsResolved { get; set; }
    
        public virtual tblAdmin tblAdmin1 { get; set; }
        public virtual tblAdmin tblAdmin2 { get; set; }
        [System.Diagnostics.CodeAnalysis.SuppressMessage("Microsoft.Usage", "CA2227:CollectionPropertiesShouldBeReadOnly")]
        public virtual ICollection<tblComplaint> tblComplaints { get; set; }
    }
}
