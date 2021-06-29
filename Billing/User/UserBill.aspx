<%@ Page Title="" Language="C#" MasterPageFile="~/UserPanelMasterPage.Master" AutoEventWireup="true" CodeBehind="UserBill.aspx.cs" Inherits="PtclCustomerService.Billing.User.UserBill" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="../../Js/scripts.js"></script>
    <script src="../../Js/html2canvas.min.js"></script>
    <script src="../../Js/pdfmake.min.js"></script>

    <script src="jsfiles/html2canvas.min.js"></script>
    <script src="jsfiles/pdfmake.min.js"></script>
    <script type="text/javascript">
        function Export() {
            html2canvas(document.getElementById('target'), {
                onrendered: function (canvas) {
                    var data = canvas.toDataURL();
                    var docDefinition = {
                        content: [{
                            image: data,
                            width: 500
                        }]
                    };
                    pdfMake.createPdf(docDefinition).download("AdmitCard.pdf");
                    //alert("Admit Card Downloading Started");
                }
            });
        }
    </script>

    <script type="text/javascript">
        function printDiv(divName) {
            var pr = document.getElementById(divName).innerHTML;
            var printContents = "<body style='height: 100px !important;'>";
            printContents = printContents + pr;
            printContents = printContents + "</body>";

            var originalContents = document.body.innerHTML;

            document.body.innerHTML = printContents;

            window.print();

            document.body.innerHTML = originalContents;
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container-fluid px-5 " id="print">
        <h1 class="mx-4 text-center ">User Bill</h1>

        <div class="row">
            <div class="col-sm my-3">
                <asp:RequiredFieldValidator runat="server" ID="RFV0" ControlToValidate="ddMonthList" SetFocusOnError="true" Text="*" InitialValue="0" ForeColor="Red"></asp:RequiredFieldValidator>
                <asp:DropDownList ID="ddMonthList" runat="server" OnSelectedIndexChanged="listChange" AutoPostBack="true">
                    <asp:ListItem Value="0">Select</asp:ListItem>
                    <asp:ListItem Value="1">January</asp:ListItem>
                    <asp:ListItem Value="2">February</asp:ListItem>
                    <asp:ListItem Value="3">March</asp:ListItem>
                    <asp:ListItem Value="4">April</asp:ListItem>
                    <asp:ListItem Value="5">May</asp:ListItem>
                    <asp:ListItem Value="6">June</asp:ListItem>
                    <asp:ListItem Value="7">July</asp:ListItem>
                    <asp:ListItem Value="8">August</asp:ListItem>
                    <asp:ListItem Value="9">September</asp:ListItem>
                    <asp:ListItem Value="10">October</asp:ListItem>
                    <asp:ListItem Value="11">November</asp:ListItem>
                    <asp:ListItem Value="12">December</asp:ListItem>
                </asp:DropDownList>
            </div>
            <div class="col-sm">
                <div style="text-align: right">
                    <button onclick="printDiv('target')" class="btn btn-success"><i class="fa fa-print"></i>&nbsp;&nbsp;Print</button>
                    <input type="button" id="btnExport" value="Export as PDF" onclick="Export()" class="btn btn-success">
                </div>
            </div>
        </div>
        <hr>

        <asp:Panel runat="server" ID="panelBill" Visible="false">

            <section id="target">
                <div id="content">
                    <div class="container my-5 card">
                        <div class="d-flex justify-content-center row">
                            <div class="col-md-8">
                                <div class="p-3 bg-white rounded">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <h1 class="text-uppercase">PTCL Invoice</h1>
                                            <div class="billed">
                                                <span class="font-weight-bold text-uppercase">Customer Name: </span><span class="ml-1">
                                                    <asp:Label CssClass="ml-1" runat="server" ID="lblBillName"></asp:Label></span>
                                            </div>
                                            <div class="billed">
                                                <span class="font-weight-bold text-uppercase">
                                                    <asp:Label runat="server" CssClass="ml-1" ID="lblDueDate"></asp:Label></span>
                                            </div>
                                            <div class="billed">
                                                <span class="font-weight-bold text-uppercase">Consumer ID:</span><span class="ml-1">

                                                    <asp:Label runat="server" CssClass="ml-1" ID="lbluserID"></asp:Label>
                                                </span>
                                            </div>
                                            <div class="billed">
                                                <span class="font-weight-bold text-uppercase">LandLine Number:</span><span class="ml-1">

                                                    <asp:Label runat="server" ID="tblLandline"></asp:Label>
                                                </span>
                                            </div>
                                            <div class="billed">
                                                <span class="font-weight-bold text-uppercase">Location:</span><span class="ml-1">

                                                    <asp:Label runat="server" ID="lblLocation"></asp:Label>
                                                </span>
                                            </div>

                                            <div class="billed">
                                                <span class="font-weight-bold text-uppercase">Billing Month:</span><span class="ml-1">

                                                    <asp:Label runat="server" ID="lblMonth"></asp:Label>
                                                </span>
                                            </div>
                                        </div>
                                        <div class="col-md-6 text-right mt-3">
                                            <img src="../../assets/img/PCS_Logo.png" style="width: 200px" />
                                        </div>
                                    </div>
                                    <div class="mt-3">
                                        <div class="table-responsive">
                                            <table class="table">
                                                <thead>
                                                    <tr>
                                                        <th>Service</th>
                                                        <th>Type</th>
                                                        <th>Price</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <tr>
                                                        <td>Broadband Price </td>
                                                        <td>8MB</td>
                                                        <td>2080</td>
                                                    </tr>
                                                    <tr>
                                                        <td>Line Rate</td>
                                                        <td>2.5%</td>
                                                        <td>280</td>
                                                    </tr>
                                                    <tr>
                                                        <td>#</td>
                                                        <td>Total</td>
                                                        <td>2360</td>
                                                    </tr>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </section>
        </asp:Panel>
        <asp:Label runat="server" ID="lblNoBill" ForeColor="Red"></asp:Label>
        <asp:Label runat="server" ID="lblNoMonth" ForeColor="Red"></asp:Label>
    </div>
</asp:Content>