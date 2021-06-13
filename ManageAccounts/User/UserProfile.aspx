<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="UserProfile.aspx.cs" Inherits="PtclCustomerService.ManageAccounts.User.UserProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            margin-top: 20px;
            color: #1a202c;
            text-align: left;
            background-color: #e2e8f0;
        }

        .main-body {
            padding: 15px;
        }

        .card {
            box-shadow: 0 1px 3px 0 rgba(0,0,0,.1), 0 1px 2px 0 rgba(0,0,0,.06);
        }

        .card {
            position: relative;
            display: flex;
            flex-direction: column;
            min-width: 0;
            word-wrap: break-word;
            background-color: #fff;
            background-clip: border-box;
            border: 0 solid rgba(0,0,0,.125);
            border-radius: .25rem;
        }

        .card-body {
            flex: 1 1 auto;
            min-height: 1px;
            padding: 1rem;
        }

       
    </style>
    <script src="../../Js/scripts.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">

        <!-- Breadcrumb -->
        <nav aria-label="breadcrumb" class="main-breadcrumb">
            <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">Home</a></li>
                <li class="breadcrumb-item"><a href="#">Users</a></li>
                <li class="breadcrumb-item active" aria-current="page">Profile</li>
            </ol>
        </nav>
    </div>
    <!-- /Breadcrumb -->

    <h3 class="text-center my-3 text-success ">User Profile</h3>
    <div class="container">
        <div class="main-body">

            <div class="row gutters-sm">
                <div class="col-md-4 mb-3">
                    <div class="card">
                        <div class="card-body">
                            <div class="d-flex flex-column align-items-center text-center">
                                <asp:Image runat="server" alt="User Profile Picture" CssClass="rounded-circle" Width="150" Height="160" ID="userPic" />
                                <div class="mt-3">
                                    <asp:Panel runat="server" ID="PanelFirstName"></asp:Panel>
                                    <asp:Panel runat="server" CssClass="ext-secondary mb-1" ID="PanelCustomerType">User at PTCL Customer Care</asp:Panel>
                                    <asp:Panel runat="server" CssClass="text-muted font-size-sm" ID="PanelLocation"></asp:Panel>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-8">
                    <div class="card mb-3">
                        <div class="card-body">
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Full Name</h6>
                                </div>
                                <asp:Panel runat="server" ID="PanelFullName" Text="" CssClass="col-sm-9 text-secondary"></asp:Panel>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Email</h6>
                                </div>
                                <asp:Panel runat="server" ID="PanelEmail" Text="" CssClass="col-sm-9 text-secondary"></asp:Panel>
                            </div>
                            <hr>
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Phone</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    <asp:Panel runat="server" ID="PanelPhone" Text="" CssClass="col-sm-9 text-secondary"></asp:Panel>
                                </div>
                            </div>
                            <hr />
                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">CNIC</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    <asp:Panel runat="server" ID="PanelCnic" Text="" CssClass="col-sm-9 text-secondary"></asp:Panel>
                                </div>
                            </div>
                            <hr>

                            <div class="row">
                                <div class="col-sm-3">
                                    <h6 class="mb-0">Customer Status</h6>
                                </div>
                                <div class="col-sm-9 text-secondary">
                                    <asp:Panel runat="server" ID="PanelStatus" Text="" CssClass="col-sm-9 text-secondary"></asp:Panel>
                                </div>
                            </div>
                            <hr>

                            <div class="row">
                                <div class="col-sm-12">
                                    <a class="btn btn-primary " target="__blank" href="UserEditProfile.aspx">Edit Profile</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>