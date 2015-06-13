<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackothers_globalsetting.aspx.cs" Inherits="usertrackothers_globalsetting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                   <a href="usertrackmyhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>  » Global settings
                </div>
             </div>
            <div class="floatright">
                <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                <a id="userhelp" href="#"><img src="resources/images/h.png" /></a>
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
    <div class="clear" style="margin-bottom:100px">
        This page display current global settings.<br /><br />
        Measurement system: <asp:RadioButton ID="rdmetric" runat="server" Text="Metric" GroupName="g" />
                            <asp:RadioButton ID="rdus" runat="server" Text="US" GroupName="g" Checked="True"/>
    </div>
   <div class="no-border">
        <table class="clear">
        <tr>
            <td><asp:Button ID="btnsave" runat="server" Text="Save" onclick="btnsave_Click" /></td>
            <td><asp:Button ID="btncancel" runat="server" Text="Cancel"  
                    PostBackUrl="~/usertrackothers.aspx" 
                    CausesValidation="False" /></td>
        </tr>
    </table>
    </div>

</asp:Content>

