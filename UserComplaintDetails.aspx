<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="UserComplaintDetails.aspx.cs" Inherits="PtclCustomerService.UserComplaintDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h1>User Complaint Details</h1>
    <div class="row">

        <div class="col-lg-6 mt-2">
            <div class="form-group mt-2">
                <label>ID </label>
                <asp:TextBox runat="server" ID="txtComplaintID" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="col-lg-6 mt-2">
            <div class="form-group mt-2">
                <label>Compaint Title </label>
                <asp:TextBox runat="server" ID="txtLastName" CssClass="form-control"></asp:TextBox>
            </div>
        </div>

        <div class="col-lg-6">
            <div class="form-group mt-4 w-100">
                <label>Phone: </label>
                <asp:TextBox runat="server" ID="txtPhone" CssClass="form-control" TextMode="number"></asp:TextBox>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="form-group mt-4 w-100">
                <label>CNIC: </label>
                <asp:TextBox runat="server" ID="txtCnic" CssClass="form-control" TextMode="number"></asp:TextBox>
            </div>
        </div>
        <div class="form-group mt-4">
            <label>Email: </label>
            <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" TextMode="email"></asp:TextBox>
        </div>

        <div class="col-lg-6 mt-4">
            <div class="form-group">
                <label>Password: </label>
                <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control"></asp:TextBox>
            </div>
        </div>
        <div class="col-lg-6 mt-4">
            <div class="form-group">
                <label>Confirm Password: </label>
                <asp:TextBox runat="server" ID="txtConfirmPassword" CssClass="form-control"></asp:TextBox>
            </div>
        </div>

        <!-- Will Convert This into radio button in future module   -->
        <div class="form-group mt-4">
            <label>Status (Enter Only True or False): </label>
            <label>Status (Only 1 and 0):  </label>
            <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-control">
                <asp:ListItem Text="True" Value="1" />
                <asp:ListItem Text="False" Value="0" />
            </asp:DropDownList>
        </div>

        <div class="form-group mb-2">
            <asp:Button Text="Submit" runat="server" ID="cmdSubmit" CssClass="btn btn-primary mt-4" />
            <a class="btn btn-primary mt-4" href="AdminPanel.aspx">Cancel</a>
        </div>
    </div>
</asp:Content>