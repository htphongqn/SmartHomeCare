<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackmyhealth_globalsetting.aspx.cs" Inherits="usertrackmyhealth_globalsetting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 59px;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#userhelp').click(function (e) {
                window.open('userhelp.aspx', 'User Help', 500, 500);
            });
        });
    </script>
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
        <table class="">
            <tr>
                <td class="style1"><asp:Button ID="btnsave" runat="server" Text="Save" onclick="btnsave_Click" /></td>
                <td><asp:Button ID="btncancel" runat="server" Text="Cancel" 
                        onclick="btncancel_Click" CausesValidation="False" 
                        PostBackUrl="~/usertrackmyhealth.aspx" /></td>
            </tr>
        </table>
    </div>

</asp:Content>

