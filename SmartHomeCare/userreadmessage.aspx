<%@ Page Language="C#" AutoEventWireup="true" CodeFile="userreadmessage.aspx.cs" Inherits="userreadmessage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<link href="styles/popup.css" rel="stylesheet" type="text/css" />
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div class="popupConfirmation">
        <div class="popup_Container">
            <div class="popup_Titlebar">
                <div class="TitlebarLeft">
                    <asp:Label ID="lblTitle" runat="server" Text=""></asp:Label>
                </div>
                <div class="TitlebarRight">
                </div>
            </div>
            <div class="popup_Body">
                <asp:Literal ID="ltrMessage" runat="server"></asp:Literal>
            </div>
            <div class="popup_Buttons">
                <asp:Button ID="Button1" runat="server" Text="Button" />
            </div>
        </div>
    </div>
    </form>
</body>
</html>
