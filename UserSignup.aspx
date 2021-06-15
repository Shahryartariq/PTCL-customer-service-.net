<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserSignup.aspx.cs" Inherits="PtclCustomerService.UserSignup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up | PCS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="Css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="">
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-lg-3"></div>
                <div class="col-lg-6 card mt-2">
                    <h4 class="text-center text-success mt-2">User Registeration for PCS</h4>

                    <div class="row">
                        <div class="col-lg-6 mt-2">
                            <div class="form-group mt-2">
                                <!-- First Name Name -->
                                <label>First Name: </label>
                                <asp:RequiredFieldValidator runat="server" ID="RFV1" ControlToValidate="txtFirstName" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your First Name" ForeColor="Red" ValidationGroup="UserSignUp"></asp:RequiredFieldValidator>
                                <asp:TextBox runat="server" ID="txtFirstName" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <!-- Last Name -->
                        <div class="col-lg-6 mt-2">
                            <div class="form-group mt-2">
                                <label>Last Name (Optional) </label>
                                <asp:TextBox runat="server" ID="txtLastName" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <div class="row mt-1">
                        <!-- Phone -->
                        <div class="col-lg-6 mt-2">
                            <div class="form-group  w-100">
                                <label>Phone: </label>
                                <asp:RequiredFieldValidator runat="server" ID="RFV2" ControlToValidate="txtPhone" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your Phone Number" ForeColor="Red" ValidationGroup="UserSignUp"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ID="REV1" ControlToValidate="txtPhone" SetFocusOnError="true" Text="*" ErrorMessage="Invalid Phone Number" ForeColor="Red" ValidationExpression="^[0-9]{11,12}$" ValidationGroup="UserSignUp"></asp:RegularExpressionValidator>

                                <asp:TextBox runat="server" ID="txtPhone" CssClass="form-control" TextMode="Phone"></asp:TextBox>
                            </div>
                        </div>

                        <!-- CNIC -->
                        <div class="col-lg-6 mt-2">
                            <div class="form-group w-100">
                                <label>CNIC: </label>
                                <asp:RequiredFieldValidator runat="server" ID="RFV3" ControlToValidate="txtCnic" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your CNIC" ForeColor="Red" ValidationGroup="UserSignUp"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ID="REV2" ControlToValidate="txtCnic" SetFocusOnError="true" Text="*" ErrorMessage="Invalid CNIC" ForeColor="Red" ValidationExpression="^[0-9]{13}$" ValidationGroup="UserSignUp"></asp:RegularExpressionValidator>

                                <asp:TextBox runat="server" ID="txtCnic" CssClass="form-control" TextMode="number"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <!-- Email -->
                    <div class="form-group mt-2">
                        <label>Email: </label>
                        <asp:RequiredFieldValidator runat="server" ID="RFV4" ControlToValidate="txtEmail" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your Email" ForeColor="Red" ValidationGroup="UserSignUp"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator runat="server" ID="REV3" ControlToValidate="txtEmail" SetFocusOnError="true" Text="*" ErrorMessage="Invalid Email" ForeColor="Red" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ValidationGroup="UserSignUp"></asp:RegularExpressionValidator>
                        <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" TextMode="email"></asp:TextBox>
                    </div>

                    <div class="row mt-2">
                        <!-- Password -->
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Password: </label>
                                <asp:CompareValidator runat="server" ID="CMV4" ControlToValidate="txtPassword" ControlToCompare="txtConfirmPassword" Text="*" ErrorMessage="Password Donot Match" ForeColor="Red" ValidationGroup="UserSignUp"></asp:CompareValidator>
                                <asp:RequiredFieldValidator runat="server" ID="RFV5" ControlToValidate="txtPassword" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your Password" ForeColor="Red" ValidationGroup="UserSignUp"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator runat="server" ID="REV4" ControlToValidate="txtPassword" SetFocusOnError="true" Text="*" ErrorMessage="Password Must be Minimum eight characters, at least one letter and one number" ForeColor="Red" ValidationExpression="^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$" ValidationGroup="UserSignUp"></asp:RegularExpressionValidator>
                                <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control" TextMode="Password"></asp:TextBox>
                            </div>
                        </div>

                        <!-- Confirm Password -->
                        <div class="col-lg-6">
                            <div class="form-group">
                                <label>Confirm Password: </label>
                                <asp:RequiredFieldValidator runat="server" ID="RFV6" ControlToValidate="txtConfirmPassword" SetFocusOnError="true" Text="*" ErrorMessage="Please Confirm Password" ForeColor="Red" ValidationGroup="UserSignUp"></asp:RequiredFieldValidator>
                                <asp:TextBox runat="server" ID="txtConfirmPassword" CssClass="form-control" TextMode="Password"></asp:TextBox>
                            </div>
                        </div>
                    </div>

                    <div class="form-group mt-2">
                        <!-- Location -->
                        <label>Location: </label>
                        <asp:RequiredFieldValidator runat="server" ID="RFV7" ControlToValidate="txtLocation" SetFocusOnError="true" Text="*" ErrorMessage="Please Enter Your Current Location" ForeColor="Red" ValidationGroup="UserSignUp"></asp:RequiredFieldValidator>
                        <asp:TextBox runat="server" ID="txtLocation" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="form-group mt-2">
                        <!-- Location -->
                        <label>Upload Your Profile Picture </label>
                        <asp:RegularExpressionValidator ID="RegExValFileUploadFileType" runat="server"
                            ControlToValidate="FileUpload"
                            ErrorMessage="Only .jpg,.png,.jpeg Files are allowed"
                            ValidationExpression="(.*?)\.(jpg|jpeg|png|JPG|JPEG|PNG)$"
                            SetFocusOnError="true" Text="*" ForeColor="Red" ValidationGroup="UserSignUp">
                        </asp:RegularExpressionValidator>
                        <br />

                        <asp:FileUpload CssClass="my-2 btn" ID="FileUpload" runat="server" accept=".png,.jpg,.jpeg" /><br />
                        <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                    </div>

                    <!-- Validation Summary  -->
                    <div class="mt-2">
                        <asp:ValidationSummary runat="server" ID="ValidationSummary1" ForeColor="Red" ValidationGroup="UserSignUp" />
                    </div>

                    <!-- Buttons -->
                    <div>
                        <asp:Label runat="server" ID="lblMsg" ForeColor="Red"></asp:Label>
                    </div>
                    <div class="form-group mt-4 mb-2">
                        <asp:Button Text="Register" runat="server" ID="cmdRegister" CssClass="btn btn-primary w-100 mb-4" CausesValidation="true" ValidationGroup="UserSignUp" OnClick="cmdRegister_Click" />
                        <asp:Button Text="Login as User" runat="server" ID="cmdLoginUser" CssClass="btn btn-primary w-50" OnClick="cmdLoginUser_Click" />
                        <asp:Button Text="Login as Admin" runat="server" ID="cmdLoginAdmin" CssClass="btn btn-primary" Style="width: 48%;" OnClick="cmdLoginAdmin_Click" />
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>