<%@ Page Title="" Language="C#" MasterPageFile="~/siteadmin.master" AutoEventWireup="true" CodeFile="adminusermanagement_details.aspx.cs" Inherits="adminusermanagement_details" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head1" Runat="Server">
    <style type="text/css">
    .marginleft
    {
        margin-left:20px;
    }
    .padding
    {
        padding:5px;
    }
    .style1
    {
        width: 149px;
    }
        .style2
        {
            width: 500px;
        }
        .style3
        {
            width: 83px;
        }
        .style4
        {
            width: 75px;
        }
    </style>

    <script type="text/javascript" language="javascript">
        function enableTextBox() {

            if (document.getElementById("<%= chkAuto.ClientID %>").checked == true) {

                document.getElementById("<%= txtDate.ClientID %>").disabled = false;               
                document.getElementById("<%= txtAmount.ClientID %>").disabled = false;
                document.getElementById("<%= txtDescription.ClientID %>").disabled = false;
            }
            else {
                document.getElementById("<%= txtDate.ClientID %>").disabled = true;              
                document.getElementById("<%= txtAmount.ClientID %>").disabled = true;
                document.getElementById("<%= txtDescription.ClientID %>").disabled = true;
            }
        }
</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="right1" Runat="Server">
    <div class="title_new">
            <div class="floatleft">
                <div class="td">
                   User Management Details
                </div>
             </div>
            <div class="floatright">
                <asp:ImageButton ID="ImageButton2" runat="server" Height="25px" ImageUrl="~/resources/images/printer.png" Width="25px" OnClientClick="return processPrint('print');" CssClass="floatleft"/>&nbsp;&nbsp;
                <a id="adminhelp" href="#"><img src="resources/images/h.png" /></a>
            </div>
            <div class="clear"></div>
    </div><!-- border bottom -->
    <div id="print" class="borderbottom padding">
        <span class="bold">User overview:</span>
        <table class="marginleft">
            <tr>
                <td>Username</td>
                <td>
                    <asp:Label runat="server" ID="lbUserName"></asp:Label>
                    <asp:TextBox runat="server" ID="txtUserName" Width="220px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                        ControlToValidate="txtUserName" ErrorMessage="*" ForeColor="Red" 
                        ValidationGroup="overview"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>Registered</td>
                <td>
                    <asp:Label runat="server" ID="lbRegistered"></asp:Label>
                    <asp:TextBox runat="server" ID="txtRegistered" Width="220px"></asp:TextBox>
                    <asp:CalendarExtender ID="dateRegistered" runat="server" Format="MM/dd/yyyy" CssClass="orange"
                    Enabled="True" TargetControlID="txtRegistered">
                    
                </asp:CalendarExtender>
                </td>
            </tr>
            <tr>
                <td>Registered from IP</td>
                <td>
                    <asp:Label runat="server" ID="lbIP"></asp:Label>
                    <asp:TextBox  runat="server" ID="txtIP" Width="220px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Last active</td>
                <td>
                        <asp:Label runat="server" ID="lbLastActive"></asp:Label>
                         <asp:TextBox  runat="server" ID="txtLastActive" Width="220px"></asp:TextBox>
                        
                </td>
            </tr>
            <tr>
                <td>Warnings</td>
                <td>
                     <asp:Label runat="server" ID="lbWarning"></asp:Label>
                    <asp:TextBox  runat="server" ID="txtWarning" Width="220px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ValidationGroup="overview"
                        ControlToValidate="txtWarning" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>Email</td>
                <td>
                    <asp:Label runat="server" ID="lbEmail"></asp:Label>
                    <asp:TextBox  runat="server" ID="txtEmail" Width="220px"></asp:TextBox>
                     <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                ErrorMessage="*" ControlToValidate="txtEmail" ForeColor="Red" ValidationGroup="overview"
                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationGroup="overview"
                ControlToValidate="txtEmail" ErrorMessage="*" ForeColor="Red" 
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td>Confirm email</td>
                <td>
                    <asp:Label runat="server" ID="lbConfirmEmail"></asp:Label>
                    <asp:TextBox  runat="server" ID="txtConfirmEmail" Width="220px"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                ErrorMessage="*" ControlToValidate="txtConfirmEmail" ForeColor="Red" ValidationGroup="overview"
                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator2" runat="server" ValidationGroup="overview"
                        ControlToCompare="txtEmail" ControlToValidate="txtConfirmEmail" 
                        ErrorMessage="*" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td>New password</td>
                <td>
                    <asp:Label runat="server" ID="lbNewPassword"></asp:Label>
                    <asp:TextBox runat="server" ID="txtNewPassword" Width="220px" 
                        TextMode="Password"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>Confirm new password</td>
                <td>
                    <asp:Label runat="server" ID="lbConfirmPass"></asp:Label>
                    <asp:TextBox ID="txtConfirmPass" runat="server" Width="220px" 
                        TextMode="Password" ></asp:TextBox>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="overview"
                        ControlToCompare="txtNewPassword" ControlToValidate="txtConfirmPass" 
                        ErrorMessage="*" ForeColor="Red"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                <div class="textcenter">
                    <asp:Button ID="btnedit" runat ="server" Text="Edit" onclick="btneditoverview_Click" CausesValidation="False" />
                    <asp:Button ID="btncanceloverview" runat ="server" Text="Cancel" onclick="btncanceloverview_Click" CausesValidation="False" />
                    <asp:Button ID="Button5" runat="server" Text="Save" onclick="btnsaveoverview_Click" ValidationGroup="overview"/>
                    
                </div>
                </td>
            </tr>
        </table>
        <hr class="clear"/>
        <span class="bold clear left">User profile:</span>
        <table id="tblinfo" class="marginleft clear" runat="server" align="left">
        <tr>
            <td class="style1">Email</td>
            <td>
                <asp:Label ID="lbemailinfo" runat="server"></asp:Label>
                <asp:TextBox ID="txtemailinfo" runat="server" Width="220px" ></asp:TextBox>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                ErrorMessage="*" ControlToValidate="txtemailinfo" ForeColor="Red" 
                SetFocusOnError="True" Display="Dynamic" ValidationGroup="profile"></asp:RequiredFieldValidator>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationGroup="profile"
                ControlToValidate="txtemailinfo" ErrorMessage="*" ForeColor="Red" 
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
            </td>
        </tr>
        <tr>
            <td class="style1">First name</td>
            <td>
                <asp:Label ID="lbfirstname" runat="server"></asp:Label>
                <asp:TextBox ID="txtfirstname" runat="server" Width="220px" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">Last name</td>
            <td>
                <asp:Label ID="lblastname" runat="server"></asp:Label>
                <asp:TextBox ID="txtlastname" runat="server" Width="220px" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">Date of Birth</td>
            <td>
                <asp:Label ID="lbdateofbirth" runat="server"></asp:Label>
                <asp:TextBox ID="txtdateofbirth" runat="server" Width="220px" ></asp:TextBox>
                <asp:CalendarExtender ID="txtdateofbirth_CalendarExtender" runat="server" Format="MM/dd/yyyy" CssClass="orange"
                    Enabled="True" TargetControlID="txtdateofbirth">
                </asp:CalendarExtender>
                <%--<asp:CalendarExtender ID="txtdateofbirth_CalendarExtender" runat="server" Format="MM/dd/yyyy" CssClass="orange"
                    Enabled="True" TargetControlID="txtdateofbirth">
                </asp:CalendarExtender>--%>
            </td>
        </tr>
        <tr>
            <td class="style1">Gender</td>
            <td>
                <asp:Label ID="lbgender" runat="server"></asp:Label>
                <asp:RadioButton ID="rdmale" runat="server" Text="Male" GroupName="gender" />
                <asp:RadioButton ID="rdfemale" runat="server" Text="Female" GroupName="gender"/>
            </td>
        </tr>
        <tr>
            <td class="style1">Address</td>
            <td>
                <asp:Label ID="lbaddress" runat="server"></asp:Label>
                <asp:TextBox ID="txtaddress" runat="server" Width="220px" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">City</td>
            <td>
                <asp:Label ID="lbcity" runat="server"></asp:Label>
                <asp:TextBox ID="txtcity" runat="server" Width="220px" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">Country</td>
            <td>
                <asp:Label ID="lbcountry" runat="server"></asp:Label>
                <asp:DropDownList ID="ddlcountry" runat="server" DataTextField="Name" 
                    DataValueField="Code" onselectedindexchanged="ddlcountry_SelectedIndexChanged" 
                    Width="230px" AutoPostBack="True" ></asp:DropDownList>
                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="profile"
                    ControlToValidate="ddlcountry" ErrorMessage="*" ForeColor="Red" 
                    InitialValue="0"></asp:RequiredFieldValidator>--%>
            </td>
        </tr>
        <tr>
            <td class="style1">State</td>
            <td>
                <asp:Label ID="lbstate" runat="server"></asp:Label>
                <asp:DropDownList ID="ddlstate" runat="server" DataTextField="Name" 
                    DataValueField="Code" 
                    Width="230px" ></asp:DropDownList>
               <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="profile"
                    ControlToValidate="ddlstate" ErrorMessage="*" ForeColor="Red" InitialValue="0"></asp:RequiredFieldValidator>--%>
            </td>
        </tr>
        <tr>
            <td class="style1">Zip code</td>
            <td>
                <asp:Label ID="lbzipcode" runat="server"></asp:Label>
                <asp:TextBox ID="txtzipcode" runat="server" Width="220px" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">County</td>
            <td>
                <asp:Label ID="lbcounty" runat="server"></asp:Label>
                <asp:TextBox ID="txtcounty" runat="server" Width="220px" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">Home Phone</td>
            <td>
                <asp:Label ID="lbhomephone" runat="server"></asp:Label>
                <asp:TextBox ID="txthomephone" runat="server" Width="220px" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="style1">Mobile Phone</td>
            <td>
                <asp:Label ID="lbmobilephone" runat="server"></asp:Label>
                <asp:TextBox ID="txtmobilephone" runat="server" Width="220px" ></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>MemeberType</td>
            <td>
                <asp:Label ID="lbmembertype" runat="server"></asp:Label>
                <asp:DropDownList ID="ddlmembertype" runat="server" DataValueField="RuleCode" 
                DataTextField="RuleName" Width="230px"></asp:DropDownList></td>
        </tr>
        <tr>
            <td colspan="2">
                 <div class="textcenter">
                     <asp:HiddenField ID="HiddenRegistercode" runat="server" />
                    <asp:Button ID="Button1" runat ="server" Text="Edit" onclick="btneditprofile_Click" CausesValidation="False" />
                    <asp:Button ID="Button2" runat ="server" Text="Cancel" onclick="btncancelprofile_Click" CausesValidation="False" />
                    <asp:Button ID="Button3" runat ="server" Text="Save" onclick="btnsaveprofile_Click" ValidationGroup="profile" />
                    
                </div>
            </td>
        </tr>
    </table>
        <hr class="clear" />        
        <span class="bold">User preferentces:</span>
        <div class="marginleft">
            <div class="clear">
                <br />
                Measurement system: <asp:RadioButton ID="rdmetric" runat="server" Text="Metric" GroupName="g" />
                                    <asp:RadioButton ID="rdus" runat="server" Text="US" GroupName="g" Checked="True"/>
                <br />
                <asp:Button ID="Button4" runat ="server" Text="Save" onclick="btnsavepreferentces_Click" />
        </div>
        <hr class="clear" /> 
        <span class="bold">Groups:</span>
        <div class="marginleft">No group</div>
        <hr class="clear" /> 
        <span class="bold">Permissions:</span>
        <table class="marginleft">
            <tr>
                <td valign="top">Granted users:</td>
                <td><asp:ListBox ID="lstuser" runat="server" Width="190px" 
                        DataTextField="AuthorizedUser" ></asp:ListBox></td>
            </tr>
        </table>
        <hr class="clear" /> 
        <span class="bold">Billing management:</span>
        <table style="width:100%;">
            <tr>
                <td class="style3">
                    <asp:CheckBox ID="chkAuto" runat="server" OnChange="javascript:enableTextBox();"/>
                      
                </td>
                <td class="style4">
                    Auto bill:</td>
                <td>
                    Billing Type</td>
                <td>
                    Date</td>
                <td>
                    Amount</td>
                <td>
                    Description</td>
            </tr>
            <tr>
                <td class="style3">
                    &nbsp;</td>
                <td class="style4">
                    &nbsp;</td>
                <td>
                    <%--<asp:TextBox ID="txtBillingType" runat="server" Name="textBox" Enabled="False"></asp:TextBox>--%>
                    <asp:DropDownList ID="ddlType" runat="server" DataTextField="Name" 
                        DataValueField="AutoId">
                    </asp:DropDownList>
                </td>
                <td>
                    <asp:TextBox ID="txtDate" runat="server" Name="textBox" Enabled="False"></asp:TextBox>
                    <asp:CalendarExtender ID="Calendardate" runat="server" TargetControlID="txtDate" Format="MM/dd/yyyy" CssClass="orange">
                    </asp:CalendarExtender>
                </td>
                <td>
                    <asp:TextBox ID="txtAmount" runat="server" Name="textBox" Enabled="False"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox ID="txtDescription" runat="server" Name="textBox" Enabled="False"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style3">
                    &nbsp;</td>
                <td class="style4">
                    Manual:</td>
                <td>
                    &nbsp;</td>
                <td>
                    Date</td>
                <td>
                    Amount</td>
                <td>
                    Description</td>
            </tr>
            <tr>
                <td class="style3">
                    &nbsp;</td>
                <td class="style4">
                    &nbsp;</td>
                <td>
                    <asp:Button ID="btnAdd" runat="server" Height="21px" Text="Add" Width="68px" 
                        CausesValidation="False" onclick="btnaddbill_Click" />
                </td>
                <td>
                    <asp:TextBox ID="txtDateManual" runat="server"></asp:TextBox>
                     <asp:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtDateManual"  CssClass="orange">
                    </asp:CalendarExtender>
                </td>
                <td>
                    <asp:TextBox ID="txtAmountManual" runat="server"></asp:TextBox>
                </td>
                <td>
                    <asp:TextBox ID="txtDescriptionManual" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
            <td colspan="6">
                 <div class="textcenter">
                    <asp:Button ID="Button8" runat ="server" Text="Save" onclick="btnsavebill_Click" ValidationGroup="bill" />
                    
                </div>
            </td>
        </tr>
        </table>
        <br />
        
    </div>
    </div>
    
</asp:Content>

