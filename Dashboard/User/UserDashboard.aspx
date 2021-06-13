<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="UserDashboard.aspx.cs" Inherits="PtclCustomerService.UserDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Js/scripts.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container-fluid px-5">
        <h1 class="mt-2">Customer Dashboard</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item active">Dashboard</li>
        </ol>
        <div class="row">
            <div class="col-xl-3 col-md-6 ">
                <div class="card bg-primary text-white mb-4 ">
                    <div class="card-body text-center text-capitalize fw-bold">Total Complaints
                          <div>
                        <asp:Label runat="server" ID="lblActiveComplaints" CssClass="h2">
                            
                        </asp:Label></div>
                    </div>
                        <div class="card-footer d-flex align-items-center justify-content-between">
                        <a class="small text-white stretched-link" href="#">View Details</a>
                        <div class="small text-white"><i class="fas fa-angle-right">asdasd</i></div>
                    </div>
                </div>
            </div>
           
        </div>
    </div>
</asp:Content>