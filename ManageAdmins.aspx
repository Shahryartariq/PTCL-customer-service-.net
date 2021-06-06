<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="ManageAdmins.aspx.cs" Inherits="PtclCustomerService.ManageAdmins" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
   <style>
      
   </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Contnet Start -->

    <div class="row overflow-hidden">

        <h3 class="text-center my-3 text-success ">Welcome Admin</h3>
        <div class="card mb-4">
            <div class="card-body">
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
</asp:Content>