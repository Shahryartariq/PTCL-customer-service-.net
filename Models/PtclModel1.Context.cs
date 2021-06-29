﻿//------------------------------------------------------------------------------
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
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Entity.Core.Objects;
    using System.Linq;
    
    public partial class PTCLEntities : DbContext
    {
        public PTCLEntities()
            : base("name=PTCLEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<tblAdmin> tblAdmins { get; set; }
        public virtual DbSet<tblComplaint> tblComplaints { get; set; }
        public virtual DbSet<tblComplaintType> tblComplaintTypes { get; set; }
        public virtual DbSet<tblPtclUser> tblPtclUsers { get; set; }
        public virtual DbSet<tblUserLocation> tblUserLocations { get; set; }
    
        public virtual ObjectResult<ActiveC_Result> ActiveC()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<ActiveC_Result>("ActiveC");
        }
    
        public virtual ObjectResult<AdminApprovedComplaint_Result> AdminApprovedComplaint()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<AdminApprovedComplaint_Result>("AdminApprovedComplaint");
        }
    
        public virtual ObjectResult<ComplaintDetailsByCID_Result> ComplaintDetailsByCID(Nullable<int> complaintID)
        {
            var complaintIDParameter = complaintID.HasValue ?
                new ObjectParameter("ComplaintID", complaintID) :
                new ObjectParameter("ComplaintID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<ComplaintDetailsByCID_Result>("ComplaintDetailsByCID", complaintIDParameter);
        }
    
        public virtual int DeleteComplaint(Nullable<int> complaintID)
        {
            var complaintIDParameter = complaintID.HasValue ?
                new ObjectParameter("ComplaintID", complaintID) :
                new ObjectParameter("ComplaintID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("DeleteComplaint", complaintIDParameter);
        }
    
        public virtual int DeletePtclAdmin(Nullable<int> adminID)
        {
            var adminIDParameter = adminID.HasValue ?
                new ObjectParameter("AdminID", adminID) :
                new ObjectParameter("AdminID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("DeletePtclAdmin", adminIDParameter);
        }
    
        public virtual int DeletePtlcUser(Nullable<int> userID)
        {
            var userIDParameter = userID.HasValue ?
                new ObjectParameter("UserID", userID) :
                new ObjectParameter("UserID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("DeletePtlcUser", userIDParameter);
        }
    
        public virtual ObjectResult<GetComplaintbyCID_Result> GetComplaintbyCID(Nullable<int> complaintID)
        {
            var complaintIDParameter = complaintID.HasValue ?
                new ObjectParameter("ComplaintID", complaintID) :
                new ObjectParameter("ComplaintID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetComplaintbyCID_Result>("GetComplaintbyCID", complaintIDParameter);
        }
    
        public virtual ObjectResult<GetComplaints_Result> GetComplaints()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetComplaints_Result>("GetComplaints");
        }
    
        public virtual ObjectResult<GetComplaintType_Result> GetComplaintType()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetComplaintType_Result>("GetComplaintType");
        }
    
        public virtual ObjectResult<GetCustomerActiveComplaint_Result> GetCustomerActiveComplaint(Nullable<int> userID)
        {
            var userIDParameter = userID.HasValue ?
                new ObjectParameter("UserID", userID) :
                new ObjectParameter("UserID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetCustomerActiveComplaint_Result>("GetCustomerActiveComplaint", userIDParameter);
        }
    
        public virtual ObjectResult<GetMyComplaints_Result> GetMyComplaints(Nullable<int> userID)
        {
            var userIDParameter = userID.HasValue ?
                new ObjectParameter("userID", userID) :
                new ObjectParameter("userID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetMyComplaints_Result>("GetMyComplaints", userIDParameter);
        }
    
        public virtual ObjectResult<GetPtclAdmins_Result> GetPtclAdmins()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetPtclAdmins_Result>("GetPtclAdmins");
        }
    
        public virtual ObjectResult<GetPtclUsers_Result> GetPtclUsers()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<GetPtclUsers_Result>("GetPtclUsers");
        }
    
        public virtual ObjectResult<MyApprovedComplaint_Result> MyApprovedComplaint(Nullable<int> userID)
        {
            var userIDParameter = userID.HasValue ?
                new ObjectParameter("UserID", userID) :
                new ObjectParameter("UserID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<MyApprovedComplaint_Result>("MyApprovedComplaint", userIDParameter);
        }
    
        public virtual ObjectResult<PtclAdminLogin_Result> PtclAdminLogin(string userName, string password)
        {
            var userNameParameter = userName != null ?
                new ObjectParameter("UserName", userName) :
                new ObjectParameter("UserName", typeof(string));
    
            var passwordParameter = password != null ?
                new ObjectParameter("Password", password) :
                new ObjectParameter("Password", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<PtclAdminLogin_Result>("PtclAdminLogin", userNameParameter, passwordParameter);
        }
    
        public virtual ObjectResult<PtclUserLogin_Result> PtclUserLogin(string email, string password)
        {
            var emailParameter = email != null ?
                new ObjectParameter("Email", email) :
                new ObjectParameter("Email", typeof(string));
    
            var passwordParameter = password != null ?
                new ObjectParameter("Password", password) :
                new ObjectParameter("Password", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<PtclUserLogin_Result>("PtclUserLogin", emailParameter, passwordParameter);
        }
    
        public virtual ObjectResult<RegeneratedComplaints_Result> RegeneratedComplaints()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<RegeneratedComplaints_Result>("RegeneratedComplaints");
        }
    
        public virtual ObjectResult<spGetLocation_Result> spGetLocation()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spGetLocation_Result>("spGetLocation");
        }
    
        public virtual ObjectResult<temp_Result> temp()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<temp_Result>("temp");
        }
    
        public virtual ObjectResult<uniqueEmail_Result> uniqueEmail(string email)
        {
            var emailParameter = email != null ?
                new ObjectParameter("Email", email) :
                new ObjectParameter("Email", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<uniqueEmail_Result>("uniqueEmail", emailParameter);
        }
    
        public virtual ObjectResult<uniqueUserName_Result> uniqueUserName(string userName)
        {
            var userNameParameter = userName != null ?
                new ObjectParameter("userName", userName) :
                new ObjectParameter("userName", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<uniqueUserName_Result>("uniqueUserName", userNameParameter);
        }
    
        public virtual ObjectResult<UserPendingComplaints_Result> UserPendingComplaints(Nullable<int> userID)
        {
            var userIDParameter = userID.HasValue ?
                new ObjectParameter("userID", userID) :
                new ObjectParameter("userID", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<UserPendingComplaints_Result>("UserPendingComplaints", userIDParameter);
        }
    
        public virtual ObjectResult<spGetRegeneratedComplaints_Result> spGetRegeneratedComplaints()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spGetRegeneratedComplaints_Result>("spGetRegeneratedComplaints");
        }
    
        public virtual ObjectResult<spUserWithLocation_Result> spUserWithLocation()
        {
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<spUserWithLocation_Result>("spUserWithLocation");
        }
    }
}
