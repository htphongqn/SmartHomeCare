<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackothers_fertility_settings.aspx.cs" Inherits="usertrackothers_fertility_settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <script type="text/javascript" language="javascript">
        function enablebtn() {
            document.getElementById("<%= btnSave.ClientID %>").disabled = false;
            document.getElementById("<%= btnSave.ClientID %>").style.color = "#fff";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="borderbottom">
        <div class="floatleft title">Track <asp:Label ID="lbcurrentuser" runat="server" ></asp:Label>&nbsp;Health<br />Fertility Monitoring - Settings</div>
        <div class="floatright"> <asp:LinkButton runat="server" ID="lb" Text="Print" OnClientClick="return printDiv('print');"></asp:LinkButton>     &nbsp;&nbsp;     <a href="userhelp.aspx">Help</a></div>
        <div class="clear"></div>
    </div>
    <br />
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
                    <asp:DropDownList ID="ddlinputtemperature" runat="server" Width="120px" OnChange="javascript:enablebtn();" >
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
         <asp:Button ID="btnback" runat="server" Text="Cancel" CausesValidation="false" PostBackUrl="usertrackothers_fertility.aspx"/>
    </div>
</asp:Content>

