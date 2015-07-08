<%@     Page Title="" Language="C#" MasterPageFile="~/sitehome.master" AutoEventWireup="true" CodeFile="home.aspx.cs" Inherits="home" %>

<asp:Content ID="Content3" ContentPlaceHolderID="head1" Runat="Server">
    <style type="text/css">

    </style>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="center1" Runat="Server">
        <%--<asp:Label ID="lbcontent" runat="server"></asp:Label>--%>
    <div class="container1">
    <div class="rowmn rSign">
      <div class="col4">
        <div class="frm frmSign">
          <h3>Already have an account? Sign in.</h3>
          <form novalidate action="/Account/Login" id="frmLogin" method="post" name="frmLogin">
            <label for="UserName">Username</label>
            <asp:TextBox ID="txtusername" runat="server" class="form-control"  placeholder="Enter User Name" TabIndex="1"></asp:TextBox>
            <span class="field-validation-valid text-danger">
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ErrorMessage="Please enter a username." ControlToValidate="txtusername" ForeColor="Red" 
                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
            </span> <br>
            <label for="Password">Password</label>
            <asp:TextBox ID="txtpassword" runat="server" TextMode="Password" class="form-control" placeholder="Enter Password"
                TabIndex="2"></asp:TextBox>
            <span class="field-validation-valid text-danger"> 
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ErrorMessage="Please enter a password." ControlToValidate="txtpassword" ForeColor="Red" 
                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
            </span>
            <label class="checkbox">
              <input data-val="true" type="checkbox">
              Remember username </label>
            <asp:Button ID="btnsignin" runat="server" Text="Sign in" class="btn btn-primary btn-block"
                onclick="btnsignin_Click" Width="80px" TabIndex="3" />
                <span class="field-validation-valid text-danger"> 
                    <asp:Label ID="lbMessage" runat="server" Text=""></asp:Label></span>
          </form>
          <hr>
          <p> Forgot your <a href="forgotusername.aspx" data-toggle="modal" data-target="#modalUsername">username</a> or <a href="forgotpassword.aspx" data-toggle="modal" data-target="#modalPassword">password</a>? </p>
          <p>For questions or help with your online<br />
            account, <a href="/Help">use the help form</a>.</p>
        </div>
      </div>
      <!---modal---> 
      
      <!---modal--->
      
      <div class="col8">
        <h3>Don't have an account yet?</h3>
        <p>Create a free, online patient account for safe and simple access to information from your electronic health record.</p>
        <ul>
          <li>Lab Results</li>
          <li>Discharge Instructions</li>
          <li>Immunizations</li>
          <li>Medications</li>
          <li>Allergies</li>
          <li>Patient Education</li>
          <li>Continuity of Care Document<br>
            (An electronic medical care summary that can be shared with your physician)</li>
        </ul>
        <p> <a class="btn btn-success" href="register.aspx">Create your account now</a> <a class="btn btn-default" href="/">Learn more</a> </p>
        <div class="well well-lg block-pay-bill invisible">
          <h3>Just want to pay your bill?</h3>
          <p>You don't have to sign in to <a>pay your bill online</a>.</p>
        </div>
      </div>
    </div>
  </div>
</asp:Content>
<%--<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <table cellpadding="0" cellspacing="0" align="center" class="tblright">
    <tr>
        <td>Username</td>
    </tr>
    <tr>
        <td><asp:TextBox ID="txtusername" runat="server" Width="220px" TabIndex="1"></asp:TextBox></td>
    </tr>
    <tr>
        <td>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ErrorMessage="Please enter a username." ControlToValidate="txtusername" ForeColor="Red" 
                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator></td>
    </tr>
    <tr>
        <td align="right"><a href="forgotusername.aspx" class="forgot">Forgot username?</a></td>
    </tr>
    <tr>
        <td>Password</td>
    </tr>
    <tr>
        <td><asp:TextBox ID="txtpassword" runat="server" Width="220px" TextMode="Password" 
                TabIndex="2"></asp:TextBox></td>
    </tr>
    <tr>
        <td>            
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ErrorMessage="Please enter a password." ControlToValidate="txtpassword" ForeColor="Red" 
                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td align="right"><a href="forgotpassword.aspx" class="forgot">Forgot password?</a></td>
    </tr>
    <tr>
        <td height="5px"></td>
    </tr>
    <tr>
        <td align="center">
            <asp:Button ID="btnsignin" runat="server" Text="Sign in" 
                onclick="btnsignin_Click" Width="80px" TabIndex="3" /></td>
    </tr>
    <tr>
        <td>
            <asp:Label ID="lbmessage" runat="server" ForeColor="Red" Font-Size="9pt"></asp:Label></td>
    </tr>
    <tr>
        <td height="10"></td>
    </tr>
    <tr>
        <td style="border-bottom:2px solid #d4d4d4;border-top:1px solid #d4d4d4">
            <table width="100%">
                <tr>
                    <td class="silver">New User?</td>
                    <td align="right"><asp:LinkButton ID="lnkregister" runat="server" Text="Register" 
                            CausesValidation="False" onclick="lnkregister_Click"></asp:LinkButton> </td>
                </tr>
            </table>
        </td>
    </tr>
    <tr>
        <td style="height: 20px"></td>
    </tr>
    <tr>
        <td class="silver">Learn more...</td>
    </tr>
    <tr>
        <td align="right">
            <asp:LinkButton ID="lnkfqas" runat="server" Text="FAQs" CausesValidation="False" onclick="lnkfqas_Click"></asp:LinkButton>
        </td>
    </tr>
    <tr>
        <td align="right">
            <asp:LinkButton ID="lnkprivacypolicy" runat="server" Text="Privacy Policy" 
                            CausesValidation="False" onclick="lnkprivacypolicy_Click"></asp:LinkButton>
        </td>
    </tr>
    <tr>
        <td align="right">
            <asp:LinkButton ID="lnktermsandconditions" runat="server" Text="Terms and Conditions" 
                            CausesValidation="False" onclick="lnktermsandconditions_Click"></asp:LinkButton>
        </td>
    </tr>
</table>
</asp:Content>--%>

