<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="UserComplaintDetails.aspx.cs" Inherits="PtclCustomerService.UserComplaintDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        body {
            color: #000;
            overflow-x: hidden;
            height: 100%;
            background-repeat: no-repeat;
            background-size: 100% 100%
        }

        .card {
            padding: 30px 40px;
            margin-top: 10px;
            margin-bottom: 60px;
            border: none !important;
            box-shadow: 0 6px 12px 0 rgba(0, 0, 0, 0.2)
        }

        .blue-text {
            color: #00BCD4
        }

        .form-control-label {
            margin-bottom: 0
        }

        input,
        textarea,
        button {
            padding: 8px 15px;
            border-radius: 5px !important;
            margin: 5px 0px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            font-size: 18px !important;
            font-weight: 300
        }

            input:focus,
            textarea:focus {
                -moz-box-shadow: none !important;
                -webkit-box-shadow: none !important;
                box-shadow: none !important;
                border: 1px solid #00BCD4;
                outline-width: 0;
                font-weight: 400
            }

        .btn-block {
            text-transform: uppercase;
            font-size: 15px !important;
            font-weight: 400;
            height: 43px;
            cursor: pointer
        }

            .btn-block:hover {
                color: #fff !important
            }

        button:focus {
            -moz-box-shadow: none !important;
            -webkit-box-shadow: none !important;
            box-shadow: none !important;
            outline-width: 0
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mx-auto my-0">
        <div class="row justify-content-center">
            <div class="col-xl-7 col-lg-8 col-md-9 col-11">
                <div class="card">
                    <h5 class="text-center mb-4">Complaint Details</h5>
                    <div class="form-card">
                        <div class="row justify-content-between text-left mb-2">
                            <div class="form-group col-sm-6 flex-column d-flex">
                                <label class="form-control-label px-3">ComplaintID</label>
                                <asp:TextBox  ReadOnly="true" runat="server" ID="txtComplaintID" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group col-sm-6 flex-column d-flex">
                                <label class="form-control-label px-3">Complaint Title</label>
                                <asp:TextBox  ReadOnly="true" runat="server" ID="txtComplaintTitle" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                       
                        <div class="row justify-content-between text-left mb-2">
                            <div class="form-group col-sm-6 flex-column d-flex">
                                <label class="form-control-label px-3">Complaint User ID</label>
                                <asp:TextBox  ReadOnly="true" runat="server" ID="txtComplaintUserID" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group col-sm-6 flex-column d-flex">
                                <label class="form-control-label px-3">Complaint Status</label>

                                <asp:DropDownList runat="server" ID="ddlComplaintStatus" CssClass="form-control"  ReadOnly="true">
                                    <asp:ListItem Text="True" Value="1" />
                                    <asp:ListItem Text="False" Value="0" />
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row justify-content-between text-left mb-2">
                            <div class="form-group col-12 flex-column d-flex">
                                <label class="form-control-label px-3">Complaint Regenerated</label>
                                <asp:TextBox runat="server" ID="txtComplaintRegenerated" CssClass="form-control"  ReadOnly="true"></asp:TextBox>
                                <asp:HyperLink ID="HypRegeneratedComplaint" runat="server" Text="" CssClass="nav-link"></asp:HyperLink>

                            </div>
                        </div>
                         <div class="row justify-content-between text-left">
                            <div class="form-group col-12 flex-column d-flex">
                                <label class="form-control-label px-3">Complaint Description</label>
                                <asp:TextBox  ReadOnly="true" runat="server" ID="txtComplaintDescription" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row justify-content-end text-center py-2">
                            <div class="form-group col-sm-6">
                                <button type="submit" class="btn-block btn-primary">Request a demo</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>