<%@ Page Language="C#" AutoEventWireup="true" CodeFile="popupDateTime.aspx.cs" Inherits="popupDateTime" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager1" runat="server" >
    </asp:ScriptManager>
    <asp:UpdatePanel ID="UpPanel" runat="server">
        <ContentTemplate>
            
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdateProgress ID="UpProcess" runat="server" >
        <ProgressTemplate>
            
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div id="content">
        
    </div>
    </form>
</body>
</html>
