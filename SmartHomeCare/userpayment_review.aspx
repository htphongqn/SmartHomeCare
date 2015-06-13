<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="userpayment_review.aspx.cs" Inherits="userpaymentreview" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                   Pay Bill
                </div>
             </div>
            <div class="floatright">
                <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                <a id="userhelp" href="#"><img src="resources/images/h.png" /></a>
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
    <div id="print">
    <div class="borderbottom">
        <span class="bold">Payment review</span>
        <br /><br />
        <table class="marginleft">
            <tr>
                <td>Account number : </td>
                <td>
                    <asp:Label ID="lbAcountNumber" runat="server" Text="xxxxxx"></asp:Label></td>
            </tr>
            <tr>
                <td>Account type :</td>
                <td>
                    <asp:Label ID="lbAccountType" runat="server" Text="xxx"></asp:Label></td>
            </tr>
            <tr>
                <td>Amount due :</td>
                <td>
                    <asp:Label ID="lbAmountDue" runat="server" Text="10$"></asp:Label></td>
            </tr>
            <tr>
                <td colspan="2" height="20"></td>
            </tr>
            <tr>
                <td>Amount to pay</td>
                <td>: 
                    <asp:Label ID="lbAmountPay" runat="server" Text="10$"></asp:Label></td>
            </tr>
        </table>
        <br />
        <span class="bold">Billing address:</span>
        <table class="marginleft">
            <tr>
                <td>Name:</td>
                <td>
                    <asp:Label ID="lbName" runat="server" Text="xxxxxxxxxxxxx"></asp:Label></td>
            </tr>
             <tr>
                <td>Address:</td>
                <td>
                    <asp:Label ID="lbAddress" runat="server" Text="xxxxxxxxxxxxxxxxxx"></asp:Label></td>
            </tr>
            <tr>
                <td>Phone:</td>
                <td>
                    <asp:Label ID="lbPhone" runat="server" Text="xxxxxxxxxxx"></asp:Label></td>
            </tr>
            <tr>
                <td>Email address:</td>
                <td>
                    <asp:Label ID="lbEmail" runat="server" Text="xxxxxxxxxxx@mint-corp.com"></asp:Label></td>
            </tr>
            <tr>
                <td>Pay by credit card:</td>
                <td>
                    <asp:Label ID="lbPay" runat="server" Text="xxxxxxxxx123"></asp:Label></td>
            </tr>
        </table>
        <br />
    </div>
    </div>
    <div class="borderbottom">
        <asp:Button ID="btnsubmit" runat="server" Text="Submit" 
            onclick="btnsubmit_Click" />
            <input type="button" value="Back" onclick="goBack()">
    </div>
</asp:Content>

