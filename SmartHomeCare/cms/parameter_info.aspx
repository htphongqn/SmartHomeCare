<%@ Page Title="" Language="C#" MasterPageFile="~/cms/sitecms.master" AutoEventWireup="true" CodeFile="parameter_info.aspx.cs" Inherits="Admin_parameter_addnew" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <style type="text/css">
        .style1
        {
            width: 133px;
        }
        .style2
        {
            width: 176px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">


   
<div class="floatleft">
<h1>Parameter</h1>
    <asp:Label ID="lbMessages" runat="server" ForeColor="Red" Visible="False">Incorrect</asp:Label>
    <table>
        <tr>
            <td class="style2">Parameter Code</td>
            <td class="style1">&nbsp;</td>
        </tr>
        <tr>
            <td class="style2">
                <asp:TextBox ID="txtCode" runat="server" CssClass="TextBox" Height="25px" 
                    Width="300px"></asp:TextBox>
            </td>
            <td class="style1">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="txtCode" ErrorMessage="* field not empty ." ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style2">Description</td>
            <td class="style1">&nbsp;</td>
        </tr>
        <tr>
            <td class="style2">
                <asp:TextBox ID="txtDescription" runat="server" CssClass="TextBox" 
                    Height="25px" Width="300px"></asp:TextBox>
            </td>
            <td class="style1">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="txtDescription" ErrorMessage="* field not empty ." 
                    ForeColor="Red"></asp:RequiredFieldValidator>
            </td>
        </tr>
        <tr>
            <td class="style2">Value</td>
            <td class="style1">&nbsp;</td>
        </tr>
        <tr>
            <td class="style2">
                <asp:TextBox ID="txtValue" runat="server" CssClass="TextBox" Height="25px" 
                    Width="300px"></asp:TextBox>
            </td>
            <td class="style1">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2">Note</td>
            <td class="style1">&nbsp;</td>
        </tr>
        <tr>
            <td class="style2">
                <asp:TextBox ID="txtNote" runat="server" CssClass="TextBox" Height="25px" 
                    Width="300px"></asp:TextBox>
            </td>
            <td class="style1">
                &nbsp;</td>
        </tr>
        <tr>
            <td class="style2">IsActive</td>
            <td class="style1">&nbsp;</td>
        </tr>
        <tr>
            <td class="style2">
                <asp:CheckBox ID="chkIsActive" runat="server" />
            </td>
            <td class="style1">
                &nbsp;</td>
        </tr>
        <tr>
            <td colspan="2">
                <asp:Button ID="btnAddNew" runat="server" Text="Save"  CssClass="Button_Orage" 
                     onclick="btnAddNew_Click"/>
                 <asp:Button ID="btnUpdate" runat="server" Text="Update"  
                     CssClass="Button_Orage" Visible="False"/>
                 <asp:Button ID="btnCancel" runat="server" Text="Cancel"  CssClass="Button_Blue" 
                     PostBackUrl="~/cms/parameter.aspx" CausesValidation="False" 
                    onclick="btnCancel_Click"/>
                <br />
            </td>
        </tr>
        </table>
    
</div><!-- Infomation -->

         

    
               

</asp:Content>

