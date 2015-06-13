<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackothers_position.aspx.cs" Inherits="usertrackothers_position" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<%@ Register assembly="TeeChart" namespace="Steema.TeeChart.Web" tagprefix="tchart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" runat="Server">
    <link href="styles/tab.css" rel="stylesheet" type="text/css" />
    <link href="styles/control.css" rel="stylesheet" type="text/css" />
    <link href="styles/Position.css" rel="stylesheet" type="text/css" />
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
                   <a href="usertrackotherhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> &nbsp;health </a> » <a href="usertrackothers_position.aspx">Position monitoring</a>
                </div>
             </div>
            <div class="floatright">
                <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                <a id="userhelp" href="#"><img src="resources/images/h.png" /></a>
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
     Select GRAPH or TABLE buttons to see Position monitoring Report.
        <div style="padding-top:10px;">
            <asp:Button ID="btnGraph2" runat="server" OnClick="btnGraph2_Click" Text="Graph" />
            <asp:Button ID="btnTable2" runat="server" OnClick="btnTable2_Click" Text="Table" />
        </div>
        <asp:MultiView ID="MultiViewPosition" runat="server" ActiveViewIndex="0">
            
            <asp:View ID="ViewGraph" runat="server">
            <div class="item_report">
                <div class="select_data">
                    Report is viewed with:
                    <asp:DropDownList ID="ddl_Graph" runat="server" CssClass="dropdown" 
                        AutoPostBack="True" >
                        <asp:ListItem Value="1">Default data</asp:ListItem>
                        <asp:ListItem Value="0">Raw data</asp:ListItem>
                    </asp:DropDownList>
                    . Click drop-down list to select a different view.
                </div>
                <div id="chart" align="center">
                        <%--<div><asp:Button ID="btnDrawData" runat="server" Text="Draw Data" 
                                onclick="btnDrawData_Click" /></div>  --%>
                        <asp:Panel ID="pnChart" runat="server" Visible="False">
                            
                            <table id="linearBg2">
                                <tr>
                                    <td style="border-right:1px solid #ccc; height:200px;" valign="top">
                                        <div class="ColumnHeader" >Supine</div>
                                        <div class="ColumnHeader" >Prone</div>
                                        <div class="ColumnHeader" >Left</div>
                                        <div class="ColumnHeader" >Right</div>
                                        <div class="ColumnHeader" >Up</div>
                                        <div class="ColumnHeader" >Down</div>
                                    </td>
                                    <td style="overflow: hidden;" valign="top" rowspan="2">
                                        <div class="Chart">
                                            <asp:DataList ID="dtlPostion" CssClass="DatalistChart" runat="server" RepeatDirection="Horizontal">
                                                <ItemTemplate>
                                                    <table>
                                                        <tr style="height: 200px;" align="center">
                                                            <td class="Obese" >
                                                                <div class='<%# Eval("Position") %>'></div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                                <div style="over-flow:hidden;">
                                                                <asp:Label ID="lblDate" runat="server" CssClass="LabelTitle" Text='<%# Bind("ReceivedDate", "{0:MM/dd/yy}") %>'></asp:Label>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:DataList>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td style=" background-color:Transparent;" ></td>
                                </tr>
                            </table>

                        </asp:Panel>
                        <asp:Panel ID="pnDrawData" runat="server">
                            
                            <asp:Chart ID="ChartDrawData" runat="server" BorderlineWidth="0" Height="350px" 
                                Width="500px">
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
                                        <Position Auto="False" Height="20" Width="80" />
                                        <InnerPlotPosition Auto="False" Height="40" Width="80" X="20" Y="14" />
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
                                        <Position Auto="False" Height="20" Width="80" Y="15" />
                                        <InnerPlotPosition Auto="False" Height="40" Width="80" X="20" Y="14" />
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
                                        <Position Auto="False" Height="20" Width="80" Y="30" />
                                        <InnerPlotPosition Auto="False" Height="40" Width="80" X="20" Y="14" />
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
                                        <Position Auto="False" Height="20" Width="80" Y="45" />
                                        <InnerPlotPosition Auto="False" Height="40" Width="80" X="20" Y="14" />
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
                                        <Position Auto="False" Height="20" Width="80" Y="60" />
                                        <InnerPlotPosition Auto="False" Height="40" Width="80" X="20" Y="14" />
                                    </asp:ChartArea>
                                    <asp:ChartArea BorderWidth="0" Name="Z">
                                        <AxisY>
                                            <MajorGrid Enabled="False" />
                                            <LabelStyle ForeColor="Transparent" />
                                        </AxisY>
                                        <AxisX IsLabelAutoFit="False">
                                            <MajorGrid Enabled="False" />
                                            <LabelStyle Angle="-30" Font="Microsoft Sans Serif, 6.75pt" ForeColor="DimGray" 
                                                Format="MM/dd/yy" />
                                        </AxisX>
                                        <Position Auto="False" Height="20" Width="80" Y="75" />
                                        <InnerPlotPosition Auto="False" Height="40" Width="80" X="20" Y="14" />
                                    </asp:ChartArea>
                                </ChartAreas>
                                <Titles>
                                    <asp:Title Name="HR" Text="HR">
                                        <Position Auto="False" Height="4.48369551" Width="15" Y="5" />
                                    </asp:Title>
                                    <asp:Title Name="HRVoltage" Text="HR Voltage">
                                        <Position Auto="False" Height="4.48369551" Width="15" Y="20" />
                                    </asp:Title>
                                    <asp:Title Name="GSR" Text="GSR">
                                        <Position Auto="False" Height="4.48369551" Width="15" Y="35" />
                                    </asp:Title>
                                    <asp:Title Name="X" Text="X">
                                        <Position Auto="False" Height="4.48369551" Width="15" Y="50" />
                                    </asp:Title>
                                    <asp:Title Name="Y" Text="Y">
                                        <Position Auto="False" Height="4.48369551" Width="15" Y="65" />
                                    </asp:Title>
                                    <asp:Title Name="Z" Text="Z">
                                        <Position Auto="False" Height="4.48369551" Width="15" Y="80" />
                                    </asp:Title>
                                </Titles>
                                <BorderSkin BackColor="ControlDark" SkinStyle="Emboss" />
                            </asp:Chart>
                            
                        </asp:Panel>
                            <div align="center" style="width: 450px;">
                                <asp:Panel ID="pnEmptyData" runat="server" CssClass="panel_empty_data2">
                                    <asp:Label ID="lbDataEmpty" runat="server" Text="You have no data to graph!" ForeColor="Red"></asp:Label></asp:Panel>
                        </div>
                        <div align="center" style="width: 450px;">
                            <asp:LinkButton ID="lbtnDateTime" runat="server" Font-Underline="False" 
                                onclick="lbtnDateTime_Click" ForeColor="#000099">DateTime</asp:LinkButton>
                        </div>
                        </div>
                   <%-- <asp:ModalPopupExtender ID="MPE" runat="server" TargetControlID="lbtnDateTime" PopupControlID="Panel1"
                        DropShadow="True" PopupDragHandleControlID="Panel2" DynamicServicePath="" 
                        CancelControlID="btnCancel" Enabled="True"></asp:ModalPopupExtender>--%>
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
                    </div>
            </asp:View>
            <asp:View ID="ViewTable" runat="server">
                <div class="item_report">
                <%--<asp:Button ID="btnRawData" runat="server" Text="Raw Data" 
                        CssClass="floatright" onclick="btnRawData_Click"/>
                    <div class ="clear"></div>--%>
                <div class="select_data">
                    Report is viewed with:
                    <asp:DropDownList ID="ddl_Table" runat="server" CssClass="dropdown" 
                            AutoPostBack="True" onselectedindexchanged="ddl_Table_SelectedIndexChanged">
                        <asp:ListItem Value="1">Default data</asp:ListItem>
                        <asp:ListItem Value="0">Raw data</asp:ListItem>
                    </asp:DropDownList>
                    . Click drop-down list to select a different view.
                </div>
                    <asp:LinkButton ID="lbPopup" runat="server" CssClass="lbPopupDate" 
                        onclick="lbPopup_Click">DateTime</asp:LinkButton>
                <%--    <asp:ModalPopupExtender ID="MPE2" runat="server" TargetControlID="lbPopup" PopupControlID="Panel3"
                        DropShadow="True" PopupDragHandleControlID="Panel4" DynamicServicePath="" 
                        CancelControlID="btnCancel2" Enabled="True" ></asp:ModalPopupExtender> --%>
                <asp:UpdatePanel ID="UpdateTable" runat="server">
                <ContentTemplate>
                    <asp:Panel ID="table_item" runat="server" CssClass="table_item">
                       
                                  <div class="title_grv">
                                    <table>
                                        <tr>
                                            <td style="width:150px;">
                                                
                                            </td>
                                            <td style="width:250px;">
                                                Position
                                            </td>
                                            <td style="width:240px;">
                                                Alarm
                                            </td>
                                            
                                        </tr>
                                    </table>
                                </div>
                                <!-- Title -->
                     <div class="content_grv">
                    <asp:GridView ID="grvData" runat="server" AutoGenerateColumns="False" 
                             BackColor="White" BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" 
                             CellPadding="3" Width="100%" 
                        EmptyDataText="There is no record to show !" 
                        onpageindexchanging="grvData_PageIndexChanging" PageSize="100" 
                             ShowHeader="False" >
                        <Columns>
                            <asp:BoundField DataField="ReceivedDate" 
                                DataFormatString="{0:MM/dd/yyyy hh:mm tt}" ><ItemStyle 
                                HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" /></asp:BoundField>
                            <asp:BoundField DataField="Position" HeaderText="Position" ><ItemStyle 
                                HorizontalAlign="Center" VerticalAlign="Middle" Width="250px" /></asp:BoundField>
                            <asp:BoundField DataField="Alarm" HeaderText="Alarm" ><ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" /></asp:BoundField>
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
                        <SortedAscendingCellStyle BackColor="#F1F1F1" />
                        <SortedAscendingHeaderStyle BackColor="#007DBB" />
                        <SortedDescendingCellStyle BackColor="#CAC9C9" />
                        <SortedDescendingHeaderStyle BackColor="#00547E" />
                    </asp:GridView>
                     </div><!-- table -->
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
                                                <asp:Label ID="lb_pager" runat="server"></asp:Label>
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
                                       
                                    </td>
                                    <td style="width:200px;">
                                       X
                                    </td>
                                    <td style="width:200px;">
                                        Y
                                    </td>
                                    <td style="width:200px;">
                                        Z
                                    </td>
                                </tr>
                            </table>
                        </div><!-- Title -->
                        <div class="content_grv">
                      <asp:GridView ID="grvRawData" runat="server" AutoGenerateColumns="False" 
                          Width="100%" 
                          onpageindexchanging="grvRawData_PageIndexChanging"
                                EmptyDataText="There is no record to show !" PageSize="100" 
                                ShowHeader="False" 
                                onselectedindexchanged="grvRawData_SelectedIndexChanged" >
                          <Columns>
                              <asp:BoundField DataField="ReceivedDate" 
                                  DataFormatString="{0:MM/dd/yyyy hh:mm tt}" ><ItemStyle Width="150px" /></asp:BoundField>
                              <asp:BoundField DataField="ValueX" HeaderText="X" >
                              <ItemStyle Width="200px" />
                              </asp:BoundField>
                              <asp:BoundField DataField="ValueY" HeaderText="Y" >
                              <ItemStyle Width="200px" />
                              </asp:BoundField>
                              <asp:BoundField DataField="ValueZ" HeaderText="Z" >
                              <ItemStyle Width="200px" />
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
                                        <asp:Label ID="lbpage2" runat="server"></asp:Label>
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
                                        &nbsp;</td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtFromDate2" runat="server"></asp:TextBox>
                                        

                                        <asp:CalendarExtender
                                            ID="txtFromDate_CalendarExtender2" runat="server" Enabled="True"
                                            TargetControlID="txtFromDate2" CssClass="orange">
                                        </asp:CalendarExtender>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtToDate2" runat="server"></asp:TextBox>
                                        <asp:CalendarExtender ID="txtToDate_CalendarExtender2"
                                            runat="server" Enabled="True" TargetControlID="txtToDate2" 
                                            CssClass="orange">
                                        </asp:CalendarExtender>
                                    </td>
                                    <td>
                                        &nbsp;</td>
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
                    </div>
            </asp:View>
        </asp:MultiView>
</div><!-- print-->
     

    <br />
     <div class="border-top-bottom">
        <div class="title">Diagnosis &amp; Recommendations</div>
        <div class="">This page displays your current mediacal issues and the date that they were noded in your 
            medical record. Click on the issue name for more in-depth information on that particular issue.
        </div>
        </div>
        
    <div class="no-border">
        <br />
        <table class="clear" width="200">
            <tr>
                <td><asp:Button ID="Button1" runat="server" Text="Settings" 
                        PostBackUrl="~/usertrackothers_position_settings.aspx"/></td>
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

