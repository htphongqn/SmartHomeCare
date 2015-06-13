<%@ Page Title="" Language="C#" MasterPageFile="~/cms/sitecms.master" AutoEventWireup="true" CodeFile="parameter.aspx.cs" Inherits="cms_parameter" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                   Parameters List
                </div>
             </div>
            <div class="floatright">
                
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
    <div class="cms_gridview">
        <asp:GridView ID="grdParameter" runat="server" AutoGenerateColumns="False" 
            EmptyDataText="There is no record to show !"  AllowPaging="True"
         PageSize="25">
            <Columns>
                <asp:TemplateField HeaderText="Code">
                    <ItemTemplate>
                        <asp:HyperLink ID="hpCode" runat="server" NavigateUrl='<%# "~/cms/parameter_info.aspx?PId="+Eval("AutoId")%>' Text='<%# Bind("ParamCode") %>'></asp:HyperLink>
                    </ItemTemplate>
                </asp:TemplateField>
                
                <asp:BoundField DataField="Description" HeaderText="Description" />
                
                <asp:BoundField HeaderText="Value" DataField="ParamValue" />
                 <asp:BoundField HeaderText="Note" DataField="Note" />
                 <asp:BoundField HeaderText="Active" DataField="IsActive" />
            </Columns>
        </asp:GridView>
        </div>
        <asp:Button ID="btnAddnew" runat="server" Text="Add new parameters" 
                    CssClass="Button_Orage" PostBackUrl="~/cms/parameter_info.aspx" 
                        onclick="btnAddnew_Click"/>
</asp:Content>

