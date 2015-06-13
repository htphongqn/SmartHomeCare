<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="userchangepassword.aspx.cs" Inherits="userchangepassword" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
<div class="title_new">
            <div class="floatleft">
                <div class="td">
                   Change password
                </div>
             </div>
           
            <div class="clear"></div>
     </div><!-- border bottom -->
<table width="100%" align="left" cellspacing="10">
    <tr>
        <td colspan="2"><asp:Label ID="lbmessage" runat="server" ForeColor="Red"></asp:Label></td>
    </tr>
    <tr>
        <td width="220">Current password</td>
        <td><asp:TextBox ID="txtcurrentpassword" runat="server" Width="220px" 
                TextMode="Password" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" 
                ErrorMessage="*" ControlToValidate="txtcurrentpassword" ForeColor="Red" 
                SetFocusOnError="True"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td>New password</td>
        <td><asp:TextBox ID="txtnewpassword" runat="server" Width="220px" 
                TextMode="Password" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" Display="Dynamic"
                ErrorMessage="*" ControlToValidate="txtnewpassword" ForeColor="Red" 
                SetFocusOnError="True"></asp:RequiredFieldValidator>
                
                <asp:Image ID="Image1" runat="server" 
                ImageUrl="~/resources/images/help.png" ImageAlign="Bottom" Height="15px" 
                Width="15px" /> 
            <asp:BalloonPopupExtender ID="txtpassword_BalloonPopupExtender" runat="server" 
                TargetControlID="Image1" BalloonPopupControlID="pnpasswordrule" 
                BalloonSize="Medium" >
            </asp:BalloonPopupExtender>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
			    ErrorMessage="<br/>Password not meet requirement" ControlToValidate="txtnewpassword" ForeColor="Red"
			    ValidationExpression=".{4,14}" Display="Dynamic"></asp:RegularExpressionValidator>
            <asp:Panel ID="pnpasswordrule" runat="server" CssClass="passrule">
                <p>
                    Password must be 4 to 14 characters.
                    Not content username, first name, last name and date of birth.
                </p>
            </asp:Panel>
        </td>
    </tr>
    <tr>
        <td>Confirm new password</td>
        <td><asp:TextBox ID="txtconfirmnewpassword" runat="server" Width="220px" 
                TextMode="Password" ></asp:TextBox>
            
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ErrorMessage="*" ControlToValidate="txtconfirmnewpassword" ForeColor="Red" 
                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:CompareValidator ID="CompareValidator2" runat="server" Display="Dynamic"
                ControlToCompare="txtnewpassword" ControlToValidate="txtconfirmnewpassword" 
                ErrorMessage="<br/>Password mismatched" ForeColor="Red"></asp:CompareValidator>
                
        </td>
    </tr>
    <tr>
        <td>Password hint</td>
        <td><asp:TextBox ID="txtpasswordhit" runat="server" Width="220px" ></asp:TextBox>
            
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                ErrorMessage="*" ControlToValidate="txtconfirmnewpassword" ForeColor="Red" 
                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:BalloonPopupExtender ID="txtpasswordhit_BalloonPopupExtender" 
                runat="server" CustomCssUrl="" DynamicServicePath="" Enabled="True" 
              TargetControlID="Image3" BalloonPopupControlID="pnpasswordrule" 
                BalloonSize="Medium" >
            </asp:BalloonPopupExtender>
             <asp:Image ID="Image3" runat="server" 
                ImageUrl="~/resources/images/help.png" ImageAlign="Bottom" Height="15px"
                Width="15px" />
                <asp:CompareValidator ID="CompareValidator3" runat="server" 
                    ControlToCompare="txtnewpassword" ControlToValidate="txtpasswordhit" 
                    ErrorMessage="<br />Password hint must be different from password" ForeColor="Red" 
                    Operator="NotEqual" Display="Dynamic">
                </asp:CompareValidator>
                <asp:Panel ID="panepasshind" runat="server" CssClass="passrule">
                    <p>
                        Use a password hint to remind your password.
                        Password hint should not content your password, username, first name, last name, date of birth. 
                    </p>
                </asp:Panel>
        </td>
    </tr>
    <tr>
        <td align="right"><asp:Button ID="btnsave" runat="server" Text="Save" 
                onclick="btnsave_Click" /></td>
        <td><asp:Button ID="btncancel" runat="server" Text="Cancel" 
                CausesValidation="False" PostBackUrl="~/userhome.aspx" /></td>
    </tr>
</table>
</asp:Content>

