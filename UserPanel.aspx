<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="UserPanel.aspx.cs" Inherits="PtclCustomerService.UserPanel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <!-- Page level ki Java/cs -->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <h1 class="text-center my-4">User Panel</h1>

    <div class="container">
        <div class="row">
            <div class="col-lg-4 card">
                <button class="btn btn-primary w-50 m-auto mt-3 active">
                    Edit Account
                </button>
                <button class="btn btn-primary w-50 m-auto mt-3">
                    Package Details
                </button>
                <button class="btn btn-primary w-50 m-auto mt-3">
                    Print Bill
                </button>

                <button class="btn btn-primary w-50 m-auto mt-3">
                    Remaining Data
                </button>
                <button class="btn btn-primary w-50 m-auto mt-3">
                    Customer Support
                </button>

                <a class="btn btn-primary w-50 m-auto my-3" href="Home.aspx">Go to HomePage</a>
                <a class="btn btn-primary w-50 m-auto my-3" href="Logout.aspx">Logout</a>
            </div>
            <div class="col-lg-8 card">

                <div class="row">

                    <div class="form-group mt-2">
                        <label>First Name: </label>
                        <asp:TextBox runat="server" ID="txtMyName" CssClass="form-control" />
                    </div>

                    <div class="form-group mt-4">
                        <label>Last Name: </label>
                        <asp:TextBox runat="server" ID="txtLastName" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-lg-6">

                        <div class="form-group mt-4 w-100">
                            <label>Phone: </label>
                            <asp:TextBox runat="server" ID="txtPhone" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="col-lg-6">

                        <div class="form-group mt-4 w-100">
                            <label>CNIC: </label>
                            <asp:TextBox runat="server" ID="txtCnic" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group mt-4">
                        <label>Email: </label>
                        <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="col-lg-6 my-4">
                        <div class="form-group">
                            <label>Password: </label>
                            <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="col-lg-6 my-4">
                        <div class="form-group">
                            <label>Confirm Password: </label>
                            <asp:TextBox runat="server" ID="txtConfirmPassword" CssClass="form-control"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group mb-2">
                        <asp:Button Text="Update" runat="server" ID="cmdUpdate" CssClass="btn btn-primary" OnClick="cmdUpdate_Click" />
                        <a class="btn btn-primary" href="Home.aspx">Cancel</a>

                        <div>
                            <asp:Label runat="server" ID="lblMsg" ForeColor="Red"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>