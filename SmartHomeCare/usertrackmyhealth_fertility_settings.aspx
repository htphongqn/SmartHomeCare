<%@ Page Title="fertility monitoring - settings" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackmyhealth_fertility_settings.aspx.cs" Inherits="usertrackmyhealth_fertility_settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <script type="text/javascript" language="javascript">
        function enablebtn() {
            document.getElementById("<%= btnSave.ClientID %>").disabled = false;
            document.getElementById("<%= btnSave.ClientID %>").style.color = "#fff";
        }
    </script>
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
                   <a href="usertrackmyhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>  »<asp:LinkButton ID="lblinks" runat="server" onclick="lblinks_Click">Fertility monitoring</asp:LinkButton> » Settings
                </div>
             </div>
            <div class="floatright">
                <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                <a id="userhelp" href="#"><img src="resources/images/h.png" /></a>
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
    <div id="print">
     <div class="clear borderbottom">
        <table>
            <tr>
                <td>
                     This page display current settings of this feature.
                </td>
            </tr>
            <tr style="height:10px">
                <td>
                     
                </td>
            </tr>
            <tr>
                <td>Input temperature : 
                    <%--<asp:Label ID="lbinputtemperature" runat="server" Text=""></asp:Label>--%>
                    <asp:DropDownList ID="ddlinputtemperature" runat="server" Width="120px" OnChange="javascript:enablebtn();">
                        <asp:ListItem Value="0">Manual</asp:ListItem>
                        <asp:ListItem Value="1">Auto</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>
    </div>
    <div class="clear" style="margin-bottom:20px;margin-top:20px">
         <%--<asp:Button ID="btnEdit" runat="server" Text="Edit" onclick="btnEdit_Click" />--%>
         <asp:Button ID="btnSave" runat="server" Text="Save Settings" 
             onclick="btnSave_Click" Enabled="false" ForeColor="#999999" />
         <%--<asp:Button ID="btnCancel" runat="server" Text="Cancel" 
             onclick="btnCancel_Click" CausesValidation="False" />--%>
         <asp:Button ID="btnback" runat="server" Text="Cancel" CausesValidation="false" PostBackUrl="usertrackmyhealth_fertility.aspx"/>
    </div>
</asp:Content>

