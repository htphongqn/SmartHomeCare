<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackothers_sleep_settings.aspx.cs" Inherits="usertrackothers_sleep_settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <script type="text/javascript" language="javascript">
        function enablebtn() {
            document.getElementById("<%= btnSave.ClientID %>").disabled = false;
            document.getElementById("<%= btnSave.ClientID %>").style.color = "#fff";
        }
    </script>
    <style>
        .form-control
        {
            width: 100%;
            float: left;
            margin: 0px 5px 5px 0px;
            height: 34px;
            padding: 6px 12px;
            font-size: 14px;
            line-height: 1.42857143;
            color: #555;
            background-color: #fff;
            background-image: none;
            border: 1px solid #ccc;
            border-radius: 4px;
            -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
            -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
            -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
            }
           .tTable input
           {
                width: 100%;
                float: left;
                margin: 0px 5px 5px 0px;
                height: 34px;
                padding: 6px 12px;
                font-size: 14px;
                line-height: 1.42857143;
                color: #555;
                background-color: #fff;
                background-image: none;
                border: 1px solid #ccc;
                border-radius: 4px;
                -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
                box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
                -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
                -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
                transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
               }
            .tTable select
           {
               width: 54%;
                float: left;
                margin: 0px 5px 5px 0px;
                height: 34px;
                padding: 6px 12px;
                font-size: 14px;
                line-height: 1.42857143;
                color: #555;
                background-color: #fff;
                background-image: none;
                border: 1px solid #ccc;
                border-radius: 4px;
                -webkit-box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
                box-shadow: inset 0 1px 1px rgba(0,0,0,.075);
                -webkit-transition: border-color ease-in-out .15s,-webkit-box-shadow ease-in-out .15s;
                -o-transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
                transition: border-color ease-in-out .15s,box-shadow ease-in-out .15s;
               }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Reports</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <a href="usertrackotherhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>  » <a href="usertrackothers_sleep.aspx">Sleep monitoring</a> » Settings
                    <div class="floatright">
                        <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                    </div>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6" style="width:100%;">
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
                                        <td>Heart rate sample rate:</td>
                                        <td>
                                            <%--<asp:Label ID="lbhrsamplerate" runat="server" Text=""></asp:Label>--%>
                                            <asp:TextBox ID="txthrsamplerate" runat="server" CssClass="form-control" Width="133px" onclick="javascript:enablebtn();"
                                                onkeypress="return digits(this, event, true, true);" ></asp:TextBox>
                                            <asp:DropDownList ID="ddlhrsamplerate" runat="server" CssClass="form-control" Width="80px" OnChange="javascript:enablebtn();" 
                                                DataTextField="Name" DataValueField="AutoId"></asp:DropDownList> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>GSR sample rate:</td>
                                        <td>
                                            <%--<asp:Label ID="lbgsrsamplerate" runat="server" Text=""></asp:Label>--%>
                                            <asp:TextBox ID="txtgsrsamplerate" runat="server" CssClass="form-control" Width="133px" onclick="javascript:enablebtn();"
                                                onkeypress="return digits(this, event, true, true);" ></asp:TextBox>
                                            <asp:DropDownList ID="ddlgsrsamplerate" runat="server" CssClass="form-control" Width="80px"  OnChange="javascript:enablebtn();"
                                                DataTextField="Name" DataValueField="AutoId"></asp:DropDownList> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Accelerometer sample rate:</td>
                                        <td>
                                            <%--<asp:Label ID="lbaccsamplerate" runat="server" Text=""></asp:Label>--%>
                                            <asp:TextBox ID="txtaccsamplerate" runat="server" CssClass="form-control" Width="133px" onclick="javascript:enablebtn();"
                                                onkeypress="return digits(this, event, true, true);" ></asp:TextBox>
                                            <asp:DropDownList ID="ddlaccsamplerate" runat="server" CssClass="form-control" Width="80px" OnChange="javascript:enablebtn();" 
                                                DataTextField="Name" DataValueField="AutoId"></asp:DropDownList> 
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Skin temperature sample rate:</td>
                                        <td>
                                            <%--<asp:Label ID="lbskinsamplerate" runat="server" Text=""></asp:Label>--%>
                                            <asp:TextBox ID="txtskinsamplerate" runat="server" CssClass="form-control" Width="133px" onclick="javascript:enablebtn();"
                                                onkeypress="return digits(this, event, true, true);" ></asp:TextBox>
                                            <asp:DropDownList ID="ddlskinsamplerate" runat="server" CssClass="form-control" Width="80px" OnChange="javascript:enablebtn();" 
                                                DataTextField="Name" DataValueField="AutoId"></asp:DropDownList> 
                                        </td>
                                    </tr>
                                    <tr style="height:10px">
                                        <td></td>
                                        <td>
                    
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Alarm setting:</td>
                                        <td>
                                            <asp:RadioButton ID="rdauto" runat="server" Text="Auto" GroupName="alarm" 
                                                AutoPostBack="True" oncheckedchanged="rdauto_CheckedChanged" />
                                            <asp:RadioButton ID="rdmanual" runat="server" Text="Manual"
                                                GroupName="alarm" AutoPostBack="True" 
                                                oncheckedchanged="rdmanual_CheckedChanged" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="padding-left:30px">
                                            <table>
                                                <tr id="trauto" runat="server" visible="false">
                                                    <td>sleep duration</td>
                                                    <td>
                                                        <asp:TextBox ID="txtsleepduration" runat="server" CssClass="form-control" Width="123px" OnChange="javascript:enablebtn();"
                                                            onkeypress="return digits(this, event, true, true);" ></asp:TextBox>
                                                        <asp:DropDownList ID="ddlsleepduration" runat="server" CssClass="form-control" Width="50px" OnChange="javascript:enablebtn();" 
                                                            DataTextField="Name" DataValueField="AutoId"></asp:DropDownList> 
                                                    </td>
                                                </tr>
                                                <tr id="trmanual" runat="server" visible="false">
                                                    <td valign="top">add alarms</td>
                                                    <td>
                                                        <%--<asp:ImageButton ID="lbtnaddalarm" runat="server" 
                                                            ImageUrl="~/resources/images/i_add.png" onclick="lbtnaddalarm_Click"></asp:ImageButton>--%>
                                                            <asp:Button ID="btnaddalarm" runat="server" Text="+" onclick="btnaddalarm_Click" CssClass="btn btn-default" style="height: 25px;padding: 0px 10px;margin-bottom: 10px;"></asp:Button>
                                                        <asp:Table ID="tblalarms" runat="server" Width="100%" class="tTable" onclick="javascript:enablebtn();">
                                                        </asp:Table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>            
                                </table>
                            </div>
                            </div>
                            <div class="clear" style="margin-bottom:20px;margin-top:20px">
                                 <%--<asp:Button ID="btnEdit" runat="server" Text="Edit" onclick="btnEdit_Click" />--%>
                                 <asp:Button ID="btnSave" runat="server" Text="Save Settings" CssClass="btn btn-default"
                                     onclick="btnSave_Click" Enabled="false" ForeColor="#999999" />
                                 <%--<asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                                     onclick="btnCancel_Click" CausesValidation="False" />--%>
                                 <asp:Button ID="btnback" runat="server" Text="Cancel" CausesValidation="false" PostBackUrl="usertrackmyhealth_sleep.aspx" CssClass="btn btn-default"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

