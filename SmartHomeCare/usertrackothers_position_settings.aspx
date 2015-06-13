<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackothers_position_settings.aspx.cs" Inherits="usertrackothers_position_settings" %>

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
                   <a href="usertrackotherhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>  » <a href="usertrackothers_position.aspx">Position monitoring </a> » Settings
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
                <td>Sample rate:
                    <%--<asp:Label ID="lbsamplerate" runat="server" Text=""></asp:Label>--%>
                    <asp:TextBox ID="txtsamplerate" runat="server" Width="103px" onclick="javascript:enablebtn();"
                        onkeypress="return digits(this, event, true, true);" ></asp:TextBox>
                    <asp:DropDownList ID="ddlsamplerate" runat="server" Width="50px" OnChange="javascript:enablebtn();" 
                        DataTextField="Name" DataValueField="AutoId"></asp:DropDownList>                   
                </td>
            </tr>
            <tr style="height:10px">
                <td>
                     
                </td>
            </tr>
            <tr>
                <td>Alarm position setting</td>
            </tr>
            <tr>
                <td style="padding-left:10px">
                    <asp:CheckBox ID="chkSupine" Text="Supine" runat="server" OnChange="javascript:enablebtn();"/><br />
                    <asp:CheckBox ID="chkProne" Text="Prone" runat="server" OnChange="javascript:enablebtn();"/><br />
                    <asp:CheckBox ID="chkLeftLateral" Text="Left Lateral" runat="server" OnChange="javascript:enablebtn();"/><br />
                    <asp:CheckBox ID="chkRightLateral" Text="Right Lateral" runat="server" OnChange="javascript:enablebtn();"/><br />
                    <asp:CheckBox ID="chkUp" Text="Up" runat="server" OnChange="javascript:enablebtn();"/><br />
                    <asp:CheckBox ID="chkDown" Text="Down" runat="server" OnChange="javascript:enablebtn();"/><br />
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
         <asp:Button ID="btnback" runat="server" Text="Cancel" CausesValidation="false" PostBackUrl="usertrackothers_position.aspx"/>
    </div>
</asp:Content>

