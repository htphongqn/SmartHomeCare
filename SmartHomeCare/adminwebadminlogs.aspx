<%@ Page Title="" Language="C#" MasterPageFile="~/siteadmin.master" AutoEventWireup="true" CodeFile="adminwebadminlogs.aspx.cs" Inherits="adminwebadminlogs" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <style type="text/css">
    .margin
    {
        margin:7px;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server" >
<asp:Panel runat="server" ID="p" DefaultButton="btnfilter">
    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                   Webadmin Logs
                </div>
             </div>
            <div class="floatright">
                <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                <a id="adminhelp" href="#"><img src="resources/images/h.png" /></a>
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
     <div id="print" style="height:580px">
     <asp:UpdatePanel ID="UpdateTable" runat="server">
                <ContentTemplate>  
     <div class="clear" style="margin-bottom:30px">
        <table align="center" width="95%">
            <tr>
                <td>Username:</td>
                <td colspan="5"><asp:TextBox ID="txtusername" runat="server" Width="140px"></asp:TextBox></td>                
                
            </tr>
            <tr>
                <td>From Date:</td>
                    <td><asp:TextBox ID="txtfromdate" runat="server" Width="140px"></asp:TextBox>
                        <asp:CalendarExtender ID="txtfromdate_CalendarExtender" runat="server" Format="MM/dd/yyyy"  CssClass="orange"
                            Enabled="True" TargetControlID="txtfromdate">
                        </asp:CalendarExtender>
                    </td>
                    <td>To Date:</td>
                    <td><asp:TextBox ID="txttodate" runat="server" Width="140px"></asp:TextBox>
                        <asp:CalendarExtender ID="txttodate_CalendarExtender" runat="server" Format="MM/dd/yyyy"  CssClass="orange"
                            Enabled="True" TargetControlID="txttodate">
                        </asp:CalendarExtender>
                    </td>
                <td  align="center"> <asp:Button ID="btnfilter" runat="server" 
                        Text="Filter" onclick="btnfilter_Click" /></td>
            </tr>
        </table>
    </div>
        <div class="">
            <asp:Panel ID="table_item" runat="server" CssClass="table_item" >
                                  <div class="title_grv margin-top-20px" >
                                    <table>
                                        <tr>
                                            <td style="width:170px;">
                                                DateTime
                                            </td>
                                            <td style="width:150px;">
                                                Username
                                            </td>
                                            <td style="width:150px;">
                                                UserType
                                            </td>
                                            <td style="width:150px;">
                                                Notes
                                            </td>
                                            <td style="width:150px;">
                                                IP
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                                <!-- Title -->
            <div class="content_grv" style="height:444px">
            <asp:GridView ID="grdlogs" runat="server" AutoGenerateColumns="False" 
                EmptyDataText="There is no record to show !"  AllowPaging="True" 
                PageSize="1000" Width="100%" onpageindexchanging="grdlogs_PageIndexChanging" 
                    ShowHeader="False" >
                <Columns>
                
                    <asp:BoundField DataField="LoginTime" HeaderText="DateTime" >
                    <ItemStyle Width="170px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="UserName" HeaderText="Username">
                    <ItemStyle Width="150px" /></asp:BoundField>
                    <asp:BoundField DataField="RuleName" HeaderText="UserType">
                    <ItemStyle Width="150px" /></asp:BoundField>
                    <asp:BoundField  DataField="Notes" HeaderText="Notes">
                    <ItemStyle Width="150px" /></asp:BoundField>
                    <asp:BoundField DataField="LoginFromComputerIP" HeaderText="IP">
                    <ItemStyle Width="150px" /></asp:BoundField>
                </Columns>
                <PagerSettings Visible="False" />
            </asp:GridView>
             </div><!-- table -->
            <div class="footer_grv">
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
        </div>
  </ContentTemplate>
  </asp:UpdatePanel>
  <asp:UpdateProgress ID="UpadateProc" AssociatedUpdatePanelID="UpdateTable" runat="server">
            <ProgressTemplate>
                    <div class="loading">
                <img src="resources/images/process.gif" />
            </div>
    </ProgressTemplate>
    </asp:UpdateProgress>
  </div>
   </asp:Panel>
</asp:Content>

