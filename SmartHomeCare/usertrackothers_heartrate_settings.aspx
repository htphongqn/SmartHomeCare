<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackothers_heartrate_settings.aspx.cs" Inherits="usertrackothers_heartrate_settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <script type="text/javascript" language="javascript">
        function enablebtn() {
            document.getElementById("<%= btnSave.ClientID %>").disabled = false;
            //document.getElementById("<%= btnSave.ClientID %>").style.color = "#fff";
        }
    </script>
    <style type="text/css">
        td, th {
          padding: 5px;
        }
        .form-control
        {
            padding:6px 1px;
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
                    <a href="usertrackotherhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>  » <a href="usertrackothers_heartrate.aspx">Heart Rate monitoring</a> » Settings
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div id="print">
                             <div class="clear borderbottom">
                                <table>
                                    <tr>
                                        <td colspan="3">
                                             This page display current settings of this feature.
                                        </td>
                                    </tr>
                                    <tr style="height:10px">
                                        <td colspan="3">
                     
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Sample rate: </td>
                                        <td>
                                            <%--<asp:Label ID="lbsamplerate" runat="server" Text=""></asp:Label>--%>
                                            <asp:TextBox ID="txtsamplerate" runat="server" Width="230px" onclick="javascript:enablebtn();" CssClass="form-control"
                                                onkeypress="return digits(this, event, true, true);" ></asp:TextBox></td>
                                            <td>
                                            <asp:DropDownList ID="ddlsamplerate" runat="server" Width="60px" OnChange="javascript:enablebtn();" CssClass="form-control"
                                                DataTextField="Name" DataValueField="AutoId"></asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td>Max HR estimation:</td>
                                        <td colspan="2">
                                            <%--<asp:Label ID="lbmaxhrestimation" runat="server" Text=""></asp:Label>--%>
                                            <asp:DropDownList ID="ddlmaxhrestimation" runat="server" Width="230px" OnChange="javascript:enablebtn();" CssClass="form-control"
                                                DataTextField="Name" DataValueField="AutoId"></asp:DropDownList>
                   
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>High Resting HR threshold:</td>
                                        <td colspan="2">
                                            <%--<asp:Label ID="lbhighresting" runat="server" Text=""></asp:Label>--%>
                                            <asp:DropDownList ID="ddlhighresting" runat="server" Width="230px" OnChange="javascript:enablebtn();" CssClass="form-control"
                                                DataTextField="Name" DataValueField="AutoId"></asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Low Resting HR threshold:</td>
                                        <td colspan="2">
                                            <%--<asp:Label ID="lblowresting" runat="server" Text=""></asp:Label>--%>
                                            <asp:DropDownList ID="ddllowresting" runat="server" Width="230px" OnChange="javascript:enablebtn();" CssClass="form-control"
                                                DataTextField="Name" DataValueField="AutoId"></asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>HRV analysis interval:</td>
                                        <td>
                                            <%--<asp:Label ID="lbhrvanalysis" runat="server"></asp:Label>--%>
                                            <asp:TextBox ID="txthrvanalysis" runat="server" Width="230px" onclick="javascript:enablebtn();" CssClass="form-control"
                                                onkeypress="return digits(this, event, true, true);"></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlhrvanalysis" runat="server" Width="60px" OnChange="javascript:enablebtn();" CssClass="form-control"
                                                DataTextField="Name" DataValueField="AutoId"></asp:DropDownList></td>
                                    </tr>
                                </table>
                            </div>
                            </div>
                            <div class="no-border" style="margin-bottom:10px;margin-top:10px">
                                <asp:Button ID="btnSave" runat="server" onclick="btnSave_Click" Text="Save Settings"  CssClass="btn btn-default"
              Enabled="false" />
                            <asp:Button ID="btnback" runat="server" Text="Cancel" PostBackUrl="~/usertrackothers_heartrate.aspx" CssClass="btn btn-default"/>
                            </div>                
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

