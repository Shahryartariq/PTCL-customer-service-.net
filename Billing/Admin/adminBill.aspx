<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="adminBill.aspx.cs" Inherits="PtclCustomerService.Billing.Admin.adminBill" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Js/scripts.js"></script>
    <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js"></script>
    <link href="https://cdn.datatables.net/1.10.20/css/jquery.dataTables.css" rel="stylesheet" type="text/css" />
    <script>
        $(document).ready(function () {
            $('.datatable').DataTable({
                "lengthMenu": [[10, 20, 50, -1], [10, 20, 50, "All"]]
            });

        });
    </script>
    <style>
        .dataTables_filter {
            margin-bottom: 1%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <h3 class="text-center my-3 text-success ">Customers Bill</h3>
        <div class="card mb-4">
            <div class="card-body">
                <asp:GridView class="datatable table table-bordered table-hover" ClientIDMode="Static" ID="grdViewDetail" runat="server" AutoGenerateColumns="False">
                    <Columns>
                        <asp:TemplateField HeaderText="Customer ID">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblCustomerID" Text='<%# Eval("UserID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Details">
                            <ItemTemplate>
                                <div class="container-fluid">
                                    <div class="row">
                                        <div class="col-md-10">
                                            <div class="row">
                                                <div class="col-12">
                                                    <asp:Label runat="server" ID="lblName">
                                                        <asp:Label ID="lblFullName" runat="server" Text='<%# string.Concat(Eval("FirstName"), " ", Eval("LastName"))%>' Font-Bold="True" Font-Size="Large"></asp:Label>
                                                    </asp:Label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-12">
                                                    <asp:Label ID="lblEmail" runat="server" Text='<%# Eval("EmailAddress") %>'></asp:Label>
                                                </div>
                                            </div>
                                        </div>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="LandLine Number">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblLandline" Text='<%# string.Concat("0", Eval("LocationCode"), Eval("landline"))%>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:TemplateField HeaderText="Location">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblLocation" Text='<%# Eval("LocationName") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>

                        <asp:HyperLinkField
                            Text="Print Bill"
                            HeaderText="Download Bill"
                            DataNavigateUrlFields="UserID"
                            DataNavigateUrlFormatString="Download.aspx?UserID={0}"
                            Target="_blank" />
                    </Columns>
                </asp:GridView>

                <asp:Label runat="server" ID="lblCustomersMsg" CssClass="text-center" ForeColor="Red"></asp:Label>
            </div>
        </div>
    </div>
</asp:Content>