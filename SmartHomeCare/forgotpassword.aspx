<%@ Page Title="" Language="C#" MasterPageFile="~/sitehome.master" AutoEventWireup="true" CodeFile="forgotpassword.aspx.cs" Inherits="forgotpassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="center1" Runat="Server">
<table cellpadding="0" cellspacing="0" align="center" class="tblright col4">
    <tr>
        <td class="titleforgot">
            <p>Recover your HomeCare password<br />
            Please verify your personal information</p> 
        </td>
    </tr>
    <tr>
        <td>Username</td>
    </tr>
    <tr>
        <td><asp:TextBox ID="txtusername" runat="server" Width="220px"></asp:TextBox></td>
    </tr>
     <tr>
        <td><asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                ErrorMessage="Please enter your username." ControlToValidate="txtusername" ForeColor="Red" 
                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></td>
    </tr>
    <tr>
        <td>Date of Birth</td>
    </tr>
    <tr>
        <td>
            <table width="265px" cellpadding="0" cellspacing="0">
                <tr>
                    <td><asp:TextBox ID="txtmm" runat="server" Width="40px" onkeypress="return ValidateKeypress(/\d/,event);"></asp:TextBox>/</td>
                    <td><asp:TextBox ID="txtdd" runat="server" Width="40px" onkeypress="return ValidateKeypress(/\d/,event);"></asp:TextBox>/</td>
                    <td valign="top"><asp:TextBox ID="txtyyyy" runat="server" Width="80px" onkeypress="return ValidateKeypress(/\d/,event);"></asp:TextBox></td>
                </tr>
                <tr class="silver">
                    <td>mm</td>
                    <td>dd</td>
                    <td>yyyy</td>
                </tr>
            </table>
        </td>
    </tr>   
    <tr>
        <td><asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                ErrorMessage="Please enter your month of birth." ControlToValidate="txtmm" ForeColor="Red" 
                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></td>
    </tr>
    <tr>
        <td><asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                ErrorMessage="Please enter your day of birth." ControlToValidate="txtdd" ForeColor="Red" 
                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></td>
    </tr>
    <tr>
        <td><asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                ErrorMessage="Please enter your year of birth." ControlToValidate="txtyyyy" ForeColor="Red" 
                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></td>
    </tr>
    <tr>
        <td>
            <asp:UpdatePanel runat="server" ID="updatepanelcaptcha">
                <ContentTemplate>
                    <asp:Image ID="captchaImage" runat="server" Height="35px" />
                    &nbsp;
                    <asp:ImageButton ID="imgreload" runat="server" ImageUrl="~/resources/images/captcha-reload.png" CausesValidation="False"
                        OnClick="imgreload_Click" />
                </ContentTemplate>
            </asp:UpdatePanel>
		    <strong>Enter the code shown above:</strong><br>
		    <asp:TextBox id="txtcaptcha" runat="server" Width="220px"></asp:TextBox><br>
		    <asp:Label id="lbmessagecaptcha" runat="server"></asp:Label>
        </td>
    </tr>
    <tr>
        <td align="center">
            <p>
            <asp:Button ID="btnsubmit" runat="server" Text="Submit" onclick="btnsubmit_Click" />
            </p>
        </td>
        
    </tr>
    <tr>
        <td><asp:Label ID="lbmessage" runat="server" ForeColor="Red" Font-Size="9pt"></asp:Label>  </td>
    </tr>
</table>
<div class="col8">
<br />

    If you have an e-mail address on file then a ternporary password will be sent to your e-mail account.
<br />
<br />
If you do not remember your HomeCare username, please click on<br />
<a href="forgotusername.aspx" class="forgot">Forgot Homecare username</a>.
</div>
</asp:Content>
<%--<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    
</asp:Content>--%>

