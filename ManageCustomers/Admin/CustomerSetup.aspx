<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="CustomerSetup.aspx.cs" Inherits="PtclCustomerService.UserSetup" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Contnet Start -->
    <div class="container">

        <div class="row">
            <asp:Label Text="Manage Customers" CssClass="text-center my-3 text-success h3" runat="server" ID="lblCustomer" ForeColor="Red"></asp:Label>

            <hr />

            <div class="col-lg-6 mt-2">
                <div class="form-group mt-2">
                    <label>First Name: </label>
                    <asp:RequiredFieldValidator runat="server" ID="RFV1" ControlToValidate="txtFirstName" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your First Name" ForeColor="Red" ValidationGroup="UserSetup"></asp:RequiredFieldValidator>
                    <asp:TextBox runat="server" ID="txtFirstName" CssClass="form-control"></asp:TextBox>
                </div>
            </div>
            <div class="col-lg-6 mt-2">
                <div class="form-group mt-2">
                    <label>Last Name: </label>
                    <asp:TextBox runat="server" ID="txtLastName" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <div class="col-lg-6">
                <div class="form-group mt-4 w-100">
                    <label>Phone: </label>
                    <asp:RequiredFieldValidator runat="server" ID="RFV2" ControlToValidate="txtPhone" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your Phone Number" ForeColor="Red" ValidationGroup="UserSetup"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator runat="server" ID="REV1" ControlToValidate="txtPhone" SetFocusOnError="true" Text="*" ErrorMessage="Invalid Phone Number" ForeColor="Red" ValidationExpression="^[0-9]{11,12}$" ValidationGroup="UserSetup"></asp:RegularExpressionValidator>

                    <asp:TextBox runat="server" ID="txtPhone" CssClass="form-control" TextMode="number"></asp:TextBox>
                </div>
            </div>
            <div class="col-lg-6">
                <div class="form-group mt-4 w-100">
                    <label>CNIC: </label>
                    <asp:RequiredFieldValidator runat="server" ID="RFV3" ControlToValidate="txtCnic" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your CNIC" ForeColor="Red" ValidationGroup="UserSetup"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator runat="server" ID="REV2" ControlToValidate="txtCnic" SetFocusOnError="true" Text="*" ErrorMessage="Invalid CNIC" ForeColor="Red" ValidationExpression="^[0-9]{13}$" ValidationGroup="UserSetup"></asp:RegularExpressionValidator>

                    <asp:TextBox runat="server" ID="txtCnic" CssClass="form-control" TextMode="number"></asp:TextBox>
                </div>
            </div>
            <div class="form-group mt-4">
                <label>Email: </label>
                <asp:RequiredFieldValidator runat="server" ID="RFV4" ControlToValidate="txtEmail" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your Email" ForeColor="Red" ValidationGroup="UserSetup"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator runat="server" ID="REV3" ControlToValidate="txtEmail" SetFocusOnError="true" Text="*" ErrorMessage="Invalid Email" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="UserSetup"></asp:RegularExpressionValidator>

                <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" TextMode="email"></asp:TextBox>
            </div>

            <div class="col-lg-6 mt-4">
                <div class="form-group">
                    <label>Password: </label>
                    <asp:CompareValidator runat="server" ID="CMV4" ControlToValidate="txtPassword" ControlToCompare="txtConfirmPassword" SetFocusOnError="true" Text="*" ErrorMessage="Password Donot Match" ForeColor="Red" ValidationGroup="UserSetup"></asp:CompareValidator>
                    <asp:RequiredFieldValidator runat="server" ID="RFV5" ControlToValidate="txtPassword" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your Password" ForeColor="Red" ValidationGroup="UserSetup"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator runat="server" ID="REV4" ControlToValidate="txtPassword" SetFocusOnError="true" Text="*" ErrorMessage="Password Must be Minimum eight characters, at least one letter and one number" ForeColor="Red" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$" ValidationGroup="UserSetup"></asp:RegularExpressionValidator>

                    <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control"></asp:TextBox>
                </div>
            </div>
            <div class="col-lg-6 mt-4">
                <div class="form-group">
                    <label>Confirm Password: </label>
                    <asp:RequiredFieldValidator runat="server" ID="RFV6" ControlToValidate="txtConfirmPassword" SetFocusOnError="true" Text="*" ErrorMessage="Please Confirm Password" ForeColor="Red" ValidationGroup="UserSetup"></asp:RequiredFieldValidator>
                    <asp:TextBox runat="server" ID="txtConfirmPassword" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <!-- Will Convert This into radio button in future module   -->
            <div class="form-group mt-4">
                <label>Status (Enter Only True or False): </label>
                <label>Status (Only 1 and 0):  </label>
                <asp:DropDownList runat="server" ID="ddlStatus" CssClass="form-control">
                    <asp:ListItem Text="True" Value="1" />
                    <asp:ListItem Text="False" Value="0" />
                </asp:DropDownList>
            </div>

            <!-- Validation Summary  -->
            <div class="mt-2">
                <asp:ValidationSummary runat="server" ID="ValidationSummary1" ForeColor="Red" ValidationGroup="UserSetup" />
            </div>

            <div class="form-group mb-2">
                <asp:Button Text="Submit" runat="server" ID="cmdSubmit" CssClass="btn btn-primary mt-4" OnClick="cmdSubmit_Click" ValidationGroup="UserSetup" />
                <a class="btn btn-primary mt-4" href="AdminManageCustomers.aspx">Cancel</a>

                <div>
                    <asp:Label runat="server" ID="lblMsg" ForeColor="Red"></asp:Label>
                </div>
            </div>
        </div>
    </div>
</asp:Content>