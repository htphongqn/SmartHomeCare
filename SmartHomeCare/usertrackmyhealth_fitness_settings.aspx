<%@ Page Title="fitness monitoring - setting" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackmyhealth_fitness_settings.aspx.cs" Inherits="usertrackmyhealth_fitness_settings" %>

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
                   <a href="usertrackmyhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>  » <asp:LinkButton ID="lnlinks" runat="server" onclick="lnlinks_Click">Fitness monitoring</asp:LinkButton> » Settings
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
                <td class="bold">Heart rate exercise: </td>
                <td>
                    
                </td>
            </tr>
            <tr>
                <td>Exercise mode:</td>
                <td>
                    <%--<asp:Label ID="lbexercisemode" runat="server" Text=""></asp:Label>--%>
                    <asp:DropDownList ID="ddlexercisemode" runat="server" Width="230px" OnChange="javascript:enablebtn();"
                        DataTextField="Name" DataValueField="AutoId" AutoPostBack="True" 
                        onselectedindexchanged="ddlexercisemode_SelectedIndexChanged"></asp:DropDownList>
                   
                </td>
            </tr>
            <tr>
                <td>Target HR method:</td>
                <td>
                    <%--<asp:Label ID="lbtargethr" runat="server" Text=""></asp:Label>--%>
                    <asp:DropDownList ID="ddltargethr" runat="server" Width="230px" OnChange="javascript:enablebtn();" 
                        DataTextField="Name" DataValueField="AutoId"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>Custom exercise programs:</td>
                <td>
                    <asp:HyperLink ID="hplcustom" runat="server" NavigateUrl="usertrackmyhealth_fitness_settings_custom.aspx" >Click here to customize</asp:HyperLink>
                </td>
            </tr>
            <tr style="height:10px">
                <td></td>
                <td>
                    
                </td>
            </tr>
            <tr>
                <td class="bold">Pedometer:</td>
                <td>
                </td>
            </tr>
            <tr>
                <td>Target setting:</td>
                <td>
                    <%--<asp:Label ID="lbtargetsetting" runat="server" Text=""></asp:Label>--%>
                    <asp:DropDownList ID="ddltargetsetting" runat="server" Width="230px" OnChange="javascript:enablebtn();"
                        DataTextField="Name" DataValueField="AutoId"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>Remind setting:</td>
                <td>
                    <%--<asp:Label ID="lbremindsetting" runat="server" Text=""></asp:Label>--%>
                    <asp:DropDownList ID="ddlremindsetting" runat="server" Width="230px" OnChange="javascript:enablebtn();" 
                        DataTextField="Name" DataValueField="AutoId"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>Calories burned method:</td>
                <td>
                    <%--<asp:Label ID="lbcaloryburn" runat="server" Text=""></asp:Label>--%>
                    <asp:DropDownList ID="ddlcaloryburn" runat="server" Width="230px" OnChange="javascript:enablebtn();"
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
         <asp:Button ID="btnback" runat="server" CausesValidation="false" PostBackUrl="usertrackmyhealth_fitness.aspx" Text="Cancel"/>
    </div>
</asp:Content>

