<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="ManageAdmins.aspx.cs" Inherits="PtclCustomerService.ManageAdmins" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        fixflow {
            overflow: hidden;
        }
    </style>
    <script src="../../Js/scripts.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <link href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <script>
        $(document).ready(function () {
            $('#GVAdmin').DataTable({
                "lengthMenu": [[5, 10, 15, -1], [5, 10, 15, "All"]]
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Contnet Start -->

    <div class="row overflow-hidden fixflow">

        <h3 class="text-center my-3 text-success ">Welcome Admin</h3>
        <div class="card mb-4">
            <div class="card-body">
                <a class="btn btn-primary m-auto my-3" href="AdminSetup.aspx">Add New Admin</a>
                <asp:GridView runat="server" ID="GVAdmin" ClientIDMode="Static" CssClass="table table-bordered table-hover" AutoGenerateColumns="false" OnRowCommand="GVAdmin_RowCommand" OnRowDeleting="GVAdmin_RowDeleting" OnRowEditing="GVAdmin_RowEditing">
                    <Columns>
                        <asp:BoundField DataField="AdminID" HeaderText="Admin ID" />
                        <asp:BoundField DataField="UserName" HeaderText="User Name" />
                        <asp:BoundField DataField="EmailAddress" HeaderText="Email" />
                        <asp:BoundField DataField="Location" HeaderText="Location" />
                        <asp:BoundField DataField="Status" HeaderText="Status" />

                        <asp:TemplateField HeaderText="View Profile">
                            <ItemTemplate>
                                <!-- AdminID-->
                                <asp:LinkButton runat="server" ID="lnkEdit" Text="Edit" CommandName="edit" CommandArgument='<%# Bind("AdminID") %>'></asp:LinkButton>
                                /
                                <asp:LinkButton runat="server" ID="lnkDelete" Text="Delete" CommandName="delete" CommandArgument='<%# Bind("AdminID") %>' OnClientClick="return confirm('Are you sure you want to delete this Admin?');"></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>

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