<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="AdminManageCustomers.aspx.cs" Inherits="PtclCustomerService.AdminPanel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Js/scripts.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <link href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#GV').DataTable();
        });
        /*$(function () {
            $("[id*=GV]").DataTable(
                {
                    bLengthChange: true,
                    lengthMenu: [[5, 10, -1], [5, 10, "All"]],
                    bFilter: true,
                    bSort: true,
                    bPaginate: true
                });
        });*/
    </script>
    <style>
        .dataTables_filter {
            margin-bottom: 1%;

        }

       /* .dataTables_filter input {
        border-radius: 115px;
        }
        .dataTables_filter {
            margin-top: 20px;
            margin-bottom: 20px;

        }
        .dataTables_length{
               margin-top:20px;
            margin-bottom: 20px;
        }*/
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Contnet Start -->

    <!-- Contnet Start -->
    <h3 class="text-center my-3 text-success ">Our PTCL Customers</h3>
    <div class="card mb-4">
        <div class="card-body">

            <asp:GridView runat="server" ID="GV" ClientIDMode="Static" CssClass="display compact table table-bordered table-hover table-responsive" AutoGenerateColumns="false" OnRowCommand="GV_RowCommand" OnRowDeleting="GV_RowDeleting" OnRowEditing="GV_RowEditing">
                <Columns>
                    <asp:BoundField DataField="FirstName" HeaderText="First Name" />
                    <asp:BoundField DataField="EmailAddress" HeaderText="Email" />
                    <asp:BoundField DataField="Cnic" HeaderText="Cnic" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                    <asp:TemplateField HeaderText="Action">
                        <ItemTemplate>
                            <!-- userid-->
                            <asp:LinkButton runat="server" ID="lnkEdit" Text="Edit" CommandName="edit" CommandArgument='<%# Bind("UserID") %>'></asp:LinkButton>
                            /
                                <asp:LinkButton runat="server" ID="lnkDelete" Text="Delete" CommandName="delete" CommandArgument='<%# Bind("UserID") %>' OnClientClick="return confirm('Are you sure you want to delete this Customer?');"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
        </div>
    </div>
</asp:Content>