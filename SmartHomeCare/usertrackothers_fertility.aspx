﻿<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackothers_fertility.aspx.cs" Inherits="usertrackothers_fertility" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <link href="styles/tab.css" rel="stylesheet" type="text/css" />
    <link href="styles/control.css" rel="stylesheet" type="text/css" />
    <link href="styles/fertility.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#userhelp').click(function (e) {
                window.open('userhelp.aspx', 'User Help', 500, 500);
            });
        });
    </script>
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
                    » <a href="usertrackothers_fertility.aspx">  Fertility monitoring</a>
                    <div class="floatright">
                        <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                    </div>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6" style="width:100%;">
                            <div id="print">
                             Select GRAPH or TABLE buttons to see Fertility monitoring Report.
                             <div style="padding-top:10px;">
                                    <asp:Button ID="btnGraph2" runat="server" OnClick="btnGraph2_Click" Text="Graph" CssClass="btn btn-default" style="color:#000;"/>
                                    <asp:Button ID="btnTable2" runat="server" OnClick="btnTable2_Click" Text="Table" CssClass="btn btn-default" style="color:#000;"/>
                             </div>
                            <asp:MultiView ID="MultiViewFertility" runat="server" ActiveViewIndex="0">
                                <asp:View ID="ViewGraph" runat="server">
                                    <div class="item_report">
                                        <div id="chart" align="center">
                                            <br />
                                            <asp:Panel ID="pnChart" runat="server">
                                                <div>
                                                    <asp:Chart ID="ChartFertility" runat="server" Height="250px" Width="400px">
                                                        <Series>
                                                            <asp:Series ChartArea="ChartAreaFertility" ChartType="Line" Color="Red" 
                                                                Name="SeriesTemperature" XValueMember="ReceivedDate" YValueMembers="Skin">
                                                            </asp:Series>
                                                        </Series>
                                                        <ChartAreas>
                                                            <asp:ChartArea Name="ChartAreaFertility">
                                                                <AxisY Title="Temperature" Maximum="120" Minimum="20">
                                                                    <MajorGrid Enabled="False" />
                                                                </AxisY>
                                                                <AxisX>
                                                                    <MajorGrid LineDashStyle="Dot" />
                                                                    <LabelStyle Enabled="False" />
                                                                </AxisX>
                                                            </asp:ChartArea>
                                                        </ChartAreas>
                                                        <BorderSkin SkinStyle="Raised" />
                                                    </asp:Chart>
                                                </div>
                                                <div align="center" style="margin-left:55px;">
                                                    <table style="width:320px;">
                                                        <tr>
                                                            <td>
                                                                <asp:LinkButton ID="lbtnPrevWeek" runat="server" onclick="lbtnPrevWeek_Click" 
                                                                    Font-Overline="False">&lt;&lt;</asp:LinkButton>
                                                            </td>
                                                            <td>
                                                                <div align="center">
                                                                    <asp:DataList ID="dtlDaysInMonth" runat="server" RepeatColumns="6" RepeatDirection="Horizontal"
                                                                        Width="250px">
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                                                                        <ItemTemplate>
                                                                            <div class="DaysInMonth">
                                                                                <%# Eval("Value") %></div>
                                                                        </ItemTemplate>
                                                                    </asp:DataList></div>
                                                            </td>
                                                            <td>
                                                                <asp:LinkButton ID="lbtnNextWeek" runat="server" onclick="lbtnNextWeek_Click" 
                                                                    Font-Overline="False">&gt;&gt;</asp:LinkButton>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                                <div style="margin-left:55px;">
                                                    <asp:LinkButton ID="lbtnPrevMonth" runat="server" Font-Overline="False" OnClick="lbtnPrevMonth_Click">&lt;&lt;</asp:LinkButton>
                                                    <asp:Label ID="lblMonthYear" runat="server" Height="20px" Text="MonthYear" Width="120px"></asp:Label>
                                                    <asp:LinkButton ID="lbtnNextMonth" runat="server" Font-Overline="False" OnClick="lbtnNextMonth_Click">&gt;&gt;</asp:LinkButton>
                                                </div>
                                                <br />
                                            </asp:Panel>
                                        </div>
                                    </div><!-- item -->
                                </asp:View>
                                <asp:View ID="ViewTable" runat="server">
                                <div class="item_report">
                                    <div class="fertility">
                                        <div class="dates_fertility">
                        
                        
                       
                                            <table>
                                                <tr>
                                                    <td style="width:100px"></td>
                                                    <td style="width:25px">
                                                        <asp:LinkButton ID="lbBack" runat="server" onclick="lbBack_Click" CssClass="text_underline_none"><<</asp:LinkButton>
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbdate" runat="server" Text=""></asp:Label>
                                                    </td>
                                                    <td style="width:25px">
                                                        <asp:LinkButton ID="lbNext" runat="server" onclick="lbNext_Click" CssClass="text_underline_none">>></asp:LinkButton>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div><!-- date -->
                                        <div class="contents_fertility">
                                            <div class="tops_fertility">
                                            <div class="border_fertility">
                                                <div class="titles_fertility">
                                                <table >
                                                     <tr>
                                                            <th>Fertility</th>
                                   
                                                     </tr>
                                                        <tr>
                                                            <td>Start of period</td>
                                 
                                                        </tr>
                                                        <tr>
                                                            <td>Ovulation date</td>
                                   
                                                        </tr>
                                                        <tr>
                                                            <td>Most fertile time</td>
                                    
                                                        </tr>
                                                        <tr>
                                                            <td>Most pregnant time</td>
                                   
                                                        </tr>
                                                       </table>
                                                </div><!-- title -->
                                                <div class="datas_fertility"> 
                                                    <asp:Label ID="lb_html" runat="server" Text=""></asp:Label>
                                                </div><!-- data -->
                        
                                                <div class="clear"></div>
                                                </div><!-- border -->
                                           </div><!--top -->
                                            <div class="tops_fertility">
                                            <div class="border_fertility">
                                                <div class="titles_fertility">
                                                <table>
                                                    <tr>
                                                            <th>Advance Prediction</th>
                                    
                                                        </tr>
                                                        <tr>
                                                            <td>Start of next period</td>
                                 
                                                        </tr>
                                                        <tr>
                                                            <td>Next ovulation date</td>
                                  
                                                        </tr>
                                                        <tr>
                                                            <td>Next most fertile time</td>
                                   
                                                        </tr>
                                                        <tr>
                                                            <td>Next most pregnant time</td>
                                                        </tr>

                                                </table>
                                                </div><!-- title -->
                                                <div class="datas_fertility"> 
                                                    <asp:Label ID="lbhtml3" runat="server" Text=""></asp:Label>
                                                </div><!-- data -->
                        
                                                <div class="clear"></div>
                                                </div><!-- border -->
                                           </div><!--top -->
                                            <div class ="bottoms_fertility">
                                                <div class="border_fertility">
                                                <div class="titles_fertility">
                                                <table>
                                                     <tr>
                                                            <th>Statistics</th>
                                   
                                                     </tr>
                                                        <tr>
                                                            <td>Cycles tracked N</td>
                                 
                                                        </tr>
                                                        <tr>
                                                            <td>Average cycle length</td>
                                   
                                                        </tr>
                                                        <tr>
                                                            <td>Cycle length variation</td>
                                    
                                                        </tr>
                                                        <tr>
                                                            <td>Average ovulation time</td>
                                   
                                                        </tr>
                                                        <tr>
                                                            <td>Longest cycle</td>
                                    
                                                        </tr>
                                                        <tr>
                                                            <td>Shortest cycle</td>
                                 
                                                        </tr>
                               
                                                </table>
                                                </div><!-- title -->
                                                <div class="datas_fertility1"> 
                                                    <asp:Label ID="lb_html2" runat="server" Text=""></asp:Label>
                                                </div><!-- data -->
                                                <div class="clear"></div>
                                                </div>
                                            </div><!--bottom -->
                                        </div><!-- content -->
                                    </div><!-- fertility -->
            
                                        <asp:Panel ID="date_table" CssClass="datetime_filter" runat="server" Visible="false">
                                                <div>
                                                    <asp:Panel ID="div_header_popup" CssClass="TitlePanelDateTime" runat="server">
                                                        Select Date
                                                    </asp:Panel>
                                                </div>
                                                <div class="ContentDateTime">
                                                    <table style="width:100%">
                                                        <tr align="left">
                                                            <td>
                                                                From Date:
                                                            </td>
                                                            <td>
                                                                To Date:
                                                            </td>
                                                        </tr>
                                                        <tr align="left">
                                                            <td>
                                                                <asp:DropDownList ID="ddl_FromMonth" runat="server">
                                                                </asp:DropDownList>
                                                                /<asp:DropDownList ID="ddl_FromYear" runat="server">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:DropDownList ID="ddl_ToMonth" runat="server">
                                                                </asp:DropDownList>/
                                                                <asp:DropDownList ID="ddl_ToYear" runat="server">
                                                                </asp:DropDownList>
                                        
                                                            </td>
                                                        </tr>
                                                        <tr align="center">
                                                            <td colspan="2" align="center">
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
                        </div><!-- print-->
                            <div class="border-top-bottom">
                                <div class="title">Diagnosis & Recommendations</div>
                                <div class="">This page displays your current mediacal issues and the date that they were noded in your 
                                    medical record. Click on the issue name for more in-depth information on that particular issue.
                                </div>

                            </div>
                            <div class="no-border">
                                <asp:Button ID="Button1" runat="server" Text="Settings" CssClass="btn btn-default"
                                    PostBackUrl="~/usertrackothers_fertility_settings.aspx" />
                                <asp:Button ID="Button2" runat="server" Text="Back to Track others health" CssClass="btn btn-default"
                                    PostBackUrl="~/usertrackotherhealth.aspx" />
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

