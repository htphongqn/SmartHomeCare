<%@ Page Title="" Language="C#" MasterPageFile="~/cms/sitecms.master" AutoEventWireup="true" CodeFile="adminmessages_info.aspx.cs" Inherits="Admin_adminmessages_addnew" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 186px;
        }
        .style2
        {
            width: 359px;
        }
        .TextBox
        {}
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    
<div class="floatleft">
<h1>Messages </h1>
    <asp:Label ID="lbmessages" runat="server" Text="Error" Visible="False" 
        ForeColor="Red"></asp:Label>
    <table>
        <tr>
            <td class="style2">Code</td>
            <td class="style1">&nbsp;</td>
        </tr>
        <tr>
            <td class="style2">
                <asp:TextBox ID="txtCode" runat="server" CssClass="TextBox" Width="215px" 
                    Height="25px"></asp:TextBox>
            </td>
            <td class="style1">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txtCode" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style2">Title</td>
            <td class="style1">&nbsp;</td>
        </tr>
        <tr>
            <td class="style2">
                <asp:TextBox ID="txtTitle" runat="server" CssClass="TextBox" Width="356px" 
                    Height="25px"></asp:TextBox>
            </td>
            <td class="style1">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="txtTitle" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        
        
        <tr>
            <td class="style2">
                Title Viet Nam</td>
            <td class="style1">
                &nbsp;</td>
        </tr>
        
        
        <tr>
            <td class="style2">
                <asp:TextBox ID="txtTitleVN" runat="server" CssClass="TextBox" Width="355px" 
                    Height="25px"></asp:TextBox>
            </td>
            <td class="style1">
                &nbsp;</td>
        </tr>
        
        
        <tr>
            <td class="style2">
                Note</td>
            <td class="style1">
                &nbsp;</td>
        </tr>
        
        
        <tr>
            <td class="style2">
                <asp:TextBox ID="txtNote" runat="server" Height="25px" Width="351px"></asp:TextBox>
            </td>
            <td class="style1">
                &nbsp;</td>
        </tr>
        
        
        <tr>
            <td class="style2">
                <asp:CheckBox ID="chkApproved" runat="server" Text="Is Approved" />
            </td>
            <td class="style1">
                &nbsp;</td>
        </tr>
        
        
        </table>
    
</div><!-- Infomation -->
<div class="clear"></div>
<div class="control">
         <br />
         <asp:Button ID="btnAddNew" runat="server" Text="Save"  CssClass="Button_Orage" 
             onclick="btnAddNew_Click"/>
         <asp:Button ID="btnUpdate" runat="server" Text="Update"  
             CssClass="Button_Orage" Visible="False" onclick="btnUpdate_Click"/>
         <asp:Button ID="btnCancel" runat="server" Text="Cancel"  CssClass="Button_Blue" 
             PostBackUrl="~/cms/adminmessages.aspx" CausesValidation="False"/>
</div>
</asp:Content>

