<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackothers_stress_settings.aspx.cs" Inherits="usertrackothers_stress_settings" %>

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
                  <a href="usertrackotherhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>  » <a href="usertrackothers_stress.aspx">Stress monitoring</a> &gt; Settings
                </div>
             </div>
            <div class="floatright">
                <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                <a id="userhelp" href="#"><img src="resources/images/h.png" /></a>
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
    <br />
    <div id="print">
     <div class="clear borderbottom">
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
                <td>Measurement duration:</td>
                <td>
                    <%--<asp:Label ID="lbmeasurementduration" runat="server" Text=""></asp:Label>--%>
                    <asp:TextBox ID="txtmeasurementduration" runat="server" Width="173px" onclick="javascript:enablebtn();"></asp:TextBox>
                    <asp:DropDownList ID="ddlmeasurementduration" runat="server" Width="50px" OnChange="javascript:enablebtn();" 
                        DataTextField="Name" DataValueField="AutoId"></asp:DropDownList>                   
                </td>
            </tr>
            <tr>
                <td>Heart rate sample:</td>
                <td>
                    <%--<asp:Label ID="lbheartratesample" runat="server" Text=""></asp:Label>--%>
                    <asp:TextBox ID="txtheartratesample" runat="server" Width="173px" onclick="javascript:enablebtn();"></asp:TextBox>
                    <asp:DropDownList ID="ddlheartratesample" runat="server" Width="50px" OnChange="javascript:enablebtn();" 
                        DataTextField="Name" DataValueField="AutoId"></asp:DropDownList>
                </td>
            </tr>
            <tr style="height:10px">
                <td colspan="2"></td>
            </tr>
            <tr>
                <td>GSR sample rate:</td>
                <td>
                    <%--<asp:Label ID="lbgsrsamplerate" runat="server" Text=""></asp:Label>--%>
                    <asp:TextBox ID="txtgsrsamplerate" runat="server" Width="173px" onclick="javascript:enablebtn();"></asp:TextBox>
                    <asp:DropDownList ID="ddlgsrsamplerate" runat="server" Width="50px" OnChange="javascript:enablebtn();"  
                        DataTextField="Name" DataValueField="AutoId"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>Accelerometer sample rate:</td>
                <td>
                    <%--<asp:Label ID="lbaccelerometersamplerate" runat="server" Text=""></asp:Label>--%>
                    <asp:TextBox ID="txtaccelerometersamplerate" runat="server" Width="173px" onclick="javascript:enablebtn();"></asp:TextBox>
                    <asp:DropDownList ID="ddlaccelerometersamplerate" runat="server" Width="50px" OnChange="javascript:enablebtn();"
                        DataTextField="Name" DataValueField="AutoId"></asp:DropDownList>
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
         <asp:Button ID="btnback" runat="server" CausesValidation="false" PostBackUrl="usertrackothers_stress.aspx" Text="Cancel"/>
    </div>
</asp:Content>

