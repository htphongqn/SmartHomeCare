<%@ Page Title="temperature monitoring - setting" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackmyhealth_temperature_settings.aspx.cs" Inherits="usertrackmyhealth_temperature_settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <script type="text/javascript" language="javascript">
        function enablebtn() {
            document.getElementById("<%= btnSave.ClientID %>").disabled = false;
//            document.getElementById("<%= btnSave.ClientID %>").style.color = "#fff";
        }
    </script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#userhelp').click(function (e) {
                window.open('userhelp.aspx', 'User Help', 500, 500);
            });
        });
    </script>
        <style type="text/css">
        .style1
        {
            height: 114px;
        }
        .style2
        {
            height: 136px;
        }
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
                    <a href="usertrackmyhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>
                    »<asp:LinkButton ID="lnlinks" runat="server" 
                        onclick="lnlinks_Click">Temperature monitoring</asp:LinkButton>&nbsp;» Settings
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6"> 
                            <div id="print">
                             <div class="clear">
                                <table>
                                    <tr>
                                        <td colspan="3">
                                             This page display current settings of this feature.
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Sample rate: </td>
                                        <td>
                                           <%--<asp:Label ID="lbSimpleRate" runat="server" Text=""></asp:Label>--%>
                                           <asp:TextBox ID="txtSimpleRate" runat="server" Width="220px" onclick="javascript:enablebtn();" CssClass="form-control"
                                                onkeypress="return digits(this, event, true, true);" ></asp:TextBox>                                            
                                        </td>
                                        <td><asp:DropDownList ID="ddlSimpleRate" runat="server" Width="60px" DataValueField = "AutoId" DataTextField = "Name" CssClass="form-control" OnChange="javascript:enablebtn();"></asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td>Low Threshold:</td>
                                        <td>
                                            <%--<asp:Label ID="lbNormalThreshold" runat="server" Text=""></asp:Label>--%>
                                            <asp:TextBox ID="txtNormalThreshold" runat="server" onclick="javascript:enablebtn();"  CssClass="form-control"
                                                onkeypress="return digits(this, event, true, true);" Width="220px"></asp:TextBox>                                                              
                                        </td>
                                        <td><asp:Label ID="lbNormalThresholdUnits" runat="server" Text="⁰F"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td>High Threshhold:</td>
                                        <td>
                                            <%--<asp:Label ID="lbHighThreshold" runat="server" Text=""></asp:Label>--%>
                                            <asp:TextBox ID="txtHighThreshold" runat="server" onclick="javascript:enablebtn();" CssClass="form-control"
                                                onkeypress="return digits(this, event, true, true);" Width="220px"></asp:TextBox>                                                
                                        </td>
                                        <td><asp:Label ID="lbHighThresholdUnits" runat="server" Text="⁰F"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td>Very High threshold:</td>
                                        <td>
                                            <%--<asp:Label ID="lbVeryHighThreshold" runat="server" Text=""></asp:Label>--%>
                                            <asp:TextBox ID="txtVeryHighThreshold" runat="server" onclick="javascript:enablebtn();"  CssClass="form-control"
                                                onkeypress="return digits(this, event, true, true);" Width="220px"></asp:TextBox>                                                
                                        </td>
                                        <td><asp:Label ID="lbVeryHighThresholdUnits" runat="server" Text="⁰F"></asp:Label></td>
                                    </tr>
                                </table>
                            </div>
                            </div>
                            <div class="no-border" style="margin-bottom:10px;margin-top:10px">                                
                                 <asp:Button ID="btnSave" runat="server" Text="Save Settings"  CssClass="btn btn-default"
                                     onclick="btnSave_Click" Enabled="false" />
                                 <asp:Button ID="btnback" runat="server" Text="Cancel"  CssClass="btn btn-default"
                                                PostBackUrl="~/usertrackmyhealth_temperature.aspx" />
                            </div>                
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

