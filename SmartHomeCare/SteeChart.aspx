<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SteeChart.aspx.cs" Inherits="SteeChart" %>

<%@ Register assembly="TeeChart" namespace="Steema.TeeChart.Web" tagprefix="tchart" %>

<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="styles/Position.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        
        <tchart:WebChart ID="WebChart1" runat="server" AutoPostback="False" 
            Config="AAEAAAD/////AQAAAAAAAAAMAgAAAFJUZWVDaGFydCwgVmVyc2lvbj00LjEuMjAxMy4xMTA4NiwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj05YzgxMjYyNzZjNzdiZGI3DAMAAABXU3lzdGVtLldpbmRvd3MuRm9ybXMsIFZlcnNpb249NC4wLjAuMCwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj1iNzdhNWM1NjE5MzRlMDg5DAQAAABRU3lzdGVtLkRyYXdpbmcsIFZlcnNpb249NC4wLjAuMCwgQ3VsdHVyZT1uZXV0cmFsLCBQdWJsaWNLZXlUb2tlbj1iMDNmNWY3ZjExZDUwYTNhBQEAAAAVU3RlZW1hLlRlZUNoYXJ0LkNoYXJ0LwAAAA0uWm9vbS5IaXN0b3J5Dy5ab29tLkRpcmVjdGlvbhMuWm9vbS5BbmltYXRlZFN0ZXBzFC5QYW5uaW5nLk1vdXNlQnV0dG9uEC5DdXN0b21DaGFydFJlY3QZLlBhbmVsLlNoYWRvdy5CcnVzaC5Db2xvchsuUGFuZWwuQnJ1c2guR3JhZGllbnQuQW5nbGUgLlBhbmVsLkJydXNoLkdyYWRpZW50LlN0YXJ0Q29sb3IdLlBhbmVsLkJydXNoLkdyYWRpZW50LlZpc2libGUSLlBhbmVsLkJydXNoLkNvbG9yDy5MZWdlbmQuVmlzaWJsZRkuQXNwZWN0LkNvbG9yUGFsZXR0ZUluZGV4Fi5Bc3BlY3QuQ2hhcnQzRFBlcmNlbnQQLkFzcGVjdC5IZWlnaHQzRA8uQXNwZWN0LldpZHRoM0QOLkFzcGVjdC5WaWV3M0QSLkF4ZXMuTnVtRml4ZWRBeGVzEy5BeGVzLkxlZnQuSUdhcFNpemUULkF4ZXMuTGVmdC5JU3RhcnRQb3MSLkF4ZXMuTGVmdC5JRW5kUG9zFC5BeGVzLkxlZnQuSUF4aXNTaXplFi5BeGVzLkxlZnQuSXNEZXB0aEF4aXMSLkF4ZXMuVG9wLklHYXBTaXplEy5BeGVzLlRvcC5JU3RhcnRQb3MRLkF4ZXMuVG9wLklFbmRQb3MTLkF4ZXMuVG9wLklBeGlzU2l6ZRUuQXhlcy5Ub3AuSXNEZXB0aEF4aXMULkF4ZXMuUmlnaHQuSUdhcFNpemUVLkF4ZXMuUmlnaHQuSVN0YXJ0UG9zEy5BeGVzLlJpZ2h0LklFbmRQb3MVLkF4ZXMuUmlnaHQuSUF4aXNTaXplFy5BeGVzLlJpZ2h0LklzRGVwdGhBeGlzFS5BeGVzLkJvdHRvbS5JR2FwU2l6ZRYuQXhlcy5Cb3R0b20uSVN0YXJ0UG9zFC5BeGVzLkJvdHRvbS5JRW5kUG9zFi5BeGVzLkJvdHRvbS5JQXhpc1NpemUYLkF4ZXMuQm90dG9tLklzRGVwdGhBeGlzFy5BeGVzLkRlcHRoVG9wLklHYXBTaXplGC5BeGVzLkRlcHRoVG9wLklTdGFydFBvcxYuQXhlcy5EZXB0aFRvcC5JRW5kUG9zGC5BeGVzLkRlcHRoVG9wLklBeGlzU2l6ZRouQXhlcy5EZXB0aFRvcC5Jc0RlcHRoQXhpcxQuQXhlcy5EZXB0aC5JR2FwU2l6ZRUuQXhlcy5EZXB0aC5JU3RhcnRQb3MTLkF4ZXMuRGVwdGguSUVuZFBvcxUuQXhlcy5EZXB0aC5JQXhpc1NpemUXLkF4ZXMuRGVwdGguSXNEZXB0aEF4aXMABAAEAAQABAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAEeU3RlZW1hLlRlZUNoYXJ0Llpvb21EaXJlY3Rpb25zAgAAAAghU3lzdGVtLldpbmRvd3MuRm9ybXMuTW91c2VCdXR0b25zAwAAAAEUU3lzdGVtLkRyYXdpbmcuQ29sb3IEAAAABhRTeXN0ZW0uRHJhd2luZy5Db2xvcgQAAAABFFN5c3RlbS5EcmF3aW5nLkNvbG9yBAAAAAEICAgIAQgICAgIAQgICAgBCAgICAEICAgIAQgICAgBCAgICAECAAAAAQX7////HlN0ZWVtYS5UZWVDaGFydC5ab29tRGlyZWN0aW9ucwEAAAAHdmFsdWVfXwAIAgAAAAAAAABkAAAABfr///8hU3lzdGVtLldpbmRvd3MuRm9ybXMuTW91c2VCdXR0b25zAQAAAAd2YWx1ZV9fAAgDAAAAAAAQAAAF+f///xRTeXN0ZW0uRHJhd2luZy5Db2xvcgQAAAAEbmFtZQV2YWx1ZQprbm93bkNvbG9yBXN0YXRlAQAAAAkHBwQAAAAKgID//wAAAAAAAAIAAAAAAAAALkAB+P////n///8KwMDA/wAAAAAAAAIAAAH3////+f///wrAwMD/AAAAAAAAAgAAAAAAAAUAAAAAAAAAAAAAAAAGAAAAAAAAADsAAABrAQAAMAEAAAAAAAAAGQAAAD8CAAAmAgAAAAAAAAA7AAAAawEAADABAAAAAAAAABkAAAA/AgAAJgIAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAABCw==" 
            GetChartFile="GetChart.aspx" Height="400px" TempChart="Session" 
            Width="600px" ongetaxislabel="WebChart1_GetAxisLabel" 
            onafterdraw="WebChart1_AfterDraw" onclickaxis="WebChart1_ClickAxis" 
            onclickseries="WebChart1_ClickSeries" />
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <br />
        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
        <asp:CalendarExtender ID="TextBox1_CalendarExtender" runat="server" 
            Enabled="True" TargetControlID="TextBox1">
        </asp:CalendarExtender>
        <asp:Button ID="Button1" runat="server" onclick="Button1_Click" Text="Button" />
        <br />
        
    </div>
    </form>
</body>
</html>
