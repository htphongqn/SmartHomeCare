<%@ Page Title="" Language="C#" MasterPageFile="~/siteadmin.master" AutoEventWireup="true" CodeFile="x_adminsitemap.aspx.cs" Inherits="adminsitemap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
<div class="item">
    <asp:TreeView ID="TreeView2" runat="server">
    <Nodes>
        <asp:TreeNode Text="Admin Site Map" Value="Admin Site Map">
            <asp:TreeNode NavigateUrl="~/adminusermanagement.aspx" Text="User Management" 
                Value="User Management">
                <asp:TreeNode NavigateUrl="~/adminusermanagement_details.aspx" 
                    Text="User Management Details" Value="User Management Details">
                </asp:TreeNode>
            </asp:TreeNode>
            <asp:TreeNode Text="Report" Value="Report">
                <asp:TreeNode NavigateUrl="~/adminreportstatistics.aspx" Text="Statistic " 
                    Value="Statistic "></asp:TreeNode>
            </asp:TreeNode>
            <asp:TreeNode Text="Logs" Value="Logs">
                <asp:TreeNode NavigateUrl="~/adminwebadminlogs.aspx" Text="Webadmin Logs" 
                    Value="Webadmin Logs"></asp:TreeNode>
                <asp:TreeNode NavigateUrl="~/adminsynclogs.aspx" Text="Sync Logs" 
                    Value="Sync Logs"></asp:TreeNode>
            </asp:TreeNode>
            <asp:TreeNode Text="System Tool" Value="System Tool"></asp:TreeNode>
            <asp:TreeNode Text="Messages Center" Value="Messages Center">
                <asp:TreeNode NavigateUrl="~/admininbox.aspx" Text="Inbox" Value="Inbox">
                </asp:TreeNode>
                <asp:TreeNode NavigateUrl="~/adminsentmessages.aspx" Text="Sent Messages" 
                    Value="Sent Messages"></asp:TreeNode>
            </asp:TreeNode>
            <asp:TreeNode NavigateUrl="~/adminmyaccount.aspx" Text="My Account" 
                Value="My Account"></asp:TreeNode>
        </asp:TreeNode>
    </Nodes>
</asp:TreeView>
</div>
</asp:Content>

