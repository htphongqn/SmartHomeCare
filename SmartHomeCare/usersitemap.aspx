<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usersitemap.aspx.cs" Inherits="usersitemap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
<div class="div_title">Site Map</div>
<%--<div class="item">
    <ul>
        <li class="tt"><a href="#">Home</a></li>
        
    </ul>
</div>--%>
<div class="div_content">
<div class="item">
    <ul>
        <li class="tt"><a href="userinformation.aspx">My Profile</a></li>
        <li><a href="userinformation.aspx">User Information</a></li>
        <li><a href="userchangepassword.aspx">Change Password</a></li>
        <li><a href="userauthorizedusers.aspx">Authorized Users</a></li>
    </ul>
</div>
<div class="item">
    <ul>
        <li class="tt"><a href="#">Report</a></li>
        <li><a href="usertrackmyhealth.aspx">Track My Health</a>
            <ul>
                <li><a href="usertrackmyhealth_globalsetting.aspx">Global Setting</a></li>
                <li><a href="usertrackmyhealth_temperature_graph.aspx">Temperature Tracking Feature</a>
                    
                </li>
            </ul>
        </li>
        <li><a href="usertrackothers.aspx">Track Others</a>
             <ul>
                <li><a href="usertrackotherhealth.aspx">Track Others Feature</a></li>
                <li><a href="usertrackothers_globalsetting.aspx">Global Setting</a></li>
                <li><a href="usertrackothers_temperature_graph.aspx">Temperature Tracking Feature</a>
                    
                </li>
            </ul>
        </li>
        
    </ul>
</div>
<%--<div class="clear"></div>--%>
<div class="item">
    <ul>

        <li class="tt"><a href="#" >Messages Center</a></li>
        
        <li><a href="userinbox.aspx">Inbox</a></li>
        <li><a href="usersentmessages.aspx">Sent Messages</a></li>
        <li><a href="usertrash.aspx">Trash Messages</a></li>
        <li><a href="useralarmmessages.aspx">Alarm messages</a></li>
    </ul>
</div>
<div class="item" style="border:none;">
    <ul>
    <li class="tt"><a href="#">Billing Account </a></li>
        <li ><a href="userbillingaccountsummar.aspx">Billing Account Summary</a>
           
        </li>
        <li><a href="userpaymentinformation.aspx">	Coverage Details</a></li>
    </ul>
</div>
<div class="clear"></div>
</div>
</asp:Content>

