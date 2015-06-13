<%@ Page Title="" Language="C#" MasterPageFile="~/siteadmin.master" AutoEventWireup="true" CodeFile="adminhelp.aspx.cs" Inherits="adminhelp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
 <div class="title_new">
            <div class="floatleft">
                <div class="td">Admin help</div>
             </div>
            <div class="floatright"> 
                <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
            </div>
            <div class="clear"></div>
</div><!-- border bottom -->
</asp:Content>

