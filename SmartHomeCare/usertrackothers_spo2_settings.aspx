<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackothers_spo2_settings.aspx.cs" Inherits="usertrackothers_spo2_settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <script type="text/javascript" language="javascript">
        function enablebtn() {
            document.getElementById("<%= btnSave.ClientID %>").disabled = false;
            document.getElementById("<%= btnSave.ClientID %>").style.color = "#fff";
        }
    </script>
    <style type="text/css">
        td, th {
          padding: 5px;
        }
        .form-control
        {
            display:inline;
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
                    <a href="usertrackotherhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>  » <a href="usertrackothers_spo2.aspx">Oxygen Monitoring </a> » Settings
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
                                        <td>Sample rate: </td>
                                        <td>
                                            <%--<asp:Label ID="lbsamplerate" runat="server" Text=""></asp:Label>--%>
                                            <asp:TextBox ID="txtsamplerate" runat="server" Width="173px" onclick="javascript:enablebtn();" CssClass="form-control"
                                                onkeypress="return digits(this, event, true, true);" ></asp:TextBox>
                                            <asp:DropDownList ID="ddlsamplerate" runat="server" Width="80px"  OnChange="javascript:enablebtn();" CssClass="form-control"
                                                DataTextField="Name" DataValueField="AutoId"></asp:DropDownList></td>
                                    </tr>
                                    <tr>
                                        <td>Tracking mode:</td>
                                        <td>
                                            <%--<asp:Label ID="lbtrackingmode" runat="server"></asp:Label>--%>
                                            <asp:DropDownList ID="ddltrackingmode" runat="server" Width="230px" OnChange="javascript:enablebtn();" CssClass="form-control"
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
                                            <asp:TextBox ID="txtmeasurementduration" runat="server" Width="173px" onclick="javascript:enablebtn();" CssClass="form-control"
                                                onkeypress="return digits(this, event, true, true);" ></asp:TextBox>
                                            <asp:DropDownList ID="ddlmeasurementduration" runat="server" Width="80px" OnChange="javascript:enablebtn();" CssClass="form-control"
                                                DataTextField="Name" DataValueField="AutoId"></asp:DropDownList>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            </div>
                            <div class="clear" style="margin-bottom:20px;margin-top:20px">
                                 <%--<asp:Button ID="btnEdit" runat="server" Text="Edit" onclick="btnEdit_Click" />--%>
                                 <asp:Button ID="btnSave" runat="server" onclick="btnSave_Click" Text="Save Settings" CssClass="btn btn-default"
                                      Enabled="false" ForeColor="#999999" />
                                 <%--<asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                                     onclick="btnCancel_Click" CausesValidation="False" />--%>
                                 <asp:Button ID="btnback" runat="server" Text="Cancel" CausesValidation="false" PostBackUrl="usertrackothers_spo2.aspx" CssClass="btn btn-default"/>
                            </div>                  
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

