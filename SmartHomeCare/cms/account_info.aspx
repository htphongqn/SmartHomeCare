<%@ Page Title="" Language="C#" MasterPageFile="~/cms/sitecms.master" AutoEventWireup="true" CodeFile="account_info.aspx.cs" Inherits="Admin_account_info" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <style type="text/css">
        .style2
        {
            width: 117px;
        }
        .style9
        {
            height: 25px;
            width: 128px;
        }
        .style10
        {
            width: 90px;
            height: 25px;
        }
        </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">

    <div class="floatleft">
<h1>Account</h1>
    <table>
        <tr>
            <td class="style9">User name</td>
            <td class="style10">
                <asp:TextBox ID="txtCode" runat="server" Enabled="False"></asp:TextBox>
            </td>
        </tr>
        </table>
    <h1>Information</h1>
    <table>
    <tr>
        <td>*First name:</td>
        <td><asp:TextBox ID="txtfirstname" runat="server" Width="220px" Enabled="False"  ></asp:TextBox></td>
    </tr>
    <tr>
        <td>*Last name:</td>
        <td><asp:TextBox ID="txtlastname" runat="server" Width="220px" Enabled="False"  ></asp:TextBox></td>
    </tr>
    <tr>
        <td>*Date of Birth</td>
        <td><asp:TextBox ID="txtdateofbirth" runat="server" Width="220px" Enabled="False"  ></asp:TextBox></td>
    </tr>
    <tr>
        <td>*Gender:</td>
        <td>
            <asp:RadioButton ID="rdmale" runat="server" Text="Male" GroupName="gender" Checked="True" />
            <asp:RadioButton ID="rdfemale" runat="server" Text="Female" GroupName="gender"/>
        </td>
    </tr>
    <tr>
        <td>*Your email address:</td>
        <td><asp:TextBox ID="txtemailaddress" runat="server" Width="220px" 
                Enabled="False"   ></asp:TextBox></td>
    </tr>
    <tr>
        <td>Street Address:</td>
        <td><asp:TextBox ID="txtstreetaddress" runat="server" Width="220px" 
                Enabled="False"  ></asp:TextBox></td>
    </tr>
    <tr>
        <td>City:</td>
        <td><asp:TextBox ID="txtcity" runat="server" Width="220px" Enabled="False"  ></asp:TextBox></td>
    </tr>
    <tr>
        <td>State:</td>
        <td><asp:TextBox ID="txtstate" runat="server" Width="220px" Enabled="False"  ></asp:TextBox></td>
    </tr>
    <tr>
        <td>ZIP Code:</td>
        <td><asp:TextBox ID="txtzipcode" runat="server" Width="220px" Enabled="False"  ></asp:TextBox></td>
    </tr>
    <tr>
        <td>County:</td>
        <td><asp:TextBox ID="txtcounty" runat="server" Width="220px" Enabled="False"  ></asp:TextBox></td>
    </tr>
    <tr>
        <td>Country:</td>
        <td><asp:TextBox ID="txtcountry" runat="server" Width="220px" Enabled="False"  ></asp:TextBox></td>
    </tr>
    <tr>
        <td>Home Phone:</td>
        <td><asp:TextBox ID="txthomephone" runat="server" Width="220px" Enabled="False"  ></asp:TextBox></td>
    </tr>
    <tr>
        <td>Mobile Phone:</td>
        <td><asp:TextBox ID="txtmobilephone" runat="server" Width="220px" Enabled="False"  ></asp:TextBox></td>
    </tr>

 </table>
 <h1>Contact</h1>
    <table>
        <tr>
            <td>Name:</td>
            <td><asp:TextBox ID="txtname" runat="server" Width="220px" Enabled="False"  ></asp:TextBox></td>
        </tr>
        <tr>
            <td>Email:</td>
            <td><asp:TextBox ID="txtemail" runat="server" Width="220px" Enabled="False"  ></asp:TextBox></td>
        </tr>
        <tr>
            <td class="style2">Phone:</td>
            <td class="style2"><asp:TextBox ID="txtphone" runat="server" Width="220px" 
                    Enabled="False"  ></asp:TextBox></td>
        </tr>
        <tr>
            <td>Address:</td>
            <td><asp:TextBox ID="txtaddress" runat="server" Width="220px" Enabled="False"  ></asp:TextBox></td>
        </tr>
        <tr>
            <td colspan="2"></td>
        </tr>
    </table>
 </div>
</asp:Content>

