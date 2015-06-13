<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="userbillingaccountsummar.aspx.cs" Inherits="userbillingaccountsummar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
<style type="text/css">
    .padding
    {
        padding:7px;
    }
</style>
    <script src="scripts/Print.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                   Billing Account Summary
                </div>
             </div>
            <div class="floatright">
                <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                <a id="userhelp" href="#"><img src="resources/images/h.png" /></a>
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
    <div class="borderbottom clear">
        Click Account Details or See More Payments to see more
        information about a particular account. If you have an outstanding balance on an account,
        click Pay Bill to pay online using a credit card.<br /><br />
    </div>
    <div id="print">
    <div class=" textright padding">
    <div class="gridview">
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" 
            EmptyDataText="empty data" Width="100%">
            <Columns>
                
                <asp:BoundField DataField="AccountNumber" HeaderText="Account"/>
                <asp:BoundField DataField="AccountType" HeaderText="Account Type" />
                <asp:BoundField DataField="LastPayment" HeaderText="Last Payment" />
                <asp:BoundField DataField="Balance"  HeaderText="Outstanding Balance" >
                <HeaderStyle Width="180px" />
                </asp:BoundField>
            </Columns>
        </asp:GridView>
        </div>
    </div>
     <div class="borderbottom textright">
        <asp:Button ID="btnaccountdetail" runat="server" Text="Account Details" 
             PostBackUrl="~/useraccountdetails.aspx" Width="220px" />
        <asp:Button ID="btnseemorepayments" runat="server" Text="See More Payments" 
             onclick="btnseemorepayments_Click" Width="185px"/>
        <asp:Button ID="btnpaybill" runat="server" Text="Pay Bill" 
             PostBackUrl="~/userpaybill.aspx" Width="180px" />
        <br /><br /><br />
    </div>
    </div>
    <div class="borderbottom textcenter">
    <br />
        <asp:Button ID="Button1" runat="server" Text="Back to Home" PostBackUrl="~/userhome.aspx" />
        <br /><br />
    </div>
</asp:Content>

