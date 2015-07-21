<%@ Page Title="" Language="C#" MasterPageFile="~/site.master" AutoEventWireup="true" CodeFile="register.aspx.cs" Inherits="register" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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
                if (result == true) {
                    lbl.innerHTML = '<%= DBClass.GetMessageByCode2("username_exist") %>';
                    lbl.style.color = "red";
                }
                else {
                    lbl.innerHTML = '<%= DBClass.GetMessageByCode2("user_available") %>';
                    lbl.style.color = "green";
                }
            }
        }

    </script>

    <style type="text/css">
        .style2
        {
            height: 26px;
        }
        .tblregister
        {
            width:500px;
            border:1px solid #ccc;
            margin-top:10px;
            padding: 10px;
        }
    </style>
    <link href="styles/tooltip.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="menu" Runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="main" Runat="Server">

    <table align="center" class="tblregister">
    <tr>
        <td class='title' width="200">Registration</td>
        <td>*Required</td>
    </tr>
    <tr>
        <td></td>
        <td height="20px"><asp:Label ID="lbcheckusername" runat="server"></asp:Label></td>
    </tr>
    <tr>
        <td>*Create Homecare username:</td>
        <td>
            <asp:TextBox ID="txtusername" runat="server" Width="220px"  
                onkeyup="UserChecker(this.value)" EnableViewState="False" 
                ViewStateMode="Disabled" ToolTip="Username must be 6 to 50 characters"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" 
                ErrorMessage="*" ControlToValidate="txtusername" ForeColor="Red" 
                SetFocusOnError="True"></asp:RequiredFieldValidator>
                 <asp:Image ID="Image2" runat="server" 
                ImageUrl="~/resources/images/help.png" ImageAlign="Bottom" Height="15px" CssClass="floatright"
                Width="15px" />
                <asp:BalloonPopupExtender ID="Image2_BalloonPopupExtender" runat="server"  
                BalloonPopupControlID="paneluser" TargetControlID="Image2" BalloonSize="Medium" 
                ScrollBars="None">
                </asp:BalloonPopupExtender>
                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" 
			    ErrorMessage="<br />Username must be 6 to 50 characters " ControlToValidate="txtusername" ForeColor="Red"
			    ValidationExpression=".{6,50}" Display="Dynamic"></asp:RegularExpressionValidator>
                <asp:Panel ID="paneluser" runat="server" CssClass="passrule">
                    <p>
                        Username contents only letters and numbers,
                        Must be 6 to 50 characters
                    </p>
                </asp:Panel>
        </td>
    </tr>
    <tr>
        <td>*Create Homecare password:</td>
        <td><asp:TextBox ID="txtpassword" runat="server" Width="220px" TextMode="Password" 
                EnableViewState="False" ViewStateMode="Disabled" ToolTip="Password must be 4 to 14 characters"></asp:TextBox> 
                       
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                ErrorMessage="*" ControlToValidate="txtpassword" ForeColor="Red" 
                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
                <asp:Image ID="Image1" runat="server" 
                ImageUrl="~/resources/images/help.png" ImageAlign="Bottom" Height="15px" CssClass="floatright" 
                Width="15px" />
            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
			    ErrorMessage="<br />Password not meet requirement" ControlToValidate="txtPassword" ForeColor="Red"
			    ValidationExpression=".{4,14}" Display="Dynamic"></asp:RegularExpressionValidator>
                
            <asp:BalloonPopupExtender ID="txtpassword_BalloonPopupExtender" runat="server" 
                TargetControlID="Image1" BalloonPopupControlID="pnpasswordrule" BalloonSize="Medium" 
                ScrollBars="None">
            </asp:BalloonPopupExtender>
            <asp:Panel ID="pnpasswordrule" runat="server" CssClass="passrule">
                <p>
                    Password must be 4 to 14 characters.
                    Not content username, first name, last name and date of birth.
                </p>
            </asp:Panel>
        </td>
    </tr>
    <tr>
        <td>*Confirm password:</td>
        <td><asp:TextBox ID="txtpasswordconfirm" runat="server" Width="220px" 
                TextMode="Password" EnableViewState="False" ViewStateMode="Disabled" ></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                ErrorMessage="*" ControlToValidate="txtpasswordconfirm" ForeColor="Red" 
                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator2" runat="server" 
                ControlToCompare="txtpassword" ControlToValidate="txtpasswordconfirm" 
                ErrorMessage="<br />Password mismatched" ForeColor="Red" Display="Dynamic"></asp:CompareValidator>
        </td>
    </tr>
    <tr>
        <td>*Password Hint:</td>
        <td><asp:TextBox ID="txtpasswordhint" runat="server" Width="220px" 
                ToolTip="password hint"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                ErrorMessage="*" ControlToValidate="txtpasswordhint" ForeColor="Red" 
                SetFocusOnError="True"></asp:RequiredFieldValidator>
            &nbsp;
            <asp:Image ID="Image3" runat="server" 
                ImageUrl="~/resources/images/help.png" ImageAlign="Bottom" Height="15px" CssClass="floatright"
                Width="15px" />
                <asp:CompareValidator ID="CompareValidator3" runat="server" 
                    ControlToCompare="txtpassword" ControlToValidate="txtpasswordhint" 
                    ErrorMessage="<br />Password hint must be different from password" ForeColor="Red" 
                    Operator="NotEqual" Display="Dynamic"></asp:CompareValidator>
                <asp:BalloonPopupExtender ID="Image3_BalloonPopupExtender" runat="server" 
                TargetControlID="Image3" BalloonPopupControlID="panepasshind" BalloonSize="Medium" 
                ScrollBars="None">
                </asp:BalloonPopupExtender>
                <asp:Panel ID="panepasshind" runat="server" CssClass="passrule">
                    <p>
                        Use a password hint to remind your password.
                        Password hint should not content your password, username, first name, last name, date of birth. 
                    </p>
                </asp:Panel>
        </td>
    </tr>
    <tr>
        <td>*First name:</td>
        <td><asp:TextBox ID="txtfirstname" runat="server" Width="220px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                ErrorMessage="*" ControlToValidate="txtfirstname" ForeColor="Red" 
                SetFocusOnError="True"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td>*Last name:</td>
        <td><asp:TextBox ID="txtlastname" runat="server" Width="220px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                ErrorMessage="*" ControlToValidate="txtlastname" ForeColor="Red" 
                SetFocusOnError="True"></asp:RequiredFieldValidator>
        </td>
    </tr>
    <tr>
        <td>*Date of Birth</td>
        <td>
            <asp:TextBox ID="txtmm" runat="server" Width="50px" MaxLength="2" onkeypress="return ValidateKeypress(/\d/,event);"></asp:TextBox>
            <asp:TextBoxWatermarkExtender ID="txtmm_TextBoxWatermarkExtender" 
                runat="server" Enabled="True" TargetControlID="txtmm" WatermarkText="mm" WatermarkCssClass="watermarked">
            </asp:TextBoxWatermarkExtender>
            /
            <asp:TextBox ID="txtdd" runat="server" Width="50px" MaxLength="2" onkeypress="return ValidateKeypress(/\d/,event);"></asp:TextBox>
            <asp:TextBoxWatermarkExtender ID="txtdd_TextBoxWatermarkExtender" 
                runat="server" Enabled="True" TargetControlID="txtdd" WatermarkText="dd" WatermarkCssClass="watermarked">
            </asp:TextBoxWatermarkExtender>
            /
            <asp:TextBox ID="txtyyyy" runat="server" Width="87px" MaxLength="4" onkeypress="return ValidateKeypress(/\d/,event);"></asp:TextBox>
            <asp:TextBoxWatermarkExtender ID="txtyyyy_TextBoxWatermarkExtender" 
                runat="server" Enabled="True" TargetControlID="txtyyyy" WatermarkText="yyyy" WatermarkCssClass="watermarked">
            </asp:TextBoxWatermarkExtender>
            <asp:Label id="lberrordate" runat="server" Text="" ForeColor="Red"></asp:Label>
            <%--<span class="silver">(mm/dd/yyyy)</span>  --%>
            <%--<asp:TextBox ID="txtdateofbirth" runat="server" Width="220px"></asp:TextBox>
            <asp:CalendarExtender ID="txtdateofbirth_CalendarExtender" runat="server" CssClass="orange"
                Enabled="True" TargetControlID="txtdateofbirth" Format="MM/dd/yyyy">
            </asp:CalendarExtender>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                ErrorMessage="*" ControlToValidate="txtdateofbirth" ForeColor="Red" 
                SetFocusOnError="True"></asp:RequiredFieldValidator>--%>
        </td>
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
        <td><asp:TextBox ID="txtemailaddress" runat="server" Width="220px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" 
                ErrorMessage="*" ControlToValidate="txtemailaddress" ForeColor="Red" 
                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:Label id="lberroremailaddress" runat="server" Text="" ForeColor="Red"></asp:Label>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                ControlToValidate="txtemailaddress" 
                ErrorMessage="<br />Invalid email address" ForeColor="Red" 
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                Display="Dynamic"></asp:RegularExpressionValidator>
                
        </td>
    </tr>
    <tr>
        <td>*Confirm email address:</td>
        <td><asp:TextBox ID="txtemailaddressconfirm" runat="server" Width="220px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" 
                ErrorMessage="*" ControlToValidate="txtemailaddressconfirm" ForeColor="Red" 
                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" 
                ControlToCompare="txtemailaddress" ControlToValidate="txtemailaddressconfirm" 
                ErrorMessage="<br />Email address mismatched" ForeColor="Red" 
                Display="Dynamic"></asp:CompareValidator>
        </td>
    </tr>
    <tr>
        <td>*Registration code:</td>
        <td>
            <asp:TextBox ID="txtregistrationcode" runat="server" Width="220px"></asp:TextBox>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                ErrorMessage="*" ControlToValidate="txtregistrationcode" ForeColor="Red" 
                SetFocusOnError="True" Display="Dynamic"></asp:RequiredFieldValidator>
            <asp:Label id="lberrorregistrationcode" runat="server" Text="" ForeColor="Red"></asp:Label>
        </td>
    </tr>
    <tr>
        <td colspan="2"  style="border-bottom:1px solid #d4d4d4"></td>
    </tr>
    <tr>
        <td>Street Address:</td>
        <td><asp:TextBox ID="txtstreetaddress" runat="server" Width="220px"></asp:TextBox></td>
    </tr>
    <tr>
        <td>City:</td>
        <td><asp:TextBox ID="txtcity" runat="server" Width="220px"></asp:TextBox></td>
    </tr>
    <tr>
        <td>Country:</td>
        <td><asp:DropDownList ID="ddlcountry" runat="server" DataTextField="Name" 
                    DataValueField="Code" onselectedindexchanged="ddlcountry_SelectedIndexChanged" 
                    Width="230px" AutoPostBack="True" ></asp:DropDownList></td>
    </tr>
    <tr>
        <td>State:</td>
        <td>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
                    <asp:DropDownList ID="ddlstate" runat="server" DataTextField="Name" 
                            DataValueField="Code"
                            Width="230px" ></asp:DropDownList>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="ddlcountry" EventName="SelectedIndexChanged" />
                </Triggers>
            </asp:UpdatePanel>            
        </td>
    </tr>
    <tr>
        <td>ZIP Code:</td>
        <td><asp:TextBox ID="txtzipcode" runat="server" Width="220px"></asp:TextBox></td>
    </tr>
    <tr>
        <td>County:</td>
        <td><asp:TextBox ID="txtcounty" runat="server" Width="220px"></asp:TextBox></td>
    </tr>
    <tr>
        <td>Home Phone:</td>
        <td><asp:TextBox ID="txthomephone" runat="server" Width="220px" onkeypress="return ValidateKeypress(/\d/,event);"></asp:TextBox></td>
    </tr>
    <tr>
        <td>Mobile Phone:</td>
        <td><asp:TextBox ID="txtmobilephone" runat="server" Width="220px" onkeypress="return ValidateKeypress(/\d/,event);"></asp:TextBox></td>
    </tr>
    <tr>
        <td colspan="2"  style="border-bottom:1px solid #d4d4d4"></td>
    </tr>
    <tr>
        <td class="bold">Emergency contact</td>
        <td align="right"><asp:Button ID="btnaddmore" runat="server" Text="Add more..." 
                CausesValidation="False" onclick="btnaddmore_Click" /> </td>
    </tr>
    <tr>
        <td>Name:</td>
        <td><asp:TextBox ID="txtname" runat="server" Width="220px"></asp:TextBox></td>
    </tr>
    <tr>
        <td>Email:</td>
        <td><asp:TextBox ID="txtemail" runat="server" Width="220px"></asp:TextBox></td>
    </tr>
    <tr>
        <td class="style2">Phone:</td>
        <td class="style2"><asp:TextBox ID="txtphone" runat="server" Width="220px"></asp:TextBox></td>
    </tr>
    <tr>
        <td>Address:</td>
        <td><asp:TextBox ID="txtaddress" runat="server" Width="220px"></asp:TextBox></td>
    </tr>
     <tr>
        <td colspan="2">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
                    <asp:Table ID="tblcontacts" runat="server" Width="100%">
                    </asp:Table>
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnaddmore" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>
        </td>
    </tr>
    <tr>
        <td colspan="2"  style="border-bottom:1px solid #d4d4d4"></td>
    </tr>
    <tr>
        <td>Captcha:</td>
        <td align="left">
             <%--<asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional" >
                <ContentTemplate>
                    --<img src="usercontrols/jpegimage.aspx" width="200" height="50"
                        style="z-index:200;position:relative; top: 0px; left: 0px;">--                    
                    <table>
                        <tr>
                            <td><asp:Label id="lbcaptcha" runat="server" CssClass="captcha" Enabled="False"></asp:Label></td>
                            <td><asp:ImageButton ID="imgreload" runat="server" 
                                ImageUrl="~/resources/images/captcha-reload.png" CausesValidation="False" 
                                onclick="imgreload_Click" BorderWidth="0" />   </td>
                        </tr>
                    </table>     
                    --<asp:UpdateProgress ID="UpdateProgress1" runat="server" AssociatedUpdatePanelID="UpdatePanel3" >
                        <ProgressTemplate>
                            <div class="captchaloading" align="left">
                                <img src="resources/images/loading.gif" align="middle" />
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>  --                    
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="imgreload" EventName="Click" />
                </Triggers>
            </asp:UpdatePanel>--%>

            <asp:UpdatePanel runat="server" ID="updatepanelcaptcha">
                <ContentTemplate>
                <br>
                    <asp:Image ID="captchaImage" runat="server" Height="35px" />
                    &nbsp;
                    <asp:ImageButton ID="imgreload" runat="server" ImageUrl="~/resources/images/captcha-reload.png" CausesValidation="False"
                        OnClick="imgreload_Click" />
                </ContentTemplate>
            </asp:UpdatePanel>
				<strong>Enter the code shown above:</strong><br>
				<asp:TextBox id="txtcaptcha" runat="server" Width="220px"></asp:TextBox><br>
				<em class="notice">(Note: If you cannot read the code in the above
					image, press reload to generate a new one.)</em><br>
                <asp:Label id="lbmessage" runat="server"></asp:Label>          
        </td>
    </tr>
    <tr>
        <td colspan="2"></td>
    </tr>
    <tr>
        <td></td>
        <td><asp:Button ID="btnregister" runat="server" Text="Register" 
                onclick="btnregister_Click" />
        </td>
    </tr>
</table>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="footer" Runat="Server">
    <%--<div class="footer">Public Home Footer</div>--%>
</asp:Content>

