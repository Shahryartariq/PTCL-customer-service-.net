<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="AdminSetup.aspx.cs" Inherits="PtclCustomerService.AdminSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Contnet Start -->

    <div class="row">

        <h3 class="text-center my-3 text-success ">Add Admin New</h3>
        <div class="card mb-4">
            <div class="card-body">

                <div class="form-group mt-4">
                    <label>UserName: </label>
                    <asp:RequiredFieldValidator runat="server" ID="RFV1" ControlToValidate="txtUserName" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your UserName" ForeColor="Red" ValidationGroup="AdminSetup"></asp:RequiredFieldValidator>
                    <asp:TextBox runat="server" ID="txtUserName" CssClass="form-control w-75"></asp:TextBox>
                </div>

                <div class="form-group mt-4">
                    <label>Password: </label>
                    <asp:CompareValidator runat="server" ID="CMV4" ControlToValidate="txtPassword" ControlToCompare="txtConfirmPassword" SetFocusOnError="true" Text="*" ErrorMessage="Password Donot Match" ForeColor="Red" ValidationGroup="AdminSetup"></asp:CompareValidator>
                    <asp:RequiredFieldValidator runat="server" ID="RFV5" ControlToValidate="txtPassword" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your Password" ForeColor="Red" ValidationGroup="AdminSetup"></asp:RequiredFieldValidator>

                    <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control w-75"></asp:TextBox>
                </div>

                <div class="form-group mt-4">
                    <label>Confirm Password: </label>
                    <asp:RequiredFieldValidator runat="server" ID="RFV6" ControlToValidate="txtConfirmPassword" SetFocusOnError="true" Text="*" ErrorMessage="Please Confirm Password" ForeColor="Red" ValidationGroup="AdminSetup"></asp:RequiredFieldValidator>

                    <asp:TextBox runat="server" ID="txtConfirmPassword" CssClass="form-control w-75"></asp:TextBox>
                </div>

                <div class="form-group mt-4">
                    <label>Status (Only 1 and 0):  </label>
                    <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-control w-75">
                        <asp:ListItem Text="True" Value="1" />
                        <asp:ListItem Text="False" Value="0" />
                    </asp:DropDownList>
                </div>

                <!-- Validation Summary  -->
                <div class="mt-2">
                    <asp:ValidationSummary runat="server" ID="ValidationSummary1" ForeColor="Red" ValidationGroup="AdminSetup" />
                </div>

                <div class="form-group mb-2">
                    <asp:Button Text="Submit" runat="server" ID="cmdCreate" CssClass="btn btn-primary mt-4" OnClick="cmdCreate_Click" ValidationGroup="AdminSetup" />
                    <a class="btn btn-primary mt-4" href="ManageAdmins.aspx">Cancel</a>

                    <div>
                        <asp:Label runat="server" ID="lblMsg" ForeColor="Red"></asp:Label>
                    </div>
                </div>
            </div>
        </div>
</asp:Content>