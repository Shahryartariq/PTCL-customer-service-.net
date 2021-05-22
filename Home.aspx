<%@ Page Title="" Language="C#" MasterPageFile="~/MainMaster.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="PtclCustomerService.Home" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Page level ki Java/cs -->
    <link href="Css/Home.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <main>
        <section id="HomeCover">
            <h1>Say Hello to the Future</h1>
        </section>

        <!-- Packages Start -->
        <section id="ourPlans" class="container">
            <h1 class="sectionHeader">Select Your Desired Package</h1>
            <div class="ourPlanList">
                <article class="ourPlan">
                    <h3 class="ourPlanTitle">BASIC</h3>
                    <h3 class="ourPlanPrice">1200 Rs</h3>
                    <h4>For Personal Use</h4>
                    <ul class="ourPlanfeatures">
                        <li class="ourPlanfeature">2 MB</li>
                        <li class="ourPlanfeature">40 GB Data Limit</li>
                        <li class="ourPlanfeature">200 Free Mints</li>
                        <li class="ourPlanfeature">Basic Support</li>
                    </ul>
                    <div>
                        <button class="btn btn-success">CHOOSE PLAN</button>
                    </div>
                </article>
                <article class="ourPlan ourPlanRecommended">
                    <h3 class="ourPlanHighlighted">RECOMMENDED</h3>
                    <h3 class="ourPlanTitle">STANDARD</h3>
                    <h3 class="ourPlanPrice">2500 Rs</h3>
                    <h4>For Small Business</h4>
                    <ul class="ourPlanfeatures">
                        <li class="ourPlanfeature">8 MB</li>
                        <li class="ourPlanfeature">Unlimited Data Limit</li>
                        <li class="ourPlanfeature">1000 Free Mints</li>
                        <li class="ourPlanfeature">Advance Support</li>
                    </ul>
                    <div>
                        <button class="btn btn-success btn-lg text-dark">CHOOSE PLAN</button>
                    </div>
                </article>
                <article class="ourPlan">
                    <h3 class="ourPlanTitle">PREMIUM</h3>
                    <h3 class="ourPlanPrice">4000 Rs</h3>
                    <h4>Large Business & Enterprise</h4>
                    <ul class="ourPlanfeatures">
                        <li class="ourPlanfeature">20 MB</li>
                        <li class="ourPlanfeature">Unlimited Data Limit</li>
                        <li class="ourPlanfeature">Unlimited Free Mints</li>
                        <li class="ourPlanfeature">Premium Support</li>
                    </ul>
                    <div>
                        <button class="btn btn-success">CHOOSE PLAN</button>
                    </div>
                </article>
            </div>
        </section>
        <!-- Packages End -->
    </main>
</asp:Content>