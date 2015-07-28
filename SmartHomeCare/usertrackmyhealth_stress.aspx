<%@ Page Title="Stress Monitoring" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="usertrackmyhealth_stress.aspx.cs" Inherits="usertrackmyhealth_stress" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<%@ Register assembly="TeeChart" namespace="Steema.TeeChart.Web" tagprefix="tchart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">

    <link href="styles/tab.css" rel="stylesheet" type="text/css" />
    <link href="styles/control.css" rel="stylesheet" type="text/css" />
    <link href="styles/Stress.css" rel="stylesheet" type="text/css" />
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
                Position monitoring
                <div class="floatright">
                    <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                </div>
            </div>
            <div class="panel-body">
                <div class="row">
                    <div class="col-lg-6" style="width:100%;">
                        <div id="print">
                         Select GRAPH or TABLE buttons to see Stress monitoring Report.
                            <div style="padding-top:10px;">
                                <asp:Button ID="btnGraph2" runat="server" OnClick="btnGraph2_Click" Text="Graph" CssClass="btn btn-default"/>
                                <asp:Button ID="btnTable2" runat="server" OnClick="btnTable2_Click" Text="Table" CssClass="btn btn-default" style="color:#000;"/>
                            </div>
                            <asp:MultiView ID="MultiViewStress" runat="server" ActiveViewIndex="0">
                                <asp:View ID="ViewGraph" runat="server">
                                <div class="item_report">
                                    <div id="chart">
                     
                                            <div class="select_data">
                                                Report is viewed with:
                                                <asp:DropDownList ID="ddl_graph" runat="server" CssClass="form-control"
                                                    AutoPostBack="True" style="width:30%;display:inline;"
                                                    onselectedindexchanged="ddl_graph_SelectedIndexChanged" >
                                                    <asp:ListItem Value="1">% Stress</asp:ListItem>
                                                    <asp:ListItem Value="0">Raw data</asp:ListItem>
                                                </asp:DropDownList>
                                                . Click drop-down list to select a different view.
                                            </div>
                                            <asp:Panel ID="pnStress" runat="server">                            
                                                <tchart:WebChart ID="WebChartStress" runat="server" AutoPostback="False" 
                                                    GetChartFile="GetChart.aspx" Height="400px" TempChart="Session" Width="700px" 
                                                    Config="AAEAAAD/////AQAAAAAAAAAMAgAAAFJUZWVDaGFydCwgVmVyc2lvbj00LjEuMjAxMy4xMTA4NiwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj05YzgxMjYyNzZjNzdiZGI3DAMAAABRU3lzdGVtLkRyYXdpbmcsIFZlcnNpb249NC4wLjAuMCwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj1iMDNmNWY3ZjExZDUwYTNhBQEAAAAVU3RlZW1hLlRlZUNoYXJ0LkNoYXJ0OAAAABAuQ3VzdG9tQ2hhcnRSZWN0EC5QYW5lbC5NYXJnaW5Ub3ATLlBhbmVsLk1hcmdpbkJvdHRvbQ8uTGVnZW5kLlZpc2libGUNLkhlYWRlci5MaW5lcxkuQXNwZWN0LkNvbG9yUGFsZXR0ZUluZGV4EC5Bc3BlY3QuSGVpZ2h0M0QPLkFzcGVjdC5XaWR0aDNEDi5Bc3BlY3QuVmlldzNEB1Rvb2xzLjAYLlRvb2xzLjAuVmlld1NlZ21lbnRTaXplFC5Ub29scy4wLk1vdXNlQWN0aW9uFi5Ub29scy4wLlN0YXJ0UG9zaXRpb24ZLlRvb2xzLjAuU2VnbWVudFZpZXdVbml0cxwuVG9vbHMuMC5BdHRyaWJ1dGVzLkRyYWdab29tHy5Ub29scy4wLkF0dHJpYnV0ZXMuQ2FudmFzSW5kZXgeLlRvb2xzLjAuQXR0cmlidXRlcy5GaWxsVHJhbnNwHC5Ub29scy4wLkF0dHJpYnV0ZXMuSW1hZ2VTdHIjLlRvb2xzLjAuQXR0cmlidXRlcy5Ob0NsaWNrUG9zdGJhY2sYLlRvb2xzLjAuWm9vbUNhbnZhc0luZGV4HS5Ub29scy4wLlpvb21GaWxsVHJhbnNwYXJlbmN5FS5Ub29scy4wLlpvb21QZW5Db2xvchguVG9vbHMuMC5DdXN0b21WYXJpYWJsZXMSLkF4ZXMuTnVtRml4ZWRBeGVzEy5BeGVzLkxlZnQuSUdhcFNpemUULkF4ZXMuTGVmdC5JU3RhcnRQb3MSLkF4ZXMuTGVmdC5JRW5kUG9zFC5BeGVzLkxlZnQuSUF4aXNTaXplFi5BeGVzLkxlZnQuSXNEZXB0aEF4aXMSLkF4ZXMuVG9wLklHYXBTaXplEy5BeGVzLlRvcC5JU3RhcnRQb3MRLkF4ZXMuVG9wLklFbmRQb3MTLkF4ZXMuVG9wLklBeGlzU2l6ZRUuQXhlcy5Ub3AuSXNEZXB0aEF4aXMULkF4ZXMuUmlnaHQuSUdhcFNpemUVLkF4ZXMuUmlnaHQuSVN0YXJ0UG9zEy5BeGVzLlJpZ2h0LklFbmRQb3MVLkF4ZXMuUmlnaHQuSUF4aXNTaXplFy5BeGVzLlJpZ2h0LklzRGVwdGhBeGlzFS5BeGVzLkJvdHRvbS5JR2FwU2l6ZRYuQXhlcy5Cb3R0b20uSVN0YXJ0UG9zFC5BeGVzLkJvdHRvbS5JRW5kUG9zFi5BeGVzLkJvdHRvbS5JQXhpc1NpemUYLkF4ZXMuQm90dG9tLklzRGVwdGhBeGlzHS5BeGVzLkJvdHRvbS5SZWxhdGl2ZVBvc2l0aW9uGi5BeGVzLkJvdHRvbS5Qb3NpdGlvblVuaXRzFy5BeGVzLkRlcHRoVG9wLklHYXBTaXplGC5BeGVzLkRlcHRoVG9wLklTdGFydFBvcxYuQXhlcy5EZXB0aFRvcC5JRW5kUG9zGC5BeGVzLkRlcHRoVG9wLklBeGlzU2l6ZRouQXhlcy5EZXB0aFRvcC5Jc0RlcHRoQXhpcxQuQXhlcy5EZXB0aC5JR2FwU2l6ZRUuQXhlcy5EZXB0aC5JU3RhcnRQb3MTLkF4ZXMuRGVwdGguSUVuZFBvcxUuQXhlcy5EZXB0aC5JQXhpc1NpemUXLkF4ZXMuRGVwdGguSXNEZXB0aEF4aXMAAAAABgAAAAABAAQABAAAAAEAAAAEAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAEGBgEICAgBCCdTdGVlbWEuVGVlQ2hhcnQuVG9vbHMuU2Nyb2xsTW91c2VBY3Rpb24CAAAACChTdGVlbWEuVGVlQ2hhcnQuVG9vbHMuU2Nyb2xsVG9vbFZpZXdVbml0AgAAAAEICAEICBRTeXN0ZW0uRHJhd2luZy5Db2xvcgMAAAAICAgICAEICAgIAQgICAgBCAgICAEGHVN0ZWVtYS5UZWVDaGFydC5Qb3NpdGlvblVuaXRzAgAAAAgICAgBCAgICAECAAAAAAAAAAAAAABAAAAAAAAAIEAACQQAAAAAAAAAAAAAAAAAAAAABgUAAAAgU3RlZW1hLlRlZUNoYXJ0LlRvb2xzLlNjcm9sbFRvb2wUAAAABfr///8nU3RlZW1hLlRlZUNoYXJ0LlRvb2xzLlNjcm9sbE1vdXNlQWN0aW9uAQAAAAd2YWx1ZV9fAAgCAAAAAQAAAAEAAAAF+f///yhTdGVlbWEuVGVlQ2hhcnQuVG9vbHMuU2Nyb2xsVG9vbFZpZXdVbml0AQAAAAd2YWx1ZV9fAAgCAAAAAQAAAAAAAAAAAAAAAAYIAAAAAADzAQAAHgAAAAX3////FFN5c3RlbS5EcmF3aW5nLkNvbG9yBAAAAARuYW1lBXZhbHVlCmtub3duQ29sb3IFc3RhdGUBAAAACQcHAwAAAAoAAAAAAAAAAI0AAQAJCAAAAAYAAAAAAAAAMwAAAFsBAAAoAQAAAAAAAAAcAAAAoAIAAIQCAAAAAAAAADMAAABbAQAAKAEAAAAAAAAAHAAAAKACAACEAgAAAAAAAAAAADDABfb///8dU3RlZW1hLlRlZUNoYXJ0LlBvc2l0aW9uVW5pdHMBAAAAB3ZhbHVlX18ACAIAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAREEAAAAAQAAAAkIAAAACw==" />
                                              </asp:Panel>
                                            <asp:Panel ID="pnRawData" runat="server">
                                                <div align="center">
                                                    <asp:Chart ID="ChartDrawData" runat="server" BorderlineWidth="0" Width="700px" 
                                                    Height="400px">
                                                    <Series>
                                                        <asp:Series ChartArea="HR" ChartType="StepLine" Color="Red" Name="SR_HR" 
                                                            XValueMember="ReceivedDate" YValueMembers="HR">
                                                        </asp:Series>
                                                        <asp:Series ChartArea="HR Voltarage" ChartType="Line" Color="Yellow" 
                                                            Name="SR_HRVoltage" XValueMember="ReceivedDate" YValueMembers="HRVoltage">
                                                        </asp:Series>
                                                        <asp:Series ChartArea="GSR" ChartType="Line" Color="64, 64, 64" Name="SR_GSR" 
                                                            XValueMember="ReceivedDate" YValueMembers="GSR">
                                                        </asp:Series>
                                                        <asp:Series ChartArea="X" ChartType="Line" Color="Green" Name="SR_X" 
                                                            XValueMember="ReceivedDate" YValueMembers="ValueX">
                                                        </asp:Series>
                                                        <asp:Series ChartArea="Y" ChartType="Line" Color="192, 0, 0" Name="SR_Y" 
                                                            XValueMember="ReceivedDate" YValueMembers="ValueY">
                                                        </asp:Series>
                                                        <asp:Series ChartArea="Z" ChartType="Line" Color="Blue" Name="SR_Z" 
                                                            XValueMember="ReceivedDate" YValueMembers="ValueZ">
                                                        </asp:Series>
                                                    </Series>
                                                    <ChartAreas>
                                                        <asp:ChartArea BorderColor="Transparent" BorderWidth="0" Name="HR">
                                                            <AxisY>
                                                                <MajorGrid Enabled="False" />
                                                                <LabelStyle ForeColor="Transparent" />
                                                            </AxisY>
                                                            <AxisX LineColor="Transparent">
                                                                <MajorGrid Enabled="False" />
                                                                <MinorGrid LineWidth="0" />
                                                                <LabelStyle ForeColor="Transparent" />
                                                            </AxisX>
                                                            <Position Height="20" Width="80" Auto="False" />
                                                            <InnerPlotPosition Height="40" Width="80" X="20" Y="14" Auto="False" />
                                                        </asp:ChartArea>
                                                        <asp:ChartArea BorderWidth="0" Name="HR Voltarage">
                                                            <AxisY>
                                                                <MajorGrid Enabled="False" />
                                                                <LabelStyle ForeColor="Transparent" />
                                                            </AxisY>
                                                            <AxisX>
                                                                <MajorGrid Enabled="False" />
                                                                <LabelStyle ForeColor="Transparent" />
                                                            </AxisX>
                                                            <Position Height="20" Width="80" Y="15" Auto="False" />
                                                            <InnerPlotPosition Height="40" Width="80" X="20" Y="14" Auto="False" />
                                                        </asp:ChartArea>
                                                        <asp:ChartArea BorderWidth="0" Name="GSR">
                                                            <AxisY>
                                                                <MajorGrid Enabled="False" />
                                                                <LabelStyle ForeColor="Transparent" />
                                                            </AxisY>
                                                            <AxisX>
                                                                <MajorGrid Enabled="False" />
                                                                <LabelStyle ForeColor="Transparent" />
                                                            </AxisX>
                                                            <Position Height="20" Width="80" Y="30" Auto="False" />
                                                            <InnerPlotPosition Height="40" Width="80" X="20" Y="14" Auto="False" />
                                                        </asp:ChartArea>
                                                        <asp:ChartArea BorderWidth="0" Name="X">
                                                            <AxisY>
                                                                <MajorGrid Enabled="False" />
                                                                <LabelStyle ForeColor="Transparent" />
                                                            </AxisY>
                                                            <AxisX>
                                                                <MajorGrid Enabled="False" />
                                                                <LabelStyle ForeColor="Transparent" />
                                                            </AxisX>
                                                            <Position Height="20" Width="80" Y="45" Auto="False" />
                                                            <InnerPlotPosition Height="40" Width="80" X="20" Y="14" Auto="False" />
                                                        </asp:ChartArea>
                                                        <asp:ChartArea BorderWidth="0" Name="Y">
                                                            <AxisY>
                                                                <MajorGrid Enabled="False" />
                                                                <LabelStyle ForeColor="Transparent" />
                                                            </AxisY>
                                                            <AxisX>
                                                                <MajorGrid Enabled="False" />
                                                                <LabelStyle ForeColor="Transparent" />
                                                            </AxisX>
                                                            <Position Height="20" Width="80" Y="60" Auto="False" />
                                                            <InnerPlotPosition Height="40" Width="80" X="20" Y="14" Auto="False" />
                                                        </asp:ChartArea>
                                                        <asp:ChartArea BorderWidth="0" Name="Z">
                                                            <AxisY>
                                                                <MajorGrid Enabled="False" />
                                                                <LabelStyle ForeColor="Transparent" />
                                                            </AxisY>
                                                            <AxisX IsLabelAutoFit="False">
                                                                <MajorGrid Enabled="False" />
                                                                <LabelStyle ForeColor="DimGray" Angle="-30" Font="Microsoft Sans Serif, 6.75pt" 
                                                                    Format="MM/dd/yy" />
                                                            </AxisX>
                                                            <Position Height="20" Width="80" Y="75" Auto="False" />
                                                            <InnerPlotPosition Height="40" Width="80" X="20" Y="14" Auto="False" />
                                                        </asp:ChartArea>
                                                    </ChartAreas>
                                                    <Titles>
                                                        <asp:Title Name="HR" Text="HR">
                                                            <Position Height="4.48369551" Width="15" Y="5" Auto="False" />
                                                        </asp:Title>
                                                        <asp:Title Name="HRVoltage" Text="HR Voltage">
                                                            <Position Height="4.48369551" Width="15" Y="20" Auto="False" />
                                                        </asp:Title>
                                                        <asp:Title Name="GSR" Text="GSR">
                                                            <Position Height="4.48369551" Width="15" Y="35" Auto="False" />
                                                        </asp:Title>
                                                        <asp:Title Name="X" Text="X">
                                                            <Position Height="4.48369551" Width="15" Y="50" Auto="False" />
                                                        </asp:Title>
                                                        <asp:Title Name="Y" Text="Y">
                                                            <Position Height="4.48369551" Width="15" Y="65" Auto="False" />
                                                        </asp:Title>
                                                        <asp:Title Name="Z" Text="Z">
                                                            <Position Height="4.48369551" Width="15" Y="80" Auto="False" />
                                                        </asp:Title>
                                                    </Titles>
                                                    <BorderSkin BackColor="ControlDark" SkinStyle="Emboss" />
                                                </asp:Chart>
                                                </div>
                                            </asp:Panel>
                                            <br />
                                            <div align="center" style="width: 100%;">
                                                <asp:Panel ID="pnEmptyData" runat="server" CssClass="panel_empty_data">
                                                    <asp:Label ID="lbDataEmpty" runat="server" Text="You have no data to graph!" ForeColor="Red"></asp:Label></asp:Panel>
                                            </div>
                                            <div align="center" style="width: 100%;">
                                                <asp:LinkButton ID="lbtnDateTime" runat="server" Font-Underline="False" 
                                                    onclick="lbtnDateTime_Click">DateTime</asp:LinkButton>
                                            </div>
                                            </div>
                                    <asp:Panel ID="date_graph" CssClass="datetime_filter" runat="server" 
                                        Visible="False">
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
                                                        <asp:Button ID="btnCancel" runat="server" Text="Cancel" 
                                                            onclick="btnCancel_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </asp:Panel>
                                    </div>
                                </asp:View>
                                <asp:View ID="ViewTable" runat="server">
                                <div class="item_report">
                                        <div class="select_data">
                                            Report is viewed with:
                                            <asp:DropDownList ID="ddl_Table" runat="server" CssClass="dropdown" 
                                                    AutoPostBack="True" onselectedindexchanged="ddl_Table_SelectedIndexChanged">
                                                <asp:ListItem Value="1">% Stress</asp:ListItem>
                                                <asp:ListItem Value="0">Raw data</asp:ListItem>
                                            </asp:DropDownList>
                                            . Click drop-down list to select a different view.
                                        </div>
                                         <asp:UpdatePanel ID="UpdateTable" runat="server">
                                        <ContentTemplate>
                                        <asp:Panel runat="server" ID="table_item2" Visible="False" CssClass="table_item">
                                                      <div class="title_grv">
                                                        <table>
                                                            <tr>
                                                                <td style="width:150px;">
                                                
                                                                </td>
                                                                <td style="width:80px;">
                                                                    HR
                                                                </td>
                                                                <td style="width:80px;">
                                                                    HRVoltage
                                                                </td>
                                                                <td style="width:80px;">
                                                                    GSR
                                                                </td>
                                                                <td style="width:80px;">
                                                                    X
                                                                </td>
                                                                <td style="width:80px;">
                                                                    Y
                                                                </td>
                                                                <td style="width:80px;">
                                                                    Z
                                                                </td>
                                                                <td style="width:200px;">
                                                                    Diagn
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <!-- Title -->
                                                    <div class="content_grv" style="height:392px">
                                                        <asp:GridView ID="grvRawData_Stress" runat="server" 
                                                            AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
                                                            BorderStyle="None" BorderWidth="1px" CellPadding="3" Width="100%" 
                                                            EmptyDataText=" There is no record to show !" 
                                                            onpageindexchanging="grvRawData_Stress_PageIndexChanging" PageSize="50" 
                                                            ShowHeader="False" 
                                                            onselectedindexchanged="grvRawData_Stress_SelectedIndexChanged" 
                                                            AllowPaging="True" >
                                                            <Columns>
                                                                <asp:BoundField DataField="ReceivedDate" 
                                                                    DataFormatString="{0:MM/dd/yyyy HH:mm:ss}">
                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="HR" HeaderText="HR" >
                                                                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="80px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="HRVoltage" HeaderText="HRVoltage" >
                                                                <ItemStyle Width="80px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="GSR" HeaderText="GSR" >
                                                                <ItemStyle Width="80px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="ValueX" HeaderText="X" >
                                                                <ItemStyle Width="80px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="ValueY" HeaderText="Y" >
                                                                <ItemStyle Width="80px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="ValueZ" HeaderText="Z" >
                                                                <ItemStyle Width="80px" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="Diagnosis" HeaderText="Diagnostics">
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
                                                        <table style="margin:auto;">
                                                            <tr>
                                                                <td style="width:5%;text-align:left">
                                                                    <asp:ImageButton ID="btnback" runat="server" Height="26px" 
                                                                        ImageUrl="~/resources/images/Previous-icon.png" OnClick="back_Click" 
                                                                        Width="26px" />
                                                                </td>
                                                                <td style="width:50%; text-align:center">
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
                                                                    <asp:Label ID="lb_pager" runat="server" Text="Page: 1/10"></asp:Label>
                                                                </td>
                                                                <td style="width:5%;text-align:right">
                                                                    <asp:ImageButton ID="btnnext" runat="server" Height="26px" 
                                                                        ImageUrl="~/resources/images/next.jpg" OnClick="next_Click" Width="26px" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <!-- footer -->
                              
                                        </asp:Panel>
                                        <asp:Panel runat="server" ID="table_item" CssClass="table_item">
                        
                                                      <div class="title_grv">
                                                        <table>
                                                            <tr>
                                                                <td style="width:130px;">
                                                
                                                                </td>
                                                                <td style="width:100px;">
                                                                    Stresslevel
                                                                </td>
                                            
                                            
                                                                <td style="width:400px;">
                                                                    Diagnosis
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <!-- Title -->
                                                    <div class="content_grv" style="height:392px">
                                                          <asp:GridView ID="grvDataStress" runat="server" AutoGenerateColumns="False" 
                                                              Width="100%" EmptyDataText=" There is no record to show !" 
                                                              onpageindexchanging="grvDataStress_PageIndexChanging" 
                                                              PageSize="100" ShowHeader="False" AllowPaging="True">
                                                              <Columns>
                                                                  <asp:BoundField DataField="ReceivedDate" 
                                                                      DataFormatString="{0:MM/dd/yyyy HH:mm:ss}" >
                                                                  <ItemStyle Width="150px" />
                                                                  </asp:BoundField>
                                                                  <asp:BoundField DataField="Stresslevel" HeaderText="Stresslevel" >
                                                                  <ItemStyle Width="100px" />
                                                                  </asp:BoundField>
                                                                  <asp:BoundField DataField="Diagnosis" HeaderText="Diagnosis" />
                                                              </Columns>
                                                              <PagerSettings Visible="False" />
                                                          </asp:GridView>
                                     
                                                    </div><!-- table -->
                                
                                                        <div class="footer_grv">
                                                            <table style="margin:auto;">
                                                                <tr>
                                                                    <td style="width:5%;text-align:left">
                                                                        <asp:ImageButton ID="btn_back1" runat="server" Height="26px" 
                                                                            ImageUrl="~/resources/images/Previous-icon.png" Width="26px" 
                                                                            onclick="btn_back1_Click"/>
                                                                    </td>
                                                                    <td style="width:50%;text-align:center">
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
                                                                        <asp:Label ID="lbpage2" runat="server" Text="/10"></asp:Label>
                                                                    </td>
                                                                    <td style="width:5%;text-align:right">
                                                                        <asp:ImageButton ID="btn_next2" runat="server" Height="26px" 
                                                                            ImageUrl="~/resources/images/next.jpg" Width="26px" 
                                                                            onclick="btn_next2_Click"  />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div><!-- footer -->
                                    
                                        </asp:Panel><!-- table item -->
                                        <div align="center" style="width: 450px;margin:auto;">
                                        <asp:LinkButton ID="lbPopup" runat="server"
                                            onclick="lbPopup_Click">DateTime</asp:LinkButton>
                                        </div>
                                    </ContentTemplate>
                                    </asp:UpdatePanel>
                                   <asp:Panel ID="date_table" CssClass="datetime_filter" runat="server"  Visible="False">
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
                                                            &nbsp;</td>
                                                    </tr>
                                                    <tr>
                                                        <td style="padding:0px 5px 5px 0px;">
                                                            <asp:TextBox ID="txtFromDate2" runat="server" Width="150"></asp:TextBox>

                                                            <asp:CalendarExtender ID="txtFromDate2_CalendarExtender" runat="server" 
                                                                Enabled="True" TargetControlID="txtFromDate2" CssClass="orange">
                                                            </asp:CalendarExtender>
                                                        </td>
                                                        <td style="padding-bottom:5px;">
                                                            <asp:TextBox ID="txtToDate2" runat="server" Width="150"></asp:TextBox>
                                                            <asp:CalendarExtender ID="txtToDate2_CalendarExtender" runat="server" 
                                                                Enabled="True" TargetControlID="txtToDate2" CssClass="orange">
                                                            </asp:CalendarExtender>
                                                        </td>
                                                        <td>
                                                        </td>
                                                    </tr>
                                
                                
                                                    <tr align="center">
                                                        <td colspan="3">
                                                            <asp:Button ID="btnOk2" runat="server" Text="Select" onclick="btnOk2_Click" />
                                                            <asp:Button ID="btnCancel2" runat="server" Text="Cancel" 
                                                                onclick="btnCancel2_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                        </asp:Panel>
                                    </div><!-- item -->
                                </asp:View>
                            </asp:MultiView>
                        <br />
    
                    </div><!-- print-->
                        <br />
                        <div class="border-top-bottom">
                            <div class="title">Diagnosis &amp; Recommendations</div>
                            <div class="">This page displays your current mediacal issues and the date that they were noded in your 
                                medical record. Click on the issue name for more in-depth information on that particular issue.
                            </div>
                        </div>
                        <div class="no-border" style="margin-top: 10px;">
                            <asp:Button ID="Button1" runat="server" Text="Settings" CssClass="btn btn-default"
                                    PostBackUrl="~/usertrackmyhealth_stress_settings.aspx" />
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

