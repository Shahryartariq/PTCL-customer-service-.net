<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="AdminSetup.aspx.cs" Inherits="PtclCustomerService.AdminSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Contnet Start -->
    <h1 class="text-center my-4">Admin Panel</h1>

    <div class="container">
        <div class="row">
            <div class="col-lg-3 card">

                <a class="btn btn-primary w-50 m-auto my-3 active" href="ManageAdmins.aspx">Manange Admin</a>
                <a class="btn btn-primary w-50 m-auto my-3 " href="AdminPanel.aspx">Manage Customers</a>

                <button class="btn btn-primary w-50 m-auto mt-3">
                    Bill Management
                </button>

                <button class="btn btn-primary w-50 m-auto mt-3">
                    Revenue
                </button>
                <button class="btn btn-primary w-50 m-auto mt-3">
                    Your Account
                </button>

                <a class="btn btn-primary w-50 m-auto my-3" href="Home.aspx">Go to HomePage</a>
                <a class="btn btn-primary w-50 m-auto my-3" href="AdminLogin.aspx">Logout</a>
            </div>
            <div class="col-lg-9 card">
                <h3 class="text-center my-3 text-success ">ADMIN SETUP</h3>
                <div class="container">
                    <div class="row">

                        <div class="form-group mt-4">
                            <label>UserName: </label>
                            <asp:TextBox runat="server" ID="txtUserName" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="form-group mt-4">
                            <label>Password: </label>
                            <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="form-group mt-4">
                            <label>Confirm Password: </label>
                            <asp:TextBox runat="server" ID="txtConfirmPassword" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="form-group mt-4">
                            <label>Status:  </label>
                            <asp:TextBox runat="server" ID="txtStatus" CssClass="form-control"></asp:TextBox>
                        </div>

                        <div class="form-group mb-2">
                            <asp:Button Text="Submit" runat="server" ID="cmdCreate" CssClass="btn btn-primary mt-4" OnClick="cmdCreate_Click" />
                            <a class="btn btn-primary mt-4" href="ManageAdmins.aspx">Cancel</a>

                            <div>
                                <asp:Label runat="server" ID="lblMsg" ForeColor="Red"></asp:Label>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>