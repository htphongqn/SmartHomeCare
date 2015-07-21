<%@ Page Title="" Language="C#" MasterPageFile="~/siteuser.master" AutoEventWireup="true" CodeFile="userchangepassword.aspx.cs" Inherits="userchangepassword" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
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
                    Change password
                </div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-lg-6">
                        <table width="100%" align="left" cellspacing="10">
                            <tr>
                                <td colspan="2"><asp:Label ID="lbmessage" runat="server" ForeColor="Red"></asp:Label></td>
                            </tr>
                            <tr>
                                <td width="220">Current password</td>
                                <td><asp:TextBox ID="txtcurrentpassword" runat="server" 
                                        TextMode="Password" CssClass="form-control" ></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server"  ValidationGroup="g1" Display="None"
                                        ErrorMessage="Please, Enter Current password!" ControlToValidate="txtcurrentpassword" ForeColor="Red" 
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                </td>
                            </tr>
                            <tr>
                                <td>New password</td>
                                <td><asp:TextBox ID="txtnewpassword" runat="server"
                                        TextMode="Password" CssClass="form-control" ></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server"  ValidationGroup="g1" Display="None"
                                        ErrorMessage="Please, Enter New password!" ControlToValidate="txtnewpassword" ForeColor="Red" 
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                
                                        <%--<asp:Image ID="Image1" runat="server" 
                                        ImageUrl="~/resources/images/help.png" ImageAlign="Bottom" Height="15px" 
                                        Width="15px" /> 
                                    <asp:BalloonPopupExtender ID="txtpassword_BalloonPopupExtender" runat="server" 
                                        TargetControlID="Image1" BalloonPopupControlID="pnpasswordrule" 
                                        BalloonSize="Medium" >
                                    </asp:BalloonPopupExtender>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
			                            ErrorMessage="<br/>Password not meet requirement" ControlToValidate="txtnewpassword" ForeColor="Red"
			                            ValidationExpression=".{4,14}" Display="Dynamic"></asp:RegularExpressionValidator>
                                    <asp:Panel ID="pnpasswordrule" runat="server" CssClass="passrule">
                                        <p>
                                            Password must be 4 to 14 characters.
                                            Not content username, first name, last name and date of birth.
                                        </p>
                                    </asp:Panel>--%>
                                </td>
                            </tr>
                            <tr>
                                <td>Confirm new password</td>
                                <td><asp:TextBox ID="txtconfirmnewpassword" runat="server"
                                        TextMode="Password" CssClass="form-control" ></asp:TextBox>            
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                        ErrorMessage="Please, Enter Confirm new password!" ControlToValidate="txtconfirmnewpassword" ForeColor="Red" 
                                        SetFocusOnError="True"  ValidationGroup="g1" Display="None"></asp:RequiredFieldValidator>
                                    <asp:CompareValidator ID="CompareValidator2" runat="server"  ValidationGroup="g1" Display="None"
                                        ControlToCompare="txtnewpassword" ControlToValidate="txtconfirmnewpassword" 
                                        ErrorMessage="Password mismatched" ForeColor="Red"></asp:CompareValidator>                
                                </td>
                            </tr>
                            <tr>
                                <td>Password hint</td>
                                <td><asp:TextBox ID="txtpasswordhit" runat="server"  CssClass="form-control" ></asp:TextBox>            
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ValidationGroup="g1" Display="None"
                                        ErrorMessage="Please, Enter Password hint!" Text="" ControlToValidate="txtpasswordhit" ForeColor="Red" 
                                        SetFocusOnError="True"></asp:RequiredFieldValidator>
                                    <%--<asp:BalloonPopupExtender ID="txtpasswordhit_BalloonPopupExtender" 
                                        runat="server" CustomCssUrl="" DynamicServicePath="" Enabled="True" 
                                      TargetControlID="Image3" BalloonPopupControlID="pnpasswordrule" 
                                        BalloonSize="Medium" >
                                    </asp:BalloonPopupExtender>
                                     <asp:Image ID="Image3" runat="server" 
                                        ImageUrl="~/resources/images/help.png" ImageAlign="Bottom" Height="15px"
                                        Width="15px" />
                                        <asp:CompareValidator ID="CompareValidator3" runat="server" 
                                            ControlToCompare="txtnewpassword" ControlToValidate="txtpasswordhit" 
                                            ErrorMessage="<br />Password hint must be different from password" ForeColor="Red" 
                                            Operator="NotEqual" Display="Dynamic">
                                        </asp:CompareValidator>
                                        <asp:Panel ID="panepasshind" runat="server" CssClass="passrule">
                                            <p>
                                                Use a password hint to remind your password.
                                                Password hint should not content your password, username, first name, last name, date of birth. 
                                            </p>
                                        </asp:Panel>--%>
                                </td>
                            </tr>
                        </table>
                        <asp:Button ID="btnsave" runat="server" Text="Save" CssClass="btn btn-default" ValidationGroup="g1"
                                        onclick="btnsave_Click" />
                        <asp:Button ID="btncancel" runat="server" Text="Cancel" CssClass="btn btn-default" 
                                        CausesValidation="False" PostBackUrl="~/userhome.aspx" />

                        <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="true" ShowSummary="false" ValidationGroup="g1" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

