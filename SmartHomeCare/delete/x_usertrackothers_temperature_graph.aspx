<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="x_usertrackothers_temperature_graph.aspx.cs" Inherits="usertrackothers_temperature_graph" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <script src="scripts/Print.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
<div id="print">
    <div class="borderbottom">
        <div class="floatleft title">Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health<br />Temperature</div>
        <div class="floatright"> <asp:LinkButton runat="server" ID="lb" Text="Print" OnClientClick="return printDiv('print');"></asp:LinkButton>     <a href="userhelp.aspx">Help</a></div>
        <div class="clear"></div>
    </div>
    <br />
     <div class="clear borderbottom">
        <table class="clear" width="100">
            <tr>
                <td><asp:Button ID="btngraph" runat="server" Text="Graph" /></td>
                <td><asp:Button ID="btntable" runat="server" Text="Table" 
                        PostBackUrl="~/usertrackothers_temperature_table.aspx" 
                        onclick="btntable_Click" ForeColor="Gray" /></td>
            </tr>
        </table>
        
        <div id="chart">
            <asp:Chart ID="ChartTemperature" runat="server" AntiAliasing="Text" 
                BackColor="AliceBlue" BorderlineWidth="3" Width="450px">
                <Series>
                    <asp:Series Name="SkinTemp" ChartType="Line" Color="Red" 
                        XValueMember="ReceivedDate" YValueMembers="SkinTemp">
                    </asp:Series>
                    <asp:Series ChartArea="ChartAreaTemperature" ChartType="Line" Color="64, 64, 64" 
                        Name="AmbTemp" XValueMember="ReceivedDate" YValueMembers="AmbTemp">
                    </asp:Series>
                </Series>
                <ChartAreas>
                    <asp:ChartArea Name="ChartAreaTemperature" BorderColor="Transparent">
                        <AxisY Title="Temperature">
                        </AxisY>
                        <AxisX Title="Date" IsLabelAutoFit="False">
                            <LabelStyle Angle="-30" />
                            <ScaleBreakStyle LineDashStyle="NotSet" />
                        </AxisX>
                    </asp:ChartArea>
                </ChartAreas>
                <BorderSkin BorderColor="Transparent" BorderWidth="0" />
            </asp:Chart>
            <asp:Label ID="lbDataEmpty" CssClass="emptydata" runat="server" Text="There is no data to display!" 
                Visible="False" ForeColor="Red"></asp:Label>
        </div>
        </div>
        </div>
        <div>
            
            <table>
                <tr>
                    <td>
                    From date:<asp:Label ID="Label1" runat="server" 
                            Text="(mm/dd/yyyy hh:mm) " Font-Italic="True" Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                         <asp:TextBox ID="txtFromDate" runat="server" Width="220px"></asp:TextBox>
                          <asp:CalendarExtender ID="txtFromDate_CalendarExtender" runat="server" 
                            CssClass="orange" Enabled="True" TargetControlID="txtFromDate">
                        </asp:CalendarExtender>
                    </td>
                    <td>
                        <asp:DropDownList ID="drpFromH" runat="server" Width="50px">
                        </asp:DropDownList>
                        :
                        <asp:DropDownList ID="drpFromM" runat="server" Width="50px">
                        </asp:DropDownList>
                    </td>
                    <td rowspan="2">
                    <asp:Button ID="btnFilter" runat="server" onclick="btnFilter_Click" Text="View" 
                            Height="47px" Width="57px" />
                    </td>
                </tr>
                <tr>
                    <td>
                        To Date:<asp:Label ID="Label2" runat="server" Text="(mm/dd/yyyy hh:mm) " 
                            Font-Italic="True" Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtToDate" runat="server" Width="220px"></asp:TextBox>
                        <asp:CalendarExtender ID="txtToDate_CalendarExtender" runat="server" 
                                CssClass="orange" Enabled="True" TargetControlID="txtToDate">
                            </asp:CalendarExtender>
                    </td>
                    <td>
                        <asp:DropDownList ID="drpToH" runat="server" Width="50px">
                        </asp:DropDownList>
                        : <asp:DropDownList ID="drpToM" runat="server" Width="50px">
                        </asp:DropDownList>
                    </td>
                </tr>
              
            </table>
            
        </div>

    
    
    <br />
     <div class="clear">
        <div class="title">Diagnosis & Recommendationsss>Diagnosis & Recommendationsss</div>
        <div class="borderbottom">This page displays your current mediacal issues and the date that they were noded in your 
            medical record. Click on the issue name for more in-depth information on that particular issue.
        </div>
        <br />
     </div>
       
        <table class="clear" width="200">
            <tr>
                <td><asp:Button ID="Button1" runat="server" Text="Settings" 
                        onclick="Button1_Click" /></td>
                <td><asp:Button ID="Button2" runat="server" Text="Back to Track other" 
                        PostBackUrl="~/usertrackothers.aspx" /></td>
            </tr>
        </table>
    
</asp:Content>

