<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="userhome.aspx.cs" Inherits="userhome" %>

<asp:Content ID="Content1" ContentPlaceHolderID="right1" Runat="Server">
    <div class="rightpaddingleft">
    <div>
        <p>
            Welcome to ...<br /><br />
            To review portions of your personal health record and manage your Homecare account, please use the
            menu on the left.</p>
    </div> 
    <table>
        <tr>
            <td><img class="msg_img" src="resources/images/mail_envelope.png" /></td>
            <td><%--<a href="useralarmmessages.aspx">  <asp:Label ID="lbitemsalarm" runat="server"></asp:Label>--%></a>
                <asp:HyperLink ID="lbalarm" runat="server" NavigateUrl="useralarmmessages.aspx"></asp:HyperLink>
                <asp:Label ID="lbnew_alarm" runat="server" Text=""></asp:Label>
            </td>
        </tr>
        <tr>
            <td><img class="msg_img" src="resources/images/mail_envelope.png" /></td>
            <td>
                <asp:HyperLink ID="lbMessage" runat="server" NavigateUrl="userinbox.aspx"></asp:HyperLink>
                <asp:Label ID="lbnew" runat="server" Text=""></asp:Label>
            </td>
        </tr>
    </table>
</div>
</asp:Content>

