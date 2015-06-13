<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackothers_temperature_settings.aspx.cs" Inherits="usertrackothers_temperature_settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <script type="text/javascript" language="javascript">
        function enablebtn() {
            document.getElementById("<%= btnSave.ClientID %>").disabled = false;
            document.getElementById("<%= btnSave.ClientID %>").style.color = "#fff";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
  <div class="title_new">
            <div class="floatleft">
                <div class="td">
                 <a href="usertrackotherhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>
                    » <a href="usertrackother_temperature.aspx">Temperature monitoring </a>&nbsp;» Settings
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
                <td colspan="2">
                     This page display current settings of this feature.
                </td>
            </tr>
            <tr>
                <td>Sample rate: </td>
                <td>
                   <%--<asp:Label ID="lbSimpleRate" runat="server" Text=""></asp:Label>--%>
                   <asp:TextBox ID="txtSimpleRate" runat="server" Width="173px" onclick="javascript:enablebtn();"
                        onkeypress="return digits(this, event, true, true);" ></asp:TextBox>
                    <asp:DropDownList ID="ddlSimpleRate" runat="server" Width="50px" DataValueField = "AutoId" DataTextField = "Name" OnChange="javascript:enablebtn();"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>Low Threshold:</td>
                <td>
                    <%--<asp:Label ID="lbNormalThreshold" runat="server" Text=""></asp:Label>--%>
                    <asp:TextBox ID="txtNormalThreshold" runat="server" onclick="javascript:enablebtn();" 
                        onkeypress="return digits(this, event, true, true);" Width="220px"></asp:TextBox> 
                    <asp:Label ID="lbNormalThresholdUnits" runat="server" Text="⁰F"></asp:Label>                 
                </td>
            </tr>
            <tr>
                <td>High Threshhold:</td>
                <td>
                    <%--<asp:Label ID="lbHighThreshold" runat="server" Text=""></asp:Label>--%>
                    <asp:TextBox ID="txtHighThreshold" runat="server" onclick="javascript:enablebtn();"
                        onkeypress="return digits(this, event, true, true);" Width="220px"></asp:TextBox>
                        <asp:Label ID="lbHighThresholdUnits" runat="server" Text="⁰F"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Very High threshold:</td>
                <td>
                    <%--<asp:Label ID="lbVeryHighThreshold" runat="server" Text=""></asp:Label>--%>
                    <asp:TextBox ID="txtVeryHighThreshold" runat="server" onclick="javascript:enablebtn();" 
                        onkeypress="return digits(this, event, true, true);" Width="220px"></asp:TextBox>
                        <asp:Label ID="lbVeryHighThresholdUnits" runat="server" Text="⁰F"></asp:Label>
                </td>
            </tr>
        </table>
    </div>
    </div>
     <div class="clear" style="margin-bottom:50px;margin-top:50px">
         <%--<asp:Button ID="btnEdit" runat="server" Text="Edit" onclick="btnEdit_Click" />--%>
         <asp:Button ID="btnSave" runat="server" Text="Save Settings" 
             onclick="btnSave_Click" Enabled="false" ForeColor="#999999" />
         <%--<asp:Button ID="btnCancel" runat="server" Text="Cancel" 
             onclick="btnCancel_Click" CausesValidation="False" />--%>
         <asp:Button ID="btnback" runat="server" Text="Cancel" 
                        PostBackUrl="~/usertrackother_temperature.aspx" />
    </div>
</asp:Content>

