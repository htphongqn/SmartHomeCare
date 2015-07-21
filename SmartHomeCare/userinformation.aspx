<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="userinformation.aspx.cs" Inherits="userinformation" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content2" ContentPlaceHolderID="head1" Runat="Server">
    <style type="text/css">
    .tdcolor
    {
        color:#999999;
    }
    .divpadding
    {
    }
    td, th {
      padding: 5px;
    }
</style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="right1" Runat="Server">
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
                    User information
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                            <div id="print">
                                <table id="tblinfo" runat="server" width="100%" align="left" cellspacing="10">
                                    <tr>
                                        <td width="180">Email</td>
                                        <td>
                                            <asp:Label ID="lbemail" runat="server"></asp:Label>
                                            <asp:TextBox ID="txtemail" runat="server" CssClass="form-control" ></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                                            ErrorMessage="Please, Enter Email!" ControlToValidate="txtemail" ForeColor="Red" 
                                            SetFocusOnError="True" ValidationGroup="g1" Display="None"></asp:RequiredFieldValidator>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                            ControlToValidate="txtemail" ErrorMessage="Invalid email" ForeColor="Red" ValidationGroup="g1" Display="None"
                                            ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdcolor">First name</td>
                                        <td>
                                            <asp:Label ID="lbfirstname" runat="server" CssClass="tdcolor"></asp:Label>
                                            <asp:TextBox ID="txtfirstname" runat="server" CssClass="form-control" ></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdcolor">Last name</td>
                                        <td>
                                            <asp:Label ID="lblastname" runat="server" CssClass="tdcolor"></asp:Label>
                                            <asp:TextBox ID="txtlastname" runat="server" CssClass="form-control" ></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdcolor">Date of Birth</td>
                                        <td>
                                            <asp:Label ID="lbdateofbirth" runat="server" CssClass="tdcolor"></asp:Label>
                                            <asp:TextBox ID="txtdateofbirth" runat="server" CssClass="form-control" ></asp:TextBox>
                                            <asp:CalendarExtender ID="txtdateofbirth_CalendarExtender" runat="server" Format="MM/dd/yyyy" CssClass="orange"
                                                Enabled="True" TargetControlID="txtdateofbirth">
                                            </asp:CalendarExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdcolor">Gender</td>
                                        <td>
                                            <asp:Label ID="lbgender" runat="server" CssClass="tdcolor"></asp:Label>
                                            <asp:RadioButton ID="rdmale" runat="server" Text="Male" GroupName="gender" />
                                            <asp:RadioButton ID="rdfemale" runat="server" Text="Female" GroupName="gender"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Address</td>
                                        <td>
                                            <asp:Label ID="lbaddress" runat="server"></asp:Label>
                                            <asp:TextBox ID="txtaddress" runat="server" CssClass="form-control" ></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>City</td>
                                        <td>
                                            <asp:Label ID="lbcity" runat="server"></asp:Label>
                                            <asp:TextBox ID="txtcity" runat="server" CssClass="form-control" ></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Country</td>
                                        <td>
                                            <asp:Label ID="lbcountry" runat="server"></asp:Label>
                                            <asp:DropDownList ID="ddlcountry" runat="server" DataTextField="Name" 
                                                DataValueField="Code" onselectedindexchanged="ddlcountry_SelectedIndexChanged" 
                                                CssClass="form-control" AutoPostBack="True" ></asp:DropDownList>
                                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                                                ControlToValidate="ddlcountry" ErrorMessage="*" ForeColor="Red" 
                                                InitialValue="0"></asp:RequiredFieldValidator>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>State</td>
                                        <td>
                                            <asp:Label ID="lbstate" runat="server"></asp:Label>
                                            <asp:DropDownList ID="ddlstate" runat="server" DataTextField="Name" 
                                                DataValueField="Code" onselectedindexchanged="ddlstate_SelectedIndexChanged" 
                                                CssClass="form-control" ></asp:DropDownList>
                                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                                ControlToValidate="ddlstate" ErrorMessage="*" ForeColor="Red" InitialValue="0"></asp:RequiredFieldValidator>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Zip code</td>
                                        <td>
                                            <asp:Label ID="lbzipcode" runat="server"></asp:Label>
                                            <asp:TextBox ID="txtzipcode" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>County</td>
                                        <td>
                                            <asp:Label ID="lbcounty" runat="server"></asp:Label>
                                            <asp:TextBox ID="txtcounty" runat="server" CssClass="form-control"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Home Phone</td>
                                        <td>
                                            <asp:Label ID="lbhomephone" runat="server"></asp:Label>
                                            <asp:TextBox ID="txthomephone" runat="server" CssClass="form-control"></asp:TextBox>
                                             <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
			                                ErrorMessage="<br />Phone number must 10 numbers" ControlToValidate="txthomephone" ForeColor="Red"
			                                ValidationExpression=".{10,10}" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Mobile Phone</td>
                                        <td>
                                            <asp:Label ID="lbmobilephone" runat="server"></asp:Label>
                                            <asp:TextBox ID="txtmobilephone" runat="server" CssClass="form-control"></asp:TextBox>
                                            <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
			                                ErrorMessage="<br />Phone number must 10 numbers" ControlToValidate="txtmobilephone" ForeColor="Red"
			                                ValidationExpression=".{10,10}" Display="Dynamic"></asp:RegularExpressionValidator>--%>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="tdcolor">User type</td>
                                        <td>
                                            <asp:Label ID="lblUserType" runat="server" class="tdcolor"></asp:Label>
                                            <asp:DropDownList ID="ddlUserType" runat="server" DataTextField="RuleName"  DataValueField="RuleCode" 
                                                CssClass="form-control" ></asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="g1" Display="None"
                                                ControlToValidate="ddlUserType" ErrorMessage="Please, Enter User type!" ForeColor="Red" 
                                                InitialValue="0"></asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <asp:Button ID="btnedit" runat="server" Text="Edit" CssClass="btn btn-default" onclick="btnedit_Click" />
                            <asp:Button ID="btnback" runat="server" Text="Back to Home" CssClass="btn btn-default" PostBackUrl="~/userhome.aspx"/>
                            <asp:Button ID="btnsave" runat="server" Text="Save" CssClass="btn btn-default" onclick="btnsave_Click" ValidationGroup="g1" />
                            <asp:Button ID="btncancel" runat="server" Text="Cancel" CssClass="btn btn-default" onclick="btncancel_Click" CausesValidation="False" />
                            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true" ShowSummary="false" ValidationGroup="g1" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

