<%@     Page Title="" Language="C#" MasterPageFile="~/sitehome.master" AutoEventWireup="true" CodeFile="home.aspx.cs" Inherits="home" %>

<asp:Content ID="Content3" ContentPlaceHolderID="head1" Runat="Server">
    <style type="text/css">

    </style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="center1" Runat="Server">
        <asp:Label ID="lbcontent" runat="server"></asp:Label>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <table cellpadding="0" cellspacing="0" align="center" class="tblright">
    <tr>
        <td>Username</td>
    </tr>
    <tr>
        <td><asp:TextBox ID="txtusername" runat="server" Width="220px" TabIndex="1"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ErrorMessage="Please enter a username." ControlToValidate="txtusername" ForeColor="Red" 
                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></td>
    </tr>
    <tr>
        <td align="right"><a href="forgotusername.aspx" class="forgot">Forgot username?</a></td>
    </tr>
    <tr>
        <td>Password</td>
    </tr>
    <tr>
        <td><asp:TextBox ID="txtpassword" runat="server" Width="220px" TextMode="Password" 
                TabIndex="2"></asp:TextBox></td>
    </tr>
    <tr>
        <td>            
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ErrorMessage="Please enter a password." ControlToValidate="txtpassword" ForeColor="Red" 
                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td align="right"><a href="forgotpassword.aspx" class="forgot">Forgot password?</a></td>
    </tr>
    <tr>
        <td height="5px"></td>
    </tr>
    <tr>
        <td align="center">
            <asp:Button ID="btnsignin" runat="server" Text="Sign in" 
                onclick="btnsignin_Click" Width="80px" TabIndex="3" /></td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lbmessage" runat="server" ForeColor="Red" Font-Size="9pt"></asp:Label></td>
    </tr>
    <tr>
        <td height="10"></td>
    </tr>
    <tr>
        <td style="border-bottom:2px solid #d4d4d4;border-top:1px solid #d4d4d4">
            <table width="100%">
                <tr>
                    <td class="silver">New User?</td>
                    <td align="right"><asp:LinkButton ID="lnkregister" runat="server" Text="Register" 
                            CausesValidation="False" onclick="lnkregister_Click"></asp:LinkButton> </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td style="height: 20px"></td>
    </tr>
    <tr>
        <td class="silver">Learn more...</td>
    </tr>
    <tr>
        <td align="right"><%--<a href="fqas.aspx">FQAs</a>--%>
            <asp:LinkButton ID="lnkfqas" runat="server" Text="FAQs" 
                            CausesValidation="False" onclick="lnkfqas_Click"></asp:LinkButton>
        </td>
    </tr>
    <tr>
        <td align="right"><%--<a href="privacypolicy.aspx">Privacy Policy</a>--%>
            <asp:LinkButton ID="lnkprivacypolicy" runat="server" Text="Privacy Policy" 
                            CausesValidation="False" onclick="lnkprivacypolicy_Click"></asp:LinkButton>
        </td>
    </tr>
    <tr>
        <td align="right"><%--<a href="termsandconditions.aspx">Terms and Conditions</a>--%>
            <asp:LinkButton ID="lnktermsandconditions" runat="server" Text="Terms and Conditions" 
                            CausesValidation="False" onclick="lnktermsandconditions_Click"></asp:LinkButton>
        </td>
    </tr>
</table>
</asp:Content>

