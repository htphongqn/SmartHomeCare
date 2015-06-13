<%@ Page Title="" Language="C#" MasterPageFile="~/cms/sitecms.master" AutoEventWireup="true" CodeFile="account.aspx.cs" Inherits="Admin_account" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                  Accounts List
                </div>
             </div>
            <div class="floatright">
                
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
    <div class="cms_gridview">
        <asp:GridView ID="grdParameter" runat="server" AutoGenerateColumns="False" 
            EmptyDataText="There is no record to show !" AllowPaging="True" 
            onpageindexchanging="grdParameter_PageIndexChanging" PageSize="25" 
            Width="100%" Font-Size="Small">
            <Columns>
                <asp:TemplateField HeaderText="Username">
                    <ItemTemplate>
                    
                        <asp:HyperLink ID="hpEdit" NavigateUrl='<%# "account_info.aspx?Id="+Convert.ToString(Eval("UserName")) %>' Text='<%# Bind("UserName")%>' runat="server"></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="First Name" DataField="Firstname" />
                <asp:BoundField HeaderText="Last Name" DataField="Lastname" />
                <asp:BoundField DataField="EmailAddress" HeaderText="EmailAddress" />
                <%--<asp:BoundField DataField="DateOfBirth"  />--%>
                <asp:TemplateField HeaderText="DateOfBirth">
                    <ItemTemplate >
                        <asp:Label ID="lbb" runat="server"  Text='<%# Bind("DateOfBirth", "{0:MM/dd/yyyy}") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
               <%-- <asp:BoundField DataField="UserName" HeaderText="UserName" />
                <asp:BoundField DataField="HomePhone" HeaderText="HomePhone" />
                <asp:BoundField DataField="MobilePhone" HeaderText="MobilePhone" />--%>
                <asp:BoundField DataField="UserTypeName" HeaderText="User Type Name" />
                <asp:BoundField DataField="RuleName" HeaderText="Rule Name" />
                
            </Columns>
        </asp:GridView>
    </div><!-- GridTable -->
      <asp:Button ID="btnAddnew" runat="server" Text="Add new account" 
          CssClass="Button_Orage" Visible="False"/>
</asp:Content>

