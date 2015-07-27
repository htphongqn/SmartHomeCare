<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="usercompose.aspx.cs" Inherits="usercompose" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <style type="text/css">
        td, th {padding: 5px;}
    </style>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">Message center</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Compose message
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                        <table width="100%" align="left" cellspacing="10">
                            <tr>
                                <td colspan="2"><asp:Label ID="lbmessage" runat="server" ForeColor="Red"></asp:Label></td>
                            </tr>
                            <tr>
                                <td width="120">From</td>
                                <td><asp:TextBox ID="txtMailFrom" runat="server" CssClass="form-control" 
                                        Enabled="False"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td>To</td>
                                <td>
                                    <asp:TextBox ID="txtMailTo" runat="server" CssClass="form-control"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"  ValidationGroup="g11" Display="None"
                                        ErrorMessage="Please, Enter Mail to!" ControlToValidate="txtMailTo" ForeColor="Red" 
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                        ControlToValidate="txtMailTo" ErrorMessage="The email is invalid" 
                                        ForeColor="#CC0000" ValidationGroup="g11" Display="None"
                                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" ></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>Subject</td>
                                <td>
                                    <asp:TextBox ID="txtSubject" runat="server" CssClass="form-control"></asp:TextBox>      
                                </td>
                            </tr>
                            <tr>
                                <td>Message</td>
                                <td>
                                    <asp:TextBox ID="txtMessage" runat="server" CssClass="form-control" TextMode="MultiLine"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <asp:Button ID="btnSend" runat="server" onclick="btnSend_Click" Text="Send" ValidationGroup="g11" CssClass="btn btn-default"/>
                        <asp:Button ID="btndelete0" runat="server" Text="Cancel" CssClass="btn btn-default"
                            PostBackUrl="~/userhome.aspx" CausesValidation="False" />
                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true" ShowSummary="false" ValidationGroup="g11" />
                        <div>
                            <asp:Label ID="lblMessage" runat="server" ForeColor="Red" Visible="False"></asp:Label>
                        </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

