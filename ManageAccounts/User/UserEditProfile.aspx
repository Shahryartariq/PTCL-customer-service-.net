<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="UserEditProfile.aspx.cs" Inherits="PtclCustomerService.UserPanel" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
   </style>
    <script src="../../Js/scripts.js"></script>

    <!-- Page level ki Java/cs -->
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="container w-75">

        <div class="row overflow-hidden">

            <h3 class="text-center my-3 text-success ">Edit Account</h3>
            <hr />

            <div class="col-lg-6">
                <div class="form-group mt-2">
                    <label>First Name: </label>
                    <asp:RequiredFieldValidator runat="server" ID="RFV1" ControlToValidate="txtMyName" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your First Name" ForeColor="Red" ValidationGroup="UserUpdate"></asp:RequiredFieldValidator>
                    <asp:TextBox runat="server" ID="txtMyName" CssClass="form-control" />
                </div>
            </div>

            <div class="col-lg-6">
                <div class="form-group mt-2">
                    <label>Last Name: </label>
                    <asp:TextBox runat="server" ID="txtLastName" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <div class="col-lg-6">

                <div class="form-group mt-4 w-100">
                    <label>Phone: </label>
                    <asp:RequiredFieldValidator runat="server" ID="RFV2" ControlToValidate="txtPhone" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your Phone Number" ForeColor="Red" ValidationGroup="UserUpdate"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator runat="server" ID="REV1" ControlToValidate="txtPhone" SetFocusOnError="true" Text="*" ErrorMessage="Invalid Phone Number" ForeColor="Red" ValidationExpression="^[0-9]{11,12}$" ValidationGroup="UserUpdate"></asp:RegularExpressionValidator>

                    <asp:TextBox runat="server" ID="txtPhone" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <div class="col-lg-6">

                <div class="form-group mt-4 w-100">
                    <label>CNIC: </label>
                    <asp:RequiredFieldValidator runat="server" ID="RFV3" ControlToValidate="txtCnic" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your CNIC" ForeColor="Red" ValidationGroup="UserUpdate"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator runat="server" ID="REV2" ControlToValidate="txtCnic" SetFocusOnError="true" Text="*" ErrorMessage="Invalid CNIC" ForeColor="Red" ValidationExpression="^[0-9]{13}$" ValidationGroup="UserUpdate"></asp:RegularExpressionValidator>

                    <asp:TextBox runat="server" ID="txtCnic" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <div class="form-group mt-4">
                <label>Email: </label>
                <asp:RequiredFieldValidator runat="server" ID="RFV4" ControlToValidate="txtEmail" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your Email" ForeColor="Red" ValidationGroup="UserUpdate"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator runat="server" ID="REV3" ControlToValidate="txtEmail" SetFocusOnError="true" Text="*" ErrorMessage="Invalid Email" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="UserUpdate"></asp:RegularExpressionValidator>
                <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control"></asp:TextBox>
            </div>

            <div class="col-lg-6 mt-4">
                <div class="form-group">
                    <label>Password: </label>
                    <asp:CompareValidator runat="server" ID="CMV4" ControlToValidate="txtPassword" ControlToCompare="txtConfirmPassword" SetFocusOnError="true" Text="*" ErrorMessage="Password Donot Match" ForeColor="Red" ValidationGroup="UserUpdate"></asp:CompareValidator>
                    <asp:RequiredFieldValidator runat="server" ID="RFV5" ControlToValidate="txtPassword" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your Password" ForeColor="Red" ValidationGroup="UserUpdate"></asp:RequiredFieldValidator>

                    <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control"></asp:TextBox>
                </div>
            </div>

            <div class="col-lg-6 mt-4">
                <div class="form-group">
                    <label>Confirm Password: </label>
                    <asp:RequiredFieldValidator runat="server" ID="RFV6" ControlToValidate="txtConfirmPassword" SetFocusOnError="true" Text="*" ErrorMessage="Please Confirm Password" ForeColor="Red" ValidationGroup="UserUpdate"></asp:RequiredFieldValidator>
                    <asp:TextBox runat="server" ID="txtConfirmPassword" CssClass="form-control"></asp:TextBox>
                </div>
            </div>



             <div class="col-lg-6 mt-4">
                <div class="form-group">
                    <label>Area Code: </label>
                    <asp:RequiredFieldValidator runat="server" ID="RFV7" ControlToValidate="ddlLocationCode" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your Area Code" ForeColor="Red" ValidationGroup="UserUpdate"></asp:RequiredFieldValidator>

                     <asp:DropDownList runat="server" ID="ddlLocationCode" CssClass="form-control">
                </asp:DropDownList>
                </div>
            </div>

            <div class="col-lg-6 mt-4">
                <div class="form-group">
                    <label>LandLine Number: </label>
                    <asp:RequiredFieldValidator runat="server" ID="RFV8" ControlToValidate="txtLandLineNumber" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Landline Number" ForeColor="Red" ValidationGroup="UserUpdate"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator runat="server" ID="REV5" ControlToValidate="txtLandLineNumber" SetFocusOnError="true" Text="*" ErrorMessage="Invalid LandLine Number" ForeColor="Red" ValidationExpression="^[0-9]{7}$" ValidationGroup="UserUpdate"></asp:RegularExpressionValidator>

                    <asp:TextBox runat="server" ID="txtLandLineNumber" CssClass="form-control"></asp:TextBox>
                </div>
            </div>







                   <div class="form-group mt-4">
                <!-- profile -->
                <label>Update Your Profile Picture </label>
                <asp:RegularExpressionValidator ID="RegExValFileUploadFileType" runat="server"
                    ControlToValidate="FileUpload"
                    ErrorMessage="Only .jpg,.png,.jpeg Files are allowed"
                    ValidationExpression="(.*?)\.(jpg|jpeg|png|JPG|JPEG|PNG)$"
                    SetFocusOnError="true" Text="*" ForeColor="Red" ValidationGroup="UserUpdate" />
                <br />
                <asp:FileUpload ID="FileUpload" runat="server" accept=".png,.jpg,.jpeg" /><br />
                <asp:Label ID="lblUpload" runat="server" Text=""></asp:Label>
            </div>

            <div class="form-group my-4 ">
                <label>Status: </label>
                <asp:TextBox runat="server" ReadOnly="true" ID="txtStatus" CssClass="form-control" />
            </div>
            <!-- Validation Summary  -->
            <div class="mt-2">
                <asp:ValidationSummary runat="server" ID="ValidationSummary1" ForeColor="Red" ValidationGroup="UserUpdate" />
            </div>

            <div class="form-group mb-4">
                <asp:Button Text="Update" runat="server" ID="cmdUpdate" CssClass="btn btn-primary" OnClick="cmdUpdate_Click" ValidationGroup="UserUpdate" />
                <a class="btn btn-primary" href="UserProfile.aspx">Cancel</a>

                <div>
                    <asp:Label runat="server" ID="lblMsg" ForeColor="Red"></asp:Label>
                </div>
            </div>
        </div>
    </div>
</asp:Content>