<%@ Page Title="" Language="C#" MasterPageFile="~/cms/sitecms.master" AutoEventWireup="true" CodeFile="adminmessages.aspx.cs" Inherits="Admin_adminmessages" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
   <div class="title_new">
            <div class="floatleft">
                <div class="td">
                 Messages List
                </div>
             </div>
            <div class="floatright">
                
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
    <div class="">
     <div class="cms_gridview">
        <asp:GridView ID="grdMessages" runat="server" AutoGenerateColumns="False" 
            EmptyDataText="There is no record to show !" AllowPaging="True" 
            onpageindexchanging="grdMessages_PageIndexChanging" PageSize="25" 
             Width="100%" Font-Size="Small"> 
            <Columns>
                <asp:TemplateField HeaderText="Code">
                    <ItemTemplate>
                        <asp:HyperLink ID="hl" runat="server" NavigateUrl='<%# "~/cms/adminmessages_info.aspx?MId="+ Eval("AutoId")%>' Text='<%#Eval("Code")%>'></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField HeaderText="Title" DataField="Title" />
                <asp:BoundField HeaderText="Title Viet Nam" DataField="TitleVN" />
                <asp:BoundField HeaderText="Note" DataField="Note" />
                 <asp:BoundField HeaderText="Approved" DataField="IsApproved" />
            </Columns>
            <PagerSettings Mode="NumericFirstLast" />
        </asp:GridView>
        </div>
        <br />
    <asp:Button ID="btnAddnew" runat="server" Text="Add new messages" 
    CssClass="Button_Orage" PostBackUrl="~/cms/adminmessages_info.aspx"/>
 </div>
</asp:Content>

