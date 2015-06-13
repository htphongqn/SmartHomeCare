<%@ Page Title="" Language="C#" MasterPageFile="~/siteadmin.master" AutoEventWireup="true" CodeFile="adminsynclogs.aspx.cs" Inherits="adminsynclogs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
<style type="text/css">
    .margin
    {
        margin:7px;
    }
</style>
    <script src="scripts/Print.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                   Sync Logs
                </div>
             </div>
            <div class="floatright">
                <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                <a id="userhelp" href="#"><img src="resources/images/h.png" /></a>
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
    <div id="print">
        <div class="border margin">
            Sync information
        </div>
    </div>
</asp:Content>

