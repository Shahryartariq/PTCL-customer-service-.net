<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="AdminPanel.aspx.cs" Inherits="PtclCustomerService.AdminPanel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <!-- Contnet Start -->
                  <h3 class="text-center my-3 text-success ">Our PTCL Customers</h3>
                    <div class="card mb-4">
                         <div class="card-body">

                        <asp:GridView runat="server" ID="GV" CssClass="table table-bordered table-hover" AutoGenerateColumns="false" OnRowCommand="GV_RowCommand" OnRowDeleting="GV_RowDeleting" OnRowEditing="GV_RowEditing">
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