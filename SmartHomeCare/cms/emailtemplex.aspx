<%@ Page Title="" Language="C#" MasterPageFile="~/cms/sitecms.master" AutoEventWireup="true" CodeFile="emailtemplex.aspx.cs" Inherits="cms_EmailTemplex" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                   List email's template
                </div>
             </div>
            <div class="floatright">
                
            </div>
            <div class="clear"></div>
     </div><!-- border bottom --> 
    <div class="cms_gridview">
    <asp:GridView ID="grvemailtemplates" runat="server" AutoGenerateColumns="False" Width="100%">
        <Columns>
            
            <asp:TemplateField HeaderText="ID">
                <ItemTemplate>
                    <asp:HyperLink ID="hpid" runat="server" NavigateUrl='<%# "~/cms/emailtemplex_info.aspx?Id="+ Eval("AutoId") %>' Text='<%# Eval("AutoId") %>'></asp:HyperLink>
                </ItemTemplate>
                <HeaderStyle Width="50px" />
                <ItemStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:BoundField DataField="Code" HeaderText="Code" >
            <HeaderStyle Width="100px" />
            </asp:BoundField>
            <asp:BoundField DataField="Subject" HeaderText="Subject" >    
            <ItemStyle Width="30%" />
            </asp:BoundField>
            <asp:BoundField DataField="Note" HeaderText="Note" >
            <HeaderStyle Width="100px" />
            <ItemStyle Width="50%" />
            </asp:BoundField>        
        </Columns>
    </asp:GridView>
    </div>
    <asp:Button runat="server" ID="btnAdd" Text="Add new email's template" 
        PostBackUrl="~/cms/emailtemplex_info.aspx" />
</asp:Content>

