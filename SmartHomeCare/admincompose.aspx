<%@ Page Title="" Language="C#" MasterPageFile="~/siteadmin.master" AutoEventWireup="true" CodeFile="admincompose.aspx.cs" Inherits="admincompose" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
  <style type="text/css">
        .style1
        {
            width: 100%;
        }
        
        .txtMaxWidth
        {
            max-width:690px;
        }
    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="title_new">
            <div class="floatleft">
                <div class="td">Compose message</div>
             </div>
            <div class="floatright"> <a id="adminhelp" href="#"><img src="resources/images/h.png" /></a></div>
            <div class="clear"></div>
     </div><!-- border bottom -->
    <br />
    <div class="clear">
        <table class="style1">
            <tr>
                <td style="width:100px;">
                    From:</td>
                <td>
                    <asp:TextBox ID="txtMailFrom" runat="server" BorderStyle="Solid" 
                        BorderWidth="1px" Width="300px" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td style="width:100px;">
                    To:</td>
                <td>
                    <asp:TextBox ID="txtMailTo" runat="server" BorderStyle="Solid" 
                        BorderWidth="1px" Width="300px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="txtMailTo" ErrorMessage=" (*)" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    Subject:</td>
                <td>
                    <asp:TextBox ID="txtSubject" runat="server" BorderStyle="Solid" 
                        BorderWidth="1px" Width="300px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <fieldset style="margin:0 auto;">
                        <legend>Message:</legend>
                        <asp:TextBox ID="txtMessage" CssClass="txtMaxWidth" runat="server" Width="690px" 
                            TextMode="MultiLine" Height="150px"></asp:TextBox>
                    </fieldset>
                </td>
            </tr>
        </table>
        <br />
    </div>
    <div>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Visible="False"></asp:Label>
    </div>
    <div class="clear borderbottom">
    </div>
    <br />
     <div class="clear">
         <asp:Button ID="btnSend" runat="server" onclick="btnSend_Click" Text="Send" />
         <asp:Button ID="btndelete0" runat="server" Text="Cancel" 
             PostBackUrl="~/userhome.aspx" CausesValidation="False" />
    </div>
</asp:Content>

