<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="AdminReport.aspx.cs" Inherits="PtclCustomerService.Report.Admin.AdminReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        fixflow {
            overflow: hidden;
        }

        .dataTables_filter {
            margin-bottom: 1%;
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

    <script>
        if (document.getElementById('ddlAdmins').value == '--Select--' || document.getElementById('ddlAdmins').value == '0') {
            alert("Please select Admin");
            document.getElementById('ddlAdmins').focus();
            return false;
        }
        else {
            if (document.getElementById('ddlLocation').value == '--Select--' || document.getElementById('ddlLocation').value == '0') {
                alert("Please select a City");
                document.getElementById('ddlLocation').focus();
                return false;
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!--<div class="container mt-4">
        <asp:RequiredFieldValidator runat="server" ID="RFV0" ControlToValidate="ddlPrimary" SetFocusOnError="true" Text="*" InitialValue="0" ForeColor="Red"></asp:RequiredFieldValidator>
        <asp:DropDownList ID="ddlPrimary" runat="server" AutoPostBack="true">
            <asp:ListItem Value="0">Select</asp:ListItem>
            <asp:ListItem Value="1">Admin</asp:ListItem>
            <asp:ListItem Value="2">Complaint</asp:ListItem>
            <asp:ListItem Value="3">Users</asp:ListItem>
        </asp:DropDownList>    </div>-->
    <div class="container mt-4">
        <div class="row mt-2">
            <!-- Main Category -->
            <div class="col-lg-6">
                <div class="form-group">
                    <label>Select Required Admin</label>
                    <br />
                    <asp:DropDownList runat="server" ID="ddlAdmins" AutoPostBack="true" CssClass="form-control">
                    </asp:DropDownList>
                </div>
            </div>

            <!-- Sub Category -->
            <div class="col-lg-6">
                <div class="form-group">
                    <asp:RequiredFieldValidator runat="server" ID="RFV1" ControlToValidate="ddlLocation" SetFocusOnError="true" Text="*" InitialValue="1" ForeColor="Red"></asp:RequiredFieldValidator>
                    <label>Location</label>
                    <br />
                    <asp:DropDownList runat="server" ID="ddlLocation" CssClass="form-control"></asp:DropDownList>
                </div>
            </div>
        </div>
        <asp:Label runat="server" ID="lblAdminmsg" CssClass="text-center" ForeColor="Red"></asp:Label>

        <div class="text-center my-4">
            <asp:Button runat="server" ID="btnSearch" Text="Search" OnClick="btnSearch_Click" CssClass="btn btn-primary" />
        </div>
        <asp:GridView runat="server" ID="GVAdmin" ClientIDMode="Static" CssClass="table table-bordered table-hover" AutoGenerateColumns="false">
            <Columns>
                <asp:BoundField DataField="ComplaintID" HeaderText="Admin ID" />
                <asp:BoundField DataField="ComplaintTitle" HeaderText="Title" />
                <asp:BoundField DataField="FirstName" HeaderText="Customer Name" />
                <asp:BoundField DataField="FullName" HeaderText="Resolved by" />
                <asp:BoundField DataField="ComplaintCreationDate" HeaderText="ComplaintCreationDate" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>