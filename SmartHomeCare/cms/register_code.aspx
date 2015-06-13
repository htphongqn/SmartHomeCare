<%@ Page Title="" Language="C#" MasterPageFile="~/cms/sitecms.master" AutoEventWireup="true" CodeFile="register_code.aspx.cs" Inherits="cms_register_code" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
<div class="title_new">
            <div class="floatleft">
                <div class="td">
                   Register code
                </div>
             </div>
            <div class="floatright">
                
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
    <asp:UpdatePanel ID="UpdatePanel" runat="server">
        <ContentTemplate>
        &nbsp;&nbsp;
        <asp:DropDownList ID="ddlRule" runat="server" Height="25px" 
            onselectedindexchanged="ddlRule_SelectedIndexChanged">
        </asp:DropDownList>
        <asp:DropDownList ID="ddlIsUsing" runat="server" Height="25px">
            <asp:ListItem Value="2">(All)</asp:ListItem>
            <asp:ListItem Value="1">IsUsing</asp:ListItem>
            <asp:ListItem Value="0">NoneUsing</asp:ListItem>
    </asp:DropDownList>
    <asp:DropDownList ID="ddlDisable" runat="server" Height="25px">
        <asp:ListItem Value="2">(All)</asp:ListItem>
        <asp:ListItem Value="1">Disnable</asp:ListItem>
        <asp:ListItem Value="0">None Disable</asp:ListItem>
    </asp:DropDownList>
        <asp:Button ID="btnfilter" runat="server" onclick="btnfilter_Click" 
            Text="filter" />
  
    <div class="cms_gridview">
        <asp:GridView ID="grvRegister" runat="server" AutoGenerateColumns="False" 
            Width="100%" AllowPaging="True" 
            onpageindexchanging="GridView1_PageIndexChanging" PageSize="20" 
            AllowSorting="True" onsorting="GridView1_Sorting" >
            <Columns>
                <asp:BoundField HeaderText="RuleCode" DataField="RuleCode" 
                    SortExpression="RuleCode" >
                <ItemStyle HorizontalAlign="Center" Width="120px"/>
                </asp:BoundField>
                <asp:TemplateField HeaderText="Register Code" >
                    <ItemTemplate >
                        <asp:HyperLink ID="HyperLink1" runat="server" Text='<%# Eval("RegisterCode") %>' NavigateUrl='<%# "registercode_info.aspx?Code="+Eval("RegisterCode") %>' Enabled='<%# Convert.ToString(Eval("IsUsing"))=="0"?true:false %>'></asp:HyperLink>
                    </ItemTemplate>
                    <ItemStyle  HorizontalAlign="Center" />
                </asp:TemplateField>
               
                <asp:BoundField HeaderText="IsNotUse" DataField="IsNotUse" 
                    SortExpression="IsNotUse"/>
                <asp:BoundField HeaderText="IsUsing" DataField="IsUsing" 
                    SortExpression="IsUsing"/>
                <asp:BoundField HeaderText="IsDisable" DataField="IsDisable" 
                    SortExpression="IsDisable"/>
            </Columns>
            <PagerSettings Mode="NumericFirstLast" />
    </asp:GridView>
    </div>
    </ContentTemplate>
</asp:UpdatePanel>

</asp:Content>

