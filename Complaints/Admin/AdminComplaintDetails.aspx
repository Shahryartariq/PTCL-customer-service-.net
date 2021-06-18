<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="AdminComplaintDetails.aspx.cs" Inherits="PtclCustomerService.AdminComplaintDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Js/scripts.js"></script>

    <style>
        body {
            margin-top: 20px;
            background: #f5f5f5;
        }

        .ui-w-100 {
            width: 100px !important;
            height: auto;
        }

        .card {
            background-clip: padding-box;
            box-shadow: 0 1px 4px rgba(24,28,33,0.012);
        }

        .user-view-table td:first-child {
            width: 9rem;
        }

        .user-view-table td {
            padding-right: 0;
            padding-left: 0;
            border: 0;
        }

        .text-light {
            color: #babbbc !important;
        }

        .card .row-bordered > [class*=" col-"]::after {
            border-color: rgba(24,28,33,0.075);
        }

        .text-xlarge {
            font-size: 170% !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">

        <div class="align-items-center py-3 mb-3 text-center">
            <asp:Image runat="server" alt="Customer Profile Picture" CssClass="ui-w-100 d-block m-auto rounded-circle mb-2" ID="CustomerPic" ImageUrl="~/assets/img/avatar.png" />
            <div class="media-body ml-4">
                <asp:Panel runat="server" ID="PanelFirstName" CssClass="font-weight-bold mb-0"></asp:Panel>
                <asp:Panel runat="server" ID="PanelCID" CssClass="text-muted mb-2 text-center"></asp:Panel>
                <asp:HyperLink runat="server" ID="HypCustomerProfile" class="btn btn-primary btn-sm">Complainant Profile</asp:HyperLink>&nbsp;
                <asp:HyperLink runat="server" ID="HypEmailIcon" class="btn btn-default btn-sm icon-btn"><i class="fas fa-envelope fa-2x"></i></asp:HyperLink>
            </div>
        </div>
        <div class="card mb-4">

            <div class="card-body">

                <h6 class="mt-3 mb-4">Customer Information</h6>
                <div class="row mb-2">
                    <div class="col-sm-2">
                        <label class="mb-0">Full Name</label>
                    </div>
                    <asp:Panel runat="server" ID="Panel1" Text="Shehryar" CssClass="col-sm-10 text-secondary">Shehryar</asp:Panel>
                </div>

                <div class="row mt-3 mb-2">
                    <div class="col-sm-2">
                        <label class="mb-0">Full Name</label>
                    </div>
                    <asp:Panel runat="server" ID="Panel2" Text="Shehryar" CssClass="col-sm-10 text-secondary">Shehryar</asp:Panel>
                </div>

                <div class="row mt-3 mb-2">
                    <div class="col-sm-2">
                        <label class="mb-0">Full Name</label>
                    </div>
                    <asp:Panel runat="server" ID="Panel6" Text="Shehryar" CssClass="col-sm-10 text-secondary">Shehryar</asp:Panel>
                </div>
            </div>
            <hr class="border-light m-0">
        </div>
        <div class="card mb-4">

            <div class="card-body">
                <h6 class="mt-3 mb-4">Complaint Information</h6>
                <div class="row mb-2">
                    <div class="col-sm-2">
                        <label class="mb-0">Complaint Title</label>
                    </div>
                    <asp:Panel runat="server" ID="PanelComplaintTitle" CssClass="col-sm-10 text-secondary"></asp:Panel>
                </div>

                <div class="row mt-3 mb-2">
                    <div class="col-sm-2">
                        <label class="mb-0">Full Name</label>
                    </div>
                    <asp:Panel runat="server" ID="Panel4" Text="Shehryar" CssClass="col-sm-10 text-secondary">Shehryar</asp:Panel>
                </div>

                <div class="row mt-3 mb-2">
                    <div class="col-sm-2">
                        <label class="mb-0">Uploaded Data</label>
                    </div>
                    <asp:HyperLink ID="HypDownloadUpload" runat="server" CssClass="col-sm-3 btn btn-outline-danger" Target="_blank">Show Attachment</asp:HyperLink>
                </div>
            </div>
            <hr class="border-light m-0">
        </div>
    </div>
</asp:Content>