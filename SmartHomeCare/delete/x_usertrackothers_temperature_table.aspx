<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="x_usertrackothers_temperature_table.aspx.cs" Inherits="usertrackothers_temperature_table" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <script src="scripts/Print.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
 <div id="print">
<div class="borderbottom">
        <div class="floatleft title">Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health<br />Temperature</div>
        <div class="floatright"> <asp:LinkButton runat="server" ID="lb" Text="Print" OnClientClick="return printDiv('print');"></asp:LinkButton>      <a href="userhelp.aspx">Help</a></div>
        <div class="clear"></div>
    </div>
    <br />
     <div class="clear borderbottom">
        <table class="clear" width="100">
            <tr>
                <td><asp:Button ID="btngraph" runat="server" Text="Graph" 
                        PostBackUrl="~/usertrackothers_temperature_graph.aspx" /></td>
                <td><asp:Button ID="btntable" runat="server" Text="Table" PostBackUrl="#" 
                        onclick="btntable_Click" /></td>
            </tr>
        </table>
        <div id="table" class="gridview">
           
        <asp:GridView ID="grvTemp" runat="server" AllowPaging="True" 
            AutoGenerateColumns="False" BackColor="White" BorderColor="#CCCCCC" 
            BorderStyle="None" BorderWidth="1px" CellPadding="3" Width="98%" 
            EmptyDataText="No message" onpageindexchanging="grvTemp_PageIndexChanging">
            <Columns>
                <asp:BoundField DataField="ReceivedDate" 
                    DataFormatString="{0:MM/dd/yyyy hh:mm tt}" HeaderText="Received" >
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="SkinTemp" HeaderText="SkinTemp" >
                <ItemStyle HorizontalAlign="Center" VerticalAlign="Middle" />
                </asp:BoundField>
                <asp:BoundField DataField="AmbTemp" HeaderText="AmbTemp" >
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
        </div>
         </div><!-- print-->
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
                            Height="45px" Width="65px" />
                    </td>
                </tr>
                <tr>
                    <td>
                        To Date: <asp:Label ID="Label2" runat="server" Text="(mm/dd/yyyy hh:mm) " 
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
    
     <div class="clear">
        <div class="title">Diagnosis & Recommendations</div>
        <div  class="borderbottom">This page displays your current mediacal issues and the date that they were noded in your 
            medical record. Click on the issue name for more in-depth information on that particular issue.
        </div>
        </div>
       
        <div class="clear">
        <br />
        <table class="clear" width="200">
            <tr>
                <td><asp:Button ID="Button1" runat="server" Text="Settings" 
                        onclick="Button1_Click" /></td>
                <td><asp:Button ID="Button2" runat="server" Text="Cancel to Track other health" 
                        PostBackUrl="~/usertrackothers.aspx" /></td>
            </tr>
        </table>
    </div>
</asp:Content>

