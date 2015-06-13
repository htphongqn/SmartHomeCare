<%@ Page Title="" Language="C#" MasterPageFile="~/siteadmin.master" AutoEventWireup="true" CodeFile="adminmyaccount.aspx.cs" Inherits="adminmyaccount" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <style type="text/css">
    .marginleft
    {
        margin-left:10px;
    }
    .style1
    {
        width: 227px;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                   My Account
                </div>
             </div>
            <div class="floatright">
                <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                <a id="adminhelp" href="#"><img src="resources/images/h.png" /></a>
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
    <div id="print">
    <div class="borderbottom">
        <table class="marginleft">
            <tr>
                <td>Password</td>
                <td class="style1">
                    <asp:Label ID="lbPassword" runat="server" Text="Label"></asp:Label>
                    <asp:TextBox ID="txtPassword" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Real name</td>
                <td class="style1">
                     <asp:Label ID="lbName" runat="server" Text="Label"></asp:Label>
                    <asp:TextBox ID="txtName" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Email</td>
                <td class="style1">
                    <asp:Label ID="lbEmail" runat="server" Text="Label"></asp:Label>
                    <asp:TextBox ID="txtEmail" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Language</td>
                <td class="style1">
                    <asp:Label ID="lbLanguage" runat="server" Text="Label"></asp:Label>
                    <asp:TextBox ID="txtLanguage" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Privileges</td>
                <td class="style1">
                    <asp:Label ID="lbPrivileges" runat="server" Text="Label"></asp:Label>
                    <asp:TextBox ID="txtPrivileges" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Last login</td>
                <td class="style1">
                    <asp:Label ID="lbLastLogin" runat="server" Text="Label"></asp:Label>
                    <asp:TextBox ID="txtLastLogin" runat="server"></asp:TextBox>
                </td>
            </tr>
        </table>  
        <br />
        <br />
    </div>
    </div>
    <div class="textcenter">
    <br />
        <asp:Button ID="btnedit" runat ="server" Text="Edit" onclick="btnedit_Click" />
        <asp:Button ID="btncancel" runat ="server" Text="Cancel" 
            onclick="btncancel_Click" />
        <asp:Button ID="btnsave" runat ="server" Text="Save" onclick="btnsave_Click" />
        <asp:Button ID="btnback" runat ="server" Text="Back" />
    </div>
</asp:Content>

