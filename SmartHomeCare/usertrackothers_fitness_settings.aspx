<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackothers_fitness_settings.aspx.cs" Inherits="usertrackothers_fitness_settings" %>

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
                    <a href="usertrackotherhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>  » <a href="usertrackothers_fitness.aspx">Fitness monitoring </a> » Settings
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
                                        <td class="bold">Heart rate exercise: </td>
                                        <td>
                    
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Exercise mode:</td>
                                        <td>
                                            <%--<asp:Label ID="lbexercisemode" runat="server" Text=""></asp:Label>--%>
                                            <asp:DropDownList ID="ddlexercisemode" runat="server" Width="230px" OnChange="javascript:enablebtn();"
                                                DataTextField="Name" DataValueField="AutoId" AutoPostBack="True" CssClass="form-control"
                                                onselectedindexchanged="ddlexercisemode_SelectedIndexChanged"></asp:DropDownList>
                   
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Target HR method:</td>
                                        <td>
                                            <%--<asp:Label ID="lbtargethr" runat="server" Text=""></asp:Label>--%>
                                            <asp:DropDownList ID="ddltargethr" runat="server" Width="230px" OnChange="javascript:enablebtn();" CssClass="form-control"
                                                DataTextField="Name" DataValueField="AutoId"></asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Custom exercise programs:</td>
                                        <td>
                                            <asp:HyperLink ID="hplcustom" runat="server" NavigateUrl="usertrackothers_fitness_settings_custom.aspx" >Click here to customize</asp:HyperLink>
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
                                            <asp:DropDownList ID="ddltargetsetting" runat="server" Width="230px" OnChange="javascript:enablebtn();" CssClass="form-control"
                                                DataTextField="Name" DataValueField="AutoId"></asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Remind setting:</td>
                                        <td>
                                            <%--<asp:Label ID="lbremindsetting" runat="server" Text=""></asp:Label>--%>
                                            <asp:DropDownList ID="ddlremindsetting" runat="server" Width="230px" OnChange="javascript:enablebtn();" CssClass="form-control"
                                                DataTextField="Name" DataValueField="AutoId"></asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Calories burned method:</td>
                                        <td>
                                            <%--<asp:Label ID="lbcaloryburn" runat="server" Text=""></asp:Label>--%>
                                            <asp:DropDownList ID="ddlcaloryburn" runat="server" Width="230px" OnChange="javascript:enablebtn();" CssClass="form-control"
                                                DataTextField="Name" DataValueField="AutoId"></asp:DropDownList>
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
                                 <asp:Button ID="btnback" runat="server" CausesValidation="false" PostBackUrl="usertrackothers_fitness.aspx" Text="Cancel" CssClass="btn btn-default"/>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

