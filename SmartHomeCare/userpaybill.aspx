<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="userpaybill.aspx.cs" Inherits="userpaybill" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
<style type="text/css">
    .marginleft
    {
        margin-left:30px;
    }
</style>
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
        <span class="bold">Pay bill by credit card</span>
        <br /><br />
        <table class="marginleft">
            <tr>
                <td>Account number</td>
                <td>: <asp:Label ID="lbAccountNumber" runat="server" Text="0"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Account type</td>
                <td>: <asp:Label ID="lbAccountType" runat="server" Text="0"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Amount due</td>
                <td>: $<asp:Label ID="lbAmountDue" runat="server" Text="10$"></asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="2" height="20"></td>
            </tr>
            <tr>
                <td>Amount to pay</td>
                <td>: 
                    <asp:TextBox ID="txtAmountPay" runat="server" onkeypress="return ValidateKeypress(/\d/,event);"></asp:TextBox>

                </td>
            </tr>
        </table>
        <br />
        <span class="bold">Billing information</span>
        <table class="marginleft">
            <tr>
                <td>*is Required</td>
            </tr>
            <tr>
                <td colspan="2" height="20"></td>
            </tr>
            <tr>
                <td>*Name on card</td>
                <td><asp:TextBox ID="txtnameoncard" runat="server" Width="220"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="txtnameoncard" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
             <tr>
                <td>*Address</td>
                <td><asp:TextBox ID="txtaddress" runat="server" Width="220"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                        ControlToValidate="txtaddress" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>Address line 2</td>
                <td><asp:TextBox ID="txtaddressline" runat="server" Width="220"></asp:TextBox>                
                </td>
            </tr>
            <tr>
                <td>*City</td>
                <td><asp:TextBox ID="txtciy" runat="server" Width="220"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                        ControlToValidate="txtciy" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>*Country</td>
                <td><asp:DropDownList ID="ddlcountry" runat="server" Width="150px" 
                        AutoPostBack="True" DataTextField="Name" DataValueField="Code" 
                        onselectedindexchanged="ddlcountry_SelectedIndexChanged"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>*State</td>
                <td><asp:DropDownList ID="ddlstate" runat="server" Width="150px" DataTextField="Name" 
                        DataValueField="Code"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>*Zipcode</td>
                <td><asp:TextBox ID="txtzipcode" runat="server" Width="140px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                        ControlToValidate="txtzipcode" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>*Phone</td>
                <td><asp:TextBox ID="txtphone" runat="server" Width="140px" onkeypress="return ValidateKeypress(/\d/,event);"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                        ControlToValidate="txtphone" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>Email address</td>
                <td><asp:TextBox ID="txtemailaddress" runat="server" Width="220"></asp:TextBox>
               
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                        ControlToValidate="txtemailaddress" ErrorMessage="*" ForeColor="#CC0000" 
                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
               
                </td>
            </tr>
            <tr>
                <td>*Card type</td>
                <td><asp:DropDownList ID="ddlcardtype" runat="server" Width="150px" 
                        DataTextField="Name" DataValueField="AutoId"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>*Card number</td>
                <td><asp:TextBox ID="txtcardnumber" runat="server" Width="220"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                        ControlToValidate="txtcardnumber" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>*Expiration date</td>
                <td><asp:DropDownList ID="ddlmmexpirationdate" runat="server" Width="60"></asp:DropDownList>
                    /<asp:DropDownList ID="ddlyyexpirationdate" runat="server" Width="80"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>*Security code</td>
                <td><asp:TextBox ID="txtsecuritycode" runat="server" Width="140px"></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" 
                        ControlToValidate="txtsecuritycode" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
        <br />
    </div>
    </div>
    <div>
        <asp:Button ID="btncontinue" runat="server" Text="Continue" 
            onclick="btncontinue_Click" />
        <asp:Button ID="Button1" runat="server" Text="Cancel" 
            PostBackUrl="~/userbillingaccountsummar.aspx" CausesValidation="False" />
            <br /><br />
    </div>

</asp:Content>

