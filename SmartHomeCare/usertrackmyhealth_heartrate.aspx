<%@ Page Title="Heart Rate" Language="C#" MasterPageFile="~/siteuser.master" EnableEventValidation="false" AutoEventWireup="true" CodeFile="usertrackmyhealth_heartrate.aspx.cs" Inherits="usertrackmyhealth_heartrate" %>

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
    
   
    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                   <a href="usertrackmyhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>  »
             
                    <asp:LinkButton ID="lblinks" runat="server" onclick="lblinks_Click">Heart Rate Monitoring</asp:LinkButton>
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
         <div id="print">
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
                                
                                Config="AAEAAAD/////AQAAAAAAAAAMAgAAAFJUZWVDaGFydCwgVmVyc2lvbj00LjEuMjAxMy4xMTA4NiwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj05YzgxMjYyNzZjNzdiZGI3DAMAAABRU3lzdGVtLkRyYXdpbmcsIFZlcnNpb249NC4wLjAuMCwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj1iMDNmNWY3ZjExZDUwYTNhBQEAAAAVU3RlZW1hLlRlZUNoYXJ0LkNoYXJ0YQAAAA4uWm9vbS5BbmltYXRlZBIuWm9vbS5Vc2VOYXRpdmVQZW4QLkN1c3RvbUNoYXJ0UmVjdBMuUGFuZWwuTWFyZ2luQm90dG9tFC5QYW5lbC5TaGFkb3cuSGVpZ2h0Ey5QYW5lbC5TaGFkb3cuV2lkdGggLlBhbmVsLkJydXNoLkdyYWRpZW50LlNpZ21hRm9jdXMgLlBhbmVsLkJydXNoLkdyYWRpZW50LlNpZ21hU2NhbGUhLkxlZ2VuZC5CcnVzaC5HcmFkaWVudC5TaWdtYUZvY3VzIS5MZWdlbmQuQnJ1c2guR3JhZGllbnQuU2lnbWFTY2FsZSEuTGVnZW5kLkJydXNoLkdyYWRpZW50LlN0YXJ0Q29sb3IiLkxlZ2VuZC5CcnVzaC5HcmFkaWVudC5NaWRkbGVDb2xvch8uTGVnZW5kLkJydXNoLkdyYWRpZW50LkVuZENvbG9yDS5IZWFkZXIuTGluZXMVLkhlYWRlci5TaGFkb3cuSGVpZ2h0FC5IZWFkZXIuU2hhZG93LldpZHRoIS5IZWFkZXIuQnJ1c2guR3JhZGllbnQuU2lnbWFGb2N1cyEuSGVhZGVyLkJydXNoLkdyYWRpZW50LlNpZ21hU2NhbGUhLkhlYWRlci5CcnVzaC5HcmFkaWVudC5TdGFydENvbG9yIi5IZWFkZXIuQnJ1c2guR3JhZGllbnQuTWlkZGxlQ29sb3IfLkhlYWRlci5CcnVzaC5HcmFkaWVudC5FbmRDb2xvchkuQXNwZWN0LkNvbG9yUGFsZXR0ZUluZGV4EC5Bc3BlY3QuSGVpZ2h0M0QPLkFzcGVjdC5XaWR0aDNEDi5Bc3BlY3QuVmlldzNEB1Rvb2xzLjAYLlRvb2xzLjAuVmlld1NlZ21lbnRTaXplFC5Ub29scy4wLk1vdXNlQWN0aW9uFi5Ub29scy4wLlN0YXJ0UG9zaXRpb24ZLlRvb2xzLjAuU2VnbWVudFZpZXdVbml0cxwuVG9vbHMuMC5BdHRyaWJ1dGVzLkRyYWdab29tHy5Ub29scy4wLkF0dHJpYnV0ZXMuQ2FudmFzSW5kZXgeLlRvb2xzLjAuQXR0cmlidXRlcy5GaWxsVHJhbnNwHC5Ub29scy4wLkF0dHJpYnV0ZXMuSW1hZ2VTdHIjLlRvb2xzLjAuQXR0cmlidXRlcy5Ob0NsaWNrUG9zdGJhY2sYLlRvb2xzLjAuWm9vbUNhbnZhc0luZGV4HS5Ub29scy4wLlpvb21GaWxsVHJhbnNwYXJlbmN5FS5Ub29scy4wLlpvb21QZW5Db2xvchguVG9vbHMuMC5DdXN0b21WYXJpYWJsZXMlLldhbGxzLkxlZnQuQnJ1c2guR3JhZGllbnQuU2lnbWFGb2N1cyUuV2FsbHMuTGVmdC5CcnVzaC5HcmFkaWVudC5TaWdtYVNjYWxlJS5XYWxscy5MZWZ0LkJydXNoLkdyYWRpZW50LlN0YXJ0Q29sb3ImLldhbGxzLkxlZnQuQnJ1c2guR3JhZGllbnQuTWlkZGxlQ29sb3IjLldhbGxzLkxlZnQuQnJ1c2guR3JhZGllbnQuRW5kQ29sb3ImLldhbGxzLlJpZ2h0LkJydXNoLkdyYWRpZW50LlNpZ21hRm9jdXMmLldhbGxzLlJpZ2h0LkJydXNoLkdyYWRpZW50LlNpZ21hU2NhbGUmLldhbGxzLlJpZ2h0LkJydXNoLkdyYWRpZW50LlN0YXJ0Q29sb3InLldhbGxzLlJpZ2h0LkJydXNoLkdyYWRpZW50Lk1pZGRsZUNvbG9yJC5XYWxscy5SaWdodC5CcnVzaC5HcmFkaWVudC5FbmRDb2xvchguV2FsbHMuUmlnaHQuQnJ1c2guQ29sb3ImLldhbGxzLkJhY2suQnJ1c2guR3JhZGllbnQuTWlkZGxlQ29sb3InLldhbGxzLkJvdHRvbS5CcnVzaC5HcmFkaWVudC5TaWdtYUZvY3VzJy5XYWxscy5Cb3R0b20uQnJ1c2guR3JhZGllbnQuU2lnbWFTY2FsZScuV2FsbHMuQm90dG9tLkJydXNoLkdyYWRpZW50LlN0YXJ0Q29sb3IoLldhbGxzLkJvdHRvbS5CcnVzaC5HcmFkaWVudC5NaWRkbGVDb2xvciUuV2FsbHMuQm90dG9tLkJydXNoLkdyYWRpZW50LkVuZENvbG9yEi5BeGVzLk51bUZpeGVkQXhlcxMuQXhlcy5MZWZ0LklHYXBTaXplFC5BeGVzLkxlZnQuSVN0YXJ0UG9zEi5BeGVzLkxlZnQuSUVuZFBvcxQuQXhlcy5MZWZ0LklBeGlzU2l6ZRYuQXhlcy5MZWZ0LklzRGVwdGhBeGlzHS5BeGVzLkxlZnQuVGlja3NJbm5lci5WaXNpYmxlEi5BeGVzLlRvcC5JR2FwU2l6ZRMuQXhlcy5Ub3AuSVN0YXJ0UG9zES5BeGVzLlRvcC5JRW5kUG9zEy5BeGVzLlRvcC5JQXhpc1NpemUVLkF4ZXMuVG9wLklzRGVwdGhBeGlzHC5BeGVzLlRvcC5UaWNrc0lubmVyLlZpc2libGUULkF4ZXMuUmlnaHQuSUdhcFNpemUVLkF4ZXMuUmlnaHQuSVN0YXJ0UG9zEy5BeGVzLlJpZ2h0LklFbmRQb3MVLkF4ZXMuUmlnaHQuSUF4aXNTaXplFy5BeGVzLlJpZ2h0LklzRGVwdGhBeGlzHi5BeGVzLlJpZ2h0LlRpY2tzSW5uZXIuVmlzaWJsZRUuQXhlcy5Cb3R0b20uSUdhcFNpemUWLkF4ZXMuQm90dG9tLklTdGFydFBvcxQuQXhlcy5Cb3R0b20uSUVuZFBvcxYuQXhlcy5Cb3R0b20uSUF4aXNTaXplGC5BeGVzLkJvdHRvbS5Jc0RlcHRoQXhpcyIuQXhlcy5Cb3R0b20uTGFiZWxzLkRhdGVUaW1lRm9ybWF0Hy5BeGVzLkJvdHRvbS5UaWNrc0lubmVyLlZpc2libGUYLkF4ZXMuQm90dG9tLlRpdGxlLkFuZ2xlHS5BeGVzLkJvdHRvbS5SZWxhdGl2ZVBvc2l0aW9uGi5BeGVzLkJvdHRvbS5Qb3NpdGlvblVuaXRzFy5BeGVzLkRlcHRoVG9wLklHYXBTaXplGC5BeGVzLkRlcHRoVG9wLklTdGFydFBvcxYuQXhlcy5EZXB0aFRvcC5JRW5kUG9zGC5BeGVzLkRlcHRoVG9wLklBeGlzU2l6ZRouQXhlcy5EZXB0aFRvcC5Jc0RlcHRoQXhpcyEuQXhlcy5EZXB0aFRvcC5UaWNrc0lubmVyLlZpc2libGUULkF4ZXMuRGVwdGguSUdhcFNpemUVLkF4ZXMuRGVwdGguSVN0YXJ0UG9zEy5BeGVzLkRlcHRoLklFbmRQb3MVLkF4ZXMuRGVwdGguSUF4aXNTaXplFy5BeGVzLkRlcHRoLklzRGVwdGhBeGlzHi5BeGVzLkRlcHRoLlRpY2tzSW5uZXIuVmlzaWJsZQAAAAAAAAAAAAAEBAQGAAAAAAQEBAAAAAABAAQABAAAAAEAAAAEAQAABAQEAAAEBAQEBAAABAQEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAQAAAAAAAAAAAAAAAABAQEGCAgLCwsLFFN5c3RlbS5EcmF3aW5nLkNvbG9yAwAAABRTeXN0ZW0uRHJhd2luZy5Db2xvcgMAAAAUU3lzdGVtLkRyYXdpbmcuQ29sb3IDAAAACAgLCxRTeXN0ZW0uRHJhd2luZy5Db2xvcgMAAAAUU3lzdGVtLkRyYXdpbmcuQ29sb3IDAAAAFFN5c3RlbS5EcmF3aW5nLkNvbG9yAwAAAAgICAEIJ1N0ZWVtYS5UZWVDaGFydC5Ub29scy5TY3JvbGxNb3VzZUFjdGlvbgIAAAAIKFN0ZWVtYS5UZWVDaGFydC5Ub29scy5TY3JvbGxUb29sVmlld1VuaXQCAAAAAQgIAQgIFFN5c3RlbS5EcmF3aW5nLkNvbG9yAwAAAAsLFFN5c3RlbS5EcmF3aW5nLkNvbG9yAwAAABRTeXN0ZW0uRHJhd2luZy5Db2xvcgMAAAAUU3lzdGVtLkRyYXdpbmcuQ29sb3IDAAAACwsUU3lzdGVtLkRyYXdpbmcuQ29sb3IDAAAAFFN5c3RlbS5EcmF3aW5nLkNvbG9yAwAAABRTeXN0ZW0uRHJhd2luZy5Db2xvcgMAAAAUU3lzdGVtLkRyYXdpbmcuQ29sb3IDAAAAFFN5c3RlbS5EcmF3aW5nLkNvbG9yAwAAAAsLFFN5c3RlbS5EcmF3aW5nLkNvbG9yAwAAABRTeXN0ZW0uRHJhd2luZy5Db2xvcgMAAAAUU3lzdGVtLkRyYXdpbmcuQ29sb3IDAAAACAgICAgBAQgICAgBAQgICAgBAQgICAgBAQgGHVN0ZWVtYS5UZWVDaGFydC5Qb3NpdGlvblVuaXRzAgAAAAgICAgBAQgICAgBAQIAAAABAQAAAAAAAAAgQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAX8////FFN5c3RlbS5EcmF3aW5nLkNvbG9yBAAAAARuYW1lBXZhbHVlCmtub3duQ29sb3IFc3RhdGUBAAAACQcHAwAAAAr/////AAAAAAAAAgAB+/////z///8KAAAAAAAAAAAAAAIAAfr////8////CgD///8AAAAAAAACAAkHAAAAAAAAAAAAAAAAAAAAAAAAAAH4/////P///wr/////AAAAAAAAAgAB9/////z///8KAAAAAAAAAAAAAAIAAfb////8////CgD///8AAAAAAAACAAAAAAAAAAAAAAAAAAAGCwAAACBTdGVlbWEuVGVlQ2hhcnQuVG9vbHMuU2Nyb2xsVG9vbBQAAAAF9P///ydTdGVlbWEuVGVlQ2hhcnQuVG9vbHMuU2Nyb2xsTW91c2VBY3Rpb24BAAAAB3ZhbHVlX18ACAIAAAABAAAAAQAAAAXz////KFN0ZWVtYS5UZWVDaGFydC5Ub29scy5TY3JvbGxUb29sVmlld1VuaXQBAAAAB3ZhbHVlX18ACAIAAAAAAAAAAAAAAAAAAAAABg4AAAAAAPMBAAAeAAAAAfH////8////CgAAAAAAAAAAjQABAAkOAAAAAAAAAAAAAAAB8P////z///8K/////wAAAAAAAAIAAe/////8////CgAAAAAAAAAAAAACAAHu/////P///woA////AAAAAAAAAgAAAAAAAAAAAAHt/////P///wr/////AAAAAAAAAgAB7P////z///8KAAAAAAAAAAAAAAIAAev////8////CgD///8AAAAAAAACAAHq/////P///wrAwMD/AAAAAAAAAgAB6f////z///8KAAAAAAAAAAAAAAIAAAAAAAAAAAAB6P////z///8K/////wAAAAAAAAIAAef////8////CgAAAAAAAAAAAAACAAHm/////P///woA////AAAAAAAAAgAGAAAAAAAAADsAAABbAQAAIAEAAAABAAAAABwAAACgAgAAhAIAAAABAAAAADsAAABbAQAAIAEAAAABAAAAABwAAACgAgAAhAIAAAAGGwAAAApNTS9kZC95eXl5AS0AAAAAAAAAAAAwwAXk////HVN0ZWVtYS5UZWVDaGFydC5Qb3NpdGlvblVuaXRzAQAAAAd2YWx1ZV9fAAgCAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAABAQAAAAAAAAAAAAAAAAAAAAABAREHAAAAAQAAAAkOAAAACw==" 
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
                                                                <div class="ColumnData" style="height: <%# PercentColumnMeanHR(Eval("MeanHR").ToString()) %>" title='<%# Eval("MeanHR") %>'></div>
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 50px;"  align="center">
                                                            <td class="Obese" >
                                                                <div class="ColumnData" style="height: <%# PercentColumnStdHR(Eval("StdHR").ToString()) %>" title='<%# Eval("StdHR") %>'></div>
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 50px;"  align="center">
                                                            <td class="Obese">
                                                                <div class="ColumnData" style="height: <%# PercentColumnMeanRR(Eval("MeanRR").ToString()) %>" title='<%# Eval("MeanRR") %>'></div>
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 50px;"  align="center">
                                                            <td class="Obese" >
                                                                <div class="ColumnData" style="height: <%# PercentColumnSDNN(Eval("SDNN").ToString()) %>" title='<%# Eval("SDNN") %>'></div>
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 50px;"  align="center">
                                                            <td class="Obese" >
                                                                <div class="ColumnData" style="height: <%# PercentColumnRMSSD(Eval("RMSSD").ToString()) %>" title='<%# Eval("RMSSD") %>'></div>
                                                            </td>
                                                        </tr>
                                                        <tr style="height: 50px;"  align="center">
                                                            <td class="Obese" >
                                                                <div class="ColumnData" style="height: <%# PercentColumnpNN50(Eval("pNN50").ToString()) %>" title='<%# Eval("pNN50") %>'></div>
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
                        </asp:Panel>
                        <div align="center">
                        <asp:Panel ID="pnEmptyData" runat="server" CssClass="panel_empty_data">
                            <asp:Label ID="lbDataEmpty" runat="server" Text="You have no data to graph!"
                                ForeColor="Red"></asp:Label></asp:Panel></div>
                        <div align="center"><asp:LinkButton ID="lbtnDateTime" runat="server" 
                                Font-Underline="False" onclick="lbtnDateTime_Click">DateTime</asp:LinkButton></div>
                        </div>
                    <asp:Panel ID="date_graph" CssClass="datetime_filter" runat="server" Visible="False">
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
                    </div><!-- Item -->
            </asp:View>
            <asp:View ID="ViewTable" runat="server">
             <asp:UpdatePanel ID="UpdateTable" runat="server">
                <ContentTemplate>
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
                      Text="DateTime" onclick="lbDateTable_Click" ></asp:LinkButton>
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
                                        ShowHeader="False" AllowPaging="true">
                                        <Columns>
                                            <asp:BoundField DataField="ReceivedDate" 
                                                DataFormatString="{0:MM/dd/yyyy HH:mm:ss}">
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
                                <div class="footer_grv">
                                    <table>
                                        <tr>
                                            <td style="width:26px;text-align:left">
                                                <asp:ImageButton ID="btnback" runat="server" Height="26px" 
                                                    ImageUrl="~/resources/images/Previous-icon.png" OnClick="back_Click" 
                                                    Width="26px" />
                                            </td>
                                            <td style="text-align:center">
                                                 <!-- add new -->
                                                <asp:Label ID="Label1" runat="server" Text="Records to display on 1 page: "></asp:Label>
                                                <asp:DropDownList ID="ddl_number" runat="server" AutoPostBack="True" 
                                                    onselectedindexchanged="ddl_number_SelectedIndexChanged">
                                                    <asp:ListItem Value="0">(All)</asp:ListItem>
                                                    <asp:ListItem Value="10">10</asp:ListItem>
                                                    <asp:ListItem Value="25">25</asp:ListItem>
                                                    <asp:ListItem Value="50">50</asp:ListItem>
                                                    <asp:ListItem Value="100">100</asp:ListItem>
                                                    <asp:ListItem Value="250">250</asp:ListItem>
                                                    <asp:ListItem Value="500">500</asp:ListItem>
                                                </asp:DropDownList>
                                                <!-- end add new -->
                                                Page :
                                                <asp:TextBox ID="txtpage" runat="server" AutoPostBack="True" 
                                                    ontextchanged="txtpage_TextChanged" Width="15px" onkeypress="return ValidateKeypress(/\d/,event);"></asp:TextBox>
                                                <asp:Label ID="lb_pager" runat="server" Text="1"></asp:Label>
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
                                 PageSize="100" ShowHeader="False" AllowPaging="true">
                                <Columns>
                                    <asp:BoundField DataField="ReceivedDate" DataFormatString="{0:MM/dd/yyyy HH:mm:ss}">
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
                        <div class="footer_grv">
                            <table>
                                <tr>
                                    <td style="width:26px;text-align:left">
                                        <asp:ImageButton ID="btn_back1" runat="server" Height="26px" 
                                            ImageUrl="~/resources/images/Previous-icon.png" Width="26px" 
                                            onclick="btn_back1_Click"/>
                                    </td>
                                    <td style="text-align:center">
                                         <!-- add new -->
                                                <asp:Label ID="Label2" runat="server" Text="Records to display on 1 page: "></asp:Label>
                                                <asp:DropDownList ID="ddlNo2" runat="server" AutoPostBack="True" 
                                             onselectedindexchanged="ddlNo2_SelectedIndexChanged" >
                                                    <asp:ListItem Value="0">(All)</asp:ListItem>
                                                    <asp:ListItem Value="10">10</asp:ListItem>
                                                    <asp:ListItem Value="25">25</asp:ListItem>
                                                    <asp:ListItem Value="50">50</asp:ListItem>
                                                    <asp:ListItem Value="100">100</asp:ListItem>
                                                    <asp:ListItem Value="250">250</asp:ListItem>
                                                    <asp:ListItem Value="500">500</asp:ListItem>
                                                </asp:DropDownList>
                                           <!-- end add new -->
                                        Page : 
                                        <asp:TextBox ID="txt_page2" runat="server" AutoPostBack="True" 
                                             Width="15px" ontextchanged="txt_page2_TextChanged" onkeypress="return ValidateKeypress(/\d/,event);"></asp:TextBox>
                                        <asp:Label ID="lbpage2" runat="server" Text="/1"></asp:Label>
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
                 </ContentTemplate>
            </asp:UpdatePanel>
            </asp:View>
        </asp:MultiView>
    
</div><!-- print--> 

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
                        PostBackUrl="~/usertrackmyhealth_heartrate_settings.aspx" /></td>
                <td><asp:Button ID="Button2" runat="server" Text="Back to Track my health" 
                        PostBackUrl="~/usertrackmyhealth.aspx" /></td>
            </tr>
        </table>
    </div>
 <asp:UpdateProgress ID="UpadateProc" AssociatedUpdatePanelID="UpdateTable" runat="server">
     <ProgressTemplate>
             <div class="loading">
                <img src="resources/images/process.gif" alt="" />
            </div>
    </ProgressTemplate>
</asp:UpdateProgress>
</asp:Content>

