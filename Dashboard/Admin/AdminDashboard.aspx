<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="PtclCustomerService.Dashboard.Admin.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!--<link href="../../Css/bootstrap.min.css" rel="stylesheet" />
    <link href="../../Css/styles.css" rel="stylesheet" /> -->

    <script src="../../Js/scripts.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-5">
        <h1 class="mt-2">Admin Dashboard</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item active">Dashboard</li>
        </ol>
        <div class="row">
            <div class="col-xl-3 col-md-6 ">
                <div class="card bg-primary text-white mb-4 ">
                    <div class="card-body text-center text-capitalize fw-bold">Total Customers
                          <div>
                        <asp:Label runat="server" ID="lblTotalCustomers" CssClass="h2">
                            
                        </asp:Label></div>
                    </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                        <a class="small text-white stretched-link" href="../../ManageCustomers/Admin/AdminManageCustomers.aspx">View Details</a>
                        <div class="small text-white"><i class="fas fa-angle-right">asdasd</i></div>
                    </div>
                </div>
            </div>
           
        </div>
    </div>
</asp:Content>