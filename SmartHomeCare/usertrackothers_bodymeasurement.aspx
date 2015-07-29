<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackothers_bodymeasurement.aspx.cs" Inherits="usertrackothers_bodymeasurement" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <link href="styles/tab.css" rel="stylesheet" type="text/css" />
    <link href="styles/control.css" rel="stylesheet" type="text/css" />
    <link href="styles/BodyMeasurement.css" rel="stylesheet" type="text/css" />
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
                    <a href="usertrackotherhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a> 
                » <a href="usertrackothers_bodymeasurement.aspx"> Body measurement monitoring</a>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            
                            <div id="print">
                                Select GRAPH or TABLE buttons to see Body measurement monitoring Report.
                                <div style="padding-top:10px;">
                                    <asp:Button ID="btnGraph2" runat="server" OnClick="btnGraph2_Click" Text="Graph" CssClass="btn btn-default" />
                                    <asp:Button ID="btnTable2" runat="server" OnClick="btnTable2_Click" Text="Table" CssClass="btn btn-default" />
                                </div>
                                <asp:MultiView ID="MultiViewBody" runat="server" ActiveViewIndex="0">
                                    <asp:View ID="ViewGraph" runat="server">
                                        <div class="item_report_body">
                                            <div id="chart" align="center">
                                            <asp:Chart ID="ChartBodyMeasurement" runat="server" AntiAliasing="Text" BorderlineWidth="3"
                                                Width="500px" Visible="False">
                                                <Series>
                                                    <asp:Series ChartArea="ChartAreaBMI" Name="SeriesBMI">
                                                        <Points>
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                        </Points>
                                                    </asp:Series>
                                                    <asp:Series ChartArea="ChartAreaWHR" Name="SeriesWHR">
                                                        <Points>
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                        </Points>
                                                    </asp:Series>
                                                    <asp:Series ChartArea="ChartAreaBMR" Name="SeriesBMR">
                                                        <Points>
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                        </Points>
                                                    </asp:Series>
                                                    <asp:Series ChartArea="ChartAreaBF" Name="SeriesBF">
                                                        <Points>
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                        </Points>
                                                    </asp:Series>
                                                    <asp:Series ChartArea="ChartAreaIdeal" Name="SeriesIdeal">
                                                        <Points>
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                        </Points>
                                                    </asp:Series>
                                                    <asp:Series ChartArea="ChartAreaMeta" Name="SeriesMeta">
                                                        <Points>
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                            <asp:DataPoint YValues="1" />
                                                        </Points>
                                                    </asp:Series>
                                                </Series>
                                                <ChartAreas>
                                                    <asp:ChartArea Name="ChartAreaBMI">
                                                        <AxisY>
                                                            <LabelStyle ForeColor="Transparent" />
                                                            <MajorGrid Enabled="False" />
                                                        </AxisY>
                                                        <AxisX>
                                                            <LabelStyle Enabled="False" />
                                                            <MajorGrid Enabled="False" />
                                                        </AxisX>
                                                        <Position Height="30" Width="100" Y="5" />
                                                        <InnerPlotPosition Height="35" Width="80" X="15" />
                                                    </asp:ChartArea>
                                                    <asp:ChartArea Name="ChartAreaWHR">
                                                        <AxisY>
                                                            <LabelStyle Enabled="False" ForeColor="Transparent" />
                                                            <MajorGrid Enabled="False" />
                                                        </AxisY>
                                                        <AxisX>
                                                            <LabelStyle Enabled="False" />
                                                            <MajorGrid Enabled="False" />
                                                        </AxisX>
                                                        <Position Height="30" Width="100" Y="20" />
                                                        <InnerPlotPosition Height="35" Width="80" X="15" />
                                                    </asp:ChartArea>
                                                    <asp:ChartArea Name="ChartAreaBMR">
                                                        <AxisY>
                                                            <LabelStyle Enabled="False" />
                                                            <MajorGrid Enabled="False" />
                                                        </AxisY>
                                                        <AxisX>
                                                            <LabelStyle Enabled="False" />
                                                            <MajorGrid Enabled="False" />
                                                        </AxisX>
                                                        <Position Height="30" Width="100" Y="35" />
                                                        <InnerPlotPosition Height="35" Width="80" X="15" />
                                                    </asp:ChartArea>
                                                    <asp:ChartArea Name="ChartAreaBF">
                                                        <AxisY>
                                                            <LabelStyle Enabled="False" />
                                                            <MajorGrid Enabled="False" />
                                                        </AxisY>
                                                        <AxisX>
                                                            <LabelStyle Enabled="False" />
                                                            <MajorGrid Enabled="False" />
                                                        </AxisX>
                                                        <Position Height="30" Width="100" Y="50" />
                                                        <InnerPlotPosition Height="35" Width="80" X="15" />
                                                    </asp:ChartArea>
                                                    <asp:ChartArea Name="ChartAreaIdeal">
                                                        <AxisY>
                                                            <LabelStyle Enabled="False" />
                                                            <MajorGrid Enabled="False" />
                                                        </AxisY>
                                                        <AxisX>
                                                            <LabelStyle Enabled="False" />
                                                            <MajorGrid Enabled="False" />
                                                        </AxisX>
                                                        <Position Height="15" Width="100" Y="65" />
                                                        <InnerPlotPosition Height="80" Width="80" X="15" />
                                                    </asp:ChartArea>
                                                    <asp:ChartArea Name="ChartAreaMeta">
                                                        <AxisY>
                                                            <LabelStyle Enabled="False" />
                                                            <MajorGrid Enabled="False" />
                                                        </AxisY>
                                                        <AxisX>
                                                            <LabelStyle Enabled="False" />
                                                            <MajorGrid Enabled="False" />
                                                        </AxisX>
                                                        <Position Height="15" Width="100" Y="80" />
                                                        <InnerPlotPosition Height="80" Width="80" X="15" />
                                                    </asp:ChartArea>
                                                </ChartAreas>
                                                <Titles>
                                                    <asp:Title Alignment="BottomLeft" DockedToChartArea="ChartAreaBMI" Docking="Left"
                                                        Name="BMI" Text="BMI">
                                                        <Position Height="4.48369551" Width="10" X="4" Y="8" Auto="False" />
                                                    </asp:Title>
                                                    <asp:Title Alignment="BottomLeft" DockedToChartArea="ChartAreaBMI" Name="WHR"
                                                        Text="WHR">
                                                        <Position Height="4.48369551" Width="90" X="4" Y="23" Auto="False" />
                                                    </asp:Title>
                                                    <asp:Title Alignment="BottomLeft" DockedToChartArea="ChartAreaBMI" Name="BMR"
                                                        Text="BMR">
                                                        <Position Height="4.48369551" Width="90" X="4" Y="38" Auto="False" />
                                                    </asp:Title>
                                                    <asp:Title Alignment="BottomLeft" DockedToChartArea="ChartAreaBMI" Name="BF%"
                                                        Text="BF%">
                                                        <Position Height="4.48369551" Width="90" X="4" Y="53" Auto="False" />
                                                    </asp:Title>
                                                    <asp:Title Alignment="TopLeft" DockedToChartArea="ChartAreaBMI" Name="Ideal weight"
                                                        Text="Ideal weight">
                                                        <Position Height="4.48369551" Width="94" Y="68" Auto="False" />
                                                    </asp:Title>
                                                    <asp:Title Alignment="BottomLeft" DockedToChartArea="ChartAreaBMI" Name="Metabolic age"
                                                        Text="Metabolic age">
                                                        <Position Height="4.48369551" Width="94" Y="83" Auto="False" />
                                                    </asp:Title>
                                                </Titles>
                                                <BorderSkin BorderColor="Transparent" BorderWidth="0" />
                                            </asp:Chart>
                                            <br />
                                            <asp:Panel ID="pnChart" runat="server" Visible="False">
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
                                                <asp:Panel ID="pnEmptyData" runat="server" CssClass="panel_empty_data_body">
                                                    <asp:Label ID="lbDataEmpty" runat="server" Text="You have no data to graph!" ForeColor="Red"></asp:Label>
                                                </asp:Panel>
                                            <asp:LinkButton ID="lbtnDateTime" runat="server" Font-Underline="False" 
                                                    onclick="lbtnDateTime_Click">DateTime</asp:LinkButton>       
                                            <asp:Panel ID="datetime_graph" CssClass="datetime_filter_graph" runat="server">
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
                                                                <asp:TextBox ID="txtFromDate" runat="server" Width="140"></asp:TextBox>
                                                                <asp:CalendarExtender
                                                                    ID="txtFromDate_CalendarExtender" runat="server" Enabled="True"
                                                                    TargetControlID="txtFromDate" CssClass="orange">
                                                                </asp:CalendarExtender>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtToDate" runat="server" Width="140"></asp:TextBox>
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
                                    <div class="clear">
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
                                            <asp:Panel ID="div_popup" CssClass="datetime_filter_top" runat="server">
                                                <div>
                                                    <asp:Panel ID="div_header_popup" CssClass="TitlePanelDateTime" runat="server">
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
                                        
                                                                <asp:CalendarExtender ID="txtFromDateTable_CalendarExtender" runat="server" 
                                                                    Enabled="True" TargetControlID="txtFromDateTable" CssClass="orange">
                                                                </asp:CalendarExtender>
                                        
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtToDateTable" runat="server"></asp:TextBox>
                                       
                                                                <asp:CalendarExtender ID="txtToDateTable_CalendarExtender" runat="server" 
                                                                    Enabled="True" TargetControlID="txtToDateTable" CssClass="orange">
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
                                            </div><!--clear -->
                                            <div class="clear"></div>
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
                                <asp:Button ID="btnSetting" runat="server" Text="Settings"  CssClass="btn btn-default"
                        PostBackUrl="~/usertrackothers_bodymeasurement_settings.aspx" />
                                <asp:Button ID="Button2" runat="server" Text="Back to Track others health"  CssClass="btn btn-default"
                        PostBackUrl="~/usertrackotherhealth.aspx" />
                            </div>                
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>        
           
</asp:Content>



