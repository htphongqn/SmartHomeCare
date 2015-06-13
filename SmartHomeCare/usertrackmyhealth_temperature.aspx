<%@ Page Title="Temperature Monitoring" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" EnableEventValidation="false" CodeFile="usertrackmyhealth_temperature.aspx.cs" Inherits="usertrackmyhealth_temperature_graph" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<%@ Register assembly="TeeChart" namespace="Steema.TeeChart.Web" tagprefix="tchart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <link href="styles/tab.css" rel="stylesheet" type="text/css" />
    <link href="styles/control.css" rel="stylesheet" type="text/css" />
   <script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#userhelp').click(function (e) {
                window.open('userhelp.aspx', 'User Help', 500, 500);
            });
        });
        function OpenPopUp(){
           
            $('.popupConfirmation').css('display', 'block');
        }
        function Close() {
            $('.popupConfirmation').css('display', 'none');
            location.reload();
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
        <div class="title_new">
            <div class="floatleft">
                <div class="td">
                 <a href="usertrackmyhealth.aspx"> Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health </a>
                    » <asp:LinkButton ID="lnlinks" runat="server" 
                        onclick="lnlinks_Click">Temperature monitoring</asp:LinkButton>
                </div>
             </div>
            <div class="floatright"><%--
                <asp:Button ID="btnPrint" runat="server" Text="Print" 
                    onclick="btnPrint_Click" />--%>
                <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" 
                    ImageUrl="~/resources/images/printer.png" Width="25px" 
                    OnClientClick="return " CssClass="floatleft" 
                    onclick="ImageButton2_Click"/>&nbsp;&nbsp;
                <a id="userhelp" href="#"><img src="resources/images/h.png" alt=""/></a>
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
     Select GRAPH or TABLE buttons to see Temperature monitoring Report.
     
     <div style="padding-top:10px;">
         <asp:Button ID="btnGraph2" runat="server" OnClick="btnGraph2_Click" 
             Text="Graph" />
         <asp:Button ID="btnTable2" runat="server" OnClick="btnTable2_Click" 
             Text="Table" />
    </div>
    <div id="print">
    <asp:MultiView ID="MultiViewTemperature" runat="server" ActiveViewIndex="0">
        <asp:View ID="ViewGraph" runat="server">
            <div class="item_report">
                <div class="over_item"></div><!-- over item-->
                <div id="chart">
                    <asp:Panel ID="pnChart" runat="server" Visible="False">
                        <br />
                        <tchart:WebChart ID="ChartTemperature" runat="server" AutoPostback="False" Config="AAEAAAD/////AQAAAAAAAAAMAgAAAFJUZWVDaGFydCwgVmVyc2lvbj00LjEuMjAxMy4xMTA4NiwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj05YzgxMjYyNzZjNzdiZGI3DAMAAABRU3lzdGVtLkRyYXdpbmcsIFZlcnNpb249NC4wLjAuMCwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj1iMDNmNWY3ZjExZDUwYTNhBQEAAAAVU3RlZW1hLlRlZUNoYXJ0LkNoYXJ0OAAAABAuQ3VzdG9tQ2hhcnRSZWN0Ey5QYW5lbC5NYXJnaW5Cb3R0b20NLkhlYWRlci5MaW5lcxkuQXNwZWN0LkNvbG9yUGFsZXR0ZUluZGV4EC5Bc3BlY3QuSGVpZ2h0M0QPLkFzcGVjdC5XaWR0aDNEDi5Bc3BlY3QuVmlldzNEB1Rvb2xzLjAYLlRvb2xzLjAuVmlld1NlZ21lbnRTaXplFC5Ub29scy4wLk1vdXNlQWN0aW9uFi5Ub29scy4wLlN0YXJ0UG9zaXRpb24ZLlRvb2xzLjAuU2VnbWVudFZpZXdVbml0cxwuVG9vbHMuMC5BdHRyaWJ1dGVzLkRyYWdab29tHy5Ub29scy4wLkF0dHJpYnV0ZXMuQ2FudmFzSW5kZXgeLlRvb2xzLjAuQXR0cmlidXRlcy5GaWxsVHJhbnNwHC5Ub29scy4wLkF0dHJpYnV0ZXMuSW1hZ2VTdHIjLlRvb2xzLjAuQXR0cmlidXRlcy5Ob0NsaWNrUG9zdGJhY2sYLlRvb2xzLjAuWm9vbUNhbnZhc0luZGV4HS5Ub29scy4wLlpvb21GaWxsVHJhbnNwYXJlbmN5FS5Ub29scy4wLlpvb21QZW5Db2xvchguVG9vbHMuMC5DdXN0b21WYXJpYWJsZXMSLkF4ZXMuTnVtRml4ZWRBeGVzEy5BeGVzLkxlZnQuSUdhcFNpemUULkF4ZXMuTGVmdC5JU3RhcnRQb3MSLkF4ZXMuTGVmdC5JRW5kUG9zFC5BeGVzLkxlZnQuSUF4aXNTaXplFi5BeGVzLkxlZnQuSXNEZXB0aEF4aXMYLkF4ZXMuTGVmdC5UaXRsZS5DYXB0aW9uFi5BeGVzLkxlZnQuVGl0bGUuTGluZXMSLkF4ZXMuVG9wLklHYXBTaXplEy5BeGVzLlRvcC5JU3RhcnRQb3MRLkF4ZXMuVG9wLklFbmRQb3MTLkF4ZXMuVG9wLklBeGlzU2l6ZRUuQXhlcy5Ub3AuSXNEZXB0aEF4aXMULkF4ZXMuUmlnaHQuSUdhcFNpemUVLkF4ZXMuUmlnaHQuSVN0YXJ0UG9zEy5BeGVzLlJpZ2h0LklFbmRQb3MVLkF4ZXMuUmlnaHQuSUF4aXNTaXplFy5BeGVzLlJpZ2h0LklzRGVwdGhBeGlzFS5BeGVzLkJvdHRvbS5JR2FwU2l6ZRYuQXhlcy5Cb3R0b20uSVN0YXJ0UG9zFC5BeGVzLkJvdHRvbS5JRW5kUG9zFi5BeGVzLkJvdHRvbS5JQXhpc1NpemUYLkF4ZXMuQm90dG9tLklzRGVwdGhBeGlzHS5BeGVzLkJvdHRvbS5SZWxhdGl2ZVBvc2l0aW9uGi5BeGVzLkJvdHRvbS5Qb3NpdGlvblVuaXRzFy5BeGVzLkRlcHRoVG9wLklHYXBTaXplGC5BeGVzLkRlcHRoVG9wLklTdGFydFBvcxYuQXhlcy5EZXB0aFRvcC5JRW5kUG9zGC5BeGVzLkRlcHRoVG9wLklBeGlzU2l6ZRouQXhlcy5EZXB0aFRvcC5Jc0RlcHRoQXhpcxQuQXhlcy5EZXB0aC5JR2FwU2l6ZRUuQXhlcy5EZXB0aC5JU3RhcnRQb3MTLkF4ZXMuRGVwdGguSUVuZFBvcxUuQXhlcy5EZXB0aC5JQXhpc1NpemUXLkF4ZXMuRGVwdGguSXNEZXB0aEF4aXMAAAYAAAAAAQAEAAQAAAABAAAABAEAAAAAAAABBgAAAAAAAAAAAAAAAAAAAAAEAAAAAAAAAAAAAAEGCAgIAQgnU3RlZW1hLlRlZUNoYXJ0LlRvb2xzLlNjcm9sbE1vdXNlQWN0aW9uAgAAAAgoU3RlZW1hLlRlZUNoYXJ0LlRvb2xzLlNjcm9sbFRvb2xWaWV3VW5pdAIAAAABCAgBCAgUU3lzdGVtLkRyYXdpbmcuQ29sb3IDAAAACAgICAgBCAgICAEICAgIAQgICAgBBh1TdGVlbWEuVGVlQ2hhcnQuUG9zaXRpb25Vbml0cwIAAAAICAgIAQgICAgBAgAAAAAAAAAAAAAgQAkEAAAAAAAAAAAAAAAAAAAAAAYFAAAAIFN0ZWVtYS5UZWVDaGFydC5Ub29scy5TY3JvbGxUb29sAQAAAAX6////J1N0ZWVtYS5UZWVDaGFydC5Ub29scy5TY3JvbGxNb3VzZUFjdGlvbgEAAAAHdmFsdWVfXwAIAgAAAAEAAAABAAAABfn///8oU3RlZW1hLlRlZUNoYXJ0LlRvb2xzLlNjcm9sbFRvb2xWaWV3VW5pdAEAAAAHdmFsdWVfXwAIAgAAAAEAAAAAAAAAAAAAAAAGCAAAAAAA8wEAAB4AAAAF9////xRTeXN0ZW0uRHJhd2luZy5Db2xvcgQAAAAEbmFtZQV2YWx1ZQprbm93bkNvbG9yBXN0YXRlAQAAAAkHBwMAAAAKAAAAAAAAAACNAAEACQgAAAAGAAAAAAAAADsAAABbAQAAIAEAAAAGCgAAAAtUZW1wZXJhdHVyZQkLAAAAAAAAACoAAACgAgAAdgIAAAAAAAAAOwAAAFsBAAAgAQAAAAAAAAAqAAAAoAIAAHYCAAAAAAAAAAAAMMAF9P///x1TdGVlbWEuVGVlQ2hhcnQuUG9zaXRpb25Vbml0cwEAAAAHdmFsdWVfXwAIAgAAAAEAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAABEQQAAAABAAAACQgAAAARCwAAAAEAAAAGDgAAAAtUZW1wZXJhdHVyZQs="
                            GetChartFile="GetChart.aspx" Height="400px" TempChart="Session" 
                            Width="700px" />
                    </asp:Panel>
                </div>
                <div align="center" style="padding-top:20px;">
                    <asp:Panel ID="pnEmptyData" runat="server" CssClass="panel_empty_data">
                        <asp:Label ID="lbDataEmpty" runat="server" Text="You have no data to graph!" ForeColor="Red"></asp:Label></asp:Panel>
                </div>
                <div align="center" style="padding-top:20px;">
                    <asp:LinkButton ID="lbtnDateTime" runat="server" Font-Underline="False" 
                        OnClick="lbtnDateTime_Click">DateTime</asp:LinkButton>
                </div>
                <div css="popupConfirmation">
            <asp:Panel ID="date_graph" CssClass="datetime_filter " runat="server" Visible="False">
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
                                <asp:TextBox ID="txtFromDateChart" runat="server"></asp:TextBox>
                                <asp:CalendarExtender ID="CalendarExtender1" runat="server" Enabled="True" TargetControlID="txtFromDateChart"
                                    CssClass="orange">
                                </asp:CalendarExtender>
                            </td>
                            <td>
                                <asp:TextBox ID="txtToDateChart" runat="server"></asp:TextBox>
                                <asp:CalendarExtender ID="CalendarExtender2" runat="server" Enabled="True" TargetControlID="txtToDateChart"
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
                    
                </div><!-- item-->
            </asp:Panel>
            </div>
        </asp:View>
        <asp:View ID="ViewTable" runat="server">
        <asp:UpdatePanel ID="UpdateTable" runat="server">
        <ContentTemplate>
            <div class="item_report">
                
                    <asp:Panel ID="table_item" runat="server" CssClass="table_item" BorderColor="#f3f3f3">
                    
                       <div class="title_grv" id="title_grv">
                                    <table>
                                        <tr>
                                            <td style="width:170px;">
                                                <asp:LinkButton ID="lbPopup" runat="server" onclick="lbPopup_Click" 
                                                    ForeColor="White">DateTime</asp:LinkButton>
                                            </td>
                                            <td style="width:180px;">
                                                Skin temperature<asp:Label ID="lbSkin" runat="server" Text=""></asp:Label>
                                            </td>
                                            <td style="width:150px;">
                                                Ambient Temperature<asp:Label ID="lbAmb" runat="server" Text=""></asp:Label>
                                            </td>
                                            <td style="width:300px;">
                                                Diagnosis
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <!-- Title -->
                   <div class="content_grv" style="height:423px">
                   <div id="print_table">
                    <asp:GridView ID="grvTemp" runat="server" 
                        AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
                        BorderStyle="None" BorderWidth="1px" CellPadding="3" Width="100%" 
                        EmptyDataText="There is no record to show !" 
                           onpageindexchanging="grvTemp_PageIndexChanging" PageSize="100" 
                           ShowHeader="false" AllowPaging="true">
                        <Columns>
                            <asp:BoundField DataField="ReceivedDate" 
                                DataFormatString="{0:MM/dd/yyyy HH:mm:ss}" >
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SkinTempC" HeaderText="Skin temperature " >
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="AmbTempC" HeaderText="Ambient Temperature " >
                            <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" Width="150px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Diagnosis" HeaderText="Diagnosis" >
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
                     </div> <!-- table -->
                    </div><!-- print table -->
                                <div class="footer_grv" style="visibility:visible">
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
                            <asp:Panel ID="date_table" CssClass="datetime_filter" runat="server" 
                        Visible="False">
                            <div>
                            <asp:Panel ID="headerpop" runat="server" CssClass="TitlePanelDateTime">Select Date </asp:Panel>
                            </div>
                            <div class="ContentDateTime">
                            <table>
                                <tr>
                                    <td>
                                    From date:</td>
                                    <td>
                                     To Date:
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="txtFromDate" runat="server" Width="150px" CssClass="input"></asp:TextBox>
                                          <asp:CalendarExtender ID="txtFromDate_CalendarExtender" runat="server" 
                                            CssClass="orange" Enabled="True" TargetControlID="txtFromDate">
                                        </asp:CalendarExtender>
                                    </td>
                                    <td>
                                        <asp:TextBox ID="txtToDate" runat="server" Width="150px" CssClass="input"></asp:TextBox>
                                        <asp:CalendarExtender ID="txtToDate_CalendarExtender" runat="server" 
                                                CssClass="orange" Enabled="True" TargetControlID="txtToDate">
                                            </asp:CalendarExtender>
                                    </td>
                                </tr>
                                <tr>
                                       <td colspan="2" align="center">
                                            <asp:Button ID="btnFilter" runat="server" onclick="btnFilter_Click" Text="Select" 
                                                Height="25px" Width="100px"  />
                                        
                                            <asp:Button ID="btncancelTable" runat="server" Text="Cancel" Height="25px" 
                                                Width="100px" onclick="btncancelTable_Click" />
                                        </td>
                                    </tr>
                            </table>
                            </div>
                            </asp:Panel><!-- Popup -->
                         
            </div><!-- item -->
            </ContentTemplate>
        </asp:UpdatePanel>
        </asp:View>
    </asp:MultiView>
   </div><!-- print-->
  
    <br />
     <div class="border-top-bottom">
        <div class="title">Diagnosis & Recommendations</div>
        <div >This page displays your current mediacal issues and the date that they were noded in your 
            medical record. Click on the issue name for more in-depth information on that particular issue.
        </div>
        </div>
        
    <div class="no-border"  style="padding-bottom:10px">
        <br />
        <table class="clear" width="200">
            <tr>
                <td><asp:Button ID="Button1" runat="server" Text="Settings" 
                        onclick="Button1_Click" /></td>
                <td><asp:Button ID="Button2" runat="server" Text="Back to Track my health" 
                        PostBackUrl="~/usertrackmyhealth.aspx" /></td>
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

