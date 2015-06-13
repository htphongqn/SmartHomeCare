<%@ Page Title="" Language="C#" MasterPageFile="~/cms/sitecms.master" AutoEventWireup="true" CodeFile="emailtemplex_info.aspx.cs" Inherits="cms_emailtemplex_info" %>

<%@ Register assembly="CKEditor.NET" namespace="CKEditor.NET" tagprefix="CKEditor" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="title">Email's template</div>
    <br />
    Code:<br />
    <asp:TextBox ID="txtcode" runat="server" Width="220px"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
        ControlToValidate="txtcode" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
    <br />
    Note:<br />
    <asp:TextBox ID="txtnote" runat="server" Width="220px"></asp:TextBox>
    <br />
    Subject:<br />
    <asp:TextBox ID="txtsubject" runat="server" Width="397px" Height="18px"></asp:TextBox>
    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
        ControlToValidate="txtsubject" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
    <br />
    Body : <span class="silver"> (No change @...)</span><br />
    <CKEditor:CKEditorControl ID="txtbody" runat="server" Width="98%">
        
    </CKEditor:CKEditorControl>
    <br />
    <asp:Button ID="btnUpdate" runat="server" Text="Save"  onclick="btnUpdate_Click" />
    <asp:Button ID="btnCancel" runat="server" Text="Cancel" CausesValidation="False" PostBackUrl="~/cms/emailtemplex.aspx" />
</asp:Content>

