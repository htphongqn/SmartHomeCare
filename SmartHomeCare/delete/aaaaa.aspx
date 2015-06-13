<%@ Page Language="C#" AutoEventWireup="true" CodeFile="aaaaa.aspx.cs" Inherits="Default2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" language="javascript">
        function enablebtn() {
            document.getElementById("<%= Button1.ClientID %>").disabled = false;
            document.getElementById("<%= Button1.ClientID %>").style.background = "red";
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <div>
    
        <asp:CheckBox ID="CheckBox1" runat="server" OnChange="javascript:enablebtn();" />
        <br />
        <asp:DropDownList ID="DropDownList1" runat="server" OnChange="javascript:enablebtn();">
            <asp:ListItem>b</asp:ListItem>
            <asp:ListItem>a</asp:ListItem>
        </asp:DropDownList>
        <br />
        <asp:TextBox ID="TextBox1" runat="server" OnChange="javascript:enablebtn();"></asp:TextBox>
        <br />
        <asp:RadioButton ID="RadioButton1" runat="server" OnChange="javascript:enablebtn();"/>
        <asp:RadioButton ID="RadioButton2" runat="server" OnChange="javascript:enablebtn();"/>
        <br />
        <asp:Button ID="Button1" runat="server" Text="Button" Enabled="false" 
            onclick="Button1_Click" />
    
    </div>
    <div>
        <asp:UpdatePanel runat="server" ID="updatepanelcaptcha">
            <ContentTemplate>
                <asp:Image ID="captchaImage" runat="server" />
                &nbsp;
                <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/resources/images/captcha-reload.png"
                    OnClick="ImageButton1_Click" />
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    </form>
</body>
</html>
