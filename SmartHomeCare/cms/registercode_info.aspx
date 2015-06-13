<%@ Page Title="" Language="C#" MasterPageFile="~/cms/sitecms.master" AutoEventWireup="true" CodeFile="registercode_info.aspx.cs" Inherits="cms_registercode_info" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <style type="text/css">
        .style1
        {
        }
        .style2
        {
        }
        .style3
        {
            width: 156px;
        }
        .style4
        {
            width: 156px;
            height: 24px;
        }
        .style5
        {
            height: 24px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">

    <table style="width:100%;">
        <tr>
            <td class="style2" colspan="2">
                <h1 class="title"><asp:Label ID="Label1" runat="server" Text="Activison"></asp:Label></h1>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style3">
                Registion Code</td>
            <td>
                <asp:TextBox ID="txtRegisterCode" runat="server"></asp:TextBox>
            </td>
            <td>
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style1">
                &nbsp;</td>
            <td class="style1">
                <asp:CheckBox ID="chkIsActive" runat="server" Text="Is Active" />
            </td>
            <td class="style1">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style4">
                </td>
            <td class="style5">
                <asp:Button ID="btnsave" runat="server" Text="Save" onclick="btnsave_Click" />
                <asp:Button ID="btncancel" runat="server" Text="Cancel" 
                    PostBackUrl="~/cms/register_code.aspx" />
            </td>
            <td class="style5">
                </td>
        </tr>
    </table>

</asp:Content>

