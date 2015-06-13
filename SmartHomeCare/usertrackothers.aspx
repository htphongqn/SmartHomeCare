<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackothers.aspx.cs" Inherits="usertrackothers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <link href="styles/control.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="borderbottom">
        <div class="floatleft title">Track others</div>
        <div class="floatright"><a href="userhelp.aspx">Help</a></div>
        <div class="clear"></div>
    </div>
    <br />
    <div class="clear">
        Select other user you want to view/track.<br /><br />
    </div>
    <div class="clear borderbottom">
        <asp:ListBox ID="lstTracOther" runat="server" Width="249px" 
            ondblclick="lstTracOther_DoubleClick()" Rows="8" CssClass="listbox" >           
        </asp:ListBox>
    </div>
    
     <div class="clear"  style="margin-bottom:50px;margin-top:30px">
        <asp:Label ID="lbMaessages" runat="server" Text="Please select other user" ForeColor="Red" Visible="false"></asp:Label><br />
        <asp:Button ID="btnglobalsettings" runat="server" Text="Select" 
             onclick="btnglobalsettings_dbick" />
        <asp:Button ID="Button1" runat="server" Text="Back to Home" 
             PostBackUrl="~/userhome.aspx" CausesValidation="False" />
    </div>
</asp:Content>

