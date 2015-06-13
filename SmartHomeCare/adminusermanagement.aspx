<%@ Page Title="" Language="C#" MasterPageFile="~/siteadmin.master" AutoEventWireup="true" CodeFile="adminusermanagement.aspx.cs" Inherits="adminusermanagement" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <style type="text/css">
    .margin
    {
        margin:7px;
    }
    .padding
    {
        padding:20px;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
   
    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                   User Management
                </div>
             </div>
            <div class="floatright">
               <%-- <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;--%>
                <a id="adminhelp" href="#"><img src="resources/images/h.png" /></a>
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
    <div>
        <br />
    </div>
    <div>
        <table align="center" width="90%">
            <tr>
                <td>User ID:</td>
                <td><asp:TextBox ID="txtuserid" runat="server" Width="220px" onkeypress="return ValidateKeypress(/\d/,event);"></asp:TextBox></td>
                <td>Username:</td>
                <td><asp:TextBox ID="txtusername" runat="server" Width="220px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Email:</td>
                <td><asp:TextBox ID="txtemail" runat="server" Width="220px"></asp:TextBox></td>
                <td>Status:</td>
                <td><asp:DropDownList ID="ddlactive" runat="server" Width="230px">
                    <asp:ListItem Value="-1" Text="(All)"></asp:ListItem>
                    <asp:ListItem Value="1" Text="Active"></asp:ListItem>
                    <asp:ListItem Value="0" Text="Deactive"></asp:ListItem>
                </asp:DropDownList></td>
            </tr>
            <tr>
                <td>From Date:</td>
                <td><asp:TextBox ID="txtfromdate" runat="server" Width="220px"></asp:TextBox>
                    <asp:CalendarExtender ID="txtfromdate_CalendarExtender" runat="server" Format="MM/dd/yyyy"  CssClass="orange"
                        Enabled="True" TargetControlID="txtfromdate">
                    </asp:CalendarExtender>
                </td>
                <td>To Date:</td>
                <td><asp:TextBox ID="txttodate" runat="server" Width="220px"></asp:TextBox>
                    <asp:CalendarExtender ID="txttodate_CalendarExtender" runat="server" Format="MM/dd/yyyy"  CssClass="orange"
                        Enabled="True" TargetControlID="txttodate">
                    </asp:CalendarExtender>
                </td>
            </tr>
            <tr>
                <td colspan="4" align="center"> <asp:Button ID="btnfilter" runat="server" 
                        Text="Filter" onclick="btnfilter_Click" /></td>
            </tr>
        </table>
    </div>
    <div>
        <%--paging--%>
    </div>
    <div class="gridview">
        <asp:GridView ID="grdusermanagement" runat="server" AutoGenerateColumns="False" 
            EmptyDataText="There is no record to show !"  AllowPaging="True" 
            PageSize="25" Width="95%" 
            onpageindexchanging="grdusermanagement_PageIndexChanging">
            <Columns>

                <asp:TemplateField HeaderText="ID">
                    <ItemTemplate>
                        <asp:CheckBox ID="chkcheckuser" runat="server" ></asp:CheckBox>
                        <asp:HyperLink ID="hplID" runat="server" Text='<%# Eval("AutoId") %>' NavigateUrl='<%#"~/adminusermanagement_details.aspx?user=" + Eval("UserName") %>'></asp:HyperLink>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="70px" />
                </asp:TemplateField>
                
                <asp:BoundField DataField="UserName" HeaderText="Username" />
                
                <asp:BoundField DataField="EmailAddress" HeaderText="Email"/>
                <asp:BoundField DataField="Status" HeaderText="Status" >
                
                <ItemStyle HorizontalAlign="Center" />
                </asp:BoundField>
                
                <asp:BoundField  DataField="Notes" HeaderText="Note"/>
                <asp:BoundField  DataField="RuleName" HeaderText="MemeberType"/>
            </Columns>
        </asp:GridView>
    </div>
    <div class="padding textcenter">
        <asp:Button ID="btnactive" runat="server" Text="Active account" 
            onclick="btnactive_Click" />
        <asp:Button ID="btndeactive" runat="server" Text="Deactive account" onclick="btndeactive_Click" 
             />
    </div>
</asp:Content>

