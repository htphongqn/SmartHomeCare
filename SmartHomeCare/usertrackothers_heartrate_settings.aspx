<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackothers_heartrate_settings.aspx.cs" Inherits="usertrackothers_heartrate_settings" %>

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
                   <a href="usertrackotherhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>  » <a href="usertrackothers_heartrate.aspx">Heart Rate monitoring</a> » Settings
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
            <tr style="height:10px">
                <td colspan="2">
                     
                </td>
            </tr>
            <tr>
                <td>Sample rate: </td>
                <td>
                    <%--<asp:Label ID="lbsamplerate" runat="server" Text=""></asp:Label>--%>
                    <asp:TextBox ID="txtsamplerate" runat="server" Width="173px" onclick="javascript:enablebtn();"
                        onkeypress="return digits(this, event, true, true);" ></asp:TextBox>
                    <asp:DropDownList ID="ddlsamplerate" runat="server" Width="50px" OnChange="javascript:enablebtn();"
                        DataTextField="Name" DataValueField="AutoId"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>Max HR estimation:</td>
                <td>
                    <%--<asp:Label ID="lbmaxhrestimation" runat="server" Text=""></asp:Label>--%>
                    <asp:DropDownList ID="ddlmaxhrestimation" runat="server" Width="230px" OnChange="javascript:enablebtn();"
                        DataTextField="Name" DataValueField="AutoId"></asp:DropDownList>
                   
                </td>
            </tr>
            <tr>
                <td>High Resting HR threshold:</td>
                <td>
                    <%--<asp:Label ID="lbhighresting" runat="server" Text=""></asp:Label>--%>
                    <asp:DropDownList ID="ddlhighresting" runat="server" Width="230px" OnChange="javascript:enablebtn();"
                        DataTextField="Name" DataValueField="AutoId"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>Low Resting HR threshold:</td>
                <td>
                    <%--<asp:Label ID="lblowresting" runat="server" Text=""></asp:Label>--%>
                    <asp:DropDownList ID="ddllowresting" runat="server" Width="230px" OnChange="javascript:enablebtn();"
                        DataTextField="Name" DataValueField="AutoId"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>HRV analysis interval:</td>
                <td>
                    <%--<asp:Label ID="lbhrvanalysis" runat="server"></asp:Label>--%>
                    <asp:TextBox ID="txthrvanalysis" runat="server" Width="173px" onclick="javascript:enablebtn();"
                        onkeypress="return digits(this, event, true, true);"></asp:TextBox>
                    <asp:DropDownList ID="ddlhrvanalysis" runat="server" Width="50px" OnChange="javascript:enablebtn();"
                        DataTextField="Name" DataValueField="AutoId"></asp:DropDownList>
                </td>
            </tr>
        </table>
    </div>
    </div>
    <div class="clear" style="margin-bottom:20px;margin-top:20px">
         <%--<asp:Button ID="btnEdit" runat="server" Text="Edit" onclick="btnEdit_Click" />--%>
         <asp:Button ID="btnSave" runat="server" onclick="btnSave_Click" Text="Save Settings" 
              Enabled="false" ForeColor="#999999" />
         <%--<asp:Button ID="btnCancel" runat="server" Text="Cancel" 
             onclick="btnCancel_Click" CausesValidation="False" />--%>
         <asp:Button ID="btnback" runat="server" Text="Cancel" PostBackUrl="~/usertrackothers_heartrate.aspx"/>
    </div>
</asp:Content>

