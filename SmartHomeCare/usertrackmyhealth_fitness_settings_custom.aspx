<%@ Page Title="fitness monitoring - custom" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackmyhealth_fitness_settings_custom.aspx.cs" Inherits="usertrackmyhealth_fitness_settings_custom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
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
                   <a href="usertrackmyhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>  »<asp:LinkButton ID="lnlinks" runat="server" onclick="lnlinks_Click">Fitness monitoring</asp:LinkButton> » <a href="usertrackmyhealth_fitness_settings.aspx"> Settings</a> » Custom
                </div>
             </div>
            <div class="floatright">
                <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                <a id="userhelp" href="#"><img src="resources/images/h.png" /></a>
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
    <div id="print">
     <div class="clear borderbottom" style="margin-bottom:20px">
        <table>
            <tr>
                <td colspan="2">
                     This page display current settings of this feature.
                </td>
            </tr>
            <tr style="height:10px">
                <td colspan="2">
                     
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <table width="100%">
                        <tr>
                            <td>Number of stages: <asp:TextBox ID="txtnumberofstages" runat="server" Width="60" 
                                    AutoPostBack="True" onkeypress="return ValidateKeypress(/\d/,event);" 
                                    ontextchanged="txtnumberofstages_TextChanged"></asp:TextBox></td>
                            <td align="right">
                                <asp:Button ID="btnSave" runat="server" Text="Save" onclick="btnSave_Click" />
                                <asp:Button ID="btnback" runat="server" CausesValidation="false" PostBackUrl="usertrackmyhealth_fitness_settings.aspx" Text="Cancel"/>
                            </td>
                        </tr>
                    </table>
                </td>                
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Table ID="tblfitnessprogram" runat="server" Width="100%" 
                        ViewStateMode="Enabled">
                    </asp:Table>
                </td>
            </tr>            
            <tr>
                <td>Transition Audio:</td>
                <td><asp:TextBox ID="txttransitionaudio" runat="server" Width="200"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Program name:</td>
                <td><asp:TextBox ID="txtprogramname" runat="server" Width="200"></asp:TextBox></td>
            </tr>
        </table>
    </div>
    </div>

</asp:Content>

