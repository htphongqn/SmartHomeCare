<%@ Page Title="" Language="C#" MasterPageFile="~/sitehome.master" AutoEventWireup="true" CodeFile="forgotusername.aspx.cs" Inherits="forgotusername" %>

<asp:Content ID="Content1" ContentPlaceHolderID="center1" Runat="Server">

<table cellpadding="0" cellspacing="0" class="tblright col4">
                    <tr>
                        <td class="titleforgot">
                            <p>Recover your HomeCare username</p> 
                        </td>
                    </tr>
                    <tr>
                        <td>First name</td>
                    </tr>
                    <tr>
                        <td><asp:TextBox ID="txtfirstname" runat="server" Width="267px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td><asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                ErrorMessage="Please enter your first name." ControlToValidate="txtfirstname" ForeColor="Red" 
                                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></td>
                    </tr>
                    <tr>
                        <td>Last name</td>
                    </tr>
                    <tr>
                        <td><asp:TextBox ID="txtlastname" runat="server" Width="267px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td><asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                ErrorMessage="Please enter your last name." ControlToValidate="txtlastname" ForeColor="Red" 
                                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></td>
                    </tr>
                    <tr>
                        <td>Date of Birth</td>
                    </tr>
                    <tr>
                        <td>
                            <table width="265px" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td><asp:TextBox ID="txtmm" runat="server" Width="50px" onkeypress="return ValidateKeypress(/\d/,event);"></asp:TextBox>/</td>
                                    <td><asp:TextBox ID="txtdd" runat="server" Width="50px" onkeypress="return ValidateKeypress(/\d/,event);"></asp:TextBox>/</td>
                                    <td valign="top"><asp:TextBox ID="txtyyyy" runat="server" Width="100px" onkeypress="return ValidateKeypress(/\d/,event);"></asp:TextBox></td>
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
                        <td>Zip Code</td>
                    </tr>
                    <tr>
                        <td><asp:TextBox ID="txtzipcode" runat="server" Width="267px" onkeypress="return ValidateKeypress(/\d/,event);"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td><asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                                ErrorMessage="Please enter your zipcode." ControlToValidate="txtzipcode" ForeColor="Red" 
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
				            <asp:TextBox id="txtcaptcha" runat="server" Width="267px"></asp:TextBox><br>
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
    If you have an e-mail address on file then your HomeCare ID will be sent to your e-mail account.
<br />
If you do not remember any of this information or you do not have a valid e-mail address on file, you will 
have to contact the HomeCare Help Line at xxx-xxx-xxx, Monday through Friday, x am to xpm.
<br />
</div>
</asp:Content>
<%--<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">

</asp:Content>--%>
