<%@ Page Title="" Language="C#" MasterPageFile="~/cms/sitelogin.master" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="Admin_login" %>


<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="cc1" %>


<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
<div class="table_login">
    <table >
            <tr>
                <td colspan="2" class="textcenter">
                    <h1>LOG IN</h1>
                </td>
            </tr>
            <tr>
                <td class="style2" style="width: 128px; height: 30px;" >
                   <asp:Label ID="Label1" runat="server" Text="Username : "></asp:Label> 
                </td>
                <td style="height: 30px; width: 215px">
                    <asp:TextBox ID="txtUserName" runat="server" CssClass="TextBox"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="txtUserName" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            
            </tr>
            <tr>
                <td class="style2" style="width: 128px">
                    <asp:Label ID="lbU" runat="server" Text="Password : "></asp:Label> 
                </td>
                <td style="width: 215px">
                    <asp:TextBox ID="txtPassWord" runat="server" CssClass="TextBox" 
                        TextMode="Password"></asp:TextBox>
                </td>
            
            </tr>
            <tr>
                <td class="style2" style="width: 128px">
                    &nbsp;</td>
                <td style="width: 215px">
                    <asp:Label ID="lbMessages" runat="server" Font-Bold="True" Font-Size="Smaller" 
                        ForeColor="Red" Text="Username or password incorrect" Visible="False"></asp:Label>
                </td>
            
            </tr>
            <tr>
                <td colspan="2" class="textright">
                    <asp:Button ID="btnLogin" runat="server" Text ="Log In" 
                         onclick="btnLogin_Click"/>
                </td>
            </tr>
        </table>

</div>
<br />
<br />
<div class="clear"></div>
</asp:Content>

