<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true"
    CodeFile="usertrackothers_spo2.aspx.cs" Inherits="usertrackothers_spo2" %>

<%@ Register Assembly="TeeChart" Namespace="Steema.TeeChart.Web" TagPrefix="tchart" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register assembly="DevExpress.XtraCharts.v12.1, Version=12.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraCharts" tagprefix="cc1" %>
<%@ Register Assembly="DevExpress.XtraCharts.v12.1.Web, Version=12.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" runat="Server">
    <script src="scripts/Print.js" type="text/javascript"></script>
    <link href="styles/tab.css" rel="stylesheet" type="text/css" />
    <link href="styles/control.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        $(document).ready(function () {
            $('#userhelp').click(function (e) {
                window.open('userhelp.aspx', 'User Help', 500, 500);
            });
        });
    </script>
    <style>
        .datetime_filter {
            background-color: White;
            border: 1px solid #167DC1;
            position: relative;
            z-index: 99999999;
            top: -360px;
            width: 320px;
            left: 20px;
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
                    <a href="usertrackmyhealth.aspx">Track
                        <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label>
                        health </a>» <a href="usertrackothers_spo2.aspx">Oxygen monitoring</a>
                    <div class="floatright">
                        <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png"
                            Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft" />&nbsp;&nbsp;
                    </div>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6" style="width:100%;">
                        <div id="print">
                            Select GRAPH or TABLE buttons to see Oxygen monitoring Report.
                            <div style="padding-top: 10px;">
                                <asp:Button ID="btnGraph2" runat="server" OnClick="btnGraph2_Click" Text="Graph" CssClass="btn btn-default" style="color:#000;"/>
                                <asp:Button ID="btnTable2" runat="server" OnClick="btnTable2_Click" Text="Table" CssClass="btn btn-default" style="color:#000;"/>
                            </div>
                            <asp:MultiView ID="MultiViewOxyGen" runat="server" ActiveViewIndex="0">
                                <asp:View ID="ViewGraph" runat="server">
                                    <div class="item_report">
                                        <div id="chart">
                                            <asp:Panel runat="server" ID="pnGraphSpO2">
                                                <%--<tchart:webchart id="WebChartGraphSpO2" runat="server" autopostback="False" config="AAEAAAD/////AQAAAAAAAAAMAgAAAFJUZWVDaGFydCwgVmVyc2lvbj00LjEuMjAxMy4xMTA4NiwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj05YzgxMjYyNzZjNzdiZGI3DAMAAABRU3lzdGVtLkRyYXdpbmcsIFZlcnNpb249NC4wLjAuMCwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj1iMDNmNWY3ZjExZDUwYTNhBQEAAAAVU3RlZW1hLlRlZUNoYXJ0LkNoYXJ0NwAAABAuQ3VzdG9tQ2hhcnRSZWN0Ey5QYW5lbC5NYXJnaW5Cb3R0b20PLkxlZ2VuZC5WaXNpYmxlDy5IZWFkZXIuVmlzaWJsZRkuQXNwZWN0LkNvbG9yUGFsZXR0ZUluZGV4EC5Bc3BlY3QuSGVpZ2h0M0QPLkFzcGVjdC5XaWR0aDNEDi5Bc3BlY3QuVmlldzNEB1Rvb2xzLjAYLlRvb2xzLjAuVmlld1NlZ21lbnRTaXplFC5Ub29scy4wLk1vdXNlQWN0aW9uFi5Ub29scy4wLlN0YXJ0UG9zaXRpb24ZLlRvb2xzLjAuU2VnbWVudFZpZXdVbml0cxwuVG9vbHMuMC5BdHRyaWJ1dGVzLkRyYWdab29tHy5Ub29scy4wLkF0dHJpYnV0ZXMuQ2FudmFzSW5kZXgeLlRvb2xzLjAuQXR0cmlidXRlcy5GaWxsVHJhbnNwHC5Ub29scy4wLkF0dHJpYnV0ZXMuSW1hZ2VTdHIjLlRvb2xzLjAuQXR0cmlidXRlcy5Ob0NsaWNrUG9zdGJhY2sYLlRvb2xzLjAuWm9vbUNhbnZhc0luZGV4HS5Ub29scy4wLlpvb21GaWxsVHJhbnNwYXJlbmN5FS5Ub29scy4wLlpvb21QZW5Db2xvchguVG9vbHMuMC5DdXN0b21WYXJpYWJsZXMSLkF4ZXMuTnVtRml4ZWRBeGVzEy5BeGVzLkxlZnQuSUdhcFNpemUULkF4ZXMuTGVmdC5JU3RhcnRQb3MSLkF4ZXMuTGVmdC5JRW5kUG9zFC5BeGVzLkxlZnQuSUF4aXNTaXplFi5BeGVzLkxlZnQuSXNEZXB0aEF4aXMSLkF4ZXMuVG9wLklHYXBTaXplEy5BeGVzLlRvcC5JU3RhcnRQb3MRLkF4ZXMuVG9wLklFbmRQb3MTLkF4ZXMuVG9wLklBeGlzU2l6ZRUuQXhlcy5Ub3AuSXNEZXB0aEF4aXMULkF4ZXMuUmlnaHQuSUdhcFNpemUVLkF4ZXMuUmlnaHQuSVN0YXJ0UG9zEy5BeGVzLlJpZ2h0LklFbmRQb3MVLkF4ZXMuUmlnaHQuSUF4aXNTaXplFy5BeGVzLlJpZ2h0LklzRGVwdGhBeGlzFS5BeGVzLkJvdHRvbS5JR2FwU2l6ZRYuQXhlcy5Cb3R0b20uSVN0YXJ0UG9zFC5BeGVzLkJvdHRvbS5JRW5kUG9zFi5BeGVzLkJvdHRvbS5JQXhpc1NpemUYLkF4ZXMuQm90dG9tLklzRGVwdGhBeGlzHS5BeGVzLkJvdHRvbS5SZWxhdGl2ZVBvc2l0aW9uGi5BeGVzLkJvdHRvbS5Qb3NpdGlvblVuaXRzFy5BeGVzLkRlcHRoVG9wLklHYXBTaXplGC5BeGVzLkRlcHRoVG9wLklTdGFydFBvcxYuQXhlcy5EZXB0aFRvcC5JRW5kUG9zGC5BeGVzLkRlcHRoVG9wLklBeGlzU2l6ZRouQXhlcy5EZXB0aFRvcC5Jc0RlcHRoQXhpcxQuQXhlcy5EZXB0aC5JR2FwU2l6ZRUuQXhlcy5EZXB0aC5JU3RhcnRQb3MTLkF4ZXMuRGVwdGguSUVuZFBvcxUuQXhlcy5EZXB0aC5JQXhpc1NpemUXLkF4ZXMuRGVwdGguSXNEZXB0aEF4aXMAAAAAAAAAAAEABAAEAAAAAQAAAAQBAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAQYBAQgICAEIJ1N0ZWVtYS5UZWVDaGFydC5Ub29scy5TY3JvbGxNb3VzZUFjdGlvbgIAAAAIKFN0ZWVtYS5UZWVDaGFydC5Ub29scy5TY3JvbGxUb29sVmlld1VuaXQCAAAAAQgIAQgIFFN5c3RlbS5EcmF3aW5nLkNvbG9yAwAAAAgICAgIAQgICAgBCAgICAEICAgIAQYdU3RlZW1hLlRlZUNoYXJ0LlBvc2l0aW9uVW5pdHMCAAAACAgICAEICAgIAQIAAAAAAAAAAAAAIEAAAAAAAAAAAAAAAAAAAAAGBAAAACBTdGVlbWEuVGVlQ2hhcnQuVG9vbHMuU2Nyb2xsVG9vbAEAAAAF+////ydTdGVlbWEuVGVlQ2hhcnQuVG9vbHMuU2Nyb2xsTW91c2VBY3Rpb24BAAAAB3ZhbHVlX18ACAIAAAABAAAAAQAAAAX6////KFN0ZWVtYS5UZWVDaGFydC5Ub29scy5TY3JvbGxUb29sVmlld1VuaXQBAAAAB3ZhbHVlX18ACAIAAAAAAAAAAAAAAAAAAAAABgcAAAAAAPMBAAAeAAAABfj///8UU3lzdGVtLkRyYXdpbmcuQ29sb3IEAAAABG5hbWUFdmFsdWUKa25vd25Db2xvcgVzdGF0ZQEAAAAJBwcDAAAACgAAAAAAAAAAjQABAAkHAAAABgAAAAAAAAAlAAAAWwEAADYBAAAAAAAAABwAAACgAgAAhAIAAAAAAAAAJQAAAFsBAAA2AQAAAAAAAAAcAAAAoAIAAIQCAAAAAAAAAAAAMMAF9////x1TdGVlbWEuVGVlQ2hhcnQuUG9zaXRpb25Vbml0cwEAAAAHdmFsdWVfXwAIAgAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAABCw=="
                                                    getchartfile="GetChart.aspx" height="400px" tempchart="Session" width="700px" />--%>
                                            <dxchartsui:WebChartControl ID="ChartSpo2Main" runat="server" Height="450px" style="margin:auto;"
                                            Width="600px">
                                            <diagramserializable>
                                                <cc1:XYDiagram>
                                                    <axisx visibleinpanesserializable="-1">
                                                        <range sidemarginsenabled="False" />
                                                    </axisx>
                                                    <axisy visibleinpanesserializable="-1">
                                                        <range sidemarginsenabled="True" />
                                                    </axisy>
                                                </cc1:XYDiagram>
                                            </diagramserializable>
                                            <fillstyle>
                                                <optionsserializable>
                                                    <cc1:SolidFillOptions />
                                                </optionsserializable>
                                            </fillstyle>
                                            <seriesserializable>
                                                <cc1:Series ArgumentDataMember="ReceivedDate" 
                                                    ArgumentScaleType="DateTime" ValueDataMembersSerializable="SpO2Value">
                                                    <viewserializable>
                                                        <cc1:AreaSeriesView>
                                                        </cc1:AreaSeriesView>
                                                    </viewserializable>
                                                    <labelserializable>
                                                        <cc1:PointSeriesLabel LineVisible="True">
                                                            <fillstyle>
                                                                <optionsserializable>
                                                                    <cc1:SolidFillOptions />
                                                                </optionsserializable>
                                                            </fillstyle>
                                                            <pointoptionsserializable>
                                                                <cc1:PointOptions>
                                                                </cc1:PointOptions>
                                                            </pointoptionsserializable>
                                                        </cc1:PointSeriesLabel>
                                                    </labelserializable>
                                                    <legendpointoptionsserializable>
                                                        <cc1:PointOptions>
                                                        </cc1:PointOptions>
                                                    </legendpointoptionsserializable>
                                                </cc1:Series>
                                            </seriesserializable>
                                            <seriestemplate>
                                                <viewserializable>
                                                    <cc1:SwiftPlotSeriesView>
                                                    </cc1:SwiftPlotSeriesView>
                                                </viewserializable>
                                                <legendpointoptionsserializable>
                                                    <cc1:PointOptions>
                                                    </cc1:PointOptions>
                                                </legendpointoptionsserializable>
                                            </seriestemplate>
                                            <crosshairoptions>
                                                <commonlabelpositionserializable>
                                                    <cc1:CrosshairMousePosition />
                                                </commonlabelpositionserializable>
                                            </crosshairoptions>
                                            <tooltipoptions>
                                                <tooltippositionserializable>
                                                    <cc1:ToolTipMousePosition />
                                                </tooltippositionserializable>
                                            </tooltipoptions>
                                        </dxchartsui:WebChartControl>
                                            </asp:Panel>
                                            <br />
                                            <div align="center">
                                                <asp:Panel ID="pnEmptyData" runat="server" CssClass="panel_empty_data">
                                                    <asp:Label ID="lbDataEmpty" runat="server" Text="You have no data to graph!" ForeColor="Red"></asp:Label></asp:Panel>
                                            </div>
                                            <div align="center">
                                                <asp:LinkButton ID="lbtnDateTime" runat="server" Font-Underline="False" OnClick="lbtnDateTime_Click">DateTime</asp:LinkButton></div>
                                            <%--<asp:ModalPopupExtender ID="MPE" runat="server" TargetControlID="lbtnDateTime" PopupControlID="Panel1"
                                            DropShadow="True" PopupDragHandleControlID="Panel2" DynamicServicePath="" 
                                            CancelControlID="btnCancel" Enabled="True">
                                        </asp:ModalPopupExtender>--%>
                                            <asp:Panel ID="date_graph" CssClass="datetime_filter_top" runat="server">
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
                                                            <td style="padding:0px 5px 5px 0px;">
                                                                <asp:TextBox ID="txtFromDate" runat="server" Width="150"></asp:TextBox>
                                                                <asp:CalendarExtender ID="txtFromDate_CalendarExtender" runat="server" Enabled="True"
                                                                    TargetControlID="txtFromDate" CssClass="orange">
                                                                </asp:CalendarExtender>
                                                            </td>
                                                            <td style="padding-bottom:5px;">
                                                                <asp:TextBox ID="txtToDate" runat="server" Width="150"></asp:TextBox>
                                                                <asp:CalendarExtender ID="txtToDate_CalendarExtender" runat="server" Enabled="True"
                                                                    TargetControlID="txtToDate" CssClass="orange">
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
                                    </div>
                                    <!-- report -->
                                </asp:View>
                                <asp:View ID="ViewTable" runat="server">
                                    <div class="item_report">
                                        <asp:LinkButton ID="lbPopup" runat="server" CssClass="top-8px" OnClick="lbPopup_Click">DateTime</asp:LinkButton>
                                        <asp:UpdatePanel ID="UpdateTable" runat="server">
                                            <ContentTemplate>
                                                <asp:Panel ID="table_item" runat="server" CssClass="table_item">
                                                    <div class="title_grv margin-top-20px">
                                                        <table>
                                                            <tr>
                                                                <td style="width: 170px;">
                                                                </td>
                                                                <td style="width: 150px;">
                                                                    %SpO2
                                                                </td>
                                                                <td style="width: 150px;">
                                                                    Threshold
                                                                </td>
                                                                <td style="width: 150px;">
                                                                    Mode
                                                                </td>
                                                                <td style="width: 350px;">
                                                                    Diagnosis
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <!-- Title -->
                                                    <div class="content_grv" style="height: 444px">
                                                        <asp:GridView ID="grvSpO2" runat="server" AllowPaging="true" AutoGenerateColumns="False"
                                                            BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px"
                                                            CellPadding="3" Width="100%" EmptyDataText=" " OnPageIndexChanging="grvSpO2_PageIndexChanging"
                                                            PageSize="1000" ShowHeader="False">
                                                            <Columns>
                                                                <asp:BoundField DataField="ReceivedDate" DataFormatString="{0:MM/dd/yyyy hh:mm:ss}">
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="SpO2Value" HeaderText="%SpO2">
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="ThresholdValue" HeaderText="Threshold">
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="ModeTypeId" HeaderText="Mode">
                                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField HeaderText="Diagn" DataField="Diagnosis">
                                                                    <ItemStyle Width="300px" />
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
                                                                <td style="width: 26px; text-align: left">
                                                                    <asp:ImageButton ID="btnback" runat="server" Height="26px" ImageUrl="~/resources/images/Previous-icon.png"
                                                                        OnClick="back_Click" Width="26px" />
                                                                </td>
                                                                <td style="width: 60%; text-align: center">
                                                                    Page :
                                                                    <asp:TextBox ID="txtpage" runat="server" AutoPostBack="True" OnTextChanged="txtpage_TextChanged"
                                                                        Width="15px" onkeypress="return ValidateKeypress(/\d/,event);"></asp:TextBox>
                                                                    <asp:Label ID="lb_pager" runat="server"></asp:Label>
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
                                            </ContentTemplate>
                                        </asp:UpdatePanel>
                                        <%--<asp:ModalPopupExtender ID="mdpTable" TargetControlID="lbPopup" runat="server"
                                        CancelControlID="btncancelTable" PopupControlID="popup" PopupDragHandleControlID="headerpop"
                                        Drag="True" DropShadow="True" DynamicServicePath="" Enabled="True">
                                        </asp:ModalPopupExtender>--%>
                                        <asp:Panel ID="date_table" CssClass="datetime_filter" runat="server">
                                            <div>
                                                <asp:Panel ID="headerpop" runat="server" CssClass="TitlePanelDateTime">
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
                                                        <td style="padding:0px 5px 5px 0px;">
                                                            <asp:TextBox ID="txtFromDateTable" runat="server" Width="150"></asp:TextBox>
                                                            <asp:CalendarExtender ID="txtClfromDateTable" runat="server" CssClass="orange" Enabled="True"
                                                                TargetControlID="txtFromDateTable">
                                                            </asp:CalendarExtender>
                                                        </td>
                                                        <td style="padding-bottom:5px;">
                                                            <asp:TextBox ID="txtToDateTable" runat="server" Width="150"></asp:TextBox><asp:CalendarExtender
                                                                ID="txtCltoDateTable" runat="server" CssClass="orange" Enabled="True" TargetControlID="txtToDateTable">
                                                            </asp:CalendarExtender>
                                                        </td>
                                                    </tr>
                                                    <tr align="center">
                                                        <td colspan="2">
                                                            <asp:Button ID="btnView" runat="server" OnClick="btnView_Click" Text="View" />
                                                            <asp:Button ID="btncancelTable" runat="server" Text="Cancel" OnClick="btncancelTable_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </asp:Panel>
                                        <!-- Popup -->
                                    </div>
                                    <!-- report -->
                                </asp:View>
                            </asp:MultiView>
                        </div>
                        <!-- print-->
                        <br />
                        <div class="border-top-bottom">
                            <div class="title">
                                Diagnosis &amp; Recommendations</div>
                            <div class="">
                                This page displays your current mediacal issues and the date that they were noded
                                in your medical record. Click on the issue name for more in-depth information on
                                that particular issue.
                            </div>
                        </div>
                        <div class="clear" style="margin-top: 10px;">
                            <asp:Button ID="Button1" runat="server" Text="Settings" PostBackUrl="~/usertrackothers_spo2_settings.aspx" CssClass="btn btn-default"/>
                            <asp:Button ID="Button2" runat="server" Text="Back to Track my health" PostBackUrl="~/usertrackotherhealth.aspx" CssClass="btn btn-default"/>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
