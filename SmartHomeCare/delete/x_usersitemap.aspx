<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="x_usersitemap.aspx.cs" Inherits="usersitemap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <asp:TreeView ID="TreeView2" runat="server">
    <Nodes>
        <asp:TreeNode Text=" User Site Map" Value="Site Map">
            <asp:TreeNode Text="Home" Value="Home page"></asp:TreeNode>
            <asp:TreeNode Text="My Profile" Value="My profile">
                <asp:TreeNode NavigateUrl="~/userinformation.aspx" Text="User Information" 
                    Value="User Information"></asp:TreeNode>
                <asp:TreeNode NavigateUrl="~/userchangepassword.aspx" Text="Change Password" 
                    Value="Change Password"></asp:TreeNode>
                <asp:TreeNode NavigateUrl="~/userauthorizedusers.aspx" Text="Authorized Users" 
                    Value="Authorized Users"></asp:TreeNode>
            </asp:TreeNode>
            <asp:TreeNode Text="Report" Value="Report">
                <asp:TreeNode Text="Track My Health" Value="Track My Health">
                    <asp:TreeNode NavigateUrl="~/usertrackmyhealth_globalsetting.aspx" 
                        Text="Global Setting" Value="Global Setting"></asp:TreeNode>
                    <asp:TreeNode NavigateUrl="~/usertrackmyhealth_temperature_graph.aspx" 
                        Text="Temperature Tracking Feature" Value="Temperature Tracking Feature">
                        <asp:TreeNode NavigateUrl="~/usertrackmyhealth_temperature_settings.aspx" 
                            Text="Temperature Setting" Value="Temperature Setting"></asp:TreeNode>
                    </asp:TreeNode>
                </asp:TreeNode>
                <asp:TreeNode NavigateUrl="~/usertrackothers.aspx" Text="Track Others" 
                    Value="Track Others">
                    <asp:TreeNode NavigateUrl="~/usertrackotherhealth.aspx" 
                        Text="Track Others Features" Value="Track Others Features"></asp:TreeNode>
                    <asp:TreeNode NavigateUrl="~/usertrackothers_globalsetting.aspx" 
                        Text="Global Setting" Value="Global Setting"></asp:TreeNode>
                    <asp:TreeNode NavigateUrl="~/usertrackothers_temperature_graph.aspx" 
                        Text="Others Temperature Tracking Feature" 
                        Value="Others Temperature Tracking Feature">
                        <asp:TreeNode NavigateUrl="~/usertrackothers_temperature_settings.aspx" 
                            Text="Temperature Setting" Value="Temperature Setting"></asp:TreeNode>
                    </asp:TreeNode>
                </asp:TreeNode>
            </asp:TreeNode>
            <asp:TreeNode Text="Message Center" Value="Message center">
                <asp:TreeNode NavigateUrl="~/userinbox.aspx" Text="Inbox " Value="Inbox ">
                </asp:TreeNode>
                <asp:TreeNode NavigateUrl="~/usersentmessages.aspx" Text="Sent Messages" 
                    Value="Sent Messages"></asp:TreeNode>
                <asp:TreeNode NavigateUrl="~/useralarmmessages.aspx" Text="Alarm Messages" 
                    Value="Alarm Messages"></asp:TreeNode>
            </asp:TreeNode>
            <asp:TreeNode Text="Billing Account" Value="Billing Account">
                <asp:TreeNode NavigateUrl="~/userbillingaccountsummar.aspx" 
                    Text="Billing Account Summary" Value="Billing Account Summary">
                    <asp:TreeNode NavigateUrl="~/useraccountdetails.aspx" Text="Account Details" 
                        Value="Account Details"></asp:TreeNode>
                    <asp:TreeNode NavigateUrl="~/userpaymentinformation.aspx" 
                        Text="Payment Information " Value="Payment Information "></asp:TreeNode>
                    <asp:TreeNode NavigateUrl="~/userpaybill.aspx" Text="Pay Bill" Value="Pay Bill">
                    </asp:TreeNode>
                    <asp:TreeNode NavigateUrl="~/userpayment_review.aspx" Text="Payment Review" 
                        Value="Payment Review"></asp:TreeNode>
                    <asp:TreeNode NavigateUrl="~/userpayment_receipt.aspx" Text="Payment Receipt" 
                        Value="Payment Receipt"></asp:TreeNode>
                </asp:TreeNode>
            </asp:TreeNode>
        </asp:TreeNode>
    </Nodes>
</asp:TreeView>
</asp:Content>

