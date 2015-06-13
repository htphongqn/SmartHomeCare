<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="x_usertrackmyhealth_temperature_table.aspx.cs" Inherits="usertrackmyhealth_temperature_table" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <script src="scripts/Print.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
<div id="print">
    <div class="borderbottom">
        <div class="floatleft title">Track <asp:Label ID="lbNameHealth" runat="server" Text="my"></asp:Label> health<br />Temperature</div>
        <div class="floatright"> <asp:LinkButton runat="server" ID="lb" Text="Print" OnClientClick="return printDiv('print');"></asp:LinkButton>   <a href="userhelp.aspx">Help</a></div>
        <div class="clear"></div>
    </div>
    <br />
     <div class="clear borderbottom">
        <table class="clear" width="100">
            <tr>
                <td><asp:Button ID="btngraph" runat="server" Text="Graph" 
                        PostBackUrl="~/usertrackmyhealth_temperature_graph.aspx" 
                        ForeColor="Gray" /></td>
                <td><asp:Button ID="btntable" runat="server" Text="Table" PostBackUrl="#" 
                        onclick="btntable_Click" /></td>
            </tr>
        </table>
        
        <div id="table" class="gridview">
         
        <asp:GridView ID="grvTemp" runat="server" AllowPaging="True" 
            AutoGenerateColumns="False" EmptyDataText="There is no record to show !" 
                onpageindexchanging="grvTemp_PageIndexChanging">
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
          
        </asp:GridView>
            
        </div>
        </div>
   </div><!-- print -->
        <div>
            
           <table>
                <tr>
                    <td>
                    From date:
                        <asp:Label ID="Label1" runat="server" Text="(mm/dd/yyyy hh:mm) " 
                            Font-Italic="True" Font-Size="Small"></asp:Label>
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
                            Height="48px" Width="63px" />
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
    
    
        <div class="title">Diagnosis & Recommendations</div>
        <div  class="borderbottom">This page displays your current mediacal issues and the date that they were noded in your 
            medical record. Click on the issue name for more in-depth information on that particular issue.
        </div>
       
        <br />
        <div class="clear">
        <table class="clear" width="200">
            <tr>
                <td><asp:Button ID="Button1" runat="server" Text="Settings" 
                        PostBackUrl="~/usertrackmyhealth_temperature_settings.aspx" /></td>
                <td><asp:Button ID="Button2" runat="server" Text="Back to Track my health" 
                        PostBackUrl="~/usertrackmyhealth.aspx" /></td>
            </tr>
        </table>
    </div>
</asp:Content>

