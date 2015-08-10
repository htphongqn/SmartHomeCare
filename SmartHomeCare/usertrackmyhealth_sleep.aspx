<%@ Page Title="Sleep Monitoring" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackmyhealth_sleep.aspx.cs" Inherits="usertrackmyhealth_sleep" %>

<%@ Register Assembly="TeeChart" Namespace="Steema.TeeChart.Web" TagPrefix="tchart" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<%@ Register assembly="DevExpress.XtraCharts.v12.1, Version=12.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" namespace="DevExpress.XtraCharts" tagprefix="cc1" %>
<%@ Register Assembly="DevExpress.XtraCharts.v12.1.Web, Version=12.1.4.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a"
    Namespace="DevExpress.XtraCharts.Web" TagPrefix="dxchartsui" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <link href="styles/tab.css" rel="stylesheet" type="text/css" />
    <link href="styles/control.css" rel="stylesheet" type="text/css" />
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
                    Sleep monitoring
                    <div class="floatright">
                        <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                    </div>
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6" style="width:100%;">
                            
                            <div id="print"> <!-- print-->
                             Select GRAPH or TABLE buttons to see Sleep monitoring Report.
                                <div style="padding-top:10px;">
                                    <asp:Button ID="btnGraph2" runat="server" OnClick="btnGraph2_Click" Text="Graph" CssClass="btn btn-default"/>
                                    <asp:Button ID="btnTable2" runat="server" OnClick="btnTable2_Click" Text="Table" CssClass="btn btn-default" style="color:#000;"/>
                                </div>
                                <asp:MultiView ID="MultiViewSleep" runat="server" ActiveViewIndex="0">        
                                    <asp:View ID="ViewGraph" runat="server">
                                    <div class="item_report">
                                        <div id="Div2">
                                                <div class="select_data">
                                                Report is viewed with:
                                                <asp:DropDownList ID="ddl_Graph" runat="server" style="width:30%;display:inline;"
                                                        AutoPostBack="True" CssClass="form-control"
                                                        onselectedindexchanged="ddl_Graph_SelectedIndexChanged">
                                                    <asp:ListItem Value="1">Default data</asp:ListItem>
                                                    <asp:ListItem Value="0">Raw data</asp:ListItem>
                                                </asp:DropDownList>
                                                . Click drop-down list to select a different view.
                                            </div>
                                                <div align="center">
                                                    <table>
                                                        <tr>
                                                            <td>
                                                                <asp:DropDownList ID="ddlTimeType" runat="server" CssClass="form-control"
                                                                    onselectedindexchanged="ddlTimeType_SelectedIndexChanged">
                                                                    <asp:ListItem>Weekly</asp:ListItem>
                                                                    <asp:ListItem>Monthly</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                &nbsp;</td>
                                                            <td>
                                        
                                                            </td>
                                                            <td>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                   <%-- <asp:ModalPopupExtender ID="ModalPopupExtender1" runat="server" TargetControlID="lbtnDateTime" PopupControlID="Panel1"
                                                DropShadow="True" PopupDragHandleControlID="Panel2" DynamicServicePath="" 
                                                CancelControlID="btnCancel" Enabled="True"></asp:ModalPopupExtender>--%>
                                                    <asp:Panel ID="Panel1" CssClass="PanelDateTime" runat="server" Visible="false">
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
                                                                        <asp:TextBox ID="TextBox1" runat="server" CssClass="form-control"></asp:TextBox>
                                                                        <asp:CalendarExtender ID="CalendarExtender1" runat="server" Enabled="True" TargetControlID="txtFromDate"
                                                                            CssClass="orange">
                                                                        </asp:CalendarExtender>
                                                                    </td>
                                                                    <td>
                                                                        <asp:TextBox ID="TextBox2" runat="server" CssClass="form-control"></asp:TextBox>
                                                                        <asp:CalendarExtender ID="CalendarExtender2" runat="server" Enabled="True" TargetControlID="txtToDate"
                                                                            CssClass="orange">
                                                                        </asp:CalendarExtender>
                                                                    </td>
                                                                </tr>
                                                                <tr align="center">
                                                                    <td colspan="2">
                                                                        <asp:Button ID="Button3" runat="server" OnClick="btnOk_Click" Text="Select" CssClass="btn btn-default"/>
                                                                        <asp:Button ID="Button4" runat="server" Text="Cancel" CssClass="btn btn-default"/>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </asp:Panel>
                                                </div>
                                                <div>
                                                    <asp:Panel ID="pnGraph" runat="server" Visible="False">
                                                        <%--<tchart:WebChart ID="WebChartGraph" runat="server" AutoPostback="False" 
                                                            Config="AAEAAAD/////AQAAAAAAAAAMAgAAAFJUZWVDaGFydCwgVmVyc2lvbj00LjEuMjAxMy4xMTA4NiwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj05YzgxMjYyNzZjNzdiZGI3DAMAAABRU3lzdGVtLkRyYXdpbmcsIFZlcnNpb249NC4wLjAuMCwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj1iMDNmNWY3ZjExZDUwYTNhBQEAAAAVU3RlZW1hLlRlZUNoYXJ0LkNoYXJ0NgAAABAuQ3VzdG9tQ2hhcnRSZWN0Ey5QYW5lbC5NYXJnaW5Cb3R0b20NLkhlYWRlci5MaW5lcxkuQXNwZWN0LkNvbG9yUGFsZXR0ZUluZGV4EC5Bc3BlY3QuSGVpZ2h0M0QPLkFzcGVjdC5XaWR0aDNEDi5Bc3BlY3QuVmlldzNEB1Rvb2xzLjAYLlRvb2xzLjAuVmlld1NlZ21lbnRTaXplFC5Ub29scy4wLk1vdXNlQWN0aW9uFi5Ub29scy4wLlN0YXJ0UG9zaXRpb24ZLlRvb2xzLjAuU2VnbWVudFZpZXdVbml0cxwuVG9vbHMuMC5BdHRyaWJ1dGVzLkRyYWdab29tHy5Ub29scy4wLkF0dHJpYnV0ZXMuQ2FudmFzSW5kZXgeLlRvb2xzLjAuQXR0cmlidXRlcy5GaWxsVHJhbnNwHC5Ub29scy4wLkF0dHJpYnV0ZXMuSW1hZ2VTdHIjLlRvb2xzLjAuQXR0cmlidXRlcy5Ob0NsaWNrUG9zdGJhY2sYLlRvb2xzLjAuWm9vbUNhbnZhc0luZGV4HS5Ub29scy4wLlpvb21GaWxsVHJhbnNwYXJlbmN5FS5Ub29scy4wLlpvb21QZW5Db2xvchguVG9vbHMuMC5DdXN0b21WYXJpYWJsZXMSLkF4ZXMuTnVtRml4ZWRBeGVzEy5BeGVzLkxlZnQuSUdhcFNpemUULkF4ZXMuTGVmdC5JU3RhcnRQb3MSLkF4ZXMuTGVmdC5JRW5kUG9zFC5BeGVzLkxlZnQuSUF4aXNTaXplFi5BeGVzLkxlZnQuSXNEZXB0aEF4aXMSLkF4ZXMuVG9wLklHYXBTaXplEy5BeGVzLlRvcC5JU3RhcnRQb3MRLkF4ZXMuVG9wLklFbmRQb3MTLkF4ZXMuVG9wLklBeGlzU2l6ZRUuQXhlcy5Ub3AuSXNEZXB0aEF4aXMULkF4ZXMuUmlnaHQuSUdhcFNpemUVLkF4ZXMuUmlnaHQuSVN0YXJ0UG9zEy5BeGVzLlJpZ2h0LklFbmRQb3MVLkF4ZXMuUmlnaHQuSUF4aXNTaXplFy5BeGVzLlJpZ2h0LklzRGVwdGhBeGlzFS5BeGVzLkJvdHRvbS5JR2FwU2l6ZRYuQXhlcy5Cb3R0b20uSVN0YXJ0UG9zFC5BeGVzLkJvdHRvbS5JRW5kUG9zFi5BeGVzLkJvdHRvbS5JQXhpc1NpemUYLkF4ZXMuQm90dG9tLklzRGVwdGhBeGlzHS5BeGVzLkJvdHRvbS5SZWxhdGl2ZVBvc2l0aW9uGi5BeGVzLkJvdHRvbS5Qb3NpdGlvblVuaXRzFy5BeGVzLkRlcHRoVG9wLklHYXBTaXplGC5BeGVzLkRlcHRoVG9wLklTdGFydFBvcxYuQXhlcy5EZXB0aFRvcC5JRW5kUG9zGC5BeGVzLkRlcHRoVG9wLklBeGlzU2l6ZRouQXhlcy5EZXB0aFRvcC5Jc0RlcHRoQXhpcxQuQXhlcy5EZXB0aC5JR2FwU2l6ZRUuQXhlcy5EZXB0aC5JU3RhcnRQb3MTLkF4ZXMuRGVwdGguSUVuZFBvcxUuQXhlcy5EZXB0aC5JQXhpc1NpemUXLkF4ZXMuRGVwdGguSXNEZXB0aEF4aXMAAAYAAAAAAQAEAAQAAAABAAAABAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAABBggICAEIJ1N0ZWVtYS5UZWVDaGFydC5Ub29scy5TY3JvbGxNb3VzZUFjdGlvbgIAAAAIKFN0ZWVtYS5UZWVDaGFydC5Ub29scy5TY3JvbGxUb29sVmlld1VuaXQCAAAAAQgIAQgIFFN5c3RlbS5EcmF3aW5nLkNvbG9yAwAAAAgICAgIAQgICAgBCAgICAEICAgIAQYdU3RlZW1hLlRlZUNoYXJ0LlBvc2l0aW9uVW5pdHMCAAAACAgICAEICAgIAQIAAAAAAAAAAAAAIEAJBAAAAAAAAAAAAAAAAAAAAAAGBQAAACBTdGVlbWEuVGVlQ2hhcnQuVG9vbHMuU2Nyb2xsVG9vbBQAAAAF+v///ydTdGVlbWEuVGVlQ2hhcnQuVG9vbHMuU2Nyb2xsTW91c2VBY3Rpb24BAAAAB3ZhbHVlX18ACAIAAAABAAAAAQAAAAX5////KFN0ZWVtYS5UZWVDaGFydC5Ub29scy5TY3JvbGxUb29sVmlld1VuaXQBAAAAB3ZhbHVlX18ACAIAAAAAAAAAAAAAAAAAAAAABggAAAAAAPMBAAAeAAAABff///8UU3lzdGVtLkRyYXdpbmcuQ29sb3IEAAAABG5hbWUFdmFsdWUKa25vd25Db2xvcgVzdGF0ZQEAAAAJBwcDAAAACgAAAAAAAAAAjQABAAkIAAAABgAAAAAAAAA7AAAAWwEAACABAAAAAAAAABwAAACgAgAAhAIAAAAAAAAAOwAAAFsBAAAgAQAAAAAAAAAcAAAAoAIAAIQCAAAAAAAAAAAAMMAF9v///x1TdGVlbWEuVGVlQ2hhcnQuUG9zaXRpb25Vbml0cwEAAAAHdmFsdWVfXwAIAgAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAABEQQAAAABAAAACQgAAAAL" 
                                                            GetChartFile="GetChart.aspx" Height="400px" TempChart="Session" 
                                                            Width="700px" />--%>
                                                    </asp:Panel>    
                                                </div>
                                                <div>
                                                    <asp:Panel ID="pnDrawData" runat="server" Visible="False">
                                                        <%--<tchart:WebChart ID="WebChartDrawData" runat="server" AutoPostback="False" 
                                                            Config="AAEAAAD/////AQAAAAAAAAAMAgAAAFJUZWVDaGFydCwgVmVyc2lvbj00LjEuMjAxMy4xMTA4NiwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj05YzgxMjYyNzZjNzdiZGI3DAMAAABRU3lzdGVtLkRyYXdpbmcsIFZlcnNpb249NC4wLjAuMCwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj1iMDNmNWY3ZjExZDUwYTNhBQEAAAAVU3RlZW1hLlRlZUNoYXJ0LkNoYXJ0NgAAABAuQ3VzdG9tQ2hhcnRSZWN0Ey5QYW5lbC5NYXJnaW5Cb3R0b20NLkhlYWRlci5MaW5lcxkuQXNwZWN0LkNvbG9yUGFsZXR0ZUluZGV4EC5Bc3BlY3QuSGVpZ2h0M0QPLkFzcGVjdC5XaWR0aDNEDi5Bc3BlY3QuVmlldzNEB1Rvb2xzLjAYLlRvb2xzLjAuVmlld1NlZ21lbnRTaXplFC5Ub29scy4wLk1vdXNlQWN0aW9uFi5Ub29scy4wLlN0YXJ0UG9zaXRpb24ZLlRvb2xzLjAuU2VnbWVudFZpZXdVbml0cxwuVG9vbHMuMC5BdHRyaWJ1dGVzLkRyYWdab29tHy5Ub29scy4wLkF0dHJpYnV0ZXMuQ2FudmFzSW5kZXgeLlRvb2xzLjAuQXR0cmlidXRlcy5GaWxsVHJhbnNwHC5Ub29scy4wLkF0dHJpYnV0ZXMuSW1hZ2VTdHIjLlRvb2xzLjAuQXR0cmlidXRlcy5Ob0NsaWNrUG9zdGJhY2sYLlRvb2xzLjAuWm9vbUNhbnZhc0luZGV4HS5Ub29scy4wLlpvb21GaWxsVHJhbnNwYXJlbmN5FS5Ub29scy4wLlpvb21QZW5Db2xvchguVG9vbHMuMC5DdXN0b21WYXJpYWJsZXMSLkF4ZXMuTnVtRml4ZWRBeGVzEy5BeGVzLkxlZnQuSUdhcFNpemUULkF4ZXMuTGVmdC5JU3RhcnRQb3MSLkF4ZXMuTGVmdC5JRW5kUG9zFC5BeGVzLkxlZnQuSUF4aXNTaXplFi5BeGVzLkxlZnQuSXNEZXB0aEF4aXMSLkF4ZXMuVG9wLklHYXBTaXplEy5BeGVzLlRvcC5JU3RhcnRQb3MRLkF4ZXMuVG9wLklFbmRQb3MTLkF4ZXMuVG9wLklBeGlzU2l6ZRUuQXhlcy5Ub3AuSXNEZXB0aEF4aXMULkF4ZXMuUmlnaHQuSUdhcFNpemUVLkF4ZXMuUmlnaHQuSVN0YXJ0UG9zEy5BeGVzLlJpZ2h0LklFbmRQb3MVLkF4ZXMuUmlnaHQuSUF4aXNTaXplFy5BeGVzLlJpZ2h0LklzRGVwdGhBeGlzFS5BeGVzLkJvdHRvbS5JR2FwU2l6ZRYuQXhlcy5Cb3R0b20uSVN0YXJ0UG9zFC5BeGVzLkJvdHRvbS5JRW5kUG9zFi5BeGVzLkJvdHRvbS5JQXhpc1NpemUYLkF4ZXMuQm90dG9tLklzRGVwdGhBeGlzHS5BeGVzLkJvdHRvbS5SZWxhdGl2ZVBvc2l0aW9uGi5BeGVzLkJvdHRvbS5Qb3NpdGlvblVuaXRzFy5BeGVzLkRlcHRoVG9wLklHYXBTaXplGC5BeGVzLkRlcHRoVG9wLklTdGFydFBvcxYuQXhlcy5EZXB0aFRvcC5JRW5kUG9zGC5BeGVzLkRlcHRoVG9wLklBeGlzU2l6ZRouQXhlcy5EZXB0aFRvcC5Jc0RlcHRoQXhpcxQuQXhlcy5EZXB0aC5JR2FwU2l6ZRUuQXhlcy5EZXB0aC5JU3RhcnRQb3MTLkF4ZXMuRGVwdGguSUVuZFBvcxUuQXhlcy5EZXB0aC5JQXhpc1NpemUXLkF4ZXMuRGVwdGguSXNEZXB0aEF4aXMAAAYAAAAAAQAEAAQAAAABAAAABAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAABBggICAEIJ1N0ZWVtYS5UZWVDaGFydC5Ub29scy5TY3JvbGxNb3VzZUFjdGlvbgIAAAAIKFN0ZWVtYS5UZWVDaGFydC5Ub29scy5TY3JvbGxUb29sVmlld1VuaXQCAAAAAQgIAQgIFFN5c3RlbS5EcmF3aW5nLkNvbG9yAwAAAAgICAgIAQgICAgBCAgICAEICAgIAQYdU3RlZW1hLlRlZUNoYXJ0LlBvc2l0aW9uVW5pdHMCAAAACAgICAEICAgIAQIAAAAAAAAAAAAAIEAJBAAAAAAAAAAAAAAAAAAAAAAGBQAAACBTdGVlbWEuVGVlQ2hhcnQuVG9vbHMuU2Nyb2xsVG9vbBQAAAAF+v///ydTdGVlbWEuVGVlQ2hhcnQuVG9vbHMuU2Nyb2xsTW91c2VBY3Rpb24BAAAAB3ZhbHVlX18ACAIAAAABAAAAAQAAAAX5////KFN0ZWVtYS5UZWVDaGFydC5Ub29scy5TY3JvbGxUb29sVmlld1VuaXQBAAAAB3ZhbHVlX18ACAIAAAAAAAAAAAAAAAAAAAAABggAAAAAAPMBAAAeAAAABff///8UU3lzdGVtLkRyYXdpbmcuQ29sb3IEAAAABG5hbWUFdmFsdWUKa25vd25Db2xvcgVzdGF0ZQEAAAAJBwcDAAAACgAAAAAAAAAAjQABAAkIAAAABgAAAAAAAAA7AAAAWwEAACABAAAAAAAAABwAAACgAgAAhAIAAAAAAAAAOwAAAFsBAAAgAQAAAAAAAAAcAAAAoAIAAIQCAAAAAAAAAAAAMMAF9v///x1TdGVlbWEuVGVlQ2hhcnQuUG9zaXRpb25Vbml0cwEAAAAHdmFsdWVfXwAIAgAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAABEQQAAAABAAAACQgAAAAL" 
                                                            GetChartFile="GetChart.aspx" Height="400px" TempChart="Session" 
                                                            Width="700px" />--%>
                                                        <dxchartsui:WebChartControl ID="ChartSleepMain" runat="server" Height="450px" style="margin:auto;"
                                                        Width="600px">
                                                        <diagramserializable>
                                                            <cc1:XYDiagram>
                                                                <axisx visibleinpanesserializable="-1">
                                                                    <range sidemarginsenabled="True" />
                                                                    <range sidemarginsenabled="True" />
                                                                    <range sidemarginsenabled="True" />
                                                                </axisx>
                                                                <axisy visibleinpanesserializable="-1">
                                                                    <range sidemarginsenabled="True" />
                                                                    <range sidemarginsenabled="True" />
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
                                                                ArgumentScaleType="DateTime" ValueDataMembersSerializable="SkinTemp">
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
                                                            </cc1:Series>
                                                        </seriesserializable>
                                                        <seriestemplate>
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
                                                </div>
                                                <br />
                                                <asp:Panel ID="pnHeartRateData" runat="server" Visible="False">                            
                                                    <asp:Panel runat="server" ID="pnllaa" ScrollBars="Horizontal">
                                                        <asp:Chart ID="Chart1" runat="server" Width="700px" Visible="False">
                                                            <Series>
                                                                <asp:Series Name="Series2" ChartType="Line">
                                                                </asp:Series>
                                                            </Series>
                                                        </asp:Chart>
                                                    </asp:Panel>                            
                                                    <br />
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
                                            
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                    <br />
                           
                                                </asp:Panel>
                                                <div align="center">
                                                <asp:Panel ID="pnEmptyData" runat="server" CssClass="panel_empty_data_body">
                                                    <asp:Label ID="Label1" runat="server" Text="You have no data to graph!"
                                                        ForeColor="Red"></asp:Label></asp:Panel></div>
                                                <div align="center"><asp:LinkButton ID="lbtnDateTime" runat="server" 
                                                        Font-Underline="False" onclick="lbtnDateTime_Click" 
                                                        oncommand="lbtnDateTime_Command">DateTime</asp:LinkButton></div>
                                                </div>
                    
                                            <asp:Panel ID="date_graph" CssClass="datetime_filter" runat="server" Visible="false">
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
                                                        </tr>
                                                        <tr>
                                                            <td style="padding:0px 5px 5px 0px;">
                                                                <asp:TextBox ID="txtFromDate" runat="server" Width="150"></asp:TextBox>
                                                                <asp:CalendarExtender
                                                                    ID="txtFromDate_CalendarExtender" runat="server" Enabled="True"
                                                                    TargetControlID="txtFromDate" CssClass="orange">
                                                                </asp:CalendarExtender>
                                                            </td>
                                                            <td style="padding-bottom:5px;">
                                                                <asp:TextBox ID="txtToDate" runat="server" Width="150"></asp:TextBox>
                                                                <asp:CalendarExtender ID="txtToDate_CalendarExtender"
                                                                    runat="server" Enabled="True" TargetControlID="txtToDate" 
                                                                    CssClass="orange">
                                                                </asp:CalendarExtender>
                                                            </td>
                                                        </tr>
                                                        <tr align="center">
                                                            <td colspan="2">
                                                                <asp:Button ID="btnOk" runat="server" Text="Select" onclick="btnOk_Click" CssClass="btn btn-default"/>
                                                                <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-default"
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
                                                <asp:DropDownList ID="ddl_Table" runat="server" CssClass="form-control"
                                                        AutoPostBack="True" onselectedindexchanged="ddl_Table_SelectedIndexChanged">
                                                    <asp:ListItem Value="1">Default data</asp:ListItem>
                                                    <asp:ListItem Value="0">Raw data</asp:ListItem>
                                                </asp:DropDownList>
                                                . Click drop-down list to select a different view.
                       
                                         </div>
                                         <div style="width:100%;text-align:center">
                                          &nbsp;&nbsp;&nbsp; <asp:LinkButton ID="lbtdatesleep" runat="server" onclick="lbtdatesleep_Click" CssClass="floatleft">DateTime</asp:LinkButton>
                                            <asp:DropDownList ID="ddlMonthly" runat="server">
                                            <asp:ListItem Value="0">Daily</asp:ListItem>
                                            <asp:ListItem Value="0">Weekly</asp:ListItem>
                                            <asp:ListItem Value="1">Monthly</asp:ListItem>
                                            </asp:DropDownList>
                                            <div class="clear"></div>
                                         </div>
                                        &nbsp;
               
                                        <div class="textcenter" style="margin-top:-15px"><h1 class="title"> Monthly statistics </h1></div>
                                        <asp:UpdatePanel ID="UpdateTable" runat="server">
                                        <ContentTemplate>
                                            <asp:Panel ID="table_item" runat="server" CssClass="table_item_sleep">
                       
                                                          <div class="title_grv">
                                                            <table>
                                                                <tr>
                                                                    <td style="width:150px;">
                                                                        Month
                                                                    </td>
                                                                    <td style="width:150px;">
                                                                        Sleep duration
                                                                    </td>
                                                                    <td style="width:120px;">
                                                                        Deep sleep
                                                                    </td>
                                                                    <td style="width:150px;">
                                                                        wake up#
                                                                    </td>
                                            
                                                                    <td style="width:150px;">
                                                                        Sleep quality
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                        <!-- Title -->
                                            <div class="content_grv_sleep">
                                            <asp:GridView ID="grvTemp" runat="server" AllowPaging="true" 
                                                AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
                                                BorderStyle="None" BorderWidth="1px" CellPadding="3" Width="100%" 
                                                EmptyDataText="There is no record to show !" PageSize="100" ShowHeader="False" >
                                                <Columns>
                                                    <asp:BoundField DataField="ReceivedDate" 
                                                        DataFormatString="{0:MM/dd/yyyy HH:mm:ss}" HeaderText="Month" >
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="" HeaderText="Sleep duration" >
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="" HeaderText="Deep sleep" >
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="" HeaderText="wake up#" >
                                                    <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                                                    </asp:BoundField>
                                                    <asp:BoundField HeaderText="Sleep quality" >
                                                    <ItemStyle Width="150px" />
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
                                                                <asp:Label ID="Label2" runat="server" Text="Records to display on 1 page: "></asp:Label>
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
                                                            <td style="width:150px;">
                                                               DateTime
                                                            </td>
                                                            <td style="width:80px;">
                                                                HR
                                                            </td>
                                                            <td style="width:80px;">
                                                                SkinTemp
                                                            </td>
                                                            <td style="width:80px;">
                                                                GSR
                                                            </td>
                                                            <td style="width:80px;">
                                                                X
                                                            <td style="width:80px;">
                                                                Y
                                                            </td>
                                                            <td style="width:80px;">
                                                                Y
                                                            </td>
                                                            <td style="width:230px;">
                                                                Diagnosis
                                                            </td>
                    
                                                        </tr>
                                                    </table>
                                                </div><!-- Title -->
                                                <div class="content_grv_sleep">
                                              <asp:GridView ID="grvRawData" runat="server" AutoGenerateColumns="False" 
                                                  EmptyDataText="no data" AllowPaging="false" PageSize="100" ShowHeader="False">
                                                  <Columns>
                                                      <asp:BoundField DataField="ReceivedDate" HeaderText="DateTime" DataFormatString="{0:MM/dd/yyyy HH:mm:ss}">
                                                      <ItemStyle Width="150px" />
                                                      </asp:BoundField>
                                                      <asp:BoundField DataField="HR" HeaderText="HR" >
                                                      <ItemStyle Width="80px" />
                                                      </asp:BoundField>
                                                      <asp:BoundField DataField="SkinTemp" HeaderText="SkinTemp" >
                                                      <ItemStyle Width="80px" />
                                                      </asp:BoundField>
                                                      <asp:BoundField DataField="GSR" HeaderText="GSR" >
                                                      <ItemStyle Width="80px" />
                                                      </asp:BoundField>
                                                      <asp:BoundField DataField="ValueX" HeaderText="ValueX" >
                                                      <ItemStyle Width="80px" />
                                                      </asp:BoundField>
                                                      <asp:BoundField DataField="ValueY" HeaderText="ValueY" >
                                                      <ItemStyle Width="80px" />
                                                      </asp:BoundField>
                                                      <asp:BoundField DataField="ValueZ" HeaderText="ValueZ" >
                                                      <ItemStyle Width="80px" />
                                                      </asp:BoundField>
                                                      <asp:BoundField DataField="Diagnosis" HeaderText="Diagnosis" >
                                                      <ItemStyle Width="300px" />
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
                                                            <td style="width:60%;text-align:center">
                                                            <!-- add new -->
                                                                        <asp:Label ID="Label3" runat="server" Text="Records to display on 1 page: "></asp:Label>
                                                                        <asp:DropDownList ID="ddlNo2" runat="server" AutoPostBack="True" onselectedindexchanged="ddlNo2_SelectedIndexChanged" >
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
                
                                       <asp:Panel ID="date_table" CssClass="datetime_filter" runat="server" Visible="false">
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
                                                                <asp:Button ID="btn_Ok_Table" runat="server" Text="Select" onclick="btn_Ok_Table_Click"  />
                                                                <asp:Button ID="btncancel2" runat="server" Text="Cancel"  onclick="btncancel2_Click" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </div>
                                        </asp:Panel>
                                        </div><!-- end item -->
                                    </asp:View>
                                </asp:MultiView>
                            </div><!-- print--> 
                            <br />
                            <div class="border-top-bottom">
                                <div class="title">
                                    Diagnosis & Recommendations</div>
                                <div class="">
                                    This page displays your current mediacal issues and the date that they were noded
                                    in your medical record. Click on the issue name for more in-depth information on
                                    that particular issue.
                                </div>
                            </div>   
                            <div class="no-border" style="margin-top: 10px;">
                                <asp:Button ID="Button1" runat="server" Text="Settings" CssClass="btn btn-default"
                                        PostBackUrl="~/usertrackmyhealth_sleep_settings.aspx" />
                                <asp:Button ID="Button2" runat="server" Text="Back to Track my health" CssClass="btn btn-default"
                                        PostBackUrl="~/usertrackmyhealth.aspx" />
                            </div>
                            <asp:UpdateProgress ID="UpadateProc" AssociatedUpdatePanelID="UpdateTable" runat="server">
                                <ProgressTemplate>
                                        <div class="loading">
                                            <img src="resources/images/process.gif" />
                                        </div>
                                </ProgressTemplate>
                            </asp:UpdateProgress>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

