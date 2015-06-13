<%@ Page Title="" Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="urlinvalid.aspx.cs" Inherits="urlinvalid" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <style type="text/css">
        .divinfo
        {
            margin-top:10px;
            padding-left:20px;
            padding-bottom:40px;
            font-size:14px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="menu" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="main" Runat="Server">
<div class="divinfo">
        The requested URL is invalid.<br />
        Click <a href="home.aspx">here</a> for home page
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" Runat="Server">
</asp:Content>

