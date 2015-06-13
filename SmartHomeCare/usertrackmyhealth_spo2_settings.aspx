<%@ Page Title="Oxygen monitoring - setting" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackmyhealth_spo2_settings.aspx.cs" Inherits="usertrackmyhealth_spo2_settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            $('#userhelp').click(function (e) {
                window.open('userhelp.aspx', 'User Help', 500, 500);
            });
        });
    </script>
    <script type="text/javascript" language="javascript">
        function enablebtn() {
            document.getElementById("<%= btnSave.ClientID %>").disabled = false;
            document.getElementById("<%= btnSave.ClientID %>").style.color = "#fff";
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div id="print">
    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                  <a href="usertrackmyhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>  » <a href="usertrackmyhealth_spo2.aspx">Oxygen Monitoring </a> » Settings
                </div>
             </div>
            <div class="floatright">
                <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                <a id="userhelp" href="#"><img src="resources/images/h.png" /></a>
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
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
                    <asp:DropDownList ID="ddlsamplerate" runat="server" Width="50px"  OnChange="javascript:enablebtn();"
                        DataTextField="Name" DataValueField="AutoId"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>Tracking mode:</td>
                <td>
                    <%--<asp:Label ID="lbtrackingmode" runat="server"></asp:Label>--%>
                    <asp:DropDownList ID="ddltrackingmode" runat="server" Width="230px" OnChange="javascript:enablebtn();"
                        DataTextField="Name" DataValueField="AutoId" AutoPostBack="True" 
                        onselectedindexchanged="ddltrackingmode_SelectedIndexChanged"></asp:DropDownList>
                   
                </td>
            </tr>
            <tr>
                <td>Warning threshold:</td>
                <td>
                    <asp:Label ID="lbwarningthreshold" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>Measurement duration:</td>
                <td>
                    <%--<asp:Label ID="lbmeasurementduration" runat="server"></asp:Label>--%>
                    <asp:TextBox ID="txtmeasurementduration" runat="server" Width="173px" onclick="javascript:enablebtn();"
                        onkeypress="return digits(this, event, true, true);" ></asp:TextBox>
                    <asp:DropDownList ID="ddlmeasurementduration" runat="server" Width="50px" OnChange="javascript:enablebtn();"
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
         <asp:Button ID="btnback" runat="server" Text="Cancel" CausesValidation="false" PostBackUrl="usertrackmyhealth_spo2.aspx"/>
    </div>
</asp:Content>

