<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UserSignup.aspx.cs" Inherits="PtclCustomerService.UserSignup" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Sign Up | PCS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="Css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-lg-3"></div>
                <div class="col-lg-6 card" style="margin-top: 4%;">
                    <div class="form-group mt-2">
                        <h4 class="text-center">User Registeration for PCS</h4>
                        <label>First Name: </label>
                        <asp:TextBox runat="server" ID="txtFirstName" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group mt-4">
                        <label>Last Name: </label>
                        <asp:TextBox runat="server" ID="txtLastName" CssClass="form-control"></asp:TextBox>
                    </div>

                    <div class="row">
                        <div class="col-lg-6">
                          <div class="form-group mt-4 w-100">
                                <label>Phone: </label>
                                <asp:TextBox runat="server" ID="txtPhone" CssClass="form-control" TextMode="number"></asp:TextBox>
                          </div>
                       </div>
                     <div class="col-lg-6">
                    <div class="form-group mt-4 w-100 d-inline-block">
                        <label>CNIC: </label>
                        <asp:TextBox runat="server" ID="txtCnic" CssClass="form-control" TextMode="number"></asp:TextBox>
                    </div>
                    </div></div>
                     <div class="form-group mt-4">
                        <label>Email: </label>
                        <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" TextMode="email"></asp:TextBox>
                    </div>

                    <div class="row mt-4"">
                        <div class="col-lg-6">
                          <div class="form-group">
                        <label>Password: </label>
                        <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control" TextMode="Password"></asp:TextBox>
                    </div>
                       </div>
                     <div class="col-lg-6">
                    <div class="form-group">
                        <label>Confirm Password: </label>
                        <asp:TextBox runat="server" ID="txtConfirmPassword" CssClass="form-control" TextMode="Password"></asp:TextBox>
                    </div>
                    </div></div>

                    <div class="form-group mt-4 mb-2">
                        <asp:Button Text="Register" runat="server" ID="cmdRegister" CssClass="btn btn-primary w-100 mb-4" OnClick="cmdRegister_Click" />
                        <asp:Button Text="Login as User" runat="server" ID="cmdLoginUser" CssClass="btn btn-primary w-50" OnClick="cmdLoginUser_Click" />
                        <asp:Button Text="Login as Admin" runat="server" ID="cmdLoginAdmin" CssClass="btn btn-primary" Style="width: 48%;" onClick="cmdLoginAdmin_Click" />
                        <div>
                            <asp:Label runat="server" ID="lblMsg" ForeColor="Red"></asp:Label>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>