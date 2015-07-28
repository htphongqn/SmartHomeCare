<%@ Page Title="Body measurement monitoring - settings" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackmyhealth_bodymeasurement_settings.aspx.cs" Inherits="usertrackmyhealth_bodymeasurement_settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
     <script type="text/javascript" language="javascript">
         function enablebtn() {
             document.getElementById("<%= btnSave.ClientID %>").disabled = false;
//             document.getElementById("<%= btnSave.ClientID %>").style.color = "#fff";
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
                »<asp:LinkButton ID="lblinks" runat="server" 
                        onclick="lblinks_Click">Body measurement monitoring</asp:LinkButton> » Settings
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div id="print">
                                 <div class="clear" >
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
                                        <tr class="bold">
                                            <td colspan="3">
                                                 Measurement methods:
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>IW method</td>
                                            <td colspan="2">
                                                <%--<asp:Label ID="lbiwmethod" runat="server" Text=""></asp:Label>--%>
                                                <asp:DropDownList ID="ddliwmethod" runat="server" DataTextField="Name" OnChange="javascript:enablebtn();" CssClass="form-control"
                                                    DataValueField="AutoId" Width="230px"></asp:DropDownList>                   
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>BF% method</td>
                                            <td colspan="2">
                                                <%--<asp:Label ID="lbbfmethod" runat="server" Text=""></asp:Label>--%>
                                                <asp:DropDownList ID="ddlbfmethod" runat="server" DataTextField="Name" OnChange="javascript:enablebtn();" CssClass="form-control"
                                                    DataValueField="AutoId" Width="230px"></asp:DropDownList>                   
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Fat Evalute</td>
                                            <td colspan="2">
                                                <%--<asp:Label ID="lbfateval" runat="server" Text=""></asp:Label>--%>
                                                <asp:DropDownList ID="ddlfateval" runat="server" DataTextField="Name" OnChange="javascript:enablebtn();" CssClass="form-control"
                                                    DataValueField="AutoId" Width="230px"></asp:DropDownList>                   
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                BMR method
                                            </td>
                                            <td colspan="2">
                                                <%--<asp:Label ID="lbbmrmethod" runat="server" Text=""></asp:Label>--%>
                                                <asp:DropDownList ID="ddlbmrmethod" runat="server" DataTextField="Name" OnChange="javascript:enablebtn();" CssClass="form-control"
                                                    DataValueField="AutoId" Width="230px"></asp:DropDownList>                   
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Activity Factor
                                            </td>
                                            <td colspan="2">
                                                <%--<asp:Label ID="lbactivityfactor" runat="server" Text=""></asp:Label>--%>
                                                <asp:DropDownList ID="ddlactivityfactor" runat="server" DataTextField="Name" OnChange="javascript:enablebtn();" CssClass="form-control"
                                                    DataValueField="AutoId" Width="230px"></asp:DropDownList>                   
                                            </td>
                                        </tr>
                                        <tr style="height:10px">
                                            <td>
                    
                                            </td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr class="bold">
                                            <td colspan="3">
                                                 Current body measurements:
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Weight:
                                            </td>
                                            <td>
                                                <%--<asp:Label ID="lbweight" runat="server" Text=""></asp:Label>--%>
                                                <asp:TextBox ID="txtweight" runat="server" onclick="javascript:enablebtn();" CssClass="form-control"
                                                    onkeypress="return digits(this, event, true, true);" Width="220px"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="lbweightunits" runat="server" Text=""></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Height:
                                            </td>
                                            <td>
                                                <%--<asp:Label ID="lbheightfeet" runat="server" Text=""></asp:Label>--%>
                                                <asp:TextBox ID="txtheightfeet" runat="server" onclick="javascript:enablebtn();" CssClass="form-control"
                                                    onkeypress="return digits(this, event, true, true);" Width="93px"></asp:TextBox>
                                                <asp:Label ID="lbheightfeetunits" runat="server" Text=""></asp:Label> 

                                                <%--<asp:Label ID="lbheight" runat="server" Text=""></asp:Label>--%>
                                                <asp:TextBox ID="txtheight" runat="server" onclick="javascript:enablebtn();" CssClass="form-control"
                                                    onkeypress="return digits(this, event, true, true);" Width="93px"></asp:TextBox>     
                                            </td>
                                            <td>
                                                <asp:Label ID="lbheightunits" runat="server" Text=""></asp:Label>   </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Waist:
                                            </td>
                                            <td>
                                                <%--<asp:Label ID="lbwaist" runat="server" Text=""></asp:Label>--%>
                                                <asp:TextBox ID="txtwaist" runat="server" onclick="javascript:enablebtn();" CssClass="form-control"
                                                    onkeypress="return digits(this, event, true, true);" Width="220px"></asp:TextBox>   
                                            </td>
                                            <td>
                                                <asp:Label ID="lbwaistunits" runat="server" Text=""></asp:Label>     </td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Hip:
                                            </td>
                                            <td>
                                                <%--<asp:Label ID="lbhip" runat="server" Text=""></asp:Label>--%>
                                                <asp:TextBox ID="txthip" runat="server" onclick="javascript:enablebtn();" CssClass="form-control"
                                                    onkeypress="return digits(this, event, true, true);" Width="220px"></asp:TextBox>
                                            </td>
                                            <td>
                                                <asp:Label ID="lbhipunits" runat="server" Text=""></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                Neck:
                                            </td>
                                            <td>
                                                <%--<asp:Label ID="lbneck" runat="server" Text=""></asp:Label>--%>
                                                <asp:TextBox ID="txtneck" runat="server" onclick="javascript:enablebtn();" CssClass="form-control"
                                                    onkeypress="return digits(this, event, true, true);" Width="220px"></asp:TextBox>     
                                            </td>
                                            <td>
                                                <asp:Label ID="lbneckunits" runat="server" Text=""></asp:Label>   </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                            <div class="no-border" style="margin-bottom:10px;margin-top:10px">
                                <asp:Button ID="btnSave" runat="server" Text="Save Settings" CssClass="btn btn-default"
                                    onclick="btnSave_Click" Enabled="false"/>
                                <asp:Button ID="btnback" runat="server" Text="Cancel" CssClass="btn btn-default" PostBackUrl="usertrackmyhealth_bodymeasurement.aspx" />
                            </div>                
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

