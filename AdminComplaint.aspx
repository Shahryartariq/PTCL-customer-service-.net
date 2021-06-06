<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="AdminComplaint.aspx.cs" Inherits="PtclCustomerService.AdminComplaint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">

   
    <div class="row">

        <h3 class="text-center my-3 text-success ">Manage Your Complaint</h3>
        <div class="card mb-4">
            <div class="card-body">
        <p class="text-center">Create your PTCL online account easily by entering your email address and basic personal information. Please take a little time and submit your complaint, we will fix these complaints as soon as possible</p>
        <div class="mb-3">
            <div class="text-center">

                <asp:Button ID="PendingComplaint" runat="server" Text="Pending Complaint" CssClass="btn btn-primary" OnClick="PendingComplaint_Click"></asp:Button>
                <asp:Button ID="ApprovedComplaint" runat="server" Text="Approved Complaint" CssClass="btn btn-primary" OnClick="ApprovedComplaint_Click"></asp:Button>
            </div>

            <%--Pending --%>
            <asp:Panel ID="PanelPendingComplaint" runat="server" CssClass="d-none">
                <asp:GridView runat="server" ID="GV1" CssClass="mt-3 table table-bordered table-hover" AutoGenerateColumns="false" OnRowCommand="GV_RowCommand" OnRowDeleting="GV_RowDeleting">
                    <Columns>
                        <asp:BoundField DataField="ComplaintID" HeaderText="ComplaintID" />
                        <asp:BoundField DataField="ComplaintTitle" HeaderText="Complaint Title" />
                        <asp:BoundField DataField="ComplaintStatus" HeaderText="Status" />
                        <asp:BoundField DataField="ComplaintTypeName" HeaderText="Complaint Type" />
                        <asp:HyperLinkField
                            Text="Detail"
                            HeaderText="More Info"
                            DataNavigateUrlFields="ComplaintID"
                            DataNavigateUrlFormatString="AdminComplaintDetails.aspx?ComplaintID={0}"
                            target="_blank"
                            />
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="lnkDelete" Text="Delete" CommandName="delete" CommandArgument='<%# Bind("ComplaintID") %>' OnClientClick="return confirm('Are you sure you want to delete this Complaint?');"><i class="mx-3 text-center fas fa-trash fa-1x"></i></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </asp:Panel>
            <%--Approved --%>

            <asp:Panel ID="PanelApprovedComplaint" runat="server" CssClass="d-none">
                <asp:GridView runat="server" ID="GV2" CssClass="mt-3 table table-bordered table-hover" AutoGenerateColumns="false" OnRowCommand="GV_RowCommand" OnRowDeleting="GV_RowDeleting">
                    <Columns>
                        <asp:BoundField DataField="ComplaintID" HeaderText="ComplaintID" />
                        <asp:BoundField DataField="ComplaintTitle" HeaderText="Complaint Title" />
                        <asp:BoundField DataField="ComplaintStatus" HeaderText="Status" />
                        <asp:BoundField DataField="ComplaintTypeName" HeaderText="Complaint Type" />
                        <asp:HyperLinkField
                            Text="Detail"
                            HeaderText="More Info"
                            DataNavigateUrlFields="ComplaintID"
                            DataNavigateUrlFormatString="AdminComplaintDetails.aspx?ComplaintID={0}"
                            target="_blank"
                            />
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton runat="server" ID="lnkDelete" Text="Delete" CommandName="delete" CommandArgument='<%# Bind("ComplaintID") %>' OnClientClick="return confirm('Are you sure you want to delete this Complaint?');"><i class="mx-3 text-center fas fa-trash fa-1x"></i></asp:LinkButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </asp:Panel>
        </div>
    </div>
             </div>
        </div>
</asp:Content>