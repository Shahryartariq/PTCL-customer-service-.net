<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="ManageAdmins.aspx.cs" Inherits="PtclCustomerService.ManageAdmins" %>

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
                <a class="btn btn-primary w-50 m-auto my-3 " href="BillManagement.aspx">Bill Management</a>
                <a class="btn btn-primary w-50 m-auto my-3 " href="Revenue.aspx">Revenue</a>
                <a class="btn btn-primary w-50 m-auto my-3 " href="AdminAccount.aspx">Admin Account</a>
                <a class="btn btn-primary w-50 m-auto my-3" href="Home.aspx">HomePage</a>
                <a class="btn btn-primary w-50 m-auto my-3" href="AdminLogin.aspx">Logout</a>

            </div>
            <div class="col-lg-9 card">
                <div class="row">

                    <h3 class="text-center my-3 text-success ">Welcome Admin</h3>
                    <div class="mt-3">
                        <a class="btn btn-primary m-auto my-3" href="AdminSetup.aspx">Add New Admin</a>
                        <asp:GridView runat="server" ID="GVAdmin" CssClass="table table-bordered table-hover" AutoGenerateColumns="false" OnRowCommand="GVAdmin_RowCommand" OnRowDeleting="GVAdmin_RowDeleting" OnRowEditing="GVAdmin_RowEditing">
                            <Columns>
                                <asp:BoundField DataField="AdminID" HeaderText="Admin ID" />
                                <asp:BoundField DataField="UserName" HeaderText="User Name" />
                                <asp:BoundField DataField="Password" HeaderText="Password" />
                                <asp:BoundField DataField="Status" HeaderText="Status" />
                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <!-- AdminID-->
                                        <asp:LinkButton runat="server" ID="lnkEdit" Text="Edit" CommandName="edit" CommandArgument='<%# Bind("AdminID") %>'></asp:LinkButton>
                                        /
                                <asp:LinkButton runat="server" ID="lnkDelete" Text="Delete" CommandName="delete" CommandArgument='<%# Bind("AdminID") %>' OnClientClick="return confirm('Are you sure you want to delete this Admin?');"></asp:LinkButton>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>