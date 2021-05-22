<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="AdminAccount.aspx.cs" Inherits="PtclCustomerService.AdminAccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
      <!-- Contnet Start -->
    <h1 class="text-center my-4">Admin Panel</h1>

    <div class="container">
        <div class="row">
            <div class="col-lg-3 card">
                
                <a class="btn btn-primary w-50 m-auto my-3 " href="ManageAdmins.aspx">Manange Admin</a>
                <a class="btn btn-primary w-50 m-auto my-3 " href="AdminPanel.aspx">Manage Customers</a>
                <a class="btn btn-primary w-50 m-auto my-3  " href="BillManagement.aspx">Bill Management</a>
                <a class="btn btn-primary w-50 m-auto my-3 " href="Revenue.aspx">Revenue</a>
                <a class="btn btn-primary w-50 m-auto my-3 active" href="AdminAccount.aspx">Admin Account</a>
                <a class="btn btn-primary w-50 m-auto my-3" href="Home.aspx">HomePage</a>
                <a class="btn btn-primary w-50 m-auto my-3" href="AdminLogin.aspx">Logout</a>

            </div>
            <div class="col-lg-9 card">
                <div class="row">

                    <h3 class="text-center my-3 text-success ">Admin Account</h3>

                </div>
        </div>
    </div>
        </div>
</asp:Content>