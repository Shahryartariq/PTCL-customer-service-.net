<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="AdminSetup.aspx.cs" Inherits="PtclCustomerService.AdminSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h3 class="text-center my-3 text-success ">Add Admin New</h3>
    <div class="row w-75 m-auto">

        <div class="card mb-4 card-body">

            <div class="form-group mt-4">
                <label>UserName: </label>
                <asp:RequiredFieldValidator runat="server" ID="RFV1" ControlToValidate="txtUserName" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your UserName" ForeColor="Red" ValidationGroup="AdminSetup"></asp:RequiredFieldValidator>
                <asp:TextBox runat="server" ID="txtUserName" CssClass="form-control w-100"></asp:TextBox>
            </div>

            <div class="form-group mt-4">
                <label>FullName: </label>
                <asp:RequiredFieldValidator runat="server" ID="RFV2" ControlToValidate="txtFullName" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your FullName   " ForeColor="Red" ValidationGroup="AdminSetup"></asp:RequiredFieldValidator>
                <asp:TextBox runat="server" ID="txtFullName" CssClass="form-control w-100"></asp:TextBox>
            </div>

            <div class="form-group mt-4">
                <label>Email: </label>
                <asp:RequiredFieldValidator runat="server" ID="RFV3" ControlToValidate="txtEmailAddress" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your Email   " ForeColor="Red" ValidationGroup="AdminSetup"></asp:RequiredFieldValidator>
                <asp:TextBox runat="server" ID="txtEmailAddress" CssClass="form-control w-100" TextMode="Email"></asp:TextBox>
            </div>

            <div class="row">
                <div class="col-lg-6">
                    <div class="form-group mt-4">
                        <label>Password: </label>
                        <asp:CompareValidator runat="server" ID="CMV4" ControlToValidate="txtPassword" ControlToCompare="txtConfirmPassword" SetFocusOnError="true" Text="*" ErrorMessage="Password Donot Match" ForeColor="Red" ValidationGroup="AdminSetup"></asp:CompareValidator>
                        <asp:RequiredFieldValidator runat="server" ID="RFV5" ControlToValidate="txtPassword" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your Password" ForeColor="Red" ValidationGroup="AdminSetup"></asp:RequiredFieldValidator>
                        <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>

                <div class="col-lg-6">
                    <div class="form-group mt-4">
                        <label>Confirm Password: </label>
                        <asp:RequiredFieldValidator runat="server" ID="RFV6" ControlToValidate="txtConfirmPassword" SetFocusOnError="true" Text="*" ErrorMessage="Please Confirm Password" ForeColor="Red" ValidationGroup="AdminSetup"></asp:RequiredFieldValidator>

                        <asp:TextBox runat="server" ID="txtConfirmPassword" CssClass="form-control"></asp:TextBox>
                    </div>
                </div>
            </div>
            
            <div class="row">
                <div class="col-lg-6">
                    <div class="form-group mt-4">
                        <label>Location: </label>
                        <asp:RequiredFieldValidator runat="server" ID="RFV4" ControlToValidate="txtAddress" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your Address   " ForeColor="Red" ValidationGroup="AdminSetup"></asp:RequiredFieldValidator>
                        <asp:TextBox runat="server" ID="txtAddress" CssClass="form-control w-100"></asp:TextBox>
                    </div>
                </div> 
                <div class="col-lg-6">
                    <div class="form-group mt-4">
                        <label>Phome: </label>
                       
                                <asp:RequiredFieldValidator runat="server" ID="RFVPhone" ControlToValidate="txtPhone" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your Phone Number" ForeColor="Red" ValidationGroup="AdminSetup"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ID="REVP" ControlToValidate="txtPhone" SetFocusOnError="true" Text="*" ErrorMessage="Invalid Phone Number" ForeColor="Red" ValidationExpression="^[0-9]{11,12}$" ValidationGroup="AdminSetup"></asp:RegularExpressionValidator>

                                <asp:TextBox runat="server" ID="txtPhone" CssClass="form-control" TextMode="Phone"></asp:TextBox>
                            </div>
                    </div>
                </div>

            <div class="form-group mt-4">
                <label>Status:  </label>
                <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-control w-50">
                    <asp:ListItem Text="True" Value="1" />
                    <asp:ListItem Text="False" Value="0" />
                </asp:DropDownList>
            </div>

            <div class="form-group mt-4">
                <label>Upload Your Profile Picture </label>
                <br />
                <asp:FileUpload ID="FileUpload" runat="server" /><br />
                <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
            </div>

            <div class="form-group mt-4">
                <label>Location: </label>
                <asp:TextBox runat="server" ID="txtDummyImage" CssClass="form-control w-100"></asp:TextBox>
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