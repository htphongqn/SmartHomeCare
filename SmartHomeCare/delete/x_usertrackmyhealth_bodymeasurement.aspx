<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true"
    CodeFile="x_usertrackmyhealth_bodymeasurement.aspx.cs" Inherits="usertrackmyhealth_bodymeasurement" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head1" runat="Server">
    <link href="styles/tab.css" rel="stylesheet" type="text/css" />
    <link href="styles/control.css" rel="stylesheet" type="text/css" />
    <link href="styles/BodyMeasurement.css" rel="stylesheet" type="text/css" />

    <style type="text/css">
        .style1
        {
            width: 71px;
        }
        .style2
        {
            width: 50px;
        }
        .style3
        {
            width: 45px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" runat="Server">
    <div id="print">
        
        <div class="floatleft title">
            Track
            <asp:Label ID="lbNameHealth" runat="server" Text="My"></asp:Label>
            &nbsp;Health<br />
            Body Measurement</div>
        <div class="floatright">
            <asp:LinkButton runat="server" CssClass="clprint" ID="lb" Text="Print" OnClientClick="return printDiv('print');"> </asp:LinkButton>&nbsp;<a
                href="userhelp.aspx" target="_blank">Help</a>
        </div>
        <div class="clear"></div>
        <div style="padding-top:10px;">
            <asp:Button ID="btnGraph2" runat="server" OnClick="btnGraph2_Click" Text="Graph" />
            <asp:Button ID="btnTable2" runat="server" OnClick="btnTable2_Click" Text="Table" />
        </div>
        <asp:MultiView ID="MultiViewBody" runat="server">
            <asp:View ID="ViewGraph" runat="server">
                <div id="chart" align="center">
                    <asp:Chart ID="ChartBodyMeasurement" runat="server" AntiAliasing="Text" BorderlineWidth="3"
                        Width="500px" Visible="False">
                        <Series>
                            <asp:Series ChartArea="ChartAreaTemperature" Name="SeriesTemp">
                                <Points>
                                    <asp:DataPoint Color="255, 192, 128" YValues="1.2" />
                                    <asp:DataPoint Color="255, 128, 128" YValues="1.2" />
                                </Points>
                            </asp:Series>
                            <asp:Series ChartArea="ChartAreaTemperature" Name="Series1" XValueMember="CreatedDate"
                                YAxisType="Secondary" YValueMembers="MetaAge">
                            </asp:Series>
                        </Series>
                        <ChartAreas>
                            <asp:ChartArea Name="ChartAreaTemperature" BorderColor="Transparent" BorderWidth="0">
                                <AxisY IsLabelAutoFit="False">
                                    <LabelStyle ForeColor="Transparent" />
                                </AxisY>
                                <AxisX IsLabelAutoFit="False">
                                    <LabelStyle Angle="-45" Format="MM/dd/yyyy" />
                                    <ScaleBreakStyle LineDashStyle="NotSet" />
                                </AxisX>
                                <AxisX2>
                                    <LabelStyle Format="yyyy-MM-dd HH:mm" />
                                </AxisX2>
                                <AxisY2 Title="asd">
                                </AxisY2>
                                <Position Height="100" Width="95" Auto="False" X="4" />
                            </asp:ChartArea>
                        </ChartAreas>
                        <Titles>
                            <asp:Title Alignment="BottomLeft" DockedToChartArea="ChartAreaTemperature" Docking="Left"
                                Name="BMI" Text="BMI">
                                <Position Height="4.48369551" Width="10" X="4" Y="6" Auto="False" />
                            </asp:Title>
                            <asp:Title Alignment="BottomLeft" DockedToChartArea="ChartAreaTemperature" Name="WHR"
                                Text="WHR">
                                <Position Height="4.48369551" Width="90" X="4" Y="18" Auto="False" />
                            </asp:Title>
                            <asp:Title Alignment="BottomLeft" DockedToChartArea="ChartAreaTemperature" Name="BMR"
                                Text="BMR">
                                <Position Height="4.48369551" Width="90" X="4" Y="32" Auto="False" />
                            </asp:Title>
                            <asp:Title Alignment="BottomLeft" DockedToChartArea="ChartAreaTemperature" Name="BF%"
                                Text="BF%">
                                <Position Height="4.48369551" Width="90" X="4" Y="45" Auto="False" />
                            </asp:Title>
                            <asp:Title Alignment="TopLeft" DockedToChartArea="ChartAreaTemperature" Name="Ideal weight"
                                Text="Ideal weight">
                                <Position Height="4.48369551" Width="94" Y="59" Auto="False" />
                            </asp:Title>
                            <asp:Title Alignment="BottomLeft" DockedToChartArea="ChartAreaTemperature" Name="Metabolic age"
                                Text="Metabolic age">
                                <Position Height="4.48369551" Width="94" Y="72" Auto="False" />
                            </asp:Title>
                        </Titles>
                        <BorderSkin BorderColor="Transparent" BorderWidth="0" />
                    </asp:Chart>
                    <br />
                    <asp:Panel ID="pnChart" runat="server">
                        <table >
                            <tr>
                                <td valign="top">
                                    <table style="width:100px;">
                                        <tr><td class="TitleChart">BMI</td></tr>
                                        <tr><td class="TitleChart">WHR</td></tr>
                                        <tr><td class="TitleChart">BMR</td></tr>
                                        <tr><td class="TitleChart">BF%</td></tr>
                                        <tr><td class="TitleChart">Ideal weight</td></tr>
                                        <tr><td class="TitleChart">Metabolic age</td></tr>                                                     
                                    </table>
                                </td>
                                <td style="overflow: hidden;" valign="top">
                                    <div class="Chart">
                                        <asp:DataList ID="dtlChart" runat="server" RepeatDirection="Horizontal">
                                            <ItemTemplate>
                                                <table cellspacing = "5">
                                                    <tr style="height:25px;">
                                                        <td class="Obese" style="background-color: <%# Eval("BMI_Color") %>">
                                                        </td>
                                                    </tr>
                                                    <tr style="height:25px;">
                                                        <td class="Healthy" style="background-color: <%# Eval("WHR_Color") %>">
                                                        </td>
                                                    </tr>
                                                    <tr style="height:25px;">
                                                        <td class="UnderOverWeight" style="background-color: <%# Eval("BMR_Color") %>">
                                                        </td>
                                                    </tr>
                                                    <tr style="height:25px;">
                                                        <td class="Obese" style="background-color: <%# Eval("BFPercent_Color") %>">
                                                        </td>
                                                    </tr>
                                                    <tr style="height:25px;">
                                                        <td class="Healthy" style="background-color: <%# Eval("IW_Color") %>">
                                                        </td>
                                                    </tr>
                                                    <tr style="height:25px;">
                                                        <td class="UnderOverWeight" style="background-color: <%# Eval("MetaAge_Color") %>">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:Label ID="lblDate" CssClass="LabelTitle" runat="server" Text='<%# Bind("CreatedDate", "{0:MM/dd/yy}") %>'></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </ItemTemplate>
                                        </asp:DataList>
                                    </div>
                                </td>
                            </tr>
                        </table>
                                    
                        <br />
                    </asp:Panel>
                    <asp:LinkButton ID="lbtnDateTime" runat="server" Font-Underline="False">DateTime</asp:LinkButton>
                    &nbsp;<asp:Label ID="lbDataEmpty" runat="server" Text="You have no data to graph!"
                        Visible="False" ForeColor="Red" CssClass="emptydata"></asp:Label>
                    <asp:ModalPopupExtender ID="MPE" runat="server" TargetControlID="lbtnDateTime" PopupControlID="Panel1"
                        DropShadow="True" PopupDragHandleControlID="Panel2" DynamicServicePath="" CancelControlID="btnCancel"
                        Enabled="True">
                    </asp:ModalPopupExtender>
                    <asp:Panel ID="Panel1" CssClass="PanelDateTime" runat="server">
                        <div>
                            <asp:Panel ID="Panel2" CssClass="TitlePanelDateTime" runat="server">
                                Select Date To Draw Chart
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
                                        <asp:CalendarExtender ID="txtFromDate_CalendarExtender" runat="server" CssClass="orange"
                                            Enabled="True" TargetControlID="txtFromDate">
                                        </asp:CalendarExtender>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtToDate" runat="server"></asp:TextBox>
                                        <asp:CalendarExtender ID="txtToDate_CalendarExtender" runat="server" CssClass="orange"
                                            Enabled="True" TargetControlID="txtToDate">
                                        </asp:CalendarExtender>
                                    </td>
                                </tr>
                                <tr align="center">
                                    <td colspan="2">
                                        <asp:Button ID="btnOk" runat="server" Text="View" OnClick="btnOk_Click" />
                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" />
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </asp:Panel>
                </div>
            </asp:View>
            <asp:View ID="ViewTable" runat="server">
            <div style="float:left;  margin-right:5px">
                    <table style="border-collapse:collapse">
                             <tr>
                                    <td>
                                        <table class="body_table_">
                                            <tr>
                                                <th style="width:79px;background:#f3f3f3" >
                                                                
                                                </th>
                                                </tr>
                                                <tr>
                                                <td class="style1">
                                                    <asp:LinkButton ID="lbDateTable" runat="server" Text="DateTime"  Font-Size="X-Small"></asp:LinkButton>
                                                </td>
                                                </tr>
                                            </table>

                                    </td>
                                    <td>
                                        <table class="body_table_">
                                            <tr>
                                                            
                                                <th style="width:140px">
                                                    Value
                                                </th>
                                                <th style="width:200px">
                                                    Diagnose
                                                </th>
                                            </tr>
                                            <tr>
                                                            
                                                <td class="style2">
                                                    <asp:Label ID="lbDate1" runat="server" Text="null"></asp:Label>
                                                    </td>
                                                <td class="style3">
                                                    ...
                                                </td>
                                            </tr>
                                        </table><!-- Title 1 -->
                                    </td><!-- data 1-->
                                    <td>
                                        <table  class="body_table_">
                                            <tr>
                                                            
                                                <th style="width:140px">
                                                    Value
                                                </th>
                                                <th style="width:200px">
                                                    Diagnose
                                                </th>
                                            </tr>
                                            <tr>
                                                            
                                                <td>
                                                    <asp:Label ID="lbDate2" runat="server" Text="null"></asp:Label>
                                                    </td>
                                                <td>
                                                    ...
                                                </td>
                                            </tr>
                                        </table><!-- Title 1 -->
                                    </td>
                                </tr>
                                <tr><!-- Data -->
                                    <td style="vertical-align:top">
                                        <table class="body_table_">
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
                                    </td>
                                    <td style="vertical-align:top">
                                        <asp:GridView ID="grvBody" runat="server" AutoGenerateColumns="False" 
                                        ShowHeader="False" CssClass="body_table_">
                                            <Columns>
                                                <asp:BoundField HeaderText="Value" DataField="Value">
                                                    <ItemStyle HorizontalAlign="Center" Width="143px" />
                                                </asp:BoundField>
                                                <asp:BoundField HeaderText="Diagnose" DataField="Diagnose">
                                                    <ItemStyle HorizontalAlign="Center" Width="200px" Height="40px" />
                                                </asp:BoundField>
                                            </Columns>
                                        </asp:GridView>
                                    </td><!--1 -->
                                    <td style="vertical-align:top">
                                            <asp:GridView ID="grvBody2" runat="server" AutoGenerateColumns="False" 
                                                ShowHeader="False" CssClass="body_table_">
                                                    <Columns>
                                    
                                                        <asp:BoundField HeaderText="Value" DataField="Value">
                                                            <ItemStyle HorizontalAlign="Center" Width="143px" />
                                                        </asp:BoundField>
                                                        <asp:BoundField HeaderText="Diagnose" DataField="Diagnose">
                                                            <ItemStyle HorizontalAlign="Center" Width="200px" Height="40px" />
                                                        </asp:BoundField>
                                                    </Columns>
                                                </asp:GridView>
                                    </td><!-- 2 -->
                                </tr>
                            </table>
                                        
                            <div style="clear:both">
                                <asp:Button ID="btn_back" runat="server" Text="Back" onclick="btn_back_Click" />
                                <asp:Button ID="btnNext" runat="server" Text="Next" onclick="btnNext_Click" />
                            </div>
                    </div>
                    <div class="clear">
                        <asp:Label ID="lbEmpty" runat="server" ForeColor="#FF3300" Text="Data Empty"></asp:Label>
                    </div>
                    
                <!-- Popup -->
                <asp:ModalPopupExtender ID="mdpTable" TargetControlID="lbDateTable" runat="server"
                    CancelControlID="btncancelTable" PopupControlID="popup" PopupDragHandleControlID="headerpop"
                    Drag="True" DropShadow="True" DynamicServicePath="" Enabled="True">
                </asp:ModalPopupExtender>
                <asp:Panel ID="popup" CssClass="PanelDateTime" runat="server">
                    <div>
                        <asp:Panel ID="headerpop" CssClass="TitlePanelDateTime" runat="server">
                            Select Date To Draw Chart
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
                                    <asp:CalendarExtender ID="clFrom" runat="server" CssClass="orange" TargetControlID="txtFromDateTable"
                                        Enabled="True">
                                    </asp:CalendarExtender>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtToDateTable" runat="server"></asp:TextBox>
                                    <asp:CalendarExtender ID="clTo" runat="server" CssClass="orange" TargetControlID="txtToDateTable"
                                        Enabled="True">
                                    </asp:CalendarExtender>
                                </td>
                            </tr>
                            <tr align="center">
                                <td colspan="2">
                                    <asp:Button ID="btnView" runat="server" Text="View" OnClick="btnView_Click" />
                                    <asp:Button ID="btncancelTable" runat="server" Text="Cancel" />
                                </td>
                            </tr>
                        </table>
                    </div>
                    <div class="clear"></div>
                </asp:Panel>
                <!-- End popup -->
            </asp:View>
        </asp:MultiView>
        
    </div>
    <!-- print-->
    <br />
    <div class="clear">
        <div class="title">
            Diagnosis & Recommendations</div>
        <div class="borderbottom">
            This page displays your current mediacal issues and the date that they were noded
            in your medical record. Click on the issue name for more in-depth information on
            that particular issue.
            <br />
        </div>
    </div>
    <div class="clear">
        <br />
        <table class="clear" width="200">
            <tr>
                <td>
                    <asp:Button ID="btnSetting" runat="server" Text="Settings" PostBackUrl="~/usertrackmyhealth_bodymeasurement_settings.aspx" />
                </td>
                <td>
                    <asp:Button ID="Button2" runat="server" Text="Back to Track my health" PostBackUrl="~/usertrackmyhealth.aspx" />
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
