<%@ Page Title="Fitness" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usertrackothers_fitness.aspx.cs" Inherits="usertrackothers_fitness" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
    
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<%@ Register assembly="TeeChart" namespace="Steema.TeeChart.Web" tagprefix="tchart" %>

<asp:Content ID="Content3" ContentPlaceHolderID="head1" Runat="Server">
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
    <div id="print">
    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                    <a href="usertrackotherhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>» <a href="usertrackothers_fitness.aspx">Fitness monitoring</a>
                </div>
             </div>
            <div class="floatright">
                <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                <a id="userhelp" href="#"><img src="resources/images/h.png" /></a>
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
     Select GRAPH or TABLE buttons to see Fitness monitoring Report.
    <div style="padding-top:10px;">
            <asp:Button ID="btnGraph2" runat="server" OnClick="btnGraph2_Click" Text="Graph" />
            <asp:Button ID="btnTable2" runat="server" OnClick="btnTable2_Click" Text="Table" />
        </div>
        <asp:MultiView ID="MultiViewHeartRate" runat="server" ActiveViewIndex="0">        
            <asp:View ID="ViewGraph" runat="server">
            <div class="item_report">
                <div id="chart" align="center">
                        <div style="padding-top:5px;">
                            Select parameter to draw:<asp:DropDownList ID="ddlParameter" runat="server" 
                                DataTextField="Distance" DataValueField="Distance" AutoPostBack="True" 
                                onselectedindexchanged="ddlParameter_SelectedIndexChanged">
                                <asp:ListItem Value="step_counts" Selected="True">Step Counts</asp:ListItem>
                                <asp:ListItem Value="distance">Distance</asp:ListItem>
                                <asp:ListItem Value="average_speed">Average Speed</asp:ListItem>
                                <asp:ListItem Value="calory_burn">Calories Burned</asp:ListItem>
                                <asp:ListItem Value="pedometer_duration">Pedometer Duration</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    <asp:Panel ID="pnFitness" runat="server" Visible="False">
                        <div align="left">
                            <tchart:WebChart ID="WebChartFitness" runat="server" AutoPostback="False" Config="AAEAAAD/////AQAAAAAAAAAMAgAAAFJUZWVDaGFydCwgVmVyc2lvbj00LjEuMjAxMy4xMTA4NiwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj05YzgxMjYyNzZjNzdiZGI3DAMAAABRU3lzdGVtLkRyYXdpbmcsIFZlcnNpb249NC4wLjAuMCwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj1iMDNmNWY3ZjExZDUwYTNhBQEAAAAVU3RlZW1hLlRlZUNoYXJ0LkNoYXJ0PAAAABAuQ3VzdG9tQ2hhcnRSZWN0Ey5QYW5lbC5NYXJnaW5Cb3R0b20RLkhlYWRlci5BbGlnbm1lbnQNLkhlYWRlci5MaW5lcxouSGVhZGVyLkZvbnQuU2hhZG93LkhlaWdodBkuSGVhZGVyLkZvbnQuU2hhZG93LldpZHRoHC5IZWFkZXIuQnJ1c2guR3JhZGllbnQuQW5nbGUgLkhlYWRlci5CcnVzaC5HcmFkaWVudC5EaXJlY3Rpb24eLkhlYWRlci5CcnVzaC5HcmFkaWVudC5WaXNpYmxlGS5Bc3BlY3QuQ29sb3JQYWxldHRlSW5kZXgQLkFzcGVjdC5IZWlnaHQzRA8uQXNwZWN0LldpZHRoM0QOLkFzcGVjdC5WaWV3M0QHVG9vbHMuMBguVG9vbHMuMC5WaWV3U2VnbWVudFNpemUULlRvb2xzLjAuTW91c2VBY3Rpb24WLlRvb2xzLjAuU3RhcnRQb3NpdGlvbhkuVG9vbHMuMC5TZWdtZW50Vmlld1VuaXRzHC5Ub29scy4wLkF0dHJpYnV0ZXMuRHJhZ1pvb20fLlRvb2xzLjAuQXR0cmlidXRlcy5DYW52YXNJbmRleB4uVG9vbHMuMC5BdHRyaWJ1dGVzLkZpbGxUcmFuc3AcLlRvb2xzLjAuQXR0cmlidXRlcy5JbWFnZVN0ciMuVG9vbHMuMC5BdHRyaWJ1dGVzLk5vQ2xpY2tQb3N0YmFjaxguVG9vbHMuMC5ab29tQ2FudmFzSW5kZXgdLlRvb2xzLjAuWm9vbUZpbGxUcmFuc3BhcmVuY3kVLlRvb2xzLjAuWm9vbVBlbkNvbG9yGC5Ub29scy4wLkN1c3RvbVZhcmlhYmxlcxIuQXhlcy5OdW1GaXhlZEF4ZXMTLkF4ZXMuTGVmdC5JR2FwU2l6ZRQuQXhlcy5MZWZ0LklTdGFydFBvcxIuQXhlcy5MZWZ0LklFbmRQb3MULkF4ZXMuTGVmdC5JQXhpc1NpemUWLkF4ZXMuTGVmdC5Jc0RlcHRoQXhpcxIuQXhlcy5Ub3AuSUdhcFNpemUTLkF4ZXMuVG9wLklTdGFydFBvcxEuQXhlcy5Ub3AuSUVuZFBvcxMuQXhlcy5Ub3AuSUF4aXNTaXplFS5BeGVzLlRvcC5Jc0RlcHRoQXhpcxQuQXhlcy5SaWdodC5JR2FwU2l6ZRUuQXhlcy5SaWdodC5JU3RhcnRQb3MTLkF4ZXMuUmlnaHQuSUVuZFBvcxUuQXhlcy5SaWdodC5JQXhpc1NpemUXLkF4ZXMuUmlnaHQuSXNEZXB0aEF4aXMVLkF4ZXMuQm90dG9tLklHYXBTaXplFi5BeGVzLkJvdHRvbS5JU3RhcnRQb3MULkF4ZXMuQm90dG9tLklFbmRQb3MWLkF4ZXMuQm90dG9tLklBeGlzU2l6ZRguQXhlcy5Cb3R0b20uSXNEZXB0aEF4aXMdLkF4ZXMuQm90dG9tLlJlbGF0aXZlUG9zaXRpb24aLkF4ZXMuQm90dG9tLlBvc2l0aW9uVW5pdHMXLkF4ZXMuRGVwdGhUb3AuSUdhcFNpemUYLkF4ZXMuRGVwdGhUb3AuSVN0YXJ0UG9zFi5BeGVzLkRlcHRoVG9wLklFbmRQb3MYLkF4ZXMuRGVwdGhUb3AuSUF4aXNTaXplGi5BeGVzLkRlcHRoVG9wLklzRGVwdGhBeGlzFC5BeGVzLkRlcHRoLklHYXBTaXplFS5BeGVzLkRlcHRoLklTdGFydFBvcxMuQXhlcy5EZXB0aC5JRW5kUG9zFS5BeGVzLkRlcHRoLklBeGlzU2l6ZRcuQXhlcy5EZXB0aC5Jc0RlcHRoQXhpcwAABAYAAAAEAAAAAAABAAQABAAAAAEAAAAEAQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAEGHlN5c3RlbS5EcmF3aW5nLlN0cmluZ0FsaWdubWVudAMAAAAICAYrU3lzdGVtLkRyYXdpbmcuRHJhd2luZzJELkxpbmVhckdyYWRpZW50TW9kZQMAAAABCAgIAQgnU3RlZW1hLlRlZUNoYXJ0LlRvb2xzLlNjcm9sbE1vdXNlQWN0aW9uAgAAAAgoU3RlZW1hLlRlZUNoYXJ0LlRvb2xzLlNjcm9sbFRvb2xWaWV3VW5pdAIAAAABCAgBCAgUU3lzdGVtLkRyYXdpbmcuQ29sb3IDAAAACAgICAgBCAgICAEICAgIAQgICAgBBh1TdGVlbWEuVGVlQ2hhcnQuUG9zaXRpb25Vbml0cwIAAAAICAgIAQgICAgBAgAAAAAAAAAAAAAgQAX8////HlN5c3RlbS5EcmF3aW5nLlN0cmluZ0FsaWdubWVudAEAAAAHdmFsdWVfXwAIAwAAAAAAAAAJBQAAABMAAAALAAAAAAAAAAAAPkAF+v///ytTeXN0ZW0uRHJhd2luZy5EcmF3aW5nMkQuTGluZWFyR3JhZGllbnRNb2RlAQAAAAd2YWx1ZV9fAAgDAAAAAAAAAAEAAAAAAAAAAAAAAAAABgcAAAAgU3RlZW1hLlRlZUNoYXJ0LlRvb2xzLlNjcm9sbFRvb2wUAAAABfj///8nU3RlZW1hLlRlZUNoYXJ0LlRvb2xzLlNjcm9sbE1vdXNlQWN0aW9uAQAAAAd2YWx1ZV9fAAgCAAAAAQAAAAEAAAAF9////yhTdGVlbWEuVGVlQ2hhcnQuVG9vbHMuU2Nyb2xsVG9vbFZpZXdVbml0AQAAAAd2YWx1ZV9fAAgCAAAAAAAAAAAAAAAAAAAAAAYKAAAAAADzAQAAHgAAAAX1////FFN5c3RlbS5EcmF3aW5nLkNvbG9yBAAAAARuYW1lBXZhbHVlCmtub3duQ29sb3IFc3RhdGUBAAAACQcHAwAAAAoAAAAAAAAAAI0AAQAJCgAAAAYAAAAAAAAAOwAAAFsBAAAgAQAAAAAAAAAcAAAAoAIAAIQCAAAAAAAAADsAAABbAQAAIAEAAAAAAAAAHAAAAKACAACEAgAAAAAAAAAAADDABfT///8dU3RlZW1hLlRlZUNoYXJ0LlBvc2l0aW9uVW5pdHMBAAAAB3ZhbHVlX18ACAIAAAABAAAAAAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAAAAAAAAAREFAAAAAQAAAAkKAAAACw=="
                                GetChartFile="GetChart.aspx" Height="400px" TempChart="Session" 
                                Width="700px" />
                        </div>
                    </asp:Panel>
                            <br />           
                    <asp:Panel ID="pnEmptyData" runat="server" CssClass="panel_empty_data">
                        <asp:Label ID="lbDataEmpty" runat="server" Text="You have no data to graph!" ForeColor="Red"></asp:Label></asp:Panel>
                        <asp:LinkButton ID="lbtnDateTime" runat="server" Font-Underline="False" 
                            onclick="lbtnDateTime_Click">DateTime</asp:LinkButton></div>
                    <%--<asp:ModalPopupExtender ID="MPE" runat="server" TargetControlID="lbtnDateTime" PopupControlID="Panel1"
                        DropShadow="True" PopupDragHandleControlID="Panel2" DynamicServicePath="" CancelControlID="btnCancel"
                        OkControlID="btnOk" Enabled="True">
                    </asp:ModalPopupExtender>--%>
                <asp:Panel ID="date_graph" CssClass="datetime_filter" runat="server">
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
                                    <asp:TextBox ID="txtFromDate" runat="server"></asp:TextBox><asp:CalendarExtender
                                        ID="txtFromDate_CalendarExtender" runat="server" Enabled="True" CssClass="orange"
                                        TargetControlID="txtFromDate">
                                    </asp:CalendarExtender>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtToDate" runat="server"></asp:TextBox><asp:CalendarExtender ID="txtToDate_CalendarExtender"
                                        runat="server" Enabled="True" CssClass="orange" TargetControlID="txtToDate">
                                    </asp:CalendarExtender>
                                </td>
                            </tr>
                            <tr align="center">
                                <td colspan="2">
                                    <asp:Button ID="btnOk" runat="server" Text="View" OnClick="btnOk_Click" />
                                    <asp:Button ID="btnCancel" runat="server" Text="Cancel" onclick="btnCancel_Click" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:Panel>
                    </div><!-- item -->
            </asp:View>
            <asp:View ID="ViewTable" runat="server">
            <div class="item_report">
                <asp:LinkButton ID="lbPopup" runat="server" CssClass="lbPopup" 
                    onclick="lbPopup_Click">DateTime</asp:LinkButton>
                    <asp:TabContainer ID="Subtab" runat="server" ActiveTabIndex="0" 
                    CssClass="subtab" Width="100%">
                            <asp:TabPanel ID="tabHR"  runat="server" HeaderText="HR exercise">
                            <ContentTemplate>
                                <asp:Panel runat="server" ID="table_item" CssClass="table_item">
                                  <div class="title_grv">
                                    <table>
                                        <tr>
                                            <td style="width:150px;">
                                                
                                            </td>
                                            <td style="width:100px;">
                                                Duration
                                            </td>
                                            <td style="width:100px;">
                                                Exercise
                                            </td>
                                            <td style="width:150px;">
                                                Time in zones
                                            </td>
                                            <td style="width:100px;">
                                                TargetHR
                                            </td>
                                            <td style="width:100px;">
                                                AverageHR
                                            </td>
                                            <td style="width:100px;">
                                                MaximumHR
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <!-- Title -->
                                <div class="content_grv" style="height:395px">
                                    <asp:GridView ID="grvHRExercise" runat="server" 
                                        AutoGenerateColumns="False" Width="100%" EmptyDataText="There is no record to show ! " 
                                        onpageindexchanging="grvHRExercise_PageIndexChanging" PageSize="100" 
                                        ShowHeader="False" >
                                        <Columns>
                                        <asp:BoundField  DataField="ReceivedDate" 
                                                DataFormatString="{0:MM/dd/yyyy hh:mm:ss}" >
                                            <ItemStyle Width="150px" />
                                            </asp:BoundField>
                                        <asp:BoundField HeaderText="Duration" DataField="Duration" >
                                            <ItemStyle Width="100px" />
                                            </asp:BoundField>
                                        <asp:BoundField HeaderText="Exercise" DataField="Exercise" >
                                            <ItemStyle Width="100px" />
                                            </asp:BoundField>
                                        <asp:BoundField HeaderText="Time in zones" DataField="TimeInZones" >
                                            <ItemStyle Width="150px" />
                                            </asp:BoundField>
                                        <asp:BoundField HeaderText="Target HR" DataField="TargetHR" >
                                            <ItemStyle Width="100px" />
                                            </asp:BoundField>
                                        <asp:BoundField HeaderText="Average HR" DataField="AverageHR" >
                                            <ItemStyle Width="100px" />
                                            </asp:BoundField>
                                        <asp:BoundField HeaderText="Maximum HR" DataField="MaximumHR" >
                                            <ItemStyle Width="100px" />
                                            </asp:BoundField>
                                        </Columns>
                                        <PagerSettings Visible="False" />
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
                                                <asp:Label ID="lb_pager" runat="server" Text="0"></asp:Label>
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
                            </ContentTemplate>
                            </asp:TabPanel>
                            <asp:TabPanel ID="tabPedometer" runat="server" HeaderText="Pedometer" TabIndex="1">
                                <ContentTemplate>
                                
                                <asp:Panel runat="server" ID="table_item2" CssClass="table_item">
                                  <div class="title_grv">
                                    <table>
                                        <tr>
                                            <td style="width:150px;">
                                                
                                            </td>
                                            <td style="width:80px;">
                                                Target
                                            </td>
                                            <td style="width:80px;">
                                                Steps
                                            </td>
                                            <td style="width:100px;">
                                                Distance
                                            </td>
                                            <td style="width:100px;">
                                                AverageSpeed
                                            </td>
                                            <td style="width:140px;">
                                                Calories burned
                                            </td>
                                            <td style="width:120px;">
                                                Duration
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <!-- Title -->
                                <div class="content_grv" style="height:395px">
                                        <asp:GridView ID="grvPedometer" runat="server" 
                                        AutoGenerateColumns="False" EmptyDataText="There is no record to show !" 
                                        Width="100%" onpageindexchanging="grvPedometer_PageIndexChanging" 
                                            PageSize="100" ShowHeader="False">
                                        <Columns>
                                        <asp:BoundField  DataField="ReceivedDate" 
                                                DataFormatString="{0:MM/dd/yyyy hh:mm:ss}" >
                                            <ItemStyle Width="150px" />
                                            </asp:BoundField>
                                        <asp:BoundField HeaderText="Target" DataField="TargetPM" >
                                            <ItemStyle Width="80px" />
                                            </asp:BoundField>
                                        <asp:BoundField HeaderText="Steps" DataField="Steps" >
                                            <ItemStyle Width="80px" />
                                            </asp:BoundField>
                                        <asp:BoundField HeaderText="Distance" DataField="Distance" >
                                            <ItemStyle Width="100px" />
                                            </asp:BoundField>
                                        <asp:BoundField HeaderText="Average Speed" DataField="AverageSpeed" >
                                            <ItemStyle Width="100px" />
                                            </asp:BoundField>
                                        <asp:BoundField HeaderText="Calories burned" DataField="CaloryBurn" >
                                            <ItemStyle Width="140px" />
                                            </asp:BoundField>
                                        <asp:BoundField HeaderText="Duration" DataField="Duration" >
                                            <ItemStyle Width="120px" />
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
                            </asp:TabPanel>
                            </asp:TabContainer>
                           <%-- <asp:ModalPopupExtender ID="mdpTable" TargetControlID="lbPopup" runat="server" CancelControlID="btncancelTable" PopupControlID="popup" PopupDragHandleControlID="headerpop"    Drag="True" DropShadow="True" DynamicServicePath="" Enabled="True">
                            </asp:ModalPopupExtender>--%>
                                <asp:Panel ID="date_table" CssClass="datetime_filter" 
                    runat="server" Visible="False">
                                    <div>
                                        <asp:Panel ID="headerpop" runat="server" CssClass="TitlePanelDateTime">Select Date To Draw Chart </asp:Panel>
                                    </div>
                                    <div class="ContentDateTime">
                                        <table>
                                        <tr>
                                        <td>From Date: </td>
                                        <td>To Date: </td>
                                        </tr><tr>
                                        <td><asp:TextBox 
                                        ID="txtFromDateTable" runat="server"></asp:TextBox>
                                        <asp:CalendarExtender ID="clFrom" runat="server" CssClass="orange" Enabled="True" TargetControlID="txtFromDateTable">
                                        </asp:CalendarExtender>
                                        </td>
                                        <td>
                                        <asp:TextBox ID="txtToDateTable" runat="server"></asp:TextBox><asp:CalendarExtender 
                                        ID="clTo" runat="server" CssClass="orange" Enabled="True" TargetControlID="txtToDateTable">
                                        </asp:CalendarExtender>
                                        </td>
                                        </tr>
                                        <tr align="center">
                                        <td colspan="2">
                                        <asp:Button ID="btnView" runat="server" OnClick="btnView_Click" Text="View" />
                                        <asp:Button ID="btncancelTable" runat="server" Text="Cancel" 
                                                onclick="btncancelTable_Click" />
                                        </td>
                                        </tr>
                                        </table>
                                    </div>
                                </asp:Panel><!-- Popup -->
                    <div class="clear"></div>
                    </div><!-- item -->
            </asp:View>
        </asp:MultiView>
     
</div><!-- print-->
     

    <br />
     <div class="border-top-bottom">
        <div class="title">Diagnosis & Recommendations</div>
        <div class="">This page displays your current mediacal issues and the date that they were noded in your 

            medical record. Click on the issue name for more in-depth information on that particular issue.
        </div>
    </div>

    <div class="no-border">

        <br />
        <table class="clear" width="200">
            <tr>
                <td><asp:Button ID="Button1" runat="server" Text="Settings" 
                        PostBackUrl="~/usertrackothers_fitness_settings.aspx" /></td>
                <td><asp:Button ID="Button2" runat="server" Text="Back to Track others health" 
                        PostBackUrl="~/usertrackotherhealth.aspx" /></td>
            </tr>
        </table>
    </div>
</asp:Content>

