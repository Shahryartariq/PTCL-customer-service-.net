<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="PtclCustomerService.AdminLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Login | PCS</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link href="Css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="row">
                <div class="col-lg-4"></div>
                <div class="col-lg-4 card" style="margin-top: 10%;">
                    <div class="form-group mt-4">
                        <h4 class="text-center">Login as Admin</h4>
                        <label>UserName: </label>
                        <asp:TextBox runat="server" ID="txtUserName" CssClass="form-control"></asp:TextBox>
                    </div>
                    <div class="form-group mt-4">
                        <label>Password: </label>
                        <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control" TextMode="Password"></asp:TextBox>
                    </div>
                    <div class="form-group mt-4 mb-2">
                        <asp:Button Text="Login Admin" runat="server" ID="cmdLoginAdmin" CssClass="btn btn-primary w-100 mb-4" OnClick="cmdLoginAdmin_Click" />
                        <asp:Button Text="SignUp User" runat="server" ID="cmdSignup" CssClass="btn btn-primary w-50" OnClick="cmdSignup_Click" />
                        <asp:Button Text="Login as User" runat="server" ID="cmdLoginUser" CssClass="btn btn-primary" Style="width: 48%;" OnClick="cmdLoginUser_Click" />
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