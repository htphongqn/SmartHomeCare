<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="adminsitemap.aspx.cs" Inherits="adminsitemap" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
<div class="div_title">Site Map</div>
<div class="items">
    <ul>
        <li class="tt"><a href="userinformation.aspx">User Management</a></li>
        <li><a href="userinformation.aspx">User Management Details</a></li>

        <li class="tt"><a href="#">Report</a></li>
        <li><a href="usertrackmyhealth.aspx">Statistic </a></li>

        <li class="tt"><a href="#" >Logs</a></li>
        <li><a href="usercompose.aspx">Webadmin Logs</a></li>
        <li><a href="userinbox.aspx">Sync Logs</a></li>

         <li class="tt"><a href="#">System Tool</a></li>
         <li ><a href="userbillingaccountsummar.aspx">Security</a></li>
         <li ><a href="userbillingaccountsummar.aspx">Configure</a></li>
       
         <li class="tt"><a href="#">Messages Center</a> </li>
         <li ><a href="userbillingaccountsummar.aspx">Inbox</a></li>
         <li ><a href="userbillingaccountsummar.aspx">Sent Messages</a></li>
          
       
         <li class="tt"><a href="#">My Account</a></li>
    </ul>

</div>

<div class="clear"></div>
</asp:Content>

