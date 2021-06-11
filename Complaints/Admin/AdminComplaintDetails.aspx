<%@ Page Title="" Language="C#" MasterPageFile="~/AdminPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="AdminComplaintDetails.aspx.cs" Inherits="PtclCustomerService.AdminComplaintDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Complaint ID: <asp:Label ID="lblComplaintID" runat="server" Text="Label1" ></asp:Label>-->
    <div class="row">
        <div class="container border " style="background-color: #f8f8f8;">
            <div class="row">
                <div id="product1" class="col-sm-2 col-xs-4 col-md-4 order-md-1 item-photo">
                    <img class="img-fluid" style="max-width: 100%;" src="https://media.primus.eu/detail/7330033905977_SS17_a_trailbottle_10l_tritan_black_primus_22.jpg" alt="" />
                </div>
                <div class="col-sm-10 col-md-8 order-md-2 col-xs-8 " style="border: 0px solid gray;">
                    <h3 class="mb-3">King Timer</h3>
                    <h5 class="mb-3" style="color: #337ab7;">5% WDG</h5>
                    <h6 class="title-price mb-3"><small>CROP: </small>All</h6>
                    <h3 class="mb-3" style="margin-top: 0px;"><small>DOSE/ACRE: </small>as per attached Label</h3>
                    <p style="white-space: pre-line;">Active Ingredient: Emamectin Benzoate 50 gm/kg(5%w/w) Other Ingredients......To make 100% Chemical Composition On 100% Basis</p>
                    <h6 class="title-price mb-3"><small>DISEASE/PEST: </small>N/A</h6>
                    <a href="images/labels/KingTimer-01.jpg" target="_blank">
                        <h6 class="btn btn-primery" style="background-color: #079aee !important; color: #fff;">LABEL DOWNLOAD</h6>
                    </a>
                    <br />
                    <br />
                    <a href="#top">Back to Top</a>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <h2>End row</h2>
    </div>
</asp:Content>