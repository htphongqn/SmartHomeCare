<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackmyhealth_position_settings.aspx.cs" Inherits="usertrackmyhealth_position_settings" %>

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
    <style>
        .form-control
        {
            width: 100%;
            float: left;
            margin: 0px 5px 5px 0px;
            height: 34px;
            padding: 6px 10px;
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
                    <a href="usertrackmyhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>  » 
                   <asp:LinkButton ID="lbLinks" runat="server" onclick="lbLinks_Click">Position monitoring</asp:LinkButton> » Settings
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
                                            <asp:TextBox ID="txtsamplerate" runat="server" Width="103px" CssClass="form-control" onclick="javascript:enablebtn();"
                                                onkeypress="return digits(this, event, true, true);" ></asp:TextBox>
                                            <asp:DropDownList ID="ddlsamplerate" runat="server" Width="70px" OnChange="javascript:enablebtn();" CssClass="form-control"
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
                                 <asp:Button ID="btnSave" runat="server" Text="Save Settings" CssClass="btn btn-default"
                                     onclick="btnSave_Click" Enabled="false" ForeColor="#999999" />
                                 <%--<asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                                     onclick="btnCancel_Click" CausesValidation="False" />--%>
                                 <asp:Button ID="btnback" runat="server" Text="CANCEL" CausesValidation="false" PostBackUrl="usertrackmyhealth_position.aspx" CssClass="btn btn-default"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

