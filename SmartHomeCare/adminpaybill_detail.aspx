<%@ Page Title="" Language="C#" MasterPageFile="~/siteadmin.master" AutoEventWireup="true" CodeFile="adminpaybill_detail.aspx.cs" Inherits="adminpaybill_detail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">

    <style type="text/css">
        .style3
        {
            height: 54px;
        }
        .style4
        {
            height: 30px;
        }
        .style5
        {
            height: 29px;
        }
        .style6
        {
            height: 32px;
        }
        .style7
        {
            height: 28px;
        }
        .style8
        {
            height: 27px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                   Detail
                </div>
             </div>
            <div class="floatright">
                
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
    <table style="width: 100%;">
        <tr>
            <td class="style4">
                User name</td>
            <td class="style4">
                &nbsp;
                <asp:TextBox ID="txtUserName" runat="server" Height="20px" Width="220px" 
                    Enabled="False"></asp:TextBox>
            </td>
            <td class="style4">
                &nbsp;
            </td>
            <td class="style4">
            </td>
        </tr>
        <tr>
            <td class="style4">
                First name</td>
            <td class="style4">
                &nbsp;
                <asp:TextBox ID="txtFirstName" runat="server" Height="20px" Width="220px" 
                    Enabled="False"></asp:TextBox>
            </td>
            <td class="style4">
                Last name
            </td>
            <td class="style4">
                <asp:TextBox ID="txtLastName" runat="server" Height="20px" Width="220px" 
                    Enabled="False" style="margin-bottom: 0px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style5">
                
                Account number</td>
            <td class="style5">
                &nbsp;
                <asp:TextBox ID="txtAccountNumber" runat="server" Height="20px" Width="220px" 
                    Enabled="False"></asp:TextBox>
            </td>
            <td class="style5">
                Account Type</td>
            <td class="style5">
                <asp:TextBox ID="txtAccountType" runat="server" Height="20px" Width="220px" 
                    Enabled="False"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style3" colspan="4">
            </td>
        </tr>
        <tr>
            <td class="style6">
                Active<asp:CheckBox ID="chkActive" runat="server" />
            </td>
            <td class="style6">
                PayBill
                <asp:CheckBox ID="chkPaybill" runat="server" 
                    oncheckedchanged="chkPaybill_CheckedChanged" />
            </td>
            <td class="style6">
                <asp:Label ID="Label1" runat="server" Text="Amount change" Width="100px"></asp:Label>
            </td>
            <td class="style6">
                <asp:TextBox ID="txtAmountChange" runat="server" Height="20px" Width="220px" 
                    style="margin-bottom: 0px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style7" colspan="2">
                First day apply to charge in monthly:
            </td>
            <td class="style7" colspan="2">
                <asp:TextBox ID="TextBox5" runat="server" Height="20px" Width="330px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style8" colspan="2">
                Note&nbsp;
                &nbsp;
            </td>
            <td class="style8" colspan="2">
                <asp:TextBox ID="txtNote" runat="server" Height="20px" Width="330px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <asp:Button ID="btnSave" runat="server" Text="Save" />
                <asp:Button ID="btnCancel" runat="server" CausesValidation="False" 
                    PostBackUrl="~/adminpaybill.aspx" Text="Cancel" />
            </td>
        </tr>
    </table>
    </asp:Content>

