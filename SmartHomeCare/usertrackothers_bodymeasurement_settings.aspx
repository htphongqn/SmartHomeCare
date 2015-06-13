<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackothers_bodymeasurement_settings.aspx.cs" Inherits="usertrackothers_bodymeasurement_settings" %>

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
                »<a href="usertrackothers_bodymeasurement.aspx"> Body measurement monitoring</a> » Settings 
                </div>
             </div>
            <div class="floatright">
                <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                <a id="userhelp" href="javascript:void(0)"><img src="resources/images/h.png" /></a>
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
    <div id="print">
     <div class="clear borderbottom" >
        <table>
            <tr>
                <td colspan="2">
                     This page display current settings of this feature.
                </td>
            </tr>
            <tr  style="height:10px">
                <td colspan="2">
                     
                </td>
            </tr>
            <tr class="bold">
                <td colspan="2">
                     Measurement methods:
                </td>
            </tr>
            <tr>
                <td>IW method</td>
                <td>
                    <%--<asp:Label ID="lbiwmethod" runat="server" Text=""></asp:Label>--%>
                    <asp:DropDownList ID="ddliwmethod" runat="server" DataTextField="Name" OnChange="javascript:enablebtn();"
                        DataValueField="AutoId" Width="230px"></asp:DropDownList>                   
                </td>
            </tr>
            <tr>
                <td>BF% method</td>
                <td>
                    <%--<asp:Label ID="lbbfmethod" runat="server" Text=""></asp:Label>--%>
                    <asp:DropDownList ID="ddlbfmethod" runat="server" DataTextField="Name" OnChange="javascript:enablebtn();"
                        DataValueField="AutoId" Width="230px"></asp:DropDownList>                   
                </td>
            </tr>
            <tr>
                <td>Fat Evalute</td>
                <td>
                    <%--<asp:Label ID="lbfateval" runat="server" Text=""></asp:Label>--%>
                    <asp:DropDownList ID="ddlfateval" runat="server" DataTextField="Name" OnChange="javascript:enablebtn();"
                        DataValueField="AutoId" Width="230px"></asp:DropDownList>                   
                </td>
            </tr>
            <tr>
                <td>
                    BMR method
                </td>
                <td>
                    <%--<asp:Label ID="lbbmrmethod" runat="server" Text=""></asp:Label>--%>
                    <asp:DropDownList ID="ddlbmrmethod" runat="server" DataTextField="Name" OnChange="javascript:enablebtn();"
                        DataValueField="AutoId" Width="230px"></asp:DropDownList>                   
                </td>
            </tr>
            <tr>
                <td>
                    Activity Factor
                </td>
                <td>
                    <%--<asp:Label ID="lbactivityfactor" runat="server" Text=""></asp:Label>--%>
                    <asp:DropDownList ID="ddlactivityfactor" runat="server" DataTextField="Name" OnChange="javascript:enablebtn();"
                        DataValueField="AutoId" Width="230px"></asp:DropDownList>                   
                </td>
            </tr>
            <tr style="height:10px">
                <td>
                    
                </td>
                <td></td>
            </tr>
            <tr class="bold">
                <td colspan="2">
                     Current body measurements:
                </td>
            </tr>
            <tr>
                <td>
                    Weight:
                </td>
                <td>
                    <%--<asp:Label ID="lbweight" runat="server" Text=""></asp:Label>--%>
                    <asp:TextBox ID="txtweight" runat="server" onclick="javascript:enablebtn();"
                        onkeypress="return digits(this, event, true, true);" Width="220px"></asp:TextBox>
                    <asp:Label ID="lbweightunits" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    Height:
                </td>
                <td>
                    <%--<asp:Label ID="lbheightfeet" runat="server" Text=""></asp:Label>--%>
                    <asp:TextBox ID="txtheightfeet" runat="server" onclick="javascript:enablebtn();"
                        onkeypress="return digits(this, event, true, true);" Width="93px"></asp:TextBox>
                    <asp:Label ID="lbheightfeetunits" runat="server" Text=""></asp:Label> 

                    <%--<asp:Label ID="lbheight" runat="server" Text=""></asp:Label>--%>
                    <asp:TextBox ID="txtheight" runat="server" onclick="javascript:enablebtn();"
                        onkeypress="return digits(this, event, true, true);" Width="93px"></asp:TextBox>
                    <asp:Label ID="lbheightunits" runat="server" Text=""></asp:Label>        
                </td>
            </tr>
            <tr>
                <td>
                    Waist:
                </td>
                <td>
                    <%--<asp:Label ID="lbwaist" runat="server" Text=""></asp:Label>--%>
                    <asp:TextBox ID="txtwaist" runat="server" onclick="javascript:enablebtn();"
                        onkeypress="return digits(this, event, true, true);" Width="220px"></asp:TextBox>
                    <asp:Label ID="lbwaistunits" runat="server" Text=""></asp:Label>        
                </td>
            </tr>
            <tr>
                <td>
                    Hip:
                </td>
                <td>
                    <%--<asp:Label ID="lbhip" runat="server" Text=""></asp:Label>--%>
                    <asp:TextBox ID="txthip" runat="server" onclick="javascript:enablebtn();"
                        onkeypress="return digits(this, event, true, true);" Width="220px"></asp:TextBox>
                    <asp:Label ID="lbhipunits" runat="server" Text=""></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    Neck:
                </td>
                <td>
                    <%--<asp:Label ID="lbneck" runat="server" Text=""></asp:Label>--%>
                    <asp:TextBox ID="txtneck" runat="server" onclick="javascript:enablebtn();"
                        onkeypress="return digits(this, event, true, true);" Width="220px"></asp:TextBox>
                    <asp:Label ID="lbneckunits" runat="server" Text=""></asp:Label>        
                </td>
            </tr>
        </table>
    </div>
    </div>
    <div class="clear" style="margin-bottom:20px;margin-top:20px">
         <%--<asp:Button ID="btnEdit" runat="server" Text="Edit" onclick="btnEdit_Click" />--%>
         <asp:Button ID="btnSave" runat="server" Text="Save Settings" onclick="btnSave_Click" Enabled="false" ForeColor="#999999" />
         <%--<asp:Button ID="btnCancel" runat="server" Text="Cancel" onclick="btnCancel_Click" CausesValidation="False" />--%>
         <asp:Button ID="btnback" runat="server" Text="Cancel" PostBackUrl="usertrackothers_bodymeasurement.aspx" />
    </div>

</asp:Content>

