<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackothers_heartrate.aspx.cs" Inherits="usertrackothers_heartrate" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<%@ Register assembly="TeeChart" namespace="Steema.TeeChart.Web" tagprefix="tchart" %>

<%--<%@ Register src="usercontrols/ChartHeartRate.ascx" tagname="ChartHeartRate" tagprefix="uc1" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <link href="styles/tab.css" rel="stylesheet" type="text/css" />
    <link href="styles/control.css" rel="stylesheet" type="text/css" />
    <link href="styles/HeartRate.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        function DateTime() {
            jPrompt('<u>acs</u>', '129', '222', function (r) {
                if (r) {
                    jAlert(r);
                }
                return r;
            });
        }

        function OpenDialog() {
            $("#dialog").dialog({
                close: function (event, ui) {
                    // do whatever you need on close
                }
            });
        }
    </script>
    <style type="text/css">

        .style1
        {
            width: 100%;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#userhelp').click(function (e) {
                window.open('userhelp.aspx', 'User Help', 500, 500);
            });
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    
    <div id="print">
    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                   <a href="usertrackotherhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>  » <a href="usertrackothers_heartrate.aspx">Heart Rate Monitoring</a>
                </div>
             </div>
            <div class="floatright">
                <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                <a id="userhelp" href="#"><img src="resources/images/h.png" /></a>
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
     Select GRAPH or TABLE buttons to see Heart Rate monitoring Report.
        <div style="padding-top:10px;">
            <asp:Button ID="btnGraph2" runat="server" OnClick="btnGraph2_Click" Text="Graph" />
            <asp:Button ID="btnTable2" runat="server" OnClick="btnTable2_Click" Text="Table" />
        </div>
        <asp:MultiView ID="MultiViewHeartRate" runat="server" ActiveViewIndex="0">        
            <asp:View ID="ViewGraph" runat="server">
            <div class="item_report">
                <div id="chart">
                        <div class="select_data">Report is viewed with:
                            <asp:DropDownList ID="ddlHeartRateData" runat="server" AutoPostBack="True" 
                                OnSelectedIndexChanged="HeartRateData_SelectedIndexChanged">
                                <asp:ListItem Value="0">Heart rate data</asp:ListItem>
                                <asp:ListItem Value="1">HRV Data</asp:ListItem>
                            </asp:DropDownList>
                            . Click drop-down list to select a different view.
                        </div>
                        <br />
                        <asp:Panel ID="pnHeartRateData" runat="server" Visible="False">
                            <tchart:WebChart ID="WebChartHeartRate" runat="server" AutoPostback="False" 
                                GetChartFile="GetChart.aspx" Height="400px" TempChart="Session" Width="700px"  
                                
                                Config="AAEAAAD/////AQAAAAAAAAAMAgAAAFJUZWVDaGFydCwgVmVyc2lvbj00LjEuMjAxMy4xMTA4NiwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj05YzgxMjYyNzZjNzdiZGI3DAMAAABRU3lzdGVtLkRyYXdpbmcsIFZlcnNpb249NC4wLjAuMCwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj1iMDNmNWY3ZjExZDUwYTNhBQEAAAAVU3RlZW1hLlRlZUNoYXJ0LkNoYXJ0YgAAAA4uWm9vbS5BbmltYXRlZBIuWm9vbS5Vc2VOYXRpdmVQZW4QLkN1c3RvbUNoYXJ0UmVjdBMuUGFuZWwuTWFyZ2luQm90dG9tFC5QYW5lbC5TaGFkb3cuSGVpZ2h0Ey5QYW5lbC5TaGFkb3cuV2lkdGggLlBhbmVsLkJydXNoLkdyYWRpZW50LlNpZ21hRm9jdXMgLlBhbmVsLkJydXNoLkdyYWRpZW50LlNpZ21hU2NhbGUhLkxlZ2VuZC5CcnVzaC5HcmFkaWVudC5TaWdtYUZvY3VzIS5MZWdlbmQuQnJ1c2guR3JhZGllbnQuU2lnbWFTY2FsZSEuTGVnZW5kLkJydXNoLkdyYWRpZW50LlN0YXJ0Q29sb3IiLkxlZ2VuZC5CcnVzaC5HcmFkaWVudC5NaWRkbGVDb2xvch8uTGVnZW5kLkJydXNoLkdyYWRpZW50LkVuZENvbG9yDy5MZWdlbmQuVmlzaWJsZQ0uSGVhZGVyLkxpbmVzFS5IZWFkZXIuU2hhZG93LkhlaWdodBQuSGVhZGVyLlNoYWRvdy5XaWR0aCEuSGVhZGVyLkJydXNoLkdyYWRpZW50LlNpZ21hRm9jdXMhLkhlYWRlci5CcnVzaC5HcmFkaWVudC5TaWdtYVNjYWxlIS5IZWFkZXIuQnJ1c2guR3JhZGllbnQuU3RhcnRDb2xvciIuSGVhZGVyLkJydXNoLkdyYWRpZW50Lk1pZGRsZUNvbG9yHy5IZWFkZXIuQnJ1c2guR3JhZGllbnQuRW5kQ29sb3IZLkFzcGVjdC5Db2xvclBhbGV0dGVJbmRleBAuQXNwZWN0LkhlaWdodDNEDy5Bc3BlY3QuV2lkdGgzRA4uQXNwZWN0LlZpZXczRAdUb29scy4wGC5Ub29scy4wLlZpZXdTZWdtZW50U2l6ZRQuVG9vbHMuMC5Nb3VzZUFjdGlvbhYuVG9vbHMuMC5TdGFydFBvc2l0aW9uGS5Ub29scy4wLlNlZ21lbnRWaWV3VW5pdHMcLlRvb2xzLjAuQXR0cmlidXRlcy5EcmFnWm9vbR8uVG9vbHMuMC5BdHRyaWJ1dGVzLkNhbnZhc0luZGV4Hi5Ub29scy4wLkF0dHJpYnV0ZXMuRmlsbFRyYW5zcBwuVG9vbHMuMC5BdHRyaWJ1dGVzLkltYWdlU3RyIy5Ub29scy4wLkF0dHJpYnV0ZXMuTm9DbGlja1Bvc3RiYWNrGC5Ub29scy4wLlpvb21DYW52YXNJbmRleB0uVG9vbHMuMC5ab29tRmlsbFRyYW5zcGFyZW5jeRUuVG9vbHMuMC5ab29tUGVuQ29sb3IYLlRvb2xzLjAuQ3VzdG9tVmFyaWFibGVzJS5XYWxscy5MZWZ0LkJydXNoLkdyYWRpZW50LlNpZ21hRm9jdXMlLldhbGxzLkxlZnQuQnJ1c2guR3JhZGllbnQuU2lnbWFTY2FsZSUuV2FsbHMuTGVmdC5CcnVzaC5HcmFkaWVudC5TdGFydENvbG9yJi5XYWxscy5MZWZ0LkJydXNoLkdyYWRpZW50Lk1pZGRsZUNvbG9yIy5XYWxscy5MZWZ0LkJydXNoLkdyYWRpZW50LkVuZENvbG9yJi5XYWxscy5SaWdodC5CcnVzaC5HcmFkaWVudC5TaWdtYUZvY3VzJi5XYWxscy5SaWdodC5CcnVzaC5HcmFkaWVudC5TaWdtYVNjYWxlJi5XYWxscy5SaWdodC5CcnVzaC5HcmFkaWVudC5TdGFydENvbG9yJy5XYWxscy5SaWdodC5CcnVzaC5HcmFkaWVudC5NaWRkbGVDb2xvciQuV2FsbHMuUmlnaHQuQnJ1c2guR3JhZGllbnQuRW5kQ29sb3IYLldhbGxzLlJpZ2h0LkJydXNoLkNvbG9yJi5XYWxscy5CYWNrLkJydXNoLkdyYWRpZW50Lk1pZGRsZUNvbG9yJy5XYWxscy5Cb3R0b20uQnJ1c2guR3JhZGllbnQuU2lnbWFGb2N1cycuV2FsbHMuQm90dG9tLkJydXNoLkdyYWRpZW50LlNpZ21hU2NhbGUnLldhbGxzLkJvdHRvbS5CcnVzaC5HcmFkaWVudC5TdGFydENvbG9yKC5XYWxscy5Cb3R0b20uQnJ1c2guR3JhZGllbnQuTWlkZGxlQ29sb3IlLldhbGxzLkJvdHRvbS5CcnVzaC5HcmFkaWVudC5FbmRDb2xvchIuQXhlcy5OdW1GaXhlZEF4ZXMTLkF4ZXMuTGVmdC5JR2FwU2l6ZRQuQXhlcy5MZWZ0LklTdGFydFBvcxIuQXhlcy5MZWZ0LklFbmRQb3MULkF4ZXMuTGVmdC5JQXhpc1NpemUWLkF4ZXMuTGVmdC5Jc0RlcHRoQXhpcx0uQXhlcy5MZWZ0LlRpY2tzSW5uZXIuVmlzaWJsZRIuQXhlcy5Ub3AuSUdhcFNpemUTLkF4ZXMuVG9wLklTdGFydFBvcxEuQXhlcy5Ub3AuSUVuZFBvcxMuQXhlcy5Ub3AuSUF4aXNTaXplFS5BeGVzLlRvcC5Jc0RlcHRoQXhpcxwuQXhlcy5Ub3AuVGlja3NJbm5lci5WaXNpYmxlFC5BeGVzLlJpZ2h0LklHYXBTaXplFS5BeGVzLlJpZ2h0LklTdGFydFBvcxMuQXhlcy5SaWdodC5JRW5kUG9zFS5BeGVzLlJpZ2h0LklBeGlzU2l6ZRcuQXhlcy5SaWdodC5Jc0RlcHRoQXhpcx4uQXhlcy5SaWdodC5UaWNrc0lubmVyLlZpc2libGUVLkF4ZXMuQm90dG9tLklHYXBTaXplFi5BeGVzLkJvdHRvbS5JU3RhcnRQb3MULkF4ZXMuQm90dG9tLklFbmRQb3MWLkF4ZXMuQm90dG9tLklBeGlzU2l6ZRguQXhlcy5Cb3R0b20uSXNEZXB0aEF4aXMiLkF4ZXMuQm90dG9tLkxhYmVscy5EYXRlVGltZUZvcm1hdB8uQXhlcy5Cb3R0b20uVGlja3NJbm5lci5WaXNpYmxlGC5BeGVzLkJvdHRvbS5UaXRsZS5BbmdsZR0uQXhlcy5Cb3R0b20uUmVsYXRpdmVQb3NpdGlvbhouQXhlcy5Cb3R0b20uUG9zaXRpb25Vbml0cxcuQXhlcy5EZXB0aFRvcC5JR2FwU2l6ZRguQXhlcy5EZXB0aFRvcC5JU3RhcnRQb3MWLkF4ZXMuRGVwdGhUb3AuSUVuZFBvcxguQXhlcy5EZXB0aFRvcC5JQXhpc1NpemUaLkF4ZXMuRGVwdGhUb3AuSXNEZXB0aEF4aXMhLkF4ZXMuRGVwdGhUb3AuVGlja3NJbm5lci5WaXNpYmxlFC5BeGVzLkRlcHRoLklHYXBTaXplFS5BeGVzLkRlcHRoLklTdGFydFBvcxMuQXhlcy5EZXB0aC5JRW5kUG9zFS5BeGVzLkRlcHRoLklBeGlzU2l6ZRcuQXhlcy5EZXB0aC5Jc0RlcHRoQXhpcx4uQXhlcy5EZXB0aC5UaWNrc0lubmVyLlZpc2libGUAAAAAAAAAAAAABAQEAAYAAAAABAQEAAAAAAEABAAEAAAAAQAAAAQBAAAEBAQAAAQEBAQEAAAEBAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAABAAAAAAAAAAAAAAAAAEBAQYICAsLCwsUU3lzdGVtLkRyYXdpbmcuQ29sb3IDAAAAFFN5c3RlbS5EcmF3aW5nLkNvbG9yAwAAABRTeXN0ZW0uRHJhd2luZy5Db2xvcgMAAAABCAgLCxRTeXN0ZW0uRHJhd2luZy5Db2xvcgMAAAAUU3lzdGVtLkRyYXdpbmcuQ29sb3IDAAAAFFN5c3RlbS5EcmF3aW5nLkNvbG9yAwAAAAgICAEIJ1N0ZWVtYS5UZWVDaGFydC5Ub29scy5TY3JvbGxNb3VzZUFjdGlvbgIAAAAIKFN0ZWVtYS5UZWVDaGFydC5Ub29scy5TY3JvbGxUb29sVmlld1VuaXQCAAAAAQgIAQgIFFN5c3RlbS5EcmF3aW5nLkNvbG9yAwAAAAsLFFN5c3RlbS5EcmF3aW5nLkNvbG9yAwAAABRTeXN0ZW0uRHJhd2luZy5Db2xvcgMAAAAUU3lzdGVtLkRyYXdpbmcuQ29sb3IDAAAACwsUU3lzdGVtLkRyYXdpbmcuQ29sb3IDAAAAFFN5c3RlbS5EcmF3aW5nLkNvbG9yAwAAABRTeXN0ZW0uRHJhd2luZy5Db2xvcgMAAAAUU3lzdGVtLkRyYXdpbmcuQ29sb3IDAAAAFFN5c3RlbS5EcmF3aW5nLkNvbG9yAwAAAAsLFFN5c3RlbS5EcmF3aW5nLkNvbG9yAwAAABRTeXN0ZW0uRHJhd2luZy5Db2xvcgMAAAAUU3lzdGVtLkRyYXdpbmcuQ29sb3IDAAAACAgICAgBAQgICAgBAQgICAgBAQgICAgBAQgGHVN0ZWVtYS5UZWVDaGFydC5Qb3NpdGlvblVuaXRzAgAAAAgICAgBAQgICAgBAQIAAAABAQAAAAAAAAAgQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAX8////FFN5c3RlbS5EcmF3aW5nLkNvbG9yBAAAAARuYW1lBXZhbHVlCmtub3duQ29sb3IFc3RhdGUBAAAACQcHAwAAAAr/////AAAAAAAAAgAB+/////z///8KAAAAAAAAAAAAAAIAAfr////8////CgD///8AAAAAAAACAAAJBwAAAAAAAAAAAAAAAAAAAAAAAAAB+P////z///8K/////wAAAAAAAAIAAff////8////CgAAAAAAAAAAAAACAAH2/////P///woA////AAAAAAAAAgAAAAAAAAAAAAAAAAAABgsAAAAgU3RlZW1hLlRlZUNoYXJ0LlRvb2xzLlNjcm9sbFRvb2wUAAAABfT///8nU3RlZW1hLlRlZUNoYXJ0LlRvb2xzLlNjcm9sbE1vdXNlQWN0aW9uAQAAAAd2YWx1ZV9fAAgCAAAAAQAAAAEAAAAF8////yhTdGVlbWEuVGVlQ2hhcnQuVG9vbHMuU2Nyb2xsVG9vbFZpZXdVbml0AQAAAAd2YWx1ZV9fAAgCAAAAAAAAAAAAAAAAAAAAAAYOAAAAAADzAQAAHgAAAAHx/////P///woAAAAAAAAAAI0AAQAJDgAAAAAAAAAAAAAAAfD////8////Cv////8AAAAAAAACAAHv/////P///woAAAAAAAAAAAAAAgAB7v////z///8KAP///wAAAAAAAAIAAAAAAAAAAAAB7f////z///8K/////wAAAAAAAAIAAez////8////CgAAAAAAAAAAAAACAAHr/////P///woA////AAAAAAAAAgAB6v////z///8KwMDA/wAAAAAAAAIAAen////8////CgAAAAAAAAAAAAACAAAAAAAAAAAAAej////8////Cv////8AAAAAAAACAAHn/////P///woAAAAAAAAAAAAAAgAB5v////z///8KAP///wAAAAAAAAIABgAAAAAAAAA7AAAAWwEAACABAAAAAQAAAAAcAAAAoAIAAIQCAAAAAQAAAAA7AAAAWwEAACABAAAAAQAAAAAcAAAAoAIAAIQCAAAABhsAAAAKTU0vZGQveXl5eQEtAAAAAAAAAAAAMMAF5P///x1TdGVlbWEuVGVlQ2hhcnQuUG9zaXRpb25Vbml0cwEAAAAHdmFsdWVfXwAIAgAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAQEAAAAAAAAAAAAAAAAAAAAAAQERBwAAAAEAAAAJDgAAAAs=" 
                                onafterdraw="WebChartHeartRate_AfterDraw" 
                                onclickaxis="WebChartHeartRate_ClickAxis" 
                                onclickseries="WebChartHeartRate_ClickSeries" />
                        </asp:Panel>
                        <asp:Panel ID="pnHRVData" runat="server" Visible="False">
                            <table>
                                <tr>
                                    <td valign="top">
                                        <table cellpadding="1px" cellspacing="0px" style="width: 100px; border-right:1px solid;">
                                            <tr>
                                                <td class="TitleChart">
                                                    <div class="ColumnHeader"> Mean HR </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="TitleChart">
                                                    <div class="ColumnHeader"> Std HR </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="TitleChart">
                                                    <div class="ColumnHeader"> Mean RR </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="TitleChart">
                                                    <div class="ColumnHeader"> SDNN </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="TitleChart">
                                                    <div class="ColumnHeader"> RMSSD </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td class="TitleChart">
                                                    <div class="ColumnHeader"> pNN50 </div>
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                    <td style="overflow: hidden;" valign="top">
                                        <div class="Chart">
                                            <asp:DataList ID="dtlChart" CssClass="DatalistChart" runat="server" RepeatDirection="Horizontal">
                                                <ItemTemplate>
                                                    <table cellpadding="1px" cellspacing="0px">
                                                        <tr style="height: 50px;" align="center">
                                                            <td class="Obese" >
                                                                <div class="ColumnData" style="height: <%# PercentColumnMeanHR(Eval("MeanHR").ToString()) %>"></div>
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 50px;"  align="center">
                                                            <td class="Obese" >
                                                                <div class="ColumnData" style="height: <%# PercentColumnStdHR(Eval("StdHR").ToString()) %>"></div>
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 50px;"  align="center">
                                                            <td class="Obese">
                                                                <div class="ColumnData" style="height: <%# PercentColumnMeanRR(Eval("MeanRR").ToString()) %>"></div>
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 50px;"  align="center">
                                                            <td class="Obese" >
                                                                <div class="ColumnData" style="height: <%# PercentColumnSDNN(Eval("SDNN").ToString()) %>"></div>
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 50px;"  align="center">
                                                            <td class="Obese" >
                                                                <div class="ColumnData" style="height: <%# PercentColumnRMSSD(Eval("RMSSD").ToString()) %>"></div>
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 50px;"  align="center">
                                                            <td class="Obese" >
                                                                <div class="ColumnData" style="height: <%# PercentColumnpNN50(Eval("pNN50").ToString()) %>"></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <asp:Label ID="lblDate" runat="server" CssClass="LabelTitle" Text='<%# Bind("ReceivedDate", "{0:MM/dd/yy}") %>'></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                            <hr />
                                        </div>
                                    </td>
                                </tr>
                            </table>
                            <br />
                        </asp:Panel>
                        <div align="center">
                        <asp:Panel ID="pnEmptyData" runat="server" CssClass="panel_empty_data">
                            <asp:Label ID="lbDataEmpty" runat="server" Text="You have no data to graph!"
                                ForeColor="Red"></asp:Label></asp:Panel></div>
                        <div align="center"><asp:LinkButton ID="lbtnDateTime" runat="server" 
                                Font-Underline="False" onclick="lbtnDateTime_Click">DateTime</asp:LinkButton></div>
                        </div>
                    <%--<asp:ModalPopupExtender ID="MPE" runat="server" 
                    TargetControlID="lbtnDateTime" PopupControlID="Panel1"
                        DropShadow="True" PopupDragHandleControlID="Panel2" DynamicServicePath="" 
                        CancelControlID="btnCancel" BackgroundCssClass="modalBackground" 
                    Drag="True" RepositionMode="None">
                    </asp:ModalPopupExtender>--%>
                    
                    <asp:Panel ID="date_graph" CssClass="datetime_filter" runat="server">
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
                    </div><!-- Item -->
            </asp:View>
            <asp:View ID="ViewTable" runat="server">
             
              <div class="item_report">
                <div class="select_data">
                    Report is viewed with:
                    <asp:DropDownList ID="ddl" runat="server" CssClass="dropdown" AutoPostBack="True"
                        OnSelectedIndexChanged="ddl_SelectedIndexChanged">
                        <asp:ListItem Value="0">Heart rate data</asp:ListItem>
                        <asp:ListItem Value="1">HRV data</asp:ListItem>
                    </asp:DropDownList>
                    . Click drop-down list to select a different view.
                </div>
                <asp:LinkButton ID="lbDateTable" CssClass="lbPopupDate" runat="server" 
                      Text="DateTime" onclick="lbDateTable_Click"
                    ></asp:LinkButton>
               <%-- <asp:ModalPopupExtender ID="MPE2" runat="server" TargetControlID="lbDateTable" PopupControlID="Panel3"
                    DropShadow="True" PopupDragHandleControlID="Panel4" DynamicServicePath="" CancelControlID="btnCancel2"
                    Enabled="True" Drag="True" X="-1" Y="-1" BackgroundCssClass="modalBackground">
                </asp:ModalPopupExtender>--%>
                <asp:UpdatePanel ID="UpdateTable" runat="server">
                <ContentTemplate>
                    <asp:Panel ID="table_item" runat="server" CssClass="table_item">
                       <div class="title_grv">
                                    <table>
                                        <tr>
                                            <td style="width:150px;">
                                                
                                            </td>
                                            <td style="width:80px;">
                                                HR
                                            </td>
                                            <td style="width:120px;">
                                                Resting HR
                                            </td>
                                            <td style="width:120px;">
                                                HRV
                                            </td>
                                            
                                            <td style="width:200px;">
                                                Diagn
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <!-- Title -->
                                <div class="content_grv" style="height:390px">
                                    <asp:GridView ID="grvTable" runat="server" 
                                        AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
                                        BorderStyle="None" BorderWidth="1px" CellPadding="3" 
                                        EmptyDataText="There is no record to show !" PageSize="100" 
                                        ShowHeader="False">
                                        <Columns>
                                            <asp:BoundField DataField="ReceivedDate" 
                                                DataFormatString="{0:MM/dd/yyyy hh:mm:ss}">
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="HR" HeaderText="HR">
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="RestHR" HeaderText="Resting HR">
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="120px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Voltage" HeaderText="HRV">
                                            <ItemStyle HorizontalAlign="Center" Width="120px" />
                                            </asp:BoundField>
                                            <asp:BoundField DataField="Diagnosis" HeaderText="Diagn">
                                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="200px" />
                                            </asp:BoundField>
                                        </Columns>
                                        <FooterStyle BackColor="White" ForeColor="#000066" />
                                        <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                                        <PagerSettings Visible="False" />
                                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                                        <RowStyle CssClass="record" ForeColor="#000066" />
                                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                                        <SortedAscendingHeaderStyle BackColor="#007DBB" />
                                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                                        <SortedDescendingHeaderStyle BackColor="#00547E" />
                                    </asp:GridView>
                                </div>
                                <!-- table -->
                                <div class="footer_grv" style="visibility:hidden">
                                    <table>
                                        <tr>
                                            <td style="width:26px;text-align:left">
                                                <asp:ImageButton ID="btnback" runat="server" Height="26px" 
                                                    ImageUrl="~/resources/images/Previous-icon.png" OnClick="back_Click" 
                                                    Width="26px" />
                                            </td>
                                            <td style="width:60%;text-align:center">
                                                Page :
                                                <asp:TextBox ID="txtpage" runat="server" AutoPostBack="True" 
                                                    ontextchanged="txtpage_TextChanged" Width="15px" onkeypress="return ValidateKeypress(/\d/,event);"></asp:TextBox>
                                                <asp:Label ID="lb_pager" runat="server" Text="Page: 1/10"></asp:Label>
                                            </td>
                                            <td style="width:26px;text-align:right">
                                                <asp:ImageButton ID="btnnext" runat="server" Height="26px" 
                                                    ImageUrl="~/resources/images/next.jpg" OnClick="next_Click" Width="26px" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <!-- footer -->

                        
                    </asp:Panel>
                    <asp:Panel ID="table_item2" runat="server" CssClass="table_item" 
                    Visible="False">
                    
                        <div class="title_grv">
                            <table>
                                <tr>
                                    <td style="width:170px;">
                                       
                                    </td>
                                    <td style="width:80px;">
                                        MeanHR
                                    </td>
                                    <td style="width:80px;">
                                        Std HR
                                    </td>
                                    <td style="width:80px;">
                                        MeanRR
                                    </td>
                                    <td style="width:80px;">
                                        SDNN
                                    <td style="width:80px;">
                                        RMSSD
                                    </td>
                                    <td style="width:80px;">
                                        PNN50
                                    </td>
                                    <td style="width:230px;">
                                        Diagn
                                    </td>
                    
                                </tr>
                            </table>
                        </div><!-- Title -->
                        <div class="content_grv" style="height:390px">
                            <asp:GridView ID="grvHVRData" runat="server" AutoGenerateColumns="False"
                                EmptyDataText=" There is no record to show !" OnPageIndexChanging="grvHVRData_PageIndexChanging"
                                 PageSize="100" ShowHeader="False">
                                <Columns>
                                    <asp:BoundField DataField="ReceivedDate" DataFormatString="{0:MM/dd/yyyy hh:mm:ss}">
                                        <ItemStyle HorizontalAlign="Center" Width="150px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="MeanHR" HeaderText="MeanHR" >
                                    <ItemStyle Width="80px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="StdHR" HeaderText="Std HR" >
                                    <ItemStyle Width="80px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="MeanRR" HeaderText="MeanRR" >
                                    <HeaderStyle Width="80px" />
                                    <ItemStyle Width="80px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="SDNN" HeaderText="SDNN" >
                                    <ItemStyle Width="80px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="RMSSD" HeaderText="RMSSD" >
                                    <ItemStyle Width="80px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="PNN50" HeaderText="PNN50" >
                                    <ItemStyle Width="80px" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="Diagnosis" HeaderText="Diagnosis" >
                                    <ItemStyle Width="230px" />
                                    </asp:BoundField>
                                </Columns>
                                <PagerSettings Visible="False" />
                            </asp:GridView>
                        </div><!-- table -->
                        <div class="footer_grv" style="visibility:hidden">
                            <table>
                                <tr>
                                    <td style="width:26px;text-align:left">
                                        <asp:ImageButton ID="btn_back1" runat="server" Height="26px" 
                                            ImageUrl="~/resources/images/Previous-icon.png" Width="26px" 
                                            onclick="btn_back1_Click"/>
                                    </td>
                                    <td style="width:60%;text-align:center">
                                        Page : 
                                        <asp:TextBox ID="txt_page2" runat="server" AutoPostBack="True" 
                                             Width="15px" ontextchanged="txt_page2_TextChanged" onkeypress="return ValidateKeypress(/\d/,event);"></asp:TextBox>
                                        <asp:Label ID="lbpage2" runat="server" Text="/10"></asp:Label>
                                    </td>
                                    <td style="width:26px;text-align:right">
                                        <asp:ImageButton ID="btn_next2" runat="server" Height="26px" 
                                            ImageUrl="~/resources/images/next.jpg" Width="26px" 
                                            onclick="btn_next2_Click"  />
                                    </td>
                                </tr>
                            </table>
                        </div><!-- footer -->
                        
                    </asp:Panel><!-- table item -->
                    </ContentTemplate>
                    </asp:UpdatePanel>
                 
                <asp:Panel ID="date_table" CssClass="datetime_filter" runat="server" 
                    Visible="False">
                    <div>
                        <asp:Panel ID="Panel4" CssClass="TitlePanelDateTime" runat="server">
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
                                <td>
                                    &nbsp;
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:TextBox ID="txtFromDate2" runat="server"></asp:TextBox>
                                    <asp:CalendarExtender ID="txtFromDate_CalendarExtender2" runat="server" Enabled="True"
                                        TargetControlID="txtFromDate2" CssClass="orange">
                                    </asp:CalendarExtender>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtToDate2" runat="server"></asp:TextBox>
                                    <asp:CalendarExtender ID="txtToDate_CalendarExtender2" runat="server" Enabled="True"
                                        TargetControlID="txtToDate2" CssClass="orange">
                                    </asp:CalendarExtender>
                                </td>
                                <td>
                                   
                                </td>
                            </tr>
                            <tr align="center">
                                <td colspan="3">
                                    <asp:Button ID="btnOk2" runat="server" Text="Select" OnClick="btnOk2_Click" />
                                    <asp:Button ID="btnCancel2" runat="server" Text="Cancel" 
                                        onclick="btnCancel2_Click" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:Panel>
                
                   
                </div><!-- end item report-->
            </asp:View>
        </asp:MultiView>
    <br />
</div><!-- print-->
     

    <br />
    <div class="border-top-bottom">
        <div class="title">Diagnosis & Recommendations</div>
        <div class="">This page displays your current mediacal issues and the date that they were noded in your 
            medical record. Click on the issue name for more in-depth information on that particular issue.
        </div>

    </div>

    <div class="no-border"  style="padding-bottom:10px">

        <br />
        <table class="clear" width="200">
            <tr>
                <td><asp:Button ID="Button1" runat="server" Text="Settings" 
                        PostBackUrl="~/usertrackothers_heartrate_settings.aspx" /></td>
                <td><asp:Button ID="Button2" runat="server" Text="Back to Track others health" 
                        PostBackUrl="~/usertrackotherhealth.aspx" /></td>
            </tr>
        </table>
    </div>
 <asp:UpdateProgress ID="UpadateProc" AssociatedUpdatePanelID="UpdateTable" runat="server">
            <ProgressTemplate>
                    <div class="loading">
                <img src="resources/images/process.gif" />
            </div>
    </ProgressTemplate>
</asp:UpdateProgress>
</asp:Content>

