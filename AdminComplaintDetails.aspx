<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="AdminComplaintDetails.aspx.cs" Inherits="PtclCustomerService.AdminComplaintDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container">
        <div class="row">

            Complaint ID: <asp:Label ID="lblComplaintID" runat="server" Text="Label1" >

                          </asp:Label>

            <a href="AdminComplaint.aspx"> Go Back</a>
        </div>
    </div>
</asp:Content>