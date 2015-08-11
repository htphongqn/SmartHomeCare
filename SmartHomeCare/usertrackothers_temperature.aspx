<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true"
    CodeFile="usertrackothers_temperature.aspx.cs" Inherits="usertrackothers_temperature" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="TeeChart" Namespace="Steema.TeeChart.Web" TagPrefix="tchart" %>

<%@ Register Assembly="DevExpress.XtraCharts.v12.1.Web, Version=12.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>
<%@ Register assembly="DevExpress.XtraCharts.v12.1, Version=12.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraCharts" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" runat="Server">
    <link href="styles/tab.css" rel="stylesheet" type="text/css" />
    <link href="styles/control.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#userhelp').click(function (e) {
                window.open('userhelp.aspx', 'User Help', 500, 500);
            });
        });
    </script>
    </script>
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
                    <a href="usertrackothers.aspx">Track
                    <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label>
                    health </a>» <a href="usertrackothers_temperature.aspx">Temperature monitoring</a>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <!-- border bottom -->
                            Select GRAPH or TABLE buttons to see Temperature monitoring Report.
                            <div style="padding-top: 10px;">
                                <asp:Button ID="btnGraph2" runat="server" OnClick="btnGraph2_Click" Text="Graph" CssClass="btn btn-default" />
                                <asp:Button ID="btnTable2" runat="server" OnClick="btnTable2_Click" Text="Table" CssClass="btn btn-default" />
                            </div>
                            <div id="print">
                                <asp:MultiView ID="MultiViewTemperature" runat="server" ActiveViewIndex="0">
                                    <asp:View ID="ViewGraph" runat="server">
                                        <div class="item_report">
                                            <div id="chart">
                                                <asp:Panel ID="pnChart" runat="server" Visible="False">
                                                    <%--<tchart:WebChart ID="ChartTemperature" runat="server" AutoPostback="False" Config="AAEAAAD/////AQAAAAAAAAAMAgAAAFJUZWVDaGFydCwgVmVyc2lvbj00LjEuMjAxMy4xMTA4NiwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj05YzgxMjYyNzZjNzdiZGI3DAMAAABRU3lzdGVtLkRyYXdpbmcsIFZlcnNpb249NC4wLjAuMCwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj1iMDNmNWY3ZjExZDUwYTNhBQEAAAAVU3RlZW1hLlRlZUNoYXJ0LkNoYXJ0OQAAABAuQ3VzdG9tQ2hhcnRSZWN0Ey5QYW5lbC5NYXJnaW5Cb3R0b20PLkxlZ2VuZC5WaXNpYmxlDS5IZWFkZXIuTGluZXMZLkFzcGVjdC5Db2xvclBhbGV0dGVJbmRleBAuQXNwZWN0LkhlaWdodDNEDy5Bc3BlY3QuV2lkdGgzRA4uQXNwZWN0LlZpZXczRAdUb29scy4wGC5Ub29scy4wLlZpZXdTZWdtZW50U2l6ZRQuVG9vbHMuMC5Nb3VzZUFjdGlvbhYuVG9vbHMuMC5TdGFydFBvc2l0aW9uGS5Ub29scy4wLlNlZ21lbnRWaWV3VW5pdHMcLlRvb2xzLjAuQXR0cmlidXRlcy5EcmFnWm9vbR8uVG9vbHMuMC5BdHRyaWJ1dGVzLkNhbnZhc0luZGV4Hi5Ub29scy4wLkF0dHJpYnV0ZXMuRmlsbFRyYW5zcBwuVG9vbHMuMC5BdHRyaWJ1dGVzLkltYWdlU3RyIy5Ub29scy4wLkF0dHJpYnV0ZXMuTm9DbGlja1Bvc3RiYWNrGC5Ub29scy4wLlpvb21DYW52YXNJbmRleB0uVG9vbHMuMC5ab29tRmlsbFRyYW5zcGFyZW5jeRUuVG9vbHMuMC5ab29tUGVuQ29sb3IYLlRvb2xzLjAuQ3VzdG9tVmFyaWFibGVzEi5BeGVzLk51bUZpeGVkQXhlcxMuQXhlcy5MZWZ0LklHYXBTaXplFC5BeGVzLkxlZnQuSVN0YXJ0UG9zEi5BeGVzLkxlZnQuSUVuZFBvcxQuQXhlcy5MZWZ0LklBeGlzU2l6ZRYuQXhlcy5MZWZ0LklzRGVwdGhBeGlzGC5BeGVzLkxlZnQuVGl0bGUuQ2FwdGlvbhYuQXhlcy5MZWZ0LlRpdGxlLkxpbmVzEi5BeGVzLlRvcC5JR2FwU2l6ZRMuQXhlcy5Ub3AuSVN0YXJ0UG9zES5BeGVzLlRvcC5JRW5kUG9zEy5BeGVzLlRvcC5JQXhpc1NpemUVLkF4ZXMuVG9wLklzRGVwdGhBeGlzFC5BeGVzLlJpZ2h0LklHYXBTaXplFS5BeGVzLlJpZ2h0LklTdGFydFBvcxMuQXhlcy5SaWdodC5JRW5kUG9zFS5BeGVzLlJpZ2h0LklBeGlzU2l6ZRcuQXhlcy5SaWdodC5Jc0RlcHRoQXhpcxUuQXhlcy5Cb3R0b20uSUdhcFNpemUWLkF4ZXMuQm90dG9tLklTdGFydFBvcxQuQXhlcy5Cb3R0b20uSUVuZFBvcxYuQXhlcy5Cb3R0b20uSUF4aXNTaXplGC5BeGVzLkJvdHRvbS5Jc0RlcHRoQXhpcx0uQXhlcy5Cb3R0b20uUmVsYXRpdmVQb3NpdGlvbhouQXhlcy5Cb3R0b20uUG9zaXRpb25Vbml0cxcuQXhlcy5EZXB0aFRvcC5JR2FwU2l6ZRguQXhlcy5EZXB0aFRvcC5JU3RhcnRQb3MWLkF4ZXMuRGVwdGhUb3AuSUVuZFBvcxguQXhlcy5EZXB0aFRvcC5JQXhpc1NpemUaLkF4ZXMuRGVwdGhUb3AuSXNEZXB0aEF4aXMULkF4ZXMuRGVwdGguSUdhcFNpemUVLkF4ZXMuRGVwdGguSVN0YXJ0UG9zEy5BeGVzLkRlcHRoLklFbmRQb3MVLkF4ZXMuRGVwdGguSUF4aXNTaXplFy5BeGVzLkRlcHRoLklzRGVwdGhBeGlzAAAABgAAAAABAAQABAAAAAEAAAAEAQAAAAAAAAEGAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAQYBCAgIAQgnU3RlZW1hLlRlZUNoYXJ0LlRvb2xzLlNjcm9sbE1vdXNlQWN0aW9uAgAAAAgoU3RlZW1hLlRlZUNoYXJ0LlRvb2xzLlNjcm9sbFRvb2xWaWV3VW5pdAIAAAABCAgBCAgUU3lzdGVtLkRyYXdpbmcuQ29sb3IDAAAACAgICAgBCAgICAEICAgIAQgICAgBBh1TdGVlbWEuVGVlQ2hhcnQuUG9zaXRpb25Vbml0cwIAAAAICAgIAQgICAgBAgAAAAAAAAAAAAAgQAAJBAAAAAAAAAAAAAAAAAAAAAAGBQAAACBTdGVlbWEuVGVlQ2hhcnQuVG9vbHMuU2Nyb2xsVG9vbAEAAAAF+v///ydTdGVlbWEuVGVlQ2hhcnQuVG9vbHMuU2Nyb2xsTW91c2VBY3Rpb24BAAAAB3ZhbHVlX18ACAIAAAABAAAAAQAAAAX5////KFN0ZWVtYS5UZWVDaGFydC5Ub29scy5TY3JvbGxUb29sVmlld1VuaXQBAAAAB3ZhbHVlX18ACAIAAAABAAAAAAAAAAAAAAAABggAAAAAAPMBAAAeAAAABff///8UU3lzdGVtLkRyYXdpbmcuQ29sb3IEAAAABG5hbWUFdmFsdWUKa25vd25Db2xvcgVzdGF0ZQEAAAAJBwcDAAAACgAAAAAAAAAAjQABAAkIAAAABgAAAAAAAAA7AAAAWwEAACABAAAABgoAAAATVGVtcGVyYXR1cmUgKCDCsEYgKQkLAAAAAAAAACoAAACgAgAAdgIAAAAAAAAAOwAAAFsBAAAgAQAAAAAAAAAqAAAAoAIAAHYCAAAAAAAAAAAAMMAF9P///x1TdGVlbWEuVGVlQ2hhcnQuUG9zaXRpb25Vbml0cwEAAAAHdmFsdWVfXwAIAgAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAABEQQAAAABAAAACQgAAAARCwAAAAEAAAAGDgAAABNUZW1wZXJhdHVyZSAoIMKwRiApCw=="
                                                        GetChartFile="GetChart.aspx" Height="400px" TempChart="Session" Width="700px" />--%>
                                                        <dxchartsui:WebChartControl ID="ChartTemperature" runat="server" Height="400px"
                                                        Width="700px"><fillstyle>
                                                            <optionsserializable>
                                                                <cc1:SolidFillOptions />
                                                            </optionsserializable>
                                                        </fillstyle><seriestemplate>
                                                            <viewserializable>
                                                                <cc1:SideBySideBarSeriesView>
                                                                </cc1:SideBySideBarSeriesView>
                                                            </viewserializable>
                                                            <labelserializable>
                                                                <cc1:SideBySideBarSeriesLabel LineVisible="True">
                                                                    <fillstyle>
                                                                        <optionsserializable>
                                                                            <cc1:SolidFillOptions />
                                                                        </optionsserializable>
                                                                    </fillstyle>
                                                                    <pointoptionsserializable>
                                                                        <cc1:PointOptions>
                                                                        </cc1:PointOptions>
                                                                    </pointoptionsserializable>
                                                                </cc1:SideBySideBarSeriesLabel>
                                                            </labelserializable>
                                                            <legendpointoptionsserializable>
                                                                <cc1:PointOptions>
                                                                </cc1:PointOptions>
                                                            </legendpointoptionsserializable>
                                                        </seriestemplate><crosshairoptions>
                                                            <commonlabelpositionserializable>
                                                                <cc1:CrosshairMousePosition />
                                                            </commonlabelpositionserializable>
                                                        </crosshairoptions><tooltipoptions>
                                                            <tooltippositionserializable>
                                                                <cc1:ToolTipMousePosition />
                                                            </tooltippositionserializable>
                                                        </tooltipoptions>
                                                        </dxchartsui:WebChartControl>
                                                </asp:Panel>
                                            </div>
                                            <div align="center" style="padding-top: 20px;">
                                                <asp:Panel ID="pnEmptyData" runat="server" CssClass="panel_empty_data">
                                                    <asp:Label ID="lbDataEmpty" runat="server" Text="You have no data to graph!" ForeColor="Red"></asp:Label></asp:Panel>
                                            </div>
                                            <div align="center" style="padding-top: 20px;">
                                                <asp:LinkButton ID="lbtnDateTime" runat="server" Font-Underline="False" OnClick="lbtnDateTime_Click">DateTime</asp:LinkButton>
                                            </div>
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
                                                            <asp:TextBox ID="txtFromDateChart" runat="server" Width="140"></asp:TextBox>
                                                            <asp:CalendarExtender ID="CalendarExtender1" runat="server" Enabled="True" TargetControlID="txtFromDateChart"
                                                                CssClass="orange">
                                                            </asp:CalendarExtender>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtToDateChart" runat="server" Width="140"></asp:TextBox>
                                                            <asp:CalendarExtender ID="CalendarExtender2" runat="server" Enabled="True" TargetControlID="txtToDateChart"
                                                                CssClass="orange">
                                                            </asp:CalendarExtender>
                                                        </td>
                                                    </tr>
                                                    <tr align="center">
                                                        <td colspan="2">
                                                            <asp:Button ID="btnOk" runat="server" OnClick="btnOk_Click" Text="Select" />
                                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" OnClick="btnCancel_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </asp:Panel>
                                            </div>
                                    </asp:View>
                                    <asp:View ID="ViewTable" runat="server">
                                        <div class="item_report">
                                            <asp:UpdatePanel ID="UpdateTable" runat="server">
                                                <ContentTemplate>
                                                    <asp:Panel ID="table_item" runat="server" CssClass="table_item" BorderColor="#f3f3f3">
                                                        <div class="title_grv">
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 170px;">
                                                                        <asp:LinkButton ID="lbPopup" runat="server" OnClick="lbPopup_Click" ForeColor="White">DateTime</asp:LinkButton>
                                                                    </td>
                                                                    <td style="width: 180px;">
                                                                        Skin temperature (oC/oF)
                                                                    </td>
                                                                    <td style="width: 150px;">
                                                                        Ambient Temperature (oC/oF)
                                                                    </td>
                                                                    <td style="width: 300px;">
                                                                        Diagnosis
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <!-- Title -->
                                                        <div class="content_grv" style="height: 423px">
                                                            <asp:GridView ID="grvTemp" runat="server" AutoGenerateColumns="False" BackColor="White"
                                                                BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="3" Width="100%"
                                                                EmptyDataText="There is no record to show !" OnPageIndexChanging="grvTemp_PageIndexChanging"
                                                                PageSize="100" ShowHeader="False">
                                                                <Columns>
                                                                    <asp:BoundField DataField="ReceivedDate" DataFormatString="{0:MM/dd/yyyy hh:mm:ss}">
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="SkinTempC" HeaderText="Skin temperature (oC/oF)">
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="AmbTempC" HeaderText="Ambient Temperature  (oC/oF) ">
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="Diagnosis" HeaderText="Diagnosis">
                                                                        <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
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
                                                        <div class="footer_grv" style="visibility: hidden">
                                                            <table>
                                                                <tr>
                                                                    <td style="width: 26px; text-align: left">
                                                                        <asp:ImageButton ID="btnback" runat="server" Height="26px" ImageUrl="~/resources/images/Previous-icon.png"
                                                                            OnClick="back_Click" Width="26px" />
                                                                    </td>
                                                                    <td style="width: 60%; text-align: center">
                                                                        Page :
                                                                        <asp:TextBox ID="txtpage" runat="server" AutoPostBack="True" OnTextChanged="txtpage_TextChanged"
                                                                            Width="15px" onkeypress="return ValidateKeypress(/\d/,event);"></asp:TextBox>
                                                                        <asp:Label ID="lb_pager" runat="server" Text="Page: 1/10"></asp:Label>
                                                                    </td>
                                                                    <td style="width: 26px; text-align: right">
                                                                        <asp:ImageButton ID="btnnext" runat="server" Height="26px" ImageUrl="~/resources/images/next.jpg"
                                                                            OnClick="next_Click" Width="26px" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <!-- footer -->
                                                    </asp:Panel>
                                                    <%--<asp:ModalPopupExtender ID="mdpTable" TargetControlID="lbPopup" runat="server"
                                                    CancelControlID="btncancelTable" PopupControlID="popup" PopupDragHandleControlID="headerpop"
                                                    Drag="True" DropShadow="True" DynamicServicePath="" Enabled="True">
                                                    </asp:ModalPopupExtender>--%>
                                                    <asp:Panel ID="date_table" CssClass="datetime_filter" runat="server" Visible="False">
                                                        <div>
                                                            <asp:Panel ID="headerpop" runat="server" CssClass="TitlePanelDateTime">
                                                                Select Date
                                                            </asp:Panel>
                                                        </div>
                                                        <div class="ContentDateTime">
                                                            <table>
                                                                <tr>
                                                                    <td>
                                                                        From date:
                                                                    </td>
                                                                    <td>
                                                                        To Date:
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:TextBox ID="txtFromDate" runat="server" Width="150px" CssClass="input"></asp:TextBox>
                                                                        <asp:CalendarExtender ID="txtFromDate_CalendarExtender" runat="server" CssClass="orange"
                                                                            Enabled="True" TargetControlID="txtFromDate">
                                                                        </asp:CalendarExtender>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtToDate" runat="server" Width="150px" CssClass="input"></asp:TextBox>
                                                                        <asp:CalendarExtender ID="txtToDate_CalendarExtender" runat="server" CssClass="orange"
                                                                            Enabled="True" TargetControlID="txtToDate">
                                                                        </asp:CalendarExtender>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2" align="center">
                                                                        <asp:Button ID="btnFilter" runat="server" OnClick="btnFilter_Click" Text="View" Height="25px"
                                                                            Width="100px" />
                                                                        <asp:Button ID="btncancelTable" runat="server" Text="Cancel" Height="25px" Width="100px"
                                                                            OnClick="btncancelTable_Click" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </asp:Panel>
                                                    <!-- Popup -->
                                                </ContentTemplate>
                                            </asp:UpdatePanel>
                                        </div>
                                        <!-- item -->
                                    </asp:View>
                                </asp:MultiView>
                            </div>
                            <!-- print-->
                            <br />
                            <div class="border-top-bottom">
                                <div class="title">
                                    Diagnosis & Recommendations</div>
                                <div>
                                    This page displays your current mediacal issues and the date that they were noded
                                    in your medical record. Click on the issue name for more in-depth information on
                                    that particular issue.
                                </div>
                            </div>
                            <div class="no-border" style="margin-bottom:10px;margin-top:10px">
                                <asp:Button ID="Button1" runat="server" Text="Settings" OnClick="Button1_Click" CssClass="btn btn-default" />
                                <asp:Button ID="Button2" runat="server" Text="Back to Track my health" PostBackUrl="~/usertrackotherhealth.aspx" CssClass="btn btn-default" />
                            </div>                
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:UpdateProgress ID="UpadateProc" AssociatedUpdatePanelID="UpdateTable" runat="server">
        <ProgressTemplate>
            <div class="loading">
                <img src="resources/images/process.gif" />
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
</asp:Content>
