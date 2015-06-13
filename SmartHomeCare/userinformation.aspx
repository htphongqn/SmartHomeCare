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
</style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="right1" Runat="Server">

    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                   User information
                </div>
             </div>
            <div class="floatright">
                <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                <a id="userhelp" href="#"><img src="resources/images/h.png" /></a>
            </div>
            <div class="clear"></div>
     </div><!-- border bottom -->
<div class="rightpaddingleft">
<br />

<div ID="print">
    <table id="tblinfo" runat="server" width="100%" align="left">
        <tr>
            <td width="180">Email</td>
            <td>
                <asp:Label ID="lbemail" runat="server"></asp:Label>
                <asp:TextBox ID="txtemail" runat="server" Width="220px" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                ErrorMessage="*" ControlToValidate="txtemail" ForeColor="Red" 
                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                ControlToValidate="txtemail" ErrorMessage="*" ForeColor="Red" 
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="tdcolor">First name</td>
            <td>
                <asp:Label ID="lbfirstname" runat="server" CssClass="tdcolor"></asp:Label>
                <asp:TextBox ID="txtfirstname" runat="server" Width="220px" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="tdcolor">Last name</td>
            <td>
                <asp:Label ID="lblastname" runat="server" CssClass="tdcolor"></asp:Label>
                <asp:TextBox ID="txtlastname" runat="server" Width="220px" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="tdcolor">Date of Birth</td>
            <td>
                <asp:Label ID="lbdateofbirth" runat="server" CssClass="tdcolor"></asp:Label>
                <asp:TextBox ID="txtdateofbirth" runat="server" Width="220px" ></asp:TextBox>
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
                <asp:TextBox ID="txtaddress" runat="server" Width="220px" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>City</td>
            <td>
                <asp:Label ID="lbcity" runat="server"></asp:Label>
                <asp:TextBox ID="txtcity" runat="server" Width="220px" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>Country</td>
            <td>
                <asp:Label ID="lbcountry" runat="server"></asp:Label>
                <asp:DropDownList ID="ddlcountry" runat="server" DataTextField="Name" 
                    DataValueField="Code" onselectedindexchanged="ddlcountry_SelectedIndexChanged" 
                    Width="230px" AutoPostBack="True" ></asp:DropDownList>
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
                    Width="230px" ></asp:DropDownList>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                    ControlToValidate="ddlstate" ErrorMessage="*" ForeColor="Red" InitialValue="0"></asp:RequiredFieldValidator>--%>
            </td>
        </tr>
        <tr>
            <td>Zip code</td>
            <td>
                <asp:Label ID="lbzipcode" runat="server"></asp:Label>
                <asp:TextBox ID="txtzipcode" runat="server" Width="220px" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>County</td>
            <td>
                <asp:Label ID="lbcounty" runat="server"></asp:Label>
                <asp:TextBox ID="txtcounty" runat="server" Width="220px" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>Home Phone</td>
            <td>
                <asp:Label ID="lbhomephone" runat="server"></asp:Label>
                <asp:TextBox ID="txthomephone" runat="server" Width="220px"></asp:TextBox>
                 <%--<asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
			    ErrorMessage="<br />Phone number must 10 numbers" ControlToValidate="txthomephone" ForeColor="Red"
			    ValidationExpression=".{10,10}" Display="Dynamic"></asp:RegularExpressionValidator>--%>
            </td>
        </tr>
        <tr>
            <td>Mobile Phone</td>
            <td>
                <asp:Label ID="lbmobilephone" runat="server"></asp:Label>
                <asp:TextBox ID="txtmobilephone" runat="server" Width="220px"></asp:TextBox>
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
                    Width="230px" ></asp:DropDownList>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                    ControlToValidate="ddlUserType" ErrorMessage="*" ForeColor="Red" 
                    InitialValue="0"></asp:RequiredFieldValidator>
            </td>
        </tr>
    </table>
</div>
<br />
    <table class="clear">    
        <tr>
            <td><asp:Button ID="btnedit" runat="server" Text="Edit" onclick="btnedit_Click" />
            <asp:Button ID="btnback" runat="server" Text="Back to Home" PostBackUrl="~/userhome.aspx"/>
            <asp:Button ID="btnsave" runat="server" Text="Save" onclick="btnsave_Click" />
            <asp:Button ID="btncancel" runat="server" Text="Cancel" onclick="btncancel_Click" CausesValidation="False" /></td>
        </tr>
    </table>
</div>
</asp:Content>

