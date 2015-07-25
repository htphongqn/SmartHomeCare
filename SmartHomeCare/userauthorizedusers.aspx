<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="userauthorizedusers.aspx.cs" Inherits="userauthorizedusers" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <script type="text/javascript">
    function UserChecker(username) {

        lbl = document.getElementById('<%=lbcheckusername.ClientID %>');
        if (username == '' || username.length == 0) {
            lbl.innerHTML = '';
            lbl.style.color = "black";
        }
        else {

            PageMethods.UserNameChecker(username, OnSucceeded);
        }
    }

    function OnSucceeded(result, userContext, methodName) {
        lbl = document.getElementById('<%=lbcheckusername.ClientID %>');

        if (methodName == "UserNameChecker") {
            if (result == false) {
                lbl.innerHTML = 'User not exist';
                lbl.style.color = "red";
            }
            else {
                lbl.innerHTML = '<%= DBClass.GetMessageByCode2("user_available") %>';
                lbl.style.color = "green";
            }
        }
    }
    function Email_Checker(email) {

        lbl = document.getElementById('<%=lbinvitenewmember.ClientID %>');
        if (email == '' || email.length == 0) {
            lbl.innerHTML = '';
            lbl.style.color = "black";
        }
        else {

            PageMethods.EmailChecker(email, onSuccessEmailExist);
        }
    }
    function onSuccessEmailExist(result, userContext, methodName) {
        lbl = document.getElementById('<%=lbinvitenewmember.ClientID %>');

        if (methodName == "EmailChecker") {
            if (result == true) {
                lbl.innerHTML = '<%= DBClass.GetMessageByCode2("email_registered") %>';
                lbl.style.color = "red";
            }
            else {
                lbl.innerHTML = '';
                lbl.style.color = "green";
            }
        }
    }
    </script>
    <style type="text/css">
    td, th {
      padding: 5px;
    }
</style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header">My profile</h1>
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <div class="row">
        <div class="col-lg-12">
            <div class="panel panel-default">
                <div class="panel-heading">
                    Authorized users
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                        <table width="100%" align="left" cellspacing="5">
                            <tr id="trcurrent" runat="server">
                                <td width="220">Current authorized users</td>
                                <td><asp:ListBox ID="lstcurrentauthorizedusers" runat="server" CssClass="form-control"
                                        DataTextField="AuthorizedUser" DataValueField="AutoId" Height="100px" ></asp:ListBox></td>
                            </tr>
                            <tr id="trcurrentcontrol" runat="server">
                                <td></td>
                                <td><asp:Button ID="btndelete" runat="server" Text="Delete"  CssClass="btn btn-default"
                                        onclick="btndelete_Click" />
                                </td>
                            </tr>
                            <tr id="traddcurrent" runat="server">
                                <td>Add authorized users:</td>
                                <td>
                                    <asp:TextBox ID="txtusername" runat="server" CssClass="form-control" onkeyup="UserChecker(this.value)" ></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" Display="None" 
                                        ErrorMessage="Please, Enter authorized users!" ControlToValidate="txtusername" ForeColor="Red" 
                                        SetFocusOnError="True" ValidationGroup="add"></asp:RequiredFieldValidator>
                                    <asp:Label ID="lbcheckusername" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr id="traddcurrentcontrol" runat="server">
                                <td></td>
                                <td><asp:Button ID="btnadd" runat="server" Text="Add" onclick="btnadd_Click" CssClass="btn btn-default"
                                        ValidationGroup="add" />
                                <asp:ValidationSummary ID="ValidationSummary2" runat="server" ShowMessageBox="true" ShowSummary="false" ValidationGroup="add" /></td>
                            </tr>
                            <tr>
                                <td>Invite new member:</td>
                                <td><asp:TextBox ID="txtemail" runat="server" CssClass="form-control" onkeyup="Email_Checker(this.value)"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator92" runat="server" Display="None"
                                        ErrorMessage="Please, Enter new member!" ControlToValidate="txtemail" ForeColor="Red" 
                                        SetFocusOnError="True" ValidationGroup="invite"></asp:RequiredFieldValidator>
                                    <asp:Label ID="lbinvitenewmember" runat="server" ForeColor="Green"></asp:Label>            
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                        ControlToValidate="txtemail" ErrorMessage="The email is invalid"  Display="None"
                                        ForeColor="#CC0000" 
                                        ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                                        ValidationGroup="invite"></asp:RegularExpressionValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>Member type:</td>
                                <td>
                                    <asp:DropDownList ID="ddlmembertype" runat="server" DataValueField="RuleCode" CssClass="form-control"
                                        DataTextField="RuleName"></asp:DropDownList>
                                </td>
                            </tr>
                            <tr>
                                <td></td>
                                <td>
                                <asp:Button ID="btninvite" runat="server" Text="Invite"  CssClass="btn btn-default"
                                        onclick="btninvite_Click" ValidationGroup="invite"/>
                                <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true" ShowSummary="false" ValidationGroup="invite" />
                                </td>
                            </tr>
                        </table>                        
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

