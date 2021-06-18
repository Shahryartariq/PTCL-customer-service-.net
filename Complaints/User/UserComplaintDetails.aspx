<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="UserComplaintDetails.aspx.cs" Inherits="PtclCustomerService.UserComplaintDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Js/scripts.js"></script>

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
                                <label class="form-control-label ">ComplaintID</label>
                                <asp:TextBox ReadOnly="true" runat="server" ID="txtComplaintID" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group col-sm-6 flex-column d-flex">
                                <label class="form-control-label ">Complaint Title</label>
                                <asp:TextBox ReadOnly="true" runat="server" ID="txtComplaintTitle" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>

                        <div class="row justify-content-between text-left">
                            <div class="form-group col-sm-6 flex-column d-flex">
                                <label class="form-control-label">Complainant ID</label>
                                <asp:TextBox ReadOnly="true" runat="server" ID="txtComplaintUserID" CssClass="form-control"></asp:TextBox>
                            </div>
                            <div class="form-group col-sm-6 flex-column d-flex " style="margin-top: 2px">

                                <label class="form-control-label mb-1">Complaint Status</label>

                                <asp:DropDownList runat="server" ID="ddlComplaintStatus" CssClass="form-control" Enabled="False">
                                    <asp:ListItem Text="True" Value="1" />
                                    <asp:ListItem Text="False" Value="0" />
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row justify-content-between text-left mb-2">
                            <div class="form-group col-sm-6 flex-column d-flex mt-1">
                                <label class="form-control-label">Complaint Regenerated</label>
                                <asp:TextBox runat="server" ID="txtComplaintRegenerated" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                                <asp:HyperLink ID="HypRegeneratedComplaint" Target="_blank" runat="server" Text="" CssClass="badge bg-danger p-2"></asp:HyperLink>
                            </div>
                            <div class="form-group col-sm-6 flex-column d-flex mt-1">
                                <label class="form-control-label">Creation Date</label>
                                <asp:TextBox runat="server" ID="txtDateTime" CssClass="form-control" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row justify-content-between text-left">
                            <div class="form-group col-12 flex-column d-flex">
                                <label class="form-control-label">Complaint Description</label>
                                <asp:TextBox ReadOnly="true" runat="server" ID="txtComplaintDescription" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                            </div>
                        </div>
                        <asp:HyperLink ID="HypDownloadUpload" runat="server" CssClass="mt-2 btn btn-outline-danger" Target="_blank">Download Attachment</asp:HyperLink>

                        <div class="row justify-content-end text-center pb-3 p">
                            <div class="form-group col-sm-6">

                                <asp:HyperLink ID="HypCancel" runat="server" CssClass="mt-1 p-2 btn btn-primary float-end" NavigateUrl="~/Complaints/User/UserComplaint.aspx?active=1">Cancel</asp:HyperLink>
                                <asp:Panel runat="server" ID="PanelRegenerate">
                                    <!-- Button trigger modal -->
                                    <button class="mx-3 btn btn-primary float-end " type="button" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                                        Regenerate
                                    </button>

                                    <!-- Modal -->
                                    <div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
                                        <div class="modal-dialog">
                                            <div class="modal-content">
                                                <div class="modal-header">
                                                    <h5 class="modal-title" id="staticBackdropLabel">Regenerate Complaint</h5>
                                                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                                                </div>
                                                <div class="modal-body">
                                                    Are You sure you want to Regenerate this complaint?
                                                </div>
                                                <div class="modal-footer">
                                                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">No</button>
                                                    <asp:Button ID="btnRegenerate" runat="server" Text="Yes" CssClass="btn btn-primary" OnClick="btnRegenerate_Click" />
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>