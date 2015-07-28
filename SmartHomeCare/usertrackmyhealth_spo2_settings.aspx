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
//            document.getElementById("<%= btnSave.ClientID %>").style.color = "#fff";
        }
    </script>
        <style type="text/css">
        td, th {
          padding: 5px;
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
                    <a href="usertrackmyhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>  » <a href="usertrackmyhealth_spo2.aspx">Oxygen Monitoring </a> » Settings
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div class="clear">
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
                                            <asp:TextBox ID="txtsamplerate" runat="server" Width="173px" onclick="javascript:enablebtn();" CssClass="form-control"
                                                onkeypress="return digits(this, event, true, true);" ></asp:TextBox></td>
                                            <td>
                                            <asp:DropDownList ID="ddlsamplerate" runat="server" Width="50px"  OnChange="javascript:enablebtn();" CssClass="form-control"
                                                DataTextField="Name" DataValueField="AutoId"></asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td>Tracking mode:</td>
                                        <td colspan="2">
                                            <%--<asp:Label ID="lbtrackingmode" runat="server"></asp:Label>--%>
                                            <asp:DropDownList ID="ddltrackingmode" runat="server" Width="230px" OnChange="javascript:enablebtn();" CssClass="form-control"
                                                DataTextField="Name" DataValueField="AutoId" AutoPostBack="True"
                                                onselectedindexchanged="ddltrackingmode_SelectedIndexChanged"></asp:DropDownList>                   
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Warning threshold:</td>
                                        <td colspan="2">
                                            <asp:Label ID="lbwarningthreshold" runat="server"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Measurement duration:</td>
                                        <td>
                                            <%--<asp:Label ID="lbmeasurementduration" runat="server"></asp:Label>--%>
                                            <asp:TextBox ID="txtmeasurementduration" runat="server" Width="173px" onclick="javascript:enablebtn();" CssClass="form-control"
                                                onkeypress="return digits(this, event, true, true);" ></asp:TextBox>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlmeasurementduration" runat="server" Width="50px" OnChange="javascript:enablebtn();" CssClass="form-control"
                                                DataTextField="Name" DataValueField="AutoId"></asp:DropDownList></td>
                                    </tr>
                                </table>
                            </div>
                            <div class="no-border" style="margin-bottom:10px;margin-top:10px">
                                <asp:Button ID="btnSave" runat="server" onclick="btnSave_Click" Text="Save Settings"  CssClass="btn btn-default"
                                    Enabled="false"/>
                                <asp:Button ID="btnback" runat="server" Text="Cancel" CssClass="btn btn-default" CausesValidation="false" PostBackUrl="usertrackmyhealth_spo2.aspx"/>
                            </div>                
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

