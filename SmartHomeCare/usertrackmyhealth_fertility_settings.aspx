<%@ Page Title="fertility monitoring - settings" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackmyhealth_fertility_settings.aspx.cs" Inherits="usertrackmyhealth_fertility_settings" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <script type="text/javascript" language="javascript">
        function enablebtn() {
            document.getElementById("<%= btnSave.ClientID %>").disabled = false;
            //document.getElementById("<%= btnSave.ClientID %>").style.color = "#fff";
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
                    <a href="usertrackmyhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>  »<asp:LinkButton ID="lblinks" runat="server" onclick="lblinks_Click">Fertility monitoring</asp:LinkButton> » Settings
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
                                        <td>Input temperature :
                                            <%--<asp:Label ID="lbinputtemperature" runat="server" Text=""></asp:Label>--%>
                                            <asp:DropDownList ID="ddlinputtemperature" runat="server" Width="120px" OnChange="javascript:enablebtn();" CssClass="form-control">
                                                <asp:ListItem Value="0">Manual</asp:ListItem>
                                                <asp:ListItem Value="1">Auto</asp:ListItem>
                                            </asp:DropDownList>
                                            <br />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            </div>
                            <div class="clear" style="margin-bottom:20px;margin-top:20px">
                                 <%--<asp:Button ID="btnEdit" runat="server" Text="Edit" onclick="btnEdit_Click" />--%>
                                 <asp:Button ID="btnSave" runat="server" Text="Save Settings" CssClass="btn btn-default"
                                     onclick="btnSave_Click" Enabled="false" />
                                 <%--<asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                                     onclick="btnCancel_Click" CausesValidation="False" />--%>
                                 <asp:Button ID="btnback" runat="server" Text="Cancel" CausesValidation="false" PostBackUrl="usertrackmyhealth_fertility.aspx" CssClass="btn btn-default"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

