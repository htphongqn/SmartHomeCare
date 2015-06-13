<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="xx_usertrackother_temperature.aspx.cs" Inherits="usertrackmyhealth_temperature_graph" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <script src="scripts/Print.js" type="text/javascript"></script>
    <link href="styles/control.css" rel="stylesheet" type="text/css" />
    <link href="styles/tab.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    
    
    <div class="borderbottom">
        <div class="floatleft title">Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health<br />Temperature</div>
        <div class="floatright"> <asp:LinkButton runat="server" CssClass="clprint"  ID="lb" Text="Print" OnClientClick="return printDiv('print');"> </asp:LinkButton>&nbsp;<a href="userhelp.aspx" target="_blank">Help</a></div>
        <div class="clear"></div>
    </div>
    <br />
       <div class="search">
            <table>
                <tr>
                    <td>
                    From date:<asp:Label 
                            ID="Label1" runat="server" Text="(mm/dd/yyyy hh:mm) " Font-Italic="True" 
                            Font-Size="Small"></asp:Label>
                    </td>
                    <td>
                         <asp:TextBox ID="txtFromDate" runat="server" Width="220px" CssClass="input"></asp:TextBox>
                          <asp:CalendarExtender ID="txtFromDate_CalendarExtender" runat="server" 
                            CssClass="orange" Enabled="True" TargetControlID="txtFromDate">
                        </asp:CalendarExtender>
                    </td>
                    <td>
                        <asp:DropDownList ID="drpFromH" runat="server" Width="50px">
                        </asp:DropDownList>
                        :
                        <asp:DropDownList ID="drpFromM" runat="server" Width="50px" >
                        </asp:DropDownList>
                    </td>
                    <td rowspan="2">
                    <asp:Button ID="btnFilter" runat="server" onclick="btnFilter_Click" Text="View"  CssClass="btn_view" />
                    </td>
                </tr>
                <tr>
                    <td>
                        To Date: <asp:Label ID="Label2" runat="server" Text="(mm/dd/yyyy hh:mm) " 
                            Font-Italic="True" Font-Size="Small" ></asp:Label>
                    </td>
                    <td>
                        <asp:TextBox ID="txtToDate" runat="server" Width="220px" CssClass="input"></asp:TextBox>
                        <asp:CalendarExtender ID="txtToDate_CalendarExtender" runat="server" 
                                CssClass="orange" Enabled="True" TargetControlID="txtToDate">
                            </asp:CalendarExtender>
                    </td>
                    <td>
                        <asp:DropDownList ID="drpToH" runat="server" Width="50px" >
                        </asp:DropDownList>
                        : <asp:DropDownList ID="drpToM" runat="server" Width="50px">
                        </asp:DropDownList>
                    </td>
                </tr>
              
            </table>
            

            
        </div>
     <div class="clear borderbottom">
         <div class="clear">

          
         <div id="print">
        <asp:TabContainer ID="tabGrad" runat="server" ActiveTabIndex="1" CssClass="mytab" 
                 Width="98%">
            <asp:TabPanel runat="server" HeaderText="Graph" ID="Grad" TabIndex="0">
                <ContentTemplate>
                    <div id="chart">
                        <asp:Chart ID="ChartTemperature" runat="server" AntiAliasing="Text" 
                            BorderlineWidth="3" Width="450px">
                            <Series>
                                <asp:Series Name="SkinTemp" ChartType="Line" Color="Red" 
                                    XValueMember="ReceivedDate" YValueMembers="SkinTempC" 
                                    ChartArea="ChartAreaTemperature">
                                </asp:Series>
                                <asp:Series ChartArea="ChartAreaTemperature" ChartType="Line" Color="64, 64, 64" 
                                    Name="AmbTemp" XValueMember="ReceivedDate" YValueMembers="AmbTempC">
                                </asp:Series>
                            </Series>
                            <ChartAreas>
                                <asp:ChartArea Name="ChartAreaTemperature" BorderColor="Transparent">
                                    <AxisY Title="oC / oF">
                                    </AxisY>
                                    <AxisX Title="Time" IsLabelAutoFit="False">
                                        <LabelStyle Angle="-30" Format="yyyy-MM-dd HH:mm" />
                                        <ScaleBreakStyle LineDashStyle="NotSet" />
                                    </AxisX>
                                    <AxisX2>
                                        <LabelStyle Format="yyyy-MM-dd HH:mm" />
                                    </AxisX2>
                                </asp:ChartArea>
                            </ChartAreas>
                            <BorderSkin BorderColor="Transparent" BorderWidth="0" />
                        </asp:Chart>
                            <asp:Label ID="lbDataEmpty" runat="server" Text="There is no data to display!" 
                            Visible="False" ForeColor="Red"></asp:Label>
            
                    </div>
                </ContentTemplate>
                    
            </asp:TabPanel>
            <asp:TabPanel ID="Table" runat="server" HeaderText="Table" TabIndex="1">
                <ContentTemplate>
                  <div id="Div1" class="gridview">
           
                    <asp:GridView ID="grvTemp" runat="server" AllowPaging="True" 
                        AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
                        BorderStyle="None" BorderWidth="1px" CellPadding="3" Width="98%" 
                        EmptyDataText="There is no record to show !" onpageindexchanging="grvTemp_PageIndexChanging">
                        <Columns>
                            <asp:BoundField DataField="ReceivedDate" 
                                DataFormatString="{0:MM/dd/yyyy hh:mm tt}" HeaderText="Received" >
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SkinTempC" HeaderText="Skin temperature (oC/oF)" >
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:BoundField>
                            <asp:BoundField DataField="AmbTempC" HeaderText="Ambient Temperature  (oC/oF) " >
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Diagnosis" HeaderText="Diagnosis" >
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                            </asp:BoundField>
                        </Columns>
                        <FooterStyle BackColor="White" ForeColor="#000066" />
                        <HeaderStyle BackColor="#006699" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="White" ForeColor="#000066" HorizontalAlign="Left" />
                        <RowStyle CssClass="record" ForeColor="#000066" />
                        <SelectedRowStyle BackColor="#669999" Font-Bold="True" ForeColor="White" />
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#007DBB" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#00547E" />
                    </asp:GridView>
            
                    </div>
                </ContentTemplate>
            </asp:TabPanel>
        </asp:TabContainer>
        </div><!-- print-->
       
    </div>
 </div>

     

    <br />
     <div class="clear">
        <div class="title">Diagnosis & Recommendationsss</div>
        <div class="borderbottom">This page displays your current mediacal issues and the date that they were noded in your 
            medical record. Click on the issue name for more in-depth information on that particular issue.
        </div>
        </div>
        
    <div class="clear">
        <br />
        <table class="clear" width="200">
            <tr>
                <td><asp:Button ID="Button1" runat="server" Text="Settings" 
                        onclick="Button1_Click" /></td>
                <td><asp:Button ID="Button2" runat="server" Text="Back to Track others" 
                        PostBackUrl="~/usertrackothers.aspx" /></td>
            </tr>
        </table>
    </div>
   
</asp:Content>

