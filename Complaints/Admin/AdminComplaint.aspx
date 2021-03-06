<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="AdminComplaint.aspx.cs" Inherits="PtclCustomerService.AdminComplaint" %>

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

        <div class="row">

            <asp:Label runat="server" ID="lblTitle" CssClass="h3 text-center my-3 text-success "></asp:Label>
            <div class="card mb-4">
                <div class="card-body">
                    <p class="text-center">Create your PTCL online account easily by entering your email address and basic personal information. Please take a little time and submit your complaint, we will fix these complaints as soon as possible</p>
                    <div class="my-3">
                        <div class="text-center">

                            <asp:Button ID="PendingComplaint" runat="server" Text="Active Complaint" CssClass="btn btn-primary" OnClick="PendingComplaint_Click"></asp:Button>
                            <asp:Button ID="ApprovedComplaint" runat="server" Text="Closed Complaint" CssClass="btn btn-primary" OnClick="ApprovedComplaint_Click"></asp:Button>
                            <asp:Button ID="RegeneratedComplaint" runat="server" Text="Regenerated Complaint" CssClass="btn btn-primary" OnClick="RegeneratedComplaint_Click"></asp:Button>
                        </div>

                        <%--Pending --%>
                        <asp:Panel ID="PanelPendingComplaint" runat="server" CssClass="d-none">
                            <asp:GridView runat="server" ClientIDMode="Static" ID="GVPendingComplaint" CssClass="datatable mt-3 table table-bordered table-hover" AutoGenerateColumns="false" OnRowCommand="GV_RowCommand" OnRowDeleting="GV_RowDeleting">
                                <Columns>
                                    <asp:BoundField DataField="ComplaintID" HeaderText="Complaint ID" />
                                    <asp:BoundField DataField="FirstName" HeaderText="Complainant Name" />
                                    <asp:BoundField DataField="ComplaintTypeName" HeaderText="Complaint Type" />
                                    <asp:BoundField DataField="ComplaintCreationDate" HeaderText="Creation Date & Time" />

                                    <asp:HyperLinkField
                                        Text="Detail"
                                        HeaderText="More Info"
                                        DataNavigateUrlFields="ComplaintID"
                                        DataNavigateUrlFormatString="AdminComplaintDetails.aspx?ComplaintID={0}"
                                        Target="_blank" />
                                </Columns>
                            </asp:GridView>

                            <asp:Label runat="server" ID="lblTablePendingMsg" CssClass="text-center" ForeColor="Red"></asp:Label>
                        </asp:Panel>
                        <%--Approved --%>
                        <asp:HyperLink runat="server" NavigateUrl="~/UserLogin.aspx"></asp:HyperLink>

                        <asp:Panel ID="PanelApprovedComplaint" ClientIDMode="Static" runat="server" CssClass="d-none">
                            <asp:GridView runat="server" ID="GVApprovedComplaint" CssClass="datatable mt-3 table table-bordered table-hover" AutoGenerateColumns="false" OnRowCommand="GV_RowCommand" OnRowDeleting="GV_RowDeleting">
                                <Columns>
                                    <asp:BoundField DataField="ComplaintID" HeaderText="Complaint ID" />
                                    <asp:BoundField DataField="FirstName" HeaderText="Complainant Name" />
                                    <asp:BoundField DataField="ComplaintTypeName" HeaderText="Complaint Type" />
                                    <asp:BoundField DataField="ComplaintCreationDate" HeaderText="Creation Date & Time" />

                                     <asp:TemplateField HeaderText="RegeneratedID">

                                        <ItemTemplate>
                                            <asp:Label ID="Label9" runat="server" Text='<%# Convert.ToInt32(Eval("RegeneratedID")) == 0 ? "No" : "Yes" %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:HyperLinkField
                                        Text="Detail"
                                        HeaderText="More Info"
                                        DataNavigateUrlFields="ComplaintID"
                                        DataNavigateUrlFormatString="AdminComplaintDetails.aspx?ComplaintID={0}"
                                        Target="_blank" />
                                </Columns>
                            </asp:GridView>
                            <asp:Label runat="server" ID="lblTableClosedMsg" CssClass="text-center" ForeColor="Red"></asp:Label>
                        </asp:Panel>

                        <%--Regenerated Complaints --%>
                        <asp:Panel ID="PanelRegeneratedComplaint" runat="server" CssClass="d-none">
                            <asp:GridView runat="server" ClientIDMode="Static" ID="GVRegeneratedComplaint" CssClass="datatable mt-3 table table-bordered table-hover" AutoGenerateColumns="false" OnRowCommand="GV_RowCommand" OnRowDeleting="GV_RowDeleting">
                                <Columns>
                                    <asp:BoundField DataField="ComplaintID" HeaderText="Complaint ID" />
                                    <asp:BoundField DataField="FirstName" HeaderText="Complainant Name" />
                                    <asp:BoundField DataField="ComplaintTypeName" HeaderText="Complaint Type" />
                                    <asp:BoundField DataField="ComplaintCreationDate" HeaderText="Creation Date & Time" />
                                    <asp:HyperLinkField
                                        Text="Detail"
                                        HeaderText="More Info"
                                        DataNavigateUrlFields="ComplaintID"
                                        DataNavigateUrlFormatString="AdminComplaintDetails.aspx?ComplaintID={0}"
                                        Target="_blank" />
                                </Columns>
                            </asp:GridView>
                            <asp:Label runat="server" ID="lblTableRegeneratedMsg" CssClass="text-center" ForeColor="Red"></asp:Label>
                        </asp:Panel>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>