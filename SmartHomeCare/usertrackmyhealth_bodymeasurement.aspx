<%@ Page Title="Body Measurement Monitoring" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="usertrackmyhealth_bodymeasurement.aspx.cs" Inherits="usertrackmyhealth_bodymeasurement" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head1" runat="Server">
    <link href="styles/tab.css" rel="stylesheet" type="text/css" />
    <link href="styles/control.css" rel="stylesheet" type="text/css" />
    <link href="styles/BodyMeasurement.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function dateSelectionChanged(sender, args) {
            selectedDate = sender.get_selectedDate();
            sundayDate = getSundayDateUsingYourAlgorithm(selectedDate);
            sender.set_SelectedDate(sundayDate);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" runat="Server">
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
                        onclick="lblinks_Click">Body measurement monitoring</asp:LinkButton>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">                            
                        <div id="print">
                            Select GRAPH or TABLE buttons to see Body measurement monitoring Report.
                            <div style="padding-top:10px;">
                                <asp:Button ID="btnGraph2" runat="server" CssClass="btn btn-default" OnClick="btnGraph2_Click" Text="Graph" />
                                <asp:Button ID="btnTable2" runat="server" CssClass="btn btn-default" OnClick="btnTable2_Click" Text="Table" />
                            </div>
                            <asp:MultiView ID="MultiViewBody" runat="server" ActiveViewIndex="0">
                                <asp:View ID="ViewGraph" runat="server">
                                    <div class="item_report_body">
                                        <div id="chart" align="center">
                                        <asp:Panel ID="pnChart" runat="server" Visible="False">
                                            <div style="float:left; width:78%;">
                                                <table>
                                                    <tr>
                                                        <td valign="top">
                                                            <table style="width: 100px;">
                                                                <tr>
                                                                    <td class="TitleChart">
                                                                        BMI
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="TitleChart">
                                                                        WHR
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="TitleChart">
                                                                        BMR
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="TitleChart">
                                                                        BF%
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="TitleChart">
                                                                        Ideal weight
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td class="TitleChart">
                                                                        Metabolic age
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </td>
                                                        <td style="overflow: hidden;" valign="top">
                                                            <div class="Chart">
                                                                <div>
                                                                    <asp:DataList ID="dtlChart" runat="server" RepeatDirection="Horizontal">
                                                                        <ItemTemplate>
                                                                            <table cellspacing="5" style="border-right: 1px solid;">
                                                                                <tr style="height: 25px;">
                                                                                    <td class="Obese" style="background-color: <%# Eval("BMI_Color") %>">
                                                                                    </td>
                                                                                </tr>
                                                                                <tr style="height: 25px;">
                                                                                    <td class="Healthy" style="background-color: <%# Eval("WHR_Color") %>">
                                                                                    </td>
                                                                                </tr>
                                                                                <tr style="height: 25px;">
                                                                                    <td class="UnderOverWeight" style="background-color: <%# Eval("BMR_Color") %>">
                                                                                    </td>
                                                                                </tr>
                                                                                <tr style="height: 25px;">
                                                                                    <td class="Obese" style="background-color: <%# Eval("BFPercent_Color") %>">
                                                                                    </td>
                                                                                </tr>
                                                                                <tr style="height: 25px;">
                                                                                    <td class="Healthy" style="background-color: <%# Eval("IW_Color") %>">
                                                                                    </td>
                                                                                </tr>
                                                                                <tr style="height: 25px;">
                                                                                    <td class="UnderOverWeight" style="background-color: <%# Eval("MetaAge_Color") %>">
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                            <div style="padding-left: 15px;">
                                                                                <asp:Label ID="lblDate" CssClass="LabelTitle" runat="server" Text='<%# Bind("CreatedDate", "{0:MM/dd/yy}") %>'></asp:Label>
                                                                            </div>
                                                                        </ItemTemplate>
                                                                    </asp:DataList>
                                                                </div>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>

                                                <asp:LinkButton ID="lbtnDateTime" runat="server" Font-Underline="False" 
                                                onclick="lbtnDateTime_Click">DateTime</asp:LinkButton>
                                            </div>

                                            <div style="float:left; width:20%;text-align:left; border-left: 2px solid #ccc;">
                                                <div style="font-size: 7pt;">
                                                    <fieldset style="height: 135px;">
                                                        <legend>BMI</legend>
                                                        <table cellpadding="0" cellspacing="1">
                                                            <tr>
                                                                <td>
                                                                    <div class="Legend" style="background-color: Blue;">
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    Severely underweight
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <div class="Legend" style="background-color: LightBlue;">
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    Underweight
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <div class="Legend" style="background-color: Green;">
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    Normal
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <div class="Legend" style="background-color: Yellow;">
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    Overweight
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <div class="Legend" style="background-color: Orange;">
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    Obese
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <div class="Legend" style="background-color: Red;">
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    Very Obese
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                    <fieldset style="height: 100px;">
                                                        <legend>WHR</legend>
                                                        <table cellpadding="0" cellspacing="1">
                                                            <tr>
                                                                <td>
                                                                    <div class="Legend" style="background-color: Green;">
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    Low
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <div class="Legend" style="background-color: Yellow;">
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    Moderate
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <div class="Legend" style="background-color: Orange;">
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    High
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <div class="Legend" style="background-color: Red;">
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    Very high
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                    <asp:Literal ID="ltrBF" runat="server"></asp:Literal>
                                                </div>
                                            </div>
                                                            
                                            <br />
                                        </asp:Panel>
                                            <asp:Panel ID="pnEmptyData" runat="server" CssClass="panel_empty_data_body">
                                                <asp:Label ID="lbDataEmpty" runat="server" Text="You have no data to graph!" ForeColor="Red"></asp:Label>
                                            </asp:Panel>                                            
                    
                                        <asp:Panel ID="datetime_graph" CssClass="datetime_filter_graph" runat="server" Visible="false">
                                            <div>
                                                <asp:Panel ID="Panel2" CssClass="TitlePanelDateTime" runat="server">
                                                    Select Date
                                                </asp:Panel>
                                            </div>
                                            <div class="ContentDateTime">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            From Date:
                                                        </td>
                                                        <td>
                                                            To Date:
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtFromDate" runat="server"></asp:TextBox>
                                                            <asp:CalendarExtender
                                                                ID="txtFromDate_CalendarExtender" runat="server" Enabled="True"
                                                                TargetControlID="txtFromDate" CssClass="orange">
                                                            </asp:CalendarExtender>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtToDate" runat="server"></asp:TextBox>
                                                            <asp:CalendarExtender ID="txtToDate_CalendarExtender"
                                                                runat="server" Enabled="True" TargetControlID="txtToDate" 
                                                                CssClass="orange">
                                                            </asp:CalendarExtender>
                                                        </td>
                                                    </tr>
                                                    <tr align="center">
                                                        <td colspan="2">
                                                            <asp:Button ID="btnOk" runat="server" OnClick="btnOk_Click" Text="Select" />
                                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                                                                onclick="btnCancel_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </asp:Panel>
                                    </div>
                                    </div>
                                </asp:View>
                                <asp:View ID="ViewTable" runat="server">
                                <div class="item_report_body">
                                <div class="body_measurement">
                                                <div class="title_data">
                                                    <table>
                                                        <tr>
                                                            <th></th>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                            
                                                                <asp:LinkButton ID="lbDateTable" runat="server" onclick="lbDateTable_Click" 
                                                                    CssClass="cursor" ForeColor="White" >DateTime</asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td style="width:79px">BMI</td>
                                                        </tr>
                                                        <tr>
                                                            <td>WHR</td>
                                                        </tr>
                                                        <tr>
                                                            <td>BMR</td>
                                                        </tr>
                                                        <tr>
                                                            <td>BF%</td>
                                                        </tr>
                                                        <tr>
                                                            <td>LBW</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Ideal W</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Meta. age</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Act. level</td>
                                                        </tr>
                                                        <tr>
                                                            <td>Cal. needs</td>
                                                        </tr>
                                                    </table>
                                        </div>
                                        <div class="body_data">
                                                <asp:Label runat="server" ID="ld_data"></asp:Label>
                                        </div>
                                        <div class="clear">
                                        </div>
                                  </div>      
              
                                        <asp:Panel ID="div_popup" CssClass="datetime_filter_top" runat="server" Visible="false">
                                            <div>
                                                <asp:Panel ID="div_header_popup" CssClass="TitlePanelDateTime" runat="server">
                                                    Select Date
                                                </asp:Panel>
                                            </div>
                                            <div class="ContentDateTime">
                                                <table>
                                                    <tr>
                                                        <td>
                                                            From Date:
                                                        </td>
                                                        <td>
                                                            To Date:
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtFromDateTable" runat="server"></asp:TextBox>
                                                            <asp:CalendarExtender
                                                                ID="cl_txtFromT" runat="server" Enabled="True" OnClientDateSelectionChanged="dateSelectionChanged"
                                                                TargetControlID="txtFromDateTable" CssClass="orange" 
                                                                DaysModeTitleFormat="MM,dd,yyyy" TodaysDateFormat="MM,dd,yyyy">
                                                            </asp:CalendarExtender>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtToDateTable" runat="server"></asp:TextBox>
                                                            <asp:CalendarExtender ID="cl_txtToT"
                                                                runat="server" Enabled="True" TargetControlID="txtToDateTable" 
                                                                CssClass="orange">
                                                            </asp:CalendarExtender>
                                                        </td>
                                                    </tr>
                                                    <tr align="center">
                                                        <td colspan="2">
                                                            <asp:Button ID="btn_Ok_Table" runat="server" Text="Select" 
                                                                onclick="btn_Ok_Table_Click" />
                                                            <asp:Button ID="btncancel2" runat="server" Text="Cancel" 
                                                                onclick="btncancel2_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </asp:Panel>
                                         </div><!-- item -->
                                </asp:View>
                            </asp:MultiView>
        
                        </div>
                        <!-- print-->
                        <br />
                        <div class="border-top-bottom">
                            <div class="title">
                                Diagnosis & Recommendations</div>
                            <div >
                                This page displays your current mediacal issues and the date that they were noded
                                in your medical record. Click on the issue name for more in-depth information on
                                that particular issue.
                                <br />
                            </div>
                        </div>
                            <div class="no-border" style="margin-bottom:10px;margin-top:10px">                                
                                 <asp:Button ID="btnSetting" runat="server" Text="Settings" CssClass="btn btn-default" PostBackUrl="~/usertrackmyhealth_bodymeasurement_settings.aspx" />
                                 <asp:Button ID="Button2" runat="server" Text="Back to Track my health" CssClass="btn btn-default" PostBackUrl="~/usertrackmyhealth.aspx" />
                            </div>                
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
