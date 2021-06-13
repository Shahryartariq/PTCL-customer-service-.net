<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="UserComplaint.aspx.cs" Inherits="PtclCustomerService.UserComplaint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
            <script src="../../Js/scripts.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">

        <div class="row">

            <h3 class="text-center my-3 text-success ">Manage Your Complaint</h3>
            <div class="card mb-4">
                <div class="card-body">
                    <p class="text-center">Create your PTCL online account easily by entering your email address and basic personal information. Please take a little time and submit your complaint, we will fix these complaints as soon as possible</p>
                    <div class="my-3">
                        <div class="text-center">

                            <asp:Button ID="RegisterComplaint" runat="server" Text="Register Complaint" CssClass=" btn btn-primary" OnClick="RegisterComplaint_Click"></asp:Button>
                            <asp:Button ID="PendingComplaint" runat="server" Text="Active Complaint" CssClass="btn btn-primary" OnClick="PendingComplaint_Click"></asp:Button>
                            <asp:Button ID="ApprovedComplaint" runat="server" Text="Closed Complaint" CssClass="btn btn-primary" OnClick="ApprovedComplaint_Click"></asp:Button>
                        </div>

                        <%--Register --%>

                        <asp:Panel ID="PanelRegisterComplaint" runat="server" CssClass="d-none">
                            <div class="container mt-4 w-75">
                                <div class="form-group">
                                    <label>Complaint Type: </label>
                                    <asp:DropDownList runat="server" ID="ddlComplaint" CssClass="form-control"></asp:DropDownList>
                                </div>
                                <div class="form-group mt-3">
                                    <label>Complaint Title: </label>
                                    <asp:RequiredFieldValidator runat="server" ID="RFV1" ControlToValidate="txtComplaintTitle" SetFocusOnError="true" Text="*" ForeColor="Red" ValidationGroup="Submit"></asp:RequiredFieldValidator>
                                    <asp:TextBox runat="server" ID="txtComplaintTitle" CssClass="form-control"></asp:TextBox>
                                </div>

                                <div class="form-group mt-3">
                                    <label>Complaint Description: </label>
                                    <asp:RequiredFieldValidator runat="server" ID="RFV2" ControlToValidate="txtComplaintDescription" SetFocusOnError="true" Text="*" ForeColor="Red" ValidationGroup="Submit"></asp:RequiredFieldValidator>
                                    <asp:TextBox runat="server" ID="txtComplaintDescription" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                                </div>
                                <div class="form-group mt-3">
                                    <asp:FileUpload CssClass="my-2 btn" ID="FileUploadControl" runat="server" />
                                    <asp:Button CssClass="my-2 btn btn-secondary" runat="server" ID="UploadButton" Text="Upload File" />
                                    <asp:Label runat="server" ID="StatusLabel" Text="" />
                                </div>

                                <div class="form-group mb-2">
                                    <asp:Button Text="Submit" runat="server" ID="cmdSubmit" CssClass="btn btn-primary mt-4" OnClick="cmdSubmit_Click" ValidationGroup="Submit" />
                                    <asp:Button Text="cancel" runat="server" ID="cmdCancelMenu" CssClass="btn btn-primary mt-4" OnClick="cmdCancelMenu_Click" />

                                    <div>
                                        <asp:Label runat="server" ID="lblMsg" ForeColor="Red"></asp:Label>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>

                        <%--Pending --%>

                        <asp:Panel ID="PanelPendingComplaint" runat="server" CssClass="d-none">
                            <asp:GridView runat="server" ID="GV1" CssClass="mt-3 table table-bordered table-hover" AutoGenerateColumns="false" OnRowCommand="GV_RowCommand" OnRowDeleting="GV_RowDeleting">
                                <Columns>
                                    <asp:BoundField DataField="ComplaintID" HeaderText="ID" />
                                    <asp:BoundField DataField="FirstName" HeaderText="Complainant Name" />
                                    <asp:BoundField DataField="ComplaintTitle" HeaderText="ComplaintTitle" />
                                    <asp:BoundField DataField="ComplaintTypeName" HeaderText="Complaint Type" />
                                    <asp:BoundField DataField="ComplaintCreationDate" HeaderText="Creation Date & Time" />
                                    <asp:BoundField DataField="RegeneratedID" HeaderText="Regenerated" />

                                    <asp:HyperLinkField
                                        Text="Detail"
                                        HeaderText="More Info"
                                        DataNavigateUrlFields="ComplaintID"
                                        DataNavigateUrlFormatString="UserComplaintDetails.aspx?ComplaintID={0}"
                                        Target="_blank" />
                                    <asp:TemplateField HeaderText="Action">
                                        <ItemTemplate>
                                            <asp:LinkButton runat="server" ID="lnkDelete" Text="Delete" CommandName="delete" CommandArgument='<%# Bind("ComplaintID") %>' OnClientClick="return confirm('Are you sure you want to delete this Complaint?');"><i class="mx-3 text-center fas fa-trash fa-1x"></i></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Regenerated">
                                        <ItemTemplate>
                                            <asp:LinkButton runat="server" ID="lnkRegenerated" Text="Regenerated" CommandName="Regenerated" CommandArgument='<%# Bind("ComplaintID") %>'>
                                                <asp:Label runat="server" ID="lblRegenerated"></asp:Label>
                                            </asp:LinkButton>
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

                                    <asp:HyperLinkField
                                        Text="Detail"
                                        HeaderText="More Info"
                                        DataNavigateUrlFields="ComplaintID"
                                        DataNavigateUrlFormatString="AdminComplaintDetails.aspx?ComplaintID={0}"
                                        Target="_blank" />
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
    </div>
</asp:Content>